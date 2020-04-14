
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
AllPlayers = GLOBAL.AllPlayers
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local resolvefilepath = GLOBAL.resolvefilepath
local TheInput = GLOBAL.TheInput
local IsServer = GLOBAL.TheNet:GetIsServer()
local containers = require("containers")

-- PrefabFiles =
-- {
-- "touxian",
-- }

Assets = {
Asset("ATLAS", "images/hud/back.xml"),
Asset("IMAGE", "images/hud/back.tex"),
Asset("ATLAS", "images/hud/hj.xml"),
Asset("IMAGE", "images/hud/hj.tex"),
Asset("ATLAS", "images/hud/huishou.xml"),
Asset("IMAGE", "images/hud/huishou.tex"),
Asset("ATLAS", "images/hud/hupenghuanyou.xml"),
Asset("IMAGE", "images/hud/hupenghuanyou.tex"),
Asset("IMAGE", "images/hud/item1.tex"),
Asset("ATLAS", "images/hud/item1.xml"),
Asset("IMAGE", "images/hud/item2.tex"),
Asset("ATLAS", "images/hud/item2.xml"),
Asset("IMAGE", "images/hud/item3.tex"),
Asset("ATLAS", "images/hud/item3.xml"),
Asset("IMAGE", "images/hud/item4.tex"),
Asset("ATLAS", "images/hud/item4.xml"),
Asset("IMAGE", "images/hud/item5.tex"),
Asset("ATLAS", "images/hud/item5.xml"),
Asset("IMAGE", "images/hud/itemback.tex"),
Asset("ATLAS", "images/hud/itemback.xml"),
Asset("IMAGE", "images/hud/jf.tex"),
Asset("ATLAS", "images/hud/jf.xml"),
Asset("IMAGE", "images/hud/km.tex"),
Asset("ATLAS", "images/hud/km.xml"),
Asset("IMAGE", "images/hud/last.tex"),
Asset("ATLAS", "images/hud/last.xml"),
Asset("IMAGE", "images/hud/mingrenbang.tex"),
Asset("ATLAS", "images/hud/mingrenbang.xml"),
Asset("IMAGE", "images/hud/next.tex"),
Asset("ATLAS", "images/hud/next.xml"),
Asset("IMAGE", "images/hud/queren.tex"),
Asset("ATLAS", "images/hud/queren.xml"),
Asset("IMAGE", "images/hud/tile.tex"),
Asset("ATLAS", "images/hud/tile.xml"),
Asset("IMAGE", "images/hud/tuijian.tex"),
Asset("ATLAS", "images/hud/tuijian.xml"),
Asset("IMAGE", "images/hud/zanzhu.tex"),
Asset("ATLAS", "images/hud/zanzhu.xml"),
}

GLOBAL.AddReplicableComponent("kmplayer")

--人物初始化
    AddPlayerPostInit(function (inst)
    inst.km = {}
    inst.km.ye = GLOBAL.net_uint(inst.GUID,"kmye","kmyedirty")
    inst.km.zye = GLOBAL.net_uint(inst.GUID,"kmzye","kmzyedirty")
	inst.km.jf = GLOBAL.net_uint(inst.GUID,"kmjf","kmjfdirty")
    inst.dialog = {}
    inst.dialog.enable = GLOBAL.net_event(inst.GUID,"kmdialogdirty")
    inst.dialog.str = GLOBAL.net_string(inst.GUID,"dialog.str")
	if GLOBAL.TheWorld.ismastersim then
		inst:AddComponent("kmplayer")
	end
    if not GLOBAL.TheWorld.ismastersim then
		inst:ListenForEvent("kmdialogdirty",function(inst) 
            for k,v in ipairs (GLOBAL.TheFrontEnd.screenstack) do
                if v.out then
                    v:out(inst.dialog.str:value(),inst)
                    return 
                end
            end
    
        end)
        inst:ListenForEvent("kmyedirty",function(inst) 
            for k,v in ipairs (GLOBAL.TheFrontEnd.screenstack) do
                if v.gethj then
                    v:gethj()
                    return 
                end
            end
    
        end)
        inst:ListenForEvent("kmjfdirty",function(inst) 
            for k,v in ipairs (GLOBAL.TheFrontEnd.screenstack) do
                if v.gethj then
                    v:gethj()
                    return 
                end
            end
    
        end)
	end
end)
    
    
local ImageButton = require("widgets/imagebutton")
--商店UI
local function Addstore2(self)
	self.kmstore = self:AddChild(ImageButton("images/hud/hj.xml", "hj.tex", nil, nil, nil, nil, {1,1}, {0,0}))
	self.kmstore:SetScale(1, 1, 1)
	self.kmstore:SetHAnchor(1)
	self.kmstore:SetVAnchor(1)
	self.kmstore:SetPosition(150, -50, 0)
	self.kmstore:SetOnClick(function ()
       GLOBAL.TheFrontEnd:PushScreen(require("screens/kmstore")(GLOBAL.ThePlayer, goodsinfo, ganbilist))
	end)
end
AddClassPostConstruct("widgets/controls", Addstore2)
    
    
if  TheNet:GetIsClient()then
	--客机接受指令
    AddModRPCHandler("kmplayer", "kmcz", function () end)
	AddModRPCHandler("kmplayer", "buy", function () end)
	AddModRPCHandler("kmplayer", "getgoods", function () end)	
end


	


