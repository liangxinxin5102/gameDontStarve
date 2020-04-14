


local function gethuajicoin(self,huajicoin) self.inst.currenthuajicoin:set(huajicoin)end
--这个函数用来取当前的数值

local Cy_trade = Class(function(self, inst)
    self.inst = inst
    self.huajicoin = 1
	self.chenghaoStr = "   "
	self.chenghaoColor = 1

	

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
		chenghaoStr = self.chenghaoStr,
		chenghaoColor = self.chenghaoColor,
		
    }   
    return data
end

--载入
function Cy_trade:OnLoad(data)
    self.huajicoin = data.huajicoin or 1000
	self.chenghaoStr = data.chenghaoStr or "322"
	self.chenghaoColor = data.chenghaoColor or 1
	
end



function Cy_trade:coinDoDelta(value)
    self.huajicoin = self.huajicoin + value
end


--购买函数
function Cy_trade:buy(inst,name,price)---投币购买效果
    if self.huajicoin >= price then--判定coin数量
	self:coinDoDelta(-price)
	local item = SpawnPrefab(name)
	if item then
	inst.components.inventory:GiveItem(item)--购买得到
    end
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
	
	self.inst.SoundEmitter:PlaySound("dontstarve/HUD/research_available")--抽奖音效-------------------------------------------------------------------------------------
	
	 self:coinDoDelta(-choujiangfee)	
	 for var=1,prizeamount or 1 do
	inst.components.inventory:GiveItem(SpawnPrefab(prizename))--购买得到
      end

    end
end
--称号
function Cy_trade:chenghao(inst,chenghaofee)

    if self.huajicoin >= chenghaofee then--判定coin数量
	self.inst.SoundEmitter:PlaySound("cycycy/cycycy/cycycy")
	self:coinDoDelta(-chenghaofee)
    end
end


--预运行
function Cy_trade:Init(inst)
    inst:DoTaskInTime(.1, function()      
    end)
end



return Cy_trade