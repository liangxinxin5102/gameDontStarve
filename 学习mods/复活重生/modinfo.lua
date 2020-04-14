name = "复活重生"
author = "Skull & Orange Anydong 汉化更改"
version = "0.2.3.h.0.2"
forumthread = "http://steamcommunity.com/sharedfiles/filedetails/?id=462434129"
api_version = 10
priority = -77
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
dst_compatible = true
all_clients_require_mod = false
client_only_mod = false
server_only_mod = true
server_filter_tags = { "Restart" }

icon_atlas = "modicon.xml"
icon = "modicon.tex"

description = [[服务端专用MOD.
按Y(公聊)或者U(私聊)输入指令:
#重生/#restart (重生换角色)
##重生/#restart_d (重生并掉落物品)
#复活/#resurrect  (角色复活)
#自杀/#kill  (角色自杀)
添加中英双语通用指令
]]
configuration_options = {
	{
		name = "MOD_RESTART_IGNORING_ADMIN",
		label = "管理员不受限制",
		hover = "房主和管理员不受冷却时间限制.",
		options =
		{
			{description = "开", data = true},
			{description = "关", data = false},
		},
		default = true,
	},
	{
		name = "MOD_RESTART_ALLOW_RESTART",
		label = "重生",
		options =
		{
			{description = "开", data = true},
			{description = "关", data = false},
		},
		default = true,
	},
	{
		name = "MOD_RESTART_ALLOW_RESURRECT",
		label = "复活",
		options =
		{
			{description = "开", data = true},
			{description = "关", data = false},
		},
		default = true,
	},
	{
		name = "MOD_RESTART_ALLOW_KILL",
		label = "自杀",
		options =
		{
			{description = "开", data = true},
			{description = "关", data = false},
		},
		default = true,
	},
	{
		name = "MOD_RESTART_CD_RESTART",
		label = "重生CD冷却时间（分）",
		hover = "重生的冷却时间，默认五分钟",
		options =
		{
			{description = "无", data = 0, hover = "无限重生"},
			{description = "1", data = 1, hover = "1 分钟"},
			{description = "2", data = 2, hover = "2 分钟"},
			{description = "3", data = 3, hover = "3 分钟"},
			{description = "5", data = 5, hover = "5 分钟"},
			{description = "7", data = 7, hover = "7 分钟"},
			{description = "10", data = 10, hover = "10 分钟"},
		},
		default = 5,
	},
	{
		name = "MOD_RESTART_CD_RESURRECT",
		label = "复活CD冷却时间（分）",
		hover = "复活的冷却时间,默认为七分钟",
		options =
		{
			{description = "无", data = 0, hover = "无限复活"},
			{description = "1", data = 1, hover = "1 分钟"},
			{description = "2", data = 2, hover = "2 分钟"},
			{description = "3", data = 3, hover = "3 分钟"},
			{description = "5", data = 5, hover = "5 分钟"},
			{description = "7", data = 7, hover = "7 分钟"},
			{description = "10", data = 10, hover = "10 分钟"},
		},
		default = 7,
	},
	{
		name = "MOD_RESTART_CD_KILL",
		label = "自杀CD冷却时间（分）",
		hover = "自杀的冷却时间，默认为三分钟",
		options =
		{
			{description = "无", data = 0, hover = "无限自杀"},
			{description = "1", data = 1, hover = "1 分钟"},
			{description = "2", data = 2, hover = "2 分钟"},
			{description = "3", data = 3, hover = "3 分钟"},
			{description = "5", data = 5, hover = "5 分钟"},
			{description = "7", data = 7, hover = "7 分钟"},
			{description = "10", data = 10, hover = "10 分钟"},
		},
		default = 3,
	},
	{
		name = "MOD_RESTART_TRIGGER_MODE",
		label = "命令模式",
		hover = "设置命令触发模式，私聊或者公聊触发指令，默认公聊和私聊",
		options =
		{
			{description = "公聊和私聊", data = 1},
			{description = "仅公聊", data = 2},
			{description = "仅私聊", data = 3},
		},
		default = 1,
	},
	{
		name = "MOD_RESTART_FORCE_DROP_MODE",
		label = "是否强制掉落道具",
		hover = "重生时是否强制掉落身上物品",
		options =
		{
			{description = "默认", data = 1, hover = "默认"},
			{description = "掉落", data = 2, hover = "重生强制掉落"},
			{description = "不掉落", data = 3, hover = "重生不掉落"},
		},
		default = 1,
	},
	{
		name = "MOD_RESTART_WELCOME_TIPS",
		label = "帮助信息",
		hover = "首次进入房间提示命令使用帮助",
		options =
		{
			{description = "开", data = true},
			{description = "关", data = false},
		},
		default = true,
	},
	{
		name = "MOD_RESTART_WELCOME_TIPS_TIME",
		label = "帮助信息显示（秒）",
		hover = "设置帮助信息显示时间，默认为六秒",
		options =
		{
			{description = "4", data = 4},
			{description = "5", data = 5},
			{description = "6", data = 6},
			{description = "7", data = 7},
			{description = "8", data = 8},
			{description = "9", data = 9},
			{description = "10", data = 10},
			{description = "11", data = 11},
			{description = "12", data = 12},
		},
		default = 6,
	},

}
