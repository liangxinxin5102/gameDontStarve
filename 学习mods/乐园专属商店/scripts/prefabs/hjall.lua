
local assets =
{
    Asset("ANIM", "anim/lavaarena_boarrior_basic.zip"),
}

local brain = require("brains/hjzsbrain")
local TARGET_DIST = 16
local brainaa = require("brains/tornadobrain")

local function ontornadolifetime(inst)
    inst.task = nil
    inst.sg:GoToState("despawn")
end

local function SetDuration(inst, duration)
    if inst.task ~= nil then
        inst.task:Cancel()
    end
    inst.task = inst:DoTaskInTime(duration, ontornadolifetime)
end
local function FindTarget(inst)
    local range = inst:GetPhysicsRadius(0) + 8
    return FindEntity(
            inst,
            TARGET_DIST,
            function(guy)
                return inst.components.combat:CanTarget(guy)
                    and (   guy.components.combat:TargetIs(inst) or
                            guy:IsNear(inst, range)
                        )
            end,
            { "_combat","_health" },
            { "fx", "INLIMBO" , "hj","playgohst"}
        )
end

local function GetTargetFn(inst)
    if not (inst.components.health == nil or  inst.components.health:IsDead()) 
        then
        local target = FindClosestPlayerToInst(inst, 8, true)
        return target ~= nil and not target:HasTag("playgohst") and not target:HasTag("hj") and not target:HasTag("notarget") and target or nil
    end
end
local function getspawnlocation(inst, target)
    local x1, y1, z1 = inst.Transform:GetWorldPosition()
    local x2, y2, z2 = target.Transform:GetWorldPosition()
    return x1 + .15 * (x2 - x1), 0, z1 + .15 * (z2 - z1)
end
local function PlayLightningAnim(pos)
    local inst = CreateEntity()
    inst:AddTag("FX")
    inst.entity:SetCanSleep(false)
    inst.persists = false
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddLight()
    inst.Transform:SetPosition(pos:Get())
    inst.Transform:SetScale(2, 2, 2)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetLightOverride(1)
    inst.AnimState:SetBank("lightning")
    inst.AnimState:SetBuild("lightning")
    inst.AnimState:PlayAnimation("anim")
    inst:ListenForEvent("animover", inst.Remove)
end
local function PlayThunderSound(pos)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddSoundEmitter()
    inst.Transform:SetPosition(pos:Get())
    inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
    inst:Remove()
end
local function soralightStartFX(proxy)
    local pos = Vector3(proxy.Transform:GetWorldPosition())
    PlayLightningAnim(pos)
    if TheNet:IsDedicated() then
        return
	end
    local pos0 = Vector3(TheFocalPoint.Transform:GetWorldPosition())
   	local diff = pos - pos0
    local distsq = diff:LengthSq()
    local minsounddist = 10
    local normpos = pos
   	if distsq > minsounddist * minsounddist then
        local normdiff = diff * (minsounddist / math.sqrt(distsq))
   	    normpos = pos0 + normdiff
    end
    PlayThunderSound(normpos)
end
local function OnHitOther(inst, other)
	if other and  other:IsValid() and inst.buff ~= nil then 
		if inst.buff == "ice"  then
			if other.components.freezable ~= nil then
				other.components.freezable:AddColdness(7)
				other.components.freezable:SpawnShatterFX()
			end
		elseif inst.buff == "light" then
			local x, y, z = other.Transform:GetWorldPosition()
			SpawnPrefab("hjlight").Transform:SetPosition(x, y - .5, z)	
			if other.components.combat and inst.components.heath and not inst.components.heath:IsDesd() then
				other.components.combat:GetAttacked(inst,100, nil ,"electric")
			end
		elseif inst.buff == "fire"  then
			if other.components.burnable ~= nil and not other.components.burnable:IsBurning() then
				other.components.burnable:Ignite(true)	
			end
		elseif inst.buff == "tornado"  then
			local tornado = SpawnPrefab("hjtornado")
			tornado.Transform:SetPosition(getspawnlocation(inst, other))
			tornado.components.knownlocations:RememberLocation("target", other:GetPosition())
			tornado.WINDSTAFF_CASTER = inst		
		elseif inst.buff == "poison"  then
			if other.entity:IsVisible() and
				other.components.debuffable ~= nil and
				not other.components.debuffable:HasDebuff("hjpoison") and
				not (other.components.health ~= nil and
                other.components.health:IsDead()) then
				other.components.debuffable:AddDebuff("hjpoison", "hjpoison")
			end
		end
	end
end

local function KeepTarget(inst, target)
	return inst.components.combat:CanTarget(target) and not target:HasTag("hj") and(target.components.health and not target.components.health:IsDead())
end

local function OnAttacked(inst, data)
    if data and data.attacker and data.attacker.components.combat ~= nil and not data.attacker:HasTag("hj")then
            inst.components.combat:SuggestTarget(data.attacker)
	end
end
local function hjhj(name)
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.DynamicShadow:SetSize(2.25, 0.95)
    inst.Transform:SetFourFaced()

    inst:SetPhysicsRadiusOverride(0.75)
    MakeCharacterPhysics(inst, 250, inst.physicsradiusoverride)

    inst.AnimState:SetBank("boarrior")
    inst.AnimState:SetBuild("lavaarena_boarrior_basic")
    inst.AnimState:PlayAnimation("idle_loop", true)

    inst.AnimState:AddOverrideBuild("fossilized")
	inst.Transform:SetScale(0.5, 0.5, 0.5)
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("largecreature")
	inst:AddTag("hj")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	inst.buffs = {"shanbi","fanji","ice","light","fire","tornado","poison"}
	inst.buff = inst.buffs[math.random(7)]
    inst:AddComponent("locomotor")
	inst.components.locomotor.walkspeed =16
    inst.components.locomotor.runspeed =16
	
    inst:SetStateGraph("SGhjall")

    inst:SetBrain(brain)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(5000000)
	inst.components.health:SetAbsorptionAmount(0.95)
    inst.components.health:StartRegen(450.1)
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(500)
	inst.components.combat:SetRange(6, 8)
	inst.components.combat.playerdamagepercent = 1
    inst.components.combat:SetAttackPeriod(0.5)
    inst.components.combat:SetRetargetFunction(1, FindTarget)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)

	inst.components.combat.onhitotherfn = OnHitOther
	local oooddd = inst.components.combat.GetAttacked
	inst.components.combat.GetAttacked = function(self,attacker, damage, weapon, stimuli)
		if self.inst.buff =="shanbi" then 
		    if self.inst.shanbi and self.inst.shanbi == 1 then 
				self.inst.shanbi = 0
				return
			else
				self.inst.shanbi = 1
			end
		end
		if self.inst.buff == "fanji" then
			if self.inst.fanji and self.inst.fanji == 1 then
				self.inst.fanji = 0
				if attacker and attacker.components.combat ~= nil then
					attacker.components.combat:GetAttacked(self.inst,damage,nil,self.inst.prefab)
				end
			else
				self.inst.fanji = 1
			end
		end	
		oooddd(self,attacker, damage, weapon, stimuli)
	end
	inst:AddComponent("inspectable")
	inst:AddComponent("knownlocations")

	inst.persists = false
    inst:ListenForEvent("attacked", OnAttacked)
    return inst
end
return Prefab(name, fn, assets)
end
local function tornado_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetFinalOffset(2)
    inst.AnimState:SetBank("tornado")
    inst.AnimState:SetBuild("tornado")
    inst.AnimState:PlayAnimation("tornado_pre")
    inst.AnimState:PushAnimation("tornado_loop")

    inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/tornado", "spinLoop")

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("knownlocations")

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TUNING.TORNADO_WALK_SPEED * .33
    inst.components.locomotor.runspeed = TUNING.TORNADO_WALK_SPEED

    inst:SetStateGraph("SGhjtornado")
    inst:SetBrain(brainaa)

    inst.WINDSTAFF_CASTER = nil
    inst.persists = false

    inst.SetDuration = SetDuration
    inst:SetDuration(TUNING.TORNADO_LIFETIME)

    return inst
end
local function light_fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddNetwork()
    inst:AddTag("FX")
    inst:DoTaskInTime(0, soralightStartFX)
	

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
	end
    inst.entity:SetCanSleep(false)
    inst.persists = false
    inst:DoTaskInTime(1, inst.Remove)
    return inst
end
return hjhj("hjzs1"),
		hjhj("hjzs2"),
		hjhj("hjzs3"),
		hjhj("hjzs4"),
		hjhj("hjzs5"),
		hjhj("hjzs6"),
		Prefab("hjtornado", tornado_fn),
		Prefab("hjlight", light_fn)
