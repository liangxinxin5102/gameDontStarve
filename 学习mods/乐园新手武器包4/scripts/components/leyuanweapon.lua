local SourceModifierList = require("util/sourcemodifierlist")

local function onlevel(self, level)
    self.inst.replica.leyuanweapon:SetLevel(level)
end

local function onmaxlevel(self, maxlevel)
    self.inst.replica.leyuanweapon:SetMaxLevel(maxlevel)
end

local function onexp(self,exp)
	self.inst.replica.leyuanweapon:SetExp(exp)
end 

local function onmaxexp(self,maxexp)
	self.inst.replica.leyuanweapon:SetMaxExp(maxexp)
end 

local function OnHitother(inst,data)
	local damageresolved = data.damageresolved or 0
	local gain = damageresolved / 100
	local weapon = inst.components.combat:GetWeapon()
	weapon.components.leyuanweapon:ExpDoDelta(gain)
end 

local function OnEquip(inst,data)
	inst:ListenForEvent("onhitother",OnHitother,data.owner)
end 

local function OnUnequip(inst,data)
	inst:RemoveEventCallback("onhitother",OnHitother,data.owner)
end 

local LeyuanWeapon = Class(function(self, inst)
	self.inst = inst
	self.level = 1
	self.maxlevel = 10
	self.exp = 0
	self.maxexp = 100 
	
	self.startdamage = 0 
	self.deltadamage = 0 
	self.damage_multi = SourceModifierList(self.inst)
	
	inst:ListenForEvent("equipped",OnEquip)
	inst:ListenForEvent("unequipped",OnUnequip)
end,
nil,
{
	level = onlevel,
	maxlevel = onmaxlevel,
	exp = onexp,
	maxexp = onmaxexp,
})

function LeyuanWeapon:IsMaxLevel()
	return self.level >= self.maxlevel
end 

function LeyuanWeapon:SetStartDamage(dmg)
	self.startdamage = dmg
end 

function LeyuanWeapon:SetDeltaDamage(dmg)
	self.deltadamage = dmg 
end 

function LeyuanWeapon:SetExp(val)
	self.exp = val
	self.exp = math.max(self.exp,0)
	while (self.exp >= self.maxexp and not self:IsMaxLevel()) do 
		self.exp = self.exp - self.maxexp 
		self:LevelDoDelta(1) 
	end 
end 

function LeyuanWeapon:ExpDoDelta(delta)
	self:SetExp(self.exp + delta)
end 

function LeyuanWeapon:SetLevel(level)
	local old_level = self.level
	self.level = level
	self.level = math.min(self.level,self.maxlevel)
	self.level = math.max(self.level,0)
	self.maxexp = self.level * 100 
	
	if self.inst.components.weapon then 
		self.inst.components.weapon:SetDamage((self.startdamage + self.deltadamage * (self.level - 1)) * self.damage_multi:Get())
	end
	self.inst:PushEvent("leyuanweapon_levelchange",{oldlevel = old_level,level = self.level})
end 

function LeyuanWeapon:SetMaxLevel(max)
	self.maxlevel = max 
end 

function LeyuanWeapon:LevelDoDelta(val)
	self:SetLevel(self.level + val)
end

function LeyuanWeapon:OnSave()
	return {
		level = self.level,
		exp = self.exp,
	}
end

function LeyuanWeapon:OnLoad(data)
	if data then 
		self:SetLevel(data.level)
		self:SetExp(data.exp)
	end
end

return LeyuanWeapon