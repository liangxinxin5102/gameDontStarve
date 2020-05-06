
local trace = function() end

local assets=
{
	Asset("ANIM", "anim/hound_basic.zip"),
	--Asset("ANIM", "anim/hound.zip"),
	Asset("ANIM", "anim/ghosthound.zip"),
	--Asset("ANIM", "anim/hound_red.zip"),
	--Asset("ANIM", "anim/hound_ice.zip"),
	Asset("SOUND", "sound/hound.fsb"),
}

local prefabs =
{
	--"houndstooth",
	--"monstermeat",
	--"redgem",
	--"bluegem",
}
SetSharedLootTable( 'ghosth',
{
   -- {'houndstooth',  0.125},
})

local WAKE_TO_FOLLOW_DISTANCE = 5
--local SLEEP_NEAR_HOME_DISTANCE = 10
local SHARE_TARGET_DIST = 30
local HOME_TELEPORT_DIST = 30


local function close(inst)
local player = GetPlayer()
player.components.leader:AddFollower(inst)
inst.components.locomotor.runspeed = 11
 end

local function far(inst)
local player = GetPlayer()
local fx = SpawnPrefab("sparklefx")
player.components.leader:AddFollower(inst)
inst.components.locomotor.runspeed = 15
if inst:HasTag("remove") then
inst.components.health:DoDelta(-1000)
player.components.health:DoDelta(30)
fx.entity:SetParent(player.entity)
fx.Transform:SetScale(1, 2, 1)
fx.Transform:SetPosition(0.3, 0, 0)
end
end

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst) or (inst.components.follower and inst.components.follower.leader and not inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE))
end
--[[
local function ShouldSleep(inst)
    return inst:HasTag("pet_hound")
    and not GetClock():IsDay()
    and not (inst.components.combat and inst.components.combat.target)
    and not (inst.components.burnable and inst.components.burnable:IsBurning() )
    and (not inst.components.homeseeker or inst:IsNear(inst.components.homeseeker.home, SLEEP_NEAR_HOME_DISTANCE))
end

local function OnNewTarget(inst, data)
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end
]]--

local function OnNewTarget(inst, data)
    if data.target and data.target:HasTag("player") then
end
end

local function retargetfn(inst)
    local dist = TUNING.HOUND_TARGET_DIST
   -- if inst:HasTag("pet_hound") then
       -- dist = TUNING.HOUND_FOLLOWER_TARGET_DIST
        if inst.components.combat.target == inst.components.follower.leader then
            inst.components.combat:SetTarget(nil)
        end
        inst.components.follower:SetLeader(nil)
--[[
return FindEntity(inst, dist, function(guy) 
		return not guy:HasTag("wall") and not guy:HasTag("bird") and not guy:HasTag("animal") and not guy:HasTag("prey") and not guy:HasTag("beefalo") and not guy:HasTag("structure") and not guy:HasTag("companion") and not guy:HasTag("worker") and not guy:HasTag("chester") and not guy:HasTag("player") and inst.components.combat:CanTarget(guy)
    end)
]]--
end

--[[    
return FindEntity(inst, dist, function(guy) 
		return not guy:HasTag("wall") and not guy:HasTag("houndmound") and not (guy:HasTag("hound") or guy:HasTag("houndfriend")) and inst.components.combat:CanTarget(guy)
    end)
end
end

]]--
local function KeepTarget(inst, target)
    return inst.components.combat:CanTarget(target) and (not inst:HasTag("pet_hound") or inst:IsNear(target, TUNING.HOUND_FOLLOWER_TARGET_KEEP))
end

local function OnAttacked(inst, data)

    inst.components.combat:SuggestTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 10, function(dude) return dude:HasTag("companion") and not dude.components.health:IsDead() end, 5)

end

--[[
local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, SHARE_TARGET_DIST, function(dude) return dude:HasTag("hound") or dude:HasTag("houndfriend") and not dude.components.health:IsDead() end, 5)
end

local function OnAttackOther(inst, data)
    inst.components.combat:ShareTarget(data.target, SHARE_TARGET_DIST, function(dude) return dude:HasTag("hound") or dude:HasTag("houndfriend") and not dude.components.health:IsDead() end, 5)
end

local function GetReturnPos(inst)
    local rad = 2
    local pos = inst:GetPosition()
    trace("GetReturnPos", inst, pos)
    local angle = math.random()*2*PI
    pos = pos + Point(rad*math.cos(angle), 0, -rad*math.sin(angle))
    trace("    ", pos)
    return pos:Get()
end

local function DoReturn(inst)
    --print("DoReturn", inst)
    if inst.components.homeseeker and inst.components.homeseeker:HasHome()  then
        if inst:HasTag("pet_hound") then
            if inst.components.homeseeker.home:IsAsleep() and not inst:IsNear(inst.components.homeseeker.home, HOME_TELEPORT_DIST) then
                local x, y, z = GetReturnPos(inst.components.homeseeker.home)
                inst.Physics:Teleport(x, y, z)
                trace("hound warped home", x, y, z)
            end
        elseif inst.components.homeseeker.home.components.childspawner then
            inst.components.homeseeker.home.components.childspawner:GoHome(inst)
        end
    end
end
]]--
--[[
local function OnNight(inst)
    --print("OnNight", inst)
    if inst:IsAsleep() then
        DoReturn(inst)  
    end
end


local function OnEntitySleep(inst)
    --print("OnEntitySleep", inst)
    if not GetClock():IsDay() then
        DoReturn(inst)
    end
end
]]--
local function OnSave(inst, data)
    data.ispet = inst:HasTag("pet_hound")
    --print("OnSave", inst, data.ispet)
end
        
local function OnLoad(inst, data)
    --print("OnLoad", inst, data.ispet)
    if data and data.ispet then
        inst:AddTag("pet_hound")
        inst:AddComponent("follower")
        if inst.sg then
            inst.sg:GoToState("idle")
        end
    end
end

local function fncommon()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.9, 0.9 )
    inst.Transform:SetFourFaced()
	
	--inst:AddTag("scarytoprey")
    --inst:AddTag("monster")
    --inst:AddTag("hostile")
    --inst:AddTag("hound")
    inst:AddTag("houndmound")
        inst:AddTag("companion")
	inst:AddTag("notraptrigger")
    inst:AddTag("character")

    MakeCharacterPhysics(inst, 10, .5)
     
    anim:SetBank("hound")
    anim:SetBuild("ghosthound")
    anim:PlayAnimation("idle")
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = TUNING.HOUND_SPEED
    inst:SetStateGraph("SGhound")


  --  local brain = require "brains/houndbrain"
    local brain = require "brains/ghosthoundbrain"
    inst:SetBrain(brain)
    
    inst:AddComponent("eater")
--    inst.components.eater:SetCarnivore()
--	inst.components.eater:SetCanEatHorrible()

    inst.components.eater.strongstomach = true -- can eat monster meat!
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.HOUND_HEALTH)
    
   -- inst:AddComponent("sanityaura")
    --inst.components.sanityaura.aura = -TUNING.SANITYAURA_MED
    
    
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.HOUND_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.HOUND_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(3, retargetfn)
   -- inst.components.combat:SetKeepTargetFunction(KeepTarget)
	inst:ListenForEvent("attacked", OnAttacked)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('ghosth')
    
    inst:AddComponent("inspectable")
    --[[
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
    inst:ListenForEvent("newcombattarget", OnNewTarget)

    inst:ListenForEvent( "dusktime", function() OnNight( inst ) end, GetWorld()) 
    inst:ListenForEvent( "nighttime", function() OnNight( inst ) end, GetWorld()) 
    inst.OnEntitySleep = OnEntitySleep

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("onattackother", OnAttackOther)
]]--

    return inst
end

--[[
local function fndefault()
	local inst = fncommon(Sim)
	
    MakeMediumFreezableCharacter(inst, "hound_body")
    MakeMediumBurnableCharacter(inst, "hound_body")
	return inst
end

local function fnfire(Sim)
	local inst = fncommon(Sim)
	inst.AnimState:SetBuild("hound_red")
	
    MakeMediumFreezableCharacter(inst, "hound_body")
    inst.components.freezable:SetResistance(4) --because fire

    inst.components.combat:SetDefaultDamage(TUNING.FIREHOUND_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.FIREHOUND_ATTACK_PERIOD)
    inst.components.locomotor.runspeed = TUNING.FIREHOUND_SPEED
    inst.components.health:SetMaxHealth(TUNING.FIREHOUND_HEALTH)
    inst.components.lootdropper:SetChanceLootTable('hound_fire')

	inst:ListenForEvent("death", function(inst)
		inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/firehound_explo", "explosion")
	end)
	
	return inst
end

local function fncold(Sim)
	local inst = fncommon(Sim)
	inst.AnimState:SetBuild("hound_ice")

    MakeMediumBurnableCharacter(inst, "hound_body")

    inst.components.combat:SetDefaultDamage(TUNING.ICEHOUND_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.ICEHOUND_ATTACK_PERIOD)
    inst.components.locomotor.runspeed = TUNING.ICEHOUND_SPEED
    inst.components.health:SetMaxHealth(TUNING.ICEHOUND_HEALTH)
    inst.components.lootdropper:SetChanceLootTable('hound_cold')
	
	inst:ListenForEvent("death", function(inst)
		inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/icehound_explo", "explosion")
	end)

	return inst
end
]]--
----------add
local function Onfreeze(attacked, data)
        if data and data.attacker and data.attacker.components.freezable then
            data.attacker.components.freezable:AddColdness(1)
            data.attacker.components.freezable:SpawnShatterFX()
        end 
    end

local function fnghost(Sim)
	local inst = fncommon(Sim)
	local player = GetPlayer()
	inst.AnimState:SetBuild("ghosthound")
    inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )

    MakeMediumBurnableCharacter(inst, "hound_body")
    inst.entity:AddLight()
	inst.Light:SetRadius(.3)
    inst.Light:SetFalloff(.5)
    inst.Light:SetIntensity(.3)
    inst.Light:SetColour(15/255,15/255,15/255)
	inst.Light:Enable(true)

    inst.Transform:SetScale(0.6, 0.6, 0.6)

        inst:AddTag("companion")
	inst:AddTag("notraptrigger")
    inst:AddTag("character")
--------------------
        inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(5, 8)
    inst.components.playerprox:SetOnPlayerNear(close)
    inst.components.playerprox:SetOnPlayerFar(far)
    inst:AddComponent("follower")

    ------------------------------------------

    inst.components.combat:SetDefaultDamage(TUNING.HOUND_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.ICEHOUND_ATTACK_PERIOD)
    inst.components.locomotor.runspeed = TUNING.HOUND_SPEED  * 1.2  inst.components.health:SetMaxHealth(200)
    inst.components.lootdropper:SetChanceLootTable('ghosth')
	
	inst:ListenForEvent("death", function(inst)
		inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/icehound_explo", "explosion")
	end)
    inst:ListenForEvent("attacked", Onfreeze)

player.components.leader:AddFollower(inst)
-------
 if ACTIONS.STAYORDER~= nil then
    inst:AddComponent("staycommand")
    	end
-------

	return inst
end

-------------
--[[
local function fnfiredrop(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
    MakeInventoryPhysics(inst)

    MakeLargeBurnable(inst, 6+ math.random()*6)
    MakeLargePropagator(inst)
    inst.components.burnable:Ignite()
    return inst
end
]]--

return Prefab ( "ghosthound", fnghost, assets, prefabs) 

