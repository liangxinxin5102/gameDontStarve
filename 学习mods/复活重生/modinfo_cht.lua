description = [[伺服器專用MOD.
按Y(公開)或者U(密語)輸入指令:
#restart / #重生 (重生換角色)
#restart_d / ##重生 (重生並掉落物品)
#resurrect / #復活 / #复活 (角色復活)
#kill / #自殺 / #自杀 (角色自殺)
]]

configuration_options = {
	{
		name = "MOD_RESTART_IGNORING_ADMIN",
		label = "管理員不受限制",
		hover = "房主和管理員不受冷卻時間限制.",
		options =
		{
			{description = "開", data = true},
			{description = "關", data = false},
		},
		default = true,
	},
	{
		name = "MOD_RESTART_ALLOW_RESTART",
		label = "重生",
		options =
		{
			{description = "開", data = true},
			{description = "關", data = false},
		},
		default = true,
	},
	{
		name = "MOD_RESTART_ALLOW_RESURRECT",
		label = "復活",
		options =
		{
			{description = "開", data = true},
			{description = "關", data = false},
		},
		default = true,
	},
	{
		name = "MOD_RESTART_ALLOW_KILL",
		label = "自殺",
		options =
		{
			{description = "開", data = true},
			{description = "關", data = false},
		},
		default = true,
	},
	{
		name = "MOD_RESTART_CD_RESTART",
		label = "重生冷卻(分)",
		hover = "重生的冷卻時間.",
		options =
		{
			{description = "無", data = 0, hover = "無限重生"},
			{description = "1", data = 1, hover = "1 分鐘"},
			{description = "2", data = 2, hover = "2 分鐘"},
			{description = "3", data = 3, hover = "3 分鐘"},
			{description = "5", data = 5, hover = "5 分鐘"},
			{description = "7", data = 7, hover = "7 分鐘"},
			{description = "10", data = 10, hover = "10 分鐘"},
		},
		default = 5,
	},
	{
		name = "MOD_RESTART_CD_RESURRECT",
		label = "復活冷卻(分)",
		hover = "復活的冷卻時間.",
		options =
		{
			{description = "無", data = 0, hover = "無限復活"},
			{description = "1", data = 1, hover = "1 分鐘"},
			{description = "2", data = 2, hover = "2 分鐘"},
			{description = "3", data = 3, hover = "3 分鐘"},
			{description = "5", data = 5, hover = "5 分鐘"},
			{description = "7", data = 7, hover = "7 分鐘"},
			{description = "10", data = 10, hover = "10 分鐘"},
		},
		default = 7,
	},
	{
		name = "MOD_RESTART_CD_KILL",
		label = "自殺冷卻(分)",
		hover = "自殺的冷卻時間.",
		options =
		{
			{description = "無", data = 0, hover = "無限自殺"},
			{description = "1", data = 1, hover = "1 分鐘"},
			{description = "2", data = 2, hover = "2 分鐘"},
			{description = "3", data = 3, hover = "3 分鐘"},
			{description = "5", data = 5, hover = "5 分鐘"},
			{description = "7", data = 7, hover = "7 分鐘"},
			{description = "10", data = 10, hover = "10 分鐘"},
		},
		default = 3,
	},
	{
		name = "MOD_RESTART_TRIGGER_MODE",
		label = "聊天模式",
		hover = "公開或者密語觸發指令.",
		options =
		{
			{description = "公開&密語", data = 1},
			{description = "僅公開", data = 2},
			{description = "僅密語", data = 3},
		},
		default = 1,
	},
	{
		name = "MOD_RESTART_FORCE_DROP_MODE",
		label = "強制掉落道具",
		hover = "重生是否強制掉落道具.",
		options =
		{
			{description = "預設", data = 1, hover = "預設"},
			{description = "掉落", data = 2, hover = "重生強制掉落道具"},
			{description = "不掉落", data = 3, hover = "重生強制不掉落道具"},
		},
		default = 1,
	},
	{
		name = "MOD_RESTART_WELCOME_TIPS",
		label = "幫助信息",
		hover = "首次進入遊戲的使用提示.",
		options =
		{
			{description = "開", data = true},
			{description = "關", data = false},
		},
		default = true,
	},
	{
		name = "MOD_RESTART_WELCOME_TIPS_TIME",
		label = "幫助顯示(秒)",
		hover = "幫助信息顯示的持續時間.",
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
