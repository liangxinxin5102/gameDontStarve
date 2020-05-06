local assets=
{
	Asset("ANIM", "anim/hat_mbunny.zip"),
  Asset("ATLAS", "images/inventoryimages/hat_mbunny.xml"),
  Asset("IMAGE", "images/inventoryimages/hat_mbunny.tex")
}

--------------bushhat
    local function stopusingbush(inst, data)
        local hat = inst.components.inventory and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if hat and not (data.statename == "hide_idle" or data.statename == "hide") then
            hat.components.useableitem:StopUsingItem()
        end
    end

    local function onequipbush(inst, owner)

        owner.AnimState:OverrideSymbol("swap_hat", "hat_mbunny", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Show("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Hide("HAIR")


        if owner:HasTag("player") then
            owner.AnimState:Hide("HEAD")
            owner.AnimState:Show("HEAD_HAIR")
        end

        inst:ListenForEvent("newstate", stopusingbush, owner) 
    end

    local function onunequipbush(inst, owner)
        owner.AnimState:Hide("HAT")
        owner.AnimState:Hide("HAT_HAIR")
        owner.AnimState:Show("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")

        if owner:HasTag("player") then
            owner.AnimState:Show("HEAD")
            owner.AnimState:Hide("HEAD_HAIR")
        end

        inst:RemoveEventCallback("newstate", stopusingbush, owner)
    end
 
  local function onusebush(inst)
        local owner = inst.components.inventoryitem.owner
        if owner then
            owner.sg:GoToState("hide")
        end
    end
---------------bushhat end
---------------hat fn sim
	
local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

    MakeInventoryPhysics(inst)
    
    inst:AddTag("hat")

    anim:SetBank("bushhat")
    anim:SetBuild("hat_mbunny")

    anim:PlayAnimation("anim")    
        
    inst:AddComponent("inspectable")
    
   -- inst:AddTag("irreplaceable")
	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hat_mbunny.xml"

   -- inst:AddComponent("armor")
   -- inst.components.armor:InitCondition(TUNING.ARMORGRASS, TUNING.ARMORGRASS_ABSORPTION)
    ---inst.components.armor:InitCondition(TUNING.ARMOR_FOOTBALLHAT, TUNING.ARMOR_FOOTBALLHAT_ABSORPTION)

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD

        inst:AddTag("hide")
        inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/bushhat"
            inst:AddComponent("useableitem")
       inst.components.useableitem:SetOnUseFn(onusebush)
        inst.components.equippable:SetOnEquip( onequipbush )
        inst.components.equippable:SetOnUnequip( onunequipbush )
    inst.components.equippable.walkspeedmult = 1.2
    inst.components.equippable.runspeedmult = 1.2

       inst:AddComponent("insulator")
	inst.components.insulator.insulation = TUNING.INSULATION_MED	
        inst.components.equippable.insulated = true

    return inst
end
---------------------------------
return Prefab( "common/inventory/hat_mbunny", fn, assets ) 
