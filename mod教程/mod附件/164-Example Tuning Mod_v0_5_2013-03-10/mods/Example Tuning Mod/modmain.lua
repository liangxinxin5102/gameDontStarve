-- Example Tuning Mod
-- by WrathOf
-- v0.5
-------------------------------------------------------------------------------
-- Support thread here: 
--
-- This is the simplest mod as you are just changing the game's internal tuning
-- settings. Refer to the tuning.lua file in the game's scripts folder to see
-- what you can adjust and then set them to new values here.
--
-- To install this mod, put this file in a folder under
-- "...\Steam\steamapps\common\dont_starve\mods" called "Example Tuning Mod",
-- then open the "modsettings.lua" file in the mods folder and add the
-- following but without the beginning "--":
--
--ModManager:AddMod("Example Tuning Mod")
--
-- When you run the game you should see a screen pop up that lists this mod as
-- being loaded.
--
-------------------------------------------------------------------------------


--example tuning value overrides
--remove the beginning "--" to activate a setting
-------------------------------------------------------------------------------
TUNING.HAYWALL_HEALTH = 200		--Default: 100
TUNING.WOODWALL_HEALTH = 300	--Default: 200
TUNING.STONEWALL_HEALTH = 500	--Default: 400

