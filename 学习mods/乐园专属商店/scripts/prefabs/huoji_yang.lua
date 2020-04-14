require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/xiaoyangbili.zip"),
	Asset("ANIM", "anim/xiaoyang_item.zip"),
	Asset("ATLAS", "images/inventoryimages/xiaoyang_item.xml"),
}

local prefabs =
{
    "collapse_small",
}


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	inst.Transform:SetFourFaced()
    --MakeObstaclePhysics(inst, .2)

    inst.MiniMapEntity:SetIcon("chuansongyang.tex")

    inst.AnimState:SetBank("xiaoyangbili")
    inst.AnimState:SetBuild("xiaoyangbili")
    inst.AnimState:PlayAnimation("idle_loop",true)

    --MakeSnowCoveredPristine(inst)

    inst:AddTag("structure")
    inst:AddTag("sign")

    --Sneak these into pristine state for optimization
    inst:AddTag("_writeable")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    --Remove these tags so that they can be added properly when replicating components below
    inst:RemoveTag("_writeable")
	inst:AddComponent("fasttravel")
    inst:AddComponent("inspectable")
    inst:AddComponent("writeable")
    MakeSnowCovered(inst)
	inst:AddComponent("trader")--交易系统
	inst.components.trader:SetAcceptTest(function(inst, item) 
        if item.prefab == "lucky_goldnugget" and inst:HasTag("keyichuansong") then
           return true
        end
        return false
    end)
	inst.components.trader.onaccept = function(inst, giver, item)
		giver.Transform:SetPosition(inst.components.fasttravel.xf, 0, inst.components.fasttravel.zf)
	end
    --[[MakeSmallBurnable(inst, nil, nil, true)
    MakeSmallPropagator(inst)

    MakeHauntableWork(inst)]]
   

    return inst
end
local function sfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("xiaoyang_item")
    inst.AnimState:SetBuild("xiaoyang_item")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	inst:AddTag("molebait")
	inst:AddComponent("stackable")
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst:AddComponent("tradable")
    inst.components.inventoryitem.imagename = "xiaoyang_item"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/xiaoyang_item.xml"
    inst:AddComponent("selfstacker")
		local function OnDeploy (inst, pt)
    local tree = SpawnPrefab("xiaoyangbili")
	tree.Transform:SetPosition(pt.x, pt.y, pt.z)
    inst.components.stackable:Get():Remove()
end
    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = OnDeploy

    MakeHauntableLaunchAndSmash(inst)

    return inst
end
return Prefab("xiaoyangbili", fn, assets, prefabs),
Prefab("xiaoyang_item", sfn, assets, prefabs),
MakePlacer("xiaoyang_item_placer", "xiaoyangbili", "xiaoyangbili", "idle_loop")
