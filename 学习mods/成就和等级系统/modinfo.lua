name =
[[成就和等级系统]]
description =
[[v3.5
添加一个游戏成就和等级系统。
吃食物或杀死怪物获得经验xp。
花费等级可用点数给任务属性加点。
获得成就将得到成就星。
花费成就星升级属性或解锁永久的能力。
如果你完成了所有成就可以调多重复多次在模组配置。
提示：成就系统和等级系统是分别独立的，成就星不是点数哦！
]]
author = "Lavax 编译 小白完美汉化"
version = "3.5"
priority = -1000
server_filter_tags = {"achievement", "level"}

forumthread = ""

api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options =
{
	{
        name = "SYSTEM",
        label = "激活系统",
        options =   {
                        {description = "双方都有", data = "both"},
                        {description = "只有等级", data = "level"},
						{description = "只有成就", data = "achieve"},
                    },
        default = "both",
		hover = "选择你想玩的系统",
    },
	{
        name = "LANGUAGE",
        label = "语言",
        options =   {
                        {description = "英语", data = "e"},
                        {description = "韩语", data = "kr"},
						{description = "葡萄牙语 (巴西)", data = "ptbr"},
						{description = "西班牙语", data = "es"},
						{description = "意大利语", data = "it"},
						{description = "简体中文", data = "chs"},
						{description = "繁体中文", data = "cht"},
						{description = "俄国语", data = "ru"},
						{description = "德国语", data = "de"},
                    },
        default = "chs",
        hover = "选择您使用的语言",
    },
	{
        name = "MULT",
        label = "福利成本倍增",
        options =   {
						{description = "0.5x", data = 0.5},
						{description = "0.75x", data = 0.75},
                        {description = "1.0x", data = 1},
                        {description = "1.5x", data = 1.5},
						{description = "2.0x", data = 2.0},
						{description = "2.5x", data = 2.5},
                    },
        default = 1,
		hover = "增加额外费用，使之更具挑战性",
    },
	{
        name = "EXPMULT",
        label = "XP倍增",
        options =   {
						{description = "0.5x", data = 0.5},
						{description = "0.75x", data = 0.75},
                        {description = "1.0x", data = 1},
                        {description = "1.25x", data = 1.25},
						{description = "1.5x", data = 1.5},
						{description = "2.0x", data = 2.0},
                    },
        default = 1,
		hover = "修改经验值",
    },
	{
        name = "HIDEPERK",
        label = "禁用福利类别",
        options =   {
						{description = "没有", data = "none"},
						{description = "能力", data = "ab"},
						{description = "制作", data = "cr"},
						{description = "能力和制作", data = "abcr"},

                    },
        default = "none",
		hover = "隐藏能力 并且/或者 制作在成就标签",
    },
	{
        name = "GAMEBREAKER",
        label = "改变游戏规则的特权",
        options =   {
						{description = "启动", data = true},
						{description = "禁用", data = false},
                    },
        default = true,
		hover = "禁用更改游戏的特权",
    },
	{
        name = "REFUND",
        label = "重置返还百分比",
        options =   {
                        {description = "75%", data = 0.75},
                        {description = "85%", data = 0.85},
						{description = "95%", data = 0.95},
						{description = "100%", data = 1},
                    },
        default = 1,
		hover = "选择多少点，你得到退款时重置",
    },
	{
        name = "HEALTHPENATLY",
        label = "重置的健康值惩罚",
        options =   {
                        {description = "启动", data = true},
                        {description = "禁用", data = false},
                    },
        default = true,
		hover = "重置时可移除生命值惩罚",
    },
	{
        name = "COSTRAISE",
        label = "提高福利成本",
        options =   {
                        {description = "启动", data = true},
                        {description = "禁用", data = false},
                    },
        default = true,
		hover = "选择可重复升级的成本是否应该增加",
    },
	{
        name = "GEAR",
        label = "开局物品",
        options =   {
						{description = "没有", data = "nothing"},
                        {description = "战斗", data = "fight"},
                        {description = "幸存者", data = "survive"},
                    },
        default = "nothing",
		hover = "选择玩家开始的物品",
    },
	{
        name = "PLAYS",
        label = "成就重复",
        options =   {
						{description = "0", data = 0},
                        {description = "1", data = 1},
                        {description = "2", data = 2},
						{description = "3", data = 3},
						{description = "无限", data = 999},
                    },
        default = 999,
        hover = "在完成所有的成就后，它们将被重置多次",
    },
	{
        name = "LEVELXP",
        label = "XP上限",
        options =   {
						{description = "500", data = 500},
						{description = "1000", data = 1000},
						{description = "2000", data = 2000},
                        {description = "3000", data = 3000},
                        {description = "4000", data = 4000},
                    },
        default = 2000,
        hover = "升一级所需的最大经验值",
    },
	{
        name = "LEVELPOINTS",
        label = "升级点",
        options =   {
						{description = "1", data = 1},
						{description = "2", data = 2},
                        {description = "3", data = 3},
                        {description = "4", data = 4},
						{description = "5", data = 5},
                    },
        default = 3,
        hover = "升级后获得的点数",
    },
	{
        name = "MANDRAKEBOI",
        label = "曼德拉草重生",
        options =   {
                        {description = "关", data = false},
                        {description = "开", data = true},
                    },
        default = true,
        hover = "每年秋天在草地上生成最多可达4只曼德拉草",
    },
	{
        name = "CAVES",
        label = "洞穴启用",
        options =   {
                        {description = "没有洞穴", data = false},
                        {description = "地面与洞穴", data = true},
                    },
        default = true,
		hover = "如果你在没有洞穴的情况下进行游戏，那么你将获得无奖励的洞穴成就",
    },
}