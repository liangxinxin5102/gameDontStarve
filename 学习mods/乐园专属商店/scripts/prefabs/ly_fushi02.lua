local assets =
{
	Asset("IMAGE", "images/inventoryimages/ly_fushi02.tex"),
	Asset("ATLAS", "images/inventoryimages/ly_fushi02.xml"),
	Asset("ANIM", "anim/ly_fushi02.zip"),
}

local prefabs =
{
    "ly_fushi02",
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



    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = 40

    inst:AddComponent("tradable")
    inst.Transform:SetScale(2.2, 2.2, 2.2)    
    inst:AddComponent("inspectable")
	
	




    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ly_fushi02.xml"

    MakeHauntableLaunchAndPerish(inst)

    return inst
end

return Prefab("ly_fushi02", fn, assets, prefabs)