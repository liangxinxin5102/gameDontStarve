
name = "6格装备栏"
description = "增加了一个背包，护身符和指南针的插槽游戏。."
author = "（萌主搬运汉化）"
version = "2.5.0"

forumthread = ""

api_version = 10
priority = 10

--This lets the clients know that they need to download the mod before they can join a server that is using it.
all_clients_require_mod = true

--This let's the game know that this mod doesn't need to be listed in the server's mod listing
client_only_mod = false

--Let the mod system know that this mod is functional with Don't Starve Together
dont_starve_compatible = true
reign_of_giants_compatible = true
dst_compatible = true

--These tags allow the server running this mod to be found with filters from the server listing screen
server_filter_tags = {"extra equip slot eqs"}

icon_atlas = "preview.xml"
icon = "preview.tex"

configuration_options =
{
    {
        name = "slots_count",
        label = "额外的插槽开关",
        options = 
        {
            {description = "关", data = 1.25},
            {description = "1", data = 1.33},
			{description = "2", data = 1.4},
        }, 
        default = 1.25,
    },
	
	{
        name = "compass_state",
        label = "指南针槽开关",
        options = 
        {
            {description = "关", data = 2},
			{description = "开", data = 1},
        }, 
        default = 1,
    },
}