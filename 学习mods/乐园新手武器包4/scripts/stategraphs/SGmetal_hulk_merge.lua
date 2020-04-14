local TadalinUtil = require("tadalin_util")
require("stategraphs/commonstates")

local actionhandlers = 
{

}

local function HasCircleEmeny(inst)
	return FindEntity(
        inst,
        13,
        function(guy)
			if not (guy and guy:IsValid()) then 
				return false
			end 
			local dist = math.sqrt(inst:GetDistanceSqToInst(guy))
            return TadalinUtil.CanAttack(guy) and dist >= 5 
        end,
        { "_combat","character"},
        {"FX", "NOCLICK","INLIMBO", "monster","tadalin" }
		)
end 

local events=
{
    
    
    EventHandler("attacked", function(inst,data) 
		if not inst.sg:HasStateTag("busy") and data.damage and data.damage >= (3400 + math.random()*6600) then
			inst.sg:GoToState("hit")
		end
	end),
    EventHandler("doattack", function(inst) 
        if not inst.components.health:IsDead() and not inst.sg:HasStateTag("busy") then 
			if inst.skill_circleatk and HasCircleEmeny(inst) then 
				inst.sg:GoToState("atk_circle") 
			elseif inst.wantstobarrier then
                inst.wantstobarrier = nil
                inst.sg:GoToState("barrier")
            elseif inst.wantstolob then
                inst.wantstolob = nil
                inst.sg:GoToState("lob")
            elseif inst.wantstoteleport then
                inst.wantstoteleport = nil
                inst.sg:GoToState("telportout_pre")
            elseif inst.wantstomine then
                inst.wantstomine = nil
                inst.sg:GoToState("bomb_pre")
			else
				inst.sg:GoToState("attack") 
            end      
        end 
    end),
    EventHandler("death", function(inst) inst.sg:GoToState("death") end),
--[[    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),--]]
    CommonHandlers.OnLocomote(false,true),
}

local function ShakeIfClose(inst)
    ShakeAllCameras(CAMERASHAKE.FULL, 0.7, 0.02, 0.3, inst, 30)
end

local function ShakePound(inst)
    ShakeAllCameras(CAMERASHAKE.FULL, 1.2, .03, .7, inst, 30)
end

local function ShakeRoar(inst)
    ShakeAllCameras(CAMERASHAKE.FULL, 0.8, .03, .5, inst, 30)
end

local function DoFootstep(inst)
end

local function SetLightRadius(inst, radius)
    inst.Light:SetRadius(radius)
end

local function DisableLight(inst)
    inst.Light:Enable(false)
end

local function DoAnim(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	if inst.AnimState ~= nil then
        inst.AnimState:PlayAnimation("hit_"..tostring(math.random(5)))
        inst:Show()
        inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength() + 2 * FRAMES, inst.Remove)

        inst.Light:Enable(true)
        inst:DoTaskInTime(4 * FRAMES, SetLightRadius, .5)
        inst:DoTaskInTime(5 * FRAMES, DisableLight)

        SpawnPrefab("deerclops_laserscorch").Transform:SetPosition(x, 0, z)
        local fx = SpawnPrefab("deerclops_lasertrail")
        fx.Transform:SetPosition(x, 0, z)
        fx:FastForward(GetRandomMinMax(.3, .7))
    else
        inst:DoTaskInTime(2 * FRAMES, inst.Remove)
    end
end 

local function DoCircleLaserAtk(inst,rad,start_roa)
	ShakeIfClose(inst)
	start_roa = start_roa or inst:GetRotation() or 0
	inst:StartThread(function()
		for roa = start_roa  ,start_roa+ 360,18 do 
			roa = roa * DEGREES
			local mypos = inst:GetPosition()
			local spawnpos = mypos + Vector3(math.cos(roa)*rad,0,math.sin(roa)*rad)
			local fx1 = SpawnPrefab("deerclops_laser")
			local targets, skiptoss = {}, {}
			local delay = 0.5
			local fx2 = SpawnPrefab("deerclops_laserscorch")
			fx1.Transform:SetScale(2,2,2)
			fx1.Transform:SetPosition(spawnpos:Get())
			
			fx2.Transform:SetScale(1.75,1.75,1.75)
			fx2.Transform:SetPosition(spawnpos:Get())
			
			fx1:SetPrefabNameOverride(inst.nameoverride)
			fx1.caster = inst
			--fx1:Trigger(delay * FRAMES, targets, skiptoss)
			DoAnim(fx1)
			inst:DoDamage(spawnpos,4,TUNING.HULK_ATK*0.75)
			--ShakeIfClose(inst)
			Sleep(0)
		end
		
		ShakeIfClose(inst)
	end)
end 

local function DoLineLightning(inst,targetpos)
	if targetpos then 
		local mypos = inst:GetPosition() 
		local vec = (targetpos - mypos):GetNormalized()
		local per_dist = 2
		inst:StartThread(function()
		for i=1,10 do 
			if targetpos then 
				local strikepos = mypos + vec*per_dist*i
				local fx = SpawnPrefab("tadalin_lava_lightning")
				fx.Transform:SetPosition(strikepos:Get())
				fx:SetSize("medium",1.25)
				fx:DoAreaAttack(inst,1.25,TUNING.HULK_LIGHTNING_ATK)
			end
			Sleep(0.1)
		end 
	end)
	end
end 

local function teleport(inst) 
    inst.teleporttime = nil
    local pt = Vector3(inst.Transform:GetWorldPosition())
    
    if inst.components.combat.target then
        pt = Vector3(inst.components.combat.target.Transform:GetWorldPosition())
    end

    local theta = math.random() * 2 * PI

    local offset = nil
    while not offset do
		offset = FindWalkableOffset(pt, theta,12+5*math.random(),12, true) --12
    end
    
    pt.x = pt.x + offset.x
    pt.z = pt.z + offset.z
    inst.Physics:SetActive(true)
    inst.Transform:SetPosition(pt.x,0,pt.z)
    inst.sg:GoToState("telportin")
end

local function launchprojectile(inst, dir)
    local pt = Vector3(inst.Transform:GetWorldPosition())

    local theta = dir - (PI/6) + (PI/3*math.random())

    local offset = nil

        offset = FindWalkableOffset(pt, theta, 6 + math.random()*6, 12, true) --12

    if offset then
        pt.x = pt.x + offset.x
        pt.y=0
        pt.z = pt.z + offset.z
        inst.LaunchProjectile(inst,pt)
    end
end

local function spawnburns(inst,rad,startangle,endangle,num)
    startangle = startangle *DEGREES
    endangle = endangle *DEGREES
    local pt = Vector3(inst.Transform:GetWorldPosition()) 
    local down = TheCamera:GetDownVec()             
    local angle = math.atan2(down.z, down.x)

    local angle = angle + startangle
    local angdiff = (endangle-startangle)/num
    for i=1,num do
        local offset = Vector3(rad * math.cos( angle ), 0, rad * math.sin( angle ))
        local newpt = pt + offset  
        local fx = SpawnPrefab("laser")
        fx:Trigger(0 * FRAMES, {},{})
        fx.Transform:SetPosition(newpt.x,newpt.y,newpt.z)
        local burn =  SpawnPrefab("deerclops_laserscorch")
        burn.Transform:SetPosition(newpt.x,newpt.y,newpt.z)
        angle = angle + angdiff           
    end    
end

local states=
{
    State
    {
        name = "atk_circle",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.Physics:Stop()
			inst.Transform:SetNoFaced()
			--inst.Transform:SetRotation(0)
			local target = inst.components.combat.target
			if target and target:IsValid() then 
				inst:ForceFacePoint(target:GetPosition():Get())
			end
            inst.AnimState:PlayAnimation("atk_circle")
        end,
		
		onupdate = function(inst)
			if not inst.LaserSwitch then 
				return 
			end
		end,
		
		onexit = function(inst)
			inst.LaserSwitch = false
			inst.Transform:SetSixFaced()
		end,

        timeline = 
        {
			TimeEvent(1*FRAMES, function(inst)  end),
            TimeEvent(30*FRAMES, function(inst)  end),
			TimeEvent(30*FRAMES, function(inst) 
				inst.LaserSwitch = true
				DoCircleLaserAtk(inst,9)
				inst:PushEvent("use_metalhulk_skill",{cd = 10,name = "skill_circleatk"})
			end),
			TimeEvent(30*FRAMES, ShakeRoar),
			TimeEvent(50*FRAMES, function(inst)
				inst.LaserSwitch = false 
			end),
        },
        
        events =
        {
            EventHandler("animover", function(inst) 
				inst.sg:GoToState("idle") 
			end),
        },
    },
	
	------------- TELEPORT ----------------------------

    State{
        name = "telportout_pre",  
        tags = {"busy"},
        
        onenter = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("teleport_out_pre")

        end,

        events =
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("telportout") end ),        
        },

        timeline=
        {
                        ---teleport---
            TimeEvent(18*FRAMES, function(inst) end),
                    -------------step---------------
            TimeEvent(9*FRAMES, function(inst)  end),
            TimeEvent(20*FRAMES, function(inst)  end),
        },
    },

    State{
        name = "telportout",  
        tags = {"busy","invisible"},
        
        onenter = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
			inst.components.health:SetInvincible(true) 
            inst.AnimState:PlayAnimation("teleport_out")          
        end,     
		
		onexit = function(inst)
			inst.components.health:SetInvincible(false) 
		end,       
        
        events =
        {   
            EventHandler("animover", function(inst)                
                inst:Hide()
                inst:DoTaskInTime(0.5,function() teleport(inst)  end)
            end ),        
        },

        timeline=
        {
                        -----------servo---------------            
            TimeEvent(11*FRAMES, function(inst)
                
            end),
            ----steps---
            TimeEvent(15*FRAMES, function(inst)  end),
            TimeEvent(16*FRAMES, function(inst)  end),
            TimeEvent(18*FRAMES, function(inst)  end),
            TimeEvent(39*FRAMES, function(inst)  end),
            ----------gears loop--------------
            TimeEvent(19*FRAMES, function(inst)   
            end),
            TimeEvent(5*FRAMES, function(inst)
                inst:DoDamage(nil,4,TUNING.HULK_ATK/5)
            end),
            TimeEvent(10*FRAMES, function(inst)
                inst.Physics:SetActive(false)
                inst.DynamicShadow:Enable(false)   
                inst:DoDamage(nil,5,TUNING.HULK_ATK/5)
            end),
            TimeEvent(15*FRAMES, function(inst)
                inst:DoDamage(nil,5,TUNING.HULK_ATK/5)
            end),
            TimeEvent(20*FRAMES, function(inst)
                inst:DoDamage(nil,4,TUNING.HULK_ATK/5)
            end),
        },
    },

    State{
        name = "telportin",  
        tags = {"busy","invisible"},
        
        onenter = function(inst)
            inst:Show()
            inst.DynamicShadow:Enable(true)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
			inst.components.health:SetInvincible(true) 
            inst.AnimState:PlayAnimation("teleport_in")
        end,     
		
		onexit = function(inst)
			inst.components.health:SetInvincible(false) 
		end,       
        
        events =
        {   
            EventHandler("animover", function(inst) 
                inst.sg:GoToState("idle")
            end ),        
        },

        timeline=
        {
            TimeEvent(0*FRAMES, function(inst)  end),
            -----------step---------------
            TimeEvent(15*FRAMES, function(inst)  end),
            TimeEvent(19*FRAMES, function(inst)  end),
            TimeEvent(16*FRAMES, function(inst) 
				TheMixer:PushMix("boom")
            end),
            TimeEvent(17*FRAMES, function(inst) 
            end),
            TimeEvent(17*FRAMES, function(inst)    
				ShakePound(inst)         
                inst.components.ly_groundpounder:GroundPound()
				inst.components.health:SetInvincible(false) 
            end),
            TimeEvent(19*FRAMES, function(inst) 
				TheMixer:PopMix("boom")
            end),
        },
    },

    --------------------- BOMBS -------------------------------

    State{
        name = "bomb_pre",  
        tags = {"busy"},
        
        onenter = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("atk_bomb_pre")
        end,            

        events =
        {   
            EventHandler("animover", function(inst) 
                inst.sg:GoToState("bomb")
            end ),        
        },
        timeline=
        {   
            -----rust----
            TimeEvent(16*FRAMES, function(inst)  end),
            TimeEvent(18*FRAMES, function(inst)  end),
            TimeEvent(20*FRAMES, function(inst)  end),
            TimeEvent(22*FRAMES, function(inst)  end),
            -----bomb ting----
            TimeEvent(18*FRAMES, function(inst)  end),
            TimeEvent(20*FRAMES, function(inst)  end),
            TimeEvent(22*FRAMES, function(inst)  end),
            TimeEvent(24*FRAMES, function(inst)  end),
            ----electro-----
            TimeEvent(12*FRAMES, function(inst)  end),
            TimeEvent(15*FRAMES, function(inst)  end),
            TimeEvent(19*FRAMES, function(inst)  end),
            TimeEvent(23*FRAMES, function(inst)  end),
        },
    },

    State{
        name = "bomb",  
        tags = {"busy"},
        
        onenter = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("atk_bomb_loop")
        end,            
        
        timeline=
        {   ---mine shoot---
            TimeEvent(4*FRAMES, function(inst)  end),
            TimeEvent(8*FRAMES, function(inst)  end),
            TimeEvent(12*FRAMES, function(inst)  end),
            TimeEvent(18*FRAMES, function(inst)  end),


            TimeEvent(1*FRAMES, function(inst)
                launchprojectile(inst, 0)
            end),
			TimeEvent(3*FRAMES, function(inst)    
                launchprojectile(inst, PI*0.25)
            end),
            TimeEvent(6*FRAMES, function(inst)    
                launchprojectile(inst, PI*0.5)
            end),
			TimeEvent(9*FRAMES, function(inst)    
                launchprojectile(inst, PI*0.75)
            end),
            TimeEvent(11*FRAMES, function(inst)    
                launchprojectile(inst, PI)
            end),
			TimeEvent(13*FRAMES, function(inst)    
                launchprojectile(inst, PI*1.25)
            end),
            TimeEvent(16*FRAMES, function(inst)    
                launchprojectile(inst, PI*1.5)
            end),
        },

        events =
        {   
            EventHandler("animover", function(inst) 
                inst.sg:GoToState("bomb_pst")
            end ),        
        },
    },

    State{
        name = "bomb_pst",  
        tags = {"busy"},
        
        onenter = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("atk_bomb_pst")
        end,            

        events =
        {   
            EventHandler("animover", function(inst) 
                inst.sg:GoToState("idle")
            end ),        
        },
        
        timeline=
        {
            -----rust----
            TimeEvent(6*FRAMES, function(inst)  end),
            TimeEvent(9*FRAMES, function(inst)  end),
            TimeEvent(11*FRAMES, function(inst)  end),
            TimeEvent(17*FRAMES, function(inst)  end),
            -----bomb ting----
            TimeEvent(8*FRAMES, function(inst)  end),
            TimeEvent(11*FRAMES, function(inst)  end),
            TimeEvent(13*FRAMES, function(inst)  end),
            TimeEvent(19*FRAMES, function(inst)  end),
             -----------servo---------------            
            TimeEvent(11*FRAMES, function(inst)
             end),
        },
    },

---------------------------LOB---------------

    State{
        name = "lob",  
        tags = {"busy","canrotate"},
        
        onenter = function(inst)

            inst.AnimState:PlayAnimation("atk_lob")

            inst.lobtarget = nil
            if inst.components.combat.target and inst.components.combat.target:IsValid() then
                inst.lobtarget = Vector3(inst.components.combat.target.Transform:GetWorldPosition())
            else
                local angle = inst.Transform:GetRotation() * DEGREES
                local offset = Vector3(15 * math.cos( angle ), 0, -15 * math.sin( angle ))
                local pt = Vector3(inst.Transform:GetWorldPosition())

                inst.lobtarget = Vector3(pt.x + offset.x,pt.y + offset.y,pt.z + offset.z)
            end        
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
        end,            

        timeline =
        {
            TimeEvent(30*FRAMES, function(inst)     
                local pt = inst.lobtarget
                if inst.components.combat.target and inst.components.combat.target:IsValid() then   
                    inst.lobtarget = Vector3(inst.components.combat.target.Transform:GetWorldPosition())
                end                  
                inst.orbs = inst.orbs -1 
                if inst.orbs == 0 then
                    inst.orbtime = 10
                end
                inst.ShootProjectile(inst, inst.lobtarget)
            end),

            TimeEvent(0*FRAMES, function(inst)  end),
            TimeEvent(30*FRAMES, function(inst) 
            end),
        },

        onupdate = function(inst)
            if inst.components.combat.target and inst.components.combat.target:IsValid() then 
                inst:ForceFacePoint(Vector3(inst.components.combat.target.Transform:GetWorldPosition()))
            end
        end,

        events =
        {   
            EventHandler("animover", function(inst) 
                inst.sg:GoToState("idle")
            end ),        
        },
    },
	
	----------------------BARRIER--------------------

    State{
        name = "barrier",  
        tags = {"busy"},
        
        onenter = function(inst)
            inst.Transform:SetNoFaced()
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("atk_barrier")
        end,            
        
        timeline=
        {        
            --step---
            TimeEvent(12*FRAMES, function(inst) 
            end),
            ---barrier attack---
            TimeEvent(19*FRAMES, function(inst) 
            end),

            TimeEvent(67*FRAMES, function(inst) 
            end),
            
            TimeEvent(67*FRAMES, function(inst) TheMixer:PushMix("boom")
            end),

            TimeEvent(90*FRAMES, function(inst) TheMixer:PopMix("boom")
            end),

            TimeEvent(64*FRAMES, function(inst)                
                inst.components.ly_groundpounder.damageRings = 4
                inst.components.ly_groundpounder.destructionRings = 4
                inst.components.ly_groundpounder.numRings = 4                
				ShakePound(inst) 
                inst.components.ly_groundpounder:GroundPound()
                local pt = Vector3(inst.Transform:GetWorldPosition())
                TheWorld:DoTaskInTime(0.6,function() inst.spawnbarrier(inst,pt) end)
                local fx = SpawnPrefab("metal_hulk_ring_fx")
                fx.Transform:SetPosition(pt.x,pt.y,pt.z)
                
            end),
        },

        onexit = function(inst)
            inst.Transform:SetSixFaced()
            inst.barriertime = 10
            inst.components.ly_groundpounder.damageRings = 2
            inst.components.ly_groundpounder.destructionRings = 3
            inst.components.ly_groundpounder.numRings = 3            
        end, 

        events =
        {   
            EventHandler("animover", function(inst) 
                inst.sg:GoToState("idle")
            end ),        
        },
    },

	
	State
    {
        name = "activate",
        tags = { "busy","activating"},

        onenter = function(inst)
            --inst.components.locomotor:WalkForward()
			inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("activate")
        end,

        timeline = {
			
		},

        events =
        {
            EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
        },
    },
	
	State
    {
        name = "taunt",
        tags = {"busy","recharging"},

        onenter = function(inst)
			inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("recharge")
        end,
		
		onexit = function(inst)
			inst:AddTag("lightningrod")
		end,

        timeline = {
			TimeEvent(27 * FRAMES, function(inst)
				
				
				local target = inst.components.combat.target
				local z_speed = -4
				inst:StartThread(function()
					for i = 0,8 do 
						if target and target:IsValid() then 
							local bullet = SpawnAt("metal_hulk_bullet",inst:GetPosition()+Vector3(0,4,0))
							local offset = Vector3(GetRandomMinMax(-6,6),0,GetRandomMinMax(-6,6))
							bullet:InitSpeed(Vector3(0,10,(z_speed+i)*8))
							bullet.components.ly_projectile:Throw(inst,target:GetPosition()+offset,true)
						end 
						Sleep(0.1)
					end 
				end)
				if target and target:IsValid() then 
					DoLineLightning(inst,target:GetPosition())
				end 
				TheWorld:PushEvent("ms_sendlightningstrike", inst:GetPosition())
				ShakeAllCameras(CAMERASHAKE.FULL, .5, .02, .2, inst, 30)
            end),
			TimeEvent(32 * FRAMES, function(inst)
				inst:RemoveTag("lightningrod")
			end),
		},

        events =
        {
            EventHandler("animover", function(inst)
				inst.sg:GoToState("walk")
			end),
        },
    },
	
	State
    {
        name = "walk_start",
        tags = { "moving", "canrotate" },

        onenter = function(inst)
            --inst.components.locomotor:WalkForward()
            inst.AnimState:PlayAnimation("walk_pre")
        end,

        timeline = {
			TimeEvent(0*FRAMES, ShakeIfClose),
		},

        events =
        {
            EventHandler("animover", function(inst)
				if inst.AnimState:AnimDone() then
					inst.sg:GoToState("walk")
				end
			end),
        },
    },
	
	State
    {
        name = "walk",
        tags = { "moving", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:WalkForward()
            inst.AnimState:PlayAnimation("walk_loop")
            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
        end,

        timeline = {
			TimeEvent(12*FRAMES, function(inst)
				DoFootstep(inst)
            end),
            TimeEvent(16*FRAMES, function(inst)
                DoFootstep(inst)
            end),
            TimeEvent(20*FRAMES, function(inst) 
                --inst.SoundEmitter:PlaySoundWithParams("dontstarve_DLC003/creatures/boss/hulk_metal_robot/arm/step", {intensity=math.random()})
			end),
            TimeEvent(3*FRAMES, function(inst) 
               -- inst.SoundEmitter:PlaySoundWithParams("dontstarve_DLC003/creatures/boss/hulk_metal_robot/ribs/servo", {intensity=math.random()}) 
			end),
			--[[TimeEvent(0*FRAMES, ShakeIfClose),
			TimeEvent(8*FRAMES, function(inst) PlayFootstep(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/metal_robot/leg/step") end),
			TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/metal_robot/leg/servo") end),
			TimeEvent(20*FRAMES, ShakeIfClose),
			TimeEvent(20*FRAMES, function(inst) PlayFootstep(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/metal_robot/leg/step") end),
		--]]},

        ontimeout = function(inst)
			inst.sg:GoToState("walk")
			--inst.Physics:Stop()
		end,
    },
	
	State
    {
        name = "walk_stop",
        tags = { "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("walk_pst")
			DoFootstep(inst)
        end,

        --timeline = timelines ~= nil and timelines.endtimeline or nil,

        events =
        {
            EventHandler("animqueueover", function(inst)
				if inst.AnimState:AnimDone() then
					inst.sg:GoToState("idle")
				end
			end),
        },
    },
    
}

CommonStates.AddIdle(states,nil,"idle",{
	TimeEvent(0*FRAMES,function(inst)
		if inst.components.combat.target then  
			if inst.wantstobarrier then
				inst.wantstobarrier = nil
				inst.sg:GoToState("barrier")
			elseif inst.wantstolob then
				inst.wantstolob = nil
				inst.sg:GoToState("lob")
			elseif inst.wantstoteleport then
				inst.wantstoteleport = nil
				inst.sg:GoToState("telportout_pre")
			elseif inst.wantstomine then
				inst.wantstomine = nil
				inst.sg:GoToState("bomb_pre")
			end 
		end 
	end),
	TimeEvent(2*FRAMES, function(inst) 
        --inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/metal_robot/electro",nil,0.5)
    end),
    TimeEvent(5*FRAMES, function(inst) 
       -- inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/metal_robot/electro")
    end),
    TimeEvent(12*FRAMES, function(inst) 
		--inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/metal_robot/leg/servo")
	end),
	TimeEvent(12*FRAMES, function(inst) 
		--inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/metal_robot/leg/servo")
	end),
	TimeEvent(27*FRAMES, function(inst) 
		--inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/metal_robot/leg/servo_small",nil,0.5)
	end),
	TimeEvent(31*FRAMES, function(inst) 
		--inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/metal_robot/leg/servo_small",nil,0.5)
	end),
	TimeEvent(45*FRAMES, function(inst) 
		--inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/metal_robot/leg/servo",nil,0.6)
	end),
})

CommonStates.AddCombatStates(states,
{
    attacktimeline = 
    {        
		
		TimeEvent(1*FRAMES, function(inst)
			inst.sg.statemem.target = inst.components.combat.target
			--inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/metal_robot/leg/servo") 
			if inst.sg.statemem.target and inst.sg.statemem.target:IsValid() then 
				inst:ForceFacePoint(inst.sg.statemem.target:GetPosition():Get())
			end 
		end),
		
		TimeEvent(3*FRAMES, function(inst)
			--inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/metal_robot/head/attack")
			if inst.sg.statemem.target and inst.sg.statemem.target:IsValid() then 
				inst:ForceFacePoint(inst.sg.statemem.target:GetPosition():Get())
			end 
		end),
		
        TimeEvent(18*FRAMES, function(inst) 
			if inst.sg.statemem.target and inst.sg.statemem.target:IsValid() then 
				inst:ForceFacePoint(inst.sg.statemem.target:GetPosition():Get())
			end 
			local target = inst.sg.statemem.target
			if target and target:IsValid() then 
				local pos = target:GetPositionAdjacentTo(inst,5)
				inst.components.combat:DoAttack()
				inst:DoDamage(pos,3,TUNING.HULK_ATK/3)
				local ring = SpawnPrefab("laser_ring")
				ring.Transform:SetPosition(pos:Get())
				ShakePound(inst)
			end 
			inst.sg.statemem.target = nil 
		end),
		TimeEvent(50*FRAMES, function(inst) 
			--inst.components.combat:DoAreaAttack(inst,2) 
			inst.components.combat:DoAttack()
			ShakeIfClose(inst)
		end),
    },

    hittimeline =
    {
		TimeEvent(1*FRAMES, function(inst)
		end)
	},

    deathtimeline =
    {
        --[[TimeEvent(1*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/hide_hit") 
			--inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/taunt")
			inst.SoundEmitter:KillSound("gears")
		end),
		TimeEvent(2*FRAMES, function(inst) 
			inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/metal_robot/electro",nil,0.5)
		end),
		TimeEvent(11*FRAMES, ShakeIfClose),
			TimeEvent(11*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/deerclops/bodyfall_dirt") end),
			TimeEvent(11*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/hide_pre")
			--inst.SoundEmitter:PlaySound("dontstarve/impacts/impact_mech_med_sharp")
			end),
		TimeEvent(12*FRAMES, function(inst) 
			inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/metal_robot/electro",nil,0.5)
		end),
		TimeEvent(20*FRAMES, ShakeIfClose),
		TimeEvent(30*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/hide_hit") 
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/taunt")
		end),
		TimeEvent(60*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/hide_hit") 
		end),
		TimeEvent(62*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/metal_robot/leg/step")
		end),
		TimeEvent(66*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/hide_hit") 
		end),
		TimeEvent(72*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/hide_hit") 
		end),
		TimeEvent(74*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/metal_robot/leg/step")
		end),
		TimeEvent(78*FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/hide_hit") 		
		end),--]]
			TimeEvent(1*FRAMES, function(inst)
				inst.Physics:ClearCollisionMask()
			end),

            TimeEvent(81*FRAMES, function(inst) 
				ShakePound(inst)
                local x,y,z = inst.Transform:GetWorldPosition()
                SpawnPrefab("deerclops_laserscorch").Transform:SetPosition(x, 0, z) 
                SpawnPrefab("deerclops_laserscorch").Transform:SetPosition(x+1, 0, z-1)    
                SpawnPrefab("deerclops_laserscorch").Transform:SetPosition(x-1, 0, z+1)
                SpawnPrefab("deerclops_laserscorch").Transform:SetPosition(x+1, 0, z)
                SpawnPrefab("deerclops_laserscorch").Transform:SetPosition(x, 0, z+1)
                SpawnPrefab("deerclops_laserscorch").Transform:SetPosition(x, 0, z-1)
                SpawnPrefab("deerclops_laserscorch").Transform:SetPosition(x-1, 0, z)
                    

				inst:DoDamage(nil,5,TUNING.HULK_ATK*5)                  
            end),
    },
},
{
	attack = "atk_chomp",
	death = "death_explode",
}
)


return StateGraph("SGmetal_hulk_merge", states, events, "activate", actionhandlers)

