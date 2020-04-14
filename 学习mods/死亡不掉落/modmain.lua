local Min_diao = GetModConfigData("mindiaoluo")
local Max_diao = GetModConfigData("maxdiaoluo")
if Max_diao < Min_diao then
	Min_diao = GetModConfigData("maxdiaoluo")
	Max_diao = GetModConfigData("mindiaoluo")
end
AddComponentPostInit("inventory", function(Inventory, inst)
	
	Inventory.oldDropEverythingFn = Inventory.DropEverything

	function Inventory:DropSuiji(ondeath)
		local i = 1
		for k = 1, self.maxslots do
			local v = self.itemslots[math.random(1,self.maxslots)]
			if i > math.random(Min_diao,Max_diao) then return false end
			if v ~= nil then
				self:DropItem(v, true, true)
				i = i + 1 
			end
		end
		if i < 2 then
			for k, v in pairs(self.equipslots) do
				if not v:HasTag("backpack") then
					self:DropItem(v, true, true)
				end
			end
		end
	end

	function Inventory:DropEverything(ondeath, keepequip)
		if not inst:HasTag("player") then
			return Inventory:oldDropEverythingFn(ondeath, keepequip)
		else
			return Inventory:DropSuiji(ondeath)
		end
	end

end)