local function fn_fx()
    local inst = CreateEntity()

    inst.entity:AddTransform()
	local s=1
	inst.Transform:SetScale(s,s,s)
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)
    inst.AnimState:SetBank("zg_fx_mihawkhsqj")
    inst.AnimState:SetBuild("zg_fx_mihawkhsqj")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)
    inst.AnimState:PlayAnimation("idle")
	inst.AnimState:SetAddColour(math.random(1,255)/255,math.random(1,255)/255,math.random(1,255)/255,0)

    inst:AddTag("FX")
	inst:AddTag("NOCLICK")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
    return inst
end
return Prefab("zg_fx_mihawkhsqj", fn_fx)   --c_give"zg_fx_mihawkhsqj"






