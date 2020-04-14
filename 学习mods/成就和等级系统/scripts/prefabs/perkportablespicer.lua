require "prefabutil"

local assets_item =
{
    Asset("ANIM", "anim/portable_spicer.zip"),
    Asset("ATLAS", "images/inventoryimages/perkportablespicer.xml"),
    Asset("IMAGE", "images/inventoryimages/perkportablespicer.tex"),
}

local prefabs_item =
{
    "portablespicer",
}

---------------------------------------------------------------
----------------- Inventory Portable Spicer -------------------
---------------------------------------------------------------

local function ondeploy(inst, pt, deployer)
    local spicer = SpawnPrefab("portablespicer")
    if spicer ~= nil then
        spicer.Physics:SetCollides(false)
        spicer.Physics:Teleport(pt.x, 0, pt.z)
        spicer.Physics:SetCollides(true)
        spicer.AnimState:PlayAnimation("place")
        spicer.AnimState:PushAnimation("idle_empty", false)
        spicer.SoundEmitter:PlaySound("dontstarve/common/together/portable/spicer/place")
        inst:Remove()
        PreventCharacterCollisionsWithPlacedObjects(spicer)
    end
end

local function itemfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("portable_spicer")
    inst.AnimState:SetBuild("portable_spicer")
    inst.AnimState:PlayAnimation("idle_ground")

    inst:AddTag("portableitem")

    MakeInventoryFloatable(inst, "med")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/perkportablespicer.xml"

    inst:AddComponent("deployable")
    inst.components.deployable.restrictedtag = "masterchef"
    inst.components.deployable.ondeploy = ondeploy
    --inst.components.deployable:SetDeployMode(DEPLOYMODE.ANYWHERE)
    --inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    MakeMediumBurnable(inst)
    MakeSmallPropagator(inst)

    return inst
end

return MakePlacer("perkportablespicer_placer", "portable_spicer", "portable_spicer", "idle_empty"),
    Prefab("perkportablespicer", itemfn, assets_item, prefabs_item)
