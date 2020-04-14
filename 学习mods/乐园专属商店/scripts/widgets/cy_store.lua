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
local TEMPLATES = require "widgets/templates"
local UIAnim = require "widgets/uianim"
local DEBUG_MODE = BRANCH == "dev"
-- modimport"scripts/goodsinfodata.lua"
local assets =
{
   
}

---创建初始界面
local Cy_store = Class(Widget ,function(self,owner,goodsinfo,jieshaopanduan)

Widget._ctor(self, "Cy_store")--创建这个界面,Cy_store为screen名称
-- TheInput:ClearCachedController()--让玩家不能使用摁键? 禁用键盘操作
self.owner = owner
self.jieshaopanduan=jieshaopanduan
    self.goodsinfo = goodsinfo
    self.perpage = 25
    self.perline = 5

    -- self.goodsinfo = goodsinfo
--设置根基？
self.root = self:AddChild(Widget("ROOT"))--可理解为创建屏幕的一个基础点
self.root:SetVAnchor(ANCHOR_MIDDLE)--把整个界面的中心点设成屏幕中心点
self.root:SetHAnchor(ANCHOR_MIDDLE)
self.root:SetPosition(0,0,0)
self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)

--载入背景
self.bg=self.root:AddChild(Image("images/background/background.xml","background.tex"))
self.bg:SetVRegPoint(ANCHOR_MIDDLE)
self.bg:SetHRegPoint(ANCHOR_MIDDLE)
self.bg:SetScale(0.6,0.6,0.6)
self.bg:Hide()



--载入按钮
	self.main = self.root:AddChild(ImageButton("images/hud/storeico.xml", "storeico.tex", nil, nil, nil, nil, {1,1}, {0,0}))
		self.main:SetScale(0.45, 0.45, 0.45)
		self.main:SetHoverText("乐园商店")
		self.main:SetHAnchor(1) 
		self.main:SetVAnchor(2) 
		self.main:SetPosition(70,50,0) 
		self.main:SetOnClick(function()    
		self:CreatAmount()		
		if self.bg.shown then
			
		else
			self.bg:Show()
		end
		end)
--位置调整

-- local x=200
-- local y=-50

-- TheInput:AddKeyDownHandler(KEY_L,function()
   -- x=x+1
		-- self.dssjz:SetPosition(x,y, 0)
-- end)
-- TheInput:AddKeyDownHandler(KEY_J,function()
   -- x=x-1
		-- self.dssjz:SetPosition(x,y, 0)
-- end)
-- TheInput:AddKeyDownHandler(KEY_I,function()
   -- y=y+1
	-- self.dssjz:SetPosition(x,y, 0)
-- end)
-- TheInput:AddKeyDownHandler(KEY_K,function()
   -- y=y-1
	-- self.dssjz:SetPosition(x,y, 0)
-- end)


-- TheInput:AddKeyDownHandler(KEY_P,function()
   -- print(x,y)
  

-- end)

----377 -305

-------------------------基本按钮显示-------------------------------------
    --关闭
	self.guanbi = self.bg:AddChild(ImageButton("images/hud/guanbi.xml", "guanbi.tex"))
	self.guanbi:SetPosition(436, 290, 0)
	self.guanbi:SetOnClick(function()self:Close() end)
	--动画
	---------------------------------------------------------------
	self.dssjz = self.bg:AddChild(UIAnim())
	self.dssjz:SetPosition(330,-240, 0)
	self.dssjz:SetScale(0.57,0.57)
	self.dssjz:GetAnimState():SetBuild("dssjz")
	self.dssjz:GetAnimState():SetBank("dssjz")
	
	self.dssjz:GetAnimState():PlayAnimation("idle", true)	--标号-normal - start

	
	
	
--抽奖
	self.choujiang = self.bg:AddChild(ImageButton("images/hud/choujiang.xml", "choujiang.tex"))
	self.choujiang:SetPosition(337, 87, 0)
	self.choujiang:SetHoverText("乐园抽奖")
	self.choujiang:SetOnClick(function() 
	--清理
	for var1=1,#self.goodsinfo do
			if self.goods.goodsbutton[var1].goodsitem.shown then
			self.goods.goodsbutton[var1].goodsitem:Hide()
			end
		end
		
	self.fuwuqijieshaopos:Hide()
		
	--self.chenghaogpos:Hide()
	self.choujiangpos:Show()
	
	
	end)
--抽奖附着点
	self.choujiangpos = self.bg:AddChild(Widget("goods"))
	self.choujiangpos:SetPosition(109,-54, 0)
	self.choujiangpos:Hide()
	
	self.choujiang1 = self.choujiangpos:AddChild(Image("images/hud/choujiang1.xml", "choujiang1.tex"))
	self.choujiang1:SetPosition( -129, 15, 0)
--抽奖1次按钮
	self.choujiang2 = self.choujiang1:AddChild(ImageButton("images/hud/choujiang2.xml", "choujiang2.tex"))
	self.choujiang2:SetPosition(-5, -139, 0)
	self.choujiang2:SetOnClick(function() 
--判断玩家死活，发送数据	
		if not self.owner:HasTag("playerghost") and self.owner.currenthuajicoin:value()>= 666 then
		SendModRPCToServer(GetModRPC("Cy_store", "choujiang"))
		--延迟用来等待数据刷新
			self.inst:DoTaskInTime(.2, function()
				

				self:CreatAmount()
				
			end)
		end
	
	end)
	
	

--介绍附着点
self.fuwuqijieshaopos = self.bg:AddChild(Widget("goods"))
self.fuwuqijieshaopos:SetPosition(109,-54, 0)
self.fuwuqijieshaopos:Hide()

--服务器介绍按钮
	self.fuwuqijieshao = self.bg:AddChild(ImageButton("images/hud/fuwuqijieshao.xml", "fuwuqijieshao.tex"))
	self.fuwuqijieshao:SetScale(0.15,0.15,0.15)
	self.fuwuqijieshao:SetPosition( 411,288, 0)
	if self.jieshaopanduan ==false then 
		self.fuwuqijieshao:Hide()
	end
	self.fuwuqijieshao:SetOnClick(function()
		--清理
		for var1=1,#self.goodsinfo do
			if self.goods.goodsbutton[var1].goodsitem.shown then
			self.goods.goodsbutton[var1].goodsitem:Hide()
			end
		end
		
		self.choujiangpos:Hide()
		self.fuwuqijieshaopos:Show()
		self.fuwuqijieshao.page=1
		self:CreatInfo()
	end)


	
--商品显示位置
self.goods = self.bg:AddChild(Widget("goods"))
self.goods:SetPosition(68 ,-23, 0)
self.goods.goodsbutton = {}
--这个table必须要local？
local buttonlist={
[1]="ziyuan",
[2]="fight",
[3]="cloth",
[4]="shiwu",
}
for buttonum = 1, #self.goodsinfo  do
-- -- ------------------------------生成商品按钮及其附属信息--------------------
local ycut=-(75*(buttonum-1))
self.goods.goodsbutton[buttonum]=self.bg:AddChild(ImageButton("images/hud/"..buttonlist[buttonum]..".xml", buttonlist[buttonum]..".tex"))
self.goods.goodsbutton[buttonum]:SetPosition(-337,130-75+ycut, 0)
--商品信息主界面附着点
	self.goods.goodsbutton[buttonum].goodsitem = self.bg:AddChild(Image("images/hud/goodspos2.xml","goodspos2.tex"))
--这里原点坐标还需要调整s
--只调整goodsitem的hide和show
	self.goods.goodsbutton[buttonum].goodsitem:SetPosition(-21 ,-38, 0)
--页码商品等以他为附着点 不需要再加ycut
	self.goods.goodsbutton[buttonum].goodsitem:Hide()
	
self.goods.goodsbutton[buttonum]:SetOnClick(function()	
	for var1=1,#self.goodsinfo do
			if var1==buttonum  then
			self.goods.goodsbutton[buttonum].goodsitem:Show()
			else
			self.goods.goodsbutton[var1].goodsitem:Hide()
			end
	end
	
	self.fuwuqijieshaopos:Hide() 
	self.choujiangpos:Hide()
	--self.chenghaogpos:Hide()
	--点击显示内容--goodsitem
end)
self.goods.goodsbutton[buttonum].page = 1
self.goods.goodsbutton[buttonum].maxpage = math.ceil(#self.goodsinfo[buttonum] / self.perpage) or 1---商品量除以每页的商品数得到最大页数
self.goods.goodsbutton[buttonum].items = self.goods.goodsbutton[buttonum].goodsitem:AddChild(Widget("goods"))
self.goods.goodsbutton[buttonum].items:SetPosition(0,0, 0)
-- --预显示
self:CreatGoods(buttonum)
--上一页
self.goods.goodsbutton[buttonum].lastpage = self.goods.goodsbutton[buttonum].goodsitem:AddChild(ImageButton("images/hud/lastpage.xml", "lastpage.tex"))
self.goods.goodsbutton[buttonum].lastpage:SetPosition(-119,-245, 0)
self.goods.goodsbutton[buttonum].lastpage:SetOnClick(function()self:PageLast(buttonum) end)
--下一页
self.goods.goodsbutton[buttonum].nextpage = self.goods.goodsbutton[buttonum].goodsitem:AddChild(ImageButton("images/hud/nextpage.xml", "nextpage.tex"))
self.goods.goodsbutton[buttonum].nextpage:SetPosition(122,-245, 0)
self.goods.goodsbutton[buttonum].nextpage:SetOnClick (function()self:PageNext(buttonum) end)		
--页码
self.goods.goodsbutton[buttonum].pages = self.goods.goodsbutton[buttonum].goodsitem:AddChild(Text(BUTTONFONT, 30))
self.goods.goodsbutton[buttonum].pages:SetPosition(0,-245, 0)
self.goods.goodsbutton[buttonum].pages:SetColour(255 / 255, 255 / 255, 255 / 255, 1)
self.goods.goodsbutton[buttonum].pages:SetString("第  "  ..tostring(self.goods.goodsbutton[buttonum].page) .."  页")--获取页码
end

-----------服务器介绍部分

self.fuwuqijieshao.info={}
self.fuwuqijieshao.page=1
for var = 1,9 do
-- -- ------------------------------生成按钮及其附属信息--------------------
self.fuwuqijieshao.info[var]=self.fuwuqijieshaopos:AddChild(Image("images/hud/info"..tostring(var)..".xml", "info"..tostring(var)..".tex"))
self.fuwuqijieshao.info[var]:SetPosition(0,0, 0)
self.fuwuqijieshao.info[var]:SetScale(1,1,1)
self.fuwuqijieshao.info[var]:Hide()
end

--服务器上一页属于pos140 -252
self.fuwuqijieshao.lastpage = self.fuwuqijieshaopos:AddChild(ImageButton("images/hud/lastpage.xml", "lastpage.tex"))
self.fuwuqijieshao.lastpage:SetPosition( 249-109, -305+53, 0)
self.fuwuqijieshao.lastpage:SetOnClick(function()
self:jieshaoPageLast() 
end)
--下一页
self.fuwuqijieshao.nextpage = self.fuwuqijieshaopos:AddChild(ImageButton("images/hud/nextpage.xml", "nextpage.tex"))
self.fuwuqijieshao.nextpage:SetPosition(377-109,-305+53, 0)
self.fuwuqijieshao.nextpage:SetOnClick (function()
self:jieshaoPageNext() 
end)		
--页码
self.fuwuqijieshao.pages = self.fuwuqijieshaopos:AddChild(Text(BUTTONFONT, 30))
self.fuwuqijieshao.pages:SetPosition(71-109,-307+53, 0)
self.fuwuqijieshao.pages:SetColour(255 / 255, 255 / 255, 255 / 255, 1)
self.fuwuqijieshao.pages:SetString("第  "  ..tostring(self.fuwuqijieshao.page) .."  页")--获取页码

--金钱显示
self.coin = self.bg:AddChild(Widget("goods"))
self.goods.goodsbutton[1].goodsitem:Show()
self.fuwuqijieshaopos:MoveToFront()	
end)

--刷新金钱显示
function Cy_store:CreatAmount()
	self.coin:KillAllChildren()
	self.huajicoin = self.coin:AddChild(Text(NEWFONT_OUTLINE, 40, self.owner.currenthuajicoin:value()))
	self.huajicoin:SetScale(0.85,0.85,0.85)
	self.huajicoin:SetPosition( 336+10,235 , 0)
end

-- --刷新介绍显示	
function Cy_store:CreatInfo()
for var=1,9 do
self.fuwuqijieshao.info[var]:Hide()
end
self.fuwuqijieshao.info[self.fuwuqijieshao.page]:Show()
self.fuwuqijieshao.pages:SetString("第  "  ..tostring(self.fuwuqijieshao.page) .."  页")--刷新页码

	-- self.fuwuqijieshao.info[self.fuwuqijieshao.page-1]:Hide()

end

--刷新商品显示	
function Cy_store:CreatGoods(buttonum)
local spacex =-85
local spacey =83
local perline=5	
local prefabname = "log"
self.goods.goodsbutton[buttonum].goodsitem.image={}
self.goods.goodsbutton[buttonum].goodsitem.text={}
self.goods.goodsbutton[buttonum].items:KillAllChildren()
	for row =1,5,1 do
		for line = 1,5,1 do 
			local num=(self.goods.goodsbutton[buttonum].page-1)*25+(row-1)*perline + line
		
			if num <= #self.goodsinfo[buttonum] then
		---调试用 默认为Log	local prefabname = "log"
			if type(self.goodsinfo[buttonum][num][001]) == "string" then prefabname = self.goodsinfo[buttonum][num][001] end--如果名称的类型是string则名字改成商品的名字
--显示图标		

    if prefabname == "chazi" then
    self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/chazi.xml", "chazi.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("乐园鬼叉")
	elseif prefabname == "hj_pokeball" then --精灵球  
    self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/hj_pokeball.xml", "hj_pokeball.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("精灵球")
	elseif prefabname == "hj_wings1" then --火鸡背包1
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/hj_wings1.xml", "hj_wings1.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("火鸡背包")
	elseif prefabname == "hj_wings2" then --火鸡背包2
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/hj_wings2.xml", "hj_wings2.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("火鸡背包")
	elseif prefabname == "hj_wings3" then --火鸡背包3
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/hj_wings3.xml", "hj_wings3.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("火鸡背包")
	elseif prefabname == "hj_wings4" then --火鸡背包4
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/hj_wings4.xml", "hj_wings4.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("火鸡背包")
	elseif prefabname == "hj_wings5" then --火鸡背包5
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/hj_wings5.xml", "hj_wings5.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("火鸡背包")
	
	elseif prefabname == "lgq" then --流光琴
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/lgq.xml", "lgq.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("音乐流光琴")
	elseif prefabname == "ly_bobbag" then --海绵宝宝背包
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/ly_bobbag.xml", "ly_bobbag.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("海绵背包")
	elseif prefabname == "ly_hehebag" then --滑稽背包
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/ly_hehebag.xml", "ly_hehebag.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("滑稽背包")
	elseif prefabname == "ly_juanzhou" then --乐园卷轴
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/yyy.xml", "yyy.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("鉴定石")
	elseif prefabname == "ly_pandabag" then --乐园熊猫背包
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/ly_pandabag.xml", "ly_pandabag.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("熊猫背包")
	elseif prefabname == "ly_wingbag" then --乐园翅膀背包
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/ly_wingbag.xml", "ly_wingbag.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("翅膀背包")
	elseif prefabname == "lyzcm001" then --乐园白色招财猫
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/ly_zcm001.xml", "ly_zcm001.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("乐园招财猫")
	elseif prefabname == "lyzcm002" then --乐园紫色招财猫
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/ly_zcm002.xml", "ly_zcm002.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("乐园进宝猫")
	elseif prefabname == "lycoin"   then --乐园100元充值币
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/ly_zcm003.xml", "ly_zcm003.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("乐园充值币")
	elseif prefabname == "newweapons" then --乐园新手武器
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/newweapons.xml", "newweapons.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("新手武器")
	elseif prefabname == "rongguang" then --乐园荣光
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/rongguang.xml", "rongguang.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("乐园荣光")
	elseif prefabname == "taidao" then --乐园太刀
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/taidao.xml", "taidao.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("乐园太刀")
	elseif prefabname == "zhenkong" then --乐园真空
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/zhenkong.xml", "zhenkong.tex", "default.tex"))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("乐园真空")
    ---多加物品 复制 514 515 两行 然后修改 prefab名字 和 后面的图片位置。然后在 modinfo里加上 物品的价格表。。
	elseif prefabname == "ly_juanzhou" then --乐园卷轴
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/yyy.xml", "yyy.tex", ""))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("鉴定卷轴")
	elseif prefabname == "ly_fushi01" then --
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/ly_fushi01.xml", "ly_fushi01.tex", ""))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("武器强化石")
	
	elseif prefabname == "ly_qhs-chuanshuo" then --
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/ly_qhs-chuanshuo.xml", "ly_qhs-chuanshuo.tex", ""))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("低级升星石1-4")
	elseif prefabname == "ly_qhs-xingyun" then --
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/ly_qhs-xingyun.xml", "ly_qhs-xingyun.tex", ""))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("高级升星石4-5")
	------------------------------------------------------------------------
	elseif prefabname == "ly_fushi03" then --
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/ly_fushi03.xml", "ly_fushi03.tex", ""))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("五行转换石")
	
	elseif prefabname == "ly_mengpo" then --
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages/ly_mengpo.xml", "ly_mengpo.tex", ""))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("乐园孟婆汤")
	elseif prefabname == "ly_zaolu3x3" then --
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/ly_zaolu3x3.xml", "ly_zaolu3x3.tex", ""))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("乐园造陆3X3")
	elseif prefabname == "ly_zaolu9x9" then --
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/ly_zaolu9x9.xml", "ly_zaolu9x9.tex", ""))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("乐园造陆9X9")
	elseif prefabname == "ly_tianhai3x3" then --
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/ly_tianhai3x3.xml", "ly_tianhai3x3.tex", ""))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("乐园填海3X3")
	elseif prefabname == "ly_tianhai9x9" then --
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/ly_tianhai9x9.xml", "ly_tianhai9x9.tex", ""))
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetHoverText("乐园填海9X9")
    else
	self.goods.goodsbutton[buttonum].goodsitem.image[num] = self.goods.goodsbutton[buttonum].items:AddChild(ImageButton("images/inventoryimages.xml", prefabname .. ".tex", "default.tex"))
	end
	
	local pos = Vector3(spacey * (line - perline/2 - 0.5)+0,spacex * (row - perline/2 - 0.5)+10,0)
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetPosition(pos)
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetScale(0.85,0.85,0.85)
	self.goods.goodsbutton[buttonum].goodsitem.image[num].name = self.goodsinfo[buttonum][num][001]
	self.goods.goodsbutton[buttonum].goodsitem.image[num].price = self.goodsinfo[buttonum][num][002] or 9999
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
--点击按钮			
	self.goods.goodsbutton[buttonum].goodsitem.image[num]:SetOnClick(function()
		if not self.owner:HasTag("playerghost") and self.owner.currenthuajicoin:value()>= self.goods.goodsbutton[buttonum].goodsitem.image[num].price then
		SendModRPCToServer(GetModRPC("Cy_store", "buy"),buttonum,num)
		--延迟用来等待数据刷新
				self.inst:DoTaskInTime(.2, function()
				self:CreatAmount()
				
				end)
		end
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
--介绍翻页函数1


function  Cy_store:jieshaoPageLast()
    if self.fuwuqijieshao.page == 1 then return false end
    
    if self.fuwuqijieshao.page > 1 then self.fuwuqijieshao.page =self.fuwuqijieshao.page - 1 end
    self:CreatInfo()
    self.fuwuqijieshao.pages:SetString("第  "  ..tostring(self.fuwuqijieshao.page) .."  页")
end
--介绍翻页函数2
function  Cy_store:jieshaoPageNext()
    if self.fuwuqijieshao.page ==9 then return false end
    
    if self.fuwuqijieshao.page < 9 then self.fuwuqijieshao.page = self.fuwuqijieshao.page + 1 end
     self:CreatInfo()
	
    self.fuwuqijieshao.pages:SetString("第  "  ..tostring(self.fuwuqijieshao.page) .."  页")
end


--初始化界面
function Cy_store:OnBecomeActive()
	Cy_store._base.OnBecomeActive(self)
	--self.console_edit:SetFocus()
	--self.console_edit:SetEditing(true)

end

--界面关闭
function Cy_store:Close()
self.bg:Hide()
end


return Cy_store