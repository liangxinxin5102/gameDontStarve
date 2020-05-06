require("stategraphs/commonstates")


local actionhandlers = 
{
    ActionHandler(ACTIONS.EAT, "eat"),
    ActionHandler(ACTIONS.GOHOME, "eat"),
	ActionHandler(ACTIONS.TAKEITEM, "eat"),
}

local events=
{
    CommonHandlers.OnStep(),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnLocomote(false,true),
    CommonHandlers.OnFreeze(),
    EventHandler("attacked", function(inst)
        if not inst.components.health:IsDead() then
            inst.sg:GoToState("hit")
        end
    end),
    EventHandler("doattack", function(inst) 
        if not inst.components.health:IsDead() and not inst.sg:HasStateTag("busy") then 
            inst.sg:GoToState("attack") 
        end 
    end),

    EventHandler("death", function(inst) inst.sg:GoToState("death") end),
}

local states=
{
    State{
        name = "idle",
        tags = {"idle", "canrotate"},
        
        onenter = function(inst, pushanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle", true)
            inst.sg:SetTimeout(4 + 4*math.random())
        end,

        ontimeout = function(inst)
            --print("smallbird - idle timeout")
            if math.random() <= inst.userfunctions.GetPeepChance(inst) then
                inst.sg:GoToState("idle_peep")
            else
                inst.sg:GoToState("idle_blink")
            end
            if math.random() <= inst.userfunctions.GetCryChance(inst) then
                inst.sg:GoToState("cry")
	end
        end,

        events=
        {
            EventHandler("startstarving", 
                function(inst, data)
                    --print("smallbird - SG - startstarving")
                    inst.sg:GoToState("idle_peep")
                end
            ),
        },
    },

    State{
        name = "cry",
        tags = {"busy", "canrotate"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("call")
        end,
        
        timeline=
        {
            TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/chirp_short") end),
            TimeEvent(17*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/chirp_short") end),
            TimeEvent(28*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/chirp_short") end),
        },
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },    
    State{
        name = "idle_blink",
        tags = {"idle", "canrotate"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle_blink")
        end,
       
        timeline = 
        {
            TimeEvent(17*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/blink") end),
        },

        events=
        {
            EventHandler("animover", 
                function(inst,data) 
                    if math.random() < 0.1 then
                        inst.sg:GoToState("idle_blink")
                    else
                        inst.sg:GoToState("idle")
                    end
                end
            ),
        },
    },

    State{
        name = "idle_peep",
        tags = {"idle"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("meep")
        end,
       
        timeline = 
        {
            TimeEvent(3*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/chirp") end),
        },

        events=
        {
            EventHandler("animover", 
                function(inst,data) 
                    if math.random() <= inst.userfunctions.GetPeepChance(inst) then
                        inst.sg:GoToState("idle_peep")
                    else
                        inst.sg:GoToState("idle")
                    end
                end
            ),
        },
    },

	State{
        name = "death",
        tags = {"busy"},
        
        onenter = function(inst)
           inst.components.container:Close()
            inst.components.container:DropEverything()
         --   inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/death")
            inst.AnimState:PlayAnimation("death")
            inst.components.locomotor:StopMoving()
            RemovePhysicsColliders(inst)            
            inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))            
        end,
        
    },

    State{
        name = "open",
        tags = {"busy", "open"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.components.sleeper:WakeUp()
            inst.AnimState:PlayAnimation("meep")
        end,

        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("open_idle") end ),
        },

        timeline=
        {
            TimeEvent(3*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/chirp") end),
    },
},
    State{
        name = "open_idle",
        tags = {"busy", "open"},
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle", true)
            inst.sg:SetTimeout(4 + 4*math.random())
            
            if not inst.sg.mem.pant_ducking or inst.sg:InNewState() then
				inst.sg.mem.pant_ducking = 1
			end
            
        end,

        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("open_idle") end ),
        },

        timeline=
        {
        
        
            TimeEvent(3*FRAMES, function(inst) 
				inst.sg.mem.pant_ducking = inst.sg.mem.pant_ducking or 1
				inst.SoundEmitter:PlaySound("dontstarve/wilson/lighter_on", nil, inst.sg.mem.pant_ducking) 
				if inst.sg.mem.pant_ducking and inst.sg.mem.pant_ducking > .35 then
					inst.sg.mem.pant_ducking = inst.sg.mem.pant_ducking - .05
				end
			end),
        },        
    },

    State{
        name = "close",
        tags = {""},
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle_blink")
        end,

        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },

        timeline=
        {
            TimeEvent(17*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/blink") end),
        },        
    },



    State{
        name = "hatch",
        tags = {"busy"},
        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/egg_hatch_crack")
            inst.AnimState:PlayAnimation("hatch")
        end,
        timeline = 
        {
            TimeEvent(30*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/egg_hatch") end),
        },
        events=
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
                inst.userfunctions.FollowPlayer(inst)
            end),
        },
    },

    State{
        name = "growup",
        tags = {"busy"},
        onenter = function(inst)
           inst.components.container:Close()
            inst.components.container:DropEverything()
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("grow")
        end,
        timeline = 
        {
            TimeEvent(1*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/leg_sproing") end),
            TimeEvent(1*FRAMES, function(inst) inst.Transform:SetScale(1.1,1.1,1.1) end),
            TimeEvent(1*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/teenbird/leg_sproing") end),
            TimeEvent(1*FRAMES, function(inst) inst.Transform:SetScale(1.1, 1.1, 1.1) end),
        },
        events=
        {
            EventHandler("animover", function(inst)
                inst.userfunctions.SpawnAdult5(inst)
            end),
        },
    },

    State{
        name = "taunt",
        tags = {"busy", "canrotate"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("call")
            if inst.components.combat and inst.components.combat.target then
                inst:FacePoint(Vector3(inst.components.combat.target.Transform:GetWorldPosition()))
            end
        end,
        
        timeline=
        {
            TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/chirp_short") end),
            TimeEvent(17*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/chirp_short") end),
            TimeEvent(28*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/chirp_short") end),
        },
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },    
    
    State{
        name = "attack",
        tags = {"attack"},
        
        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.components.combat:StartAttack()
            inst.AnimState:PushAnimation("atk", false)
        end,
        
        timeline=
        {
            TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/attack") end),
            TimeEvent(12*FRAMES, function(inst) inst.components.combat:DoAttack() end),
        },
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "hit",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/hurt")
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()            
        end,
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },        
    },
    State{
        name = "eat",
        tags = {"busy", "canrotate"},
        
        onenter = function(inst)
            inst.Physics:Stop()            
            inst.AnimState:PlayAnimation("eat")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/scratch_ground")
        end,
        
        timeline=
        {
            TimeEvent(7*FRAMES, function(inst) 
                inst:PerformBufferedAction() 
            end),
        },
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },        
    },
}

CommonStates.AddWalkStates(states, {
    walktimeline = 
    { 
        TimeEvent(1*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/wings") end),
        --TimeEvent(13*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/footstep") end),
    }
}, nil, true)

CommonStates.AddSleepStates(states,
{
    starttimeline = 
    {
        TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/sleep") end)
    },
    waketimeline = 
    {
        TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/wakeup") end)
    },
})
CommonStates.AddFrozenStates(states)
CommonStates.AddSimpleState(states,"refuse", "idle_blink", {"busy"})

return StateGraph("musha_tall5", states, events, "idle", actionhandlers)

