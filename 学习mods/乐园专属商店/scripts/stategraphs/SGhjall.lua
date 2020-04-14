
local function GetTargetFn(inst)
    if not (inst.components.health == nil or  inst.components.health:IsDead()) 
        then
        local target = FindClosestPlayerToInst(inst, 8, true)
        return target ~= nil and not target:HasTag("playgohst") and not target:HasTag("notarget") and target or nil
    end
end

local actionhandlers = 
{
}

local events=
{
    EventHandler("death", function(inst) inst.sg:GoToState("death") end),
    EventHandler("doattack", function(inst) inst.sg:GoToState("attack") end),
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
        end,
		
		events=
        {
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    }, 

    State{
        name = "attack", 
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
		inst.AnimState:PushAnimation("attack1_pst", false)
	end,

    timeline=
    {

			TimeEvent(8*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/swipe")
			end),
            TimeEvent(11*FRAMES, function(inst)
				inst.components.combat:DoAttack()
			end),
    },
        events=
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
				--	inst:DoTaskInTime(2, function(inst)
				--	inst:Hide()
				--inst:Show()
				--local target = GetTargetFn(inst)
				--	if target ~= nil   and inst:IsValid()
				--	and target:IsValid() and inst.components.combat and  inst.components.combat:CanTarget(target) then
				--	inst.components.combat:SuggestTarget(target)
				--	end
				--end)
				--inst:DoTaskInTime(4, function(inst)
				--	inst:Show()
				--end)
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
        },

        events=
        {
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle") 
			end),
        },
    },
    State{
        name = "death",
        tags = {"busy"},

        onenter = function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/death")
            inst.AnimState:PlayAnimation("death2")
            inst.Physics:Stop()
			inst:AddTag("NOCLICK")
			ChangeToObstaclePhysics(inst)
        end,

		timeline=
        {
			TimeEvent(30*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bonehit1") end),
			TimeEvent(50*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bonehit1") end),
			TimeEvent(55*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/death_bodyfall") end),
			TimeEvent(70*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bonehit2") end),
        },
		
        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
					
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
        end,	
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("run") end ),
        },
    },
	
	State
    {
        name = "run",
        tags = { "moving", "running", "canrotate" },

        onenter = function(inst)
			inst.components.locomotor:WalkForward()
			inst.AnimState:PlayAnimation("walk_loop")
        end,
		
		timeline=
        {
			TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/step") 
			end),
			TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/grunt") 
			end),
			TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/step") 
			end),
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
        },

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },
}
   
return StateGraph("hjall", states, events, "taunt", actionhandlers)

