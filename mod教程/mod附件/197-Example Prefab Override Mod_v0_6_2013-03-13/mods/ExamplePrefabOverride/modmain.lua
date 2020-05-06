-- Example Prefab Override Mod
-- by WrathOf
-- v0.6
-- Updated for Revision 74452 2013-03-12_14-18-42 (A Little Rain Must Fall)
-------------------------------------------------------------------------------
-- Support thread here: 
--
--
-- This mod provides a basic example of overriding the game's existing prefab
-- files, either as a way of doing modding more easily or for cases where it is
-- difficult to change a prefab's functionality in a PrefabPostInit callback
-- function from a mod's modmain file.
--
-- In this example, we are overriding the rabbit.lua prefab in order to change
-- the loot dropped when it is a rabbit and a beardling.
--
--
-- To install this mod, put this file in a folder under
-- "...\Steam\steamapps\common\dont_starve\mods" called "ExamplePrefabOverride",
-- then open the "modsettings.lua" file in the mods folder and add the
-- following but without the beginning "--":
--
--ModManager:AddMod("ExamplePrefabOverride")
--
-- When you run the game you should see a screen pop up that lists this mod as
-- being loaded.
--
-------------------------------------------------------------------------------

-- NOTE: You no longer need to bother making and loading a prefab.xml file

--This type of mod does not require anything here in order to run but we will
--go ahead and add a print statement so it will showup in the log as being
--loaded.  The log.txt file can ba found in the game's bin folder.

print("Example Prefab Override loaded.")
