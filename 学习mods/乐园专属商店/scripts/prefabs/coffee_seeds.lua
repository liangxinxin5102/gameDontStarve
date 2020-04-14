require "prefabutil"

local Assets =
{
  Asset("ANIM", "anim/coffee_seeds.zip"),
	Asset("ATLAS", "images/inventoryimages/coffee_seeds.xml"),
	Asset("IMAGE", "images/inventoryimages/coffee_seeds.tex")
}


local prefabs =
		{
			"coffee",
			"coffee_seeds"
		} 



local function fn(Sim)
       local inst = CreateEntity()
	    inst.entity:AddTransform()
	    inst.entity:AddAnimState()
      inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)
	    inst.AnimState:SetBank("coffee_seeds")
	    inst.AnimState:SetBuild("coffee_seeds")
	    inst.AnimState:SetRayTestOnBB(true)
		  inst.AnimState:PlayAnimation("idle")

inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("edible")
      inst.components.edible.foodtype = "SEEDS"
      inst.components.edible.healthvalue = 0
      inst.components.edible.hungervalue = 0
      inst.components.edible.sanityvalue = 0
  
  MakeHauntableLaunch(inst)

    inst:AddComponent("inspectable")
    inst:AddComponent("perishable")
      inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERSLOW)
      inst.components.perishable:StartPerishing()
      inst.components.perishable.onperishreplacement = "spoiled_food"
      
    inst:AddComponent("cookable")
      inst.components.cookable.product = "seeds_cooked"
      
    inst:AddComponent("inventoryitem")
      inst.components.inventoryitem.imagename = "coffee_seeds"
      inst.components.inventoryitem.atlasname = "images/inventoryimages/coffee_seeds.xml"	

	inst:AddComponent("stackable")
    inst.components.stackable.maxsize = 40




	
	inst:AddComponent("bait")
	inst:AddComponent("plantable")
	inst.components.plantable.growtime = TUNING.SEEDS_GROW_TIME
	inst.components.plantable.product = "coffee"
	
	
	return inst
end

return Prefab( "common/inventory/coffee_seeds", fn, Assets)

			