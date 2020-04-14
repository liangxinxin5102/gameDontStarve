local function change()
	return 
{	
	Asset("ANIM", "anim/ly_chazi.zip"),
	Asset("ANIM", "anim/swap_ly_chazi001.zip"),
	Asset("ANIM", "anim/swap_ly_chazi002.zip"),
	Asset("ANIM", "anim/swap_ly_chazi003.zip"),
	Asset("ANIM", "anim/swap_ly_chazi004.zip"),
	Asset("ANIM", "anim/swap_ly_chazi005.zip"),
	Asset("ANIM", "anim/swap_ly_chazi006.zip"),
	Asset("ANIM", "anim/swap_ly_chazi007.zip"),
	Asset("ANIM", "anim/swap_ly_chazi008.zip"),
	Asset("ATLAS", "images/inventoryimages/chazi.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/chazi.tex"),
	}	
end

local assets = change()
------------------------------
local function onequip(inst, owner) --装备
    inst.entity:AddLight()
	inst.Light:Enable(true)
	inst.Light:SetRadius(6)  ----光照范围
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.8)
    inst.Light:SetColour(225/255,120/255,80/255)
    
    if owner.xxlevel >= 1000 then
	if inst.dengji < 1 then 
		owner.AnimState:OverrideSymbol("swap_object", "swap_ly_chazi004", "swap_ly_chazi004")
	elseif inst.dengji < 3 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_ly_chazi003", "swap_ly_chazi003")
	elseif inst.dengji < 5 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_ly_chazi002", "swap_ly_chazi002")
	elseif inst.dengji < 8 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_ly_chazi001", "swap_ly_chazi001")
	elseif inst.dengji < 10 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_ly_chazi005", "swap_ly_chazi005")
    elseif inst.dengji < 13 then		
		owner.AnimState:OverrideSymbol("swap_object", "swap_ly_chazi006", "swap_ly_chazi006")
    elseif inst.dengji < 15 then		
		owner.AnimState:OverrideSymbol("swap_object", "swap_ly_chazi007", "swap_ly_chazi007")
	elseif inst.dengji < 18 then	
		owner.AnimState:OverrideSymbol("swap_object", "swap_ly_chazi008", "swap_ly_chazi008")
	end
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
	
	else 
		owner:DoTaskInTime(0.01,function()
			local inv = owner.components.inventory
			if inv then 
				inv:GiveItem(inst)
				owner.components.talker:Say("等级不足，需要等级1000级")	
			end
	    end)
	
	end 
end

local function onunequip(inst, owner) 
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
	inst.AnimState:SetBank("ly_chazi")  --地上动画
    inst.AnimState:SetBuild("ly_chazi")
    inst.AnimState:PlayAnimation("idle",true)   
    inst:AddTag("sharp") 
    inst:AddTag("pointy")	
	inst:AddComponent("talker")	
	inst.components.talker.fontsize = 24
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(.7, .5, .5, 1)
    inst.components.talker.offset = Vector3(200,-250,0)
    inst.components.talker.symbol = "swap_object"
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	inst.gongji = 135
    inst:AddComponent("weapon") 


    inst:AddComponent("inspectable") 

    inst:AddComponent("inventoryitem") 
	inst.components.inventoryitem.atlasname = "images/inventoryimages/chazi.xml" --物品贴图
    inst:AddComponent("equippable") --可装备组件
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("chazi", fn, assets)