local assets=
{
	Asset("ANIM", "anim/musha_flute.zip"),
	Asset("ATLAS", "images/inventoryimages/musha_flute.xml"),
	Asset("IMAGE", "images/inventoryimages/musha_flute.tex"),
}

local function onfinished(inst)
    inst:Remove()
end

local function Hearmusha(inst, musician, instrument, data)
local player = GetPlayer()
local fx = SpawnPrefab("sparklefx")
local fxx = SpawnPrefab("sparklefx")
	if player.components.health then
        player.components.health:DoDelta(.3)
        player.components.sanity:DoDelta(.3)
       -- player.components.hunger:DoDelta(-.5)

        fxx.entity:SetParent(player.entity)
	fxx.Transform:SetScale(1.3, 1.3, 1.3)
        fxx.Transform:SetPosition(0, -0.2, 0)
	end
	if inst.components.health and inst:HasTag("companion") then
        inst.components.health:DoDelta(50)
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1.3, 1.3, 1.3)
        fx.Transform:SetPosition(0, -0.2, 0)
	end
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()

	inst:AddTag("flute")
    	--inst:AddTag("horn")
	inst:AddTag("musha_flute")

    inst.AnimState:SetBank("pan_flute")
    inst.AnimState:SetBuild("musha_flute")

    inst.AnimState:PlayAnimation("idle")
    MakeInventoryPhysics(inst)
    
    inst:AddComponent("inspectable")
    inst:AddComponent("instrument")
    inst.components.instrument.range = TUNING.PANFLUTE_SLEEPRANGE
    inst.components.instrument:SetOnHeardFn(Hearmusha)
    
    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.PLAY)

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(30)
    inst.components.finiteuses:SetUses(30)
    inst.components.finiteuses:SetOnFinished( onfinished)
    inst.components.finiteuses:SetConsumption(ACTIONS.PLAY, 1)

    inst:AddComponent("inventoryitem")
    	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_flute.xml"
     inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_flute.tex" )


    return inst
end

return Prefab( "common/inventory/musha_flute", fn, assets) 
