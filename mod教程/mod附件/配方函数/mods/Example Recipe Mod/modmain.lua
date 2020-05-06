-- Example Recipe Mod
-- by WrathOf
-- v0.7
-- Updated for Revision 74452 2013-03-12_14-18-42 (A Little Rain Must Fall)
-------------------------------------------------------------------------------
-- Support thread here: 
--
-- This is a basic mod that allows you to change the items required to make a
-- craftable in the game such as tool and weapons.
-- 
-- Refer to the recipes.lua file in the game's scripts folder to see what the
-- existing recipes are and what the internal names for the ingredients are.
--
--
-- Note: Currently requires an override of the crafting.lua file to overcome a
--       coding bug in the game's version.  Make sure it is included with your
--       mods that change or make new crafting recipes.
--
--
-- To install this mod, put this file in a folder under
-- "...\Steam\steamapps\common\dont_starve\mods" called "Example Recipe Mod",
-- then open the "modsettings.lua" file in the mods folder and add the
-- following but without the beginning "--":
--
--ModManager:AddMod("Example Recipe Mod")
--
-- When you run the game you should see a screen pop up that lists this mod as
-- being loaded.
--
-------------------------------------------------------------------------------

print("Example Recipe Mod loaded.")

--Callback function to change the recipe for pan flutes at GamePostInit.
--The name can be almost anything, just don't start with 0-9 and use the exact
--same name in the AddGamePostInit line below.
local function modGamePostInit()

	--Search for the recipe you want to change
	local recipe = GLOBAL.GetRecipe("panflute")
	--If find it then change it
	if recipe then
		--Set the ingredients for a recipe to a new list
		recipe.ingredients = {
			--Each ingredient is the internal name for it & the amount needed
			GLOBAL.Ingredient("cutreeds", 10),
			GLOBAL.Ingredient("rope", 1),
		}
		--No need to update the crafting menu since this change is done before the game builds the menu
	end
	
end

--Add a post init callback to the game when this mod is loaded.
--This will tell the game to run the function above after loading the game's
--main screen but before handing control over to the player.
AddGamePostInit(modGamePostInit)

--Callback function to change the recipe for pan flutes at SimPostInit.
--Use this version if need to access hud to force an update to the crafting menu.
local function modSimPostInit( maincharacter )

	--Search for the recipe you want to change
	local recipe = GLOBAL.GetRecipe("panflute")
	--If find it then change it
	if recipe then
		--Set the ingredients for a recipe to a new list
		recipe.ingredients = {
			--Each ingredient is the internal name for it & the amount needed
			GLOBAL.Ingredient("cutreeds", 10),
			GLOBAL.Ingredient("rope", 1),
		}

		--Should not be necessary, but wanted to show how to do this just in case
		--Get reference to crafting menu
		local craftmenu = maincharacter.HUD.controls.crafttabs

		--Tell menu to update so recipe changes appear
		if craftmenu then craftmenu:UpdateRecipes() end
	end

end

--Add a post init callback to the game when this mod is loaded.
--This will tell the game to run the function above after loading a saved game
--but before handing control over to the player.
--uncomment to try but comment out AddGamePostInit line above so only one or
--the other method is used.
--AddSimPostInit(modSimPostInit)

