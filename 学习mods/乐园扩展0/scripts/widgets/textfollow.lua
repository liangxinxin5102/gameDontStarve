require("constants")
local Text = require "widgets/text"
local Widget = require "widgets/widget"

local YOFFSETUP = -380
local YOFFSETDOWN = -350
local XOFFSET = -210

local SHOW_DELAY = 0 --10

local TextFollow = Class(Widget, function(self, str,secondarystr)
    Widget._ctor(self, "TextFollow")
    --self.owner = owner
    self.isFE = false
    self:SetClickable(false)
    --self:MakeNonClickable()

    self.default_text_pos = Vector3(0, 20, 0)
    self.text = self:AddChild(Text(UIFONT, 30))
    self.text:SetPosition(self.default_text_pos)
    self:FollowMouseConstrained()
    self:StartUpdating()
    self:SetStr(str,secondarystr)
    self.lastStr = ""
    self.strFrames = 0
end)

function TextFollow:OnUpdate()
end

function TextFollow:SetStr(tile)
    self.text:SetString(tile)
    self.str = tile
    if tile and tile ~= '' then
        self.text:Show()
        else
        self.text:Hide()
    end

end

function TextFollow:UpdatePosition(x, y)
    local scale = self:GetScale()
    local scr_w, scr_h = TheSim:GetScreenSize()
    local w = (x -900) /scale.x
    local h = (y -600) / scale.y
    self:SetPosition(w,h)
end

function TextFollow:FollowMouseConstrained()
    if self.followhandler == nil then
        self.followhandler = TheInput:AddMoveHandler(function(x, y) self:UpdatePosition(x, y) end)
        local pos = TheInput:GetScreenPosition()
        self:UpdatePosition(pos.x, pos.y)
    end
end

return TextFollow
