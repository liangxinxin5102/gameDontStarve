name = "生物加强(Monster strengthened)"
description = "加强大部分的敌对生物(Strengthen most hostile creatures)"
author = "qingliu"
version = "1.31"

forumthread = ""

api_version = 10
dst_compatible = true
reign_of_giants_compatible = false
priority = -10

all_clients_require_mod = true
client_only_mod = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options =
{
	{
	  name = "health_boss",
	  label = "BOSS血量加强",
	  hover = "boss health multiple",
	   options = 
        {		
			{description = "1x", data = 1},
			{description = "1.5x", data = 1.5},
			{description = "2x", data = 2},
			{description = "3x", data = 3},
     	 },
	    default = 1,
	
	},
	
	{
	  name = "health_biology",
	  label = "生物血量加强",
	  hover = "biology health multiple",
	   options = 
        {		
			{description = "1x", data = 1},
			{description = "1.5x", data = 1.5},
			{description = "2x", data = 2},
			{description = "3x", data = 3},
     	 },
	    default = 1,
	
	},
	
	{
	  name = "damage_boss",
	  label = "BOSS攻击加强",
	  hover = "boss damage multiple",
	   options = 
        {		
			{description = "1x", data = 1},
			{description = "1.5x", data = 1.5},
			{description = "2x", data = 2},
			{description = "3x", data = 3},
     	 },
	    default = 1,
	
	},
	
	{
	  name = "damage_biology",
	  label = "生物攻击加强",
	  hover = "biology damage multiple",
	   options = 
        {		
			{description = "1x", data = 1},
			{description = "1.5x", data = 1.5},
			{description = "2x", data = 2},
			{description = "3x", data = 3},
     	 },
	    default = 1,
	
	},
		
	{
	  name = "boss_period",
	  label = "BOSS攻速加强",
	  hover = "boss period strengthen",
	   options = 
        {		
			{description = "关闭", data = false, hover = "OFF"},
			{description = "开启", data = true, hover = "ON"},
     	 },
	    default = false,
	
	},
	
	{
	  name = "biology_period",
	  label = "生物攻速加强",
	  hover = "biology period strengthen",
	   options = 
        {		
			{description = "关闭", data = false, hover = "OFF"},
			{description = "开启", data = true, hover = "ON"},
     	 },
	    default = false,
	
	},
	
	{
	  name = "boss_armor",
	  label = "BOSS护甲",
	  hover = "boss armor",
	   options = 
        {		
			{description = "0%", data = 0},
			{description = "15%", data = 0.15},
			{description = "30%", data = 0.3},
     	 },
	    default = 0,
	
	},	
	
	{
	  name = "biology_armor",
	  label = "生物护甲",
	  hover = "biology armor",
	   options = 
        {		
			{description = "0%", data = 0},
			{description = "10%", data = 0.1},
			{description = "20%", data = 0.2},
     	 },
	    default = 0,
	
	},	
	
	{
	  name = "boss_regen",
	  label = "BOSS回血",
	  hover = "boss regen health",
	   options = 
        {		
			{description = "0", data = 0},
			{description = "5HP/S", data = 5},
			{description = "10HP/S", data = 10},
			{description = "20HP/S", data = 20},
     	 },
	    default = 0,
	
	},	
	
	{
	  name = "biology_regen",
	  label = "生物回血",
	  hover = "biology regen health",
	   options = 
        {		
			{description = "0", data = 0},
			{description = "3HP/S", data = 3},
			{description = "6HP/S", data = 6},
			{description = "9HP/S", data = 9},
     	 },
	    default = 0,
	
	},
	
	{
	  name = "armour_health",
	  label = "护甲值倍数",
	  hover = "armour health multiple",
	   options = 
        {		
			{description = "1x", data = 1},
			{description = "1.5x", data = 1.5},
			{description = "2x", data = 2},
			{description = "2.5x", data = 2.5},
     	 },
	    default = 1,
	
	},
	
	{
	  name = "armour_armor",
	  label = "护甲减伤调整",
	  hover = "armour armor adjustment",
	   options = 
        {		
			{description = "关闭", data = false, hover = "OFF"},
			{description = "开启", data = true, hover = "ON"},
     	 },
	    default = false,
	
	},
	
	{
	  name = "arms_damage",
	  label = "武器伤害倍数",
	  hover = "arms damage multiple",
	   options = 
        {		
			{description = "1x", data = 1},
			{description = "1.25x", data = 1.25},
			{description = "1,5x", data = 1.5},
			--{description = "1.75x", data = 1.75},
     	 },
	    default = 1,
	
	},
	
	{
	  name = "arms_uses",
	  label = "武器耐久倍数",
	  hover = "arms uses multiple",
	   options = 
        {		
			{description = "1x", data = 1},
			{description = "2x", data = 2},
			{description = "3x", data = 3},
     	 },
	    default = 1,
	
	},
	
	{
	  name = "more_strengthening",
	  label = "更多加强",
	  hover = "more strengthening",
	   options = 
        {		
			{description = "关闭", data = false, hover = "OFF"},
			{description = "开启", data = true, hover = "ON"},
     	 },
	    default = false,
	
	},
}
	
	
	
	
	
	
	
	
	
	
	




