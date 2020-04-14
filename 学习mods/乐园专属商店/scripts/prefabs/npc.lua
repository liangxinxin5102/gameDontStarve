
local assets =
{

	---Asset("ANIM", "anim/yun_platform_forge.zip"),




}

local prefabs =
{
    "npc",
}


local function fn()
     local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	
    MakeObstaclePhysics(inst, .2)

    ---inst.Transform:SetScale(2, 2, 2)    ---大小
    inst.AnimState:SetBank("wilson")
    inst.AnimState:SetBuild("wilson")
	inst.AnimState:PlayAnimation("idle")
   
	                    -----------名字组件
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("named")   
	
	inst:AddComponent("inspectable")	
	inst:AddComponent("talker")	
	inst.components.talker.fontsize = 35
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(1, .5, .5, 1)
    inst.components.talker.offset = Vector3(200,-250,0)
    inst.components.talker.symbol = "swap_object"	
	
	
	
    return inst
end

return Prefab("npc", fn, assets, prefabs)	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	