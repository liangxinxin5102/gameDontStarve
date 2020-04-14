
local prefix="sn_"    ---sn_ggo    sn_alo      c_give("sn_ggo")
local manshape_defs={
	{
		name="ggo",
		anim="idle",
		zg_name="百元礼包",
		zg_desc="打开可获得百元赞助奖励",
		zg_desc_rec="百元奖励哦~",
		teacher=true,
		onteach=function(inst, learner)
			if learner and learner.components.inventory then 
				learner.components.inventory:GiveItem(SpawnPrefab("ly_tangguo09",1)) 
				learner.components.inventory:GiveItem(SpawnPrefab("ly_tgjys07",1)) 
				learner.components.inventory:GiveItem(SpawnPrefab("ly_tangguo01",20)) 
				learner.components.inventory:GiveItem(SpawnPrefab("ly_tangguo04",5)) 
				learner.components.inventory:GiveItem(SpawnPrefab("ly_tangguo12",2)) 
				learner.components.inventory:GiveItem(SpawnPrefab("ly_tangguo13",1)) 
				learner.components.inventory:GiveItem(SpawnPrefab("ly_tangguo02",1)) 
				learner.components.inventory:GiveItem(SpawnPrefab("ly_yc001",1)) 
				--learner.components.inventory:GiveItem(SpawnPrefab("ly_yc001",1)) 
				learner.components.inventory:GiveItem(SpawnPrefab("ly_yc001",1)) 
				learner.components.inventory:GiveItem(SpawnPrefab("ly_bx003",1)) 
				learner.components.inventory:GiveItem(SpawnPrefab("ly_bx002",1)) 
				learner.components.inventory:GiveItem(SpawnPrefab("ly_bx001",1)) 
				
			end
		end,
	},
	
	--alo
	{
		name="alo",
		anim="idle",
		zg_name="666元大翅膀礼包",
		zg_desc="打开可随机获得一个大翅膀",
		zg_desc_rec="随机翅膀",
		teacher=true,
		onteach=function(inst, learner)
			if learner and learner.components.inventory then 
				local tab={"cbdz0","cbdz1" ,"cbdz2","cbdz3","cbdz4","cbdz5","cbdz6","cbdz7"}
				learner.components.inventory:GiveItem(SpawnPrefab(tab[math.random(#tab)])) 
				learner.components.inventory:GiveItem(SpawnPrefab("ly_tangguo09",1)) 
			end
		end,
	},
		
}

local function MakeManshape(def)
	
	def.assets={
		Asset("ANIM","anim/"..prefix..def.name..".zip"),
		Asset("ATLAS","images/inventoryimages/"..prefix..def.name..".xml"),
	}

	local function fn()
		local inst = CreateEntity()

		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddNetwork()
		inst.entity:AddSoundEmitter()

		MakeInventoryPhysics(inst)

		--地上图片
		inst.AnimState:SetBank(def.bank or prefix..def.name)
		inst.AnimState:SetBuild(def.build or prefix..def.name)
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
		inst.components.inventoryitem.atlasname="images/inventoryimages/"..prefix..def.name..".xml"
		inst.components.inventoryitem.imagename= prefix..def.name
		
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