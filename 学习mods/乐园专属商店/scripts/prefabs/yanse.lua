local Color_N = {
	{ 230/255,  26/255, 230/255},
	{  94/255, 241/255,  14/255},
	{ 207/255,  27/255,  27/255},
	{   6/255, 242/255, 255/255},
	{ 255/255, 236/255,   6/255},
}


local function Text_K(inst)

	local YuYan = inst.YuYan:value() or ""
	local Yzhou = inst.Yzhou:value() or 2
	local DaXiao = inst.DaXiao:value() or 30
	local RGB = inst.Color_E or Color_N[inst.Color_C:value() or 3]

	local label = inst.entity:AddLabel()
	label:SetFont(DEFAULTFONT)
	label:SetFontSize(DaXiao)
	label:SetWorldOffset(0, Yzhou, 0)
	label:SetColour(RGB[1],RGB[2],RGB[3])
	label:SetText(YuYan)
	label:Enable(true)

	inst:StartThread(function()
		local label = inst.Label

		local t = 0
		local t_max = 1
		local dt = 0.01

		while inst:IsValid() and t < t_max do
			label:SetFontSize(DaXiao - DaXiao/2 * t)
			label:SetWorldOffset(0, Yzhou + (5 * t), 0)
			t = t + dt
			Sleep(dt)
		end
	end)
end

local function Text_A(inst)

	local YuYan = inst.YuYan_A:value() or ""
	local Yzhou = inst.Yzhou:value() or 2
	local DaXiao = inst.DaXiao:value() or 40
	local RGB = inst.Color_E or Color_N[inst.Color_C:value() or 3]

	if inst._labei == nil then
	inst._labei = inst.entity:AddLabel()
	end
	inst._labei:SetFont(DEFAULTFONT)
	inst._labei:SetFontSize(DaXiao)
	inst._labei:SetWorldOffset(0, Yzhou, 0)
	inst._labei:SetColour(RGB[1],RGB[2],RGB[3])
	inst._labei:SetText(YuYan)
	inst._labei:Enable(true)
end

local function Text_color(inst)
	local e = {}
	local c = inst.Color_D:value()
	if c[1] and c[2] and c[3] then
		e[1] = c[1]/255
		e[2] = c[2]/255
		e[3] = c[3]/255
	else
		e  = {1,1,1}
	end
	inst.Color_E = e
end

local function SetText(inst,str,gaodu,daxiao,yanse,sf)
	if inst and str and type(str) == "string" then
		local G_ = gaodu or 2
		local D_ = daxiao or 40
		local Y_ = yanse or 3
		inst.Yzhou:set(G_)
		inst.DaXiao:set(D_)
		if type(Y_) == "table" then
			inst.Color_D:set(Y_)
		else
			inst.Color_C:set(Y_)
		end
		if sf then
			inst.YuYan_A:set(str)
			if inst._Time then
				inst._Time:Cancel()
				inst._Time = nil
			end
		else
			inst.YuYan:set(str)
		end
	end
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddNetwork()
	
	inst.Color_E = nil
	inst._labei = nil
	
	inst.Yzhou = net_float(inst.GUID, "Z_T.Yzhou", "Yzhou_N")
	inst.DaXiao = net_byte(inst.GUID, "Z_T.DaXiao", "DaXiao_N")
	inst.Color_C = net_smallbyte(inst.GUID, "Z_T.Color_C", "Color_C")
	inst.Color_D = net_bytearray(inst.GUID, "Z_T.Color_D", "Color_D")
	inst:ListenForEvent("Color_D", Text_color)
	inst.YuYan = net_string(inst.GUID, "Z_T.YuYan", "YuYan_N")
	inst:ListenForEvent("YuYan_N", Text_K)

	inst.YuYan_A = net_string(inst.GUID, "Z_T.YuYan_A", "YuYan_A")
	inst:ListenForEvent("YuYan_A", Text_A)
	
	inst.entity:SetPristine()

	if TheNet:IsDedicated() or TheNet:GetIsServer() then
		inst.Stext = SetText
		inst._Time = inst:DoTaskInTime(10, function() inst:Remove() end)
		inst.persists = false
	end

	return inst
end

return Prefab("yanse", fn)
