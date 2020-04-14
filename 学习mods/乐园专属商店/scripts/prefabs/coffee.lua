require "prefabutil"

local Assets=
		{
			Asset("ATLAS", "images/inventoryimages/coffee.xml"),
			Asset("ATLAS", "images/inventoryimages/coffee_cooked.xml"),
			Asset("ANIM", "anim/coffee.zip"),
			Asset("ANIM", "anim/coffee_cooked.zip")
		}

local prefabs =
		{
			"coffee",
			"coffee_seeds"
		}    


local function turnoffspeed(inst)
	inst.components.locomotor.groundspeedmultiplier = 1
	inst.components.locomotor.externalspeedmultiplier = 1	 
    end



local function OnEaten(inst, eater)
	eater.components.locomotor.isrunning = true
	eater.components.locomotor.groundspeedmultiplier = 1.83
	eater.components.locomotor.externalspeedmultiplier = 1.83
	    eater:DoTaskInTime(240, turnoffspeed)

end

local function raw(Sim)
        local inst = CreateEntity()
			inst.entity:AddTransform()
			inst.entity:AddAnimState()
			inst.entity:AddNetwork()

		MakeInventoryPhysics(inst)
			inst.AnimState:SetBank("coffee")
			inst.AnimState:SetBuild("coffee")
			inst.AnimState:PlayAnimation("idle")

inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

		inst:AddComponent("edible")  
			inst.components.edible.foodtype = "VEGGIE"
			inst.components.edible.healthvalue = 0
			inst.components.edible.hungervalue = TUNING.CALORIES_TINY
			inst.components.edible.sanityvalue = 0

	MakeHauntableLaunch(inst)

		inst:AddComponent("bait")
		inst:AddComponent("inspectable")
		inst:AddComponent("perishable")
			inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
			inst.components.perishable:StartPerishing()
			inst.components.perishable.onperishreplacement = "spoiled_food"
    
		inst:AddComponent("cookable")
			inst.components.cookable.product = "coffee_cooked"
			
		inst:AddComponent("inventoryitem")
			inst.components.inventoryitem.atlasname = "images/inventoryimages/coffee.xml"

		inst:AddComponent("stackable")
			inst.components.stackable.maxsize = 40

    inst:AddComponent("tradable")
    
			return inst
end

			

local function cooked(Sim)
		local inst = CreateEntity()
			inst.entity:AddTransform()
			inst.entity:AddAnimState()
			inst.entity:AddNetwork()

		MakeInventoryPhysics(inst)
			inst.AnimState:SetBank("coffee_cooked")
			inst.AnimState:SetBuild("coffee_cooked")
			inst.AnimState:PlayAnimation("idle")

inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

		inst:AddComponent("edible")
			inst.components.edible.foodtype = "GOODIES"
			inst.components.edible.healthvalue = 3
			inst.components.edible.hungervalue = TUNING.CALORIES_TINY
			inst.components.edible.sanityvalue = -5
			inst.components.edible:SetOnEatenFn(OnEaten)

	MakeHauntableLaunch(inst)

		inst:AddComponent("inspectable")
		inst:AddComponent("perishable")
			inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
			inst.components.perishable:StartPerishing()
			inst.components.perishable.onperishreplacement = "spoiled_food"

		inst:AddComponent("inventoryitem")
			inst.components.inventoryitem.atlasname = "images/inventoryimages/coffee_cooked.xml"

		inst:AddComponent("stackable")
			inst.components.stackable.maxsize = 40
  
			return inst
end

return Prefab( "common/inventory/coffee", raw, Assets, prefabs),
			Prefab( "common/inventory/coffee_cooked", cooked)