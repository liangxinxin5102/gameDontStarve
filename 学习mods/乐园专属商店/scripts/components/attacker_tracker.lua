
local DEBUG = false --DEBUG开关
local LyTools = require("tools/ly_tools") 

--生物受到玩家攻击时
local function OnAttacked(inst,data)
	local self = inst.components.attacker_tracker
	local attacker = data.attacker
	local damageresolved = data.damageresolved
	if self and attacker:HasTag("player") then 
		self:AddAttacker(attacker,damageresolved)--计入attacker
		self:Debug() 
	end
end 

local function onUIstr(self,UIstr)
	self.inst.replica.attacker_tracker:SetStr(UIstr)
end 

local AttackerTracker = Class(function(self, inst)
	self.inst = inst 
	self.attackers = {}--记录的attacker存放与此
	self.UIstr = self:GetDebugString()
	
	self.inst:ListenForEvent("attacked",OnAttacked)
end,
nil,
{
	UIstr = onUIstr,
})

--通过一个玩家的userid找到玩家实体
function AttackerTracker:FindAttackerInMap(userid)
	for k,v in pairs(AllPlayers) do 
		if v and v:IsValid() and v.userid == userid  then 
			return v 
		end
	end
end 

--通过一个玩家实体找到在本组件中对应的位置
function AttackerTracker:FindAttackerInList(attacker)
	for k,v in pairs(self.attackers) do 
		if v.userid == attacker.userid then 
			return k,v
		end
	end
end 

function AttackerTracker:FindAttackerInListByUserid(userid)
	for k,v in pairs(self.attackers) do 
		if v.userid == userid then 
			return k,v
		end
	end
end 

function AttackerTracker:AddAttacker(attacker,damage)
	damage = damage or 0
	local num,attackerlist = self:FindAttackerInList(attacker)
	if num and attackerlist then 
		self.attackers[num].damage = self.attackers[num].damage + damage
		self.attackers[num].name = attacker.name
	else
		table.insert(self.attackers,{name = attacker.name,userid = attacker.userid,damage = damage})
	end
	self:SetStr()
end 

function AttackerTracker:RemoveAttacker(attacker)
	local num,attackerlist = self:FindAttackerInList(attacker)
	if num and attackerlist then 
		table.remove(self.attackers,num)
	end
	self:Debug()
	self:SetStr()
end 

function AttackerTracker:CalcPercent(attacker)
	local num,attackerlist = self:FindAttackerInList(attacker)
	if not num or not attackerlist then 
		return  
	end 
	
	local all_damage = 0
	for k,v in pairs(self.attackers) do 
		all_damage = all_damage + v.damage
	end
	
	if all_damage <= 0 then 
		return 
	else
		local attacker_damage = attackerlist.damage
		return attackerlist.damage / all_damage
	end
end 

function AttackerTracker:MakeValid()
	LyTools.RemoveItemInTable(self.attackers,function(list,k,v)
		local entity = self:FindAttackerInMap(v.userid)
		return not (entity and entity:IsValid()) 
	end)
	self:Debug()
	self:SetStr()
end 

--我懒的考虑保存的问题，你来打我呀
--[[function AttackerTracker:OnSave()
	return {
		attackers = self.attackers 
	}
end

function AttackerTracker:OnLoad(data)
	if data then 
		self.attackers = data.attackers
	end 
end--]]


function AttackerTracker:Debug()
	if DEBUG   then 
		print(self:GetDebugString())
	end 
end 

function AttackerTracker:SetStr()
	self.UIstr = self:GetDebugString()
end 

function AttackerTracker:GetDebugString()
	local debugstring = string.format("敌人: %s (%s)\n",tostring(self.inst.name),tostring(self.inst))
	local all_damage = 0
	
	for k,v in pairs(self.attackers) do 
		all_damage = all_damage + v.damage
	end
	
	for k,v in pairs(self.attackers) do 
		local playerstring = string.format("名字:%s 伤害:%.1f 比重:%.1f%% \n",v.name,v.damage,v.damage * 100 / all_damage)
		debugstring = debugstring..playerstring
	end 
	
	--print(debugstring)
	return debugstring
end

--c_spawn("deerclops"):AddComponent("attacker_tracker")
--c_findnext("deerclops").components.attacker_tracker:MakeValid()
--c_findnext("deerclops").components.combat:GetAttacked(c_spawn("wilson"),2000)
return AttackerTracker