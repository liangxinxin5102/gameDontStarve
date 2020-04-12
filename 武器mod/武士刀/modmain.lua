local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH

TUNING.SL = GetModConfigData("sl")
TUNING.SX = GetModConfigData("sx")
TUNING.XXS = GetModConfigData("xxs")
TUNING.BB = GetModConfigData("bb")
TUNING.BX = GetModConfigData("bx")

PrefabFiles = {
	"yd",
    }

Assets = {
	Asset("ATLAS", "images/inventoryimages/yd.xml"),
}

STRINGS.NAMES.YD = "武士刀"
STRINGS.RECIPE_DESC.YD = "一把锋利的刀"
STRINGS.CHARACTERS.GENERIC.YD = "感觉很帅"

AddRecipe("yd", {Ingredient("moonrocknugget", 1), Ingredient("goldnugget", TUNING.SL)},
 RECIPETABS.WAR,  GLOBAL.TECH.NONE, nil, nil, nil, nil, nil,
"images/inventoryimages/yd.xml", "yd.tex")

if GetModConfigData("Chop") == true then
    TUNING.redcherrychop = 1
end
if GetModConfigData("Mine") == true then
    TUNING.redcherrymine = 1
end
if GetModConfigData("Dig") == true then
    TUNING.redcherrydig = 1
end
if GetModConfigData("Hammer") == true then
    TUNING.redcherryhammer = 1
end

