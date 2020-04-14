local assets =
{
	Asset("IMAGE", "images/inventoryimages/ly_fushi01.tex"),
	Asset("ATLAS", "images/inventoryimages/ly_fushi01.xml"),
	Asset("ANIM", "anim/ly_fushi01.zip"),
}

local prefabs =
{
    "ly_fushi01",  --c_give"ly_fushi01"
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBuild("ly_fushi02")
    inst.AnimState:SetBank("ly_fushi02")
    inst.AnimState:PlayAnimation("idle")
	
	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    inst.Transform:SetScale(2.2, 2.2, 2.2)
    inst:AddComponent("stackable")
  --  inst.components.stackable.maxsize = 40
    inst.components.stackable.maxsize = 99

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")
	
	




    inst:AddComponent("inventoryitem")
	
	---inst.components.inventoryitem.atlasname = "images/inventoryimages/chazi.xml" --物品贴图
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ly_fushi01.xml"

    MakeHauntableLaunchAndPerish(inst)

    return inst
end

return Prefab("ly_fushi01", fn, assets, prefabs)