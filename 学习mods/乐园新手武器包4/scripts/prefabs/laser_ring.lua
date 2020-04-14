local assets =
{
    Asset("ANIM", "anim/laser_ring_fx.zip"),
	Asset("ANIM", "anim/laser_ring_fx_blue.zip"),	
	Asset("ANIM", "anim/laser_explosion.zip"),
	Asset("ANIM", "anim/laser_explode_sm.zip"),  
}

local prefabs =
{

}

local function Scorch_OnUpdateFade(inst)
	local r,g,b,a = inst.AnimState:GetAddColour()
    inst.alpha = math.max(0, inst.alpha - (1/90) )
	
    inst.AnimState:SetMultColour(1, 1, 1,  inst.alpha)
	inst.AnimState:SetAddColour(math.max(0,r - (1/30)),math.max(0,g - (1/30)),math.max(0,b - (1/30)),math.max(0,a - (1/30)))
	
    if inst.alpha <= 0 and r <= 0 and g <= 0 and b <= 0 and a <= 0 then
        inst:Remove()
    end
end

local function scorchfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

    inst.AnimState:SetBuild("laser_ring_fx")
    inst.AnimState:SetBank("laser_ring_fx")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst:AddTag("NOCLICK")
    inst:AddTag("FX")
    inst:AddTag("laser")

    inst.Transform:SetScale(0.85,0.85,0.85)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.alpha = 1
	inst.persists = false
    inst:DoTaskInTime(0.7,function()
        inst:DoPeriodicTask(0, Scorch_OnUpdateFade)
    end)  

    inst.Transform:SetRotation(math.random() * 360)
	
	inst.MakeBlue = function(self)
		self.AnimState:SetBuild("laser_ring_fx_blue")
		self.AnimState:Hide("scorched_ground1")
		self.AnimState:PlayAnimation("idle")
		self.AnimState:SetAddColour(16/255,213/255,220/255,1)
	end 

    return inst
end

local function explosionfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

    inst.AnimState:SetBuild("laser_explosion")
    inst.AnimState:SetBank("laser_explosion")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("NOCLICK")
    inst:AddTag("FX")
    inst:AddTag("laser")

    inst.Transform:SetScale(0.85,0.85,0.85)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:ListenForEvent("animover",inst.Remove)

    return inst
end

local function explode_smfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

    inst.AnimState:SetBuild("laser_explode_sm")
    inst.AnimState:SetBank("laser_explode_sm")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("NOCLICK")
    inst:AddTag("FX")
    inst:AddTag("laser")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:ListenForEvent("animover",inst.Remove)

    return inst
end

return Prefab("laser_ring", scorchfn, assets, prefabs),
Prefab("laser_explosion", explosionfn, assets, prefabs),
Prefab("laser_explode_sm", explode_smfn, assets, prefabs)