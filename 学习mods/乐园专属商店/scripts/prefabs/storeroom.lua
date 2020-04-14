require "prefabutil"

local assets=
{
	Asset("ANIM", "anim/storeroom.zip"),
	Asset("ANIM", "anim/ui_chest_4x5.zip"),
	Asset("ANIM", "anim/ui_chest_5x8.zip"),
	Asset("ANIM", "anim/ui_chest_5x12.zip"),
	Asset("ANIM", "anim/ui_chest_5x16.zip"),
}

local function onopen(inst)
	inst.AnimState:PlayAnimation("open")
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end 

local function onclose(inst)
	inst.AnimState:PlayAnimation("closed")
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
end 

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	if inst.components.container ~= nil then
		inst.components.container:DropEverything()
	end
	local fx = SpawnPrefab("collapse_big")
	fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
	fx:SetMaterial("wood")
	inst:Remove()
end

local function onhit(inst, worker)
	inst.AnimState:PlayAnimation("hit")
	inst.AnimState:PushAnimation("closed")
	if inst.components.container ~= nil then
		inst.components.container:Close()
	end
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("closed")
end

local function fn(Sim)
	local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
		inst.entity:AddMiniMapEntity()
		inst.entity:AddNetwork()

		inst.MiniMapEntity:SetIcon("storeroom.tex")

		MakeObstaclePhysics(inst, 1.25)

		inst:AddTag("structure")
		inst:AddTag("chest")
		inst:AddTag("icestoreroom")
		inst.AnimState:SetBank("storeroom")
		inst.AnimState:SetBuild("storeroom")
		inst.AnimState:PlayAnimation("closed", true)

		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end

		inst:AddComponent("inspectable")
		inst:AddComponent("container")
		inst.components.container:WidgetSetup("storeroom")
		inst.components.container.onopenfn = onopen
		inst.components.container.onclosefn = onclose

		inst:AddComponent("lootdropper")


	return inst
end

return Prefab( "common/storeroom", fn, assets),
			 MakePlacer("common/storeroom_placer", "storeroom", "storeroom", "closed") 
