local assets=
{
Asset("ANIM", "anim/xzz.zip"),
Asset("ANIM", "anim/dsxzz.zip"),

Asset("ATLAS", "images/inventoryimages/xzz.xml"),
}

local prefabs = {
}

local function animground(inst)
	inst:DoTaskInTime(0.2, function ()
		local anim = inst.entity:AddAnimState()
		anim:SetBuild("dsxzz")
		local bank = "dsxzz"
		anim:SetBank(bank)
		anim:PlayAnimation("idle",true)
	end)
end








local function onequip(inst, owner)
	local level = inst.components.redcherrystatus.level
	inst:DoTaskInTime(0.2, function ()
	owner.components.talker:Say("武器目前等级为"..level.."级！") end)
	owner.AnimState:OverrideSymbol("swap_object", "xzz", "xzz")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
	
	
	
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
	
	
	if target:HasTag("glommer") and target.components.health:IsDead() then--咕噜米
		inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 5
	end
	
			local level = inst.components.redcherrystatus.level
	if level >=666  then
		
		level =666
		
	end
	
	inst:DoTaskInTime(0.02, function () inst.components.weapon:SetDamage(math.ceil(20 + inst.components.redcherrystatus.level)) end)
	
	
	if math.random() <= 0.10 then
		local x,y,z = target.Transform:GetWorldPosition()
		local ents = TheSim:FindEntities(x,y,z,4)
	
		attacker.components.combat:DoAreaAttack(target, 4, inst, nil, nil, {"player"})
		for i,v in pairs(ents) do 
		if v:HasTag("player") and v ~= attacker and TheNet:GetPVPEnabled() then
			if not v.components.inventory:IsInsulated() then
				v.components.health:DoDelta(-20)
				v.sg:GoToState("electrocute")
			end
		end
		if v.components.health and not v:HasTag("player") then
	
		local x,y,z = v.Transform:GetWorldPosition()
		SpawnPrefab("lightning").Transform:SetPosition(x,y,z)
		v.components.health:DoDelta(-10)
		end
		end
		if attacker.components.sanity then
		attacker.components.sanity:DoDelta(-5)
		end
	
	
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
	inst.components.inventoryitem.atlasname = "images/inventoryimages/xzz.xml"
	
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )
	
	inst:AddComponent("tool")
		inst:AddComponent("finiteuses")
		inst.components.finiteuses:SetMaxUses(300)
		inst.components.finiteuses:SetUses(300)
		inst.components.finiteuses:SetOnFinished(inst.Remove)
	
	inst:AddComponent("inspectable")
	inst:AddComponent("burnable")
	inst.components.burnable.canlight = false
	inst.components.burnable.fxprefab = nil
	inst:AddComponent("named")
	
	inst.components.named:SetName("小可爱之杖\n击杀咕噜米可以升级")
	
	inst:AddComponent("weapon")
	
	inst:DoTaskInTime(0.02, function () inst.components.weapon:SetDamage(math.ceil(20 + inst.components.redcherrystatus.level)) end)
	inst.components.weapon:SetOnAttack(onattack)
	inst.components.weapon:SetRange(6)

	inst.components.weapon:SetProjectile("bishop_charge")
	return inst
end



return Prefab("common/inventory/xzz", fn, assets, prefabs)
