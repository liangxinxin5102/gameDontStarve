--改自熔炉mod的boss
local assets =
{
    Asset("ANIM", "anim/lavaarena_boarrior_basic.zip"),
}

local prefabs =
{
    "hj_groundlift",
    "hj_groundliftembers",
    "hj_groundliftrocks",
    "hj_groundliftwarning",
    "hj_groundliftempty",
}

local brain = require("brains/hjzsbrain")
local TARGET_DIST = 16

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
            { "_combat" },
            { "fx", "INLIMBO","hj","playgohst" }
        )
end

local function OnHitOther(inst, other)
	if not inst.is_doing_special then
		if other.sg and other.sg.sg.events.knockback then
		other:PushEvent("knockback", {knocker = inst, radius = 5})
	else
	if other ~= nil and not (other:HasTag("epic") or other:HasTag("largecreature")) then
		if other:IsValid() and other.entity:IsVisible() and not (other.components.health ~= nil and other.components.health:IsDead()) then
            if other.components.combat ~= nil then
                if other.Physics ~= nil then
					local x, y, z = inst.Transform:GetWorldPosition()
                    local distsq = other:GetDistanceSqToPoint(x, 0, z)
						if distsq > 0 then
							other:ForceFacePoint(x, 0, z)
						end
						local k = .5 * distsq / 25 - 1
						other.speed = 60 * k
						other.dspeed = 2
						other.Physics:ClearMotorVelOverride()
						other.Physics:Stop()
						
						if other.components.inventory and other.components.inventory:ArmorHasTag("heavyarmor") or other:HasTag("heavybody") then 
						other:DoTaskInTime(0.1, function(inst) 
							other.Physics:SetMotorVelOverride(-2, 0, 0) 
						end)
						else
						other:DoTaskInTime(0, function(inst) 
							other.Physics:SetMotorVelOverride(-25, 0, 0) 
						end)
						end
						other:DoTaskInTime(0.4, function(inst) 
						other.Physics:ClearMotorVelOverride()
						other.Physics:Stop()
						end)
                end
            end
        end
	end
	end
	end
end


local function Phase2(inst)
	inst.level = 1
	inst.altattack = true
	if inst.sg then 
		inst.sg:GoToState("taunt")
	end
end

local function Phase3(inst)
	if inst.level < 2 then
	inst.level = 2
	inst.altattack = true
		if inst.sg then 
			inst.sg.statemem.wants_to_banner = true
			inst.sg:GoToState("banner_pre")
		end
	end
end

local badys = {  --分身
	"hjzs1",
	"hjzs2",
	"hjzs3",
	"hjzs4",
	"hjzs5",
	"hjzs6",
}
local loots = {  --掉落
	"purplegem",  --紫宝石
	"purplegem",
	"purplegem",
	"purplegem",
	"purplegem",
	"purplegem",

	"opalpreciousgem",
	"opalpreciousgem",
	"opalpreciousgem",
	"opalpreciousgem",
	"opalpreciousgem",
	"opalpreciousgem",
	
	"orangegem",
	"orangegem",
	"orangegem",
	"orangegem",
	"orangegem",
	"orangegem",

	"yellowgem",
	"yellowgem",
	"yellowgem",
	"yellowgem",
	"yellowgem",
	"yellowgem",
	
	--'xxsq',
	--'xxsq',
	--'xxsq',
	--'xxsq',
	--'xxsq',
	--'xxsq',
}

local function Phase4(inst)
	inst.level = 3
	if not inst.badys then
		inst.badys = {}
	end
	inst:DoTaskInTime(1, function(inst)
	if inst.components.health and not inst.components.health:IsDead() then

	inst.components.health:StartRegen(600, 1)

	local pos = Vector3(inst.Transform:GetWorldPosition())
	for i,v in ipairs(badys) do
		local a = (i - 1)*360/6 + 360/6 
		local x, y, z =  8*math.cos(2*math.pi/360*a) + pos.x, pos.y, pos.z + 8*math.sin(2*math.pi/360*a)
		local bady = SpawnPrefab(v)
		bady.Transform:SetPosition(x,y,z)
		table.insert(inst.badys, bady) 
	end	
	end
	end)
end
		
 local function launchitem(item)
    local speed = math.random() * 4 + 6
    local angle = math.random(360) * DEGREES
    item.Physics:SetVel(speed * math.cos(angle), math.random() * 2 + 8, speed * math.sin(angle))
end	
local function biubiu(inst)	
	local x, y, z = inst.Transform:GetWorldPosition()
	inst:StartThread(function()
    for i,v in pairs(loots) do
        local nug = SpawnPrefab(v)
		if nug then
			nug.Transform:SetPosition(x, y+8, z)
			if nug.components.stackable ~= nil and nug:HasTag("quakedebris") then
				nug.components.stackable:SetStackSize(10)
			end
			launchitem(nug)
		end
	Sleep(.1)
    end
end)
end
	
local function ondeath(inst)
	if inst.altar ~= nil then
		biubiu(inst.altar)
	end
	if inst.badys ~= nil then
		for k,v in pairs(inst.badys) do
			if v:IsValid() and v.components.health and not v.components.health:IsDead() then
				v.components.health:Kill()
			end
		end
	end
end


local function OnNewTarget(inst, data)
	if data and data.target then
		inst.lasttarget = inst.components.combat.target
		if inst.components.health:GetPercent() <= 0.75  and not inst:IsNear(data.target, 3) and not (inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("nointerrupt")) then
			if  inst.sg then
				inst.sg.statemem.wants_to_slam = data.target
			end
		end
	end
end

local function KeepTarget(inst, target)
	return inst.components.combat:CanTarget(target) and (target.components.health and not target.components.health:IsDead())
end

local function OnAttacked(inst, data)
	if data and data.attacker  and not data.attacker:HasTag("hj") and not data.attacker:HasTag("notarget") and not (inst.aggrotimer and inst.components.combat.lastwasattackedtime <= inst.aggrotimer) then	
		local player, distsq = inst:GetNearestPlayer()	
		if player and player.components.health and not player.components.health:IsDead() and player == data.attacker then
			if inst.components.combat.target and not (data.attacker:HasTag("lessaggro") or inst:IsNear(inst.components.combat.target, 2.5)) then
				inst.components.combat:SetTarget(data.attacker)
			elseif not inst.components.combat.target then
				inst.components.combat:SetTarget(data.attacker)
			end		
		end
	end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.DynamicShadow:SetSize(5.25, 1.75)
    inst.Transform:SetFourFaced()

    inst:SetPhysicsRadiusOverride(1.5)
    MakeCharacterPhysics(inst, 500, inst.physicsradiusoverride)
    RemovePhysicsColliders(inst)
	inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    --inst.Physics:CollidesWith(COLLISION.WORLD)	
	

    inst.AnimState:SetBank("boarrior")
    inst.AnimState:SetBuild("lavaarena_boarrior_basic")
    inst.AnimState:PlayAnimation("idle_loop", true)

    inst.AnimState:AddOverrideBuild("fossilized")
	
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("largecreature")
    inst:AddTag("epic")
	inst:AddTag("hj")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	inst.altattack = true
	inst.altattack2 = true
	inst.altattack3 = true
	inst.level = 0
    inst:AddComponent("locomotor")
	inst.components.locomotor.walkspeed = 8
    inst.components.locomotor.runspeed =8
	
    inst:SetStateGraph("SGhjzs")

    inst:SetBrain(brain)


    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(30000000)
	inst.components.health:SetAbsorptionAmount(0.97)
	inst.components.health:StartRegen(450,1)
	
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(5500) 
	inst.components.combat:SetRange(5, 8)
	inst.components.combat.playerdamagepercent = 1
    inst.components.combat:SetAttackPeriod(0.5)
    inst.components.combat:SetRetargetFunction(1, FindTarget)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
	inst.components.combat.battlecryenabled = false
	inst.components.combat.onhitotherfn = OnHitOther
	--local old = inst.components.combat.GetAttacked
	--inst.components.combat.GetAttacked = function(self,attacker, damage, weapon, stimuli)
	--	if  weapon ~= nil and weapon.components.weapon ~= nil and weapon.components.weapon.attackrange ~= nil and
	--		weapon.components.weapon.attackrange >= 4 then
	--		damage = 0.5*damage
	--	end
	--	old(self,attacker, damage, weapon, stimuli)
	--end
	inst:AddComponent("lootdropper")

    inst:AddComponent("inspectable")
	
	inst:AddComponent("healthtrigger")
	inst.components.healthtrigger:AddTrigger(0.75, Phase2)
	inst.components.healthtrigger:AddTrigger(0.5, Phase3)
	inst.components.healthtrigger:AddTrigger(0.25, Phase4)

	inst:AddComponent("knownlocations")
	
	inst.persists = false
    inst:ListenForEvent("attacked", OnAttacked)
	inst:ListenForEvent("death", ondeath)
	inst:ListenForEvent("newcombattarget", OnNewTarget)

    return inst
end

return Prefab("hjzs", fn, assets, prefabs)