name = "青龙偃月刀"
description = "青龙偃月刀[功能全在设置里调]。技能类一次只能开一个，阅读能力类一次只能开一个。（黄金修补武器耐久，黄金增加武器攻击力，黄金开启无敌护盾）:给武器补充一个黄金。召唤雷电的能力：将武器扔在地上右键点击开启或关闭。(亮瞎钛合金狗眼技能,通灵术大青蛙技能，瞬移技能）：右键施法。(阅读能力(毁灭）（圣光术）)：右键点武器阅读。背包功能：青龙偃月刀装备时有和坎普斯背包一样多的格子。保鲜功能 : 青龙偃月刀的格子和冰箱一样可以保鲜。玩家死亡后自动复活：当持有武器死亡后3秒自动复活"
author = "WD fack"
version = "4.0"

forumthread = ""

api_version = 10
priority = - 33333
icon_atlas = "modicon.xml"
icon = "modicon.tex"

--客户端服务器MOD
all_clients_require_mod = true

client_only_mod = false

dst_compatible = true




configuration_options =
{    
     {
		name = "fh",
		label = "玩家死亡后自动复活",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
     {
		name = "xb",
		label = "黄金修补武器耐久",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
    {
		name = "smsx",
		label = "黄金增加武器攻击力",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
	{
		name = "wdhd",
		label = "黄金开启无敌护盾",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
	{
		name = "fyt",
		label = "召唤雷电能力",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
    {
		name = "jn",
		label = "亮瞎钛合金狗眼技能",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
	{
		name = "xhnj",
		label = "施放亮瞎狗眼技能消耗武器耐久",
		options =
		{
			{description = "无消耗", data = 0},
			{description = "极低", data = 0.01},
			{description = "低", data = 0.1},
			{description = "中（默认）", data = 0.25},
			{description = "高", data = 0.5},
			{description = "极高", data = 1},
			
		},
		default = 0.25,
	},
	
	{
		name = "xhje",
		label = "施放亮瞎狗眼技能消耗饥饿",
		options =
		{
			{description = "无消耗", data = 0},
			{description = "极低", data = 10},
			{description = "低", data = 25},
			{description = "中（默认）", data = 50},
			{description = "高", data = 100},
			{description = "极高", data = 120},
			
		},
		default = 50,
	},
	
    {
		name = "xhjs",
		label = "施放亮瞎狗眼技能消耗精神",
		options =
		{
			{description = "无消耗", data = 0},
			{description = "极低", data = 5},
			{description = "低", data = 10},
			{description = "中（默认）", data = 50},
			{description = "高", data = 80},
			{description = "极高", data = 120},
			
		},
		default = 50,
	},
	
	{
		name = "zhdqw",
		label = "通灵术大青蛙技能",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
	{
		name = "sy",
		label = "瞬移技能",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
	{
		name = "bb",
		label = "背包功能",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
	{
		name = "bx",
		label = "背包可保鲜",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
	{
		name = "yd",
		label = "阅读（毁灭）",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
	{
		name = "zl",
		label = "阅读（圣光术）",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
	{
		name = "aoe",
		label = "攻击为范围性攻击",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
	{
		name = "xtx",
		label = "作死攻击特效",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
	{
		name = "jt",
		label = "攻击附带击退效果",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
    {
		name = "bd",
		label = "攻击附带冰冻效果",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	 
	{
		name = "rs",
		label = "攻击附带燃烧效果",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},

	{
		name = "fwbd",
		label = "攻击附带范围冰冻效果",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
	{
		name = "hx",
		label = "攻击回血",
		options =
		{
			{description = "0（默认）", data = 0},
			{description = "1", data = 1},
			{description = "3", data = 3},
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "50", data = 50},
			{description = "100", data = 100},
			{description = "300", data = 300},
		},
		default = 0,
	},
	
	{
		name = "js",
		label = "攻击回复精神",
		options =
		{
			{description = "0（默认）", data = 0},
			{description = "1", data = 1},
			{description = "3", data = 3},
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "50", data = 50},
			{description = "100", data = 100},
			{description = "200", data = 200},
		},
		default = 0,
	},
	
    {
		name = "qlyyddamage",
		label = "攻击伤害",
		options =
		{
			{description = "40", data = 40},
			{description = "60", data = 60},
			{description = "80（默认）", data = 80},
			{description = "100", data = 100},
			{description = "120", data = 120},
			{description = "140", data = 140},
			{description = "160", data = 160},
			{description = "180", data = 180},
			{description = "200", data = 200},
			{description = "300", data = 300},
			{description = "400", data = 400},
			{description = "500", data = 500},
			{description = "600", data = 600},
			{description = "700", data = 700},
			{description = "800", data = 800},
			{description = "900", data = 900},
			{description = "1000", data = 1000},
			{description = "秒一切", data = 99999999},
		},
		default = 80,
	},
	
	{
		name = "qlyydattackrange",
		label = "攻击距离",
		options =
		{
			{description = "1", data = 1},
			{description = "1.2(默认)", data = 1.2},
			{description = "1.5", data = 1.5},
			{description = "2", data = 2},
			{description = "4", data = 4},
			{description = "8", data = 8},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "30", data = 30},
		},
		default = 1.2,
	},
	
	{
		name = "qlyydmovespeedmul",
		label = "移动速度",
		options =
		{
			{description = "不增加", data = 1},
			{description = "增加20%默认", data = 1.2},
			{description = "增加50%", data = 1.5},
			{description = "增加100%", data = 2},
			{description = "增加150%", data = 2.5},
			
		},
		default = 1.2,
	},
	
	{
		name = "qlyydlightradius",
		label = "光亮半径",
		options =
		{
		    {description = "0(默认)", data = 0},
			{description = "0.6", data = 0.6},
			{description = "1", data = 1},
			{description = "2", data = 2},
			{description = "3", data = 3},
			{description = "4", data = 4},
			{description = "5", data = 5},
			{description = "10", data = 10},
		},
		default = 0,
	},

	{
		name = "qlyydlightintensity",
		label = "光强度",
		options =
		{
			{description = "0.3", data = 0.3},
			{description = "0.5(默认)", data = 0.5},
			{description = "0.8", data = 0.8},
		},
		default = 0.5,
	},

	{
		name = "qlyydcanuseashammer",
		label = "可锤",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},

	{
		name = "qlyydcanuseasshovel",
		label = "可铲",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	 
	{
		name = "wk",
		label = "可挖矿",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},

	{
		name = "ks",
		label = "可砍树",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
	{
		name = "yjks",
		label = "一键砍树开关",
		options =
		{
			{description = "开启", data = 66},
			{description = "关闭(默认)", data = 2},
		},
		default = 2,
	},
	
	{
		name = "bc",
		label = "可捕虫",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
	{
		name = "qlyydfiniteuses",
		label = "武器耐久度",
		options =
		{
			{description = "100", data = 100},
			{description = "200（默认）", data = 200},
			{description = "300", data = 300},
			{description = "400", data = 400},
			{description = "500", data = 500},
			{description = "600", data = 600},
			{description = "800", data = 800},
			{description = "1000", data = 1000},
			{description = "3000", data = 3000},
			{description = "999999", data = 999999},
			
		},
		default = 200,
	},
	
	{
		name = "sl",
		label = "制作需要黄金数量",
		options =
		{
			{description = "1", data = 1},
			{description = "2", data = 2},
			{description = "5", data = 5},
			{description = "10（默认）", data = 10},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "100", data = 100},
			
		},
		default = 10,
	},
}