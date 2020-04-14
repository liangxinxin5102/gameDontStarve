local AttackerTracker = Class(function(self, inst)
	self.inst = inst 
	self._UIstr = net_string(inst.GUID,"AttackerTrackerReplica._UIstr")
	
	--self._UIstr:set("")
end)

function AttackerTracker:SetStr(str)
	self._UIstr:set(str)
end 

function AttackerTracker:GetStr()
	return self._UIstr:value() 
end


--print(c_findnext("deerclops").replica.attacker_tracker:GetStr())

return AttackerTracker