local function OnLightWeaponDrop(inst)
	local lightdata = inst.LightableData
	if inst.leyuan_weapon_fx == nil then
        inst.leyuan_weapon_fx = SpawnPrefab("leyuan_weapon_fx")
		if lightdata then 
			--function(self,Intensity,Radius,Falloff,Colour,Enable)
			inst.leyuan_weapon_fx:InitLight(lightdata.Intensity,lightdata.Radius,lightdata.Falloff,lightdata.Colour,lightdata.Enable)
		end
		inst.leyuan_weapon_fx.entity:SetParent(inst.entity)         
		inst.leyuan_weapon_fx.Transform:SetPosition(0,0,0) 
		inst.leyuan_weapon_fx.owner = inst
    end
end 

local function OnLightWeaponPickup(inst)
	if inst.leyuan_weapon_fx ~= nil then
        inst.leyuan_weapon_fx:Remove()
        inst.leyuan_weapon_fx = nil
    end
end 

local function OnLightWeaponEquip(inst,data)
	local lightdata = inst.LightableData
	local owner = data.owner 
	if inst.leyuan_weapon_fx == nil then
        inst.leyuan_weapon_fx = SpawnPrefab("leyuan_weapon_fx")
		if lightdata then 
			inst.leyuan_weapon_fx:InitLight(lightdata.Intensity,lightdata.Radius,lightdata.Falloff,lightdata.Colour,lightdata.Enable)
		end
        inst.leyuan_weapon_fx.entity:AddFollower()
        inst.leyuan_weapon_fx.Follower:FollowSymbol(owner.GUID, "swap_object", 0, -110, 0)
		inst.leyuan_weapon_fx.owner = inst
    end
end 

local function OnLightWeaponUnEquip(inst)
	if inst.leyuan_weapon_fx ~= nil then
        inst.leyuan_weapon_fx:Remove()
        inst.leyuan_weapon_fx = nil
    end
end 

local function MakeLightable(inst,data)
	inst.LightableData = data 
	inst:DoTaskInTime(0,function()
		if inst.components.inventoryitem and not inst.components.inventoryitem.owner then 
			OnLightWeaponDrop(inst)
		end
	end)
	inst:ListenForEvent("equipped",OnLightWeaponEquip)
	inst:ListenForEvent("unequipped",OnLightWeaponUnEquip)
	inst:ListenForEvent("ondropped",OnLightWeaponDrop)
	inst:ListenForEvent("onputininventory",OnLightWeaponPickup)
	inst:ListenForEvent("onremove",OnLightWeaponUnEquip)
end 

--ACTIONS.CHOP
local function AddTools(inst,actionname,effects,consume)
	consume = consume or 1
	
	if not inst.components.tool then
		inst:AddComponent("tool")
	end
	inst.components.tool:SetAction(actionname,effects)
	
	if inst.components.finiteuses then 
		inst.components.finiteuses:SetConsumption(actionname,consume)
	end
end 

local function AddLevelable(inst,startdamage,deltadamage,maxlevel)
	if not inst.components.leyuanweapon then
		inst:AddComponent("leyuanweapon")
	end
	inst.components.weapon:SetDamage(startdamage)
	inst.components.leyuanweapon:SetStartDamage(startdamage or 0)
	inst.components.leyuanweapon:SetDeltaDamage(deltadamage or 0)
	inst.components.leyuanweapon:SetMaxLevel(maxlevel or 10)
end 

local ExtraClientFns = {

}

local ExtraServerFns = {
	gay_samllsword = function(inst)
		AddTools(inst,ACTIONS.CHOP)
		AddTools(inst,ACTIONS.MINE)
		AddLevelable(inst,25,5) 
		MakeLightable(inst,{
			Colour = Vector3(137/255,74/255,42/255),
		})
	end,
	
	undead_killer = function(inst)
		AddLevelable(inst,45,5) 
	end,
}

local function MakeWeapon(prefabname,tags,damage,range,finite_uses,walkspeedmult,dapperness,extraclientfn,extraserverfn)
	extraclientfn = extraclientfn or ExtraClientFns[prefabname] or nil 
	extraserverfn = extraserverfn or ExtraServerFns[prefabname] or nil 
	local assets =
	{
		Asset("ANIM", "anim/leyuan_weapon_groups.zip"),
		Asset("ANIM", "anim/swap_leyuan_weapon_groups.zip"),
		Asset("IMAGE","images/inventoryimages/"..prefabname..".tex"),
		Asset("ATLAS","images/inventoryimages/"..prefabname..".xml"),
	}

	local function onequip(inst, owner)
		owner.AnimState:OverrideSymbol("swap_object", "swap_leyuan_weapon_groups",prefabname)
		owner.AnimState:Show("ARM_carry")
		owner.AnimState:Hide("ARM_normal")
	end

	local function onunequip(inst, owner)
		owner.AnimState:Hide("ARM_carry")
		owner.AnimState:Show("ARM_normal")
		owner.AnimState:ClearOverrideSymbol("swap_object")
	end

	local function fn()
		local inst = CreateEntity()

		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
		inst.entity:AddNetwork()

		MakeInventoryPhysics(inst)

		inst.AnimState:SetBank("leyuan_weapon_groups")
		inst.AnimState:SetBuild("leyuan_weapon_groups")
		inst.AnimState:PlayAnimation(prefabname)

		--inst:AddTag("sharp")
		--inst:AddTag("pointy")
		if tags then 
			for k,v in pairs(tags) do 
				inst:AddTag(v) 
			end
		end 
		
		if extraclientfn then 
			extraclientfn(inst) 
		end 

		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end

		inst:AddComponent("weapon")
		inst.components.weapon:SetDamage(damage or 0)
		inst.components.weapon:SetRange(range)

		-------
		
		if finite_uses then 
			inst:AddComponent("finiteuses")
			inst.components.finiteuses:SetMaxUses(finite_uses)
			inst.components.finiteuses:SetUses(finite_uses)
			inst.components.finiteuses:SetOnFinished(inst.Remove)
		end 

		inst:AddComponent("inspectable")

		inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.imagename = prefabname
		inst.components.inventoryitem.atlasname = "images/inventoryimages/"..prefabname..".xml"

		inst:AddComponent("equippable")
		inst.components.equippable:SetOnEquip(onequip)
		inst.components.equippable:SetOnUnequip(onunequip)
		inst.components.equippable.walkspeedmult = walkspeedmult or 1.0 
		inst.components.equippable.dapperness = dapperness or 0 

		MakeHauntableLaunch(inst)
		
		if extraserverfn then 
			extraserverfn(inst)
		end

		return inst
	end
	
	--STRINGS.NAMES[string.upper(prefabname)] = stringname
	--STRINGS.RECIPE_DESC[string.upper(prefabname)] = recipe_desc
	--STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper(prefabname)] = description
	
	return Prefab(prefabname, fn, assets)
end 

local function fxfn()
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    inst.Light:SetIntensity(0.7)
	inst.Light:SetRadius(1.25)
	inst.Light:SetFalloff(0.5)
	inst.Light:SetColour(0/255,255/255,255/255)
	inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
	
	inst.InitLight = function(self,Intensity,Radius,Falloff,Colour,Enable)
		if Enable == nil then 
			Enable = true 
		end
		if Colour == nil then 
			Colour = Vector3(0/255,255/255,255/255)
		end
		self.Light:SetIntensity(Intensity or 0.7)
		self.Light:SetRadius(Radius or 1.25)
		self.Light:SetFalloff(Falloff or 0.5)
		self.Light:SetColour(Colour:Get())
		self.Light:Enable(Enable)
	end 
	
	inst:DoTaskInTime(0,function()
		if inst.owner == nil then 
			inst:Remove()
		end
	end)
	
    return inst
end

--prefabname,stringname,recipe_desc,description,tags,damage,range,finite_uses,walkspeedmult,dapperness,extraclientfn,extraserverfn
return Prefab( "leyuan_weapon_fx", fxfn),
MakeWeapon("gay_samllsword",nil,25,0.2,nil,1.05,0.1),
MakeWeapon("undead_killer",nil,45,0.4)
