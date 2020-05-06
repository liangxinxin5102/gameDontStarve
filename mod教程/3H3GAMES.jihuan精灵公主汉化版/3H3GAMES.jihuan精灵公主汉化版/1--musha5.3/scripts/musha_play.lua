AddStategraphPostInit("wilson", function(sg)
local state = sg.states["play_flute"]
local smallhorn_onenter = state.onenter
	state.onenter = function(inst)
		local bufaction = inst:GetBufferedAction()
		local is_musha_play =
			bufaction
			and bufaction.action == GLOBAL.ACTIONS.PLAY
			and bufaction.invobject
			and bufaction.invobject:HasTag("musha_flute")
	if is_musha_play then
	inst.components.locomotor:Stop()
        	inst.AnimState:PlayAnimation("flute")
          inst.AnimState:OverrideSymbol("pan_flute01", "musha_flute", "pan_flute01")
	            inst.AnimState:Hide("ARM_carry") 
	            inst.AnimState:Show("ARM_normal")
if inst.components.inventory.activeitem and inst.components.inventory.activeitem.components.instrument then
inst.components.inventory:ReturnActiveItem()
       end
	else
	smallhorn_onenter(inst)
	end
	end
	end)
