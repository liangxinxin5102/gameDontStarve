
local assets=
{
	Asset("ANIM", "anim/zg_we_blacknight_swap.zip"),
	Asset("ANIM", "anim/zg_we_blacknight.zip"),
	Asset("ATLAS", "images/zg_we_blacknight.xml"),
	Asset("IMAGE", "images/zg_we_blacknight.tex"),
}

local function onattack_gandr(inst, attacker, target)

    if attacker and attacker.components.sanity then
        attacker.components.sanity:DoDelta(-0)
    end
end

local function storeincontainer(inst, container)
    if container ~= nil and container.components.container ~= nil then
        inst:ListenForEvent("onputininventory", inst._oncontainerownerchanged, container)
        inst:ListenForEvent("ondropped", inst._oncontainerownerchanged, container)
        inst._container = container
    end
end

local function unstore(inst)
    if inst._container ~= nil then
        inst:RemoveEventCallback("onputininventory", inst._oncontainerownerchanged, inst._container)
        inst:RemoveEventCallback("ondropped", inst._oncontainerownerchanged, inst._container)
        inst._container = nil
    end
end

local function topocket(inst, owner)
    if inst._container ~= owner then
        unstore(inst)
        storeincontainer(inst, owner)
    end
end

local function toground(inst)
    unstore(inst)
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	inst.Transform:SetScale(1.5,1.5,1.5)
	
	inst.AnimState:SetBank("zg_we_blacknight")
    inst.AnimState:SetBuild("zg_we_blacknight")
    inst.AnimState:PlayAnimation("idle")
	
	if not TheWorld.ismastersim then
        return inst
    end
	
	inst._container = nil
	
    inst._oncontainerownerchanged = function(container)
        topocket(inst, container)
    end

    inst._oncontainerremoved = function()
        unstore(inst)
    end
	
    local function OnEquip(inst, owner)
        owner.AnimState:OverrideSymbol("swap_object", "zg_we_blacknight_swap", "zg_we_blacknight_swap")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
		--inst.SoundEmitter:PlaySound("jile/qm/jileshijie","jile")
		
		inst.entity:AddLight()
		inst.Light:Enable(true)
		inst.Light:SetRadius(7)  ----光照范围
		inst.Light:SetFalloff(.5)
		inst.Light:SetIntensity(.5)
		inst.Light:SetColour(225/255,120/255,80/255)
		
		
    end
 
    local function OnUnequip(inst, owner)
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
    end
 
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/zg_we_blacknight.xml"
	inst.components.inventoryitem.imagename = "zg_we_blacknight"
     
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
	inst.components.equippable.walkspeedmult = 1.3
	
	inst:AddComponent("inspectable")
	inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.CHOP, 15)   --砍伐
    inst.components.tool:SetAction(ACTIONS.MINE, 15)   --开采
    inst.components.tool:SetAction(ACTIONS.DIG)        --铲土
    inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_ABSOLUTE)
	
	
	-----c_give("shenqi")
		
	inst:AddTag("shadow")
 	inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(3200)
	inst.components.weapon:SetOnAttack(onattack_gandr)
    inst.components.weapon:SetRange(2, 2)

    return inst
	
end
STRINGS.NAMES.SHENQI = "乐园 极乐宝刃" 
	
return  Prefab("common/inventory/shenqi", fn, assets)