-- Example New Structure Mod
-- by WrathOf
-- v0.7
-------------------------------------------------------------------------------
--
-- Provides skeleton for new structure type prefab
--
-------------------------------------------------------------------------------
print("Loading LeifStatue Prefab...")


--Needed for MakePlacer function at end of file
require "prefabutil"


--Technically not nesessary but useful for reference but contents *must* be in
--this mod's prefabs.xml file
local assets = 
{
	--Asset("ANIM", "data/anim/leif_walking.zip"),
	--Asset("ANIM", "data/anim/leif_actions.zip"),
	--Asset("ANIM", "data/anim/leif_attacks.zip"),
	--Asset("ANIM", "data/anim/leif_idles.zip"),
	--Asset("ANIM", "data/anim/leif_build.zip"),
	--Asset("SOUND", "data/sound/leif.fsb"),

	--Substituting winterometer animation until new one can be made
	Asset("ANIM",  "data/anim/winter_meter.zip"),
	--Asset("ANIM",  "mods/ExampleNewStructure/anim/leifstatue.zip"),

	--Substituting renamed copy of resurrect statue texture file until new one can be made
	--Asset("IMAGE", "data/inventoryimages/winterometer.tex"),
	Asset("IMAGE", "mods/ExampleNewStructure/inventoryimages/leifstatue.tex"),
}


--Callback function for Workable component's OnFinish event
local function onhammered(inst, worker)

	if inst.components.lootdropper and inst:HasTag("leifstatue") then
		inst.components.lootdropper:DropLoot()
	end

	SpawnPrefab("collapse_big").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
	
end


--Callback function for Workable component's OnWork event
local function onhit(inst, worker)
--	if inst:HasTag("leifstatue") then
--		inst.AnimState:PlayAnimation("hit")
--		inst.AnimState:PushAnimation("idle")
--	end
end


--Main function to create a new prefab instance
local function fn(Sim)

	local inst = CreateEntity()
	inst.entity:AddTransform()	-- must be setup first

    inst:AddTag("leifstatue")
    inst:AddTag("structure")

	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()

	--Future functionality to test
	--inst.Transform:SetFourFaced()
	--inst.entity:AddDynamicShadow()	
	--inst.entity:DynamicShadow:SetSize( 4, 1.5 )
	--inst.entity:AddMiniMapEntity()
	--inst.MiniMapEntity:SetIcon( "leifstatue.png" )

	MakeObstaclePhysics(inst, 0.4)

	--Substitute winterometer's anim graphics until new one can be made
    --inst.AnimState:SetBank("leifstatue")
    --inst.AnimState:SetBuild("leifstatue")
	--inst.AnimState:PlayAnimation("idle")
    --inst.AnimState:PlayAnimation("idle_loop") --vs idle since copied from leif prefab
	--inst.AnimState:PlayAnimation("tree_idle", true)
	inst.AnimState:SetBank("winter_meter")
	inst.AnimState:SetBuild("winter_meter")
	inst.AnimState:SetPercent("meter", 0)

	--Allows character to inspect so speech message pops up
	inst:AddComponent("inspectable")
	
	--Allow player to use hammer on structure to remove and recieve some of the recipe items back
	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)		
	
	MakeSnowCovered(inst, 0.01)

	return inst

end

return Prefab( "common/objects/leifstatue", fn, assets),
	   --MakePlacer("common/leifstatue_placer", "leifstatue", "leifstatue", "idle" )
	   MakePlacer("common/leifstatue_placer", "winter_meter", "winter_meter", "idle" )

