GLOBAL.setmetatable(env,{__index=function (t,k) return GLOBAL.rawget(GLOBAL,k) end})
modimport "lib_ver.lua"
modimport"scripts/goodsinfodata.lua"
goodsinfo[1]= GetModConfigData("ziyuan")
goodsinfo[2]= GetModConfigData("fight")
goodsinfo[3]= GetModConfigData("cloth")
goodsinfo[4]= GetModConfigData("shiwu")
prizelist= GetModConfigData("prizelist")
jieshaopanduan= GetModConfigData("jieshao")
TUNING.GRASSGEKKO_MORPH_CHANCE = 0



local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH
local STRINGS = GLOBAL.STRINGS
local IsServer = GLOBAL.TheNet:GetIsServer()
local Vector3 = GLOBAL.Vector3
local containers = require("containers")
local TheNet= GLOBAL.TheNet

local require=GLOBAL.require
local Cy_store=require("widgets/cy_store")


modimport"scripts/tou_xian.lua"
PrefabFiles = 
{
	"touxian",
	"quagmire_coins",
	"hj_wings",  --  c_give"hj_wings2"
	"ly_bag",     ---c_give"ly_bobbag"
	"lycoin",   --充值币
	"lyzcm001",  --白猫罐
	"lyzcm002",    ----红猫罐         --	c_give"lgq"
	"lgq",   ------
	"shenqi", -----	
	"chazi",                      -----c_give"newweapons"
	"newweapons",
	"rongguang",
	"zhenkong",
	"taidao",
	"ly_juanzhou",
	"hj_pokeball", 
	"hj_pokeball_base",
	"warg_altar",
	"hjzs",
	"hjall",
	"hjgroundlifts",
	"hjpoison",
	"huoji_yang",
	"lajidai",
	"coffee",
	"coffee_seeds",
	"dmgind",
	"fireflies",
	"redfireflies",
	"orangefireflies",
	"yellowfireflies",
	"greenfireflies",
	"bluefireflies",
	"cyanfireflies",
	"purplefireflies",
	"storeroom",
	"ly_fushi01",
	"ly_fushi02",
	"ly_fushi03",
	"zg_fx_mihawkhsqj",
	"yanse",
	"npc",
	----"npc1",
	"ly_qhs-chuanshuo",  ---c_give"ly_fushi01"
	"ly_qhs-xingyun",
	"jgb",
	"wharang_foxhat",
	"ly_b1",
	"ly_b2",
	"ly_mengpo",
	"tianhaizaolu",

}

Assets = {
    Asset("IMAGE", "images/wy.tex"),
    Asset("ATLAS", "images/wy.xml"),
    Asset("SOUNDPACKAGE", "sound/cycycy.fev"),
    Asset("SOUND", "sound/cycycy.fsb"),
	Asset("ANIM", "anim/dssjz.zip"),
	Asset("ANIM", "anim/ui_hj_wings_2x8.zip"),
   	Asset("IMAGE", "images/ly_bagbg2.tex"),
    Asset("ATLAS", "images/ly_bagbg2.xml"),
	Asset("ANIM", "anim/ly_bobbag.zip"),
	Asset("ANIM", "anim/ly_hehebag.zip"),
	Asset("ANIM", "anim/ly_zcm001.zip"),
	Asset("ANIM", "anim/ly_zcm002.zip"),
	Asset("ANIM", "anim/ly_zcm003.zip"),
	Asset("ANIM", "anim/zg_fx_mihawkhsqj.zip"),
	Asset("IMAGE", "images/inventoryimages/ly_zcm001.tex"),
    Asset("ATLAS", "images/inventoryimages/ly_zcm001.xml"),
	Asset("IMAGE", "images/inventoryimages/ly_zcm002.tex"),
    Asset("ATLAS", "images/inventoryimages/ly_zcm002.xml"),
	Asset("IMAGE", "images/inventoryimages/ly_zcm003.tex"),
    Asset("ATLAS", "images/inventoryimages/ly_zcm003.xml"),		
	--Asset("SOUNDPACKAGE", "sound/jile.fev"),
	--Asset("SOUND", "sound/jile.fsb"),	
	Asset("ATLAS", "images/hjball.xml"),
	Asset("ATLAS_BUILD", "images/hjball.xml", 256),
	Asset("ANIM", "anim/hjballbase.zip"),
	Asset( "IMAGE", "images/map_icons/chuansongyang.tex" ),
	Asset( "ATLAS", "images/map_icons/chuansongyang.xml" ),
	
	Asset("IMAGE", "images/inventoryimages/coffee.tex"),
	Asset("ATLAS", "images/inventoryimages/coffee.xml"),
	Asset("IMAGE", "images/inventoryimages/coffee_seeds.tex"),
	Asset("ATLAS", "images/inventoryimages/coffee_seeds.xml"),
	Asset("IMAGE", "images/inventoryimages/coffee_cooked.tex"),
	Asset("ATLAS", "images/inventoryimages/coffee_cooked.xml"),
	Asset("ANIM", "anim/coffee.zip"),
	Asset("ANIM", "anim/coffee_seeds.zip"),
	Asset("ANIM", "anim/coffee_cooked.zip"),
	
	  Asset("IMAGE", "images/back.tex"),
    Asset("ATLAS", "images/back.xml"),
    Asset("IMAGE", "images/neck.tex"),
    Asset("ATLAS", "images/neck.xml"),
	
	Asset("ATLAS", "minimap/storeroom.xml" ),
	Asset("ATLAS", "images/inventoryimages/storeroom.xml"),

 

	Asset("ATLAS", "images/background/background.xml"),
	Asset("IMAGE", "images/background/background.tex"),

	Asset("ATLAS", "images/hud/goodspos.xml"),
	Asset("IMAGE", "images/hud/goodspos.tex"),
	Asset("ATLAS", "images/hud/goodspos2.xml"),
	Asset("IMAGE", "images/hud/goodspos2.tex"),

	Asset("ATLAS", "images/hud/fuwuqijieshao.xml"),
	Asset("IMAGE", "images/hud/fuwuqijieshao.tex"),

	Asset("ATLAS", "images/hud/storeico.xml"),
	Asset("IMAGE", "images/hud/storeico.tex"),
	
	Asset("ATLAS", "images/hud/nextpage.xml"),
	Asset("IMAGE", "images/hud/nextpage.tex"),
	Asset("ATLAS", "images/hud/lastpage.xml"),
	Asset("IMAGE", "images/hud/lastpage.tex"),
	Asset("ATLAS", "images/hud/ziyuan.xml"),
	Asset("IMAGE", "images/hud/ziyuan.tex"),
	Asset("ATLAS", "images/hud/guanbi.xml"),
	Asset("IMAGE", "images/hud/guanbi.tex"),

	Asset("ATLAS", "images/hud/fight.xml"),
	Asset("IMAGE", "images/hud/fight.tex"),
	Asset("ATLAS", "images/hud/cloth.xml"),
	Asset("IMAGE", "images/hud/cloth.tex"),
	Asset("ATLAS", "images/hud/chenghao.xml"),
	Asset("IMAGE", "images/hud/chenghao.tex"),
	Asset("ATLAS", "images/hud/choujiang.xml"),
	Asset("IMAGE", "images/hud/choujiang.tex"),
	Asset("ATLAS", "images/hud/shiwu.xml"),
	Asset("IMAGE", "images/hud/shiwu.tex"),
	
	
	Asset("ATLAS", "images/hud/cant.xml"),
	Asset("IMAGE", "images/hud/cant.tex"),
	Asset("ATLAS", "images/hud/ok.xml"),
	Asset("IMAGE", "images/hud/ok.tex"),
	
	
	Asset("ATLAS", "images/hud/dalaoplease.xml"),
	Asset("IMAGE", "images/hud/dalaoplease.tex"),
	Asset("ATLAS", "images/hud/nothanks.xml"),
	Asset("IMAGE", "images/hud/nothanks.tex"),
	
	Asset("ATLAS", "images/hud/choujiang1.xml"),
	Asset("IMAGE", "images/hud/choujiang1.tex"),
	Asset("ATLAS", "images/hud/choujiang2.xml"),
	Asset("IMAGE", "images/hud/choujiang2.tex"),
	
	Asset("ATLAS", "images/hud/chenghaojieshao.xml"),
	Asset("IMAGE", "images/hud/chenghaojieshao.tex"),
	Asset("ATLAS", "images/hud/chenghaobt1.xml"),
	Asset("IMAGE", "images/hud/chenghaobt1.tex"),
    Asset("ATLAS", "images/hud/chenghaobt2.xml"),
	Asset("IMAGE", "images/hud/chenghaobt2.tex"),
	Asset("ATLAS", "images/hj_pokeball.xml"),
	Asset("IMAGE", "images/hj_pokeball.tex"),
	--Asset("SOUNDPACKAGE", "sound/hqg.fev"),
	--Asset("SOUND", "sound/hqg.fsb"),
	
 }

for var=1 , 9  do
	table.insert(Assets, Asset("ATLAS", "images/hud/info"..tostring(var)..".xml"))
    table.insert(Assets, Asset("IMAGE", "images/hud/info"..tostring(var)..".tex"))
end
AddMinimapAtlas("minimap/storeroom.xml")
AddMinimapAtlas("images/map_icons/chuansongyang.xml")
RemapSoundEvent( "dontstarve/zg/lgq", "liuguangqing/sound/lgq" )

if  TheNet:GetIsClient()then
 --客机接受指令
AddModRPCHandler("Cy_store", "buy", function() end)
AddModRPCHandler("Cy_store", "choujiang", function() end)
AddModRPCHandler("Cy_store", "chenghao",function()  end)
AddModRPCHandler("Cy_store", "chenghaohide",function()  end)
end
--获得物品测试
--player.components.inventory:GiveItem(GLOBAL.SpawnPrefab("log"))
 --主机接受指令
if not TheNet:GetIsClient()then
 
	AddModRPCHandler("Cy_store", "buy",function(player,buttonum,num) 
		if buttonum ~= nil and num ~= nil  and type(num) == "number" and type(buttonum) == "number" then
		
		if not goodsinfo[buttonum] or not goodsinfo[buttonum][num] then return end
		
			name = goodsinfo[buttonum][num][1] or "log"
			price = goodsinfo[buttonum][num][2] or 1
			if player.currenthuajicoin:value()>=price then
				player.components.Cy_trade:buy(player,name,price)
			else
				player.components.talker:Say("好好想一想，不找腐竹赞助，你怎么可能变强呢？QQ群361101313 找腐竹")
			end
		else
			TheNet:Announce("玩家【" .. player:GetDisplayName() .."】妄想使用奇怪指令炸服已被系统管理制裁！")
			TheNet:Ban(player.userid)							
		end
	end)
	AddModRPCHandler("Cy_store", "choujiang",function(player) 
	--随机一个物品作为奖品
		--print("rpc")

		local prizenum=math.floor(math.random(1,#prizelist)) 
		local prizename=prizelist[prizenum][001]
		local prizeamount=prizelist[prizenum][002]
		local choujiangfee=666666
		if player.currenthuajicoin:value()>= choujiangfee then
			player.components.Cy_trade:choujiang(player,choujiangfee,prizename,prizeamount) 
		else
			player.components.talker:Say("该充钱了")
		end

	end)

end

 --预运行
AddPlayerPostInit(function(inst)
	inst.currenthuajicoin = GLOBAL.net_uint(inst.GUID,"currenthuajicoin")
	inst.chenghaoCD=0
	inst:WatchWorldState("cycles", function (inst)inst.chenghaoCD=0 end)
	if GLOBAL.TheWorld.ismastersim then
	inst:AddComponent("Cy_trade")	
	end	
	inst.xxlevel = 0
end)
		
--UI尺寸
local function PositionUI(self, screensize)
	local hudscale = self.top_root:GetScale()
	self.Cy_store:SetScale(.72*hudscale.x,.72*hudscale.y,1)
	self.Cy_store:SetPosition(0,300*hudscale.y,0)
end

--UI
local Cy_store = require("widgets/cy_store")
local function Addstore(self)
    self.Cy_store = self.top_root:AddChild(Cy_store(self.owner,goodsinfo,jieshaopanduan))
    local screensize = {GLOBAL.TheSim:GetScreenSize()}
    PositionUI(self, screensize)
    self.Cy_store:SetHAnchor(0)
    self.Cy_store:SetVAnchor(0)
    --H: 0=中间 1=左端 2=右端
    --V: 0=中间 1=顶端 2=底端
    self.Cy_store:MoveToFront()
    local OnUpdate_base = self.OnUpdate
	self.OnUpdate = function(self,dt)
		OnUpdate_base(self,dt)
		local curscreensize = {GLOBAL.TheSim:GetScreenSize()}
		if curscreensize[1] ~= screensize[1] or curscreensize[2] ~= screensize[2] then
			PositionUI(self, curscreensize)
			screensize = curscreensize
		end
	end
end

AddClassPostConstruct("widgets/controls",Addstore)


AddRecipe("ly_qhs-chuanshuo",  --添加物品的配方
   {Ingredient("redgem", 60) ,Ingredient("opalpreciousgem", 15)   },  --材料
    RECIPETABS.WAR,  TECH.NONE,  
nil, nil, nil, nil, nil,  "images/inventoryimages/ly_qhs-chuanshuo.xml",  "ly_qhs-chuanshuo.tex")

AddRecipe("ly_fushi03",  --添加物品的配方
   {Ingredient("greengem", 20) ,Ingredient("bluegem", 20)   },  --材料
    RECIPETABS.WAR,  TECH.NONE,  
nil, nil, nil, nil, nil,  "images/inventoryimages/ly_fushi03.xml",  "ly_fushi03.tex")





----------------------------------------背包 

local function newwings()
local params = {}
params.hj_wings1 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ui_hj_wings_2x8",
        pos = Vector3(-5, -120, 0),
    },
    issidewidget = true,
    type = "pack",
}

for y = 0, 6 do
	table.insert(params.hj_wings1.widget.slotpos, Vector3(-162-75, -75 * y + 240, 0))
    table.insert(params.hj_wings1.widget.slotpos, Vector3(-162, -75 * y + 240, 0))
    table.insert(params.hj_wings1.widget.slotpos, Vector3(-162 + 75, -75 * y + 240, 0))
end
-----
params.hj_wings2 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ui_hj_wings_2x8",
        pos = Vector3(-5, -120, 0),
    },
    issidewidget = true,
    type = "pack",
}

for y = 0, 6 do
	table.insert(params.hj_wings2.widget.slotpos, Vector3(-162-75, -75 * y + 240, 0))
    table.insert(params.hj_wings2.widget.slotpos, Vector3(-162, -75 * y + 240, 0))
    table.insert(params.hj_wings2.widget.slotpos, Vector3(-162 + 75, -75 * y + 240, 0))
end
params.hj_wings3 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ui_hj_wings_2x8",
        pos = Vector3(-5, -120, 0),
    },
    issidewidget = true,
    type = "pack",
}

for y = 0, 6 do
	table.insert(params.hj_wings3.widget.slotpos, Vector3(-162-75, -75 * y + 240, 0))
    table.insert(params.hj_wings3.widget.slotpos, Vector3(-162, -75 * y + 240, 0))
    table.insert(params.hj_wings3.widget.slotpos, Vector3(-162 + 75, -75 * y + 240, 0))
end
params.hj_wings4 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ui_hj_wings_2x8",
        pos = Vector3(-5, -120, 0),
    },
    issidewidget = true,
    type = "pack",
}

for y = 0, 6 do
	table.insert(params.hj_wings4.widget.slotpos, Vector3(-162-75, -75 * y + 240, 0))
    table.insert(params.hj_wings4.widget.slotpos, Vector3(-162, -75 * y + 240, 0))
    table.insert(params.hj_wings4.widget.slotpos, Vector3(-162 + 75, -75 * y + 240, 0))
end
params.hj_wings5 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_krampusbag_2x8",
        animbuild = "ui_hj_wings_2x8",
        pos = Vector3(-5, -120, 0),
    },
    issidewidget = true,
    type = "pack",
}

for y = 0, 6 do
	table.insert(params.hj_wings5.widget.slotpos, Vector3(-162-75, -75 * y + 240, 0))
    table.insert(params.hj_wings5.widget.slotpos, Vector3(-162, -75 * y + 240, 0))
    table.insert(params.hj_wings5.widget.slotpos, Vector3(-162 + 75, -75 * y + 240, 0))
end
local containers = GLOBAL.require "containers"
for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end

local containers = require("containers")
local oldwidgetsetup = containers.widgetsetup
	function containers.widgetsetup(container, prefab, data,...)
		local pref = prefab or container.inst.prefab
		if pref == "hj_wings1"  or pref == "hj_wings2"  or pref == "hj_wings3" or  pref == "hj_wings4" or  pref == "hj_wings5" 
		    or pref == "ly_bobbag" or pref == "ly_hehebag" or pref == "ly_wingbag" or pref == "ly_pandabag"     then
			local t = params[pref]
			if t ~= nil then
				for k, v in pairs(t) do
					container[k] = v
				end
			container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
			end
		else
		return oldwidgetsetup(container, prefab, data,...)
		end
	end
end
newwings()

STRINGS.NAMES.LY_FUSHI01= "武器强化石"    --名字
STRINGS.RECIPE_DESC.LY_FUSHI01 = "升级武器必备的道具"  --配方上面的描述
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LY_FUSHI01 = "武器强化石，升级武器必备的道具"  --人物检查的描述
STRINGS.NAMES.LY_FUSHI02= "无"    --名字
STRINGS.RECIPE_DESC.LY_FUSHI02 = "无"  --配方上面的描述
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LY_FUSHI02 = "暂时没用"  --人物检查的描述
--高级经验石
STRINGS.NAMES.LY_FUSHI03= "五行转换石"    --名字
STRINGS.RECIPE_DESC.LY_FUSHI03 = "五行转换石"  --配方上面的描述
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LY_FUSHI03 = "五行转换石，给予武器转换五行，以达到契合目的"  --人物检查的描述
STRINGS.NAMES.JGB= "乐园金箍棒"    --名字
STRINGS.RECIPE_DESC.JGB = "乐园金箍棒"  --配方上面的描述
STRINGS.CHARACTERS.GENERIC.DESCRIBE.JGB = "砍树挖矿必备工具"  --人物检查的描述

STRINGS.NAMES.LY_ZAOLU3X3 = "乐园造陆3X3"   --  c_give"ly_zaolu3x3"
STRINGS.NAMES.LY_ZAOLU9X9 = "乐园造陆9X9"
STRINGS.NAMES.LY_TIANHAI3X3 = "乐园填海3X3"
STRINGS.NAMES.LY_TIANHAI9X9 = "乐园填海9X9"
   -----wharang_foxhat

STRINGS.NAMES.WHARANG_FOXHAT = "狐仙面具"    --名字
STRINGS.RECIPE_DESC.WHARANG_FOXHAT = "狐仙面具"  --配方上面的描述
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WHARANG_FOXHAT = "我是可爱的小狐仙"  --人物检查的描述





STRINGS.NAMES.NPC= "乐园NPC"   
STRINGS.CHARACTERS.GENERIC.NPC = "排行榜NPC"  
STRINGS.NAMES.HJ_WINGS1= "火●鸡翅膀"   
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJ_WINGS1 = "灰呀灰呀灰"  
STRINGS.NAMES.HJ_WINGS2= "火●鸡翅膀"   
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJ_WINGS2 = "灰呀灰呀灰"
STRINGS.NAMES.HJ_WINGS3= "火●鸡翅膀"   
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJ_WINGS3 = "灰呀灰呀灰"
STRINGS.NAMES.HJ_WINGS4= "火●鸡翅膀"   
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJ_WINGS4 = "灰呀灰呀灰"
STRINGS.NAMES.HJ_WINGS5= "火●鸡翅膀"   
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJ_WINGS5 = "灰呀灰呀灰"
GLOBAL.STRINGS.NAMES.LGQ = "流光琴"
GLOBAL.STRINGS.RECIPE_DESC.LGQ = "东方流光琴，净化涅槃。代表“善”与“重生”之物"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.LGQ = "圆圈勾勒成指纹" 
GLOBAL.STRINGS.NAMES.LY_BOBBAG = "乐园●海绵背包"
GLOBAL.STRINGS.NAMES.LY_HEHEBAG = "乐园●滑稽背包"
GLOBAL.STRINGS.NAMES.LY_WINGBAG = "乐园●服主画的翅膀背包"
GLOBAL.STRINGS.NAMES.LY_PANDABAG = "乐园●熊猫背包"
GLOBAL.STRINGS.NAMES.LYZCM001 = "乐园·招财猫\n\n左键：交换\n右键：给予\n"
GLOBAL.STRINGS.NAMES.LYZCM002 = "乐园·进宝猫\n\n左键：交换\n右键：给予\n"
GLOBAL.STRINGS.NAMES.LYCOIN = "乐园· 现金\n百元充值币"
--武器
STRINGS.NAMES.NEWWEAPONS= "新手武器"    --名字
STRINGS.RECIPE_DESC.NEWWEAPONS = "大佬来做把武器吧"  --配方上面的描述
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEWWEAPONS = "打人老疼了"  --人物检查的描述

--武器
STRINGS.NAMES.RONGGUANG= "乐园专属神器●荣光"    --名字
STRINGS.RECIPE_DESC.RONGGUANG = "大佬来做把武器吧"  --配方上面的描述
STRINGS.CHARACTERS.GENERIC.DESCRIBE.RONGGUANG = "打人老疼了"  --人物检查的描述

--武器
STRINGS.NAMES.CHAZI= "乐园专属神器●鬼叉"    --名字
STRINGS.RECIPE_DESC.CHAZI = "大佬来做把武器吧"  --配方上面的描述
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CHAZI = "打人老疼了"  --人物检查的描述

--武器
STRINGS.NAMES.ZHENKONG= "乐园专属神器●真空"    --名字
STRINGS.RECIPE_DESC.ZHENKONG = "大佬来做把武器吧"  --配方上面的描述
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ZHENKONG = "打人老疼了"  --人物检查的描述

--武器
STRINGS.NAMES.TAIDAO= "乐园专属神器●太刀"    --名字
STRINGS.RECIPE_DESC.TAIDAO = "大佬来做把武器吧"  --配方上面的描述
STRINGS.CHARACTERS.GENERIC.DESCRIBE.TAIDAO = "打人老疼了"  --人物检查的描述
STRINGS.NAMES.LY_JUANZHOU= "乐园●鉴定石"    --名字
STRINGS.RECIPE_DESC.LY_JUANZHOU = "鉴定装备必备道具"  --配方上面的描述
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LY_JUANZHOU = "你有 我也有~"  --人物检查的描述
STRINGS.NAMES.HJ_POKEBALL = "精灵球"
STRINGS.RECIPE_DESC.HJ_POKEBALL = "精灵球"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJ_POKEBALL = "捕捉神奇宝贝"
STRINGS.NAMES.HJ_POKEDBALL = "精灵球"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJ_POKEDBALL = "捕捉神奇宝贝"

STRINGS.NAMES.HJ_JZPOKEBALL = "建筑打包球"
STRINGS.RECIPE_DESC.HJ_JZPOKEBALL = "建筑打包球"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJ_JZPOKEBALL = "移植建筑"
STRINGS.NAMES.HJ_JZPOKEDBALL = "建筑打包球"
STRINGS.RECIPE_DESC.HJ_JZPOKEDBALL = "建筑打包球"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJ_JZPOKEDBALL = "移植建筑"

STRINGS.NAMES.HJ_POKEBALL_BASE = "精灵球底座"
STRINGS.RECIPE_DESC.HJ_POKEBALL_BASE = "用来放置精灵球"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJ_POKEBALL_BASE = "会发光的哟"

STRINGS.NAMES.LY_MENGPO= "乐园孟婆汤"    --名字

STRINGS.CHARACTERS.GENERIC.ACTIONFAIL.HJ_POKE={
	NOPOCK = "该生物不可以捕捉！",
										}
STRINGS.CHARACTERS.GENERIC.ACTIONFAIL.HJ_JZPOKE={
	NOPOCK = "该建筑不可以打包！",
	NOQUAN = "权限不足不可以打包",
										}
										
STRINGS.CHARACTERS.GENERIC.ACTIONFAIL.HJ_UNBALL={
	NOQUAN = "权限不足,无法取出",
										}
STRINGS.CHARACTERS.GENERIC.ACTIONFAIL.HJ_BALL={
	NOQUAN = "权限不足，无法放置",
										}
---------
local function Update(inst, dt)
    if inst.components.perishable then
		
		local modifier = 1
		local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner or nil
        if not owner and inst.components.occupier then
            owner = inst.components.occupier:GetOwner()
        end

		if owner then
			if owner:HasTag("fridge") then
				if inst:HasTag("frozen") and not owner:HasTag("nocool") and not owner:HasTag("lowcool") then
					modifier = TUNING.PERISH_COLD_FROZEN_MULT
				else
					modifier = TUNING.PERISH_FRIDGE_MULT
				end
			elseif owner:HasTag("spoiler") then
				modifier = TUNING.PERISH_GROUND_MULT 
			elseif owner:HasTag("cage") and inst:HasTag("small_livestock") then
                modifier = TUNING.PERISH_CAGE_MULT
			elseif owner:HasTag("hjwings") then
                modifier = 0
			elseif owner:HasTag("icestoreroom") then
				if inst:HasTag("frozen") and not owner:HasTag("nocool") and not owner:HasTag("lowcool") then
					modifier = TUNING.PERISH_COLD_FROZEN_MULT
				else
					modifier = -10
				end
            end
		else
			modifier = TUNING.PERISH_GROUND_MULT 
		end

		if inst:GetIsWet() then
			modifier = modifier * TUNING.PERISH_WET_MULT
		end

		
		if TheWorld.state.temperature < 0 then
			if inst:HasTag("frozen") and not inst.components.perishable.frozenfiremult then
				modifier = TUNING.PERISH_COLD_FROZEN_MULT
			else
				modifier = modifier * TUNING.PERISH_WINTER_MULT
			end
		end

		if inst.components.perishable.frozenfiremult then
			modifier = modifier * TUNING.PERISH_FROZEN_FIRE_MULT
		end

		if TheWorld.state.temperature > TUNING.OVERHEAT_TEMP then
			modifier = modifier * TUNING.PERISH_SUMMER_MULT
		end

        modifier = modifier * inst.components.perishable.localPerishMultiplyer

		modifier = modifier * TUNING.PERISH_GLOBAL_MULT
		
		local old_val = inst.components.perishable.perishremainingtime
		local delta = dt or (10 + math.random()*FRAMES*8)
		if inst.components.perishable.perishremainingtime then 
			inst.components.perishable.perishremainingtime = inst.components.perishable.perishremainingtime - delta*modifier
	        if math.floor(old_val*100) ~= math.floor(inst.components.perishable.perishremainingtime*100) then
		        inst:PushEvent("perishchange", {percent = inst.components.perishable:GetPercent()})
		    end
		end

		if inst.components.edible and inst.components.edible.temperaturedelta and inst.components.edible.temperaturedelta > 0 then
			if owner and owner:HasTag("fridge") then
				if not owner:HasTag("nocool") then
					inst.components.edible.temperatureduration = inst.components.edible.temperatureduration - 1
				end
			elseif TheWorld.state.temperature < TUNING.OVERHEAT_TEMP - 5 then
				inst.components.edible.temperatureduration = inst.components.edible.temperatureduration - .25
			end
			if inst.components.edible.temperatureduration < 0 then inst.components.edible.temperatureduration = 0 end
		end
        
        --trigger the next callback
        if inst.components.perishable.perishremainingtime and inst.components.perishable.perishremainingtime <= 0 then
			inst.components.perishable:Perish()
        end
    end
end
local Perishable = require("components/perishable")
function Perishable:LongUpdate(dt)
    if self.updatetask ~= nil then
        Update(self.inst, dt or 0)
    end
end

function Perishable:StartPerishing()
    if self.updatetask ~= nil then
        self.updatetask:Cancel()
        self.updatetask = nil
    end

    local dt = 10 + math.random()*FRAMES*8
    self.updatetask = self.inst:DoPeriodicTask(dt, Update, math.random()*2, dt)
end

----
local dududu = {  --代码 --权重 --池塘投币

	--dragonfly = 50,  ----龙鹰
	fishtacos = 1285,  --鱼卷
    toadstool_dark = 55, ---悲剧毒菇
	--spat = 255,  --钢羊
	fish = 3100,--鱼
	eel = 3100,---鳗鱼
	--xxsq = 10,---神器
	hj_wings1 = 2,---翅膀
	hj_wings2 = 2,---翅膀
	--hj_wings3 = 1,---翅膀
	hj_wings4 = 2,---翅膀
	--hj_wings5 = 1,---翅膀
    lucky_goldnugget = 1600, --元宝 
	quagmire_coin1 = 800,   --铜币 
	quagmire_coin2 = 600,   --银币 
	quagmire_coin3 = 320,   --金币 
	quagmire_coin4 = 100,   --月币 
	hj_jzpokeball = 100,   --建筑打包球
	ly_juanzhou = 1500,   --鉴定卷轴
	newweapons = 1500,   --新手武器
	rongguang = 1000,   --rongguang 
	zhenkong = 433,   --zhenkong
	--chazi = 500,   --zhenkong
	--taidao = 333,   --zhenkong

	--hj_pokeball_base = 20,  --打包球
}

local function OnGetItemFromPlayer(inst, giver, item)
	inst.cangive = false
	inst:DoTaskInTime(2 / 3, function(inst) 
		local down = TheCamera:GetDownVec()
		local spawnangle = math.atan2(down.z, down.x)
		local angle = math.atan2(down.z, down.x) + (math.random()*90-45)*DEGREES
		local sp = math.random()*3+2
				
		local item = SpawnPrefab(weighted_random_choice(dududu))
		if item then
		if item.components.inventoryitem and not item.components.inventoryitem.health and item.Physics then
			local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(2*math.cos(spawnangle), 3, 2*math.sin(spawnangle))
			item.Transform:SetPosition(pt:Get())
			item.Physics:SetVel(sp*math.cos(angle), math.random()*2+9, sp*math.sin(angle))
		else
			local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(2*math.cos(spawnangle), 0, 2*math.sin(spawnangle))
			pt = pt + Vector3(sp*math.cos(angle), 0, sp*math.sin(angle))
			item.Transform:SetPosition(pt:Get())
			SpawnPrefab("collapse_small").Transform:SetPosition(pt:Get())
		end
		end
	end)
end

local function AcceptTest(inst, item, giver)
    return item.prefab == "lucky_goldnugget" and inst.cangive == true and inst.frozen ~= true
end
local function OnStartDay(inst)
	inst.cangive = true
end

AddPrefabPostInit("pond", function(inst)
    if not TheWorld.ismastersim then
        return inst
    end
	inst.cangive = true
    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(AcceptTest)
    inst.components.trader.onaccept = OnGetItemFromPlayer
	inst:WatchWorldState("startcaveday", OnStartDay)
	inst:WatchWorldState("startday", OnStartDay)
end)


local HJPOKE = {
	pigman  = true ,       ---猪人
	pigguard = true ,       ---猪人守卫
	merm	= true ,        --鱼人
	bunnyman = true ,  --兔人
	rabbit =true,   --兔子
	babybeefalo = true,  --小牛
	beefalo = true,  --牛
	walrus=true, --海象
	little_walrus =true, --小海象
	koalefant_summer =true ,--夏象
	koalefant_winter= true , --冬象
	lightninggoat = true, --电羊
	spat = true,--刚羊
	deer =  true , --无睛鹿
	deer_red =  true , --无睛鹿
	deer_blue =  true , --无睛鹿
	spider = true , --小蜘蛛
	spider_warrior = true , --蜘蛛战士
	spider_hider = true, --洞穴蜘蛛
	spider_spitter = true ,--喷射蜘蛛
	spider_dropper = true ,--白蜘蛛
	hound = true, --猎狗
	firehound = true, --猎狗  
	icehound = true, --猎狗
	smallbird = true,--小高鸟
	teenbird = true,
	tallbird = true,
	crow = true, --乌鸦
	robin = true, --红雀
	robin_winter = true ,--雪雀
	canary = true, --金丝雀
	perd = true,--火鸡
	penguin = true ,--企鹅
	frog = true,--青蛙
	mole = true,--鼹鼠
	glommer = true, --格罗姆
	catcoon = true, --小碗熊
	grassgekko = true,--草蜥蜴
	bee = true , --蜜蜂
	killerbee = true , -- 杀人蜂
	mosquito = true, --蚊子
	butterfly = true , --蝴蝶
	slurtle = true,
	snurtle = true,
	lavae = true,
	chester = true, --切斯特
	hutch = true,--哈奇
	krampus = true, --卡普斯
	ghost = true,--鬼魂
	lureplant = true,--食人花
	eyeplant = true,--食人花眼球
	knight = true ,--发条骑士
	bishop = true ,--主教
	rook = true,--战车
	crawlinghorror = true, --影怪
	crawlingnightmare = true,
	terrorbeak = true,
	nightmarebeak = true,
	--触手我要死了
	shadow_rook = true, --暗影
	shadow_bishop = true,
	shadow_knight = true ,
	bat = true , --蝙蝠
	rocky = true ,--石虾
	sluroer = true, --大坏人
	worm = true, --远古虫子
	spiderqueen = true,--蜘蛛女王
	leif = true,--树精
	leif_sparse  = true ,
	birchnutdrake = true ,--坚果精
	deciduoustree = true, --桦树精
	minotaur = true, --远古守护者
	moose = true,--鹅鹅鹅
	mossling = true,--小鹅
	--dragonfly = true,--龙龙
	bearger = true,--熊熊熊
	deerclops = true,
	beequeen =true,--蜜蜂女王
	beegurd = true,--守卫
	toadstool = true, --+1+!!+!+!+!+!
	toadstool_dark =true,--+1+!!+!+!+!+!
	klaus = true , --卡劳斯
	stalker_forest = true, --森林守护者
	stalker = true,
	--stalker_atrium = true,
	warg = true,--座狼
	buzzard = true,--秃鹫
	monkey = true ,--猴子
	rook_nightmare = true, --犀牛
	knight_nightmare = true, --骑士
	bishop_nightmare = true, --主教
}

---这里添加可以打包的建筑
local HJJZPOKE = {

	pighouse = true, --猪人房子
	birdcage = true, --鸟笼
	firepit = true,	--火堆
	researchlab1 = true, -- 四个科技
	researchlab2 = true, --
	researchlab3 = true, --
	researchlab4 = true, --
	tent = true,--帐篷
	cookpot = true,--锅
	icebox = true,--冰箱
	treasurechest = true , --木箱子
    krampus_sack = true , --坎普斯背包
	hj_wings1 = true,--背包
	hj_wings2 = true,--背包
	hj_wings3 = true,--背包
	hj_wings4 = true,--背包
	hj_wings5 = true,--背包
	ly_bobbag = true,--背包
	ly_hehebag = true,--背包
	ly_pandabag = true,--背包
	ly_wingbag = true,--背包
	cbdz0 = true,--背包
	cbdz1 = true,--背包
	cbdz2 = true,--背包
	cbdz3 = true,--背包
	cbdz4 = true,--背包
	cbdz5 = true,--背包
	cbdz6 = true,--背包
	cbdz7 = true,--背包
	cbdz8 = true,--背包
	xiaoyang_item = true,--背包
	xiaoyangbili = true,--背包
	eyeturret = true,--背包

}
for k,v in pairs(HJPOKE) do  
	table.insert(Assets, Asset("ANIM", "anim/poke_"..k..".zip"))
end
AddRecipe("hj_jzpokeball",
{Ingredient("lucky_goldnugget", 18),Ingredient("opalpreciousgem", 2)},
RECIPETABS.MAGIC,  TECH.SCIENCE_TWO,
nil, nil, nil, nil, nil, 
"images/hjball.xml",
"hj_jzpokeball.tex")

AddRecipe("hj_pokeball_base",
{Ingredient("lucky_goldnugget", 180),Ingredient("opalpreciousgem", 20)},
RECIPETABS.MAGIC,  TECH.SCIENCE_TWO,
"hj_pokeball_base_placer", 2, nil, nil, nil, 
"images/hjball.xml",
"hj_pokeball_base.tex")
-----poke
local HJ_POKE = GLOBAL.Action({priority = 5, distance=12, mount_valid=true})
local HJ_JZPOKE = GLOBAL.Action({priority = 5, distance=8, mount_valid=true})
local HJ_POKEOUT = GLOBAL.Action({priority = 5, distance=12, mount_valid=true})
local HJ_JZPOKEOUT = GLOBAL.Action({priority = 5, distance=8, mount_valid=true})
HJ_POKE.id = "HJ_POKE"
HJ_JZPOKE.id = "HJ_JZPOKE"
HJ_POKEOUT.id = "HJ_POKEOUT"
HJ_JZPOKEOUT.id = "HJ_JZPOKEOUT"
HJ_POKE.str = "捕捉"
HJ_POKEOUT.str = "释放"
HJ_JZPOKE.str = "打包"
HJ_JZPOKEOUT.str = "放置"

HJ_POKE.fn = function(act)
    if act.invobject and act.doer and act.target and HJPOKE[act.target.prefab]~= nil then
        if act.invobject.components.hjprojectile and act.doer.components.inventory then
            local projectile = act.doer.components.inventory:DropItem(act.invobject, false)
            if projectile then
                local pos = act.target:GetPosition()
                projectile.components.hjprojectile.targetoffset = {x=0,y=1.5,z=0}
				projectile.components.hjprojectile:Launch(pos, act.doer,act.target)
				return true
            end
        end
	else
		return false , "NOPOCK"
    end
end

HJ_JZPOKE.fn = function(act)
    if act.invobject and act.doer and act.target and HJJZPOKE[act.target.prefab]== true then
		if act.target.ownerlist ~= nil  and act.target.ownerlist.master  then
		if 	act.target.ownerlist.master ~= act.doer.userid then
			return false , "NOQUAN"
		end
        if act.invobject.components.hjjzprojectile and act.doer.components.inventory then
            local projectile = act.doer.components.inventory:DropItem(act.invobject, false)
            if projectile then
                local pos = act.target:GetPosition()
                projectile.components.hjjzprojectile.targetoffset = {x=0,y=1.5,z=0}
				projectile.components.hjjzprojectile:Launch(pos, act.doer,act.target)
				return true
            end
        end
		else
        if act.invobject.components.hjjzprojectile and act.doer.components.inventory then
            local projectile = act.doer.components.inventory:DropItem(act.invobject, false)
            if projectile then
                local pos = act.target:GetPosition()
                projectile.components.hjjzprojectile.targetoffset = {x=0,y=1.5,z=0}
				projectile.components.hjjzprojectile:Launch(pos, act.doer,act.target)
				return true
            end
        end		
		end
	else
		return false , "NOPOCK"
    end
end
HJ_POKEOUT.fn = function(act)
    if act.invobject and act.doer then
        if act.invobject.components.hjprojectile and act.doer.components.inventory then
            local projectile = act.doer.components.inventory:DropItem(act.invobject, false)
            if projectile then
                local act_pos = act:GetActionPoint()
				projectile.components.hjprojectile:Launch(act_pos, act.doer,act.target or nil )
				return true
            end
        end
    end
end
HJ_JZPOKEOUT.fn = function(act)
    if act.invobject and act.doer then
        if act.invobject.components.hjjzprojectile and act.doer.components.inventory then
            local projectile = act.doer.components.inventory:DropItem(act.invobject, false)
            if projectile then
                local act_pos = act:GetActionPoint()
				projectile.components.hjjzprojectile:Launch(act_pos, act.doer,act.target or nil )
				return true
            end
        end
    end
end

AddAction(HJ_POKE) 
AddAction(HJ_POKEOUT)
AddAction(HJ_JZPOKE) 
AddAction(HJ_JZPOKEOUT)
AddComponentAction("POINT", "hjprojectile" , function(inst, doer, pos, actions, right) 
	if right and inst:HasTag("poked") and inst.replica.equippable and inst.replica.equippable:IsEquipped()  then
		---	and
        --not GLOBAL.TheWorld.Map:IsGroundTargetBlocked(target:GetPosition())		then 
		table.insert(actions, GLOBAL.ACTIONS.HJ_POKEOUT)
	end
end)
AddComponentAction("POINT", "hjjzprojectile" , function(inst, doer, pos, actions, right) 
	if right and inst:HasTag("poked") and inst.replica.equippable and inst.replica.equippable:IsEquipped()  then
		---	and
        --not GLOBAL.TheWorld.Map:IsGroundTargetBlocked(target:GetPosition())		then 
		table.insert(actions, GLOBAL.ACTIONS.HJ_JZPOKEOUT)
	end
end)
AddComponentAction("EQUIPPED", "hjprojectile" , function(inst, doer, target, actions,right) 
	if right and  not inst:HasTag("poked") and target and target:IsValid() and not target:HasTag("wall") and 
		target.replica.health ~= nil and not target.replica.health:IsDead() and
		target.replica.combat ~= nil then
		---	and
        --not GLOBAL.TheWorld.Map:IsGroundTargetBlocked(target:GetPosition())		then
		table.insert(actions, GLOBAL.ACTIONS.HJ_POKE)
	end
end)
AddComponentAction("EQUIPPED", "hjjzprojectile" , function(inst, doer, target, actions,right) 
	if right and  not inst:HasTag("poked") and target and target:IsValid() and not target:HasTag("wall") and 
		target.replica.health == nil  then
		---	and
        --not GLOBAL.TheWorld.Map:IsGroundTargetBlocked(target:GetPosition())		then
		table.insert(actions, GLOBAL.ACTIONS.HJ_JZPOKE)
	end
end)


local HJ_BALL = GLOBAL.Action({priority=3, rmb=false})
local HJ_UNBALL = GLOBAL.Action({})
HJ_BALL.id = "HJ_BALL"
HJ_UNBALL.id = "HJ_UNBALL"
HJ_BALL.str = "放置"
HJ_UNBALL.str = "取出"
HJ_BALL.fn = function(act)
	if act.invobject and act.target and  act.doer then
		if act.target.ownerlist ~= nil  and act.target.ownerlist.master  then
			if 	act.target.ownerlist.master ~= act.doer.userid then
				return false , "NOQUAN"
			end
			if act.target.components.hj_base then
				act.target.components.hj_base:Ball(act.invobject,act.doer)
			end
			return true			
		else
			if act.target.components.hj_base then

				act.target.components.hj_base:Ball(act.invobject,act.doer)
			end

			return true
		end
	end
end
HJ_UNBALL.fn = function(act)
	if  act.target and  act.doer then
		if act.target.ownerlist ~= nil  and act.target.ownerlist.master  then
			if 	act.target.ownerlist.master ~= act.doer.userid then
				return false , "NOQUAN"
			end
			if act.target.components.hj_base then
				act.target.components.hj_base:UnBall(act.doer)
			end
			return true
		else	
			if act.target.components.hj_base then
				act.target.components.hj_base:UnBall(act.doer)
			end
			return true
		end
	end
end
AddAction(HJ_BALL)
AddAction(HJ_UNBALL)
AddComponentAction("USEITEM", "hjprojectile" , function(inst, doer, target, actions) 
	if inst:HasTag("poked") and  target:HasTag("hj_ball") and not target:HasTag("ballpoked") then
		table.insert(actions, ACTIONS.HJ_BALL)
	end
end)

AddComponentAction("SCENE", "hj_base" , function(inst, doer, actions, right) 
	if  right and inst:HasTag("ballpoked")  then
		table.insert(actions, ACTIONS.HJ_UNBALL)
	end
end)
AddStategraphActionHandler("wilson",ActionHandler(ACTIONS.HJ_POKE, "throw"))
AddStategraphActionHandler("wilson_client",ActionHandler(ACTIONS.HJ_POKE, "throw"))
AddStategraphActionHandler("wilson",ActionHandler(ACTIONS.HJ_POKEOUT, "throw"))
AddStategraphActionHandler("wilson_client",ActionHandler(ACTIONS.HJ_POKEOUT, "throw"))
AddStategraphActionHandler("wilson",ActionHandler(ACTIONS.HJ_JZPOKE, "throw"))
AddStategraphActionHandler("wilson_client",ActionHandler(ACTIONS.HJ_JZPOKE, "throw"))
AddStategraphActionHandler("wilson",ActionHandler(ACTIONS.HJ_JZPOKEOUT, "throw"))
AddStategraphActionHandler("wilson_client",ActionHandler(ACTIONS.HJ_JZPOKEOUT, "throw"))
AddStategraphActionHandler("wilson",ActionHandler(ACTIONS.HJ_BALL, "give"))
AddStategraphActionHandler("wilson_client",ActionHandler(ACTIONS.HJ_BALL, "give"))
AddStategraphActionHandler("wilson",ActionHandler(ACTIONS.HJ_UNBALL, "dolongaction"))
AddStategraphActionHandler("wilson_client",ActionHandler(ACTIONS.HJ_UNBALL, "dolongaction"))

AddComponentPostInit("playercontroller", function(self)
	local old = self.DoActionAutoEquip
	function self:DoActionAutoEquip(buffaction,...)
    if buffaction.invobject ~= nil and
        buffaction.invobject.replica.equippable ~= nil and
        buffaction.invobject.replica.equippable:EquipSlot() == EQUIPSLOTS.HANDS and
        buffaction.action == ACTIONS.HJ_BALL then
		return
	end
	old(self,buffaction,...)
	end
end)

local function biu(inst)
	if not TheWorld.ismastersim then
		return
	end	
	local function wuli(inst)
		if inst.Physics then
			inst.Physics:CollidesWith(COLLISION.OBSTACLES)--这个是大的物体比如墙之类的
			inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES) --这个是小的 比如岩石
		end
	end
	inst:ListenForEvent("ms_becameghost", wuli)
	if inst:HasTag("playghost") then
		wuli(inst)
	end
end
AddPlayerPostInit(biu)



local params = {}

local containers_widgetsetup_base = containers.widgetsetup
	function containers.widgetsetup(container, prefab, data)
		local pref = prefab or container.inst.prefab
		if container.inst:HasTag("ly_bag") then
			pref = "ly_bag"
		end
		if pref == "ly_bag" then
			local t = params[pref]
			if t ~= nil then
				for k, v in pairs(t) do
					container[k] = v
				end
			container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
			end
		else
			return containers_widgetsetup_base(container, prefab)
		end
	end


local function makebag2()
	local container =
{
widget =
{
slotpos = {},
animbank = nil,
animbuild = nil,
bgatlas = "images/ly_bagbg2.xml",
bgimage = "ly_bagbg2.tex",
pos = Vector3(-100,-120,0),
},
issidewidget = true,
type = "pack",
}

for y = 0, 6 do
	
	table.insert(container.widget.slotpos, Vector3(3  -75, -y*72 + 210 , 0))	--New 3rd col
	table.insert(container.widget.slotpos, Vector3(3     , -y*72 + 210 ,0))	--2nd col
	table.insert(container.widget.slotpos, Vector3(3  +75, -y*72 + 210 ,0))	--1st col at screen edge
	
end

	return container
end

params.ly_bag = makebag2()

for k, v in pairs(params) do
	containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end

----	物品文字
local function RGB(r, g, b)
    return { r / 255, g / 255, b / 255, 1 }
end

local lan = RGB(238, 238, 0)
local hong = RGB(255, 0, 0)
local zi = RGB(255, 0, 255)
local chen = RGB(255, 157, 35)



----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------

local JQ = GLOBAL.require("widgets/jq")
local function AddJQ(self)
    self.JQ = self:AddChild(JQ())
    self.JQ:SetHAnchor(1)
    self.JQ:SetVAnchor(1)
    self.JQ:SetPosition(0,0,0)
end

AddClassPostConstruct("widgets/controls", AddJQ)



GLOBAL.STRINGS.NAMES.WARG_ALTAR = "座狼祭坛"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.WARG_ALTAR = "可以召唤座狼"

GLOBAL.STRINGS.NAMES.MOOSE_ALTAR = "驼鹿祭坛"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.MOOSE_ALTAR = "可以召唤驼鹿"

GLOBAL.STRINGS.NAMES.DRAGONFLY_ALTAR = "龙蝇祭坛"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.DRAGONFLY_ALTAR = "可以召唤龙蝇"

GLOBAL.STRINGS.NAMES.BEARGER_ALTAR = "熊獾祭坛"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.BEARGER_ALTAR = "可以召唤熊獾"

GLOBAL.STRINGS.NAMES.DEERCLOPS_ALTAR = "巨鹿祭坛"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.DEERCLOPS_ALTAR = "可以召唤巨鹿"

GLOBAL.STRINGS.NAMES.TOADSTOOL_DARK_ALTAR = "毒菇祭坛"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.TOADSTOOL_DARK_ALTAR = "可以召唤毒菇"

GLOBAL.STRINGS.NAMES.MINOTAUR_ALTAR = "犀牛祭坛"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.MINOTAUR_ALTAR = "可以召唤犀牛"

GLOBAL.STRINGS.NAMES.HJZS_ALTAR = "乐园祭坛"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJZS_ALTAR = "可以召唤服主，取尔等项上人头"

GLOBAL.STRINGS.NAMES.HJZS = "SOLOHAM"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJZS = "萌新瑟瑟发抖"

GLOBAL.STRINGS.NAMES.HJZS1 = "面瘫"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJZS1 = "面瘫"

GLOBAL.STRINGS.NAMES.HJZS2 = "颜老污"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJZS2 = "颜老污"

GLOBAL.STRINGS.NAMES.HJZS3 = "啊翰"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJZS3 = "啊翰"

GLOBAL.STRINGS.NAMES.HJZS4 = "流年"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJZS4 = "流年"

GLOBAL.STRINGS.NAMES.HJZS5 = "浩天"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJZS5 = "浩天"

GLOBAL.STRINGS.NAMES.HJZS6 = "鬼子"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.HJZS6 = "鬼子"

--添加可燃
AddPrefabPostInit("xtsp", function(inst) --这里写名字
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = GLOBAL.TUNING.LARGE_FUEL
end)

local boss =
{
	"warg",
	"spider",
	"spider_warrior",
	"spiderqueen",
	"minotaur",
	"toadstool",
	"toadstool_dark",
	"lavae",
	"mossling",
	"klaus",
	"moose",
}
for k,v in pairs(boss) do  
	AddPrefabPostInit(v, function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
		if inst.Physics then
			GLOBAL.RemovePhysicsColliders(inst)
			inst.Physics:CollidesWith(GLOBAL.COLLISION.CHARACTERS)
		end
	end)
end

local FTSignTag = 'fast_travel'

local FT_Points = {
	"xiaoyangbili"
}
for k, v in pairs(FT_Points) do
	AddPrefabPostInit(v,function(inst)
		inst:AddComponent("talker")
	end)
end
STRINGS.NAMES.XIAOYANGBILI = "小羊比利"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XIAOYANGBILI= "用来传送"
STRINGS.NAMES.XIAOYANG_ITEM = "小羊玩偶"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XIAOYANG_ITEM= "[让我来帮助你吧，人类]\n它是这么说的"

AddAction("DESTINATION", "快速旅行", function(act)
	if act.doer ~= nil and act.target ~= nil and act.doer:HasTag("player") and act.target.components.fasttravel and not act.target:HasTag("burnt") and not act.target:HasTag("fire") then
		act.target.components.fasttravel:SelectDestination(act.doer)
		return true
	end
end)



AddComponentAction("SCENE", "fasttravel", function(inst, doer, actions, right)
	if right then
		if inst:HasTag(FTSignTag) and not inst:HasTag("burnt") and not inst:HasTag("fire") then
			table.insert(actions, GLOBAL.ACTIONS.DESTINATION)
		end
	end
end)

local SignGenerator = require"signgenerator"
local kinds = {}

kinds["xiaoyangbili"] = {
    prompt = "写点东西",
    animbank = "ui_board_5x3",
    animbuild = "ui_board_5x3",
    menuoffset = Vector3(6, -70, 0),

    cancelbtn = { text = "取消", cb = nil, control = CONTROL_CANCEL },
    middlebtn = { text = "随机", cb = function(inst, doer, widget)
            widget:OverrideText( SignGenerator(inst, doer) )
        end, control = CONTROL_MENU_MISC_2 },
    acceptbtn = { text = "写名字", cb = nil, control = CONTROL_ACCEPT },
}

local writeables = GLOBAL.require "writeables"

local old = writeables.makescreen
writeables.makescreen = function (inst, doer,...)
	if inst.prefab == "xiaoyangbili" then 
		local data = kinds[inst.prefab]
		if doer and doer.HUD then
			return doer.HUD:ShowWriteableWidget(inst, data)
		end
	else
		return old(inst, doer,...)
	end
end

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.DESTINATION, "give"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.DESTINATION, "give"))
----------------沙漠
GLOBAL.TUNING.GREAT_OASISLAKE_MAX_FISH = 200000

local function AddOasislakeGetFish(inst)
	return math.random() < 0.6 and "wetpouch" or "fish"
end 

local function AddOasislake(inst)-------增大沙漠湖的容量！
    if not TheWorld.ismastersim then
        return inst
    end
	inst.components.fishable.maxfish = TUNING.GREAT_OASISLAKE_MAX_FISH ---最大总量，原版15个
    inst.components.fishable:SetRespawnTime(1) ----恢复间隔，原版是90s
    inst.components.fishable:SetGetFishFn(AddOasislakeGetFish) ------钓上来的礼品
end
AddPrefabPostInit("oasislake",AddOasislake)

-------------------------------------------------------------------------------

local function AddFishingrod(inst)--------快速的钓鱼！
	if not TheWorld.ismastersim then
        return inst
    end
    inst.components.fishingrod:SetWaitTimes(3,5)
    --inst.components.fishingrod:SetStrainTimes(0, 5)
end
AddPrefabPostInit("fishingrod",AddFishingrod)

-------------------------------------------------------------------------------

-- local function onfishingcollect(inst,data)
	-- local caughtfish = data.fish
	-- print("Quick give fish!",caughtfish,inst,inst.components.inventory)
	-- if caughtfish and caughtfish:IsValid() and inst and inst.components.inventory then 
		-- inst.components.inventory:GiveItem(caughtfish)--------鱼会自己进背包里
	-- end
-- end 
-------------------------------------------------------------------------------------------------
-- local function onfishingcollect(inst,data)
	-- local caughtfish = data.fish
	-- print("Quick give fish!",caughtfish,inst,inst.components.inventory)
	-- if caughtfish and caughtfish:IsValid() and inst and inst.components.inventory then
		-- if caughtfish.components.inventoryitem ~= nil and
            -- caughtfish.components.inventoryitem.canbepickedup and
            -- caughtfish.components.inventoryitem.cangoincontainer and
            -- not caughtfish.components.inventoryitem:IsHeld() and
            -- inst.components.inventory:CanAcceptCount(caughtfish, 1) > 0 then
			-- if caughtfish.components.stackable ~= nil then
                -- caughtfish = caughtfish.components.stackable:Get()
            -- end
			-- inst.components.inventory:GiveItem(caughtfish)--------鱼会自己进背包里
			-- --inst.components.inventory:DoTaskInTime(0.3, GiveItem(caughtfish))--------鱼会自己进背包里
		-- end
	-- end
-- end
------------------------------------------------------------------------------------------------------
local function onfishingcollect(inst, data)
	local caughtfish = data.fish
	print("Quick give fish!",caughtfish,inst,inst.components.inventory)
	if caughtfish and caughtfish:IsValid() and not caughtfish:IsInLimbo() and inst and inst.components.inventory then
		inst.components.inventory:GiveItem(caughtfish)--------鱼会自己进背包里
	end
end

local function AddPlayerCollectFish(inst)
	if not TheWorld.ismastersim then
        return inst
    end
	inst:ListenForEvent("fishingcollect",onfishingcollect)
end 
AddPlayerPostInit(AddPlayerCollectFish)

-------------------------------------------------------------------------------


local wetpouch = ---------------妈的直接照抄，我去你妈的兼容性
{
    loottable =
    {
        goggleshat_blueprint = 0,
        deserthat_blueprint = 0,
        succulent_potted_blueprint = 0,
        antliontrinket = 0,
        trinket_1 = 1, -- marbles
        trinket_3 = 1, -- knot
        trinket_8 = 1, -- plug
        trinket_9 = 1, -- buttons
        trinket_26 = .1, -- potatocup
        TOOLS_blueprint = .05,
        LIGHT_blueprint = .05,
        SURVIVAL_blueprint = .05,
        FARM_blueprint = .05,
        SCIENCE_blueprint = .05,
        REFINE_blueprint = .05,
        DRESS_blueprint = .05,
    },

    UpdateLootBlueprint = function(loottable, doer)
        local builder = doer ~= nil and doer.components.builder or nil
        loottable["goggleshat_blueprint"] = (builder ~= nil and not builder:KnowsRecipe("goggleshat")) and 1 or 0.1
        loottable["deserthat_blueprint"] = (builder ~= nil and not builder:KnowsRecipe("deserthat") and builder:KnowsRecipe("goggleshat")) and 1 or 0.1
        loottable["succulent_potted_blueprint"] = (builder ~= nil and not builder:KnowsRecipe("succulent_potted")) and 1 or 0.1
        loottable["antliontrinket"] = (builder ~= nil and builder:KnowsRecipe("deserthat")) and .8 or 0.1
    end,
    
    lootfn = function(inst, doer)
        inst.setupdata.UpdateLootBlueprint(inst.setupdata.loottable, doer)

        local total = 0
        for _,v in pairs(inst.setupdata.loottable) do
            total = total + v
        end
        --print ("TOTOAL:", total)
        --for k,v in pairs(inst.setupdata.loottable) do print(" - ", tostring(v/total), k) end

        local item = weighted_random_choice(inst.setupdata.loottable)

        if IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST) and
            string.sub(item, 1, 7) == "trinket" and
            item ~= "trinket_26" then
            --chance to replace trinkets (but not potatocup)
            local rnd = math.random(6)
            if rnd == 1 then
                item = GetRandomBasicWinterOrnament()
            elseif rnd == 2 then
                item = GetRandomFancyWinterOrnament()
            elseif rnd == 3 then
                item = GetRandomLightWinterOrnament()
            end
        end

        return { item }
    end,

    master_postinit = function(inst, setupdata)
        inst.build = "wetpouch"
        inst.setupdata = setupdata
        inst.wet_prefix = STRINGS.WET_PREFIX.POUCH
        inst.components.inventoryitem:InheritMoisture(100, true)
    end,
}



local function OnUnwrapped_Klei(inst, pos, doer) ---------------我去你妈的兼容性
	local loot, tossloot, setupdata = JoinArrays(table.invert(wetpouch.loottable), GetAllWinterOrnamentPrefabs()), false, wetpouch
    if inst.burnt then
        SpawnPrefab("ash").Transform:SetPosition(pos:Get())
    else
        local loottable = (setupdata ~= nil and setupdata.lootfn ~= nil) and setupdata.lootfn(inst, doer) or loot
        if loottable ~= nil then
			local moisture = inst.components.inventoryitem:GetMoisture()
            local iswet = inst.components.inventoryitem:IsWet()
            for i, v in ipairs(loottable) do
                local item = SpawnPrefab(v)
                if item ~= nil then
                    if item.Physics ~= nil then
                        item.Physics:Teleport(pos:Get())
                    else
                        item.Transform:SetPosition(pos:Get())
                    end
                    if item.components.inventoryitem ~= nil then
                        item.components.inventoryitem:InheritMoisture(moisture, iswet)
                        if tossloot then
                            item.components.inventoryitem:OnDropped(true, .5)
                        end
                    end
                end
            end
        end
        SpawnPrefab("wetpouch_unwrap").Transform:SetPosition(pos:Get())
    end
    if doer ~= nil and doer.SoundEmitter ~= nil then
        doer.SoundEmitter:PlaySound("dontstarve/common/together/packaged")
    end
	--local one = inst.components.stackable and inst.components.stackable:Get() or inst
    --one:Remove()
end

local extra_droploot = { ------在这里修改互斥掉落物及其几率
	spear = 0.33,
	footballhat = 0.5,
	armorwood = 0.33,
}

local function GetRandLoot(list)
	local total = 0
	for k,v in pairs(list) do 
		total = total + v
	end
	local rand = total*math.random()
	for k,v in pairs(list) do 
		rand = rand - v
		if rand <= 0 then 
			return k
		end
	end
end 

local function OnUnwrapped_My(inst, pos, doer)---------------我去你妈的兼容性
	local stacksize = inst.components.stackable.stacksize
	for i=1,stacksize do 
		OnUnwrapped_Klei(inst, pos, doer)
		local loot = {}
		local randloot = GetRandLoot(extra_droploot)
		table.insert(loot, randloot)
		inst.components.lootdropper:SetLoot(loot)
		inst.components.lootdropper:DropLoot(pos)
	end
	inst:Remove()
end 

  STRINGS.RECIPE_DESC.COFFEE_SEEDS = "They look more like beans to me!"
        GLOBAL.STRINGS.NAMES.COFFEE_SEEDS = "咖啡种子"
        GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.COFFEE_SEEDS = "I can feel the energy!"

	GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.COFFEE = "It's not quite ready yet."
	GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.COFFEE_COOKED = "很好!"
        GLOBAL.STRINGS.NAMES.COFFEE = "咖啡"
	GLOBAL.STRINGS.NAMES.COFFEE_COOKED = "热咖啡"


	local coffee_seeds = GLOBAL.Recipe("coffee_seeds",{ Ingredient("seeds", 10)}, RECIPETABS.FARM, TECH.SCIENCE_TWO )
                    coffee_seeds.atlas = "images/inventoryimages/coffee_seeds.xml"


----------------- CONFIGURATION --------------------

TUNING.SHOW_DAMAGE_ONLY =  "on"		-- set to true, if you want to see damage only (no healing)

TUNING.SHOW_NUMBERS_THRESHOLD = 0.1

TUNING.SHOW_DECIMAL_POINTS = "on"	

TUNING.DISPLAY_MODE = "waving"

----------------------------------------------------


TUNING.HEALTH_LOSE_COLOR = {
	r = 0.7,
	g = 0,
	b = 0
}
TUNING.HEALTH_GAIN_COLOR = {
	r = 0,
	g = 0.7,
	b = 0
}


TUNING.LABEL_FONT_SIZE = 70

TUNING.LABEL_Y_START = 4

TUNING.LABEL_TIME = 1.0

TUNING.LABEL_TIME_DELTA = 0.01

TUNING.GRAVITY = 0.1
TUNING.FRICTION_PRESERVE = 0.9

TUNING.LIFT_ACC = 0.003
TUNING.SIDE_WAVE_RND = 0.15
TUNING.LABEL_Y_START_VELO = 0.05

TUNING.LABEL_MIN_AMPLITUDE_X = 0.8
TUNING.LABEL_MAX_AMPLITUDE_X = 1.6

local function PrintInst(inst)
    local msg = ""
    for k,v in pairs(inst) do
        msg = msg..string.format("%s:%s\n", tostring(k), tostring(v))
        if k == "components" then
            for key,value in pairs(v) do
                msg = msg..string.format("\t%s:%s\n", tostring(key), tostring(value))
            end
        end
    end
    if inst.components and inst.components.stackable then
        msg = msg..string.format("\tstacksize=%s, maxstacksize=%s\n",
                        tostring(inst.components.stackable.stacksize),
                        tostring(inst.components.stackable.maxsize))
                    end
    print(msg)
end

AddComponentPostInit("health", function(Health, inst)
	inst:ListenForEvent("healthdelta", function(inst, data)
		if inst.components.health then
			local amount = data.newpercent * inst.components.health.maxhealth - data.oldpercent * inst.components.health.maxhealth
			if data.amount and math.abs(data.amount) < math.abs(amount) then
				amount = data.amount
			end
			if amount == 0 then
				return
			end
			if math.abs(amount) > TUNING.SHOW_NUMBERS_THRESHOLD then
				if not (TUNING.SHOW_DAMAGE_ONLY and amount > 0) then
					local CDI = GLOBAL.SpawnPrefab("dmgind")
					CDI.Transform:SetPosition(inst.Transform:GetWorldPosition())
					CDI.isheal:set_local(false)
					CDI.isheal:set(amount > 0)
					CDI.indicator:set_local(0)
					CDI.indicator:set(math.abs(amount))
				end
			end
		end
	end)
end)

local Inv = require "widgets/inventorybar"

GLOBAL.EQUIPSLOTS=
{
    HANDS = "hands",
    HEAD = "head",
    BODY = "body",
    BACK = "back",
    NECK = "neck",
}
GLOBAL.EQUIPSLOT_IDS = {}
local slot = 0
for k, v in pairs(GLOBAL.EQUIPSLOTS) do
    slot = slot + 1
    GLOBAL.EQUIPSLOT_IDS[v] = slot
end
slot = nil

AddComponentPostInit("resurrectable", function(self, inst)
    local original_FindClosestResurrector = self.FindClosestResurrector
    local original_CanResurrect = self.CanResurrect
    local original_DoResurrect = self.DoResurrect

    self.FindClosestResurrector = function(self)
        if IsServer and self.inst.components.inventory then
            local item = self.inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.NECK)
            if item and item.prefab == "amulet" then
                return item
            end
        end
        original_FindClosestResurrector(self)
    end

    self.CanResurrect = function(self)
        if IsServer and self.inst.components.inventory then
            local item = self.inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.NECK)
            if item and item.prefab == "amulet" then
                return true
            end
        end
        original_CanResurrect(self)
    end

    self.DoResurrect = function(self)
        self.inst:PushEvent("resurrect")
        if IsServer and self.inst.components.inventory then
            local item = self.inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.NECK)
            if item and item.prefab == "amulet" then
                self.inst.sg:GoToState("amulet_rebirth")
                return true
            end
        end
        original_DoResurrect(self)
    end
end)

AddComponentPostInit("inventory", function(self, inst)
    local original_Equip = self.Equip
    self.Equip = function(self, item, old_to_active)
        if original_Equip(self, item, old_to_active) and item and item.components and item.components.equippable then
            local eslot = item.components.equippable.equipslot
            if self.equipslots[eslot] ~= item then
                if eslot == GLOBAL.EQUIPSLOTS.BACK and item.components.container ~= nil then
                    self.inst:PushEvent("setoverflow", { overflow = item })
                end
            end
            return true
        else
            return
        end
    end

    self.GetOverflowContainer = function()
        if self.ignoreoverflow then
            return
        end
        local item = self:GetEquippedItem(GLOBAL.EQUIPSLOTS.BACK)
        return item ~= nil and item.components.container or nil
    end
end)

AddGlobalClassPostConstruct("widgets/inventorybar", "Inv", function()
    local Inv_Refresh_base = Inv.Refresh or function() return "" end
    local Inv_Rebuild_base = Inv.Rebuild or function() return "" end

    function Inv:LoadExtraSlots(self)
        self.bg:SetScale(1.35,1,1.25)
        self.bgcover:SetScale(1.35,1,1.25)

        if self.addextraslots == nil then
            self.addextraslots = 1

            self:AddEquipSlot(GLOBAL.EQUIPSLOTS.BACK, "images/back.xml", "back.tex")
            self:AddEquipSlot(GLOBAL.EQUIPSLOTS.NECK, "images/neck.xml", "neck.tex")
        -- else
            -- GLOBAL.GetPlayer().HUD.controls.stickyrecipepopup:Refresh()

            if self.inspectcontrol then
                local W = 68
                local SEP = 12
                local INTERSEP = 28
                local inventory = self.owner.replica.inventory
                local num_slots = inventory:GetNumSlots()
                local num_equip = #self.equipslotinfo
                local num_buttons = self.controller_build and 0 or 1
                local num_slotintersep = math.ceil(num_slots / 5)
                local num_equipintersep = num_buttons > 0 and 1 or 0
                local total_w = (num_slots + num_equip + num_buttons) * W + (num_slots + num_equip + num_buttons - num_slotintersep - num_equipintersep - 1) * SEP + (num_slotintersep + num_equipintersep) * INTERSEP
            	self.inspectcontrol.icon:SetPosition(-4, 6)
            	self.inspectcontrol:SetPosition((total_w - W) * .5 + 3, -6, 0)
            end
        end

        --if not self.controller_build then
        --    self.bg:SetScale(1.22, 1, 1)
        --    self.bgcover:SetScale(1.22, 1, 1)

        --    self.inspectcontrol = self.root:AddChild(TEMPLATES.IconButton(atlas_name, image_name, STRINGS.UI.HUD.INSPECT_SELF, false, false, function() self.owner.HUD:InspectSelf() end, {size = 40}, "self_inspect_mod.tex"))
        --    self.inspectcontrol.icon:SetScale(.7)
        --    self.inspectcontrol.icon:SetPosition(-4, 6)
        --    self.inspectcontrol:SetScale(1.25)
        --    self.inspectcontrol:SetPosition((total_w - W) * .5 + 3, -6, 0)
        --else
        --    self.bg:SetScale(1.15, 1, 1)
        --    self.bgcover:SetScale(1.15, 1, 1)

        --    if self.inspectcontrol ~= nil then
        --        self.inspectcontrol:Kill()
        --        self.inspectcontrol = nil
        --    end
        --end
    end

    function Inv:Refresh()
        Inv_Refresh_base(self)
        Inv:LoadExtraSlots(self)
    end

    function Inv:Rebuild()
        Inv_Rebuild_base(self)
        Inv:LoadExtraSlots(self)
    end
end)

AddPrefabPostInit("inventory_classified", function(inst)
    function GetOverflowContainer(inst)
        local item = inst.GetEquippedItem(inst, GLOBAL.EQUIPSLOTS.BACK)
        return item ~= nil and item.replica.container or nil
    end

    function Count(item)
        return item.replica.stackable ~= nil and item.replica.stackable:StackSize() or 1
    end

    function Has(inst, prefab, amount)
        local count =
            inst._activeitem ~= nil and
            inst._activeitem.prefab == prefab and
            Count(inst._activeitem) or 0

        if inst._itemspreview ~= nil then
            for i, v in ipairs(inst._items) do
                local item = inst._itemspreview[i]
                if item ~= nil and item.prefab == prefab then
                    count = count + Count(item)
                end
            end
        else
            for i, v in ipairs(inst._items) do
                local item = v:value()
                if item ~= nil and item ~= inst._activeitem and item.prefab == prefab then
                    count = count + Count(item)
                end
            end
        end

        local overflow = GetOverflowContainer(inst)
        if overflow ~= nil then
            local overflowhas, overflowcount = overflow:Has(prefab, amount)
            count = count + overflowcount
        end

        return count >= amount, count
    end

  

    if not IsServer then
        inst.GetOverflowContainer = GetOverflowContainer
        inst.Has = Has
        -- inst.UseItemFromInvTile = UseItemFromInvTile
        -- inst.ReceiveItem = ReceiveItem
        -- inst.RemoveIngredients = RemoveIngredients
    end
end)

AddStategraphPostInit("wilson", function(self)
    for key,value in pairs(self.states) do
        if value.name == 'amulet_rebirth' then
            local original_amulet_rebirth_onexit = self.states[key].onexit


            self.states[key].onexit = function(inst)
                local item = inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.NECK)
                if item and item.prefab == "amulet" then
                    item = inst.components.inventory:RemoveItem(item)
                    if item then
                        item:Remove()
                        item.persists = false
                    end
                end
                original_amulet_rebirth_onexit(inst)
            end
        end
    end
end)

function backpackpostinit(inst)
    if IsServer then
        inst.components.equippable.equipslot = GLOBAL.EQUIPSLOTS.BACK or GLOBAL.EQUIPSLOTS.BODY
    end
end

function amuletpostinit(inst)
    if IsServer then
        inst.components.equippable.equipslot = GLOBAL.EQUIPSLOTS.NECK or GLOBAL.EQUIPSLOTS.BODY
    end
end


AddPrefabPostInit("amulet", amuletpostinit)
AddPrefabPostInit("blueamulet", amuletpostinit)
AddPrefabPostInit("purpleamulet", amuletpostinit)
AddPrefabPostInit("orangeamulet", amuletpostinit)
AddPrefabPostInit("greenamulet", amuletpostinit)
AddPrefabPostInit("yellowamulet", amuletpostinit)

AddPrefabPostInit("backpack", backpackpostinit)
AddPrefabPostInit("krampus_sack", backpackpostinit)
AddPrefabPostInit("piggyback", backpackpostinit)
AddPrefabPostInit("icepack", backpackpostinit)
local NAMES = GLOBAL.STRINGS.NAMES
local JIESHAO = GLOBAL.STRINGS.RECIPE_DESC

GLOBAL.FIREFLIES_FEAR = 222
local STRINGS_CHS = {
	fireflies = {
		name = "萤火虫",
		jieshao = "点缀黑夜的萤火虫",
	},
	
	redfireflies = {
		name = "红萤火虫",
		jieshao = "点缀黑夜的萤火虫",
	},
	
	orangefireflies = {
		name = "橙萤火虫",
		jieshao = "点缀黑夜的萤火虫",
	},

	yellowfireflies = {
		name = "黄萤火虫",
		jieshao = "点缀黑夜的萤火虫",
	},

	greenfireflies = {
		name = "绿萤火虫",
		jieshao = "点缀黑夜的萤火虫",
	},
	
	bluefireflies = {
		name = "蓝萤火虫",
		jieshao = "点缀黑夜的萤火虫",
	},
	
	cyanfireflies = {
		name = "青萤火虫",
		jieshao = "点缀黑夜的萤火虫",
	},
	
	purplefireflies = {
		name = "紫萤火虫",
		jieshao = "点缀黑夜的萤火虫",
	},
	
}


local modstr=nil
local function getStr(str)
	return str
end
modstr=getStr(STRINGS_CHS)
	GLOBAL.RTYWORDS=modstr.RTYWORDS
	
	----萤火虫制作信息
NAMES.FIREFLIES = modstr.fireflies.name                                      --默认
JIESHAO.FIREFLIES = modstr.fireflies.jieshao

NAMES.REDFIREFLIES = modstr.redfireflies.name                                --红
JIESHAO.REDFIREFLIES = modstr.redfireflies.jieshao

NAMES.ORANGEFIREFLIES = modstr.orangefireflies.name                                --橙
JIESHAO.ORANGEFIREFLIES = modstr.orangefireflies.jieshao

NAMES.YELLOWFIREFLIES = modstr.yellowfireflies.name                                --黄
JIESHAO.YELLOWFIREFLIES = modstr.yellowfireflies.jieshao

NAMES.GREENFIREFLIES = modstr.greenfireflies.name                                --绿
JIESHAO.GREENFIREFLIES = modstr.greenfireflies.jieshao

NAMES.BLUEFIREFLIES = modstr.bluefireflies.name                                --
JIESHAO.BLUEFIREFLIES = modstr.bluefireflies.jieshao

NAMES.CYANFIREFLIES = modstr.cyanfireflies.name                                --
JIESHAO.CYANFIREFLIES = modstr.cyanfireflies.jieshao

NAMES.PURPLEFIREFLIES = modstr.purplefireflies.name                                --紫
JIESHAO.PURPLEFIREFLIES = modstr.purplefireflies.jieshao

AddRecipe("fireflies",   { Ingredient("lightbulb", 20)}, RECIPETABS.LIGHT,  TECH.SCIENCE_ONE, nil, nil, nil, nil, nil)
AddRecipe("redfireflies",   { Ingredient("lightbulb", 20)}, RECIPETABS.LIGHT,  TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/redfireflies.xml", "redfireflies.tex")
AddRecipe("orangefireflies",   { Ingredient("lightbulb", 20)}, RECIPETABS.LIGHT,  TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/orangefireflies.xml", "orangefireflies.tex")
AddRecipe("yellowfireflies",   { Ingredient("lightbulb", 20)}, RECIPETABS.LIGHT,  TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/yellowfireflies.xml", "yellowfireflies.tex")
AddRecipe("greenfireflies",   { Ingredient("lightbulb", 20)}, RECIPETABS.LIGHT,  TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/greenfireflies.xml", "greenfireflies.tex")
AddRecipe("cyanfireflies",   { Ingredient("lightbulb", 20)}, RECIPETABS.LIGHT,  TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/cyanfireflies.xml", "cyanfireflies.tex")
AddRecipe("bluefireflies",   { Ingredient("lightbulb", 20)}, RECIPETABS.LIGHT,  TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/bluefireflies.xml", "bluefireflies.tex")
AddRecipe("purplefireflies",   { Ingredient("lightbulb", 20)}, RECIPETABS.LIGHT,  TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/purplefireflies.xml", "purplefireflies.tex")


local require = GLOBAL.require
local stackable_replica = require "components/stackable_replica"
local IsServer = GLOBAL.TheNet:GetIsServer()

local size = 60
local TUNING = GLOBAL.TUNING
local net_byte = GLOBAL.net_byte

TUNING.STACK_SIZE_LARGEITEM = size
TUNING.STACK_SIZE_MEDITEM = size
TUNING.STACK_SIZE_SMALLITEM = size 

-- Define functions
local stackable_replica_ctorBase = stackable_replica._ctor or function() return true end    
function stackable_replica._ctor(self, inst)
    self.inst = inst

    self._stacksize = net_byte(inst.GUID, "stackable._stacksize", "stacksizedirty")
    self._maxsize = size
end

local stackable_replicaSetMaxSize_Base = stackable_replica.SetMaxSize or function() return true end
function stackable_replica:SetMaxSize(maxsize)
	self._maxsize = size
end

local stackable_replicaMaxSize_Base = stackable_replica.MaxSize or function() return true end
function stackable_replica:MaxSize()
	return self._maxsize
end

if IsServer then
AddPrefabPostInit("rabbit",function(inst)
   if(inst.components.stackable == nil) then
      inst:AddComponent("stackable")
   end
   inst.components.inventoryitem:SetOnDroppedFn(function(inst)
        inst.components.perishable:StopPerishing()
        inst.sg:GoToState("stunned")
        if inst.components.stackable then
    	    while inst.components.stackable:StackSize() > 1 do
    	        local item = inst.components.stackable:Get()
    	        if item then
    	            if item.components.inventoryitem then
    	                item.components.inventoryitem:OnDropped()
    	            end
    	            item.Physics:Teleport(inst.Transform:GetWorldPosition() )
    	        end
    	    end
    	 end
    end)
end)
end

-----地窖
local mod_slots = 80
local function updaterecipe(slots)
	cutstone_value = math.floor(slots / 2.6)
	boards_value = math.floor(slots / 2.6)
	marble_value = math.floor(slots / 10)
end
updaterecipe(mod_slots)

local function widgetcreation(widgetanimbank, widgetpos, slot_x, slot_y, posslot_x, posslot_y)
	local params={}
	params.storeroom =
	{
		widget =
		{
			slotpos = {},
			animbank = widgetanimbank,
			animbuild = widgetanimbank,
			pos = widgetpos,
			side_align_tip = 160,
		},
	type = "chest",
	}

	for y = slot_y, 0, -1 do
		for x = 0, slot_x do
			table.insert(params.storeroom.widget.slotpos, _G.Vector3(80*x-346*2+posslot_x, 80*y-100*2+posslot_y,0))
		end
	end

	local containers = _G.require "containers"
	containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, params.storeroom.widget.slotpos ~= nil and #params.storeroom.widget.slotpos or 0)

	local old_widgetsetup = containers.widgetsetup
	function containers.widgetsetup(container, prefab, data)
		local pref = prefab or container.inst.prefab
		if pref == "storeroom" then
			local t = params[pref]
			if t ~= nil then
				for k, v in pairs(t) do
					container[k] = v
				end
			container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
			end
		else
			return old_widgetsetup(container, prefab)
		end
	end
end


cupboard = AddRecipe("storeroom",{ Ingredient("cutstone", cutstone_value), Ingredient("marble", marble_value), Ingredient("boards", boards_value) }, RECIPETABS.TOWN, TECH.SCIENCE_TWO, "storeroom_placer" )
cupboard.atlas = "images/inventoryimages/storeroom.xml"
STRINGS.NAMES.STOREROOM = "储藏室"
	STRINGS.RECIPE_DESC.STOREROOM = "更多的储存空间"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.STOREROOM = "我真的非常喜欢，这是一个巨大的储藏室！"
	
	
	
	widgetpos = _G.Vector3(0,190,0)
	widgetanimbank = "ui_chest_5x16"
	slot_x = 15
	slot_y = 4
	posslot_x = 91
	posslot_y = 42

widgetcreation(widgetanimbank, widgetpos, slot_x, slot_y, posslot_x, posslot_y)



local checkfocustarget = require("widgets/checkfocustarget")
local LyTools = require("tools/ly_tools") 

local function inv_redefine(self)
    self.checkfocustarget = self:AddChild(checkfocustarget(self.owner))
	-----------按空格键checkfocustarget的UI数据清理
	TheInput:AddKeyDownHandler(KEY_SPACE, function()
		local underHUD = TheInput:GetHUDEntityUnderMouse() 
		if  underHUD and underHUD.UITransform and Vector3(underHUD.UITransform:GetWorldPosition()):Dist(self.checkfocustarget:GetWorldPosition()) <= 1 then 
			self.checkfocustarget:ClearUiStr()
		end
	end)
end
AddClassPostConstruct("widgets/controls", inv_redefine)

--在这里写需要设定掉落物价值的物品的代码名（物品的默认掉落物价值是1）
local LootValue = {
	meat = {value = 1},
	goldnugget = {value = 4},
	
	deerclops_eyeball = {value = 10},
	goose_feather = {value = 6},
	dragon_scales = {value = 15},
	bearger_fur = {value = 10},
	
	minotaurhorn = {value = 15},
	
	royal_jelly = {value = 10},
	hivehat = {value = 10},
	bundlewrap_blueprint = {value = 10},
	
	shroom_skin = {value = 9},
	mushroom_light2_blueprint = {value = 10},
	sleepbomb_blueprint = {value = 9},
	
	townportaltalisman = {value = 5},
	townportal_blueprint = {value = 6},
	
	purplegem = {value = 30},
	bluegem = {value = 30},
	redgem = {value = 30},
	orangegem = {value = 30},
	yellowgem = {value = 30},
	greengem = {value = 30},
	opalpreciousgem = {value = 30},
	halloweencandy_1 = {value = 5,isVIP = true},    --苹果糖
	halloweencandy_2 = {value = 20,isVIP = true},    --玉米糖
	halloweencandy_3 = {value = 48,isVIP = true},    --玉米
	halloweencandy_4 = {value = 35,isVIP = true},   --蜘蛛糖	  3级根骨	 500级以下吃了直接升一级
	halloweencandy_5 = {value = 30,isVIP = true},   --卡通糖果    2级根骨
	halloweencandy_6 = {value = 25,isVIP = true},   --葡萄干      1级根骨
	halloweencandy_7 = {value = 45,isVIP = true},   --盒装葡萄干  			 400级以下吃了直接升一级
	halloweencandy_8 = {value = 15,isVIP = true},   --幽灵糖     			 150级以下吃了直接升一级
	halloweencandy_10 = {value = 50,isVIP = true},  --触须棒糖   			 800级以下吃了直接升一级
	halloweencandy_11 = {value = 40,isVIP = true},  --牛奶糖     			 300级以下吃了直接升一级
	halloweencandy_12 = {value = 55,isVIP = true},  --糖果狮      4级根骨     					
	halloweencandy_13 = {value = 80,isVIP = true},  --末世糖      5级根骨
	ly_tangguo01 = {value = 5,isVIP = true},    --苹果糖
	ly_tangguo02 = {value = 20,isVIP = true},    --玉米糖
	ly_tangguo03 = {value = 48,isVIP = true},    --玉米
	ly_tangguo04 = {value = 35,isVIP = true},   --蜘蛛糖	  3级根骨	 500级以下吃了直接升一级
	ly_tangguo05 = {value = 30,isVIP = true},   --卡通糖果    2级根骨
	ly_tangguo06 = {value = 25,isVIP = true},   --葡萄干      1级根骨
	ly_tangguo07 = {value = 45,isVIP = true},   --盒装葡萄干  			 400级以下吃了直接升一级
	ly_tangguo08 = {value = 15,isVIP = true},   --幽灵糖     			 150级以下吃了直接升一级
	ly_tangguo09 = {value = 50,isVIP = true},  --触须棒糖   			 800级以下吃了直接升一级
	ly_tangguo10 = {value = 40,isVIP = true},  --牛奶糖     			 300级以下吃了直接升一级
	ly_tangguo11 = {value = 55,isVIP = true},  --糖果狮      4级根骨     					
	ly_tangguo12 = {value = 80,isVIP = true},  --末世糖      5级根骨
	ly_tangguo12 = {value = 80,isVIP = true},  --末世糖      5级根骨
	rongguang = {value = 30,isVIP = true},  --rongguang
	zhenkong = {value = 50,isVIP = true},  --zhenkong
	chazi = {value = 70,isVIP = true},  --guicha
	taidao = {value = 90,isVIP = true},  --太刀
	ly_tgjys01 = {value = 30,isVIP = true},  --末世糖      5级根骨
	ly_tgjys02 = {value = 60,isVIP = true},  --末世糖      5级根骨
	ly_tgjys03 = {value = 90,isVIP = true},  --末世糖      5级根骨
	hj_pokeball = {value = 20,isVIP = true},  --精灵球
	--deerhat = {value = 20},  --鹿帽子
} 

--在这里写需要增加【按需分配掉落物】组件的生物的代码名
local SpecialBoss = {
	"deerclops",--巨鹿
	"bearger",--熊
	"dragonfly",--龙蝇
	"moose",--鹿鸭
	
	"spiderqueen",--蜘蛛女王
	
	"minotaur",--远古守护者
	
	"beequeen",--蜜蜂女王
	"toadstool",--洞穴蟾蜍
	"toadstool_dark",--悲痛蟾蜍
	"antlion",--蚁狮
	
	"spat",--刚羊
	--    "rabbit", --兔子
  --  "perd", --火鸡
--    "crow", --乌鸦
--    "robin", --红雀
--    "robin_winter", --雪雀
--    "buttlefly", --蝴蝶
--    "fireflies", --萤火虫
--    "bee", --蜜蜂
--    "killerbee", --杀人蜂
--    "fles", --苍蝇
--    "mosquito", --蚊子
--    "frog", --青蛙
--    "beefalo", --牛
--    "babybeefalo", --小牛
--    "lightninggoat", --闪电羊
--    "pigman", --猪人
--    "pigguard", --猪守卫
--    "bunnyman", --兔人
    "merm", --鱼人
--    "spider_hider", --洞穴蜘蛛
--    "spider_spitter", --喷射蜘蛛
--    "spider", --地面小蜘蛛
--    "spider_warrior", --地面绿蜘蛛
    "spiderqueen", --蜘蛛女王
    "spider_dropper", --白蜘蛛
    "hound", --猎狗
    "firehound", --火狗
--    "icehound", --冰狗
--    "tentacle", --触手
--    "tentacle_garden", --巨型触手
    "leif", --树精
    "leif_sparse", --稀有树精
    "walrus", --海象
--    "little_walrus", --小海象
--    "smallbird", --小高鸟
--    "teenbird", --青年高鸟
--    "tallbird", --高鸟
    "koalefant_summer", --夏天的大象
    "koalefant_winter", --冬天的大象
--    "penguin", --企鹅
--    "slurtle", --蜗牛龟
--    "suurtle", --黏糊虫
--    "bat", --蝙蝠
--    "rocky", --龙虾
--    "monkey", --猴子
--    "slurper", --缀食者
--    "buzzard", --秃鹫
--    "mole", --鼹鼠
--    "catcoon", --浣熊
    "knight", --发条骑士
    "bishop", --主教
    "rook", --战车
--    "crawlinghorror", --爬行暗影怪
    "deerclops", --巨鹿
    "minotaur", --远古守护者
--    "worm", --远古虫子
--    "abigail", --abigail（乐园腐竹：”我也不知道是什么东西“）
--    "ghost", --幽灵
--    "shadowwaxwell", --麦斯威尔黑影小人
--    "krampus", --坎普斯
--    "glommer", --格罗门
--    "chester", --切斯特
  --  "lureplant", --食人花
--    "eyeplant", --食人花眼睛
--    "bigfoot", --大脚
--    "pigking", --猪王
 --   "moose", --鹿鸭
    "mossling", --小鸭
    "dragonfly", --龙蝇
    "warg", --座狼
    "bearger", --大熊
--    "birchnudrake", --坚果鸭
--    "mooseegg", --鹿鸭蛋
	"hjzs", --火鸡祭坛BOSS1
	"hjzs1", --火鸡祭坛BOSS1
	"hjzs2", --火鸡祭坛BOSS2
	"hjzs3", --火鸡祭坛BOSS3
	"hjzs4", --火鸡祭坛BOSS4
	"hjzs5", --火鸡祭坛BOSS5
	"hjzs6", --火鸡祭坛BOSS6
	"metal_hulk_merge", --和平行者
	"zombie", --BOSS僵尸
	"zombiewomen", --女僵尸
	"zombieone", --长舌僵尸
	"zombietwo", --独眼僵尸
	"malbatross", --独眼僵尸
	"ly_exrumia", --镜像BOSS
}

--给掉落物们设定掉落物价值
for k,v in pairs(LootValue) do 
	AddPrefabPostInit(k,function(inst)
		if not TheWorld.ismastersim then
			return inst
		end
		if inst.components.inventoryitem then 
			inst.components.inventoryitem:SetLootValue(v.value,v.isVIP)
		end
	end)
end 

--给boss们增加attacker_tracker组件
for k,v in pairs(SpecialBoss) do 
	AddPrefabPostInit(v,function(inst)
	
		AddReplicableComponent("attacker_tracker")

		if not TheWorld.ismastersim then
			return inst
		end
		
		inst:AddComponent("attacker_tracker")
	end)
end 

--在这里判定是不是表现特别优异的玩家（是特殊boss的召唤者/是造成伤害的前两名）
local function IsVIPPlayer(player,rank)
	return rank <= 2 
end 

--掉落糖果之类的杂项
local function DropFestivalLoot(self)
	if IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST) then
		local prefabname = string.upper(self.inst.prefab)
		local num_decor_loot = TUNING.WINTERS_FEAST_TREE_DECOR_LOOT[prefabname] or nil
		if num_decor_loot ~= nil then
			for i = 1, num_decor_loot.basic do
				self:SpawnLootPrefab(GetRandomBasicWinterOrnament(), pt)
			end
			if num_decor_loot.special ~= nil then
				self:SpawnLootPrefab(num_decor_loot.special, pt)
			end
		elseif not TUNING.WINTERS_FEAST_LOOT_EXCLUSION[prefabname] and (self.inst:HasTag("monster") or self.inst:HasTag("animal")) then
			local loot = math.random()
			if loot < 0.005 then
				self:SpawnLootPrefab(GetRandomBasicWinterOrnament(), pt)
			elseif loot < 0.20 then
				self:SpawnLootPrefab("winter_food"..math.random(NUM_WINTERFOOD), pt)
			end
		end
	end
end 

--检查烧焦的掉落物
local function CheckFireable(self,prefabs)
	if self.inst:HasTag("burnt")
		or (self.inst.components.burnable ~= nil and
			self.inst.components.burnable:IsBurning() and
			(self.inst.components.fueled == nil or self.inst.components.burnable.ignorefuel)) then

		local isstructure = self.inst:HasTag("structure")
		for k, v in pairs(prefabs) do
			if PrefabExists(v.."_cooked") then
				prefabs[k] = v.."_cooked"
			elseif PrefabExists("cooked"..v) then
				prefabs[k] = "cooked"..v
			elseif (not isstructure and not self.inst:HasTag("tree")) or self.inst:HasTag("hive") then -- because trees have specific burnt loot and "hive"s are structures...
				prefabs[k] = "ash"
			end
		end
	end
	
	return prefabs
end 

--对loot_list中的掉落物分配给player_list中的玩家,self是组件,specialstr是debug用的字符串
local function DistrubuteLoots(self,player_list,loot_list,specialstr)
	local all_value = 0 
	local all_percent = 0
	local attacker_tracker = self.inst.components.attacker_tracker
	
	local player_list_part = {}
	
	specialstr = specialstr or "掉落物分配"
	
	--总价值
	for k,v in pairs(loot_list) do 
		all_value = all_value + v.components.inventoryitem.lootvalue
	end 
	
	--伤害总比值
	for k,v in pairs(player_list) do 
		local percent = attacker_tracker:CalcPercent(v)
		all_percent = all_percent + (percent or 0 )
	end
	
	--整理好数据加入player_list_part
	for k,v in pairs(player_list) do 
		local percent = attacker_tracker:CalcPercent(v)
		table.insert(player_list_part,{entity = v,percent = percent/all_percent,now_percent = percent/all_percent,items = {}})
	end
				
	--依照价值从大到小排序
	table.sort(loot_list,function(v1,v2) 
		return v1.components.inventoryitem.lootvalue > v2.components.inventoryitem.lootvalue 
	end) 
				
	--依照玩家造成的伤害比值从大到小排序
	table.sort(player_list_part,function(player1,player2) 
		return player1.percent > player2.percent
	end) 
	
	print("等待分配的物品有：")
	for _,item in pairs(loot_list) do 
		print(item)
	end 
	
	--分配掉落物
	for _,item in pairs(loot_list) do 
		local value = item.components.inventoryitem.lootvalue
		local valuepercent = value / all_value
		print("这个"..item.name.."的价值比重是"..valuepercent)
		for rank,player in pairs(player_list_part) do 
			print("player.now_percent:"..player.now_percent)
			if player.now_percent + 0.000000000000001 >= valuepercent then --为了防止某些计算机内部误差，所以加了一个很小的数
				player.now_percent = player.now_percent - valuepercent
				item.Transform:SetPosition(player.entity:GetPosition():Get())
				if player.entity.components.inventory then 
					player.entity.components.inventory:GiveItem(item)
				end
				table.insert(player.items,item)
				print(string.format("给%s分配了%s,now_percent还有%f",player.entity.name,item.name,player.now_percent))
				break 
			end
		end
	end
	
	--这个是用来debug的			
	for _,v in pairs(player_list_part) do 
		local itemstr = ""
		local values = 0 
		for _,item in pairs(v.items) do 
			itemstr = itemstr..tostring(item.name)..","
			values = values + item.components.inventoryitem.lootvalue
		end
		local str = string.format("[%s] %s(伤害比重:%.2f%%)获得了物品:%s(价值比重:%.2f%%)",tostring(specialstr),v.entity.name,v.percent*100,itemstr,values*100/all_value)
		print(str)
	end
end 

AddComponentPostInit("inventoryitem",function(self)
	self.lootvalue = 1
	self.isVIPitem = false 
	
	self.SetLootValue = function(self,val,vip)
		self.lootvalue = val or 1 
		self.isVIPitem = vip or false 
	end 
end)

AddComponentPostInit("lootdropper",function(self)
	local old_DropLoot = self.DropLoot 
	
	self.DropLoot = function(self,pt)
		local attacker_tracker = self.inst.components.attacker_tracker
		if attacker_tracker then 
			local prefabs = self:GenerateLoot()
			
			local vip_loots = {}
			local normal_loots = {} 
			
			local vip_attackers = {}
			local all_attackers = {}
			--local all_value = 0 
			
			prefabs = CheckFireable(self,prefabs)
			DropFestivalLoot(self)
			
			for k, v in pairs(prefabs) do
				local item = self:SpawnLootPrefab(v, pt)
				if item and item:IsValid() and item.components.inventoryitem then 
					if item.components.inventoryitem.isVIPitem then 
						table.insert(vip_loots,item)
					else
						table.insert(normal_loots,item)
					end 
				end 
			end
			
			--剔除不合法的玩家
			attacker_tracker:MakeValid()
			
			for k,v in pairs(attacker_tracker.attackers) do 
				local entity = attacker_tracker:FindAttackerInMap(v.userid)
				table.insert(all_attackers,entity)
			end
			
			--依照玩家造成的伤害比值从大到小排序
			table.sort(all_attackers,function(player1,player2) 
				return attacker_tracker:CalcPercent(player1) > attacker_tracker:CalcPercent(player2)
			end) 
			
			for rank,player in pairs(all_attackers) do 
				if IsVIPPlayer(player,rank) then 
					table.insert(vip_attackers,player) 
				end
			end 
						
			DistrubuteLoots(self,vip_attackers,vip_loots,"VIP掉落物品分配")
			DistrubuteLoots(self,all_attackers,normal_loots)			
		else
			return old_DropLoot(self,pt)
		end
	end 
	
end)











