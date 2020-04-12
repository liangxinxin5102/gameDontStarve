local assets=
{
Asset("ANIM", "anim/sjz.zip"),
Asset("ANIM", "anim/dssjz.zip"),

Asset("ATLAS", "images/inventoryimages/sjz.xml"),
}

local prefabs = {
}

local function animground(inst)
	inst:DoTaskInTime(0.2, function ()
		local anim = inst.entity:AddAnimState()
		anim:SetBuild("dssjz")
		local bank = "dssjz"
		anim:SetBank(bank)
		anim:PlayAnimation("idle",true)
	end)
end




local function light(inst, owner)
	inst.components.burnable:Ignite()				
		if inst.fire == nil then
			inst.fire = SpawnPrefab("nightstickfire")
			inst.fire.entity:AddFollower()
			inst.fire.Follower:FollowSymbol(owner.GUID, "swap_object", 0, -110, 0)
		end
	
end

local function onequip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "sjz", "sjz")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
	light(inst, owner)
	
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

	if  target ~= nil and target.components.freezable ~= nil then
			target.components.freezable:AddColdness(1)
		end

	
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
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sjz.xml"
	
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )
	
	inst:AddComponent("tool")
	
	inst:AddComponent("inspectable")
	inst:AddComponent("burnable")
	inst.components.burnable.canlight = false
	inst.components.burnable.fxprefab = nil
		inst:AddComponent("named")

	inst.components.named:SetName("上九之杖\n上九专属法杖")

	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(100)
	inst.components.weapon:SetOnAttack(onattack)
	inst.components.weapon:SetRange(6)
	 inst.components.weapon:SetProjectile("bishop_charge")
	 
	 MakeHauntableLaunch(inst)
	return inst
end



return Prefab("common/inventory/sjz", fn, assets, prefabs)
