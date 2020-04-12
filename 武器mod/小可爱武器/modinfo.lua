name = "小可爱武器"
description =
[[修改了制作难度，自用于风滚草服务器。
 小可爱帽子就是骨头头盔，修改了属性外观。
 赤羽之矛：初始攻击30，攻击距离2，可**龙蝇升级。制作困难
 寒羽之刃：初始攻击30，攻击可冰冻，可**巨鹿升级。制作困难
 上九之杖：攻击100，距离6，攻击可冰冻，佩戴发光。制造超级困难
 小可爱之翼：小偷包加些许高级材料制作，18格大背包
]]
author = "落落大方"
version = "1.6.0"

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
        name = "finiteus",
        label = "关闭耐久度",
        options =
        {
            {description = "危险", data = true, hover = "测试专用危险勿开"},
            {description = "无耐久", data = false, hover = "武器无耐久"},
        },
        default = false,
    },
  {
        name = "newweapon",
        label = "开启神器制作",
        options =
        {
            {description = "开启", data = true, hover = "神器可制作"},
            {description = "关闭", data = false, hover = "不开启"},
        },
        default = false,
    },

 }

