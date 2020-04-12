local Assets =
{
	Asset("ANIM", "anim/dianyangqiu.zip"), -- a standard asset
    Asset("ATLAS", "images/inventoryimages/dianyangqiu.xml"),    -- a custom asset, found in the mod folder
	Asset("IMAGE", "images/inventoryimages/dianyangqiu.tex"), 
}
local prefabs =
{
    "dianyangqiu",
}   
local function OnDropped(inst)
    inst.AnimState:PlayAnimation("idle")
end

local function UnwrappedFn(inst, pos, doer)
    SpawnPrefab("lightninggoat").Transform:SetPosition(pos:Get())
			if doer ~= nil and doer.SoundEmitter ~= nil then
				doer.SoundEmitter:PlaySound("dontstarve/common/together/packaged")
			end
			inst:Remove()

end

-- Write a local function that creates, customizes, and returns an instance of the prefab.
local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("dianyangqiu")
    inst.AnimState:SetBuild("dianyangqiu")
    inst.AnimState:PlayAnimation("idle", true)
   
	if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inspectable")
	inst:AddComponent("named")
	inst:AddComponent("unwrappable")
    inst.components.unwrappable:SetOnUnwrappedFn(UnwrappedFn)
	inst.components.named:SetName("电羊精灵球")
	
    inst:AddComponent("inventoryitem")
	 inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem.imagename = "dianyangqiu"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/dianyangqiu.xml"
MakeHauntableLaunch(inst)
    return inst
end
return Prefab( "common/inventory/dianyangqiu", fn, Assets)