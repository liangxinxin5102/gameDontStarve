description = [[服务端专用MOD.
按Y(公聊)或者U(私聊)输入指令:
#restart / #重生 (重生换角色)
#restart_d / ##重生 (重生并掉落物品)
#resurrect / #复活 / #復活 (角色复活)
#kill / #自杀 / #自殺 (角色自杀)
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
		label = "重生冷却(分)",
		hover = "重生的冷却时间.",
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
		label = "复活冷却(分)",
		hover = "复活的冷却时间.",
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
		label = "自杀冷却(分)",
		hover = "自杀的冷却时间.",
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
		label = "触发模式",
		hover = "公聊或者私聊触发指令.",
		options =
		{
			{description = "公&私聊", data = 1},
			{description = "仅公聊", data = 2},
			{description = "仅私聊", data = 3},
		},
		default = 1,
	},
	{
		name = "MOD_RESTART_FORCE_DROP_MODE",
		label = "强制掉落道具",
		hover = "重生是否强制掉落道具.",
		options =
		{
			{description = "默认", data = 1, hover = "默认"},
			{description = "掉落", data = 2, hover = "重生强制掉落道具"},
			{description = "不掉落", data = 3, hover = "重生强制不掉落道具"},
		},
		default = 1,
	},
	{
		name = "MOD_RESTART_WELCOME_TIPS",
		label = "帮助信息",
		hover = "首次进入游戏的使用提示.",
		options =
		{
			{description = "开", data = true},
			{description = "关", data = false},
		},
		default = true,
	},
	{
		name = "MOD_RESTART_WELCOME_TIPS_TIME",
		label = "帮助显示(秒)",
		hover = "帮助信息显示的持续时间.",
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
