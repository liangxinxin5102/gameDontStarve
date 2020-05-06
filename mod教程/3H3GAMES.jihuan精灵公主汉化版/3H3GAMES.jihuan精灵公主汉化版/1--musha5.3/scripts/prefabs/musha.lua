local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
        Asset( "ANIM", "anim/player_basic.zip" ),
        Asset( "ANIM", "anim/player_idles_shiver.zip" ),
        Asset( "ANIM", "anim/player_actions.zip" ),
        Asset( "ANIM", "anim/player_actions_axe.zip" ),
        Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
        Asset( "ANIM", "anim/player_actions_shovel.zip" ),
        Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
        Asset( "ANIM", "anim/player_actions_eat.zip" ),
        Asset( "ANIM", "anim/player_actions_item.zip" ),
        Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
        Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
        Asset( "ANIM", "anim/player_actions_fishing.zip" ),
        Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
        Asset( "ANIM", "anim/player_bush_hat.zip" ),
        Asset( "ANIM", "anim/player_attacks.zip" ),
        Asset( "ANIM", "anim/player_idles.zip" ),
        Asset( "ANIM", "anim/player_rebirth.zip" ),
        Asset( "ANIM", "anim/player_jump.zip" ),
        Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
        Asset( "ANIM", "anim/player_teleport.zip" ),
        Asset( "ANIM", "anim/wilson_fx.zip" ),
        Asset( "ANIM", "anim/player_one_man_band.zip" ),
        Asset( "ANIM", "anim/shadow_hands.zip" ),
        Asset( "SOUND", "sound/sfx.fsb" ),
        Asset( "SOUND", "sound/maxwell.fsb" ),
	Asset("SOUND", "sound/willow.fsb"),    
        Asset( "ANIM", "anim/beard.zip" ),

        Asset( "ANIM", "anim/musha_battle.zip" ),
        Asset( "ANIM", "anim/musha.zip" ),
        Asset( "ANIM", "anim/musha_normal.zip" ),
Asset( "ANIM", "anim/musha_hunger.zip" ),
}
local prefabs = {
	"willowfire",
        "book_birds",
        "book_tentacles",
        "book_gardening",
        "book_sleep",
        "book_brimstone",
}
local start_inv = 
{
      "musha_egg",
      "broken_frosthammer",
   --   "frosthammer",
   --   "hat_mbunny",
   --   "hat_mcrown",
    --  "hat_mprincess",
   --   "armor_mushaa",
   --   "armor_mushab",
"mushasword",
"musha_flute",
"glowdust",
"glowdust",
"glowdust",
"glowdust",
"glowdust",
"glowdust",

}

local function levelexp(inst,data)

	local max_exp = 7000
	local exp = math.min(inst.level, max_exp)

	--local hunger_percent = inst.components.hunger:GetPercent()
	--local health_percent = inst.components.health:GetPercent()
	local sanity_percent = inst.components.sanity:GetPercent()

	--inst.components.hunger.max = math.ceil (120 + exp* 0.02)
	--inst.components.health.maxhealth = math.ceil (85 + exp* 0.02)
	inst.components.sanity.max = math.ceil (120 + exp* 0.02)

	inst.components.talker:Say("[EXP] \n".. (inst.level))

			if inst.level >4 and inst.level <= 5 then
	inst.components.talker:Say("Level 1\n Unlock: [闪 电 盾]\n1/4")
	inst:AddTag("healshield1")
	inst.components.health:SetMaxHealth(80)
	inst.components.hunger:SetMax(110)

inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")

			elseif inst.level >0 and inst.level < 4 then
inst.components.talker:Say("Next :EXP[5]\n[EXP] ".. (inst.level))
--[test]
--[[

			elseif inst.level < 1 then
inst.components.talker:Say("Level 1\n Unlock: [All Level 1]\ntest")
	inst:AddTag("healshield1")
	inst:AddTag("hitcritical1")
	inst:AddTag("Valkyrie")
	inst:AddTag("hitlightning1")
	inst:AddTag("Berserk")
	inst:AddTag("fshield1")
	inst:AddTag("hpregen1")
	inst:AddTag("hitfreeze1")
	inst:AddTag("lessercure1")
	inst:AddTag("cure1")
 inst.components.combat.damagemultiplier = TUNING.WENDY_DAMAGE_MULT *2
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
]]--
			elseif inst.level >5 and inst.level < 9 then
inst.components.talker:Say("Next :EXP[10]\n[EXP] + ".. (inst.level))
	inst:AddTag("healshield1")
	inst.components.health:SetMaxHealth(80)
	inst.components.hunger:SetMax(110)

		elseif inst.level >9 and inst.level <= 10 then
	inst.components.talker:Say("Level 2\n Unlock:[女 武 神 能 力 获 得]\n1/1")
	inst:AddTag("Valkyrie")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("healshield1")
	inst.components.health:SetMaxHealth(90)
	inst.components.hunger:SetMax(120)
	
			elseif inst.level >10 and inst.level < 29 then
inst.components.talker:Say("Next :EXP[30]\n[EXP] + ".. (inst.level))
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst.components.health:SetMaxHealth(90)
	inst.components.hunger:SetMax(120)

		elseif inst.level >29 and inst.level <= 30 then
	inst.components.talker:Say("Level 3\n Unlock: [致 命 一 击]\n1/4")
	inst:AddTag("hitcritical1")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst.components.health:SetMaxHealth(100)
	inst.components.hunger:SetMax(130)

			elseif inst.level >30 and inst.level <49  then
inst.components.talker:Say("Next :EXP[50]\n[EXP] + ".. (inst.level))
	inst:AddTag("hitcritical1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst.components.health:SetMaxHealth(100)
	inst.components.hunger:SetMax(130)

		elseif inst.level >49 and inst.level <= 50 then
	inst.components.talker:Say("Level 4\n Unlock: [闪 电 攻 击]\n1/2")
	inst:AddTag("hitlightning1")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:AddTag("hitcritical1")
	inst.components.health:SetMaxHealth(110)
	inst.components.hunger:SetMax(140)


			elseif inst.level >50 and inst.level <79  then
inst.components.talker:Say("Next :EXP[80]\n[EXP] + ".. (inst.level))
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:AddTag("hitcritical1")
	inst.components.health:SetMaxHealth(110)
	inst.components.hunger:SetMax(140)

		elseif inst.level >79 and inst.level <= 80 then
	inst.components.talker:Say("Level 5\n Unlock : [小 治 疗]\n1/2")
	inst:AddTag("lessercure1")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:AddTag("hitcritical1")
	inst.components.health:SetMaxHealth(120)
	inst.components.hunger:SetMax(150)

			elseif inst.level >80 and inst.level <124  then
inst.components.talker:Say("Next :EXP[125]\n[EXP] + ".. (inst.level))
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:AddTag("hitcritical1")
	inst.components.health:SetMaxHealth(120)
	inst.components.hunger:SetMax(150)

		elseif inst.level >124 and inst.level <= 125 then
	inst.components.talker:Say("Level 6\n Unlock: [狂 暴 能 力 获 得]\n1/1")
	inst:AddTag("Berserk")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:AddTag("hitcritical1")
	inst.components.health:SetMaxHealth(130)
	inst.components.hunger:SetMax(160)

			elseif inst.level >125 and inst.level <199  then
inst.components.talker:Say("Next :EXP[200]\n[EXP] + ".. (inst.level))
inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:AddTag("hitcritical1")
	inst.components.health:SetMaxHealth(130)
	inst.components.hunger:SetMax(160)

		elseif inst.level >199 and inst.level <= 200 then
	inst.components.talker:Say("Level 7\n Unlock : [火 焰 屏 障]\n1/4")
	inst:AddTag("fshield1")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:AddTag("hitcritical1")
	inst.components.health:SetMaxHealth(140)
	inst.components.hunger:SetMax(170)

			elseif inst.level >200 and inst.level <339  then
inst.components.talker:Say("Next :EXP[340]\n[EXP] + ".. (inst.level))
	inst:AddTag("fshield1")
inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:AddTag("hitcritical1")
	inst.components.health:SetMaxHealth(140)
	inst.components.hunger:SetMax(170)

		elseif inst.level >339 and inst.level <= 340 then
	inst.components.talker:Say("Level 8\n Unlock : [HP 恢 复]\n1/4")
	inst:AddTag("hpregen1")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:AddTag("hitcritical1")
	inst.components.health:SetMaxHealth(150)
	inst.components.hunger:SetMax(180)
	
			elseif inst.level >340 and inst.level <429  then
inst.components.talker:Say("Next :EXP[430]\n[EXP] + ".. (inst.level))
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:AddTag("hitcritical1")
	inst.components.health:SetMaxHealth(150)
	inst.components.hunger:SetMax(180)

		elseif inst.level >429 and inst.level <= 430 then
	inst.components.talker:Say("Level 9\n Unlock : [寒 冰 攻 击]\n1/4")
	inst:AddTag("hitfreeze1")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:AddTag("hitcritical1")
	inst.components.health:SetMaxHealth(160)
	inst.components.hunger:SetMax(190)

			elseif inst.level >430 and inst.level <529  then
inst.components.talker:Say("Next :EXP[530]\n[EXP] + ".. (inst.level))
	inst:AddTag("hitfreeze1")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:AddTag("hitcritical1")
	inst.components.health:SetMaxHealth(160)
	inst.components.hunger:SetMax(190)

		elseif inst.level >529 and inst.level <= 530 then
	inst.components.talker:Say("Level 10\n Unlock: [致 命 一 击]\n2/4")
	inst:RemoveTag("hitcritical1")
	inst:AddTag("hitcritical2")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("hitfreeze1")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst.components.health:SetMaxHealth(165)
	inst.components.hunger:SetMax(192)

			elseif inst.level >530 and inst.level <639  then
inst.components.talker:Say("Next :EXP[640]\n[EXP] + ".. (inst.level))
	inst:AddTag("hitcritical2")
	inst:AddTag("hitfreeze1")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst.components.health:SetMaxHealth(165)
	inst.components.hunger:SetMax(192)

		elseif inst.level >639 and inst.level <= 640 then
	inst.components.talker:Say("Level 11\n Unlock: [致 命 一 击]\n3/4")
	inst:RemoveTag("hitcritical2")
	inst:AddTag("hitcritical3")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("hitfreeze1")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst.components.health:SetMaxHealth(170)
	inst.components.hunger:SetMax(194)

			elseif inst.level >640 and inst.level <759  then
inst.components.talker:Say("Next :EXP[760]\n[EXP] + ".. (inst.level))
	inst:AddTag("hitcritical3")
	inst:AddTag("hitfreeze1")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst.components.health:SetMaxHealth(170)
	inst.components.hunger:SetMax(194)

		elseif inst.level >759 and inst.level <= 760 then
inst.components.talker:Say("Level 12\n Unlock: [致 命 一 击 升 至 最 高]\n4/4")
	inst:RemoveTag("hitcritical3")
	inst:AddTag("hitcritical4")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("hitfreeze1")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst.components.health:SetMaxHealth(175)
	inst.components.hunger:SetMax(196)

			elseif inst.level >760 and inst.level <889  then
inst.components.talker:Say("Next :EXP[890]\n[EXP] + ".. (inst.level))
	inst:AddTag("hitcritical4")
	inst:AddTag("hitfreeze1")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:AddTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(175)
	inst.components.hunger:SetMax(196)

		elseif inst.level >889 and inst.level <= 890 then
	inst.components.talker:Say("Level 13\n Unlock: [闪 电 盾]\n2/4")
	inst:RemoveTag("healshield1")
	inst:AddTag("healshield2")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("hitcritical4")
	inst:AddTag("hitfreeze1")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(180)
	inst.components.hunger:SetMax(198)

			elseif inst.level >890 and inst.level <1029  then
inst.components.talker:Say("Next :EXP[1030]\n[EXP] + ".. (inst.level))
	inst:AddTag("healshield2")
	inst:AddTag("hitcritical4")
	inst:AddTag("hitfreeze1")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(180)
	inst.components.hunger:SetMax(198)

		elseif inst.level >1029 and inst.level <= 1030 then
	inst.components.talker:Say("Level 14\n Unlock: [闪 电 盾]\n3/4")
	inst:RemoveTag("healshield2")
	inst:AddTag("healshield3")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("hitcritical4")
	inst:AddTag("hitfreeze1")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(185)
	inst.components.hunger:SetMax(200)

			elseif inst.level >1030 and inst.level <1179  then
inst.components.talker:Say("Next :EXP[1180]\n[EXP] + ".. (inst.level))
	inst:AddTag("healshield3")
	inst:AddTag("hitcritical4")
	inst:AddTag("hitfreeze1")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(185)
	inst.components.hunger:SetMax(200)

		elseif inst.level >1179 and inst.level <= 1180 then
inst.components.talker:Say("Level 15\n Unlock: [闪 电 盾 升 至 最 高]\n4/4")
	inst:RemoveTag("healshield3")
	inst:AddTag("healshield4")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("hitcritical4")
	inst:AddTag("hitfreeze1")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(190)
	inst.components.hunger:SetMax(202)

			elseif inst.level >1180 and inst.level <1339  then
inst.components.talker:Say("Next :EXP[1340]\n[EXP] + ".. (inst.level))
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("hitfreeze1")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("lessercure1")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(190)
	inst.components.hunger:SetMax(202)

		elseif inst.level >1339 and inst.level <= 1340 then
inst.components.talker:Say("Level 16\n Unlock : [小 治 疗 升 至 最 高]\n2/2")
	inst:RemoveTag("lessercure1")
	inst:AddTag("lessercure2")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("hitfreeze1")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(195)
	inst.components.hunger:SetMax(204)

			elseif inst.level >1340 and inst.level <1509  then
inst.components.talker:Say("Next :EXP[1510]\n[EXP] + ".. (inst.level))
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("hitfreeze1")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(195)
	inst.components.hunger:SetMax(204)

		elseif inst.level >1509 and inst.level <= 1510 then
	inst.components.talker:Say("Level 17\n Unlock : [寒 冰 攻 击]\n2/4")
	inst:RemoveTag("hitfreeze1")
	inst:AddTag("hitfreeze2")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("hitfreeze1")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(200)
	inst.components.hunger:SetMax(206)

			elseif inst.level >1509 and inst.level <1689  then
inst.components.talker:Say("Next :EXP[1690]\n[EXP] + ".. (inst.level))
	inst:AddTag("hitfreeze2")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(200)
	inst.components.hunger:SetMax(206)

		elseif inst.level >1689 and inst.level <= 1690 then
inst.components.talker:Say("Level 18\n Unlock : [寒 冰 攻 击]\n3/4")
	inst:RemoveTag("hitfreeze2")
	inst:AddTag("hitfreeze3")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(205)
	inst.components.hunger:SetMax(208)

			elseif inst.level >1690 and inst.level <1879  then
inst.components.talker:Say("Next :EXP[1880]\n[EXP] + ".. (inst.level))
	inst:AddTag("hitfreeze3")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(205)
	inst.components.hunger:SetMax(208)

		elseif inst.level >1879 and inst.level <= 1880 then
inst.components.talker:Say("Level 19\n Unlock : [寒 冰 攻 击 升 至 最 高]\n4/4")
	inst:RemoveTag("hitfreeze3")
	inst:AddTag("hitfreeze4")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(210)
	inst.components.hunger:SetMax(210)

			elseif inst.level >1880 and inst.level <2079  then
inst.components.talker:Say("Next :EXP[2080]\n[EXP] + ".. (inst.level))
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(210)
	inst.components.hunger:SetMax(210)

		elseif inst.level >2079 and inst.level <= 2080 then
	inst.components.talker:Say("Level 20\n Unlock : [HP 恢 复]\n2/4")
	inst:RemoveTag("hpregen1")
	inst:AddTag("hpregen2")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(215)
	inst.components.hunger:SetMax(212)

			elseif inst.level >2080 and inst.level <2289  then
inst.components.talker:Say("Next :EXP[2289]\n[EXP] + ".. (inst.level))
	inst:AddTag("hpregen2")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(215)
	inst.components.hunger:SetMax(212)

		elseif inst.level >2189 and inst.level <= 2290 then
	inst.components.talker:Say("Level 21\n Unlock : [HP 恢 复]\n3/4")
	inst:RemoveTag("hpregen2")
	inst:AddTag("hpregen3")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(220)
	inst.components.hunger:SetMax(214)

			elseif inst.level >2290 and inst.level <2499  then
inst.components.talker:Say("Next :EXP[2500]\n[EXP] + ".. (inst.level))
	inst:AddTag("hpregen3")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("hpregen1")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("hpregen2")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(225)
	inst.components.hunger:SetMax(214)

		elseif inst.level >2499 and inst.level <= 2500 then
	inst.components.talker:Say("Level 22\n Unlock : [火 焰 屏 障]\n2/4")
	inst:RemoveTag("fshield1")
	inst:AddTag("fshield2")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("hpregen3")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("hpregen1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("hpregen2")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(230)
	inst.components.hunger:SetMax(216)

			elseif inst.level >2500 and inst.level <2849  then
inst.components.talker:Say("Next :EXP[2850]\n[EXP] + ".. (inst.level))
	inst:AddTag("fshield2")
	inst:AddTag("hpregen3")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("fshield1")
	inst:RemoveTag("hpregen2")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(235)
	inst.components.hunger:SetMax(216)

		elseif inst.level >2849 and inst.level <= 2850 then
	inst.components.talker:Say("Level 23\n Unlock : [火 焰 屏 障]\n3/4")
	inst:RemoveTag("fshield2")
	inst:AddTag("fshield3")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("hpregen3")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("fshield1")
	inst:RemoveTag("hpregen2")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(240)
	inst.components.hunger:SetMax(218)

			elseif inst.level >2850 and inst.level <3199  then
inst.components.talker:Say("Next :EXP[3200]\n[EXP] + ".. (inst.level))
	inst:AddTag("fshield3")
	inst:AddTag("hpregen3")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("fshield2")
	inst:RemoveTag("fshield1")
	inst:RemoveTag("hpregen2")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(240)
	inst.components.hunger:SetMax(218)

		elseif inst.level >3199 and inst.level <= 3200 then
inst.components.talker:Say("Level 24\n Unlock : [火 焰 屏 障 升 至 最 高]\n4/4")
	inst:RemoveTag("fshield3")
	inst:AddTag("fshield4")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("hpregen3")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("fshield2")
	inst:RemoveTag("fshield1")
	inst:RemoveTag("hpregen2")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(245)
	inst.components.hunger:SetMax(220)

			elseif inst.level >3200 and inst.level <3699  then
inst.components.talker:Say("Next :EXP[3700]\n[EXP] + ".. (inst.level))
	inst:AddTag("fshield4")
	inst:AddTag("hpregen3")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("fshield3")
	inst:RemoveTag("fshield2")
	inst:RemoveTag("fshield1")
	inst:RemoveTag("hpregen2")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(245)
	inst.components.hunger:SetMax(220)

		elseif inst.level >3699 and inst.level <= 3700 then
inst.components.talker:Say("Level 25\n Unlock : [治 愈]\n1/2")
	inst:AddTag("cure1")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("fshield4")
	inst:AddTag("hpregen3")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("fshield3")
	inst:RemoveTag("fshield2")
	inst:RemoveTag("fshield1")
	inst:RemoveTag("hpregen2")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(250)
	inst.components.hunger:SetMax(222)

			elseif inst.level >3700 and inst.level <4199  then
inst.components.talker:Say("Next :EXP[4200]\n[EXP] + ".. (inst.level))
	inst:AddTag("cure1")
	inst:AddTag("fshield4")
	inst:AddTag("hpregen3")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("fshield3")
	inst:RemoveTag("fshield2")
	inst:RemoveTag("fshield1")
	inst:RemoveTag("hpregen2")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(250)
	inst.components.hunger:SetMax(222)

		elseif inst.level >4199 and inst.level <= 4200 then
inst.components.talker:Say("Level 26\n Unlock : [治 愈 升 至 最 高]\n2/2")
	inst:RemoveTag("cure1")
	inst:AddTag("cure2")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("fshield4")
	inst:AddTag("hpregen3")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("fshield3")
	inst:RemoveTag("fshield2")
	inst:RemoveTag("fshield1")
	inst:RemoveTag("hpregen2")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst.components.health:SetMaxHealth(255)
	inst.components.hunger:SetMax(224)

			elseif inst.level >4200 and inst.level <4699  then
inst.components.talker:Say("Next :EXP[4700]\n[EXP] + ".. (inst.level))
	inst:AddTag("cure2")
	inst:AddTag("fshield4")
	inst:AddTag("hpregen3")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("fshield3")
	inst:RemoveTag("fshield2")
	inst:RemoveTag("fshield1")
	inst:RemoveTag("hpregen2")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst:RemoveTag("cure1")
	inst.components.health:SetMaxHealth(255)
	inst.components.hunger:SetMax(224)

		elseif inst.level >4699 and inst.level <= 4700 then
inst.components.talker:Say("Level 27\n Unlock : [双 倍 伤 害 获 得]\n1/1")
 inst.components.combat.damagemultiplier = TUNING.WENDY_DAMAGE_MULT *2

inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("cure2")
	inst:AddTag("fshield4")
	inst:AddTag("hpregen3")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("fshield3")
	inst:RemoveTag("fshield2")
	inst:RemoveTag("fshield1")
	inst:RemoveTag("hpregen2")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst:RemoveTag("cure1")
	inst.components.health:SetMaxHealth(260)
	inst.components.hunger:SetMax(226)

			elseif inst.level >4700 and inst.level <5499  then
inst.components.talker:Say("Next :EXP[5500]\n[EXP] + ".. (inst.level))
	inst:AddTag("cure2")
	inst:AddTag("fshield4")
	inst:AddTag("hpregen3")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("fshield3")
	inst:RemoveTag("fshield2")
	inst:RemoveTag("fshield1")
	inst:RemoveTag("hpregen2")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst:RemoveTag("cure1")
 inst.components.combat.damagemultiplier = TUNING.WENDY_DAMAGE_MULT *2
	inst.components.health:SetMaxHealth(260)
	inst.components.hunger:SetMax(226)

		elseif inst.level >5499 and inst.level <= 5500 then
	inst.components.talker:Say("Level 28\n Unlock : [HP 恢 复 升 至 最 高]\n4/4")
	inst:RemoveTag("hpregen3")
	inst:AddTag("hpregen4")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("cure2")
	inst:AddTag("fshield4")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("fshield3")
	inst:RemoveTag("fshield2")
	inst:RemoveTag("fshield1")
	inst:RemoveTag("hpregen2")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst:RemoveTag("cure1")
 inst.components.combat.damagemultiplier = TUNING.WENDY_DAMAGE_MULT *2
	inst.components.health:SetMaxHealth(280)
	inst.components.hunger:SetMax(233)

			elseif inst.level >5500 and inst.level <6999  then
inst.components.talker:Say("Next :EXP[7000]\n[EXP] + ".. (inst.level))
	inst:AddTag("hpregen4")
	inst:AddTag("cure2")
	inst:AddTag("fshield4")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("hitlightning1")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("fshield3")
	inst:RemoveTag("fshield2")
	inst:RemoveTag("fshield1")
	inst:RemoveTag("hpregen2")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst:RemoveTag("cure1")
	inst:RemoveTag("hpregen3")
 inst.components.combat.damagemultiplier = TUNING.WENDY_DAMAGE_MULT *2
	inst.components.health:SetMaxHealth(280)
	inst.components.hunger:SetMax(230)

		elseif inst.level >6999 and inst.level < 7001 then
inst.components.talker:Say("Level 29\n Unlock : [闪 电 攻 击 升 至 最 高]\n2/2")
	inst:RemoveTag("hitlightning1")
	inst:AddTag("hitlightning2")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	inst:AddTag("hpregen4")
	inst:AddTag("cure2")
	inst:AddTag("fshield4")
	inst:AddTag("hitfreeze4")
	inst:AddTag("lessercure2")
	inst:AddTag("healshield4")
	inst:AddTag("hitcritical4")
	inst:AddTag("fshield1")
	inst:AddTag("Berserk")
	inst:AddTag("Valkyrie")
	inst:RemoveTag("fshield3")
	inst:RemoveTag("fshield2")
	inst:RemoveTag("fshield1")
	inst:RemoveTag("hpregen2")
	inst:RemoveTag("hpregen1")
	inst:RemoveTag("hitfreeze3")
	inst:RemoveTag("hitfreeze2")
	inst:RemoveTag("hitfreeze1")
	inst:RemoveTag("lessercure1")
	inst:RemoveTag("healshield3")
	inst:RemoveTag("healshield2")
	inst:RemoveTag("healshield1")
	inst:RemoveTag("hitcritical1")
	inst:RemoveTag("hitcritical2")
	inst:RemoveTag("hitcritical3")
	inst:RemoveTag("cure1")
	inst:RemoveTag("hpregen3")
 inst.components.combat.damagemultiplier = TUNING.WENDY_DAMAGE_MULT *2
	inst.components.health:SetMaxHealth(300)
	inst.components.hunger:SetMax(240)

	end
	--inst.components.hunger:SetPercent(hunger_percent)
	--inst.components.health:SetPercent(health_percent)
	inst.components.sanity:SetPercent(sanity_percent)
	end

---

local tynychance = 0.05
local smallllchance = 0.1
local smallchance = 0.2
local normalchance = 0.3
local largechance = 0.7

local function onkilll(inst, data)
	if data.cause == inst.prefab and not data.inst:HasTag("companion") then
                if math.random() < normalchance and data.inst:HasTag("prey") then
        			inst.level = inst.level + 1
	levelexp(inst)	

	elseif math.random() < largechance and not data.inst:HasTag("prey") and not data.inst:HasTag("eyeplant") then
    				inst.level = inst.level + 1
	levelexp(inst)

	elseif math.random() < smallllchance and data.inst:HasTag("eyeplant") then
    				inst.level = inst.level + 1
	levelexp(inst)

	elseif math.random() < smallllchance and data.inst:HasTag("arm") then
    				inst.level = inst.level + 1
	levelexp(inst)

    			 end
		          end
			end
			
local function expeat(inst, food)

if food.components.edible and math.random() < largechance and food.components.edible.hungervalue > 140 or food.components.edible.healthvalue > 35 then 
	inst.level = inst.level + 1
	levelexp(inst)
elseif food.components.edible and math.random() < normalchance and food.components.edible.hungervalue > 55 or food.components.edible.healthvalue > 29 or food.components.edible.sanityvalue > 14  then 
	inst.level = inst.level + 1
	levelexp(inst)
elseif food.components.edible and math.random() < smallchance and food.components.edible.hungervalue > 25 or food.components.edible.healthvalue > 19 or food.components.edible.sanityvalue > 9  then 
	inst.level = inst.level + 1
	levelexp(inst)
elseif food.components.edible and math.random() < tynychance and food.components.edible.hungervalue > 9 or food.components.edible.healthvalue > 4 or food.components.edible.sanityvalue > 4  then 
	inst.level = inst.level + 1
	levelexp(inst)
end
end

local function onpreload(inst, data)
	if data then
		if data.level then
		inst.level = data.level
			levelexp(inst)
--[[
			if data.health and data.health.health then inst.components.health.currenthealth = data.health.health end
			if data.hunger and data.hunger.hunger then inst.components.hunger.current = data.hunger.hunger end
]]--
			
			if data.sanity and data.sanity.current then inst.components.sanity.current = data.sanity.current end
			inst.components.health:DoDelta(0)
			inst.components.hunger:DoDelta(0)
			inst.components.sanity:DoDelta(0)
end
	end
		end

local function onsave(inst, data)
	data.level = inst.level
	data.charge_time = inst.charge_time
end
    local function lessercure_proc(inst, data)
	if inst.components.sanity.current > 10 then
        inst.components.health:DoDelta(30)
        inst.components.sanity:DoDelta(-10)
        local fx = SpawnPrefab("sparklefx")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1.3, 1.3, 1.3)
        fx.Transform:SetPosition(0, -0.2, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
        fx:ListenForEvent("blocked", fx_hitanim, inst)
        inst.active = true
        inst:DoTaskInTime(--[[Duration]] 5, function()
            fx:RemoveEventCallback("blocked", fx_hitanim, inst)
            if inst:IsValid() then
                inst:DoTaskInTime(--[[Cooldown]] 1800, function() inst.active = false 			end)
            end
        end)
    end
end
    local function lessercure2_proc(inst, data)
	if inst.components.sanity.current > 10 then
        inst.components.health:DoDelta(50)
        inst.components.sanity:DoDelta(-10)
        local fx = SpawnPrefab("sparklefx")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1.3, 1.3, 1.3)
        fx.Transform:SetPosition(0, -0.2, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
        fx:ListenForEvent("blocked", fx_hitanim, inst)
        inst.active = true
        inst:DoTaskInTime(--[[Duration]] 5, function()
            fx:RemoveEventCallback("blocked", fx_hitanim, inst)
            if inst:IsValid() then
                inst:DoTaskInTime(--[[Cooldown]] 900, function() inst.active = false 			end)
            end
        end)
    end
end

    local function cure1_proc(inst, data)
	if inst.components.sanity.current > 20 then
        inst.components.health:DoDelta(300)
        inst.components.sanity:DoDelta(-20)
        local fx = SpawnPrefab("sparklefx")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1.3, 1.3, 1.3)
        fx.Transform:SetPosition(0, -0.2, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
        fx:ListenForEvent("blocked", fx_hitanim, inst)
        inst.active = true
        inst:DoTaskInTime(--[[Duration]] 5, function()
            fx:RemoveEventCallback("blocked", fx_hitanim, inst)
            if inst:IsValid() then
                inst:DoTaskInTime(--[[Cooldown]] 1800, function() inst.active = false 			end)
            end
        end)
    end
end
    local function cure2_proc(inst, data)
	if inst.components.sanity.current > 20 then
        inst.components.health:DoDelta(300)
        inst.components.sanity:DoDelta(-20)
        local fx = SpawnPrefab("sparklefx")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1.3, 1.3, 1.3)
        fx.Transform:SetPosition(0, -0.2, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
        fx:ListenForEvent("blocked", fx_hitanim, inst)
        inst.active = true
        inst:DoTaskInTime(--[[Duration]] 5, function()
            fx:RemoveEventCallback("blocked", fx_hitanim, inst)
            if inst:IsValid() then
                inst:DoTaskInTime(--[[Cooldown]] 900, function() inst.active = false 			end)
            end
        end)
    end
end
    local function healshield1_proc(inst, data)
	if inst.components.sanity.current > 3 and inst.components.health:GetPercent() > .7 then
        inst.components.health:DoDelta(6)
        inst.components.sanity:DoDelta(-2)
        local sfx = SpawnPrefab("shock_fx2")
        local fx = SpawnPrefab("sparklefx")
    inst.SoundEmitter:PlaySound("dontstarve/common/lightningrod")
        sfx.entity:SetParent(inst.entity)
	sfx.Transform:SetScale(1.3, 1.3, 1.3)
        sfx.Transform:SetPosition(0, -0.2, 0)
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1.3, 1.3, 1.3)
        fx.Transform:SetPosition(0, -0.2, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
        fx:ListenForEvent("blocked", fx_hitanim, inst)
        inst.active = true
        inst:DoTaskInTime(--[[Duration]] 1, function()
            fx:RemoveEventCallback("blocked", fx_hitanim, inst)
            if inst:IsValid() then
                inst:DoTaskInTime(--[[Cooldown]] 2, function() inst.active = false 			end)
            end
        end)
    end
end
    local function healshield2_proc(inst, data)
	if inst.components.sanity.current > 3 and inst.components.health:GetPercent() > .7 then
        inst.components.health:DoDelta(7)
        inst.components.sanity:DoDelta(-2)
        local sfx = SpawnPrefab("shock_fx2")
        local fx = SpawnPrefab("sparklefx")
    inst.SoundEmitter:PlaySound("dontstarve/common/lightningrod")
        sfx.entity:SetParent(inst.entity)
	sfx.Transform:SetScale(1.3, 1.3, 1.3)
        sfx.Transform:SetPosition(0, -0.2, 0)
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1.3, 1.3, 1.3)
        fx.Transform:SetPosition(0, -0.2, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
        fx:ListenForEvent("blocked", fx_hitanim, inst)
        inst.active = true
        inst:DoTaskInTime(--[[Duration]] 1, function()
            fx:RemoveEventCallback("blocked", fx_hitanim, inst)
            if inst:IsValid() then
                inst:DoTaskInTime(--[[Cooldown]] 2, function() inst.active = false 			end)
            end
        end)
    end
end
    local function healshield3_proc(inst, data)
	if inst.components.sanity.current > 3 and inst.components.health:GetPercent() > .7 then
        inst.components.health:DoDelta(8)
        inst.components.sanity:DoDelta(-2)
        local sfx = SpawnPrefab("shock_fx2")
        local fx = SpawnPrefab("sparklefx")
    inst.SoundEmitter:PlaySound("dontstarve/common/lightningrod")
        sfx.entity:SetParent(inst.entity)
	sfx.Transform:SetScale(1.3, 1.3, 1.3)
        sfx.Transform:SetPosition(0, -0.2, 0)
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1.3, 1.3, 1.3)
        fx.Transform:SetPosition(0, -0.2, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
        fx:ListenForEvent("blocked", fx_hitanim, inst)
        inst.active = true
        inst:DoTaskInTime(--[[Duration]] 1, function()
            fx:RemoveEventCallback("blocked", fx_hitanim, inst)
            if inst:IsValid() then
                inst:DoTaskInTime(--[[Cooldown]] 2, function() inst.active = false 			end)
              end
        end)
    end
end
    local function healshield4_proc(inst, data)
	if inst.components.sanity.current > 3 and inst.components.health:GetPercent() > .7 then
        inst.components.health:DoDelta(9)
        inst.components.sanity:DoDelta(-2)
        local sfx = SpawnPrefab("shock_fx2")
        local fx = SpawnPrefab("sparklefx")
    inst.SoundEmitter:PlaySound("dontstarve/common/lightningrod")
        sfx.entity:SetParent(inst.entity)
	sfx.Transform:SetScale(1.3, 1.3, 1.3)
        sfx.Transform:SetPosition(0, -0.2, 0)
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1.3, 1.3, 1.3)
        fx.Transform:SetPosition(0, -0.2, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
        fx:ListenForEvent("blocked", fx_hitanim, inst)
        inst.active = true
        inst:DoTaskInTime(--[[Duration]] 1, function()
            fx:RemoveEventCallback("blocked", fx_hitanim, inst)
            if inst:IsValid() then
                inst:DoTaskInTime(--[[Cooldown]] 2, function() inst.active = false 			end)
              end
        end)
    end
end

------------------    
local function OnHitfreeze1(inst, data)
local hitfreezechance = 0.1
    local other = data.target
    if math.random() < hitfreezechance then
    if other and other.components.freezable then
        other.components.freezable:AddColdness(0.1)
        other.components.freezable:SpawnShatterFX()
    end
    if other.components.burnable and other.components.burnable:IsBurning() then
        other.components.burnable:Extinguish()
    end
     inst:RemoveEventCallback("onhitother", OnHitfreeze1)
end
end
local function OnHitfreeze2(inst, data)
local hitfreezechance = 0.2
    local other = data.target
    if math.random() < hitfreezechance then
    if other and other.components.freezable then
        other.components.freezable:AddColdness(0.13)
        other.components.freezable:SpawnShatterFX()
    end
    if other.components.burnable and other.components.burnable:IsBurning() then
        other.components.burnable:Extinguish()
    end
     inst:RemoveEventCallback("onhitother", OnHitfreeze2)
end
end
local function OnHitfreeze3(inst, data)
local hitfreezechance = 0.3
    local other = data.target
    if math.random() < hitfreezechance then
    if other and other.components.freezable then
        other.components.freezable:AddColdness(0.16)
        other.components.freezable:SpawnShatterFX()
    end
    if other.components.burnable and other.components.burnable:IsBurning() then
        other.components.burnable:Extinguish()
    end
     inst:RemoveEventCallback("onhitother", OnHitfreeze3)
end
end
local function OnHitfreeze4(inst, data)
local hitfreezechance = 0.4
    local other = data.target
    if math.random() < hitfreezechance then
    if other and other.components.freezable then
        other.components.freezable:AddColdness(0.2)
        other.components.freezable:SpawnShatterFX()
    end
    if other.components.burnable and other.components.burnable:IsBurning() then
        other.components.burnable:Extinguish()
    end
     inst:RemoveEventCallback("onhitother", OnHitfreeze4)
end
end
local function Onframeshield1(attacked, data)
        if data and data.attacker and data.attacker.components.burnable then
            data.attacker.components.health:DoDelta(-15)
            data.attacker.components.burnable:Ignite()
		end
    if data.attacker.components.burnable and data.attacker.components.burnable:IsBurning() then
        data.attacker.components.burnable:Extinguish()
        end 
     inst:RemoveEventCallback("attacked", Onframeshield1)
    end
local function Onframeshield2(attacked, data)
        if data and data.attacker and data.attacker.components.burnable then
            data.attacker.components.health:DoDelta(-30)
            data.attacker.components.burnable:Ignite()
		end
    if data.attacker.components.burnable and data.attacker.components.burnable:IsBurning() then
        data.attacker.components.burnable:Extinguish()
        end 
     inst:RemoveEventCallback("attacked", Onframeshield2)
    end
local function Onframeshield3(attacked, data)
        if data and data.attacker and data.attacker.components.burnable then
            data.attacker.components.health:DoDelta(-45)
            data.attacker.components.burnable:Ignite()
		end
    if data.attacker.components.burnable and data.attacker.components.burnable:IsBurning() then
        data.attacker.components.burnable:Extinguish()
        end 
     inst:RemoveEventCallback("attacked", Onframeshield3)
    end
local function Onframeshield4(attacked, data)
        if data and data.attacker and data.attacker.components.burnable then
            data.attacker.components.health:DoDelta(-60)
            data.attacker.components.burnable:Ignite()
		end
    if data.attacker.components.burnable and data.attacker.components.burnable:IsBurning() then
        data.attacker.components.burnable:Extinguish()
        end 
     inst:RemoveEventCallback("attacked", Onframeshield4)
    end

local function Onfreeze(attacked, data)
        if data and data.attacker and data.attacker.components.freezable then
            data.attacker.components.freezable:AddColdness(0.2)
            data.attacker.components.freezable:SpawnShatterFX()
        end 
    end
local function OnHitlightning1(inst, data)
	do
local other = data.target
   local pos = other:GetPosition()
	GetSeasonManager():DoLightningStrike(pos)
		other.components.health:DoDelta(-50)
	inst.components.health:DoDelta(5,false,"lightning")
        inst.components.sanity:DoDelta(-7)
    if other.components.burnable and other.components.burnable:IsBurning() then
        other.components.burnable:Extinguish()
   		 end
	inst.Light:Enable(false)
inst.AnimState:SetBloomEffectHandle( "" )
inst:RemoveEventCallback("onhitother", OnHitlightning1)
		end
	end

local function OnHitlightning2(inst, data)
	do
local other = data.target
   local pos = other:GetPosition()
	GetSeasonManager():DoLightningStrike(pos)
		other.components.health:DoDelta(-120)
	inst.components.health:DoDelta(15,false,"lightning")
        inst.components.sanity:DoDelta(-7)
    if other.components.burnable and other.components.burnable:IsBurning() then
        other.components.burnable:Extinguish()
   		 end
	inst.Light:Enable(false)
inst.AnimState:SetBloomEffectHandle( "" )
    inst:RemoveEventCallback("onhitother", OnHitlightning2)
		end
	end
local function OnHitcritical1(inst, data)
local hitcriticalchance = 0.02
    local other = data.target
    if math.random() < hitcriticalchance then
        other.components.health:DoDelta(-30)
       local fx = SpawnPrefab("staffcastfx")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(.1, .1, .1)
        fx.Transform:SetPosition(0, 4, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
inst:RemoveEventCallback("onhitother", OnHitcritical1)
    end
end
local function OnHitcritical2(inst, data)
local hitcriticalchance2 = 0.04
    local other = data.target
    if math.random() < hitcriticalchance2 then
        other.components.health:DoDelta(-40)
       local fx = SpawnPrefab("staffcastfx")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(.1, .1, .1)
        fx.Transform:SetPosition(0, 4, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
inst:RemoveEventCallback("onhitother", OnHitcritical2)
    end
end
local function OnHitcritical3(inst, data)
local hitcriticalchance3 = 0.06
    local other = data.target
    if math.random() < hitcriticalchance3 then
        other.components.health:DoDelta(-50)
       local fx = SpawnPrefab("staffcastfx")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(.1, .1, .1)
        fx.Transform:SetPosition(0, 4, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
inst:RemoveEventCallback("onhitother", OnHitcritical3)
    end
end
local function OnHitcritical4(inst, data)
local hitcriticalchance4 = 0.1
    local other = data.target
    if math.random() < hitcriticalchance4 then
        other.components.health:DoDelta(-60)
       local fx = SpawnPrefab("staffcastfx")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(.1, .1, .1)
        fx.Transform:SetPosition(0, 4, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
inst:RemoveEventCallback("onhitother", OnHitcritical4)
    end
end
----------

    local function tryproc(inst)
 if not inst.active and math.random() < .25 and inst:HasTag("healshield1") then
           healshield1_proc(inst)
 elseif not inst.active and math.random() < .3 and inst:HasTag("healshield2") then
           healshield2_proc(inst)
 elseif not inst.active and math.random() < .35 and inst:HasTag("healshield3") then
           healshield3_proc(inst)
 elseif not inst.active and math.random() < .4 and inst:HasTag("healshield4") then
           healshield4_proc(inst)
 	elseif inst.components.health:GetPercent() < .20  and inst:HasTag("lessercure1") then
           lessercure_proc(inst)
 	elseif inst.components.health:GetPercent() < .20  and inst:HasTag("lessercure2") then
           lessercure2_proc(inst)
 elseif inst.components.health:GetPercent() < .15  and inst:HasTag("cure1") then
           cure1_proc(inst)
 elseif inst.components.health:GetPercent() < .15  and inst:HasTag("cure2") then
           cure2_proc(inst)
        end
    end

local shieldchance = .25
local lightningchance = 0.07
local function skillupgrade(inst, data)

				if inst:HasTag("Valkyrieh") and inst.components.sanity.current > 10 and inst:HasTag("Hitlightning1") and math.random() < lightningchance then
	inst.Light:Enable(true)
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	--inst.components.playerlightningtarget:SetHitChance(0.2)
    inst:ListenForEvent("onhitother", OnHitlightning1)

			elseif inst:HasTag("Valkyrieh") and inst.components.sanity.current > 10 and inst:HasTag("Hitlightning2") and math.random() < lightningchance then
	inst.Light:Enable(true)
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	--inst.components.playerlightningtarget:SetHitChance(0.2)
    inst:ListenForEvent("onhitother", OnHitlightning2)

			elseif not inst:HasTag("Valkyrieh") or inst.components.sanity.current < 10 then
	inst.Light:Enable(false)
inst.AnimState:SetBloomEffectHandle( "" )
	--inst.components.playerlightningtarget:SetHitChance(0.3)
    inst:RemoveEventCallback("onhitother", OnHitlightning1)
    inst:RemoveEventCallback("onhitother", OnHitlightning2)

	end

	if inst.components.health then
	if inst:HasTag("hpregen1") then
	inst.components.health:StartRegen(1, 20)
	elseif inst:HasTag("hpregen2") then
	inst.components.health:StartRegen(1, 15)
	elseif inst:HasTag("hpregen3") then
	inst.components.health:StartRegen(1, 10)
	elseif inst:HasTag("hpregen4") then
	inst.components.health:StartRegen(1, 5)
	end

	if math.random() < lightningchance then
	if inst:HasTag("Hitcritical1") then 
    inst:ListenForEvent("onhitother", OnHitcritical1)
	elseif inst:HasTag("Hitcritical2") and not inst:HasTag("Hitcritical1") then
	     inst:RemoveEventCallback("onhitother", OnHitcritical1)
    inst:ListenForEvent("onhitother", OnHitcritical2)
	elseif inst:HasTag("Hitcritical3") and not inst:HasTag("Hitcritical2") then
	     inst:RemoveEventCallback("onhitother", OnHitcritical2)
    inst:ListenForEvent("onhitother", OnHitcritical3)
	elseif inst:HasTag("Hitcritical4") and not inst:HasTag("Hitcritical3") then
	     inst:RemoveEventCallback("onhitother", OnHitcritical3)
    inst:ListenForEvent("onhitother", OnHitcritical4)
	end
if inst.components.health and not inst:HasTag("Valkyrieh") then
	if inst:HasTag("Hitfreeze1") then
    inst:ListenForEvent("onhitother", OnHitfreeze1)
	elseif inst:HasTag("Hitfreeze2") then
	     inst:RemoveEventCallback("onhitother", OnHitfreeze1)
    inst:ListenForEvent("onhitother", OnHitfreeze2)
	elseif inst:HasTag("Hitfreeze3") then
	     inst:RemoveEventCallback("onhitother", OnHitfreeze2)
    inst:ListenForEvent("onhitother", OnHitfreeze3)
	elseif inst:HasTag("Hitfreeze4") then
	     inst:RemoveEventCallback("onhitother", OnHitfreeze3)
    inst:ListenForEvent("onhitother", OnHitfreeze4)
	end
if inst.components.health and inst:HasTag("Valkyrieh") and math.random() < shieldchance then
	if inst:HasTag("Fshield1") then
    inst:ListenForEvent("attacked", Onframeshield1)
	elseif inst:HasTag("Fshield2") then
	     inst:RemoveEventCallback("attacked", Onframeshield1)
    inst:ListenForEvent("attacked", Onframeshield2)
	elseif inst:HasTag("Fshield3") then
	     inst:RemoveEventCallback("attacked", Onframeshield2)
    inst:ListenForEvent("attacked", Onframeshield3)
	elseif inst:HasTag("Fshield4") then
	     inst:RemoveEventCallback("attacked", Onframeshield3)
    inst:ListenForEvent("attacked", Onframeshield4)

end
	if inst.components.health:GetPercent() < .5 then
inst:AddTag("valkyreh")
	elseif inst.components.health:GetPercent() > .5 then
inst:RemoveTag("valkyreh")

end
end
end
end
end
end

local function applystats(inst)

    if GetClock():IsDay() then
		if inst.strength == "full" then	
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.2)
			inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.05)
			inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.05)
			TUNING.SANITY_DAY_GAIN = 10/60

		elseif inst.strength == "normal" then	
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 0.9)
			inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.1)
			inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.1)
			TUNING.SANITY_DAY_GAIN = 3/60

		elseif inst.strength == "Valkyrie" then
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.3)
			inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.3 )
			inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.3 )
			TUNING.SANITY_DAY_GAIN = 3/60

		elseif inst.strength == "berserk" then
			inst.components.temperature.hurtrate = 0
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 0.5)
			inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.4 )
			inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.4 )
			TUNING.SANITY_DAY_GAIN = -25/60
			inst.components.temperature.hurtrate = 0

		end

 	elseif GetClock():IsDusk() then
		if inst.strength == "full" then	
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.1)
			inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1)
			inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1)
			TUNING.SANITY_NIGHT_LIGHT = 5/60
			TUNING.SANITY_NIGHT_MID = 1/60

		elseif inst.strength == "normal" then	
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 0.8)
			inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.1)
			inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.1)
			TUNING.SANITY_NIGHT_LIGHT = -1/60
			TUNING.SANITY_NIGHT_MID = -6/60

		elseif inst.strength == "Valkyrie" then
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.3)
			inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.3)
			inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.3 )
			TUNING.SANITY_NIGHT_LIGHT = -1/60
			TUNING.SANITY_NIGHT_MID = -6/60

		elseif inst.strength == "berserk" then
			inst.components.temperature.hurtrate = 0
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 0.5)
			inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.4 )
			inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.4 )
			TUNING.SANITY_NIGHT_LIGHT = -25/60
			TUNING.SANITY_NIGHT_MID = -25/60
			inst.components.temperature.hurtrate = 0

		end

    elseif GetClock():IsNight() then
		if inst.strength == "full" then	
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 0.9)
			inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.9)
			inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.9)
			TUNING.SANITY_NIGHT_LIGHT = 1/60
			TUNING.SANITY_NIGHT_DARK = -10/60

		elseif inst.strength == "normal" then	
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 0.7)
			inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1)
			inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1)
			TUNING.SANITY_NIGHT_LIGHT = -6/60
			TUNING.SANITY_NIGHT_DARK = -15/60

		elseif inst.strength == "Valkyrie" then
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.3 )
			inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.3)
			inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.3)
			TUNING.SANITY_NIGHT_LIGHT = -6/60
			TUNING.SANITY_NIGHT_DARK = -15/60

		elseif inst.strength == "berserk" then
			inst.components.temperature.hurtrate = 0
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 0.45 )
			inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.4 )
			inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.4 )
			TUNING.SANITY_NIGHT_LIGHT = -25/60
			TUNING.SANITY_NIGHT_DARK = -25/60
			inst.components.temperature.hurtrate = 0

		end	
	end
end

local function phasechange(inst, data)

if inst.components.health:GetPercent() < .6 and inst.components.hunger.current > 60 then
 	inst:AddTag("Valkyrieh") 
elseif inst.components.health:GetPercent() > .6 then
	inst:RemoveTag("Valkyrieh") 
	end

if inst.strength == "full" then

	if inst.components.hunger.current > 40 and inst:HasTag("Valkyrie") and inst:HasTag("Valkyrieh") then
			inst.strength = "Valkyrie"
			inst.AnimState:SetBuild("musha_battle")
inst:RemoveTag("crazy")
    inst.components.combat:SetAttackPeriod(.15)
inst.components.combat:SetAreaDamage(0, 0)
    inst:RemoveEventCallback("attacked", Onfreeze)
inst.components.health.fire_damage_scale = 0
inst.components.temperature.hurtrate = 1

		inst.components.talker:Say("我 是 女 武 神 !")

		elseif inst.components.hunger.current > 40 and inst.components.hunger.current <= 120 and not inst:HasTag("Valkyrieh") then
			inst.strength = "normal"
			inst.AnimState:SetBuild("musha_normal")
inst:RemoveTag("crazy")
    inst.components.combat:SetAttackPeriod(.5)
inst.components.combat:SetAreaDamage(0, 0)
    inst:RemoveEventCallback("attacked", Onfreeze)
inst.components.health.fire_damage_scale = 1
inst.components.temperature.hurtrate = 1

		---inst.components.talker:Say("有 点 饿 了.")

		elseif inst.components.hunger.current < 40 and inst:HasTag("berserk") then
 
			inst.strength = "berserk"
			inst.AnimState:SetBuild("musha_hunger")
inst:AddTag("crazy")
    inst.components.combat:SetAttackPeriod(.05)
inst.components.combat:SetAreaDamage(2, .25)
    inst:ListenForEvent("attacked", Onfreeze)
inst.components.health.fire_damage_scale = 1
inst.components.temperature.hurtrate = 0

			inst.components.talker:Say("唔 啊 啊 啊 啊 啊...")

		end

else
if inst.strength == "Valkyrie" then

		if inst.components.hunger.current > 40 and inst.components.hunger.current < 120 and not inst:HasTag("Valkyrieh") then
			inst.strength = "normal"
			inst.AnimState:SetBuild("musha_normal")
inst:RemoveTag("crazy")
    inst.components.combat:SetAttackPeriod(.5)
inst.components.combat:SetAreaDamage(0, 0)
    inst:RemoveEventCallback("attacked", Onfreeze)
inst.components.health.fire_damage_scale = 1
inst.components.temperature.hurtrate = 1

			inst.components.talker:Say("好 了. 恢 复 健 康")

		elseif inst.components.hunger.current > 120 and not inst:HasTag("Valkyrieh") then
			inst.strength = "full"
			inst.AnimState:SetBuild("musha")
inst:RemoveTag("crazy")
    inst.components.combat:SetAttackPeriod(.6)
inst.components.combat:SetAreaDamage(0, 0)
    inst:RemoveEventCallback("attacked", Onfreeze)
inst.components.health.fire_damage_scale = 0
inst.components.temperature.hurtrate = 1

		inst.components.talker:Say("现 在 安 全 了")

		elseif inst.components.hunger.current < 40 and inst:HasTag("berserk") then
 
			inst.strength = "berserk"
			inst.AnimState:SetBuild("musha_hunger")
inst:AddTag("crazy")
    inst.components.combat:SetAttackPeriod(.05)
inst.components.combat:SetAreaDamage(2, .25)
    inst:ListenForEvent("attacked", Onfreeze)
inst.components.health.fire_damage_scale = 1
inst.components.temperature.hurtrate = 0

			inst.components.talker:Say("唔 啊 啊 啊 啊 啊...")

		end

else
if inst.strength == "normal" then

	if inst.components.hunger.current > 40 and inst:HasTag("Valkyrie") and inst:HasTag("Valkyrieh") then
			inst.strength = "Valkyrie"
			inst.AnimState:SetBuild("musha_battle")
inst:RemoveTag("crazy")
    inst.components.combat:SetAttackPeriod(.15)
inst.components.combat:SetAreaDamage(0, 0)
    inst:RemoveEventCallback("attacked", Onfreeze)
inst.components.health.fire_damage_scale = 0
inst.components.temperature.hurtrate = 1

		inst.components.talker:Say("战 斗 !!")

		elseif inst.components.hunger.current > 120 and not inst:HasTag("Valkyrieh") then
			inst.strength = "full"
			inst.AnimState:SetBuild("musha")
inst:RemoveTag("crazy")
    inst.components.combat:SetAttackPeriod(.6)
inst.components.combat:SetAreaDamage(0, 0)
    inst:RemoveEventCallback("attacked", Onfreeze)
inst.components.health.fire_damage_scale = 0

		--inst.components.talker:Say("心 情 愉 快 !")

	elseif inst.components.hunger.current < 40 and inst:HasTag("berserk") then
 
			inst.strength = "berserk"
			inst.AnimState:SetBuild("musha_hunger")
inst:AddTag("crazy")
    inst.components.combat:SetAttackPeriod(.05)
inst.components.combat:SetAreaDamage(2, .25)
    inst:ListenForEvent("attacked", Onfreeze)
inst.components.health.fire_damage_scale = 1
inst.components.temperature.hurtrate = 0

			inst.components.talker:Say("唔 啊 啊 啊 啊...")

		end
else
if inst.strength == "berserk" then
	if inst.components.hunger.current > 40 and inst:HasTag("Valkyrie") and inst:HasTag("Valkyrieh") then
			inst.strength = "Valkyrie"
			inst.AnimState:SetBuild("musha_battle")
inst:RemoveTag("crazy")
    inst.components.combat:SetAttackPeriod(.15)
inst.components.combat:SetAreaDamage(0, 0)
    inst:RemoveEventCallback("attacked", Onfreeze)
inst.components.health.fire_damage_scale = 0
inst.components.temperature.hurtrate = 1

		inst.components.talker:Say("来 吧!!")

	elseif inst.components.hunger.current > 120 and not inst:HasTag("Valkyrieh") then
			inst.strength = "full"
			inst.AnimState:SetBuild("musha")
inst:RemoveTag("crazy")
    inst.components.combat:SetAttackPeriod(.6)
inst.components.combat:SetAreaDamage(0, 0)
    inst:RemoveEventCallback("attacked", Onfreeze)
inst.components.health.fire_damage_scale = 0
inst.components.temperature.hurtrate = 1

		inst.components.talker:Say("... 我 不 记 得 我 吃 了 什 么?")

	elseif inst.components.hunger.current > 40 and inst.components.hunger.current < 120 and not inst:HasTag("Valkyrieh") then
			inst.strength = "normal"
			inst.AnimState:SetBuild("musha_normal")
inst:RemoveTag("crazy")
    inst.components.combat:SetAttackPeriod(.5)
inst.components.combat:SetAreaDamage(0, 0)
    inst:RemoveEventCallback("attacked", Onfreeze)
inst.components.health.fire_damage_scale = 1
inst.components.temperature.hurtrate = 1

		inst.components.talker:Say("有 点 累 了..")

		end

	end
	end
	end
end
	
	applystats(inst)
end

local fn = function(inst)

	inst.soundsname = "willow"
    inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha.tex" )
	inst.level = 0
	inst.components.eater:SetOnEatFn(expeat)
inst:ListenForEvent("levelup", levelexp)
	inst.strength = "full"
	inst.components.health:SetMaxHealth(70)
	inst.components.hunger:SetMax(100)
	--inst.components.hunger:SetMax(210)
        inst.components.sanity:SetMax(120)
 inst.components.combat.damagemultiplier = TUNING.WENDY_DAMAGE_MULT
-----------
inst:AddTag("musha")
    inst.entity:AddLight()
	inst.Light:SetRadius(.3)
    inst.Light:SetFalloff(.5)
    inst.Light:SetIntensity(.3)
    inst.Light:SetColour(15/255,15/255,15/255)

        inst.procfn = function() tryproc(inst) end
        inst:ListenForEvent("attacked", inst.procfn)

	inst:AddComponent("playerlightningtarget")
--inst:AddTag("Berserk")
--------------------------------------------------------------
--test bird
--[[
    inst:AddComponent("childspawner")
    inst.components.childspawner.childname = "musha_tall2"
    inst.components.childspawner:StartSpawning()
    inst.components.childspawner.maxchildren = 1
]]--
    ----------------------------------------------------------
   -- inst.userfunctions =    {updatestats = updatestats}
	-- eater
    inst.components.eater:SetOmnivore()

	inst.components.eater.strongstomach = true

	inst:ListenForEvent( "dusktime", function() applystats(inst) end , GetWorld())
        inst:ListenForEvent( "daytime", function() applystats(inst) end , GetWorld())
        inst:ListenForEvent( "nighttime", function() applystats(inst) end , GetWorld())
         applystats(inst)

	inst:AddComponent("reader")
    inst.components.eater.stale_hunger = TUNING.WICKERBOTTOM_STALE_FOOD_HUNGER
    inst.components.eater.stale_health = TUNING.WICKERBOTTOM_STALE_FOOD_HEALTH
    inst.components.eater.spoiled_hunger = TUNING.WICKERBOTTOM_SPOILED_FOOD_HUNGER
    inst.components.eater.spoiled_health = TUNING.WICKERBOTTOM_SPOILED_FOOD_HEALTH

	inst.components.builder.science_bonus = 1
	local booktab = {str = STRINGS.TABS.BOOKS, sort=999, icon = "tab_book.tex"}
	inst.components.builder:AddRecipeTab(booktab)

	Recipe("book_birds", {Ingredient("papyrus", 2), Ingredient("bird_egg", 2)}, booktab, {SCIENCE = 0, MAGIC = 0, ANCIENT = 0})
	Recipe("book_gardening", {Ingredient("papyrus", 2), Ingredient("seeds", 1), Ingredient("poop", 1)}, booktab, {SCIENCE = 1})
	Recipe("book_sleep", {Ingredient("papyrus", 2), Ingredient("nightmarefuel", 2)}, booktab, {MAGIC = 2})
	Recipe("book_brimstone", {Ingredient("papyrus", 2), Ingredient("redgem", 1)}, booktab, {MAGIC = 3})
	Recipe("book_tentacles", {Ingredient("papyrus", 2), Ingredient("tentaclespots", 1)}, booktab, {SCIENCE = 3})

	inst.OnSave = onsave
	inst.OnPreLoad = onpreload

    inst:ListenForEvent("entity_death", function(wrld, data) onkilll(inst, data) end, GetWorld())

inst:ListenForEvent( "healthdelta", skillupgrade)
inst:ListenForEvent("hungerdelta", phasechange)

    return inst

end


--------------------------------------------------------------

STRINGS.CHARACTER_TITLES.musha = "精 灵 公 主"
STRINGS.CHARACTER_NAMES.musha = "musha"
STRINGS.CHARACTER_DESCRIPTIONS.musha = "[有 4 个 阶 段 的 变 化]\n[升 级 之 后 可 以 获 得 新 的 能 力]\n[可 以 成 长 的 特 殊 宠 物]"
STRINGS.CHARACTER_QUOTES.musha = "\" 我 是 一 个 快 乐 的 公 主 \""
STRINGS.CHARACTERS.musha = {}
STRINGS.CHARACTERS.musha.DESCRIBE = {}


return MakePlayerCharacter("musha", prefabs, assets, fn, start_inv)
