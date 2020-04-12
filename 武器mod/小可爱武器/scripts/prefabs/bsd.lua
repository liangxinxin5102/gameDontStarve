local assets=
{
Asset("ANIM", "anim/cs.zip"),
Asset("ANIM", "anim/dscs.zip"),
Asset("ANIM", "anim/dsj.zip"),
Asset("ANIM", "anim/dsdsj.zip"),
Asset("ANIM", "anim/wzj.zip"),
Asset("ANIM", "anim/dswzj.zip"),
Asset("ANIM", "anim/szj.zip"),
Asset("ANIM", "anim/dsszj.zip"),
Asset("ANIM", "anim/xzj.zip"),
Asset("ANIM", "anim/dsxzj.zip"),
Asset("ATLAS", "images/inventoryimages/bsd.xml"),
}

local prefabs = {
}






local function NoHoles(pt)
	return not TheWorld.Map:IsPointNearHole(pt)
end
local function cnl(inst, owner, target)
	if math.random() < .2 then
		local pt
		if target ~= nil and target:IsValid() then
			pt = target:GetPosition()
		else
			pt = owner:GetPosition()
			target = nil
		end
		local offset = FindWalkableOffset(pt, math.random() * 2 * PI, 2, 3, false, true,NoHoles)
		if offset ~= nil then
			inst.SoundEmitter:PlaySound("dontstarve/common/shadowTentacleAttack_1")
			inst.SoundEmitter:PlaySound("dontstarve/common/shadowTentacleAttack_2")
			local tentacle = SpawnPrefab("shadowtentacle")
			if tentacle ~= nil then
				tentacle.Transform:SetPosition(pt.x + offset.x, 0, pt.z + offset.z)
				tentacle.components.combat:SetTarget(target)
			end
		end
	end
end

local function toolpower(inst)
	if inst.components.redcherrystatus.level >= 40  then
		inst:DoTaskInTime(0.2, function ()
			inst.components.equippable.walkspeedmult = math.ceil(100 + 0.4*inst.components.redcherrystatus.level)/100
			
		end)
	end
	
end

local function animground(inst)
	inst:DoTaskInTime(0.2, function ()
		local anim = inst.entity:AddAnimState()
		local build = "dscs"
		local bank = "dscs"
		local level = inst.components.redcherrystatus.level
		if level <10 then
			bank = "dscs"
			build = "dscs"
		end
		
		if level >=10 and level < 20 then
			bank = "dsdsj"
			build = "dsdsj"
		end
		if level >=20 and level < 30 then
			bank = "dswzj"
			build = "dswzj"
		end
		if level >=30 and level < 40 then
			bank = "dsszj"
			build = "dsszj"
		end
		if level >=40  then
			bank = "dsxzj"
			build = "dsxzj"
		end
		anim:SetBuild(build)
		anim:SetBank(bank)
		anim:PlayAnimation("idle")
	end)
end

local function overridesymbol(inst, owner)
	inst:DoTaskInTime(0.2, function ()
		local level = inst.components.redcherrystatus.level
		
		if level <1 then
			owner.AnimState:OverrideSymbol("swap_object", "cs", "cs")
			inst:DoTaskInTime(0.2, function ()
			owner.components.talker:Say("武器目前等级为0级，段位青铜！") end)
		end
		if level >=1 and level <10 then
			owner.AnimState:OverrideSymbol("swap_object", "cs", "cs")
			inst:DoTaskInTime(0.2, function ()
			owner.components.talker:Say("武器目前等级为"..level.."级，段位青铜！") end)
		end
			
		if level >=10 and level < 20 then
			owner.AnimState:OverrideSymbol("swap_object", "dsj", "dsj")
			inst:DoTaskInTime(0.2, function ()
			owner.components.talker:Say("武器目前等级为"..level.."级，段位白银！") end)
		end
		
		
		if level >=20 and level < 30 then
			owner.AnimState:OverrideSymbol("swap_object", "wzj", "wzj")
			
			inst:DoTaskInTime(0.2, function ()
			owner.components.talker:Say("武器目前等级为"..level.."级，段位黄金！") end)
		end
		
		
		if level >=30 and level < 40 then
			owner.AnimState:OverrideSymbol("swap_object", "szj", "szj")
			
			inst:DoTaskInTime(0.2, function ()
			owner.components.talker:Say("武器目前等级为"..level.."级，段位白金！") end)
		end
		
		
		if level >=40 and level < 50 then
			owner.AnimState:OverrideSymbol("swap_object", "xzj", "xzj")
			
			inst:DoTaskInTime(0.2, function ()
			owner.components.talker:Say("武器目前等级为"..level.."级，段位大师！") end)
		end
		
		
		if level >=50  then
			owner.AnimState:OverrideSymbol("swap_object", "xzj", "xzj")
			
			inst:DoTaskInTime(0.2, function ()
			owner.components.talker:Say("武器已满级，段位王者！！") end)
		end
		
	
	end)
end



local function light(inst, owner)
	inst.components.burnable:Ignite()
	local level = inst.components.redcherrystatus.level
	if level >=50  then
		
		
		if inst.fire == nil then
			inst.fire = SpawnPrefab("nightstickfire")
			inst.fire.entity:AddFollower()
			inst.fire.Follower:FollowSymbol(owner.GUID, "swap_object", 0, -110, 0)
		end
	end
end

local function onequip(inst, owner)
	overridesymbol(inst, owner)
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


local function onpocket(inst)
	inst.components.burnable:Extinguish()
end




local function onattack(inst, attacker, target, skipsanity, owner)
	local level = inst.components.redcherrystatus.level
	if target.components.health:IsDead() then
		if level <1 then
			inst:DoTaskInTime(0.2, function ()
			attacker.components.talker:Say("武器目前等级为0级，段位青铜！") end)
		end
		
		if level >=1 and level <9 then
			inst:DoTaskInTime(0.2, function ()
			attacker.components.talker:Say("武器目前等级为"..level.."级，段位青铜！") end)
		end
		if level >=9 and level <10 then
			inst:DoTaskInTime(0.2, function ()
			attacker.components.talker:Say("武器目前等级为"..level.."级，需要杀死树精才能升级！") end)
		end
		
		if level >=10 and level <19  then
			inst:DoTaskInTime(0.2, function ()
			attacker.components.talker:Say("武器目前等级为"..level.."级，段位白银！") end)
		end
		if level >=19 and level <20 then
			inst:DoTaskInTime(0.2, function ()
			attacker.components.talker:Say("武器目前等级为"..level.."级，需要杀死巨鹿才能升级！") end)
		end
		
		if level >=20 and level <29 then
			inst:DoTaskInTime(0.2, function ()
			attacker.components.talker:Say("武器目前等级为"..level.."级，段位黄金！") end)
		end
		if level >=29 and level <30 then
			inst:DoTaskInTime(0.2, function ()
			attacker.components.talker:Say("武器目前等级为"..level.."级，需要杀死巨熊才能升级！") end)
		end
		if level >=30 and level < 39 then
			inst:DoTaskInTime(0.2, function ()
			attacker.components.talker:Say("武器目前等级为"..level.."级，段位白金！") end)
		end
		if level >=39 and level < 40 then
			inst:DoTaskInTime(0.2, function ()
			attacker.components.talker:Say("武器目前等级为"..level.."级，需要杀死特定蛤蟆才能升级！") end)
		end
		if level >=40 and level < 49 then
			inst:DoTaskInTime(0.2, function ()
			attacker.components.talker:Say("武器目前等级为"..level.."级，段位大师！") end)
		end
		if level >=49 and level < 50 then
			inst:DoTaskInTime(0.2, function ()
			attacker.components.talker:Say("武器目前等级为"..level.."级，需要杀死特定龙蝇才能升级！") end)
		end

		
		if level >=50 then
			inst:DoTaskInTime(0.2, function ()
			attacker.components.talker:Say("武器已满级，段位王者！！") end)
		end
		
		if inst.components.redcherrystatus.level <= 9 then
			inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + .1
		end
		if inst.components.redcherrystatus.level >= 10 and inst.components.redcherrystatus.level <= 19 then
			inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + (math.floor(math.random()*100+1)-10)/1000
		end
		if inst.components.redcherrystatus.level >= 20 and inst.components.redcherrystatus.level <= 29 then
			inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + (math.floor(math.random()*100+1)-20)/2000
		end
		if inst.components.redcherrystatus.level >= 30 and inst.components.redcherrystatus.level <= 39 then
			inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + (math.floor(math.random()*100+1)-30)/3000
		end
		if inst.components.redcherrystatus.level >= 40 and inst.components.redcherrystatus.level <= 49 then
			inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + (math.floor(math.random()*100+1)-30)/5000
		end
		if inst.components.redcherrystatus.level >= 50 then
			inst.components.redcherrystatus.level = 50
		end
		
	end
	------------------------------------------------
	if target:HasTag("leif") and target.components.health:IsDead() then
		if inst.components.redcherrystatus.level >= 9 and inst.components.redcherrystatus.level < 10 then
			inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 1
		end
	end
	if target:HasTag("deerclops") and target.components.health:IsDead() then
		if inst.components.redcherrystatus.level >= 19 and inst.components.redcherrystatus.level < 20 then
			inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 1
		end
	end
	if target:HasTag("bearger") and target.components.health:IsDead() then
		if inst.components.redcherrystatus.level >= 29 and inst.components.redcherrystatus.level < 30 then
			local randomnum = math.floor(math.random()*100+1)
		
			if randomnum >= 0 and randomnum < 35 then
				inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 0
				inst:DoTaskInTime(0.2, function ()
			    attacker.components.talker:Say("升级失败，等级没有变化！") end)
			end
			if randomnum >= 35 and randomnum < 45 then
				inst.components.redcherrystatus.level = inst.components.redcherrystatus.level - 1
				inst:DoTaskInTime(0.2, function ()
			    attacker.components.talker:Say("升级失败，等级下降1级！") end)
			end
			if randomnum >= 45 and randomnum < 50 then
				inst.components.redcherrystatus.level = inst.components.redcherrystatus.level - 3
				inst:DoTaskInTime(0.2, function ()
			    attacker.components.talker:Say("升级失败，等级下降3级！！") end)
			end
			if randomnum >= 50 and randomnum < 100 then
				inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 1
				inst:DoTaskInTime(0.2, function ()
			    attacker.components.talker:Say("升级成功，等级上升1级！") end)
			end
			
		end
	end
	if target:HasTag("toadstool") and target.components.health:IsDead() then
		if inst.components.redcherrystatus.level >= 39 and inst.components.redcherrystatus.level < 40 then
			local randomnum = math.floor(math.random()*100+1)
			if randomnum >= 0 and randomnum < 35 then
				inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 0
				inst:DoTaskInTime(0.2, function ()
			    attacker.components.talker:Say("升级失败，等级没有变化！") end)
			end
			if randomnum >= 35 and randomnum < 55 then
				inst.components.redcherrystatus.level = inst.components.redcherrystatus.level - 1
				inst:DoTaskInTime(0.2, function ()
			    attacker.components.talker:Say("升级失败，等级下降1级！") end)
			end
			if randomnum >= 55 and randomnum < 70 then
				inst.components.redcherrystatus.level = inst.components.redcherrystatus.level - 3
				inst:DoTaskInTime(0.2, function ()
			    attacker.components.talker:Say("升级失败，等级下降3级！！") end)
			end
			if randomnum >= 70 and randomnum < 100 then
				inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 1
				inst:DoTaskInTime(0.2, function ()
			    attacker.components.talker:Say("升级成功，等级上升1级！") end)
			end
		end
	end
	if target:HasTag("dragonfly") and target.components.health:IsDead() then
		if inst.components.redcherrystatus.level >= 49 and inst.components.redcherrystatus.level < 50 then
			local randomnum = math.floor(math.random()*100+1)
			if randomnum >= 0 and randomnum < 35 then
				inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 0
				inst:DoTaskInTime(0.2, function ()
			    attacker.components.talker:Say("升级失败，等级没有变化！") end)
			end
			if randomnum >= 35 and randomnum < 60 then
				inst.components.redcherrystatus.level = inst.components.redcherrystatus.level - 1
				inst:DoTaskInTime(0.2, function ()
			    attacker.components.talker:Say("升级失败，等级下降1级！") end)
			end
			if randomnum >= 60 and randomnum < 80 then
				inst.components.redcherrystatus.level = inst.components.redcherrystatus.level - 3
				inst:DoTaskInTime(0.2, function ()
			    attacker.components.talker:Say("升级失败，等级下降3级！！") end)
			end
			if randomnum >= 80 and randomnum < 100 then
				inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 1
				inst:DoTaskInTime(0.2, function ()
			    attacker.components.talker:Say("升级成功，等级上升1级！") end)
			end
		end
	end

	
	

	----------------------------------
	if inst.components.redcherrystatus.level < 10 then
		inst:DoTaskInTime(0.02, function () inst.components.weapon:SetDamage(math.ceil(10 + inst.components.redcherrystatus.level)) end)
	end
	
	if inst.components.redcherrystatus.level >= 10 and inst.components.redcherrystatus.level < 20 then
		inst:DoTaskInTime(0.02, function () inst.components.weapon:SetDamage(math.ceil(10 + 1.1*inst.components.redcherrystatus.level)) end)
	end
	
	if inst.components.redcherrystatus.level >= 20 and inst.components.redcherrystatus.level < 30 then
		inst:DoTaskInTime(0.02, function () inst.components.weapon:SetDamage(math.ceil(10 + 1.2*inst.components.redcherrystatus.level)) end)
		if attacker.components.health then
			attacker.components.health:DoDelta(0.2)
		end
	end
	
	if inst.components.redcherrystatus.level >= 30 and inst.components.redcherrystatus.level < 40 then
		inst:DoTaskInTime(0.02, function () inst.components.weapon:SetDamage(math.ceil(10 + 1.3*inst.components.redcherrystatus.level)) end)
		if attacker.components.health then
			attacker.components.health:DoDelta(0.3)
		end
		if  target ~= nil and target.components.freezable ~= nil then
			target.components.freezable:AddColdness(0.3)
		end
	end
	if inst.components.redcherrystatus.level >= 40 and inst.components.redcherrystatus.level < 50 then
		inst:DoTaskInTime(0.02, function () inst.components.weapon:SetDamage(math.ceil(10 + 1.4*inst.components.redcherrystatus.level)) end)
		if attacker.components.health then
			attacker.components.health:DoDelta(0.5)
		end
		if  target ~= nil and target.components.freezable ~= nil then
			target.components.freezable:AddColdness(0.5)
		end
		if attacker and target.components.freezable then
			
		end
	end
	
	if inst.components.redcherrystatus.level >= 50  then
		inst:DoTaskInTime(0.02, function () inst.components.weapon:SetDamage(math.ceil(10 + 1.4*inst.components.redcherrystatus.level)) end)
		if attacker.components.health then
			attacker.components.health:DoDelta(0.5)
		end
		if  target ~= nil and target.components.freezable ~= nil then
			target.components.freezable:AddColdness(0.5)
		end
		if attacker and target.components.freezable then
			cnl(inst, owner, target)
		end
	end
	

	toolpower(inst)
	animground(inst)
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
	inst.components.inventoryitem.atlasname = "images/inventoryimages/bsd.xml"
	
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnPocket(onpocket)
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )
	
	inst:AddComponent("tool")
	toolpower(inst)
	
	inst:AddComponent("inspectable")
	inst:AddComponent("burnable")
	inst.components.burnable.canlight = false
	inst.components.burnable.fxprefab = nil
	

	inst:AddComponent("weapon")
	inst.components.weapon:SetOnAttack(onattack)
	if inst.components.redcherrystatus.level < 10 then
		inst:DoTaskInTime(0.02, function () inst.components.weapon:SetDamage(math.ceil(10 + inst.components.redcherrystatus.level)) end)
	end
	if inst.components.redcherrystatus.level >= 10 and inst.components.redcherrystatus.level < 20 then
		inst:DoTaskInTime(0.02, function () inst.components.weapon:SetDamage(math.ceil(10 + 1.1*inst.components.redcherrystatus.level)) end)
	end
	if inst.components.redcherrystatus.level >= 20 and inst.components.redcherrystatus.level < 30 then
		inst:DoTaskInTime(0.02, function () inst.components.weapon:SetDamage(math.ceil(10 + 1.2*inst.components.redcherrystatus.level)) end)
	end
	if inst.components.redcherrystatus.level >= 30 and inst.components.redcherrystatus.level < 40 then
		inst:DoTaskInTime(0.02, function () inst.components.weapon:SetDamage(math.ceil(10 + 1.3*inst.components.redcherrystatus.level)) end)
	end
	if inst.components.redcherrystatus.level >= 40 and inst.components.redcherrystatus.level < 50 then
		inst:DoTaskInTime(0.02, function () inst.components.weapon:SetDamage(math.ceil(10 + 1.4*inst.components.redcherrystatus.level)) end)
	end
	if inst.components.redcherrystatus.level >= 50 then
		inst:DoTaskInTime(0.02, function () inst.components.weapon:SetDamage(math.ceil(10 + 1.4*inst.components.redcherrystatus.level)) end)
		
		inst.components.weapon:SetOnAttack(cnl)
	end
	inst:AddComponent("finiteuses")
		inst.components.finiteuses:SetMaxUses(800)
		inst.components.finiteuses:SetUses(800)
		inst.components.finiteuses:SetOnFinished(inst.Remove)
	MakeHauntableLaunch(inst)
	return inst
end


return Prefab("common/inventory/bsd", fn, assets, prefabs)
