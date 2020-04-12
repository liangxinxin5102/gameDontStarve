require "prefabutil"
require "recipe"
require "modutil"


local assets=
{
    Asset("ANIM", "anim/backpack.zip"),
    Asset("ANIM", "anim/swap_bigbag.zip"),
    Asset("ATLAS", "images/inventoryimages/bigbag.xml"),
    Asset("ATLAS", "images/bigbagbg.xml"),
}

-------------------------------------------------------------------------------

local function onopen(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")

end

local function onclose(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
   
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "swap_bigbag", "backpack")
    owner.AnimState:OverrideSymbol("swap_body", "swap_bigbag", "swap_body")
    if inst.components.container ~= nil then
        inst.components.container:Open(owner)
    end
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    owner.AnimState:ClearOverrideSymbol("backpack")
    if inst.components.container ~= nil then
        inst.components.container:Close(owner)
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("backpack1")
    inst.AnimState:SetBuild("swap_bigbag")
    inst.AnimState:PlayAnimation("anim")
   inst:AddTag("backpack")
    inst:AddTag("fridge")
    inst:AddTag("nocool")
    inst:AddTag("bigbag")


    inst.foleysound = "dontstarve/movement/foley/krampuspack"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/bigbag.xml"
    inst.components.inventoryitem.cangoincontainer = false -- [[can be carried]]!!!!!!!!!!!!!!!!!!!!

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BACK or EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("bigbag")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    MakeHauntableLaunchAndDropFirstItem(inst)
    return inst
end

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

--local STRINGS=GLOBAL.STRINGS

STRINGS.NAMES.BIGBAG                                     = "小可爱之翼"
STRINGS.RECIPE_DESC.BIGBAG                               = "一个非常大的包."


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

return Prefab( "common/inventory/bigbag", fn, assets)
