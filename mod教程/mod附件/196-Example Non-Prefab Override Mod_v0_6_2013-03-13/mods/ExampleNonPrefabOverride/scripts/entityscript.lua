--Modified by WrathOf to workaround hard coded path issue in game version
--Changes the LoadStateGraph function to use the require statement instead
--of the loadfile function defined in main.lua so the state graphs can be
--overriden by the mods
--Left the indexing of StateGraph table to include the ".lua" in the name
--since not sure if anything assumes this is present
--
--Updated for Revision 74452 2013-03-12_14-18-42 (A Little Rain Must Fall)
--
print("Loading custom entityscript")

require("class")

local BehaviourTrees = {}
local StateGraphs = {}
local Components = {}


local function LoadComponent(name)
    
    if Components[name] == nil then
        Components[name] = require("components/"..name)
    end
    return Components[name]
end



local function LoadStateGraph(name)

    if StateGraphs[name] == nil then
--[[ ORIG --
        local filename = "data/scripts/stategraphs/"..name
        local fn = loadfile(filename)
        assert(fn, "could not load stategraph "..filename)
        StateGraphs[name] = fn()
-- /ORIG --]]
-- MOD --
		local filename = name
		if string.find(name, ".lua", -4) then filename = string.sub(name, 1, -5) end
		local fn = require("stategraphs/"..filename)
        assert(fn, "could not load stategraph "..name)
        StateGraphs[name] = fn
-- /MOD --
    end
    
    local sg = StateGraphs[name]
    
    assert(sg, "stategraph "..name.." is not valid")
    return sg
end

EntityScript = Class(function(self, entity)
    self.entity = entity
    self.components = {}
    self.GUID = entity:GetGUID()
    self.spawntime = GetTime()
    self.persists = true
    self.inlimbo = false
    self.name = nil
    
    self.data = nil
    self.listeners = nil
    self.updatecomponents = nil
    self.inherentactions = nil
    self.event_listeners = nil
    self.event_listening = nil
    self.pendingtasks = nil
    self.children = nil
    self.age = 0
end)

function EntityScript:GetSaveRecord()
    local record = 
    {
        prefab = self.prefab,
        id = self.GUID,
        age = self:GetTimeAlive()
    }
    
    if self.Transform then
        local x, y, z = self.Transform:GetWorldPosition()
        record.x = math.floor(x*10)/10
        record.z = math.floor(z*10)/10
        --y is often 0 in our game, so be selective.
        if y ~= 0 then
            record.y = math.floor(y*10)/10
        end
    end
    
    record.data = self:GetPersistData()
            
    return record
end


function EntityScript:Hide()
    self.entity:Hide(false)
end

function EntityScript:Show()
    self.entity:Show(false)
end

function EntityScript:IsInLimbo()
    return self.inlimbo
end

function EntityScript:RemoveFromScene()
    self.inlimbo = true
	self.entity:Hide()
	
	self:StopBrain()
	
	if self.sg then
	    self.sg:Stop()
	end
	if self.Physics then
        self.Physics:SetActive(false)
    end
    if self.Light then
        self.Light:Enable(false)
    end
    if self.AnimState then
        self.AnimState:Pause()
    end
    if self.DynamicShadow then
        self.DynamicShadow:Enable(false)
    end
    self:PushEvent("enterlimbo")
end

function EntityScript:ReturnToScene()
    
    self.inlimbo = false
	self.entity:Show()
    if self.Physics then
        self.Physics:SetActive(true)
	end
    if self.Light then
        self.Light:Enable(true)
    end
    if self.AnimState then
        self.AnimState:Resume()
    end
    if self.DynamicShadow then
        self.DynamicShadow:Enable(true)
    end
    
    self:RestartBrain()
    
	if self.sg then
	    self.sg:Start()
	end
    self:PushEvent("exitlimbo")
end


function EntityScript:OnProgress()
	for k,v in pairs(self.components) do
		if v.OnProgress then
			v:OnProgress()
		end
	end
end

function EntityScript:__tostring()
    return string.format("%d - %s%s", self.GUID, self.prefab or "", self.inlimbo and "(LIMBO)" or "")
end

function EntityScript:AddInherentAction(act)
    if not self.inherentactions then
		self.inherentactions = {}
    end
    self.inherentactions[act] = true
end

function EntityScript:RemoveInherentAction(act)
    if self.inherentactions then
		self.inherentactions[act] = nil
	end
end

function EntityScript:GetTimeAlive()
    return GetTime() - self.spawntime + self.age
end


function EntityScript:StartUpdatingComponent(cmp)
    
    if not self.updatecomponents then
        self.updatecomponents = {}
        NewUpdatingEnts[self.GUID] = self
        num_updating_ents = num_updating_ents + 1
    end

    self.updatecomponents[cmp] = true
    
    
end



function EntityScript:StopUpdatingComponent(cmp)
    
    if self.updatecomponents then
        
        self.updatecomponents[cmp] = nil
        
        local num = 0
        for k,v in pairs(self.updatecomponents) do
            num = num + 1
            break
        end
        
        if num == 0 then
            self.updatecomponents = nil
            UpdatingEnts[self.GUID] = nil
			NewUpdatingEnts[self.GUID] = nil
            num_updating_ents = num_updating_ents - 1
        end
    end
    
end

function EntityScript:AddTag(tag)
    self.entity:AddTag(tag)
end

function EntityScript:RemoveTag(tag)
    self.entity:RemoveTag(tag)
end

function EntityScript:HasTag(tag)
    return self.entity:HasTag(tag)
end

function EntityScript:AddComponent(name)
    if self.components[name] then
        print("component "..name.." already exists!")
    end
    local cmp = LoadComponent(name)
    assert(cmp, "component ".. name .. " does not exist!")
    
    local loadedcmp = cmp(self)
    self.components[name] = loadedcmp
    local postinitfns = ModManager:GetComponentPostInitFns(name)

    for k,fn in ipairs(postinitfns) do
        fn(loadedcmp,self)
    end
end

function EntityScript:RemoveComponent(name)
    local cmp = self.components[name]
    if cmp then
        self.components[name] = nil
        if cmp.OnRemoveFromEntity then
            cmp:OnRemoveFromEntity()
        end
    end
end


function EntityScript:SetPrefabName(name)
    self.prefab = name
    self.entity:SetPrefabName(name)
    self.name = self.name or (STRINGS.NAMES[string.upper(self.prefab)] or "MISSING NAME")
end
            

function EntityScript:SpawnChild(name)
    if self.prefabs then
		assert(self.prefabs, "no prefabs registered for this entity ".. name)
		local prefab = self.prefabs[name]
		assert(prefab, "Could not spawn unknown child type "..name)
		local inst = SpawnPrefab(prefab)
		assert(inst, "Could not spawn prefab "..name.." "..prefab)
	    self:AddChild(inst)
	    return inst
	else
		local inst = SpawnPrefab(name)
	    self:AddChild(inst)
	    return inst
	end
    
end

function EntityScript:RemoveChild(child)
    child.parent = nil
    if self.children then
		self.children[child] = nil
	end		
    child.entity:SetParent(nil)
end

function EntityScript:AddChild(child)
    if child.parent then
        child.parent:RemoveChild(child)
    end

    child.parent = self
    if not self.children then
		self.children = {}
    end
    
    self.children[child] = true
    child.entity:SetParent(self.entity)
    
end

function EntityScript:GetBrainString()
	local str = {}
    
    if self.brain then
        table.insert(str, "BRAIN:\n")
        table.insert(str, tostring(self.brain))
        table.insert(str, "--------\n")
    end
    
	return table.concat(str, "")
end

function EntityScript:GetDebugString()
    local str = {}
    
    table.insert(str, tostring(self))
    table.insert(str, string.format(" age %2.2f", self:GetTimeAlive()))
    table.insert(str, "\n")
    
    table.insert(str, self.entity:GetDebugString())
    
    table.insert(str, "Buffered Action: "..tostring(self.bufferedaction).."\n")

    if self.debugstringfn then
		table.insert(str, self.debugstringfn())
    end

    if self.sg then
        table.insert(str, "SG:" .. tostring(self.sg).."\n-----------\n")
    end
    
    for k,v in pairs(self.components) do
        if v.GetDebugString then
            table.insert(str, k..": "..v:GetDebugString().."\n")
        end
    end
    
    --[[if self.brain then
        table.insert(str, "-------\nBRAIN:\n")
        table.insert(str, tostring(self.brain))
        table.insert(str, "--------\n")
    end
    --]]
    
    
    --[[
    table.insert(str, "-------\nListening for Events:\n")
    for ent, evs in pairs(self.event_listening) do
        table.insert(str, "\t"..tostring(ent)..":  ")
        
        for ev in pairs(evs) do
            table.insert(str, tostring(ev).." ")
        end
        table.insert(str, "\n")
    end
    
    table.insert(str, "-------\nBroadcasting Events:\n")
    for ev,insts in pairs(self.event_listeners) do
        table.insert(str, "\t"..tostring(ev)..":")
        for inst in pairs(insts) do
            table.insert(str, tostring(inst.GUID).." ")
        end
        table.insert(str, "\n")
    end
    
    --]]
    --[[
    table.insert(str, "-------\nPending tasks:\n")
    for id,task in pairs(self.pendingtasks) do
		if task then
			table.insert(str, tostring(id)..": "..task.name.. " " ..task.tick)
		end
    end
    --]]
    return table.concat(str, "")
end

function EntityScript:KillTasks()
    KillThreadsWithID(self.GUID)
end


function EntityScript:StartThread( fn )
    local thread = StartThread(fn, self.GUID)
    return thread
end

function EntityScript:RunScript(name)
    local fn = LoadScript(name)
    fn(self)
end

function EntityScript:RestartBrain()
	self:StopBrain()
	if self.brainfn then
		--if type(self.brainfn) ~= "table" then print(self, self.brainfn) end
		self.brain = self.brainfn()
		if self.brain then
	        self.brain.inst = self
			self.brain:Start()
		end
	end
end

function EntityScript:StopBrain(brainfn)
    if self.brain then
        self.brain:Stop()
    end
	self.brain = nil
end


function EntityScript:SetBrain(brainfn)
	if brainfn == nil then
		print (self)
	end
	self.brainfn = brainfn
	if self.brain then
		self:RestartBrain()
	end
end


function EntityScript:SetStateGraph(name)
	if self.sg then
		SGManager:RemoveInstance(self.sg)
	end
    local sg = LoadStateGraph(name)
    assert(sg)
    if sg then
        self.sg = StateGraphInstance(sg, self)
        SGManager:AddInstance(self.sg)
        self.sg:GoToState(self.sg.sg.defaultstate)
        return self.sg
    end
end

function EntityScript:ClearStateGraph()
	if self.sg then
		SGManager:RemoveInstance(self.sg)
		self.sg = nil
	end
end

function EntityScript:ListenForEvent(event, fn, source)
    --print ("Listen for event", self, event, source)
    source = source or self
    
    if not source.event_listeners then
		source.event_listeners = {}
	end
	
	local ev = source.event_listeners[event]
	if not ev then
		ev = {}
		source.event_listeners[event] = ev
	end
    
    local for_listener = ev[self]
    if not for_listener then
        for_listener = {}
        ev[self] = for_listener
    end
    
    table.insert(for_listener, fn)

    if not self.event_listening then
		self.event_listening = {}
    end
	
	local at_target = self.event_listening[source]
	if not at_target then
		at_target = {}
		self.event_listening[source] = at_target
	end

    at_target[event] = true
end

function EntityScript:RemoveEventCallback(event, target)
    if self.event_listeners then
		target = target or self
	    
		local event_targets = self.event_listeners[event]

		if event_targets then
			event_targets[target] = nil
		end
	    
	    if target.event_listening then
			local target_listening = target.event_listening[self]
	    
			if target_listening then
				target_listening[event] = nil
			end
		end
	end
	
end

function EntityScript:RemoveAllEventCallbacks()
    
    --tell others that we are no longer listening for them
    if self.event_listening then
		for target, events in pairs(self.event_listening) do
			if target ~= self then
				for event,k in pairs(events) do
					if target.event_listeners then
						target.event_listeners[event][self] = nil
					end
				end
			end
		end
		self.event_listening = nil
	end    
    
    --tell others who are listening to us to stop
    if self.event_listeners then
		for event, targets in pairs(self.event_listeners) do
			for target, fns in pairs(targets) do
				if target.event_listening then
					target.event_listening[self] = nil
				end
			end
		end
	    self.event_listeners = nil
	end
end

function EntityScript:PushEvent(event, data)
	if self.event_listeners then
		local listeners = self.event_listeners[event]
		if listeners then
			for entity, fns in pairs(listeners) do
	            
				for k,fn in ipairs(fns) do
					fn(self, data)
				end
	            
			end
		end
	end
	    
    if self.sg then
        if self.sg:IsListeningForEvent(event) then
            self.sg:PushEvent(event, data)
            SGManager:OnPushEvent(self.sg)
        end
    end
    
    if self.brain then
        self.brain:PushEvent(event, data)
    end
end

function EntityScript:GetPosition()
    return Point(self.Transform:GetWorldPosition())
end

function EntityScript:GetAngleToPoint(dest)
    local pos = Point(self.Transform:GetWorldPosition())
    local dz = pos.z - dest.z
    local dx = dest.x - pos.x
    local angle = math.atan2(dz, dx) / DEGREES
    return angle
end

function EntityScript:FacePoint(dest, force)
    if not force and (self.sg and self.sg:HasStateTag("busy")) then
        return
    end
    
    local angle = self:GetAngleToPoint(dest)
    self.Transform:SetRotation(angle)
end


function EntityScript:GetDistanceSqToInst(inst)
        local pos1 = Point(inst.Transform:GetWorldPosition())
        local pos2 = Point(self.Transform:GetWorldPosition())
        
        return distsq(pos1, pos2)
end

function EntityScript:IsNear(otherinst, dist)
        return otherinst and self:GetDistanceSqToInst(otherinst) < dist*dist
end

function EntityScript:GetDistanceSqToPoint(point)
        local pos2 = Point(self.Transform:GetWorldPosition())
        return distsq(point, pos2)
end

function EntityScript:FaceAwayFromPoint(dest, force)
    if not force and (self.sg and self.sg:HasStateTag("busy")) then
        return
    end
    
    local pos = Point(self.Transform:GetWorldPosition())
    local dz = pos.z - dest.z
    local dx = dest.x - pos.x
    local angle = math.atan2(dz, dx) / DEGREES + 180
    self.Transform:SetRotation(angle)
end

function EntityScript:IsAsleep()
    return not self.entity:IsAwake()
end

function EntityScript:CancelAllPendingTasks()
    if self.pendingtasks then
		for k,v in pairs(self.pendingtasks) do
	        k:Cancel()
	    end
	    self.pendingtasks = nil
	end
end

function EntityScript:DoPeriodicTask(time, fn, initialdelay)
    
    local per = scheduler:ExecutePeriodic(time, fn, nil, initialdelay, self)

    if not self.pendingtasks then
		self.pendingtasks = {}
    end
    
    self.pendingtasks[per] = true
    per.onfinish = function() if self.pendingtasks then self.pendingtasks[per] = nil end end
    return per
end

function EntityScript:DoTaskInTime(time, fn, ...)

    if not self.pendingtasks then
		self.pendingtasks = {}
    end
    
    local per = scheduler:ExecuteInTime(time, fn, self, ...)
    self.pendingtasks[per] = true
    per.onfinish = function() if self and self.pendingtasks then self.pendingtasks[per] = nil end end
    return per
end


function EntityScript:ClearBufferedAction()
    if self.bufferedaction then
        self.bufferedaction:Fail()
        self.bufferedaction = nil
    end
end

function EntityScript:InterruptBufferedAction()
    if self.bufferedaction then
        self.bufferedaction:Interrupt()
    end
end


function EntityScript:PushBufferedAction(bufferedaction)

	local dupe = bufferedaction and self.bufferedaction
	            and bufferedaction.target == self.bufferedaction.target
	            and bufferedaction.action == bufferedaction.action
	            and not self.bufferedaction.interrupted
	if dupe then
		return
	end
    
    if self.bufferedaction then
        self.bufferedaction:Fail()
        self.bufferedaction = nil
    end
    
    local success, reason = bufferedaction:TestForStart()
    if not success then
        self:PushEvent("actionfailed", {action = bufferedaction, reason = reason})
        return
    end
    
    --walkto is kind of a nil action - the locomotor will have put us at the destination by now if we get to here
    if bufferedaction.action == ACTIONS.WALKTO then
        bufferedaction:Succeed()
        self.bufferedaction = nil
    elseif bufferedaction.action.instant then
        if bufferedaction.target and bufferedaction.target.Transform then
            self:FacePoint(Vector3(bufferedaction.target.Transform:GetWorldPosition()))
        end
        
        bufferedaction:Do()
        self.bufferedaction = nil
        
    else
        self.bufferedaction = bufferedaction
        if not self.sg then
            self:PushEvent("startaction", {action = bufferedaction})
        elseif not self.sg:StartAction(bufferedaction) then
            self.bufferedaction:Fail()
            self.bufferedaction = nil
        end
    end
end


function EntityScript:PerformBufferedAction()

	
    if self.bufferedaction then
        
        if self.bufferedaction.target and self.bufferedaction.target:IsValid() and self.bufferedaction.target.Transform then
            self:FacePoint(Vector3(self.bufferedaction.target.Transform:GetWorldPosition()))
        end
        
        
        local success, reason = self.bufferedaction:Do()

        if  success then
            self.bufferedaction = nil   
            return true
        end
    
        
        self:PushEvent("actionfailed", {action = self.bufferedaction, reason = reason})
        self.bufferedaction:Fail()
        self.bufferedaction = nil
    end
end

function EntityScript:GetBufferedAction()
    if self.bufferedaction then
        return self.bufferedaction
    elseif self.components.locomotor then
        return self.components.locomotor.bufferedaction
    end
end



function EntityScript:OnBuilt(builder)
    for k,v in pairs(self.components) do
        if v.OnBuilt then
            v:OnBuilt(builder)
        end
    end
end

function EntityScript:Remove()

    if self.parent then
        self.parent:RemoveChild(self)
    end
    
	OnRemoveEntity(self.GUID)    
	
    self:PushEvent("onremove")
    
    --tell our listeners to forget about us
    self:RemoveAllEventCallbacks()
    self:CancelAllPendingTasks()
    
    for k,v in pairs(self.components) do
        if v.OnRemoveEntity then
            v:OnRemoveEntity()
        end
    end
    
    
    if self.updatecomponents then
		self.updatecomponents = nil
        UpdatingEnts[self.GUID] = nil
		num_updating_ents = num_updating_ents - 1
    end    
    
    if self.children then
		for k,v in pairs(self.children) do
			k.parent = nil
			k:Remove()
		end
	end
    
    if self.OnRemoveEntity then
		self.OnRemoveEntity(self)
    end
    self.persists = false
    self.entity:Retire()
    
    
end

function EntityScript:IsValid()
    return self.entity:IsValid()
end

function EntityScript:CanInteractWith(inst)
    if not inst:IsValid() then
        return false
    end
    local parent = inst.entity:GetParent()
    if parent and parent ~= self then
        return false
    end
    
    return true
end


function EntityScript:IsActionValid(action)

    for k,v in pairs(self.components) do
        if v.IsActionValid and v:IsActionValid(action) then
            return true
        end
    end
    
end


function EntityScript:OnUsedAsItem(action)
    for k,v in pairs(self.components) do
        if v.OnUsedAsItem then
            v:OnUsedAsItem(action)
        end
    end
end

function EntityScript:CanDoAction(action)
    if self.inherentactions and self.inherentactions[action] then
        return true
    end
    
    if self.components.tool and self.components.tool.action == action then
        return true
    end
    
    if self.components.inventory then
        local item = self.components.inventory:GetActiveItem()
        
        if item and item:CanDoAction(action) then
            return true
        end
        
        item = self.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if item and item:CanDoAction(action) then
            return true
        end
    end
    
end

function EntityScript:IsOnValidGround()
	local tile = self:GetCurrentTileType()
	return tile and tile ~= GROUND.IMPASSABLE
end


function EntityScript:GetCurrentTileType()

    if TheMap then
		local pt = Vector3(self.Transform:GetWorldPosition())
		local tilecenter = Vector3(TheMap:GetTileCenterPoint(pt.x,0,pt.z))
		local tx, ty = TheMap:GetTileCoordsAtPoint(pt.x, 0, pt.z)
		local actual_tile = TheMap:GetTile(tx, ty)
		
		if actual_tile then
			local xpercent = (tilecenter.x - pt.x)/TILE_SCALE + .5
			local ypercent = (tilecenter.z - pt.z)/TILE_SCALE + .5
			
			local x_off = 0
			local y_off = 0
			local x_checks = {0}
			local y_checks = {0}
			if actual_tile == GROUND.IMPASSABLE then
				
				if xpercent < .333 then
					table.insert(x_checks, 1)
				elseif xpercent > .666 then
					table.insert(x_checks, -1)
				end

				if ypercent < .333 then
					table.insert(y_checks, 1)
				elseif ypercent > .666 then
					table.insert(y_checks, -1)
				end
				
				for k, x in pairs(x_checks) do
					for k, y in pairs(y_checks) do
						local tile = TheMap:GetTile(tx + x, ty + y)
						if tile > actual_tile then
							actual_tile = tile
							x_off = x
							y_off = y
						end
					end
				end
			end
			
			return actual_tile, GetTileInfo(actual_tile)	
		end		
		
		--print (string.format("(%d+%d, %d+%d), (%2.2f, %2.2f), %d", tx, x_off, ty, y_off, xpercent, ypercent, actual_tile))
	
	end
    return nil
  
end

function EntityScript:GetPersistData()
    
    local data = nil
    for k,v in pairs(self.components) do
        if v.OnSave then
            local t = v:OnSave()
            if t and not data then
                data = {}
            end
            if t then
                data[k] = t
            end
        end
    end
    
    if self.OnSave then
        if not data then
            data = {}
        end
        self.OnSave(self, data)
    end
    
    if data then
        for k,v in pairs(data) do 
            return data    
        end
    end
end

function EntityScript:LoadPostPass(newents, savedata)
    
    if savedata then
        for k,v in pairs(savedata) do
            local cmp = self.components[k]
            if cmp and cmp.LoadPostPass then
                cmp:LoadPostPass(newents, v)
            end
        end
    end
    
    if self.OnLoadPostPass then
        self:OnLoadPostPass(newents, savedata)
    end
    
end



function EntityScript:SetPersistData(data, newents)
    if data then
        for k,v in pairs(data) do
            local cmp = self.components[k]
            if cmp and cmp.OnLoad then
                cmp:OnLoad(v, newents)
            end
        end
    end

    if self.OnLoad then
        self:OnLoad(data, newents)
    end
end

function EntityScript:GetAdjective()

	for k,v in pairs(self.components) do
		if v.GetAdjective then
			local str = v:GetAdjective()
			if str then
				return str
			end
		end
	end
end

function EntityScript:SetProfile(profile)
    self.profile = profile
    if profile then
        for k,v in pairs(self.components) do
            if v.OnSetProfile then
                v:OnSetProfile(profile)
            end
        end
    end
    
    if self.OnSetProfile then
        self:OnSetProfile(profile)
    end
    
    self:PushEvent("onsetprofile", {})
    
end


function EntityScript:SetInherentSceneAction(action)
	self.inherentsceneaction = action
end
