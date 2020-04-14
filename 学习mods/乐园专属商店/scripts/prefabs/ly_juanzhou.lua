local assets =
{
	Asset("IMAGE", "images/inventoryimages/yyy.tex"),
	Asset("ATLAS", "images/inventoryimages/yyy.xml"),   --c_give"ly_juanzhou"
	Asset("ANIM", "anim/yyy.zip"),
}

local prefabs =
{
    "ly_juanzhou",
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("carrot")
    inst.AnimState:SetBuild("yyy")
    inst.AnimState:PlayAnimation("idle")
	
	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    inst:AddComponent("stackable")
    ---inst.components.stackable.maxsize = 40

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")
	
	


    inst:AddComponent("inventoryitem")
	 inst.components.inventoryitem.imagename = "yyy"
	
	inst.components.inventoryitem.atlasname = "images/inventoryimages/yyy.xml"

    MakeHauntableLaunchAndPerish(inst)

    return inst
end

return Prefab("ly_juanzhou", fn, assets, prefabs)