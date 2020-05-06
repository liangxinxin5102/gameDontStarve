PrefabFiles = {
	"esctemplate",  --人物代码文件
	"esctemplate_none",  --人物皮肤
}
---对比老版本 主要是增加了names图片 人物检查图标 还有人物的手臂修复（增加了上臂）
--人物动画里面有个SWAP_ICON 里面的图片是在检查时候人物头像那里显示用的


----2019.05.08 修复了 人物大图显示错误和检查图标显示错误

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/esctemplate.tex" ), --存档图片
    Asset( "ATLAS", "images/saveslot_portraits/esctemplate.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/esctemplate.tex" ), --单机选人界面
    Asset( "ATLAS", "images/selectscreen_portraits/esctemplate.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/esctemplate_silho.tex" ), --单机未解锁界面
    Asset( "ATLAS", "images/selectscreen_portraits/esctemplate_silho.xml" ),

    Asset( "IMAGE", "bigportraits/esctemplate.tex" ), --人物大图（方形的那个）
    Asset( "ATLAS", "bigportraits/esctemplate.xml" ),
	
	Asset( "IMAGE", "images/map_icons/esctemplate.tex" ), --小地图
	Asset( "ATLAS", "images/map_icons/esctemplate.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_esctemplate.tex" ), --tab键人物列表显示的头像
    Asset( "ATLAS", "images/avatars/avatar_esctemplate.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_esctemplate.tex" ),--tab键人物列表显示的头像（死亡）
    Asset( "ATLAS", "images/avatars/avatar_ghost_esctemplate.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_esctemplate.tex" ), --人物检查按钮的图片
    Asset( "ATLAS", "images/avatars/self_inspect_esctemplate.xml" ),
	
	Asset( "IMAGE", "images/names_esctemplate.tex" ),  --人物名字
    Asset( "ATLAS", "images/names_esctemplate.xml" ),
	
    Asset( "IMAGE", "bigportraits/esctemplate_none.tex" ),  --人物大图（椭圆的那个）
    Asset( "ATLAS", "bigportraits/esctemplate_none.xml" ),

--[[---注意事项
1、目前官方自从熔炉之后人物的界面显示用的都是那个椭圆的图
2、官方人物目前的图片跟名字是分开的 
3、names_esctemplate 和 esctemplate_none 这两个文件需要特别注意！！！
这两文件每一次重新转换之后！需要到对应的xml里面改对应的名字 否则游戏里面无法显示
具体为：
降names_esctemplatxml 里面的 Element name="esctemplate.tex" （也就是去掉names——）
将esctemplate_none.xml 里面的 Element name="esctemplate_none_oval" 也就是后面要加  _oval
（注意看修改的名字！不是两个都需要修改）
	]]
}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

GLOBAL.PREFAB_SKINS["esctemplate"] = {   --修复人物大图显示
	"esctemplate_none",
}

-- The character select screen lines  --人物选人界面的描述
STRINGS.CHARACTER_TITLES.esctemplate = "The Sample Character"
STRINGS.CHARACTER_NAMES.esctemplate = "Esc"
STRINGS.CHARACTER_DESCRIPTIONS.esctemplate = "*Perk 1\n*Perk 2\n*Perk 3"
STRINGS.CHARACTER_QUOTES.esctemplate = "\"Quote\""

-- Custom speech strings  ----人物语言文件  可以进去自定义
STRINGS.CHARACTERS.ESCTEMPLATE = require "speech_esctemplate"

-- The character's name as appears in-game  --人物在游戏里面的名字
STRINGS.NAMES.ESCTEMPLATE = "Esc"
STRINGS.SKIN_NAMES.esctemplate_none = "Esc"  --检查界面显示的名字

AddMinimapAtlas("images/map_icons/esctemplate.xml")  --增加小地图图标

--增加人物到mod人物列表的里面 性别为女性（MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL）
AddModCharacter("esctemplate", "FEMALE") 

