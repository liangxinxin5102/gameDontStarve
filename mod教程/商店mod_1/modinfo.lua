name = "商店"
description =
[[
远古徽章和科技二本打开回收材料
]]
author = "皮妈妈"
version = "1.2.6"

forumthread = ""

api_version = 10

all_clients_require_mod = true

client_only_mod = false

dst_compatible = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"


server_filter_tags = {}

configuration_options =
{

  {
        name = "weapon",
        label = "开启神器抽奖",
        options =
        {
            {description = "开启", data = true, hover = "需要同时开启【一键开服】"},
            {description = "关闭", data = false, hover = "不开启"},
        },
        default = false,
    },

{
name = "ewai",
label = "ewai",
default = 	{
--自行添加
}
},
{
name = "ziyuan",
label = "ziyuan",
default = 	{
{"cutgrass",10},--草
{"stinger",10},--蜂刺
{"twigs",10},--树枝
{"log",10},--木头
{"petals",10},--花瓣
{"pinecone",10},--松果
{"foliage",10},--叶子
{"charcoal",20},--木炭
{"ice",20},--冰
{"rocks",50},--岩石
{"flint",50},--燧石
{"silk",30},--蜘蛛丝
{"lightbulb",20},--荧光果
{"slurtleslime",20},--蜗牛龟粘液
{"slurtle_shellpieces",20},--蜗牛龟壳片
{"nitre",30},--硝石
{"goldnugget",30},--金子
{"beefalowool",30},--牛毛
{"poop",60},--便便
{"guano",60},--鸟粪
{"pigskin",60},--猪皮
{"manrabbit_tail",60},--兔人尾巴
{"marble",60},--大理石
{"cutlichen",60},--摘下的苔藓
{"goose_feather",60},--鸭毛
{"horn",60},--牛角
{"feather_crow",60},--乌鸦羽毛
{"feather_robin",60},--红雀羽毛
{"feather_robin_winter",60},--雪雀羽毛
{"butterflywings",100},--蝴蝶翅膀
{"glommerfuel",100},--格罗门燃料
{"dug_sapling",100},--树苗
{"dug_berrybush",100},--浆果丛
{"dug_grass",100},--草根
{"beardhair",100},--胡子
{"boneshard",120},--硬骨头
{"honeycomb",200},--蜂巢
{"houndstooth",200},--犬牙
{"wormlight",200},--虫子果
{"nightmarefuel",200},--噩梦燃料
{"thulecite_pieces",200},--铥矿碎片
{"lureplantbulb",500},--食人花种子
{"gears",500},--齿轮
{"steelwool",500},--刚羊毛
{"bernie_inactive",500},--伯尼
{"lightninggoathorn",600},--电羊角
{"slurper_pelt",600},--吞噬者皮
{"redgem",600},--红宝石
{"bluegem",600},--蓝宝石
{"walrus_tusk",1000},--海象牙
{"glommerwings",1000},--格罗门翅膀
{"moonrocknugget",1000},--月之石
{"livinglog",1000},--活木
{"thulecite",1000},--铥矿
{"purplegem",1000},--紫宝石
{"lucky_goldnugget",1000},--元宝
{"orangegem",2000},--橙宝石
{"yellowgem",2000},--黄宝石
{"dragon_scales",2000},--龙蝇皮
{"bearger_fur",2000},--熊皮
{"deerclops_eyeball",2000},--眼球
{"shroom_skin",2000},--蛤蟆皮
{"atrium_key",30000},--远古钥匙
}
},
{
name = "fight",
label = "fight",
default = 	{
{"boomerang",200},--回旋镖
{"tentaclespike",200},--狼牙棒
{"blowdart_pipe",200},--吹箭
{"blowdart_sleep",200},--麻醉吹箭
{"blowdart_fire",200},--燃烧吹箭
{"hambat",300},--火腿短棍
{"footballhat",300},--猪皮帽
{"gunpowder",400},--火药
{"batbat",600},--蝙蝠棒
{"nightsword",800},--暗影剑
{"armormarble",1000},--大理石盔甲
{"armor_sanity",1000},--夜魔盔甲
{"ruinshat",1000},--远古盔甲
{"armordragonfly",1200},--蜻蜓盔甲
{"slurtlehat",1200},--蜗牛帽子
{"armorruins",1400},--远古盔甲
{"armorsnurtleshell",1500},--蜗牛龟盔甲
{"ruins_bat",1500},--远古短棒


}
},
{
name = "cloth",
label = "cloth",
default = 	{
{"heatrock",200},--保温石
{"strawhat",200},--草帽
{"earmuffshat",200},--兔耳罩
{"flowerhat",200},--花环
{"winterhat",300},--冬帽
{"bushhat",400},--丛林帽
{"rainhat",400},--防雨帽
{"beefalohat",500},--牛毛帽
{"featherhat",500},--羽毛帽
{"tophat",500},--高礼帽
{"beehat",500},--蜂帽
{"watermelonhat",400},--西瓜帽
{"icehat",600},--冰帽
{"minerhat",800},--矿工帽
{"spiderhat",800},--蜘蛛帽
{"hawaiianshirt",1000},--夏威夷衬衫
{"trunkvest_summer",1000},--夏日背心
{"trunkvest_winter",1000},--寒冬背心
{"raincoat",1000},--雨衣
{"armorslurper",1500},--饥饿腰带
{"molehat",1500},--鼹鼠帽
{"beargervest",2000},--熊背心
{"eyebrellahat",2000},--眼睛帽
{"walrushat",2000},--海象帽


}
},
{
name = "shenqilist",
label = "shenqilist",
default = 	{
        { "moshi", 1 },
        { "lr_weapon_01", 1 },
        { "lr_weapon_02", 1 },
        { "lr_weapon_03", 1 },
		{ "lr_weapon_04", 1 },
        { "lr_weapon_05", 1 },
        { "lr_weapon_06", 1 },
        { "lr_weapon_07", 1 },
        { "lr_weapon_08", 1 },
		{ "lr_weapon_09", 1 },
        { "lr_weapon_10", 1 },
        { "lr_weapon_11", 1 },
		{ "lr_weapon_12", 1 },
        { "lr_weapon_13", 1 },
        { "lr_weapon_14", 1 },
        { "lr_weapon_15", 1 },
        { "lr_weapon_16", 1 },
	    { "lr_weapon_17", 1 },
        { "lr_weapon_18", 1 },
        { "lr_weapon_19", 1 },
        { "lr_weapon_20", 1 },
		{ "witch_hat", 1 },
        { "pipi_ycb", 1 },
        { "pipi_glass", 1 },
        { "pipi_bag", 1 },
        { "bookmoose", 1 },
        { "bookdeerclops", 1 },
        { "bookbearger", 1 },
        { "bookdragonfly", 1 },

}
},
{
name = "shiwu",
label = "shiwu",
default = 	{
{"spoiled_food",10},--腐烂食物
{"wetgoop",10},--（湿腻焦糊）
{"acorn",30},--橡果
{"berries",10},--浆果
{"smallmeat",50},--小肉
{"drumstick",50},--鸡腿
{"froglegs",50},--蛙腿
{"plantmeat",50},--食人花肉
{"pumpkin",50},--南瓜
{"pomegranate",50},--石榴
{"corn",50},--玉米
{"eggplant",50},--茄子
{"cave_banana",50},--洞穴香蕉
{"rottenegg",50},--烂鸡蛋
{"red_cap",50},--采摘的红蘑菇
{"green_cap",60},--采摘的绿蘑菇
{"blue_cap",60},--采摘的蓝蘑菇
{"honey",60},--蜂蜜
{"batwing",100},--蝙蝠翅膀
{"durian",100},--榴莲
{"cactus_meat",100},--仙人掌肉
{"watermelon",100},--西瓜
{"meat",100},--大肉
{"fish",100},--鱼
{"jammypreserves",120},	--（果酱蜜饯）
{"pumpkincookie",150},	--（南瓜饼）
{"kabobs",100},	--肉串
{"eel",200},--鳗鱼
{"taffy",200},	--太妃糖
{"frogglebunwich",200},	--（青蛙圆面包三明治）
{"watermelonicle",200},        --	（西瓜冰）
{"baconeggs",200},	--（鸡蛋火腿）
{"stuffedeggplant",200},--	（香酥茄盒）
{"fruitmedley",200},	---（水果拼盘）
{"flowersalad",250},           --（花沙拉）
{"turkeydinner",250},	--（火鸡正餐）
{"fishsticks",250},	--（鱼肉条）
{"honeynuggets",250},	--（甜蜜金砖）
{"bonestew",250},	--（肉汤）
{"butter",300},--黄油
{"fishtacos",300},	--（玉米饼包炸鱼）
{"butterflymuffin",300},	--（奶油松饼）
{"perogies",350},	--（半圆小酥饼）
{"honeyham",360},	--（蜜汁火腿）
{"goatmilk",400},--羊奶
{"dragonpie",450},	--（龙馅饼）
{"unagi",500},	           --（鳗鱼料理）
{"icecream",600},	        --（冰激淋）
{"waffles",600}, 	--（华夫饼）
{"mandrake",1000},	--（曼德拉草


}
},
{
name = "prizelist",
label = "prizelist",
default = 	{
{"spoiled_food",1},--腐烂食物
{"monsterlasagna",1},--（怪物千层饼）
{"jammypreserves",1},	--（果酱蜜饯）
{"pumpkincookie",1},	--（南瓜饼）
{"kabobs",1},	--肉串
{"eel",1},--鳗鱼
{"taffy",1},	--太妃糖
{"frogglebunwich",1},	--（青蛙圆面包三明治）
{"watermelonicle",1},        --	（西瓜冰）
{"baconeggs",1},	--（鸡蛋火腿）
{"stuffedeggplant",1},--	（香酥茄盒）
{"fruitmedley",1},	---（水果拼盘）
{"flowersalad",1},           --（花沙拉）
{"turkeydinner",1},	--（火鸡正餐）
{"fishsticks",1},	--（鱼肉条）
{"honeynuggets",1},	--（甜蜜金砖）
{"bonestew",1},	--（肉汤）
{"butter",1},--黄油
{"fishtacos",1},	--（玉米饼包炸鱼）
{"butterflymuffin",1},	--（奶油松饼）
{"perogies",1},	--（半圆小酥饼）
{"honeyham",1},	--（蜜汁火腿）
{"goatmilk",1},--羊奶
{"dragonpie",1},	--（龙馅饼）
{"unagi",1},	           --（鳗鱼料理）
{"icecream",1},	        --（冰激淋）
{"waffles",1}, 	--（华夫饼）
{"mandrake",1},	--（曼德拉草
{"heatrock",1},--保温石
{"strawhat",1},--草帽
{"earmuffshat",1},--兔耳罩
{"flowerhat",1},--花环
{"winterhat",1},--冬帽
{"bushhat",1},--丛林帽
{"rainhat",1},--防雨帽
{"beefalohat",1},--牛毛帽
{"featherhat",1},--羽毛帽
{"tophat",1},--高礼帽
{"beehat",1},--蜂帽
{"watermelonhat",1},--西瓜帽
{"icehat",1},--冰帽
{"minerhat",1},--矿工帽
{"spiderhat",1},--蜘蛛帽
{"hawaiianshirt",1},--夏威夷衬衫
{"trunkvest_summer",1},--夏日背心
{"trunkvest_winter",1},--寒冬背心
{"raincoat",1},--雨衣
{"armorslurper",1},--饥饿腰带
{"molehat",1},--鼹鼠帽
{"beargervest",1},--熊背心
{"eyebrellahat",1},--眼睛帽
{"walrushat",1},--海象帽
{"boomerang",1},--回旋镖
{"tentaclespike",1},--狼牙棒
{"blowdart_pipe",1},--吹箭
{"blowdart_sleep",1},--麻醉吹箭
{"blowdart_fire",1},--燃烧吹箭
{"hambat",1},--火腿短棍
{"footballhat",1},--猪皮帽
{"gunpowder",1},--火药
{"batbat",1},--蝙蝠棒
{"nightsword",1},--暗影剑
{"armormarble",1},--大理石盔甲
{"armor_sanity",1},--夜魔盔甲
{"ruinshat",1},--远古盔甲
{"armordragonfly",1},--蜻蜓盔甲
{"slurtlehat",1},--蜗牛帽子
{"armorruins",1},--远古盔甲
{"armorsnurtleshell",1},--蜗牛龟盔甲
{"ruins_bat",1},--远古短棒
{"honeycomb",1},--蜂巢
{"houndstooth",1},--犬牙
{"wormlight",1},--虫子果
{"nightmarefuel",1},--噩梦燃料
{"thulecite_pieces",1},--铥矿碎片
{"lureplantbulb",1},--食人花种子
{"gears",1},--齿轮
{"steelwool",1},--刚羊毛
{"bernie_inactive",1},--伯尼
{"lightninggoathorn",1},--电羊角
{"slurper_pelt",1},--吞噬者皮
{"redgem",1},--红宝石
{"bluegem",1},--蓝宝石
{"moonrocknugget",1},--月之石
{"livinglog",1},--活木
{"thulecite",1},--铥矿
{"purplegem",1},--紫宝石
{"orangegem",1},--橙宝石
{"yellowgem",1},--黄宝石

}
},

}

