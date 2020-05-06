local assets=
{
	Asset("ANIM", "anim/armor_mushaa.zip"),
  Asset("ATLAS", "images/inventoryimages/armor_mushaa.xml"),
  Asset("IMAGE", "images/inventoryimages/armor_mushaa.tex")

}
--------------
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
	if inst.components.container then 
	inst.components.container:DropEverything() 
    end
	inst:Remove()
            end
----------------

local function OnBlocked(owner) 
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour") 

end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "armor_mushaa", "swap_body")
   -- owner.components.inventory:SetOverflow(inst)
    inst.components.container:Open(owner)

    inst:ListenForEvent("blocked", OnBlocked, owner)
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    owner.AnimState:ClearOverrideSymbol("backpack")
    --owner.components.inventory:SetOverflow(nil)
    inst.components.container:Close(owner)

    inst:RemoveEventCallback("blocked", OnBlocked, owner)
end
----------------

local function OnOpen(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/lighter_on")
end 

local function OnClose(inst) 
    inst.SoundEmitter:PlaySound("dontstarve/wilson/lighter_on")
end 
local slotpos = {}

for y = 0, 3 do
	table.insert(slotpos, Vector3(-162, -y*75 + 114 ,0))
	table.insert(slotpos, Vector3(-162 +75, -y*75 + 114 ,0))
end
--[[
local slotpos = {}
for y = 0, 3 do
	table.insert(slotpos, Vector3(-162 +75, -y*75 + 114 ,0))
end
]]--

local function onfinished(inst)
    inst:Remove()
end

--------------

local function fn(Sim)
	local inst = CreateEntity()
    	inst.entity:AddSoundEmitter()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("armor_wood")
    inst.AnimState:SetBuild("armor_mushaa")
    inst.AnimState:PlayAnimation("anim")
    
    inst:AddTag("wood")
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/marblearmour"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/armor_mushaa.xml"
   
    inst:AddComponent("armor")
    inst.components.armor:InitCondition(math.huge, 0.7 )

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )

    inst:AddComponent("container")
    inst.components.container:SetNumSlots(#slotpos)
    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
    
    inst.components.container.widgetslotpos = slotpos
    inst.components.container.widgetanimbank = "ui_backpack_2x4"
    inst.components.container.widgetanimbuild = "ui_backpack_2x4"
    inst.components.container.widgetpos = Vector3(-145,-180,0)
    inst.components.container.widgetpos = Vector3(-140,-50,0)
    inst.components.container.side_widget = true

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

return Prefab( "common/inventory/armor_mushaa", fn, assets) 
