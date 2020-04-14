--改自熔炉mod的boss
require("stategraphs/commonstates")

local function WantsToCharge(inst)
	if inst.level >= 2 and inst.components.combat.target then
		local x, y, z = inst.components.combat.target.Transform:GetWorldPosition()
		local distsq = inst:GetDistanceSqToPoint(x, y, z)
		if distsq > 300 and distsq < 400 then
			return true
		else
			return false
		end
	else
		return false
	end	
end

local function AttemptSlam(inst, target)
	if inst.components.combat.target and inst.altattack and inst.altattack == true and inst.components.combat.canattack == true and inst.components.health and inst.components.health:GetPercent() <= 0.9 then
		local x, y, z = inst.components.combat.target.Transform:GetWorldPosition()
		local distsq = inst:GetDistanceSqToPoint(x, y, z)
		if distsq and distsq > 30 and distsq < 130 then
			inst.sg:GoToState("attack_special", inst.components.combat.target)
		end
	end
end


local BANNER_LOOPS = 10

local function ShakeIfClose(inst)
    ShakeAllCameras(CAMERASHAKE.FULL, .5, .02, .2, inst, 30)
end

local function ShakeIfCloseSlam(inst)
    ShakeAllCameras(CAMERASHAKE.FULL, .7, .04, .2, inst, 30)
end

local function ShakePound(inst)
	inst.SoundEmitter:PlaySound("dontstarve/creatures/deerclops/bodyfall_dirt")
    ShakeAllCameras(CAMERASHAKE.FULL, 1.2, .03, .7, inst, 30)
end

local function ShakeRoar(inst)
    ShakeAllCameras(CAMERASHAKE.FULL, 0.7, .03, .5, inst, 30)
end

local function FindMidRangeTarget(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 10, { "locomotor", "player" }, { "INLIMBO", "playerghost"})
	local targets = {}
	for i, v in ipairs(ents) do
		if v:IsValid() and (v.components.health and not v.components.health:IsDead()) then
			local x, y, z = v.Transform:GetWorldPosition()
			local distsq = inst:GetDistanceSqToPoint(x, y, z)
			if distsq and distsq > 45 and distsq < 130 then
				table.insert(targets, v)
			end
		end		
	end
	return targets
end

local function DoTrail(inst, targetposx, targetposz, trailend)
	inst.stopslam = nil
	local startingpos = inst:GetPosition()
	inst:ForceFacePoint(targetposx, 0, targetposz)
		local targetpos = {x = targetposx, y = 0, z = targetposz}
		local found_players = {}
		
		local angle = -inst.Transform:GetRotation() * DEGREES
		local angled_offset = {x = 1.25 * math.cos(angle+90), y = 0, z = 1.25 * math.sin(angle+90)}
		local angled_offset2 = {x = 1.25 * math.cos(angle-90), y = 0, z = 1.25 * math.sin(angle-90)}
		local impact_distance = 36
					
		local maxtrails = 12 + 5
		for i = 1, maxtrails do
			inst:DoTaskInTime(FRAMES*math.ceil(1+i/ (trailend and 1.5 or 3.5)), function()
				local offset = (targetpos - startingpos):GetNormalized()*(i)
				local x, y, z = (startingpos + offset):Get()
				if TheWorld.Map:IsAboveGroundAtPoint((startingpos+offset):Get()) and not inst.stopslam then
					if i > 6 then
						SpawnPrefab(trailend ~= nil and "hj_groundlift" or "hj_groundliftrocks").Transform:SetPosition((startingpos+offset+angled_offset):Get())
						SpawnPrefab(trailend ~= nil and "hj_groundlift" or "hj_groundliftrocks").Transform:SetPosition((startingpos+offset+angled_offset2):Get())
						if not inst:HasTag("groundspike") then
							inst:AddTag("groundspike")
						end
					end
					local ents = TheSim:FindEntities(x, y, z, 2, { "locomotor" }, { "hj", "shadow", "playerghost", "INLIMBO" })
					for _,ent in ipairs(ents) do
						if ent ~= inst and inst.components.combat:IsValidTarget(ent) and ent.components.health and not ent.hasbeenhit then
							inst:PushEvent("onareaattackother", { target = ent})
							ent.components.combat:GetAttacked(inst, i < 6 and 500 or (450 * (not trailend and 0.5 or 1))) --伤害
							ent.hasbeenhit = true
							ent:DoTaskInTime(0.25, function(inst) inst.hasbeenhit = nil end)
						end
					end
				else
					inst.stopslam = true
				end	
				if i == maxtrails then
					inst.stopslam = nil
				end
			end)
		end
end
local actionhandlers = 
{
}
local function nobody(inst)
	local players = {}
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 60, { "player" }, { "INLIMBO", "playerghost"})
	for i, v in ipairs(ents) do
		if v:IsValid() and (v.components.health and not v.components.health:IsDead()) then
			table.insert(players, v)
		end		
	end 
	return #players
end

local function remove(inst,target)
	local distsq = distsq(target:GetPosition(), inst:GetPosition()) or nil
	if distsq and distsq  > 3600 then
		return true
	end
	if nobody(target) == 0 then
		return true
	end
	return false
end

local function miemie(inst)
	if inst.badys ~= nil then
		for k,v in pairs(inst.badys) do
			if v:IsValid() and v.components.health and not v.components.health:IsDead() then
				v.components.health:Kill()
			end
		end
	end
end

local function rechange(inst)
	if inst.components.warg_lvl ~= nil then
		inst.components.warg_lvl.time = 0
		inst.components.warg_lvl.lvl = inst.components.warg_lvl.maxlvl
	end
end

local events=
{
	CommonHandlers.OnDeath(),
    EventHandler("doattack", function(inst, data) 
		if inst.ischarging then inst.ischarging = nil end
		if not inst.components.health:IsDead() and not (inst.sg:HasStateTag("hit") or inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("nointerrupt")) then 
			if inst.level > 0 and inst.altattack2 and inst.altattack2 == true then
				inst.sg:GoToState("attack_special2")	--转圈
			elseif inst.components.health and inst.components.health:GetPercent() <= 0.99 and #FindMidRangeTarget(inst) > 0 and inst.altattack and inst.altattack == true then
				inst.sg:GoToState("attack_special", data.target)  --电
			else
				inst.sg:GoToState("attack", data.target) --普通攻击 
			end
		end 
	end),
	EventHandler("locomote", function(inst, data)
        if inst.sg:HasStateTag("busy")  then
            return
        end
        local is_moving = inst.sg:HasStateTag("moving")
        local should_move = inst.components.locomotor:WantsToMoveForward()
		
        if is_moving and not should_move then
			if not inst.ischarging then
				inst.sg:GoToState("run_stop")
			end
        elseif not is_moving and should_move then
			if inst.ischarging then
				inst.sg:GoToState("dash")
			else
				inst.sg:GoToState("run_start")
			end
        elseif data.force_idle_state and not (is_moving or should_move or inst.sg:HasStateTag("idle")) then
            inst.sg:GoToState("idle")
        end
    end),
}

 local states=
{

    State{
        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle_loop", true)
			if inst.components.combat.target then
				AttemptSlam(inst, inst.components.combat.target)
			end
        end,
		
		events=
        {
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    }, 
	
	State{
		name = "stun",
        tags = {"busy", "nofreeze"},

        onenter = function(inst, data)
            inst.Physics:Stop()
			if data.stimuli ~= nil and data.stimuli == "electric" then
				inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/stun")
				inst.AnimState:PlayAnimation("stun_loop", true)
				inst.sg:SetTimeout(1)
				inst.components.combat:SetTarget(data.attacker and data.attacker or nil)
				inst.aggrotimer = GetTime() + 2
			else
				inst.components.combat:SetTarget(nil)
				inst.AnimState:PlayAnimation("stun_loop")
				inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/hit")
			end
			inst.sg.stun_stimuli = data.stimuli
        end,

		timeline=
        {
			TimeEvent(5*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/stun") end),
			TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/stun") end),
			TimeEvent(15*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/stun") end),
			TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/stun") end),
			TimeEvent(25*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/stun") end),
			TimeEvent(30*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/stun") end),
			TimeEvent(35*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/stun") end),
			TimeEvent(40*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/stun") end),
        },
		
		onexit = function(inst)
            
        end,
		
		ontimeout = function(inst)
			inst.sg:GoToState("stun_pst", inst.sg.stun_stimuli or nil)
		end,

        events=
        {
			EventHandler("animover", function(inst) inst.sg:GoToState("stun_pst", inst.sg.stun_stimuli or nil) end),
        },
    },
	
	State{
		name = "stun_pst",
        tags = {"busy", "nofreeze"},

        onenter = function(inst, stimuli)
			if stimuli ~= nil then inst.sg.stun_stimuli = stimuli end
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("stun_pst")
        end,

		timeline=
        {

        },
		
		onexit = function(inst)
            
        end,

        events=
        {
			EventHandler("animover", function(inst) 
				if inst.banner_calls and inst.banner_calls < BANNER_LOOPS then
					inst.sg:GoToState("banner_pre")
				else
					if inst.sg.stun_stimuli and (inst.sg.stun_stimuli == "explosive") then
						inst.sg:GoToState("taunt") 
					else
						inst.sg:GoToState("idle") 
					end
				end	
				inst.sg.stun_stimuli = nil
			end),
        },
    },
	
	State{
		name = "banner_pre",
        tags = {"busy", "nointerrupt"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("banner_pre")
			if not inst.banner_calls then
				inst.banner_calls = 0
			end
			inst.sg.statemem.wants_to_banner = true 
        end,

		timeline=
        {
        },
		
		onexit = function(inst)
            
        end,

        events=
        {
			EventHandler("animover", function(inst) inst.sg:GoToState("banner_loop") end),
        },
    },
	
	State{
		name = "banner_loop",
        tags = {"busy", "nointerrupt", "nofreeze"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("banner_loop", true)
			inst.banner_calls = inst.banner_calls ~= nil and inst.banner_calls + 1 or 1
        end,

		timeline=
        {
			TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/banner_call_a") end),
        },
		
		onexit = function(inst)
            
        end,

        events=
        {
			EventHandler("animover", function(inst) 
				if inst.banner_calls and inst.banner_calls < BANNER_LOOPS then
					inst.sg:GoToState("banner_loop") 
				else
					inst.sg:GoToState("banner_pst")
				end
			end),
        },
    },
	
	State{
		name = "banner_pst",
        tags = {"busy"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("banner_pst")
			
        end,

		timeline=
        {
        },
		
		onexit = function(inst)
        end,

        events=
        {
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "attack", --swipe
        tags = {"attack", "busy"},
		
		onenter = function(inst, target)
        inst.components.combat:StartAttack()
        inst.components.locomotor:Stop()
        inst.Physics:Stop()		
        if inst.components.combat.target ~= nil then
            if inst.components.combat.target:IsValid() then
                inst:ForceFacePoint(inst.components.combat.target:GetPosition())
            end
        end
		inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/swipe_pre")
        inst.AnimState:PlayAnimation("attack1")
		if inst.components.health:GetPercent() > 0.5 or inst.altattack3 == false then
			inst.AnimState:PushAnimation("attack1_pst", false)
		elseif not inst.components.combat.target or inst.components.combat.target.components.health:IsDead() then
			inst.AnimState:PushAnimation("attack1_pst", false)
		end
	end,

    timeline=
    {

			TimeEvent(8*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/swipe")
			end),
            TimeEvent(11*FRAMES, function(inst)
				inst.components.combat:DoAttack()
				inst.components.combat:DoAreaAttack(inst.components.combat.target or inst, 3, nil, nil, nil, {"hj", "shadow", "INLIMBO", "playerghost", "battlestandard"}) 
			end),
    },

        events=
        {
            EventHandler("animover", function(inst) 
				if inst.components.health:GetPercent() <= 0.5 and inst.components.combat.target and not inst.components.combat.target.components.health:IsDead() and inst.altattack3 and inst.altattack3 == true then
					inst.altattack3 = false
					inst.sg:GoToState("attack2", inst.components.combat.target)
				else
					inst.components.combat:TryRetarget()
					inst.sg:GoToState("idle")  
				end
			end),
        },
	
    },
	
	State{
        name = "attack2", --swipe  --快击
        tags = {"attack", "busy"},
		
		onenter = function(inst, target)
		if inst.components.combat.target then  
			inst:ForceFacePoint(inst.components.combat.target:GetPosition())
		end
        inst.components.locomotor:Stop()
        inst.Physics:Stop()
		inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/swipe_pre")
        inst.AnimState:PlayAnimation("attack2")
		if not inst.components.combat.target or inst.components.combat.target.components.health:IsDead() then
			inst.AnimState:PushAnimation("attack2_pst", false)	
		end
		
		if inst.brain ~= nil then
			inst.brain:Stop()
		end
        
		inst.Physics:SetMotorVelOverride(10,0,0)
	end,
	
	onexit = function(inst)
		if inst.brain ~= nil then
			inst.brain:Start()
		end
    end,

    timeline=
    {

            TimeEvent(4*FRAMES, function(inst) 
				inst.components.combat:DoAttack(inst.components.combat.target)
				inst.components.combat:DoAreaAttack(inst.components.combat.target or inst, 3, nil, nil, nil, {"hj", "shadow", "INLIMBO", "playerghost", "battlestandard"}) 
			end),
			TimeEvent(6*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/swipe")
			end),
			TimeEvent(6*FRAMES, function(inst) inst.Physics:ClearMotorVelOverride()
					inst.components.locomotor:Stop() end),
    },

        events=
        {
            EventHandler("animover", function(inst) 
				if inst.components.combat.target and not inst.components.combat.target.components.health:IsDead() then
					inst.sg:GoToState("attack3")
				else
					inst.sg:GoToState("idle")  
				end end),
        },
	
    },
	
	State{
        name = "attack3",   --左勾拳
        tags = {"attack", "busy"},
		
		onenter = function(inst, target)
        inst.components.locomotor:Stop()
        inst.Physics:Stop()
		inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/swipe_pre")
        inst.AnimState:PlayAnimation("attack3")
        if inst.components.combat.target then  
			inst:ForceFacePoint(inst.components.combat.target:GetPosition())
		end
		
		if inst.brain ~= nil then
			inst.brain:Stop()
		end
		inst.Physics:SetMotorVelOverride(10,0,0)
	end,
	
	onexit = function(inst)
		if inst.brain ~= nil then
			inst.brain:Start()
		end
    end,

    timeline=
    {

			TimeEvent(6*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/swipe")
			end),
			TimeEvent(6*FRAMES, function(inst) inst.Physics:ClearMotorVelOverride()
					inst.components.locomotor:Stop() end),
			TimeEvent(6*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/taunt_2")
			end),
			TimeEvent(6*FRAMES, ShakeIfClose),
            TimeEvent(6*FRAMES, function(inst) 
				inst.components.combat:DoAttack(inst.components.combat.target)
				inst.components.combat:DoAreaAttack(inst.components.combat.target or inst, 3, nil, nil, nil, {"hj", "shadow", "INLIMBO", "playerghost", "battlestandard"}) 
			end),
    },

        events=
        {
            EventHandler("animover", function(inst) 
				inst.components.combat:TryRetarget()
				inst.sg:GoToState("idle")
			end),
        },
	
    },
	
	State{
        name = "attack_special",   ---火火火
        tags = {"attack", "busy"},
		
		onenter = function(inst, target, forcedtarget)
		inst.sg.statemem.wants_to_slam = nil
		if not forcedtarget then
		inst.altattack = false
		end
		inst.is_doing_special = true
		inst.Transform:SetEightFaced()
        inst.components.locomotor:Stop()
        inst.Physics:Stop()
		inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/grunt")
        inst.AnimState:PlayAnimation("attack5")
		local targets = FindMidRangeTarget(inst)
		if #targets > 0 and not forcedtarget then 
			inst.components.combat:SetTarget(targets[math.random(1, #targets)])
		elseif forcedtarget and forcedtarget:IsValid() then
			inst.components.combat:SetTarget(forcedtarget) -- this is pretty redudant but whatever.
		end
		
        if inst.components.combat.target ~= nil then
            if inst.components.combat.target:IsValid() then
                inst:ForceFacePoint(inst.components.combat.target:GetPosition())
				inst.targetx, inst.targety, inst.targetz = inst.components.combat.target.Transform:GetWorldPosition()
            end
        end
	end,
	
	onexit = function(inst)
		inst:RemoveTag("groundspike")
		inst.Transform:SetFourFaced()
		inst:DoTaskInTime(0.25, function(inst) inst.is_doing_special = nil end)
		inst.targetx = nil
		inst.targety = nil
		inst.targetz = nil
		inst.components.combat:SetRange(3.5 , 6)
		if not inst.altattack or inst.altattack == false then
			if inst.level >= 3 then
				inst:DoTaskInTime(8/inst.level, function(inst) 
				inst.altattack = true 
				end)
			else
				inst:DoTaskInTime(8, function(inst) 
				inst.altattack = true 
			end)
			end
		end	
    end,
	
    timeline=
		{

			TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/attack_5")
			end),
			TimeEvent(15*FRAMES, ShakeIfClose),
			TimeEvent(15*FRAMES, function(inst) 
				inst.sg:AddStateTag("nocancel")
				if inst.components.combat.target then
				
				inst.targetx, inst.targety, inst.targetz = inst.components.combat.target.Transform:GetWorldPosition()
				end
				if inst.targetx and inst.targetz then	
					inst:FacePoint(inst.targetx, 0, inst.targetz)
					DoTrail(inst,inst.targetx, inst.targetz)
				end	
			end),
			TimeEvent(35*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/attack_5_fire_1") end),
			TimeEvent(37*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/attack_5_fire_2") end),
			TimeEvent(35*FRAMES, ShakeIfClose),
			TimeEvent(35*FRAMES, function(inst) 
				if inst.targetx and inst.targetz then	 
					DoTrail(inst,inst.targetx, inst.targetz, true)
				end	
				inst.sg:RemoveStateTag("nocancel")
			end),
		},

        events=
        {
            EventHandler("animover", function(inst) 
				inst.sg:GoToState("idle")
			end),
        },
	
    },
	
	State{
		name = "hit",
        tags = {"busy", "hit"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("hit")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/hit")
			inst.sg.mem.last_hit_time = GetTime()
        end,

        events=
        {
			EventHandler("animover", function(inst) 
				if inst.banner_calls and inst.banner_calls < BANNER_LOOPS then
					inst.sg:GoToState("banner_pre")
				elseif inst.sg.statemem.wants_to_slam then
					inst.sg:GoToState("attack_special", nil, inst.sg.statemem.wants_to_slam)
				else
					inst.sg:GoToState("idle") 
				end	
			end),
        },
    },
	
	
	State{
		name = "taunt",  --咆哮
        tags = {"busy"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("taunt")
        end,

		timeline=
        {
			TimeEvent(15*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/taunt")
			end),
			TimeEvent(15*FRAMES, ShakeRoar)
        },

        events=
        {
			EventHandler("animover", function(inst)
				if inst.banner_calls and inst.banner_calls < BANNER_LOOPS then
					inst.sg:GoToState("banner_pre") 
				else
					inst.sg:GoToState("idle") 
				end
			end),
        },
    },
	
	State{
		name = "attack_special2",  --转啊转
        tags = {"busy"},

        onenter = function(inst, cb)
			inst.altattack2 = false
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("attack4")
			inst.components.combat:StartAttack()
        end,

		timeline=
        {
			TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/spin") end),
			TimeEvent(13*FRAMES, function(inst) inst.components.combat:DoAreaAttack(inst, 6.2, nil, nil, nil, {"battlestandard", "hj", "shadow", "playerghost", "FX", "DECOR"}) end),
			TimeEvent(31*FRAMES, function(inst) inst.components.combat:DoAreaAttack(inst, 6.2, nil, nil, nil, {"battlestandard", "hj", "shadow", "playerghost", "FX", "DECOR"}) end), 
        },
		
		onexit = function(inst)
			if inst.level >= 2 then
				inst.altattack3 = true
			end
			inst:DoTaskInTime(5, function(inst) inst.altattack2 = true end)
		end,
		
        events=
        {
			EventHandler("onhitother", function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/swipe") end),
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },
	
	State{
		name = "action",
        tags = {"busy"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
			inst:PerformBufferedAction()
            inst.AnimState:PlayAnimation("walk_pst")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/step")		
        end,

		timeline=
        {

        },

        events=
        {
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },
	
    State{
        name = "yichu",
        tags = {"busy"},

        onenter = function(inst)
			inst.Physics:Stop()
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/death")
            inst.AnimState:PlayAnimation("death2")
            RemovePhysicsColliders(inst)
			miemie(inst)
        end,

		timeline=
        {
			TimeEvent(30*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bonehit1") end),
			TimeEvent(50*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bonehit1") end),
			TimeEvent(55*FRAMES, function(inst) 
			ShakeRoar(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/death_bodyfall") end),
			TimeEvent(70*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bonehit2") end),
        },
		
        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
					inst:Remove()
                end
            end),
        },

    },
	State
    {
        name = "run_start",
        tags = { "moving", "running", "canrotate" },

        onenter = function(inst)
			inst.components.locomotor:WalkForward()
            inst.AnimState:PlayAnimation("walk_pre")
			local wantstocharge = WantsToCharge(inst)
			if wantstocharge == true then
				inst.ischarging = true
				inst.sg:GoToState("dash")
			end	
        end,	
        events =
        {
            EventHandler("animover", function(inst) 
			if inst.altar ~= nil and  remove(inst,inst.altar) then
				inst.sg:GoToState("yichu")
				rechange(inst.altar)
			else
				inst.sg:GoToState("run") 
			end
			end ),
        },
    },
	
	State
    {
        name = "run",
        tags = { "moving", "running", "canrotate" },

        onenter = function(inst)
			inst.components.locomotor:WalkForward()
			inst.AnimState:PlayAnimation("walk_loop")
			if inst.components.combat.target then
				AttemptSlam(inst, inst.components.combat.target)
			end
			local wantstocharge = WantsToCharge(inst)
			if wantstocharge == true then
				inst.ischarging = true
				inst.sg:GoToState("dash")
			end	
        end,
		
		timeline=
        {
			TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/step") 
			end),
			TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/grunt") 
			end),
			TimeEvent(0*FRAMES, ShakeIfClose),
			TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/step") 
			end),
			TimeEvent(20*FRAMES, ShakeIfClose),
        },
        events=
			{
				EventHandler("animover", function(inst) inst.sg:GoToState("run") end ),
			},

    },
	
	State
    {
        name = "run_stop",
        tags = { "idle" },

        onenter = function(inst) 
            inst.components.locomotor:StopMoving()
			inst.AnimState:PlayAnimation("walk_pst")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/step")     
        end,
		
		timeline=
        {
			TimeEvent(0*FRAMES, ShakeIfClose),
        },

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },
	
	State
    {
        name = "dash",
        tags = { "nointerrupt", "moving", "running", "canrotate" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("dash")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/grunt") 
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/step")		
        end,
		
		onexit = function(inst)
			inst.ischarging = nil
		end,
		
		timeline = 
		{
			TimeEvent(2*FRAMES, function(inst) inst.components.locomotor:RunForward() 
			end),  
			TimeEvent(13*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/step")  
			end),
			TimeEvent(13*FRAMES, ShakeIfClose),
		},
		
        events =
        {
            EventHandler("animover", function(inst) 
				inst.components.locomotor:StopMoving() 
				if inst.components.combat.target then
					inst.sg:GoToState("attack_special", nil, inst.components.combat.target) 
				else
					inst.sg:GoToState("idle")
				end
			end ),
        },
    },
}
CommonStates.AddDeathState(states, 
		{timeline = 
		{
			TimeEvent(30*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bonehit1") end),
			TimeEvent(50*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bonehit1") end),
			TimeEvent(55*FRAMES, function(inst) 
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/death_bodyfall")
			ShakeRoar(inst)			
			end),
			TimeEvent(70*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bonehit2") end),
		},}, "death2")

return StateGraph("hjzs", states, events, "taunt", actionhandlers)

