local LeyuanWeapon = Class(function(self, inst)
	self.inst = inst
	self.level = net_ushortint(inst.GUID, "leyuanweapon.level")
	self.maxlevel = net_ushortint(inst.GUID, "leyuanweapon.maxlevel") 
	self.exp = net_ushortint(inst.GUID, "leyuanweapon.exp")
	self.maxexp = net_ushortint(inst.GUID, "leyuanweapon.maxexp") 
end)

function LeyuanWeapon:SetLevel(level)
	self.level:set(level)
end

function LeyuanWeapon:SetMaxLevel(max)
	self.maxlevel:set(max)
end 

function LeyuanWeapon:SetExp(exp)
	self.exp:set(exp)
end 

function LeyuanWeapon:SetMaxExp(max)
	self.maxexp:set(max)
end 

function LeyuanWeapon:GetLevel()
	return self.level:value()
end

function LeyuanWeapon:GetMaxLevel()
	return self.maxlevel:value()
end

function LeyuanWeapon:GetExp()
	return self.exp:value()
end

function LeyuanWeapon:GetMaxExp()
	return self.maxexp:value()
end

function LeyuanWeapon:IsMaxLevel()
	return self:GetLevel() >= self:GetMaxLevel()
end


return LeyuanWeapon