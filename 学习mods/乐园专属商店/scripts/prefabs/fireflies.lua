local assets =
{
    Asset("ANIM", "anim/fireflies.zip"),
}

local fireflies_fear = FIREFLIES_FEAR                                               --模组选项：萤火虫玩家靠近是否害怕

local INTENSITY = .5	--强度

local function randomizefadein()	--浅淡化
    return math.random(1, 31)
end

local function randomizefadeout()
    return math.random(32, 63)
end

local function immediatefadeout()	--立即淡化
    return 0
end

local function resolvefaderate(x)	--褪色率
    --immediate fadeout -> 0
    --randomize fadein -> INTENSITY * FRAMES / (3 + math.random() * 2)
    --randomize fadeout -> -INTENSITY * FRAMES / (.75 + math.random())
    return (x == 0 and 0)
        or (x < 32 and INTENSITY * FRAMES / (3 + (x - 1) / 15))
        or INTENSITY * FRAMES / ((32 - x) / 31 - .75)
end

local function RGB(inst)	--RGB循环--
math.randomseed(tostring(os.time()):reverse():sub(1, 6)) 
local r = math.random(1,255)/255
local g = math.random(1,255)/255
local b = math.random(1,255)/255
inst.Light:SetColour(r,g,b)
end

local function updatefade(inst, rate)	--更新褪色
    inst._fadeval:set_local(math.clamp(inst._fadeval:value() + rate, 0, INTENSITY))

    --Client light modulation is enabled:
    inst.Light:SetIntensity(inst._fadeval:value())

    if rate == 0 or
        (rate < 0 and inst._fadeval:value() <= 0) or
        (rate > 0 and inst._fadeval:value() >= INTENSITY) then
        inst._fadetask:Cancel()
        inst._fadetask = nil
        if inst._fadeval:value() <= 0 and TheWorld.ismastersim then
            inst:AddTag("NOCLICK")
            inst.Light:Enable(false)
        end
    end
end

local function fadein(inst)		--显露
    local ismastersim = TheWorld.ismastersim
    if not ismastersim or resolvefaderate(inst._faderate:value()) <= 0 then
        if ismastersim then
            inst:RemoveTag("NOCLICK")
            inst.Light:Enable(true)
            inst.AnimState:PlayAnimation("swarm_pre")
            inst.AnimState:PushAnimation("swarm_loop", true)
            inst._faderate:set(randomizefadein())
        end
        if inst._fadetask ~= nil then
            inst._fadetask:Cancel()
        end
        local rate = resolvefaderate(inst._faderate:value()) * math.clamp(1 - inst._fadeval:value() / INTENSITY, 0, 1)
        inst._fadetask = inst:DoPeriodicTask(FRAMES, updatefade, nil, rate)
        if not ismastersim then
            updatefade(inst, rate)
        end
    end
end

local function fadeout(inst)	--淡出
    local ismastersim = TheWorld.ismastersim
    if not ismastersim or resolvefaderate(inst._faderate:value()) > 0 then
        if ismastersim then
            inst.AnimState:PlayAnimation("swarm_pst")
            inst._faderate:set(randomizefadeout())
        end
        if inst._fadetask ~= nil then
            inst._fadetask:Cancel()
        end
        local rate = resolvefaderate(inst._faderate:value()) * math.clamp(inst._fadeval:value() / INTENSITY, 0, 1)
        inst._fadetask = inst:DoPeriodicTask(FRAMES, updatefade, nil, rate)
        if not ismastersim then
            updatefade(inst, rate)
        end
    end
end

local function OnFadeRateDirty(inst)	--颜色衰退
    local rate = resolvefaderate(inst._faderate:value())
    if rate > 0 then
        fadein(inst)	--fadein函数
    elseif rate < 0 then
        fadeout(inst)	--fadeout函数
    elseif inst._fadetask ~= nil then
        inst._fadetask:Cancel()
        inst._fadetask = nil
        inst._fadeval:set_local(0)

        --Client light modulation is enabled:
        inst.Light:SetIntensity(0)	--强度
    end
end

local function updatelight(inst)
  if fireflies_fear == 222     then
    if TheWorld.state.isnight and not inst.components.playerprox:IsPlayerClose() and inst.components.inventoryitem.owner == nil then
	--如果 是晚上            并且 不是              玩家接近                     并且     不是在库存(不在物品栏)--(玩家不靠近并且是晚上才发光)
        fadein(inst)
		RGB(inst)
	else 
	    fadeout(inst)
	--夜晚玩家靠近会消失光--白天会消失光
	end
  elseif fireflies_fear == 333 then
    if TheWorld.state.isnight and inst.components.inventoryitem.owner == nil then
		fadein(inst)
		RGB(inst)	    
    else
	    fadeout(inst)
	end
  elseif fireflies_fear == 444 then
	if inst.components.inventoryitem.owner == nil then
		fadein(inst)
		RGB(inst)	    	
    --任何时候都发光 	
    end
  end
end

local function ondropped(inst)	--在放下
    inst.components.workable:SetWorkLeft(1)
    inst._fadeval:set(0)
    inst._faderate:set_local(immediatefadeout())
    fadein(inst)
    inst:DoTaskInTime(2 + math.random(), updatelight)	--及时完成工作
end

local function onpickup(inst)	--在拾取
    if inst._fadetask ~= nil then
        inst._fadetask:Cancel()
        inst._fadetask = nil
    end
    inst._fadeval:set_local(0)
    inst._faderate:set(immediatefadeout())
    inst.Light:SetIntensity(0)
    inst.Light:Enable(false)
end

local function onworked(inst, worker)	--在工作
    if worker.components.inventory ~= nil then
        worker.components.inventory:GiveItem(inst, nil, inst:GetPosition())
    end
end

local function getstatus(inst)	--获得状态
    if inst.components.inventoryitem.owner ~= nil then
        return "HELD"
    end
end

local function OnIsNight(inst)	--在晚上
    inst:DoTaskInTime(2 + math.random(), updatelight)
end


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddPhysics()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst:AddTag("NOBLOCK")
    inst:AddTag("NOCLICK")

    inst.Light:SetFalloff(1)	--衰减
    inst.Light:SetIntensity(INTENSITY)	--强度
    inst.Light:SetRadius(1)	--半径
	--inst.Light:SetColour(R,G,B)
    --inst.Light:SetColour(180/255, 195/255, 150/255)	--颜色
	--定义个RGB的函数怎么样？
	RGB(inst)
    inst.Light:SetIntensity(0)	--强度
    inst.Light:Enable(false)	--开
    inst.Light:EnableClientModulation(true)	--客户机开

    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    inst.AnimState:SetBank("fireflies")
    inst.AnimState:SetBuild("fireflies")
    inst.AnimState:SetRayTestOnBB(true)

    inst:AddTag("cattoyairborne")

    inst._fadeval = net_float(inst.GUID, "fireflies._fadeval")
    inst._faderate = net_smallbyte(inst.GUID, "fireflies._faderate", "onfaderatedirty")
    inst._fadetask = nil

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		--监听 颜色衰退 执行颜色衰退函数
        inst:ListenForEvent("onfaderatedirty", OnFadeRateDirty)

        return inst
    end

    inst:AddComponent("playerprox")

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = getstatus

    inst:AddComponent("workable")	--可执行
    inst.components.workable:SetWorkAction(ACTIONS.NET)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnFinishCallback(onworked)

    inst:AddComponent("stackable")	--堆叠
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst.components.stackable.forcedropsingle = true

    inst:AddComponent("inventoryitem")	
    inst.components.inventoryitem:SetOnDroppedFn(ondropped)
    inst.components.inventoryitem:SetOnPickupFn(onpickup)
    inst.components.inventoryitem.canbepickedup = false
    inst.components.inventoryitem.canbepickedupalive = true

    inst:AddComponent("tradable")	--交易

    inst:AddComponent("fuel")	--燃料
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL
    inst.components.fuel.fueltype = FUELTYPE.CAVE

    inst.components.playerprox:SetDist(3,5)	--玩家攻击 距离
    inst.components.playerprox:SetOnPlayerNear(updatelight)	--附近
    inst.components.playerprox:SetOnPlayerFar(updatelight)	--远离

    inst:AddComponent("hauntable")	--出没
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:WatchWorldState("isnight", OnIsNight)

    updatelight(inst)

    return inst
end

return Prefab("common/fireflies", fn, assets)
