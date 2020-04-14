require "behaviours/chaseandattack"
require "behaviours/leash"
require "behaviours/wander"
require "behaviours/doaction"

local HjzsBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function GetWanderPoint(inst)
    return inst.components.knownlocations:GetLocation("home") or nil
end

function HjzsBrain:OnStart()
    
    local root = PriorityNode(
    {
		ChaseAndAttack(self.inst, 8),
        Wander(self.inst, GetWanderPoint, 20),
    }, .25)
    
    self.bt = BT(self.inst, root)
end

return HjzsBrain
