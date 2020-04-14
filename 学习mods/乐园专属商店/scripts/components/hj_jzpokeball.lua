local function onname(self,name)
	if name ~= nil then
		self.inst._name:set(tostring(name))
		self.inst:AddTag("poked")
	end
end

local function get_name(target)
	local name = target:GetDisplayName() or (target.components.named and target.components.named.name)
	if not name or name == "MISSING NAME" then return end
	local adj = target:GetAdjective()
	if adj then
		name = adj.." "..name
	end
	return name
end

local Hj_jzpokeball = Class(function(self, inst)
	self.inst = inst
	self.packfn = nil
	self.poke = nil
	self.name = nil
end,
nil,
{
    name = onname,
})

function Hj_jzpokeball:Haspoke()
	return self.poke ~= nil
end

function Hj_jzpokeball:CanPock(target)
	return self.inst:IsValid()
		and not self:Haspoke()
		and target:IsValid()
end

function Hj_jzpokeball:Pock(target,doer)
	if self:CanPock(target) then
		local fx = SpawnPrefab("collapse_small")
		fx.Transform:SetPosition(target.Transform:GetWorldPosition())
		self.poke = {
			prefab = target.prefab,
			name = get_name(target),
			skinname  = target.skinname or nil,
			skin_id = target.skin_id or nil,
		}
		self.poke.data, self.poke.refs = target:GetPersistData()
		self.name = get_name(target)
		target:Remove()
		if self.packfn ~= nil then
			self.packfn(self.inst,doer)
		end
		return true
	end
end

function Hj_jzpokeball:GetName()
	return self.name
end

function Hj_jzpokeball:Unpock(x,y,z)
	if  self.poke then 
	local target = SpawnPrefab(self.poke.prefab,self.poke.skinname, self.poke.skin_id)
	if target then
		target.Transform:SetPosition( x,0,z )
		local fx = SpawnPrefab("collapse_small")
		fx.Transform:SetPosition(x,0,z)
		
		if target.components.childspawner ~= nil or target.components.spawner ~= nil then
			return
		end
		if target.prefab == "scarecrow" then
			return
		end		
		local newents = {}
		if self.poke.refs then
			for _, guid in ipairs(self.poke.refs) do
				newents[guid] = {entity = _G.Ents[guid]}
			end
		end
		if target.components.leader then
		target.components.leader.LoadPostPass= function(newents, savedata)
			if self.inst:HasTag("player") then
				return
			end
			if savedata ~= nil and savedata.followers ~= nil then
				for k,v in pairs(savedata.followers) do
					local targ = newents[v]
					if targ ~= nil and targ:IsValid() and targ.entity and targ.entity.components.follower ~= nil then
						self:AddFollower(targ.entity)
					end
				end
			end
		end
		end
		target:SetPersistData(self.poke.data, newents)
		target:LoadPostPass(newents, self.poke.data)
		target.Transform:SetPosition(x,0,z)
		self.inst:Remove()
		return true
	end
	end
end

function Hj_jzpokeball:OnSave()
	if self.poke then
		return {poke = self.poke}, self.poke.refs
	end
end

function Hj_jzpokeball:OnLoad(data)
	if data and data.poke then
		self.poke = data.poke
		self.name = self.poke.name
	end
end

return Hj_jzpokeball
