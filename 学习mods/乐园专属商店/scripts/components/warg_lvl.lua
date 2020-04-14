
local function onlvl(self, lvl)
    self.inst._lvl:set(lvl)
end

local function ontime(self, time)
	local time = math.ceil(time/480)
	self.inst._time:set(time)
end

local function OnTaskTick(inst, self, period)
    self:DoDec(period)
end


local function boss(inst, self)
	inst.AnimState:PlayAnimation("teleport")
	inst.AnimState:PushAnimation("idle_empty")
	local down = TheCamera:GetDownVec()
	local spawnangle = math.atan2(down.z, down.x)
	local angle = math.atan2(down.z, down.x) + (math.random()*90-45)*DEGREES
	local sp = math.random()*3+2
	local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(2*math.cos(spawnangle), 0, 2*math.sin(spawnangle))
	pt = pt + Vector3(sp*math.cos(angle), 0, sp*math.sin(angle))
	inst:DoTaskInTime(1, function()
		if self.boss ~= nil then 
			local boss = SpawnPrefab(self.boss) 
			if boss then
				if boss.components.knownlocations ~= nil then
					boss.components.knownlocations:RememberLocation("home", inst:GetPosition())
				end
				boss.Transform:SetPosition(pt:Get())
				boss.altar = inst
				SpawnPrefab("collapse_big").Transform:SetPosition(pt:Get())
			end
		end
	end)
end

local Warg_lvl = Class(function(self, inst)
    self.inst = inst
    self.max = 480 
	self.maxlvl = 10
	self.time = 0	
	self.lvl = self.maxlvl
	self.boss = nil
	self.bossdis = false
	
    local period = 1
    self.inst._wargtask = self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
end,
nil,
{
    time = ontime,
    lvl = onlvl,
})

function Warg_lvl:OnSave()
	return {
	time = self.time ,
	lvl = self.lvl ,
	}
end

function Warg_lvl:OnLoad(data)
    if data~= nil  then
        self.time = data.time
        self.lvl = data.lvl
    end
end

function Warg_lvl:SetMax(max)
    self.max =  (max ~= 0  and 480 * max or 120)
end

function Warg_lvl:SetMaxlvl(maxlvl)
    self.maxlvl = maxlvl
	self.lvl = maxlvl
end
function Warg_lvl:SetBoss(boss)
    self.boss = boss
end

function Warg_lvl:DoDelta(num)
	self.lvl = math.clamp(self.lvl - num, 0, self.maxlvl)
	if self.lvl == 0 then
		boss(self.inst,self)
		self.lvl = self.maxlvl 
		self.time = self.max
		self.inst._wargtask = self.inst:DoPeriodicTask(1, OnTaskTick, nil, self, 1)
	end
end

function Warg_lvl:DoDec(num)
    if self.time == 0 then
		if self.inst._wargtask ~= nil then
			self.inst._wargtask:Cancel()
			self.inst._wargtask = nil
		end
		return
	end
	self.time = math.clamp(self.time - num, 0, self.max)
end

return Warg_lvl
