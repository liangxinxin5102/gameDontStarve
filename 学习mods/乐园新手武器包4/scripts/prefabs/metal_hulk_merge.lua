local TadalinUtil = require("tadalin_util")
local easing = require("easing")

local assets =
{
	Asset("ANIM", "anim/metal_hulk_build.zip"),
	Asset("ANIM", "anim/metal_hulk_basic.zip"),
    Asset("ANIM", "anim/metal_hulk_attacks.zip"),
    Asset("ANIM", "anim/metal_hulk_actions.zip"),
    Asset("ANIM", "anim/metal_hulk_barrier.zip"),
    Asset("ANIM", "anim/metal_hulk_explode.zip"),    
    Asset("ANIM", "anim/metal_hulk_bomb.zip"),    
    Asset("ANIM", "anim/metal_hulk_projectile.zip"),    

    Asset("ANIM", "anim/laser_explode_sm.zip"),  
    Asset("ANIM", "anim/smoke_aoe.zip"),
    Asset("ANIM", "anim/laser_explosion.zip"),
    --Asset("ANIM", "anim/ground_chunks_breaking.zip"),
    Asset("ANIM", "anim/ground_chunks_breaking_brown.zip"),
	
    Asset("ANIM", "anim/metal_hulk_ring_fx.zip"),

	
	Asset("ANIM", "anim/lavaarena_hammer_attack_fx.zip"),
	Asset("ANIM", "anim/rock_basalt.zip"),
	Asset("MINIMAP_IMAGE", "rock"),
}

local assets_ball = {
	Asset("ANIM", "anim/death_dragon_ball.zip"),
	Asset("ANIM", "anim/death_dragon_ball_red.zip"),
	Asset("ANIM", "anim/halloween_embers.zip"),
	
	
}

local prefabs =
{
    "froglegs",
    "frogsplash",
}

local brain = require "brains/frogbrain"

--------动画名：
--[[
idle
walk_pre
walk_loop
walk_pst
hit
atk_chomp
atk_circle
death
--]]

SetSharedLootTable('metal_hulk_merge',
{
	{'purplegem',           1.0},
	{'purplegem',           1.0},
	{'purplegem',           1.0},
	{'purplegem',           1.0},
	{'purplegem',           1.0},
	{'purplegem',           1.0},
	{'purplegem',           1.0},
	{'purplegem',           1.0},
	{'purplegem',           1.0},
	{'purplegem',           1.0},
	{'purplegem',           1.0},
	{'purplegem',           1.0},
	
	{'opalpreciousgem',           1.0},
	{'opalpreciousgem',           1.0},
	{'opalpreciousgem',           1.0},
	{'opalpreciousgem',           1.0},
	{'opalpreciousgem',           1.0},
	{'opalpreciousgem',           1.0},
	{'opalpreciousgem',           1.0},
	{'opalpreciousgem',           1.0},
	{'opalpreciousgem',           1.0},
	{'opalpreciousgem',           1.0},
	{'opalpreciousgem',           1.0},
	{'opalpreciousgem',           1.0},
	
	{'orangegem',           1.0},
	{'orangegem',           1.0},
	{'orangegem',           1.0},
	{'orangegem',           1.0},
	{'orangegem',           1.0},
	{'orangegem',           1.0},
	{'orangegem',           1.0},
	{'orangegem',           1.0},
	{'orangegem',           1.0},
	{'orangegem',           1.0},
	{'orangegem',           1.0},
	{'orangegem',           1.0},
	
	{'yellowgem',           1.0},
	{'yellowgem',           1.0},
	{'yellowgem',           1.0},
	{'yellowgem',           1.0},
	{'yellowgem',           1.0},
	{'yellowgem',           1.0},
	{'yellowgem',           1.0},
	{'yellowgem',           1.0},
	{'yellowgem',           1.0},
	{'yellowgem',           1.0},
	{'yellowgem',           1.0},
	{'yellowgem',           1.0},
	
	--{'xxsq',           1.0},
	--{'xxsq',           1.0},
	--{'xxsq',           1.0},
	--{'xxsq',           1.0},
	--{'xxsq',           1.0},
	--{'xxsq',           1.0},
	
	{'halloweencandy_1',   0.05},
	{'halloweencandy_2',   0.05},
	{'halloweencandy_3',   0.05},
	{'halloweencandy_4',   0.05},
	{'halloweencandy_5',   0.05},
	{'halloweencandy_6',   0.05},
	{'halloweencandy_7',   0.05},
	{'halloweencandy_8',   0.25},
	{'halloweencandy_9',   0.00001},
	
	

    {'gears',           1.0},
    {'gears',           1.0},
    {'gears',           0.75},
    {'gears',           0.30},    
})

SetSharedLootTable('metal_hulk_merge_rock',
{
    {'rocks',  1.00},
    {'rocks',  1.00},
    {'rocks',  0.50},
    {'flint',  1.00},
    {'flint',  0.30},
})





local function PushMusic(inst)
    if ThePlayer == nil then
        inst._playingmusic = false
    elseif ThePlayer:IsNear(inst, inst._playingmusic and 40 or 20) then
        inst._playingmusic = true
        ThePlayer:PushEvent("triggeredevent", { name = "metal_hulk_merge" })
    elseif inst._playingmusic and not ThePlayer:IsNear(inst, 50) then
        inst._playingmusic = false
    end
end


local function ClearRecentlyCharged(inst, other)
    inst.recentlycharged[other] = nil
end

local function onothercollide(inst, other)
    if not other:IsValid() or not TadalinUtil.CanAttack(other) or inst.recentlycharged[other] then
        return
    elseif other:HasTag("smashable") and other.components.health ~= nil then
        --other.Physics:SetCollides(false)
        other.components.health:Kill()
    elseif other.components.workable ~= nil
        and other.components.workable:CanBeWorked()
        and other.components.workable.action ~= ACTIONS.NET then
        SpawnPrefab("collapse_small").Transform:SetPosition(other.Transform:GetWorldPosition())
        other.components.workable:Destroy(inst)
        if other:IsValid() and other.components.workable ~= nil and other.components.workable:CanBeWorked() then
            inst.recentlycharged[other] = true
            inst:DoTaskInTime(3, ClearRecentlyCharged, other)
        end
    elseif other.components.health ~= nil and not other.components.health:IsDead() and other.components.combat and TadalinUtil.CanAttack(other) then
        inst.recentlycharged[other] = true
        inst:DoTaskInTime(3, ClearRecentlyCharged, other)
        --inst.components.combat:DoAttack(other, inst.weapon)
		other.components.combat:GetAttacked(inst,TUNING.HULK_COLLIDE_ATK)
    end
end

local function oncollide(inst, other)
    if not (other ~= nil and other:IsValid() and inst:IsValid())
        or inst.recentlycharged[other]
        or other:HasTag("tadalin")
		or not TadalinUtil.CanAttack(other)
        or Vector3(inst.Physics:GetVelocity()):LengthSq() < 42
		or not inst.sg:HasStateTag("moving")
		 then
        return
    end
    ShakeAllCameras(CAMERASHAKE.SIDE, .5, .05, .1, inst, 40)
    inst:DoTaskInTime(2 * FRAMES, onothercollide, other)
end

local function onskilluse(inst,data)
	local skillname = data.name
	local skillcd = data.cd
	inst[skillname] = false 
	
	inst.components.timer:StartTimer(skillname,skillcd)
end 

local function ontimerdone(inst,data)
	local skillname = data.name
	inst[skillname] = true 
end 

local function onlightningdelta(inst)
	print(inst,"onlightningdelta",inst.LightningHealthDelta)
	if inst.LightningHealthDelta >= TUNING.HULK_HEALTH / 80  then 
		if inst.LightningHealthDelta <= TUNING.HULK_HEALTH / 8 then 
			if not (inst.ElecFx1 and inst.ElecFx1:IsValid()) then 
				inst.ElecFx1 = SpawnPrefab("metal_hulk_merge_overload_fx")
				inst.ElecFx1.entity:SetParent(inst.entity)
				inst.ElecFx1.entity:AddFollower()
				inst.ElecFx1.Follower:FollowSymbol(inst.GUID, "body01", 0,0, 0)
			end 
		elseif  inst.LightningHealthDelta <= TUNING.HULK_HEALTH / 4.5 then 
			if not (inst.ElecFx2 and inst.ElecFx2:IsValid()) then 
				inst.ElecFx2 = SpawnPrefab("metal_hulk_merge_overload_fx")
				inst.ElecFx2.Transform:SetScale(0.75,0.75,0.75)
				inst.ElecFx2.entity:SetParent(inst.entity)
				inst.ElecFx2.entity:AddFollower()
				inst.ElecFx2.Follower:FollowSymbol(inst.GUID, "horn02", 0,45, 0)
			end 
		elseif  inst.LightningHealthDelta <= TUNING.HULK_HEALTH / 3.2 then 
			if not (inst.ElecFx3 and inst.ElecFx3:IsValid()) then 
				inst.ElecFx3 = SpawnPrefab("metal_hulk_merge_overload_fx")
				inst.ElecFx3.entity:SetParent(inst.entity)
				inst.ElecFx3.Transform:SetScale(0.75,0.75,0.75)
				inst.ElecFx3.entity:AddFollower()
				inst.ElecFx3.Follower:FollowSymbol(inst.GUID, "segment01", 0,35, 0)
			end 
		elseif  inst.LightningHealthDelta <= TUNING.HULK_HEALTH / 2.1 then 
			if not (inst.ElecFx4 and inst.ElecFx4:IsValid()) then 
				inst.ElecFx4 = SpawnPrefab("metal_hulk_merge_overload_fx")
				inst.ElecFx4.entity:SetParent(inst.entity)
				inst.ElecFx4.entity:AddFollower()
				inst.ElecFx4.Follower:FollowSymbol(inst.GUID, "shoulder01", 0,0, 0)
			end 
		else
			if not inst.components.health:IsDead() then 
				inst:SpawnChild("laser_explosion").Transform:SetScale(1.5,1.5,1.5)
				inst.components.health:SetCurrentHealth(1)
				inst.LightningHealthDelta = 0
				if (inst.ElecFx1 and inst.ElecFx1:IsValid()) then 
					inst.ElecFx1:KillFx()
				end
				if (inst.ElecFx2 and inst.ElecFx2:IsValid()) then 
					inst.ElecFx2:KillFx()
				end
				if (inst.ElecFx3 and inst.ElecFx3:IsValid()) then 
					inst.ElecFx3:KillFx()
				end
				if (inst.ElecFx4 and inst.ElecFx4:IsValid()) then 
					inst.ElecFx4:KillFx()
				end
				
				inst:StartThread(function()
					local fx1 = SpawnPrefab("laser_explode_sm")
					fx1.entity:SetParent(inst.entity)
					fx1.entity:AddFollower()
					fx1.Follower:FollowSymbol(inst.GUID, "body01", 0,0, 0)
					fx1.Transform:SetScale(2,2,2)
					Sleep(0.2)
					local fx2 = SpawnPrefab("laser_explode_sm")
					fx2.entity:SetParent(inst.entity)
					fx2.entity:AddFollower()
					fx2.Follower:FollowSymbol(inst.GUID, "horn02", 0,45, 0)
					fx2.Transform:SetScale(2,2,2)
					Sleep(0.15)
					local fx3 = SpawnPrefab("laser_explode_sm")
					fx3.entity:SetParent(inst.entity)
					fx3.entity:AddFollower()
					fx3.Follower:FollowSymbol(inst.GUID, "segment01", 0,35, 0)
					fx3.Transform:SetScale(2,2,2)
					Sleep(0.1)
					local fx4 = SpawnPrefab("laser_explode_sm")
					fx4.entity:SetParent(inst.entity)
					fx4.entity:AddFollower()
					fx4.Follower:FollowSymbol(inst.GUID, "shoulder01", 0,0, 0)
					fx4.Transform:SetScale(2,2,2)
				end)
				
			end 
		end
	end 
	inst.components.combat:SetAttackPeriod(3*(1-inst.LightningHealthDelta / TUNING.HULK_HEALTH * 2.1))
end 

local function onlightning(inst)
	if inst.components.health and not inst.components.health:IsDead() then 
		local delta = math.random(TUNING.HULK_HEALTH / 40,TUNING.HULK_HEALTH / 16)
		inst.components.health:DoDelta(delta)
		inst.LightningHealthDelta = inst.LightningHealthDelta + delta 
		onlightningdelta(inst)
	end
end 



local function setfires(x,y,z, rad)
    for i, v in ipairs(TheSim:FindEntities(x, 0, z, rad, nil, { "laser", "DECOR", "INLIMBO","player","tadalin" })) do 
        if v.components.burnable and TadalinUtil.CanAttack(v)  then
            v.components.burnable:Ignite()
        end
    end
end

local function DoDamage(inst,pos,rad,damage)
    local targets = {}
	pos = pos or inst:GetPosition()
	damage = damage or 35
    local x, y, z = pos:Get()
  
    setfires(x,y,z, rad)
    for i, v in ipairs(TheSim:FindEntities(x, 0, z, rad, nil, { "laser", "DECOR", "INLIMBO" , "tadalin" })) do  --  { "_combat", "pickable", "campfire", "CHOP_workable", "HAMMER_workable", "MINE_workable", "DIG_workable" }
		if TadalinUtil.CanAttack(v) then 
			if not targets[v] and v:IsValid() and not v:IsInLimbo() and not (v.components.health ~= nil and v.components.health:IsDead()) and not v:HasTag("laser_immune") then            
				local vradius = 0
				if v.Physics then
					vradius = v.Physics:GetRadius()
				end

				local range = rad + vradius
				if v:GetDistanceSqToPoint(Vector3(x, y, z)) < range * range then
					local isworkable = false
					if v.components.workable ~= nil then
						local work_action = v.components.workable:GetWorkAction()
						--V2C: nil action for campfires
						isworkable =
							(   work_action == nil and v:HasTag("campfire")    ) or
							
								(   work_action == ACTIONS.CHOP or
									work_action == ACTIONS.HAMMER or
									work_action == ACTIONS.MINE or   
									work_action == ACTIONS.DIG
								)
					end
					if isworkable then
						targets[v] = true
						v:DoTaskInTime(0.6, function() 
							if v.components.workable then
								v.components.workable:Destroy(inst) 
								local vx,vy,vz = v.Transform:GetWorldPosition()
								v:DoTaskInTime(0.3, function() setfires(vx,vy,vz,1) end)
							end
						 end)
						if v:IsValid() and v:HasTag("stump") then
						   -- v:Remove()
						end
					elseif v.components.pickable ~= nil
						and v.components.pickable:CanBePicked()
						and not v:HasTag("intense") then
						targets[v] = true
						local num = v.components.pickable.numtoharvest or 1
						local product = v.components.pickable.product
						local x1, y1, z1 = v.Transform:GetWorldPosition()
						v.components.pickable:Pick(inst) -- only calling this to trigger callbacks on the object
						if product ~= nil and num > 0 then
							for i = 1, num do
								local loot = SpawnPrefab(product)
								loot.Transform:SetPosition(x1, 0, z1)
								targets[loot] = true
							end
						end

					elseif v.components.health and v.components.combat then                    
						--inst.components.combat:DoAttack(v)   
						v.components.combat:GetAttacked(inst,damage)             
						if v:IsValid() then
							if not v.components.health or not v.components.health:IsDead() then
								if v.components.freezable ~= nil then
									if v.components.freezable:IsFrozen() then
										v.components.freezable:Unfreeze()
									elseif v.components.freezable.coldness > 0 then
										v.components.freezable:AddColdness(-2)
									end
								end
								if v.components.temperature ~= nil then
									local maxtemp = math.min(v.components.temperature:GetMax(), 10)
									local curtemp = v.components.temperature:GetCurrent()
									if maxtemp > curtemp then
										v.components.temperature:DoDelta(math.min(10, maxtemp - curtemp))
									end
								end
							end
						end                   
					end
					if v:IsValid() and v.AnimState then
						SpawnPrefab("deerclops_laserhit"):SetTarget(v)
					end
				end
			end
		end
    end
end

---------------------------------------------------------------------------------------

local function color(x,y,tiles,islands,value)
    tiles[y][x] = false
    islands[y][x] = value
end

local function check_validity(x,y,w,h,tiles,stack)
    if x >= 1 and y >= 1 and x <= w and y <= h and tiles[y][x] then
        stack[#stack+1] = {x=x,y=y}
    end
end

local function floodfill(x,y,w,h,tiles,islands,value)
--    Queue q
    local q = {}
--    q.push((x,y))
    q[#q+1] = {x=x,y=y}
--    while (q is not empty)
    while #q > 0 do
--       (x1,y1) = q.pop()
        local el = q[#q] 
        table.remove(q)
        local x1,y1 = el.x, el.y
--       color(x1,y1)         -- islandmap[x,y] = color
--print("Color",x1,y1)
        color(x1,y1,tiles,islands,value)
                            
        check_validity(x1+1,y1,w,h,tiles,q)
        check_validity(x1-1,y1,w,h,tiles,q)
        check_validity(x1,y1+1,w,h,tiles,q)
           check_validity(x1,y1-1,w,h,tiles,q)
        -- diagonals
        check_validity(x1-1,y1-1,w,h,tiles,q)
        check_validity(x1-1,y1+1,w,h,tiles,q)
        check_validity(x1+1,y1-1,w,h,tiles,q)
            check_validity(x1+1,y1+1,w,h,tiles,q)

--            q.push(x1,y1-1)    
    end
end

local function dofloodfillfromcoord(x,y,w, h, tiles, islands)
    local index = 3
    local rescan = true
    local val = tiles[y][x]
    if val then
        floodfill(x,y,w,h,tiles,islands,index)
        index = index + 1
    end
end

function getDropLocations(inst)
   local islands = {}
   local tiles = {}
   local map = GetWorld().Map
   local w,h = map:GetSize()

   print("=====================================",w,h)

   for y = 1,h do
       tiles[y] = {}
       islands[y] = {}
       for x = 1, w do
           local tile = map:GetTile(x-1,y-1)

           tiles[y][x] = tile ~= GROUND.IMPASSABLE and tile ~= GROUND.LILYPOND
       end
   end
   local x,y,z = inst.Transform:GetWorldPosition()

   x = math.floor(x/4+ (w/2))
   z = math.floor(z/4 + (h/2))
   dofloodfillfromcoord(x,z,w, h, tiles, islands)

   local locations = {}
   for z=1,h do
       for x=1,w do
           if islands[z][x] then
               table.insert(locations,{x=x,z=z})
           end
       end
   end

   return locations
end

---------------------------------------------------------------------------------------

local function SetLightValue(inst, val1, val2, time)
    --print("LIGHT VALUE", val1, val2, time)
    inst.components.fader:StopAll()
    if val1 and val2 and time then
        inst.Light:Enable(true)
        inst.components.fader:Fade(val1, val2, time, function(v) inst.Light:SetIntensity(v) end)
    else    
        inst.Light:Enable(false)
    end
end


local function dropparts(inst)

    local locations = getDropLocations(inst)
    local map = GetWorld().Map
    local w,h = map:GetSize()

    assert(#locations > 0,"NO LOCATIONS!?!?!?")

    local parts = {
        "ancient_robot_claw",
        "ancient_robot_claw",
        "ancient_robot_leg",
        "ancient_robot_leg",
        "ancient_robot_ribs",
    }

    for i, part in ipairs(parts) do        
        local partprop = SpawnPrefab(part)
        partprop.spawntask:Cancel()
        partprop.spawntask = nil
        partprop.spawned = true
        partprop:AddTag("dormant")                                                    
        partprop.sg:GoToState("idle_dormant")

        local idx = math.random(1,#locations)
        local sample = locations[idx]          
        local loc = sample            
        table.remove(locations,idx)

        partprop.Transform:SetPosition( (loc.x-(w/2)) *4 -4,0, (loc.z-(h/2)) *4-4 )
        
        inst.DoDamage(partprop,3,TUNING.HULK_ATK)        
    end
end


--发射地雷
local function LaunchProjectile(inst, targetpos)
    local x, y, z = inst.Transform:GetWorldPosition()

    local projectile = SpawnPrefab("metal_hulk_merge_mine")

    projectile.primed = false
    projectile.AnimState:PlayAnimation("spin_loop",true)
    projectile.Transform:SetPosition(x, 1, z)

    --V2C: scale the launch speed based on distance
    --     because 15 does not reach our max range.
    local dx = targetpos.x - x
    local dz = targetpos.z - z
    local rangesq = dx * dx + dz * dz
    local maxrange = TUNING.FIRE_DETECTOR_RANGE
    local speed = easing.linear(rangesq, 15, 3, maxrange * maxrange)
    projectile.components.complexprojectile:SetHorizontalSpeed(speed)
    projectile.components.complexprojectile:SetGravity(-25)
    projectile.components.complexprojectile:Launch(targetpos, inst, inst)
    projectile.owner = inst
end

--发送一个光球
local function ShootProjectile(inst, targetpos)
    local x, y, z = inst.Transform:GetWorldPosition()

    local projectile = SpawnPrefab("metal_hulk_merge_orb")

    projectile.primed = false
    projectile.AnimState:PlayAnimation("spin_loop",true)

    local pt = inst.shotspawn:GetPosition()
    projectile.Transform:SetPosition(pt.x, pt.y+2.5, pt.z)
    --projectile.Transform:SetPosition(x, 4, z)

   -- inst.shotspawn:Remove()
   -- inst.shotspawn = nil

    local speed =  45 --  easing.linear(rangesq, 15, 3, maxrange * maxrange)
    projectile.components.complexprojectile:SetHorizontalSpeed(speed)
    projectile.components.complexprojectile:SetGravity(-150)
	targetpos.y = 0
    projectile.components.complexprojectile:Launch(targetpos, inst, inst)
    projectile.owner = inst
end

--创造壁垒
local function spawnbarrier(inst,pt)
    local angle = 0
    local radius = 13
    local number = 32
    for i=1,number do        
        local offset = Vector3(radius * math.cos( angle ), 0, -radius * math.sin( angle ))
        local newpt = pt + offset
        local tile = TheWorld.Map:GetTileAtPoint(newpt.x, newpt.y, newpt.z)

        if tile ~= GROUND.IMPASSABLE and tile ~= GROUND.INVALID then
            inst:DoTaskInTime(math.random()*0.3, function()            
                local rock = SpawnPrefab("metal_hulk_merge_rock")
                rock.AnimState:PlayAnimation("emerge")
                rock.AnimState:PushAnimation("full")

                rock.Transform:SetPosition(newpt.x,newpt.y,newpt.z)

            end)
        end
        angle = angle + (PI*2/number)
    end
end

local function checkforAttacks(inst)
    -- mine
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,y,z,20,{"ancient_hulk_mine"})
    if #ents < 2 then 
        inst.wantstomine = true
    else
        inst.wantstomine = nil
    end
    -- lob
    if inst.orbs > 0 then
        if inst.components.combat.target and inst.components.combat.target:IsValid() then
            local dist = inst:GetDistanceSqToInst(inst.components.combat.target)
            if dist > 10*10  and dist < 25*25 then
                inst.wantstolob = true
            else
                inst.wantstolob = nil
            end
        end
    else
        inst.orbtime = inst.orbtime -1
        if inst.orbtime <= 0 then
            inst.orbtime = nil
            inst.orbs = 2
        end
    end

    -- teleport
    if inst.components.combat.target and inst.components.combat.target:IsValid() then
        local dist = inst:GetDistanceSqToInst(inst.components.combat.target)
        if dist < 6*6 then
            if not inst.teleporttime then
                inst.teleporttime = 0
            end
            inst.teleporttime = inst.teleporttime + 1
            if inst.teleporttime > 5 then
                inst.wantstoteleport = true
            end
        else
            inst.teleporttime =  nil
        end
    end

--[[    -- spin
    if inst.components.combat.target and inst.components.combat.target:IsValid() and inst.components.health:GetPercent() < 0.5  then
        if not inst.spintime or inst.spintime <=0 then
            local dist = inst:GetDistanceSqToInst(inst.components.combat.target)
            if dist < 6*6 then
                inst.wantstospin = true
            else            
                inst.wantstospin = nil
            end
        else
            inst.spintime = inst.spintime - 1            
        end
    end--]]

    -- barrier?
    if inst.components.combat.target and inst.components.combat.target:IsValid() and inst.components.health:GetPercent() < 0.3  then
        if not inst.barriertime or inst.barriertime <=0 then
            local dist = inst:GetDistanceSqToInst(inst.components.combat.target)
            if dist < 6*6 then
                inst.wantstobarrier = true
            else            
                inst.wantstobarrier = nil
            end
        else
            inst.barriertime = inst.barriertime - 1            
        end
    end    
end


local function CanGroundPoundHit(inst,target)
	return TadalinUtil.CanAttack(target) 
end 

local function OnSave(inst,data)
	data.LightningHealthDelta = inst.LightningHealthDelta
end 

local function OnLoad(inst,data)
	if data then 
		inst.LightningHealthDelta = data.LightningHealthDelta
	end
	onlightningdelta(inst)
end 

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeGiantCharacterPhysics(inst, 1000,2.5)

    inst.DynamicShadow:SetSize(6, 3)
    inst.Transform:SetSixFaced()

    inst.AnimState:SetBank("metal_hulk")
    inst.AnimState:SetBuild("metal_hulk_build")
    inst.AnimState:PlayAnimation("idle",true)
	
	inst.AnimState:AddOverrideBuild("laser_explode_sm")
    inst.AnimState:AddOverrideBuild("smoke_aoe")    
    inst.AnimState:AddOverrideBuild("laser_explosion")   
    inst.AnimState:AddOverrideBuild("ground_chunks_breaking")   
	
	inst.Transform:SetScale(1.2,1.2,1.2)

    inst:AddTag("hostile")
    inst:AddTag("mech")
	inst:AddTag("epic")
	inst:AddTag("noepicmusic")
	inst:AddTag("lightningrod")
	
	inst._playingmusic = false
	if not TheNet:IsDedicated() then
        inst:DoPeriodicTask(1, PushMusic,0)
    end

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
	
	inst.LightningHealthDelta = 0
	inst.skill_circleatk = true 
	inst.recentlycharged = {} 
	inst.Physics:SetCollisionCallback(oncollide)
	inst.DoDamage = DoDamage
	inst.LaunchProjectile = LaunchProjectile
	inst.ShootProjectile = ShootProjectile
	inst.SetLightValue = SetLightValue
	inst.dropparts = dropparts
	inst.spawnbarrier = spawnbarrier
	
	inst.orbs = 2
	
	inst.OnSave = OnSave
	inst.OnLoad = OnLoad 

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 8
    inst.components.locomotor.runspeed = 8

    inst:SetStateGraph("SGmetal_hulk_merge")

    inst:SetBrain(brain)

   

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.HULK_HEALTH)
	inst.components.health.destroytime = 5

    inst:AddComponent("combat")
	inst.components.combat.playerdamagepercent = 0.5
    inst.components.combat:SetDefaultDamage(TUNING.HULK_ATK)
	inst.components.combat:SetAreaDamage(1.5,0.6)
    inst.components.combat:SetAttackPeriod(3)
	inst.components.combat:SetRange(5,4)
	inst.components.combat.externaldamagetakenmultipliers:SetModifier(inst,0.10,"merge_defence")


    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable("metal_hulk_merge")
	
	inst:AddComponent("ly_groundpounder")
    inst.components.ly_groundpounder.destroyer = true
    inst.components.ly_groundpounder.destructionRings = 3
    inst.components.ly_groundpounder.numRings = 3
	inst.components.ly_groundpounder.damageRings = 2
    inst.components.ly_groundpounder.groundpoundfx = "groundpound_fx_hulk"
	inst.components.ly_groundpounder.noTags = { "FX", "NOCLICK", "DECOR", "INLIMBO","tadalin","ancient_robot" }
	inst.components.ly_groundpounder.canhitFn = CanGroundPoundHit
	--inst.components.ly_groundpounder.groundpoundFn = groundpoundFn

    inst:AddComponent("knownlocations")
    inst:AddComponent("inspectable")
	inst:AddComponent("timer")
	
	inst:ListenForEvent("use_metalhulk_skill",onskilluse)
	inst:ListenForEvent("timerdone",ontimerdone)
	inst:ListenForEvent("lightningstrike", onlightning)
	
	TadalinUtil.MakeNormalTadalin(inst)
	
	local eye1 = SpawnPrefab("metal_hulk_eyeflame")
	eye1.entity:SetParent(inst.entity)
    eye1.entity:AddFollower()
    eye1.Follower:FollowSymbol(inst.GUID, "eye01", 0,0, 0)
	
	--[[local eye1 = SpawnPrefab("frostbreath")
	eye1.entity:SetParent(ThePlayer.entity)
    eye1.entity:AddFollower()
    eye1.Follower:FollowSymbol(ThePlayer.GUID, "swap_object", 0,-55, 0)--]]
	
	inst:DoPeriodicTask(1,checkforAttacks) 
	if not inst.shotspawn then
        inst.shotspawn = SpawnPrefab( "metal_hulk_marker" )        
        inst.shotspawn:Hide()
        inst.shotspawn.persists = false
        local follower = inst.shotspawn.entity:AddFollower()
        follower:FollowSymbol( inst.GUID, "hand01", 0,0,0 )
    end
	
	onlightningdelta(inst)
	
    return inst
end

local function DestroyWorks(inst,rad)
	local x,y,z = inst:GetPosition():Get()
	for k,v in pairs(TheSim:FindEntities(x,y,z,rad)) do 
		if v and v:IsValid() and v.components.workable then 
			v.components.workable:Destroy(inst) 
		end
	end
end 

local function Explode(inst,rad)
	local x,y,z = inst.Transform:GetWorldPosition()
	inst.Transform:SetPosition(x,0,z)
	x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,0,z,rad,{"_combat"},{"tadalin"})
	for k,v in pairs(ents) do 
		if TadalinUtil.CanAttack(v) then 
			if inst.master and inst.master:IsValid() then 
				v.components.combat:GetAttacked(inst.master,TUNING.HULK_BULLET_ATK)
			else
				inst.components.combat:DoAttack(v)
			end
		end
	end
	DestroyWorks(inst,rad) 
	
	SpawnAt("metal_hulk_bullet_hitfx",Vector3(x,y,z)).Transform:SetScale(2,2,2)
	SpawnAt("laser_ring",Vector3(x,y,z))
	inst.Hited = true
	if inst.Shock and inst.Shock:IsValid() then 
		inst.Shock:Remove() 
	end
	inst:Hide() 
	inst:DoTaskInTime(3,inst.Remove) 
end

local function canhit(inst,owner,target)
	return TadalinUtil.CanAttack(target)
end 

local function onhit(inst,owner,target)
	if not inst.Hited then 
		Explode(inst,3)
	end 
end 

local function onthrown(inst,owner)
	local targetpos = inst.components.ly_projectile.dest
	local startpos = inst:GetPosition()
	inst.StartPos = startpos
	
	local y_0_targetpos = Vector3(targetpos.x,0,targetpos.z)
	local y_0_startpos = Vector3(startpos.x,0,startpos.z)
	inst.StartLength = (y_0_targetpos - y_0_startpos):Length()
	inst.StartYSpeed = inst.y_speed 
	inst.StartZSpeed = inst.z_speed
	inst:ForceFacePoint(targetpos:Get())
	--print(string.format("startpos:%s targetpos:%s StartLength:%0.2f",tostring(startpos),tostring(targetpos),inst.StartLength))
end 

local function onupdate(inst,targetpos,delta_t)
	local mypos = inst:GetPosition()
	if mypos.y <= 0.03 and not inst.Hited then 
		Explode(inst,3)
	else
		--[[local y_0_targetpos = Vector3(targetpos.x,0,targetpos.z)
		local y_0_mypos = Vector3(mypos.x,0,mypos.z)
		
		local nowlength = (y_0_targetpos - y_0_mypos):Length()
		local startlength = inst.StartLength
		local startpos = inst.StartPos 
		local height = startpos.y
		
		local A = -4
		local B = (-A*startlength*startlength - height) / startlength
		local X = startlength - nowlength
		local K = 2*A*X+B
		
		local speed = inst.components.ly_projectile.speed
		local x_speed = speed / (math.sqrt(1+K*K))
		local y_speed = speed * K / (math.sqrt(1+K*K)) 
		
		
		print(string.format("Y = %.2fX^2 + %.2fX + %.2f,X = %.2f,K = %.2f,x_speed = %0.2f,y_speed = %.2f",A,B,height,X,K,x_speed,y_speed))--]]
		local y_0_targetpos = Vector3(targetpos.x,0,targetpos.z)
		local y_0_mypos = Vector3(mypos.x,0,mypos.z)
		
		local startpos = inst.StartPos 
		local startheight = startpos.y
		local startlength = inst.StartLength
		
		
		local nowlength = (y_0_targetpos - y_0_mypos):Length()
		
		local speed = inst.components.ly_projectile.speed
		local t_all = startlength / speed
		local t_remain = nowlength / speed
		
		local a = 2*(startheight+inst.StartYSpeed*t_all)/(t_all*t_all)*1.5
		
		local a_z = 2*inst.StartZSpeed/t_all*1.5
		
		inst.x_speed = speed
		inst.y_speed = inst.y_speed - a*delta_t 
		inst.z_speed = inst.z_speed - a_z*delta_t 
		
		--print(string.format("x_speed = %0.2f,y_speed = %.2f,z_speed = %.2f",inst.x_speed,inst.y_speed,inst.z_speed))
		--inst:ForceFacePoint(targetpos:Get())
		inst.Physics:SetMotorVel(inst.x_speed,inst.y_speed,inst.z_speed)
	end
end 

local function bulletfn()
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    --inst.entity:AddPhysics()
    inst.entity:AddNetwork()
	
	
	--MakeInventoryPhysics(inst)
    --RemovePhysicsColliders(inst)
	
	inst.Transform:SetScale(1.4,1.4,1.4)

    inst.AnimState:SetBank("death_dragon_ball_red")
    inst.AnimState:SetBuild("death_dragon_ball_red")
    inst.AnimState:PlayAnimation("fall",true)
    inst.AnimState:SetFinalOffset(1)
	inst.AnimState:SetLightOverride(1)
	inst.AnimState:SetMultColour(189/255,10/255,10/255,1)
	
	--MakeInventoryPhysics(inst)
    --RemovePhysicsColliders(inst)
	MakeTinyFlyingCharacterPhysics(inst,10,0.1)
	RemovePhysicsColliders(inst)
	inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(0)
	inst.Physics:SetCapsule(.01, .01)
	--[[inst.Physics:SetMass(1000)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(0)
    inst.Physics:SetCollisionGroup(COLLISION.FLYERS)
    inst.Physics:CollidesWith(COLLISION.WORLD)
    --inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    --inst.Physics:CollidesWith(COLLISION.ITEMS)
	inst.Physics:ClearCollisionMask()--]]
    --inst.Physics:SetCapsule(.2, .2)
	--RemovePhysicsColliders(inst)

    inst:AddTag("notarget")
	inst:AddTag("tadalin")
	inst:AddTag("projectile")
	
	inst.nameoverride = "metal_hulk_merge"
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
	inst.master = nil 
	inst.Hited = false 
	inst.StartLength = nil 
	inst.Shock = inst:SpawnChild("metal_hulk_bullet_shock")
	inst.Shock.Transform:SetPosition(0,0.5,0)
	
	inst.x_speed = 0
	inst.y_speed = 10
	inst.z_speed = 0
	
	inst.InitSpeed = function(self,speed)
		inst.x_speed,inst.y_speed,inst.z_speed = speed:Get() 
	end 

	
	inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.HULK_BULLET_ATK)
	inst.components.combat.playerdamagepercent = .5
	inst.components.combat:SetRange(4)
	inst.components.combat:SetAttackPeriod(0)
	
	inst:AddComponent("ly_projectile")
	inst.components.ly_projectile.damage = 0
	inst.components.ly_projectile:SetSpeed(12)
	inst.components.ly_projectile:SetHitDist(1)
	inst.components.ly_projectile:SetCanHit(canhit)
	inst.components.ly_projectile:SetLaunchOffset(Vector3(0,4,0))
	inst.components.ly_projectile:SetOnFreeUpdateFn(onupdate)
	inst.components.ly_projectile:SetOnThrownFn(onthrown)
	inst.components.ly_projectile:SetOnHitFn(onhit)
	
	
	
	
    return inst
end

local function bullet_hit_fx()
	local inst = CreateEntity()--以下这三句都是默认要添加的，这里就不解释那么多了
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	
	inst:AddTag("NO_TIME_STOP")
	inst:AddTag("FX")
	
	anim:SetBank("halloween_embers")-----前面两句是指定timecrack的图片边界和材质，在特效中作用不大，只是必写。
	anim:SetBuild("halloween_embers")
	anim:PlayAnimation("puff_"..tostring(math.random(1,3)))
	
	anim:SetMultColour(180/255,0,0,0.7)
	
	inst.AnimState:SetFinalOffset(3)
	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
	
	inst.persists = false
	
	inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end	  
	
	inst:ListenForEvent("animover", inst.Remove)
	
	return inst
end



local function OnMineCollide(inst, other)
    -- may want to do some charging damage?
end

local function OnHit(inst, dist)    
    inst.AnimState:PlayAnimation("land")
    inst.AnimState:PushAnimation("open")
    inst:ListenForEvent("animover", function() 
        if inst.AnimState:IsCurrentAnimation("open") then
            inst.primed  = true
            inst.AnimState:PlayAnimation("green_loop",true)
        end
    end)
end

local function onnearmine(inst)    
    if inst.primed  then
        inst.SetLightValue(inst, 0,0.75,0.2 )
        inst.AnimState:PlayAnimation("red_loop", true)
        inst:DoTaskInTime(0.8,function() 
            --explode, end beep
            ShakeAllCameras(CAMERASHAKE.FULL, 1.2, .03, .7, inst, 30)
            inst:Hide()
            local ring = SpawnPrefab("laser_ring")
            ring.Transform:SetPosition(inst.Transform:GetWorldPosition())
            inst:DoTaskInTime(0.3,function() 
				--DoDamage(inst, 3.5) 
				inst:DoDamage(nil,3.5,TUNING.HULK_MINE_ATK)
				inst:Remove() 
			end)    
            
            local explosion = SpawnPrefab("laser_explosion")
            explosion.Transform:SetPosition(inst.Transform:GetWorldPosition())
                                   
        end)
    end
end

local function minefn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	inst.glow = inst.entity:AddLight()    
    inst.glow:SetIntensity(.6)
    inst.glow:SetRadius(2)
    inst.glow:SetFalloff(1)
    inst.glow:SetColour(1, 0.3, 0.3)
    inst.glow:Enable(false)
	
    MakeInventoryPhysics(inst, 75, 0.5)

    

    anim:SetBank("metal_hulk_mine")
    anim:SetBuild("metal_hulk_bomb")
    anim:PlayAnimation("green_loop", true)
	
	inst.nameoverride = "metal_hulk_merge"

    inst:AddTag("ancient_hulk_mine")
	inst:AddTag("tadalin")
	
	inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end	  
	
	inst.primed =true
	inst.persists = false
	inst.DoDamage = DoDamage 
	
	inst.Physics:SetCollisionCallback(OnMineCollide)
	
    inst:AddComponent("locomotor")
	
    inst:AddComponent("complexprojectile")
    inst.components.complexprojectile:SetOnHit(OnHit)
	inst.components.complexprojectile:SetLaunchOffset(Vector3(0,2.5,0))

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.HULK_MINE_ATK)
    --inst.components.combat.playerdamagepercent = .5

    inst:AddComponent("fader")
	
    

    inst.SetLightValue = SetLightValue

    --inst:AddComponent("creatureprox")   
    --inst.components.creatureprox.period = 0.01
    --inst.components.creatureprox:SetDist(3.5,5) 
    --inst.components.creatureprox:SetOnPlayerNear(onnearmine)
	inst.CreatureNearTask = inst:DoPeriodicTask(0.1,function()
		local ent = FindEntity(inst,3.5,function(guy)
			return TadalinUtil.CanAttack(guy) and guy.components.combat and 
				guy.components.health and not guy.components.health:IsDead() 
		end,{"_combat"},{"INLIMBO","FX","playerghost"})
		if ent and inst.primed then 
			if inst.CreatureNearTask then 
				onnearmine(inst) 
				inst.CreatureNearTask:Cancel()
				inst.CreatureNearTask = nil 
			end 
		end
	end)

    return inst
end

local function OnHitOrb(inst)    
    ShakeAllCameras(CAMERASHAKE.FULL, 1.2, .03, .7, inst, 30)
    inst.AnimState:PlayAnimation("impact")  
    inst:ListenForEvent("animover", function() 
        if inst.AnimState:IsCurrentAnimation("impact") then
           inst:Remove()
        end
    end)
    local ring = SpawnPrefab("laser_ring")
    ring.Transform:SetPosition(inst.Transform:GetWorldPosition())     
    inst:DoTaskInTime(0.3,function() inst:DoDamage(nil,3.5,TUNING.HULK_BALL_ATK) end)
end

local function orbfn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	
	inst.glow = inst.entity:AddLight()    
    inst.glow:SetIntensity(.6)
    inst.glow:SetRadius(3)
    inst.glow:SetFalloff(1)
    inst.glow:SetColour(1, 0.3, 0.3)
    inst.glow:Enable(true)

    MakeInventoryPhysics(inst, 75, 0.5)
	RemovePhysicsColliders(inst)

    

    anim:SetBank("metal_hulk_projectile")
    anim:SetBuild("metal_hulk_projectile")
    anim:PlayAnimation("spin_loop", true)

    inst:AddTag("ancient_hulk_orb")
	inst:AddTag("tadalin")
	
	inst.nameoverride = "metal_hulk_merge"
	
	inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end	  

    inst.persists = false
	inst.DoDamage = DoDamage 
	
	inst.Physics:SetCollisionCallback(OnMineCollide)

    inst:AddComponent("locomotor")
	
    inst:AddComponent("complexprojectile")
    inst.components.complexprojectile:SetOnHit(OnHitOrb)
    inst.components.complexprojectile:SetLaunchOffset(Vector3(0,2.5,0))

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.HULK_BALL_ATK)
    inst.components.combat.playerdamagepercent = 0.5


    inst:AddComponent("fader")
    

    inst.SetLightValue = SetLightValue
	--[[inst.CreatureNearTask = inst:DoPeriodicTask(0.03,function()
		local ent = FindEntity(inst,3.5,function(guy)
			return TadalinUtil.CanAttack(guy) and guy.components.combat and 
				guy.components.health and not guy.components.health:IsDead() 
		end,{"_combat"},{"INLIMBO","FX"})
		if ent then 
			if inst.CreatureNearTask then 
				OnHitOrb(inst) 
				inst.CreatureNearTask:Cancel()
				inst.CreatureNearTask = nil 
			end 
		end
	end)--]]


    return inst
end


local function OnWork(inst, worker, workleft)
    if workleft <= 0 then
        local pt = inst:GetPosition()
        SpawnPrefab("rock_break_fx").Transform:SetPosition(pt:Get())
        inst.components.lootdropper:DropLoot(pt)

        if inst.showCloudFXwhenRemoved then
            local fx = SpawnPrefab("collapse_small")
            fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        end

		if not inst.doNotRemoveOnWorkDone then
	        inst:Remove()
		end
    else
        inst.AnimState:PlayAnimation(
            (workleft < TUNING.ROCKS_MINE / 3 and "low") or
            (workleft < TUNING.ROCKS_MINE * 2 / 3 and "med") or
            "full"
        )
    end
end

local function basalt_fn()
	local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("rock.png")

    inst.AnimState:SetBank("rock_basalt")
	inst.AnimState:SetBuild("rock_basalt")
	inst.AnimState:PlayAnimation("full")

    MakeSnowCoveredPristine(inst)

    inst:AddTag("boulder")
	
	inst.nameoverride = "rock1"
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper") 
	inst.components.lootdropper:SetChanceLootTable('metal_hulk_merge_rock')

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
    inst.components.workable:SetOnWorkCallback(OnWork)

    local color = 0.5 + math.random() * 0.5
    inst.AnimState:SetMultColour(color, color, color, 1)

    inst:AddComponent("inspectable")
	inst.components.inspectable.nameoverride = "ROCK"
	
    MakeSnowCovered(inst)

    MakeHauntableWork(inst)

    return inst
end

local function ringfxfn()
	local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("metal_hulk_ring_fx")
	inst.AnimState:SetBuild("metal_hulk_ring_fx")
	inst.AnimState:PlayAnimation("idle")
	
	inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 2 )
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:ListenForEvent("animover", inst.Remove)
	return inst
end

local function pondringfn()
	local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("bearger_ground_fx")
	inst.AnimState:SetBuild("bearger_ground_fx")
	inst.AnimState:PlayAnimation("idle")
	
	inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 2 )
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	
	inst:ListenForEvent("animover", inst.Remove)
	return inst
end



local function markerfn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
  --  local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
    return inst
end

local function elecfxfn()
	local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("lavaarena_hammer_attack_fx")
	inst.AnimState:SetBuild("lavaarena_hammer_attack_fx")
	inst.AnimState:PlayAnimation(math.random() <= 0.5 and "crackle_loop" or "crackle_pst",true)
	inst.AnimState:SetAddColour((190+math.random()*60)/255,0,0,1)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst.KillFx = function(self)
		self.AnimState:PushAnimation("crackle_pst",false)
		self:ListenForEvent("animover", function() 
			if self.AnimState:IsCurrentAnimation("crackle_pst") then
				self:Remove()
			end
		end) 
    end
	
	return inst
end

return Prefab("metal_hulk_merge", fn, assets, prefabs),
Prefab("metal_hulk_bullet", bulletfn, assets_ball),
Prefab("metal_hulk_bullet_hitfx", bullet_hit_fx,assets_ball),
Prefab("metal_hulk_merge_mine", minefn, assets, prefabs),
Prefab("metal_hulk_merge_orb", orbfn, assets, prefabs),
Prefab("metal_hulk_merge_rock", basalt_fn, assets, prefabs),
Prefab("metal_hulk_ring_fx",ringfxfn,assets,prefabs),
Prefab("groundpound_fx_hulk",pondringfn,assets,prefabs),
Prefab( "metal_hulk_merge_overload_fx", elecfxfn, assets, prefabs),
Prefab( "metal_hulk_marker", markerfn, assets, prefabs)
--c_findnext("metal_hulk_merge").sg:GoToState("taunt")