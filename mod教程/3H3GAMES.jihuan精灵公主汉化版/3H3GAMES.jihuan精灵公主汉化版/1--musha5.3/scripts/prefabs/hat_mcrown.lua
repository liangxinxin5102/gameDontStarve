local assets=
{
	Asset("ANIM", "anim/hat_mcrown.zip"),
  Asset("ATLAS", "images/inventoryimages/hat_mcrown.xml"),
  Asset("IMAGE", "images/inventoryimages/hat_mcrown.tex")
}
------------

    local function summon_proc(inst, owner)
        inst:AddTag("forcefield")
        owner.components.health:DoDelta(18)
       -- inst.components.armor:SetAbsorption(TUNING.FULL_ABSORPTION)
        local fx = SpawnPrefab("forcefieldfx")
		local summon = SpawnPrefab("ghosthound")
        fx.entity:SetParent(owner.entity)
	fx.Transform:SetScale(0.8, 0.8, 0.8)
        fx.Transform:SetPosition(0, 0.2, 0)
		summon.Transform:SetPosition(inst.Transform:GetWorldPosition())	
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
        fx:ListenForEvent("blocked", fx_hitanim, owner)


        inst.active = true

        owner:DoTaskInTime(--[[Duration]] 1, function()
            fx:RemoveEventCallback("blocked", fx_hitanim, owner)
            fx.kill_fx(fx)
            if inst:IsValid() then
                inst:RemoveTag("forcefield")
                inst.components.armor.ontakedamage = nil
            --    inst.components.armor:SetAbsorption(TUNING.ARMOR_RUINSHAT_ABSORPTION)
                owner:DoTaskInTime(--[[Cooldown]] 3, function() inst.active = false end)
            end
        end)
    end

    local function tryproc(inst, owner)
        if not inst.active and math.random() < --[[ Chance to proc ]] 0.2 then
           summon_proc(inst, owner)
        end
    end
-----------
local function close(inst)
inst.components.resurrector.active = true
end

local function far(inst)
inst.components.resurrector.active = false
end

local function makeused(inst)
	inst.AnimState:PlayAnimation("debris")
end

local function doresurrect(inst, dude)
    dude.entity:AddLight()
	dude.Light:SetRadius(3)
    dude.Light:SetFalloff(10)
    dude.Light:SetIntensity(.5)
    dude.Light:SetColour(15/255,165/255,165/255)
	dude.Light:Enable(true)

	inst:AddTag("busy")	
	inst.persists = false
    if inst.Physics then
		RemovePhysicsColliders(inst)
    end
    --dude:Hide()
    if dude.HUD then
        dude.HUD:Hide()
    end
    if dude.components.playercontroller then
        dude.components.playercontroller:Enable(false)
    end

    inst:RemoveComponent("inspectable")
    dude:ClearBufferedAction()
------
    scheduler:ExecuteInTime(2, function()
        dude:Show()
       -- inst:Hide()

inst.AnimState:PlayAnimation("debris")
-------
        dude.sg:GoToState("rebirth")
        dude:DoTaskInTime(4, function() 

            if dude.HUD then
                dude.HUD:Show()
            end
            if dude.components.health then
				dude.components.health:RecalculatePenalty()
                dude.components.health:Respawn(300)
                dude.components.health:SetInvincible(true)
            end
          if dude.components.sanity then
			    dude.components.sanity:SetPercent(1)
            end
          if dude.components.hunger then
                dude.components.hunger:SetPercent(1)
            end
        if dude.components.playercontroller then
                dude.components.playercontroller:Enable(true)
            end
            inst:RemoveTag("busy")
            dude.components.health:SetInvincible(false)
	dude.Light:Enable(false)

 end)
	inst:Show()

 end)
	inst:Remove()
            end
----------------

------------------    
    local function stopusingbush(inst, data)
        local hat = inst.components.inventory and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if hat and not (data.statename == "hide_idle" or data.statename == "hide") then
            hat.components.useableitem:StopUsingItem()
        end
    end

    local function onequipbush(inst, owner)

     owner.AnimState:OverrideSymbol("swap_hat", "hat_mcrown", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Show("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Hide("HAIR")
            owner:AddTag("houndmound")

        inst.procfn = function() tryproc(inst, owner) end
        owner:ListenForEvent("attacked", inst.procfn)

        inst:ListenForEvent("newstate", stopusingbush, owner) 
    end

    local function onunequipbush(inst, owner)
         owner.AnimState:Hide("HAT")
        owner.AnimState:Hide("HAT_HAIR")
        owner.AnimState:Show("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")
  --  inst.components.childspawner:StopSpawning()

            owner:RemoveTag("houndmound")

        owner:RemoveEventCallback("attacked", inst.procfn)

        inst:RemoveEventCallback("newstate", stopusingbush, owner)
    end
 
 local function onusebush(inst)
  --  inst.components.childspawner.childname = "ghosthound"
   -- inst.components.childspawner:StartSpawning()
  --  inst.components.childspawner.maxchildren = 1
    inst:AddComponent("armor")
inst.components.armor:InitCondition(TUNING.ARMOR_FOOTBALLHAT * 1, TUNING.ARMOR_FOOTBALLHAT_ABSORPTION * 4)
        local owner = inst.components.inventoryitem.owner
        if owner then
            owner.sg:GoToState("hide")
owner.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
        end
    end

 local function offusebush(inst)
 --   inst.components.childspawner:StopSpawning()
    inst:AddComponent("armor")
         inst.components.armor:SetAbsorption(0)
	inst.components.armor:SetCondition(100)

    end

---------------hat fn sim
	
local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

    MakeInventoryPhysics(inst)
    
    inst:AddTag("hat")

    anim:SetBank("bushhat")
    anim:SetBuild("hat_mcrown")

    anim:PlayAnimation("anim")    
        
    inst:AddComponent("inspectable")
    	
 --   inst:AddComponent("insulator")
--inst.components.insulator.insulation = TUNING.INSULATION_SMALL	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hat_mcrown.xml"

    inst:AddComponent("armor")
       -- inst.components.armor:InitCondition(TUNING.ARMOR_RUINSHAT, TUNING.ARMOR_RUINSHAT_ABSORPTION)
	inst.components.armor:SetAbsorption(0)
	inst.components.armor:SetCondition(100)

        --inst:AddComponent("childspawner")

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD

    --    inst:AddTag("hide")
        inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/bushhat"
            inst:AddComponent("useableitem")
       inst.components.useableitem:SetOnUseFn(onusebush)
       inst.components.useableitem:SetOnStopUseFn(offusebush)
       inst.components.equippable:SetOnEquip( onequipbush )
       inst.components.equippable:SetOnUnequip( onunequipbush )
 -------------------------   
---resurrect
        inst:AddComponent("playerprox")
    inst:AddComponent("resurrector")
   -- inst.components.resurrector.active = true
	inst.components.resurrector.doresurrect = doresurrect
	inst.components.resurrector.makeusedfn = makeused
    inst.components.playerprox:SetDist(10, 11)
    inst.components.playerprox:SetOnPlayerNear(close)
    inst.components.playerprox:SetOnPlayerFar(far)

----------------------
        inst:AddTag("metal")
----------------------
    return inst
end
---------------------------------
return Prefab( "common/inventory/hat_mcrown", fn, assets ) 
