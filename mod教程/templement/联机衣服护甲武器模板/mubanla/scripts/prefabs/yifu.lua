local assets =
{
    Asset("ANIM", "anim/yifu.zip"),  --对应在anim里面的文件 加载动画文件
	Asset("ATLAS", "images/inventoryimages/yifu.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/yifu.tex"),
}

local function OnBlocked(owner, data) 
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end

local function onequip(inst, owner) --装备
	owner.AnimState:OverrideSymbol("swap_body", "yifu", "swap_body")
						 --三个参数分别是替换的贴图是swap_body  使用的动画是yifu  第三个这个注意 这个swap_body是你的动画里装图片的文件夹的名字
   
    inst:ListenForEvent("blocked", OnBlocked, owner)
end

local function onunequip(inst, owner)  --脱下
    owner.AnimState:ClearOverrideSymbol("swap_body")
    inst:RemoveEventCallback("blocked", OnBlocked, owner)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("yifu") --动画 --SP软件里面动画的总名字
    inst.AnimState:SetBuild("yifu") --smcl文件的名字
    inst.AnimState:PlayAnimation("anim")	--丢地上的动画 

    inst:AddTag("wood")

    inst.foleysound = "dontstarve/movement/foley/logarmour"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable") --可悲检查组件

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/yifu.xml"  --加载物品栏贴图 mod物品必须有
    
	inst:AddComponent("waterproofer")  --防雨组件  （括号里面可以直接填数字）
    inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_ABSOLUTE)
    
	inst:AddComponent("insulator") --温度隔绝组件（括号里可以直接天数字就是保温多少秒）
    inst.components.insulator:SetInsulation(240)
	
	inst:AddComponent("fuel")--燃料 组件
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME) --燃烧有关
    MakeSmallPropagator(inst)

    inst:AddComponent("armor")--护甲组件
    inst.components.armor:InitCondition(1500,0.9) --耐久度和减伤（90%）
    inst.components.armor:AddWeakness("beaver", TUNING.BEAVER_WOOD_DAMAGE)

    inst:AddComponent("equippable") --装备组件
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY --装备的部位是身体

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("yifu", fn, assets) --生成这个预设物  代码为 yifu
