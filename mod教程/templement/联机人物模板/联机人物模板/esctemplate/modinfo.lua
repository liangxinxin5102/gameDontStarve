-- This information tells other players more about the mod
name = "Extended Sample Character"  ---mod名字
description = "A character template for Don't Starve Together. Skins compatible version."  --mod描述
author = "Dragon Wolf Leo" --作者
version = "1.2.3" -- mod版本 上传mod需要两次的版本不一样

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = "/files/file/950-extended-sample-character/"


-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true --兼容联机

-- Not compatible with Don't Starve
dont_starve_compatible = false --不兼容原版
reign_of_giants_compatible = false --不兼容巨人DLC

-- Character mods need this set to true
all_clients_require_mod = true --所有人mod

icon_atlas = "modicon.xml" --mod图标
icon = "modicon.tex"

-- The mod's tags displayed on the server list
server_filter_tags = {  --服务器标签
"character",
}

--configuration_options = {} --mod设置