require "prefabutil"
require "recipe"
require "modutil"

local bags = {
{"ly_bobbag"},
{"ly_hehebag"},
{"ly_wingbag"},
{"ly_pandabag"},
}

local function Makeweapon(idx)
	local assets = {
    Asset("ANIM", "anim/"..idx[1]..".zip"),
    Asset("IMAGE", "images/inventoryimages/"..idx[1]..".tex"),
    Asset("ATLAS", "images/inventoryimages/"..idx[1]..".xml"),
	Asset("IMAGE", "images/ly_bagbg2.tex"),
    Asset("ATLAS", "images/ly_bagbg2.xml"),
	}
	
local function update(inst, owner) 	 
     local day = owner.components.age:GetDisplayAgeInDays()
     if day >= 1000 then --天数大于1000背包升级
        inst.components.waterproofer:SetEffectiveness(1)
	    inst.components.equippable.walkspeedmult = 1.15
	    inst.components.equippable.dapperness = 0.3
		inst:AddTag("fridge")
	 else
		inst.components.equippable.walkspeedmult = 1.1
	    inst.components.equippable.dapperness = 0.1	
        inst.components.waterproofer:SetEffectiveness(0.8)
        inst:RemoveTag("fridge")
     end		
		
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", idx[1], "swap_body")
	 owner.AnimState:OverrideSymbol("backpack", idx[1], "backpack")
    if inst.components.container ~= nil then
	   local day = owner.components.age:GetDisplayAgeInDays()
		update(inst, owner)
		if day >= 1000 then 
		  if owner.components.temperature then --高级背包装备时保持体温上下限
			 owner.components.temperature.maxtemp = 50 --最高50
			 owner.components.temperature.mintemp = 10 --最低10
			 owner.components.health.fire_damage_scale = 0  --火焰伤害0
		  end
		end
        inst.components.container:Open(owner)
    end
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
	owner.AnimState:ClearOverrideSymbol("backpack")
    if inst.components.container ~= nil then
        inst.components.container:Close(owner)
    end
	if owner.components.temperature  then --脱下以后还原体温上下限
			owner.components.temperature.maxtemp = TUNING.MAX_ENTITY_TEMP
			owner.components.temperature.mintemp = TUNING.MIN_ENTITY_TEMP
			owner.components.health.fire_damage_scale = 1
	end
end

	
	
local function fn(Sim)
 local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank(idx[1])
    inst.AnimState:SetBuild(idx[1])
    inst.AnimState:PlayAnimation("anim")
    inst:AddTag("backpack")
    inst:AddTag("fridge")
    inst:AddTag("nocool")
    inst:AddTag("ly_bag")

    inst.foleysound = "dontstarve/movement/foley/krampuspack"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddTag("waterproofer")
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/"..idx[1]..".xml"
    inst.components.inventoryitem.cangoincontainer = false 
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BACK or EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = 1.1
	inst.components.equippable.dapperness = 0.1
	inst:AddComponent("waterproofer")
	inst.components.waterproofer:SetEffectiveness(1)
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("ly_bag")
    MakeHauntableLaunchAndDropFirstItem(inst)
    return inst
	end
	return Prefab(idx[1], fn, assets)
end

local ly_bag = {}

for i,v in ipairs(bags) do
	table.insert(ly_bag, Makeweapon(v))
end

return unpack(ly_bag)

