local assets ={
    Asset("ATLAS","images/inventoryimages/beer.xml"),
}

local prefabs = {}

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then 
        return inst
    end
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "beer"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/beer.xml"
    return inst
end
return Prefab("beer",fn,assets,prefabs)