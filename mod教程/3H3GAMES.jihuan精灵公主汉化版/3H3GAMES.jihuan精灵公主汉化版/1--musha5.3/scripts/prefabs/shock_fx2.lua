local assets =
{
	Asset("ANIM", "anim/shock_fx2.zip"),
}

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.Transform:SetFourFaced()
    anim:SetBank("shock_fx")
    anim:SetBuild("shock_fx2")
    anim:PlayAnimation("shock")
    inst:AddTag("fx")
    inst:ListenForEvent( "animover", function(inst) inst:Remove() end )
    return inst
end

return Prefab("shock_fx2", fn, assets) 
