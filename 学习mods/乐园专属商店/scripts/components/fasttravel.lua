local default_dist_cost = 32
local max_sanity_cost = 15
local min_hunger_cost = 5
local sanity_cost_ratio = 20/75
local find_dist = (max_sanity_cost / sanity_cost_ratio - min_hunger_cost) * default_dist_cost

local ownershiptag = 'uid_private'
local traveltag = 'FastTravelling'
local FTSignTag = 'fast_travel'

local FastTravel = Class(function(self, inst)
    self.inst = inst
	self.destinations = {}
	self.site = nil
	self.totalsites = 0
	self.currentplayer = nil
	self.traveltask = nil
	self.dist_cost = default_dist_cost
	self.inst:AddTag(FTSignTag)
	self.ownership = false
	self.time = 1
	self.xf =0
	self.yf =0
	self.zf =0
end)
function FastTravel:ListDestination(traveller)
	local x, y, z = self.inst.Transform:GetWorldPosition()
	local dests = TheSim:FindEntities(x, y, z, find_dist, FTSignTag)
	local dest = {}
	
	for k,v in pairs(dests) do
		if v ~= self.inst and v.components.fasttravel and not (v.components.fasttravel.ownership and v:HasTag(ownershiptag) and traveller.userid ~= nil and not v:HasTag('uid_'..traveller.userid)) then
			table.insert(dest, v)
		end
	end
	
	self.destinations = dest
	self.site = self.site or #dest
	self.totalsites = #dest
end
function FastTravel:SelectDestination(traveller)

	if traveller == nil then return	end
	self:ListDestination(traveller)
	local comment = self.inst.components.talker
	local talk = traveller.components.talker
	local destination = self.destinations[self.time]
	local desc = destination and destination.components.writeable and destination.components.writeable:GetText()
	self.inst:AddTag("keyichuansong")
	if not desc then self.inst:RemoveTag("keyichuansong")
	comment:Say("不存在能到达的目的地",4) 
	return
	end
	comment:Say("目的地调整为"..desc.."\n如果确定目的地请投入1个元宝",4) 
	
	self.xf,self.yf,self.zf = destination.Transform:GetWorldPosition()
	self.inst:ForceFacePoint(self.xf,0,self.zf) 
	
	if self.time < self.totalsites then
	self.time= self.time+1 
	else self.time =1 end
return FastTravel
end
return FastTravel