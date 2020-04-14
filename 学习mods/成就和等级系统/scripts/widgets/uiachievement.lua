local UIAnim = require "widgets/uianim"
local Text = require "widgets/text"
local Widget = require "widgets/widget"
local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"
local AnimButton = require "widgets/animbutton"
local HoverText = require "widgets/hoverer"
--if _G.HARD then 
--	require "AllAchiv/allachivbalancehard"
--else
require "AllAchiv/allachivbalance"
--end

local uiachievement = Class(Widget, function(self, owner)
	Widget._ctor(self, "uiachievement")
	self.owner = owner
	self.mainui = self:AddChild(Widget("mainui"))
	
	self.mainui.achievement_bg = self.mainui:AddChild(Image("images/hud/background_lmod.xml", "background_lmod.tex"))
	self.mainui.achievement_bg:SetPosition(-5, 40, 0)
	self.mainui.achievement_bg:SetScale(1.05,1.1,1)
	self.mainui.achievement_bg:MoveToFront()
	self.mainui.achievement_bg:Hide()
	
	self.mainui.achievement_bg.info = self.mainui.achievement_bg:AddChild(Image("images/hud/background_info.xml", "background_info.tex"))
	--self.mainui.achievement_bg.info:SetPosition(651, -150, 0)
	self.mainui.achievement_bg.info:MoveToBack()
	self.mainui.achievement_bg.info:Hide()
	
	self.mainui.achievement_bg.info.header = self.mainui.achievement_bg.info:AddChild(Text(TITLEFONT, 45))
	self.mainui.achievement_bg.info.header:SetPosition(-20, 415, 0)
	-- self.mainui.achievement_bg.info.header:SetHAlign(ANCHOR_LEFT)
	-- self.mainui.achievement_bg.info.header:SetVAlign(ANCHOR_TOP)
	-- self.mainui.achievement_bg.info.header:SetHAnchor(ANCHOR_LEFT) 
	-- self.mainui.achievement_bg.info.header:SetVAnchor(ANCHOR_TOP)
	
	self.mainui.achievement_bg.info.label = self.mainui.achievement_bg.info:AddChild(Text(BODYTEXTFONT, 26))
	self.mainui.achievement_bg.info.label:SetPosition(-7, 130, 0)
	--self.mainui.achievement_bg.info.label:SetHAlign(ANCHOR_LEFT)
	self.mainui.achievement_bg.info.label:SetVAlign(ANCHOR_TOP)
	
	self.mainui.achievement_bg.title = self.mainui.achievement_bg:AddChild(Text(TITLEFONT, 64))
	self.mainui.achievement_bg.title:SetPosition(0, 435, 0)
	self.mainui.achievement_bg.title:SetString(STRINGS.GUI["achievementTitle"])
	
	self.mainui.achievement_bg.coinamount = self.mainui.achievement_bg:AddChild(Text(NUMBERFONT, 45, self.owner.currentcoinamount:value()))
	self.mainui.achievement_bg.coinamount:SetPosition(-20, 390, 0)
	
	self.mainui.achievement_bg.star = self.mainui.achievement_bg:AddChild(Image("images/hud/star.xml", "star.tex"))
	self.mainui.achievement_bg.star:SetPosition(20, 390, 0)
	self.mainui.achievement_bg.star:SetScale(.5,.5,1)
	
	self.mainui.levelbg = self.mainui:AddChild(Image("images/hud/background_lmod.xml", "background_lmod.tex"))
	self.mainui.levelbg:SetPosition(-5, 40, 0)
	self.mainui.levelbg:SetScale(1.05,1.1,1)
	self.mainui.levelbg:MoveToFront()
	self.mainui.levelbg:Hide()
	
	self.mainui.levelbg.title = self.mainui.levelbg:AddChild(Text(TITLEFONT, 64))
	self.mainui.levelbg.title:SetPosition(0, 420, 0)
	self.mainui.levelbg.title:SetString(STRINGS.GUI["levelTitle"])
	
	self.mainui.achievement_bg.close = self.mainui.achievement_bg:AddChild(ImageButton("images/button/button_bg.xml", "button_bg.tex"))
	self.mainui.achievement_bg.close:SetPosition(0, -355, 0)
	self.mainui.achievement_bg.close:SetScale(1,0.9,1)
	self.mainui.achievement_bg.close:SetOnClick(function()
		self.mainui.allachiv:Hide()
		self.mainui.allcoin:Hide()
		--self.mainui.bigtitle:Hide()
		self.mainui.achievement_bg:Hide()
		self.mainui.infobutton:Hide()
		self.mainui.perk_cat:Hide()
	end)
	self.mainui.achievement_bg.close.label = self.mainui.achievement_bg.close:AddChild(Text(BUTTONFONT, 45))
	--self.mainui.achievement_bg.close.label:SetString(STRINGS.GUI["close"])
	self.mainui.achievement_bg.close.label:SetMultilineTruncatedString(STRINGS.GUI["close"], 2, 100, 50, "", true)
	self.mainui.achievement_bg.close.label:SetColour(0,0,0,1)
	
	self.mainui.allachiv = self.mainui:AddChild(Widget("allachiv"))
	self.mainui.allachiv:SetPosition(0, 460, 0)
	self.mainui.allachiv:Hide()
	
	self.mainui.allcoin = self.mainui:AddChild(Widget("allcoin"))
	self.mainui.allcoin:SetPosition(0, 460, 0)
	self.mainui.allcoin:Hide()
	
	self.mainui.achievement_bg.reset = self.mainui.achievement_bg:AddChild(ImageButton("images/button/button_bg.xml", "button_bg.tex"))
	self.mainui.achievement_bg.reset:SetPosition(365, -355, 0)
	self.mainui.achievement_bg.reset:SetScale(1.1,0.75,1)
	self.mainui.achievement_bg.reset:SetOnClick(function()
		self.mainui.removeinfo:Show()
		self.mainui.removeinfo:MoveToFront()
	end)
	self.mainui.achievement_bg.reset.label = self.mainui.achievement_bg.reset:AddChild(Text(BUTTONFONT, 35))
	--self.mainui.achievement_bg.reset.label:SetString(STRINGS.GUI["reset"])
	self.mainui.achievement_bg.reset.label:SetMultilineTruncatedString(STRINGS.GUI["reset"], 2, 100, 50, "", true)
	self.mainui.achievement_bg.reset.label:SetColour(0,0,0,1)

	self.mainui.removeinfo = self.mainui:AddChild(Image("images/hud/reset_info.xml", "reset_info.tex"))
	self.mainui.removeinfo:SetPosition(445, -180, 0)
	self.mainui.removeinfo:SetScale(1.3,1.3,1)
	self.mainui.removeinfo:Hide()
	self.mainui.removeinfo.label = self.mainui.removeinfo:AddChild(Text(BODYTEXTFONT, 28))
	self.mainui.removeinfo.label:SetPosition(-48, 40, 0)
	--self.mainui.removeinfo.label:SetRegionSize(400,100)
	self.mainui.removeinfo.label:SetMultilineTruncatedString(STRINGS.GUI["resetAchievments"], 5, 330, 500, "", true)
	--self.mainui.removeinfo.label:SetRegionSize(400,100)
	--self.mainui.removeinfo.label:SetString(STRINGS.GUI["resetAchievments"])

	self.mainui.removeinfo.removeyes = self.mainui.removeinfo:AddChild(ImageButton("images/button/button_bg.xml", "button_bg.tex"))
	self.mainui.removeinfo.removeyes:SetPosition(-100, -60, 0)
	self.mainui.removeinfo.removeyes:SetNormalScale(0.6,0.5,1)
	self.mainui.removeinfo.removeyes:SetFocusScale(0.7,0.6,1)
	self.mainui.removeinfo.removeyes:SetOnClick(function()
		self.mainbutton.configbg:Hide()
		self.mainbutton.configbigger:Hide()
		self.mainbutton.configsmaller:Hide()
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["removecoin"])
		self.owner:DoTaskInTime(.35, function()
			self:loadcoinlist()
			self:perk_build()
		end)
		self.mainui.removeinfo:Hide()
		self.mainui.allcoin:Hide()
		self.mainui.achievement_bg:Hide()
		self.mainui.infobutton:Hide()
		self.mainui.allachiv:Hide()
		self.mainui.perk_cat:Hide()
	end)
	self.mainui.removeinfo.removeyes.label = self.mainui.removeinfo.removeyes:AddChild(Text(BUTTONFONT, 27))
	self.mainui.removeinfo.removeyes.label:SetMultilineTruncatedString(STRINGS.GUI["reset"], 2, 70, 50, "", true)
	--self.mainui.removeinfo.removeyes.label:SetString(STRINGS.GUI["reset"])
	self.mainui.removeinfo.removeyes.label:SetColour(0,0,0,1)
	self.mainui.removeinfo.removeyes.label:SetScale(1,0.8,1)

	self.mainui.removeinfo.removeno = self.mainui.removeinfo:AddChild(ImageButton("images/button/button_bg.xml", "button_bg.tex"))
	self.mainui.removeinfo.removeno:SetPosition(20, -60, 0)
	self.mainui.removeinfo.removeno:SetNormalScale(0.6,0.5,1)
	self.mainui.removeinfo.removeno:SetFocusScale(0.7,0.6,1)
	self.mainui.removeinfo.removeno:SetOnClick(function()
		self.mainui.removeinfo:Hide()
	end)
	self.mainui.removeinfo.removeno.label = self.mainui.removeinfo.removeno:AddChild(Text(BUTTONFONT, 27))
	--self.mainui.removeinfo.removeno.label:SetString("Close")
	self.mainui.removeinfo.removeno.label:SetMultilineTruncatedString(STRINGS.GUI["close"], 2, 70, 50, "", true)
	self.mainui.removeinfo.removeno.label:SetColour(0,0,0,1)
	self.mainui.removeinfo.removeno.label:SetScale(1,0.8,1)
	
	self.mainbutton = self:AddChild(Widget("mainbutton"))
	self.mainbutton:SetHAnchor(ANCHOR_LEFT) 
	self.mainbutton:SetVAnchor(ANCHOR_TOP)

	local dragging = false
	self.mainbutton.OnMouseButton = function(inst, button, down, x, y)
		
		if button == 1001 then
			if down then
				dragging = true
				local mousepos = TheInput:GetScreenPosition()
				self.dragPosDiff = self.mainbutton:GetPosition() - mousepos
			else
				dragging = false
			end
		end	
	end
	
	self.followhandler = TheInput:AddMoveHandler(function(x,y)
		if dragging then
			local initialPosition = self.mainbutton:GetPosition()
			local w,h = self.mainbutton.bg:GetSize()
			local margin = 20
			local threshold = h*self.mainbutton.bg:GetScale().y
			local screenw_full, screenh_full = _G.unpack({_G.TheSim:GetScreenSize()})
			if y < screenh_full-threshold-margin then dragging = false end
			local pos
			if type(x) == "number" then
				pos = Vector3(x, y, 1)
			else
				pos = x
			end
			--self.mainbutton:SetPosition(pos.x + self.dragPosDiff.x, initialPosition.y, initialPosition.z)
			--self.menuposition = self.mainbutton:GetPosition()
			SendModRPCToServer(MOD_RPC["DSTAchievement"]["saveWidgetXPos"],pos.x + self.dragPosDiff.x)
		end
	end)
	
	self.mainbutton.bg = self.mainbutton:AddChild(Image("images/button/mainbutton_bg.xml", "mainbutton_bg.tex"))
	self.mainbutton.bg:MoveToFront()
	self.mainbutton.bg:SetClickable(true)
	self.mainbutton.bg:SetHRegPoint(ANCHOR_LEFT)
	self.mainbutton.bg:SetVRegPoint(ANCHOR_TOP)
	self.mainbutton.bg:SetScale(0.60,0.60,1)


	
	self.mainbutton.xpbar_empty = self.mainbutton:AddChild(Image("images/hud/xpbar_empty.xml", "xpbar_empty.tex"))
    self.mainbutton.xpbar_empty:MoveToFront()
	self.mainbutton.xpbar_empty:SetHRegPoint(ANCHOR_LEFT)
    --self.mainbutton.levelbadge:SetHoverText(STRINGS.ALLACHIVCURRENCY[7],{ size = 9, offset_x = 90, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.xpbar_empty:SetScale(0.20,0.15,1)
	self.mainbutton.xpbar_empty:SetPosition(43, -50, 0)
	
	self.mainbutton.xpbar_filled = self.mainbutton:AddChild(Image("images/hud/xpbar_filled.xml", "xpbar_filled.tex"))
    self.mainbutton.xpbar_filled:MoveToFront()
	self.mainbutton.xpbar_filled:SetHRegPoint(ANCHOR_LEFT)
    --self.mainbutton.levelbadge:SetHoverText(STRINGS.ALLACHIVCURRENCY[7],{ size = 9, offset_x = 90, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.xpbar_filled:SetScale(5.1,0.15,1)
	self.mainbutton.xpbar_filled:SetPosition(43, -50, 0)
	
	self.mainbutton.levelbadge = self.mainbutton:AddChild(ImageButton("images/hud/levelbadge.xml", "levelbadge.tex"))
    self.mainbutton.levelbadge:MoveToFront()
    --self.mainbutton.levelbadge:SetHoverText(STRINGS.ALLACHIVCURRENCY[7],{ size = 9, offset_x = 90, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.levelbadge:SetScale(0.20,0.23,1)
	--self.mainbutton.levelbadge:SetFocusScale(0.27,0.27,1)
	self.mainbutton.levelbadge:SetPosition(35, -50, 0)
	
	self.mainbutton.levelbadge:SetOnClick(function()
		if self.mainui.levelbg.shown then
			self.mainui.allcoin:Hide()
			self.mainui.achievement_bg:Hide()
			self.mainui.perk_cat:Hide()
			self.mainui.infobutton:Hide()
			self.mainui.levelbg:Hide()
		else
			self.mainui.allcoin:Hide()
			self.mainui.achievement_bg:Hide()
			self.mainui.infobutton:Hide()
			self.mainui.perk_cat:Hide()
			self.mainui.allachiv:Hide()
			self.mainui.levelbg:Show()
		end
	end)
	
	self.mainbutton.level = self.mainbutton.levelbadge:AddChild(Text(BODYTEXTFONT, 90))
	self.mainbutton.level:SetPosition(10, -3, 0)
	self.mainbutton.level:SetHAlign(ANCHOR_MIDDLE)
	
	if _G.SYSTEM_CONFIG == "achieve" then
		self.mainbutton.xpbar_empty:Hide()
		self.mainbutton.levelbadge:Hide()
		self.mainbutton.xpbar_filled:Hide()
		self.mainbutton.level:Hide()
		self.mainbutton.bg:SetTexture("images/button/mainbutton_bg_achieve.xml", "mainbutton_bg_achieve.tex")
	end

    self.mainbutton.checkbutton = self.mainbutton:AddChild(ImageButton("images/button/checkbutton.xml", "checkbutton.tex"))
    self.mainbutton.checkbutton:MoveToFront()
    self.mainbutton.checkbutton:SetHoverText(STRINGS.ALLACHIVCURRENCY[7],{ size = 9, offset_x = 90, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.checkbutton:SetScale(0.5,0.5,1)
	self.mainbutton.checkbutton:SetPosition(35, -19, 0)

	self.mainbutton.checkbutton:SetOnClick(function()
		if self.mainui.allachiv.shown then
			self.mainui.allachiv:Hide()
			self.mainui.achievement_bg:Hide()
			self.mainui.infobutton:Hide()
			self.mainui.perk_cat:Hide()
			self.mainui.levelbg:Hide()
			self.mainui.achievement_bg.reset:Hide()
		else
			self.mainui.allachiv:Show()
			self.mainui.achievement_bg.reset:Hide()
			self.mainui.achievement_bg:Show()
			self.mainui.infobutton:Show()
			self.mainui.perk_cat:Hide()
			self.mainui.allcoin:Hide()
			self.mainui.levelbg:Hide()
		end
		self.maxnumpage = 11
		self:setAllAchivCategoriesActive()
		
		if self.numpage == 1 then
			self.mainui.infobutton.cat1:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
		if self.numpage == 2 then
			self.mainui.infobutton.cat2:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
		if self.numpage == 3 then
			self.mainui.infobutton.cat3:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
		if self.numpage == 4 then
			self.mainui.infobutton.cat4:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
		if self.numpage == 5 then
			self.mainui.infobutton.cat5:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
		if self.numpage == 6 then
			self.mainui.infobutton.cat6:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
		if self.numpage == 7 then
			self.mainui.infobutton.cat7:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
		if self.numpage == 8 then
			self.mainui.infobutton.cat8:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
		if self.numpage == 9 then
			self.mainui.infobutton.cat9:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
		if self.numpage == 10 then
			self.mainui.infobutton.cat10:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
		if self.numpage == 11 then
			self.mainui.infobutton.cat11:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
	end)

    self.mainbutton.coinbutton = self.mainbutton:AddChild(ImageButton("images/button/coinbutton.xml", "coinbutton.tex"))
    self.mainbutton.coinbutton:MoveToFront()
	self.mainbutton.coinbutton:SetPosition(75, -23, 0)
    self.mainbutton.coinbutton:SetScale(0.5,0.5,1)
    self.mainbutton.coinbutton:SetHoverText(STRINGS.ALLACHIVCURRENCY[8],{ size = 9, offset_x = 15, offset_y = -55, colour = {1,1,1,1}})

	self.mainbutton.coinbutton:SetOnClick(function()
		if self.mainui.allcoin.shown then
			self.mainui.allcoin:Hide()
			self.mainui.achievement_bg.reset:Hide()
			self.mainui.achievement_bg:Hide()
			self.mainui.infobutton:Hide()
			self.mainui.levelbg:Hide()
			self.mainui.perk_cat:Hide()
		else
			self.mainui.allcoin:Show()
			self.mainui.achievement_bg.reset:Show()
			self.mainui.achievement_bg:Show()
			self.mainui.perk_cat:Show()
			self.mainui.infobutton:Hide()
			self.mainui.allachiv:Hide()
			self.mainui.levelbg:Hide()
		end
		if self.perkpage == 1 then
			self.mainui.perk_cat.perkcat1:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		else
			self.mainui.perk_cat.perkcat1:SetTextures("images/button/button_bg.xml", "button_bg.tex")
		end
		if self.perkpage == 2 then
			self.mainui.perk_cat.perkcat2:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		else
			self.mainui.perk_cat.perkcat2:SetTextures("images/button/button_bg.xml", "button_bg.tex")
		end
		if self.perkpage == 3 then
			self.mainui.perk_cat.perkcat3:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		else
			self.mainui.perk_cat.perkcat3:SetTextures("images/button/button_bg.xml", "button_bg.tex")
		end
	end)

	self.mainbutton.configbg = self.mainbutton:AddChild(Image("images/button/config_bg.xml", "config_bg.tex"))
	self.mainbutton.configbg:SetPosition(98, -20, 0)
	self.mainbutton.configbg:SetHRegPoint(ANCHOR_LEFT)
	self.mainbutton.configbg:SetScale(0.6,0.60,1)
	self.mainbutton.configbg:SetClickable(false)
	self.mainbutton.configbg:Hide()

	self.mainbutton.configact = self.mainbutton:AddChild(ImageButton("images/button/config_act.xml", "config_act.tex"))
	self.mainbutton.configact:SetPosition(117, -23, 0)
	self.mainbutton.configact:SetNormalScale(0.5,0.5,1)
	self.mainbutton.configact:SetFocusScale(0.6,0.6,1)
	self.mainbutton.configact:SetHoverText(STRINGS.ALLACHIVCURRENCY[15],{ size = 9, offset_x = 0, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.configact:SetOnClick(function()
		if self.mainbutton.configbg.shown then
			self.mainbutton.configbg:Hide()
			self.mainbutton.configbigger:Hide()
			self.mainbutton.configsmaller:Hide()
			self.mainbutton.configlanguage:Hide()
			self.mainbutton.languages:Hide()
		else
			self.mainbutton.configbg:Show()
			self.mainbutton.configbigger:Show()
			self.mainbutton.configsmaller:Show()
			self.mainbutton.configlanguage:Show()
		end
		self.mainui.removeinfo:Hide()
		self.mainui.removeinfoXP:Hide()
	end)

	self.size = self.owner.currentzoomlevel:value() or 1
	self.mainui:SetScale(self.size, self.size, 1)
	self.mainbutton.configbigger = self.mainbutton:AddChild(ImageButton("images/button/config_bigger.xml", "config_bigger.tex"))
	self.mainbutton.configbigger:SetPosition(145, -23, 0)
	self.mainbutton.configbigger:Hide()
	self.mainbutton.configbigger:SetNormalScale(0.5,0.5,1)
	self.mainbutton.configbigger:SetFocusScale(0.6,0.6,1)
	self.mainbutton.configbigger:SetHoverText(STRINGS.ALLACHIVCURRENCY[16],{ size = 9, offset_x = 0, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.configbigger:SetOnClick(function()
		if not self.mainui.allachiv.shown and not self.mainui.allcoin.shown and not self.mainui.levelbg.shown then
			self.mainui.allachiv:Show()
			self.mainui.achievement_bg:Show()
			self.mainui.infobutton:Show()
		end
		self.size = self.size + .02
		--self.mainui:SetScale(self.size, self.size, 1)
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["saveZoomlevel"],self.size)
		-- debug add
		--SendModRPCToServer(MOD_RPC["DSTAchievement"]["addcoins"])
		--SendModRPCToServer(MOD_RPC["DSTAchievement"]["addxp"])
	end)

	self.mainbutton.configsmaller = self.mainbutton:AddChild(ImageButton("images/button/config_smaller.xml", "config_smaller.tex"))
	self.mainbutton.configsmaller:SetPosition(175, -23, 0)
	self.mainbutton.configsmaller:Hide()
	self.mainbutton.configsmaller:SetNormalScale(0.5,0.5,1)
	self.mainbutton.configsmaller:SetFocusScale(0.6,0.6,1)
	self.mainbutton.configsmaller:SetHoverText(STRINGS.ALLACHIVCURRENCY[17],{ size = 9, offset_x = 0, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.configsmaller:SetOnClick(function()
		if not self.mainui.allachiv.shown and not self.mainui.allcoin.shown and not self.mainui.levelbg.shown then
			self.mainui.allachiv:Show()
			self.mainui.achievement_bg:Show()
			self.mainui.infobutton:Show()
		end
		if self.size > .02 then
			self.size = self.size - .02
		end
		--self.mainui:SetScale(self.size, self.size, 1)
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["saveZoomlevel"],self.size)
	end)
	
	self.mainbutton.configlanguage = self.mainbutton:AddChild(ImageButton("images/button/config_language.xml", "config_language.tex"))
	self.mainbutton.configlanguage:SetPosition(205, -23, 0)
	self.mainbutton.configlanguage:Hide()
	self.mainbutton.configlanguage:SetNormalScale(0.5,0.5,1)
	self.mainbutton.configlanguage:SetFocusScale(0.6,0.6,1)
	self.mainbutton.configlanguage:SetHoverText(STRINGS.ALLACHIVCURRENCY[17],{ size = 9, offset_x = 0, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.configlanguage:SetOnClick(function()
		if self.mainbutton.languages.shown then
			self.mainbutton.languages:Hide()
		else
			self.mainbutton.languages:Show()
		end
	end)
	local languagelist = { "English", "Korean", "Portugese (Brazil)", "Spanish", "Italian", "simplified Chinese", "traditional Chinese", "Russian", "German", "Vietnamese"}
	local shortlist = { "e", "kr", "ptbr", "es", "it", "chs", "cht", "ru", "de", "vi"}
	self.mainbutton.languages = self.mainbutton:AddChild(Widget("languages"))
	self.mainbutton.languages:SetPosition(205, -20, 0)
	self.mainbutton.languages:Hide()
	local languagebuttons = {}
	for i, language in ipairs(languagelist) do
		languagebuttons[i] = self.mainbutton.languages:AddChild(ImageButton("images/button/levelplus.xml", "levelplus.tex"))
		languagebuttons[i]:SetPosition(0, i*-40, 0)
		languagebuttons[i]:SetScale(1.5,1,1)
		languagebuttons[i].label = languagebuttons[i]:AddChild(Text(DEFAULTFONT, 18))
		languagebuttons[i].label:SetColour(0,0,0,1)
		languagebuttons[i].label:SetHAlign(ANCHOR_MIDDLE)
		languagebuttons[i].label:SetPosition(0, 2, 0)
		languagebuttons[i].label:SetScale(0.5,0.7,1)
		languagebuttons[i].label:SetMultilineTruncatedString(language, 2, 110, 50, "", true)
		languagebuttons[i]:SetOnClick(function()
			SendModRPCToServer(MOD_RPC["DSTAchievement"]["saveLanguage"],shortlist[i])
			self:changeLanguage(shortlist[i])
			self.mainbutton.configbg:Hide()
			self.mainbutton.configbigger:Hide()
			self.mainbutton.configsmaller:Hide()
			self.mainbutton.configlanguage:Hide()
			self.mainbutton.languages:Hide()
		end)
	end

	self.mainui.infobutton = self.mainui:AddChild(Widget("infobutton"))
	self.mainui.infobutton:SetPosition(339, 85, 0)
	self.mainui.infobutton:Hide()
	
	self.mainui.perk_cat = self.mainui:AddChild(Widget("perk_cat"))
	self.mainui.perk_cat:SetPosition(500, 85, 0)
	self.mainui.perk_cat:Hide()

	self.mainui.infobutton.cat1 = self.mainui.infobutton:AddChild(ImageButton("images/button/button_bg_inactive.xml", "button_bg_inactive.tex"))
	self.mainui.infobutton.cat1:SetScale(0.65,0.6,1)
	self.mainui.infobutton.cat1:SetPosition(-780, -370, 0)
	self.mainui.infobutton.cat1:SetOnClick(function()
		if self.mainui.allachiv.shown then
			self.numpage = 1
			self:build()
			self:setAllAchivCategoriesActive()
			self.mainui.infobutton.cat1:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
	end)
	self.mainui.infobutton.cat1.label = self.mainui.infobutton.cat1:AddChild(Text(BUTTONFONT, 55))
	--self.mainui.infobutton.cat1.label:SetString(STRINGS.GUI["food"])
	self.mainui.infobutton.cat1.label:SetScale(0.9,0.9,1)
	self.mainui.infobutton.cat1.label:SetColour(0,0,0,1)
	self.mainui.infobutton.cat1.label:SetMultilineTruncatedString(STRINGS.GUI["food"], 2, 120, 50, "", true)

	self.mainui.infobutton.cat2 = self.mainui.infobutton:AddChild(ImageButton("images/button/button_bg_inactive.xml", "button_bg_inactive.tex"))
	self.mainui.infobutton.cat2:SetPosition(-693, -370, 0)
	self.mainui.infobutton.cat2:SetScale(0.65,0.6,1)
	self.mainui.infobutton.cat2:SetOnClick(function()
		if self.mainui.allachiv.shown then
			self.numpage = 2
			self:build()
			self:setAllAchivCategoriesActive()
			self.mainui.infobutton.cat2:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
	end)
	self.mainui.infobutton.cat2.label = self.mainui.infobutton.cat2:AddChild(Text(BUTTONFONT, 55))
	--self.mainui.infobutton.cat2.label:SetString(STRINGS.GUI["life"])
	self.mainui.infobutton.cat2.label:SetScale(0.9,0.9,1)
	self.mainui.infobutton.cat2.label:SetColour(0,0,0,1)
	self.mainui.infobutton.cat2.label:SetMultilineTruncatedString(STRINGS.GUI["life"], 2, 120, 50, "", true)

	self.mainui.infobutton.cat3 = self.mainui.infobutton:AddChild(ImageButton("images/button/button_bg_inactive.xml", "button_bg_inactive.tex"))
	self.mainui.infobutton.cat3:SetPosition(-606, -370, 0)
	self.mainui.infobutton.cat3:SetScale(0.65,0.6,1)
	self.mainui.infobutton.cat3:SetOnClick(function()
		if self.mainui.allachiv.shown then
			self.numpage = 3
			self:build()
			self:setAllAchivCategoriesActive()
			self.mainui.infobutton.cat3:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
	end)
	self.mainui.infobutton.cat3.label = self.mainui.infobutton.cat3:AddChild(Text(BUTTONFONT, 55))
	--self.mainui.infobutton.cat3.label:SetString(STRINGS.GUI["work"])
	self.mainui.infobutton.cat3.label:SetScale(0.9,0.9,1)
	self.mainui.infobutton.cat3.label:SetColour(0,0,0,1)
	self.mainui.infobutton.cat3.label:SetMultilineTruncatedString(STRINGS.GUI["work"], 2, 120, 50, "", true)

	self.mainui.infobutton.cat4 = self.mainui.infobutton:AddChild(ImageButton("images/button/button_bg_inactive.xml", "button_bg_inactive.tex"))
	self.mainui.infobutton.cat4:SetPosition(-519, -370, 0)
	self.mainui.infobutton.cat4:SetScale(0.65,0.6,1)
	self.mainui.infobutton.cat4:SetOnClick(function()
		if self.mainui.allachiv.shown then
			self.numpage = 4
			self:build()
			self:setAllAchivCategoriesActive()
			self.mainui.infobutton.cat4:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
	end)
	self.mainui.infobutton.cat4.label = self.mainui.infobutton.cat4:AddChild(Text(BUTTONFONT, 55))
	--self.mainui.infobutton.cat4.label:SetString(STRINGS.GUI["have"])
	self.mainui.infobutton.cat4.label:SetScale(0.9,0.9,1)
	self.mainui.infobutton.cat4.label:SetColour(0,0,0,1)
	self.mainui.infobutton.cat4.label:SetMultilineTruncatedString(STRINGS.GUI["have"], 2, 120, 50, "", true)

	self.mainui.infobutton.cat5 = self.mainui.infobutton:AddChild(ImageButton("images/button/button_bg_inactive.xml", "button_bg_inactive.tex"))
	self.mainui.infobutton.cat5:SetPosition(-432, -370, 0)
	self.mainui.infobutton.cat5:SetScale(0.65,0.6,1)
	self.mainui.infobutton.cat5:SetOnClick(function()
		if self.mainui.allachiv.shown then
			self.numpage = 5
			self:build()
			self:setAllAchivCategoriesActive()
			self.mainui.infobutton.cat5:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
	end)
	self.mainui.infobutton.cat5.label = self.mainui.infobutton.cat5:AddChild(Text(BUTTONFONT, 55))
	--self.mainui.infobutton.cat5.label:SetString(STRINGS.GUI["like"])
	self.mainui.infobutton.cat5.label:SetScale(0.9,0.9,1)
	self.mainui.infobutton.cat5.label:SetColour(0,0,0,1)
	self.mainui.infobutton.cat5.label:SetMultilineTruncatedString(STRINGS.GUI["like"], 2, 120, 50, "", true)

	self.mainui.infobutton.cat6 = self.mainui.infobutton:AddChild(ImageButton("images/button/button_bg_inactive.xml", "button_bg_inactive.tex"))
	self.mainui.infobutton.cat6:SetPosition(-345, -370, 0)
	self.mainui.infobutton.cat6:SetScale(0.65,0.6,1)
	self.mainui.infobutton.cat6:SetOnClick(function()
		if self.mainui.allachiv.shown then
			self.numpage = 6
			self:build()
			self:setAllAchivCategoriesActive()
			self.mainui.infobutton.cat6:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
	end)
	self.mainui.infobutton.cat6.label = self.mainui.infobutton.cat6:AddChild(Text(BUTTONFONT, 55))
	--self.mainui.infobutton.cat6.label:SetString(STRINGS.GUI["pain"])
	self.mainui.infobutton.cat6.label:SetScale(0.9,0.9,1)
	self.mainui.infobutton.cat6.label:SetColour(0,0,0,1)
	self.mainui.infobutton.cat6.label:SetMultilineTruncatedString(STRINGS.GUI["pain"], 2, 120, 50, "", true)

	self.mainui.infobutton.cat7 = self.mainui.infobutton:AddChild(ImageButton("images/button/button_bg_inactive.xml", "button_bg_inactive.tex"))
	self.mainui.infobutton.cat7:SetPosition(-258, -370, 0)
	self.mainui.infobutton.cat7:SetScale(0.65,0.6,1)
	self.mainui.infobutton.cat7:SetOnClick(function()
		if self.mainui.allachiv.shown then
			self.numpage = 7
			self:build()
			self:setAllAchivCategoriesActive()
			self.mainui.infobutton.cat7:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
	end)
	self.mainui.infobutton.cat7.label = self.mainui.infobutton.cat7:AddChild(Text(BUTTONFONT, 55))
	--self.mainui.infobutton.cat7.label:SetString(STRINGS.GUI["fight"])
	self.mainui.infobutton.cat7.label:SetScale(0.9,0.9,1)
	self.mainui.infobutton.cat7.label:SetColour(0,0,0,1)
	self.mainui.infobutton.cat7.label:SetMultilineTruncatedString(STRINGS.GUI["fight"], 2, 120, 50, "", true)

	self.mainui.infobutton.cat8 = self.mainui.infobutton:AddChild(ImageButton("images/button/button_bg_inactive.xml", "button_bg_inactive.tex"))
	self.mainui.infobutton.cat8:SetPosition(-171, -370, 0)
	self.mainui.infobutton.cat8:SetScale(0.65,0.6,1)
	self.mainui.infobutton.cat8:SetOnClick(function()
		if self.mainui.allachiv.shown then
			self.numpage = 8
			self:build()
			self:setAllAchivCategoriesActive()
			self.mainui.infobutton.cat8:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
	end)
	self.mainui.infobutton.cat8.label = self.mainui.infobutton.cat8:AddChild(Text(BUTTONFONT, 55))
	--self.mainui.infobutton.cat8.label:SetString(STRINGS.GUI["hunt"])
	self.mainui.infobutton.cat8.label:SetScale(0.9,0.9,1)
	self.mainui.infobutton.cat8.label:SetColour(0,0,0,1)
	self.mainui.infobutton.cat8.label:SetMultilineTruncatedString(STRINGS.GUI["hunt"], 2, 120, 50, "", true)

	self.mainui.infobutton.cat9 = self.mainui.infobutton:AddChild(ImageButton("images/button/button_bg_inactive.xml", "button_bg_inactive.tex"))
	self.mainui.infobutton.cat9:SetPosition(-84, -370, 0)
	self.mainui.infobutton.cat9:SetScale(0.65,0.6,1)
	self.mainui.infobutton.cat9:SetOnClick(function()
		if self.mainui.allachiv.shown then
			self.numpage = 9
			self:build()
			self:setAllAchivCategoriesActive()
			self.mainui.infobutton.cat9:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
	end)
	self.mainui.infobutton.cat9.label = self.mainui.infobutton.cat9:AddChild(Text(BUTTONFONT, 55))
	--self.mainui.infobutton.cat9.label:SetString(STRINGS.GUI["boss"])
	self.mainui.infobutton.cat9.label:SetScale(0.9,0.9,1)
	self.mainui.infobutton.cat9.label:SetColour(0,0,0,1)
	self.mainui.infobutton.cat9.label:SetMultilineTruncatedString(STRINGS.GUI["boss"], 2, 120, 50, "", true)
	
	self.mainui.infobutton.cat10 = self.mainui.infobutton:AddChild(ImageButton("images/button/button_bg_inactive.xml", "button_bg_inactive.tex"))
	self.mainui.infobutton.cat10:SetPosition(3, -370, 0)
	self.mainui.infobutton.cat10:SetScale(0.65,0.6,1)
	self.mainui.infobutton.cat10:SetOnClick(function()
		if self.mainui.allachiv.shown then
			self.numpage = 10
			self:build()
			self:setAllAchivCategoriesActive()
			self.mainui.infobutton.cat10:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
	end)
	self.mainui.infobutton.cat10.label = self.mainui.infobutton.cat10:AddChild(Text(BUTTONFONT, 55))
	--self.mainui.infobutton.cat10.label:SetString(STRINGS.GUI["misc"])
	self.mainui.infobutton.cat10.label:SetScale(0.9,0.9,1)
	self.mainui.infobutton.cat10.label:SetColour(0,0,0,1)
	self.mainui.infobutton.cat10.label:SetMultilineTruncatedString(STRINGS.GUI["misc"], 2, 120, 50, "", true)
	
	self.mainui.infobutton.cat11 = self.mainui.infobutton:AddChild(ImageButton("images/button/button_bg_inactive.xml", "button_bg_inactive.tex"))
	self.mainui.infobutton.cat11:SetPosition(90, -370, 0)
	self.mainui.infobutton.cat11:SetScale(0.65,0.6,1)
	self.mainui.infobutton.cat11:SetOnClick(function()
		if self.mainui.allachiv.shown then
			self.numpage = 11
			self:build()
			self:setAllAchivCategoriesActive()
			self.mainui.infobutton.cat11:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
	end)
	self.mainui.infobutton.cat11.label = self.mainui.infobutton.cat11:AddChild(Text(BUTTONFONT, 55))
	--self.mainui.infobutton.cat11.label:SetString(STRINGS.GUI["mile"])
	self.mainui.infobutton.cat11.label:SetScale(0.9,0.9,1)
	self.mainui.infobutton.cat11.label:SetColour(0,0,0,1)
	self.mainui.infobutton.cat11.label:SetMultilineTruncatedString(STRINGS.GUI["mile"], 2, 120, 50, "", true)
	
	
	--Buttons
	self.mainui.perk_cat.perkcat1 = self.mainui.perk_cat:AddChild(ImageButton("images/button/button_bg_inactive.xml", "button_bg_inactive.tex"))
	self.mainui.perk_cat.perkcat1:SetPosition(-690, -370, 0)
	self.mainui.perk_cat.perkcat1:SetScale(1.4,0.7,1)
	self.mainui.perk_cat.perkcat1:SetOnClick(function()
		if self.mainui.allcoin.shown then
			self.perkpage = 1
			self:perk_build()
			self.mainui.perk_cat.perkcat1:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
			self.mainui.perk_cat.perkcat2:SetTextures("images/button/button_bg.xml", "button_bg.tex")
			self.mainui.perk_cat.perkcat3:SetTextures("images/button/button_bg.xml", "button_bg.tex")
		end
	end)
	self.mainui.perk_cat.perkcat1.label = self.mainui.perk_cat.perkcat1:AddChild(Text(BUTTONFONT, 45))
	self.mainui.perk_cat.perkcat1.label:SetMultilineTruncatedString(STRINGS.GUI["attributes"], 2, 150, 50, "", true)
	--self.mainui.perk_cat.perkcat1.label:SetString(STRINGS.GUI["attributes"])
	self.mainui.perk_cat.perkcat1.label:SetScale(0.6,1,1)
	self.mainui.perk_cat.perkcat1.label:SetColour(0,0,0,1)

	self.mainui.perk_cat.perkcat2 = self.mainui.perk_cat:AddChild(ImageButton("images/button/button_bg_inactive.xml", "button_bg_inactive.tex"))
	self.mainui.perk_cat.perkcat2:SetPosition(-500, -370, 0)
	self.mainui.perk_cat.perkcat2:SetScale(1.4,0.7,1)
	self.mainui.perk_cat.perkcat2:SetOnClick(function()
		if self.mainui.allcoin.shown then
			self.perkpage = 2
			self:perk_build()
			self.mainui.perk_cat.perkcat1:SetTextures("images/button/button_bg.xml", "button_bg.tex")
			self.mainui.perk_cat.perkcat2:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
			self.mainui.perk_cat.perkcat3:SetTextures("images/button/button_bg.xml", "button_bg.tex")
		end
	end)
	self.mainui.perk_cat.perkcat2.label = self.mainui.perk_cat.perkcat2:AddChild(Text(BUTTONFONT, 45))
	self.mainui.perk_cat.perkcat2.label:SetMultilineTruncatedString(STRINGS.GUI["abilities"], 2, 150, 50, "", true)
	--self.mainui.perk_cat.perkcat2.label:SetString(STRINGS.GUI["abilities"])
	self.mainui.perk_cat.perkcat2.label:SetScale(0.6,1,1)
	self.mainui.perk_cat.perkcat2.label:SetColour(0,0,0,1)

	self.mainui.perk_cat.perkcat3 = self.mainui.perk_cat:AddChild(ImageButton("images/button/button_bg_inactive.xml", "button_bg_inactive.tex"))
	self.mainui.perk_cat.perkcat3:SetPosition(-310, -370, 0)
	self.mainui.perk_cat.perkcat3:SetScale(1.4,0.7,1)
	self.mainui.perk_cat.perkcat3:SetOnClick(function()
		if self.mainui.allcoin.shown then
			self.perkpage = 3
			self:perk_build()
			self.mainui.perk_cat.perkcat1:SetTextures("images/button/button_bg.xml", "button_bg.tex")
			self.mainui.perk_cat.perkcat2:SetTextures("images/button/button_bg.xml", "button_bg.tex")
			self.mainui.perk_cat.perkcat3:SetTextures("images/button/button_bg_inactive.xml", "button_bg_inactive.tex")
		end
	end)
	self.mainui.perk_cat.perkcat3.label = self.mainui.perk_cat.perkcat3:AddChild(Text(BUTTONFONT, 45))
	--self.mainui.perk_cat.perkcat3.label:SetString(STRINGS.GUI["crafting"])
	self.mainui.perk_cat.perkcat3.label:SetMultilineTruncatedString(STRINGS.GUI["crafting"], 2, 150, 50, "", true)
	self.mainui.perk_cat.perkcat3.label:SetScale(0.6,1,1)
	self.mainui.perk_cat.perkcat3.label:SetColour(0,0,0,1)

	if _G.HIDEPERK_CONFIG == "ab" then
		self.mainui.perk_cat.perkcat2:Hide()
		self.mainui.perk_cat.perkcat1:SetPosition(-603, -370, 0)
		self.mainui.perk_cat.perkcat3:SetPosition(-393, -370, 0)
	end
	
	if _G.HIDEPERK_CONFIG == "cr" then
		self.mainui.perk_cat.perkcat3:Hide()
		self.mainui.perk_cat.perkcat1:SetPosition(-603, -370, 0)
		self.mainui.perk_cat.perkcat2:SetPosition(-393, -370, 0)
	end
	
	if _G.HIDEPERK_CONFIG == "abcr" then
		self.mainui.perk_cat.perkcat2:Hide()
		self.mainui.perk_cat.perkcat3:Hide()
		self.mainui.perk_cat.perkcat1:SetPosition(-507, -370, 0)
	end

	-- Level Page

	self.mainui.levelbg.xpbar_empty = self.mainui.levelbg:AddChild(Image("images/hud/xpbar_empty.xml", "xpbar_empty.tex"))
	self.mainui.levelbg.xpbar_empty:SetHRegPoint(ANCHOR_LEFT)
	self.mainui.levelbg.xpbar_empty:SetPosition(-308, 209, 0)
	self.mainui.levelbg.xpbar_empty:SetScale(1.75,0.78,1)
	self.mainui.levelbg.xpbar_filled = self.mainui.levelbg:AddChild(Image("images/hud/xpbar_filled.xml", "xpbar_filled.tex"))
	self.mainui.levelbg.xpbar_filled:SetHRegPoint(ANCHOR_LEFT)
	self.mainui.levelbg.xpbar_filled:SetPosition(-308, 209, 0)
	self.mainui.levelbg.xpbar_filled:SetScale(44.5,0.78,1)
	self.mainui.levelbg.levelxp = self.mainui.levelbg:AddChild(Text(BODYTEXTFONT, 45))
	self.mainui.levelbg.levelxp:SetPosition(10, 208, 0)
	self.mainui.levelbg.levelxp:SetHAlign(ANCHOR_MIDDLE)
	
	
	self.mainui.levelbg.overallxp = self.mainui.levelbg:AddChild(Text(BODYTEXTFONT, 45))
	self.mainui.levelbg.overallxp:SetPosition(300, 300, 0)
	self.mainui.levelbg.overallxp:SetHAlign(ANCHOR_RIGHT)
	
	
	self.mainui.levelbg.levelbadge = self.mainui.levelbg:AddChild(Image("images/hud/levelbadge.xml", "levelbadge.tex"))
	self.mainui.levelbg.levelbadge:SetPosition(-360, 210, 0)
	self.mainui.levelbg.levelbadge:SetScale(1.3,1.3,1)
	self.mainui.levelbg.level = self.mainui.levelbg.levelbadge:AddChild(Text(BODYTEXTFONT, 90))
	self.mainui.levelbg.level:SetPosition(10, -3, 0)
	self.mainui.levelbg.level:SetHAlign(ANCHOR_MIDDLE)
	
	
	self.mainui.levelbg.freepoints = self.mainui.levelbg:AddChild(Text(BODYTEXTFONT, 45))
	self.mainui.levelbg.freepoints:SetPosition(-350, 75, 0)
	self.mainui.levelbg.freepoints:SetHAlign(ANCHOR_MIDDLE)
	
	self.mainui.levelbg.costheader = self.mainui.levelbg:AddChild(Text(BODYTEXTFONT, 45))
	self.mainui.levelbg.costheader:SetPosition(300, 140, 0)
	self.mainui.levelbg.costheader:SetHAlign(ANCHOR_MIDDLE)
	self.mainui.levelbg.costheader:SetString(STRINGS.GUI["attributecost"])
	
	self.mainui.levelbg.costs = self.mainui.levelbg:AddChild(Text(BODYTEXTFONT, 45))
	self.mainui.levelbg.costs:SetPosition(300, -75, 0)
	self.mainui.levelbg.costs:SetHAlign(ANCHOR_MIDDLE)
	
	self.mainui.levelbg.attributelabels = self.mainui.levelbg:AddChild(Text(BODYTEXTFONT, 45))
	self.mainui.levelbg.attributelabels:SetPosition(-140, -75, 0)
	self.mainui.levelbg.attributelabels:SetHAlign(ANCHOR_RIGHT)
	self.mainui.levelbg.attributelabels:SetString(STRINGS.GUI["attributelabels"])
	
	self.mainui.levelbg.attributelevels = self.mainui.levelbg:AddChild(Text(BODYTEXTFONT, 45))
	self.mainui.levelbg.attributelevels:SetPosition(50, -75, 0)
	self.mainui.levelbg.attributelevels:SetHAlign(ANCHOR_RIGHT)
	
	self.mainui.levelbg.attributeunits = self.mainui.levelbg:AddChild(Text(BODYTEXTFONT, 45))
	self.mainui.levelbg.attributeunits:SetPosition(90, -75, 0)
	self.mainui.levelbg.attributeunits:SetHAlign(ANCHOR_RIGHT)
	self.mainui.levelbg.attributeunits:SetString(STRINGS.GUI["attributeunits"])
	
	self.mainui.levelbg.reset = self.mainui.levelbg:AddChild(ImageButton("images/button/button_bg.xml", "button_bg.tex"))
	self.mainui.levelbg.reset:SetPosition(365, -355, 0)
	self.mainui.levelbg.reset:SetScale(1.1,0.75,1)
	self.mainui.levelbg.reset:SetOnClick(function()
		self.mainui.removeinfoXP:Show()
		self.mainui.removeinfoXP:MoveToFront()
	end)
	self.mainui.levelbg.reset.label = self.mainui.levelbg.reset:AddChild(Text(BUTTONFONT, 35))
	--self.mainui.levelbg.reset.label:SetString(STRINGS.GUI["reset"])
	self.mainui.levelbg.reset.label:SetMultilineTruncatedString(STRINGS.GUI["reset"], 2, 100, 50, "", true)
	self.mainui.levelbg.reset.label:SetColour(0,0,0,1)
	
	self.mainui.removeinfoXP = self.mainui:AddChild(Image("images/hud/reset_info.xml", "reset_info.tex"))
	self.mainui.removeinfoXP:SetPosition(445, -180, 0)
	self.mainui.removeinfoXP:SetScale(1.3,1.3,1)
	self.mainui.removeinfoXP:Hide()
	self.mainui.removeinfoXP.label = self.mainui.removeinfoXP:AddChild(Text(BODYTEXTFONT, 28))
	self.mainui.removeinfoXP.label:SetPosition(-48, 40, 0)
	--self.mainui.removeinfoXP.label:SetRegionSize(400,100)
	--self.mainui.removeinfoXP.label:SetString(STRINGS.GUI["resetlevel"])
	self.mainui.removeinfoXP.label:SetMultilineTruncatedString(STRINGS.GUI["resetlevel"], 5, 330, 500, "", true)

	self.mainui.removeinfoXP.removeyes = self.mainui.removeinfoXP:AddChild(ImageButton("images/button/button_bg.xml", "button_bg.tex"))
	self.mainui.removeinfoXP.removeyes:SetPosition(-100, -60, 0)
	self.mainui.removeinfoXP.removeyes:SetNormalScale(0.6,0.6,1)
	self.mainui.removeinfoXP.removeyes:SetFocusScale(0.7,0.7,1)
	self.mainui.removeinfoXP.removeyes:SetOnClick(function()
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["removeattributepoints"])
		self.mainui.removeinfoXP:Hide()
		self.mainui.levelbg:Hide()
	end)
	self.mainui.removeinfoXP.removeyes.label = self.mainui.removeinfoXP.removeyes:AddChild(Text(BUTTONFONT, 28))
	--self.mainui.removeinfoXP.removeyes.label:SetString(STRINGS.GUI["reset"])
	self.mainui.removeinfoXP.removeyes.label:SetMultilineTruncatedString(STRINGS.GUI["reset"], 2, 70, 50, "", true)
	self.mainui.removeinfoXP.removeyes.label:SetColour(0,0,0,1)
	self.mainui.removeinfoXP.removeyes.label:SetScale(1,0.8,1)

	self.mainui.removeinfoXP.removeno = self.mainui.removeinfoXP:AddChild(ImageButton("images/button/button_bg.xml", "button_bg.tex"))
	self.mainui.removeinfoXP.removeno:SetPosition(20, -60, 0)
	self.mainui.removeinfoXP.removeno:SetNormalScale(0.6,0.6,1)
	self.mainui.removeinfoXP.removeno:SetFocusScale(0.7,0.7,1)
	self.mainui.removeinfoXP.removeno:SetOnClick(function()
		self.mainui.removeinfoXP:Hide()
	end)
	
	self.mainui.removeinfoXP.removeno.label = self.mainui.removeinfoXP.removeno:AddChild(Text(BUTTONFONT, 28))
	--self.mainui.removeinfoXP.removeno.label:SetString(STRINGS.GUI["close"])
	self.mainui.removeinfoXP.removeno.label:SetMultilineTruncatedString(STRINGS.GUI["close"], 2, 70, 50, "", true)
	self.mainui.removeinfoXP.removeno.label:SetColour(0,0,0,1)
	self.mainui.removeinfoXP.removeno.label:SetScale(1,0.8,1)
	
	self.mainui.levelbg.close = self.mainui.levelbg:AddChild(ImageButton("images/button/button_bg.xml", "button_bg.tex"))
	self.mainui.levelbg.close:SetPosition(0, -355, 0)
	self.mainui.levelbg.close:SetScale(1,0.9,1)
	self.mainui.levelbg.close:SetOnClick(function()
		self.mainui.allachiv:Hide()
		self.mainui.allcoin:Hide()
		self.mainui.levelbg:Hide()
		self.mainui.achievement_bg:Hide()
		self.mainui.infobutton:Hide()
		self.mainui.perk_cat:Hide()
	end)
	self.mainui.levelbg.close.label = self.mainui.levelbg.close:AddChild(Text(BUTTONFONT, 45))
	--self.mainui.levelbg.close.label:SetString(STRINGS.GUI["close"])
	self.mainui.levelbg.close.label:SetMultilineTruncatedString(STRINGS.GUI["close"], 2, 100, 50, "", true)
	self.mainui.levelbg.close.label:SetColour(0,0,0,1)
	
	self.mainui.levelbg.info = self.mainui.levelbg:AddChild(Text(BODYTEXTFONT, 28))
	self.mainui.levelbg.info:SetPosition(0, -290, 0)
	self.mainui.levelbg.info:SetHAlign(ANCHOR_MIDDLE)
	self.mainui.levelbg.info:SetMultilineTruncatedString(STRINGS.GUI["iteminfo"], 2, 800, 500, "", true)--:SetString(STRINGS.GUI["iteminfo"])
	
	self.mainui.levelbg.levelupbuttons = self.mainui.levelbg:AddChild(Widget("levelupbuttons"))
	self.mainui.levelbg.levelupbuttons:SetPosition(180, 82, 0)
	self.mainui.levelbg.levelupbuttons.plushunger = self.mainui.levelbg.levelupbuttons:AddChild(ImageButton("images/button/levelplus.xml", "levelplus.tex"))
	self.mainui.levelbg.levelupbuttons.plushunger:SetPosition(0, 0, 0)
	self.mainui.levelbg.levelupbuttons.plushunger.label = self.mainui.levelbg.levelupbuttons.plushunger:AddChild(Text(BODYTEXTFONT, 35))
	self.mainui.levelbg.levelupbuttons.plushunger.label:SetHAlign(ANCHOR_MIDDLE)
	self.mainui.levelbg.levelupbuttons.plushunger.label:SetPosition(0, 2, 0)
	self.mainui.levelbg.levelupbuttons.plushunger.label:SetString("+1")
	self.mainui.levelbg.levelupbuttons.plushunger:SetOnClick(function()
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["hungeruplevel"])
	end)
	
	self.mainui.levelbg.levelupbuttons.plussanity = self.mainui.levelbg.levelupbuttons:AddChild(ImageButton("images/button/levelplus.xml", "levelplus.tex"))
	self.mainui.levelbg.levelupbuttons.plussanity:SetPosition(0, -45, 0)
	self.mainui.levelbg.levelupbuttons.plussanity.label = self.mainui.levelbg.levelupbuttons.plussanity:AddChild(Text(BODYTEXTFONT, 35))
	self.mainui.levelbg.levelupbuttons.plussanity.label:SetHAlign(ANCHOR_MIDDLE)
	self.mainui.levelbg.levelupbuttons.plussanity.label:SetPosition(0, 2, 0)
	self.mainui.levelbg.levelupbuttons.plussanity.label:SetString("+1")
	self.mainui.levelbg.levelupbuttons.plussanity:SetOnClick(function()
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["sanityuplevel"])
	end)
	
	self.mainui.levelbg.levelupbuttons.plushealth = self.mainui.levelbg.levelupbuttons:AddChild(ImageButton("images/button/levelplus.xml", "levelplus.tex"))
	self.mainui.levelbg.levelupbuttons.plushealth:SetPosition(0, -90, 0)
	self.mainui.levelbg.levelupbuttons.plushealth.label = self.mainui.levelbg.levelupbuttons.plushealth:AddChild(Text(BODYTEXTFONT, 35))
	self.mainui.levelbg.levelupbuttons.plushealth.label:SetHAlign(ANCHOR_MIDDLE)
	self.mainui.levelbg.levelupbuttons.plushealth.label:SetPosition(0, 2, 0)
	self.mainui.levelbg.levelupbuttons.plushealth.label:SetString("+1")
	self.mainui.levelbg.levelupbuttons.plushealth:SetOnClick(function()
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["healthuplevel"])
	end)
	
	self.mainui.levelbg.levelupbuttons.plusdamage = self.mainui.levelbg.levelupbuttons:AddChild(ImageButton("images/button/levelplus.xml", "levelplus.tex"))
	self.mainui.levelbg.levelupbuttons.plusdamage:SetPosition(0, -135, 0)
	self.mainui.levelbg.levelupbuttons.plusdamage.label = self.mainui.levelbg.levelupbuttons.plusdamage:AddChild(Text(BODYTEXTFONT, 35))
	self.mainui.levelbg.levelupbuttons.plusdamage.label:SetHAlign(ANCHOR_MIDDLE)
	self.mainui.levelbg.levelupbuttons.plusdamage.label:SetPosition(0, 2, 0)
	self.mainui.levelbg.levelupbuttons.plusdamage.label:SetString("+1%")
	self.mainui.levelbg.levelupbuttons.plusdamage:SetOnClick(function()
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["damageuplevel"])
	end)
	
	self.mainui.levelbg.levelupbuttons.plusdefence = self.mainui.levelbg.levelupbuttons:AddChild(ImageButton("images/button/levelplus.xml", "levelplus.tex"))
	self.mainui.levelbg.levelupbuttons.plusdefence:SetPosition(0, -180, 0)
	self.mainui.levelbg.levelupbuttons.plusdefence.label = self.mainui.levelbg.levelupbuttons.plusdefence:AddChild(Text(BODYTEXTFONT, 35))
	self.mainui.levelbg.levelupbuttons.plusdefence.label:SetHAlign(ANCHOR_MIDDLE)
	self.mainui.levelbg.levelupbuttons.plusdefence.label:SetPosition(0, 2, 0)
	self.mainui.levelbg.levelupbuttons.plusdefence.label:SetString("+1%")
	self.mainui.levelbg.levelupbuttons.plusdefence:SetOnClick(function()
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["absorbuplevel"])
	end)
	
	self.mainui.levelbg.levelupbuttons.plusspeed = self.mainui.levelbg.levelupbuttons:AddChild(ImageButton("images/button/levelplus.xml", "levelplus.tex"))
	self.mainui.levelbg.levelupbuttons.plusspeed:SetPosition(0, -225, 0)
	self.mainui.levelbg.levelupbuttons.plusspeed.label = self.mainui.levelbg.levelupbuttons.plusspeed:AddChild(Text(BODYTEXTFONT, 35))
	self.mainui.levelbg.levelupbuttons.plusspeed.label:SetHAlign(ANCHOR_MIDDLE)
	self.mainui.levelbg.levelupbuttons.plusspeed.label:SetPosition(0, 2, 0)
	self.mainui.levelbg.levelupbuttons.plusspeed.label:SetString("+1%")
	self.mainui.levelbg.levelupbuttons.plusspeed:SetOnClick(function()
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["speeduplevel"])
	end)
	
	self.mainui.levelbg.levelupbuttons.plusheat = self.mainui.levelbg.levelupbuttons:AddChild(ImageButton("images/button/levelplus.xml", "levelplus.tex"))
	self.mainui.levelbg.levelupbuttons.plusheat:SetPosition(0, -270, 0)
	self.mainui.levelbg.levelupbuttons.plusheat.label = self.mainui.levelbg.levelupbuttons.plusheat:AddChild(Text(BODYTEXTFONT, 35))
	self.mainui.levelbg.levelupbuttons.plusheat.label:SetHAlign(ANCHOR_MIDDLE)
	self.mainui.levelbg.levelupbuttons.plusheat.label:SetPosition(0, 2, 0)
	self.mainui.levelbg.levelupbuttons.plusheat.label:SetString("+5")
	self.mainui.levelbg.levelupbuttons.plusheat:SetOnClick(function()
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["insulationsummeruplevel"])
	end)
	
	self.mainui.levelbg.levelupbuttons.pluscold	= self.mainui.levelbg.levelupbuttons:AddChild(ImageButton("images/button/levelplus.xml", "levelplus.tex"))
	self.mainui.levelbg.levelupbuttons.pluscold:SetPosition(0, -315, 0)
	self.mainui.levelbg.levelupbuttons.pluscold.label = self.mainui.levelbg.levelupbuttons.pluscold:AddChild(Text(BODYTEXTFONT, 35))
	self.mainui.levelbg.levelupbuttons.pluscold.label:SetHAlign(ANCHOR_MIDDLE)
	self.mainui.levelbg.levelupbuttons.pluscold.label:SetPosition(0, 2, 0)
	self.mainui.levelbg.levelupbuttons.pluscold.label:SetString("+5")
	self.mainui.levelbg.levelupbuttons.pluscold:SetOnClick(function()
		SendModRPCToServer(MOD_RPC["DSTAchievement"]["insulationuplevel"])
	end)
	
	
	self.inst:DoTaskInTime(.2, function()
		self.numpage = 1
		self.perkpage = 1
		self:loadlist()
		self:loadcoinlist()
		self.maxnumpage = 11
		--self.achivlistbg = {}
		self.achivlisttile = {}
		self.coinlistbutton = {}
		self:build()
		self:perk_build()
		self:StartUpdating()
	
		--self.inst:DoPeriodicTask(.5, function() self:updatestats(inst) end)
		--for key,value in pairs(self.owner.components) do print(key,value) end
		--print(self.inst.components.hunger)
	end)
	
	self.inst:DoTaskInTime(3, function()
		self.language = self.owner.currentlanguage:value()
		if self.language ~= _G.LANGUAGE then
			self:changeLanguage(self.language)
		end
	end)
end)

function uiachievement:changeLanguage(language)
	package.loaded["AllAchiv/strings_acm_kr"] = nil
	package.loaded["AllAchiv/strings_acm_ptbr"] = nil
	package.loaded["AllAchiv/strings_acm_es"] = nil
	package.loaded["AllAchiv/strings_acm_it"] = nil
	package.loaded["AllAchiv/strings_acm_chs"] = nil
	package.loaded["AllAchiv/strings_acm_cht"] = nil
	package.loaded["AllAchiv/strings_acm_ru"] = nil
	package.loaded["AllAchiv/strings_acm_de"] = nil
	package.loaded["AllAchiv/strings_acm_vi"] = nil
	package.loaded["AllAchiv/strings_acm_e"] = nil

	if language == "kr" then
		require 'AllAchiv/strings_acm_kr'
	elseif language == "ptbr" then
		require 'AllAchiv/strings_acm_ptbr'
	elseif language == "es" then
		require 'AllAchiv/strings_acm_es'
	elseif language == "it" then
		require 'AllAchiv/strings_acm_it'
	elseif language == "chs" then
		require 'AllAchiv/strings_acm_chs'
	elseif language == "cht" then
		require 'AllAchiv/strings_acm_cht'
	elseif language == "ru" then
		require 'AllAchiv/strings_acm_ru'
	elseif language == "de" then
		require 'AllAchiv/strings_acm_de'
	elseif language == "vi" then
		require 'AllAchiv/strings_acm_vi'
	elseif language == "e" then
		require 'AllAchiv/strings_acm_e'
	end
	self:updateAllStrings()
end

function uiachievement:setAllAchivCategoriesActive()
	self.mainui.infobutton.cat1:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat2:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat3:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat4:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat5:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat6:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat7:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat8:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat9:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat10:SetTextures("images/button/button_bg.xml", "button_bg.tex")
	self.mainui.infobutton.cat11:SetTextures("images/button/button_bg.xml", "button_bg.tex")
end

function uiachievement:updatepage(i)
	local active = ""
    if self.achivlist[i].check == 1 then active = "_active" end

	self.achivlisttile[i]:SetTexture("images/button/achievement"..active..".xml", "achievement"..active..".tex")
	
    if allachiv_eventdata[self.achivlist[i].name] ~= nil and self.achivlist[i].name ~= "king" and self.achivlist[i].name ~= "all" then
    	self.achivlisttile[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[9]..self.achivlist[i].current.."/"..allachiv_eventdata[self.achivlist[i].name])
    else
    	self.achivlisttile[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[9]..self.achivlist[i].check.."/1")
    end
    if self.achivlist[i].name == "king" then
    	self.achivlisttile[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[9]..STRINGS.ALLACHIVCURRENCY[11]..self.achivlist[i].current1.."  "..STRINGS.ALLACHIVCURRENCY[12]..self.achivlist[i].current2.."  "..STRINGS.ALLACHIVCURRENCY[13]..self.achivlist[i].current3.."  "..STRINGS.ALLACHIVCURRENCY[14]..self.achivlist[i].current4)
    end
    if self.achivlist[i].name == "all" then
    	self.achivlisttile[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[9]..self.achivlist[i].current.."/"..(#self.achivlist-1))
    end
	if self.achivlist[i].name == "alldiet" then
		self.mainui.achievement_bg.info.header:SetString(STRINGS.GUI["foodlist"])
    	self.mainui.achievement_bg.info.label:SetMultilineTruncatedString(self.achivlist[i].foodlist, 40, 250, 38, "...", true)
    end
	
end

-- Achievements Categories number of entries
local cat_food = 11
local cat_life = 11
local cat_work = 12
local cat_have = 12
local cat_like = 12
local cat_pain = 11
local cat_fight = 12
local cat_hunt = 11
local cat_boss = 11
local cat_misc = 10
local cat_mile = 10

function uiachievement:OnUpdate(dt)
	local zoomlevel = self.owner.currentzoomlevel:value()
	if zoomlevel ~= self.size then
		self.size = zoomlevel
		self.mainui:SetScale(zoomlevel, zoomlevel, 1)
	end
	local savedxpos = self.owner.currentwidgetxpos:value()
	local pos = self.mainbutton:GetPosition()
	if savedxpos ~= -1 and pos.x ~= savedxpos then
		self.mainbutton:SetPosition(savedxpos, pos.y, pos.z)
	end
	
	
	if not self.mainui.allcoin.shown then
		self.mainui.removeinfo:Hide()
	end
	if not self.mainui.levelbg.shown then
		self.mainui.removeinfoXP:Hide()
	end
	
	self.mainui.achievement_bg.coinamount:SetString(self.owner.currentcoinamount:value())
	self.mainbutton.level:SetString(self.owner.currentlevel:value())
	self.availableattributepoints = self.owner.currentattributepoints:value()
	if(self.availableattributepoints > 0) then
		self.mainbutton.level:SetColour(1,1,0,1)
		self.mainui.levelbg.level:SetColour(1,1,0,1)
		self.mainui.levelbg.levelupbuttons:Show()
		self.mainui.levelbg.freepoints:Show()
		self.mainui.levelbg.freepoints:SetString(STRINGS.GUI["availablePoints"]..self.availableattributepoints)
		self.mainui.levelbg.costheader:Show()
		self.mainui.levelbg.costs:Show()
		local coststring = 
		self.owner.currenthungercost:value().."\n"
		..self.owner.currentsanitycost:value().."\n"
		..self.owner.currenthealthcost:value().."\n"
		..self.owner.currentdamagecost:value().."\n"
		..self.owner.currentabsorbcost:value().."\n"
		..self.owner.currentspeedcost:value().."\n"
		..self.owner.currentinsulationsummercost:value().."\n"
		..self.owner.currentinsulationcost:value()
		self.mainui.levelbg.costs:SetString(coststring)
	else
		self.mainui.levelbg.freepoints:Hide()
		self.mainui.levelbg.costheader:Hide()
		self.mainui.levelbg.costs:Hide()
		self.mainui.levelbg.levelupbuttons:Hide()
		self.mainbutton.level:SetColour(1,1,1,1)
		self.mainui.levelbg.level:SetColour(1,1,1,1)
	end

	self.mainui.levelbg.levelxp:SetString(self.owner.currentlevelxp:value().."/"..(math.min(levelxpcap,self.owner.currentlevel:value()*100)))
	self.mainui.levelbg.overallxp:SetString(STRINGS.GUI["overallxp"]..self.owner.currentoverallxp:value())
	self.mainui.levelbg.level:SetString(self.owner.currentlevel:value())
	
	local percent = self.owner.currentlevelxp:value() / math.min(levelxpcap,self.owner.currentlevel:value()*100)
	self.mainbutton.xpbar_filled:SetScale(5.1*percent,0.15,1)
	self.mainui.levelbg.xpbar_filled:SetScale(44.5*percent,0.78,1)
	
	local hunger = math.floor(self.owner.currenthungermax:value()+0.5)
	local sanity = math.floor(self.owner.currentsanitymax:value()+0.5)
	local health = math.floor(self.owner.currenthealthmax:value()+0.5)
	local damage = math.floor(self.owner.currentdamagemax:value()+0.5)
	local defence = math.floor(self.owner.currentabsorbmax:value()+0.5)
	local speed = math.floor(self.owner.currentspeedmax:value()+0.5)
	local heat = math.floor(self.owner.currentinsulationsummermax:value()+0.5)
	local cold = math.floor(self.owner.currentinsulationmax:value()+0.5)
	self.mainui.levelbg.attributelevels:SetString(hunger.."\n"..sanity.."\n"..health.."\n"..damage.."\n"..defence.."\n"..speed.."\n"..heat.."\n"..cold)

	self:loadlist()
	local x = 1
	local y = cat_food
	
	if self.numpage ~= 1 or not self.mainui.allachiv.shown then
		self.mainui.achievement_bg.info:Hide()
		self.mainui.achievement_bg.info:SetPosition(331, -150, 0)
		self.infoopen = false
	end

	-- Food
	if self.numpage == 1 then
		for i = x,y do
			self:updatepage(i)
		end
	end
	x = y + 1
	y = y + cat_life

	-- Life
	if self.numpage == 2 then
		for i = x,y do
			self:updatepage(i)
		end
	end
	x = y + 1
	y = y + cat_work

	-- Work
	if self.numpage == 3 then
		for i = x,y do
			self:updatepage(i)
		end
	end
	x = y + 1
	y = y + cat_have

	-- Have
	if self.numpage == 4 then
		for i = x,y do
			self:updatepage(i)
		end
	end
	x = y + 1
	y = y + cat_like
	
	-- Like
	if self.numpage == 5 then
		for i = x,y do
			self:updatepage(i)
		end
	end
	x = y + 1
	y = y + cat_pain

	-- Pain
	if self.numpage == 6 then
		for i = x,y do
			self:updatepage(i)
		end
	end
	x = y + 1
	y = y + cat_fight

	-- Fight
	if self.numpage == 7 then
		for i = x,y do
			self:updatepage(i)
		end
	end
	x = y + 1
	y = y + cat_hunt
	
	-- Hunt
	if self.numpage == 8 then
		for i = x,y do
			self:updatepage(i)
		end
	end
	x = y + 1
	y = y + cat_boss

	-- Slay
	if self.numpage == 9 then
		for i = x,y do
			self:updatepage(i)
		end
	end
	x = y + 1
	y = y + cat_misc

	-- Misc
	if self.numpage == 10 then
		for i = x,y do
			self:updatepage(i)
		end
	end
	x = y + 1
	y = y + cat_mile

	-- Mile
	if self.numpage == 11 then
		for i = x,y do
			self:updatepage(i)
		end
	end
end

function uiachievement:buildpage(j,i)
	local x = 240
	local y = 80- (105 * (math.ceil(j/2) + 1))

	if math.ceil(j/2) ~= j/2 then x = -240 else x = 240 end

	local active = ""
    if self.achivlist[i].check == 1 then active = "_active" end

    self.achivlisttile[i] = self.mainui.allachiv:AddChild(Image("images/button/achievement"..active..".xml", "achievement"..active..".tex"))
	self.achivlisttile[i]:SetPosition(x-8, y, 0)
    self.achivlisttile[i]:SetTint(1,1,1,1)

    if allachiv_eventdata[self.achivlist[i].name] ~= nil and self.achivlist[i].name ~= "king" and self.achivlist[i].name ~= "all" then
    	self.achivlisttile[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[9]..self.achivlist[i].current.."/"..allachiv_eventdata[self.achivlist[i].name])
    else
    	self.achivlisttile[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[9]..self.achivlist[i].check.."/1")
    end
    if self.achivlist[i].name == "king" then
    	self.achivlisttile[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[9]..STRINGS.ALLACHIVCURRENCY[11]..self.achivlist[i].current1.."  "..STRINGS.ALLACHIVCURRENCY[12]..self.achivlist[i].current2.."  "..STRINGS.ALLACHIVCURRENCY[13]..self.achivlist[i].current3.."  "..STRINGS.ALLACHIVCURRENCY[14]..self.achivlist[i].current4)
    end
    if self.achivlist[i].name == "all" then
    	self.achivlisttile[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[9]..self.achivlist[i].current.."/"..(#self.achivlist-1))
    end
	self.infoopen = false
	if self.achivlist[i].name == "alldiet" then
		self.achivlisttile[i].OnMouseButton = function(inst, button, down, x, y)
		if button == 1000 and down then
			if self.infoopen then
				--pull in
				for i=1,100 do 
					self.owner:DoTaskInTime(i/200, function()
						self.mainui.achievement_bg.info:SetPosition(651-3.2*i, -150, 0)
					end)
				end
				self.owner:DoTaskInTime(0.5, function()
					self.mainui.achievement_bg.info:Hide()
				end)
				self.infoopen = false
			else
				--pull out
				--max pos(651, -150, 0)
				self.mainui.achievement_bg.info:SetPosition(331, -150, 0)
				self.mainui.achievement_bg.info:Show()
				self.mainui.achievement_bg.info.header:SetString("Foodlist")
				self.mainui.achievement_bg.info.label:SetMultilineTruncatedString(self.achivlist[i].foodlist, 40, 250, 38, "...", true)
				--self.mainui.achievement_bg.info.label:SetString(self.achivlist[i].foodlist)
				--print(self.achivlist[i].foodlist)
				for i=1,100 do 
					self.owner:DoTaskInTime(i/200, function()
						self.mainui.achievement_bg.info:SetPosition(331+3.2*i, -150, 0)
					end)
				end
				self.infoopen = true
			end
		end	
	end
	end
	
	self.achivlisttile[i].name = self.achivlisttile[i]:AddChild(Text(BODYTEXTFONT, 45))
	self.achivlisttile[i].name:SetPosition(7, 18, 0)
	self.achivlisttile[i].name:SetHAlign(ANCHOR_LEFT)
	--self.achivlisttile[i].name:SetRegionSize(300,60)
	--self.achivlisttile[i].name:SetString(STRINGS.ALLACHIVNAME[self.achivlist[i].name])
	
	if self.achivlist[i].name == "all" then
    	self.achivlisttile[i].name:SetTruncatedString(STRINGS.ALLACHIVNAME[self.achivlist[i].name].." "..self.achivlist[i].runcount+1, 250, 500, "")
    else
		self.achivlisttile[i].name:SetTruncatedString(STRINGS.ALLACHIVNAME[self.achivlist[i].name], 250, 500, "")
	end
	local line = self.achivlisttile[i].name:GetString()
	while #line < #STRINGS.ALLACHIVNAME[self.achivlist[i].name] do
		self.achivlisttile[i].name:SetSize( self.achivlisttile[i].name:GetSize() - 1 )
		self.achivlisttile[i].name:SetTruncatedString(STRINGS.ALLACHIVNAME[self.achivlist[i].name], 250, 500, "")
		line = self.achivlisttile[i].name:GetString()
	end	
	self.achivlisttile[i].name:SetRegionSize(300,60)
	
	self.achivlisttile[i].desc = self.achivlisttile[i]:AddChild(Text(NEWFONT, 25))
	self.achivlisttile[i].desc:SetPosition(7, -19, 0)
	self.achivlisttile[i].desc:SetHAlign(ANCHOR_LEFT)
	--self.achivlisttile[i].desc:SetRegionSize(300,60)
	--self.achivlisttile[i].desc:SetString(STRINGS.ALLACHIVDESC[self.achivlist[i].name])
	self.achivlisttile[i].desc:SetColour(0,0,0,1)
	self.achivlisttile[i].desc:SetTruncatedString(STRINGS.ALLACHIVDESC[self.achivlist[i].name], 250, 500, "")
	line = self.achivlisttile[i].desc:GetString()
	while #line < #STRINGS.ALLACHIVDESC[self.achivlist[i].name] do
		self.achivlisttile[i].desc:SetSize( self.achivlisttile[i].desc:GetSize() - 1 )
		self.achivlisttile[i].desc:SetTruncatedString(STRINGS.ALLACHIVDESC[self.achivlist[i].name], 250, 500, "")
		line = self.achivlisttile[i].desc:GetString()
	end	
	self.achivlisttile[i].desc:SetRegionSize(300,60)
	
	self.achivlisttile[i].cost = self.achivlisttile[i]:AddChild(Text(NUMBERFONT, 45))
	self.achivlisttile[i].cost:SetPosition(142, 0, 0)
	self.achivlisttile[i].cost:SetHAlign(ANCHOR_RIGHT)
	self.achivlisttile[i].cost:SetRegionSize(60,60)
	self.achivlisttile[i].cost:SetString("+"..allachiv_coinget[self.achivlist[i].name])
	--self.achivlisttile[i].cost:SetColour(0,0,0,1)
	
end

function uiachievement:build()
	self.mainui.allachiv:KillAllChildren()
	local x = 1
	local y = cat_food

	-- Food
	if self.numpage == 1 then
		for i = x,y do
			self:buildpage(i-(x-1) ,i)
		end
	end
	x = y + 1
	y = y + cat_life

	-- Life
	if self.numpage == 2 then
		for i = x,y do
			self:buildpage(i-(x-1) ,i)
		end
	end
	x = y + 1
	y = y + cat_work

	-- Work
	if self.numpage == 3 then
		for i = x,y do
			self:buildpage(i-(x-1) ,i)
		end
	end
	x = y + 1
	y = y + cat_have

	-- Have
	if self.numpage == 4 then
		for i = x,y do
			self:buildpage(i-(x-1) ,i)
		end
	end
	x = y + 1
	y = y + cat_like

	-- Like
	if self.numpage == 5 then
		for i = x,y do
			self:buildpage(i-(x-1) ,i)
		end
	end
	x = y + 1
	y = y + cat_pain
	
	-- Pain
	if self.numpage == 6 then
		for i = x,y do
			self:buildpage(i-(x-1) ,i)
		end
	end
	x = y + 1
	y = y + cat_fight
	
	-- Fight
	if self.numpage == 7 then
		for i = x,y do
			self:buildpage(i-(x-1) ,i)
		end
	end
	x = y + 1
	y = y + cat_hunt

	-- Hunt
	if self.numpage == 8 then
		for i = x,y do
			self:buildpage(i-(x-1) ,i)
		end
	end
	x = y + 1
	y = y + cat_boss

	-- Boss
	if self.numpage == 9 then
		for i = x,y do
			self:buildpage(i-(x-1) ,i)
		end
	end
	x = y + 1
	y = y + cat_misc

	-- Misc
	if self.numpage == 10 then
		for i = x,y do
			self:buildpage(i-(x-1) ,i)
		end
	end
	x = y + 1
	y = y + cat_mile

	-- Mile
	if self.numpage == 11 then
		for i = x,y do
			self:buildpage(i-(x-1) ,i)
		end
	end
end

-- Achievements Categories
local perk_attributes = 13
local perk_abilities = 18
local perk_crafting = 8

function uiachievement:perk_build()
	local x = 1
	local y = perk_attributes
	self.mainui.allcoin:KillAllChildren()
	
	-- perk_attributes
	if self.perkpage == 1 then
		for i = x,y do
			self:build_perkpage(i-(x-1) ,i, true)
		end
	end
	x = y + 1
	y = y + perk_abilities

	-- perk_abilities
	if self.perkpage == 2 then
		for i = x,y do
			self:build_perkpage(i-(x-1) ,i, false)
		end
	end
	x = y + 1
	y = y + perk_crafting

	-- perk_crafting
	if self.perkpage == 3 then
		for i = x,y do
			self:build_perkpage(i-(x-1) ,i, false)
		end
	end
end

function uiachievement:build_perkpage(j,i, adaptivecost)
	local x = -325 + ((j-1)%3)*320 
	local y = 80 - (105 * (math.ceil(j/3) + 1))

	--if math.ceil(j/3) ~= j/3 then x = -240 else x = x + 240*j/3 end

	local currentlyObtained = self.coinlist[i].current
	local active = ""
	if currentlyObtained > 0 then
		active = "_active"
	end

	self.coinlistbutton[i] = self.mainui.allcoin:AddChild(ImageButton("images/button/perk"..active..".xml", "perk"..active..".tex"))
	self.coinlistbutton[i]:SetPosition(x, y, 0)
	self.coinlistbutton[i]:SetImageNormalColour(1,1,1,0.95)
	self.coinlistbutton[i]:SetOnClick(function()
		SendModRPCToServer(MOD_RPC["DSTAchievement"][self.coinlist[i].name])
		self.owner:DoTaskInTime(.3, function()
			self:loadcoinlist()
			self.coinlistbutton[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[10]..self.coinlist[i].current)
			self:perk_build()
		end)
	end)
	self.coinlistbutton[i]:SetNormalScale(1,1,1)
	self.coinlistbutton[i]:SetFocusScale(1.02,1.02,1)
	self.coinlistbutton[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[10]..self.coinlist[i].current)
	
	self.coinlistbutton[i].name = self.coinlistbutton[i]:AddChild(Text(BODYTEXTFONT, 45))
	self.coinlistbutton[i].name:SetPosition(11, 25, 0)
	self.coinlistbutton[i].name:SetHAlign(ANCHOR_LEFT)
	--self.coinlistbutton[i].name:SetRegionSize(300,60)
	--self.coinlistbutton[i].name:SetMultilineTruncatedString(STRINGS.PERKNAME[self.coinlist[i].name], 2, 300, 50, "", true)
	--self.coinlistbutton[i].name:SetString(STRINGS.PERKNAME[self.coinlist[i].name])
	self.coinlistbutton[i].name:SetTruncatedString(STRINGS.PERKNAME[self.coinlist[i].name], 220, 500, "")
	local line = self.coinlistbutton[i].name:GetString()
	while #line < #STRINGS.PERKNAME[self.coinlist[i].name] do
		self.coinlistbutton[i].name:SetSize( self.coinlistbutton[i].name:GetSize() - 1 )
		self.coinlistbutton[i].name:SetTruncatedString(STRINGS.PERKNAME[self.coinlist[i].name], 220, 500, "")
		line = self.coinlistbutton[i].name:GetString()
	end	
	self.coinlistbutton[i].name:SetRegionSize(300,60)
	
	self.coinlistbutton[i].desc = self.coinlistbutton[i]:AddChild(Text(NEWFONT, 26))
	self.coinlistbutton[i].desc:SetPosition(11, -19, 0)
	self.coinlistbutton[i].desc:SetHAlign(ANCHOR_LEFT)
	
	--self.coinlistbutton[i].desc:SetString(STRINGS.PERKDESC[self.coinlist[i].name])
	self.coinlistbutton[i].desc:SetMultilineTruncatedString(STRINGS.PERKDESC[self.coinlist[i].name], 2, 260, 500, "", true)
	self.coinlistbutton[i].desc:SetColour(0,0,0,1)
	self.coinlistbutton[i].desc:SetRegionSize(300,60)
	
	self.coinlistbutton[i].cost = self.coinlistbutton[i]:AddChild(Text(NUMBERFONT, 30))
	self.coinlistbutton[i].cost:SetPosition(90, 28, 0)
	self.coinlistbutton[i].cost:SetHAlign(ANCHOR_RIGHT)
	self.coinlistbutton[i].cost:SetRegionSize(50,30)
	if adaptivecost then
		self.coinlistbutton[i].cost:SetString("-"..self.coinlist[i].cost)
	else
		self.coinlistbutton[i].cost:SetString("-"..allachiv_coinuse[self.coinlist[i].name])
	end
	
	--self.coinlistbutton[i].cost:SetColour(0,0,0,1)
	
	
end

-- function uiachievement:coinbuild()
	-- self.mainui.allcoin:KillAllChildren()
	-- local x = -360
	-- local y = -130
	-- for i = 1, #self.coinlist do
		-- if math.ceil(i/4) ~= math.ceil((i-1)/4) then x = -360 else x = x + 360*2/3 end
		-- y = -130-96*(math.ceil(i/4)-1)
		
		-- local currentlyObtained = self.coinlist[i].current
		-- local active = ""
		-- if currentlyObtained > 0 then
			-- active = "_active"
		-- end
		
		-- self.coinlistbutton[i] = self.mainui.allcoin:AddChild(ImageButton("images/coin_"..TUNING.AllAchivLan.."/"..self.coinlist[i].name.."".._G.MODE..""..active..".xml", self.coinlist[i].name.."".._G.MODE..""..active..".tex"))
		-- self.coinlistbutton[i]:SetPosition(x+5, y, 0)
    	-- self.coinlistbutton[i]:SetImageNormalColour(1,1,1,0.95)
    	-- self.coinlistbutton[i]:SetOnClick(function()
    		-- SendModRPCToServer(MOD_RPC["DSTAchievement"][self.coinlist[i].name])
    		-- self.owner:DoTaskInTime(.3, function()
    			-- self:loadcoinlist()
    			-- self.coinlistbutton[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[10]..self.coinlist[i].current)
				-- self:perk_build()
			-- end)
		-- end)
		-- self.coinlistbutton[i]:SetNormalScale(1,1,1)
    	-- self.coinlistbutton[i]:SetFocusScale(1.02,1.02,1)
		-- self.coinlistbutton[i]:SetHoverText(STRINGS.ALLACHIVCURRENCY[10]..self.coinlist[i].current)
		-- --self.mainbutton.levelbadge:SetHoverText(STRINGS.ALLACHIVCURRENCY[7],{ size = 9, offset_x = 90, offset_y = -55, colour = {1,1,1,1}})
	-- end
-- end

function uiachievement:loadlist()
	self.achivlist = {
		--Food
		{
			name = "firsteat",
			check = self.owner.checkfirsteat:value(),
			current = nil,
		},
		{
			name = "supereat",
			check = self.owner.checksupereat:value(),
			current = self.owner.currenteatamount:value(),
		},
		{
			name = "danding",
			check = self.owner.checkdanding:value(),
			current = self.owner.currenteatmonsterlasagna:value(),
		},
		{
			name = "alldiet",
			check = self.owner.checkalldiet:value(),
			current = self.owner.currenteatall:value(),
			foodlist = self.owner.currenteatlist:value(),
		},
		{
			name = "eathot",
			check = self.owner.checkeathot:value(),
			current = self.owner.currenteathotamount:value(),
		},
		{
			name = "eatcold",
			check = self.owner.checkeatcold:value(),
			current = self.owner.currenteatcoldamount:value(),
		},
		{
			name = "eatfish",
			check = self.owner.checkeatfish:value(),
			current = self.owner.currenteatfish:value(),
		},
		{
			name = "eatturkey",
			check = self.owner.checkeatturkey:value(),
			current = self.owner.currenteatturkey:value(),
		},
		{
			name = "eatpepper",
			check = self.owner.checkeatpepper:value(),
			current = self.owner.currenteatpepper:value(),
		},
		{
			name = "eatbacon",
			check = self.owner.checkeatbacon:value(),
			current = self.owner.currenteatbacon:value(),
		},
		{
			name = "eatmole",
			check = self.owner.checkeatmole:value(),
			current = self.owner.currenteatmole:value(),
		},
		--Life
		{
			name = "noob",
			check = self.owner.checknoob:value(),
			current = nil,
		},
		{
			name = "tooyoung",
			check = self.owner.checktooyoung:value(),
			current = nil,
		},
		{
			name = "rose",
			check = self.owner.checkrose:value(),
			current = nil,
		},
		{
			name = "rot",
			check = self.owner.checkrot:value(),
			current = nil,
		},
		{
			name = "deathalot",
			check = self.owner.checkdeathalot:value(),
			current = self.owner.currentdeathamouth:value(),
		},
		{
			name = "secondchance",
			check = self.owner.checksecondchance:value(),
			current = nil,
		},
		{
			name = "messiah",
			check = self.owner.checkmessiah:value(),
			current = self.owner.currentrespawnamount:value(),
		},
		{
			name = "sleeptent",
			check = self.owner.checksleeptent:value(),
			current = self.owner.currentsleeptent:value(),
		},
		{
			name = "sleepsiesta",
			check = self.owner.checksleepsiesta:value(),
			current = self.owner.currentsleepsiesta:value(),
		},
		{
			name = "reviveamulet",
			check = self.owner.checkreviveamulet:value(),
			current = self.owner.currentreviveamulet:value(),
		},
		{
			name = "feedplayer",
			check = self.owner.checkfeedplayer:value(),
			current = self.owner.currentfeedplayer:value(),
		},
		--Work
		{
			name = "nature",
			check = self.owner.checknature:value(),
			current = self.owner.currentnatureamount:value(),
		},
		{
			name = "fishmaster",
			check = self.owner.checkfishmaster:value(),
			current = self.owner.currentfishamount:value(),
		},
		{
			name = "pickappren",
			check = self.owner.checkpickappren:value(),
			current = self.owner.currentpickamount:value(),
		},
		{
			name = "pickmaster",
			check = self.owner.checkpickmaster:value(),
			current = self.owner.currentpickamount:value(),
		},
		{
			name = "chopappren",
			check = self.owner.checkchopappren:value(),
			current = self.owner.currentchopamount:value(),
		},
		{
			name = "chopmaster",
			check = self.owner.checkchopmaster:value(),
			current = self.owner.currentchopamount:value(),
		},
		{
			name = "mineappren",
			check = self.owner.checkmineappren:value(),
			current = self.owner.currentmineamount:value(),
		},
		{
			name = "minemaster",
			check = self.owner.checkminemaster:value(),
			current = self.owner.currentmineamount:value(),
		},
		{
			name = "cookappren",
			check = self.owner.checkcookappren:value(),
			current = self.owner.currentcookamount:value(),
		},
		{
			name = "cookmaster",
			check = self.owner.checkcookmaster:value(),
			current = self.owner.currentcookamount:value(),
		},
		{
			name = "buildappren",
			check = self.owner.checkbuildappren:value(),
			current = self.owner.currentbuildamount:value(),
		},
		{
			name = "buildmaster",
			check = self.owner.checkbuildmaster:value(),
			current = self.owner.currentbuildamount:value(),
		},
		--Have
		{
			name = "emerald",
			check = self.owner.checkemerald:value(),
			current = self.owner.currentemeralds:value(),
		},
		{
			name = "citrin",
			check = self.owner.checkcitrin:value(),
			current = self.owner.currentcitrins:value(),
		},
		{
			name = "amber",
			check = self.owner.checkamber:value(),
			current = self.owner.currentambers:value(),
		},
		{
			name = "saddle",
			check = self.owner.checksaddle:value(),
			current = self.owner.currentsaddles:value(),
		},
		{
			name = "banana",
			check = self.owner.checkbanana:value(),
			current = self.owner.currentbananas:value(),
		},
		{
			name = "spore",
			check = self.owner.checkspore:value(),
			current = self.owner.currentspores:value(),
		},
		{
			name = "blueprint",
			check = self.owner.checkblueprint:value(),
			current = self.owner.currentblueprints:value(),
		},
		{
			name = "boat",
			check = self.owner.checkboat:value(),
			current = self.owner.currentboats:value(),
		},
		{
			name = "moonrock",
			check = self.owner.checkmoonrock:value(),
			current = self.owner.currentmoonrocks:value(),
		},
		{
			name = "gnome",
			check = self.owner.checkgnome:value(),
			current = self.owner.currentgnomes:value(),
		},
		{
			name = "mosquito",
			check = self.owner.checkmosquito:value(),
			current = self.owner.currentmosquitos:value(),
		},
		{
			name = "bathbomb",
			check = self.owner.checkbathbomb:value(),
			current = self.owner.currentbathbomb:value(),
		},
		--Like
		{
			name = "goodman",
			check = self.owner.checkgoodman:value(),
			current = self.owner.currentfriendpig:value(),
		},
		{
			name = "brother",
			check = self.owner.checkbrother:value(),
			current = self.owner.currentfriendbunny:value(),
		},
		{
			name = "catperson",
			check = self.owner.checkcatperson:value(),
			current = self.owner.currentfriendcat:value(),
		},
		{
			name = "rocklob",
			check = self.owner.checkrocklob:value(),
			current = self.owner.currentfriendrocky:value(),
		},
		{
			name = "spooder",
			check = self.owner.checkspooder:value(),
			current = self.owner.currentfriendspider:value(),
		},
		{
			name = "evil",
			check = self.owner.checkevil:value(),
			current = self.owner.currentevilamount:value(),
		},
		{
			name = "birdclop",
			check = self.owner.checkbirdclop:value(),
			current = nil,
		},
		{
			name = "pet",
			check = self.owner.checkpet:value(),
			current = nil,
		},
		{
			name = "shadowchester",
			check = self.owner.checkshadowchester:value(),
			current = nil,
		},
		{
			name = "snowchester",
			check = self.owner.checksnowchester:value(),
			current = nil,
		},
		{
			name = "musichutch",
			check = self.owner.checkmusichutch:value(),
			current = nil,
		},
		{
			name = "lavae",
			check = self.owner.checklavae:value(),
			current = nil,
		},
		--Pain
		{
			name = "burn",
			check = self.owner.checkburn:value(),
			current = nil,
		},
		{
			name = "freeze",
			check = self.owner.checkfreeze:value(),
			current = nil,
		},
		{
			name = "sleep",
			check = self.owner.checksleep:value(),
			current = nil,
		},
		{
			name = "starve",
			check = self.owner.checkstarve:value(),
			current = self.owner.currentstarvetime:value(),
		},
		{
			name = "nosanity",
			check = self.owner.checknosanity:value(),
			current = self.owner.currentnosanitytime:value(),
		},
		{
			name = "icebody",
			check = self.owner.checkicebody:value(),
			current = self.owner.currenticetime:value(),
		},
		{
			name = "firebody",
			check = self.owner.checkfirebody:value(),
			current = self.owner.currentfiretime:value(),
		},
		{
			name = "moistbody",
			check = self.owner.checkmoistbody:value(),
			current = self.owner.currentmoisttime:value(),
		},
		{
			name = "evilflower",
			check = self.owner.checkevilflower:value(),
			current = self.owner.currentevilflower:value(),
		},
		{
			name = "roses",
			check = self.owner.checkroses:value(),
			current = self.owner.currentroses:value(),
		},
		{
			name = "drown",
			check = self.owner.checkdrown:value(),
			current = nil,
		},
		--Fight
		{
			name = "angry",
			check = self.owner.checkangry:value(),
			current = self.owner.currentonhitdamage:value(),
		},
		{
			name = "tank",
			check = self.owner.checktank:value(),
			current = self.owner.currentattackeddamage:value(),
		},
		{
			name = "dmgnodmg",
			check = self.owner.checkdmgnodmg:value(),
			current = self.owner.currentdmgnodmg:value(),
		},
		{
			name = "bullkelp",
			check = self.owner.checkbullkelp:value(),
			current = self.owner.currentbullkelp:value(),
		},
		{
			name = "butcher",
			check = self.owner.checkbutcher:value(),
			current = self.owner.currentbutcheramount:value(),
		},
		{
			name = "horrorhound",
			check = self.owner.checkhorrorhound:value(),
			current = self.owner.currenthorrorhound:value(),
		},
		{
			name = "slurtle",
			check = self.owner.checkslurtle:value(),
			current = self.owner.currentslurtle:value(),
		},
		{
			name = "werepig",
			check = self.owner.checkwerepig:value(),
			current = self.owner.currentwerepig:value(),
		},
		{
			name = "fruitdragon",
			check = self.owner.checkfruitdragon:value(),
			current = self.owner.currentfruitdragon:value(),
		},
		{
			name = "sick",
			check = self.owner.checksick:value(),
			current = nil,
		},
		{
			name = "coldblood",
			check = self.owner.checkcoldblood:value(),
			current = nil,
		},
		{
			name = "hutch",
			check = self.owner.checkhutch:value(),
			current = nil,
		},
		--Hunt
		{
			name = "goatperd",
			check = self.owner.checkgoatperd:value(),
			current = self.owner.currentgoatperdamount:value(),
		},
		{
			name = "mossling",
			check = self.owner.checkmossling:value(),
			current = self.owner.currentmosslingamount:value(),
		},
		{
			name = "weetusk",
			check = self.owner.checkweetusk:value(),
			current = self.owner.currentweetuskamount:value(),
		},
		{
			name = "snake",
			check = self.owner.checksnake:value(),
			current = self.owner.currentsnakeamount:value(),
		},
		{
			name = "black",
			check = self.owner.checkblack:value(),
			current = nil,
		},
		{
			name = "hentai",
			check = self.owner.checkhentai:value(),
			current = self.owner.currenthentaiamount:value(),
		},
		{
			name = "treeguard",
			check = self.owner.checktreeguard:value(),
			current = self.owner.currenttreeguard:value(),
		},
		{
			name = "spiderqueen",
			check = self.owner.checkspiderqueen:value(),
			current = self.owner.currentspiderqueen:value(),
		},
		{
			name = "varg",
			check = self.owner.checkvarg:value(),
			current = self.owner.currentvarg:value(),
		},
		{
			name = "koaelefant",
			check = self.owner.checkkoaelefant:value(),
			current = self.owner.currentkoaelefant:value(),
		},
		{
			name = "monkey",
			check = self.owner.checkmonkey:value(),
			current = self.owner.currentmonkey:value(),
		},
		--Boss
		{
			name = "santa",
			check = self.owner.checksanta:value(),
			current = nil,
		},
		{
			name = "dragonfly",
			check = self.owner.checkdragonfly:value(),
			current = nil,
		},
		{
			name = "malbatross",
			check = self.owner.checkmalbatross:value(),
			current = nil,
		},
		{
			name = "knight",
			check = self.owner.checkknight:value(),
			current = nil,
		},
		{
			name = "bishop",
			check = self.owner.checkbishop:value(),
			current = nil,
		},
		{
			name = "rook",
			check = self.owner.checkrook:value(),
			current = nil,
		},
		{
			name = "minotaur",
			check = self.owner.checkminotaur:value(),
			current = nil,
		},
		{
			name = "ancient",
			check = self.owner.checkancient:value(),
			current = nil,
		},
		{
			name = "rigid",
			check = self.owner.checkrigid:value(),
			current = nil,
		},
		{
			name = "queen",
			check = self.owner.checkqueen:value(),
			current = nil,
		},
		{
			name = "king",
			check = self.owner.checkking:value(),
			current1 = self.owner.checkbossspring:value(),
			current2 = self.owner.checkbossantlion:value(),
			current3 = self.owner.checkbossautumn:value(),
			current4 = self.owner.checkbosswinter:value(),
		},
		--Misc
		{
			name = "intogame",
			check = self.owner.checkintogame:value(),
			current = nil,
		},
		{
			name = "superstar",
			check = self.owner.checksuperstar:value(),
			current = self.owner.currentstarspent:value(),
		},
		{
			name = "trader",
			check = self.owner.checktrader:value(),
			current = self.owner.currenttradeamount:value(),
		},
		{
			name = "fuzzy",
			check = self.owner.checkfuzzy:value(),
			current = self.owner.currentfuzzyamount:value(),
		},
		{
			name = "knowledge",
			check = self.owner.checkknowledge:value(),
			current = nil,
		},
		{
			name = "dance",
			check = self.owner.checkdance:value(),
			current = self.owner.currentdanceamount:value(),
		},
		{
			name = "teleport",
			check = self.owner.checkteleport:value(),
			current = self.owner.currentteleportamount:value(),
		},
		{
			name = "luck",
			check = self.owner.checkluck:value(),
			current = nil,
		},
		{
			name = "lightning",
			check = self.owner.checklightning:value(),
			current = nil,
		},
		{
			name = "birchnut",
			check = self.owner.checkbirchnut:value(),
			current = self.owner.currentbirchnut:value(),
		},
		--Mile
		{
			name = "longage",
			check = self.owner.checklongage:value(),
			current = self.owner.currentage:value(),
		},
		{
			name = "oldage",
			check = self.owner.checkoldage:value(),
			current = self.owner.currentage:value(),
		},
		{
			name = "walkalot",
			check = self.owner.checkwalkalot:value(),
			current = self.owner.currentwalktime:value(),
		},
		{
			name = "stopalot",
			check = self.owner.checkstopalot:value(),
			current = self.owner.currentstoptime:value(),
		},
		{
			name = "caveage",
			check = self.owner.checkcaveage:value(),
			current = self.owner.currentcavetime:value(),
		},
		{
			name = "rider",
			check = self.owner.checkrider:value(),
			current = self.owner.currentrider:value(),
		},
		{
			name = "fullsanity",
			check = self.owner.checkfullsanity:value(),
			current = self.owner.currentfullsanity:value(),
		},
		{
			name = "fullhunger",
			check = self.owner.checkfullhunger:value(),
			current = self.owner.currentfullhunger:value(),
		},
		{
			name = "pacifist",
			check = self.owner.checkpacifist:value(),
			current = self.owner.currentpacifist:value(),
		},
		{
			name = "all",
			check = self.owner.checkall:value(),
			current = 0,
			runcount = self.owner.currentruncount:value(),
		},
	}

	local achivvalue = 0
	for i=1, #self.achivlist do
		if self.achivlist[i].name ~= "all" then
			achivvalue = achivvalue + self.achivlist[i].check
		else
			self.achivlist[i].current = achivvalue
		end
	end
end

function uiachievement:loadcoinlist()
	self.coinlist = {
		{
			name = "hungerup",
			current = self.owner.currenthungerup:value(),
			cost = self.owner.currenthungerachivcost:value(),
		},
		{
			name = "sanityup",
			current = self.owner.currentsanityup:value(),
			cost = self.owner.currentsanityachivcost:value(),
		},
		{
			name = "healthup",
			current = self.owner.currenthealthup:value(),
			cost = self.owner.currenthealthachivcost:value(),
		},
		{
			name = "hungerrateup",
			current = self.owner.currenthungerrateup:value(),
			cost = self.owner.currenthungerrateachivcost:value(),
		},
		{
			name = "sanityregen",
			current = self.owner.currentsanityregen:value(),
			cost = self.owner.currentsanityregenachivcost:value(),
		},
		{
			name = "healthregen",
			current = self.owner.currenthealthregen:value(),
			cost = self.owner.currenthealthregenachivcost:value(),
		},
		{
			name = "damageup",
			current = self.owner.currentdamageup:value(),
			cost = self.owner.currentdamageachivcost:value(),
		},
		{
			name = "crit",
			current = self.owner.currentcrit:value(),
			cost = self.owner.currentcritachivcost:value(),
		},
		{
			name = "lifesteal",
			current = self.owner.currentlifestealup:value(),
			cost = self.owner.currentlifestealcost:value(),
		},
		{
			name = "speedup",
			current = self.owner.currentspeedup:value(),
			cost = self.owner.currentspeedachivcost:value(),
		},
		{
			name = "absorbup",
			current = self.owner.currentabsorbup:value(),
			cost = self.owner.currentabsorbachivcost:value(),
		},
		{
			name = "fireflylightup",
			current = self.owner.currentfireflylightup:value(),
			cost = self.owner.currentfireflylightcost:value(),
		},
		{
			name = "scale",
			current = self.owner.currentscaleup:value(),
			cost = self.owner.currentscalecost:value(),
		},
		{
			name = "krampusxmas",
			current = self.owner.currentkrampusxmas:value(),
		},
		{
			name = "goodman",
			current = self.owner.currentgoodman:value(),
		},
		{
			name = "animallover",
			current = self.owner.currentanimallover:value(),
		},
		{
			name = "fishmaster",
			current = self.owner.currentfishmaster:value(),
		},
		{
			name = "chopmaster",
			current = self.owner.currentchopmaster:value(),
		},
		{
			name = "minemaster",
			current = self.owner.currentminemaster:value(),
		},
		{
			name = "fastworker",
			current = self.owner.currentfastworker:value(),
		},
		{
			name = "cookmaster",
			current = self.owner.currentcookmaster:value(),
		},
		{
			name = "pickmaster",
			current = self.owner.currentpickmaster:value(),
		},
		{
			name = "nomoist",
			current = self.owner.currentnomoist:value(),
		},
		{
			name = "icebody",
			current = self.owner.currenticebody:value(),
		},
		{
			name = "firebody",
			current = self.owner.currentfirebody:value(),
		},
		{
			name = "doubledrop",
			current = self.owner.currentdoubledrop:value(),
		},
		{
			name = "buildmaster",
			current = self.owner.currentbuildmaster:value(),
		},
		{
			name = "nanobots",
			current = self.owner.currentnanobots:value(),
		},
		{
			name = "archmage",
			current = self.owner.currentarchmage:value(),
		},
		{
			name = "refresh",
			current = self.owner.currentrefresh:value(),
		},
		{
			name = "cheatdeath",
			current = self.owner.currentcheatdeath:value(),
		},
		{
			name = "reader",
			current = self.owner.currentreader:value(),
		},
		{
			name = "supply",
			current = self.owner.currentsupply:value(),
		},
		{
			name = "masterchef",
			current = self.owner.currentmasterchef:value(),
		},
		{
			name = "engineering",
			current = self.owner.currentengineering:value(),
		},
		{
			name = "shrine",
			current = self.owner.currentshrine:value(),
		},
		{
			name = "ancientstation",
			current = self.owner.currentancientstation:value(),
		},
		{
			name = "naturalist",
			current = self.owner.currentnaturalist:value(),
		},
		{
			name = "lunarcraft",
			current = self.owner.currentlunarcraft:value(),
		},
	}
	
	-- disable game changer
	if not _G.GAMEBREAKER then
		for i=#self.coinlist,1,-1 do
		   local v = self.coinlist[i]
		   print(i, v)
		   if v.name == "nanobots" or v.name == "archmage" or v.name == "refresh" or v.name == "fireflylightup" then
			 table.remove(self.coinlist, i)
		   end
		end
		perk_attributes = perk_attributes - 1
		perk_abilities = perk_abilities - 3
	end
	
end

function uiachievement:updateAllStrings()
	self.mainbutton.checkbutton:SetHoverText(STRINGS.ALLACHIVCURRENCY[7],{ size = 9, offset_x = 90, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.coinbutton:SetHoverText(STRINGS.ALLACHIVCURRENCY[8],{ size = 9, offset_x = 15, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.configact:SetHoverText(STRINGS.ALLACHIVCURRENCY[15],{ size = 9, offset_x = 0, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.configbigger:SetHoverText(STRINGS.ALLACHIVCURRENCY[16],{ size = 9, offset_x = 0, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.configsmaller:SetHoverText(STRINGS.ALLACHIVCURRENCY[17],{ size = 9, offset_x = 0, offset_y = -55, colour = {1,1,1,1}})
	self.mainbutton.configlanguage:SetHoverText(STRINGS.ALLACHIVCURRENCY[19],{ size = 9, offset_x = 0, offset_y = -55, colour = {1,1,1,1}})
	
	self.mainui.achievement_bg.title:SetString(STRINGS.GUI["achievementTitle"])
	self.mainui.levelbg.title:SetString(STRINGS.GUI["levelTitle"])
	self.mainui.achievement_bg.close.label:SetSize(45)
	self.mainui.achievement_bg.close.label:SetMultilineTruncatedString(STRINGS.GUI["close"], 2, 100, 50, "", true)
	self.mainui.achievement_bg.reset.label:SetSize(35)
	self.mainui.achievement_bg.reset.label:SetMultilineTruncatedString(STRINGS.GUI["reset"], 2, 100, 50, "", true)
	self.mainui.removeinfo.label:SetSize(28)
	self.mainui.removeinfo.label:SetMultilineTruncatedString(STRINGS.GUI["resetAchievments"], 5, 330, 500, "", true)
	self.mainui.removeinfo.removeyes.label:SetSize(27)
	self.mainui.removeinfo.removeyes.label:SetMultilineTruncatedString(STRINGS.GUI["reset"], 2, 70, 50, "", true)
	self.mainui.removeinfo.removeno.label:SetSize(27)
	self.mainui.removeinfo.removeno.label:SetMultilineTruncatedString(STRINGS.GUI["close"], 2, 70, 50, "", true)
	self.mainui.infobutton.cat1.label:SetSize(55)
	self.mainui.infobutton.cat2.label:SetSize(55)
	self.mainui.infobutton.cat3.label:SetSize(55)
	self.mainui.infobutton.cat4.label:SetSize(55)
	self.mainui.infobutton.cat5.label:SetSize(55)
	self.mainui.infobutton.cat6.label:SetSize(55)
	self.mainui.infobutton.cat7.label:SetSize(55)
	self.mainui.infobutton.cat8.label:SetSize(55)
	self.mainui.infobutton.cat9.label:SetSize(55)
	self.mainui.infobutton.cat10.label:SetSize(55)
	self.mainui.infobutton.cat11.label:SetSize(55)
	self.mainui.infobutton.cat1.label:SetMultilineTruncatedString(STRINGS.GUI["food"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat2.label:SetMultilineTruncatedString(STRINGS.GUI["life"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat3.label:SetMultilineTruncatedString(STRINGS.GUI["work"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat4.label:SetMultilineTruncatedString(STRINGS.GUI["have"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat5.label:SetMultilineTruncatedString(STRINGS.GUI["like"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat6.label:SetMultilineTruncatedString(STRINGS.GUI["pain"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat7.label:SetMultilineTruncatedString(STRINGS.GUI["fight"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat8.label:SetMultilineTruncatedString(STRINGS.GUI["hunt"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat9.label:SetMultilineTruncatedString(STRINGS.GUI["boss"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat10.label:SetMultilineTruncatedString(STRINGS.GUI["misc"], 2, 120, 50, "", true)
	self.mainui.infobutton.cat11.label:SetMultilineTruncatedString(STRINGS.GUI["mile"], 2, 120, 50, "", true)
	self.mainui.perk_cat.perkcat1.label:SetSize(45)
	self.mainui.perk_cat.perkcat2.label:SetSize(45)
	self.mainui.perk_cat.perkcat3.label:SetSize(45)
	self.mainui.perk_cat.perkcat1.label:SetMultilineTruncatedString(STRINGS.GUI["attributes"], 2, 150, 50, "", true)
	self.mainui.perk_cat.perkcat2.label:SetMultilineTruncatedString(STRINGS.GUI["abilities"], 2, 150, 50, "", true)
	self.mainui.perk_cat.perkcat3.label:SetMultilineTruncatedString(STRINGS.GUI["crafting"], 2, 150, 50, "", true)
	self.mainui.levelbg.costheader:SetString(STRINGS.GUI["attributecost"])
	self.mainui.levelbg.attributelabels:SetString(STRINGS.GUI["attributelabels"])
	self.mainui.levelbg.attributeunits:SetString(STRINGS.GUI["attributeunits"])
	self.mainui.levelbg.reset.label:SetSize(35)
	self.mainui.levelbg.reset.label:SetMultilineTruncatedString(STRINGS.GUI["reset"], 2, 100, 50, "", true)
	self.mainui.removeinfoXP.label:SetSize(28)
	self.mainui.removeinfoXP.label:SetMultilineTruncatedString(STRINGS.GUI["resetlevel"], 5, 330, 500, "", true)
	self.mainui.removeinfoXP.removeyes.label:SetSize(28)
	self.mainui.removeinfoXP.removeyes.label:SetMultilineTruncatedString(STRINGS.GUI["reset"], 2, 70, 50, "", true)
	self.mainui.removeinfoXP.removeno.label:SetSize(28)
	self.mainui.removeinfoXP.removeno.label:SetMultilineTruncatedString(STRINGS.GUI["close"], 2, 70, 50, "", true)
	self.mainui.levelbg.close.label:SetSize(45)
	self.mainui.levelbg.close.label:SetMultilineTruncatedString(STRINGS.GUI["close"], 2, 100, 50, "", true)
	self.mainui.levelbg.info:SetMultilineTruncatedString(STRINGS.GUI["iteminfo"], 2, 800, 500, "", true)
	self.mainui.achievement_bg.info.header:SetString(STRINGS.GUI["foodlist"])
	self.mainui.levelbg.freepoints:SetString(STRINGS.GUI["availablePoints"]..self.availableattributepoints)
	self.mainui.levelbg.overallxp:SetString(STRINGS.GUI["overallxp"]..self.owner.currentoverallxp:value())
	self:build()
	self:perk_build()
end

return uiachievement