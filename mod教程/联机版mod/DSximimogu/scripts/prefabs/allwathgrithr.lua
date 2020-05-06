local assets=
{
	Asset("ANIM", "anim/hat_wathgrithr.zip"),
	Asset("IMAGE", "images/inventoryimages/allwathgrithr.tex"),
    Asset("ATLAS", "images/inventoryimages/allwathgrithr.xml"),

}




local function onequip(inst, owner) 
        owner.AnimState:OverrideSymbol("swap_hat", "hat_wathgrithr", "swap_hat")
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



   inst.AnimState:SetBank("wathgrithrhat")
   inst.AnimState:SetBuild("hat_wathgrithr")
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
    inst.components.inventoryitem.atlasname = "images/inventoryimages/allwathgrithr.xml"
    
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
	
	
	
MakeHauntableLaunch(inst)


	
    return inst
end

return Prefab( "common/inventory/allwathgrithr", fn, assets) 
