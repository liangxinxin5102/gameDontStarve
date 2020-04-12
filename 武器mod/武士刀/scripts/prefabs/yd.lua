local assets=
{
	Asset("ANIM", "anim/yd.zip"),
	Asset("ANIM", "anim/dsyd.zip"),
	Asset("ATLAS", "images/inventoryimages/yd.xml"),
}

local prefabs = {
}

local function toolpower(inst)
	inst:DoTaskInTime(0.2, function() 
		if TUNING.redcherrychop == 1 then
		    inst.components.tool:SetAction(ACTIONS.CHOP, math.ceil(1 + .05*inst.components.redcherrystatus.level))
		end
	    if TUNING.redcherrymine == 1 then
		    inst.components.tool:SetAction(ACTIONS.MINE, math.ceil(1 + .05*inst.components.redcherrystatus.level))
		end
		if TUNING.redcherryhammer == 1 then
	    	inst.components.tool:SetAction(ACTIONS.HAMMER,math.ceil(1 + .05*inst.components.redcherrystatus.level))
		end
		if TUNING.redcherrydig == 1 then
	    	inst.components.tool:SetAction(ACTIONS.DIG,math.ceil(1 + .05*inst.components.redcherrystatus.level))
		end
		inst.components.equippable.walkspeedmult = 1.2
	end)
end

local function animground(inst)
    inst:DoTaskInTime(0.2, function()
    	local anim = inst.entity:AddAnimState()
    	anim:SetBuild("dsyd")
	    local bank = "dsyd"
	    local level = inst.components.redcherrystatus.level
	    if level >=0 then
			bank = "dsyd"
		end
	    anim:SetBank(bank)
	    anim:PlayAnimation("idle")
    end)
end

local function overridesymbol(inst, owner)
	inst:DoTaskInTime(0.2, function()
		local level = inst.components.redcherrystatus.level
		if level >=0 then
			owner.AnimState:OverrideSymbol("swap_object", "yd", "yd")
		end
	end)
end

local function onequip(inst, owner) 
    overridesymbol(inst, owner)
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal")
if inst.components.redcherrystatus.level < 25  then	
if owner.components.health:IsDead() then
		inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 5
end
end
inst:DoTaskInTime(0.02, function() inst.components.weapon:SetDamage(math.ceil(10 + inst.components.redcherrystatus.level)) end)
    toolpower(inst)
    if TUNING.BB then
	   inst.components.container:Open(owner)
	end
toolpower(inst)
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
if inst.components.redcherrystatus.level < 25  then
if owner.components.health:IsDead() then
		inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 5
end
end
inst:DoTaskInTime(0.02, function() inst.components.weapon:SetDamage(math.ceil(10 + inst.components.redcherrystatus.level)) end)
	if TUNING.BB then
	   inst.components.container:Close(owner)
	end
toolpower(inst)
end




local function onattack(inst, attacker, target, skipsanity, owner)
	if target.components.health:IsDead() then
		inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 1*TUNING.XXS
	end
	if target:HasTag("pig") and target:HasTag("character") and target:HasTag("scarytoprey") and target.components.health:IsDead() then--猪
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 1
	end
	if target:HasTag("cavedweller") and target:HasTag("character") and target:HasTag("pig")and target:HasTag("manrabbit") and target:HasTag("scarytoprey") and target.components.health:IsDead() then--兔
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 1
	end
	if target:HasTag("epic") and target:HasTag("epic") and target:HasTag("bee")and target:HasTag("insect") and target:HasTag("monster") and target:HasTag("scarytoprey")and target:HasTag("largecreature")and target:HasTag("flying")and target.components.health:IsDead() then--蜂
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 100
	end
	if target:HasTag("walrus") and target.components.health:IsDead() then--海象爸爸
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 2
	end
	if target:HasTag("bishop") and target.components.health:IsDead() then--发条主教
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 2
	end
	if target:HasTag("deer") and target.components.health:IsDead() then--无眼鹿
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 2
	end
	if target:HasTag("rook") and target.components.health:IsDead() then--发条战车
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 2
	end
	if target:HasTag("knight") and target.components.health:IsDead() then--发条骑士
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 2
	end
	if target:HasTag("tallbird") and target.components.health:IsDead() then--高
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 2
	end
	if target:HasTag("beefalo") and target.components.health:IsDead() then--牛
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 2
	end
	if target:HasTag("merm") and target.components.health:IsDead() then--鱼人
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 1
	end
	if target:HasTag("lightninggoat") and target.components.health:IsDead() then--闪电羊
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 2
	end
	if target:HasTag("leif") and target.components.health:IsDead() then--树
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 5
	end
	if target:HasTag("spat") and target.components.health:IsDead() then  --钢
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 10
	end
	if target:HasTag("leif_sparse") and target.components.health:IsDead() then--树
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 5
	end
	if target:HasTag("moose") and target.components.health:IsDead() then--3
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 20
	end
	if target:HasTag("spiderqueen") and target.components.health:IsDead() then--zhu
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 20
	end
	if target:HasTag("bearger") and target.components.health:IsDead() then--3
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 20
	end
	if target:HasTag("warg") and target.components.health:IsDead() then--lang
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 20
	end
	if target:HasTag("toadstool") and target.components.health:IsDead() then
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 100 --毒
	end
	if target:HasTag("deerclops") and target.components.health:IsDead() then--3
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 20
	end
	if target:HasTag("dragonfly") and target.components.health:IsDead() then--龙蝇
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 100
	end
	if target:HasTag("minotaur") and target.components.health:IsDead() then
	inst.components.redcherrystatus.level = inst.components.redcherrystatus.level + 100 --远
	end

		if inst.components.redcherrystatus.level >= TUNING.SX then
			inst.components.redcherrystatus.level = TUNING.SX
		end
		if inst.components.redcherrystatus.level >= 50 and inst.components.redcherrystatus.level < 100 then
	if attacker.components.health then
		    attacker.components.health:DoDelta(1)
	end
	end
	if inst.components.redcherrystatus.level >= 100 and inst.components.redcherrystatus.level < 200 then
	if attacker.components.health then
		    attacker.components.health:DoDelta(2)
	end
	end
	if inst.components.redcherrystatus.level >= 200 and inst.components.redcherrystatus.level < 300 then
	if attacker.components.health then
		    attacker.components.health:DoDelta(3)
	end
	end
	if inst.components.redcherrystatus.level >= 300 and inst.components.redcherrystatus.level < 400 then
	if attacker.components.health then
		    attacker.components.health:DoDelta(4)
	end
	end
	if inst.components.redcherrystatus.level >= 400 and inst.components.redcherrystatus.level < 500 then
	if attacker.components.health then
		    attacker.components.health:DoDelta(5)
	end
	end
	if inst.components.redcherrystatus.level >= 500 and inst.components.redcherrystatus.level < 600 then
	if attacker.components.health then
		    attacker.components.health:DoDelta(6)
	end
	end
	if inst.components.redcherrystatus.level >= 600 and inst.components.redcherrystatus.level < 700 then
	if attacker.components.health then
		    attacker.components.health:DoDelta(7)
	end
	end
	if inst.components.redcherrystatus.level >= 700 and inst.components.redcherrystatus.level < 800 then
	if attacker.components.health then
		    attacker.components.health:DoDelta(8)
	end
	end
	if inst.components.redcherrystatus.level >= 800 and inst.components.redcherrystatus.level < 900 then
	if attacker.components.health then
		    attacker.components.health:DoDelta(9)
	end
	end
	if inst.components.redcherrystatus.level >= 900 then
	if attacker.components.health then
		    attacker.components.health:DoDelta(10)
	end
	end

	inst:DoTaskInTime(0.02, function() inst.components.weapon:SetDamage(math.ceil(10 + inst.components.redcherrystatus.level)) end)

	toolpower(inst)
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
	inst.entity:AddNetwork() 
	
	if TUNING.BB then
	   if TUNING.BX then
	       inst:AddTag("fridge")
	   end
	end
	
	if TUNING.BB then
	   inst.foleysound = "dontstarve/movement/foley/krampuspack"
	end
	
    if not TheWorld.ismastersim then
	if TUNING.BB then
	inst.OnEntityReplicated = function(inst) inst.replica.container:WidgetSetup("krampus_sack") end
	end
        return inst
    end

    inst:AddComponent("redcherrystatus")
    animground(inst)
    
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/yd.xml"
	
	inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )

    inst:AddComponent("tool")
	toolpower(inst)
	
	inst:AddComponent("inspectable")
	
	if TUNING.BB then
	  inst:AddComponent("container")
      inst.components.container:WidgetSetup("krampus_sack")
    end

	
	inst:AddComponent("weapon")
	inst:DoTaskInTime(0.02, function() inst.components.weapon:SetDamage(math.ceil(10 + inst.components.redcherrystatus.level)) end)
	inst.components.weapon:SetOnAttack(onattack)

    return inst
end


return Prefab("common/inventory/yd", fn, assets, prefabs) 
