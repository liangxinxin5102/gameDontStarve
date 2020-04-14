--The name of the mod displayed in the 'mods' screen.
name = "叠加上限99"

--A description of the mod.
description = "修改叠加数量上限，默认为99，最大可为250！ Anydong友情汉化"

author = "ChaosMind42 Anydong 汉化"
 
version = "1.62.h.0.1"

api_version = 10

-- Compatible with both the base game, reign of giants, and dst
dont_starve_compatible = true
reign_of_giants_compatible = true
dst_compatible = true

forumthread = ""

--These let clients know if they need to get the mod from the Steam Workshop to join the game
all_clients_require_mod = true
clients_only_mod = false

--This lets people search for servers with this mod by these tags
server_filter_tags = {"utility"}

-- ModConfiguration option
configuration_options =
{
	{
		name = "MAXSTACKSIZE",
		label = "最大叠加上限设置",
		options =	{
						{description = "20", data = 20},
						{description = "40", data = 40},
						{description = "60", data = 60},
						{description = "80", data = 80},
						{description = "99", data = 99},
						{description = "120", data = 120},
						{description = "150", data = 150},
						{description = "200", data = 200},
						{description = "250", data = 250},
					},

		default = 99,
	},
}

priority = 0.00374550642