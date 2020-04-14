local TadalinUtil = require("tadalin_util")

local assets =
{
	
	Asset("ANIM", "anim/lightning.zip"),
    Asset("ANIM", "anim/red_lightning.zip"),
	Asset("ANIM", "anim/lavaarena_creature_teleport.zip"),
	Asset("ANIM", "anim/lavaarena_creature_teleport_smoke_fx.zip"),
}

local function DestroyWorks(inst,rad)
	local x,y,z = inst:GetPosition():Get()
	for k,v in pairs(TheSim:FindEntities(x,y,z,rad)) do 
		if v and v:IsValid() and v.components.workable then 
			v.components.workable:Destroy(inst) 
		end
	end
end 

local function PlayLightningAnim(pos)
    local inst = CreateEntity()

    inst:AddTag("FX")
    --[[Non-networked entity]]
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddLight()

    inst.Transform:SetPosition(pos:Get())
    inst.Transform:SetScale(2, 2, 2)

    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetLightOverride(1)
    inst.AnimState:SetBank("red_lightning")
    inst.AnimState:SetBuild("red_lightning")
    inst.AnimState:PlayAnimation("anim")
	inst.Transform:SetScale(2,2,2)
	
	
    inst:ListenForEvent("animover", inst.Remove)
end

local function PlayThunderSound(pos)
    local inst = CreateEntity()

    --[[Non-networked entity]]

    inst.entity:AddTransform()
    inst.entity:AddSoundEmitter()

    inst.Transform:SetPosition(pos:Get())
	inst.SoundEmitter:PlaySoundWithParams("dontstarve/rain/thunder_close", {intensity= 0.7})
    inst:Remove()
end

local function StartFX(proxy)
    TheWorld:PushEvent("screenflash", .5)

    local pos = Vector3(proxy.Transform:GetWorldPosition())
    PlayLightningAnim(pos)

    --Dedicated server does not need to spawn the local fx
    --(except red_lightning anim since it affects lighting)
    if TheNet:IsDedicated() then
        return
    end

    local pos0 = Vector3(TheFocalPoint.Transform:GetWorldPosition())
   	local diff = pos - pos0
    local distsq = diff:LengthSq()
    local minsounddist = 10
    local normpos = pos
   	if distsq > minsounddist * minsounddist then
       	--Sound needs to be played closer to us if red_lightning is too far from player
        local normdiff = diff * (minsounddist / math.sqrt(distsq))
   	    normpos = pos0 + normdiff
    end

    if ThePlayer ~= nil then
        ThePlayer:ShakeCamera(CAMERASHAKE.FULL, .7, .02, .5, proxy, 40)
    end
    PlayThunderSound(normpos)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    --Delay one frame so that we are positioned properly before starting the effect
    --or in case we are about to be removed
    inst:DoTaskInTime(0, StartFX)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetCanSleep(false)
    inst.persists = false
    inst:DoTaskInTime(1, inst.Remove)

    return inst
end

local function LavaLightningfn()
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddLight()


    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetLightOverride(1)
	
    inst.AnimState:SetBank("lavaarena_creature_teleport")
    inst.AnimState:SetBuild("lavaarena_creature_teleport")
    --inst.AnimState:PlayAnimation("anim")
	
	--inst.Transform:SetScale(2,2,2)

    inst:AddTag("FX")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetCanSleep(false)
    inst.persists = false

	inst.DestroyWorks = DestroyWorks
	
	inst.SetSize = function(self,size,scale)
		scale = scale or 1
		if size == "small" then 
			inst.AnimState:PlayAnimation("spawn_small")
		else
			inst.AnimState:PlayAnimation("spawn_medium")
		end 
		inst.Transform:SetScale(scale,scale,scale)
	end
	
	inst.DoAreaAttack = function(self,attacker,rad,damage)
		if not (attacker and attacker:IsValid()) then 
			return
		end 
		local pos = self:GetPosition()
		local ents = TheSim:FindEntities(pos.x,pos.y,pos.z,rad,{"_combat"})
		for k,v in pairs(ents) do 
			if v ~= attacker and TadalinUtil.CanAttack(v) then 
				v.components.combat:GetAttacked(attacker,damage,nil,"electric")
			end
		end
	end 
	
	inst:DoTaskInTime(0,function()
		SpawnPrefab("tadalin_lava_lightning_smoke").Transform:SetPosition(inst:GetPosition():Get())
		--inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
		inst.SoundEmitter:PlaySoundWithParams("dontstarve/common/lava_arena/spawn", {intensity= 0.5})
		--inst.SoundEmitter:PlaySoundWithParams("dontstarve/rain/thunder_close", {intensity= 0.5})
	end)
	
	inst:ListenForEvent("animover",inst.Remove)

    return inst
end


local function smakefn()
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddLight()


    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetLightOverride(1)
	
    inst.AnimState:SetBank("lavaarena_creature_teleport_smoke_fx")
    inst.AnimState:SetBuild("lavaarena_creature_teleport_smoke_fx")
    inst.AnimState:PlayAnimation("smoke_"..math.random(1,3))
	
    inst:AddTag("FX")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetCanSleep(false)
    inst.persists = false
	
	inst.SoundEmitter:PlaySound("dontstarve/common/lava_arena/spawner_decor")
	
	inst:ListenForEvent("animover",inst.Remove)
	
	return inst 
end

return Prefab("red_lightning", fn, assets),
Prefab("tadalin_lava_lightning", LavaLightningfn, assets),
Prefab("tadalin_lava_lightning_smoke", smakefn, assets)