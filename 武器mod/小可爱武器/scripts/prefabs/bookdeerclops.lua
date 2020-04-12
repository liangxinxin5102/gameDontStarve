local assets =
{
Asset("ANIM", "anim/bookdeerclops.zip"),
Asset("ATLAS", "images/inventoryimages/bookdeerclops.xml"),


}

local prefabs =
{

}



local book_defs =
{
{
name = "bookdeerclops",
uses = 1,
fn = function (inst, reader)
	local pt = reader:GetPosition()
	local numboss = 1
	
	reader.components.sanity:DoDelta(-TUNING.SANITY_HUGE)
	
	reader:StartThread(function ()
		for k = 1, numboss do
			local theta = math.random() * 2 * PI
			local radius = math.random(3, 8)
			
			-- we have to special case this one because birds can't land on creep
			local result_offset = FindValidPositionByFan(theta, radius, 12, function (offset)
				local pos = pt + offset
				--NOTE: The first search includes invisible entities
				return #TheSim:FindEntities(pos.x, 0, pos.z, 1, nil, { "INLIMBO", "FX" }) <= 0
				and TheWorld.Map:IsDeployPointClear(pos, nil, 1)
			end)
			
			if result_offset ~= nil then
				local x, z = pt.x + result_offset.x, pt.z + result_offset.z
				local boss = SpawnPrefab("deerclops")
				boss.Transform:SetPosition(x, 0, z)
				
			end
			
			
		end
	end)
	return true
end,
},

}

local function MakeBook(def)
	--[[local morphlist = {}
	for i, v in ipairs(book_defs) do
		if v ~= def then
			table.insert(morphlist, v.name)
		end
		end]]
		
		local function fn()
			local inst = CreateEntity()
			
			inst.entity:AddTransform()
			inst.entity:AddAnimState()
			inst.entity:AddSoundEmitter()
			inst.entity:AddNetwork()
			
			MakeInventoryPhysics(inst)
			
			inst.AnimState:SetBank("bookdeerclops")
            inst.AnimState:SetBuild("bookdeerclops")
            inst.AnimState:PlayAnimation("idle")
			
			inst.entity:SetPristine()
			
			if not TheWorld.ismastersim then
				return inst
			end
			
			-----------------------------------
			
			inst:AddComponent("inspectable")
			inst:AddComponent("book")
			inst.components.book.onread = def.fn
			
			inst:AddComponent("inventoryitem")
	       inst.components.inventoryitem.atlasname = "images/inventoryimages/bookdeerclops.xml"
		   
			inst:AddComponent("finiteuses")
			inst.components.finiteuses:SetMaxUses(def.uses)
			inst.components.finiteuses:SetUses(def.uses)
			inst.components.finiteuses:SetOnFinished(inst.Remove)
			
			inst:AddComponent("fuel")
			inst.components.fuel.fuelvalue = TUNING.MED_FUEL
			
			MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
			MakeSmallPropagator(inst)
			
			--MakeHauntableLaunchOrChangePrefab(inst, TUNING.HAUNT_CHANCE_OFTEN, TUNING.HAUNT_CHANCE_OCCASIONAL, nil, nil, morphlist)
			MakeHauntableLaunch(inst)
			
			return inst
		end
		
		return Prefab(def.name, fn, assets, prefabs)
	end
	
	local books = {}
	for i, v in ipairs(book_defs) do
		table.insert(books, MakeBook(v))
	end
	book_defs = nil
	return unpack(books)
	