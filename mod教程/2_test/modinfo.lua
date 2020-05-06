name = "西米护甲蘑菇帽"
description = [[
开启MOD后蘑菇帽子可以制造作为盔甲。其他人物可以制造女武神头盔

有问题请联系作者 Destiny&苏羽小西米。
			  ]]
author = "Destiny&苏羽小西米"
version = "1.0.1"
forumthread = ""

api_version = 10

icon_atlas = "modicon.xml"
icon = "modicon.tex"

reign_of_giants_compatible = true
dont_starve_compatible = true
all_clients_require_mod = true
client_only_mod = false
dst_compatible = true




configuration_options =
{
	{
		name = "REDMUSHROOM_PF",
		label = "红蘑菇帽制造",
		hover = "开启后可制造红蘑菇帽",
		options =
		{
			{description = "开启(默认)", data = true},
			{description = "关闭", data = false},
		},
		default = true,
	},
	{
		name = "GREENMUSHROOM_PF",
		label = "绿蘑菇帽制造",
		hover = "开启后可制造绿蘑菇帽",
		options =
		{
			{description = "开启(默认)", data = true},
			{description = "关闭", data = false},
		},
		default = true,
	},
	{
		name = "BLUEMUSHROOM_PF",
		label = "蓝蘑菇帽制造",
		hover = "开启后可制造蓝蘑菇帽",
		options =
		{
			{description = "开启(默认)", data = true},
			{description = "关闭", data = false},
		},
		default = true,
	},
	{
		name = "ALLWATHGRITHR_PF",
		label = "女武神头盔制造",
		hover = "开启后可制造女武神头盔",
		options =
		{
			{description = "开启(默认)", data = true},
			{description = "关闭", data = false},
		},
		default = true,
	}
}
