local ANCHOR_MIDDLE = GLOBAL.ANCHOR_MIDDLE
local SCALEMODE_PROPORTIONAL = GLOBAL.SCALEMODE_PROPORTIONAL
local SCALEMODE_FILLSCREEN = GLOBAL.SCALEMODE_FILLSCREEN
local FRONTEND_TITLE_COLOUR = GLOBAL.FRONTEND_TITLE_COLOUR
local RESOLUTION_X = GLOBAL.RESOLUTION_X
local RESOLUTION_Y = GLOBAL.RESOLUTION_Y
local BACK_BUTTON_Y = GLOBAL.BACK_BUTTON_Y
local STRINGS = GLOBAL.STRINGS
local GOLD = GLOBAL.GOLD
local MOVE_DOWN = GLOBAL.MOVE_DOWN
local MOVE_UP = GLOBAL.MOVE_UP

local title_x = 20
local title_y = 10
local subtitle_offset_x = 20
local subtitle_offset_y = -260
local rcol = RESOLUTION_X/2 -200
local lcol = -RESOLUTION_X/2 + 280

local Image = GLOBAL.require("widgets/image")
local Widget = GLOBAL.require("widgets/widget")
local TEMPLATES = GLOBAL.require("widgets/templates")
local OnlineStatus = GLOBAL.require("widgets/onlinestatus")
local Countdown = GLOBAL.require("widgets/countdown")
local ImageButton = GLOBAL.require("widgets/imagebutton")

local function modify(self)
    local btn_profile = {
        {name = "fuck", title = "武林大会", fn = function()
            self.fuck_button:Disable()
            if GLOBAL.IsRail() then
                GLOBAL.c_connect("dst_rail.gznc.org", 11000)
            else
                GLOBAL.c_connect("dst_steam.gznc.org", 11000)
            end
        end}
    }

    for k, v in pairs(btn_profile) do
        local btn = self.fixed_root:AddChild(ImageButton("images/frontscreen.xml", "play_highlight.tex", nil, nil, nil, nil, {1,1}, {0,0}))--"highlight.tex", "highlight_hover.tex"))
        btn.bg = btn:AddChild(Image("images/frontscreen.xml", "play_highlight_hover.tex"))
        btn.bg:SetScale(.69, .53)
        btn.bg:MoveToBack()
        btn.bg:Hide()
        btn.image:SetPosition(0,3)
        btn.bg:SetPosition(0,3)
        btn:SetPosition(-RESOLUTION_X * .35, -75 * k)
        btn:SetTextColour(1, 1, 1, 1)
        btn:SetTextFocusColour(1, 1, 1, 1)
        btn:SetTextDisabledColour({1,1,1,1})
        btn:SetNormalScale(.65, .5)
        btn:SetFocusScale(.7, .55)
        btn:SetTextSize(55)
        btn:SetFont(GLOBAL.TITLEFONT)
        btn:SetDisabledFont(GLOBAL.TITLEFONT)
        btn:SetText(v.title, true, {2,-3})
        local playgainfocusfn = btn.OnGainFocus
        local playlosefocusfn = btn.OnLoseFocus
        btn.OnGainFocus = function()
            playgainfocusfn(btn)
            btn:SetTextSize(58)
            btn.image:SetTint(1,1,1,1)
            btn.bg:Show()
        end
        btn.OnLoseFocus = function()
            playlosefocusfn(btn)
            btn:SetTextSize(55)
            btn.image:SetTint(1,1,1,.6)
            btn.bg:Hide()
        end
        btn:SetOnClick(v.fn)

        self[v.name .. "_button"] = btn
    end

    local old_OnBecomeActive = self.OnBecomeActive
    function self:OnBecomeActive()
        old_OnBecomeActive(self)
        for k, v in pairs(btn_profile) do
            self[v.name .. "_button"]:Enable()
        end
    end
end

AddClassPostConstruct("screens/redux/mainscreen", modify)