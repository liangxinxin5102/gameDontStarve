local _G = GLOBAL
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local ACTIONS = GLOBAL.ACTIONS
local ActionHandler = GLOBAL.ActionHandler
local TUNING = _G.TUNING
local CUSTOM_RECIPETABS = _G.CUSTOM_RECIPETABS

_G.CAVES_CONFIG = GetModConfigData('CAVES')
_G.MULT_CONFIG = GetModConfigData('MULT')
_G.REFUND_CONFIG = GetModConfigData('REFUND')
_G.SYSTEM_CONFIG = GetModConfigData('SYSTEM')
_G.HIDEPERK_CONFIG = GetModConfigData('HIDEPERK')
_G.STARTGEAR_CONFIG = GetModConfigData('GEAR')
_G.COSTRAISE_CONFIG = GetModConfigData('COSTRAISE')
_G.PLAYS_CONFIG = GetModConfigData('PLAYS')
_G.HEALTHPENALTY = GetModConfigData('HEALTHPENALTY')
_G.GAMEBREAKER = GetModConfigData('GAMEBREAKER')
_G.EXPMULT = GetModConfigData('EXPMULT')
_G.LEVELXP = GetModConfigData('LEVELXP')
_G.LEVELPOINTS = GetModConfigData('LEVELPOINTS')


require 'AllAchiv/allachivbalance'
require "AllAchiv/allachivrpc"
_G.LANGUAGE = GetModConfigData('LANGUAGE')
if _G.LANGUAGE == "kr" then
	require 'AllAchiv/strings_acm_kr'
elseif _G.LANGUAGE == "ptbr" then
	require 'AllAchiv/strings_acm_ptbr'
elseif _G.LANGUAGE == "es" then
	require 'AllAchiv/strings_acm_es'
elseif _G.LANGUAGE == "it" then
	require 'AllAchiv/strings_acm_it'
elseif _G.LANGUAGE == "chs" then
	require 'AllAchiv/strings_acm_chs'
elseif _G.LANGUAGE == "cht" then
	require 'AllAchiv/strings_acm_cht'
elseif _G.LANGUAGE == "ru" then
	require 'AllAchiv/strings_acm_ru'
elseif _G.LANGUAGE == "de" then
	require 'AllAchiv/strings_acm_de'
elseif _G.LANGUAGE == "vi" then
	require 'AllAchiv/strings_acm_vi'
else
	require 'AllAchiv/strings_acm_e'
end



local MANRESPAWN = GetModConfigData('MANDRAKEBOI')
if MANRESPAWN then
    if GLOBAL.STRINGS.NAMES.MIGRATION_PORTAL then
        AddPrefabPostInit("forest", function(inst)
            if inst.ismastersim then
                inst:AddComponent("minspawner")
            end
        end)
    else
        AddPrefabPostInit("world", function(inst)
            if inst.ismastersim then
                inst:AddComponent("minspawner")
            end
        end)
    end
end

PrefabFiles = {
    "seffc",
    "klaussack_placer",
	"altar_placer",
    "achivbooks",
    "pigking",
    "antlion",
    "shadowwaxwell",
    "perkportableblender",
    "perkportablecookpot",
    "perkportablespicer",
}

_G.SECONDRUN = GetModConfigData('SECOND')										 

Assets = {
    Asset("ATLAS", "images/inventoryimages/klaussack.xml"),
    Asset("IMAGE", "images/inventoryimages/klaussack.tex"),
    Asset("ATLAS", "images/inventoryimages/achivbook_birds.xml"),
    Asset("IMAGE", "images/inventoryimages/achivbook_birds.tex"),
    Asset("ATLAS", "images/inventoryimages/achivbook_brimstone.xml"),
    Asset("IMAGE", "images/inventoryimages/achivbook_brimstone.tex"),
    Asset("ATLAS", "images/inventoryimages/achivbook_gardening.xml"),
    Asset("IMAGE", "images/inventoryimages/achivbook_gardening.tex"),
    Asset("ATLAS", "images/inventoryimages/achivbook_sleep.xml"),
    Asset("IMAGE", "images/inventoryimages/achivbook_sleep.tex"),
    Asset("ATLAS", "images/inventoryimages/achivbook_tentacles.xml"),
    Asset("IMAGE", "images/inventoryimages/achivbook_tentacles.tex"),
    Asset("ATLAS", "images/inventoryimages/perkportablespicer.xml"),
    Asset("IMAGE", "images/inventoryimages/perkportablespicer.tex"),
    Asset("ATLAS", "images/inventoryimages/perkportableblender.xml"),
    Asset("IMAGE", "images/inventoryimages/perkportableblender.tex"),
    Asset("ATLAS", "images/inventoryimages/perkportablecookpot.xml"),
    Asset("IMAGE", "images/inventoryimages/perkportablecookpot.tex"),
	Asset("ATLAS", "images/inventoryimages/altar.xml"),
    Asset("IMAGE", "images/inventoryimages/altar.tex"),
	
	Asset("ATLAS", "images/hud/background_lmod.xml"),
    Asset("IMAGE", "images/hud/background_lmod.tex"),
	Asset("ATLAS", "images/hud/background_info.xml"),
    Asset("IMAGE", "images/hud/background_info.tex"),
	Asset("ATLAS", "images/hud/star.xml"),
    Asset("IMAGE", "images/hud/star.tex"),
	Asset("ATLAS", "images/hud/reset_info.xml"),
    Asset("IMAGE", "images/hud/reset_info.tex"),
	Asset("ATLAS", "images/hud/xpbar_empty.xml"),
    Asset("IMAGE", "images/hud/xpbar_empty.tex"),
	Asset("ATLAS", "images/hud/levelbadge.xml"),
    Asset("IMAGE", "images/hud/levelbadge.tex"),
	Asset("ATLAS", "images/hud/xpbar_filled.xml"),
    Asset("IMAGE", "images/hud/xpbar_filled.tex"),

	Asset("ATLAS", "images/button/perk.xml"),
    Asset("IMAGE", "images/button/perk.tex"),
	Asset("ATLAS", "images/button/perk_active.xml"),
    Asset("IMAGE", "images/button/perk_active.tex"),
	Asset("ATLAS", "images/button/button_bg.xml"),
    Asset("IMAGE", "images/button/button_bg.tex"),
	Asset("ATLAS", "images/button/button_bg_inactive.xml"),
    Asset("IMAGE", "images/button/button_bg_inactive.tex"),
	Asset("ATLAS", "images/button/achievement.xml"),
    Asset("IMAGE", "images/button/achievement.tex"),
	Asset("ATLAS", "images/button/achievement_active.xml"),
    Asset("IMAGE", "images/button/achievement_active.tex"),
    Asset("ATLAS", "images/button/checkbutton.xml"),
    Asset("IMAGE", "images/button/checkbutton.tex"),
    Asset("ATLAS", "images/button/coinbutton.xml"),
    Asset("IMAGE", "images/button/coinbutton.tex"),
    Asset("ATLAS", "images/button/config_act.xml"),
    Asset("IMAGE", "images/button/config_act.tex"),
    Asset("ATLAS", "images/button/config_bg.xml"),
    Asset("IMAGE", "images/button/config_bg.tex"),
    Asset("ATLAS", "images/button/config_bigger.xml"),
    Asset("IMAGE", "images/button/config_bigger.tex"),
    Asset("ATLAS", "images/button/config_smaller.xml"),
    Asset("IMAGE", "images/button/config_smaller.tex"),
	Asset("ATLAS", "images/button/config_language.xml"),
    Asset("IMAGE", "images/button/config_language.tex"),
	Asset("ATLAS", "images/button/levelplus.xml"),
    Asset("IMAGE", "images/button/levelplus.tex"),
	Asset("ATLAS", "images/button/mainbutton_bg.xml"),
    Asset("IMAGE", "images/button/mainbutton_bg.tex"),
	Asset("ATLAS", "images/button/mainbutton_bg_achieve.xml"),
    Asset("IMAGE", "images/button/mainbutton_bg_achieve.tex"),
    
-----Tab
    Asset( "ATLAS", "images/inventoryimages/perk_tab.xml" ),

	Asset("ANIM", "anim/altar.zip"),	
}
AddMinimapAtlas("images/inventoryimages/altar.xml")

STRINGS.NAMES.PERK_TAB = "REWARD"
STRINGS.TABS.PERK_TAB = "Rewards"
GLOBAL.RECIPETABS['PERK_TAB'] = {str = "PERK_TAB", sort=25, icon = "perk_tab.tex", icon_atlas = "images/inventoryimages/perk_tab.xml"}

AddRecipe("achivbook_birds", {Ingredient("papyrus", 2),Ingredient("bird_egg", 2)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "achivbookbuilder", 
"images/inventoryimages.xml", "book_birds.tex" )

AddRecipe("achivbook_gardening", {Ingredient("papyrus", 2), Ingredient("seeds", 1), Ingredient("poop", 1)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "achivbookbuilder", 
"images/inventoryimages.xml", "book_gardening.tex" )

AddRecipe("achivbook_sleep", {Ingredient("papyrus", 2), Ingredient("nightmarefuel", 2)}, 
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "achivbookbuilder", 
"images/inventoryimages.xml", "book_sleep.tex" )

AddRecipe("achivbook_brimstone", {Ingredient("papyrus", 2), Ingredient("redgem", 1)}, 
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "achivbookbuilder", 
"images/inventoryimages.xml", "book_brimstone.tex" )

AddRecipe("achivbook_tentacles", {Ingredient("papyrus", 2), Ingredient("tentaclespots", 1)}, 
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "achivbookbuilder", 
"images/inventoryimages.xml", "book_tentacles.tex" )

--Winonas Engineering Items
local tape = AddRecipe("sewing_tape_perk", {Ingredient("cutgrass", 6), Ingredient("silk", 2)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "engineering")
tape.image = "sewing_tape.tex"
tape.product = "sewing_tape"
GLOBAL.STRINGS.RECIPE_DESC.SEWING_TAPE_PERK = GLOBAL.STRINGS.RECIPE_DESC.SEWING_TAPE
GLOBAL.STRINGS.NAMES.SEWING_TAPE_PERK = GLOBAL.STRINGS.NAMES.SEWING_TAPE

local catapult = AddRecipe("winona_catapult_perk", {Ingredient("sewing_tape", 1), Ingredient("twigs", 8), Ingredient("rocks", 20)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, "winona_catapult_placer", TUNING.WINONA_ENGINEERING_SPACING, nil, nil, "engineering")
catapult.image = "winona_catapult.tex"
catapult.product = "winona_catapult"
GLOBAL.STRINGS.RECIPE_DESC.WINONA_CATAPULT_PERK = GLOBAL.STRINGS.RECIPE_DESC.WINONA_CATAPULT
GLOBAL.STRINGS.NAMES.WINONA_CATAPULT_PERK = GLOBAL.STRINGS.NAMES.WINONA_CATAPULT

local spotlight = AddRecipe("winona_spotlight_perk", {Ingredient("sewing_tape", 1), Ingredient("goldnugget", 4), Ingredient("fireflies", 1)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, "winona_spotlight_placer", TUNING.WINONA_ENGINEERING_SPACING, nil, nil, "engineering")
spotlight.image = "winona_spotlight.tex"
spotlight.product = "winona_spotlight"
GLOBAL.STRINGS.RECIPE_DESC.WINONA_SPOTLIGHT_PERK = GLOBAL.STRINGS.RECIPE_DESC.WINONA_SPOTLIGHT
GLOBAL.STRINGS.NAMES.WINONA_SPOTLIGHT_PERK = GLOBAL.STRINGS.NAMES.WINONA_SPOTLIGHT

local generator = AddRecipe("winona_battery_low_perk", {Ingredient("sewing_tape", 1), Ingredient("log", 4), Ingredient("nitre", 4)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, "winona_battery_low_placer", TUNING.WINONA_ENGINEERING_SPACING, nil, nil, "engineering")
generator.image = "winona_battery_low.tex"
generator.product = "winona_battery_low"
GLOBAL.STRINGS.RECIPE_DESC.WINONA_BATTERY_LOW_PERK = GLOBAL.STRINGS.RECIPE_DESC.WINONA_BATTERY_LOW
GLOBAL.STRINGS.NAMES.WINONA_BATTERY_LOW_PERK = GLOBAL.STRINGS.NAMES.WINONA_BATTERY_LOW

local gemerator = AddRecipe("winona_battery_high_perk", {Ingredient("sewing_tape", 1), Ingredient("boards", 4), Ingredient("transistor", 2)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, "winona_battery_high_placer", TUNING.WINONA_ENGINEERING_SPACING, nil, nil, "engineering")
gemerator.image = "winona_battery_high.tex"
gemerator.product = "winona_battery_high"
GLOBAL.STRINGS.RECIPE_DESC.WINONA_BATTERY_HIGH_PERK = GLOBAL.STRINGS.RECIPE_DESC.WINONA_BATTERY_HIGH
GLOBAL.STRINGS.NAMES.WINONA_BATTERY_HIGH_PERK = GLOBAL.STRINGS.NAMES.WINONA_BATTERY_HIGH

--Shrines
local perk_festive_gobbler = AddRecipe("perdshrine_perk", {Ingredient("goldnugget", 8), Ingredient("boards", 2), Ingredient("berries", 3)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, "perdshrine_placer", nil, nil, nil, "shrine")
perk_festive_gobbler.image = "perdshrine.tex"
perk_festive_gobbler.product = "perdshrine"
GLOBAL.STRINGS.RECIPE_DESC.PERDSHRINE_PERK = GLOBAL.STRINGS.RECIPE_DESC.PERDSHRINE
GLOBAL.STRINGS.NAMES.PERDSHRINE_PERK = GLOBAL.STRINGS.NAMES.PERDSHRINE

local perk_festive_varg = AddRecipe("wargshrine_perk", {Ingredient("goldnugget", 8), Ingredient("boards", 2), Ingredient("monstermeat", 4)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, "wargshrine_placer", nil, nil, nil, "shrine")
perk_festive_varg.image = "wargshrine.tex"
perk_festive_varg.product = "wargshrine"
GLOBAL.STRINGS.RECIPE_DESC.WARGSHRINE_PERK = GLOBAL.STRINGS.RECIPE_DESC.WARGSHRINE
GLOBAL.STRINGS.NAMES.WARGSHRINE_PERK = GLOBAL.STRINGS.NAMES.WARGSHRINE

local perk_festive_pig = AddRecipe("pigshrine_perk", {Ingredient("goldnugget", 8), Ingredient("boards", 2), Ingredient("pigskin", 2)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, "pigshrine_placer", nil, nil, nil, "shrine")
perk_festive_pig.image = "pigshrine.tex"
perk_festive_pig.product = "pigshrine"
GLOBAL.STRINGS.RECIPE_DESC.PIGSHRINE_PERK = GLOBAL.STRINGS.RECIPE_DESC.PIGSHRINE
GLOBAL.STRINGS.NAMES.PIGSHRINE_PERK = GLOBAL.STRINGS.NAMES.PIGSHRINE

local perk_festive_lab = AddRecipe("madscience_lab_perk", {Ingredient("transistor", 2), Ingredient("cutstone", 2), Ingredient("phlegm", 1)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, "madscience_lab_placer", nil, nil, nil, "shrine")
perk_festive_lab.image = "madscience_lab.tex"
perk_festive_lab.product = "madscience_lab"
GLOBAL.STRINGS.RECIPE_DESC.MADSCIENCE_LAB_PERK = GLOBAL.STRINGS.RECIPE_DESC.MADSCIENCE_LAB
GLOBAL.STRINGS.NAMES.MADSCIENCE_LAB_PERK = GLOBAL.STRINGS.NAMES.MADSCIENCE_LAB

local perk_festive_bag = AddRecipe("candybag_perk", {Ingredient("cutgrass", 6)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "shrine")
perk_festive_bag.image = "candybag.tex"
perk_festive_bag.product = "candybag"
GLOBAL.STRINGS.RECIPE_DESC.CANDYBAG_PERK = GLOBAL.STRINGS.RECIPE_DESC.CANDYBAG
GLOBAL.STRINGS.NAMES.CANDYBAG_PERK = GLOBAL.STRINGS.NAMES.CANDYBAG

local perk_festive_tree = AddRecipe("winter_treestand_perk", {Ingredient("poop", 4), Ingredient("boards", 2)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, "winter_treestand_placer", nil, nil, nil, "shrine")
perk_festive_tree.image = "winter_treestand.tex"
perk_festive_tree.product = "winter_treestand"
GLOBAL.STRINGS.RECIPE_DESC.WINTER_TREESTAND_PERK = GLOBAL.STRINGS.RECIPE_DESC.WINTER_TREESTAND
GLOBAL.STRINGS.NAMES.WINTER_TREESTAND_PERK = GLOBAL.STRINGS.NAMES.WINTER_TREESTAND

local perk_festive_wrap = AddRecipe("giftwrap_perk", {Ingredient("papyrus", 2), Ingredient("rope", 1), Ingredient("petals", 1)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "shrine")
perk_festive_wrap.image = "giftwrap.tex"
perk_festive_wrap.product = "giftwrap"
GLOBAL.STRINGS.RECIPE_DESC.GIFTWRAP_PERK = GLOBAL.STRINGS.RECIPE_DESC.GIFTWRAP
GLOBAL.STRINGS.NAMES.GIFTWRAP_PERK = GLOBAL.STRINGS.NAMES.GIFTWRAP

---WORMWOOD Items
local livinglog = AddRecipe("livinglog_perk", {Ingredient(GLOBAL.CHARACTER_INGREDIENT.HEALTH, 25), Ingredient("log", 1)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "naturalist")
livinglog.image = "livinglog.tex"
livinglog.product = "livinglog"
GLOBAL.STRINGS.RECIPE_DESC.LIVINGLOG_PERK = GLOBAL.STRINGS.RECIPE_DESC.LIVINGLOG
GLOBAL.STRINGS.NAMES.LIVINGLOG_PERK = GLOBAL.STRINGS.NAMES.LIVINGLOG

local armor_bramble = AddRecipe("armor_bramble_perk", {Ingredient("livinglog", 3), Ingredient("boneshard", 6)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "naturalist")
armor_bramble.image = "armor_bramble.tex"
armor_bramble.product = "armor_bramble"
GLOBAL.STRINGS.RECIPE_DESC.ARMOR_BRAMBLE_PERK = GLOBAL.STRINGS.RECIPE_DESC.ARMOR_BRAMBLE
GLOBAL.STRINGS.NAMES.ARMOR_BRAMBLE_PERK = GLOBAL.STRINGS.NAMES.ARMOR_BRAMBLE

local trap_bramble = AddRecipe("trap_bramble_perk", {Ingredient("livinglog", 2), Ingredient("stinger", 2)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "naturalist")
trap_bramble.image = "trap_bramble.tex"
trap_bramble.product = "trap_bramble"
GLOBAL.STRINGS.RECIPE_DESC.TRAP_BRAMBLE_PERK = GLOBAL.STRINGS.RECIPE_DESC.TRAP_BRAMBLE
GLOBAL.STRINGS.NAMES.TRAP_BRAMBLE_PERK = GLOBAL.STRINGS.NAMES.TRAP_BRAMBLE

local compostwrap = AddRecipe("compostwrap_perk", {Ingredient("poop", 6), Ingredient("spoiled_food", 3), Ingredient("nitre", 2)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "naturalist")
compostwrap.image = "compostwrap.tex"
compostwrap.product = "compostwrap"
GLOBAL.STRINGS.RECIPE_DESC.COMPOSTWRAP_PERK = GLOBAL.STRINGS.RECIPE_DESC.COMPOSTWRAP
GLOBAL.STRINGS.NAMES.COMPOSTWRAP_PERK = GLOBAL.STRINGS.NAMES.COMPOSTWRAP

---MOON ALTAR
local moonglassaxe = AddRecipe("moonglassaxe_perk", {Ingredient("twigs", 4), Ingredient("moonglass", 4)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "lunarcraft")
moonglassaxe.image = "moonglassaxe.tex"
moonglassaxe.product = "moonglassaxe"
GLOBAL.STRINGS.RECIPE_DESC.MOONGLASSAXE_PERK = GLOBAL.STRINGS.RECIPE_DESC.MOONGLASSAXE
GLOBAL.STRINGS.NAMES.MOONGLASSAXE_PERK = GLOBAL.STRINGS.NAMES.MOONGLASSAXE

local glasscutter = AddRecipe("glasscutter_perk", {Ingredient("boards", 2), Ingredient("moonglass", 7)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "lunarcraft")
glasscutter.image = "glasscutter.tex"
glasscutter.product = "glasscutter"
GLOBAL.STRINGS.RECIPE_DESC.GLASSCUTTER_PERK = GLOBAL.STRINGS.RECIPE_DESC.GLASSCUTTER
GLOBAL.STRINGS.NAMES.GLASSCUTTER_PERK = GLOBAL.STRINGS.NAMES.GLASSCUTTER

local turf_meteor = AddRecipe("turf_meteor_perk", {Ingredient("moonrocknugget", 1), Ingredient("moonglass", 3)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, 6, "lunarcraft")
turf_meteor.image = "turf_meteor.tex"
turf_meteor.product = "turf_meteor"
GLOBAL.STRINGS.RECIPE_DESC.TURF_METEOR_PERK = GLOBAL.STRINGS.RECIPE_DESC.TURF_METEOR
GLOBAL.STRINGS.NAMES.TURF_METEOR_PERK = GLOBAL.STRINGS.NAMES.TURF_METEOR

local bathbomb = AddRecipe("bathbomb_perk", {Ingredient("moon_tree_blossom", 8), Ingredient("nitre", 1)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "lunarcraft")
bathbomb.image = "bathbomb.tex"
bathbomb.product = "bathbomb"
GLOBAL.STRINGS.RECIPE_DESC.BATHBOMB_PERK = GLOBAL.STRINGS.RECIPE_DESC.BATHBOMB
GLOBAL.STRINGS.NAMES.BATHBOMB_PERK = GLOBAL.STRINGS.NAMES.BATHBOMB

local chesspiece_butterfly_sketch = AddRecipe("chesspiece_butterfly_sketch_perk", {Ingredient("papyrus", 2)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "lunarcraft")
chesspiece_butterfly_sketch.image = "chesspiece_butterfly_sketch.tex"
chesspiece_butterfly_sketch.product = "chesspiece_butterfly_sketch"
GLOBAL.STRINGS.RECIPE_DESC.CHESSPIECE_BUTTERFLY_SKETCH_PERK = GLOBAL.STRINGS.RECIPE_DESC.CHESSPIECE_BUTTERFLY_SKETCH
GLOBAL.STRINGS.NAMES.CHESSPIECE_BUTTERFLY_SKETCH_PERK = GLOBAL.STRINGS.NAMES.CHESSPIECE_BUTTERFLY_SKETCH

local chesspiece_moon_sketch = AddRecipe("chesspiece_moon_sketch_perk", {Ingredient("papyrus", 2)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "lunarcraft")
chesspiece_moon_sketch.image = "chesspiece_moon_sketch.tex"
chesspiece_moon_sketch.product = "chesspiece_moon_sketch"
GLOBAL.STRINGS.RECIPE_DESC.CHESSPIECE_MOON_SKETCH_PERK = GLOBAL.STRINGS.RECIPE_DESC.CHESSPIECE_MOON_SKETCH
GLOBAL.STRINGS.NAMES.CHESSPIECE_MOON_SKETCH_PERK = GLOBAL.STRINGS.NAMES.CHESSPIECE_MOON_SKETCH

AddRecipe("ancient_altar", {Ingredient("thulecite", 15), Ingredient("cutstone", 20), Ingredient("purplegem", 2)}, GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, 
"ancient_altar_placer", --placer
nil, -- min_spacing
nil, -- nounlock
nil, -- numtogive
"ancientstation", -- builder_tag
"images/inventoryimages/altar.xml", -- atlas
"altar.tex") -- image

AddRecipe("klaus_sack", {Ingredient("redmooneye",1),Ingredient("bluemooneye",1),Ingredient("silk",8)}, GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, 
"klaussack_placer", --placer
nil, -- min_spacing
nil, -- nounlock
nil, -- numtogive
"achiveking", -- builder_tag
"images/inventoryimages/klaussack.xml", -- atlas
"klaussack.tex") -- image

AddRecipe("deer_antler1", {Ingredient("boneshard",2),Ingredient("twigs",1)}, GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, 
nil, --placer
nil, -- min_spacing
nil, -- nounlock
nil, -- numtogive
"achiveking", -- builder_tag
"images/inventoryimages.xml", -- atlas
"deer_antler1.tex") -- image

--ReAdd for Warly
AddRecipe("portablecookpot_item", {Ingredient("goldnugget", 2) , Ingredient("charcoal", 6) , Ingredient("twigs", 6)},
GLOBAL.RECIPETABS.FARM, TECH.NONE, nil, nil, nil, nil, "realchef")
AddRecipe("portableblender_item", {Ingredient("goldnugget", 2) , Ingredient("transistor", 2) , Ingredient("twigs", 4)},
GLOBAL.RECIPETABS.FARM, TECH.NONE, nil, nil, nil, nil, "realchef")
AddRecipe("portablespicer_item", {Ingredient("goldnugget", 2) , Ingredient("cutstone", 6) , Ingredient("twigs", 6)},
GLOBAL.RECIPETABS.FARM, TECH.NONE, nil, nil, nil, nil, "realchef")

--Add for chef perk
AddRecipe("perkportablecookpot", {Ingredient("goldnugget", 2) , Ingredient("charcoal", 6) , Ingredient("twigs", 6)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "perkchef",
"images/inventoryimages1.xml", "portablecookpot_item.tex")
AddRecipe("perkportableblender", {Ingredient("goldnugget", 2) , Ingredient("transistor", 2) , Ingredient("twigs", 4)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "perkchef",
"images/inventoryimages1.xml", "portableblender_item.tex")
AddRecipe("perkportablespicer", {Ingredient("goldnugget", 2) , Ingredient("cutstone", 6) , Ingredient("twigs", 6)},
GLOBAL.RECIPETABS.PERK_TAB, TECH.NONE, nil, nil, nil, nil, "perkchef",
"images/inventoryimages1.xml", "portablespicer_item.tex")

AddPlayerPostInit(function(inst)
	inst.checkemerald = GLOBAL.net_shortint(inst.GUID,"checkemerald")
	inst.checkcitrin = GLOBAL.net_shortint(inst.GUID,"checkcitrin")
	inst.checkamber = GLOBAL.net_shortint(inst.GUID,"checkamber")
	inst.checksaddle = GLOBAL.net_shortint(inst.GUID,"checksaddle")
	inst.checkbanana = GLOBAL.net_shortint(inst.GUID,"checkbanana")
	inst.checkspore = GLOBAL.net_shortint(inst.GUID,"checkspore")
	inst.checkblueprint = GLOBAL.net_shortint(inst.GUID,"checkblueprint")
	inst.checkboat = GLOBAL.net_shortint(inst.GUID,"checkboat")
	inst.checkmoonrock = GLOBAL.net_shortint(inst.GUID,"checkmoonrock")
	inst.checkgnome = GLOBAL.net_shortint(inst.GUID,"checkgnome")
	inst.checkmosquito = GLOBAL.net_shortint(inst.GUID,"checkmosquito")
	
	inst.checkintogame = GLOBAL.net_shortint(inst.GUID,"checkintogame")
	inst.checkfirsteat = GLOBAL.net_shortint(inst.GUID,"checkfirsteat")
	inst.checksupereat = GLOBAL.net_shortint(inst.GUID,"checksupereat")
	inst.checkdanding = GLOBAL.net_shortint(inst.GUID,"checkdanding")
    inst.checkmessiah = GLOBAL.net_shortint(inst.GUID,"checkmessiah")
    inst.checkwalkalot = GLOBAL.net_shortint(inst.GUID,"checkwalkalot")
    inst.checkstopalot = GLOBAL.net_shortint(inst.GUID,"checkstopalot")
    inst.checktooyoung = GLOBAL.net_shortint(inst.GUID,"checktooyoung")
    inst.checkevil = GLOBAL.net_shortint(inst.GUID,"checkevil")
    inst.checksnake = GLOBAL.net_shortint(inst.GUID,"checksnake")
    inst.checkdeathalot = GLOBAL.net_shortint(inst.GUID,"checkdeathalot")
    inst.checknosanity = GLOBAL.net_shortint(inst.GUID,"checknosanity")
    inst.checksick = GLOBAL.net_shortint(inst.GUID,"checksick")
    inst.checkcoldblood = GLOBAL.net_shortint(inst.GUID,"checkcoldblood")
    inst.checkburn = GLOBAL.net_shortint(inst.GUID,"checkburn")
    inst.checkfreeze = GLOBAL.net_shortint(inst.GUID,"checkfreeze")
    inst.checksleep = GLOBAL.net_shortint(inst.GUID,"checksleep")
    inst.checkgoodman = GLOBAL.net_shortint(inst.GUID,"checkgoodman")
    inst.checkbrother = GLOBAL.net_shortint(inst.GUID,"checkbrother")
    inst.checkfishmaster = GLOBAL.net_shortint(inst.GUID,"checkfishmaster")
    inst.checkpickappren = GLOBAL.net_shortint(inst.GUID,"checkpickappren")
    inst.checkpickmaster = GLOBAL.net_shortint(inst.GUID,"checkpickmaster")
    inst.checkchopappren = GLOBAL.net_shortint(inst.GUID,"checkchopappren")
    inst.checkchopmaster = GLOBAL.net_shortint(inst.GUID,"checkchopmaster")
    inst.checkmineappren = GLOBAL.net_shortint(inst.GUID,"checkmineappren")
    inst.checkminemaster = GLOBAL.net_shortint(inst.GUID,"checkminemaster")
    inst.checknoob = GLOBAL.net_shortint(inst.GUID,"checknoob")
    inst.checkcookappren = GLOBAL.net_shortint(inst.GUID,"checkcookappren")
    inst.checkcookmaster = GLOBAL.net_shortint(inst.GUID,"checkcookmaster")
    inst.checklongage = GLOBAL.net_shortint(inst.GUID,"checklongage")
    inst.checkluck = GLOBAL.net_shortint(inst.GUID,"checkluck")
    inst.checkblack = GLOBAL.net_shortint(inst.GUID,"checkblack")
    inst.checkbuildappren = GLOBAL.net_shortint(inst.GUID,"checkbuildappren")
    inst.checkbuildmaster = GLOBAL.net_shortint(inst.GUID,"checkbuildmaster")
    inst.checktank = GLOBAL.net_shortint(inst.GUID,"checktank")
    inst.checkangry = GLOBAL.net_shortint(inst.GUID,"checkangry")
    inst.checkicebody = GLOBAL.net_shortint(inst.GUID,"checkicebody")
    inst.checkfirebody = GLOBAL.net_shortint(inst.GUID,"checkfirebody")
    inst.checksanta = GLOBAL.net_shortint(inst.GUID,"checksanta")
    inst.checkknight = GLOBAL.net_shortint(inst.GUID,"checkknight")
    inst.checkbishop = GLOBAL.net_shortint(inst.GUID,"checkbishop")
    inst.checkrook = GLOBAL.net_shortint(inst.GUID,"checkrook")
    inst.checkancient = GLOBAL.net_shortint(inst.GUID,"checkancient")
    inst.checkminotaur = GLOBAL.net_shortint(inst.GUID,"checkminotaur")
    inst.checkrigid = GLOBAL.net_shortint(inst.GUID,"checkrigid")
    inst.checkqueen = GLOBAL.net_shortint(inst.GUID,"checkqueen")
    inst.checkking = GLOBAL.net_shortint(inst.GUID,"checkking")
    inst.checkmoistbody = GLOBAL.net_shortint(inst.GUID,"checkmoistbody")
    inst.checkstarve = GLOBAL.net_shortint(inst.GUID,"checkstarve")
    inst.checkall = GLOBAL.net_shortint(inst.GUID,"checkall")
	
    inst.checkcatperson = GLOBAL.net_shortint(inst.GUID,"checkcatperson")
    inst.checkrose = GLOBAL.net_shortint(inst.GUID,"checkrose")
    inst.checkbutcher = GLOBAL.net_shortint(inst.GUID,"checkbutcher")
    inst.checkgoatperd = GLOBAL.net_shortint(inst.GUID,"checkgoatperd")
    inst.checkmossling = GLOBAL.net_shortint(inst.GUID,"checkmossling")
    inst.checkweetusk = GLOBAL.net_shortint(inst.GUID,"checkweetusk")
    inst.checksecondchance = GLOBAL.net_shortint(inst.GUID,"checksecondchance")
    inst.checknature = GLOBAL.net_shortint(inst.GUID,"checknature")
    inst.checkalldiet = GLOBAL.net_shortint(inst.GUID,"checkalldiet")
    inst.checkspooder = GLOBAL.net_shortint(inst.GUID,"checkspooder")
    inst.checkhutch = GLOBAL.net_shortint(inst.GUID,"checkhutch")
    inst.checkhentai = GLOBAL.net_shortint(inst.GUID,"checkhentai")
	inst.checkdragonfly = GLOBAL.net_shortint(inst.GUID,"checkdragonfly")
	inst.checkmalbatross = GLOBAL.net_shortint(inst.GUID,"checkmalbatross")
	inst.checktrader = GLOBAL.net_shortint(inst.GUID,"checktrader")
	inst.checkfuzzy = GLOBAL.net_shortint(inst.GUID,"checkfuzzy")
    inst.checkpet = GLOBAL.net_shortint(inst.GUID,"checkpet")
    inst.checkbirdclop = GLOBAL.net_shortint(inst.GUID,"checkbirdclop")
    inst.checkcaveage = GLOBAL.net_shortint(inst.GUID,"checkcaveage")
    inst.checkeathot = GLOBAL.net_shortint(inst.GUID,"checkeathot")
    inst.checkeatcold = GLOBAL.net_shortint(inst.GUID,"checkeatcold")
    inst.checkrot = GLOBAL.net_shortint(inst.GUID,"checkrot")
    inst.checkknowledge = GLOBAL.net_shortint(inst.GUID,"checkknowledge")
    inst.checkdance = GLOBAL.net_shortint(inst.GUID,"checkdance")
    inst.checkteleport = GLOBAL.net_shortint(inst.GUID,"checkteleport")
    inst.checkrocklob = GLOBAL.net_shortint(inst.GUID,"checkrocklob")
    inst.checksuperstar = GLOBAL.net_shortint(inst.GUID,"checksuperstar")
    inst.checkoldage = GLOBAL.net_shortint(inst.GUID,"checkoldage")
	
	inst.currenteatfish = GLOBAL.net_shortint(inst.GUID,"currenteatfish")
	inst.currenteatturkey = GLOBAL.net_shortint(inst.GUID,"currenteatturkey")
	inst.currenteatpepper = GLOBAL.net_shortint(inst.GUID,"currenteatpepper")
	inst.currenteatbacon = GLOBAL.net_shortint(inst.GUID,"currenteatbacon")
	inst.currenteatmole = GLOBAL.net_shortint(inst.GUID,"currenteatmole")
	inst.currentsleeptent = GLOBAL.net_shortint(inst.GUID,"currentsleeptent")
	inst.currentsleepsiesta = GLOBAL.net_shortint(inst.GUID,"currentsleepsiesta")
	inst.currentreviveamulet = GLOBAL.net_shortint(inst.GUID,"currentreviveamulet")
	inst.currentfeedplayer = GLOBAL.net_shortint(inst.GUID,"currentfeedplayer")
	inst.currentbathbomb = GLOBAL.net_shortint(inst.GUID,"currentbathbomb")
	inst.currentevilflower = GLOBAL.net_shortint(inst.GUID,"currentevilflower")
	inst.currentroses = GLOBAL.net_shortint(inst.GUID,"currentroses")
	inst.currentdmgnodmg = GLOBAL.net_shortint(inst.GUID,"currentdmgnodmg")
	inst.currentbullkelp = GLOBAL.net_shortint(inst.GUID,"currentbullkelp")
	inst.currenthorrorhound = GLOBAL.net_shortint(inst.GUID,"currenthorrorhound")
	inst.currentslurtle = GLOBAL.net_shortint(inst.GUID,"currentslurtle")
	inst.currentwerepig = GLOBAL.net_shortint(inst.GUID,"currentwerepig")
	inst.currentfruitdragon = GLOBAL.net_shortint(inst.GUID,"currentfruitdragon")
	inst.currenttreeguard = GLOBAL.net_shortint(inst.GUID,"currenttreeguard")
	inst.currentspiderqueen = GLOBAL.net_shortint(inst.GUID,"currentspiderqueen")
	inst.currentvarg = GLOBAL.net_shortint(inst.GUID,"currentvarg")
	inst.currentkoaelefant = GLOBAL.net_shortint(inst.GUID,"currentkoaelefant")
	inst.currentmonkey = GLOBAL.net_shortint(inst.GUID,"currentmonkey")
	inst.currentbirchnut = GLOBAL.net_shortint(inst.GUID,"currentbirchnut")
	inst.currentrider = GLOBAL.net_shortint(inst.GUID,"currentrider")
	inst.currentfullsanity = GLOBAL.net_shortint(inst.GUID,"currentfullsanity")
	inst.currentfullhunger = GLOBAL.net_shortint(inst.GUID,"currentfullhunger")
	inst.currentpacifist = GLOBAL.net_shortint(inst.GUID,"currentpacifist")

	inst.checkeatfish = GLOBAL.net_shortint(inst.GUID,"checkeatfish")
	inst.checkeatturkey = GLOBAL.net_shortint(inst.GUID,"checkeatturkey")
	inst.checkeatpepper = GLOBAL.net_shortint(inst.GUID,"checkeatpepper")
	inst.checkeatbacon = GLOBAL.net_shortint(inst.GUID,"checkeatbacon")
	inst.checkeatmole = GLOBAL.net_shortint(inst.GUID,"checkeatmole")
	inst.checksleeptent = GLOBAL.net_shortint(inst.GUID,"checksleeptent")
	inst.checksleepsiesta = GLOBAL.net_shortint(inst.GUID,"checksleepsiesta")
	inst.checkreviveamulet = GLOBAL.net_shortint(inst.GUID,"checkreviveamulet")
	inst.checkfeedplayer = GLOBAL.net_shortint(inst.GUID,"checkfeedplayer")
	inst.checkbathbomb = GLOBAL.net_shortint(inst.GUID,"checkbathbomb")
	inst.checkshadowchester = GLOBAL.net_shortint(inst.GUID,"checkshadowchester")
	inst.checksnowchester = GLOBAL.net_shortint(inst.GUID,"checksnowchester")
	inst.checkmusichutch = GLOBAL.net_shortint(inst.GUID,"checkmusichutch")
	inst.checklavae = GLOBAL.net_shortint(inst.GUID,"checklavae")
	inst.checkevilflower = GLOBAL.net_shortint(inst.GUID,"checkevilflower")
	inst.checkroses = GLOBAL.net_shortint(inst.GUID,"checkroses")
	inst.checkdrown = GLOBAL.net_shortint(inst.GUID,"checkdrown")
	inst.checkdmgnodmg = GLOBAL.net_shortint(inst.GUID,"checkdmgnodmg")
	inst.checkbullkelp = GLOBAL.net_shortint(inst.GUID,"checkbullkelp")
	inst.checkhorrorhound = GLOBAL.net_shortint(inst.GUID,"checkhorrorhound")
	inst.checkslurtle = GLOBAL.net_shortint(inst.GUID,"checkslurtle")
	inst.checkwerepig = GLOBAL.net_shortint(inst.GUID,"checkwerepig")
	inst.checkfruitdragon = GLOBAL.net_shortint(inst.GUID,"checkfruitdragon")
	inst.checktreeguard = GLOBAL.net_shortint(inst.GUID,"checktreeguard")
	inst.checkspiderqueen = GLOBAL.net_shortint(inst.GUID,"checkspiderqueen")
	inst.checkvarg = GLOBAL.net_shortint(inst.GUID,"checkvarg")
	inst.checkkoaelefant = GLOBAL.net_shortint(inst.GUID,"checkkoaelefant")
	inst.checkmonkey = GLOBAL.net_shortint(inst.GUID,"checkmonkey")
	inst.checklightning = GLOBAL.net_shortint(inst.GUID,"checklightning")
	inst.checkbirchnut = GLOBAL.net_shortint(inst.GUID,"checkbirchnut")
	inst.checkrider = GLOBAL.net_shortint(inst.GUID,"checkrider")
	inst.checkfullsanity = GLOBAL.net_shortint(inst.GUID,"checkfullsanity")
	inst.checkfullhunger = GLOBAL.net_shortint(inst.GUID,"checkfullhunger")
	inst.checkpacifist = GLOBAL.net_shortint(inst.GUID,"checkpacifist")

	inst.currentruncount = GLOBAL.net_shortint(inst.GUID,"currentruncount")
	inst.currenteatamount = GLOBAL.net_shortint(inst.GUID,"currenteatamount")
	inst.currenteatmonsterlasagna = GLOBAL.net_shortint(inst.GUID,"currenteatmonsterlasagna")
    inst.currentrespawnamount = GLOBAL.net_shortint(inst.GUID,"currentrespawnamount")
    inst.currentwalktime = GLOBAL.net_shortint(inst.GUID,"currentwalktime")
	inst.currentemeralds = GLOBAL.net_shortint(inst.GUID,"currentemeralds")
	
	inst.currentcitrins = GLOBAL.net_shortint(inst.GUID,"currentcitrins")
	inst.currentambers = GLOBAL.net_shortint(inst.GUID,"currentambers")
	inst.currentsaddles = GLOBAL.net_shortint(inst.GUID,"currentsaddles")
	inst.currentbananas = GLOBAL.net_shortint(inst.GUID,"currentbananas")
	inst.currentspores = GLOBAL.net_shortint(inst.GUID,"currentspores")
	inst.currentblueprints = GLOBAL.net_shortint(inst.GUID,"currentblueprints")
	inst.currentboats = GLOBAL.net_shortint(inst.GUID,"currentboats")
	inst.currentmoonrocks = GLOBAL.net_shortint(inst.GUID,"currentmoonrocks")
	inst.currentgnomes = GLOBAL.net_shortint(inst.GUID,"currentgnomes")
	inst.currentmosquitos = GLOBAL.net_shortint(inst.GUID,"currentmosquitos")
	
    inst.currentstoptime = GLOBAL.net_shortint(inst.GUID,"currentstoptime")
    inst.currentevilamount = GLOBAL.net_shortint(inst.GUID,"currentevilamount")
    inst.currentdeathamouth = GLOBAL.net_shortint(inst.GUID,"currentdeathamouth")
    inst.currentnosanitytime = GLOBAL.net_shortint(inst.GUID,"currentnosanitytime")
    inst.currentsnakeamount = GLOBAL.net_shortint(inst.GUID,"currentsnakeamount")
    inst.currentfriendpig = GLOBAL.net_shortint(inst.GUID,"currentfriendpig")
    inst.currentfriendbunny = GLOBAL.net_shortint(inst.GUID,"currentfriendbunny")
    inst.currentfishamount = GLOBAL.net_shortint(inst.GUID,"currentfishamount")
    inst.currentpickamount = GLOBAL.net_shortint(inst.GUID,"currentpickamount")
    inst.currentchopamount = GLOBAL.net_shortint(inst.GUID,"currentchopamount")
    inst.currentcookamount = GLOBAL.net_shortint(inst.GUID,"currentcookamount")
    inst.currentmineamount = GLOBAL.net_shortint(inst.GUID,"currentmineamount")
    inst.currentbuildamount = GLOBAL.net_shortint(inst.GUID,"currentbuildamount")
    inst.currentattackeddamage = GLOBAL.net_shortint(inst.GUID,"currentattackeddamage")
    inst.currentonhitdamage = GLOBAL.net_int(inst.GUID,"currentonhitdamage")
    inst.currenticetime = GLOBAL.net_shortint(inst.GUID,"currenticetime")
    inst.currentfiretime = GLOBAL.net_shortint(inst.GUID,"currentfiretime")
    inst.currentmoisttime = GLOBAL.net_shortint(inst.GUID,"currentmoisttime")
    inst.currentstarvetime = GLOBAL.net_shortint(inst.GUID,"currentstarvetime")
    inst.currentage = GLOBAL.net_shortint(inst.GUID,"currentage")
    inst.currentfriendcat = GLOBAL.net_shortint(inst.GUID,"currentfriendcat")
    inst.currentbutcheramount = GLOBAL.net_shortint(inst.GUID,"currentbutcheramount")
    inst.currentgoatperdamount = GLOBAL.net_shortint(inst.GUID,"currentgoatperdamount")
    inst.currentmosslingamount = GLOBAL.net_shortint(inst.GUID,"currentmosslingamount")
    inst.currentweetuskamount = GLOBAL.net_shortint(inst.GUID,"currentweetuskamount")
    inst.currentnatureamount = GLOBAL.net_shortint(inst.GUID,"currentnatureamount")
    inst.currenteatall = GLOBAL.net_shortint(inst.GUID,"currenteatall")
	inst.currenteatlist = GLOBAL.net_string(inst.GUID,"currenteatlist")
    inst.currentfriendspider = GLOBAL.net_shortint(inst.GUID,"currentfriendspider")
    inst.currenthentaiamount = GLOBAL.net_shortint(inst.GUID,"currenthentaiamount")
    inst.currenttradeamount = GLOBAL.net_shortint(inst.GUID,"currenttradeamount")
    inst.currentfuzzyamount = GLOBAL.net_shortint(inst.GUID,"currentfuzzyamount")
    inst.currentcavetime = GLOBAL.net_shortint(inst.GUID,"currentcavetime")
    inst.currenteathotamount = GLOBAL.net_shortint(inst.GUID,"currenteathotamount")
    inst.currenteatcoldamount = GLOBAL.net_shortint(inst.GUID,"currenteatcoldamount")
    inst.currentdanceamount = GLOBAL.net_shortint(inst.GUID,"currentdanceamount")
    inst.currentfriendrocky = GLOBAL.net_shortint(inst.GUID,"currentfriendrocky")
    inst.currentstarspent = GLOBAL.net_shortint(inst.GUID,"currentstarspent")
    inst.currentteleportamount = GLOBAL.net_shortint(inst.GUID,"currentteleportamount")

    inst.checkbosswinter = GLOBAL.net_shortint(inst.GUID,"checkbosswinter")
    inst.checkbossspring = GLOBAL.net_shortint(inst.GUID,"checkbossspring")
    inst.checkbossantlion = GLOBAL.net_shortint(inst.GUID,"checkbossantlion")
    inst.checkbossautumn = GLOBAL.net_shortint(inst.GUID,"checkbossautumn")

	inst.currentcoinamount = GLOBAL.net_shortint(inst.GUID,"currentcoinamount")

	inst.currenthungerup = GLOBAL.net_shortint(inst.GUID,"currenthungerup")
	inst.currentsanityup = GLOBAL.net_shortint(inst.GUID,"currentsanityup")
	inst.currenthealthup = GLOBAL.net_shortint(inst.GUID,"currenthealthup")
	inst.currenthealthregen = GLOBAL.net_shortint(inst.GUID,"currenthealthregen")
	inst.currentsanityregen = GLOBAL.net_shortint(inst.GUID,"currentsanityregen")
	inst.currenthungerrateup = GLOBAL.net_shortint(inst.GUID,"currenthungerrateup")
	inst.currentspeedup = GLOBAL.net_shortint(inst.GUID,"currentspeedup")
	inst.currentabsorbup = GLOBAL.net_shortint(inst.GUID,"currentabsorbup")
	inst.currentdamageup = GLOBAL.net_shortint(inst.GUID,"currentdamageup")
	inst.currentcrit = GLOBAL.net_shortint(inst.GUID,"currentcrit")
	inst.currentlifestealup = GLOBAL.net_shortint(inst.GUID,"currentlifestealup")
	inst.currentfireflylightup = GLOBAL.net_shortint(inst.GUID,"currentfireflylightup")
	inst.currentscaleup = GLOBAL.net_shortint(inst.GUID,"currentscaleup")
	
	inst.currenthungerachivcost = GLOBAL.net_shortint(inst.GUID,"currenthungerachivcost")
	inst.currentsanityachivcost = GLOBAL.net_shortint(inst.GUID,"currentsanityachivcost")
	inst.currenthealthachivcost = GLOBAL.net_shortint(inst.GUID,"currenthealthachivcost")
	inst.currenthealthregenachivcost = GLOBAL.net_shortint(inst.GUID,"currenthealthregenachivcost")
	inst.currentsanityregenachivcost = GLOBAL.net_shortint(inst.GUID,"currentsanityregenachivcost")
	inst.currenthungerrateachivcost = GLOBAL.net_shortint(inst.GUID,"currenthungerrateachivcost")
	inst.currentspeedachivcost = GLOBAL.net_shortint(inst.GUID,"currentspeedachivcost")
	inst.currentabsorbachivcost = GLOBAL.net_shortint(inst.GUID,"currentabsorbachivcost")
	inst.currentdamageachivcost = GLOBAL.net_shortint(inst.GUID,"currentdamageachivcost")
	inst.currentcritachivcost = GLOBAL.net_shortint(inst.GUID,"currentcritachivcost")
	inst.currentlifestealcost = GLOBAL.net_shortint(inst.GUID,"currentlifestealcost")
	inst.currentfireflylightcost = GLOBAL.net_shortint(inst.GUID,"currentfireflylightcost")
	inst.currentscalecost = GLOBAL.net_shortint(inst.GUID,"currentscalecost")

	inst.currentdoubledrop = GLOBAL.net_shortint(inst.GUID,"currentdoubledrop")
	inst.currentkrampusxmas = GLOBAL.net_shortint(inst.GUID,"currentcurrentkrampusxmas")
	inst.currentnomoist = GLOBAL.net_shortint(inst.GUID,"currentnomoist")
	inst.currentgoodman = GLOBAL.net_shortint(inst.GUID,"currentgoodman")
	inst.currentanimallover = GLOBAL.net_shortint(inst.GUID,"currentanimallover")
	inst.currentrefresh = GLOBAL.net_shortint(inst.GUID,"currentrefresh")
	inst.currentnanobots = GLOBAL.net_shortint(inst.GUID,"currentnanobots")
	inst.currentarchmage = GLOBAL.net_shortint(inst.GUID,"currentarchmage")
	inst.currentcheatdeath = GLOBAL.net_shortint(inst.GUID,"currentcheatdeath")
	inst.currentfishmaster = GLOBAL.net_shortint(inst.GUID,"currentfishmaster")
	inst.currentcookmaster = GLOBAL.net_shortint(inst.GUID,"currentcookmaster")
	inst.currentchopmaster = GLOBAL.net_shortint(inst.GUID,"currentchopmaster")
	inst.currentpickmaster = GLOBAL.net_shortint(inst.GUID,"currentpickmaster")
	inst.currentbuildmaster = GLOBAL.net_shortint(inst.GUID,"currentbuildmaster")
	inst.currenticebody = GLOBAL.net_shortint(inst.GUID,"currenticebody")
	inst.currentfirebody = GLOBAL.net_shortint(inst.GUID,"currentfirebody")
	inst.currentsupply = GLOBAL.net_shortint(inst.GUID,"currentsupply")
	inst.currentreader = GLOBAL.net_shortint(inst.GUID,"currentreader")
    inst.currentmasterchef = GLOBAL.net_shortint(inst.GUID,"currentmasterchef")
	inst.currentengineering = GLOBAL.net_shortint(inst.GUID,"currentengineering")
	inst.currentnaturalist = GLOBAL.net_shortint(inst.GUID,"currentnaturalist")
	inst.currentlunarcraft = GLOBAL.net_shortint(inst.GUID,"currentlunarcraft")
	inst.currentshrine = GLOBAL.net_shortint(inst.GUID,"currentshrine")
	inst.currentminemaster = GLOBAL.net_shortint(inst.GUID,"currentminemaster")
	inst.currentfastworker = GLOBAL.net_shortint(inst.GUID,"currentfastworker")
	inst.currentancientstation = GLOBAL.net_shortint(inst.GUID,"currentancientstation")
	
	inst.currentlevel = GLOBAL.net_shortint(inst.GUID,"currentlevel")
	inst.currentlevelxp = GLOBAL.net_uint(inst.GUID,"currentlevelxp")
	inst.currentoverallxp = GLOBAL.net_uint(inst.GUID,"currentoverallxp")
	inst.currentattributepoints = GLOBAL.net_shortint(inst.GUID,"currentattributepoints")
	
	inst.currenthungeruplevel = GLOBAL.net_shortint(inst.GUID,"currenthungeruplevel")
	inst.currentsanityuplevel = GLOBAL.net_shortint(inst.GUID,"currentsanityuplevel")
	inst.currenthealthuplevel = GLOBAL.net_shortint(inst.GUID,"currenthealthuplevel")
	inst.currentspeeduplevel = GLOBAL.net_shortint(inst.GUID,"currentspeeduplevel")
	inst.currentabsorbuplevel = GLOBAL.net_shortint(inst.GUID,"currentabsorbuplevel")
	inst.currentdamageuplevel = GLOBAL.net_shortint(inst.GUID,"currentdamageuplevel")
	inst.currentinsulationuplevel = GLOBAL.net_shortint(inst.GUID,"currentinsulationuplevel")
	inst.currentinsulationsummeruplevel = GLOBAL.net_shortint(inst.GUID,"currentinsulationsummeruplevel")
	
	inst.currenthungercost = GLOBAL.net_shortint(inst.GUID,"currenthungercost")
	inst.currentsanitycost = GLOBAL.net_shortint(inst.GUID,"currentsanitycost")
	inst.currenthealthcost = GLOBAL.net_shortint(inst.GUID,"currenthealthcost")
	inst.currentspeedcost = GLOBAL.net_shortint(inst.GUID,"currentspeedcost")
	inst.currentabsorbcost = GLOBAL.net_shortint(inst.GUID,"currentabsorbcost")
	inst.currentdamagecost = GLOBAL.net_shortint(inst.GUID,"currentdamagecost")
	inst.currentinsulationcost = GLOBAL.net_shortint(inst.GUID,"currentinsulationcost")
	inst.currentinsulationsummercost = GLOBAL.net_shortint(inst.GUID,"currentinsulationsummercost")
	
	inst.currenthungermax = GLOBAL.net_shortint(inst.GUID,"currenthungermax")
	inst.currentsanitymax = GLOBAL.net_shortint(inst.GUID,"currentsanitymax")
	inst.currenthealthmax = GLOBAL.net_shortint(inst.GUID,"currenthealthmax")
	inst.currentspeedmax = GLOBAL.net_shortint(inst.GUID,"currentspeedmax")
	inst.currentabsorbmax = GLOBAL.net_shortint(inst.GUID,"currentabsorbmax")
	inst.currentdamagemax = GLOBAL.net_shortint(inst.GUID,"currentdamagemax")
	inst.currentinsulationmax = GLOBAL.net_shortint(inst.GUID,"currentinsulationmax")
	inst.currentinsulationsummermax = GLOBAL.net_shortint(inst.GUID,"currentinsulationsummermax")
	
	inst.currentzoomlevel = GLOBAL.net_float(inst.GUID,"currentzoomlevel")
	inst.currentwidgetxpos = GLOBAL.net_float(inst.GUID,"currentwidgetxpos")
	inst.currentlanguage = GLOBAL.net_string(inst.GUID,"currentlanguage")
	
    inst:AddComponent("allachivevent")
	inst:AddComponent("allachivcoin")
	inst:AddComponent("levelsystem")
	if not GLOBAL.TheNet:GetIsClient() then
		inst.components.allachivevent:Init(inst)
		inst.components.allachivcoin:Init(inst)
		inst.components.levelsystem:Init(inst)
	end
end)

--UI尺寸
local function PositionUI(self, screensize)
	local hudscale = self.top_root:GetScale()
	local screenw_full, screenh_full = GLOBAL.unpack(screensize)
	local screenw = screenw_full/hudscale.x
	local screenh = screenh_full/hudscale.y
	
	self.uiachievement:SetScale(.60*hudscale.x,.60*hudscale.y,1)
	self.uiachievement.mainbutton.hudscale = self.top_root:GetScale()
	self.uiachievement.mainbutton:SetScale(hudscale.x,hudscale.y,1)
	local pos = self.uiachievement.mainbutton:GetPosition()
	if _G.SYSTEM_CONFIG == "level" then
		self.uiachievement.mainbutton:SetPosition(pos.x, 36*hudscale.y, pos.z)
	end
	pos = self.uiachievement.mainbutton:GetPosition()
	if self.uiachievement.menuposition == nil then
		self.uiachievement.mainbutton:SetPosition(screenw_full*0.09, pos.y, pos.z)
		--SendModRPCToServer(MOD_RPC["DSTAchievement"]["saveWidgetXPos"],self.uiachievement.mainbutton:GetPosition().x)
	else
		if self.uiachievement.menuposition.x > screenw_full then
			self.uiachievement.mainbutton:SetPosition(screenw_full-256, pos.y, pos.z)
			--SendModRPCToServer(MOD_RPC["DSTAchievement"]["saveWidgetXPos"],self.uiachievement.mainbutton:GetPosition().x)
		end
	end
end

--UI
local uiachievement = require("widgets/uiachievement")
local uiachievementWidget = nil
local function hideMenus()
	if type(GLOBAL.ThePlayer) ~= "table" or type(GLOBAL.ThePlayer.HUD) ~= "table" then return end
	uiachievementWidget.mainui.allachiv:Hide()
	uiachievementWidget.mainui.allcoin:Hide()
	uiachievementWidget.mainui.levelbg:Hide()
	uiachievementWidget.mainui.achievement_bg:Hide()
	uiachievementWidget.mainui.infobutton:Hide()
	uiachievementWidget.mainui.perk_cat:Hide()
end
local function Adduiachievement(self)
    self.uiachievement = self.top_root:AddChild(uiachievement(self.owner))
	uiachievementWidget = self.uiachievement
    local screensize = {GLOBAL.TheSim:GetScreenSize()}
    PositionUI(self, screensize)
    self.uiachievement:SetHAnchor(0)
    self.uiachievement:SetVAnchor(0)
    self.uiachievement:MoveToFront()
    local OnUpdate_base = self.OnUpdate
	self.OnUpdate = function(self, dt)
		OnUpdate_base(self, dt)
		local curscreensize = {GLOBAL.TheSim:GetScreenSize()}
		if curscreensize[1] ~= screensize[1] or curscreensize[2] ~= screensize[2] then
			PositionUI(self, curscreensize)
			screensize = curscreensize
		end
	end
	
	GLOBAL.TheInput:AddKeyUpHandler(GLOBAL.KEY_ESCAPE, hideMenus)
end

AddClassPostConstruct("widgets/controls", Adduiachievement)

--欧皇检测
AddPrefabPostInit("krampus_sack", function(inst)
    inst:AddComponent("ksmark")
end)
AddPrefabPostInit("klaussackkey", function(inst)
    inst:AddComponent("ksmark")
end)
AddPrefabPostInit("warly", function(inst)
    inst:AddTag("realchef")
end)

AddPlayerPostInit(function(inst)
    GLOBAL.STRINGS.CHARACTERS.GENERIC.ANNOUNCE_EAT['GENERIC'] = ""
    GLOBAL.STRINGS.CHARACTERS.GENERIC.ACTIONFAIL['COOK']['GENERIC'] = ""
    local name = string.upper(inst.prefab)
    if GLOBAL.STRINGS.CHARACTERS[name] then
		if GLOBAL.STRINGS.CHARACTERS[name].ANNOUNCE_EAT and GLOBAL.STRINGS.CHARACTERS[name].ANNOUNCE_EAT['GENERIC'] then 
			GLOBAL.STRINGS.CHARACTERS[name].ANNOUNCE_EAT['GENERIC'] = ""
		end
		if GLOBAL.STRINGS.CHARACTERS[name].ACTIONFAIL and GLOBAL.STRINGS.CHARACTERS[name].ACTIONFAIL['COOK'] and GLOBAL.STRINGS.CHARACTERS[name].ACTIONFAIL['COOK']['GENERIC'] then
			GLOBAL.STRINGS.CHARACTERS[name].ACTIONFAIL['COOK']['GENERIC'] = ""
		end
        GLOBAL.STRINGS.CHARACTERS[name].DESCRIBE.PERKPORTABLEBLENDER = GLOBAL.STRINGS.CHARACTERS[name].DESCRIBE.PORTABLEBLENDER_ITEM
        GLOBAL.STRINGS.CHARACTERS[name].DESCRIBE.PERKPORTABLESPICER = GLOBAL.STRINGS.CHARACTERS[name].DESCRIBE.PORTABLESPICER_ITEM
        GLOBAL.STRINGS.CHARACTERS[name].DESCRIBE.PERKPORTABLECOOKPOT = GLOBAL.STRINGS.CHARACTERS[name].DESCRIBE.PORTABLECOOKPOT_ITEM
        GLOBAL.STRINGS.CHARACTERS[name].DESCRIBE.ACHIVBOOK_BIRDS = GLOBAL.STRINGS.CHARACTERS[name].DESCRIBE.BOOK_BIRDS
        GLOBAL.STRINGS.CHARACTERS[name].DESCRIBE.ACHIVBOOK_GARDENING = GLOBAL.STRINGS.CHARACTERS[name].DESCRIBE.BOOK_GARDENING
        GLOBAL.STRINGS.CHARACTERS[name].DESCRIBE.ACHIVBOOK_SLEEP = GLOBAL.STRINGS.CHARACTERS[name].DESCRIBE.BOOK_SLEEP
        GLOBAL.STRINGS.CHARACTERS[name].DESCRIBE.ACHIVBOOK_BRIMSTONE = GLOBAL.STRINGS.CHARACTERS[name].DESCRIBE.BOOK_BRIMSTONE
        GLOBAL.STRINGS.CHARACTERS[name].DESCRIBE.ACHIVBOOK_TENTACLES = GLOBAL.STRINGS.CHARACTERS[name].DESCRIBE.BOOK_TENTACLES
    end
end)

AddComponentPostInit("crop", function(self)
local _Harvest = self.Harvest
	self.Harvest = function(self, harvester)
		local pos = self.inst:GetPosition()
		local ret, product = _Harvest(self, harvester)
		--print(harvester.components.allachivcoin.pickmaster)
		if ret and product and harvester and pos and harvester.components.allachivcoin and harvester.components.allachivcoin.pickmaster then
			local wetness = GLOBAL.TheWorld.state.wetness
			local iswet = GLOBAL.TheWorld.state.iswet
			local item = GLOBAL.SpawnPrefab(product.prefab)
			item.components.inventoryitem:InheritMoisture(wetness, iswet)
			harvester.components.inventory:GiveItem(item, nil, pos)
		end
		return ret, product
	end
end)

local function onwakeup(self)
	if self and self.components.sleepingbag then
		local onwake_old = self.components.sleepingbag.onwake
		self.components.sleepingbag.onwake = function(self, sleeper, nostatechange)                   
			sleeper:PushEvent("wakeup", self.prefab)      
			onwake_old(self, sleeper, nostatechange)                                                       
		end
	end
end
AddPrefabPostInit("siestahut", onwakeup)
AddPrefabPostInit("tent", onwakeup)

function GLOBAL.getFoodList(player)
    if player == nil then
        player = GLOBAL.ThePlayer
    end
    local eatlist = player.components.allachivevent.eatlist
    for k,v in pairs(eatlist) do
        print(k, v)
    end
end

local function NewQuickAction(inst, action)
	if action.target ~= nil and action.target.prefab == "berrybush_juicy" then return "dojostleaction" end
    local quick = false
    if inst and inst:HasTag("fastpick") then
        quick = true
    end 
        if quick then
            return "doshortaction"
        elseif action.target and action.target.components.pickable then
            if action.target.components.pickable.quickpick then
                return "doshortaction"
            else
                return "dolongaction"
            end
        else 
            return "dolongaction"
        end
end

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.PICK, NewQuickAction))
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.TAKEITEM, NewQuickAction))
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.HARVEST, NewQuickAction))
GLOBAL.package.loaded["stategraphs/SGwilson"] = nil 

-- ##################
-- example usage of saving and loading data from other mods when worldjumping/after worldjumping with teleportato
-- ##################
if GLOBAL.TUNING.TELEPORTATOMOD then
	print("##### achievement and level system with teleportato mod loaded #####")
	local functionsavewithteleportato = GLOBAL.TUNING.TELEPORTATOMOD.functionsavewithteleportato
	GLOBAL.TUNING.TELEPORTATOMOD.functionsavewithteleportato = function(player) -- called for server
		local mods_data = {}
		if functionsavewithteleportato~=nil then -- call a previous funtion from another mod, if there is one
			mods_data = functionsavewithteleportato(player)
		end
		mods_data["achievementsMod"] = player.components.allachivcoin:OnSave() -- you can use onsave, or use other values from your mod, to save them
		mods_data["levelMod"] = player.components.levelsystem:OnSave() -- you can use onsave, or use other values from your mod, to save them
		mods_data["achievementEvents"] = player.components.allachivevent:OnSave() -- you can use onsave, or use other values from your mod, to save them
		return mods_data
	end

	AddPlayerPostInit(function(player)
		player:ListenForEvent("teleportatojumpLoadData", function(player,mods_data) -- load the mods_data
			if mods_data~=nil and mods_data["achievementsMod"]~=nil and mods_data["levelMod"]~=nil and mods_data["achievementEvents"]~=nil then -- you can add a modsetting if sth should be loaded or not
				_G.CAVES_CONFIG = GetModConfigData('CAVES')
				_G.MULT_CONFIG = GetModConfigData('MULT')
				_G.REFUND_CONFIG = GetModConfigData('REFUND')
				_G.SYSTEM_CONFIG = GetModConfigData('SYSTEM')
				_G.HIDEPERK_CONFIG = GetModConfigData('HIDEPERK')
				_G.STARTGEAR_CONFIG = GetModConfigData('GEAR')
				_G.COSTRAISE_CONFIG = GetModConfigData('COSTRAISE')
				_G.PLAYS_CONFIG = GetModConfigData('PLAYS')
				_G.HEALTHPENALTY = GetModConfigData('HEALTHPENALTY')
				_G.GAMEBREAKER = GetModConfigData('GAMEBREAKER')
				_G.EXPMULT = GetModConfigData('EXPMULT')
				_G.SECONDRUN = GetModConfigData('SECOND')	
				_G.LANGUAGE = GetModConfigData('LANGUAGE')
				if _G.LANGUAGE == "kr" then
					require 'AllAchiv/strings_acm_kr'
				elseif _G.LANGUAGE == "ptbr" then
					require 'AllAchiv/strings_acm_ptbr'
				elseif _G.LANGUAGE == "es" then
					require 'AllAchiv/strings_acm_es'
				elseif _G.LANGUAGE == "it" then
					require 'AllAchiv/strings_acm_it'
				elseif _G.LANGUAGE == "chs" then
					require 'AllAchiv/strings_acm_chs'
				elseif _G.LANGUAGE == "cht" then
					require 'AllAchiv/strings_acm_cht'
				elseif _G.LANGUAGE == "ru" then
					require 'AllAchiv/strings_acm_ru'
				elseif _G.LANGUAGE == "de" then
					require 'AllAchiv/strings_acm_de'
				elseif _G.LANGUAGE == "vi" then
					require 'AllAchiv/strings_acm_vi'
				else
					require 'AllAchiv/strings_acm_e'
				end
				local MANRESPAWN = GetModConfigData('MANDRAKEBOI')
				if MANRESPAWN then
					if GLOBAL.STRINGS.NAMES.MIGRATION_PORTAL then
						AddPrefabPostInit("forest", function(inst)
							if inst.ismastersim then
								inst:AddComponent("minspawner")
							end
						end)
					else
						AddPrefabPostInit("world", function(inst)
							if inst.ismastersim then
								inst:AddComponent("minspawner")
							end
						end)
					end
				end
				player.components.allachivcoin:OnLoad(mods_data["achievementsMod"])
				player.components.levelsystem:OnLoad(mods_data["levelMod"])
				player.components.allachivevent:OnLoad(mods_data["achievementEvents"])
			end
		end)
	end)
end
-- ##################
-- ##################