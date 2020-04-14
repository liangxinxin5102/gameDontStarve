local function change()
	return 
{	
	Asset("ANIM", "anim/xinshouwuqi001.zip"),
	Asset("ANIM", "anim/xinshouwuqi002.zip"),
	Asset("ANIM", "anim/xinshouwuqi003.zip"),
	Asset("ANIM", "anim/xinshouwuqi004.zip"),
	Asset("ANIM", "anim/xinshouwuqi005.zip"),
	Asset("ANIM", "anim/xinshouwuqi006.zip"),
	Asset("ANIM", "anim/xinshouwuqi007.zip"),
	Asset("ANIM", "anim/xinshouwuqi008.zip"),
	Asset("ANIM", "anim/xinshouwuqi009.zip"),
	Asset("ANIM", "anim/xinshouwuqi010.zip"),
	Asset("ANIM", "anim/xinshouwuqi011.zip"),
	Asset("ANIM", "anim/xinshouwuqi012.zip"),
	Asset("ANIM", "anim/swap_xinshouwuqi001.zip"),
	Asset("ANIM", "anim/swap_xinshouwuqi002.zip"),
	Asset("ANIM", "anim/swap_xinshouwuqi003.zip"),
	Asset("ANIM", "anim/swap_xinshouwuqi004.zip"),
	Asset("ANIM", "anim/swap_xinshouwuqi005.zip"),
	Asset("ANIM", "anim/swap_xinshouwuqi006.zip"),
	Asset("ANIM", "anim/swap_xinshouwuqi007.zip"),
	Asset("ANIM", "anim/swap_xinshouwuqi008.zip"),
	Asset("ANIM", "anim/swap_xinshouwuqi009.zip"),
	Asset("ANIM", "anim/swap_xinshouwuqi010.zip"),
	Asset("ANIM", "anim/swap_xinshouwuqi011.zip"),
	Asset("ANIM", "anim/swap_xinshouwuqi012.zip"),
	Asset("ATLAS", "images/inventoryimages/newweapons.xml"),--加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/newweapons.tex"),
	Asset("IMAGE", "images/inventoryimages/ly_weapon.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/ly_weapon.xml"),
	}
		
end

local assets = change()

local  wepontype = math.random()
local function onequip(inst, owner) --装备
	inst.entity:AddLight()
	inst.Light:Enable(true)
	inst.Light:SetRadius(6)  ----光照范围
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.9)
    inst.Light:SetColour(225/255,120/255,80/255)
	owner.AnimState:OverrideSymbol("swap_object", "swap_xinshouwuqi012", "swap_xinshouwuqi012")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end


local function onunequip(inst, owner) --解除装备
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function fn()
    local inst = CreateEntity()	
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)	
	inst.AnimState:SetBank("xinshouwuqi012")  --地上动画
	inst.AnimState:SetBuild("xinshouwuqi012")
	inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp") 
    inst:AddTag("pointy")
	
	inst:AddComponent("talker")
	
	inst.components.talker.fontsize = 24
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.75, 0.75, 0.75, 1)
    inst.components.talker.offset = Vector3(200,-250,0)
    inst.components.talker.symbol = "swap_object"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	inst.gongji = 20
    inst:AddComponent("weapon") --增加武器组件 有了这个才可以打人
    inst:AddComponent("inspectable") --可检查组件
    inst:AddComponent("inventoryitem") --物品组件
	inst.components.inventoryitem.atlasname = "images/inventoryimages/newweapons.xml" --物品贴图
		
    inst:AddComponent("equippable") --可装备组件
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)


    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("newweapons", fn, assets)   --- c_give"newweapons"