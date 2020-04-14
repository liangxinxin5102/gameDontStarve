name = "快速工作"
author = "Meliodas"
version = "1.8.1"
description = "版本："..version..[[

可让你快速进行各种工作
未经许可请勿转载！如有问题请留言
更新日志
修复沃拓克斯无法食用灵魂的BUG]]
forumthread = "http://steamcommunity.com/sharedfiles/filedetails/?id=1200745268"
icon_atlas = "QuickWork.xml"
icon = "QuickWork.tex"

dst_compatible = true
client_only_mod = false
all_clients_require_mod = true

api_version = 10

configuration_options =
{
	{
        name = "Pick",
        label = "采集类",
		hover = "采集、捡起、收获",
        options =	{
						{description = "开启", data = true},
						{description = "关闭", data = false},
					},
		default = true,
    },
	{
		name = "BuildRepair",
        label = "建造修复类",
		hover = "建造、装饰、绘画、修复、缝补、灭火",
        options =	{
						{description = "开启", data = true},
						{description = "关闭", data = false},
					},
		default = true,
	},
	{
        name = "HSHU",
        label = "三围升级类",
		hover = "食用、治疗、学习、升级",
        options =	{
						{description = "开启", data = true},
						{description = "关闭", data = false},
					},
		default = true,
	},
	{
        name = "Animal",
        label = "动物类",
		hover = "抚摸、喂食、杀害、刷毛、刮毛",
        options =	{
						{description = "开启", data = true},
						{description = "关闭", data = false},
					},
		default = true,
    },
	{
        name = "Others",
        label = "其他动作",
		hover = "其他动作加快",
        options =	{
						{description = "开启", data = true},
						{description = "关闭", data = false},
					},
		default = true,
    },
	{
		name = "ChopTime",
		label = "砍伐次数",
		hover = "设置砍倒树木的次数",
		options =
		{
			{description = "1 次", data = 1},
			{description = "4 次", data = 4},
			{description = "关闭", data = 999},
		},
		default = 1,
	},
	{
		name = "MineTime",
		label = "开采次数",
		hover = "设置敲开矿物岩石的次数",
		options =
		{
			{description = "1 次", data = 1},
			{description = "4 次", data = 4},
			{description = "关闭", data = 999},
		},
		default = 1,
	},
	{
		name = "FishTime",
		label = "钓鱼时间",
		hover = "钓鱼时鱼按你设置的时间上钩",
		options =
		{
			{description = "立刻上钩", data = 0},
			{description = "5 秒", data = 5},
			{description = "关闭", data = 999},
		},
		default = 0,
	},
	{
        name = "CookTime",
        label = "烹饪时间",
		hover = "按照你设定的时间煮好食物",
        options = 
        {
			{description = "立刻完成", data = 0},
			{description = "只开启快速烤制", data = 998},
			{description = "15 秒", data = 15},
			{description = "30 秒", data = 30},
			{description = "关闭", data = 999},
        },
        default = 0,
    },
	{
        name = "QuickGrow",
        label = "作物成熟",
		hover = "农场种植种子成熟时间调整",
        options = 
        {
            {description = "开启", data = 0},
			{description = "只开启冬天正常生长", data = 1},
			{description = "关闭", data = 999},
        },
        default = 0,
    },
	{
        name = "QuickDry",
        label = "晾肉秒干",
		hover = "肉一挂上晾肉架就风干",
        options = 
        {
            {description = "开启", data = true},
			{description = "关闭", data = false},
        },
        default = true,
    },
}