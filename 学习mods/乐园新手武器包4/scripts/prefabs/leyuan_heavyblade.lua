local assets =
{
    Asset("ANIM", "anim/sword_buster.zip"),
    Asset("ANIM", "anim/swap_sword_buster.zip"),
}

local prefabs =
{
    "weaponsparks",
    "sunderarmordebuff",
    "superjump_fx",
    "reticulearc",
    "reticulearcping",
}

local function ReticuleTargetFn()
    return Vector3(ThePlayer.entity:LocalToWorldSpace(6.5, 0, 0))
end

local function ReticuleMouseTargetFn(inst, mousepos)
    if mousepos ~= nil then
        local x, y, z = inst.Transform:GetWorldPosition()
        local dx = mousepos.x - x
        local dz = mousepos.z - z
        local l = dx * dx + dz * dz
        if l <= 0 then
            return inst.components.reticule.targetpos
        end
        l = 6.5 / math.sqrt(l)
        return Vector3(x + dx * l, 0, z + dz * l)
    end
end

local function ReticuleUpdatePositionFn(inst, pos, reticule, ease, smoothing, dt)
    local x, y, z = inst.Transform:GetWorldPosition()
    reticule.Transform:SetPosition(x, 0, z)
    local rot = -math.atan2(pos.z - z, pos.x - x) / DEGREES
    if ease and dt ~= nil then
        local rot0 = reticule.Transform:GetRotation()
        local drot = rot - rot0
        rot = Lerp((drot > 180 and rot0 + 360) or (drot < -180 and rot0 - 360) or rot0, rot, dt * smoothing)
    end
    reticule.Transform:SetRotation(rot)
end


local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_sword_buster", "swap_sword_buster")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function oncastfn(inst,doer,pos)
	inst.components.rechargeable:StartRecharge()
	doer:PushEvent("combat_parry",{duration = 5,weapon = inst,direction = inst:GetAngleToPoint(pos:Get())})
end 

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("sword_buster")
    inst.AnimState:SetBuild("sword_buster")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp")

    --parryweapon (from parryweapon component) added to pristine state for optimization
    inst:AddTag("parryweapon")

    --rechargeable (from rechargeable component) added to pristine state for optimization
    inst:AddTag("rechargeable")

    inst:AddComponent("aoetargeting")
    inst.components.aoetargeting:SetAlwaysValid(true)
    inst.components.aoetargeting.reticule.reticuleprefab = "reticulearc"
    inst.components.aoetargeting.reticule.pingprefab = "reticulearcping"
    inst.components.aoetargeting.reticule.targetfn = ReticuleTargetFn
    inst.components.aoetargeting.reticule.mousetargetfn = ReticuleMouseTargetFn
    inst.components.aoetargeting.reticule.updatepositionfn = ReticuleUpdatePositionFn
    inst.components.aoetargeting.reticule.validcolour = { 1, .75, 0, 1 }
    inst.components.aoetargeting.reticule.invalidcolour = { .5, 0, 0, 1 }
    inst.components.aoetargeting.reticule.ease = true
    inst.components.aoetargeting.reticule.mouseenabled = true
	
	inst.nameoverride = "lavaarena_heavyblade"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("parryweapon")
	
	inst:AddComponent("rechargeable")
	inst.components.rechargeable:SetRechargeTime(15)
	
	inst:AddComponent("aoespell")
	inst.components.aoespell:SetOnCastFn(oncastfn)
	
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(45)
    inst.components.weapon:SetRange(0.5)
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "lavaarena_heavyblade"


    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	--inst.components.equippable.walkspeedmult = 1.05
	
	inst:AddComponent("leyuanweapon")
	inst.components.leyuanweapon:SetStartDamage(68)
	inst.components.leyuanweapon:SetDeltaDamage(5)
	inst.components.leyuanweapon:SetMaxLevel(10)

	MakeHauntableLaunch(inst)
	
    return inst
end

return Prefab("leyuan_heavyblade", fn, assets, prefabs)
