-- Example New Structure Mod
-- by WrathOf
-- v0.7
-- Updated for Revision 74452 2013-03-12_14-18-42 (A Little Rain Must Fall)
-------------------------------------------------------------------------------
-- Support thread here: 
--
--
-- This example mod provides a basic framework for adding a new structure type
-- item (prefab) to the game.  For now, this is really only a proof of concept
-- as we do not know how to create or edit the animation files used for the
-- graphics and even successfully creating new image files can be difficult.
--
--
-- Note: Currently requires an override of the recipe.lua file to overcome a
--       hardcoded path issue in the game's version
--
--
-- To install this mod, put this file in a folder under
-- "...\Steam\steamapps\common\dont_starve\mods" called "ExampleNewStructure",
-- then open the "modsettings.lua" file in the mods folder and add the
-- following but without the beginning "--":
--
--ModManager:AddMod("ExampleNewStructure")
--
-- When you run the game you should see a screen pop up that lists this mod as
-- being loaded.
--
-------------------------------------------------------------------------------
print("Loading Example New Structure mod...")


--Tell simulator what asset files we are using so it can allocate and manage the resources required
--NOTE: Currently this must be done in during mod load time and the file paths in the xml are hardcoded
GLOBAL.TheSim:LoadPrefabDefs( MODROOT.."prefabs.xml" )

--Define mod's global data
--[[This is just an example, the variable names can be anything but grouping them in a table is recommended
MOD_DATA = {
	VALUE1_STR = "some value",
	VALUE2_BOOL = true,
	VALUE3_NUM = 42,
}
--]]

--Create local versions of global items used for convenience
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS

--Create game global versions of mod's global items for use by custom prefabs and components
--Note: Use a unique name for this until Klei documents a data structure they want us to use
--GLOBAL.MYMODDATA = MOD_DATA


--Define basic string settings for new prefab
STRINGS.NAMES.LEIFSTATUE = "Leif Statue"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LEIFSTATUE = {}
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LEIFSTATUE.GENERIC = "That's not a mighty Leif Statue!? Maxwell!!!!"

-- Function and add a recipe to the crafting menu under the science tab
local function ModGamePostInit()

	--Define a variable to store the path to our images (for convenience)
	local imgpath = MODROOT.."inventoryimages\\"

	--Create a new recipe for our new prefab so user can build it (remember that hammer component will automatically drop a portion of these items)
	--Recipe's parameters are now: name, ingredients, tab, level, placer, min_spacing, filepath
	Recipe( "leifstatue", { Ingredient("log", 5), Ingredient("twigs", 2) }, RECIPETABS.SCIENCE, 0, "leifstatue_placer", nil, imgpath )

end


--Tell mod loader to run our function when game has loaded to the main screen
--but before handing control over to the player
AddGamePostInit(ModGamePostInit)

print("done!")
