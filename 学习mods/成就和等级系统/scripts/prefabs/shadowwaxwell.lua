local prefabs =
{
    "shadow_despawn",
    "statue_transition_2",
    "nightmarefuel",
}

local brain = require "brains/shadowwaxwellbrain"

local function findprefab(list,prefab)
    for index,value in pairs(list) do
        if value == prefab then
            return true
        end
    end
end

local function OnAttacked(inst, data)
    if data.attacker ~= nil then
        if data.attacker.components.petleash ~= nil and
            data.attacker.components.petleash:IsPet(inst) then
            if inst.components.lootdropper == nil then
                inst:AddComponent("lootdropper")
            end
            inst.components.lootdropper:SpawnLootPrefab("nightmarefuel", inst:GetPosition())
            data.attacker.components.petleash:DespawnPet(inst)
        elseif data.attacker.components.combat ~= nil then
            inst.components.combat:SuggestTarget(data.attacker)
        end
    end
end

local function retargetfn(inst)
    --Find things attacking leader
    local leader = inst.components.follower:GetLeader()
    return leader ~= nil
        and FindEntity(
            leader,
            TUNING.SHADOWWAXWELL_TARGET_DIST,
            function(guy)
                return guy ~= inst
                    and (guy.components.combat:TargetIs(leader) or
                        guy.components.combat:TargetIs(inst))
                    and inst.components.combat:CanTarget(guy)
            end,
            { "_combat" }, -- see entityreplica.lua
            { "playerghost", "INLIMBO" }
        )
        or nil
end

local function keeptargetfn(inst, target)
    --Is your leader nearby and your target not dead? Stay on it.
    --Match KEEP_WORKING_DIST in brain
    return inst.components.follower:IsNearLeader(14)
        and inst.components.combat:CanTarget(target)
        and target.components.minigame_participator == nil
end

local function spearfn(inst)
    inst.components.health:SetMaxHealth(TUNING.SHADOWWAXWELL_LIFE)
    inst.components.health:StartRegen(TUNING.SHADOWWAXWELL_HEALTH_REGEN, TUNING.SHADOWWAXWELL_HEALTH_REGEN_PERIOD)

    inst.components.combat:SetDefaultDamage(TUNING.SHADOWWAXWELL_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.SHADOWWAXWELL_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(2, retargetfn) --Look for leader's target.
    inst.components.combat:SetKeepTargetFunction(keeptargetfn) --Keep attacking while leader is near.

    return inst
end

local function nokeeptargetfn(inst)
    return false
end

local function noncombatantfn(inst)
    inst.components.combat:SetKeepTargetFunction(nokeeptargetfn)
end

local function nodebrisdmg(inst, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
    return afflicter ~= nil and afflicter:HasTag("quakedebris")
end

local function MakeMinion(prefab, tool, hat, master_postinit)
    local assets =
    {
        Asset("ANIM", "anim/waxwell_shadow_mod.zip"),
        Asset("SOUND", "sound/maxwell.fsb"),
        Asset("ANIM", "anim/"..tool..".zip"),
    }

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        MakeGhostPhysics(inst, 1, 0.5)

        inst.Transform:SetFourFaced(inst)

        inst.AnimState:SetBank("wilson")
        inst.AnimState:SetBuild("waxwell_shadow_mod")
        inst.AnimState:PlayAnimation("idle")
        inst.AnimState:SetMultColour(0, 0, 0, .5)

        if tool ~= nil then
            inst.AnimState:OverrideSymbol("swap_object", tool, tool)
            inst.AnimState:Hide("ARM_normal")
        else
            inst.AnimState:Hide("ARM_carry")
        end

        if hat ~= nil then
            inst.AnimState:OverrideSymbol("swap_hat", hat, "swap_hat")
            inst.AnimState:Hide("HAIR_NOHAT")
            inst.AnimState:Hide("HAIR")
        else
            inst.AnimState:Hide("HAT")
            inst.AnimState:Hide("HAIR_HAT")
        end

        inst:AddTag("scarytoprey")
        inst:AddTag("shadowminion")
        inst:AddTag("NOBLOCK")

        inst:SetPrefabNameOverride("shadowwaxwell")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("locomotor")
        inst.components.locomotor.runspeed = TUNING.SHADOWWAXWELL_SPEED
        inst.components.locomotor.pathcaps = { ignorecreep = true }
        inst.components.locomotor:SetSlowMultiplier(.6)

        inst:AddComponent("health")
        inst.components.health:SetMaxHealth(1)
        inst.components.health.nofadeout = true
        inst.components.health.redirect = nodebrisdmg

        inst:AddComponent("combat")
        inst.components.combat.hiteffectsymbol = "torso"
        inst.components.combat:SetRange(2)

        inst:AddComponent("follower")
        inst.components.follower:KeepLeaderOnAttacked()
        inst.components.follower.keepdeadleader = true
        inst.components.follower.keepleaderduringminigame = true

        inst:SetBrain(brain)
        inst:SetStateGraph("SGshadowwaxwell")

        inst:ListenForEvent("attacked", OnAttacked)

        local rocklist = {"marbletree", "marblepillar",
                          "rock_ice", "rock_ice_tall", "rock_ice_medium", "rock_ice_short",
                          "stalagmite", "stalagmite_full", "stalagmite_med", "stalagmite_low", 
                          "stalagmite_tall", "stalagmite_tall_full", "stalagmite_tall_med", "stalagmite_tall_low", 
        }

        inst:ListenForEvent("finishedwork", function(inst, data)
            if inst.prefab == "shadowminer" and data.target and (data.target:HasTag("boulder") or 
                                data.target:HasTag("statue") or 
                                findprefab(rocklist, data.target.prefab)) then
                local pos = Vector3(inst.Transform:GetWorldPosition())
                local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
                for k,v in pairs(ents) do
                    if v:HasTag("player") and v.prefab == "waxwell" and (v.components.allachivevent.minemaster ~= true or v.components.allachivevent.mineappren ~= true) then
                        v.components.allachivevent.mineamount = v.components.allachivevent.mineamount + 1
                        if v.components.allachivevent.mineamount >= allachiv_eventdata["mineappren"] and v.components.allachivevent.mineappren ~= true then
                            v.components.allachivevent.mineappren = true
                            v.components.allachivevent:seffc(v, "mineappren")
                            end
                        if v.components.allachivevent.mineamount >= allachiv_eventdata["minemaster"] and v.components.allachivevent.minemaster ~= true then
                            v.components.allachivevent.minemaster = true
                            v.components.allachivevent:seffc(v, "minemaster")
                        end
                    end
                end
            end
            if (inst.prefab == "shadowlumber" or inst.prefab == "shadowdigger") and data.target and data.target:HasTag("tree") then
                local pos = Vector3(inst.Transform:GetWorldPosition())
                local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
                for k,v in pairs(ents) do
                    if v:HasTag("player") and v.prefab == "waxwell" and (v.components.allachivevent.chopmaster ~= true or v.components.allachivevent.chopappren ~= true) then
                        v.components.allachivevent.chopamount = v.components.allachivevent.chopamount + 1
                        if v.components.allachivevent.chopamount >= allachiv_eventdata["chopappren"] and v.components.allachivevent.chopappren ~= true then
                            v.components.allachivevent.chopappren = true
                            v.components.allachivevent:seffc(v, "chopappren")
                            end
                        if v.components.allachivevent.chopamount >= allachiv_eventdata["chopmaster"] and v.components.allachivevent.chopmaster ~= true then
                            v.components.allachivevent.chopmaster = true
                            v.components.allachivevent:seffc(v, "chopmaster")
                        end
                    end
                end
            end
        end)
        if master_postinit ~= nil then
            master_postinit(inst)
        end

        return inst
    end

    return Prefab(prefab, fn, assets, prefabs)
end

--------------------------------------------------------------------------

local function NoHoles(pt)
    return not TheWorld.Map:IsPointNearHole(pt)
end

local function onbuilt(inst, builder)
    local theta = math.random() * 2 * PI
    local pt = builder:GetPosition()
    local radius = math.random(3, 6)
    local offset = FindWalkableOffset(pt, theta, radius, 12, true, true, NoHoles)
    if offset ~= nil then
        pt.x = pt.x + offset.x
        pt.z = pt.z + offset.z
    end
    builder.components.petleash:SpawnPetAt(pt.x, 0, pt.z, inst.pettype)
    inst:Remove()
end

local function MakeBuilder(prefab)
    --These shadows are summoned this way because petleash needs to
    --be the component that summons the pets, not the builder.
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()

        inst:AddTag("CLASSIFIED")

        --[[Non-networked entity]]
        inst.persists = false

        --Auto-remove if not spawned by builder
        inst:DoTaskInTime(0, inst.Remove)

        if not TheWorld.ismastersim then
            return inst
        end

        inst.pettype = prefab
        inst.OnBuiltFn = onbuilt

        return inst
    end

    return Prefab(prefab.."_builder", fn, nil, { prefab })
end

--------------------------------------------------------------------------

return MakeMinion("shadowlumber", "swap_axe", nil, noncombatantfn),
    MakeMinion("shadowminer", "swap_pickaxe", nil, noncombatantfn),
    MakeMinion("shadowdigger", "swap_shovel", nil, noncombatantfn),
    MakeMinion("shadowduelist", "swap_nightmaresword_shadow", nil, spearfn),
    MakeBuilder("shadowlumber"),
    MakeBuilder("shadowminer"),
    MakeBuilder("shadowdigger"),
    MakeBuilder("shadowduelist")
