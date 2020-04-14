local prefabs = {"mandrake_planted"}
local tilefns = {}
tilefns.mandrake_planted = function(tile) return (tile == GROUND.GRASS) end

function c_countprefabsonground(prefab, noprint)
	local count = 0
	for k, v in pairs(Ents) do
		local owner = v.components.inventoryitem and v.components.inventoryitem.owner
		if owner == nil then
			if v.prefab == prefab then
				count = count + 1
			end
		end
	end
	if not noprint then
		print("There are ", count, prefab.."s in the world's ground.")
	end
	return count
end

local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

local isnextautumn = false

local function updateWorld(self)
	self.inst:DoTaskInTime(1, function()
		if TheWorld.state.iswinter and not isnextautumn then
			isnextautumn = true
		end
		if TheWorld.state.isspring and not isnextautumn then
			isnextautumn = true
		end
		if TheWorld.state.issummer and not isnextautumn then
			isnextautumn = true
		end
		if TheWorld.state.isautumn and isnextautumn then
			isnextautumn = false
			local coorlist = {}
			for i = -2000, 2000, 4 do
				for j = -2000, 2000, 4 do
					local pt = Vector3(i - 2,0,j - 2)
					local tile = TheWorld.Map:GetTileAtPoint(pt.x, pt.y, pt.z)
					local canspawn = tile ~= GROUND.IMPASSABLE and tile ~= GROUND.INVALID and tile ~= 255
					local tilecheck = tilefns["mandrake_planted"]
					canspawn = canspawn and tilecheck(tile)
					if canspawn then
						pt.x = pt.x + math.random(-2,2)
						pt.z = pt.z + math.random(-2,2)
						table.insert(coorlist, pt)
					end
				end
			end
			for k, v in pairs(prefabs) do
				local min_num = self.minprefs[v]
				local count = c_countprefabsonground(v, true)
				local numtospawn = 4 - count
				if numtospawn > 0 then
					for i = 1, numtospawn, 1 do
						if next(coorlist) ~= nil then
							local n = math.random(1, tablelength(coorlist))
							local b = SpawnPrefab("mandrake_planted")
							b.Transform:SetPosition(coorlist[n]:Get())
							table.remove(coorlist, n)
						end
					end
				end
			end
		end
	end)
end

-- This function waits until the Ents table is initialized
-- Here's the kick: the data is loaded BEFORE we can read the Ents table
-- So first we wait until the Ents table loads
-- After it loads, we check that no data of ours was loaded
-- If minprefs is empty, then we put the minimum numbers
local function updatePrefabs(self)
	local next = next
	if next(Ents) == nil then
		self.inst:DoTaskInTime(0, function() updatePrefabs(self) end)
	else
		if next(self.minprefs) == nil then
			for k, v in pairs(prefabs) do
				local c = c_countprefabsonground(v, true)
				self.minprefs[v] = c
			end
		end
	end
end


local MinSpawner = Class(function(self, inst)
	self.inst = inst
	self.minprefs = {}

	inst:ListenForEvent("ms_cyclecomplete", function() updateWorld(self) end)
	inst:DoTaskInTime(0, function() updatePrefabs(self) end)
end)

function MinSpawner:OnSave()
	local data = {}
	for k, v in pairs(self.minprefs) do
		data[k] = v
	end
	return data
end

function MinSpawner:OnLoad(data)
	if data then
		for k, v in pairs(data) do
			self.minprefs[k] = v
		end
	end
end

return MinSpawner
