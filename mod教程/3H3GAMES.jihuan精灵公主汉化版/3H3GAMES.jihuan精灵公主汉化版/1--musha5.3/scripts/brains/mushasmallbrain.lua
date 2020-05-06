require "behaviours/chaseandattack"
require "behaviours/wander"
require "behaviours/faceentity"
require "behaviours/follow"
require "behaviours/standstill"
require "behaviours/leash"
require "behaviours/panic"
require "behaviours/runaway"
require "behaviours/doaction"

local MIN_FOLLOW_DIST = 1
local MAX_FOLLOW_DIST = 9
--local TARGET_FOLLOW_DIST = (MAX_FOLLOW_DIST+MIN_FOLLOW_DIST)/2
local TARGET_FOLLOW_DIST = 2
local GO_HOME_DIST = 1

----
local MIN_FOLLOW_LEADER = 1
local MAX_FOLLOW_LEADER = 6
--local TARGET_FOLLOW_LEADER = (MAX_FOLLOW_LEADER+MIN_FOLLOW_LEADER)/2
local TARGET_FOLLOW_LEADER = 2
local LEASH_RETURN_DIST = 3.5
local LEASH_MAX_DIST = 5
----
local SEE_ENEMY_DIST = 4
----

local MAX_CHASE_TIME = 30

local TRADE_DIST = 20

local MAX_WANDER_DIST = 15

local SEE_FOOD_DIST = 15
local FIND_FOOD_HUNGER_PERCENT = 0.5 
--local MAX_WANDER_DIST = 20
--local MAX_CHASE_DIST = 30

local START_RUN_DIST = 4
local STOP_RUN_DIST = 6

local function IsHungry(inst)
    return inst.components.hunger and inst.components.hunger:GetPercent() < FIND_FOOD_HUNGER_PERCENT
end

local function IsStarving(inst)
    return inst.components.hunger and inst.components.hunger:IsStarving()

end
local function ShouldStandStill(inst)
    return inst.components.hunger and inst.components.hunger:IsStarving() and inst:HasTag("never")


end
local function CanStandStill(inst)
    return inst.components.hunger and inst.components.hunger:IsStarving() and inst:HasTag("animal") and inst:HasTag("never")
end
local function CanSeeFood(inst)
    local target = FindEntity(inst, SEE_FOOD_DIST, function(item) return inst.components.eater:CanEat(item) end)
    if target then
        --print("CanSeeFood", inst.name, target.name)
    end
    return target
end

local function FindFoodAction(inst)
    local target = CanSeeFood(inst)
    if target then
        return BufferedAction(inst, target, ACTIONS.EAT)
    end
end

local function GetTraderFn(inst)
    return (inst.components.follower.leader and inst.components.trader:IsTryingToTradeWithMe(inst.components.follower.leader)) and inst.components.follower.leader or nil
end

local function KeepTraderFn(inst, target)
    return inst.components.trader:IsTryingToTradeWithMe(target)
end

--[[
]]--
local function ShouldRunAway(inst, target)
    return inst:HasTag("animal") and not inst.components.trader:IsTryingToTradeWithMe(target)
end

local function BabyRunAway(inst, target)
    return inst:HasTag("level1") and not inst:HasTag("animal") and not inst.components.trader:IsTryingToTradeWithMe(target)
end

local function ShouldStopCommand(inst, target)
    return inst:HasTag("animal") 
end

local mushasmallbrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)
--------------

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

--------------
function mushasmallbrain:OnStart()
    local root = 
-- Panic(self.inst)),
--		

    PriorityNode({
            WhileNode(function() return self.inst.components.health:GetPercent() < 0.50 end, "LowHealth", StandStill(self.inst, CanStandStill, Follow(self.inst, function() return self.inst.components.follower.leader end, 1, 2, 3 ))),

        FaceEntity(self.inst, GetTraderFn, KeepTraderFn),
        -- when starving prefer finding food over fighting
        SequenceNode{
            ConditionNode(function() return IsStarving(self.inst) and CanSeeFood(self.inst) end, "SeesFoodToEat"),
            ParallelNodeAny {
                WaitNode(math.random()*.4),
                PriorityNode {
                    StandStill(self.inst, ShouldStandStill),
                    Follow(self.inst, function() return self.inst.components.follower.leader end, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),

                },
            },
            DoAction(self.inst, function() return FindFoodAction(self.inst) end),
        },
        SequenceNode{
            ConditionNode(function() return self.inst.components.health:GetPercent() > 0.2 and self.inst:HasTag("defense") and self.inst.components.combat.target ~= nil end, "HasTarget"),
            WaitNode(math.random()*.9),
            ChaseAndAttack(self.inst, 3),
        },

  RunAway(self.inst, "monster", 6, 12, function(target) return ShouldStopCommand(self.inst, target) end ),
  RunAway(self.inst, "player", 2, 2, function(target) return BabyRunAway(self.inst, target) end ),

          RunAway(self.inst, "crazy", 3, 4),
         
	IfNode(function() 
		if self.inst.components.follower.leader ~= nil and self.inst.components.staycommand and self.inst.components.staycommand:IsCurrentlyStaying() == false then
				self.inst:RemoveTag("animal")
				self.inst:AddTag("defense")
				self.inst:RemoveTag("grow")
			return true
		elseif self.inst.components.follower.leader ~= nil and not self.inst.components.staycommand then
			return true
		end
		end, "has leader",	
		Follow(self.inst, GetLeader, MIN_FOLLOW_LEADER, TARGET_FOLLOW_LEADER, MAX_FOLLOW_LEADER)),

IfNode(function() 
		
		if self.inst.components.follower.leader ~= nil and self.inst.components.staycommand and self.inst.components.staycommand:IsCurrentlyStaying() == true then
				self.inst:AddTag("animal")
				self.inst:RemoveTag("defense")
				self.inst:AddTag("grow")
self.inst.components.combat:GiveUp()
			return true
		end
		end, "has leader",	
		WhileNode(function() return ShouldGoHome(self.inst) end, "ShouldGoHome",
            		DoAction(self.inst, GoHomeAction, "Go Home", true ))),  

---------
        SequenceNode{
            ConditionNode(function() return IsHungry(self.inst) and CanSeeFood(self.inst) end, "SeesFoodToEat"),
            ParallelNodeAny {
                WaitNode(1 + math.random()*2),
                PriorityNode {
                    StandStill(self.inst, ShouldStandStill),
                    Follow(self.inst, function() return self.inst.components.follower.leader end, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),

                },
            },
            DoAction(self.inst, function() return FindFoodAction(self.inst) end),
        },
        PriorityNode {
            StandStill(self.inst, ShouldStandStill),
            Follow(self.inst, function() return self.inst.components.follower.leader end, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
        },
        Wander(self.inst, function() if self.inst.components.follower.leader then return Vector3(self.inst.components.follower.leader.Transform:GetWorldPosition()) end end, MAX_FOLLOW_DIST- 1, {minwalktime=.5, randwalktime=.5, minwaittime=6, randwaittime=3}),
    },.25)
    self.bt = BT(self.inst, root)
 end

return mushasmallbrain