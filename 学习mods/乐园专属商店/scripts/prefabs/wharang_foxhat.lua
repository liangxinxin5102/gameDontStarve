local assets=
{
    Asset("ANIM", "anim/wharang_foxhat.zip"),
	Asset("ANIM", "anim/wharang_swap_foxhat.zip"),
	Asset("ATLAS", "images/inventoryimages/wharang_foxhat.xml")
}

local function OnBlocked(owner) 
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end

local function consume(inst, owner)

end

local function StopUsingMask(inst, data)
	local foxhat = inst.components.inventory ~= nil and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) or nil
	if foxhat ~= nil and data.statename ~= "hide" then
		inst.shield = false
		foxhat.components.armor:SetAbsorption(.97) --修改护甲为0.99
		foxhat.components.useableitem:StopUsingItem()
    else
		foxhat.components.armor:SetAbsorption(1)
    end
end

local function OnEquipMaks(inst, owner)	
	owner.AnimState:OverrideSymbol("swap_hat", "wharang_swap_foxhat", "swap_hat")
	owner.AnimState:Show("HAT")
	owner.AnimState:Hide("HAT_HAIR")
	owner.AnimState:Show("HAIR_NOHAT")
	owner.AnimState:Show("HAIR")
	inst:ListenForEvent("blocked", OnBlocked, owner)
	inst:ListenForEvent("newstate", StopUsingMask, owner) 

	if owner ~= nil and owner.components.sanity ~= nil then
		owner.components.sanity.neg_aura_absorb = TUNING.ARMOR_HIVEHAT_SANITY_ABSORPTION
	end
end

	
local function OnUnequipMak(inst, owner)
	owner.AnimState:Hide("HAT")
	owner.AnimState:Hide("HAT_HAIR")
	owner.AnimState:Show("HAIR_NOHAT")
	owner.AnimState:Show("HAIR")
	if owner:HasTag("player") then
		owner.AnimState:Show("HEAD")
		owner.AnimState:Hide("HEAD_HAIR")
	end
	inst:RemoveEventCallback("blocked", OnBlocked, owner)
	inst:RemoveEventCallback("newstate", StopUsingMask, owner)
	
	if owner ~= nil and owner.components.sanity ~= nil then
		owner.components.sanity.neg_aura_absorb = 0
	end
end

local function on_shield(inst, owner)
	if inst.shield and not inst.broken then
		inst.components.talker:Say("[狐仙隐]\n防御100%")
		inst.components.armor:InitIndestructible(1)
	elseif inst.shield and inst.broken then
		inst.components.talker:Say("[狐仙隐·消失]\n防御(60)")
		inst.components.armor:InitIndestructible(0.6)
	end 
end
local function OnUseMask(inst)
	inst.shield = true
	on_shield(inst)
	local owner = inst.components.inventoryitem.owner
	if owner then
		owner.sg:GoToState("hide")
		owner.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	end
end
local function OffUseMask(inst)
	if inst.shield then
		inst.shield = false
	end 
end


local function OnMaskDrop(inst, owner)
    if inst.remove_task then
		inst.remove_task:Cancel()
		inst.remove_task = nil
	end	
end

local function fn(Sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	
	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("wharang_foxhat")
	inst.AnimState:SetBuild("wharang_foxhat")
	inst.AnimState:PlayAnimation("anim")
	
	inst:AddTag("hat")
	
	inst:AddComponent("talker")
	inst.components.talker.fontsize = 20
	inst.components.talker.font = TALKINGFONT
	inst.components.talker.colour = Vector3(1, 0.8, 0.95, 1)
	inst.components.talker.offset = Vector3(0,-500,0)
	inst.components.talker.symbol = "swap_object"
	
	inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")

	inst:AddComponent("tradable")

	inst:AddComponent("armor")
	inst.components.armor:InitIndestructible(0.6)

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD

	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(OnUseMask)
	inst.components.useableitem:SetOnStopUseFn(OffUseMask)
	inst.components.equippable:SetOnEquip(OnEquipMaks)
	inst.components.equippable:SetOnUnequip(OnUnequipMak)

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/wharang_foxhat.xml"
	inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/bushhat"
	inst.components.inventoryitem.onpickupfn = OnMaskDrop
	inst.components.inventoryitem.onputininventoryfn = OnMaskDrop
	
	inst:AddComponent("waterproofer")
	inst.components.waterproofer:SetEffectiveness(.1)
  
    return inst
end

return Prefab( "common/inventory/wharang_foxhat", fn, assets ) 