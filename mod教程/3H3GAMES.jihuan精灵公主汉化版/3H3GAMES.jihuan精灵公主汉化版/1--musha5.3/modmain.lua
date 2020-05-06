modimport ("scripts/tuning_musha.lua")
modimport ("scripts/musha_play.lua")

local require = GLOBAL.require
local SpawnPrefab = GLOBAL.SpawnPrefab

local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local ACTIONS = GLOBAL.ACTIONS
TECH = GLOBAL.TECH

PrefabFiles = {
	"musha",
          "musha_small",
          "musha_egg",
          "musha_egg1",
          "musha_egg2",
          "musha_egg3",
          "frosthammer",
          "broken_frosthammer",
          "hat_mbunny",
          "hat_mcrown",
          "hat_mprincess",
          "ghosthound",
          "armor_mushaa",
          "armor_mushab",
	"books",
	"shock_fx2",
	"glowdust",
	"mushasword",
	"musha_flute",

}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/musha.tex" ),
    Asset( "IMAGE", "images/selectscreen_portraits/musha.tex" ),
    Asset( "IMAGE", "images/selectscreen_portraits/musha_silho.tex" ),
    Asset( "IMAGE", "bigportraits/musha.tex" ),
	Asset("IMAGE", "images/musha.tex"),
        Asset( "ANIM", "anim/musha_battle.zip"),
        Asset( "ANIM", "anim/musha.zip"),
    Asset( "ANIM", "anim/musha_hunger.zip"),

    Asset("ANIM", "anim/musha_egg.zip"),
    Asset("ANIM", "anim/musha_egg1.zip"),
    Asset("ANIM", "anim/musha_egg2.zip"),
    Asset("ANIM", "anim/musha_egg3.zip"),
    Asset("ANIM", "anim/musha_small.zip"),
    Asset("ANIM", "anim/musha_teen.zip"),
    Asset("ANIM", "anim/musha_tall.zip"),
    Asset("ANIM", "anim/musha_tall2.zip"),
    Asset("ANIM", "anim/musha_tall3.zip"),
    Asset("ANIM", "anim/musha_tall4.zip"),
    Asset("ANIM", "anim/musha_tall5.zip"),
    Asset("ANIM", "anim/frosthammer.zip"),
    Asset("ANIM", "anim/swap_frosthammer.zip"),
    Asset("ANIM", "anim/broken_frosthammer.zip"),
    Asset("ANIM", "anim/hat_mbunny.zip"),
    Asset("ANIM", "anim/hat_mcrown.zip"),
    Asset("ANIM", "anim/hat_mprincess.zip"),
    Asset("ANIM", "anim/ghosthound.zip"),
    Asset("ANIM", "anim/armor_mushaa.zip"),
    Asset("ANIM", "anim/armor_mushab.zip"),
    Asset("ANIM", "anim/ui_chest_yamche0.zip"),
    Asset("ANIM", "anim/ui_chest_yamche1.zip"),
    Asset("ANIM", "anim/ui_chest_yamche2.zip"),
    Asset("ANIM", "anim/hat_yamche.zip"),
    Asset("ANIM", "anim/ui_chest_frosthammer.zip"),
    Asset("ANIM", "anim/shock_fx2.zip"),
    Asset("ANIM", "anim/glowdust.zip"),
    Asset("ANIM", "anim/mushasword.zip"),
    Asset("ANIM", "anim/swap_mushasword.zip"),
    Asset("ANIM", "anim/musha_flute.zip"),

	Asset("IMAGE", "images/inventoryimages/musha_egg.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_egg1.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_egg2.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_egg3.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_egg_cracked.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_egg_cooked.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_small.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_teen.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_tall.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_tall2.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_tall3.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_tall4.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_tall5.tex"),
	Asset("IMAGE", "images/inventoryimages/frosthammer.tex"),
	Asset("IMAGE", "images/inventoryimages/broken_frosthammer.tex"),
	Asset("IMAGE", "images/inventoryimages/hat_mbunny.tex"),
	Asset("IMAGE", "images/inventoryimages/hat_mcrown.tex"),
	Asset("IMAGE", "images/inventoryimages/hat_mprincess.tex"),
	Asset("IMAGE", "images/inventoryimages/armor_mushaa.tex"),
	Asset("IMAGE", "images/inventoryimages/armor_mushab.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_flute.tex"),
	
	Asset("ATLAS", "images/musha.xml"),
	Asset( "ATLAS", "images/saveslot_portraits/musha.xml" ),
    Asset( "ATLAS", "images/selectscreen_portraits/musha.xml" ),
    Asset( "ATLAS", "images/selectscreen_portraits/musha_silho.xml" ),
    Asset( "ATLAS", "bigportraits/musha.xml" ),
	Asset("ATLAS", "images/inventoryimages/frosthammer.xml"),
	Asset("ATLAS", "images/inventoryimages/broken_frosthammer.xml"),
	Asset("ATLAS", "images/inventoryimages/hat_mbunny.xml"),
	Asset("ATLAS", "images/inventoryimages/hat_mcrown.xml"),
	Asset("ATLAS", "images/inventoryimages/hat_mprincess.xml"),
	Asset("ATLAS", "images/inventoryimages/armor_mushaa.xml"),
	Asset("ATLAS", "images/inventoryimages/armor_mushab.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_flute.xml"),

	Asset("ATLAS", "images/inventoryimages/musha_egg.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_egg1.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_egg2.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_egg3.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_egg_cracked.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_egg_cracked1.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_egg_cracked2.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_egg_cracked3.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_egg_cooked.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_small.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_teen.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_tall.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_tall2.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_tall3.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_tall4.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_tall5.xml"),

}

function mushaPostInit(musha)

--matarial

local broken_frosthammer = Ingredient( "broken_frosthammer", 1)
broken_frosthammer.atlas = "images/inventoryimages/broken_frosthammer.xml"

local musha_egg = Ingredient( "musha_egg", 1)
musha_egg.atlas = "images/inventoryimages/musha_egg.xml"

local glowdust= Ingredient( "glowdust", 1)
glowdust.atlas = "images/inventoryimages/glowdust.xml"

local bushhat = Ingredient( "bushhat", 1)
local ruinshat= Ingredient( "ruinshat", 1)
local armorruins= Ingredient( "armorruins", 1)
local amulet= Ingredient( "amulet", 1)
local princess= Ingredient( "hat_mprincess", 1)
princess.atlas = "images/inventoryimages/hat_mprincess.xml"

--horn

 local musha_flute = GLOBAL.Recipe( "musha_flute", {glowdust, Ingredient("horn", 1), Ingredient("honey", 12), Ingredient("spidergland", 20)},  RECIPETABS.REFINE, {SCIENCE=0})
	musha_flute.atlas = "images/inventoryimages/musha_flute.xml"

--weapon

 local mushasword= GLOBAL.Recipe( "mushasword", {  Ingredient("goldnugget", 7), Ingredient("gunpowder", 4), Ingredient("feather_robin", 4) }, RECIPETABS.REFINE, {SCIENCE=0})
mushasword.atlas = "images/inventoryimages/mushasword.xml"

 local frosthammer = GLOBAL.Recipe( "frosthammer", { broken_frosthammer, Ingredient("livinglog", 2), Ingredient("purplegem", 2), Ingredient("bluegem", 6) }, RECIPETABS.REFINE, {SCIENCE=0})
frosthammer.atlas = "images/inventoryimages/frosthammer.xml"


--egg

 local musha_egg1 = GLOBAL.Recipe( "musha_egg1", {musha_egg, Ingredient("redgem", 2), Ingredient("purplegem", 1), Ingredient("beardhair", 3)},  RECIPETABS.REFINE, {SCIENCE=0})
	musha_egg1.atlas = "images/inventoryimages/musha_egg1.xml"
 local musha_egg2 = GLOBAL.Recipe( "musha_egg2", { musha_egg, Ingredient("redgem", 4), Ingredient("purplegem", 2), Ingredient("beardhair", 6) },  RECIPETABS.REFINE, {SCIENCE=0})
	musha_egg2.atlas = "images/inventoryimages/musha_egg2.xml"
 local musha_egg3 = GLOBAL.Recipe( "musha_egg3", { musha_egg, Ingredient("redgem", 6), Ingredient("purplegem", 3), Ingredient("beardhair", 9) },  RECIPETABS.REFINE, {SCIENCE=0})
	musha_egg3.atlas = "images/inventoryimages/musha_egg3.xml"

 local musha_egg = GLOBAL.Recipe( "musha_egg", { glowdust, Ingredient("redgem", 8), Ingredient("purplegem", 4), Ingredient("beardhair", 12) },  RECIPETABS.REFINE, {SCIENCE=0})
	musha_egg.atlas = "images/inventoryimages/musha_egg.xml"

--hat

 local hat_mbunny = GLOBAL.Recipe( "hat_mbunny", {bushhat, Ingredient("dug_grass", 8), Ingredient("manrabbit_tail", 2), Ingredient("purplegem", 2)  }, RECIPETABS.DRESS, {SCIENCE=0})
	hat_mbunny.atlas = "images/inventoryimages/hat_mbunny.xml"
 local hat_mprincess = GLOBAL.Recipe( "hat_mprincess", {amulet, Ingredient("goldnugget", 8), Ingredient("purplegem", 3) },  RECIPETABS.DRESS, {SCIENCE=0})
	hat_mprincess.atlas = "images/inventoryimages/hat_mprincess.xml"
 local hat_mcrown = GLOBAL.Recipe( "hat_mcrown", {princess, Ingredient("houndstooth", 15),Ingredient("thulecite", 15), Ingredient("orangegem", 1) }, RECIPETABS.DRESS, {SCIENCE=0})
	hat_mcrown.atlas = "images/inventoryimages/hat_mcrown.xml"

--armor

 local armor_mushaa = GLOBAL.Recipe( "armor_mushaa", {amulet, Ingredient("goldnugget", 15), Ingredient("thulecite", 10) }, RECIPETABS.DRESS, {SCIENCE=0})
	armor_mushaa.atlas = "images/inventoryimages/armor_mushaa.xml"

 local armor_mushab = GLOBAL.Recipe( "armor_mushab", {Ingredient("trunk_summer", 2),  Ingredient("greengem", 2), Ingredient("orangegem", 2), Ingredient("purplegem", 15)}, RECIPETABS.DRESS, {SCIENCE=0})
	armor_mushab.atlas = "images/inventoryimages/armor_mushab.xml"

--dust

 local glowdust = GLOBAL.Recipe( "glowdust", {Ingredient("lightbulb", 3), Ingredient("wormlight", 1), Ingredient("houndstooth", 1), Ingredient("berries", 6) }, RECIPETABS.REFINE, {SCIENCE=0})
	glowdust.atlas = "images/inventoryimages/glowdust.xml"

end

AddSimPostInit(function(inst)
        if inst.prefab == "musha" then
                mushaPostInit(inst)
        end
end)

GetPlayer = GLOBAL.GetPlayer

table.insert(GLOBAL.CHARACTER_GENDERS.FEMALE, "musha")

local STRINGS = GLOBAL.STRINGS

-----------------------------
GLOBAL.STRINGS.CHARACTER_TITLES.musha = "musha"
GLOBAL.STRINGS.CHARACTER_NAMES.musha = "musha"
GLOBAL.STRINGS.CHARACTER_DESCRIPTIONS.musha = "musha"
GLOBAL.STRINGS.CHARACTER_QUOTES.musha = "\"A full belly is the mother of all happiness.\""
STRINGS.NAMES.MUSHA_SMALL = "Baby Yamche"
STRINGS.NAMES.MUSHA_TEEN = "Yamche"
STRINGS.NAMES.MUSHA_TALL = "Yamche"
STRINGS.NAMES.MUSHA_TALL2 = "Yamche"
STRINGS.NAMES.MUSHA_TALL3 = "Yamche"
STRINGS.NAMES.MUSHA_TALL4 = "Yamche"
STRINGS.NAMES.MUSHA_TALL5 = "Huge Yamche"
STRINGS.NAMES.MUSHA_EGG = "凤 凰 蛋"
STRINGS.NAMES.MUSHA_EGG_CRACKED = "Phoenix Egg"
STRINGS.NAMES.MUSHA_EGG1 = "凤 凰 蛋(5 level)"
STRINGS.NAMES.MUSHA_EGG_CRACKED1 = "Phoenix Egg"
STRINGS.NAMES.MUSHA_EGG2 = "凤 凰 蛋(6 level)"
STRINGS.NAMES.MUSHA_EGG_CRACKED2 = "Phoenix Egg"
STRINGS.NAMES.MUSHA_EGG3 = "凤 凰 蛋(7 level)"
STRINGS.NAMES.MUSHA_EGG_CRACKED3 = "Phoenix Egg"
STRINGS.NAMES.MUSHA_FLUTE= "musha的 号 角"

STRINGS.NAMES.GHOSTHOUND = "幽 灵 猎 犬"
STRINGS.NAMES.FROSTHAMMER = "冰 锤"
STRINGS.NAMES.BROKEN_FROSTHAMMER = "冰 之 心"

STRINGS.RECIPE_DESC.MUSHA_EGG = "制 作 凤 凰 蛋"
STRINGS.RECIPE_DESC.MUSHA_EGG1 = "5 级 的 蛋."
STRINGS.RECIPE_DESC.MUSHA_EGG2 = "6 级 的 蛋."
STRINGS.RECIPE_DESC.MUSHA_EGG3 = "7 级 的 蛋."
STRINGS.NAMES.MUSHASWORD = "凤 凰 剑"
STRINGS.RECIPE_DESC.MUSHASWORD = "火 焰 攻 击 (40%)"
STRINGS.RECIPE_DESC.MUSHA_FLUTE = "愈 合 的 旋 律"

STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHASWORD = "如 凤 凰 一 般 强 大 的 武 器 !"

STRINGS.NAMES.GLOWDUST = "发 光 的 尘 埃"
STRINGS.RECIPE_DESC.GLOWDUST = "吃 得 试 试"

STRINGS.RECIPE_DESC.FROSTHAMMER = "制 作 冰 锤."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FROSTHAMMER = "这 是 我 的 王 室 武 器"
STRINGS.RECIPE_DESC.BROKEN_FROSTHAMMER = "分 解 冰 锤"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BROKEN_FROSTHAMMER = "太 冷 了!"
STRINGS.NAMES.HAT_MPRINCESS = "公 主 的 皇 冠"
STRINGS.RECIPE_DESC.HAT_MPRINCESS = "它 可 以 使 你 成 为 真 正 的 公 主!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HAT_MPRINCESS = "我 是 公 主!"
STRINGS.NAMES.HAT_MCROWN = "女 王 的 皇 冠"
STRINGS.RECIPE_DESC.HAT_MCROWN = "这 是 高 贵 的 皇 冠."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HAT_MCROWN = "我 是 女 王!!"
STRINGS.NAMES.HAT_MBUNNY = "兔 子 侦 查 帽"
STRINGS.RECIPE_DESC.HAT_MBUNNY = "加 速, 保 暖, 隐 蔽"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HAT_MBUNNY = "完 美 的 侦 查"
STRINGS.NAMES.ARMOR_MUSHAA = "Musha 的 盔 甲"
STRINGS.RECIPE_DESC.ARMOR_MUSHAA = "复 活, 吸 收 70% 的 伤 害"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARMOR_MUSHAA = "这 是 非 常 坚 固 的 盔 甲"
STRINGS.NAMES.ARMOR_MUSHAB = "公 主 的 盔 甲"
STRINGS.RECIPE_DESC.ARMOR_MUSHAB = "这 是 非 常 完 美 的."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARMOR_MUSHAB = "完 全 符 合 我 的 风 格" 
------------------------------
ACTIONS.STAYORDER = GLOBAL.Action(2, true, true)
ACTIONS.STAYORDER.fn = function(act)

local targ = act.target
	if targ and targ.components.staycommand then
		act.doer.components.locomotor:Stop()
		act.doer.components.talker:Say(GLOBAL.GetString(act.doer.prefab, "ANNOUNCE_STAYORDER"))
		targ.components.staycommand:SetStaying(true)
		targ.components.staycommand:RememberStayPos("stayspot", GLOBAL.Point(targ.Transform:GetWorldPosition())) 
	return true
	end
end
ACTIONS.STAYORDER.str = STRINGS.ACTIONS.STAYORDER
ACTIONS.STAYORDER.id = "STAYORDER"
ACTIONS.STAYORDER_CANCEL = GLOBAL.Action(2, true, true)
ACTIONS.STAYORDER_CANCEL.fn = function(act)
	local targ = act.target
	if targ and targ.components.staycommand then
	act.doer.components.locomotor:Stop()
		act.doer.components.talker:Say(GLOBAL.GetString(act.doer.prefab, "ANNOUNCE_STAYORDER_CANCEL"))
		targ.components.staycommand:SetStaying(false)
		return true
	end
end
ACTIONS.STAYORDER_CANCEL.str = STRINGS.ACTIONS.STAYORDER_CANCEL
ACTIONS.STAYORDER_CANCEL.id = "STAYORDER_CANCEL"

STRINGS.ACTIONS.STAYORDER = "呆 在 这"
STRINGS.ACTIONS.STAYORDER_CANCEL = "跟 我 来"
STRINGS.CHARACTERS.GENERIC.ANNOUNCE_STAYORDER = "呆 在 这."
STRINGS.CHARACTERS.GENERIC.ANNOUNCE_STAYORDER_CANCEL = "跟 我 来."


------working DIALOGUE---
STRINGS.CHARACTERS.MUSHA =require "speech_musha"
--STRINGS.CHARACTERS.MUSHA =require "speech_willow"

function stone(inst)
        inst:AddTag("tstone")
end
AddPrefabPostInit("heatrock", stone)

function arms(inst)
        inst:AddTag("arm")
end
AddPrefabPostInit("tentacle_pillar_arm", arms)

------------
AddMinimapAtlas("images/musha.xml")
AddMinimapAtlas("images/inventoryimages/musha_egg.xml")
AddMinimapAtlas("images/inventoryimages/musha_egg_cracked.xml")
AddMinimapAtlas("images/inventoryimages/musha_egg1.xml")
AddMinimapAtlas("images/inventoryimages/musha_egg_cracked1.xml")
AddMinimapAtlas("images/inventoryimages/musha_egg2.xml")
AddMinimapAtlas("images/inventoryimages/musha_egg_cracked2.xml")
AddMinimapAtlas("images/inventoryimages/musha_egg3.xml")
AddMinimapAtlas("images/inventoryimages/musha_egg_cracked3.xml")
AddMinimapAtlas("images/inventoryimages/musha_small.xml")
AddMinimapAtlas("images/inventoryimages/musha_teen.xml")
AddMinimapAtlas("images/inventoryimages/musha_tall.xml")
AddMinimapAtlas("images/inventoryimages/frosthammer.xml")
AddMinimapAtlas("images/inventoryimages/broken_frosthammer.xml")

AddModCharacter("musha")

local function Monsterfood(inst)
	local fooditem = inst.prefab
if tostring(fooditem)=="monsterlasagna" then
inst.components.edible.sanityvalue=inst.components.edible.sanityvalue * -1	
inst.components.edible.healthvalue=inst.components.edible.healthvalue * -1
	elseif tostring(fooditem)=="monstermeat_dried" then
inst.components.edible.sanityvalue=inst.components.edible.sanityvalue * -.5	
inst.components.edible.healthvalue=inst.components.edible.healthvalue * -.4	
	elseif tostring(fooditem)=="cookedmonstermeat" then
inst.components.edible.sanityvalue=inst.components.edible.sanityvalue * -.1
inst.components.edible.healthvalue=inst.components.edible.healthvalue * -.6	
	else 
	end
end

for k, fooditem in pairs(TUNING.MUSHA_FOODS) do
    AddPrefabPostInit(fooditem, Monsterfood)
end






