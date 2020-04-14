PrefabFiles = {
	"storeroom",
}

Assets = 
{
	Asset("ATLAS", "minimap/storeroom.xml" ),
	Asset("ATLAS", "images/inventoryimages/storeroom.xml"),
}

AddMinimapAtlas("minimap/storeroom.xml")

STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
_G = GLOBAL

_G.destroyable = GetModConfigData("Destroyable")=="yees"
_G.TUNING.PERISH_ICESTOREROOM_MULT = GetModConfigData("FoodSpoilage")

local mod_slots = GetModConfigData("Slots")
local mod_craft = GetModConfigData("Craft")
local mod_lang = GetModConfigData("Language")
local mod_debug = false

local function updaterecipe(slots)
	if mod_craft=="Easy" then

		cutstone_value = math.floor(slots / 7)
		boards_value = math.floor(slots / 7)
		marble_value = math.floor(slots / 20)

	elseif mod_craft=="Hard" then

		cutstone_value = math.floor(slots / 2.6)
		boards_value = math.floor(slots / 2.6)
		marble_value = math.floor(slots / 10)

	else

		cutstone_value = math.floor(slots / 4)
		boards_value = math.floor(slots / 4)
		marble_value = math.floor(slots / 20)
	end
end
updaterecipe(mod_slots)

------------------------------------------------------
----------------------- RECIPE -----------------------
------------------------------------------------------
cupboard = AddRecipe("storeroom",{ Ingredient("cutstone", cutstone_value), Ingredient("marble", marble_value), Ingredient("boards", boards_value) }, RECIPETABS.TOWN, TECH.SCIENCE_TWO, "storeroom_placer" )
cupboard.atlas = "images/inventoryimages/storeroom.xml"

------------------------------------------------------
----------------------- WIDGET -----------------------
------------------------------------------------------

---------------------- function ----------------------
local function widgetcreation(widgetanimbank, widgetpos, slot_x, slot_y, posslot_x, posslot_y)
	local params={}
	params.storeroom =
	{
		widget =
		{
			slotpos = {},
			animbank = widgetanimbank,
			animbuild = widgetanimbank,
			pos = widgetpos,
			side_align_tip = 160,
		},
	type = "chest",
	}

	for y = slot_y, 0, -1 do
		for x = 0, slot_x do
			table.insert(params.storeroom.widget.slotpos, _G.Vector3(80*x-346*2+posslot_x, 80*y-100*2+posslot_y,0))
		end
	end

	local containers = _G.require "containers"
	containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, params.storeroom.widget.slotpos ~= nil and #params.storeroom.widget.slotpos or 0)

	local old_widgetsetup = containers.widgetsetup
	function containers.widgetsetup(container, prefab, data)
		local pref = prefab or container.inst.prefab
		if pref == "storeroom" then
			local t = params[pref]
			if t ~= nil then
				for k, v in pairs(t) do
					container[k] = v
				end
			container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
			end
		else
			return old_widgetsetup(container, prefab)
		end
	end
end

---------------------- position ----------------------
if GetModConfigData("Position")==("Left") then
	widgetpos = _G.Vector3(-210,230,0)
elseif GetModConfigData("Position")==("Center") then
	widgetpos = _G.Vector3(0,190,0)
end

----------------- formation function -----------------
if mod_slots==20 then
	widgetanimbank = "ui_chest_4x5"
	slot_x = 4
	slot_y = 3
	posslot_x = 90
	posslot_y = 130
elseif mod_slots==40 then
	widgetanimbank = "ui_chest_5x8"
	slot_x = 7
	slot_y = 4
	posslot_x = 109
	posslot_y = 42
elseif mod_slots==60 then
	widgetanimbank = "ui_chest_5x12"
	slot_x = 11
	slot_y = 4
	posslot_x = 98
	posslot_y = 42
else
	widgetanimbank = "ui_chest_5x16"
	slot_x = 15
	slot_y = 4
	posslot_x = 91
	posslot_y = 42
end
---------------------- call function ----------------------
widgetcreation(widgetanimbank, widgetpos, slot_x, slot_y, posslot_x, posslot_y)

---------------------------------------------------
-------------------- TRANSLATE --------------------
---------------------------------------------------

--------------------- Russian ---------------------
local RegisterRussianName = GLOBAL.rawget(GLOBAL,"RegisterRussianName")
if RegisterRussianName and mod_lang=="En" then
	RegisterRussianName("STOREROOM","Кладовая","she","Кладовой")
	STRINGS.RECIPE_DESC.STOREROOM = "Нужно больше места!" 
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.STOREROOM = "Мне очень нравится это большое хранилище!"

--------------------- French ----------------------
--translation by John2022
elseif mod_lang=="Fr" then
	STRINGS.NAMES.STOREROOM = "Debarras"
	STRINGS.RECIPE_DESC.STOREROOM = "Besoin de plus d'espace!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.STOREROOM = "J'apprecie beaucoup le gain de place!"

--------------------- German ----------------------
--translation by Ralkari 
elseif mod_lang=="Gr" then
	STRINGS.NAMES.STOREROOM = "Vorratskammer"
	STRINGS.RECIPE_DESC.STOREROOM = "Brauche mehr Platz!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.STOREROOM = "Ich mag die Vorratskammer!"

--------------------- Portuguese ----------------------
--translation by mauricioportella  
elseif mod_lang=="Pr" then
	STRINGS.NAMES.STOREROOM = "Porão"
	STRINGS.RECIPE_DESC.STOREROOM = "Preciso de mais espaço!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.STOREROOM = "Eu realmente gostaria de um bom porão!"

	--------------------- Swedish ----------------------
--translation by dLFN 
elseif mod_lang=="Sw" then
	STRINGS.NAMES.STOREROOM = "Förråd"
	STRINGS.RECIPE_DESC.STOREROOM = "Behöver mer utrymme!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.STOREROOM = "Jag gillar verkligen detta bra föråd!"

--------------------- Turkish ----------------------
--translation by DestORoyal
elseif mod_lang=="Tr" then
	STRINGS.NAMES.STOREROOM = "Depo"
	STRINGS.RECIPE_DESC.STOREROOM = "Daha fazla alan gerek!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.STOREROOM = "Bu depoyu gercekten begendim!"

--------------------- 中文 ----------------------
else
	STRINGS.NAMES.STOREROOM = "储藏室"
	STRINGS.RECIPE_DESC.STOREROOM = "更多的储存空间"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.STOREROOM = "我真的非常喜欢，这是一个巨大的储藏室！"
end

---------------------------------------------------
---------------------- DEBUG ----------------------
---------------------------------------------------
if mod_debug then
	print("slots_debug ",mod_slots)
	print("recipe_debug ",cutstone_value, marble_value, boards_value)
	print("widget_debug = ",widgetanimbank, widgetpos, slot_x, slot_y, posslot_x, posslot_y)
end
