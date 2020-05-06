
GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

modimport"scripts/goodsinfodata.lua"
goodsinfo[1]= GetModConfigData("ziyuan")
goodsinfo[2]= GetModConfigData("fight")
goodsinfo[3]= GetModConfigData("cloth")
goodsinfo[4]= GetModConfigData("shiwu")
goodsinfo[5] = GetModConfigData("ewai")
prizelist= GetModConfigData("prizelist")
shenqilist= GetModConfigData("shenqilist")
weapon= GetModConfigData("weapon")
local containers = require("containers")

PrefabFiles =
{

}

Assets = {

Asset("ATLAS", "images/hud/shophud.xml"),
Asset("IMAGE", "images/hud/shophud.tex"),

}




if  TheNet:GetIsClient()then
	--客机接受指令
	AddModRPCHandler("Cy_store", "buyitem", function () end)
	AddModRPCHandler("Cy_store", "choujiang", function () end)
	
			
		end
		
		--主机接受指令
		if not TheNet:GetIsClient()then
			AddModRPCHandler("Cy_store", "buyitem", function (player,buttonum,num,sum)
			if buttonum and num and type(num) == "number" and type(buttonum) == "number" and buttonum >0 and num>0 then
			   local nunun= math.ceil(num) or 1
			   local buttonumun= math.ceil(buttonum) or 1
			   local sunsd = math.ceil(sum) or 1
			   name=goodsinfo[buttonumun][nunun][1]
			   price=goodsinfo[buttonumun][nunun][2]
				if player.currenthuajicoin:value()>=price*sunsd then
					player.components.Cy_trade:buy(player,name,price,sunsd)
				else
					player.components.talker:Say("好好想一想，不充钱，你怎么可能变强呢")
				end
		         end
			end)
			AddModRPCHandler("Cy_store", "choujiang", function (player)

				
				if weapon	then
					
					local randomnum = math.random()
					if randomnum >= 0.01 and randomnum <= 1 then
						local choujiangfee=666
						local prizenum=math.floor(math.random(1,#prizelist))
						local prizename=prizelist[prizenum][001]
						local prizeamount=prizelist[prizenum][002]
						if player.currenthuajicoin:value()>= choujiangfee then
							player.components.Cy_trade:choujiang(player,choujiangfee,prizename,prizeamount)
						end
					end
					
					if randomnum >= 0 and randomnum < 0.01 then
						local prizenum=math.floor(math.random(1,#shenqilist))
						local prizename=shenqilist[prizenum][001]
						local prizeamount=shenqilist[prizenum][002]
						local id = TheShard:GetShardId()
						TheNet:Announce("恭喜玩家【" .. player:GetDisplayName() .."】在"..id.."世界抽中了☆珍稀物品☆!大家快去围观啊！")
						local choujiangfee=666
						if player.currenthuajicoin:value()>= choujiangfee then
							player.components.Cy_trade:choujiang(player,choujiangfee,prizename,prizeamount)
						end
					end
					
				else
					
					local choujiangfee=666
					local prizenum=math.floor(math.random(1,#prizelist))
					local prizename=prizelist[prizenum][001]
					local prizeamount=prizelist[prizenum][002]
					if player.currenthuajicoin:value()>= choujiangfee then
						player.components.Cy_trade:choujiang(player,choujiangfee,prizename,prizeamount)
					end
					
					
				end
				
			end)


end


AddPlayerPostInit(function (inst)
	inst.currenthuajicoin = net_uint(inst.GUID,"currenthuajicoin")
	if TheWorld.ismastersim then
		inst:AddComponent("Cy_trade")
		inst.components.Cy_trade.hongbaocd=0
		inst:WatchWorldState("startday", function (inst)
			inst.components.Cy_trade.hongbaocd=0
		end)
		inst:WatchWorldState("startcaveday", function (inst)
			inst.components.Cy_trade.hongbaocd=0
		end)
	end
	
	
end)




	
	local ImageButton = require("widgets/imagebutton")

	--商店UI
	local function Addstore2(self)
		self.cy_store = self:AddChild(ImageButton("images/hud/shophud.xml", "shangdian.tex", nil, nil, nil, nil, {1,1}, {0,0}))
		self.cy_store:SetScale(0.6)
		self.cy_store:SetHAnchor(1)
		self.cy_store:SetVAnchor(2)
		self.cy_store:SetPosition(70, 50, 0)
		self.cy_store:SetOnClick(function ()
			TheFrontEnd:PushScreen(require("screens/cy_store")(ThePlayer, goodsinfo, ewai))
		end)
	end
	AddClassPostConstruct("widgets/controls", Addstore2)

------------------------------------------充值部分-----------------------------------------------------
local params = {}

local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab, data, ...)
	local t = params[prefab or container.inst.prefab]
	if t ~= nil then
		for k, v in pairs(t) do
			container[k] = v
		end
		container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
	else
		containers_widgetsetup_base(container, prefab, data, ...)
	end
end
--设置格子的显示信息
local function makechongzhi()
	local container =
	{
	widget =
	{
	slotpos =
	{
	Vector3(0, 64 + 32 + 8 + 4, 0),
	Vector3(0, 32 + 4, 0),
	Vector3(0, -(32 + 4), 0),
	Vector3(0, -(64 + 32 + 8 + 4), 0),
	},
	animbank = "ui_cookpot_1x4",
	animbuild = "ui_cookpot_1x4",
	pos = Vector3(150, 0, 0),
	side_align_tip = 100,
	buttoninfo =
	{
	text = "充值",
	position = Vector3(0, -165, 0),
	}
	},
	type = "chongzhi",
		itemtestfn = function (container, item, slot)
		return item.prefab ~= "nightmare_timepiece"
	end
	}
	
	return container
end
local function makechongzhi2()
	local container =
	{
	widget =
	{
	slotpos =
	{
	Vector3(0,30, 0),
	},
	animbank = "ui_bundle_2x2",
	animbuild = "ui_bundle_2x2",
	pos = Vector3(150, 0, 0),
	side_align_tip = 100,
	buttoninfo =
	{
	text = "充值",
	position = Vector3(0, -60, 0),
	}
	},
	type = "chongzhi",
	itemtestfn = function (container, item, slot)
		return item.prefab ~= "nightmare_timepiece"
	end
	}
	
	return container
end
params.chongzhi = makechongzhi()
params.chongzhi2 = makechongzhi2()
--计算需要计算的格子数目
for k, v in pairs(params) do
	containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
local function chongzhiFn(player, inst)
if inst.prefab=="researchlab2" or  inst.prefab=="nightmare_timepiece" then
	local container = inst.components.container
	local coin=player.components.Cy_trade.huajicoin
	for i = 1, container:GetNumSlots() do
		local item = container:GetItemInSlot(i)
		local stacksize=1
		local itempercent=1
		local sellrate=0.2
		if item then
			if item.components.stackable then
				stacksize = item.components.stackable:StackSize()
			end
			if item.components.armor and  item.components.armor:GetPercent()~=1
				then itempercent =0			
			end
			if item.components.finiteuses and  item.components.finiteuses:GetPercent()~=1
				then itempercent =0		
			end
			if item.prefab=="lucky_goldnugget" then
				player.components.Cy_trade.huajicoin=player.components.Cy_trade.huajicoin+800*stacksize
				container:RemoveItemBySlot(i)
				item:Remove()	
			end
			
			if itempercent ~= 0 then
				local itemprice = 10
				for var=1,#goodsinfo do
					for var2=1,#goodsinfo[var] do
						if item.prefab==goodsinfo[var][var2][1] then
						itemprice= goodsinfo[var][var2][2]							
						end					
					end
				end				
				player.components.Cy_trade.huajicoin=player.components.Cy_trade.huajicoin+itemprice*stacksize*sellrate*itempercent
				container:RemoveItemBySlot(i)
				item:Remove()		
			end
			
		end
	end
	local zengzhi = player.components.Cy_trade.huajicoin-coin
	if coin==player.components.Cy_trade.huajicoin then
		player.components.talker:Say("格子里的物品不能兑换游戏币!")
	else
		player.components.talker:Say("充值成功，获得"..math.ceil(player.components.Cy_trade.huajicoin-coin).."滑稽币")
		
	end
	end
end
function params.chongzhi.widget.buttoninfo.fn(inst)
	if TheWorld.ismastersim then
		chongzhiFn(inst.components.container.opener, inst)
	else
		SendModRPCToServer(MOD_RPC["chongzhi"]["dochongzhi"], inst)
	end
end
function params.chongzhi2.widget.buttoninfo.fn(inst)
	if TheWorld.ismastersim then
		chongzhiFn(inst.components.container.opener, inst)
	else
		SendModRPCToServer(MOD_RPC["chongzhi"]["dochongzhi"], inst)
	end
end
AddModRPCHandler("chongzhi", "dochongzhi", chongzhiFn)

local function confn(inst)
	if TheWorld.ismastersim then
		if not inst.components.container then
			inst:AddComponent("container")
			inst.components.container:WidgetSetup("chongzhi")
			
		end
	else
		inst:DoTaskInTime(0, function ()
			if inst.replica.container then
				inst.replica.container:WidgetSetup("chongzhi")
			end
		end)
	end
end
AddPrefabPostInit("researchlab2",confn)
local function confn2(inst)
	if TheWorld.ismastersim then
		if not inst.components.container then
			inst:AddComponent("container")
			inst.components.container:WidgetSetup("chongzhi2")
			
		end
	else
		inst:DoTaskInTime(0, function ()
			if inst.replica.container then
				inst.replica.container:WidgetSetup("chongzhi2")
			end
		end)
	end
end
AddPrefabPostInit("nightmare_timepiece",confn2)
