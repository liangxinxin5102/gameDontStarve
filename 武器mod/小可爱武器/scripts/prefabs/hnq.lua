local assets=
{
Asset("ANIM", "anim/hnq.zip"),
Asset("ANIM", "anim/dshnq.zip"),

Asset("ATLAS", "images/inventoryimages/hnq.xml"),
}

local prefabs = {
}



local function toolpower(inst)
if inst.components.redcherrystatus.level >= 0 and inst.components.redcherrystatus.level <= 100 then
		inst:DoTaskInTime(0.2, function ()
			inst.components.equippable.walkspeedmult = math.ceil(120)/100
			
		end)
	end
		if inst.components.redcherrystatus.level >= 100 then
		inst:DoTaskInTime(0.2, function ()
			inst.components.equippable.walkspeedmult = math.ceil(150)/100
			
		end)
	end
	
end

local function animground(inst)
	inst:DoTaskInTime(0.2, function ()
		local anim = inst.entity:AddAnimState()
		anim:SetBuild("dshnq")
		local bank = "dshnq"
		local level = inst.components.redcherrystatus.level
		if level >=0 then
			bank = "dshnq"
		end
		anim:SetBank(bank)
		anim:PlayAnimation("idle")
	end)
end




local function light(inst, owner)
	inst.components.burnable:Ignite()
	local level = inst.components.redcherrystatus.level
	if level >=40  then
		
		
		if inst.fire == nil then
			inst.fire = SpawnPrefab("nightstickfire")
			inst.fire.entity:AddFollower()
			inst.fire.Follower:FollowSymbol(owner.GUID, "swap_object", 0, -110, 0)
		end
	end
end

local function onequip(inst, owner)
	local level = inst.components.redcherrystatus.level
	inst:DoTaskInTime(0.2, function ()
	owner.components.talker:Say("武器目前等级为"..level.."级！") end)
	owner.AnimState:OverrideSymbol("swap_object", "hnq", "hnq")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
	
	light(inst, owner)
	toolpower(inst)
end

local function onunequip(inst, owner)
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")
	inst.components.burnable:Extinguish()
	if inst.fire ~= nil then
		inst.fire:Remove()
		inst.fire = nil
	end
	
end






local function onattack(inst, attacker, target, skipsanity, owner)
	
	
	
	
	if target:HasTag("dragonfly") and target.components.health:IsDead() then--蜻蜓
		inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 5
	end
	
	if target:HasTag("minotaur") and target.components.health:IsDead() then ---犀牛
		inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 5
	end
	
			local level = inst.components.redcherrystatus.level
	if level >=400  then
		
		level =400
		
	end
	----------------------------------
	if attacker.components.health then
		attacker.components.health:DoDelta(math.ceil(0.1+0.01*inst.components.redcherrystatus.level))
	end
	inst:DoTaskInTime(0.02, function () inst.components.weapon:SetDamage(math.ceil(30 + inst.components.redcherrystatus.level)) end)
	toolpower(inst)
	
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	MakeInventoryPhysics(inst)
	inst.entity:AddNetwork()
	
	if not TheWorld.ismastersim then
		return inst
	end
	
	inst:AddComponent("redcherrystatus")
	animground(inst)
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hnq.xml"
	
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )
	
	inst:AddComponent("tool")
	toolpower(inst)
	inst:AddComponent("finiteuses")
		inst.components.finiteuses:SetMaxUses(300)
		inst.components.finiteuses:SetUses(300)
		inst.components.finiteuses:SetOnFinished(inst.Remove)
	inst:AddComponent("inspectable")
	inst:AddComponent("burnable")
	inst.components.burnable.canlight = false
	inst.components.burnable.fxprefab = nil
	inst:AddComponent("named")

	inst.components.named:SetName("赤羽之矛\n击杀蜻蜓和犀牛可以升级")

	inst:AddComponent("weapon")
	
	inst:DoTaskInTime(0.02, function () inst.components.weapon:SetDamage(math.ceil(30 + inst.components.redcherrystatus.level)) end)
	inst.components.weapon:SetOnAttack(onattack)
	inst.components.weapon:SetRange(2)
	
	MakeHauntableLaunch(inst)
	return inst
end



return Prefab("common/inventory/hnq", fn, assets, prefabs)
