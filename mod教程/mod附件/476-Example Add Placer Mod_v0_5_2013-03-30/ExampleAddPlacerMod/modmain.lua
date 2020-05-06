-- Example Add Placer Mod
-- by WrathOf
-- v0.5
-------------------------------------------------------------------------------
-- Support thread here: 
-- http://forums.kleientertainment.com/showthread.php?12200
--
-- This example mod shows how to add a placer to the marble pillar so it can be
-- built in a fashion similar to other structures from the crafting menu.
--
--
-- Note: Requires the ModLib mod to be installed and loaded *prior* to loading
--       this mod in order to work.
--
--
-- To install this mod, put this file in a folder under
-- "...\Steam\steamapps\common\dont_starve\mods" called "ExampleAddPlacerMod",
-- then open the "modsettings.lua" file in the mods folder and add the
-- following but without the beginning "--":
--
--ModManager:AddMod("ExampleAddPlacerMod")
--
-- When you run the game you should see a screen pop up that lists this mod as
-- being loaded.
--
-------------------------------------------------------------------------------
print("Loading Example Add Placer mod...")


--Create local versions of global items used for convenience
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS

--Add string setting for new recipe
STRINGS.RECIPE_DESC.MARBLE_PILLAR = "Build your very own marble pillar."


local function modGamePostInit()

	--Tell simulator to load custom prefab definition for resource allocation
	GLOBAL.TheSim:LoadPrefabDefs( MODROOT.."prefabs.xml" )

	--Define a variable to store the path to our images (for convenience)
	local imgpath = MODROOT.."inventoryimages\\"

	--Create placer prefab for marble pillar
	local placer = GLOBAL.MakePlacer( "common/marblepillar_placer", "marble_pillar", "marble_pillar", "full" )
	if placer then

		--Register placer prefab
		GLOBAL.ModRegisterPrefabs(placer)

		--Create a new recipe for marble pillar prefab so user can build it (remember that hammer component will automatically drop a portion of these items)
		GLOBAL.Recipe( "marblepillar", { GLOBAL.Ingredient("cutgrass", 1), GLOBAL.Ingredient("twigs", 1) }, GLOBAL.RECIPETABS.TOWN, 0, "marblepillar_placer", nil, imgpath )
    end

end

AddGamePostInit(modGamePostInit)

