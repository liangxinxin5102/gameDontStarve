local function SetNumberSign(inst)
	inst.sign = inst.isheal:value() and 1 or -1
end

local function CreateDamageIndicator(inst)
    SetNumberSign(inst)
	local amount = inst.sign * (inst.indicator:value() or 0)

	local label = inst.entity:AddLabel()
	label:SetFont(NUMBERFONT)
	label:SetFontSize(TUNING.LABEL_FONT_SIZE)
	label:SetWorldOffset(0, TUNING.LABEL_Y_START, 0)

	local color
	if amount < 0 then
		color = TUNING.HEALTH_LOSE_COLOR
	else
		color = TUNING.HEALTH_GAIN_COLOR
	end

	label:SetColour(color.r, color.g, color.b)

	local dp_no = "%d";
	local dp_yes = "%.1f";

	local format = dp_no

	if TUNING.SHOW_DECIMAL_POINTS == "all" then
		format = dp_yes
	end

	if math.abs(amount) < 1.0 and TUNING.SHOW_DECIMAL_POINTS == "low" then
		format = dp_yes
	end



	label:SetText(string.format(format, amount))
	--label:SetText( ("%d.1f"):format(amount) )  -- wanna have .x ?

	label:Enable(true)

	inst:StartThread(function()
		local label = inst.Label

		local t = 0
		local t_max = TUNING.LABEL_TIME
		local dt = TUNING.LABEL_TIME_DELTA

		-- waving upon mode ------------------
		local y = TUNING.LABEL_Y_START
		local dy = TUNING.LABEL_Y_START_VELO
		local ddy = 0.0

		local side = (math.random() * (TUNING.LABEL_MAX_AMPLITUDE_X - TUNING.LABEL_MIN_AMPLITUDE_X) + TUNING.LABEL_MIN_AMPLITUDE_X) * (math.random() >= 0.5 and -1 or 1)
		local dside = 0.0
		local ddside = 0.0
		-------------------------------------

		if TUNING.DISPLAY_MODE == 'straight' then
			side = side * 0.00
		end


		if TUNING.DISPLAY_MODE == 'bouncy' then
			-- bounce around mode ---------------
			y = TUNING.LABEL_Y_START
			dy = 0.05
			ddy = 0.0

			side = 0.0
			dside = 0.1
			if math.random() > 0.5 then
				dside = -dside
			end
			ddside = 0.0
			-----------------------------
		end

		while inst:IsValid() and t < t_max do
			if TUNING.DISPLAY_MODE == 'waving' or TUNING.DISPLAY_MODE == 'straight' then
				-- waving upon mode ------------------
				ddy = TUNING.LIFT_ACC * (math.random() * 0.5 + 0.5)
				dy = dy + ddy
				y = y + dy

				ddside = -side * math.random() * TUNING.SIDE_WAVE_RND
				dside = dside + ddside
				side = side + dside
				-------------------------------------
			end

			if TUNING.DISPLAY_MODE == 'bouncy' then
				-- bounce around mode ---------------
				ddy = -TUNING.GRAVITY
				dy = dy + ddy
				y = y + dy
				if y < 0 then
					y = -y
					dy = -dy * TUNING.FRICTION_PRESERVE
				end

				ddside = 0
				dside = dside + ddside
				side = side + dside
				-------------------------------------
			end

			local headingtarget = 45 --[[TheCamera.headingtarget]] % 180
			if headingtarget == 0 then
				label:SetWorldOffset(0, y, side)  		-- from 3d plane x = 0
			elseif headingtarget == 45 then
				label:SetWorldOffset(side, y, -side)	-- from 3d plane x + z = 0
			elseif headingtarget == 90 then
				label:SetWorldOffset(side, y, 0)		-- from 3d plane z = 0
			elseif headingtarget == 135 then
				label:SetWorldOffset(side, y, side)		-- from 3d plane z - x = 0
			end
			t = t + dt
			label:SetFontSize( TUNING.LABEL_FONT_SIZE * math.sqrt(1 - t / t_max))
			Sleep(dt)
		end

		if TheWorld.ismastersim then
			inst:Remove()
		end
	end)
end


local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddNetwork()

	inst.sign = -1

	inst.isheal = net_bool(inst.GUID, "dmgind.sign", "signdirty")
	inst:ListenForEvent("signdirty", SetNumberSign)

	inst.indicator = net_ushortint(inst.GUID, "dmgind.number", "numberdirty")
	inst:ListenForEvent("numberdirty", CreateDamageIndicator)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst.persists = false

	return inst
end

return Prefab("dmgind", fn)
