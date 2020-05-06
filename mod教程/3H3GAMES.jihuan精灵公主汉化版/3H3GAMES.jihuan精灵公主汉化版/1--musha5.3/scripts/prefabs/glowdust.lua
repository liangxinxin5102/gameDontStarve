local assets=
{
	Asset("ANIM", "anim/glowdust.zip"),
  Asset("ATLAS", "images/inventoryimages/glowdust.xml"),
  Asset("IMAGE", "images/inventoryimages/glowdust.tex"),

}
local function item_oneaten(inst, eater)
local fx = SpawnPrefab("sparklefx")
local dog = SpawnPrefab("ghosthound")
fx.entity:SetParent(inst.entity)
fx.Transform:SetScale(1, 2, 1)
fx.Transform:SetPosition(0.3, 0, 0)
dog.Transform:SetPosition(inst.Transform:GetWorldPosition())	
inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")

    if eater.glowdust then
        eater.glowdust.components.spell.lifetime = 0
        eater.glowdust.components.spell:ResumeSpell()
    else
        local light = SpawnPrefab("wormlight_light")
        light.components.spell:SetTarget(eater)
        if not light.components.spell.target then
            light:Remove()
        end
        light.components.spell:StartSpell()
    end
end

local function BlowAway(inst)
    inst.blowawaytask = nil
    inst.persists = false
    inst:RemoveComponent("inventoryitem")
    inst:RemoveComponent("inspectable")
	inst.SoundEmitter:PlaySound("dontstarve/common/dust_blowaway")
	inst.AnimState:PlayAnimation("disappear")
	inst:ListenForEvent("animover", function() inst:Remove() end)
end

local function StopBlowAway(inst)
	if inst.blowawaytask then
		inst.blowawaytask:Cancel()
		inst.blowawaytask = nil
	end
end
		
local function PrepareBlowAway(inst)
	StopBlowAway(inst)
	inst.blowawaytask = inst:DoTaskInTime(25+math.random()*10, BlowAway)
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("ashes")
    inst.AnimState:SetBuild("glowdust")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")
        inst:AddComponent("edible")
        inst.components.edible.foodtype = "VEGGIE"
    inst.components.edible.sanityvalue = 15
    inst.components.edible.healthvalue = 15
    inst.components.edible.hungervalue = TUNING.CALORIES_MED
    inst.components.edible:SetOnEatenFn(item_oneaten)

    local light = inst.entity:AddLight()
    light:SetFalloff(0.7)
    light:SetIntensity(.5)
    light:SetRadius(0.5)
    light:SetColour(69/255, 131/255, 145/255)
    light:Enable(true)
   -- inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )

    ---------------------       
    
    inst:AddComponent("inspectable")
	--inst.components.inspectable.getstatus = GetStatus
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetOnPutInInventoryFn(StopBlowAway)
inst.components.inventoryitem.atlasname = "images/inventoryimages/glowdust.xml"

	inst:ListenForEvent("ondropped",  PrepareBlowAway)
	PrepareBlowAway(inst)

    return inst
end
-----------------

local function light_resume(inst, time)
    local percent = time/inst.components.spell.duration
    local var = inst.components.spell.variables
    if percent and time > 0 then
        --Snap light to value
        inst.components.lighttweener:StartTween(inst.light, Lerp(0, var.radius, percent), 0.8, 0.5, {1,1,1}, 0)
        --resume tween with time left
        inst.components.lighttweener:StartTween(nil, 0, nil, nil, nil, time)
    end
end

local function light_onsave(inst, data)
    data.timealive = inst:GetTimeAlive()
end

local function light_onload(inst, data)
    if data and data.timealive then
        light_resume(inst, data.timealive)
    end
end

local function light_spellfn(inst, target, variables)
    if target then
        inst.Transform:SetPosition(target:GetPosition():Get())
    end
end

local function light_start(inst)
    local spell = inst.components.spell
    inst.components.lighttweener:StartTween(inst.light, spell.variables.radius, 0.8, 0.5, {169/255,231/255,245/255}, 0)
    inst.components.lighttweener:StartTween(nil, 0, nil, nil, nil, spell.duration)
end

local function light_ontarget(inst, target)
    if not target then return end
    target.glowdust = inst
    target:AddTag(inst.components.spell.spellname)
  --  target.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
end

local function light_onfinish(inst)
    if not inst.components.spell.target then
        return
    end
    inst.components.spell.target.glowdust = nil
  --  inst.components.spell.target.AnimState:ClearBloomEffectHandle()
end

local light_variables = {
    radius = TUNING.WORMLIGHT_RADIUS,
}

local function lightfn()

    local inst = CreateEntity()
    inst.entity:AddTransform()

    inst:AddComponent("lighttweener")
    inst.light = inst.entity:AddLight()
    inst.light:Enable(true)

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    local spell = inst:AddComponent("spell")
    inst.components.spell.spellname = "wormlight"
    inst.components.spell:SetVariables(light_variables)
    inst.components.spell.duration = 180
    inst.components.spell.ontargetfn = light_ontarget
    inst.components.spell.onstartfn = light_start
    inst.components.spell.onfinishfn = light_onfinish
    inst.components.spell.fn = light_spellfn
    inst.components.spell.resumefn = light_resume

    inst.components.spell.removeonfinish = true

    return inst
end

return Prefab( "glowdust", fn, assets) ,
Prefab("common/inventory/wormlight_light", lightfn)

