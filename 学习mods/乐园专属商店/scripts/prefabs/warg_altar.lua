local assets =
{
    Asset("ANIM", "anim/quagmire_altar.zip"),
}
local prefabs =
{
    "warg",
}

local function ShouldAcceptItem(inst, item)
    return item.prefab == "lucky_goldnugget" and inst._time:value() == 0
end

local function OnGetItemFromPlayer(inst, giver, item)
	inst.SoundEmitter:PlaySound("dontstarve/quagmire/common/coins/drop")
    if inst.components.warg_lvl~= nil then
        inst.components.warg_lvl:DoDelta(1)
    end
end

local function get_name(inst)
	local name = STRINGS.NAMES[string.upper(inst.prefab)]
	
	if inst._lvl:value() ~= nil then
		name = name.."\n献祭元宝需要："..inst._lvl:value().."个"
	end
	if inst._time:value() ~= nil then
		name = name.."\n冷却剩余时间："..inst._time:value().."天"
	end
	return name
end

local function altarsfn(name, max ,maxlvl,boss)
	local function fn()
		local inst = CreateEntity()

		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
		inst.entity:AddNetwork()

		MakeInventoryPhysics(inst)

		inst.AnimState:SetBank("quagmire_altar")
		inst.AnimState:SetBuild("quagmire_altar")
		inst.AnimState:PlayAnimation("idle_empty")
		inst._lvl= net_byte(inst.GUID, name.."._lvl")
		inst._time =  net_byte(inst.GUID, name.."._time")
		inst.displaynamefn = get_name
		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end

		inst:AddComponent("inspectable")
	
		inst:AddComponent("trader")
		inst.components.trader:SetAcceptTest(ShouldAcceptItem)
		inst.components.trader.onaccept = OnGetItemFromPlayer

		inst:AddComponent("warg_lvl")
		inst.components.warg_lvl:SetMax(max)
		inst.components.warg_lvl:SetMaxlvl(maxlvl)
		inst.components.warg_lvl:SetBoss(boss)
		return inst
	end
	return Prefab(name, fn, assets)
end
		--名字 天数 元宝数 召唤的boss
return  altarsfn("warg_altar", 20 , 20,"warg"), --座狼    
		altarsfn("moose_altar", 5 , 3,"moose"),   --驼鹿
		altarsfn("dragonfly_altar", 15 , 15,"dragonfly"), --龙鹰
		altarsfn("bearger_altar", 10 , 10,"bearger"), --熊獾
		altarsfn("deerclops_altar", 10 , 10,"deerclops"), --巨鹿
		altarsfn("toadstool_dark_altar", 20 , 20,"toadstool_dark"), --毒菇
		altarsfn("minotaur_altar", 20 , 20,"minotaur"), --犀牛
		altarsfn("hjzs_altar", 75, 88,"hjzs") --战神