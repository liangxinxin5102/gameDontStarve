require "prefabutil"
local brain = require "brains/mushasmallbrain"

local WAKE_TO_FOLLOW_DISTANCE = 5
local SLEEP_NEAR_LEADER_DISTANCE = 2
local CRY_NEAR_LEADER_DISTANCE = 15

local assets =
{
	Asset("ANIM", "anim/musha_small.zip"),
    	Asset("ANIM", "anim/hat_yamche.zip"),
	Asset("ATLAS", "images/inventoryimages/musha_small.xml"),
	Asset("IMAGE", "images/inventoryimages/musha_small.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_teen.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_tall.tex"),

}

local prefabs=
{
"hat_yamche",
    "musha_small",
    "musha_teen",
    "musha_tall",
    "musha_tall2",
    "musha_tall3",
    "musha_tall4",
    "musha_tall5",
	"willowfire",
    "poop",
    "campfirefire",
}

local teen_assets =
{
	Asset("ANIM", "anim/musha_teen.zip"),
	Asset("ATLAS", "images/inventoryimages/musha_teen.xml"),
}

local tall_assets =
{
	Asset("ANIM", "anim/musha_tall.zip"),
	Asset("ATLAS", "images/inventoryimages/musha_tall.xml"),
}

local tall2_assets =
{
	Asset("ANIM", "anim/musha_tall2.zip"),
	Asset("ATLAS", "images/inventoryimages/musha_tall2.xml"),
}
local tall3_assets =
{
	Asset("ANIM", "anim/musha_tall3.zip"),
	Asset("ATLAS", "images/inventoryimages/musha_tall3.xml"),
}
local tall4_assets =
{
	Asset("ANIM", "anim/musha_tall4.zip"),
	Asset("ATLAS", "images/inventoryimages/musha_tall4.xml"),
}
local tall5_assets =
{
	Asset("ANIM", "anim/musha_tall5.zip"),
	Asset("ATLAS", "images/inventoryimages/musha_tall5.xml"),
}


ACTIONS.MURDER.fn = function(act)
    local murdered = act.invobject or act.target
    if murdered and murdered.components.health and not murdered:HasTag("baby") then
                
        murdered.components.inventoryitem:RemoveFromOwner(true)

        if murdered.components.health.murdersound then
            act.doer.SoundEmitter:PlaySound(murdered.components.health.murdersound)
        end

        local stacksize = 1
        if murdered.components.stackable then
            stacksize = murdered.components.stackable.stacksize
        end

        if murdered.components.lootdropper then
            for i = 1, stacksize do
                local loots = murdered.components.lootdropper:GenerateLoot()
                for k, v in pairs(loots) do
                    local loot = SpawnPrefab(v)
                    act.doer.components.inventory:GiveItem(loot)
                end      
            end
        end
        act.doer:PushEvent("killed", {victim = murdered})
        murdered:Remove()

        return true
    end
end

----------------
local freezechance = 0.5

---------------------------
local function levelexp(inst,data)

	local max_exp = 300
	local exp = math.min(inst.level, max_exp)
	local hunger_percent = inst.components.hunger:GetPercent()
	local health_percent = inst.components.health:GetPercent()
--[[
if inst:HasTag("level1") then
	inst.components.hunger.max = math.ceil (30 + exp* 1)
	inst.components.health.maxhealth = math.ceil (150 + exp* 1)
elseif inst:HasTag("level2") then
	inst.components.hunger.max = math.ceil (60 + exp* 1)
	inst.components.health.maxhealth = math.ceil (300 + exp* 1)
elseif inst:HasTag("level3") then
	inst.components.hunger.max = math.ceil (70 + exp* 1)
	inst.components.health.maxhealth = math.ceil (400 + exp* 1)
elseif inst:HasTag("level4") then
	inst.components.hunger.max = math.ceil (80 + exp* 1)
	inst.components.health.maxhealth = math.ceil (500 + exp* 1)
elseif inst:HasTag("level5") then
	inst.components.hunger.max = math.ceil (90 + exp* 1)
	inst.components.health.maxhealth = math.ceil (600 + exp* 1)
elseif inst:HasTag("level6") then
	inst.components.hunger.max = math.ceil (110 + exp* 1)
	inst.components.health.maxhealth = math.ceil (750 + exp* 1)
elseif inst:HasTag("level7") then
	inst.components.hunger.max = math.ceil (130 + exp* 1)
	inst.components.health.maxhealth = math.ceil (900 + exp* 1)
end
]]--
if inst:HasTag("level7") then
	inst.components.hunger.max = math.ceil (130 + exp* 1)
	inst.components.health.maxhealth = math.ceil (900 + exp* 1)
end

inst.components.talker:Say("[EXP] ".. (inst.level))
	if inst.level <1 then
    		--inst.components.growable:StopGrowing()
	inst.components.talker:Say("[EXP] ".. (inst.level))

elseif inst.level >0 and inst.level <1 and inst:HasTag("level1") and not inst:HasTag("baby") then
inst.components.talker:Say("Next :EXP[2]\n[EXP] ".. (inst.level))
	elseif inst.level >1 and inst:HasTag("level1") and not inst:HasTag("baby") then
    		inst.components.growable:StartGrowing()
	inst.components.talker:Say("[Grow up]")
elseif inst.level >0 and inst.level <9 and inst:HasTag("level2") then
inst.components.talker:Say("Next :EXP[10]\n[EXP] ".. (inst.level))
	elseif inst.level >9 and inst:HasTag("level2") then
    		inst.components.growable:StartGrowing()
	inst.components.talker:Say("[Grow up]")
elseif inst.level >0 and inst.level <24 and inst:HasTag("level3") then
inst.components.talker:Say("Next :EXP[25]\n[EXP] ".. (inst.level))
	elseif inst.level >24 and inst:HasTag("level3") then
    		inst.components.growable:StartGrowing()
	inst.components.talker:Say("[Grow up]")
elseif inst.level >0 and inst.level <39 and inst:HasTag("level4") then
inst.components.talker:Say("Next :EXP[40]\n[EXP] ".. (inst.level))
	elseif inst.level >39 and inst:HasTag("level4") then
    		inst.components.growable:StartGrowing()
	inst.components.talker:Say("[Grow up]")
elseif inst.level >0 and inst.level <54 and inst:HasTag("level5") then
inst.components.talker:Say("Next :EXP[55]\n[EXP] ".. (inst.level))
	elseif inst.level >54 and inst:HasTag("level5") then
    		inst.components.growable:StartGrowing()
	inst.components.talker:Say("[Grow up]")
elseif inst.level >0 and inst.level <69 and inst:HasTag("level6") then
inst.components.talker:Say("Next :EXP[70]\n[EXP] ".. (inst.level))
	elseif inst.level >69 and inst:HasTag("level6") then
    		inst.components.growable:StartGrowing()
	inst.components.talker:Say("[Grow up]")
--elseif inst.level <84 and inst:HasTag("level7") then
--inst.components.talker:Say("Next :EXP[85]\n[EXP] ".. (inst.level))
	--elseif inst.level >84 and inst:HasTag("level7") then
    	--	inst.components.growable:StartGrowing()
	--inst.components.talker:Say("Level 7\n [Grow up]")

 		elseif inst.level >199 and inst.level <= 200 then
inst.components.talker:Say("Get Ability\n Unlock : [Cure]\n1/2")
	inst:AddTag("cure1")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
		elseif inst.level >299 then
inst.components.talker:Say("Get Ability\n Unlock : [Cure Master]\n2/2")
	inst:RemoveTag("cure1")
	inst:AddTag("cure2")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")

	end
	inst.components.hunger:SetPercent(hunger_percent)
	inst.components.health:SetPercent(health_percent)
	end


local normalchance = .75
local largechance = 1

local function onkilll(inst, data)
	if data.cause == inst.prefab and not data.inst:HasTag("companion") then
                if math.random() < largechance and data.inst:HasTag("smallcreature") then 
        			inst.level = inst.level + 1
	levelexp(inst)	

	elseif math.random() < largechance and data.inst:HasTag("largecreature") then 
    				inst.level = inst.level + 1
	levelexp(inst)
    			 end
		          end
			end

local function onpreload(inst, data)
	if data then
		if data.level then
		inst.level = data.level
			levelexp(inst)
			if data.health and data.health.health then inst.components.health.currenthealth = data.health.health end
			if data.hunger and data.hunger.hunger then inst.components.hunger.current = data.hunger.hunger end
			inst.components.health:DoDelta(0)
			inst.components.hunger:DoDelta(0)

end

	end
		end

local function onsave(inst, data)
	data.level = inst.level
	data.charge_time = inst.charge_time
end

local function onpreload(inst, data)
	if data then
		if data.level then
		inst.level = data.level
			levelexp(inst)
end
	end
		end

local function onsave(inst, data)
	data.level = inst.level
	data.charge_time = inst.charge_time
end

------------

    local function cure1_proc(inst, data)
local player = GetPlayer()

	if inst.components.hunger.current > 20 then
        inst.components.health:DoDelta(300)
        player.components.health:DoDelta(150)
        inst.components.hunger:DoDelta(-20)
        local fx = SpawnPrefab("sparklefx")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1.3, 1.3, 1.3)
        fx.Transform:SetPosition(0, -0.2, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
        fx:ListenForEvent("blocked", fx_hitanim, inst)
        inst.active = true
        inst:DoTaskInTime(--[[Duration]] 5, function()
            fx:RemoveEventCallback("blocked", fx_hitanim, inst)
            if inst:IsValid() then
                inst:DoTaskInTime(--[[Cooldown]] 1800, function() inst.active = false 			end)
            end
        end)
    end
end
    local function cure2_proc(inst, data)
local player = GetPlayer()

	if inst.components.hunger.current > 20 then
        inst.components.health:DoDelta(300)
        player.components.health:DoDelta(150)
        inst.components.hunger:DoDelta(-20)
        local fx = SpawnPrefab("sparklefx")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1.3, 1.3, 1.3)
        fx.Transform:SetPosition(0, -0.2, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
        fx:ListenForEvent("blocked", fx_hitanim, inst)
        inst.active = true
        inst:DoTaskInTime(--[[Duration]] 5, function()
            fx:RemoveEventCallback("blocked", fx_hitanim, inst)
            if inst:IsValid() then
                inst:DoTaskInTime(--[[Cooldown]] 900, function() inst.active = false 			end)
            end
        end)
    end
end

------------

local function GetStatus(inst)
    --print("smallbird - GetStatus")
    if inst.components.hunger then
        if inst.components.hunger:IsStarving(inst) then
            --print("STARVING")
            return "STARVING"
        elseif inst.components.hunger:GetPercent() < .5 then
            --print("HUNGRY")
            return "HUNGRY"
        end
	end
end

------------

    local function heal_proc(inst, data)
	if inst.components.hunger.current > 50 then
        inst:AddTag("forcefield")
        inst.components.health:DoDelta(30)
        inst.components.hunger:DoDelta(-5)
        local fx = SpawnPrefab("shock_fx2")
    inst.SoundEmitter:PlaySound("dontstarve/common/lightningrod")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1, 1, 1)
        fx.Transform:SetPosition(0, 0, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
        fx:ListenForEvent("blocked", fx_hitanim, inst)
        inst.active = true
        inst:DoTaskInTime(--[[Duration]] 1, function()
            fx:RemoveEventCallback("blocked", fx_hitanim, inst)
           -- fx.kill_fx(fx)
            if inst:IsValid() then
                inst:RemoveTag("forcefield")
                inst:DoTaskInTime(--[[Cooldown]] 3, function() inst.active = false end)
            end
        end)
    end
end

    local function tryproc(inst)
        if not inst.active and math.random() < 0.3 then
           heal_proc(inst)
 elseif inst.components.health:GetPercent() < .15  and inst:HasTag("cure1") then
           cure1_proc(inst)
 elseif inst.components.health:GetPercent() < .15  and inst:HasTag("cure2") then
           cure2_proc(inst)

        end
    end

------------------    
----------hat

local function OnPutInInventory(inst)
    inst.components.growable:StopGrowing()
   inst:AddTag("baby")
   inst:RemoveTag("level1")
    inst:AddTag("hat")

end

local function OnDropped(inst,data)
   inst:AddTag("level1")
   inst:RemoveTag("baby")
   inst:RemoveTag("hat")

local drop = SpawnPrefab("musha_small")
drop.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    if inst.components.follower.leader then
        drop.components.follower:SetLeader(inst.components.follower.leader)
	drop.components.hunger:DoDelta(-10)
    end
    inst.components.health:DoDelta(-2000)
    inst:Remove()
end


    local function onyamche(inst, owner)
    inst.components.growable:StopGrowing()
    inst:AddTag("onyamche") 
    inst:RemoveTag("level1")
    inst:AddTag("baby")
    inst:AddTag("hat")

     owner.AnimState:OverrideSymbol("swap_hat", "hat_yamche", "swap_hat")
        owner.AnimState:Show("HAT")
       -- owner.AnimState:Show("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")

    end

    local function offyamche(inst, owner)
   inst:AddTag("level1")
   inst:RemoveTag("baby")
inst:RemoveTag("onyamche") 
         owner.AnimState:Hide("HAT")
        owner.AnimState:Hide("HAT_HAIR")
        owner.AnimState:Show("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")
   inst:RemoveTag("hat")

    inst.entity:AddLight()
	inst.Light:SetRadius(.3)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(10/255,125/255,125/255)
	inst.Light:Enable(false)

    end


 --[[
 local function onuseyamche(inst)
	inst.Light:Enable(true)
    end
 local function offuseyamche(inst)
    end
]]--
-------------

local function close(inst)
local player = GetPlayer()
	inst.components.locomotor.walkspeed = 4
player.components.leader:AddFollower(inst)
 end

local function far(inst)
	inst.components.locomotor.walkspeed = 9
if inst:HasTag("animal") then
inst.components.follower:SetLeader(nil)
end
end

-----------------------
local function onignite(inst)
inst.components.burnable:AddBurnFX("campfirefire", Vector3(0,.1,0) )
end

local function onextinguish(inst)
    if inst.components.fueled then
        inst.components.fueled:InitializeFuelLevel(0)

    end
end

local function OnOpen(inst)
    if not inst.components.health:IsDead() then
        inst.sg:GoToState("open")
    end
end 

local function OnClose(inst) 
    if not inst.components.health:IsDead() then
        inst.sg:GoToState("close")
    end
end 

local slotpos_6 = {}

for y = 3, 0, -1 do
    for x = 0, 3 do
        table.insert(slotpos_6, Vector3(60*x-60*2+30, 60*y-60*2+30,0))
    end
end

local slotpos_5 = {}

for y = 3, 0, -1 do
    for x = 0, 2 do
        table.insert(slotpos_5, Vector3(75*x-75*2+75, 60*y-60*2+32,0))
    end
end

local slotpos_4 = {}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(slotpos_4, Vector3(80*x-80*2+80, 80*y-80*2+80,0))
    end
end

local slotpos_3 = {}

for y = 2, 0, -1 do
    for x = 0, 1 do
        table.insert(slotpos_3, Vector3(80*x-80*2+78, 80*y-80*2+80,0))
    end
end

local slotpos_2 = {}

for y = 1, 0, -1 do
    for x = 0, 1 do
        table.insert(slotpos_2, Vector3(80*x-80*2+78, 80*y-80*2+80,0))
    end
end

local slotpos_1 = {}

for y = 1, 0, -1 do
        table.insert(slotpos_1, Vector3(74*y-74*2+70, 0))

end


local function itemtest(inst, item, slot)
	if not item:HasTag("tstone") then
			return true
end
end

local function PhoenixSanityAura(inst, observer)
		if inst.components.hunger:GetPercent() <= .25 then
		return -TUNING.SANITYAURA_SMALL
	end
	if inst.components.hunger:GetPercent() <= .6 then
		return 0
	end
--[[
	if inst.components.hunger:GetPercent() <= .5 then
			return -TUNING.SANITYAURA_TINY
	end
	if inst.components.hunger:GetPercent() >= .5 then
			return TUNING.SANITYAURA_TINY
	end
]]--
	if inst.components.hunger:GetPercent() >= .6 then
			return TUNING.SANITYAURA_TINY
	end

	if inst.components.hunger:GetPercent() >= .9 then
			return TUNING.SANITYAURA_TINY
	end

	if inst.components.follower and inst.components.follower.leader == observer then
		--return TUNING.SANITYAURA_TINY
		return 0
	end
	
	return 0
end

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst) or inst.components.hunger:IsStarving(inst) or not inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE)
end

local function ShouldSleep(inst)
    return DefaultSleepTest(inst) and not inst.components.hunger:IsStarving(inst) and inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE)
end

local function CanEatTest(inst, item)
    --print("smallbird - CanEatTest", inst.name, item.components.edible.foodtype, item, item.prefab)
    local canEat = (item.components.edible.foodtype == "SEEDS") or (item.prefab == "berries")
    --print("   canEat?", canEat)
    return canEat
end

local function ShouldAcceptItem(inst, item)
    --print("smallbird - ShouldAcceptItem", inst.name, item.name)
    if item.components.edible and inst.components.hunger and inst.components.eater then
        return inst.components.eater:CanEat(item) and inst.components.hunger:GetPercent() < .9
    end
end

local function OnGetItemFromPlayer(inst, giver, item)
    --print("smallbird - OnGetItemFromPlayer")

    if inst.components.sleeper then
        inst.components.sleeper:WakeUp()
    end

    --I eat food
    if item.components.edible then

        if inst.components.combat.target and inst.components.combat.target == giver then
            inst.components.combat:SetTarget(nil)
elseif giver.components.leader then
inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/scratch_ground")
giver.components.leader:AddFollower(inst)
        end
        if inst.components.eater:Eat(item) then
	--inst.components.talker:Say("Zzu zu")
            --print("   yummy!")

        end
    end


--[[
        if item.components.edible.foodtype == "MEAT" then
			local last_eat_time = inst.components.eater:TimeSinceLastEating()
			if last_eat_time and last_eat_time < TUNING.PIG_MIN_POOP_PERIOD then        
				return false
			end
end
]]--
end
local poopchance2 = 0.6
local poopchance = 0.4
local rebackchance = 0.2
local tynychance = 0.1
local tynyychance = 0.05

local function OnEat(inst, food)

if food.components.edible and math.random() < largechance and not inst:HasTag("baby") and food.components.edible.hungervalue > 140 then 
	inst.level = inst.level + 1
	levelexp(inst)
elseif food.components.edible and math.random() < normalchance and not inst:HasTag("baby") and food.components.edible.hungervalue > 74  then 
	inst.level = inst.level + 1
	levelexp(inst)
elseif food.components.edible and math.random() < poopchance2 and not inst:HasTag("baby") and food.components.edible.hungervalue > 50  then 
	inst.level = inst.level + 1
	levelexp(inst)
elseif food.components.edible and math.random() < poopchance and not inst:HasTag("baby") and food.components.edible.hungervalue > 20  then 
	inst.level = inst.level + 1
	levelexp(inst)
elseif food.components.edible and math.random() < tynychance and not inst:HasTag("baby") and food.components.edible.hungervalue > 9  then 
	inst.level = inst.level + 1
	levelexp(inst)
elseif food.components.edible and math.random() < tynychance and not inst:HasTag("baby") and food.components.edible.hungervalue <= 9  then 
	inst.level = inst.level + 1
	levelexp(inst)
elseif food.components.edible and math.random() < poopchance2 and not inst:HasTag("baby") and food.components.edible.healthvalue > 39 then 
	inst.level = inst.level + 1
	levelexp(inst)
elseif food.components.edible and math.random() < poopchance and not inst:HasTag("baby") and food.components.edible.healthvalue > 19 then 
	inst.level = inst.level + 1
	levelexp(inst)
elseif food.components.edible and math.random() < tynychance and not inst:HasTag("baby") and food.components.edible.healthvalue > 8 then 
	inst.level = inst.level + 1
	levelexp(inst)
end

    -- food heal
    if inst:HasTag("companion") then
        inst.components.health:DoDelta(inst.components.health.maxhealth * .05, nil, food.prefab)
        inst.components.combat:SetTarget(nil)
    else
        inst.components.health:DoDelta(inst.components.health.maxhealth, nil, food.prefab)
    end
    -- VEGGIE -- MEAT -- SEEDS
    if food.components.edible and food.components.edible.foodtype == "MEAT" then
    if math.random() < poopchance then
		local poo = SpawnPrefab("guano")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < rebackchance then
		local poo = SpawnPrefab("poop")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("spoiled_food")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("wetgoop")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("ash")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < tynyychance then
		local poo = SpawnPrefab("glowdust")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
	end
	end

    if food.components.edible and food.components.edible.hungervalue > 141 and food.components.edible.healthvalue > 91 then
inst.components.health:DoDelta(400)
    if math.random() < poopchance then
		local poo = SpawnPrefab("orangegem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("greengem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("yellowgem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("purplegem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		

	end
	end

    if food.components.edible and food.components.edible.hungervalue > 145 or food.components.edible.healthvalue > 39 then
inst.components.health:DoDelta(500)
    if math.random() < rebackchance then
		local poo = SpawnPrefab("goldnugget")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < tynychance then
		local poo = SpawnPrefab("redgem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < tynychance then
		local poo = SpawnPrefab("bluegem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < tynychance then
		local poo = SpawnPrefab("purplegem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < tynychance then
		local poo = SpawnPrefab("thulecite")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		

	end
	end

    if food.components.edible and food.components.edible.hungervalue > 59 or food.components.edible.healthvalue > 29 or food.components.edible.sanityvalue > 14 then
inst.components.health:DoDelta(300)
    if math.random() < rebackchance then
		local poo = SpawnPrefab("goldnugget")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    elseif math.random() < rebackchance then
		local poo = SpawnPrefab("glowdust")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < rebackchance then
		local poo = SpawnPrefab("lightbulb")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < rebackchance then
		local poo = SpawnPrefab("wormlight")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < rebackchance then
		local poo = SpawnPrefab("thulecite_pieces")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		

	end
	end

    if food.components.edible and food.components.edible.hungervalue > 24 or food.components.edible.healthvalue > 9 or food.components.edible.sanityvalue > 4 then
inst.components.health:DoDelta(100)
    if math.random() < rebackchance then
		local poo = SpawnPrefab("poop")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < rebackchance then
		local poo = SpawnPrefab("Charcoal")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < rebackchance then
		local poo = SpawnPrefab("rottenegg")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    elseif math.random() < tynychance then
		local poo = SpawnPrefab("lightbulb")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < tynychance then
		local poo = SpawnPrefab("wormlight")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < rebackchance then
		local poo = SpawnPrefab("houndstooth")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		

	end
	end

    if food.components.edible and food.components.edible.foodtype == "VEGGIE" then
    if math.random() < poopchance then
		local poo = SpawnPrefab("seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("carrot_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("pumpkin_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("dragonfruit_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("pomegranate_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("corn_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("durian_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("eggplant_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    elseif math.random() < tynychance then
		local poo = SpawnPrefab("glowdust")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("ash")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
	end
	end

    if food.components.edible and food.components.edible.foodtype == "SEEDS" then
    if math.random() < poopchance then
		local poo = SpawnPrefab("ash")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
	end
	end

if food and food.components.edible and food.components.edible.foodtype == "ELEMENTAL" and inst:HasTag("musha_tall3") then
    if math.random() < tynychance then
	if inst.components.container then
	inst.components.container:DropEverything() 
		local poo = SpawnPrefab("musha_egg1")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    inst.components.health:DoDelta(-2000)
    inst:Remove()
end
end
end
if food and food.components.edible and food.components.edible.foodtype == "ELEMENTAL" and inst:HasTag("musha_tall4") then
    if math.random() < tynychance then
	if inst.components.container then
	inst.components.container:DropEverything() 
		local poo = SpawnPrefab("musha_egg2")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    inst.components.health:DoDelta(-2000)
    inst:Remove()
end
end
end
if food and food.components.edible and food.components.edible.foodtype == "ELEMENTAL" and inst:HasTag("musha_tall5") then
    if math.random() < tynychance then
	if inst.components.container then
	inst.components.container:DropEverything() 
		local poo = SpawnPrefab("musha_egg3")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    inst.components.health:DoDelta(-2000)
    inst:Remove()
end
end
end

if food and food.components.edible and food.components.edible.foodtype == "ELEMENTAL" then
    if math.random() < poopchance then
		local poo = SpawnPrefab("goldnugget")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    elseif math.random() < rebackchance then
		local poo = SpawnPrefab("glowdust")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("rocks")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("nitre")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("flint")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("ash")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("thulecite_pieces")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < tynychance then
		local poo = SpawnPrefab("bluegem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    elseif math.random() < tynychance then
		local poo = SpawnPrefab("redgem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
	end
	end
	end

local function OnRefuseItem(inst, item)
    inst.sg:GoToState("refuse")
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
end
end

local function FollowPlayer(inst)
	local player = GetPlayer()
	if player and player.components.leader then
		player.components.leader:AddFollower(inst)
	end
end

local function SetTeenAttackDefault(inst)
    --print("teenbird - Set phasers to 'KILL'")
    inst:RemoveTag("peck_attack")
    --inst.components.combat:SetDefaultDamage(TUNING.TEENBIRD_DAMAGE)
    --inst.components.combat:SetAttackPeriod(TUNING.TEENBIRD_ATTACK_PERIOD)
end

local function SetTeenAttackPeck(inst)
    --print("teenbird - Set phasers to 'PECK'")
    inst:AddTag("peck_attack")
    --inst.components.combat:SetDefaultDamage(TUNING.TEENBIRD_DAMAGE_PECK)
    --inst.components.combat:SetAttackPeriod(TUNING.TEENBIRD_PECK_PERIOD)
end

local function OnNewTarget(inst, data)
    --print("teenbird - OnNewTarget", data.target, inst.components.follower.leader)
    if data.target and data.target:HasTag("player") then
        -- combat component will restore target to player, give them the benefit of 
--[[
the doubt and use peck instead of attack to begin with
        SetTeenAttackPeck(inst)
    else
        SetTeenAttackDefault(inst)
    end
]]--
end
end
--[[
local function TeenRetarget(inst)
    return FindEntity(inst, TUNING.TEENBIRD_TARGET_DIST, function(guy)
        if inst.components.combat:CanTarget(guy)  and (not guy.LightWatcher or guy.LightWatcher:IsInLight()) then
            if inst.components.follower.leader ~= nil then
                return (guy:HasTag("monster") or (guy == inst.components.follower.leader and guy:HasTag("player") and inst.components.hunger and inst.components.hunger:IsStarving()))
            else
                return guy:HasTag("monster")
            end
        end
    end)
end

local function TeenKeepTarget(inst, target)
    return inst.components.combat:CanTarget(target) and (not target.LightWatcher or target.LightWatcher:IsInLight())
end
]]--
local function OnAttacked(inst, data)

    inst.components.combat:SuggestTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 3, function(dude) return dude:HasTag("companion") and not dude.components.health:IsDead() end, 5)


end
--[[
]]--
local function OnHitfire(inst, data)
    local other = data.target
    if other and other.components.burnable then
        other.components.burnable:Ignite()
    end
    if other and other.components.freezable and math.random() < freezechance then
        other.components.freezable:AddColdness(2)
        other.components.freezable:SpawnShatterFX()
    end
    if other.components.burnable and other.components.burnable:IsBurning() then
        other.components.burnable:Extinguish()
    end
end
--[[
local function OnHitfreeze(inst, data)
    local other = data.target
    if other and other.components.freezable then
        other.components.freezable:AddColdness(0.5)
        other.components.freezable:SpawnShatterFX()
    end
    if other.components.burnable and other.components.burnable:IsBurning() then
        other.components.burnable:Extinguish()
    end
end
]]--
local function Onfreeze(attacked, data)
        if data and data.attacker and data.attacker.components.freezable then
            data.attacker.components.freezable:AddColdness(0.25)
            data.attacker.components.freezable:SpawnShatterFX()
        end 
    if data.attacker.components.burnable and data.attacker.components.burnable:IsBurning() then
        data.attacker.components.burnable:Extinguish()
    end
    end

local function OnFire(attacked, data)
        if data and data.attacker and data.attacker.components.burnable then
            data.attacker.components.burnable:IsBurning()
            data.attacker.components.health:DoDelta(-20)
            data.attacker.components.burnable:Ignite(true)
        end 
    end

--[[
    if inst:HasTag("musha_teen") and data.attacker ~= nil and (data.attacker == inst.components.follower.leader or data.attacker:HasTag("player")) then
        --print("  what did I ever do to you!?")
        -- well i was just annoyed, but now you done pissed me off!
        SetTeenAttackDefault(inst)
    end

    inst.components.combat:SuggestTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 1, function(dude) return dude:HasTag("smallbird") and not dude.components.health:IsDead() end, 5)
end
]]--

local function SetTeen(inst)
    --print("smallbird - SetTeen")
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
    inst.sg:GoToState("growup") -- calls back to SpawnTeen
end

local function SpawnTeen(inst)
    --print("smallbird - SpawnTeen")

    local musha_teen = SpawnPrefab("musha_teen")
    musha_teen.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_teen.sg:GoToState("idle")

    if inst.components.follower.leader then
        musha_teen.components.follower:SetLeader(inst.components.follower.leader)
    end
inst.AnimState:SetBloomEffectHandle( "" )
    inst.components.health:DoDelta(-2000)
    inst:Remove()
end

local function SetAdult(inst)
    --print("smallbird - SetAdult")
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )

    inst.sg:GoToState("growup") -- calls back to SpawnAdult
end

local function SpawnAdult(inst)
    --print("smallbird - SpawnAdult")

    local musha_tall = SpawnPrefab("musha_tall")
    musha_tall.Transform:SetPosition(inst.Transform:GetWorldPosition())
   musha_tall.sg:GoToState("idle")

    if inst.components.follower.leader then
        musha_tall.components.follower:SetLeader(inst.components.follower.leader)
    end
if inst.components.container then
inst.components.container:DropEverything() 
end
inst.AnimState:SetBloomEffectHandle( "" )
    inst.components.health:DoDelta(-2000)
    inst:Remove()
end

local function SetAdult2(inst)
    --print("smallbird - SetAdult")
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )

    inst.sg:GoToState("growup") -- calls back to SpawnAdult
end

local function SpawnAdult2(inst)
    --print("smallbird - SpawnAdult")

    local musha_tall2= SpawnPrefab("musha_tall2")
    musha_tall2.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_tall2.sg:GoToState("idle")

    if inst.components.follower.leader then
        musha_tall2.components.follower:SetLeader(inst.components.follower.leader)
    end
if inst.components.container then
inst.components.container:DropEverything() 
end
inst.AnimState:SetBloomEffectHandle( "" )
    inst.components.health:DoDelta(-2000)
    inst:Remove()
end
local function SetAdult3(inst)
    --print("smallbird - SetAdult")
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )

    inst.sg:GoToState("growup") -- calls back to SpawnAdult
end

local function SpawnAdult3(inst)
    --print("smallbird - SpawnAdult")

    local musha_tall3= SpawnPrefab("musha_tall3")
    musha_tall3.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_tall3.sg:GoToState("idle")

    if inst.components.follower.leader then
        musha_tall3.components.follower:SetLeader(inst.components.follower.leader)
    end
if inst.components.container then
inst.components.container:DropEverything() 
end
inst.AnimState:SetBloomEffectHandle( "" )
    inst.components.health:DoDelta(-2000)
    inst:Remove()
end
local function SetAdult4(inst)
    --print("smallbird - SetAdult")
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )

    inst.sg:GoToState("growup") -- calls back to SpawnAdult
end

local function SpawnAdult4(inst)
    --print("smallbird - SpawnAdult")

    local musha_tall4= SpawnPrefab("musha_tall4")
    musha_tall4.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_tall4.sg:GoToState("idle")

    if inst.components.follower.leader then
        musha_tall4.components.follower:SetLeader(inst.components.follower.leader)
    end
	if inst.components.container then
	inst.components.container:DropEverything() 
end
inst.AnimState:SetBloomEffectHandle( "" )
    inst.components.health:DoDelta(-2000)
    inst:Remove()
end
local function SetAdult5(inst)
    --print("smallbird - SetAdult")
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )

   inst.sg:GoToState("growup") -- calls back to SpawnAdult
end


local function SpawnAdult5(inst)
    --print("smallbird - SpawnAdult")

    local musha_tall5= SpawnPrefab("musha_tall5")
    musha_tall5.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_tall5.sg:GoToState("idle")

    if inst.components.follower.leader then
        musha_tall5.components.follower:SetLeader(inst.components.follower.leader)
    end
	if inst.components.container then
	inst.components.container:DropEverything() 
end
inst.AnimState:SetBloomEffectHandle( "" )
    inst.components.health:DoDelta(-2000)
    inst:Remove()
end

local function updatestats(inst, data)

		if inst.components.health:GetPercent() < 0.2 then
			inst.components.locomotor.walkspeed = 12
			inst.Light:Enable(false)
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
    inst:ListenForEvent("attacked", OnFire)

		elseif inst.components.health:GetPercent() >= 0.2 then 
			inst.components.locomotor.walkspeed = 6
inst.AnimState:SetBloomEffectHandle( "" )
    inst:RemoveEventCallback("attacked", OnFire)

end

	if inst.components.health:GetPercent() > .5 then
			inst.Light:Enable(true)
inst.AnimState:SetBloomEffectHandle( "" )
    			inst.components.health:StartRegen(1, 15)
    inst:RemoveEventCallback("attacked", Onfreeze)
    inst.components.combat:SetAttackPeriod(1)

		elseif inst.components.health:GetPercent() < .5 then
    			inst.components.health:StartRegen(1, 1)
			inst.Light:Enable(false)
    inst:ListenForEvent("attacked", Onfreeze)

    inst.components.combat:SetAttackPeriod(1.5)

end

if inst:HasTag("baby") and inst:HasTag("onyamche") then
		if inst.components.hunger:GetPercent() > .95 then
    inst.entity:AddLight()
	inst.Light:SetRadius(2.5)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(200/255,165/255,165/255)
		elseif inst.components.hunger:GetPercent() <= .95 and inst.components.health:GetPercent() >= .75  then
    inst.entity:AddLight()
	inst.Light:SetRadius(2)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(200/255,165/255,165/255)
		elseif inst.components.hunger:GetPercent() <= .75 and inst.components.health:GetPercent() >= .5  then
	--inst.components.talker:Say("Kku!")
    inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/chirp") 

    inst.entity:AddLight()
	inst.Light:SetRadius(1)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(200/255,165/255,165/255)
		elseif inst.components.hunger:GetPercent() <= .5 and inst.components.health:GetPercent() >= .25  then
    inst.entity:AddLight()
	inst.Light:SetRadius(.6)
    inst.Light:SetFalloff(.4)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(200/255,165/255,165/255)
		elseif inst.components.hunger:GetPercent() < .25 then
    inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/chirp") 
    inst.entity:AddLight()
	inst.Light:SetRadius(.2)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(200/255,165/255,165/255)
end
end
end

local function GetPeepChance(inst)
    local peep_percent = 0.1
    if inst.components.hunger then
        if inst.components.hunger:IsStarving() then
            peep_percent = .7
	inst.components.talker:Say("Kkyuuu! Kkyuuu!")
        elseif inst.components.hunger:GetPercent() < .25 then
            peep_percent = 0.4
	inst.components.talker:Say("Kku! Koo! Koo!")
        elseif inst.components.hunger:GetPercent() < .5 then
            peep_percent = 0.3
	inst.components.talker:Say("Kku! Koo!")
        elseif inst.components.hunger:GetPercent() < .75 then
            peep_percent = 0.1
	inst.components.talker:Say("Kku!")
        elseif inst.components.health:GetPercent() < .25 then
            peep_percent = 0.6
	inst.components.talker:Say("PPu! Poo! Poo!")
        elseif inst.components.health:GetPercent() < .5 then
            peep_percent = 0.35
	inst.components.talker:Say("PPu! Poo!")
        elseif inst.components.health:GetPercent() < .75 then
            peep_percent = 0.1
	inst.components.talker:Say("Poo!")

        end
    end
    return peep_percent
end

local function GetCryChance(inst, data)
    local cry_percent = 0
	local player = GetPlayer()
        local fx = SpawnPrefab("sparklefx")
        local fx2 = SpawnPrefab("sparklefx")
if inst.components.follower:IsNearLeader(CRY_NEAR_LEADER_DISTANCE) then
	if inst.components.hunger.current > 50 and player.components.health:GetPercent() < .25 then
            cry_percent = .35
	inst.components.talker:Say("Kuoo!")
        player.components.health:DoDelta(10)
        player.components.sanity:DoDelta(5)
        inst.components.health:DoDelta(10)
        inst.components.hunger:DoDelta(-10)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1, 2, 1)
        fx.Transform:SetPosition(0.3, 0, 0)
        fx2.entity:SetParent(player.entity)
	fx2.Transform:SetScale(1, 2, 1)
        fx2.Transform:SetPosition(0.3, 0, 0)

elseif inst.components.hunger.current > 60 and player.components.health:GetPercent() < .5 then
            cry_percent = 0.1
	inst.components.talker:Say("Kuo!")
        player.components.health:DoDelta(6)
        player.components.sanity:DoDelta(2)
        inst.components.health:DoDelta(6)
        inst.components.hunger:DoDelta(-5)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1, 2, 1)
        fx.Transform:SetPosition(0.3, 0, 0)
        fx2.entity:SetParent(player.entity)
	fx2.Transform:SetScale(1, 2, 1)
        fx2.Transform:SetPosition(0.3, 0, 0)

elseif inst.components.hunger.current > 80 and player.components.health:GetPercent() < .75 then
            cry_percent = 0.02
	inst.components.talker:Say("Ku!")
        player.components.health:DoDelta(6)
        player.components.sanity:DoDelta(2)
        inst.components.health:DoDelta(6)
        inst.components.hunger:DoDelta(-5)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1, 2, 1)
        fx.Transform:SetPosition(0.3, 0, 0)
        fx2.entity:SetParent(player.entity)
	fx2.Transform:SetScale(1, 2, 1)
        fx2.Transform:SetPosition(0.3, 0, 0)

elseif inst.components.hunger.current > 50 and player.components.sanity:GetPercent() < .25 then
            cry_percent = .1
	inst.components.talker:Say("Guoo!")
        player.components.sanity:DoDelta(6)
        player.components.health:DoDelta(2)
        inst.components.health:DoDelta(6)
        inst.components.hunger:DoDelta(-5)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1, 2, 1)
        fx.Transform:SetPosition(0.3, 0, 0)
        fx2.entity:SetParent(player.entity)
	fx2.Transform:SetScale(1, 2, 1)
        fx2.Transform:SetPosition(0.3, 0, 0)

elseif inst.components.hunger.current > 80 and player.components.sanity:GetPercent() < .5 then
            cry_percent = 0.02
	inst.components.talker:Say("Guo!")
        player.components.sanity:DoDelta(6)
        player.components.health:DoDelta(2)
        inst.components.health:DoDelta(6)
        inst.components.hunger:DoDelta(-5)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1, 2, 1)
        fx.Transform:SetPosition(0.3, 0, 0)
        fx2.entity:SetParent(player.entity)
	fx2.Transform:SetScale(1, 2, 1)
        fx2.Transform:SetPosition(0.3, 0, 0)

    end
    end
    return cry_percent
end

--time
--(lv2)
local function GetTeenGrowTime(inst)
	return 1
end
--(lv3)
local function GetTallGrowTime(inst)
	return 1
	--return 1400
end
--(lv4)
local function GetTall2GrowTime(inst)
	return 1
	--return 2200
end
--(lv5)
local function GetTall3GrowTime(inst)
	return 1
	--return 3000
end
--(lv6)
local function GetTall4GrowTime(inst)
	return 1
	--return 3800
end
--(lv7)
local function GetTall5GrowTime(inst)
	return 1
	--return 4600
end

--[[
local function GetTallGrowTime(inst)
	return TUNING.TEENBIRD_GROW_TIME
end
]]--
local function OnHealthDelta(inst, data)
    if data.cause == "hunger" and data.newpercent < 0.1 and inst.components.follower.leader then
        --print("teenbird - STARVING i'm blowing this popsicle stand!", data.newpercent)

        if inst.components.combat.target == inst.components.follower.leader then
            inst.components.combat:SetTarget(nil)
        end

        inst.components.follower:SetLeader(nil)
    end
end

local function create_common(inst)
    --print("smallbird - create_common")
	--inst = inst or CreateEntity()
	
    inst:AddTag("companion")
    inst:AddTag("character")
    inst:AddTag("musha_small")
    inst:AddTag("scarytoprey")
    inst:AddTag("noauradamage")
inst:AddTag("fridge")
inst:AddTag("peck_attack")
inst:AddTag("notraptrigger")
---inst:AddTag("houndfriend")

    inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_small.tex" )

	inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()

--[[    
    inst.fire = SpawnPrefab( "lighterfire" )
 local follower = inst.fire.entity:AddFollower()
    follower:FollowSymbol( inst.GUID, "swap_object", 150, 0, 1 )
]]--
	--MakeCharacterPhysics(inst, 10, .25)
    	MakeCharacterPhysics(inst, 50, .5)

    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)

    inst.Transform:SetFourFaced()

	inst:SetBrain(brain)	

    inst.userfunctions = 
    {
        FollowPlayer = FollowPlayer,
        GetPeepChance = GetPeepChance,
        GetCryChance = GetCryChance,
        SpawnTeen = SpawnTeen,
        SpawnAdult = SpawnAdult,
        SpawnAdult2 = SpawnAdult2,
        SpawnAdult3 = SpawnAdult3,
        SpawnAdult4 = SpawnAdult4,
        SpawnAdult5 = SpawnAdult5,
	updatestats = updatestats
    }
    --("   order")

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = PhoenixSanityAura
--------------------
        inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(5, 8)
    inst.components.playerprox:SetOnPlayerNear(close)
    inst.components.playerprox:SetOnPlayerFar(far)

    ------------------------------------------
    inst:AddComponent("health")
	inst.components.health.fire_damage_scale = 0

    inst:AddComponent("hunger")

    inst:AddComponent("combat")
	inst:ListenForEvent("attacked", OnAttacked)
---    inst:ListenForEvent("attacked", OnFire)
        inst.procfn = function() tryproc(inst) end
        inst:ListenForEvent("attacked", inst.procfn)

    inst:ListenForEvent("onhitother", OnHitfire)
--[[
	if math.random() < freezechance then
    inst:ListenForEvent("onhitother", OnHitfreeze)end
]]--
--[[
        inst:ListenForEvent("nighttime", function(global, data)				 if GetClock():IsNight() then
	 if inst.components.follower:IsNearLeader(SLEEP_GROW_DISTANCE) then
    inst.components.growable:StartGrowing()
 	elseif not inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE) then 
    inst.components.growable:StopGrowing()

end
if GetClock():IsDay() then
	     inst.components.growable:StopGrowing()
elseif GetClock():IsDusk() then
	     inst.components.growable:StopGrowing()
			end
	    end
	end, GetWorld())
]]--

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 6
    inst.components.locomotor.runspeed = 9

  --  inst:AddTag("animal") 

    inst:AddComponent("follower")

-------
 if ACTIONS.STAYORDER~= nil then
    inst:AddComponent("staycommand")
    	end
-------
    inst:AddComponent("talker")
    inst:AddComponent("eater")
    inst.components.eater:SetOmnivore()
	--inst.components.eater:SetElemental()
    --inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "ELEMENTAL" }

    inst.components.eater:SetOnEatFn(OnEat)

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.testperiod = GetRandomWithVariance(4, 1)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem

    inst:AddComponent("periodicspawner")
    inst.components.periodicspawner:SetPrefab("feather_robin")
    inst.components.periodicspawner:SetRandomTimes(150, 600)
    inst.components.periodicspawner:SetDensityInRange(20, 2)
    inst.components.periodicspawner:SetMinimumSpacing(8)
    inst.components.periodicspawner:Start()


    inst:AddComponent("lootdropper")

    --print("smallbird - create_common END")

inst:ListenForEvent( "healthdelta", updatestats)

	inst.level = 0
    inst:ListenForEvent("entity_death", function(wrld, data) onkilll(inst, data) end, GetWorld())
inst:ListenForEvent("levelup", levelexp)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload

    return inst
end

-----------start create birds grow

local function create_smallbird()
    --print("smallbird - create_smallbird")

	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_small.tex" )

    --MakeInventoryPhysics(inst, 1,1)

    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_small")
    inst.AnimState:PlayAnimation("idle")
-------------------------------------
    inst:AddComponent("inspectable")
    inst:AddTag("musha_small")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_small.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
    inst.components.inventoryitem.cangoincontainer = false

-----------------------------

   inst:AddTag("light")
   inst:AddTag("level1")

inst:AddComponent("equippable")
        inst:AddComponent("insulator")
     --inst:AddComponent("useableitem")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
       inst.components.equippable:SetOnEquip( onyamche )
       inst.components.equippable:SetOnUnequip( offyamche )
     -- inst.components.useableitem:SetOnUseFn(onuseyamche)
    --  inst.components.useableitem:SetOnStopUseFn(offuseyamche)
    inst.components.equippable.walkspeedmult = 1.15
    inst.components.equippable.runspeedmult = 1.15

------------------------
    inst.entity:AddLight()
	inst.Light:SetRadius(.3)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(10/255,125/255,125/255)
	---inst.Light:Enable(true)
-----------------------
    --inst:AddComponent("propagator")
    -----------------------
    inst:AddComponent("burnable")
   -- inst.components.burnable:AddBurnFX("campfirefire", Vector3(0,0,0) )
    
    inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)

    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
    inst.components.fueled.accepting = true
    inst.components.fueled:SetSections(4)
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
    
    inst.components.fueled:SetUpdateFn( function()
        if GetSeasonManager() and GetSeasonManager():IsRaining() then
            inst.components.fueled.rate = 1 + TUNING.FIREPIT_RAIN_RATE*GetSeasonManager():GetPrecipitationRate()
        else
            inst.components.fueled.rate = 1
        end
        
        if inst.components.burnable and inst.components.fueled then
            inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
        end
    end)
        
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() 
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
        
    inst.components.fueled:InitializeFuelLevel(0)

-----------------------------
        inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        local sec = inst.components.fueled:GetCurrentSection()
        if sec == 0 then 
            return "OUT"
        elseif sec <= 4 then
            local t = {"EMBERS","LOW","NORMAL","HIGH"}
            return t[sec]
        end
    end
    
    inst:ListenForEvent( "onbuilt", function()
        anim:PlayAnimation("place")
        anim:PushAnimation("idle",false)
        inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
    end)
-------------------------------------------

-------------------------------------

    create_common(inst)

    inst:SetStateGraph("SGmusha_small")
    inst.Transform:SetScale(0.5, 0.5, 0.5)

	inst.DynamicShadow:SetSize( 0.8, .3 )
    --MakeSmallBurnableCharacter(inst, "head")
    MakeMediumBurnableCharacter(inst, "pig_torso")

    --inst.components.burnable:SetBurnTime(300)
    --MakeSmallPropagator(inst)
    MakeSmallFreezableCharacter(inst, "head")
    
    inst.components.health:SetMaxHealth(150)

    inst.components.hunger:SetMax(30)
    --inst.components.hunger:SetRate(TUNING.SMALLBIRD_HUNGER * 1.2 /TUNING.SMALLBIRD_STARVE_TIME)
inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 0.25)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(3)
    inst.components.combat:SetDefaultDamage(TUNING.SMALLBIRD_DAMAGE)

    inst.components.lootdropper:SetLoot({"glowdust"})

  -- inst.components.eater:SetCanEatTestFn(CanEatTest)

    local growth_stages = {
        {name="small", time = GetTeenGrowTime, fn = function() end },
        {name="tall", fn = SetTeen}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_smallbird END")
	return inst
end

local function create_teen_smallbird()
    --print("smallbird - create_teen_smallbird")

    local inst = CreateEntity()

    inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_small" )
--[[
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_small.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
]]--
--("   container")
    inst:AddComponent("container")
    inst.components.container:SetNumSlots(#slotpos_1)
        inst.components.container.itemtestfn = itemtest

    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
    
    inst.components.container.widgetslotpos = slotpos_1
    inst.components.container.widgetanimbank = "ui_chest_3x2"
    inst.components.container.widgetanimbuild = "ui_chest_yamche0"
    inst.components.container.widgetpos = Vector3(0,-180,0)
    inst.components.container.widgetpos_controller = Vector3(0,200,0)
    inst.components.container.side_align_tip = 160
----------
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_teen")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")


-------------------------------------
    inst:AddComponent("inspectable")
    inst:AddTag("musha_teen")
   inst:AddTag("level2")
   inst:RemoveTag("baby")
inst:RemoveTag("level1")

    inst.entity:AddLight()
	inst.Light:SetRadius(.6)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(15/255,125/255,125/255)
	inst.Light:Enable(true)
-----------------------
    --inst:AddComponent("propagator")
    -----------------------
    inst:AddComponent("burnable")
   -- inst.components.burnable:AddBurnFX("campfirefire", Vector3(0,0,0) )
    
    inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)

    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
    inst.components.fueled.accepting = true
    inst.components.fueled:SetSections(4)
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
    
    inst.components.fueled:SetUpdateFn( function()
        if GetSeasonManager() and GetSeasonManager():IsRaining() then
            inst.components.fueled.rate = 1 + TUNING.FIREPIT_RAIN_RATE*GetSeasonManager():GetPrecipitationRate()
        else
            inst.components.fueled.rate = 1
        end
        
        if inst.components.burnable and inst.components.fueled then
            inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
        end
    end)
        
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() 
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
        
    inst.components.fueled:InitializeFuelLevel(0)

-----------------------------
        inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        local sec = inst.components.fueled:GetCurrentSection()
        if sec == 0 then 
            return "OUT"
        elseif sec <= 4 then
            local t = {"EMBERS","LOW","NORMAL","HIGH"}
            return t[sec]
        end
    end
    
    inst:ListenForEvent( "onbuilt", function()
        anim:PlayAnimation("place")
        anim:PushAnimation("idle",false)
        inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
    end)
-------------------------------------------

-------------------------------------

    create_common(inst)
	
    inst:AddTag("musha_teen")

    inst:SetStateGraph("SGmusha_teen")


    inst.Transform:SetScale(0.65, 0.65, 0.65)

   -- inst.Physics:SetCylinder(.5, 1)

	inst.DynamicShadow:SetSize( 0.9, .4 )
    --MakeSmallBurnableCharacter(inst, "head")
    MakeMediumBurnableCharacter(inst, "pig_torso")

    --inst.components.burnable:SetBurnTime(300)
  --  MakeSmallPropagator(inst)
    MakeMediumFreezableCharacter(inst, "head")
    
    inst.components.health:SetMaxHealth(300)

    inst:ListenForEvent("healthdelta", OnHealthDelta)
    
    inst.components.hunger:SetMax(60)
   -- inst.components.hunger:SetRate(TUNING.TEENBIRD_HUNGER/TUNING.TEENBIRD_STARVE_TIME)
inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 0.25)
--[[
	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(TUNING.TEENBIRD_ATTACK_RANGE)
    inst.components.combat:SetRetargetFunction(3, TeenRetarget)
    inst.components.combat:SetKeepTargetFunction(TeenKeepTarget)
    SetTeenAttackDefault(inst)
]]--
	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(3)
    inst.components.combat:SetDefaultDamage(20)

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    --inst.components.eater:SetCanEatTestFn(CanEatTest)

    local growth_stages = {
        {name="tall", time = GetTallGrowTime, fn = function() end },
        {name="adult", fn = SetAdult}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end

-----musha tall
local function create_tall_teen()
    --print("tallbird -  create_tall_teen")

    local inst = CreateEntity()

    inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_tall.tex" )

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")


-------------------------------------
    inst:AddComponent("inspectable")
    inst:AddTag("musha_tall")
     inst:AddTag("level3")
   inst:RemoveTag("baby")
inst:RemoveTag("level1")


--[[
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_tall.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
]]--
--("   container")
    inst:AddComponent("container")
    inst.components.container:SetNumSlots(#slotpos_2)
        inst.components.container.itemtestfn = itemtest

    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
    
    inst.components.container.widgetslotpos = slotpos_2
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_yamche1"
    inst.components.container.widgetpos = Vector3(0,-180,0)
    inst.components.container.widgetpos_controller = Vector3(0,200,0)
    inst.components.container.side_align_tip = 160
----------

    inst.entity:AddLight()
	inst.Light:SetRadius(1)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(125/255,85/255,85/255)
	inst.Light:Enable(true)
-----------------------
    --inst:AddComponent("propagator")
    -----------------------
    inst:AddComponent("burnable")
   -- inst.components.burnable:AddBurnFX("campfirefire", Vector3(0,0,0) )
    
    inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)

    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
    inst.components.fueled.accepting = true
    inst.components.fueled:SetSections(4)
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
    
    inst.components.fueled:SetUpdateFn( function()
        if GetSeasonManager() and GetSeasonManager():IsRaining() then
            inst.components.fueled.rate = 1 + TUNING.FIREPIT_RAIN_RATE*GetSeasonManager():GetPrecipitationRate()
        else
            inst.components.fueled.rate = 1
        end
        
        if inst.components.burnable and inst.components.fueled then
            inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
        end
    end)
        
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() 
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
        
    inst.components.fueled:InitializeFuelLevel(0)

-----------------------------
        inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        local sec = inst.components.fueled:GetCurrentSection()
        if sec == 0 then 
            return "OUT"
        elseif sec <= 4 then
            local t = {"EMBERS","LOW","NORMAL","HIGH"}
            return t[sec]
        end
    end
    
    inst:ListenForEvent( "onbuilt", function()
        anim:PlayAnimation("place")
        anim:PushAnimation("idle",false)
        inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
    end)
-------------------------------------------

-------------------------------------

    create_common(inst)
	
    inst:AddTag("musha_tall")
   inst:RemoveTag("baby")
inst:RemoveTag("level1")

    inst:SetStateGraph("SGmusha_tall")


    inst.Transform:SetScale(0.75, 0.75, 0.75)

   -- inst.Physics:SetCylinder(.5, 1)

	inst.DynamicShadow:SetSize( 1.0, .5 )
  --  MakeSmallBurnableCharacter(inst, "head")
    MakeMediumBurnableCharacter(inst, "pig_torso")

    --inst.components.burnable:SetBurnTime(300)
 --   MakeSmallPropagator(inst)
    --MakeMediumFreezableCharacter(inst, "head")
    
    inst.components.health:SetMaxHealth(400)

    inst:ListenForEvent("healthdelta", OnHealthDelta)
    
    inst.components.hunger:SetMax(70)
    --inst.components.hunger:SetRate(TUNING.TEENBIRD_HUNGER * 1.15 /TUNING.TEENBIRD_STARVE_TIME)
inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 0.25)
--[[
	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(TUNING.TEENBIRD_ATTACK_RANGE)
    inst.components.combat:SetRetargetFunction(3, TeenRetarget)
    inst.components.combat:SetKeepTargetFunction(TeenKeepTarget)
    SetTeenAttackDefault(inst)
]]--
	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(3)
    inst.components.combat:SetDefaultDamage(30)

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    --inst.components.eater:SetCanEatTestFn(CanEatTest)

    local growth_stages = {
        {name="tall", time = GetTall2GrowTime, fn = function() end },
        {name="adult", fn = SetAdult}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end

local function create_tall2_teen()
    --print("tallbird -  create_tall_teen")

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall2")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    inst:AddComponent("inspectable")
    inst:AddTag("musha_tall2")
     inst:AddTag("level4")
   inst:RemoveTag("baby")
inst:RemoveTag("level1")


   -- inst:AddComponent("inventoryitem")
--	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_tall2.xml"

    inst.entity:AddLight()
	inst.Light:SetRadius(1.3)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(120/255,45/255,45/255)
	inst.Light:Enable(true)
-----------------------
    --inst:AddComponent("propagator")
    -----------------------
    inst:AddComponent("burnable")
   -- inst.components.burnable:AddBurnFX("campfirefire", Vector3(0,0,0) )
    
    inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)

    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
    inst.components.fueled.accepting = true
    inst.components.fueled:SetSections(4)
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
    
    inst.components.fueled:SetUpdateFn( function()
        if GetSeasonManager() and GetSeasonManager():IsRaining() then
            inst.components.fueled.rate = 1 + TUNING.FIREPIT_RAIN_RATE*GetSeasonManager():GetPrecipitationRate()
        else
            inst.components.fueled.rate = 1
        end
        
        if inst.components.burnable and inst.components.fueled then
            inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
        end
    end)
        
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() 
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
        
    inst.components.fueled:InitializeFuelLevel(0)

-----------------------------
        inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        local sec = inst.components.fueled:GetCurrentSection()
        if sec == 0 then 
            return "OUT"
        elseif sec <= 4 then
            local t = {"EMBERS","LOW","NORMAL","HIGH"}
            return t[sec]
        end
    end
    
    inst:ListenForEvent( "onbuilt", function()
        anim:PlayAnimation("place")
        anim:PushAnimation("idle",false)
        inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
    end)
-------------------------------------------

-------------------------------------

    create_common(inst)
	
    inst:AddTag("musha_tall2")
   inst:RemoveTag("baby")
inst:RemoveTag("level1")

    inst:SetStateGraph("SGmusha_tall2")


    inst.Transform:SetScale(0.85, 0.85, 0.85)

   -- inst.Physics:SetCylinder(.5, 1)

	inst.DynamicShadow:SetSize( 1.1, .6 )
    MakeMediumBurnableCharacter(inst, "pig_torso")

   -- inst.components.burnable:SetBurnTime(300)
 --   MakeSmallPropagator(inst)
    MakeSmallFreezableCharacter(inst, "head")
    
    inst.components.health:SetMaxHealth(500)

    inst:ListenForEvent("healthdelta", OnHealthDelta)
    
    inst.components.hunger:SetMax(80)
    --inst.components.hunger:SetRate(TUNING.TEENBIRD_HUNGER * 1.3 /TUNING.TEENBIRD_STARVE_TIME)
inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 0.25)
--[[
	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(TUNING.TEENBIRD_ATTACK_RANGE)
    inst.components.combat:SetRetargetFunction(3, TeenRetarget)
    inst.components.combat:SetKeepTargetFunction(TeenKeepTarget)
    SetTeenAttackDefault(inst)
]]--
	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(3)
    inst.components.combat:SetDefaultDamage(40)
--("   container")
    inst:AddComponent("container")
    inst.components.container:SetNumSlots(#slotpos_3)
        inst.components.container.itemtestfn = itemtest

    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
    
    inst.components.container.widgetslotpos = slotpos_3
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_yamche2"
    inst.components.container.widgetpos = Vector3(0,-180,0)
    inst.components.container.widgetpos_controller = Vector3(0,200,0)
    inst.components.container.side_align_tip = 160
----------

---
    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    --inst.components.eater:SetCanEatTestFn(CanEatTest)

    local growth_stages = {
        {name="tall2", time = GetTall3GrowTime, fn = function() end },
        {name="adult2", fn = SetAdult2}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end
local function create_tall3_teen()
    --print("tallbird -  create_tall_teen")

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall3")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    inst:AddComponent("inspectable")
    inst:AddTag("musha_tall3")
     inst:AddTag("level5")
   inst:RemoveTag("baby")
inst:RemoveTag("level1")


    --inst:AddComponent("inventoryitem")
	--inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_tall3.xml"

    inst.entity:AddLight()
	inst.Light:SetRadius(1.7)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(120/255,120/255,20/255)
	inst.Light:Enable(true)
-----------------------
    --inst:AddComponent("propagator")
    -----------------------
    inst:AddComponent("burnable")
   -- inst.components.burnable:AddBurnFX("campfirefire", Vector3(0,0,0) )
    
    inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)

    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
    inst.components.fueled.accepting = true
    inst.components.fueled:SetSections(4)
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
    
    inst.components.fueled:SetUpdateFn( function()
        if GetSeasonManager() and GetSeasonManager():IsRaining() then
            inst.components.fueled.rate = 1 + TUNING.FIREPIT_RAIN_RATE*GetSeasonManager():GetPrecipitationRate()
        else
            inst.components.fueled.rate = 1
        end
        
        if inst.components.burnable and inst.components.fueled then
            inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
        end
    end)
        
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() 
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
        
    inst.components.fueled:InitializeFuelLevel(0)

-----------------------------
        inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        local sec = inst.components.fueled:GetCurrentSection()
        if sec == 0 then 
            return "OUT"
        elseif sec <= 4 then
            local t = {"EMBERS","LOW","NORMAL","HIGH"}
            return t[sec]
        end
    end
    
    inst:ListenForEvent( "onbuilt", function()
        anim:PlayAnimation("place")
        anim:PushAnimation("idle",false)
        inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
    end)
-------------------------------------------

-------------------------------------

    create_common(inst)
	
    inst:AddTag("musha_tall3")
   inst:RemoveTag("baby")
inst:RemoveTag("level1")

    inst:SetStateGraph("SGmusha_tall3")


    inst.Transform:SetScale(0.95, 0.95, 0.95)

   -- inst.Physics:SetCylinder(.5, 1)

	inst.DynamicShadow:SetSize( 1.15, .7 )
    MakeMediumBurnableCharacter(inst, "pig_torso")

    inst.components.burnable:SetBurnTime(300)
  --  MakeSmallPropagator(inst)
    MakeSmallFreezableCharacter(inst, "head")
    
    inst.components.health:SetMaxHealth(600)

    inst:ListenForEvent("healthdelta", OnHealthDelta)
    
    inst.components.hunger:SetMax(90)
inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 0.25)
--[[
	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(TUNING.TEENBIRD_ATTACK_RANGE)
    inst.components.combat:SetRetargetFunction(3, TeenRetarget)
    inst.components.combat:SetKeepTargetFunction(TeenKeepTarget)
    SetTeenAttackDefault(inst)
]]--
	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(3)
    inst.components.combat:SetDefaultDamage(50)
--("   container")
    inst:AddComponent("container")
    inst.components.container:SetNumSlots(#slotpos_4)
        inst.components.container.itemtestfn = itemtest

    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
    
    inst.components.container.widgetslotpos = slotpos_4
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_3x3"
    inst.components.container.widgetpos = Vector3(0,-180,0)
    inst.components.container.widgetpos_controller = Vector3(0,200,0)
    inst.components.container.side_align_tip = 160
---
    --inst.components.eater:SetOmnivore()
	--inst.components.eater:SetElemental()
inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "ELEMENTAL" }

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    --inst.components.eater:SetCanEatTestFn(CanEatTest)

    local growth_stages = {
        {name="tall3", time = GetTall4GrowTime, fn = function() end },
        {name="adult3", fn = SetAdult3}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end
local function create_tall4_teen()
    --print("tallbird -  create_tall_teen")

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall4")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    inst:AddComponent("inspectable")
    inst:AddTag("musha_tall4")
inst:RemoveTag("musha_tall3")
     inst:AddTag("level6")
   inst:RemoveTag("baby")
inst:RemoveTag("level1")


  --  inst:AddComponent("inventoryitem")
--	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_tall4.xml"

    inst.entity:AddLight()
	inst.Light:SetRadius(2.1)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(200/255,190/255,15/255)
	inst.Light:Enable(true)
-----------------------
    --inst:AddComponent("propagator")
    -----------------------
    inst:AddComponent("burnable")
   -- inst.components.burnable:AddBurnFX("campfirefire", Vector3(0,0,0) )
    
    inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)

    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
    inst.components.fueled.accepting = true
    inst.components.fueled:SetSections(4)
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
    
    inst.components.fueled:SetUpdateFn( function()
        if GetSeasonManager() and GetSeasonManager():IsRaining() then
            inst.components.fueled.rate = 1 + TUNING.FIREPIT_RAIN_RATE*GetSeasonManager():GetPrecipitationRate()
        else
            inst.components.fueled.rate = 1
        end
        
        if inst.components.burnable and inst.components.fueled then
            inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
        end
    end)
        
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() 
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
        
    inst.components.fueled:InitializeFuelLevel(0)

-----------------------------
        inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        local sec = inst.components.fueled:GetCurrentSection()
        if sec == 0 then 
            return "OUT"
        elseif sec <= 4 then
            local t = {"EMBERS","LOW","NORMAL","HIGH"}
            return t[sec]
        end
    end
    
    inst:ListenForEvent( "onbuilt", function()
        anim:PlayAnimation("place")
        anim:PushAnimation("idle",false)
        inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
    end)
-------------------------------------------

-------------------------------------

    create_common(inst)
	
    inst:AddTag("musha_tall4")
   inst:RemoveTag("baby")
inst:RemoveTag("level1")

    inst:SetStateGraph("SGmusha_tall4")


    inst.Transform:SetScale(1.25, 1.25, 1.25)

  --  inst.Physics:SetCylinder(.5, 1)

	inst.DynamicShadow:SetSize( 1.2, 0.9)
    MakeMediumBurnableCharacter(inst, "pig_torso")
    inst.components.burnable:SetBurnTime(300)
   -- MakeSmallPropagator(inst)
    MakeSmallFreezableCharacter(inst, "head")
    
    inst.components.health:SetMaxHealth(750)

    inst:ListenForEvent("healthdelta", OnHealthDelta)
    
    inst.components.hunger:SetMax(100)
inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 0.25)
--[[
	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(TUNING.TEENBIRD_ATTACK_RANGE)
    inst.components.combat:SetRetargetFunction(3, TeenRetarget)
    inst.components.combat:SetKeepTargetFunction(TeenKeepTarget)
    SetTeenAttackDefault(inst)
]]--
	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(3)
    inst.components.combat:SetDefaultDamage(60)

--("   container")
    inst:AddComponent("container")
    inst.components.container:SetNumSlots(#slotpos_5)
        inst.components.container.itemtestfn = itemtest

    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
    
   inst.components.container.widgetslotpos = slotpos_5
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_3x3"
    inst.components.container.widgetpos = Vector3(0,200,0)
    inst.components.container.side_align_tip = 160
---
   -- inst.components.eater:SetOmnivore()
	--inst.components.eater:SetElemental()
inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "ELEMENTAL" }

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    --inst.components.eater:SetCanEatTestFn(CanEatTest)

    local growth_stages = {
        {name="tall4", time = GetTall5GrowTime, fn = function() end },
        {name="adult4", fn = SetAdult4}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

    --print("smallbird - create_teen_smallbird END")
	return inst
end
local function create_tall5_teen()
    --print("tallbird -  create_tall_teen")

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall5")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")
--inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )



-------------------------------------
    inst:AddComponent("inspectable")
    inst:AddTag("musha_tall5")
inst:RemoveTag("musha_tall3")
inst:RemoveTag("musha_tall4")

     inst:AddTag("level7")
   inst:RemoveTag("baby")
inst:RemoveTag("level1")


  --  inst:AddComponent("inventoryitem")
	--inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_tall5.xml"

    inst.entity:AddLight()
	inst.Light:SetRadius(3)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(225/255,200/255,75/255)
	inst.Light:Enable(true)
-----------------------
    --inst:AddComponent("propagator")
    -----------------------
    inst:AddComponent("burnable")
   -- inst.components.burnable:AddBurnFX("campfirefire", Vector3(0,0,0) )
    
    inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)

    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
    inst.components.fueled.accepting = true
    inst.components.fueled:SetSections(4)
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
    
    inst.components.fueled:SetUpdateFn( function()
        if GetSeasonManager() and GetSeasonManager():IsRaining() then
            inst.components.fueled.rate = 1 + TUNING.FIREPIT_RAIN_RATE*GetSeasonManager():GetPrecipitationRate()
        else
            inst.components.fueled.rate = 1
        end
        
        if inst.components.burnable and inst.components.fueled then
            inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
        end
    end)
        
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() 
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
        
    inst.components.fueled:InitializeFuelLevel(0)

-----------------------------
        inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        local sec = inst.components.fueled:GetCurrentSection()
        if sec == 0 then 
            return "OUT"
        elseif sec <= 4 then
            local t = {"EMBERS","LOW","NORMAL","HIGH"}
            return t[sec]
        end
    end
    
    inst:ListenForEvent( "onbuilt", function()
        anim:PlayAnimation("place")
        anim:PushAnimation("idle",false)
        inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
    end)
-------------------------------------------

        inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        local sec = inst.components.fueled:GetCurrentSection()
        if sec == 0 then 
            return "OUT"
        elseif sec <= 4 then
            local t = {"EMBERS","LOW","NORMAL","HIGH"}
            return t[sec]
        end
    end
    
    inst:ListenForEvent( "onbuilt", function()
        anim:PlayAnimation("place")
        anim:PushAnimation("idle",false)
        inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
    end)
-------------------------------------------

-------------------------------------

    create_common(inst)
	
    inst:AddTag("musha_tall5")
   inst:RemoveTag("baby")
inst:RemoveTag("level1")


    inst:SetStateGraph("SGmusha_tall5")


    inst.Transform:SetScale(1.5, 1.5, 1.5)

   -- inst.Physics:SetCylinder(.5, 1)

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   -- MakeSmallBurnableCharacter(inst, "head")
    MakeMediumBurnableCharacter(inst, "pig_torso")
    inst.components.burnable:SetBurnTime(300)
inst.components.burnable:SetFXLevel(300)
    --MakeSmallPropagator(inst)
    MakeSmallFreezableCharacter(inst, "head")
    
    inst.components.health:SetMaxHealth(900)

    inst:ListenForEvent("healthdelta", OnHealthDelta)
    
    inst.components.hunger:SetMax(120)
inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 0.25)
  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)
--[[
	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(TUNING.TEENBIRD_ATTACK_RANGE)
    inst.components.combat:SetRetargetFunction(3, TeenRetarget)
    inst.components.combat:SetKeepTargetFunction(TeenKeepTarget)
    SetTeenAttackDefault(inst)
]]--
	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(TUNING.TEENBIRD_ATTACK_RANGE)
    inst.components.combat:SetDefaultDamage(70)
    --("   container")
    inst:AddComponent("container")
    inst.components.container:SetNumSlots(#slotpos_6)
        inst.components.container.itemtestfn = itemtest

    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
    
    inst.components.container.widgetslotpos = slotpos_6
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_3x3"
    inst.components.container.widgetpos = Vector3(0,200,0)
    --inst.components.container.widgetpos = Vector3(-5,-75,0)
    inst.components.container.side_align_tip = 160
--	inst.components.container.side_widget = true    

--   inst.components.eater:SetOmnivore()
--	inst.components.eater:SetElemental()
inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "ELEMENTAL" }

     --   inst.procfn = function() tryproc(inst) end
     --   inst:ListenForEvent("attacked", inst.procfn)

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

	return inst

end
-------------
return Prefab( "musha_small", create_smallbird, assets, prefabs),
	   Prefab( "musha_teen", create_teen_smallbird, teen_assets),
	   Prefab( "musha_tall", create_tall_teen, tall_assets) ,
 	   Prefab( "musha_tall2", create_tall2_teen, tall2_assets), 
	   Prefab( "musha_tall3", create_tall3_teen, tall3_assets), 
	   Prefab( "musha_tall4", create_tall4_teen, tall4_assets), 
	   Prefab( "musha_tall5", create_tall5_teen, tall5_assets), 
MakePlacer( "common/firepit_placer", "firepit", "firepit", "preview" ) 

