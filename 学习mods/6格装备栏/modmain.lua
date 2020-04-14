local require = GLOBAL.require
local TheInput = GLOBAL.TheInput
local ThePlayer = GLOBAL.ThePlayer
local IsServer = GLOBAL.TheNet:GetIsServer()
local Inv = require "widgets/inventorybar"

GLOBAL.TUNING.SLOTS_COUNT = GetModConfigData("slots_count")
GLOBAL.TUNING.COMPASS_STATE = GetModConfigData("compass_state")

if TUNING.COMPASS_STATE == 1 then
Assets =
{
    Asset("IMAGE", "images/back.tex"),
    Asset("ATLAS", "images/back.xml"),
    Asset("IMAGE", "images/neck.tex"),
    Asset("ATLAS", "images/neck.xml"),
	Asset("IMAGE", "images/waist.tex"),
	Asset("ATLAS", "images/waist.xml"),
}
else
Assets =
{
    Asset("IMAGE", "images/back.tex"),
    Asset("ATLAS", "images/back.xml"),
    Asset("IMAGE", "images/neck.tex"),
    Asset("ATLAS", "images/neck.xml"),
}
end
-- for key,value in pairs(GLOBAL.EQUIPSLOTS) do print('4r',key,value) end

if TUNING.COMPASS_STATE == 1 then
GLOBAL.EQUIPSLOTS=
{
    HANDS = "hands",
    HEAD = "head",
    BODY = "body",
    BACK = "back",
    NECK = "neck",
	WAIST = "waist"
}
else
GLOBAL.EQUIPSLOTS=
{
    HANDS = "hands",
    HEAD = "head",
    BODY = "body",
    BACK = "back",
    NECK = "neck",
}
end

GLOBAL.EQUIPSLOT_IDS = {}
local slot = 0
for k, v in pairs(GLOBAL.EQUIPSLOTS) do
    slot = slot + 1
    GLOBAL.EQUIPSLOT_IDS[v] = slot
end
slot = nil


if TUNING.COMPASS_STATE == 1 then
	if TUNING.SLOTS_COUNT == 1.25 then
		TUNING.SLOTS_COUNT = 1.33
	elseif TUNING.SLOTS_COUNT == 1.33 then
		TUNING.SLOTS_COUNT = 1.4
	elseif TUNING.SLOTS_COUNT == 1.4 then
		TUNING.SLOTS_COUNT = 1.45
	end
end

AddComponentPostInit("resurrectable", function(self, inst)
    local original_FindClosestResurrector = self.FindClosestResurrector
    local original_CanResurrect = self.CanResurrect
    local original_DoResurrect = self.DoResurrect

    self.FindClosestResurrector = function(self)
        if IsServer and self.inst.components.inventory then
            local item = self.inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.NECK)
            if item and item.prefab == "amulet" then
                return item
            end
        end
        original_FindClosestResurrector(self)
    end

    self.CanResurrect = function(self)
        if IsServer and self.inst.components.inventory then
            local item = self.inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.NECK)
            if item and item.prefab == "amulet" then
                return true
            end
        end
        original_CanResurrect(self)
    end

    self.DoResurrect = function(self)
        self.inst:PushEvent("resurrect")
        if IsServer and self.inst.components.inventory then
            local item = self.inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.NECK)
            if item and item.prefab == "amulet" then
                self.inst.sg:GoToState("amulet_rebirth")
                return true
            end
        end
        original_DoResurrect(self)
    end
end)

AddComponentPostInit("inventory", function(self, inst)
    local original_Equip = self.Equip
    self.Equip = function(self, item, old_to_active)
        if original_Equip(self, item, old_to_active) and item and item.components and item.components.equippable then
            local eslot = item.components.equippable.equipslot
            if self.equipslots[eslot] ~= item then
                if eslot == GLOBAL.EQUIPSLOTS.BACK and item.components.container ~= nil then
                    self.inst:PushEvent("setoverflow", { overflow = item })
                end
            end
            return true
        else
            return
        end
    end

    self.GetOverflowContainer = function()
        if self.ignoreoverflow then
            return
        end
        local item = self:GetEquippedItem(GLOBAL.EQUIPSLOTS.BACK)
        return item ~= nil and item.components.container or nil
    end
end)

AddGlobalClassPostConstruct("widgets/inventorybar", "Inv", function()
    local Inv_Refresh_base = Inv.Refresh or function() return "" end
    local Inv_Rebuild_base = Inv.Rebuild or function() return "" end

    function Inv:LoadExtraSlots(self)
        self.bg:SetScale(TUNING.SLOTS_COUNT + 0.09,1,TUNING.SLOTS_COUNT)
        self.bgcover:SetScale(TUNING.SLOTS_COUNT + 0.09,1,TUNING.SLOTS_COUNT)

        if self.addextraslots == nil then
            self.addextraslots = 1

            self:AddEquipSlot(GLOBAL.EQUIPSLOTS.BACK, "images/back.xml", "back.tex")
            self:AddEquipSlot(GLOBAL.EQUIPSLOTS.NECK, "images/neck.xml", "neck.tex")
			
			if TUNING.COMPASS_STATE == 1 then
				self:AddEquipSlot(GLOBAL.EQUIPSLOTS.WAIST, "images/waist.xml", "waist.tex")
			end
        -- else
            -- GLOBAL.GetPlayer().HUD.controls.stickyrecipepopup:Refresh()
        end
    end

    function Inv:Refresh()
        Inv_Refresh_base(self)
        Inv:LoadExtraSlots(self)
    end

    function Inv:Rebuild()
        Inv_Rebuild_base(self)
		
		if self.inspectcontrol ~= nil then
            self.inspectcontrol:Kill()
            self.inspectcontrol = nil
        end
		
		Inv:LoadExtraSlots(self)
		
		local W = 68
		local SEP = 12
		local YSEP = 8
		local INTERSEP = 28
		
		local TEMPLATES = require "widgets/templates"
		local inventory = self.owner.replica.inventory
		local num_slots = inventory:GetNumSlots()
		local num_equip = #self.equipslotinfo
		local num_buttons = self.controller_build and 0 or 1
		local num_slotintersep = math.ceil(num_slots / 5)
		local num_equipintersep = num_buttons > 0 and 1 or 0
		local total_w = (num_slots + num_equip + num_buttons) * W + (num_slots + num_equip + num_buttons - num_slotintersep - num_equipintersep - 1) * SEP + (num_slotintersep + num_equipintersep) * INTERSEP
		
		local image_name = "self_inspect_"..self.owner.prefab..".tex" 
		local atlas_name = "images/hud.xml"
		if GLOBAL.softresolvefilepath("images/avatars/self_inspect_"..self.owner.prefab..".xml") ~= nil then
			atlas_name = "images/avatars/self_inspect_"..self.owner.prefab..".xml"
		end

		if not self.controller_build then
			self.inspectcontrol = self.root:AddChild(TEMPLATES.IconButton(atlas_name, image_name, GLOBAL.STRINGS.UI.HUD.INSPECT_SELF, false, false, function() self.owner.HUD:InspectSelf() end, {size = 40}, "self_inspect_mod.tex"))
			self.inspectcontrol.icon:SetScale(.7)
			self.inspectcontrol.icon:SetPosition(-4, 6)
			self.inspectcontrol:SetScale(1.25)
			self.inspectcontrol:SetPosition((total_w - W) * .5 + 3, -6, 0)
		else
			if self.inspectcontrol ~= nil then
				self.inspectcontrol:Kill()
				self.inspectcontrol = nil
			end
		end
    end
end)

AddPrefabPostInit("inventory_classified", function(inst)
    function GetOverflowContainer(inst)
        local item = inst.GetEquippedItem(inst, GLOBAL.EQUIPSLOTS.BACK)
        return item ~= nil and item.replica.container or nil
    end

    function Count(item)
        return item.replica.stackable ~= nil and item.replica.stackable:StackSize() or 1
    end

    function Has(inst, prefab, amount)
        local count =
            inst._activeitem ~= nil and
            inst._activeitem.prefab == prefab and
            Count(inst._activeitem) or 0

        if inst._itemspreview ~= nil then
            for i, v in ipairs(inst._items) do
                local item = inst._itemspreview[i]
                if item ~= nil and item.prefab == prefab then
                    count = count + Count(item)
                end
            end
        else
            for i, v in ipairs(inst._items) do
                local item = v:value()
                if item ~= nil and item ~= inst._activeitem and item.prefab == prefab then
                    count = count + Count(item)
                end
            end
        end

        local overflow = GetOverflowContainer(inst)
        if overflow ~= nil then
            local overflowhas, overflowcount = overflow:Has(prefab, amount)
            count = count + overflowcount
        end

        return count >= amount, count
    end

    if not IsServer then
        inst.GetOverflowContainer = GetOverflowContainer
        inst.Has = Has
        -- inst.UseItemFromInvTile = UseItemFromInvTile
        -- inst.ReceiveItem = ReceiveItem
        -- inst.RemoveIngredients = RemoveIngredients
    end
end)

AddStategraphPostInit("wilson", function(self)
    for key,value in pairs(self.states) do
        if value.name == 'amulet_rebirth' then
            local original_amulet_rebirth_onexit = self.states[key].onexit


            self.states[key].onexit = function(inst)
                local item = inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.NECK)
                if item and item.prefab == "amulet" then
                    item = inst.components.inventory:RemoveItem(item)
                    if item then
                        item:Remove()
                        item.persists = false
                    end
                end
                original_amulet_rebirth_onexit(inst)
            end
        end
    end
end)

function backpackpostinit(inst)
    if IsServer then
        inst.components.equippable.equipslot = GLOBAL.EQUIPSLOTS.BACK or GLOBAL.EQUIPSLOTS.BODY
    end
end

function amuletpostinit(inst)
    if IsServer then
        inst.components.equippable.equipslot = GLOBAL.EQUIPSLOTS.NECK or GLOBAL.EQUIPSLOTS.BODY
    end
end

if TUNING.COMPASS_STATE == 1 then
	function compasspostinit(inst)
		if IsServer then
			inst.components.equippable.equipslot = GLOBAL.EQUIPSLOTS.WAIST or GLOBAL.EQUIPSLOTS.HANDS
		end
	end
end


AddPrefabPostInit("amulet", amuletpostinit)
AddPrefabPostInit("blueamulet", amuletpostinit)
AddPrefabPostInit("purpleamulet", amuletpostinit)
AddPrefabPostInit("orangeamulet", amuletpostinit)
AddPrefabPostInit("greenamulet", amuletpostinit)
AddPrefabPostInit("yellowamulet", amuletpostinit)

AddPrefabPostInit("backpack", backpackpostinit)
AddPrefabPostInit("krampus_sack", backpackpostinit)
AddPrefabPostInit("piggyback", backpackpostinit)
AddPrefabPostInit("icepack", backpackpostinit)

if TUNING.COMPASS_STATE == 1 then
	AddPrefabPostInit("compass", compasspostinit)
end