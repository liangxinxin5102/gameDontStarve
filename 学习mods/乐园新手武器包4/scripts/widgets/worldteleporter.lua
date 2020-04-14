local Widget = require "widgets/widget" --Widget，所有widget的祖先类
local Text = require "widgets/text" --Text类，文本处理
local TextButton = require "widgets/textbutton"
local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"
local UIAnim = require "widgets/uianim"
local TextEdit = require "widgets/textedit"
local TextEditLinked = require "widgets/texteditlinked"

local WorldSpecialTips = {
	--["0"] = "\n0号世界是建家世界",
	["1"]  = "\n世界1(主世界) 禁止建家,禁止挂机",
	
	["2"]  = "\n世界2(地上) 普通建家世界,没有资源",
	["3"]  = "\n世界3(地上) 普通建家世界,没有资源",
	["4"]  = "\n世界4(地上) 普通建家世界,没有资源",
	["5"]  = "\n世界5(地上) 普通建家世界,没有资源",
	["6"]  = "\n世界6(地上) 普通建家世界,没有资源",
	
	["7"]  = "\n世界7(地上) 加强建家世界,有怪物强化",
	["8"]  = "\n世界8(地上) 加强建家世界,有怪物强化",
	
	["9"]  = "\n世界9(地上) 资源世界,内有怪物加强",
	["10"] = "\n世界10(地上) 资源世界,内有怪物加强",
	["11"] = "\n世界11(地上) 资源世界,内有怪物加强",
	["12"] = "\n世界12(地上) 资源世界,内有怪物加强",
	
	["13"] = "\n世界13(地下) 地下建家世界,没有资源",
	["14"] = "\n世界14(地下) 地下建家世界,没有资源",
	
	["15"] = "\n世界15(地下) 地下强化世界",
	["16"] = "\n世界16(地下) 地下强化世界",
	
	["17"] = "\n世界17(地上) 高级强化世界,更加丰富的掉落,更加变态的怪物",
	["18"] = "\n世界18(地上) 高级强化世界,更加丰富的掉落,更加变态的怪物",
	["19"] = "\n世界19(地下) 高级强化世界,更加丰富的掉落,更加变态的怪物",
	["20"] = "\n世界20(地下) 高级强化世界,更加丰富的掉落,更加变态的怪物",	
	
	["21"] = "\n",	
	["22"] = "\n",	
	["23"] = "\n",	
	["24"] = "\n",	
	["25"] = "\n",	
	["26"] = "\n",	
	["27"] = "\n",	
	["28"] = "\n",	
	["29"] = "\n",	
	["30"] = "\n",	
	
	-------
}

local WorldTeleporter = Class(Widget, function(self,owner) 
	Widget._ctor(self, "WorldTeleporter") 
	
	self.owner = owner
	self.TargetWorldId = 0 
	
	self.CallOnButton = self:AddChild(ImageButton())
	self.CallOnButton:SetText("世界传送")
	self.CallOnButton:SetHAnchor(0) 
	self.CallOnButton:SetVAnchor(1) 
    self.CallOnButton:SetPosition(0,-40,0) 
	self.CallOnButton:SetOnClick(function() 
		local isshown = self.Main.shown
		if isshown then 
			self.Main:Hide() 
		else
			self.Main:Show() 
		end
	end)
	
	self.Main = self:AddChild(Image("images/fepanels.xml", "panel_topmods.tex"))
	self.Main:SetHAnchor(0) 
	self.Main:SetVAnchor(0) 
	self.Main:SetPosition(0,0,0)
	self.Main:SetTint(1,1,1,0.5)
	self.Main:SetScale(1.25,1,1)
	self.Main:MoveToBack() 
	self.Main:Hide() 
	
	self.WorldIdEdit = self.Main:AddChild(TextEdit(DEFAULTFONT,32))
    self.WorldIdEdit:EnableWordWrap(true)
    self.WorldIdEdit:EnableScrollEditWindow(false)
    self.WorldIdEdit:EnableWhitespaceWrap(true)
    self.WorldIdEdit:EnableRegionSizeLimit(true)
    self.WorldIdEdit:SetForceEdit(true)
    self.WorldIdEdit:SetAllowNewline(false)
    self.WorldIdEdit.edit_text_color = {1, 1, 1, 1}
    self.WorldIdEdit.idle_text_color = {1, 1, 1, 1}
    self.WorldIdEdit:SetEditCursorColour(1, 1, 1, 1)
    self.WorldIdEdit:SetPosition(0, 90, 0)
    self.WorldIdEdit:SetRegionSize(300, 80)
	
	self.Tips = self.Main:AddChild(Text(BODYTEXTFONT, 32,"提示:"))
	self.Tips:SetPosition(0,0,0)
		
	self.TeleportButton = self.Main:AddChild(ImageButton())
	self.TeleportButton:SetText("传送")
	self.TeleportButton:SetPosition(0,-90,0)
	self.TeleportButton:SetOnClick(function()
		self:DoTeleport() 
	end)
	
	self:StartUpdating()
	
	self.owner:DoTaskInTime(0.1,function()
		self.TargetWorldId = self.owner.player_classified.NowWorldId:value() 
		self.WorldIdEdit:SetString(tostring(self.TargetWorldId))
	end)
end)

function WorldTeleporter:UpdateTips()
	local nowid = self.owner.player_classified.NowWorldId:value() 
	local specialtip_now = WorldSpecialTips[nowid] or "" 
	local targetid = self.TargetWorldId 
	
	local tipstr = string.format("提示:当前您在%s号世界,%s",nowid,specialtip_now)
	if targetid then 
		local specialtip_target = WorldSpecialTips[targetid] or "\n目标世界参数不合法,可能出错" 
		tipstr = tipstr..string.format("\n您要去%s号世界,%s",targetid,specialtip_target)
	end 
	self.Tips:SetString(tipstr)
end 

function WorldTeleporter:OnUpdate(dt)
	self.TargetWorldId = self.WorldIdEdit:GetString()
	self:UpdateTips()
end 

function WorldTeleporter:DoTeleport()
	SendModRPCToServer(MOD_RPC["leyuan_world"]["doteleport"],self.TargetWorldId)
end


return WorldTeleporter