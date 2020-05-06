
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = {}

-- Custom starting items
local start_inv = {
}

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when reviving from ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "nine_speed_mod", 1)
end
	
local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "nine_speed_mod")
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

--Taken from Senshimi's Tenshi

--Taken from Senshimi's Kagerou Mod http://steamcommunity.com/sharedfiles/filedetails/?id=700056809&searchtext=kagerou
local function perkstats(inst)

	if TheWorld.state.phase == "day" then
		if inst.components.hunger.current > (50) and inst.components.hunger.current <= (150) then

			inst.components.sanity.neg_aura_mult = 1.00
			inst.components.sanity.night_drain_mult = 1.00
			
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 1.00 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 1.00 )
		
			inst.components.combat.damagemultiplier = 1.00
			
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.00 )
			
		elseif inst.components.hunger.current == (50) then
			
			inst.components.sanity.neg_aura_mult = 2.00
			inst.components.sanity.night_drain_mult = 2.00
			
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 0.80 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 0.80 )
		
			inst.components.combat.damagemultiplier = 1.00
			
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.00 )
			
		elseif  inst.components.hunger.current >= (0) and inst.components.hunger.current < (50) then
			
			inst.components.sanity.neg_aura_mult = 2.00
			inst.components.sanity.night_drain_mult = 2.00
			
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 0.80 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 0.80 )
		
			inst.components.combat.damagemultiplier = 1.00
			
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.00 )
			
		end

	elseif TheWorld.state.phase == "dusk" then
		if inst.components.hunger.current > (50) and inst.components.hunger.current <= (150) then
	
			inst.components.sanity.neg_aura_mult = 0.75
			inst.components.sanity.night_drain_mult = 0.75
	
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 1.20 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 1.20 )
		
			inst.components.combat.damagemultiplier = 1.00
	
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.00 )
		
		elseif inst.components.hunger.current == (50) then
			
			inst.components.sanity.neg_aura_mult = 2.00
			inst.components.sanity.night_drain_mult = 2.00
			
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 0.80 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 0.80 )
		
			inst.components.combat.damagemultiplier = 1.00
			
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.00 )
			
		elseif  inst.components.hunger.current >= (0) and inst.components.hunger.current < (50) then
			
			inst.components.sanity.neg_aura_mult = 2.00
			inst.components.sanity.night_drain_mult = 2.00
			
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 0.80 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 0.80 )
		
			inst.components.combat.damagemultiplier = 1.00
			
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.00 )
			
		end

		
	elseif TheWorld.state.phase == "night" then
		if inst.components.hunger.current > (50) and inst.components.hunger.current <= (150) then
		
			inst.components.sanity.neg_aura_mult = 0.50
			inst.components.sanity.night_drain_mult = 0.50
	
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 1.60 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 1.60 )
	
			inst.components.combat.damagemultiplier = 1.60
	
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.50 )
			
		elseif inst.components.hunger.current == (50) then
			
			inst.components.sanity.neg_aura_mult = 2.00
			inst.components.sanity.night_drain_mult = 2.00
			
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 0.80 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 0.80 )
		
			inst.components.combat.damagemultiplier = 1.00
			
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.00 )
			
		elseif  inst.components.hunger.current >= (0) and inst.components.hunger.current < (50) then
			
			inst.components.sanity.neg_aura_mult = 2.00
			inst.components.sanity.night_drain_mult = 2.00
			
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 0.80 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 0.80 )
		
			inst.components.combat.damagemultiplier = 1.00
			
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.00 )
			
		end
		
	elseif tempCaveVar == true and TheWorld.state.phase == "caveday" then
		if inst.components.hunger.current > (50) and inst.components.hunger.current <= (150) then
		
			inst.components.sanity.neg_aura_mult = 1.00
			inst.components.sanity.night_drain_mult = 1.00
	
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 1.00 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 1.00 )
	
			inst.components.combat.damagemultiplier = 1.00
	
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.00 )
		
		elseif inst.components.hunger.current == (50) then
			
			inst.components.sanity.neg_aura_mult = 2.00
			inst.components.sanity.night_drain_mult = 2.00
			
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 0.80 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 0.80 )
		
			inst.components.combat.damagemultiplier = 1.00
			
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.00 )
			
		elseif  inst.components.hunger.current >= (0) and inst.components.hunger.current < (50) then
			
			inst.components.sanity.neg_aura_mult = 2.00
			inst.components.sanity.night_drain_mult = 2.00
			
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 0.80 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 0.80 )
		
			inst.components.combat.damagemultiplier = 1.00
			
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.00 )
			
		end
	
	elseif tempCaveVar == true and TheWorld.state.phase == "cavedusk" then
		if inst.components.hunger.current > (50) and inst.components.hunger.current <= (150) then

			inst.components.sanity.neg_aura_mult = 0.75
			inst.components.sanity.night_drain_mult = 0.75
	
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 1.20 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 1.20 )
	
			inst.components.combat.damagemultiplier = 1.00
	
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.00 )
		
		elseif inst.components.hunger.current == (50) then
			
			inst.components.sanity.neg_aura_mult = 2.00
			inst.components.sanity.night_drain_mult = 2.00
			
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 0.80 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 0.80 )
		
			inst.components.combat.damagemultiplier = 1.00
			
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.00 )
			
		elseif  inst.components.hunger.current >= (0) and inst.components.hunger.current < (50) then
			
			inst.components.sanity.neg_aura_mult = 2.00
			inst.components.sanity.night_drain_mult = 2.00
			
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 0.80 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 0.80 )
		
			inst.components.combat.damagemultiplier = 1.00
			
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.00 )
			
		end
	
	elseif tempCaveVar == true and TheWorld.state.phase == "cavenight" then
		if inst.components.hunger.current > (50) and inst.components.hunger.current <= (150) then

			inst.components.sanity.neg_aura_mult = 0.50
			inst.components.sanity.night_drain_mult = 0.50
	
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 1.60 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 1.60 )
	
			inst.components.combat.damagemultiplier = 1.60
	
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.50 )
			
		elseif inst.components.hunger.current == (50) then
			
			inst.components.sanity.neg_aura_mult = 2.00
			inst.components.sanity.night_drain_mult = 2.00
			
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 0.80 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 0.80 )
		
			inst.components.combat.damagemultiplier = 1.00
			
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.00 )
			
		elseif  inst.components.hunger.current >= (0) and inst.components.hunger.current < (50) then
			
			inst.components.sanity.neg_aura_mult = 2.00
			inst.components.sanity.night_drain_mult = 2.00
			
			inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 0.80 )
			inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 0.80 )
		
			inst.components.combat.damagemultiplier = 1.00
			
			inst.components.hunger.hungerrate = ( TUNING.WILSON_HUNGER_RATE * 1.00 )
			
		end
	end
end

-- Taken from Raythalosm's Shigure
local function attackreset(inst) --Modified from Buster
    if(inst.attacktimer~=nil)
    then
        inst.attacktimer:Cancel()
        inst.attacktimer = nil
    end
	if inst:HasTag("debugnoattack") then 
		inst:RemoveTag("debugnoattack")
	end
    inst.attacktimer = inst:DoPeriodicTask(10,
        function()
			if TheWorld.state.isday == false or TheWorld.state.iscaveday == false then
				if TheWorld.state.iscaveday == false then
					inst:AddTag("debugnoattack")
				end
			end
			inst.attacktimer:Cancel()
			inst.attacktimer = nil
        end
    )
end
local function onattackreset(inst, data)
    attackreset(inst)
end

local function ondeath(inst)
    inst.components.talker:Say((GetString(inst, "ANNOUNCE_DEATH")))
end

local function onload(inst)
	if TheWorld.state.isday == true then
		inst:RemoveTag("debugnoattack")
	else
		if TheWorld.state.iscaveday == true then
			inst:RemoveTag("debugnoattack")
		else
			inst:AddTag("debugnoattack")
		end
	end
end

local function OnIsDay(inst)
	inst:RemoveTag("debugnoattack")
end

local function OnIsDusk(inst)
	inst:AddTag("debugnoattack")
end

local function RemoveInvul(inst)
	inst.invul = 0
	inst.components.health:SetAbsorptionAmount(0)
end
-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "nine.tex" )
	inst:AddComponent("sanityaura")
	inst.components.sanityaura.aura = TUNING.SANITYAURA_LARGE
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "willow"	
	
	inst.invul = 0
	
	-- Stats	
	inst.components.health:SetMaxHealth(200)
	inst.components.hunger:SetMax(150)
	inst.components.sanity:SetMax(100)
	
	inst.components.sanity.neg_aura_mult = 1.00
	inst.components.sanity.night_drain_mult = 1.00
	
	inst.components.locomotor.walkspeed = ( TUNING.WILSON_WALK_SPEED * 1.00 )
	inst.components.locomotor.runspeed = ( TUNING.WILSON_RUN_SPEED * 1.00 )
	
	
	-- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = 1
	
	-- Special thanks for Sparrows for the help coding all the perks
	
	if TUNING.NINE.PRIORITY_REDIRECTION == true then
		inst:WatchWorldState("isday", OnIsDay)
		inst:WatchWorldState("isdusk", OnIsDusk)
		inst:WatchWorldState("iscaveday", OnIsDay)
		inst:WatchWorldState("iscavedusk", OnIsDusk)
		inst.OnLoad = onload
		inst.OnNewSpawn = onload
		inst:ListenForEvent("onattackother", onattackreset)
	end
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	
	inst:ListenForEvent("death", ondeath)
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
	inst:ListenForEvent("hungerdelta", function(inst) perkstats(inst) end )
	
	inst:WatchWorldState( "startday", function(inst) perkstats(inst) end )
	inst:WatchWorldState( "startdusk", function(inst) perkstats(inst) end )
	inst:WatchWorldState( "startnight", function(inst) perkstats(inst) end )
	inst:WatchWorldState( "startcaveday", function(inst) perkstats(inst) end )
	inst:WatchWorldState( "startcavedusk", function(inst) perkstats(inst) end )
	inst:WatchWorldState( "startcavenight", function(inst) perkstats(inst) end )
	perkstats(inst)
	return inst
end

return MakePlayerCharacter("nine", prefabs, assets, common_postinit, master_postinit, start_inv)
