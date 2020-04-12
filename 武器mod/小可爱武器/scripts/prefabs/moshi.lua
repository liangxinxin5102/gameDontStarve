local Assets =
{
	Asset("ANIM", "anim/moshi.zip"), -- a standard asset
    Asset("ATLAS", "images/inventoryimages/moshi.xml"),    -- a custom asset, found in the mod folder
	Asset("IMAGE", "images/inventoryimages/moshi.tex"), 
}
local prefabs =
{
    "moshi",
}   
local function OnDropped(inst)
    inst.AnimState:PlayAnimation("idle")
end

-- Write a local function that creates, customizes, and returns an instance of the prefab.
local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("moshi")
    inst.AnimState:SetBuild("moshi")
    inst.AnimState:PlayAnimation("idle", true)
   
	if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inspectable")
	inst:AddComponent("named")

	inst.components.named:SetName("转生魔石\n食用以后人物将转生下一阶段")
	inst:AddComponent("edible")		
inst.components.edible.healthvalue = 100
    inst.components.edible.hungervalue = 100
	inst.components.edible.foodtype = FOODTYPE.GOODIES
    inst:AddComponent("inventoryitem")
	 inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem.imagename = "moshi"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/moshi.xml"
	inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    return inst
end
return Prefab( "common/inventory/moshi", fn, Assets)