local Assets =
{
	Asset("ANIM", "anim/binggan.zip"), -- a standard asset
    Asset("ATLAS", "images/inventoryimages/binggan.xml"),    -- a custom asset, found in the mod folder
	Asset("IMAGE", "images/inventoryimages/binggan.tex"), 
}
local prefabs =
{
    "binggan",
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
    
    inst.AnimState:SetBank("binggan")
    inst.AnimState:SetBuild("binggan")
    inst.AnimState:PlayAnimation("idle", true)
   
	if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inspectable")
	inst:AddComponent("named")

	inst.components.named:SetName("经验饼干\n食用以后增加少量人物经验")
	inst:AddComponent("edible")		
inst.components.edible.healthvalue = 10
    inst.components.edible.hungervalue = 10
	inst.components.edible.foodtype = FOODTYPE.GOODIES
    inst:AddComponent("inventoryitem")
	 inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem.imagename = "binggan"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/binggan.xml"
	inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    return inst
end
return Prefab( "common/inventory/binggan", fn, Assets)