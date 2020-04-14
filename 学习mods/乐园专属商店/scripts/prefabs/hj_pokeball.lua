local assets =
{
	Asset("ANIM", "anim/hj_pokeball.zip"),
	Asset("ANIM", "anim/hj_jzpokeball.zip"),
}

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "hj_pokeball", "swap")

    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onepokedquip(inst, owner)
	if inst._prefab:value() == "" then
		owner.AnimState:OverrideSymbol("swap_object", "hj_pokeball", "swap")
	else
		owner.AnimState:OverrideSymbol("swap_object", "poke_"..inst._prefab:value(), "swap")
	end

    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onjzequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "hj_jzpokeball", "swap")

    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function OnHitPock(inst, attacker, target)
	if inst.components.hj_pokeball and inst.components.hj_pokeball.poke ~= nil then
		local x,y,z = inst.Transform:GetWorldPosition()
		inst.components.hj_pokeball:Unpock(x,0,z)
	else
		inst:Remove()
	end
end
local function OnHit(inst, attacker, target)
	if target and target:IsValid() and target.components.health ~= nil and not target.components.health:IsDead() then
		local ball = SpawnPrefab("hj_pokedball")
		local x,y,z = target.Transform:GetWorldPosition()
		if ball then 
			ball.Transform:SetPosition(x,0,z)
			if  ball.components.hj_pokeball then
				ball.components.hj_pokeball:Pock(target,attacker)
			else
				ball:Remove()
			end
		end
	end
	inst:Remove()
end

--jz=================================
local function OnJZHit(inst, attacker, target,pos)
	if target and target:IsValid() then
		local ball = SpawnPrefab("hj_jzpokedball")
		local x,y,z = target.Transform:GetWorldPosition()
		if ball then 
			ball.Transform:SetPosition(x,0,z)
			if  ball.components.hj_jzpokeball then
				ball.components.hj_jzpokeball:Pock(target,attacker)
			else
				ball:Remove()
			end
		end
	end
	inst:Remove()
end
local function OnJZHitPock(inst, attacker, target,pos)
	if inst.components.hj_jzpokeball and inst.components.hj_jzpokeball.poke ~= nil then
		local x,y,z = inst.Transform:GetWorldPosition()
		if pos ~= nil then
			x,y,z = pos:Get()
		end
		inst.components.hj_jzpokeball:Unpock(x,y,z)
	else
		inst:Remove()
	end
end
---============================
local function get_name(inst)
	if inst._name:value() == "" then
		return	"损坏的精灵球"
	else
		return inst._name:value().." 精灵球"
	end
end
local function get_namejz(inst)
	if inst._name:value() == "" then
		return	"损坏的打包球"
	else
		return inst._name:value().." 建筑球"
	end
end

local function onthrown(inst)
    inst:AddTag("NOCLICK")
    inst.persists = false
	
	inst.Transform:SetScale(0.8, 0.8, 0.8)
    inst.AnimState:PlayAnimation("loop", true)
	
    inst.Physics:SetMass(1)
    inst.Physics:SetCapsule(0.2, 0.2)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(0)
    inst.Physics:ClearCollisionMask()
end

local function commonfn(name,com)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank(name)
    inst.AnimState:SetBuild(name)
    inst.AnimState:PlayAnimation("idle",true)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = name
	inst.components.inventoryitem.atlasname = "images/hjball.xml"
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(10)
	
	inst:AddComponent(com)
    inst.components[com]:SetHorizontalSpeed(15)
    inst.components[com]:SetGravity(-35)
    inst.components[com]:SetLaunchOffset(Vector3(.25, 1, 0))
    inst.components[com]:SetOnLaunch(onthrown)
    
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnUnequip(onunequip)
    MakeHauntableLaunch(inst)

    return inst
end
local function pock()
    local inst = commonfn("hj_pokeball","hjprojectile")

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst.components.hjprojectile:SetOnHit(OnHit)
    inst.components.equippable:SetOnEquip(onequip)

    return inst
end

local function pocked()

    local inst = commonfn("hj_pokeball","hjprojectile")
	
	inst._name = net_string(inst.GUID, "hj_pokeball._name")
	inst._prefab = net_string(inst.GUID, "hj_pokeball._prefab")
	inst.displaynamefn = get_name
	
    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.hjprojectile:SetOnHit(OnHitPock)
	
	inst:AddComponent("hj_pokeball")

    inst.components.equippable:SetOnEquip(onepokedquip)

    return inst
end
local function jzpock()

    local inst = commonfn("hj_jzpokeball","hjjzprojectile")
	
    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.hjjzprojectile:SetOnHit(OnJZHit)

    inst.components.equippable:SetOnEquip(onjzequip)

    return inst
end
local function jzpocked()

    local inst = commonfn("hj_jzpokeball","hjjzprojectile")
	inst._name = net_string(inst.GUID, "hj_jzpokeball._name")
	inst.displaynamefn = get_namejz
    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.hjjzprojectile:SetOnHit(OnJZHitPock)

	inst:AddComponent("hj_jzpokeball")

    inst.components.equippable:SetOnEquip(onjzequip)

    return inst
end
return Prefab("hj_pokeball", pock, assets),
	Prefab("hj_pokedball", pocked, assets),
	Prefab("hj_jzpokeball", jzpock, assets),
	Prefab("hj_jzpokedball", jzpocked, assets)