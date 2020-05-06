--
-- Example Prefab Override Version
-- Changes the drop loot which is easier with an override since the code is not
-- accessible outside of this file.
-- Updated for Revision 74452 2013-03-12_14-18-42 (A Little Rain Must Fall)
--
print("Loading custom rabbit prefab override")


local assets=
{
	Asset("ANIM", "data/anim/ds_rabbit_basic.zip"),
	Asset("ANIM", "data/anim/rabbit_build.zip"),
	Asset("ANIM", "data/anim/beard_monster.zip"),
	Asset("ANIM", "data/anim/rabbit_winter_build.zip"),
	Asset("SOUND", "data/sound/rabbit.fsb"),
    Asset("IMAGE", "data/inventoryimages/rabbit.tex"),
    Asset("IMAGE", "data/inventoryimages/beard_monster.tex"),
    Asset("IMAGE", "data/inventoryimages/rabbit_winter.tex"),
}

local prefabs =
{
    "smallmeat",
    "cookedsmallmeat",
    "beardhair",
}

local function changeimagename(inst, newname)
	inst.components.inventoryitem.imagename = newname
	inst:PushEvent("imagechange")
end

local function onpickup(inst)
end

local brain = require "brains/rabbitbrain"

local function BecomeRabbit(inst)
	if not inst.israbbit or inst.iswinterrabbit then
		inst.AnimState:SetBuild("rabbit_build")
-- MOD --
	    inst.components.lootdropper:SetLoot({"smallmeat", "smallmeat"})
		inst.components.lootdropper:AddChanceLoot("carrot", 0.7)
-- /MOD --
	    inst.israbbit = true
	    inst.iswinterrabbit = false
		inst.components.sanityaura.aura = 0
		changeimagename(inst, "rabbit")	
	end
end

local function BecomeBeardling(inst)
	if inst.israbbit or inst.iswinterrabbit then
		inst.AnimState:SetBuild("beard_monster")
-- MOD --	    
		inst.components.lootdropper:SetLoot({"spoiled_food", "spoiled_food"})
-- /MOD --
		inst.components.lootdropper:AddRandomLoot("beardhair", .5)	    
		inst.components.lootdropper:AddRandomLoot("monstermeat", 1)	    
		inst.components.lootdropper:AddRandomLoot("nightmarefuel", 1)	  
		inst.components.lootdropper.numrandomloot = 1  
		inst.components.sanityaura.aura = -TUNING.SANITYAURA_MED		
	    inst.israbbit = false
	    inst.iswinterrabbit = false
	    changeimagename(inst, "beard_monster")
	end
end

local function DonWinterFur(inst)
	if not inst.iswinterrabbit or inst.israbbit then
		inst.AnimState:SetBuild("rabbit_winter_build")
		inst.components.lootdropper:SetLoot({"smallmeat"})
		inst.israbbit = false
	    inst.iswinterrabbit = true
		inst.components.sanityaura.aura = 0
		changeimagename(inst, "rabbit_winter")
	end
end

local function CheckTransformState(inst)
	if not inst.components.health:IsDead() then
		local player = GetPlayer()
		if player.components.sanity:GetPercent() > TUNING.BEARDLING_SANITY then
			if GetWorld().components.seasonmanager:IsSummer() then
				BecomeRabbit(inst)
			else
				DonWinterFur(inst)
			end
		else
			BecomeBeardling(inst)			
		end
	end
end

local function ondrop(inst)
	inst.sg:GoToState("stunned")
	CheckTransformState(inst)
end


local function OnWake(inst)
	CheckTransformState(inst)
	inst.checktask = inst:DoPeriodicTask(10, CheckTransformState)
end

local function OnSleep(inst)
	 if inst.checktask then
	 	inst.checktask:Cancel()
	 	inst.checktask = nil
	 end
end

local function GetCookProductFn(inst)
	if inst.israbbit or inst.iswinterrabbit then
		return "cookedsmallmeat" 
	else 
		return "cookedmonstermeat"
	end
end

local function OnCookedFn(inst)
	inst.SoundEmitter:PlaySound("dontstarve/rabbit/scream_short")

end


local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .75 )
    inst.Transform:SetFourFaced()

    MakeCharacterPhysics(inst, 1, 0.5)

    anim:SetBank("rabbit")
    anim:SetBuild("rabbit_build")
    anim:PlayAnimation("idle")
    
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = TUNING.RABBIT_RUN_SPEED
    inst:SetStateGraph("SGrabbit.lua")

    inst:AddTag("animal")
    inst:AddTag("prey")
    inst:AddTag("rabbit")
    inst:AddTag("smallcreature")
    inst:AddTag("canbetrapped")    

    inst:SetBrain(brain)
    
    inst.data = {}
    
    inst:AddComponent("eater")
    inst.components.eater:SetVegetarian()

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.nobounce = true
	inst.components.inventoryitem.canbepickedup = false
	inst.components.inventoryitem:SetOnPickupFn(onpickup)
	inst.components.inventoryitem:SetOnDroppedFn(ondrop)
	inst:AddComponent("sanityaura")
    

    inst:AddComponent("cookable")
    inst.components.cookable.product = GetCookProductFn
    inst.components.cookable:SetOnCookedFn(OnCookedFn)

    
    inst:AddComponent("knownlocations")
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "chest"
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.RABBIT_HEALTH)
    inst.components.health.murdersound = "dontstarve/rabbit/scream_short"
    
    MakeSmallBurnableCharacter(inst, "chest")
    MakeTinyFreezableCharacter(inst, "chest")

    inst:AddComponent("lootdropper")
    
    inst:AddComponent("inspectable")
    inst:AddComponent("sleeper")

	BecomeRabbit(inst)
    CheckTransformState(inst)
	
	inst.OnEntityWake = OnWake
	inst.OnEntitySleep = OnSleep    
    
    inst.OnSave = function(inst, data)
        data.israbbit = inst.israbbit
        data.iswinterrabbit = inst.iswinterrabbit
    end        
    
    inst.OnLoad = function(inst, data)
        if data then
		        if data.israbbit == false and data.iswinterrabbit == false then
					BecomeBeardling(inst)
				else if data.israbbit == false and data.iswinterrabbit == true then
					DonWinterFur(inst)					
		        end
		    end
	    end 
    end
        
    return inst
end

return Prefab( "forest/animals/rabbit", fn, assets, prefabs)
