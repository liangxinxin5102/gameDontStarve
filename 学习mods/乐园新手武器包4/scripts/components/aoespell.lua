-- Unofficial AOESpell component
local AOESpell = Class(function(self, inst)
	self.inst     = inst
--	self.beginfn = nil 
	self.oncastfn = nil
	self.projectile = nil
	self.lianshe = false
	
	self.getdescription = nil 
end)

function AOESpell:SetDescription(fn)
	self.getdescription = fn 
end 

function AOESpell:GetDescription(viewer)
	return self.getdescription and self.getdescription(self.inst,viewer)
end 

function AOESpell:CanCast(doer, pos)
	return true
end

function AOESpell:SetOnCastFn(fn)
	self.oncastfn = fn
end

--[[function AOESpell:SetBeginFn(fn)
	self.oncastfn = fn
end
--]]
function AOESpell:CastSpell(doer, pos)
	if self.oncastfn ~= nil then
		if (self.inst.components.rechargeable ~= nil and self.inst.components.rechargeable:GetPercent() > 0.95) or (self.inst.components.rechargeable == nil) then
			self.oncastfn(self.inst, doer, pos)
			if self.inst.components.rechargeable:GetPercent() <= 0 then 
				self.inst.components.aoetargeting:SetEnabled(false)
			end 
		end
	end
--[[	if self.projectile ~= nil then 
		if self.lianshe	 then 
			local delay = 0.0
			for i = 1, 2 do
			self.inst:DoTaskInTime(delay, function()
			local projx = SpawnPrefab(self.projectile)
				if projx and projx.components.aoe_projectile then
					local x, y, z = doer.Transform:GetWorldPosition()
					projx.Transform:SetPosition(x, y+(self.heightoffset or 0), z)
					projx.components.aoe_projectile:Throw(doer, pos)
				end			
			end)
					delay = delay + 8*FRAMES
			end
		else
			local proj = SpawnPrefab(self.projectile)
			if proj and proj.components.aoe_projectile then
				local x, y, z = doer.Transform:GetWorldPosition()
				proj.Transform:SetPosition(x, y+(self.heightoffset or 0), z)
				proj.components.aoe_projectile:Throw(doer, pos)
			end
	    end
    end--]]
	--[[if self.inst.components.rechargeable ~= nil and self.inst.components.rechargeable:GetPercent() > 0.95 then
		self.inst.components.rechargeable:Reset()
	end--]]
end

return AOESpell