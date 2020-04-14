local Widget = require "widgets/widget" 
local ImageButton = require "widgets/imagebutton"

local JQ = Class(Widget, function(self)
		Widget._ctor(self, "JQ")
		self.root = self:AddChild(Widget("ROOT"))		
		self.wy = self.root:AddChild(ImageButton("images/wy.xml", "wy.tex", nil, nil, nil, nil, {1,1}, {0,0}))
		self.wy:SetScale(0.3, 0.3, 0.3)
		self.wy:SetHAnchor(1) 
		self.wy:SetVAnchor(1) 
		self.wy:SetPosition(350,-50,0) 
		self.wy:SetOnClick(function()
                            if TheSim.RAILGetPlatform and TheSim:RAILGetPlatform() == "TGP" then
                                VisitURL("https://jq.qq.com/?_wv=1027&k=5naI4kA", false)
                            end
                        end)				
end)

local JQ = Class(Widget, function(self)
		Widget._ctor(self, "JQ")
		self.root = self:AddChild(Widget("ROOT"))		
		self.wy = self.root:AddChild(ImageButton("images/wy.xml", "wy.tex", nil, nil, nil, nil, {1,1}, {0,0}))
		self.wy:SetScale(0.3, 0.3, 0.3)
		self.wy:SetHAnchor(1) 
		self.wy:SetVAnchor(1) 
		self.wy:SetPosition(80,-50,0) 
		self.wy:SetOnClick(function()
                            if TheSim.RAILGetPlatform and TheSim:RAILGetPlatform() == "TGP" then
                                VisitURL("https://jq.qq.com/?_wv=1027&k=5naI4kA", false)
                            end
                        end)				
end)

return JQ