local function change()
	return 
{	

	Asset("ANIM", "anim/ly_taidao.zip"),
	Asset("ANIM", "anim/swap_ly_taidao001.zip"),
	Asset("ANIM", "anim/swap_ly_taidao002.zip"),
	Asset("ANIM", "anim/swap_ly_taidao003.zip"),
	Asset("ANIM", "anim/swap_ly_taidao004.zip"),
	Asset("ANIM", "anim/swap_ly_taidao005.zip"),
	Asset("ANIM", "anim/swap_ly_taidao006.zip"),
	Asset("ANIM", "anim/swap_ly_taidao007.zip"),
	Asset("ANIM", "anim/swap_ly_taidao008.zip"),
	Asset("ATLAS", "images/inventoryimages/taidao.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/taidao.tex"),
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



	if owner.xxlevel >= 1500 then 
	if inst.dengji < 1 then 
		owner.AnimState:OverrideSymbol("swap_object", "swap_ly_taidao004", "swap_ly_taidao004")
	elseif inst.dengji < 3 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_ly_taidao003", "swap_ly_taidao003")
	elseif inst.dengji < 5 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_ly_taidao002", "swap_ly_taidao002")
	elseif inst.dengji < 8 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_ly_taidao001", "swap_ly_taidao001")
	elseif inst.dengji < 10 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_ly_taidao005", "swap_ly_taidao005")
	elseif inst.dengji < 12 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_ly_taidao006", "swap_ly_taidao006")
	elseif inst.dengji < 15 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_ly_taidao007", "swap_ly_taidao007")
	elseif inst.dengji < 18 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_ly_taidao008", "swap_ly_taidao008")		
	end
		owner.AnimState:Show("ARM_carry")
		owner.AnimState:Hide("ARM_normal")
	else 
		owner:DoTaskInTime(0.01,function()
			local inv = owner.components.inventory
			if inv then 
				inv:GiveItem(inst)
				owner.components.talker:Say("等级不足，需要等级1500级")	
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
    MakeInventoryPhysics(inst)
	inst.AnimState:SetBank("ly_taidao")  --地上动画
    inst.AnimState:SetBuild("ly_taidao")
    inst.AnimState:PlayAnimation("idle",true)   
    inst:AddTag("sharp") 
    inst:AddTag("pointy")
	
	inst:AddComponent("talker")
	
	inst.components.talker.fontsize = 24
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(.5, .9, .3, 1)
    inst.components.talker.offset = Vector3(200,-250,0)
    inst.components.talker.symbol = "swap_object"
    
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	--inst.gongji = 180
	inst.gongji = 240
    inst:AddComponent("weapon") 
    inst:AddComponent("inspectable") --可检查组件
    inst:AddComponent("inventoryitem") --物品组件
	inst.components.inventoryitem.atlasname = "images/inventoryimages/taidao.xml" --物品贴图		
    inst:AddComponent("equippable") --可装备组件
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("taidao", fn, assets)