local function change()
	return 
{	

	Asset("ANIM", "anim/ly_zhenkong.zip"),
	Asset("ANIM", "anim/swap_zhenkong001.zip"),
	Asset("ANIM", "anim/swap_zhenkong002.zip"),
	Asset("ANIM", "anim/swap_zhenkong003.zip"),
	Asset("ANIM", "anim/swap_zhenkong004.zip"),
	Asset("ANIM", "anim/swap_zhenkong005.zip"),
	Asset("ANIM", "anim/swap_zhenkong006.zip"),
	Asset("ANIM", "anim/swap_zhenkong007.zip"),
	Asset("ANIM", "anim/swap_zhenkong008.zip"),
	Asset("ATLAS", "images/inventoryimages/zhenkong.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/zhenkong.tex"),
	}
		
end

local assets = change()

------------------------------
local function onequip(inst, owner) --装备
    inst.entity:AddLight()
	inst.Light:Enable(true)
	inst.Light:SetRadius(6)  ----光照范围
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.9)
    inst.Light:SetColour(225/255,120/255,80/255)


    if owner.xxlevel >= 500 then 
   
	if inst.dengji <  1  then 
		owner.AnimState:OverrideSymbol("swap_object", "swap_zhenkong004", "swap_zhenkong004")
	elseif inst.dengji < 3 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_zhenkong003", "swap_zhenkong003")
	elseif inst.dengji < 5 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_zhenkong002", "swap_zhenkong002")
	elseif inst.dengji < 8 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_zhenkong001", "swap_zhenkong001")
	elseif inst.dengji < 10 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_zhenkong005", "swap_zhenkong005")
	elseif inst.dengji < 12 then	
		owner.AnimState:OverrideSymbol("swap_object", "swap_zhenkong006", "swap_zhenkong006")
	elseif inst.dengji < 15 then	
		owner.AnimState:OverrideSymbol("swap_object", "swap_zhenkong007", "swap_zhenkong007")
	elseif inst.dengji < 18 then	
		owner.AnimState:OverrideSymbol("swap_object", "swap_zhenkong008", "swap_zhenkong008")
	end
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
	else 
		owner:DoTaskInTime(0.01,function()
			local inv = owner.components.inventory
			if inv then 
				inv:GiveItem(inst)
				owner.components.talker:Say("等级不足，需要等级500级")	
			end
	    end)
	
	end 
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
	

	inst.wepontype = math.random()
    MakeInventoryPhysics(inst)
	inst.AnimState:SetBank("ly_zhenkong")  --地上动画
    inst.AnimState:SetBuild("ly_zhenkong")
    inst.AnimState:PlayAnimation("idle",true)
    

    inst:AddTag("sharp") 
    inst:AddTag("pointy")
	
	inst:AddComponent("talker")
	
	inst.components.talker.fontsize = 24
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(.3, .9, .9, 1)
    inst.components.talker.offset = Vector3(200,-250,0)
    inst.components.talker.symbol = "swap_object"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	
	
	
	

    inst:AddComponent("weapon") 
	inst.gongji  = 90

    inst:AddComponent("inspectable") --可检查组件

    inst:AddComponent("inventoryitem") --物品组件
	inst.components.inventoryitem.atlasname = "images/inventoryimages/zhenkong.xml" --物品贴图

		
    inst:AddComponent("equippable") --可装备组件
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	inst.dengji=0
    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("zhenkong", fn, assets)   ---c_give"zhenkong"