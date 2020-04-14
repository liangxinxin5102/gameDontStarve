require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/pedestal_crate.zip"),
}

local prefabs =
{
    "collapse_small",
}

local function onopen(inst)
    inst.AnimState:PlayAnimation("open")
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_open")
end

local function onclose(inst)
    inst.AnimState:PlayAnimation("close")
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_close")
end

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
	if inst.components.hj_base ~= nil then
		inst.components.hj_base:UnBall()
	end
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function onhit(inst, worker)
	if inst.components.hj_base ~= nil then
		inst.components.hj_base:UnBall()
	end
end


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	inst.entity:AddLight()

    inst:AddTag("structure")
	inst:AddTag("hj_ball")

    inst.AnimState:SetBank("pedestal")
    inst.AnimState:SetBuild("pedestal_crate")
    inst.AnimState:PlayAnimation("idle_cakestand_dome")
	inst.Transform:SetScale(1.2, 1.2, 1.2)
	inst.AnimState:OverrideSymbol("sign_overlay", "hjballbase", "sign_overlay")
	
    inst.Light:SetIntensity(0.6)
    inst.Light:SetRadius(5)
    inst.Light:SetFalloff(.9)
	inst.Light:SetColour(180 / 255, 195 / 255, 150 / 255)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")
	inst:AddComponent("hj_base")
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(5)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit) 

    return inst
end

return Prefab("hj_pokeball_base", fn, assets, prefabs),
    MakePlacer("hj_pokeball_base_placer", "pedestal", "pedestal_crate", "idle_cakestand_dome")
