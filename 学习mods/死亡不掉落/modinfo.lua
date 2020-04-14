name = " Don't Drop Everything"
author = "伤"
old_ver = "1.0"
version = "1.1"
description = "Mod version:"..version.."     当前版本："..version.."     Old version:"..old_ver..
"\n\n·Death will not drop all the items."..
"\n\n·死亡后变成灵魂将不掉落全部物品，灵魂复活后基本不用特意去捡尸体了"..
"\n·救赎之心复活需要身上至少有一格空闲，死亡会必然掉一格以上的物品（这是随机的，可以自行配置）"..
"\n·背包和背包里的物品是不会掉落的，为PvP玩家考虑以后会加上随机掉背包的物品(当然可以自行配置)，敬请期待！"

forumthread = ""
api_version = 10

dst_compatible = true
--dont_starve_compatible = true
--reign_of_giants_compatible = true

client_only_mod = false
all_clients_require_mod = false

icon_atlas = "DropEverything.xml"
icon = "DropEverything.tex"

configuration_options = 
{
  {name="kong",label="项目\n\n",options={{description ="选择数字",data = 0,}},default=0,},
    {
        name = "mindiaoluo",
        label = "Minimum\n最小掉落",
        hover = "The smallest drop number on death.\n最小掉落的物品格数",
        options =
        {
            {description = "None", data = 0, hover = "无"},
            {description = "1",  data = 1,  hover = "注意不要超过最大掉落，可以相等"},
            {description = "2",  data = 2,  hover = ""},
            {description = "3",  data = 3,  hover = ""},
            {description = "4",  data = 4,  hover = ""},
            {description = "5",  data = 5,  hover = ""},
            {description = "6",  data = 6,  hover = ""},
            {description = "7",  data = 7,  hover = ""},
            {description = "8",  data = 8,  hover = ""},
            {description = "9",  data = 9,  hover = ""},
            {description = "10", data = 10, hover = ""},
            {description = "11", data = 11, hover = ""},
            {description = "12", data = 12, hover = ""},
            {description = "13", data = 13, hover = ""},
            {description = "14", data = 14, hover = ""},
            {description = "15", data = 15, hover = ""}
        },
        default = 1,
    },
    {
        name = "maxdiaoluo",
        label = "Maximum\n最大掉落",
        hover = "The biggest drop number on death.\n最大掉落的物品格数",
        options =
        {
            {description = "None", data = 0, hover = "无"},
            {description = "1",  data = 1,  hover = "注意不要低于最小掉落，可以相等"},
            {description = "2",  data = 2,  hover = ""},
            {description = "3",  data = 3,  hover = ""},
            {description = "4",  data = 4,  hover = ""},
            {description = "5",  data = 5,  hover = ""},
            {description = "6",  data = 6,  hover = ""},
            {description = "7",  data = 7,  hover = ""},
            {description = "8",  data = 8,  hover = ""},
            {description = "9",  data = 9,  hover = ""},
            {description = "10", data = 10, hover = ""},
            {description = "11", data = 11, hover = ""},
            {description = "12", data = 12, hover = ""},
            {description = "13", data = 13, hover = ""},
            {description = "14", data = 14, hover = ""},
            {description = "15", data = 15, hover = ""}
        },
        default = 4,
    },
}