
local function onname(self,name)
	if name ~= "" then
		self.inst:AddTag("ballpoked")
	else
		self.inst:RemoveTag("ballpoked")	
	end
	--self.inst._name:set(tostring(name))
end

local function onprefab(self,prefab)
	if  prefab == nil then
		self.inst.AnimState:ClearOverrideSymbol("SWAP_SIGN")
		self.inst.Light:Enable(false)
	else
		self.inst.AnimState:OverrideSymbol("SWAP_SIGN", resolvefilepath("images/hjball.xml"), "poke_"..prefab..".tex")
		self.inst.Light:Enable(true)
	end
end

local Hj_base = Class(function(self, inst)
	self.inst = inst
	self.poke = {}
	self.name = ""
	self.prefab = nil
end,
nil,
{
    name = onname,
	prefab = onprefab,
})


function Hj_base:Ball(target,doer)
	if target and target.components.hj_pokeball ~= nil then
		if target.components.hj_pokeball.poke ~= nil then
			self.name = target.components.hj_pokeball.poke.name
			self.prefab = target.components.hj_pokeball.poke.prefab
			local saved = target:GetSaveRecord()
			table.insert(self.poke, saved)
			target:Remove()
		end
	end
	return true
end


function Hj_base:UnBall(doer)
	if  next(self.poke) ~= nil then 
        for i, v in ipairs(self.poke) do
            local ball = SpawnSaveRecord(v)
			if ball then
				if doer ~= nil and doer.components.inventory ~= nil  then
					doer.components.inventory:GiveItem(ball, nil, self.inst:GetPosition())
				else
					ball.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
					if ball.components.inventoryitem ~= nil then
						ball.components.inventoryitem:OnDropped(true)
					end
				end
			end
        end
		self.poke = {} 
		self.name = ""
		self.prefab = nil
	end
	return true
end

function Hj_base:OnSave()
	if next(self.poke) ~= nil then	
		return {poke = self.poke,name = self.name ,prefab = self.prefab }
	end
end

function Hj_base:OnLoad(data)
	if data and data.poke and data.name and  data.prefab then
		self.poke = data.poke
		self.name = data.name
		self.prefab = data.prefab
	end
end

return Hj_base
