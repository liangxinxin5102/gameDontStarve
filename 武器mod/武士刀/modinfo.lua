name = "武士刀"
description =
[[在武器栏的最下面可制作武士刀 武士刀初始攻击力为10 装备武士刀速度提升百分之20（固定） 杀死生物升级（攻击力上限和升级难度可以调）升级提高攻击力和砍树挖矿等的效率，到达一定等级具有吸血能力 
在攻击力小于35时当玩家持有武器死亡时增加5点攻击力（攻击>35后无效果）
杀死特定生物除基本加的攻击力外额外增加攻击力:猪人、兔人、鱼人+1，（海象爸爸、发条主教、无眼鹿、发条战车、发条骑士、闪电羊、高鸟、牛）+2，树精+5、钢羊+10,（蜘蛛女王、座狼、熊、鹿、鸭）+20，（龙蝇、女王蜂、毒菇、远古犀牛)+100
]]
author = "WD fack"
version = "1.1.1"

forumthread = ""

api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true


icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {}

configuration_options =
{  
    {
        name = "sx",
        label = "武士刀攻击力上限",
        options =   {
                        {description = "50", data = 40},
                        {description = "80", data = 70},
						{description = "100", data = 90},
						{description = "200", data = 190},
						{description = "300", data = 290},
						{description = "400", data = 390},
						{description = "500", data = 490},
                        {description = "1000(默认)", data = 990},
						{description = "5000", data = 4990},
						{description = "一万", data = 9990},
						{description = "十万", data = 99990},
						{description = "一百万", data = 999990},
						{description = "一千万", data = 9999990},
						{description = "一亿", data = 99999990},
                  
                    },
        default = 990,
    },
	
   {
        name = "xxs",
        label = "武士刀升级难度",
        options =   {
                        {description = "小学生", data = 1},
                        {description = "一般难度", data = .5},
						{description = "普通难度", data = .2},
						{description = "老司机", data = .1},
						{description = "究极难度", data = .01},
						
                    },
        default = .5,
     },
	 
	 	{
		name = "bb",
		label = "储存功能",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
	
	{
		name = "bx",
		label = "储存保鲜",
		options =
		{
			{description = "开启", data = true},
			{description = "关闭(默认)", data = false},
		},
		default = false,
	},
    
	{
        name = "Chop",
        label = "可砍树",
        options =   {
                        {description = "开启", data = true},
                        {description = "关闭(默认)", data = false},
                    },
        default = false,
    },
    
    {
        name = "Mine",
        label = "可挖矿",
        options =   {
                        {description = "开启", data = true},
                        {description = "关闭(默认)", data = false},
                    },
        default = false,
    },

    {
        name = "Dig",
        label = "可铲",
        options =   {
                        {description = "开启", data = true},
                        {description = "关闭(默认)", data = false},
                    },
        default = false,
    },
	
	{
        name = "Hammer",
        label = "可锤",
        options =   {
                        {description = "开启", data = true},
                        {description = "关闭(默认)", data = false},
                    },
        default = false,
    },
	
	
	
	{
        name = "sl",
        label = "武士刀的制作难度",
        options =   {
                        {description = "低", data = 10},
                        {description = "中", data = 20},
						{description = "高（默认）", data = 50},
                   
                    },
        default = 50,
    },

 }

