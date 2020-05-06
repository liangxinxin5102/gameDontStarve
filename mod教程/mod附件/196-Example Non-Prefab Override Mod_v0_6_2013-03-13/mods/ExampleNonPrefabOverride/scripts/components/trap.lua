--
-- Example Override Version
-- Changes the search radius for finding trappable creatures
-- However, this could be done in a mod's modmain using a
-- ComponentPostInit callback function
--
-- Updated for Revision 74452 2013-03-12_14-18-42 (A Little Rain Must Fall)
--
print("Loading custom trap component override")


local Trap = Class(function(self, inst)
    self.inst = inst
    self.bait = nil
    self.issprung = false

    self.isset = false

-- MOD --
    self.range = 2		--default: 1.5
-- /MOD --

    self.range = 1.5
    self.targettag = "smallcreature"
    self.checkperiod = .75
    self.timetocheck = self.checkperiod
    self.onharvest = nil
    self.onbaited = nil
    self.onspring = nil
end)

function Trap:SetOnHarvestFn(fn)
    self.onharvest = fn
end

function Trap:SetOnSpringFn(fn)
    self.onspring = fn
end

function Trap:GetDebugString()
    
    local str = nil
    if self.isset then 
        str = "SET! "
    elseif self.issprung then
        str = "SPRUNG! "
    else 
        str = "IDLE! "
    end
    
    if self.bait then
        str = str.."Bait:"..tostring(self.bait).." "
    end

    if self.target then
        str = str.."Target:"..tostring(self.target).." "
    end

    if self.lootprefabs and #self.lootprefabs > 0 then
        str = str.."Loot: "
        for k,v in pairs(self.lootprefabs) do
			str = str .. v.." "
        end
    end
    
    return str
    
end

function Trap:SetOnBaitedFn(fn)
    self.onbaited = fn
end

function Trap:IsFree() 
    return self.bait == nil
end

function Trap:IsBaited()
	return self.isset and not self.issprung and self.bait ~= nil
end


function Trap:Reset()
    self.inst:StopUpdatingComponent(self)
    self.isset = false
    self.issprung = false
    self.lootprefabs = nil
    self.bait = nil
    self.target = nil
end

function Trap:Disarm()
	self:Reset()
end

function Trap:Set()
    self:Reset()
    self.isset = true
    self.inst:StartUpdatingComponent(self)   
end

function Trap:OnUpdate(dt)
    if self.isset then
        self.timetocheck = self.timetocheck - dt
        if self.timetocheck <= 0 then
            local guy = FindEntity(self.inst, self.range, function(guy)
                return not (guy.components.health and guy.components.health:IsDead() )
                and not (guy.components.inventoryitem and guy.components.inventoryitem:IsHeld() )
            end, {self.targettag})
            if guy then
                self.target = guy
                self.inst:StopUpdatingComponent(self)
                self.inst:PushEvent("springtrap")
                self.target:PushEvent("trapped")
            end
            self.timetocheck = self.checkperiod
        end
    end
end

function Trap:DoSpring()
    self.inst:StopUpdatingComponent(self)
    
    if self.target and self.target:IsValid() and not self.target:IsInLimbo() then
        self.target:PushEvent("ontrapped", {trapper=self.inst, bait=self.bait})
        if self.onspring then
            self.onspring(self.inst, self.target, self.bait)
        end
        if self.target.components.inventoryitem then
            self.lootprefabs = {self.target.prefab}
        else
            if self.target.components.lootdropper then
                self.lootprefabs = self.target.components.lootdropper:GenerateLoot()
            end
        end
        self.target:Remove()
    end
    
    if self.bait and self.bait:IsValid() then
        self.bait:Remove()
    else
        local x, y, z = self.inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x,y,z, 2)
        for k,v in pairs(ents) do
            if v.components.bait then
                -- don't remove items out of nearby chests, or the user's inventory
                if v.components.inventoryitem == nil or v.components.inventoryitem.owner == nil then
                    v:Remove()
                    break
                end
            end
        end
    end
    
    self.target = nil
    self.bait = nil
    self.isset = false
    self.issprung = true
    --self.inst:RemoveComponent("inventoryitem")
    
end

function Trap:Harvest(doer)
    if self.issprung then
        self.inst:PushEvent("harvesttrap")
        if self.onharvest then
			self.onharvest(self.inst)
        end
        
        if self.lootprefabs and doer.components.inventory then
            for k,v in ipairs(self.lootprefabs) do
                local loot = SpawnPrefab(v)
                if loot then
                    doer.components.inventory:GiveItem(loot, nil, Vector3(TheSim:GetScreenPos(self.inst.Transform:GetWorldPosition())))
                end
            end
        end
        self:Reset()
        
        if self.inst.components.finiteuses and self.inst.components.finiteuses:GetUses() > 0 then
            doer.components.inventory:GiveItem(self.inst, nil, Vector3(TheSim:GetScreenPos(self.inst.Transform:GetWorldPosition())))
        end
    end
end

function Trap:RemoveBait()
    if self.bait then
        if self.baitlayer then
            self.bait.AnimState:SetSortOrder(0)
        end
        self.bait.components.bait.trap = nil
        self.bait = nil
    end
end

function Trap:SetBait(bait)
    self:RemoveBait()
    if bait and bait.components.bait then
        self.bait = bait
        if self.baitlayer then
            self.bait.AnimState:SetSortOrder(self.baitsortorder)
        end
        bait.components.bait.trap = self
        bait.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
        if self.onbaited then
            self.onbaited(self.inst, self.bait)
        end
    end
end

function Trap:BaitTaken(eater)
    if eater and eater:HasTag(self.targettag) then
        self.target = eater
        self.inst:StopUpdatingComponent(self)
        self.inst:PushEvent("springtrap")
    else
        self:RemoveBait()
    end
end

function Trap:AcceptingBait()
    return self.isset and self.bait == nil
end

function Trap:CollectSceneActions(doer, actions)
    if self.issprung then
        table.insert(actions, ACTIONS.CHECKTRAP)
    end
end



function Trap:OnSave()
    return
    {
        sprung = self.issprung,
        isset = self.isset,
        bait = self.bait and self.bait.GUID or nil,
        loot = self.lootprefabs,
    }
end

function Trap:OnLoad(data)
    self.sprung = data.sprung
    self.isset = data.isset
    
    --backwards compatability
    if type(data.loot) == "string" then
        self.lootprefabs = {data.loot}
    elseif type(data.loot) == "table" then
        self.lootprefabs = data.loot
    end
    
    if self.isset then
        self.inst:StartUpdatingComponent(self)  
    elseif self.sprung then
        self.inst:PushEvent("springtrap")
    end
    
end



function Trap:LoadPostPass(newents, savedata)
    if savedata.bait then
        local bait = newents[savedata.bait]
        if bait then
            self:SetBait(bait.entity)
        end
    end
end

return Trap

