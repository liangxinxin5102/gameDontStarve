local assets =
{
    Asset("ANIM", "anim/z_greenspear.zip"),
    Asset("ANIM", "anim/z_greenspear_s.zip"),
    
    Asset("ATLAS", "images/inventoryimages/qlyyd.xml"),
}

local prefabs =
{
    "ice_projectile",
    "staffcastfx",
    "stafflight",
	"splash_ocean",
    "book_fx"
}

local function onfack(inst)
	local pos = Vector3(inst.Transform:GetWorldPosition())
	local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 15)
	local gettar = 0
	for k,v in pairs(ents) do
		if v.components.health and gettar == 0 and not v:HasTag("player") then
			inst.components.weapon:LaunchProjectile(inst, v)
			SpawnPrefab("lightning").Transform:SetPosition(v.Transform:GetWorldPosition())
			v.components.health:DoDelta(-50)
			gettar = 1
		end
	end
end

local function turnon(inst)
if TUNING.FYT then
	inst.components.machine.ison = true
	inst.task = inst:DoPeriodicTask(2, function() onfack(inst) end)
end
end

local function turnoff(inst)
if TUNING.FYT then
	inst.components.machine.ison = false
	if inst.task then inst.task:Cancel() inst.task = nil end
end
end
------------------------------------------------------
local function jtxg(inst, target)		
    SpawnPrefab("stalker_shield2").Transform:SetPosition(target.Transform:GetWorldPosition())
end

local function gjxg(inst, target)		
	SpawnPrefab("explode_small_slurtlehole").Transform:SetPosition(target.Transform:GetWorldPosition())

    if not inst then return end
      
    local numFX = math.random(20,20)
    local pos = inst:GetPosition()
    local targetPos = target and target:GetPosition()
    local vec = targetPos - pos
    vec = vec:Normalize()
    local dist = pos:Dist(targetPos)
    local angle = inst:GetAngleToPoint(targetPos:Get())

    for i = 1, numFX do
        inst:DoTaskInTime(math.random() * 0.25, function(inst)
            local prefab = "fossilspike2"
            local fx = SpawnPrefab(prefab)
            if fx then
                local x = GetRandomWithVariance(0, 2)
                local z = GetRandomWithVariance(0, 2)
                local offset = (vec * math.random(dist * 0.25, dist)) + Vector3(x,0,z)
                fx.Transform:SetPosition((offset+pos):Get())
                
                local x,y,z = fx.Transform:GetWorldPosition()
                
                
                local r = 1.5
                
                
                local dmg = math.random() * 50 * 1
                
                local ents = TheSim:FindEntities(x,y,z,r)
                for k, v in pairs(ents) do
                
                    
                    if v and v.components.health and not v.components.health:IsDead() and v.components.combat and
                        v ~= inst and
                        not (v.components.follower and v.components.follower.leader == inst ) and 
                        (TheNet:GetPVPEnabled() or not v:HasTag("player"))
                    then
                            v.components.combat:GetAttacked( inst, dmg )                      
                    end
                end
                
            end
        end)
    end

end
-------------------------------------------
local function tlzhs(staff, target, pos)
    local dqw = SpawnPrefab("tls")
    dqw.Transform:SetPosition(pos:Get())
	local dyxg = SpawnPrefab("collapse_big")
    dyxg.Transform:SetPosition(pos:Get())
	dyxg.Transform:SetScale(2,2,2)

    staff.components.finiteuses:Use(50)

    local caster = staff.components.inventoryitem.owner
    if caster ~= nil and caster.components.sanity ~= nil then
        caster.components.sanity:DoDelta(-1)
    end
end
-----------------------------------
local function onblink(staff, pos, caster)

    if caster.components.sanity ~= nil then
        caster.components.sanity:DoDelta(0)
    end
	staff.components.finiteuses:Use(10)
end

local function blinkstaff_reticuletargetfn()
    local player = ThePlayer
	local rotation = player.Transform:GetRotation() * DEGREES
    local pos = player:GetPosition()
    for r = 13, 1, -1 do
        local numtries = 2 * PI * r
        local pt = FindWalkableOffset(pos, rotation, r, numtries)
        if pt ~= nil then
            return pt + pos
        end
    end
end
------------------------------------------
local function TryAddHp(ariahpbook, whoaddhp)
    if whoaddhp:HasTag("player") then
        whoaddhp.components.health:DoDelta(50)
		whoaddhp.components.sanity:DoDelta(30)
    end
	
end

function aria_paradise(inst, reader)
    reader.components.sanity:DoDelta(0)
	reader.components.talker:Say("沐浴圣光吧")
	inst.components.finiteuses:Use(50)
    local x, y, z = reader.Transform:GetWorldPosition()
    local range = 30
    local ents = TheSim:FindEntities(x, y, z, range)
    for i, v in ipairs(ents) do
        TryAddHp(inst, v)
    end
    return true
end
----------------------------------------------


----------------------------------------------------
function qlyyd(inst, reader)
    reader.components.sanity:DoDelta(-1000)
	reader.components.hunger:DoDelta(-1000)
    local x, y, z = reader.Transform:GetWorldPosition()
    local range = 80
	inst.components.finiteuses:Use(99999)
	
    local ents = TheSim:FindEntities(x, y, z, range)
    for i, v in ipairs(ents) do
		if v.components.health and not v:HasTag("player") then
		    v.components.health:DoDelta(-10000)
		elseif v:HasTag("smashable") then
			v.components.health:Kill()
		end
	end
    return true
end
---------------------------------------
local function OnGetItemFromPlayer(inst, giver, item)
if TUNING.XB then
    local current = inst.components.finiteuses:GetPercent() + 0.3
    if current > 1 then
        inst.components.finiteuses:SetPercent(1)
    else
        inst.components.finiteuses:SetPercent(current)
    end
end

if TUNING.SMSX then
inst.components.sjxt.level = inst.components.sjxt.level + 1
inst:DoTaskInTime(0.02, function() inst.components.weapon:SetDamage(math.ceil(TUNING.QLYYD_DAMAGE*(1+.1*inst.components.sjxt.level)))end)
end

if TUNING.WDHD then
local kqwal = SpawnPrefab("forcefieldfx")
	kqwal:DoTaskInTime(0, function()
	kqwal.entity:SetParent(giver.entity)
	giver.components.health:SetInvincible(true)
	giver.components.talker:Say("护盾开启")
	end)
	kqwal:DoTaskInTime(1, function()
	end)
	kqwal:DoTaskInTime(2, function()
	end)
	kqwal:DoTaskInTime(3, function()
	end)
	kqwal:DoTaskInTime(4, function()
	end)
	kqwal:DoTaskInTime(5, function()
	giver.components.talker:Say("护盾还剩10秒")
	end)
	kqwal:DoTaskInTime(6, function()
	end)
	kqwal:DoTaskInTime(7, function()
	end)
	kqwal:DoTaskInTime(8, function()
	end)
	kqwal:DoTaskInTime(9, function()
	end)
	kqwal:DoTaskInTime(10, function()
	giver.components.talker:Say("护盾还剩5秒")
	end)
	kqwal:DoTaskInTime(11, function()
	end)
	kqwal:DoTaskInTime(12, function()
	end)
	kqwal:DoTaskInTime(13, function()
	end)
	kqwal:DoTaskInTime(14, function()
	end)
	kqwal:DoTaskInTime(15, function()
	giver.components.talker:Say("护盾即将结束")
	end)
	kqwal:DoTaskInTime(16, function()
	kqwal:Remove()
	giver.components.health:SetInvincible(false)
	end)
end

end

local function onattack_blue(inst, attacker, target, skipsanity)
    local current = inst.components.finiteuses:GetUses()
    if current <= 0 then return end
    if not skipsanity and attacker ~= nil and attacker.components.sanity ~= nil then
        attacker.components.sanity:DoDelta(0)
    end

    if not target:IsValid() then
        --target killed or removed in combat damage phase
        return
    end

    if target.components.sleeper ~= nil and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
    end

    if target.components.burnable ~= nil then
        if target.components.burnable:IsBurning() then
            target.components.burnable:Extinguish()
        elseif target.components.burnable:IsSmoldering() then
            target.components.burnable:SmotherSmolder()
        end
    end

    if target.components.combat ~= nil then
        target.components.combat:SuggestTarget(attacker)
    end

    if target.sg ~= nil and not target.sg:HasStateTag("frozen") then
        target:PushEvent("attacked", { attacker = attacker, damage = 0 })
    end

    if target.components.freezable ~= nil then
        target.components.freezable:AddColdness(1)
        target.components.freezable:SpawnShatterFX()
    end
end

local function onhauntblue(inst, haunter)
    if math.random() <= TUNING.HAUNT_CHANCE_RARE then
        local x, y, z = inst.Transform:GetWorldPosition() 
        local ents = TheSim:FindEntities(x, y, z, 20, { "freezable" }, { "INLIMBO" })
        if #ents > 0 then
            for i, v in ipairs(ents) do
                if v:IsValid() and not v:IsInLimbo() then
                    onattack_blue(inst, haunter, v, true) 
                end
            end
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_LARGE
            return true
        end
    end
    return false
end

local function createicespell(staff, target, pos)
    local current = staff.components.finiteuses:GetPercent()
    if current < TUNING.XHNJ then 
        return
    else
        staff.components.finiteuses:SetPercent(current - TUNING.XHNJ)
    end

    local spell = SpawnPrefab("deer_ice_circle")
    local fx = SpawnPrefab("deer_ice_fx")
	local light = SpawnPrefab("positronbeam_back")
	local jh1 = SpawnPrefab("lightning")
	local bz = SpawnPrefab("sporecloud")
	local nima = SpawnPrefab("deer_fire_circle")
	local ah = SpawnPrefab("atrium_gate_activatedfx")
	local jg = SpawnPrefab("staffcoldlight")
	local mx = SpawnPrefab("stafflight")
	local yx1 = SpawnPrefab("shadowmeteor")
	local yx2 = SpawnPrefab("shadowmeteor")
	local yx3 = SpawnPrefab("shadowmeteor")
	local yx4 = SpawnPrefab("shadowmeteor")
	local yx5 = SpawnPrefab("shadowmeteor")
	local yx6 = SpawnPrefab("shadowmeteor")
	local yx7 = SpawnPrefab("shadowmeteor")
	local yx8 = SpawnPrefab("shadowmeteor")
	local ljf1 = SpawnPrefab("tornado")
	local ljf2 = SpawnPrefab("tornado")
	local ljf3 = SpawnPrefab("tornado")
	local ljf4 = SpawnPrefab("tornado")
	local ljf5 = SpawnPrefab("tornado")
	local ljf6 = SpawnPrefab("tornado")
	local ljf7 = SpawnPrefab("tornado")
	local ljf8 = SpawnPrefab("tornado")
	local sw = SpawnPrefab("wathgrithr_spirit")
	local huoyan = SpawnPrefab("lavalight")
	local yg = SpawnPrefab("deer_ice_flakes")
	local lsd = SpawnPrefab("antlion_sinkhole")
    local x, y, z = pos:Get()
    local caster = staff.components.inventoryitem.owner
    spell.Transform:SetPosition(pos:Get())
	spell.Transform:SetScale(2,2,2)
    fx.Transform:SetPosition(pos:Get())
	fx.Transform:SetScale(2,2,2)
	light.Transform:SetPosition(pos:Get())
	light.Transform:SetScale(2,2,2)
	light:DoTaskInTime(30, spell.KillFX)
	jh1.Transform:SetPosition(pos:Get())
	jh1.Transform:SetScale(2,2,2)
	nima.Transform:SetPosition(pos:Get())
	nima.Transform:SetScale(2,2,2)
	nima:DoTaskInTime(30, spell.KillFX)
	ah.Transform:SetPosition(pos:Get())
	ah.Transform:SetScale(2,2,2)
	ah:DoTaskInTime(30, spell.KillFX)
	bz.Transform:SetPosition(pos:Get())
	bz.Transform:SetScale(2,2,2)
	jg.Transform:SetPosition(pos:Get())
	jg.Transform:SetScale(2,2,2)
	jg:DoTaskInTime(30, spell.KillFX)
	mx.Transform:SetPosition(pos:Get())
	mx.Transform:SetScale(2,2,2)
	mx:DoTaskInTime(30, spell.KillFX)
	yx1.Transform:SetPosition(pos:Get())
	yx1.Transform:SetScale(2,2,2)
	yx2.Transform:SetPosition(pos:Get())
	yx2.Transform:SetScale(2,2,2)
	yx3.Transform:SetPosition(pos:Get())
	yx3.Transform:SetScale(2,2,2)
	yx4.Transform:SetPosition(pos:Get())
	yx4.Transform:SetScale(2,2,2)
	yx5.Transform:SetPosition(pos:Get())
	yx5.Transform:SetScale(2,2,2)
	yx6.Transform:SetPosition(pos:Get())
	yx6.Transform:SetScale(2,2,2)
	yx7.Transform:SetPosition(pos:Get())
	yx7.Transform:SetScale(2,2,2)
	yx8.Transform:SetPosition(pos:Get())
	yx8.Transform:SetScale(2,2,2)
	ljf1.Transform:SetPosition(pos:Get())
	ljf1.Transform:SetScale(2,2,2)
	ljf2.Transform:SetPosition(pos:Get())
	ljf2.Transform:SetScale(2,2,2)
	ljf3.Transform:SetPosition(pos:Get())
	ljf3.Transform:SetScale(2,2,2)
	ljf4.Transform:SetPosition(pos:Get())
	ljf4.Transform:SetScale(2,2,2)
	ljf5.Transform:SetPosition(pos:Get())
	ljf5.Transform:SetScale(2,2,2)
	ljf6.Transform:SetPosition(pos:Get())
	ljf6.Transform:SetScale(2,2,2)
	ljf7.Transform:SetPosition(pos:Get())
	ljf7.Transform:SetScale(2,2,2)
	ljf8.Transform:SetPosition(pos:Get())
	ljf8.Transform:SetScale(2,2,2)
	sw.Transform:SetPosition(pos:Get())
	sw.Transform:SetScale(2,2,2)
	sw:DoTaskInTime(30, spell.KillFX)
	huoyan.Transform:SetPosition(pos:Get())
	huoyan.Transform:SetScale(2,2,2)
	yg.Transform:SetPosition(pos:Get())
	yg.Transform:SetScale(2,2,2)
	yg:DoTaskInTime(30, spell.KillFX)
	lsd.Transform:SetPosition(pos:Get())
	lsd.Transform:SetScale(2,2,2)
	lsd:DoTaskInTime(30, spell.KillFX)
    spell:DoTaskInTime(1, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "lightning"
                   local dsd = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   dsd.Transform:SetPosition(tx,ty,tz)
                   dsd.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end)
    spell:DoTaskInTime(2, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "lightning"
                   local dsd = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   dsd.Transform:SetPosition(tx,ty,tz)
                   dsd.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end)
    spell:DoTaskInTime(3, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "lightning"
                   local dsd = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   dsd.Transform:SetPosition(tx,ty,tz)
                   dsd.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end)
    spell:DoTaskInTime(4, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "lightning"
                   local dsd = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   dsd.Transform:SetPosition(tx,ty,tz)
                   dsd.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end)
	spell:DoTaskInTime(5, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "lightning"
                   local dsd = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   dsd.Transform:SetPosition(tx,ty,tz)
                   dsd.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end)
    spell:DoTaskInTime(6, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "tornado"
                   local dxf = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   dxf.Transform:SetPosition(tx,ty,tz)
                   dxf.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end)
    spell:DoTaskInTime(7, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "tornado"
                   local dxf = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   dxf.Transform:SetPosition(tx,ty,tz)
                   dxf.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end)
	spell:DoTaskInTime(8, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "tornado"
                   local dxf = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   dxf.Transform:SetPosition(tx,ty,tz)
                   dxf.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end)
    spell:DoTaskInTime(9, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "tornado"
                   local dxf = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   dxf.Transform:SetPosition(tx,ty,tz)
                   dxf.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end)
    spell:DoTaskInTime(10, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "tornado"
                   local dxf = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   dxf.Transform:SetPosition(tx,ty,tz)
                   dxf.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end)
    spell:DoTaskInTime(11, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "shadowmeteor"
                   local dlx = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   dlx.Transform:SetPosition(tx,ty,tz)
                   dlx.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end) 
    spell:DoTaskInTime(12, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "shadowmeteor"
                   local dlx = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   dlx.Transform:SetPosition(tx,ty,tz)
                   dlx.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end) 
    spell:DoTaskInTime(13, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "shadowmeteor"
                   local dlx = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   dlx.Transform:SetPosition(tx,ty,tz)
                   dlx.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end)        
	spell:DoTaskInTime(14, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "shadowmeteor"
                   local dlx = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   dlx.Transform:SetPosition(tx,ty,tz)
                   dlx.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end) 
    spell:DoTaskInTime(15, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "shadowmeteor"
                   local dlx = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   dlx.Transform:SetPosition(tx,ty,tz)
                   dlx.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end) 
    spell:DoTaskInTime(16, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "icespike_fx_"..math.random(1,4)
                   local icespike = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   icespike.Transform:SetPosition(tx,ty,tz)
                   icespike.Transform:SetScale(5,5,5)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end)        
	spell:DoTaskInTime(17, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "icespike_fx_"..math.random(1,4)
                   local icespike = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   icespike.Transform:SetPosition(tx,ty,tz)
                   icespike.Transform:SetScale(5,5,5)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end
    end)
    spell:DoTaskInTime(18, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
				if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "icespike_fx_"..math.random(1,4)
                   local icespike = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   icespike.Transform:SetPosition(tx,ty,tz)
                   icespike.Transform:SetScale(5,5,5)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end    
    end)	
	spell:DoTaskInTime(19, function()
    local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
		    if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
                if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "icespike_fx_"..math.random(1,4)
                   local icespike = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   icespike.Transform:SetPosition(tx,ty,tz)
                   icespike.Transform:SetScale(5,5,5)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end    
    end)
    spell:DoTaskInTime(20, function()
    local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
		    if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
                if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "icespike_fx_"..math.random(1,4)
                   local icespike = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   icespike.Transform:SetPosition(tx,ty,tz)
                   icespike.Transform:SetScale(5,5,5)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end    
    end)	
	spell:DoTaskInTime(21, function()
    local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
		    if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
                if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "deciduous_root"
                   local csgj = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   csgj.Transform:SetPosition(tx,ty,tz)
                   csgj.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end    
    end)
	spell:DoTaskInTime(22, function()
    local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
		    if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
                if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "deciduous_root"
                   local csgj = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   csgj.Transform:SetPosition(tx,ty,tz)
                   csgj.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end    
    end)
	spell:DoTaskInTime(23, function()
    local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
		    if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
                if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "deciduous_root"
                   local csgj = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   csgj.Transform:SetPosition(tx,ty,tz)
                   csgj.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end    
    end)
	spell:DoTaskInTime(24, function()
    local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
		    if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
                if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "deciduous_root"
                   local csgj = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   csgj.Transform:SetPosition(tx,ty,tz)
                   csgj.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end    
    end)
		spell:DoTaskInTime(25, function()
    local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
		    if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
                if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "deciduous_root"
                   local csgj = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   csgj.Transform:SetPosition(tx,ty,tz)
                   csgj.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end    
    end)
	spell:DoTaskInTime(26, function()
    local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
		    if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
                if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "sandspike"
                   local szjc = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   szjc.Transform:SetPosition(tx,ty,tz)
                   szjc.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end    
    end)
	spell:DoTaskInTime(27, function()
    local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
		    if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
                if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "sandspike"
                   local szjc = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   szjc.Transform:SetPosition(tx,ty,tz)
                   szjc.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end    
    end)
	spell:DoTaskInTime(28, function()
    local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
		    if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
                if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "sandspike"
                   local szjc = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   szjc.Transform:SetPosition(tx,ty,tz)
                   szjc.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end    
    end)
	spell:DoTaskInTime(29, function()
    local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
		    if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
                if v and v.components.health and not v.components.health:IsDead() then
                   local prefab = "sandspike"
                   local szjc = SpawnPrefab(prefab)
                   local targetPos = v:GetPosition()
                   local tx, ty, tz = targetPos:Get()
                   szjc.Transform:SetPosition(tx,ty,tz)
                   szjc.Transform:SetScale(2,2,2)
                   v.components.health:DoDelta(-60)
                   v:PushEvent("attacked", { attacker = caster, damage = 0 })
				end
            end
        end    
    end)
    spell:DoTaskInTime(30, spell.KillFX) --持续20秒
    fx:DoTaskInTime(30, function()
        local ents = TheSim:FindEntities(x, y, z, 20, nil, {"player"})
        for k, v in pairs(ents) do
            if v and v.components.health and not v.components.health:IsDead() then
                local prefab = "sandspike"
                local szjc = SpawnPrefab(prefab)
                local targetPos = v:GetPosition()
                local tx, ty, tz = targetPos:Get()
                szjc.Transform:SetPosition(tx,ty,tz)
                szjc.Transform:SetScale(2,2,2)
                v.components.health:DoDelta(-60)
                v:PushEvent("attacked", { attacker = caster, damage = 0 })
            end
        end    
        fx:Remove()
    end)

    if caster ~= nil and caster.components.sanity ~= nil then
		caster.components.sanity:DoDelta(-TUNING.XHJS)
    end
	     if caster ~= nil and caster.components.hunger ~= nil then
	         caster.components.hunger:DoDelta(-TUNING.XHJE)
	     end
    print("超级魔法!")
end
-----COMMON FUNCTIONS---------

local function qlyyd_lightfn()
    local inst = CreateEntity()	

    inst.entity:AddTransform()	
    inst.entity:AddLight()		
    inst.entity:AddNetwork()	

    inst:AddTag("FX")	

    inst.Light:SetIntensity(TUNING.QLYYD_LIGHT_INTENSITY)	
    inst.Light:SetRadius(TUNING.QLYYD_LIGHT_RADIUS)		
    inst.Light:Enable(true)		
    inst.Light:SetFalloff(1)	
    inst.Light:SetColour(200/255, 200/255, 200/255)		

    inst.entity:SetPristine()	

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false	

    return inst
end


local function lighton(inst, owner)
    if inst._light == nil or not inst._light:IsValid() then
        inst._light = SpawnPrefab("qlyyd_light")
    end
    if owner ~= nil then
        inst._light.entity:SetParent(owner.entity)
    end
end


local function lightoff(inst)
    if inst._light ~= nil then
            if inst._light:IsValid() then
                inst._light:Remove()
            end
            inst._light = nil
        end
end

local function SpawnIceFx(inst, target)		
    if not inst then return end
    
    inst.SoundEmitter:PlaySound("dontstarve/creatures/deerclops/swipe")
    
    local numFX = math.random(15,20)
    local pos = inst:GetPosition()
    local targetPos = target and target:GetPosition()
    local vec = targetPos - pos
    vec = vec:Normalize()
    local dist = pos:Dist(targetPos)
    local angle = inst:GetAngleToPoint(targetPos:Get())

    for i = 1, numFX do
        inst:DoTaskInTime(math.random() * 0.25, function(inst)
            local prefab = "icespike_fx_"..math.random(1,4)
            local fx = SpawnPrefab(prefab)
            if fx then
                local x = GetRandomWithVariance(0, 2)
                local z = GetRandomWithVariance(0, 2)
                local offset = (vec * math.random(dist * 0.25, dist)) + Vector3(x,0,z)
                fx.Transform:SetPosition((offset+pos):Get())
                
                local x,y,z = fx.Transform:GetWorldPosition()
                
                
                local r = 1.5
                
                
                local dmg = math.random() * 50 * 1
                
                local ents = TheSim:FindEntities(x,y,z,r)
                for k, v in pairs(ents) do
                
                    
                    if v and v.components.health and not v.components.health:IsDead() and v.components.combat and
                        v ~= inst and
                        not (v.components.follower and v.components.follower.leader == inst ) and 
                        (TheNet:GetPVPEnabled() or not v:HasTag("player"))
                    then
                            v.components.combat:GetAttacked( inst, dmg )
                        
                        if v.components.freezable then
                            v.components.freezable:AddColdness(2)
                            v.components.freezable:SpawnShatterFX()
                        end
                        
                    end
                end
                
            end
        end)
    end
end


local function onattack(weapon, attacker, target)
    --target.components.burnable:Ignite(nil, attacker)
	--target.components.freezable:AddColdness(1)	
    if attacker then
	    if attacker.components.health then
		    attacker.components.health:DoDelta(TUNING.HX)
			 if attacker.components.sanity then
			     attacker.components.sanity:DoDelta(TUNING.JS)
			 	  if attacker and target.components.freezable then
		              if TUNING.FWBD then
		                 SpawnIceFx(attacker, target)
			          end
	                      if  target ~= nil and target.components.freezable ~= nil then
			                   if TUNING.BD then
			                      target.components.freezable:AddColdness(1)	
					           end
					               
						  end
				  end
			  end
		end
	end
	if TUNING.RS then
	   if target.components.burnable ~= nil and not target.components.burnable:IsBurning() then
           if target.components.freezable ~= nil and target.components.freezable:IsFrozen() then
               target.components.freezable:Unfreeze()
           elseif target.components.fueled == nil then
               target.components.burnable:Ignite(true)
           elseif target.components.fueled.fueltype == FUELTYPE.BURNABLE
               or target.components.fueled.secondaryfueltype == FUELTYPE.BURNABLE then
               local fuel = SpawnPrefab("cutgrass")
               if fuel ~= nil then
                   if fuel.components.fuel ~= nil and
                       fuel.components.fuel.fueltype == FUELTYPE.BURNABLE then
                       target.components.fueled:TakeFuelItem(fuel)
                   else
                       fuel:Remove()
                   end
               end
           end
           --V2C: don't ignite if it doens't accespt burnable fuel!
       end
	end
	if TUNING.JT then
	  jtxg(attacker, target)
    end
	if TUNING.XTX then
      gjxg(attacker, target)
	end
	if TUNING.AOE then
	if target.components.health then
	   target.components.health:DoDelta(TUNING.QLYYD_DAMAGE)
	end
	local x, y, z = target.Transform:GetWorldPosition()
	local range = 3
    local ents = TheSim:FindEntities(x, y, z, range)
    for i, v in ipairs(ents) do
		if v.components.health and not v:HasTag("player") then
		    v.components.health:DoDelta(-TUNING.QLYYD_DAMAGE)
			SpawnPrefab("explode_small_slurtlehole").Transform:SetPosition(v.Transform:GetWorldPosition())
		end
	end
    return true  
	end
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "z_greenspear_s", "z_greenspear_s")	
	owner.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")		
    owner.AnimState:Show("ARM_carry")	
    owner.AnimState:Hide("ARM_normal")	
    if TUNING.BB then
	   inst.components.container:Open(owner)
	end
    lighton(inst, owner)
end


local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")	
    owner.AnimState:Show("ARM_normal")	
	if TUNING.BB then
	   inst.components.container:Close(owner)
	end
    lightoff(inst, owner)
		if owner.components.health:IsDead() then
	if TUNING.FH then
inst:DoTaskInTime(3,  function()

	   owner:PushEvent("respawnfromghost")
		
 end)
end
end
end


local function fn()


    local inst = CreateEntity()	
	local sound = inst.entity:AddSoundEmitter()
	
    inst.entity:AddTransform()	
    inst.entity:AddAnimState()	
    inst.entity:AddLight()		
    inst.entity:AddNetwork()	

    MakeInventoryPhysics(inst)

    inst.Light:SetIntensity(TUNING.QLYYD_LIGHT_INTENSITY)	
    inst.Light:SetRadius(TUNING.QLYYD_LIGHT_RADIUS)		
    inst.Light:Enable(true)		
    inst.Light:SetFalloff(1)	
    inst.Light:SetColour(200/255, 200/255, 200/255)		

    inst.AnimState:SetBank("z_greenspear")	
    inst.AnimState:SetBuild("z_greenspear")	
    inst.AnimState:PlayAnimation("idle")	
    
	if TUNING.BB then
	   if TUNING.BX then
	       inst:AddTag("fridge")
	   end
	end
	
	if TUNING.BB then
	   inst.foleysound = "dontstarve/movement/foley/krampuspack"
	end
	
    inst:AddTag("sharp")	
    if not TheWorld.ismastersim then
	if TUNING.BB then
	inst.OnEntityReplicated = function(inst) inst.replica.container:WidgetSetup("krampus_sack") end
	end
        return inst
    end

    inst.entity:SetPristine()	
    
	inst:AddComponent("sjxt")

    inst:AddComponent("tool")		
	if TUNING.WK then
        inst.components.tool:SetAction(ACTIONS.MINE, 2)
	end
	if TUNING.KS then
        inst.components.tool:SetAction(ACTIONS.CHOP, TUNING.YJKS) 
	end
  
	
    if TUNING.QLYYD_CAN_USE_AS_SHOVEL then
        inst.components.tool:SetAction(ACTIONS.DIG)  
    end 
	
	
    if TUNING.QLYYD_CAN_USE_AS_HAMMER then
        inst.components.tool:SetAction(ACTIONS.HAMMER) 
    end
	-----------------
	if TUNING.BC then
	    inst.components.tool:SetAction(ACTIONS.NET)
	end
	------------
	if TUNING.SY then
	   inst:AddComponent("blinkstaff")
       inst.components.blinkstaff.onblinkfn = onblink
	end
	----------------------------
    inst:AddComponent("spellcaster")
	if TUNING.JN then
    inst.components.spellcaster:SetSpellFn(createicespell)
    inst.components.spellcaster.canuseonpoint = true
	--inst.components.spellcaster.quickcast = true
	end
--------------------------------------------------------------------------

    if TUNING.ZHDQW then
    inst.components.spellcaster:SetSpellFn(tlzhs)
    inst.components.spellcaster.canuseonpoint = true
	end
	-----------------------------------------------------------
   
	
	if TUNING.XB then
	   inst:AddComponent("trader")
       inst.components.trader:SetAcceptTest(function(inst, item) return item:HasTag("icefuel") end)
       inst.components.trader.onaccept = OnGetItemFromPlayer
       inst.components.trader.deleteitemonaccept = true
	end
	
	if TUNING.WDHD then
	   inst:AddComponent("trader")
       inst.components.trader:SetAcceptTest(function(inst, item) return item:HasTag("icefuel") end)
       inst.components.trader.onaccept = OnGetItemFromPlayer
       inst.components.trader.deleteitemonaccept = true
	end
	
	if TUNING.SMSX then
	   inst:AddComponent("trader")
       inst.components.trader:SetAcceptTest(function(inst, item) return item:HasTag("icefuel") end)
       inst.components.trader.onaccept = OnGetItemFromPlayer
       inst.components.trader.deleteitemonaccept = true
    end
	
	if TUNING.FYT then
	inst:AddComponent("machine")
	inst.components.machine.turnonfn = turnon
	inst.components.machine.turnofffn = turnoff
	end
	
	inst:AddComponent("tradable")
	
    inst:AddComponent("weapon")		
    inst.components.weapon:SetDamage(TUNING.QLYYD_DAMAGE)		
    inst.components.weapon:SetRange(TUNING.QLYYD_ATTAK_RANGE, TUNING.QLYYD_ATTAK_RANGE)	
	inst.components.weapon:SetOnAttack(onattack)
	
    inst:AddComponent("inspectable")
	
	 if TUNING.YD then
          inst:AddComponent("book")	   
          inst.components.book.onread = qlyyd
	 end
	 if TUNING.ZL then
          inst:AddComponent("book")	   
	      inst.components.book.onread = aria_paradise
	 end

    inst:AddComponent("inventoryitem")	
    inst.components.inventoryitem.atlasname = "images/inventoryimages/qlyyd.xml"	


    if TUNING.QLYYD_FINITE_USES > 0 then
        inst:AddComponent("finiteuses")		
        inst.components.finiteuses:SetMaxUses(TUNING.QLYYD_FINITE_USES)	
        inst.components.finiteuses:SetUses(TUNING.QLYYD_FINITE_USES)		
        inst.components.finiteuses:SetOnFinished(inst.Remove)			
        inst.components.finiteuses:SetConsumption(ACTIONS.CHOP, .1)		
        inst.components.finiteuses:SetConsumption(ACTIONS.MINE, .1)		
        inst.components.finiteuses:SetConsumption(ACTIONS.HAMMER, .1)	
        inst.components.finiteuses:SetConsumption(ACTIONS.DIG, .1)	
        inst.components.finiteuses:SetConsumption(ACTIONS.NET, 1)		
    end
	
	if TUNING.BB then
	  inst:AddComponent("container")
      inst.components.container:WidgetSetup("krampus_sack")
    end
	
    inst:AddComponent("equippable")		
    inst.components.equippable:SetOnEquip(onequip)	
    inst.components.equippable:SetOnUnequip(onunequip)	
    inst.components.equippable.walkspeedmult = TUNING.QLYYD_MOVE_SPEED_MUL	

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("common/inventory/qlyyd", fn, assets),
       Prefab("qlyyd_light", qlyyd_lightfn)