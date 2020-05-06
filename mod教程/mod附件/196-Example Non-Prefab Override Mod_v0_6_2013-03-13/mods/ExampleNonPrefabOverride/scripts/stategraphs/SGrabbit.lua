--
-- Example Override Version
-- Removes the screaming sounds when a rabbit runs or dies.
-- Doing this as an override is easier as doing this change from a mod's
-- modmain is much more involved
--
-- Updated for Revision 74452 2013-03-12_14-18-42 (A Little Rain Must Fall)
--
print("Loading custom rabbit stategraph override")


local WALK_SPEED = 4
local RUN_SPEED = 7

require("stategraphs/commonstates")

local actionhandlers = 
{
    ActionHandler(ACTIONS.EAT, "eat"),
    ActionHandler(ACTIONS.GOHOME, "action"),
}



local events=
{
    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),
    EventHandler("attacked", function(inst) if inst.components.health:GetPercent() > 0 then inst.sg:GoToState("hit") end end),
    EventHandler("death", function(inst) inst.sg:GoToState("death") end),
    EventHandler("trapped", function(inst) inst.sg:GoToState("trapped") end),
    EventHandler("locomote", 
        function(inst) 
            if not inst.sg:HasStateTag("idle") and not inst.sg:HasStateTag("moving") then return end
            
            if not inst.components.locomotor:WantsToMoveForward() then
                if not inst.sg:HasStateTag("idle") then
                    if not inst.sg:HasStateTag("running") then
                        inst.sg:GoToState("idle")
                    end
                        inst.sg:GoToState("idle")
                end
            elseif inst.components.locomotor:WantsToRun() then
                if not inst.sg:HasStateTag("running") then
                    inst.sg:GoToState("run")
                end
            else
                if not inst.sg:HasStateTag("hopping") then
                    inst.sg:GoToState("hop")
                end
            end
        end),
}

local states=
{
 
    State{
        name = "look",
        tags = {"idle", "canrotate" },
        onenter = function(inst)
            
            inst.data.lookingup = nil
            inst.data.donelooking = nil
            
            if math.random() > .5 then
                inst.AnimState:PlayAnimation("lookup_pre")
                inst.AnimState:PushAnimation("lookup_loop", true)
                inst.data.lookingup = true
            else
                inst.AnimState:PlayAnimation("lookdown_pre")
                inst.AnimState:PushAnimation("lookdown_loop", true)
            end
            
            inst.sg:SetTimeout(1 + math.random()*1)
        end,
        
        ontimeout = function(inst)
            inst.data.donelooking = true
            if inst.data.lookingup then
                inst.AnimState:PlayAnimation("lookup_pst")
            else
                inst.AnimState:PlayAnimation("lookdown_pst")
            end
        end,
        
        events=
        {
            EventHandler("animover", function (inst, data)
                if inst.data.donelooking then
                    inst.sg:GoToState("idle")
                end
            end),
        }
    },
    
    State{
        
        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            if playanim then
                inst.AnimState:PlayAnimation(playanim)
                inst.AnimState:PushAnimation("idle", true)
            else
                inst.AnimState:PlayAnimation("idle", true)
            end                                
            inst.sg:SetTimeout(1 + math.random()*1)
        end,
        
        ontimeout= function(inst)
            inst.sg:GoToState("look")
        end,

    },
    
    State{
        
        name = "action",
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle")
            inst:PerformBufferedAction()
        end,
        events=
        {
            EventHandler("animover", function (inst, data) inst.sg:GoToState("idle") end),
        }
    },    
    
    State{
        name = "eat",
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("rabbit_eat_pre", false)
            inst.AnimState:PushAnimation("rabbit_eat_loop", true)
            inst.sg:SetTimeout(2+math.random()*4)
        end,
        
        ontimeout= function(inst)
            inst:PerformBufferedAction()
            inst.sg:GoToState("idle", "rabbit_eat_pst")
        end,
    },    

    State{
        name = "hop",
        tags = {"moving", "canrotate", "hopping"},
        
        timeline=
        {
            TimeEvent(5*FRAMES, function(inst) 
                inst.Physics:Stop() 
                inst.SoundEmitter:PlaySound("dontstarve/rabbit/hop")
            end ),
        },
        
        onenter = function(inst) 
            inst.AnimState:PlayAnimation("walk")
            inst.components.locomotor:WalkForward()
            inst.sg:SetTimeout(2*math.random()+.5)
        end,
        
        onupdate= function(inst)
            if not inst.components.locomotor:WantsToMoveForward() then
                inst.sg:GoToState("idle")
            end
        end,        
        
        ontimeout= function(inst)
            inst.sg:GoToState("hop")
        end,
    },
    
    State{
        name = "run",
        tags = {"moving", "running", "canrotate"},
        
        onenter = function(inst) 
-- MOD --
            --inst.SoundEmitter:PlaySound("dontstarve/rabbit/scream")
-- /MOD --
            inst.AnimState:PlayAnimation("run_pre")
            inst.AnimState:PushAnimation("run", true)
            inst.components.locomotor:RunForward()
        end,
        
        --[[onupdate= function(inst)
            if not inst.components.locomotor:WantsToMoveForward() then
                inst.sg:GoToState("idle")
            end
        end, --]]       
        
    },    
    
    State{
        name = "death",
        tags = {"busy"},
        
        onenter = function(inst)
-- MOD --
            --inst.SoundEmitter:PlaySound("dontstarve/rabbit/scream")
-- /MOD --
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)        
            print("dropping death loot")    
            inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))            
        end,

    },    
    
    State{
        name = "stunned",
        tags = {"busy"},
        
        onenter = function(inst) 
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("stunned_loop", true)
            inst.sg:SetTimeout(GetRandomWithVariance(6, 2) )
            if inst.components.inventoryitem then
                inst.components.inventoryitem.canbepickedup = true
            end
        end,
        
        onexit = function(inst)
            if inst.components.inventoryitem then
                inst.components.inventoryitem.canbepickedup = false
            end
        end,
        
        ontimeout = function(inst) inst.sg:GoToState("idle") end,
    },
    
    State{
        name = "trapped",
        tags = {"busy"},
        
        onenter = function(inst) 
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("stunned_loop", true)
            inst.sg:SetTimeout(1)
        end,
        
        ontimeout = function(inst) inst.sg:GoToState("idle") end,
    },
}
CommonStates.AddSleepStates(states)
CommonStates.AddSimpleState(states, "hit", "hit", {"busy"})
CommonStates.AddFrozenStates(states)

  
return StateGraph("rabbit", states, events, "idle", actionhandlers)

