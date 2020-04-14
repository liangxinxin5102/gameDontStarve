local _G = GLOBAL
local TheNet = _G.TheNet
if not (TheNet and TheNet:GetIsServer()) then return end
local STRINGS = _G.STRINGS

local ignoring_admin = GetModConfigData("MOD_RESTART_IGNORING_ADMIN")
local allow_restart = GetModConfigData("MOD_RESTART_ALLOW_RESTART")
local allow_resurrect = GetModConfigData("MOD_RESTART_ALLOW_RESURRECT")
local allow_kill = GetModConfigData("MOD_RESTART_ALLOW_KILL")
local cd_restart = GetModConfigData("MOD_RESTART_CD_RESTART") * 60
local cd_resurrect = GetModConfigData("MOD_RESTART_CD_RESURRECT") * 60
local cd_kill = GetModConfigData("MOD_RESTART_CD_KILL") * 60
local trigger_mode = GetModConfigData("MOD_RESTART_TRIGGER_MODE")
local force_drop_mode = GetModConfigData("MOD_RESTART_FORCE_DROP_MODE")
local restart_welcome_tips = GetModConfigData("MOD_RESTART_WELCOME_TIPS")
local restart_welcome_tips_time = GetModConfigData("MOD_RESTART_WELCOME_TIPS_TIME")

local MY_STRINGS = {
	welcome_msg = {
		"按Y(公聊)或者U(私聊)输入指令:",
		"按Y(公聊)输入指令:",
		"按U(私聊)输入指令:",
	},
	allow_msg = {
		" #重生/#restart (冷却:%d 秒,重生换角色)",
		" ##重生/#restart_d (冷却:%d 秒,重生并掉落物品)",
		" #复活/#resurrect (冷却:%d 秒,角色复活)",
		" #自杀/#kill  (冷却:%d 秒,角色自杀)",
	},
	force_drop_msg = {
		"",
		"当前重生强制掉落道具",
		"当前重生强制不掉落道具",
	},
	warning = "%s CD:%d 秒",
	announce = "重新开始!",
	restart = "重生",
	resurrect = "复活",
	kill = "自杀",
}

local MSG_CHOOSE = {
	["#重生"] = 1,
	["##重生"] = 2,
	["#复活"] = 3,
	["#自杀"] = 4,
	["#restart"] = 1,
	["#restart_d"] = 2,
	["#resurrect"] = 3,
	["#kill"] = 4,
}

local welcome_tips = MY_STRINGS.welcome_msg[1]

do
	local support_languages = { chs = true, cht = true, zh_CN = "chs", TW = "cht", }
	local steam_support_languages = { schinese = "chs", tchinese = "cht", }

	AddPrefabPostInit("world",function(inst)
		local steamlang = TheNet:GetLanguageCode() or nil
		if steamlang and steam_support_languages[steamlang] then
			print("<Restart> Get your language from steam!")
			modimport("restart_"..steam_support_languages[steamlang]..".lua")
		else
			local lang = _G.LanguageTranslator.defaultlang or nil
			if lang ~= nil and support_languages[lang] ~= nil then
				if support_languages[lang] ~= true then
					lang = support_languages[lang]
				end
				print("<Restart> Get your language from language mod!")
				modimport("restart_"..lang..".lua")
			end
		end

		if MY_STRINGS_OVERRIDE ~= nil then
			for k,v in pairs(MY_STRINGS_OVERRIDE) do
				if MY_STRINGS[k] ~= nil then
					MY_STRINGS[k] = v
				end
			end
		end

		if MSG_CHOOSE_OVERRIDE ~= nil then
			for k,v in pairs(MSG_CHOOSE_OVERRIDE) do
				for i,str in pairs(v) do
					if MSG_CHOOSE[str] == nil then
						MSG_CHOOSE[str] = k
					end
				end
			end
		end

		MY_STRINGS.allow_msg[1]=string.format(MY_STRINGS.allow_msg[1], cd_restart)
		MY_STRINGS.allow_msg[2]=string.format(MY_STRINGS.allow_msg[2], cd_restart)
		MY_STRINGS.allow_msg[3]=string.format(MY_STRINGS.allow_msg[3], cd_resurrect)
		MY_STRINGS.allow_msg[4]=string.format(MY_STRINGS.allow_msg[4], cd_kill)
		welcome_tips=MY_STRINGS.welcome_msg[trigger_mode]
		if allow_restart then welcome_tips=welcome_tips.."\n"..MY_STRINGS.allow_msg[1].."\n"..MY_STRINGS.allow_msg[2] end
		if allow_resurrect then welcome_tips=welcome_tips.."\n"..MY_STRINGS.allow_msg[3] end
		if allow_kill then welcome_tips=welcome_tips.."\n"..MY_STRINGS.allow_msg[4] end
		welcome_tips=welcome_tips.."\n"..MY_STRINGS.force_drop_msg[force_drop_mode]

	end)
end

-- Get Player var userid
local function GetPlayerById(playerid)
	for k,v in ipairs(_G.AllPlayers) do
		if v ~= nil and v.userid and v.userid == playerid then
			return v
		end
	end
	return nil
end

-- DropEverything for player
local function ItemDropAll(player)
	if player and player.components and player.components.inventory then
		player.components.inventory:DropEverything(false,false)
	end
end

-- Is Player Died
local function IsDied(player)
	if player and player:HasTag("player") and player:HasTag("playerghost") then
		return true
	end
end

-- List Manage Function
local restartlist = {}

local function ListInsert(player)
	if player.userid and player.components and player.components.age then
		local cdinfo = {}
		local age = player.components.age:GetAge()
		cdinfo.restart,cdinfo.resurrect,cdinfo.kill = age,age,age
		restartlist[player.userid] = cdinfo
	end
end

-- Get a player's command cooldown time
local function GetCD(player, tagnumber)
	if player.userid and restartlist[player.userid] and player.components and player.components.age then
		if tagnumber <= 2 then
			return restartlist[player.userid].restart + cd_restart - player.components.age:GetAge()
		elseif tagnumber == 3 then
			return restartlist[player.userid].resurrect + cd_resurrect - player.components.age:GetAge()
		elseif tagnumber == 4 then
			return restartlist[player.userid].kill + cd_kill - player.components.age:GetAge()
		end
	end
	return 999
end

-- When a player dies automatic counting
local function DeathRemove(player)
	if player.userid and restartlist[player.userid] and player.components and player.components.age then
		local cdinfo = restartlist[player.userid]
		if player:IsValid() and IsDied(player) then
			if player:HasTag("Restarted") then
				cdinfo.restart = cdinfo.restart - 1
				if GetCD(player,1) <= 0 then
					player:RemoveTag("Restarted")
				end
			end
			if player:HasTag("Resurrected") then
				cdinfo.resurrect = cdinfo.resurrect - 1
				if GetCD(player,3) <= 0 then
					player:RemoveTag("Resurrected")
				end
			end
			if player:HasTag("Killed") then
				cdinfo.kill = cdinfo.kill - 1
				if GetCD(player,4) <= 0 then
					player:RemoveTag("Killed")
				end
			end
			if player:HasTag("Restarted") or player:HasTag("Resurrected") or player:HasTag("Killed") then
				player:DoTaskInTime(1, DeathRemove)
			end
		else
			if player:HasTag("Restarted") then
				player:DoTaskInTime(GetCD(player,1), function()
					player:RemoveTag("Restarted")
				end)
			end
			if player:HasTag("Resurrected") then
				player:DoTaskInTime(GetCD(player,3), function()
					player:RemoveTag("Resurrected")
				end)
			end
			if player:HasTag("Killed") then
				player:DoTaskInTime(GetCD(player,4), function()
					player:RemoveTag("Killed")
				end)
			end
		end
	end
end

-- DodeSpawn Function
local function DodeSpawn(player)
	if allow_restart and player ~= nil and player:IsValid() then
		if _G.TheWorld.ismastersim then
			if cd_restart ~= 0 then
				restartlist[player.userid].restart = 0
			end
			if allow_resurrect and cd_resurrect ~= 0 then
				restartlist[player.userid].resurrect = GetCD(player,3) - cd_resurrect
			end
			if allow_kill and cd_kill ~= 0 then
				restartlist[player.userid].kill = GetCD(player,4) - cd_kill
			end
			_G.TheWorld:PushEvent("ms_playerdespawnanddelete", player)
		end
	end
end

local function ResurrectSpawn(player)
	if allow_resurrect and player ~= nil and player:IsValid() and IsDied(player) then
		if _G.TheWorld.ismastersim then
			if cd_resurrect ~= 0 then
				restartlist[player.userid].resurrect = player.components.age:GetAge()
				player:AddTag("Resurrected")
				player:DoTaskInTime(GetCD(player,3), function()
					player:RemoveTag("Resurrected")
				end)
			end
			player:PushEvent("respawnfromghost")
			player.rezsource = MY_STRINGS.resurrect
		end
	end
end

local function KillSpawn(player)
	if allow_kill and player ~= nil and player:IsValid() and not IsDied(player) then
		if _G.TheWorld.ismastersim then
			if cd_kill ~= 0 then
				restartlist[player.userid].kill = player.components.age:GetAge()
				player:AddTag("Killed")
			end
			player:PushEvent("death")
			player.deathpkname = MY_STRINGS.kill
		end
	end
end

-- Remove restart
AddComponentPostInit("playerspawner", function(OnPlayerSpawn, inst)
	inst:ListenForEvent("ms_playerjoined", function(inst, player)

			if not player then return end

			if restart_welcome_tips and restartlist[player.userid] == nil and (allow_restart or allow_resurrect or allow_kill) then
				player:DoTaskInTime(3, function(player)
					if player.components and player.components.talker then
						player.components.talker:Say(player:GetDisplayName()..", "..welcome_tips, restart_welcome_tips_time)
					end
				end)
			end

			if allow_restart and cd_restart ~= 0 or allow_resurrect and cd_resurrect ~= 0 or allow_kill and cd_kill ~= 0 then
				-- Save the command cooldown time when a player leaves the server side
				if player and player.components then
					if restartlist[player.userid] == nil then
						ListInsert(player)
						local age = player.components.age:GetAge()
						if allow_restart and cd_restart ~= 0 and age < cd_restart then
							restartlist[player.userid].restart = 0
							player:AddTag("Restarted")
						end
						if allow_resurrect and cd_resurrect ~= 0 and age < cd_resurrect then
							restartlist[player.userid].resurrect = 0
							player:AddTag("Resurrected")
						end
						if allow_kill and cd_kill ~= 0 and age < cd_kill then
							restartlist[player.userid].kill = 0
							player:AddTag("Killed")
						end
					else
						if allow_restart and cd_restart ~= 0 and GetCD(player,1) > 0 then
							player:AddTag("Restarted")
						end
						if allow_resurrect and cd_resurrect ~= 0 and GetCD(player,3) > 0 then
							player:AddTag("Resurrected")
						end
						if allow_kill and cd_kill ~= 0 and GetCD(player,4) > 0 then
							player:AddTag("Killed")
						end
					end

					if IsDied(player) then
						if player:HasTag("Restarted") or player:HasTag("Resurrected") or player:HasTag("Killed") then
							player:DoTaskInTime(1, DeathRemove)
						end
					else
						if player:HasTag("Restarted") then
							player:DoTaskInTime(GetCD(player,1), function()
								player:RemoveTag("Restarted")
							end)
						end
						if player:HasTag("Resurrected") then
							player:DoTaskInTime(GetCD(player,3), function()
								player:RemoveTag("Resurrected")
							end)
						end
						if player:HasTag("Killed") then
							player:DoTaskInTime(GetCD(player,4), function()
								player:RemoveTag("Killed")
							end)
						end
					end

					player:ListenForEvent("death", function(player)
						if player:HasTag("Restarted") or player:HasTag("Resurrected") or player:HasTag("Killed") then
							-- Waiting for the player's status was changed to death.
							player:DoTaskInTime(2.5, DeathRemove)
						end
					end)

				end
			end

	end)
end)

local function IsTrigger(whisper)
	if trigger_mode == 1 then
		return true
	elseif trigger_mode == 2 and not whisper then
		return true
	elseif trigger_mode == 3 and whisper then
		return true
	end
	return false
end

local function ChooseCD(player, choose)
	if choose <= 2 and player:HasTag("Restarted") then
		return allow_restart and choose or -choose
	elseif choose == 3 and player:HasTag("Resurrected") then
		return allow_resurrect and choose or -choose
	elseif choose == 4 and player:HasTag("Killed") then
		return allow_kill and choose or -choose
	end
	return 0
end

-- Main Function
local Old_Networking_Say = _G.Networking_Say
_G.Networking_Say = function(guid, userid, name, prefab, message, colour, whisper, isemote, ...)
	Old_Networking_Say(guid, userid, name, prefab, message, colour, whisper, isemote, ...)
	if IsTrigger(whisper) then
		local lower_msg = string.lower(message)

		if MSG_CHOOSE[lower_msg] ~= nil then
			local player = GetPlayerById(userid)
			if player then

				local choose = ChooseCD(player,MSG_CHOOSE[lower_msg])
				if choose < 0 then
					return
				elseif choose > 0 then
					if ignoring_admin and TheNet:GetIsServerAdmin() and player.components and player.Network:IsServerAdmin() then
					else
						local warning = choose == 3 and MY_STRINGS.resurrect or
							(choose == 4 and MY_STRINGS.kill or MY_STRINGS.restart)
						local msg = string.format(MY_STRINGS.warning, warning, GetCD(player,MSG_CHOOSE[lower_msg]))
						player:DoTaskInTime(0.5, function()
							if player.components.talker then player.components.talker:Say(player:GetDisplayName()..", "..msg) end
						end)
						return
					end
				end

				if MSG_CHOOSE[lower_msg] == 3 then
					player:DoTaskInTime(1, ResurrectSpawn)
				elseif MSG_CHOOSE[lower_msg] == 4 then
					player:DoTaskInTime(1, KillSpawn)
				else

					-- Drop Everything
					if force_drop_mode == 2 or force_drop_mode == 1 and MSG_CHOOSE[lower_msg] == 2 then
						ItemDropAll(player)
					end

					-- Announce all Players who restart the Game
					player:DoTaskInTime(0.5, function()
						local charactername = STRINGS.CHARACTER_NAMES[prefab] or prefab
						TheNet:Announce(player:GetDisplayName().." ("..charactername..") "..MY_STRINGS.announce)
					end)

					-- Restart the Game
					player:DoTaskInTime(1, DodeSpawn)

				end
			end
		end
	end
end
