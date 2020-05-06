local assets=
{
	Asset("ANIM", "anim/frosthammer.zip"),
	Asset("ANIM", "anim/swap_frosthammer.zip"),
	Asset("ATLAS", "images/inventoryimages/frosthammer.xml"),
	Asset("IMAGE", "images/inventoryimages/frosthammer.tex"),
}

local prefabs =
{
	--"collapse_small",
	--"collapse_big",
}


local freezechance = 0.3

local function onattack_FROST(inst, attacker, target)
    
    if target.components.freezable and math.random() < freezechance then
        target.components.freezable:AddColdness(5)
        target.components.freezable:SpawnShatterFX()
        attacker.components.sanity:DoDelta(-2)

    end
    if target.components.sleeper and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
    end
    if target.components.burnable and target.components.burnable:IsBurning() then
        target.components.burnable:Extinguish()
    end
    if target.components.combat then
        target.components.combat:SuggestTarget(attacker)
--[[
        if target.sg and not target.sg:HasStateTag("frozen") and target.sg.sg.states.hit then
            target.sg:GoToState("hit")
        end
]]--
    end
end


local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_frosthammer", "swap_umbrella")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 

      --     inst:AddComponent("heater")
     --   inst.components.heater.iscooler = true
      --  inst.components.heater.equippedheat = -1

end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 

 end
 
local function OnOpen(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/fireBurstLarge")

end 

local function OnClose(inst) 
    inst.SoundEmitter:PlaySound("dontstarve/common/fireBurstSmall")
end 

local slotpos_2 = {}

for y = 0, 1 do
	table.insert(slotpos_2, Vector3(-162, -y*75 + 114 ,0))
	table.insert(slotpos_2, Vector3(-162 +75, -y*75 + 114 ,0))
end


local function itemtest(inst, item, slot)
	return (item.components.edible and item.components.perishable) or 
	item.prefab == "spoiled_food" or 
	--item.prefab == "heatrock" or 
	item:HasTag("frozen")
end

local function fn(Sim)

	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)

 --   anim:SetBank("hammer")
    anim:SetBank("umbrella")

    anim:SetBuild("frosthammer")
    anim:PlayAnimation("idle")
     
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(56)
    inst.components.weapon:SetRange(1.5)
	
  inst.components.weapon:SetOnAttack(onattack_FROST)

    -----
    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.HAMMER)
    -------
    -------
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    	inst.components.inventoryitem.atlasname = "images/inventoryimages/frosthammer.xml"
     inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "frosthammer.tex" )
   ---------------------  
	inst:AddTag("fridge")
     
     ----------------------
    inst:AddComponent("container")
    inst.components.container.itemtestfn = itemtest
    inst.components.container:SetNumSlots(#slotpos_2)
    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
    
    inst.components.container.widgetslotpos = slotpos_2
    inst.components.container.widgetanimbank = "ui_backpack_2x4"
    inst.components.container.widgetanimbuild = "ui_chest_frosthammer"

    inst.components.container.widgetpos = Vector3(120,-180,0)
    inst.components.container.widgetpos = Vector3(-5,-50,0)

    inst.components.container.side_widget = true

    --inst.components.container.side_align_tip = 160
    --inst.components.container.acceptsstacks = false

------------------------

    inst:AddComponent("equippable")

    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )

    inst.components.equippable.walkspeedmult = 0.8
    inst.components.equippable.runspeedmult = 0.8

----

    return inst
end


return Prefab( "common/inventory/frosthammer", fn, assets, prefabs) 
