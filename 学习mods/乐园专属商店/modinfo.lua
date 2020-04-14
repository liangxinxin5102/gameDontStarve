-- This information tells other players more about the mod
name = "乐园专属商店"
description = "已经经过CY授权，基于CY商店改写出来的乐园商店，乐园服专用，2.4：更新了新的贴图"
author = "CY，SOLOHAM"
version = "3.1" -- This is the version of the template. Change it to your own number.

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = ""
--

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10
priority = 1

-- Compatible with Don't Starve Together
dst_compatible = true

-- Not compatible with Don't Starve
dont_starve_compatible = false
reign_of_giants_compatible = false

-- Character mods need this set to true
all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- The mod's tags displayed on the server list
server_filter_tags = {"pet"}

configuration_options =
{

	{
		name = "jieshao",
		label = "服务器说明",
		hover = "定制cy服务器介绍,非本服玩家不要开启",
		options =
        {
			-- {description = "开启", data = true}, 
			{description = "关闭", data = false}, 
        },
		default = false,
	},

	{
		name = "ziyuan",
		label = "ziyuan",
		default = 	{
							 {"rocks",20},--岩石
							{"cutgrass",20},--草 
							{"twigs",20},--树枝 
							{"log",20},--木头 
							{"charcoal",30},--木炭 
							{"ash",10},--灰 
							{"cutreeds",30},--采下的芦苇 
							{"lightbulb",40},--荧光果 
							{"petals",20},--花瓣 
							{"pinecone",20},--松果 
							{"foliage",10},--叶子 
							{"cutlichen",60},--摘下的苔藓 
							{"wormlight",200},--虫子果 
							{"lureplantbulb",300},--食人花种子 
							{"flint",20},--燧石 
							{"nitre",30},--硝石 
							{"redgem",1600},--红宝石 
							{"bluegem",1600},--蓝宝石 
							{"purplegem",3200},--紫宝石 
							{"greengem",1000},--绿宝石 
							{"orangegem",2400},--橙宝石 
							{"yellowgem",2400},--黄宝石 
							{"dug_sapling",100},--树苗 
							{"dug_berrybush",100},--浆果丛
							{"dug_grass",100},--草根 
							{"steelwool",500},--刚羊毛
							{"bernie_inactive",500},--伯尼 
							{"houndstooth",200},--犬牙 
							{"pigskin",300},--猪皮
							{"silk",98},--蜘蛛丝
							{"manrabbit_tail",300},--兔人尾巴 
							{"beardhair",100},--胡子 
							{"beefalowool",30},--牛毛 
							{"honeycomb",200},--蜂巢 
							{"stinger",10},--蜂刺 
							{"feather_crow",60},--乌鸦羽毛 
							{"feather_robin",60},--红雀羽毛 
							{"feather_robin_winter",100},--雪雀羽毛 
							{"horn",50},--牛角 
							{"slurtleslime",20},--蜗牛龟粘液 
							{"slurtle_shellpieces",20},--蜗牛龟壳片 
							{"butterflywings",100},--蝴蝶翅膀
							{"glommerwings",1000},--格罗门翅膀 							
							{"glommerfuel",100},--格罗门燃料 
							{"boneshard",120},--硬骨头 
							{"ice",30},--冰 
							{"goldnugget",100},--金子
							{"nightmarefuel",200},--噩梦燃料
							{"moonrocknugget",600},--月之石
							{"livinglog",1000},--活木
							 {"gears",888},--齿轮
							 {"marble",60},--大理石
							{"dragon_scales",4000},--龙蝇皮
							{"goose_feather",60},--鸭毛
							{"bearger_fur",6000},--熊皮
							{"deerclops_eyeball",5000},--眼球
							{"lightninggoathorn",600},--电羊角
							{"slurper_pelt",600},--吞噬者皮
							 {"shroom_skin",4000},--蛤蟆皮
							{"minotaurhorn",10000},--犀牛角
							{"atrium_key",10000},--远古钥匙
							{"thulecite",1000},--铥矿
							{"thulecite_pieces",150},--铥矿碎片
							-- {"mandrake",400},--曼德拉
							{"shadowheart",5000},--暗影之心
							{"lucky_goldnugget",1000},--元宝 
							{"quagmire_coin1",200},--铜币 
							{"quagmire_coin2",500},--银币 							
							{"quagmire_coin3",1000},--金币 
							{"quagmire_coin4",10000},--月币 

						--	{"lgq",1},
					    --		{"lgq",1},
							      --充值币 
							
					}	
	},
	{
		name = "fight",
		label = "fight",
		default = 	{
							 {"boomerang",360},--回旋镖 
							{"tentaclespike",430},--狼牙棒 
							{"blowdart_pipe",233},--吹箭 
							{"blowdart_sleep",322},--麻醉吹箭 
							{"blowdart_fire",322},--燃烧吹箭 
							{"hambat",460},--火腿短棍 
							{"footballhat",300},--猪皮帽 
							{"nightsword",1230},--暗影剑 
							{"batbat",1600},--蝙蝠棒 
							{"ruins_bat",5000},--远古短棒 
							-- {"spear_wathgrithr",300},--瓦丝格雷斯矛 
							{"armormarble",1600},--大理石盔甲 
							{"armor_sanity",1700},--夜魔盔甲 
							{"armorsnurtleshell",5000},--蜗牛龟盔甲 
							{"armorruins",4000},--远古盔甲 
							{"ruinshat",3500},--远古盔甲 
							{"gunpowder",400},--火药 
							{"armordragonfly",6789},--蜻蜓盔甲 
							{"slurtlehat",5000},--蜗牛帽子
							
							{"chazi",100000},
							{"hj_pokeball",500000},
							{"hj_wings1",500000},
							{"hj_wings1",500000},
							{"hj_wings3",500000},
							{"hj_wings4",500000},
							{"hj_wings5",500000},
							{"lgq",1000000},
							{"ly_bobbag",500000},
							{"ly_hehebag",500000},
							---{"ly_juanzhou",500000},
							{"ly_pandabag",500000},
							{"ly_wingbag",500000},
							{"lyzcm001",1000},   ---这个没下划线 记住了 
							{"lyzcm002",100000},
							{"lycoin",1000000},  ---百元充值币
							{"newweapons",10000},
							{"rongguang",100000},
							{"taidao",100000},
							{"zhenkong",100000},
							---ly_juanzhou
							{"ly_juanzhou",3000},
							{"ly_fushi01",10000},
							{"ly_fushi03",30000},  
							
							{"ly_qhs-chuanshuo",50000},
							
							
							{"ly_zaolu3x3",5000000},  -----填海造陆四个
							{"ly_zaolu9x9",5000000},
							{"ly_tianhai3x3",5000000},
							{"ly_tianhai9x9",5000000},
							
							
							
							
							
							
							
							
		
		
					}	
	},
	{
		name = "cloth",
		label = "cloth",
		default = 	{
								{"heatrock",260},--保温石
								{"strawhat",240},--草帽 
								{"flowerhat",360},--花环 
								{"beefalohat",560},--牛毛帽 
								{"featherhat",720},--羽毛帽 
								{"tophat",500},--高礼帽 
								{"earmuffshat",200},--兔耳罩 
								{"winterhat",340},--冬帽 
								{"minerhat",800},--矿工帽 
								{"spiderhat",1000},--蜘蛛帽 
								{"beehat",570},--蜂帽 
								{"walrushat",2000},--海象帽 
								{"slurtlehat",5000},--蜗牛帽子 
								{"bushhat",450},--丛林帽 
								{"rainhat",420},--防雨帽 
								{"icehat",800},--冰帽 
								{"watermelonhat",666},--西瓜帽 
								{"catcoonhat",666},--浣熊帽 
								{"sweatervest",630},--小巧背心 
								{"trunkvest_summer",3000},--夏日背心 
								{"trunkvest_winter",3000},--寒冬背心 
								{"armorslurper",1600},--饥饿腰带 
								{"raincoat",1600},--雨衣 
								{"molehat",2140},--鼹鼠帽 
								{"beargervest",7000},--熊背心 
								{"eyebrellahat",8000},--眼睛帽 
								{"hawaiianshirt",3000},--夏威夷衬衫
		
		
					}	
	},
	{
		name = "shiwu",
		label = "shiwu",
		default = 	{
							{"monstermeat",60},--怪物肉
							{"spoiled_food",10},--腐烂食物 
							{"monstermeat_dried",80},--干疯肉
							{"red_cap",88},--采摘的红蘑菇 
							{"red_cap_cooked",88},--煮熟的红蘑菇 
							{"durian",150},--榴莲 
							{"rottenegg",100},--烂鸡蛋 
							{"durian_cooked",150},--熟榴莲 
							{"poop",100},--便便 
							{"guano",200},--鸟粪 
							{"wetgoop",10},--（湿腻焦糊）
							{"monsterlasagna",80},--（怪物千层饼）
							{"berries",30},--浆果 
							{"pumpkin",70},--南瓜 
							-- {"dragonfruit",200},--火龙果 
							{"pomegranate",70},--石榴 
							{"corn",70},--玉米 
							{"eggplant",80},--茄子 
							{"cave_banana",60},--洞穴香蕉 
							{"acorn",30},--橡果 
							{"cactus_meat",142},--仙人掌肉 
							{"watermelon",100},--西瓜 
							{"green_cap",130},--采摘的绿蘑菇 
							{"blue_cap",100},--采摘的蓝蘑菇 
							{"smallmeat",50},--小肉 
							{"meat",100},--大肉 
							{"drumstick",50},--鸡腿 
							{"plantmeat",50},--食人花肉 
							{"fish",100},--鱼 
							{"eel",400},--鳗鱼 
							{"froglegs",50},--蛙腿 
							{"batwing",100},--蝙蝠翅膀 
							{"honey",40},--蜂蜜 
							{"butter",300},--黄油 
							{"goatmilk",600},--羊奶
							{"mandrake",3000},	--（曼德拉草
							{"butterflymuffin",700},	--（奶油松饼）
							{"frogglebunwich",210},	--（青蛙圆面包三明治）
							{"honeyham",360},	--（蜜汁火腿）
							{"dragonpie",480},	--（龙馅饼）
							{"taffy",188},	--太妃糖
							{"pumpkincookie",150},	--（南瓜饼）
							{"kabobs",99},	--肉串
							{"baconeggs",198},	--（鸡蛋火腿）
							{"bonestew",380},	--（肉汤）
							{"perogies",360},	--（半圆小酥饼）
							{"fruitmedley",233},	---（水果拼盘）
							{"fishtacos",341},	--（玉米饼包炸鱼）
							{"waffles",666}, 	--（华夫饼）
							{"turkeydinner",233},	--（火鸡正餐）
							{"fishsticks",250},	--（鱼肉条）
							{"stuffedeggplant",190},--	（香酥茄盒）
							{"honeynuggets",199},	--（甜蜜金砖）
							{"jammypreserves",120},	--（果酱蜜饯）
							{"unagi",666},	           --（鳗鱼料理）
							{"flowersalad",250},           --（花沙拉）
							{"icecream",210},	        --（冰激淋）
							{"watermelonicle",300},        --	（西瓜冰）
							{"ly_mengpo",100000},


					}	
	},
	{
		name = "prizelist",
		label = "prizelist",
		default = 	{
									{"rocks",20},--岩石
									{"cutgrass",10},--草 
									{"twigs",10},--树枝 
									{"log",10},--木头 
									{"charcoal",10},--木炭 
									{"ash",30},--灰 
									{"cutreeds",5},--采下的芦苇 
									{"lightbulb",10},--荧光果 
									{"petals",5},--花瓣 
									{"petals_evil",3},--噩梦花瓣 
									{"pinecone",60},--松果 
									{"foliage",10},--叶子 
									{"cutlichen",20},--摘下的苔藓 
									{"wormlight",3},--虫子果 
									{"lureplantbulb",1},--食人花种子 
									{"flint",10},--燧石 
									{"nitre",10},--硝石 
									{"redgem",1},--红宝石 
									{"bluegem",1},--蓝宝石 
									{"purplegem",1},--紫宝石 
									{"greengem",1},--绿宝石 
									{"orangegem",1},--橙宝石 
									{"yellowgem",1},--黄宝石 
									-- {"rope",100},--绳子 
									-- {"boards",460},--木板 
									-- {"cutstone",130},--石砖 
									-- {"transistor",},--机器原件
									-- {"papyrus",},--纸 
									{"houndstooth",2},--犬牙 
									{"pigskin",3},--猪皮
									{"manrabbit_tail",2},--兔人尾巴 
									{"beardhair",5},--胡子 
									{"beefalowool",6},--牛毛 
									{"honeycomb",1},--蜂巢 
									{"stinger",10},--蜂刺 
									{"feather_crow",3},--乌鸦羽毛 
									{"feather_robin",3},--红雀羽毛 
									{"feather_robin_winter",2},--雪雀羽毛 
									{"horn",1},--牛角 
									{"slurtleslime",10},--蜗牛液 
									{"slurtle_shellpieces",10},--蜗牛龟壳片 
									{"butterflywings",3},--蝴蝶翅膀
									{"glommerwings",1},--格罗门翅膀 
									--{"glommerflower",},--格罗门花 
									{"glommerfuel",1},--格罗门燃料 
									-- {"boneshard",320},--硬骨头 
									{"ice",20},--冰 
									{"goldnugget",2},--金子
									{"nightmarefuel",1},--噩梦燃料
									{"moonrocknugget",1},--月之石
									{"livinglog",1},--活木
									{"monstermeat",5},--好吃不贵
									{"spoiled_food",30},--腐烂食物 
									{"monstermeat_dried",6},--干疯肉
									{"red_cap",10},--采摘的红蘑菇 
									{"red_cap_cooked",10},--煮熟的红蘑菇 
									{"durian",5},--榴莲 
									{"rottenegg",10},--烂鸡蛋 
									{"durian_cooked",5},--熟榴莲 
									{"poop",66},--便便 
									{"guano",33},--鸟粪 
									{"wathgrithrhat",1},--女武神帽	
									{"boomerang",1},--回旋镖 
									{"tentaclespike",1},--狼牙棒 
									{"blowdart_pipe",1},--吹箭 
									{"blowdart_sleep",1},--麻醉吹箭 
									{"blowdart_fire",1},--燃烧吹箭 
									{"hambat",1},--火腿短棍 
									{"footballhat",1},--猪皮帽 
									{"nightsword",1},--暗影剑 
									{"batbat",1},--蝙蝠棒 
									{"ruins_bat",1},--远古短棒 
									{"spear_wathgrithr",1},--瓦丝格雷斯矛 
									{"armormarble",1},--大理石盔甲 
									{"armor_sanity",1},--夜魔盔甲 
									{"armorsnurtleshell",1},--蜗牛龟盔甲 
									{"armorruins",1},--远古盔甲 
									{"ruinshat",1},--远古盔甲 
									{"gunpowder",1},--火药 
									{"heatrock",1},--保温石
									{"strawhat",1},--草帽 
									{"flowerhat",1},--花环 
									{"beefalohat",1},--牛毛帽 
									{"featherhat",1},--羽毛帽 
									{"tophat",1},--高礼帽 
									{"earmuffshat",1},--兔耳罩 
									{"winterhat",1},--冬帽 
									{"minerhat",1},--矿工帽 
									{"spiderhat",1},--蜘蛛帽 
									{"beehat",1},--蜂帽 
									{"walrushat",1},--海象帽 
									{"slurtlehat",1},--蜗牛帽子 
									{"bushhat",1},--丛林帽 
									{"rainhat",1},--防雨帽 
									{"icehat",1},--冰帽 
									{"watermelonhat",1},--西瓜帽 
									{"catcoonhat",1},--浣熊帽 
									{"sweatervest",1},--小巧背心 
									{"trunkvest_summer",1},--夏日背心 
									{"trunkvest_winter",1},--寒冬背心 
									{"armorslurper",1},--饥饿腰带 
									{"raincoat",1},--雨衣 
									{"molehat",1},--鼹鼠帽 
									{"armordragonfly",1},--蜻蜓盔甲 
									{"beargervest",1},--熊背心 
									{"eyebrellahat",1},--眼睛帽 
									{"hawaiianshirt",1},--夏威夷衬衫 
		
		
					}	
	},
    {
        name = "lalalala",
        label = "lueluelue",
        hover = "气死我了",
        options = 
        {
            {description = "No(关闭)", data = false},
            {description = "Yes(打开)", data = true},
        },
        default = false,
    },	
}


