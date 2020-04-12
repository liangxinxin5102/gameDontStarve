require = GLOBAL.require
local Vector3 = GLOBAL.Vector3
local STRINGS = GLOBAL.STRINGS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local TheNet = GLOBAL.TheNet
EQUIPSLOTS = GLOBAL.EQUIPSLOTS
TheFrontEnd = GLOBAL.TheFrontEnd
local SpawnPrefab = GLOBAL.SpawnPrefab
local finiteus = GetModConfigData("finiteus")
local newweapon = GetModConfigData("newweapon")
PrefabFiles = {
"bsd",
"bigbag",
"binggan",
"dangao",
"moshi",
"dianyangqiu",
"hnd",
"hnq",
"sjz",
"xzz",
"bookmoose",
"bookdeerclops",
"bookbearger",
"bookdragonfly"
}

Assets = {
Asset("ATLAS", "images/inventoryimages/hnd.xml"),
Asset("ATLAS", "images/inventoryimages/hnq.xml"),
Asset("ATLAS", "images/inventoryimages/bigbag.xml"),
Asset("ATLAS", "images/inventoryimages/bsd.xml"),
Asset("ATLAS", "images/inventoryimages/binggan.xml"),
Asset("ATLAS", "images/inventoryimages/dangao.xml"),
Asset("ATLAS", "images/inventoryimages/moshi.xml"),
Asset("ATLAS", "images/inventoryimages/dianyangqiu.xml"),
Asset("ATLAS", "images/hud/lr_blackhole.xml"),
Asset("IMAGE", "images/hud/lr_blackhole.tex"),
Asset("ATLAS", "images/inventoryimages/bookmoose.xml"),
Asset("ATLAS", "images/inventoryimages/bookdeerclops.xml"),
Asset("ATLAS", "images/inventoryimages/bookbearger.xml"),
Asset("ATLAS", "images/inventoryimages/bookdragonfly.xml"),
Asset("ATLAS", "images/inventoryimages/sjz.xml"),
Asset("ATLAS", "images/inventoryimages/xzz.xml"),

}


AddRecipe("bsd", {Ingredient("moonrocknugget", 20), Ingredient("gears", 10)},
RECIPETABS.WAR, TECH.SCIENCE, nil, nil, nil, nil, nil,
"images/inventoryimages/bsd.xml", "bsd.tex")
STRINGS.NAMES.BSD = "真正的大宝剑"
STRINGS.RECIPE_DESC.BSD = "宝剑在手天下我有！"

if  finiteus == false  then
	
	
	
	
	local function finiteusbsd( inst )
		inst:RemoveComponent("finiteuses")
	end
	
	AddPrefabPostInit("bsd",finiteusbsd)
	
	
	AddPrefabPostInit("hnd",finiteusbsd)
	

	
	AddPrefabPostInit("hnq",finiteusbsd)
	
	
	
	
	
	
	
end

if newweapon then
	
	AddRecipe("hnq", {Ingredient("nightmarefuel", 20),Ingredient("livinglog", 20), Ingredient("redgem", 20),Ingredient("bluegem", 20),Ingredient("purplegem", 20),Ingredient("greengem", 20),Ingredient("orangegem", 20),Ingredient("yellowgem", 20),Ingredient("dragon_scales", 5)},
	RECIPETABS.WAR, TECH.SCIENCE, nil, nil, nil, nil, nil,
	"images/inventoryimages/hnq.xml", "hnq.tex")
	
	AddRecipe("hnd", {Ingredient("nightmarefuel", 20),Ingredient("livinglog", 20), Ingredient("redgem", 20),Ingredient("bluegem", 20),Ingredient("purplegem", 20),Ingredient("greengem", 20),Ingredient("orangegem", 20),Ingredient("yellowgem", 20),Ingredient("deerclops_eyeball", 10)},
	RECIPETABS.WAR, TECH.SCIENCE, nil, nil, nil, nil, nil,
	"images/inventoryimages/hnd.xml", "hnd.tex")
	
	AddRecipe("sjz", {Ingredient("nightmarefuel", 100),Ingredient("livinglog", 100), Ingredient("redgem", 100),Ingredient("bluegem", 100),Ingredient("purplegem", 100),Ingredient("greengem", 100),Ingredient("orangegem", 100),Ingredient("yellowgem", 100),Ingredient("goose_feather", 100)},
	RECIPETABS.WAR, TECH.SCIENCE, nil, nil, nil, nil, nil,
	"images/inventoryimages/sjz.xml", "sjz.tex")
	
	AddRecipe("xzz", {Ingredient("nightmarefuel", 50),Ingredient("livinglog", 50), Ingredient("redgem", 50),Ingredient("bluegem", 50),Ingredient("purplegem", 50),Ingredient("greengem", 50),Ingredient("orangegem", 50),Ingredient("yellowgem", 50),Ingredient("slurtleslime", 50),Ingredient("slurtle_shellpieces", 50)},
	RECIPETABS.WAR, TECH.SCIENCE, nil, nil, nil, nil, nil,
	"images/inventoryimages/xzz.xml", "xzz.tex")
		
    AddRecipe("bigbag", {Ingredient("krampus_sack", 1),Ingredient("bearger_fur", 20),Ingredient("minotaurhorn", 20)},
	RECIPETABS.MAGIC, TECH.MAGIC_THREE,nil, nil, true, nil, nil ,"images/inventoryimages/bigbag.xml","bigbag.tex")

	
	AddRecipe("bookmoose", {Ingredient("redgem", 5),Ingredient("bluegem", 5),Ingredient("purplegem", 5),Ingredient("greengem", 5),Ingredient("orangegem", 5),Ingredient("yellowgem", 5)},
	RECIPETABS.MAGIC, TECH.MAGIC_THREE,nil, nil, true, nil, nil ,"images/inventoryimages/bookmoose.xml","bookmoose.tex")
	AddRecipe("bookdeerclops", {Ingredient("redgem", 5),Ingredient("bluegem", 5),Ingredient("purplegem", 5),Ingredient("greengem", 5),Ingredient("orangegem", 5),Ingredient("yellowgem", 5)},
	RECIPETABS.MAGIC, TECH.MAGIC_THREE,nil, nil, true, nil, nil ,"images/inventoryimages/bookdeerclops.xml","bookdeerclops.tex")
	AddRecipe("bookbearger", {Ingredient("redgem", 5),Ingredient("bluegem", 5),Ingredient("purplegem", 5),Ingredient("greengem", 5),Ingredient("orangegem", 5),Ingredient("yellowgem", 5)},
	RECIPETABS.MAGIC, TECH.MAGIC_THREE,nil, nil, true, nil, nil ,"images/inventoryimages/bookbearger.xml","bookbearger.tex")
	AddRecipe("bookdragonfly", {Ingredient("redgem", 5),Ingredient("bluegem", 5),Ingredient("purplegem", 5),Ingredient("greengem", 5),Ingredient("orangegem", 5),Ingredient("yellowgem", 5)},
	RECIPETABS.MAGIC, TECH.MAGIC_THREE,nil, nil, true, nil, nil ,"images/inventoryimages/bookdragonfly.xml","bookdragonfly.tex")

	
end




if TheNet:GetIsClient() then
	local function Teleport()
		local topscreen = GLOBAL.TheFrontEnd:GetActiveScreen()
		if topscreen.name ~= "Lr_teleport" and GLOBAL.TheFrontEnd:GetScreenStackSize() <= 1 then
			local Lr_teleport = require("screens/lr_teleport")
			GLOBAL.TheFrontEnd:PushScreen(Lr_teleport(GLOBAL.ThePlayer))
		end
	end
	
	local function Blackhole(self)
		local ImageButton = require("widgets/imagebutton")
		self.blackhole = self:AddChild(ImageButton("images/hud/lr_blackhole.xml", "lr_blackhole.tex", nil, nil, nil, nil, {1,1}, {0,0}))
		self.blackhole:SetScale(.3, .3, .3)
		self.blackhole:SetPosition(-10, 100, 0)
		self.blackhole:SetOnClick(Teleport)
	end
	
	AddClassPostConstruct("widgets/mapcontrols", Blackhole)
	
	AddModRPCHandler("allclients", "lr_teleport", function () end)
	
	
end



STRINGS.NAMES.BOOKMOOSE = "春鹅召唤卷轴"
STRINGS.NAMES.BOOKDEERCLOPS = "巨鹿召唤卷轴"
STRINGS.NAMES.BOOKBEARGER = "巨熊召唤卷轴"
STRINGS.NAMES.BOOKDRAGONFLY = "龙蝇召唤卷轴"

STRINGS.NAMES.XZZ = "小可爱之杖"
STRINGS.RECIPE_DESC.XZZ = "击杀咕噜米可升级"

STRINGS.NAMES.HND = "寒羽之刃"
STRINGS.RECIPE_DESC.HND = "击杀巨鹿和犀牛可以升级"
STRINGS.NAMES.HNQ = "赤羽之矛"
STRINGS.RECIPE_DESC.HNQ = "击杀蜻蜓和犀牛可以升级"
STRINGS.NAMES.SJZ = "上九之杖"
STRINGS.RECIPE_DESC.SJZ = "画师上九专属法杖"

STRINGS.UI.LR_BLACKHOLE = "切换世界"
STRINGS.UI.LR_TELEPORT = "输入编号来传送到其他世界，靠近恶魔门才能执行此操作"
STRINGS.UI.LR_CONFIRM = "确认"
STRINGS.UI.LR_CANCEL = "取消"
STRINGS.UI.LR_TELEPORT_INFO = [[
无视这个
]]



local containers = require("containers")
local widgetsetup_Base = containers.widgetsetup or function() return true end

local containers = GLOBAL.require "containers"

local params = {}

params.bigbag =
{
    widget =
    {
        slotpos = {},
        animbank = nil,
        animbuild = nil,
        bgatlas = "images/bigbagbg.xml",
        bgimage = "bigbagbg.tex",
        pos = Vector3(-120,-60,0),
    },
    issidewidget = true,
    type = "pack",
}

for y = 0, 5 do

	table.insert(params.bigbag.widget.slotpos, Vector3(3  -72, -y*72 + 210, 0))	--New 3rd col
	table.insert(params.bigbag.widget.slotpos, Vector3(3     , -y*72 + 210 ,0))	--2nd col
	table.insert(params.bigbag.widget.slotpos, Vector3(3  +72, -y*72 + 210 ,0))	--1st col at screen edge
	
end



function params.bigbag.itemtestfn(container, item, slot)
    if item:HasTag("bigbag") then
        return false
    end
    return true
end


containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, params.bigbag.widget.slotpos ~= nil and #params.bigbag.widget.slotpos or 0)

local containers_widgetsetup = containers.widgetsetup

function containers.widgetsetup(container, prefab, data)
    local t = data or params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
    end
end

function containers.widgetsetup(container, prefab, data)
    local t = prefab or container.inst.prefab
    if t == "bigbag" then
        local t = params[t]
        if t ~= nil then
            for k, v in pairs(t) do
                container[k] = v
            end
            container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        end
    else
        return containers_widgetsetup(container, prefab)
    end
end
