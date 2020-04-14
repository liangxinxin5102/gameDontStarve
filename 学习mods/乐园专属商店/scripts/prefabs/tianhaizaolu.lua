
local assets =
{
	Asset("ANIM", "anim/ly_tianhai3x3.zip"),
	Asset("ANIM", "anim/ly_tianhai9x9.zip"),
	Asset("ANIM", "anim/ly_zaolu3x3.zip"),
	Asset("ANIM", "anim/ly_zaolu9x9.zip"),
	Asset("ATLAS", "images/ly_tianhai3x3.xml"),
	Asset("ATLAS", "images/ly_tianhai9x9.xml"),
	Asset("ATLAS", "images/ly_zaolu3x3.xml"),
	Asset("ATLAS", "images/ly_zaolu9x9.xml"),
}

local function fn1()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.entity:SetPristine()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("ly_tianhai3x3")
    inst.AnimState:SetBuild("ly_tianhai3x3")
    inst.AnimState:PlayAnimation("idle")

	inst.Transform:SetScale(3,3,3)
    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inspectable")		
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "ly_tianhai3x3"
	inst.components.inventoryitem.atlasname = "images/ly_tianhai3x3.xml"

    return inst
end
local function fn2()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.entity:SetPristine()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("ly_tianhai9x9")
    inst.AnimState:SetBuild("ly_tianhai9x9")
    inst.AnimState:PlayAnimation("idle")
	inst.Transform:SetScale(3,3,3)
    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")		
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "ly_tianhai9x9"
	inst.components.inventoryitem.atlasname = "images/ly_tianhai9x9.xml"

    return inst
end
local function fn3()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.entity:SetPristine()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("ly_zaolu3x3")
    inst.AnimState:SetBuild("ly_zaolu3x3")
    inst.AnimState:PlayAnimation("idle")
	inst.Transform:SetScale(3,3,3)


	if not TheWorld.ismastersim then
        return inst
    end
	inst:AddComponent("inspectable")		
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "ly_zaolu3x3"
	inst.components.inventoryitem.atlasname = "images/ly_zaolu3x3.xml"
	
    return inst
end
local function fn4()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.entity:SetPristine()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("ly_zaolu9x9")
    inst.AnimState:SetBuild("ly_zaolu9x9")
    inst.AnimState:PlayAnimation("idle")

	inst.Transform:SetScale(3,3,3)
	if not TheWorld.ismastersim then
        return inst
    end
	inst:AddComponent("inspectable")		
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "ly_zaolu9x9"
	inst.components.inventoryitem.atlasname = "images/ly_zaolu9x9.xml"
 
    return inst
end
return Prefab("ly_tianhai3x3", fn1, assets),  --c_give"ly_tianhai3x3"
	Prefab("ly_tianhai9x9", fn2, assets),   --c_give"ly_tianhai9x9"
	Prefab("ly_zaolu3x3", fn3, assets),   --c_give"ly_zaolu3x3"
	Prefab("ly_zaolu9x9", fn4, assets)    --c_give"ly_zaolu9x9"

