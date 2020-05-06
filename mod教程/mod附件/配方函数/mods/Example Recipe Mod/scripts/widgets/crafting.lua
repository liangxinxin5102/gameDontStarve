--Modified by WrathOf to workaround a redefinition of the Ingredients class
--that was already defined in the Recipe.lua file for use by the Recipes
--class.  Changed the class used by this file to IngredientUI so it no longer
--conflicts with the other one and allows changes to the recipes during mod
--Game and Sim post init callbacks.
--Updated for Revision 74452 2013-03-12_14-18-42 (A Little Rain Must Fall)
print("Loading crafting override")

require "class"
require "tilebg"
require "tabs"
require "widgets/inventoryslot"


local num_slots = 6
local tab_bg = 
{
    normal = "data/images/tab_normal.tex",
    selected = "data/images/tab_selected.tex",
    highlight = "data/images/tab_highlight.tex",
    overlay = "data/images/tab_researchable.tex",
}

local CraftSlots = Class(Widget, function(self, num, owner)
    Widget._ctor(self, "Crafting")
    
    self.slots = {}
    for k = 1, num do
        local slot = CraftSlot("data/images/craft_slot.tex", owner)
        self.slots[k] = slot
        self:AddChild(slot)
    end

end)

function CraftSlots:Clear()
    for k,v in ipairs(self.slots) do
        v:Clear()
    end
end

function CraftSlots:CloseAll()
    for k,v in ipairs(self.slots) do
        v:Close()
    end
end


--------------------------------------------------------------------------------------------

Crafting = Class(Widget, function(self, crafttabs, owner)
    Widget._ctor(self, "Crafting")
    self.craft_pos = 145
    
    self.crafttabs = crafttabs
	self.owner = owner


    self.bg = self:AddChild(TileBG("data/images/craft_slotbg.tex", "data/images/craft_sep.tex", nil, false))
    self.bg:SetNumTiles(num_slots)
    local w, h = self.bg:GetSize()
    self:SetPosition(w/2 + 30, 0, 0)
    
    --buttons
    self.downbutton = self:AddChild(Button())
    self.downbutton:SetImage("data/images/craft_end_normal.tex")
    local but_w, but_h = self.downbutton:GetSize()

    self.downbutton:SetMouseOverImage("data/images/craft_end_normal_mouseover.tex")
    self.downbutton:SetPosition(0, - self.bg.length/2 - but_h/2,0)
    self.downbutton:SetOnClick(function() self:ScrollUp() end)


    
    self.upbutton = self:AddChild(Button())
    self.upbutton:SetImage("data/images/craft_end_normal.tex")
    self.upbutton:SetMouseOverImage("data/images/craft_end_normal_mouseover.tex")
    self.upbutton:SetScale(Vector3(1, -1, 1))
    self.upbutton:SetPosition(0, self.bg.length/2 + but_h/2,0)
    self.upbutton:SetOnClick(function() self:ScrollDown() end)
    

    --slots
    self.craftslots = CraftSlots(num_slots, self.owner)
    self:AddChild(self.craftslots)
    for k = 1, #self.craftslots.slots do
        self.craftslots.slots[k]:SetPosition( self.bg:GetSlotPos(k) )
    end

    --self.inst:ListenForEvent("mousescrollup", function(inst, data) self:ScrollUp() end, self.owner)
    --self.inst:ListenForEvent("mousescrolldown", function(inst, data) self:ScrollDown() end, self.owner)

    self.idx = 0
    self.scrolldir = true
    self:UpdateRecipes()
    
end)

function Crafting:SetFilter(filter)
    self.filter = filter
    self:UpdateRecipes()
end

function Crafting:Close()
    self:Disable() 
	self:MoveTo(Vector3(self.craft_pos,0,0), Vector3(-64,0,0), .33)
	
	self.craftslots:CloseAll()
end

function Crafting:Open()
	self:Show() 
	self:Enable() 
	self:MoveTo(Vector3(-64,0,0), Vector3(self.craft_pos,0,0), .33)
end

function Crafting:UpdateRecipes()
    self.craftslots:Clear()
    if self.owner.components.builder then
        
        local recipes = GetAllRecipes()
        --local recipes = self.owner.components.builder.recipes
        local offset = 1
        self.valid_recipes = {}
        
        for k,v in pairs(recipes) do
			local knows = self.owner.components.builder:KnowsRecipe(v.name)
            local show = ((not self.filter) or self.filter(v.name)) and (knows or v.level <= self.owner.components.builder.current_tech_level + 1)
            if show then
                table.insert(self.valid_recipes, v)
            end
        end
        table.sort(self.valid_recipes, function(a,b) return a.sortkey < b.sortkey end)
        
        local shown_num = 0
        local num = math.min(num_slots, #self.valid_recipes)
        for k = 1,num do
        
            local recipe_idx = k
            if #self.valid_recipes > num_slots then
                recipe_idx = (self.idx + (k-1) ) % #self.valid_recipes + 1
            end
            
            local recipe = self.valid_recipes[recipe_idx]
            
            if recipe then
				
                local show = (not self.filter) or self.filter(recipe.name) 
                if show then
                    self.craftslots.slots[num_slots - k+1]:SetRecipe( recipe.name )
                    shown_num = shown_num + 1
                end
            end
        end
        
        if shown_num == 0 then
            --self:Disable() 
			--self:MoveTo(Vector3(self.inst.UITransform:GetLocalPosition()), Vector3(-64,0,0), .33)
			self.crafttabs.tabs:DeselectAll()
        end
    end
end

function Crafting:ScrollUp()
	if not IsHUDPaused() then
		self.idx = self.idx + 1
		self:UpdateRecipes()
		
		self.owner.SoundEmitter:PlaySound("dontstarve/HUD/craft_up")
	end
end

function Crafting:ScrollDown()
	if not IsHUDPaused() then
		self.idx = self.idx - 1
		self:UpdateRecipes()
		self.owner.SoundEmitter:PlaySound("dontstarve/HUD/craft_down")
	end
end

--------------------------------------------------------------------------------------------


IngredientUI = Class(Widget, function(self, image, quantity, on_hand, has_enough, name, owner)
    Widget._ctor(self, "IngredientUI")
    
    --self:SetClickable(false)
    
    if has_enough then
        self.bg = self:AddChild(Image("data/images/inv_slot.tex"))
    else
        self.bg = self:AddChild(Image("data/images/resource_needed.tex"))
    end
    
    self:SetTooltip(name)
    
    --self:SetMouseOver(function() owner.HUD:SetHoverText(name) end)
    --self:SetMouseOut(function() owner.HUD:SetHoverText(nil) end)
    
    
    self.ing = self:AddChild(Image(image))
    if quantity then
        self.quant = self:AddChild(Text(SMALLNUMBERFONT, 24))
        self.quant:SetPosition(0,-32, 0)
        self.quant:SetString(string.format("%d/%d", on_hand,quantity))
        if not has_enough then
			self.quant:SetColour(255/255,155/255,155/255,1)
		end
    end
end)

--------------------------------------------------------------------------------------------

local function DoRecipeClick(owner, recipe)
	if recipe and owner and owner.components.builder then
        local knows = owner.components.builder:KnowsRecipe(recipe.name)
        local can_build = owner.components.builder:CanBuild(recipe.name)
        local buffered = owner.components.builder:IsBuildBuffered(recipe.name)
        
        if knows then
			if buffered then
				TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
				--owner.HUD.controls.crafttabs.tabs:DeselectAll()
				if recipe.placer then
					owner.components.playercontroller:StartBuildPlacementMode(recipe, function(pt) return owner.components.builder:CanBuildAtPoint(pt, recipe) end)
				else
					owner.components.builder:MakeRecipe(recipe)
				end
			elseif can_build then
				TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")			
				if recipe.placer then
					--owner.HUD.controls.crafttabs.tabs:DeselectAll()
					owner.components.builder:BufferBuild(recipe.name)
					owner.components.playercontroller:StartBuildPlacementMode(recipe, function(pt) return owner.components.builder:CanBuildAtPoint(pt, recipe) end)
				else
					owner.components.builder:MakeRecipe(recipe)
					return true
				end
			else
				return true
			end
        else
			local tech_level = owner.components.builder.current_tech_level
			
			if can_build and tech_level >= recipe.level then
				owner.SoundEmitter:PlaySound("dontstarve/HUD/research_unlock")
				
				
				local onsuccess = function()
					owner.components.builder:ActivateCurrentResearchMachine()
					owner.components.builder:UnlockRecipe(recipe.name)
				end					
				
				if recipe.placer then
					onsuccess()
					owner.components.builder:BufferBuild(recipe.name)
					owner.components.playercontroller:StartBuildPlacementMode(recipe, function(pt) return owner.components.builder:CanBuildAtPoint(pt, recipe) end)
				else
					owner.components.builder:MakeRecipe(recipe, nil, onsuccess)
				end
			else
				return true
			end
        end
        
	end
end

--------------------------------------------------------------------------------------------

RecipePopup = Class(Widget, function(self, parentslot)
    Widget._ctor(self, "Recipe Popup")
    
    self.parentslot = parentslot
    self.bg = self:AddChild(UIAnim())
    self.bg:GetAnimState():SetBank("crafting_submenu")
    self.bg:GetAnimState():SetBuild("crafting_submenu")
    self.bg:GetAnimState():PlayAnimation("off")
    
    self.bg:SetPosition(32,16,0)
    
    self.name = self:AddChild(Text(UIFONT, 50))
    self.name:SetPosition(320, 160, 0)

    self.desc = self:AddChild(Text(BODYTEXTFONT, 25))
    self.desc:SetPosition(320, -10, 0)
    self.desc:SetRegionSize(64*3+20,70)
    self.desc:EnableWordWrap(true)
    
    self.ing = {}
    
    self.button = self:AddChild(Button())
    self.button:SetImage("data/images/button.tex")
    self.button:SetMouseOverImage("data/images/button_over.tex")
    self.button:SetDisabledImage("data/images/button_disabled.tex")
    self.button:SetScale(.7,.7,.7)
    self.button:SetFont(UIFONT)
    self.button:SetTextSize(50)
    self.button:SetOnClick(function() if not DoRecipeClick(self.owner, self.recipe) then self.owner.HUD.controls.crafttabs:Close() end end)
    
    
    self.recipecost = self:AddChild(Text(NUMBERFONT, 40))
    self.recipecost:SetHAlign(ANCHOR_LEFT)
    self.recipecost:SetRegionSize(80,50)
    self.recipecost:SetPosition(420,-115,0)--(375, -115, 0)
    self.recipecost:SetColour(255/255, 234/255,0/255, 1)
    
    
    
    self.teaser = self:AddChild(Text(BODYTEXTFONT, 25))
    self.teaser:SetPosition(320, -115, 0)
    self.teaser:SetRegionSize(64*3+20,70)
    self.teaser:EnableWordWrap(true)
    self.teaser:Hide()
end)


function RecipePopup:SetRecipe(recipe, owner)
    --if recipe ~= self.recipe then
        self.recipe = recipe
        self.owner = owner
        
        local knows = owner.components.builder:KnowsRecipe(recipe.name)
        local buffered = owner.components.builder:IsBuildBuffered(recipe.name)
        local can_build = owner.components.builder:CanBuild(recipe.name) or buffered
        local tech_level = owner.components.builder.current_tech_level
        local should_hint = not knows and tech_level < recipe.level 
        
        self.bg:GetAnimState():PlayAnimation("off")
        
        if should_hint then
			self.recipecost:Hide()
			self.button:Hide()
			
			local hint_text = 
			{
				[0] = STRINGS.UI.CRAFTING.NEEDSCIENCEMACHINE,
				[1] = STRINGS.UI.CRAFTING.NEEDALCHEMYENGINE,
                [2] = STRINGS.UI.CRAFTING.NEEDSHADOWMANIPULATOR,
				[3] = STRINGS.UI.CRAFTING.CANTRESEARCH,
			}
			local str = hint_text[math.max(0, tech_level - owner.components.builder.bonus_tech_level)] or ""
			self.teaser:SetString(str)
			self.teaser:Show()
        elseif knows then
			self.teaser:Hide()
			self.recipecost:Hide()
			self.button:Show()
			self.button:SetPosition(320, -115, 0)
			self.button:SetScale(1,1,1)
			
			self.button:SetText(buffered and STRINGS.UI.CRAFTING.PLACE or STRINGS.UI.CRAFTING.BUILD)
			if can_build then
				self.button:Enable()
			else
				self.button:Disable()
			end
		else
		
			self.teaser:Hide()
			self.recipecost:Hide()
			self.button:Show()
			self.button:SetPosition(320, -115, 0)
			self.button:SetScale(1,1,1)
			
			self.button:SetText(STRINGS.UI.CRAFTING.PROTOTYPE)
			if can_build then
				self.button:Enable()
			else
				self.button:Disable()
			end
			
		end
		
	
        
        self.name:SetString(self.recipe.descname)
        self.desc:SetString(self.recipe.description)
        
        for k,v in pairs(self.ing) do
            v:Kill()
        end
        self.ing = {}

        local center = 330
        local num = 0
        for k,v in pairs(recipe.ingredients) do num = num + 1 end
        local w = 64
        local div = 10
        
        local offset = center
        if num > 1 then 
            offset = offset - (w/2 + div)*(num-1)
        end
        
        for k,v in pairs(recipe.ingredients) do
        
            local has, num_found = owner.components.inventory:Has(v.type, v.amount)
            
            local im = "data/inventoryimages/"..v.type..".tex"
            local ing = self:AddChild(IngredientUI(im, v.amount, num_found, has, STRINGS.NAMES[string.upper(v.type)], owner))
            ing:SetPosition(Vector3(offset, 80, 0))
            offset = offset + (w+ div)
            self.ing[k] = ing
        end

    --end
end

--------------------------------------------------------------------------------------------


CraftSlot = Class(Widget, function(self, bgim, owner)
    Widget._ctor(self, "Craftslot")
    self.owner = owner
	
    self.bgimage = self:AddChild(Image(bgim))
    
    self:SetMouseOver(function()
		self:Open()
    end)

    self:SetMouseOut(function()
        self:Close()
    end)
    
    self:SetLeftMouseUp( function()
		if not DoRecipeClick(self.owner, self.recipe) then
			owner.HUD.controls.crafttabs:Close()
		end
    end)
    
	self.tile = self:AddChild(RecipeTile(nil))
	self.fgimage = self:AddChild(Image("data/images/craft_slot_locked.tex"))
    self.fgimage:Hide()
    
	self.recipepopup = self:AddChild(RecipePopup(self))
	self.recipepopup:SetPosition(0,-20,0)
	self.recipepopup:Hide()
end)


function CraftSlot:Clear()
    self.recipename = nil
    self.recipe = nil
    self.canbuild = false
    
    if self.tile then
        self.tile:Hide()
    end
	
	self.fgimage:Hide()
	--self:HideRecipe()
end


function CraftSlot:Open()
	self.open = true
    self:ShowRecipe()
    self.owner.SoundEmitter:PlaySound("dontstarve/HUD/click_mouseover")
end

function CraftSlot:Close()
    self.open = false
    self:HideRecipe()
end

function CraftSlot:ShowRecipe()
    if self.recipe then
		self.recipepopup:Show()
        self.recipepopup:SetRecipe(self.recipe, self.owner)
    end
end

function CraftSlot:HideRecipe()
	self.recipepopup:Hide()
end

function CraftSlot:SetRecipe(recipename)
	self:Show()
	local canbuild = self.owner.components.builder:CanBuild(recipename)
	local knows = self.owner.components.builder:KnowsRecipe(recipename)
	local buffered = self.owner.components.builder:IsBuildBuffered(recipename)

	--self:HideRecipe()
	
    local do_pulse = self.recipename == recipename and not self.canbuild and canbuild
    self.recipename = recipename
    self.recipe = GetRecipe(recipename)
    if self.recipe then
        self.canbuild = canbuild
		self.tile:SetRecipe(self.recipe)
        self.tile:Show()

		if self.fgimage then
			if knows then
				self.fgimage:Hide()
			else
				local right_level = self.owner.components.builder.current_tech_level >= self.recipe.level
				
				local show_highlight = false
				
				show_highlight = canbuild and right_level
				
				if not right_level then
					self.fgimage:SetTexture("data/images/craft_slot_locked_nextlevel.tex")
				elseif show_highlight then
					self.fgimage:SetTexture("data/images/craft_slot_locked_highlight.tex")
				else
					self.fgimage:SetTexture("data/images/craft_slot_locked.tex")
				end
				
				self.fgimage:Show()
			end
		end

        self.tile:SetCanBuild((buffered or canbuild )and knows)
        if self.recipepopup then
            self.recipepopup:SetRecipe(self.recipe, self.owner)
        end
        
        --self:HideRecipe()
    end
end

--------------------------------------------------------------------------------------------

RecipeTile = Class(Widget, function(self, recipe)
    Widget._ctor(self, "RecipeTile")
	self.img = self:AddChild(Image())
	self:SetClickable(false)
	if recipe then
		self.recipe = recipe
		self.img:SetTexture(recipe.image)
		--self:MakeNonClickable()
	end
end)

function RecipeTile:SetRecipe(recipe)
    self.recipe = recipe
    self.img:SetTexture(recipe.image)
end

function RecipeTile:SetCanBuild(canbuild)
    if canbuild then
        self.img:SetTint(1,1,1,1)
    else
        self.img:SetTint(0,0,0,1)
    end
end


--------------------------------------------------------------------------------------------


CraftTabs = Class(Widget, function(self, owner)
    
    Widget._ctor(self, "CraftTabs")
    self.owner = GetPlayer()    
	self.owner = owner

    self:SetHAnchor(ANCHOR_LEFT)
    self:SetVAnchor(ANCHOR_MIDDLE)
    
    
    local scale = .75
    self:SetPosition(0,0,0)
    self:SetScale(scale,scale,scale)
    
    
    self.crafting = self:AddChild(Crafting(self, self.owner))
    self.crafting:Hide()
    self.bg = self:AddChild(Image("data/images/craft_bg.tex"))
    
    
    self.tabs = self:AddChild(TabGroup())
    self.tabs.spacing = 75
    self.tabs:SetPosition(-16,0,0)

    self.tabs.onopen = function() self.owner.SoundEmitter:PlaySound("dontstarve/HUD/craft_open") end
    self.tabs.onchange = function() self.owner.SoundEmitter:PlaySound("dontstarve/HUD/craft_open") end
    self.tabs.onclose = function() self.owner.SoundEmitter:PlaySound("dontstarve/HUD/craft_close") end
    self.tabs.onhighlight = function() self.owner.SoundEmitter:PlaySound("dontstarve/HUD/recipe_ready") return .2 end
    self.tabs.onoverlay = function() self.owner.SoundEmitter:PlaySound("dontstarve/HUD/research_available") return .2 end
    
    local tabnames = {}
    for k,v in pairs(RECIPETABS) do
        table.insert(tabnames, v)
    end
    table.sort(tabnames, function(a,b) return a.sort < b.sort end)
    
    
    self.tabbyfilter = {}
    for k,v in ipairs(tabnames) do
        local tab = self.tabs:AddTab(v.str, v.icon, tab_bg.normal, tab_bg.selected, tab_bg.highlight, tab_bg.overlay,
            function() --select fn
                self.crafting:SetFilter( 
                    function(recipe)
                        local rec = GetRecipe(recipe)
                        
                        return rec and rec.tab == v
                    end)
                self.crafting:Open() 
                
            end, 
            function() --deselect fn
                self.crafting:Close()
            end)
        self.tabbyfilter[v] = tab
        
    end
    
    self.inst:ListenForEvent("techlevelchange", function(inst, data) self:UpdateRecipes() end, self.owner)
    self.inst:ListenForEvent("itemget", function(inst, data) self:UpdateRecipes() end, self.owner)
    self.inst:ListenForEvent("itemlose", function(inst, data) self:UpdateRecipes() end, self.owner)
    self.inst:ListenForEvent("stacksizechange", function(inst, data) self:UpdateRecipes() end, self.owner)
    self.inst:ListenForEvent("unlockrecipe", function(inst, data) self:UpdateRecipes() end, self.owner)
end)

function CraftTabs:Close()
	self.tabs:DeselectAll()
end

function CraftTabs:Update()
	if self.needtoupdate then
		self:DoUpdateRecipes()
	end
	
end

function CraftTabs:UpdateRecipes()
	self.needtoupdate = true
end

function CraftTabs:DoUpdateRecipes()
	if self.needtoupdate then
		self.needtoupdate = false	
		local tabs_to_highlight = {}
		local tabs_to_overlay = {}
		local valid_tabs = {}
	    
		for k,v in pairs(self.tabbyfilter) do
			tabs_to_highlight[v] = 0
			tabs_to_overlay[v] = 0
			valid_tabs[v] = false
		end
	    
		if self.owner.components.builder then
			local current_research_level = self.owner.components.builder.current_tech_level or 0
			
			
			local recipes = GetAllRecipes()
			for k,rec in pairs(recipes) do
				
				
				local tab = self.tabbyfilter[rec.tab]
				local has_researched = self.owner.components.builder:KnowsRecipe(rec.name)
				
				local can_see = has_researched or rec.level <= current_research_level
				local can_build = self.owner.components.builder:CanBuild(rec.name)
				local can_research = false
				
				can_research = not has_researched and can_build and rec.level <= current_research_level
	            
	            valid_tabs[tab] = valid_tabs[tab] or can_see
	            
				if can_build and has_researched then
					if tab then
						tabs_to_highlight[tab] = 1 + (tabs_to_highlight[tab] or 0)
					end
				end
	            
				if can_research then
					if tab then
						tabs_to_overlay[tab] = 1 + (tabs_to_overlay[tab] or 0)
					end
				end
				
			end
		end

		local to_select = nil
		local current_open = nil

		
		for k,v in pairs(valid_tabs) do
			if v then
				self.tabs:ShowTab(k)
			else
				self.tabs:HideTab(k)
			end
		end
		

		for k,v in pairs(tabs_to_highlight) do    
			if v > 0 then
				k:Highlight(v)
			else
				k:UnHighlight()
			end
	        
		end
	    
		for k,v in pairs(tabs_to_overlay) do    
			if v > 0 then
				k:Overlay()
			else
				k:HideOverlay()
			end
		end    
	    
		if self.crafting and self.crafting.shown then
			self.crafting:UpdateRecipes()
		end
	end
end
