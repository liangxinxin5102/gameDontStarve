local function gethuajicoin(self,huajicoin) self.inst.currenthuajicoin:set(huajicoin)end
--这个函数用来取当前的数值

local Cy_trade = Class(function(self, inst)
    self.inst = inst
    self.huajicoin = 1000

end,
nil,
--储存当前的数值为class数据
{
    huajicoin = gethuajicoin,
})

--保存数据
function Cy_trade:OnSave()
    local data = {
        huajicoin = self.huajicoin,	
    }   
    return data
end

--载入
function Cy_trade:OnLoad(data)
    self.huajicoin = data.huajicoin or 1000
end



function Cy_trade:coinDoDelta(value)
    self.huajicoin = self.huajicoin + value
end


--购买函数
function Cy_trade:buy(inst,name,price,buynum)---投币购买效果
 if self.huajicoin >= price*buynum then--判定coin数量
	self:coinDoDelta(-price*buynum)
      local ifitem = SpawnPrefab(name)
		if buynum > 1 and  ifitem.components and  ifitem.components.stackable then
		 local items = SpawnPrefab(name)
		 items.components.stackable:SetStackSize(buynum)
		 inst.components.inventory:GiveItem(items)
		else	
		    for i = 1,buynum do
			 local items = SpawnPrefab(name)
			inst.components.inventory:GiveItem(items)
		   end
		end
       ifitem:Remove()
		
	end
end
--贩卖函数
function Cy_trade:sell(inst,stacksize,sellvalue)---投币购买效果
    if self.huajicoin then
        self:coinDoDelta(stacksize*sellvalue)
    end
end

--抽奖函数
function Cy_trade:choujiang(inst,choujiangfee,prizename,prizeamount) 
			
    if self.huajicoin >=choujiangfee then--判定coin数量
	
	 self:coinDoDelta(-choujiangfee)
	 for var=1,prizeamount or 1 do
	inst.components.inventory:GiveItem(SpawnPrefab(prizename))--购买得到
      end
    end
end



return Cy_trade