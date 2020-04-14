local assets =
{
	Asset("ANIM", "anim/poison.zip"),
}
local function OnTick(inst, target)
    if target.components.health ~= nil and
        not target.components.health:IsDead() and
        not target:HasTag("playerghost") then
        target.components.health:DoDelta(-(target.components.health.maxhealth * 0.07), nil, "hjpoison")
    else
        inst.components.debuff:Stop()
    end
end

local function OnAttached(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)
    inst.task = inst:DoPeriodicTask(1, OnTick, nil, target)
    inst:ListenForEvent("death", function()
        inst.components.debuff:Stop()
    end, target)
end

local function OnTimerDone(inst, data)
    if data.name == "regenover" then
        inst.components.debuff:Stop()
    end
end

local function OnExtended(inst, target)
    inst.components.timer:StopTimer("regenover")
    inst.components.timer:StartTimer("regenover", 3)
    inst.task:Cancel()
    inst.task = inst:DoPeriodicTask(1, OnTick, nil, target)
end	   

	local function fn()
		local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
		inst.entity:AddNetwork()

		inst.AnimState:SetBank("poison")
		inst.AnimState:SetBuild("poison")
		inst.AnimState:PlayAnimation("level1_pre")
		
		inst:AddTag("FX")
		inst:AddTag("NOCLICK")
		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end 
		inst.AnimState:PushAnimation("level1_loop",true)		
		inst.persists = false
		inst:AddComponent("debuff")
		inst.components.debuff:SetAttachedFn(OnAttached)
		inst.components.debuff:SetDetachedFn(inst.Remove)
		inst.components.debuff:SetExtendedFn(OnExtended)

		inst:AddComponent("timer")
		inst.components.timer:StartTimer("regenover", 3)
		inst:ListenForEvent("timerdone", OnTimerDone)

		return inst
	end
return Prefab("hjpoison", fn,assets)
