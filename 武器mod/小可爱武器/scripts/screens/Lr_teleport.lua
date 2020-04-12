require "util"
local Screen = require "widgets/screen"
local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local Image = require "widgets/image"
local UIAnim = require "widgets/uianim"
local NumericSpinner = require "widgets/numericspinner"
local TextEdit = require "widgets/textedit"
local Widget = require "widgets/widget"
local Text = require "widgets/text"
local ImageButton = require "widgets/imagebutton"
local TextButton = require "widgets/textbutton"

local Lr_teleport = Class(Screen ,function(self,owner)
	Screen._ctor(self, "Lr_teleport")--创建这个界面
	TheInput:ClearCachedController()--让玩家不能使用摁键?
	self.owner = owner
	
	self.root = self:AddChild(Widget("ROOT"))--可理解为创建屏幕的一个基础点
    self.root:SetVAnchor(ANCHOR_MIDDLE)--把整个界面的中心点设成屏幕中心点
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0,0,0)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
	
	--[[
	self.black = self:AddChild(ImageButton("images/global.xml", "square.tex"))
    self.black.image:SetVRegPoint(ANCHOR_MIDDLE)
    self.black.image:SetHRegPoint(ANCHOR_MIDDLE)
    self.black.image:SetVAnchor(ANCHOR_MIDDLE)
    self.black.image:SetHAnchor(ANCHOR_MIDDLE)
    self.black.image:SetScaleMode(SCALEMODE_FILLSCREEN)
    self.black.image:SetTint(0, 0, 0, 0)-- invisible, but clickable!
    self.black:SetOnClick(function()self:Close() end)
	--]]
	
	self.bg = self.root:AddChild(Image("images/globalpanels2.xml", "panel_long.tex"))--创建界面的背景图
    self.bg:SetVRegPoint(ANCHOR_MIDDLE)--中心点也置于屏幕中心
    self.bg:SetHRegPoint(ANCHOR_MIDDLE)
	self.bg:SetScale(0.75,0.75,0.75)
	
    self.title = self.root:AddChild(Text(TITLEFONT, 35))--没啥好说的，就是放置一段文字
    self.title:SetPosition(0, 130, 0)
    self.title:SetString(STRINGS.UI.LR_TELEPORT)
	
    self.text = self.root:AddChild(Text(BODYTEXTFONT, 25))

    self.text:SetPosition(0, 25, 0)
    self.text:SetString(STRINGS.UI.LR_TELEPORT_INFO)
    self.text:EnableWordWrap(true)
    --self.text:SetRegionSize(500, 160)
	
    self.edit_bg = self.root:AddChild( Image() )
	self.edit_bg:SetTexture( "images/textboxes.xml", "textbox_long.tex" )
	self.edit_bg:SetPosition( 0,-90,0)
	self.edit_bg:ScaleToSize( 200, 50 )--根据像素设定大小？
	

	local confirmbutton = self.root:AddChild(TextButton("images/ui.xml", "blank.tex","blank.tex","blank.tex","blank.tex"))
	confirmbutton:SetPosition(-250,-90,0)
	confirmbutton.text:SetRegionSize(100, 50)
	confirmbutton.text:SetHAlign(ANCHOR_MIDDLE)
	confirmbutton:SetText(STRINGS.UI.LR_CONFIRM)
	confirmbutton:SetTextSize(32)
	confirmbutton:SetFont(UIFONT)
	confirmbutton:SetTextColour(0.9,0.8,0.6,1)
	confirmbutton:SetTextFocusColour(1,1,1,1)
	confirmbutton:SetOnClick(function()self:Run() end)
	
	local cancelbutton = self.root:AddChild(TextButton("images/ui.xml", "blank.tex","blank.tex","blank.tex","blank.tex"))
	cancelbutton:SetPosition(250,-90,0)
	cancelbutton.text:SetRegionSize(100, 50)
	cancelbutton.text:SetHAlign(ANCHOR_MIDDLE)
	cancelbutton:SetText(STRINGS.UI.LR_CANCEL)
	cancelbutton:SetTextSize(32)
	cancelbutton:SetFont(UIFONT)
	cancelbutton:SetTextColour(0.9,0.8,0.6,1)
	cancelbutton:SetTextFocusColour(1,1,1,1)
	cancelbutton:SetOnClick(function()self:Close() end)

	
	self.console_edit = self.root:AddChild( TextEdit( DEFAULTFONT, 30, "" ) )
	self.console_edit:SetPosition( 0,-90,0)
	self.console_edit:SetRegionSize( 175, 50 )
	self.console_edit:SetHAlign(ANCHOR_MIDDLE)
	self.console_edit.edit_text_color = {1,1,1,1}
	self.console_edit.idle_text_color = {1,1,1,1}
	self.console_edit:SetEditCursorColour(1,1,1,1) 

	self.console_edit.OnTextEntered = function() self:OnTextEntered() end
	self.console_edit:SetFocusedImage( self.edit_bg, "images/textboxes.xml", "textbox_long_over.tex", "textbox_long.tex" )

	self.console_edit:SetString("")

	self.console_edit.validrawkeys[KEY_TAB] = false
	self.console_edit.validrawkeys[KEY_UP] = false
	self.console_edit.validrawkeys[KEY_DOWN] = false
	self.console_edit:SetEditing(true)

	self.default_focus = self.console_edit
	self.focus_forward = self.console_edit
	


end)

function Lr_teleport:OnBecomeActive()
	Lr_teleport._base.OnBecomeActive(self)
	
	self.console_edit:SetFocus()
	self.console_edit:SetEditing(true)

end

function Lr_teleport:Run()
	local fnstr = self.console_edit:GetString()
	if type(tonumber(fnstr)) == "number" then
		local player=self.owner
		if(player and fnstr and fnstr~="")then
			SendModRPCToServer(GetModRPC("allclients", "lr_teleport"), fnstr)
			self:Close()
		end
	end
end

function Lr_teleport:Close()
	TheFrontEnd:PopScreen()
end

function Lr_teleport:OnTextEntered()
	self:Run()
end

function Lr_teleport:OnControl(control, down)
    if Lr_teleport._base.OnControl(self, control, down) then
        return true
    elseif not down and (control == CONTROL_PAUSE or control == CONTROL_CANCEL or control == KEY_B) then
        self:Close()
        TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
        return true
    end
end

return Lr_teleport
