local Screen = require "widgets/screen"
local Widget = require "widgets/widget" 
local Text = require "widgets/text" 
local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local TextEdit = require "widgets/textedit" 
local TextButton = require "widgets/textbutton"
local ImagePopupDialogScreen = require "screens/imagepopupdialog"
local PopupDialogScreen = require "screens/popupdialog"
local MouseTracker = require "widgets/mousetracker"
local TEMPLATES = require "widgets/redux/templates"
local UIAnim = require "widgets/uianim"

---创建初始界面
local Cy_store = Class(Screen ,function(self,owner,goodsinfo,ewai)

Screen._ctor(self, "Cy_store")
	TheInput:ClearCachedController()
	self.owner = owner

    self.black = self:AddChild(ImageButton("images/global.xml", "square.tex"))
    self.black.image:SetVRegPoint(ANCHOR_MIDDLE)
    self.black.image:SetHRegPoint(ANCHOR_MIDDLE)
    self.black.image:SetVAnchor(ANCHOR_MIDDLE)
    self.black.image:SetHAnchor(ANCHOR_MIDDLE)
    self.black.image:SetScaleMode(SCALEMODE_FILLSCREEN)
    self.black.image:SetTint(0, 0, 0, .25)
    self.black:SetOnClick(function() self:Close() end)

    self.goodsinfo = goodsinfo
	self.ewai = ewai
    self.perpage = 20
    self.perline = 4

	self.root = self:AddChild(Widget("ROOT"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
	
	self.bg = self.root:AddChild(Image("images/hud/shophud.xml", "background.tex"))
	self.bg:SetPosition(0, 0)
    self:Init()
	
end)

function Cy_store:Init()	

	self.guanbi = self.bg:AddChild(ImageButton("images/hud/shophud.xml", "guanbi.tex"))
	self.guanbi:SetPosition(420, -240, 0)
	self.guanbi:SetOnClick(function()self:Close() end)

	self.choujiang = self.bg:AddChild(ImageButton("images/hud/shophud.xml", "choujiang.tex"))
	self.choujiang:SetPosition(-400, 220, 0)
	self.choujiang:SetScale(0.5)
	self.choujiang:SetOnClick(function() 
	if not self.owner:HasTag("playerghost") and self.owner.currenthuajicoin:value()>= 666 then
		SendModRPCToServer(GetModRPC("Cy_store", "choujiang"))
		self:Close()		
		end
		
	end)
	
self.ewaipos = self.bg:AddChild(Widget("ewaipos"))
self.ewaipos:SetPosition(0 ,0, 0)

--商品显示位置
self.goods = self.bg:AddChild(Widget("goods"))
self.goods:SetPosition(0,0, 0)
self.goods.goodsbutton = {}
--这个table必须要local？
local buttonlist={
[1]="ziyuan",
[2]="fight",
[3]="cloth",
[4]="shiwu",
[5]="ewai"
}
for buttonum = 1, #self.goodsinfo  do
-- -- ------------------------------生成商品按钮及其附属信息--------------------
local ycut=-(70*(buttonum-1))
if buttonum == 5 then
self.goods.goodsbutton[buttonum]= self.goods:AddChild(ImageButton("images/inventoryimages.xml", "pigshrine.tex"))
self.goods.goodsbutton[buttonum]:SetPosition(400, 220, 0)
self.goods.goodsbutton[buttonum]:SetScale(1.2)
else
self.goods.goodsbutton[buttonum]=self.goods:AddChild(ImageButton("images/hud/shophud.xml", buttonlist[buttonum]..".tex"))
self.goods.goodsbutton[buttonum]:SetScale(1.2)
self.goods.goodsbutton[buttonum]:SetPosition(-300,120+ycut, 0)
end
	self.goods.goodsbutton[buttonum].goodsitem = self.goods:AddChild(Image("images/hud/shophud.xml","goodspos.tex"))
	self.goods.goodsbutton[buttonum].goodsitem:SetScale(1)
	self.goods.goodsbutton[buttonum].goodsitem:SetPosition(100 ,-40, 0)
	self.goods.goodsbutton[buttonum].goodsitem:Hide()
self.goods.goodsbutton[buttonum]:SetOnClick(function()	
	for var1=1,#self.goodsinfo do
			if var1==buttonum  then
			self.goods.goodsbutton[buttonum].goodsitem:Show()
			else
			self.goods.goodsbutton[var1].goodsitem:Hide()
			end
	end

end)
self.goods.goodsbutton[buttonum].page = 1
self.goods.goodsbutton[buttonum].maxpage = math.ceil(#self.goodsinfo[buttonum] / self.perpage) or 1---商品量除以每页的商品数得到最大页数
self.goods.goodsbutton[buttonum].items = self.goods.goodsbutton[buttonum].goodsitem:AddChild(Widget("goods"))
self.goods.goodsbutton[buttonum].items:SetPosition(-50,33, 0)
self.goods.goodsbutton[buttonum].items:SetScale(1.2)
-- --预显示
self:CreatGoods(buttonum)
--上一页
self.goods.goodsbutton[buttonum].lastpage = self.goods.goodsbutton[buttonum].goodsitem:AddChild(ImageButton("images/hud/shophud.xml", "lastpage.tex"))
self.goods.goodsbutton[buttonum].lastpage:SetPosition(-470,-140, 0)
self.goods.goodsbutton[buttonum].lastpage:SetOnClick(function()self:PageLast(buttonum) end)
--下一页
self.goods.goodsbutton[buttonum].nextpage = self.goods.goodsbutton[buttonum].goodsitem:AddChild(ImageButton("images/hud/shophud.xml", "nextpage.tex"))
self.goods.goodsbutton[buttonum].nextpage:SetPosition(-330,-140, 0)
self.goods.goodsbutton[buttonum].nextpage:SetOnClick (function()self:PageNext(buttonum) end)		
--页码
self.goods.goodsbutton[buttonum].pages = self.goods.goodsbutton[buttonum].goodsitem:AddChild(Text(BUTTONFONT, 36))
self.goods.goodsbutton[buttonum].pages:SetPosition(-400,-140, 0)
self.goods.goodsbutton[buttonum].pages:SetColour(255 / 255, 255 / 255, 255 / 255, 1)
self.goods.goodsbutton[buttonum].pages:SetString("第  "  ..tostring(self.goods.goodsbutton[buttonum].page) .."  页")--获取页码
end




--金钱显示
self.coin = self.bg:AddChild(Widget("goods"))
self.goods.goodsbutton[1].goodsitem:Show()
self:CreatAmount()	
self:StartUpdating()
end

--刷新金钱显示
function Cy_store:CreatAmount()
	self.coin:KillAllChildren()
	self.huajicoin = self.coin:AddChild(Text(NEWFONT_OUTLINE, 40, self.owner.currenthuajicoin:value()))
	self.huajicoin:SetPosition( 0,243 , 0)
end


function Cy_store:ReBuy(buttonum,num,prefabname)

local  tesbuttons = {
            {
                text = "购买", cb = function() 	
	local fnstr = self.buytimes:GetString()
	fnstr =tonumber(fnstr)
	if ( fnstr and type(fnstr) == "number" and fnstr > 0 )  then
	fnstr = math.ceil(fnstr)
	else 
	fnstr = 1
	end	
	if not self.owner:HasTag("playerghost") and self.owner.currenthuajicoin:value()>= (self.goods.goodsbutton[buttonum].goodsitem.image[num].price)*fnstr then
	SendModRPCToServer(GetModRPC("Cy_store", "buyitem"),buttonum,num,fnstr)
	self:Close()
	end
     end,
            },
			
		{text = "取消", cb = function()  self.buysometing:Hide() end  },
			
        }
    self.buysometingbg = self.buysometing:AddChild(TEMPLATES.CurlyWindow(450, 300, "输入要购买的数量" ,tesbuttons, nil, (STRINGS.NAMES[string.upper(prefabname)]or "未知").."\n x"))
	self.buysometingbg:SetPosition(100,-50,0)
	self.buysometingbg.body:SetPosition(0, 60)
	self.buytimes_bg = self.buysometingbg:AddChild(Image("images/textboxes.xml", "textbox2_small_grey.tex") )
	self.buytimes_bg:SetPosition(0,0, 0)
	self.buytimes_bg:ScaleToSize( 130, 55 )
	self.buytimes = self.buysometingbg:AddChild( TextEdit( DEFAULTFONT, 30, "" ) )
	self.buytimes:SetPosition(0,0, 0)
	self.buytimes:SetRegionSize( 120, 50 )
	self.buytimes:SetHAlign(ANCHOR_LEFT)
	self.buytimes.edit_text_color = {1,1,1,1}
	self.buytimes.idle_text_color = {1,1,1,1}
	self.buytimes:SetEditCursorColour(1,1,1,1) 
	self.buytimes:SetFocusedImage( self.buytimes_bg, "images/textboxes.xml", "textbox2_small_grey.tex", "textbox2_small_gold.tex", "textbox2_small_gold_greyfill.tex" )
	self.buytimes:SetString("")
	

end
--刷新商品显示	
function Cy_store:CreatGoods(buttonum)
local spacex =-85
local spacey =83
local perline=5	
local prefabname = "log"
self.buysometing = self.goods:AddChild(Widget("buysometing"))
self.goods.goodsbutton[buttonum].goodsitem.image={}
self.goods.goodsbutton[buttonum].goodsitem.text={}
self.goods.goodsbutton[buttonum].items:KillAllChildren()
	for row =1,4,1 do
		for line = 1,5,1 do 
			local num=(self.goods.goodsbutton[buttonum].page-1)*20+(row-1)*perline + line	
			if num <= #self.goodsinfo[buttonum] then
			if type(self.goodsinfo[buttonum][num][001]) == "string" then prefabname = self.goodsinfo[buttonum][num][001] end--如果名称的类型是string则名字改成商品的名字
--显示图标			  
if buttonum == 5 then
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/"..prefabname..".xml", prefabname .. ".tex"))
else
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages.xml", prefabname .. ".tex"))
end	
	
	local pos = Vector3(spacey * (line - perline/2 - 0.5)+30,spacex * (row - perline/2 - 0.5)-30,0)
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetPosition(pos)
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetScale(0.85,0.85,0.85)
	self.goods.goodsbutton[buttonum].goodsitem.image[num].name = self.goodsinfo[buttonum][num][001]
	self.goods.goodsbutton[buttonum].goodsitem.image[num].price = self.goodsinfo[buttonum][num][002] or 9999
--点击按钮			
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetOnClick(function()
	self.buysometing:Show()
	self:ReBuy(buttonum,num,self.goodsinfo[buttonum][num][001])
	end)
--价格显示
	
	self.goods.goodsbutton[buttonum].goodsitem.text[num]=	self.goods.goodsbutton[buttonum].goodsitem.image[num]:AddChild(Text(NEWFONT_OUTLINE,33))--字体字号
	self.goods.goodsbutton[buttonum].goodsitem.text[num]:SetPosition(0,-42-3,0)--坐标
	self.goods.goodsbutton[buttonum].goodsitem.text[num]:SetString("$" .. tostring(self.goodsinfo[buttonum][num][002]) .. " ")--文本
		if self.goodsinfo[buttonum][num][002] >=10000 then 
			self.goods.goodsbutton[buttonum].goodsitem.text[num]:SetColour(255/255,140/255,0/255,1)--颜色
		elseif self.goodsinfo[buttonum][num][002] >=1000 then 
			self.goods.goodsbutton[buttonum].goodsitem.text[num]:SetColour(255/255,182/255,193/255,1)--颜色
		else
			self.goods.goodsbutton[buttonum].goodsitem.text[num]:SetColour(255/255,255/255,224/255,1)--颜色
		
		end

	end
	end
     
    end
end



--翻页函数1

function  Cy_store:PageLast(buttonum)
    if self.goods.goodsbutton[buttonum].page == 1 then return false end
    
    if self.goods.goodsbutton[buttonum].page > 1 then self.goods.goodsbutton[buttonum].page = self.goods.goodsbutton[buttonum].page - 1 end
    self:CreatGoods(buttonum)
    self.goods.goodsbutton[buttonum].pages:SetString("第  "  ..tostring(self.goods.goodsbutton[buttonum].page) .."  页")
end
--翻页函数2
function  Cy_store:PageNext(buttonum)
    if self.goods.goodsbutton[buttonum].page == self.goods.goodsbutton[buttonum].maxpage then return false end
    
    if self.goods.goodsbutton[buttonum].page < self.goods.goodsbutton[buttonum].maxpage then self.goods.goodsbutton[buttonum].page = self.goods.goodsbutton[buttonum].page + 1 end
    self:CreatGoods(buttonum)
    self.goods.goodsbutton[buttonum].pages:SetString("第  "  ..tostring(self.goods.goodsbutton[buttonum].page) .."  页")
end

--初始化界面
function Cy_store:OnBecomeActive()
	Cy_store._base.OnBecomeActive(self)

end


--界面关闭
function Cy_store:Close()
	scheduler:ExecuteInTime(0, function() 
		for k,v in pairs(self.root:GetChildren()) do
			if k ~= self.bg then
				k:Hide()
			end
		end	
	end)
	self.black:Hide()
	self.bg:Hide()
	TheFrontEnd:PopScreen(self)
	
end



return Cy_store