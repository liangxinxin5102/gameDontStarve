local assets=
{
	Asset("ANIM", "anim/mushasword.zip"),
	Asset("ANIM", "anim/swap_mushasword.zip"),
    	Asset("ATLAS", "images/inventoryimages/mushasword.xml"),
	Asset("IMAGE", "images/inventoryimages/mushasword.tex"),

}

local framechance = 0.4

local function onattack_FRAME(inst, attacker, target)

    if target.components.burnable and target.sg and not target.sg:HasStateTag("frozen") and not target:HasTag("wall") and not target:HasTag("structure") and target.sg.sg.states.hit and math.random() < framechance then
            target.sg:GoToState("hit")
        target.components.burnable:Ignite()
    end
    if target.components.burnable and target.components.burnable:IsBurning() then
        target.components.burnable:Extinguish()
    end
    if target.components.combat then
        target.components.combat:SuggestTarget(attacker)
    end
end

local function onfinished(inst)
    inst:Remove()
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword", "swap_nightmaresword")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
end


local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("nightmaresword")
    inst.AnimState:SetBuild("mushasword")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetMultColour(1, 1, 1, 0.6)
    
  --  inst:AddTag("shadow")
    inst:AddTag("sharp")
    
    inst:AddComponent("weapon")
   -- inst.components.weapon:SetDamage(TUNING.HAMBAT_DAMAGE)
    inst.components.weapon:SetDamage(50)

      inst.components.weapon:SetOnAttack(onattack_FRAME)

    -------
    
    inst:AddComponent("finiteuses")
   -- inst.components.finiteuses:SetMaxUses(TUNING.NIGHTSWORD_USES)
 --   inst.components.finiteuses:SetUses(TUNING.NIGHTSWORD_USES)
        inst.components.finiteuses:SetMaxUses(400)
    inst.components.finiteuses:SetUses(400)

    inst.components.finiteuses:SetOnFinished( onfinished )

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    	inst.components.inventoryitem.atlasname = "images/inventoryimages/mushasword.xml"
     inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "mushasword.tex" )

        inst.entity:AddLight()
	inst.Light:SetRadius(.3)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(250/255,65/255,65/255)
	inst.Light:Enable(true)

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
--    inst.components.equippable.dapperness = TUNING.CRAZINESS_MED

    return inst
end

return Prefab( "common/inventory/mushasword", fn, assets) 
