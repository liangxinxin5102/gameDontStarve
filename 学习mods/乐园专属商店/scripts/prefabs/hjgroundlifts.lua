--来自熔炉mod
local assets =
{
    Asset("ANIM", "anim/lavaarena_boarrior_fx.zip"),
}

local function SpikeLaunch(inst, launcher, basespeed, startheight, startradius)
    local x0, y0, z0 = launcher.Transform:GetWorldPosition()
    local x1, y1, z1 = inst.Transform:GetWorldPosition()
    local dx, dz = x1 - x0, z1 - z0
    local dsq = dx * dx + dz * dz
    local angle
    if dsq > 0 then
        local dist = math.sqrt(dsq)
        angle = math.atan2(dz / dist, dx / dist) + (math.random() * 20 - 10) * DEGREES
    else
        angle = 2 * PI * math.random()
    end
    local sina, cosa = math.sin(angle), math.cos(angle)
    local speed = basespeed + math.random()
    inst.Physics:Teleport(x0 + startradius * cosa, startheight, z0 + startradius * sina)
    inst.Physics:SetVel(cosa * speed, speed * 5 + math.random() * 2, sina * speed)
end

local function DoToss(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
    local totoss = TheSim:FindEntities(x, 0, z, 0.7, { "_inventoryitem" }, { "locomotor", "INLIMBO" })
    for i, v in ipairs(totoss) do
        if v.components.mine ~= nil then
            v.components.mine:Deactivate()
        end
        if not v.components.inventoryitem.nobounce and v.Physics ~= nil and v.Physics:IsActive() then
            SpikeLaunch(v, inst, .8 + .7, .7 * .4, .7 + v:GetPhysicsRadius(0))
        end
    end
end

local function OnRemove(inst)
	inst:Remove()
end

local function MakeGroundLift(name, radius, hasanim, hassound, excludesymbols)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        if hassound then
            inst.entity:AddSoundEmitter()
        end
        inst.entity:AddNetwork()

        if hasanim then
            inst.entity:AddAnimState()
            inst.AnimState:SetBank("lavaarena_boarrior_fx")
            inst.AnimState:SetBuild("lavaarena_boarrior_fx")
			inst.AnimState:PlayAnimation("ground_hit_2")
            if excludesymbols ~= nil then
                for i, v in ipairs(excludesymbols) do
                    inst.AnimState:Hide(v)
                end
            end
        else
            inst:AddTag("CLASSIFIED")
        end
        inst:AddTag("notarget")
        inst:AddTag("hostile")
        inst:AddTag("groundspike")

        inst:AddTag("object")
        inst:AddTag("stone")
        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end
	
		if radius then
			inst:DoTaskInTime(0, DoToss)
		end
		inst:ListenForEvent("animover", OnRemove)
        return inst
    end

    return Prefab(name, fn, assets)
end

return MakeGroundLift("hj_groundlift", .7, true, false, { "embers" }),
    MakeGroundLift("hj_groundliftembers", .7, true, false),
    MakeGroundLift("hj_groundliftrocks", .7, true, false, { "embers", "splash" }),
    MakeGroundLift("hj_groundliftwarning", .7, false, false),
    MakeGroundLift("hj_groundliftempty", 1, false, true)
