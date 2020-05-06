
local StayCommand = Class(function(self, inst)
    	self.inst = inst
	self.stay = false
	self.locations = {}
end)
function StayCommand:CollectSceneActions(doer, actions, rightclick)
	if rightclick and self.inst.components.follower and self.inst.components.follower.leader == GetPlayer() then
		if not self.inst.components.staycommand:IsCurrentlyStaying() then
			table.insert(actions, ACTIONS.STAYORDER)
		else
			table.insert(actions, ACTIONS.STAYORDER_CANCEL)
		end
	end
end

function StayCommand:IsCurrentlyStaying()
	return self.stay
end

function StayCommand:SetStaying(stay)
	self.stay = stay
	end

function StayCommand:RememberStayPos(name, pos)
    self.locations[name] = pos
end

function StayCommand:OnSave()
	if self.stay == true then
	local data = 
			{ 
		stay = self.stay,
			varx = self.locations.stayspot["x"], 
				vary = self.locations.stayspot["y"], 
				varz = self.locations.stayspot["z"]
			}
		return data
	end
end   
   
function StayCommand:OnLoad(data)

if data then 
	self.stay = data.stay
	self.locations.stayspot = { }
		self.locations.stayspot["x"] = data.varx
		self.locations.stayspot["y"] = data.vary
		self.locations.stayspot["z"] = data.varz
	end
end
  
return StayCommand


