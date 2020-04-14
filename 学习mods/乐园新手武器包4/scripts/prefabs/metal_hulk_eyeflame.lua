
--local SPARKLE_TEXTURE = "fx/sparkle.tex"

local ADD_SHADER = "shaders/vfx_particle.ksh"

local SPARKLE_TEXTURE = resolvefilepath("fx/smoke.tex") 
local COLOUR_ENVELOPE_NAME = "metal_hulk_eyeflame_smoke_colourenvelope"
local SCALE_ENVELOPE_NAME = "metal_hulk_eyeflame_smoke_scaleenvelope"

local LIGHTNING_TEXTURE = resolvefilepath("fx/smoke.tex") 
local LIGHTNING_COLOUR_ENVELOPE_NAME = "metal_hulk_eyeflame_lightning_colourenvelope"
local LIGHTNING_SCALE_ENVELOPE_NAME = "metal_hulk_eyeflame_lightning_scaleenvelope"

local assets =
{
    Asset("IMAGE", SPARKLE_TEXTURE),
	Asset("IMAGE", LIGHTNING_TEXTURE),
    Asset("SHADER", ADD_SHADER),
}

--------------------------------------------------------------------------

local function IntColour(r, g, b, a)
    return { r / 255, g / 255, b / 255, a / 255 }
end

local function InitEnvelope()
    EnvelopeManager:AddColourEnvelope(COLOUR_ENVELOPE_NAME, {
		{ 0,    IntColour(225, 15, 15, 50) },
        { .3,   IntColour(200, 12, 12, 100) },
        { .55,  IntColour(198, 10, 10, 50) },
        { 1,    IntColour(198, 10, 10, 0) },
	})

    local sparkle_max_scale = 1.5
    EnvelopeManager:AddVector2Envelope(
        SCALE_ENVELOPE_NAME,
        {
            { 0,    { sparkle_max_scale, sparkle_max_scale} },
			{ .3,  { sparkle_max_scale * .9, sparkle_max_scale * .9} },
            { .55,  { sparkle_max_scale * .6, sparkle_max_scale * .6} },
			{ 1,    { sparkle_max_scale * .4, sparkle_max_scale * .4} },
        }
    )
	
	
	
	EnvelopeManager:AddColourEnvelope(LIGHTNING_COLOUR_ENVELOPE_NAME, {
		{ 0,    IntColour(225, 15, 15, 100) },
        { .3,   IntColour(200, 12, 12, 75) },
        { .55,  IntColour(198, 10, 10, 28) },
        { 1,    IntColour(198, 10, 10, 0) },
	})

    local lightning_max_scale = 1.5
    EnvelopeManager:AddVector2Envelope(
        LIGHTNING_SCALE_ENVELOPE_NAME,
        {
            { 0,    { lightning_max_scale, lightning_max_scale} },
			{ .3,  { lightning_max_scale * .9, lightning_max_scale * .9} },
            { .55,  { lightning_max_scale * .6, lightning_max_scale * .6} },
			{ 1,    { lightning_max_scale * .4, lightning_max_scale * .4} },
        }
    )

    InitEnvelope = nil
    IntColour = nil
end

--------------------------------------------------------------------------
local MAX_LIFETIME = 0.75
local LIGHTNING_MAX_LIFETIME = 0.75
local function emit_sparkle_fn(effect, sphere_emitter)
    --local vx, vy, vz = .012 * UnitRand(), 0, .012 * UnitRand()
    --local lifetime = MAX_LIFETIME * (.7 + UnitRand() * .3)
    --local px, py, pz = sphere_emitter()

    
    --local uv_offset = math.random(0, 3) * .25
    
	
	local vx, vy, vz = .01 * UnitRand(), 0, .01 * UnitRand()
    local lifetime = MAX_LIFETIME * (.9 + UnitRand() * .1)
    local px, py, pz = sphere_emitter()
    local uv_offset = math.random(0, 3) * .25
	
	local angle = math.random() * 360    
	local ang_vel = (UnitRand() - 1) * 5

    --[[effect:AddRotatingParticleUV(
        0,
        lifetime,           -- lifetime
        px, py, pz,         -- position
        vx, vy, vz,         -- velocity
        angle, ang_vel,     -- angle, angular_velocity
        uv_offset, 0        -- uv offset
    )--]]
	
	effect:AddParticleUV(
        1,
        lifetime,           -- lifetime
        px, py, pz,         -- position
        vx, vy, vz,         -- velocity
        uv_offset, 0        -- uv offset
    )
end

local function emit_lightning_fn(effect, sphere_emitter)
    local vx, vy, vz = .01 * UnitRand(), .05, .01 * UnitRand()
    local lifetime = LIGHTNING_MAX_LIFETIME * (.9 + UnitRand() * .1)
    local px, py, pz = sphere_emitter()
    local uv_offset = math.random(0, 3) * .25

    effect:AddParticleUV(
        0,
        lifetime,           -- lifetime
        px, py, pz,         -- position
        vx, vy, vz,         -- velocity
        uv_offset, 0        -- uv offset
    )      
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    --Dedicated server does not need to spawn local particle fx
    if InitEnvelope ~= nil and not TheNet:IsDedicated() then
        InitEnvelope()
    end

    local effect = inst.entity:AddVFXEffect()
    effect:InitEmitters(2)

    --SPARKLE
    --[[effect:SetRenderResources(0, SPARKLE_TEXTURE, ADD_SHADER)
    effect:SetRotationStatus(0, true)
    effect:SetUVFrameSize(0, .25, 1)
    effect:SetMaxNumParticles(0, 256)
    effect:SetMaxLifetime(0, MAX_LIFETIME)
    effect:SetColourEnvelope(0, COLOUR_ENVELOPE_NAME)
    effect:SetScaleEnvelope(0, SCALE_ENVELOPE_NAME)
    effect:SetBlendMode(0, BLENDMODE.Additive)
    effect:EnableBloomPass(0, true)
    effect:SetSortOrder(0, 0)
    effect:SetSortOffset(0, 2)--]]
	
	--lightning
	effect:SetRenderResources(0, LIGHTNING_TEXTURE, ADD_SHADER)--设置源，参数：序号，贴图，渲染程序名
    effect:SetMaxNumParticles(0, 128)--设置颗粒最大数，即粒子效果同时出现的最大数
    effect:SetMaxLifetime(0, LIGHTNING_MAX_LIFETIME)--粒子持续时间
    effect:SetColourEnvelope(0, LIGHTNING_COLOUR_ENVELOPE_NAME)--设置调色效果
    effect:SetScaleEnvelope(0, LIGHTNING_SCALE_ENVELOPE_NAME)--设置缩放效果
    effect:SetBlendMode(0, BLENDMODE.Additive)--设置混合形态
    effect:EnableBloomPass(0, true)--设置辉光
    effect:SetUVFrameSize(0, .25, 1)--
    effect:SetSortOrder(0, 2)
    effect:SetSortOffset(0, 0)
	
	--normal
	effect:SetRenderResources(1, SPARKLE_TEXTURE, ADD_SHADER)
    effect:SetMaxNumParticles(1, 32)
    effect:SetMaxLifetime(1, MAX_LIFETIME)
    effect:SetColourEnvelope(1, COLOUR_ENVELOPE_NAME)
    effect:SetScaleEnvelope(1, SCALE_ENVELOPE_NAME)
    effect:SetBlendMode(1, BLENDMODE.Additive)
    effect:EnableBloomPass(1, true)
    effect:SetUVFrameSize(1, .25, 1)
    effect:SetSortOrder(1, 1)
    effect:SetSortOffset(1, 0)
	effect:SetKillOnEntityDeath(1, true)
    effect:SetFollowEmitter(1, true)
	
	

    -----------------------------------------------------

    local tick_time = TheSim:GetTickTime()

    local fire_desired_pps = 40
    local fire_particles_per_tick = fire_desired_pps * tick_time
    local num_particles_to_emit = 0
	local lightning_num_to_emit = 0 

    local sphere_emitter = CreateSphereEmitter(.05)

    EmitterManager:AddEmitter(inst, nil, function()

        num_particles_to_emit = num_particles_to_emit + fire_particles_per_tick
        while num_particles_to_emit > 1 do
            emit_sparkle_fn(effect, sphere_emitter)
            num_particles_to_emit = num_particles_to_emit - 1
        end
		
		lightning_num_to_emit = lightning_num_to_emit + fire_particles_per_tick
        while lightning_num_to_emit > 1 do
            emit_lightning_fn(effect, sphere_emitter)
            lightning_num_to_emit = lightning_num_to_emit - 1
        end
    end)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst.persists = false

    return inst
end

return Prefab("metal_hulk_eyeflame", fn, assets)
