local assets=
{
    Asset("ANIM", "anim/lgq.zip"),
    Asset("ANIM", "anim/swap_lgq.zip"),
 
    Asset("ATLAS", "images/inventoryimages/lgq.xml"),
    Asset("IMAGE", "images/inventoryimages/lgq.tex"),
}
local prefabs =
{
    "groundpoundring_fx",
}


local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)

    inst.entity:AddNetwork()
	
	inst.AnimState:SetBank("lgq")
    inst.AnimState:SetBuild("lgq")
    inst.AnimState:PlayAnimation("idle")

	if not TheWorld.ismastersim then
        return inst
    end
 
    local function OnEquip(inst, owner)		
		owner.AnimState:OverrideSymbol("swap_object", "swap_lgq", "swap_lgq")
		owner.AnimState:Show("ARM_carry")
		owner.AnimState:Hide("ARM_normal")	
		owner:DoTaskInTime(1, function()
		--owner.SoundEmitter:PlaySound("hqg/hqg/music", "lmusic")	
        end)		
    end
 
    local function OnUnequip(inst, owner)
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
		owner.AnimState:PlayAnimation("idle")
		owner:DoTaskInTime(1, function()
			owner.SoundEmitter:KillSound("lmusic")
		end)
    end

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/lgq.xml"
	
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
	inst.components.inventoryitem.keepondeath = false
	inst:AddComponent("inspectable")
	inst:AddTag("shadow")
	
 	inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(30)
    return inst
	
end
	
return  Prefab("common/inventory/lgq", fn, assets)