require "behaviours/wander"
require "behaviours/chaseandattack"
require "behaviours/panic"
require "behaviours/attackwall"
--require "behaviours/minperiod"
require "behaviours/leash"
require "behaviours/faceentity"
--require "behaviours/doaction"
require "behaviours/standstill"

local HoundBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local SEE_DIST = 30

local MIN_FOLLOW_LEADER = 1
local MAX_FOLLOW_LEADER = 6
--local TARGET_FOLLOW_LEADER = (MAX_FOLLOW_LEADER+MIN_FOLLOW_LEADER)/2
local TARGET_FOLLOW_LEADER = 5
local GO_HOME_DIST = 1

local LEASH_RETURN_DIST = 10
local LEASH_MAX_DIST = 40

local SIT_BOY_DIST = 10
--[[
local function EatFoodAction(inst)
    local target = FindEntity(inst, SEE_DIST, function(item) return inst.components.eater:CanEat(item) and item:IsOnValidGround() end)
    if target then
        return BufferedAction(inst, target, ACTIONS.EAT)
    end
end
]]--
local function GetLeader(inst)
    return inst.components.follower and inst.components.follower.leader
end

local function GetStayPos(inst)
	return inst.components.staycommand.locations["stayspot"]
end

local function GetWanderPoint(inst)
	if inst.components.staycommand and inst.components.staycommand:IsCurrentlyStaying() then
		return GetStayPos(inst)
	else
		local target = GetLeader(inst) or GetPlayer()
   		if target then
        		return target:GetPosition()
    		end
	end
end
local function ShouldGoHome(inst)
    local homePos = inst.components.staycommand.locations["stayspot"]
    local myPos = Vector3(inst.Transform:GetWorldPosition() )
    return (homePos and distsq(homePos, myPos) > GO_HOME_DIST*GO_HOME_DIST)
end

local function GoHomeAction(inst)
    local homePos = inst.components.staycommand.locations["stayspot"]
    if homePos then
        return BufferedAction(inst, nil, ACTIONS.SLEEPIN, nil, homePos, nil, 2.2)
    end
end

local function GetHome(inst)
    return inst.components.homeseeker and inst.components.homeseeker.home
end

local function GetHomePos(inst)
    local home = GetHome(inst)
    return home and home:GetPosition()
end

local function GetNoLeaderLeashPos(inst)
    if GetLeader(inst) then
        return nil
    end
    return GetHomePos(inst)
end

local function GetWanderPoint(inst)
    local target = GetLeader(inst) or GetPlayer()

    if target then
        return target:GetPosition()
    end
end

local function ShouldStandStill(inst)
    return inst:HasTag("pet_hound") and not GetClock():IsDay() and not GetLeader(inst) and not inst.components.combat.target and inst:IsNear(GetHome(inst), SIT_BOY_DIST)
end

function HoundBrain:OnStart()
    
    local root = PriorityNode(
    {
        WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst) ),
        WhileNode(function() return not GetLeader(self.inst) end, "NoLeader", AttackWall(self.inst) ),

        Leash(self.inst, GetNoLeaderLeashPos, LEASH_MAX_DIST, LEASH_RETURN_DIST),
--[[
        WhileNode(function() return self.inst:HasTag("pet_hound") end, "Is Pet", ChaseAndAttack(self.inst, 10)),
        WhileNode(function() return not self.inst:HasTag("pet_hound") end, "Not Pet", ChaseAndAttack(self.inst, 100)),
]]--
        
	IfNode(function() 
		if self.inst.components.follower.leader ~= nil and self.inst.components.staycommand and self.inst.components.staycommand:IsCurrentlyStaying() == false then
				self.inst:RemoveTag("remove")
			return true
		elseif self.inst.components.follower.leader ~= nil and not self.inst.components.staycommand then
			return true
		end
		end, "has leader",	
		Follow(self.inst, GetLeader, MIN_FOLLOW_LEADER, TARGET_FOLLOW_LEADER, MAX_FOLLOW_LEADER)),

IfNode(function() 
		
		if self.inst.components.follower.leader ~= nil and self.inst.components.staycommand and self.inst.components.staycommand:IsCurrentlyStaying() == true then
				self.inst:AddTag("remove")

self.inst.components.combat:GiveUp()
			return true
		end
		end, "has leader",	
		WhileNode(function() return ShouldGoHome(self.inst) end, "ShouldGoHome",
            		DoAction(self.inst, GoHomeAction, "Go Home", true ))),  

------------
       SequenceNode{
            ConditionNode(function() return self.inst.components.combat.target ~= nil end, "HasTarget"),
            WaitNode(math.random()*.1),
            ChaseAndAttack(self.inst, 8),
        },

       -- DoAction(self.inst, EatFoodAction, "eat food", true ),
        Follow(self.inst, GetLeader, MIN_FOLLOW_LEADER, TARGET_FOLLOW_LEADER, MAX_FOLLOW_LEADER),
        FaceEntity(self.inst, GetLeader, GetLeader),

        StandStill(self.inst, ShouldStandStill),

        WhileNode(function() return GetHome(self.inst) end, "HasHome", Wander(self.inst, GetHomePos, 8) ),
        Wander(self.inst, GetWanderPoint, 20),
    }, .25)
    
    self.bt = BT(self.inst, root)
    
end

return HoundBrain
