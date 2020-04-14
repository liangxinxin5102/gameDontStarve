
local prefix="ly_"    ---ly_ggo    ly_alo      c_give("sn_ggo")
local manshape_defs={
	{
		name="ggo",
		anim="idle",
		zg_name="666戒指礼包",
		zg_desc="打开可获得所有戒指赞助奖励！",
		zg_desc_rec="打开可获得所有戒指赞助奖励！",
		teacher=true,
		onteach=function(inst, learner)
			if learner and learner.components.inventory then 
				learner.components.inventory:GiveItem(SpawnPrefab("wx_ringr",1)) 
				learner.components.inventory:GiveItem(SpawnPrefab("wx_ringp",1)) 
				learner.components.inventory:GiveItem(SpawnPrefab("wx_ringo",1)) 
				learner.components.inventory:GiveItem(SpawnPrefab("wx_ringg",1)) 
				learner.components.inventory:GiveItem(SpawnPrefab("wx_ringy",1)) 
				learner.components.inventory:GiveItem(SpawnPrefab("wx_ringh",1)) 
				learner.components.inventory:GiveItem(SpawnPrefab("wx_ringw",1)) 
				learner.components.inventory:GiveItem(SpawnPrefab("wx_ringb",1)) 
				learner.components.inventory:GiveItem(SpawnPrefab("wx_plus03",1)) 
				
			end
		end,
	},
	
	--alo
	{
		name="alo",
		anim="idle",
		zg_name="888元礼包",
		zg_desc="打开可随机获得",
		zg_desc_rec="随机翅膀",
		teacher=true,
		onteach=function(inst, learner)
			if learner and learner.components.inventory then 
				local tab={"log"}
				learner.components.inventory:GiveItem(SpawnPrefab(tab[math.random(#tab)])) 
			end
		end,
	},
		
}

local function MakeManshape(def)
	
	def.assets={
		Asset("ANIM","anim/sn_"..def.name..".zip"),
		Asset("ATLAS","images/inventoryimages/sn_"..def.name..".xml"),
	}

	local function fn()
		local inst = CreateEntity()

		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddNetwork()
		inst.entity:AddSoundEmitter()

		MakeInventoryPhysics(inst)

		--地上图片
		inst.AnimState:SetBank(def.bank or "sn_"..def.name)
		inst.AnimState:SetBuild(def.build or "sn_"..def.name)
		inst.AnimState:PlayAnimation(def.anim or "NewAnimation")

		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end
		
		inst.zg_name=def.zg_name
		inst.zg_desc=def.zg_desc

		inst:AddComponent("inspectable")

		--物品栏图片
		inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname="images/inventoryimages/sn_"..def.name..".xml"
		inst.components.inventoryitem.imagename= "sn_"..def.name
		
		--开盒子得到东西
		if def.teacher then
			inst:AddComponent("teacher")
			function inst.components.teacher:Teach(target)
				if self.onteach then 
					self.onteach(self.inst, target)
				end
				self.inst:Remove()
			end
			inst.components.teacher.onteach = def.onteach or function() end
		end

		return inst
	end
	return Prefab(prefix..def.name, fn, def.assets)
end




local manshapes = {}
for i, v in ipairs(manshape_defs) do
    table.insert(manshapes, MakeManshape(v))
	STRINGS.NAMES[string.upper(prefix..v.name)]=v.zg_name
	STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper(prefix..v.name)]=v.zg_desc
	STRINGS.RECIPE_DESC[string.upper(prefix..v.name)] = v.zg_desc_rec
end
manshape_defs = nil
return unpack(manshapes)