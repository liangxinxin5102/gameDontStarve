PrefabFiles = {
	"leyuan_weapon_groups",
	"leyuan_heavyblade",
	
	"metal_hulk_merge",
	"metal_hulk_bullet_shock",
	"metal_hulk_eyeflame",
	"laser_ring",
	"red_lightning",

}

GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

modimport("leyuan_weapon_strings.lua")


GLOBAL.TUNING.HULK_HEALTH = 1000000 			--和平行者生命值
GLOBAL.TUNING.HULK_ATK = 7500 				--和平行者的普通攻击力(注意:对玩家造成的伤害会减半)
GLOBAL.TUNING.HULK_COLLIDE_ATK = 6000		    --和平行者的移动碰撞攻击力
GLOBAL.TUNING.HULK_BALL_ATK = 17500 			--和平行者的lobSG中，光球造成的伤害
GLOBAL.TUNING.HULK_BULLET_ATK = 5000 			--和平行者的tauntSG中，多个光球造成的伤害
GLOBAL.TUNING.HULK_MINE_ATK = 17500 			--和平行者的地雷伤害
GLOBAL.TUNING.HULK_LIGHTNING_ATK = 2500 		--和平行者的雷击伤害





AddReplicableComponent("leyuanweapon")


local Image = require "widgets/image"
local ExtraText = {
	leyuan_heavyblade = {
		strings = 
		"以一整块钢铁直接淬炼而成的巨剑\n"..
		"剑身没有开刃,是以绝对重量压制敌人的武器\n"..
		"如果不是力量超乎常人的话,很难得拿动\n"..
		STRINGS.RMB..":战技·格挡:\n"..
		"将大剑横置,摆开架势\n"..
		"防御来自前方的攻击\n",
		position = Vector3(0,33,0),
		scale = Vector3(1.25,0.45,1),
	},
}

AddClassPostConstruct("widgets/hoverer",function(self)
	--[[self.background = self.text:AddChild(Image("images/fepanels.xml", "panel_topmods.tex"))
	self.background:SetPosition(Vector3(0,0,0))
	self.background:SetTint(1,1,1,0.5)
	self.background:SetScale(1.5,0.6,1)
	self.background:SetClickable(false) 
	self.background:MoveToBack() 
	
	local function ShowMoreDetials(str,target)
		if target and target.prefab and ExtraText[target.prefab] then 
			if ExtraText[target.prefab].strings then 
				str = str.."\n"..ExtraText[target.prefab].strings
			end
			if ExtraText[target.prefab].position then 
				self.background:SetPosition(ExtraText[target.prefab].position)
			else
				self.background:SetPosition(Vector3(0,0,0))
			end
			if ExtraText[target.prefab].scale then 
				self.background:SetScale(ExtraText[target.prefab].scale:Get())
			else
				self.background:SetScale(1,1,1)
			end
		end
		return str
	end --]]
	
	local old_SetString = self.text.SetString
	self.text.SetString = function(text,str)
		local target = TheInput:GetHUDEntityUnderMouse()
		if target ~= nil then
			target = target.widget ~= nil and target.widget.parent ~= nil and target.widget.parent.item 
		else
			target = TheInput:GetWorldEntityUnderMouse()
		end
		if target and target.replica and target.replica.leyuanweapon then 
			local level = target.replica.leyuanweapon:GetLevel()
			local maxlevel = target.replica.leyuanweapon:GetMaxLevel()
			local exp = target.replica.leyuanweapon:GetExp()
			local maxexp = target.replica.leyuanweapon:GetMaxExp()
			local ismaxlevel = target.replica.leyuanweapon:IsMaxLevel()

			local extrastr = string.format("\n等级:%d/%d\n",level,maxlevel)
			extrastr = extrastr..(not ismaxlevel and string.format("经验:%d/%d\n",exp,maxexp) or "经验:MAX")
			
			str = str..extrastr
		end
		
		--[[if target 
			and ExtraText[target.prefab] 
			and target.replica.inventoryitem 
			and target.replica.inventoryitem:IsHeldBy(player) then 
		
			if TheInput:IsKeyDown(KEY_LCTRL) then 
				str = ShowMoreDetials(str,target)
				self.background:Show()
			else
				str = str.."\n左CTRL:详细查看\n"
				self.background:Hide()
			end 
		else
			self.background:Hide()
		end--]]
		
		return old_SetString(text,str)
	end
end)

local function DoTeleport(player,worldid,portalid)
	if worldid and TheShard:GetShardId() ~= worldid and tonumber(worldid) and tonumber(worldid) > 0 then 
		TheWorld:PushEvent("ms_playerdespawnandmigrate",{player = player, worldid = worldid,portalid = portalid})
	end
end 
AddModRPCHandler("leyuan_world","doteleport",DoTeleport)

AddPrefabPostInit("player_classified",function(inst)
	inst.NowWorldId = net_string(inst.GUID,"inst.NowWorldId","NowWorldId")
end)

AddPlayerPostInit(function(inst)
	if not TheWorld.ismastersim then
        return inst
    end
	inst.player_classified.NowWorldId:set(tostring(TheShard:GetShardId()))
end)

local WorldTeleporter = require("widgets/worldteleporter")
AddClassPostConstruct("widgets/controls",function(self)
	self.worldteleporter = self:AddChild(WorldTeleporter(self.owner))
end)




local MonsterToSpawnHulk = {
	"deerclops",--巨鹿
	"bearger",--熊
	"dragonfly",--龙蝇
	"moose",--鹿鸭
	
	"spiderqueen",--蜘蛛女王
	
	"minotaur",--远古守护者
	
	"beequeen",--蜜蜂女王
	"toadstool",--洞穴蟾蜍
	"toadstool_dark",--悲痛蟾蜍
	"antlion",--蚁狮
	
	"spat",--刚羊
    "merm", --鱼人

    "spiderqueen", --蜘蛛女王
    "leif", --树精
    "leif_sparse", --稀有树精
    "walrus", --海象
    "koalefant_summer", --夏天的大象
    "koalefant_winter", --冬天的大象
    "knight", --发条骑士
    "bishop", --主教
    "rook", --战车

    "minotaur", --远古守护者
    "lureplant", --食人花
    "warg", --座狼
	"hjzs1", --火鸡祭坛BOSS1
	"hjzs2", --火鸡祭坛BOSS2
	"hjzs3", --火鸡祭坛BOSS3
	"hjzs4", --火鸡祭坛BOSS4
	"hjzs5", --火鸡祭坛BOSS5
	"hjzs6", --火鸡祭坛BOSS6
}

for k,v in pairs(MonsterToSpawnHulk) do
	AddPrefabPostInit(v,function(inst)
		if not TheWorld.ismastersim then
			return inst
		end

		inst:ListenForEvent("death",function(inst,data)
			if inst and inst:IsValid() then 
				local ent = FindEntity(inst,10000,function(guy)
					return guy.prefab == "metal_hulk_merge"
				end)
				if math.random() <= 0.01 and not ent then 
					local hulk = SpawnAt("metal_hulk_merge",inst:GetPosition())
					hulk.sg:GoToState("telportin")
				end
			end 
		end)
	end)
end




