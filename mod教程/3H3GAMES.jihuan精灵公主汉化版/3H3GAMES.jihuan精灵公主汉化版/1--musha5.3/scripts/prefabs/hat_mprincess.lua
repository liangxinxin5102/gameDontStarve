local assets=
{
	Asset("ANIM", "anim/hat_mprincess.zip"),
  Asset("ATLAS", "images/inventoryimages/hat_mprincess.xml"),
  Asset("IMAGE", "images/inventoryimages/hat_mprincess.tex")
}
--------------
local function healowner(inst, owner)
    if (owner.components.health and owner.components.health:IsHurt())
    and (owner.components.hunger and owner.components.hunger.current > 120 )then
        owner.components.health:DoDelta(1,false)

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
                dude.components.health:Respawn(100)
                dude.components.health:SetInvincible(true)
            end
          if dude.components.sanity then
			    dude.components.sanity:SetPercent(.5)
            end
          if dude.components.hunger then
                dude.components.hunger:SetPercent(.5)
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

--------------bushhat
    local function stopusingbush(inst, data)
        local hat = inst.components.inventory and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if hat and not (data.statename == "hide_idle" or data.statename == "hide") then
            hat.components.useableitem:StopUsingItem()
        end
    end

    local function onequipbush(inst, owner)

     owner.AnimState:OverrideSymbol("swap_hat", "hat_mprincess", "swap_hat")
        owner.AnimState:Show("HAT")
       -- owner.AnimState:Show("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")

            owner:AddTag("houndmound")

    inst.task = inst:DoPeriodicTask(12, function() healowner(inst, owner) end)

        inst:ListenForEvent("newstate", stopusingbush, owner) 
    end

    local function onunequipbush(inst, owner)
         owner.AnimState:Hide("HAT")
        owner.AnimState:Hide("HAT_HAIR")
        owner.AnimState:Show("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")

            owner:RemoveTag("houndmound")

        if owner:HasTag("player") then
            owner.AnimState:Show("HEAD")
            owner.AnimState:Hide("HEAD_HAIR")
        end

    if inst.task then inst.task:Cancel() inst.task = nil end
        inst:RemoveEventCallback("newstate", stopusingbush, owner)
    end
 
 local function onusebush(inst)
    inst:AddComponent("armor")
inst.components.armor:InitCondition(TUNING.ARMOR_FOOTBALLHAT * 1, TUNING.ARMOR_FOOTBALLHAT_ABSORPTION * 4)
        local owner = inst.components.inventoryitem.owner
        if owner then
            owner.sg:GoToState("hide")
owner.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
        end
    end

 local function offusebush(inst)
    inst:AddComponent("armor")
   -- inst.components.armor:InitCondition(TUNING.ARMORGRASS, TUNING.ARMORGRASS_ABSORPTION)
         inst.components.armor:SetAbsorption(0)
	inst.components.armor:SetCondition(100)


    end

---------------bushhat end
---------------hat fn sim
	
local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

    MakeInventoryPhysics(inst)
    
    inst:AddTag("hat")

    anim:SetBank("bushhat")
    anim:SetBuild("hat_mprincess")

    anim:PlayAnimation("anim")    
        
    inst:AddComponent("inspectable")
    
   -- inst:AddTag("irreplaceable")
	
    --inst:AddComponent("insulator")
	--inst.components.insulator.insulation = TUNING.INSULATION_SMALL	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hat_mprincess.xml"

inst:AddTag("hound")

    inst:AddComponent("armor")
         inst.components.armor:SetAbsorption(0)
	inst.components.armor:SetCondition(100)

        inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD

     --   inst:AddTag("hide")
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

    return inst
end
---------------------------------
return Prefab( "common/inventory/hat_mprincess", fn, assets ) 
