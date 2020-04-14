
local function hj(name)

local assets =
{
    Asset("ANIM", "anim/"..name..".zip"),
	Asset("ATLAS", "images/inventoryimages/"..name..".xml"),
}

local function onequip(inst, owner) --清除背包开启时的碰撞体积
    owner.AnimState:OverrideSymbol("swap_body", name, "swap_body")
    inst.components.container:Open(owner)
end

local function onunequip(inst, owner) --清除背包关闭时的碰撞体积
    owner.AnimState:ClearOverrideSymbol("swap_body")
    inst.components.container:Close(owner)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank(name)
    inst.AnimState:SetBuild(name)
    inst.AnimState:PlayAnimation("idle")

    inst.foleysound = "dontstarve/movement/foley/krampuspack"

    inst:AddTag("backpack")
	
	inst:AddTag("hjwings")

    inst:AddTag("waterproofer")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.cangoincontainer = false
	inst.components.inventoryitem.atlasname = "images/inventoryimages/"..name..".xml"

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot =  EQUIPSLOTS.BACK or EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(0.99) --防水

    inst:AddComponent("container")
    inst.components.container:WidgetSetup(name)

    MakeHauntableLaunchAndDropFirstItem(inst)

    return inst
end

return Prefab(name, fn, assets)
end

return hj("hj_wings1"),
		hj("hj_wings2"),
		hj("hj_wings3"),
		hj("hj_wings4"),
		hj("hj_wings5")