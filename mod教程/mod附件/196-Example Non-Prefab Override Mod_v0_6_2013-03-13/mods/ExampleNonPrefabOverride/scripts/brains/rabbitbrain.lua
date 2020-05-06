--
-- Example Override Version
-- Changes the distance settings which are not visible from a mod's modmain
-- and would require duplicating large chunks of this file's code to change.
-- Hopefully in future these types of settings with be stored in the class
-- itself so they can be easily changed outside of this file.
--
-- Updated for Revision 74452 2013-03-12_14-18-42 (A Little Rain Must Fall)
--
print("Loading custom rabbit brain override")


require "behaviours/wander"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/panic"


-- MOD --
local STOP_RUN_DIST   = 8	--Default: 10
local SEE_PLAYER_DIST = 3	--Default: 5
local SEE_BAIT_DIST   = 10	--Default: 20
local MAX_WANDER_DIST = 15	--Default: 20
-- /MOD --


local RabbitBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function OnAttacked(inst, data)
    if inst.brain then
        local x,y,z = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x,y,z, 30)
        
        local num_friends = 0
        local maxnum = 5
        for k,v in pairs(ents) do
            if v:HasTag("rabbit") then
                v:PushEvent("gohome")
                num_friends = num_friends + 1
            end
            
            if num_friends > maxnum then
                break
            end
            
        end
    end
end


local function GoHomeAction(inst)
    if inst.components.homeseeker and 
       inst.components.homeseeker.home and 
       inst.components.homeseeker.home:IsValid() then
        return BufferedAction(inst, inst.components.homeseeker.home, ACTIONS.GOHOME)
    end
end

local function EatFoodAction(inst)

    local target = FindEntity(inst, SEE_BAIT_DIST, function(item) return inst.components.eater:CanEat(item) and item.components.bait and not item:HasTag("planted") and not (item.components.inventoryitem and item.components.inventoryitem:IsHeld()) end)
    if target then
        local act = BufferedAction(inst, target, ACTIONS.EAT)
        act.validfn = function() return not (target.components.inventoryitem and target.components.inventoryitem:IsHeld()) end
        return act
    end
end


function RabbitBrain:OnStart()
    local clock = GetClock()
    
    local root = PriorityNode(
    {
        WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
        RunAway(self.inst, "scarytoprey", SEE_PLAYER_DIST, STOP_RUN_DIST, nil, true),
        EventNode(self.inst, "gohome", 
            DoAction(self.inst, function() return GoHomeAction(self.inst) end, "go home", true )),
        WhileNode(function() return clock and not clock:IsDay() end, "IsNight",
            DoAction(self.inst, function() return GoHomeAction(self.inst) end, "go home", true )),
        DoAction(self.inst, function() return EatFoodAction(self.inst) end ),
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST)
    }, .25)
    
    self.inst:ListenForEvent("attacked", OnAttacked)
    self.bt = BT(self.inst, root)
end


return RabbitBrain