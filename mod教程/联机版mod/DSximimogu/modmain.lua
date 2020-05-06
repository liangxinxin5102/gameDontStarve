PrefabFiles = 
{	
	"allwathgrithr",
	"bluemushroom",
	"greenmushroom",
	"redmushroom",
	
}



Assets = 
{
	Asset( "IMAGE", "images/inventoryimages/allwathgrithr.tex" ),
    Asset( "ATLAS", "images/inventoryimages/allwathgrithr.xml" ),
	Asset("IMAGE", "images/inventoryimages/bluemushroom.tex" ),
	Asset("ATLAS", "images/inventoryimages/bluemushroom.xml"),
	Asset("IMAGE", "images/inventoryimages/greenmushroom.tex" ),
	Asset("ATLAS", "images/inventoryimages/greenmushroom.xml"),
	Asset("IMAGE", "images/inventoryimages/redmushroom.tex" ),
	Asset("ATLAS", "images/inventoryimages/redmushroom.xml"),
	
}



local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH


GLOBAL.STRINGS.NAMES.REDMUSHROOM = "红蘑菇帽"
GLOBAL.STRINGS.RECIPE_DESC.REDMUSHROOM = "红色的蘑菇帽"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.REDMUSHROOM = "居然有防御力"

GLOBAL.STRINGS.NAMES.GREENMUSHROOM = "绿蘑菇帽"
GLOBAL.STRINGS.RECIPE_DESC.GREENMUSHROOM = "绿色的蘑菇帽"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.GREENMUSHROOM = "居然有防御力"

GLOBAL.STRINGS.NAMES.BLUEMUSHROOM = "蓝蘑菇帽"
GLOBAL.STRINGS.RECIPE_DESC.BLUEMUSHROOM = "蓝色的蘑菇帽"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.BLUEMUSHROOM = "居然有防御力"

GLOBAL.STRINGS.NAMES.ALLWATHGRITHR = "女武神头盔"
GLOBAL.STRINGS.RECIPE_DESC.ALLWATHGRITHR = "独角兽就是保护西米的东西"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ALLWATHGRITHR = "萌萌哒"




TUNING.REDMUSHROOM_PF = GetModConfigData("REDMUSHROOM_PF")           		--红蘑菇
TUNING.GREENMUSHROOM_PF = GetModConfigData("GREENMUSHROOM_PF")				--绿蘑菇
TUNING.BLUEMUSHROOM_PF = GetModConfigData("BLUEMUSHROOM_PF")           		--蓝蘑菇
TUNING.ALLWATHGRITHR_PF = GetModConfigData("ALLWATHGRITHR_PF")				--女武神





if TUNING.REDMUSHROOM_PF then
	local redmushroom = AddRecipe("redmushroom", 
	{Ingredient("goldnugget", 2), Ingredient("pigskin", 1), Ingredient("rocks", 2)}, 
	RECIPETABS.WAR, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/redmushroom.xml", "redmushroom.tex")	
	redmushroom.sortkey = 2
end


if TUNING.GREENMUSHROOM_PF then	
	local greenmushroom = AddRecipe("greenmushroom", 
	{Ingredient("goldnugget", 2), Ingredient("pigskin", 1), Ingredient("rocks", 2)}, 
	RECIPETABS.WAR,TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/greenmushroom.xml", "greenmushroom.tex")
	greenmushroom.sortkey = 3
end


if TUNING.BLUEMUSHROOM_PF then
	local bluemushroom = AddRecipe("bluemushroom", 
	{Ingredient("goldnugget", 2), Ingredient("pigskin", 1), Ingredient("rocks", 2)}, 
	RECIPETABS.WAR,TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/bluemushroom.xml", "bluemushroom.tex")
	bluemushroom.sortkey = 4
end


if TUNING.ALLWATHGRITHR_PF then
	local allwathgrithr = AddRecipe("allwathgrithr",
	{Ingredient("goldnugget", 2), Ingredient("rocks", 2)}, 
	RECIPETABS.WAR, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/allwathgrithr.xml", "allwathgrithr.tex")
	allwathgrithr.sortkey = 5
end


