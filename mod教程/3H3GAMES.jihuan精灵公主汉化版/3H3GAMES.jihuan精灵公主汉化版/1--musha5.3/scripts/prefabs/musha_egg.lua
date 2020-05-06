local assets=
{
	Asset("ANIM", "anim/musha_egg.zip"),
	Asset("ATLAS", "images/inventoryimages/musha_egg.xml"),
	Asset("IMAGE", "images/inventoryimages/musha_egg.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_egg_cracked.tex"),
	Asset("ATLAS", "images/inventoryimages/musha_egg_cracked.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_egg_cooked.xml"),

}

local prefabs = 
{
	"musha_small",
	"musha_egg_cracked",
	--"musha_egg_cooked",
	--"spoiled_food",
}

local loot_hot = 
{
    "musha_egg",
}

local loot_cold = 
{
    "musha_egg",
}

local function Hatch(inst)
    --print("tallbirdegg - Hatch")
   
    local smallbird = SpawnPrefab("musha_small")
    smallbird.Transform:SetPosition(inst.Transform:GetWorldPosition())
    smallbird.sg:GoToState("hatch")

    inst:Remove()
end

local function CheckHatch(inst)
    --print("tallbirdegg - CheckHatch")
    if inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch(inst)
    end
end

local function PlayUncomfySound(inst)
    inst.SoundEmitter:KillSound("uncomfy")
    if inst.components.hatchable.toohot then
        inst.SoundEmitter:PlaySound("dontstarve/creatures/egg/egg_hot_steam_LP", "uncomfy")
    elseif inst.components.hatchable.toocold then
        inst.SoundEmitter:PlaySound("dontstarve/creatures/egg/egg_cold_shiver_LP", "uncomfy")
    end
end

local function OnNear(inst)
    --print("tallbirdegg - OnNear")
    inst.playernear = true
    CheckHatch(inst)
end

local function OnFar(inst)
    --print("tallbirdegg - OnFar")
    inst.playernear = false
end

local function OnDropped(inst)
    --print("tallbirdegg - OnDropped")
    inst.components.hatchable:StartUpdating()
    CheckHatch(inst)
    PlayUncomfySound(inst)
end

local function OnPutInInventory(inst)
    --print("tallbirdegg - OnPutInInventory")
    inst.components.hatchable:StopUpdating()
    inst.SoundEmitter:KillSound("uncomfy")
end

local function GetStatus(inst)
    if inst.components.hatchable then
        local state = inst.components.hatchable.state
        if state == "uncomfy" then
            if inst.components.hatchable.toohot then
                return "HOT"
            elseif inst.components.hatchable.toocold then
                return "COLD"
            end
        end
    end
end

local function DropLoot(inst)
    --print("tallbirdegg - DropLoot")
    
    inst:AddComponent("lootdropper")
    if inst.components.hatchable.toohot then

        inst.components.lootdropper:SetLoot(loot_hot)
    else
        inst.components.lootdropper:SetLoot(loot_cold)
    end
    inst.components.lootdropper:DropLoot()
end

local function OnHatchState(inst, state)
    --print("tallbirdegg - OnHatchState", state)
    
    inst.SoundEmitter:KillSound("uncomfy")

    if state == "crack" then
        local cracked = SpawnPrefab("musha_egg_cracked")
        cracked.Transform:SetPosition(inst.Transform:GetWorldPosition())
        cracked.AnimState:PlayAnimation("crack")
        cracked.AnimState:PushAnimation("idle_happy", true)
        cracked.SoundEmitter:PlaySound("dontstarve/creatures/egg/egg_hatch_crack")
        inst:Remove()
    elseif state == "uncomfy" then
        if inst.components.hatchable.toohot then
            inst.AnimState:PlayAnimation("idle_hot", true)
        elseif inst.components.hatchable.toocold then
            inst.AnimState:PlayAnimation("idle_cold", true)
        end
        PlayUncomfySound(inst)
    elseif state == "comfy" then
        inst.AnimState:PlayAnimation("idle_happy", true)
    elseif state == "hatch" then
        CheckHatch(inst)

    elseif state == "dead" then
        --print("   ACK! *splat*")
        if inst.components.hatchable.toohot then
            inst.AnimState:PlayAnimation("toohot")
        elseif inst.components.hatchable.toocold then
            inst.AnimState:PlayAnimation("toocold")
        end

--[[
    elseif state == "dead" then
        --print("   ACK! *splat*")
        if inst.components.hatchable.toohot then
            inst.SoundEmitter:PlaySound("dontstarve/creatures/egg/egg_hot_jump")
            inst:DoTaskInTime(20*FRAMES, function() inst.SoundEmitter:PlaySound("dontstarve/creatures/egg/egg_hot_explo") end)
            inst:DoTaskInTime(20*FRAMES, DropLoot)
            inst.AnimState:PlayAnimation("toohot")
        elseif inst.components.hatchable.toocold then
            inst:DoTaskInTime(15*FRAMES, function() inst.SoundEmitter:PlaySound("dontstarve/creatures/egg/egg_cold_freeze") end)
            inst:DoTaskInTime(30*FRAMES, DropLoot)
            inst.AnimState:PlayAnimation("toocold")
        end
]]--
        inst:ListenForEvent("animover", function(inst) inst:Remove() end)
    end
end

local function onequip_mushaegg(inst) 
         inst:AddComponent("insulator")
        inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.Light:Enable(true)
end

local function onunequip_mushaegg(inst) 
    inst.Light:Enable(false)
end

local function onequip_mushaegg_cracked(inst) 
         inst:AddComponent("insulator")
	inst.components.insulator.insulation = TUNING.INSULATION_LARGE	
    inst.Light:Enable(false)
end

local function onunequip_mushaegg_cracked(inst) 
    inst.Light:Enable(false)
end

local function commonfn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
     inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_egg.tex" )

    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBuild("musha_egg")
    inst.AnimState:SetBank("egg")
    inst.AnimState:PlayAnimation("egg")
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_egg.xml"

   inst:AddTag("light")

    local light = inst.entity:AddLight()
    light:SetFalloff(0.9)
    light:SetIntensity(0.9)
    light:SetRadius(0.7)
    light:SetColour(200/255, 50/255, 50/255)
    light:Enable(true)

    return inst
end

local function defaultfn()
	local inst = commonfn()

	inst.entity:AddSoundEmitter()
     inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_egg.tex" )

    inst.AnimState:PlayAnimation("egg")

    inst:AddComponent("hatchable")
    inst.components.hatchable:SetOnState(OnHatchState)
    inst.components.hatchable:SetCrackTime(TUNING.SMALLBIRD_HATCH_CRACK_TIME)
   -- inst.components.hatchable:SetHatchTime(TUNING.SMALLBIRD_HATCH_TIME)
    inst.components.hatchable:SetHatchTime(TUNING.PENGUIN_MATING_SEASON_BABYDELAY)
    inst.components.hatchable:SetHatchFailTime(TUNING.SMALLBIRD_HATCH_TIME * 99999)
    inst.components.hatchable:StartUpdating()

    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)

    inst.components.inspectable.getstatus = GetStatus

    inst.playernear = false

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable.walkspeedmult = 0.9
    inst.components.equippable.runspeedmult = 0.9

        inst.components.equippable:SetOnEquip( onequip_mushaegg )
        inst.components.equippable:SetOnUnequip( onunequip_mushaegg )

        inst.entity:AddLight()
        inst.Light:Enable(false)
        inst.Light:SetRadius(1)
        inst.Light:SetFalloff(0.6)
        inst.Light:SetIntensity(.75)
        inst.Light:SetColour(140/255, 90/255, 90/255)

   inst:AddTag("light")

    local light = inst.entity:AddLight()
    light:SetFalloff(0.9)
    light:SetIntensity(0.9)
    light:SetRadius(0.7)
    light:SetColour(200/255, 50/255, 50/255)
    light:Enable(true)

	return inst
end

local function crackedfn()
    local inst = defaultfn()

        inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_egg_cracked.xml"
     inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_egg_cracked.tex" )
    inst.components.inventoryitem.cangoincontainer = false

   inst:AddTag("light")

    local light = inst.entity:AddLight()
    light:SetFalloff(0.9)
    light:SetIntensity(0.9)
    light:SetRadius(0.7)
    light:SetColour(200/255, 50/255, 50/255)
    light:Enable(true)

    inst.components.hatchable.state = "comfy"
    inst.AnimState:PlayAnimation("idle_happy")

    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(4, 6)
    inst.components.playerprox:SetOnPlayerNear(OnNear)
    inst.components.playerprox:SetOnPlayerFar(OnFar)
    
------------------------
       inst.components.equippable:SetOnEquip( onequip_mushaegg_cracked )
       inst.components.equippable:SetOnUnequip( onunequip_mushaegg_cracked  )

    return inst
end

return Prefab( "common/inventory/musha_egg", defaultfn, assets, prefabs),
		Prefab( "common/inventory/musha_egg_cracked", crackedfn, assets)
