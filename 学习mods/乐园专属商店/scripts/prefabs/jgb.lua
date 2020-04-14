local assets =
{
    Asset("ANIM", "anim/jgb.zip"),
    Asset("ANIM", "anim/swap_jgb.zip"),

    Asset("ATLAS", "images/inventoryimages/jgb.xml"),
}


local function onequip(inst, owner)
        owner.AnimState:OverrideSymbol("swap_object", "swap_jgb", "swap_jgb")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
      ---  local light = inst.entity:AddLight()
      ---  inst:AddComponent("lighttweener")
      ---  inst.components.lighttweener:StartTween(light, 5, 0.6, 0.8, {237/255, 237/255, 209/255}, 0)
      ----  light:Enable(true)
	
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
	-------light:Enable(false)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("jgb")
    inst.AnimState:SetBuild("jgb")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.CHOP, 66)
    inst.components.tool:SetAction(ACTIONS.MINE, 66)
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(100)
    inst.components.weapon:SetRange(2)
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/jgb.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = 1.2
    inst.components.equippable.insulated = true
    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("common/inventory/jgb", fn, assets)