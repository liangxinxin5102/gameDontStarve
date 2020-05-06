local assets=
{
	Asset("ANIM", "anim/hat_red_mushroom.zip"),
	Asset("IMAGE", "images/inventoryimages/redmushroom.tex"),
    Asset("ATLAS", "images/inventoryimages/redmushroom.xml"),

}




local function onequip(inst, owner) 
        owner.AnimState:OverrideSymbol("swap_hat", "hat_red_mushroom", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Show("HAT_HAIR")
end

local function onunequip(inst, owner) 
        owner.AnimState:Hide("HAT")
        owner.AnimState:Hide("HAT_HAIR")
        owner.AnimState:Show("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")
end







local function fn(Sim)
	local inst = CreateEntity()
	 inst.entity:AddTransform()
     inst.entity:AddAnimState()
     inst.entity:AddNetwork()
     inst.entity:AddSoundEmitter()
    
    MakeInventoryPhysics(inst)



   inst.AnimState:SetBank("red_mushroomhat")
   inst.AnimState:SetBuild("hat_red_mushroom")
   inst.AnimState:PlayAnimation("anim")    
        
   inst:AddComponent("inspectable")
   
   inst:AddTag("hat")
   inst:AddTag("waterproofer")

   inst.entity:SetPristine()
	 
	if not TheWorld.ismastersim then
        return inst
    end
    

	inst:AddComponent("armor")
	inst.components.armor:InitCondition(TUNING.ARMOR_WATHGRITHRHAT, TUNING.ARMOR_WATHGRITHRHAT_ABSORPTION)

	inst:AddComponent("waterproofer")
	inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_SMALL)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/redmushroom.xml"
    
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
	
	
	
MakeHauntableLaunch(inst)


	
    return inst
end

return Prefab( "common/inventory/redmushroom", fn, assets) 
