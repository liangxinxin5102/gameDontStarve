--Modified by WrathOf to workaround hard coded path issue in game version
--Adds a "filpath" parameter to the Recipe class to allow overriding default image file location
--Updated for Revision 74452 2013-03-12_14-18-42 (A Little Rain Must Fall)
print("Loading recipe override")

require "class"

Ingredient = Class(function(self, type, amount)
    self.type = type
    self.amount = amount
end)

local num = 0
Recipes = {}

Recipe = Class(function(self, name, ingredients, tab, level, placer, min_spacing, filepath)
    self.name = name
    self.descname = STRINGS.NAMES[string.upper(name)]
    self.description = STRINGS.RECIPE_DESC[string.upper(name)]
    self.ingredients = ingredients
    self.product = name
    self.tab = tab

-- MOD --
--Add support for alternate image file path
if filepath then
	self.image = string.gsub(filepath..name..".tex", "\\", "/")
else
    self.image = "data/inventoryimages/"..name..".tex"
end
-- /MOD --]]

	self.sortkey = num
	self.level = level or 0
	self.placer = placer
	self.min_spacing = min_spacing or 3.2

	if TheSim then
		TheSim:LoadPrefabs{name}
		if placer then
			TheSim:LoadPrefabs{placer}
		end
	end

	num = num + 1    
    Recipes[name] = self
    
end)



function GetAllRecipes()
	return Recipes
end

function GetRecipe(name)
    return Recipes[name]
end
