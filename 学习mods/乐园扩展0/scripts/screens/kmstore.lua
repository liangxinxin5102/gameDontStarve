local Screen = require "widgets/screen"
local Widget = require "widgets/widget" 
local Text = require "widgets/text" 
local TextEdit = require "widgets/textedit" 
local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local TextEdit = require "widgets/textedit" 
local TextButton = require "widgets/textbutton"
local FollowText = require "widgets/textfollow"
local ImagePopupDialogScreen = require "screens/imagepopupdialog"
local PopupDialogScreen = require "screens/popupdialog"
local MouseTracker = require "widgets/mousetracker"
local TEMPLATES = require "widgets/templates"
local UIAnim = require "widgets/uianim"
local DEBUG_MODE = BRANCH == "dev"

local function SetFollowText(inst,followtext,str)
    if not inst._oldGainFocus then
        inst._oldGainFocus = inst.OnGainFocus
    end
    if not inst._oldLoseFocus then
        inst._oldLoseFocus = inst.OnLoseFocus
    end
    while type(str) == "table" do 
        str = str[1]
        print ("nametable->",str)
    end
    local setstr = str
    inst.OnGainFocus = function(...) inst._oldGainFocus(...) followtext:SetStr(setstr) followtext:Show() end
    inst.OnLoseFocus = function(...) inst._oldLoseFocus(...) followtext:Hide() end
end
---创建初始界面

local function setgood(button,good)
    if good and good.id then
        local id = good.id
        local price = good.price
        local name = good.name
        --print("set",id,price,name)
        button:SetOnClick(function() SendModRPCToServer(GetModRPC("kmplayer","buy"),id,price,name) print(id,price,name) end)
    else
        button:SetOnClick(nil)
    end
end
local kmstore = Class(Screen ,function(self,owner)
    Screen._ctor(self, "kmstore")
	TheInput:ClearCachedController()
	self.owner = owner
    --self.dialogout = self.out
    self.black = self:AddChild(ImageButton("images/hud/back.xml", "back.tex"))
    self.black.image:SetVRegPoint(ANCHOR_MIDDLE)
    self.black.image:SetHRegPoint(ANCHOR_MIDDLE)
    self.black.image:SetVAnchor(ANCHOR_MIDDLE)
    self.black.image:SetHAnchor(ANCHOR_MIDDLE)
    self.black.image:SetScaleMode(SCALEMODE_FILLSCREEN)
    self.black.image:SetTint(0, 0, 0, .25)
    self.black:SetOnClick(function() self:Close() end)

	self.root = self:AddChild(Widget("ROOT"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)

    self.bg = self.root:AddChild(Image("images/hud/back.xml", "back.tex"))
	self.bg:SetPosition(0, 25)
	self.bg:SetScale(0.8)
    self.type = 1
    self.page = 1
    self:Init()
	
end)

function kmstore:Init()	
    self.follow = self.bg:AddChild(FollowText("标题","介绍"))
    self.follow:Hide()
    
    self.ldmy = self.bg:AddChild(ImageButton("images/hud/item1.xml","item1.tex"))
	self.ldmy:SetPosition(-430, 180, 0)
	self.ldmy:SetOnClick(function() self.type =1 self.page =1 self:getgoods() end)
    
    self.tcdb = self.bg:AddChild(ImageButton("images/hud/item2.xml","item2.tex"))
	self.tcdb:SetPosition(-430, 90, 0)
	self.tcdb:SetOnClick(function() self.type =2 self.page =1 self:getgoods() end)
    
    self.sblq = self.bg:AddChild(ImageButton("images/hud/item3.xml","item3.tex"))
	self.sblq:SetPosition(-430, 0, 0)
	self.sblq:SetOnClick(function() self.type =3 self.page =1 self:getgoods() end)
    
    self.brfs = self.bg:AddChild(ImageButton("images/hud/item4.xml","item4.tex"))
	self.brfs:SetPosition(-430, -90, 0)
	self.brfs:SetOnClick(function() self.type =4 self.page =1 self:getgoods() end)
    
    self.jfhk = self.bg:AddChild(ImageButton("images/hud/item5.xml","item5.tex"))
	self.jfhk:SetPosition(-430, -180, 0)
	self.jfhk:SetOnClick(function() self.type =5 self.page =1 self:getgoods() end)
    
    self.zanzhu = self.bg:AddChild(ImageButton("images/hud/zanzhu.xml","zanzhu.tex"))
	self.zanzhu:SetPosition(220, -140, 0)
	self.zanzhu:SetOnClick(function() VisitURL("https://www.kuaifaka.com/purchasing?link=3MUpV4", false) end)
    self.huishou = self.bg:AddChild(ImageButton("images/hud/huishou.xml","huishou.tex"))
	self.huishou:SetPosition(420, -140, 0)
	self.huishou:SetOnClick(function()
		TheFrontEnd:PushScreen(
			PopupDialogScreen("饥荒乐园の豪华商城", "确认后将会把身上 ( 包括背包内 ) 的所有有价值的道具回购成【乐园钻石】",
			{
				{	text = STRINGS.UI.POPUPDIALOG.OK, cb = function()
					SendModRPCToServer(MOD_RPC.QMRPC.JHJ, "HUIGOU")
					TheFrontEnd:PopScreen()
				end },
				{	text = STRINGS.UI.PURCHASEPACKSCREEN.PURCHASE_CLOSE, cb = function() TheFrontEnd:PopScreen() end },
			}
			)
		)
	end)
    
    self.hupeng = self.bg:AddChild(ImageButton("images/hud/hupenghuanyou.xml","hupenghuanyou.tex"))
	self.hupeng:SetPosition(315, -140, 0)
	self.hupeng:SetOnClick(function()
		VisitURL("https://jq.qq.com/?_wv=1027&k=54jU3ul", false)
	end)
	
    self.tile = self.bg:AddChild(Image("images/hud/tile.xml","tile.tex"))
	self.tile:SetPosition(-40, 230, 0)
    
    self.tiletext = self.bg:AddChild(Text(NEWFONT, 50))
	self.tiletext:SetPosition(-200, 230, 0)
    self.tiletext:SetColour(0 / 255,0 / 255, 0 / 255, 1)
    self.tiletext:SetString("饥荒乐园の豪华商城")
    
    self.hj = self.bg:AddChild(ImageButton("images/hud/hj.xml","hj.tex"))
	self.hj:SetPosition(-20, 233, 0)
    SetFollowText(self.hj,self.follow,"乐园钻石\n杀人放火居家旅行必备资源\n如需充值请点击下方我要赞助")
    
    self.hjb = self.bg:AddChild(Text(NEWFONT_OUTLINE,35,"0"))
	self.hjb:SetPosition(80, 233, 0)
    self.hjb:SetColour(0,1,1,1)
    SetFollowText(self.hjb,self.follow,"乐园钻石\n杀人放火居家旅行必备资源\n如需充值请点击下方我要赞助")
    
    self.jf = self.bg:AddChild(ImageButton("images/hud/jf.xml","jf.tex"))
	self.jf:SetPosition(150, 233, 0)
    SetFollowText(self.jf,self.follow,"乐园积分\n给广大消费者的豪华回馈\n消费乐园钻石后可获得积分")
    
    self.jfb = self.bg:AddChild(Text(NEWFONT_OUTLINE,35,"0"))
	self.jfb:SetPosition(230, 233, 0)
    self.jfb:SetColour(0,1,1,1)
    SetFollowText(self.jfb,self.follow,"乐园积分\n给广大消费者的豪华回馈\n消费乐园钻石后可获得积分")
    
    
    self.tj = self.bg:AddChild(Image("images/hud/tuijian.xml","tuijian.tex"))
	self.tj:SetPosition(310, 40, 0)
    
    self.mrb = self.bg:AddChild(ImageButton("images/hud/mingrenbang.xml","mingrenbang.tex"))
	self.mrb:SetPosition(400, 230, 0)
	self.mrb:SetOnClick(function() self:out("开发中") end)
    
    self.kmbg = self.bg:AddChild(Image("images/hud/km.xml","km.tex"))
	self.kmbg:SetPosition(320, -190, 0)
    
    self.kmtext = self.bg:AddChild(TextEdit(UIFONT, 20))
	self.kmtext:SetPosition(280, -190, 0)
    self.kmtext:SetColour(255 / 255,255 / 255, 0 / 255, 1)
    self.kmtext:SetString("请输入卡密")
    self.kmtext:EnableRegionSizeLimit(true)
    self.kmtext:SetForceEdit(true)
    self.kmtext:SetAllowNewline(false)
    self.kmtext:SetForceUpperCase(true)
    self.kmtext.edit_text_color = {1, 0, 1, 1}
    self.kmtext.idle_text_color = {1, 1, 0, 1}
    self.kmtext:SetEditCursorColour(0, 1, 1, 1)
    self.kmtext:SetTextLengthLimit(35)
    SetFollowText(self.kmtext,self.follow,"请输入CDK")
    self.kmtextoldOnControl = self.kmtext.OnControl

    self.kmtext.OnControl = function(...) if self.kmtext:GetString() == "请输入卡密" then self.kmtext:SetString("")  end  return self.kmtextoldOnControl(...) end

    self.kmqr = self.bg:AddChild(ImageButton("images/hud/queren.xml","queren.tex"))
	self.kmqr:SetPosition(430, -188, 0)
    self.kmqr:SetOnClick(function()  SendModRPCToServer(GetModRPC("kmplayer", "kmcz"),self.kmtext:GetString())  end)
    
    self.goods = {}
    for x =1,6,1 do 
        self.goods[x] = {}
        for y = 1,4,1 do 
            self.goods[x][y] = {
            back = self.bg:AddChild(Image("images/hud/itemback.xml","itemback.tex")),  
            priceicon = self.bg:AddChild(Image("images/hud/jf.xml","jf.tex")),
            price = self.bg:AddChild(Text(NEWFONT_OUTLINE,25,"50000")),
            button = self.bg:AddChild(ImageButton("images/inventoryimages.xml","ice.tex")),
            }
            self.goods[x][y].back:SetPosition(-420+80*x, 240 - 95*y, 0)
            self.goods[x][y].priceicon:SetPosition(-445+80*x, 195 - 95*y, 0)
            self.goods[x][y].priceicon:SetScale(0.5,0.5)
            self.goods[x][y].price:SetPosition(-410+80*x, 195 - 95*y, 0)
            self.goods[x][y].price:SetColour(0,0,0,1)
            self.goods[x][y].button:SetPosition(-420+80*x, 240 - 95*y, 0)
            self.goods[x][y].priceicon:Hide()
            self.goods[x][y].price:Hide()
            self.goods[x][y].button:Hide()
        end
    end
    self.tjgoods = {}
    for x =1,2,1 do 
        self.tjgoods[x] = {}
        for y = 1,2,1 do 
            self.tjgoods[x][y] = {
            back = self.bg:AddChild(Image("images/hud/itemback.xml","itemback.tex")),  
            priceicon = self.bg:AddChild(Image("images/hud/hj.xml","hj.tex")),
            price = self.bg:AddChild(Text(NEWFONT_OUTLINE,25,"50000")),
            button = self.bg:AddChild(ImageButton("images/inventoryimages.xml","ice.tex")),
            }
            self.tjgoods[x][y].back:SetPosition(195+75*x, 190 - 90*y, 0)
            self.tjgoods[x][y].priceicon:SetPosition(170+75*x, 145 - 90*y, 0)
            self.tjgoods[x][y].priceicon:SetScale(0.5,0.5)
            self.tjgoods[x][y].price:SetPosition(205+75*x,145 - 90*y, 0)
            self.tjgoods[x][y].price:SetColour(0,0,0,1)
            self.tjgoods[x][y].button:SetPosition(195+75*x, 200 - 95*y, 0)
            self.tjgoods[x][y].priceicon:Hide()
            self.tjgoods[x][y].price:Hide()
            self.tjgoods[x][y].button:Hide()
        end      
    end
    
    self.nextbutton = self.bg:AddChild(ImageButton("images/hud/next.xml","next.tex"))
    self.nextbutton:SetPosition(40, -225, 0)
    self.nextbutton:SetOnClick(function()  self.page = self.page + 1 self:getgoods()  end)
    
    self.lastbutton = self.bg:AddChild(ImageButton("images/hud/last.xml","last.tex"))
    self.lastbutton:SetPosition(-320, -225, 0)
    self.lastbutton:SetOnClick(function()  self.page = self.page - 1 self:getgoods()   end)

    self:gethj()
    self:getgoods()
    self.follow:MoveToFront()
end

--刷新金钱显示
function kmstore:gethj()
    if self.owner.GUID ~= ThePlayer.GUID then return end
    self.hjb:SetString(self.owner.km.ye:value())
    self.jfb:SetString(self.owner.km.jf:value())
end
function kmstore:out(str,target)
     if target and target.GUID ~= ThePlayer.GUID then return end
     TheFrontEnd:PushScreen(PopupDialogScreen("饥荒乐园の豪华商城",str,{{text=STRINGS.UI.POPUPDIALOG.OK,cb = function() TheFrontEnd:PopScreen() end }}))
end

local imagecache = {}
local repl = {

}
    -- shenqi = "zg_we_blacknight",
    -- xxsq ="xxsq_2",
    -- lycoin ="ly_zcm003",
local notimagecache = {}
local function getimage(na)
    local name = repl[na] or na
    local t = name..".tex"
    if notimagecache[name] then
        return "images/inventoryimages.xml","log.tex"
    end
    if imagecache[name] then
        return imagecache[name],t
    end
    if TheSim:AtlasContains("images/inventoryimages.xml", t) then
        imagecache[name] = "images/inventoryimages.xml"
        return "images/inventoryimages.xml",t
    elseif TheSim:AtlasContains("images/inventoryimages1.xml", t) then
        imagecache[name] = "images/inventoryimages1.xml"
        return "images/inventoryimages1.xml",t
    elseif TheSim:AtlasContains("images/inventoryimages2.xml", t) then
        imagecache[name] = "images/inventoryimages2.xml"
        return "images/inventoryimages2.xml",t
	elseif TheSim:AtlasContains(softresolvefilepath("images/qm_pifuka.xml"), t) then
        imagecache[name] = "images/qm_pifuka.xml"
        return "images/qm_pifuka.xml",t

    else
        local trueatlas = softresolvefilepath("images/inventoryimages/"..name..".xml")
        if trueatlas and TheSim:AtlasContains(trueatlas, t) then
  
            imagecache[name] = "images/inventoryimages/"..name..".xml"
            return "images/inventoryimages/"..name..".xml",t
        end
        
        trueatlas = softresolvefilepath("images/"..name..".xml")
        if trueatlas and TheSim:AtlasContains(trueatlas, t) then
  
            imagecache[name] = "images/"..name..".xml"
            return "images/"..name..".xml",t
        end
        print("notimagecache -> "..name)
        notimagecache[name] = name
    return "images/inventoryimages.xml","log.tex"
    end
end
--刷新商品显示	
function kmstore:getgoods()
    if not self.owner.replica.kmplayer then
        self:out("正在同步数据\n请稍后再试")
        return
    end
    if #self.owner.replica.kmplayer.goods < 1 then
        self:out("同步数据中\n请稍后再试")
        return
    end
    if self.owner.km.zye:value() < 1000 then
        self.hupeng:Hide()
    else    
        self.hupeng:Show()
    end
    --清空原有的
    for x =1,6,1 do 
        for y = 1,4,1 do 
            self.goods[x][y].priceicon:Hide()
            self.goods[x][y].price:Hide()
            self.goods[x][y].button:Hide()
            setgood(self.goods[x][y].button)
        end      
    end
    
    for x =1,2,1 do 
        for y = 1,2,1 do 
            self.tjgoods[x][y].priceicon:Hide()
            self.tjgoods[x][y].price:Hide()
            self.tjgoods[x][y].button:Hide()
            setgood(self.tjgoods[x][y].button)
        end      
    end
    --刷新 repl 
    if #repl < 1 then
        repl = self.owner.replica.kmplayer.repl
    end
    --解析新的
    local goods = {}
    self.type = math.min(math.max(self.type,1),5)
    
    for k,v in ipairs(self.owner.replica.kmplayer.goods) do 
        if v.type == self.type then
            table.insert(goods,v)
        end
    end
    self.page = math.max(math.min(self.page,math.ceil(#goods/24)),1)
    local n = 24
    if self.page*24 >= #goods then
        n = #goods - self.page*24 +24
    end
    for i=1,n,1 do
		
        local n1 = i -1
		local n2 = n1+1+self.page *24 -24
        local y,x = math.floor(n1/6),n1 % 6
        x = math.min(x+1,6)
        y = math.min(y+1,4)
        local good = self.goods[x][y]
        if self.type == 5 then
            good.priceicon:SetTexture("images/hud/jf.xml","jf.tex")
        else
            good.priceicon:SetTexture("images/hud/hj.xml","hj.tex")
        end
        good.priceicon:Show()
        good.price:SetString(goods[n2].price)
        good.price:Show()
        local atlas,tex = getimage(goods[n2].name)
        good.button:SetTextures(atlas,tex)
        good.button:Show()
        --good.button._good['id'] = goods[i].id
        --good.button._good['price'] = goods[i].price
        --good.button._good['name'] = goods[i].name
        --good.button:SetOnClick(function(inst) SendModRPCToServer(GetModRPC("kmplayer","buy"),inst._good.id,inst._good.price,inst._good.name)  end)
        setgood(good.button,goods[n2])
        local des = goods[n2].des
        if des == "n" then
            des = STRINGS.RECIPE_DESC[string.upper(goods[n2].name)] or STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper(goods[n2].name)]  or "腐竹很懒，没有留下任何描述" 
        end
        SetFollowText(good.button,self.follow,des)
        
    end
    
    --随机抽取推荐商品
    local tjgoods = {}
    local tj = {}
    for k,v in ipairs(self.owner.replica.kmplayer.goods) do 
        if v.type == 6 then
            table.insert(tjgoods,v)
        end
    end
    if #tjgoods > 4 then
        while #tj < 4 do
            local tjthis = tjgoods[math.random(1,#tjgoods)]
            local findthis = false
            for k,v in ipairs(tj) do 
                if v.id ==  tjthis.id then
                    findthis = true
                end
            end
            if not findthis then
                table.insert(tj,tjthis)
            end
        end
    else
        tj = tjgoods
    end
    n = #tj
    for i=1,n,1 do
        local n1 = i -1 
        local y,x = math.floor(n1/2),n1 % 2
        x = math.min(x+1,2)
        y = math.min(y+1,2)
        local good = self.tjgoods[x][y]
        good.priceicon:SetTexture("images/hud/hj.xml","hj.tex")
        good.priceicon:Show()
        good.price:SetString(tj[i].price)
        good.price:Show()
        local atlas,tex = getimage(tj[i].name)
        good.button:SetTextures(atlas,tex)
        good.button:Show()
        --good.button._good['id'] = tj[i].id
        --good.button._good['price'] = tj[i].price
        --good.button._good['name'] = tj[i].name
        --good.button:SetOnClick(function(inst) SendModRPCToServer(GetModRPC("kmplayer","buy"),inst._good.id,inst._good.price,inst._good.name)  end)
        setgood(good.button,tj[i])
        local des = tj[i].des
        if des == "n" then
            des = STRINGS.RECIPE_DESC[string.upper(tj[i].name)] or STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper(tj[i].name)]  or "腐竹很懒，没有留下任何描述" 
        end
        SetFollowText(good.button,self.follow,des)
    end
end

--初始化界面
function kmstore:OnBecomeActive()
	kmstore._base.OnBecomeActive(self)
	--self.console_edit:SetFocus()
	--self.console_edit:SetEditing(true)

end


--界面关闭
function kmstore:Close()
	scheduler:ExecuteInTime(0, function() 
		for k,v in pairs(self.root:GetChildren()) do
			if k ~= self.bg then
				k:Hide()
			end
		end	
	end)
	self.black:Hide()
	self.bg:Hide()
	--self.console_edit:SetString("")
	TheFrontEnd:PopScreen(self)
	
end



return kmstore