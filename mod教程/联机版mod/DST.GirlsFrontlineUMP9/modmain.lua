PrefabFiles = {
	"nine",
	"nine_none",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/nine.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/nine.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/nine.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/nine.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/nine_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/nine_silho.xml" ),

    Asset( "IMAGE", "bigportraits/nine.tex" ),
    Asset( "ATLAS", "bigportraits/nine.xml" ),
	
	Asset( "IMAGE", "images/map_icons/nine.tex" ),
	Asset( "ATLAS", "images/map_icons/nine.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_nine.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_nine.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_nine.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_nine.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_nine.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_nine.xml" ),
	
	Asset( "IMAGE", "images/names_nine.tex" ),
    Asset( "ATLAS", "images/names_nine.xml" ),
	
    Asset( "IMAGE", "bigportraits/nine_none.tex" ),
    Asset( "ATLAS", "bigportraits/nine_none.xml" ),

}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

GLOBAL.TUNING.NINE = {}
if GetModConfigData("Priority Redirection") == "Off" then
	GLOBAL.TUNING.NINE.PRIORITY_REDIRECTION = false
else
	GLOBAL.TUNING.NINE.PRIORITY_REDIRECTION = true
end

-- The character select screen lines
STRINGS.CHARACTER_TITLES.nine = "The Cheerful Assassin"
STRINGS.CHARACTER_NAMES.nine = "Nine"
STRINGS.CHARACTER_DESCRIPTIONS.nine = "*Positive Energy\n*Friendly Girl\n*Night Stalker"
STRINGS.CHARACTER_QUOTES.nine = "\"Let's have fun!\""

-- Custom speech strings
STRINGS.CHARACTERS.NINE = require "speech_nine"

-- The character's name as appears in-game 
STRINGS.NAMES.NINE = "Nine"

AddMinimapAtlas("images/map_icons/nine.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("nine", "FEMALE")

