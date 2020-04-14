local assets =
{
	Asset("IMAGE", "images/inventoryimages/ly_qhs-chuanshuo.tex"),
	Asset("ATLAS", "images/inventoryimages/ly_qhs-chuanshuo.xml"),
	Asset("ANIM", "anim/ly_qhs-chuanshuo.zip"),
}

local prefabs =
{
    "ly_qhs-chuanshuo",
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBuild("ly_qhs-chuanshuo")
    inst.AnimState:SetBank("ly_qhs-chuanshuo")
    inst.AnimState:PlayAnimation("idle")
	
	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = 40

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")
	 inst.Transform:SetScale(2, 2, 2)
	
	inst:AddComponent("named")                       -----------名字组件
	inst.components.named:SetName("低级升星石1-4") 
    

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ly_qhs-chuanshuo.xml"

    MakeHauntableLaunchAndPerish(inst)

    return inst
end

return Prefab("ly_qhs-chuanshuo", fn, assets, prefabs)