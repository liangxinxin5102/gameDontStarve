local require = GLOBAL.require
local stackable_replica = require "components/stackable_replica"
local IsServer = GLOBAL.TheNet:GetIsServer()

local size = GetModConfigData("MAXSTACKSIZE")
local TUNING = GLOBAL.TUNING
local net_byte = GLOBAL.net_byte

TUNING.STACK_SIZE_LARGEITEM = size
TUNING.STACK_SIZE_MEDITEM = size
TUNING.STACK_SIZE_SMALLITEM = size 

-- Define functions
local stackable_replica_ctorBase = stackable_replica._ctor or function() return true end    
function stackable_replica._ctor(self, inst)
    self.inst = inst

    self._stacksize = net_byte(inst.GUID, "stackable._stacksize", "stacksizedirty")
    self._maxsize = size
end

local stackable_replicaSetMaxSize_Base = stackable_replica.SetMaxSize or function() return true end
function stackable_replica:SetMaxSize(maxsize)
	self._maxsize = size
end

local stackable_replicaMaxSize_Base = stackable_replica.MaxSize or function() return true end
function stackable_replica:MaxSize()
	return self._maxsize
end

if IsServer then
AddPrefabPostInit("rabbit",function(inst)
   if(inst.components.stackable == nil) then
      inst:AddComponent("stackable")
   end
   inst.components.inventoryitem:SetOnDroppedFn(function(inst)
        inst.components.perishable:StopPerishing()
        inst.sg:GoToState("stunned")
        if inst.components.stackable then
    	    while inst.components.stackable:StackSize() > 1 do
    	        local item = inst.components.stackable:Get()
    	        if item then
    	            if item.components.inventoryitem then
    	                item.components.inventoryitem:OnDropped()
    	            end
    	            item.Physics:Teleport(inst.Transform:GetWorldPosition() )
    	        end
    	    end
    	 end
    end)
end)
end