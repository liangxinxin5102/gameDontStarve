local Widget = require "widgets/widget" 
local Text = require "widgets/text" --Text类，文本处理
local TextButton = require "widgets/textbutton"
local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"

local INTRODUCE = "鼠标放在本控件上\n鼠标按住拖动位置\n按下空格键清除数据" 

local function IsValidTarget(inst,target)
	return  (target and target:IsValid() and target.replica.attacker_tracker and target.replica.health and not target.replica.health:IsDead())
end 

local function GetInfo(owner,target)
	if IsValidTarget(owner,target) then 
		return target.replica.attacker_tracker:GetStr()
	else
		return "Boss数据：空"
	end
end 

local CheckFocusTarget = Class(Widget, function(self, owner)
	Widget._ctor(self, "CheckFocusTarget") 
	self.owner = owner
	self.target = nil 
	
	--self.text = self:AddChild(Text(BODYTEXTFONT, 25,"Boss数据：空")) --添加一个文本变量，接收Text实例。
	
	self.text = self:AddChild(TextButton("text"))
	self.text:SetText("Boss数据：空")
	self.text:SetTooltip(INTRODUCE)
	--------------------------------------------------------------------------------
	--注意:以下为LongFei所写苏曼莎控件代码
	--------------------------------------------------------------------------------
	local function AddPoint(self,Valid)
		for k,v in pairs(Valid) do
			if Valid[k] ==true then
				self[k].point:Show()
			else
				self[k].point:Hide()
			end
		end
	end	
	function self:OnUIAddPoint(owner,data)
		if data and data.Valid then
			local Valid = data.Valid
			AddPoint(self,Valid)
		end
	end
	self.OnUIAddPointFn = function(owner,data) self:OnUIAddPoint(owner,data) end
	self.owner:ListenForEvent("UIAddPoint", self.OnUIAddPointFn)
	self.OnControl = function (self,control, down)
		self:Passive_OnControl(control, down) 
	end
	
	self:SetPosition(190,620,0)
	self:MoveToBack()
	self:StartUpdating()
end)


function CheckFocusTarget:Passive_OnControl(control, down)
	if control == CONTROL_ACCEPT then
		if down then
			self:StartDrag()
		else
			self:EndDrag()
		end
	end
end

function CheckFocusTarget:SetDragPosition(x, y, z)
	local pos
	if type(x) == "number" then
		pos = Vector3(x, y, z)
	else
		pos = x
	end
	self:SetPosition(pos + self.dragPosDiff)
end

function CheckFocusTarget:StartDrag()
	if not self.followhandler then
		local mousepos = TheInput:GetScreenPosition()
		self.dragPosDiff = self:GetPosition() - mousepos
		self.followhandler = TheInput:AddMoveHandler(function(x,y) self:SetDragPosition(x,y) end)
		self:SetDragPosition(mousepos)
		--print("CheckFocusTarget:StartDrag()")
	end
end

function CheckFocusTarget:EndDrag()
	if self.followhandler then
		self.followhandler:Remove()
	end
	self.followhandler = nil
	self.dragPosDiff = nil
	self:MoveToBack()
	--print("CheckFocusTarget:EndDrag()")
end

function CheckFocusTarget:Scale_DoDelta(delta)
	self.scale = math.max(self.scale+delta,0.1)
	self:SetScale(self.scale,self.scale,self.scale)
	self:MoveToBack()
	--print("CheckFocusTarget:Scale_DoDelta()")
end

function CheckFocusTarget:ClearUiStr()
	self.target = nil 
	self.text:SetText(GetInfo(self.owner,self.target))
end 

function CheckFocusTarget:OnUpdate()
	if self.owner.replica.combat and self.owner.replica.combat._target then 
		if IsValidTarget(self.owner,self.owner.replica.combat._target:value()) then 
			self.target = self.owner.replica.combat._target:value()
		end 
	end
	--if not IsValidTarget(self.owner,self.target) then 
		--self.target = TheInput:GetWorldEntityUnderMouse()
	--end
	--print("当前目标:",self.target)
	self.text:SetText(GetInfo(self.owner,self.target))
end

return CheckFocusTarget