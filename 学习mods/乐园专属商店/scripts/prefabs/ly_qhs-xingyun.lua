local assets =
{
	Asset("IMAGE", "images/inventoryimages/ly_qhs-xingyun.tex"),
	Asset("ATLAS", "images/inventoryimages/ly_qhs-xingyun.xml"),
	Asset("ANIM", "anim/ly_qhs-xingyun.zip"),
}

local prefabs =
{
    "ly_qhs-xingyun",
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBuild("ly_qhs-xingyun")
    inst.AnimState:SetBank("ly_qhs-xingyun")
    inst.AnimState:PlayAnimation("idle")
	
	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = 40

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")
	inst:AddComponent("named")                       -----------名字组件
	inst.components.named:SetName("高级升星石4-5") 
	
	


    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ly_qhs-xingyun.xml"

    MakeHauntableLaunchAndPerish(inst)

    return inst
end

return Prefab("ly_qhs-xingyun", fn, assets, prefabs)