require "prefabutil"
require "recipe"
require "modutil"
require "class"


local assets =
{
	Asset("ANIM", "anim/ly_zcm001.zip"),
	Asset("IMAGE", "images/inventoryimages/ly_zcm001.tex"),
    Asset("ATLAS", "images/inventoryimages/ly_zcm001.xml"),
}


local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("ly_zcm001")
    inst.AnimState:SetBuild("ly_zcm001")
    inst.AnimState:PlayAnimation("idle")
    if not TheWorld.ismastersim then
        return inst
    end
	
	inst.entity:SetPristine()
	
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "ly_zcm001"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ly_zcm001.xml"
	
	MakeHauntableLaunch(inst)
	
    return inst
end

return  Prefab( "common/inventory/lyzcm001", fn, assets)















