--The name of the mod displayed in the 'mods' screen.
name = "快捷交流"

--A description of the mod.
description = "快捷告知队友自己的饥饿.理智.生命,(Alt+左键点击三围图标)\n告知队友接下来要制作哪种科技(Alt+左键点击科技树图标)\n告知队友自己的物资数量(Alt+Shift+左键点击物品栏材料)\n 如在使用中出现问题请及时反馈QQ506557256 更改."

--Who wrote this awesome mod?
author = "rezecib原作者 Anydong汉化"

--A version number so you can ask people if they are running an old version of your mod.
version = "2.2.1.h.0.2"

--This lets other players know if your mod is out of date. This typically needs to be updated every time there's a new game update.
api_version = 10

dst_compatible = true

--This lets clients know if they need to get the mod from the Steam Workshop to join the game
all_clients_require_mod = false

--This determines whether it causes a server to be marked as modded (and shows in the mod list)
client_only_mod = true

--This lets people search for servers with this mod by these tags
server_filter_tags = {}

icon_atlas = "statusannouncements.xml"
icon = "statusannouncements.tex"

forumthread = "http://forums.kleientertainment.com/files/file/923-dst-status-announcements"

--[[
Credits:
    Silentdarkness1 for coming up with most of the character-specific quotes,
	Acemurdock and OSMRhodey for helping out with the Woodie quotes,
	and SuperPsiPower (and friends) for helping out with the Webber quotes.
]]

configuration_options =
{
	{
		name = "WHISPER",
		label = "默认交流语言",
		options =	{
						{description = "是", data = true},
						{description = "否", data = false},
					},
		default = false,
	},
	{
		name = "EXPLICIT",
		label = "是否显示当前最大值",
		options =	{
						{description = "是", data = true},
						{description = "否", data = false},
					},
		default = true,
		hover = "在提示的数据中显示当前值和最大值",
	},
	{
		name = "SHOWPROTOTYPER",
		label = "是否需要提示科技",
		options =	{
						{description = "是", data = true},
						{description = "否", data = false},
					},
		default = true,
		hover = "在提示队友制作时，是否需要提示科技依靠",
	},
	{
		name = "SHOWDURABILITY",
		label = "耐久提示",
		options =	{
						{description = "是", data = true},
						{description = "否", data = false},
					},
		default = true,
		hover = "是否需要提示物品的耐久、耐用时间",
	},
	{
		name = "OVERRIDEB",
		label = "控制按钮开关",
		options =	{
						{description = "是", data = true},
						{description = "否", data = false},
					},
		default = true,
		hover = "默认开启按钮开关，可以 B/取消按钮 显示物品或者温度",
	},
	{
		name = "WILSON",
		label = "威尔逊专属喊话",
		options =	{
						{description = "是", data = true},
						{description = "否", data = false},
					},
		default = false,
	},
	{
		name = "WILLOW",
		label = "火女专属喊话",
		options =	{
						{description = "是", data = true},
						{description = "否", data = false},
					},
		default = false,
	},
	{
		name = "WX78",
		label = "机器人专属喊话",
		options =	{
						{description = "是", data = true},
						{description = "否", data = false},
					},
		default = false,
	},
	{
		name = "WICKERBOTTOM",
		label = "老奶奶专属喊话",
		options =	{
						{description = "是", data = true},
						{description = "否", data = false},
					},
		default = false,
	},
	{
		name = "WOLFGANG",
		label = "沃尔夫冈（大力士）专属喊话",
		options =	{
						{description = "是", data = true},
						{description = "否", data = false},
					},
		default = false,
	},
	{
		name = "WENDY",
		label = "温蒂专属喊话",
		options =	{
						{description = "是", data = true},
						{description = "否", data = false},
					},
		default = false,
	},
	{
		name = "WOODIE",
		label = "伐木工专属喊话",
		options =	{
						{description = "是", data = true},
						{description = "否", data = false},
					},
		default = false,
	},
	{
		name = "WES",
		label = "小丑专属喊话",
		options =	{
						{description = "是", data = true},
						{description = "否", data = false},
					},
		default = false,
	},
	{
		name = "WAXWELL",
		label = "麦克斯韦专属喊话",
		options =	{
						{description = "是", data = true},
						{description = "否", data = false},
					},
		default = false,
	},
	{
		name = "WEBBER",
		label = "韦伯专属喊话",
		options =	{
						{description = "是", data = true},
						{description = "否", data = false},
					},
		default = false,
	},
	{
		name = "WATHGRITHR",
		label = "女武神专属喊话",
		options =	{
						{description = "是", data = true},
						{description = "否", data = false},
					},
		default = true,
	},
}