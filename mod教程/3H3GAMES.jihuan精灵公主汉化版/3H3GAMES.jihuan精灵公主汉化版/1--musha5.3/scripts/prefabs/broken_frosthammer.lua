local assets=
{
	Asset("ANIM", "anim/broken_frosthammer.zip"),
	Asset("ATLAS", "images/inventoryimages/broken_frosthammer.xml"),
	Asset("IMAGE", "images/inventoryimages/broken_frosthammer.tex"),

}
----------------

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
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
  	inst.entity:AddSoundEmitter()
  
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("log")
    inst.AnimState:SetBuild("broken_frosthammer")
    inst.AnimState:PlayAnimation("idle")


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
    inst.components.container.acceptsstacks = false


 -------------------------   

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/broken_frosthammer.xml"
           inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "broken_frosthammer.tex" )
-------------------
	MakeSnowCovered(inst, .01)	
-------------------
    return inst
end

return Prefab( "common/inventory/broken_frosthammer", fn, assets) 

