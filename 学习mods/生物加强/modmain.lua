GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})
local BOSS_PERIOD = GetModConfigData("boss_period")
local BIOLOGY_PERIOD = GetModConfigData("biology_period")
local ARMOUR_ARMOR = GetModConfigData("armour_armor")
local MORE_STRENGTHENING = GetModConfigData("more_strengthening")

--血量（BOSS）
TUNING.DRAGONFLY_HEALTH = 27500 * GetModConfigData("health_boss")                            --龙蝇
TUNING.BEARGER_HEALTH = 3000 * 2 * GetModConfigData("health_boss")                           --熊大
TUNING.DEERCLOPS_HEALTH = 2000 * 2 * GetModConfigData("health_boss")                         --巨鹿
TUNING.MOOSE_HEALTH = 3000 * 2 * GetModConfigData("health_boss")                             --鹿角鹅
TUNING.MOSSLING_HEALTH = 350 * 1.5 * GetModConfigData("health_boss")                         --小鸭子
TUNING.MINOTAUR_HEALTH = 2500 * 4 * GetModConfigData("health_boss")                          --远古守护者
TUNING.BEEQUEEN_HEALTH = 22500 * GetModConfigData("health_boss")                             --蜂后
TUNING.TOADSTOOL_HEALTH = 52500 * GetModConfigData("health_boss")                            --普通蛤蟆
TUNING.TOADSTOOL_DARK_HEALTH = 99999 * GetModConfigData("health_boss")                       --毒蛤蟆
TUNING.SPIDERQUEEN_HEALTH = 1250 * 2 * GetModConfigData("health_boss")                       --蜘蛛女皇
TUNING.LEIF_HEALTH = 2000 * 1.5 * GetModConfigData("health_boss")                            --树精
TUNING.WARG_HEALTH = 600 * 3 * GetModConfigData("health_boss")                               --座狼
TUNING.SPAT_HEALTH = 800 * GetModConfigData("health_boss")                                   --钢羊
TUNING.WALRUS_HEALTH = 150 * 2 * GetModConfigData("health_boss")                             --海象
--血量（生物）
TUNING.KOALEFANT_HEALTH = 500 * 2 * GetModConfigData("health_biology")                          --大象
TUNING.TALLBIRD_HEALTH = 400 * 2 * GetModConfigData("health_biology")                           --高脚鸟
TUNING.TENTACLE_HEALTH = 500 * GetModConfigData("health_biology")                               --触手
TUNING.MERM_HEALTH = 250 * 2 * GetModConfigData("health_biology")                               --鱼人
TUNING.WORM_HEALTH = 900 * GetModConfigData("health_biology")                                   --蠕虫
TUNING.WEREPIG_HEALTH = 350 * 1.5 * GetModConfigData("health_biology")                          --疯猪
TUNING.SPIDER_HEALTH = 100 * GetModConfigData("health_biology")                                 --小蜘蛛
TUNING.SPIDER_WARRIOR_HEALTH = 200 * 2 * GetModConfigData("health_biology")                     --蜘蛛战士，白蜘蛛
TUNING.SPIDER_HIDER_HEALTH = 150 * 1.5 * GetModConfigData("health_biology")                     --洞穴蜘蛛
TUNING.SPIDER_SPITTER_HEALTH = 175 * 2 * GetModConfigData("health_biology")                     --喷吐蜘蛛
TUNING.HOUND_HEALTH = 150 * GetModConfigData("health_biology")                                  --狗
TUNING.FIREHOUND_HEALTH = 100 * GetModConfigData("health_biology")                              --火狗
TUNING.ICEHOUND_HEALTH = 100 * GetModConfigData("health_biology")                               --冰狗

--伤害（boss）
TUNING.DRAGONFLY_DAMAGE = 150 * GetModConfigData("damage_boss")                              --龙蝇
TUNING.DRAGONFLY_FIRE_DAMAGE = 300 * GetModConfigData("damage_boss")                         --暴怒龙蝇
TUNING.BEARGER_DAMAGE = 200 * GetModConfigData("damage_boss")                                --熊大
TUNING.DEERCLOPS_DAMAGE = 150 * GetModConfigData("damage_boss")                              --巨鹿
TUNING.MOOSE_DAMAGE = 150 * GetModConfigData("damage_boss")                                  --鹿角鹅
TUNING.MINOTAUR_DAMAGE = 100 * GetModConfigData("damage_boss")                               --远古守护者
TUNING.BEEQUEEN_DAMAGE = 120 * GetModConfigData("damage_boss")                               --蜂后
TUNING.SPIDERQUEEN_DAMAGE = 80 * GetModConfigData("damage_boss")                             --蜘蛛女皇
TUNING.LEIF_DAMAGE = 150 * GetModConfigData("damage_boss")                                   --树精
TUNING.WARG_DAMAGE = 50 * GetModConfigData("damage_boss")                                    --座狼
TUNING.SPAT_MELEE_DAMAGE = 60 * GetModConfigData("damage_boss")                              --钢羊
TUNING.WALRUS_DAMAGE = 33 * GetModConfigData("damage_boss")                                  --海象
--伤害（生物）
TUNING.KOALEFANT_DAMAGE = 50 * GetModConfigData("damage_biology")                               --象
TUNING.TALLBIRD_DAMAGE = 50 * GetModConfigData("damage_biology")                                --高脚鸟
TUNING.TENTACLE_DAMAGE = 34 * GetModConfigData("damage_biology")                                --触手
TUNING.MERM_DAMAGE = 30 * GetModConfigData("damage_biology")                                    --鱼人
TUNING.WORM_DAMAGE = 75 * GetModConfigData("damage_biology")                                    --蠕虫
TUNING.WEREPIG_DAMAGE = 40 * GetModConfigData("damage_biology")                                 --疯猪
TUNING.SPIDER_DAMAGE = 20 * GetModConfigData("damage_biology")                                  --小蜘蛛
TUNING.SPIDER_WARRIOR_DAMAGE = 20 * GetModConfigData("damage_biology")                          --蜘蛛战士，白蜘蛛
TUNING.SPIDER_HIDER_DAMAGE = 20 * GetModConfigData("damage_biology")                            --洞穴蜘蛛
TUNING.SPIDER_SPITTER_DAMAGE_MELEE = 20 * GetModConfigData("damage_biology")                    --喷吐蜘蛛近战伤害
TUNING.HOUND_DAMAGE = 20 * GetModConfigData("damage_biology")                                   --狗
TUNING.FIREHOUND_DAMAGE = 30 * GetModConfigData("damage_biology")                               --火狗
TUNING.ICEHOUND_DAMAGE = 30 * GetModConfigData("damage_biology")                                --冰狗

--攻击间隔
if BOSS_PERIOD then                                           --boss
   TUNING.DRAGONFLY_ATTACK_PERIOD = 1                         --龙蝇
   TUNING.DRAGONFLY_FIRE_ATTACK_PERIOD = 1                    --暴怒龙蝇
   TUNING.BEARGER_ATTACK_PERIOD = 1                           --熊大
   TUNING.DEERCLOPS_ATTACK_PERIOD = 1                         --巨鹿
   TUNING.MOOSE_ATTACK_PERIOD = 1                             --鹿角鹅
   TUNING.MINOTAUR_ATTACK_PERIOD = 1                          --远古守护者
   TUNING.BEEQUEEN_ATTACK_PERIOD = 1                          --蜂后
   TUNING.SPIDERQUEEN_ATTACKPERIOD = 1                        --蜘蛛女皇
   TUNING.LEIF_ATTACK_PERIOD = 1                              --树精
   TUNING.WARG_ATTACKPERIOD = 1                               --座狼
   TUNING.WALRUS_ATTACK_PERIOD = 1                            --海象
end

if BIOLOGY_PERIOD then                                        --生物
   TUNING.TALLBIRD_ATTACK_PERIOD = 1                          --高脚鸟
   TUNING.MERM_ATTACK_PERIOD = 1                              --鱼人
   TUNING.WORM_ATTACK_PERIOD = 1                              --蠕虫
   TUNING.WEREPIG_ATTACK_PERIOD = 1                           --疯猪
   TUNING.SPIDER_ATTACK_PERIOD = 1                            --小蜘蛛
   TUNING.SPIDER_WARRIOR_ATTACK_PERIOD = 1                    --蜘蛛战士，白蜘蛛
   TUNING.SPIDER_HIDER_ATTACK_PERIOD = 1                      --洞穴蜘蛛
   TUNING.SPIDER_SPITTER_ATTACK_PERIOD = 1                    --喷吐蜘蛛
   TUNING.HOUND_ATTACK_PERIOD = 1                             --狗
   TUNING.FIREHOUND_ATTACK_PERIOD = 1                         --火狗
   TUNING.ICEHOUND_ATTACK_PERIOD = 1                          --冰狗
end

--护甲（BOSS）
TUNING.BOSS_ARMOR = GetModConfigData("boss_armor")
local function boss_a(inst)
     if inst.components.health then
        inst.components.health:SetAbsorptionAmount(TUNING.BOSS_ARMOR)
	 end
end
AddPrefabPostInit("dragonfly", boss_a)      --龙蝇
AddPrefabPostInit("bearger", boss_a)        --熊大
AddPrefabPostInit("deerclops", boss_a)      --巨鹿
AddPrefabPostInit("moose", boss_a)          --鹿角鹅
AddPrefabPostInit("mossling", boss_a)       --小鸭子
AddPrefabPostInit("minotaur", boss_a)       --远古守护者
AddPrefabPostInit("beequeen", boss_a)       --蜂后
AddPrefabPostInit("toadstool", boss_a)      --普通蛤蟆
AddPrefabPostInit("toadstool_dark", boss_a) --毒蛤蟆
AddPrefabPostInit("spiderqueen", boss_a)    --蜘蛛女皇
AddPrefabPostInit("leif", boss_a)           --树精
AddPrefabPostInit("leif_sparse", boss_a)    --稀有树精
AddPrefabPostInit("warg", boss_a)           --座狼
AddPrefabPostInit("spat", boss_a)           --钢羊
AddPrefabPostInit("walrus", boss_a)         --海象
--护甲（生物）
TUNING.BIOLOGY_ARMOR = GetModConfigData("biology_armor")
local function biology_a(inst)
     if inst.components.health then
        inst.components.health:SetAbsorptionAmount(TUNING.BIOLOGY_ARMOR)
	 end
end
AddPrefabPostInit("koalefant_winter", biology_a) --冬象
AddPrefabPostInit("koalefant_summer", biology_a) --夏象
AddPrefabPostInit("tallbird", biology_a)         --高脚鸟
AddPrefabPostInit("tentacle", biology_a)         --触手
AddPrefabPostInit("merm", biology_a)             --鱼人
AddPrefabPostInit("worm", biology_a)             --蠕虫
AddPrefabPostInit("pigman", biology_a)           --猪人
AddPrefabPostInit("spider", biology_a)           --小蜘蛛
AddPrefabPostInit("spider_warrior", biology_a)   --蜘蛛战士
AddPrefabPostInit("spider_dropper", biology_a)   --白蜘蛛
AddPrefabPostInit("spider_hider", biology_a)     --洞穴蜘蛛
AddPrefabPostInit("spider_spitter", biology_a)   --喷吐蜘蛛
AddPrefabPostInit("hound", biology_a)            --狗
AddPrefabPostInit("firehound", biology_a)        --火狗
AddPrefabPostInit("icehound", biology_a)         --冰狗

--回血（BOSS）
TUNING.BOSS_REGEN = GetModConfigData("boss_regen")
local function boss_h(inst)
     if inst.components.health then
        inst.components.health:StartRegen(TUNING.BOSS_REGEN, 1)	
	 end
end
AddPrefabPostInit("dragonfly", boss_h)      --龙蝇
AddPrefabPostInit("bearger", boss_h)        --熊大
AddPrefabPostInit("deerclops", boss_h)      --巨鹿
AddPrefabPostInit("moose", boss_h)          --鹿角鹅
AddPrefabPostInit("mossling", boss_h)       --小鸭子
AddPrefabPostInit("minotaur", boss_h)       --远古守护者
AddPrefabPostInit("beequeen", boss_h)       --蜂后
AddPrefabPostInit("toadstool", boss_h)      --普通蛤蟆
AddPrefabPostInit("toadstool_dark", boss_h) --毒蛤蟆
AddPrefabPostInit("spiderqueen", boss_h)    --蜘蛛女皇
AddPrefabPostInit("leif", boss_h)           --树精
AddPrefabPostInit("leif_sparse", boss_h)    --稀有树精
AddPrefabPostInit("warg", boss_h)           --座狼
AddPrefabPostInit("spat", boss_h)           --钢羊
AddPrefabPostInit("walrus", boss_h)         --海象
--回血（生物）
TUNING.BIOLOGY_REGEN = GetModConfigData("biology_regen")
local function biology_h(inst)
     if inst.components.health then
        inst.components.health:StartRegen(TUNING.BIOLOGY_REGEN, 1)	
	 end
end
AddPrefabPostInit("koalefant_winter", biology_h) --冬象
AddPrefabPostInit("koalefant_summer", biology_h) --夏象
AddPrefabPostInit("tallbird", biology_h)         --高脚鸟
AddPrefabPostInit("tentacle", biology_h)         --触手
AddPrefabPostInit("merm", biology_h)             --鱼人
AddPrefabPostInit("worm", biology_h)             --蠕虫
AddPrefabPostInit("pigman", biology_h)           --猪人
AddPrefabPostInit("spider", biology_h)           --小蜘蛛
AddPrefabPostInit("spider_warrior", biology_h)   --蜘蛛战士
AddPrefabPostInit("spider_dropper", biology_h)   --白蜘蛛
AddPrefabPostInit("spider_hider", biology_h)     --洞穴蜘蛛
AddPrefabPostInit("spider_spitter", biology_h)   --喷吐蜘蛛
AddPrefabPostInit("hound", biology_h)            --狗
AddPrefabPostInit("firehound", biology_h)        --火狗
AddPrefabPostInit("icehound", biology_h)         --冰狗

--护甲血量
TUNING.ARMORGRASS = 158*GetModConfigData("armour_health")            --草甲血量
TUNING.ARMORWOOD = 315*GetModConfigData("armour_health")             --木甲血量
TUNING.ARMORMARBLE = 735*GetModConfigData("armour_health")           --大理石甲血量
TUNING.ARMORSNURTLESHELL = 735*GetModConfigData("armour_health")     --蜗牛甲血量
TUNING.ARMORRUINS = 1260*GetModConfigData("armour_health")           --远古甲血量
TUNING.ARMOR_FOOTBALLHAT = 315*GetModConfigData("armour_health")     --猪皮帽血量
TUNING.ARMORDRAGONFLY = 945*GetModConfigData("armour_health")        --火甲血量
TUNING.ARMOR_WATHGRITHRHAT = 525*GetModConfigData("armour_health")   --战斗头盔血量
TUNING.ARMOR_RUINSHAT = 840*GetModConfigData("armour_health")        --远古头血量
TUNING.ARMOR_SLURTLEHAT = 525*GetModConfigData("armour_health")      --蜗牛帽血量
TUNING.ARMOR_BEEHAT = 1050*GetModConfigData("armour_health")         --蜂帽血量
TUNING.ARMOR_SANITY = 525*GetModConfigData("armour_health")          --影甲血量

--护甲减伤
if ARMOUR_ARMOR then
   TUNING.ARMORGRASS_ABSORPTION = .7                --草甲减伤
   TUNING.ARMORWOOD_ABSORPTION = .85                --木甲减伤
   --TUNING.ARMORMARBLE_ABSORPTION = .95            --大理石减伤
   TUNING.ARMORSNURTLESHELL_ABSORPTION = 0.7        --蜗牛甲减伤
   TUNING.ARMORRUINS_ABSORPTION = 0.95              --远古甲减伤
   TUNING.ARMOR_FOOTBALLHAT_ABSORPTION = .85        --猪皮帽减伤
   TUNING.ARMORDRAGONFLY_ABSORPTION = 0.8           --火甲减伤
   TUNING.ARMOR_WATHGRITHRHAT_ABSORPTION = .85      --战斗头盔减伤
   TUNING.ARMOR_RUINSHAT_ABSORPTION = 0.95          --远古头减伤
   --TUNING.ARMOR_SLURTLEHAT_ABSORPTION = 0.9       --蜗牛帽减伤
   TUNING.ARMOR_BEEHAT_ABSORPTION = .9              --蜂帽减伤
   --TUNING.ARMOR_SANITY_ABSORPTION = .95           --影甲减伤
end


--武器伤害
   TUNING.NIGHTSWORD_DAMAGE = 34*2*GetModConfigData("arms_damage")                          --影刀
   TUNING.BATBAT_DAMAGE = 34*1.25*GetModConfigData("arms_damage")                           --蝙蝠棒
   TUNING.SPIKE_DAMAGE = 34*1.5*GetModConfigData("arms_damage")                             --触手尖刺
   TUNING.SPEAR_DAMAGE = 34*GetModConfigData("arms_damage")                                 --长矛
   TUNING.WATHGRITHR_SPEAR_DAMAGE = 34*1.25*GetModConfigData("arms_damage")                 --战斗长矛
   TUNING.CANE_DAMAGE = 34*.5*GetModConfigData("arms_damage")                               --步行手杖
   TUNING.RUINS_BAT_DAMAGE = 34*1.75*GetModConfigData("arms_damage")                        --远古武器
   TUNING.NIGHTSTICK_DAMAGE = 34*.85*GetModConfigData("arms_damage")                        --晨星
--武器耐久
   TUNING.NIGHTSWORD_USES = 100*GetModConfigData("arms_uses")                         --影刀
   TUNING.BATBAT_USES = 75*GetModConfigData("arms_uses")                              --蝙蝠棒
   TUNING.SPIKE_USES = 100*GetModConfigData("arms_uses")                              --触手尖刺
   TUNING.SPEAR_USES = 150*GetModConfigData("arms_uses")                              --长矛
   TUNING.WATHGRITHR_SPEAR_USES = 200*GetModConfigData("arms_uses")                   --战斗长矛
   TUNING.RUINS_BAT_USES = 150*GetModConfigData("arms_uses")                          --远古棒

--斧镐
TUNING.MULTITOOL_AXE_PICKAXE_USES = 300000000000000000000
AddPrefabPostInit("multitool_axe_pickaxe", function(inst)
  if inst.components.equippable then
	 inst.components.equippable.walkspeedmult = 1.1
  end
end)

if MORE_STRENGTHENING then
--龙蝇
AddPrefabPostInit("dragonfly", function(inst)
     if inst.Transform then
        inst.Transform:SetScale(1.3*1.5, 1.3*1.5, 1.3*1.5)
	    GLOBAL.MakeFlyingGiantCharacterPhysics(inst, 500*1.5, 1.4*1.5)
	 end
end)

--熊大
AddPrefabPostInit("bearger", function(inst)
     if inst.Transform then
        inst.Transform:SetScale(1*1.5, 1*1.5, 1*1.5)
	    GLOBAL.MakeGiantCharacterPhysics(inst, 1000*1.5, 1.5*1.5)
	 end
end)

--巨鹿
AddPrefabPostInit("deerclops", function(inst)
     if inst.Transform then
        inst.Transform:SetScale(1.65*1.5, 1.65*1.5, 1.65*1.5)
        GLOBAL.MakeGiantCharacterPhysics(inst, 1000*1.5, .5*1.5)
	 end
end)

--鹿角鹅
AddPrefabPostInit("moose", function(inst)
     if inst.Transform then
        inst.Transform:SetScale(1.55*1.5,1.55*1.5,1.55*1.5)
        GLOBAL.MakeGiantCharacterPhysics(inst, 5000*1.5, 1*1.5)
	 end
end)

--远古守护者
AddPrefabPostInit("minotaur", function(inst)
     if inst.Transform then
        inst.Transform:SetScale(1*1.5, 1*1.5, 1*1.5)
        GLOBAL.MakeCharacterPhysics(inst, 100*1.5, 2.2*1.5)
	 end
end)

--蜂后
AddPrefabPostInit("beequeen", function(inst)
     if inst.Transform then
        inst.Transform:SetScale(1.4*1.5, 1.4*1.5, 1.4*1.5)
        GLOBAL.MakeFlyingGiantCharacterPhysics(inst, 500*1.5, 1.4*1.5)
	 end
end)

--蜘蛛女王
AddPrefabPostInit("spiderqueen", function(inst)
     if inst.Transform then
        inst.Transform:SetScale(1*1.5, 1*1.5, 1*1.5)
        GLOBAL.MakeCharacterPhysics(inst, 1000*1.5, 1*1.5)
	 end
end)

--树精
local function leif_model(inst)
     if inst.Transform then
        inst.Transform:SetScale(1*1.5, 1*1.5, 1*1.5)
        GLOBAL.MakeCharacterPhysics(inst, 1000*1.5, .5*1.5)
	 end
end
AddPrefabPostInit("leif", leif_model)           --树精
AddPrefabPostInit("leif_sparse", leif_model)    --稀有树精


--座狼
AddPrefabPostInit("warg", function(inst)
     if inst.Transform then
        inst.Transform:SetScale(1*1.5, 1*1.5, 1*1.5)
        GLOBAL.MakeCharacterPhysics(inst, 1000*1.5, 1*1.5)
	 end
end)

--钢羊
AddPrefabPostInit("spat", function(inst)
     if inst.Transform then
        inst.Transform:SetScale(1*1.5, 1*1.5, 1*1.5)
	 end
end)

--海象
AddPrefabPostInit("walrus", function(inst)
     if inst.Transform then
        inst.Transform:SetScale(1.5*1.5, 1.5*1.5, 1.5*1.5)
        GLOBAL.MakeCharacterPhysics(inst, 50*1.5, .5*1.5)
	 end
end)


--龙蝇
TUNING.DRAGONFLY_ATTACK_RANGE = 7                          --攻击范围（攻击距离） 
TUNING.DRAGONFLY_SPEED = 7                                 --移动速度
TUNING.DRAGONFLY_FIRE_HIT_RANGE = 8                        --暴怒打击范围
TUNING.DRAGONFLY_FIRE_SPEED = 8                            --暴怒移动速度
TUNING.DRAGONFLY_STUN = 3750                               --判定伤害（5秒内打出1250伤害）
TUNING.DRAGONFLY_STUN_PERIOD = 5                           --判定时间（5秒内打出1250伤害）
TUNING.DRAGONFLY_STUN_DURATION = 10                        --眩晕持续时间
TUNING.DRAGONFLY_BREAKOFF_DAMAGE = 7500                    --掉龙鳞伤害
TUNING.DRAGONFLY_POUND_CD = 10                             --暴怒三连CD

--熊大
TUNING.BEARGER_CALM_WALK_SPEED = 4                         --正常行走速度
TUNING.BEARGER_ANGRY_WALK_SPEED = 7                        --激怒行走速度？
TUNING.BEARGER_RUN_SPEED = 11                              --跑动速度？
TUNING.BEARGER_MELEE_RANGE = 9                             --近战范围
TUNING.BEARGER_ATTACK_RANGE = 9                            --攻击范围

--巨鹿
TUNING.DEERCLOPS_ATTACK_RANGE = 10                          --攻击范围（攻击有效范围）
TUNING.DEERCLOPS_AOE_RANGE = 15                             --技能范围（AOE）

--鹿角鹅
TUNING.MOOSE_WALK_SPEED = 10                               --正常移动速度（跳跃距离）
TUNING.MOOSE_RUN_SPEED = 14                                --攻击移动速度（跳跃距离）
TUNING.MOOSE_ATTACK_RANGE = 8                              --攻击范围（攻击有效范围）

--远古守护者
TUNING.MINOTAUR_RUN_SPEED = 25                             --跑动速度

--蜂后
TUNING.BEEQUEEN_ATTACK_RANGE = 6                           --攻击范围
TUNING.BEEQUEEN_HIT_RANGE = 8                              --打击范围（伤害有效范围）
TUNING.BEEQUEEN_SPEED = 6                                  --移动
TUNING.BEEQUEEN_MIN_GUARDS_PER_SPAWN = 6                   --小蜜蜂最小召唤数量
TUNING.BEEQUEEN_MAX_GUARDS_PER_SPAWN = 8                   --小蜜蜂最大召唤数量
TUNING.BEEQUEEN_TOTAL_GUARDS = 12                          --判定是否召唤小蜜蜂数量（达到8只则不召唤，低于8只则召唤）
 
--蛤蟆、毒蛤蟆
TUNING.TOADSTOOL_DEAGGRO_DIST = 12                         --丢失仇恨范围
TUNING.TOADSTOOL_AGGRO_DIST = 8                            --仇恨范围
TUNING.TOADSTOOL_MUSHROOMBOMB_RADIUS = 5                   --蘑菇炸弹半径
TUNING.TOADSTOOL_SPORECLOUD_DAMAGE = 30                    --孢子云伤害
TUNING.TOADSTOOL_SPORECLOUD_RADIUS = 4                     --孢子云半径
TUNING.TOADSTOOL_SPORECLOUD_LIFETIME = 120                 --孢子云持续时间
TUNING.TOADSTOOL_MUSHROOMSPROUT_CHOPS = 15                 --蘑菇树砍掉所需次数
TUNING.TOADSTOOL_DARK_MUSHROOMSPROUT_CHOPS = 20            --毒蛤蟆蘑菇树砍掉所需次数

--蜘蛛女王
TUNING.SPIDERQUEEN_WALKSPEED = 3                           --移动速度
TUNING.SPIDERQUEEN_ATTACKRANGE = 7                         --攻击范围

--座狼
TUNING.WARG_RUNSPEED = 7                                   --移动速度
TUNING.WARG_ATTACKRANGE = 7                                --攻击范围

--海象
TUNING.WALRUS_ATTACK_DIST = 20                             --攻击距离
TUNING.WALRUS_TARGET_DIST = 20                             --仇很范围

end

--大箱子生成
--另一个复杂的写法，暂时用不上，备用
--local  function panding(inst)  --判定生物和血量
--   if inst.components.health and inst.components.combat then	--这个是大前提  只有满足这个体检才会执行下面的掉落箱子的操作
--		if inst.prefab ==  龙鹰 then
--			if	inst.components.health.maxhealth >= 27500*2 and  
--			inst.components.combat.min_attack_period == 1 and                  --这个是大前提  只有满足这个条件才会执行下面的掉落箱子的操作
--			inst.components.combat.defaultdamage > 300 then
--			dospawnchest(inst) --满足条件就掉落
--			end
--		elseif inst.prefab ==  熊 then
--			if	inst.components.health.maxhealth >= 27500*2 and  
--			inst.components.combat.min_attack_period == 1 and                  --这个是大前提  只有满足这个条件才会执行下面的掉落箱子的操作
--			inst.components.combat.defaultdamage > 300 then
--			dospawnchest(inst) --满足条件就掉落
--			end
--		end
--	end
--end
--local function big_box(inst)
--      inst:ListenForEvent("death", death)
--	    inst:ListenForEvent("death", function()
--		inst:DoTaskInTime(3, panding) --这里改成判定生物
--		end)
--end
if TUNING.DRAGONFLY_HEALTH >= 27500*2 and
   TUNING.DRAGONFLY_DAMAGE >= 300 and
   TUNING.DRAGONFLY_ATTACK_PERIOD == 1 then

local function dospawnchest(inst)                                     --生成音效
     inst.SoundEmitter:PlaySound("dontstarve/common/ghost_spawn")

     local chest =SpawnPrefab("minotaurchest")                         --生成地点
     local x, y, z = inst.Transform:GetWorldPosition()
     chest.Transform:SetPosition(x, 0, z)

     local fx = SpawnPrefab("statue_transition_2")                     --生成特效1
     if fx ~= nil then
        fx.Transform:SetPosition(x, y, z)
        fx.Transform:SetScale(1, 2, 1)
     end

     fx = SpawnPrefab("statue_transition")                             --生成特效2
     if fx ~= nil then
        fx.Transform:SetPosition(x, y, z)
        fx.Transform:SetScale(1, 1.5, 1)
     end

     chest:AddComponent("scenariorunner")                              --运行组件
     chest.components.scenariorunner:SetScript("chest_minotaur")
     chest.components.scenariorunner:Run()
end

local function big_box(inst)
        inst:ListenForEvent("death", death)
	    inst:ListenForEvent("death", function()
		inst:DoTaskInTime(3, dospawnchest)
		end)
end
AddPrefabPostInit("dragonfly", big_box)      --龙蝇
AddPrefabPostInit("bearger", big_box)        --熊大
AddPrefabPostInit("deerclops", big_box)      --巨鹿
AddPrefabPostInit("moose", big_box)          --鹿角鹅
AddPrefabPostInit("beequeen", big_box)       --蜂后


AddPrefabPostInit("minotaurchest",function(inst)
	if not TheWorld:HasTag("cave") then
		inst:DoPeriodicTask(120,function()
	    inst:Remove()
		end)
	end
end)



--蛤蟆、毒蛤蟆
local function toadstool_loot(inst)
   if inst.components.lootdropper then
 --   inst.components.lootdropper:AddChanceLoot('shroom_skin',1)            --前面物品，后面几率
      inst.components.lootdropper:AddChanceLoot('shroom_skin',1)            --蛤蟆皮
	  inst.components.lootdropper:AddChanceLoot('shroom_skin',1)            --蛤蟆皮
	  
      inst.components.lootdropper:AddChanceLoot('firestaff',1)              --火杖（红）
      inst.components.lootdropper:AddChanceLoot('icestaff',1)               --冰杖（蓝）
	  inst.components.lootdropper:AddChanceLoot('telestaff',1)              --传送法阵（紫）
	  inst.components.lootdropper:AddChanceLoot('orangestaff',1)            --瞬移法杖（橙）
	  inst.components.lootdropper:AddChanceLoot('yellowstaff',1)            --唤星法杖（黄）
	  inst.components.lootdropper:AddChanceLoot('greenstaff',1)             --分解法杖（绿）

      inst.components.lootdropper:AddChanceLoot('amulet',1)                 --生命护符
	  inst.components.lootdropper:AddChanceLoot('blueamulet',1)             --寒冰护符
	  inst.components.lootdropper:AddChanceLoot('purpleamulet',1)           --噩梦护符
	  inst.components.lootdropper:AddChanceLoot('orangeamulet',1)           --懒人护符
	  inst.components.lootdropper:AddChanceLoot('yellowamulet',1)           --魔力之光
      inst.components.lootdropper:AddChanceLoot('greenamulet',1)            --建造护符
	end
end
AddPrefabPostInit("toadstool", toadstool_loot)
AddPrefabPostInit("toadstool_dark", toadstool_loot)

--树精
local function leif_loot(inst)
   if inst.components.lootdropper then
      inst.components.lootdropper:AddChanceLoot('livinglog',1)              --活木
	  inst.components.lootdropper:AddChanceLoot('livinglog',1)
	  inst.components.lootdropper:AddChanceLoot('livinglog',1)
	  inst.components.lootdropper:AddChanceLoot('batbat',0.5)               --蝙蝠棒
      inst.components.lootdropper:AddChanceLoot('multitool_axe_pickaxe',0.25)--斧镐
	  inst.components.lootdropper:AddChanceLoot('armorruins',0.25)          --铥矿甲
      inst.components.lootdropper:AddChanceLoot('ruinshat',0.25)		    --铥矿帽
	end
end
AddPrefabPostInit("leif", leif_loot)
AddPrefabPostInit("leif_sparse", leif_loot)

--蜘蛛女王
AddPrefabPostInit("spiderqueen", function(inst)
   if inst.components.lootdropper then
        inst.components.lootdropper:AddChanceLoot('spidereggsack',1)        --蜘蛛巢
		inst.components.lootdropper:AddChanceLoot('silk',1)                 --蜘蛛丝
		inst.components.lootdropper:AddChanceLoot('silk',1)
		inst.components.lootdropper:AddChanceLoot('silk',1)
        inst.components.lootdropper:AddChanceLoot('armorruins',0.25)        --铥矿甲
        inst.components.lootdropper:AddChanceLoot('ruinshat',0.25)		    --铥矿帽
        inst.components.lootdropper:AddChanceLoot('armorwood',1)            --木甲		
        inst.components.lootdropper:AddChanceLoot('footballhat',1)          --猪皮帽
	end
end) 

--座狼
AddPrefabPostInit("warg", function(inst)
   if inst.components.lootdropper then
        inst.components.lootdropper:AddChanceLoot('redgem',1)               --红宝石
		inst.components.lootdropper:AddChanceLoot('redgem',1)
		inst.components.lootdropper:AddChanceLoot('redgem',1)
		inst.components.lootdropper:AddChanceLoot('bluegem',1)              --蓝宝石
		inst.components.lootdropper:AddChanceLoot('bluegem',1)
		inst.components.lootdropper:AddChanceLoot('bluegem',1)
		inst.components.lootdropper:AddChanceLoot('houndstooth',1)          --狗牙
		inst.components.lootdropper:AddChanceLoot('houndstooth',1)  
		inst.components.lootdropper:AddChanceLoot('houndstooth',1)
		inst.components.lootdropper:AddChanceLoot('armorruins',0.25)        --铥矿甲
        inst.components.lootdropper:AddChanceLoot('ruinshat',0.25)		    --铥矿帽
	end
end)

--钢羊
AddPrefabPostInit("spat", function(inst)
   if inst.components.lootdropper then
	    inst.components.lootdropper:AddChanceLoot('meat',1)
	    inst.components.lootdropper:AddChanceLoot('meat',1)
        inst.components.lootdropper:AddChanceLoot('steelwool',1)            --钢丝绒
		inst.components.lootdropper:AddChanceLoot('steelwool',1)            --钢丝绒
		inst.components.lootdropper:AddChanceLoot('ruins_bat',0.5)          --远古武器
	    inst.components.lootdropper:AddChanceLoot('armormarble',0.5)        --大理石甲		
        inst.components.lootdropper:AddChanceLoot('footballhat',0.5)        --猪皮帽
	end
end)

--海象
AddPrefabPostInit("walrus", function(inst)
   if inst.components.lootdropper then
        inst.components.lootdropper:AddChanceLoot('walrus_tusk',0.5)        --海象牙
		inst.components.lootdropper:AddChanceLoot('walrushat',0.25)         --海象帽
	end
end)

--克劳斯
AddPrefabPostInit("klaus", function(inst)
   if inst.components.lootdropper then
	  inst.components.lootdropper:AddChanceLoot('krampus_sack',0.25)  	    --坎普斯背包  
	end
end)

end


if TUNING.HOUND_HEALTH >= 225      and
   TUNING.HOUND_DAMAGE >= 30       and
   TUNING.HOUND_ATTACK_PERIOD == 1 then
   
--冬象
AddPrefabPostInit("koalefant_winter", function(inst)
   if inst.components.lootdropper then
      inst.components.lootdropper:AddChanceLoot('meat',1)                   --大肉
	  inst.components.lootdropper:AddChanceLoot('meat',1)
	  inst.components.lootdropper:AddChanceLoot('meat',1)
	  inst.components.lootdropper:AddChanceLoot('armorwood',0.5)            --木甲
      inst.components.lootdropper:AddChanceLoot('trunk_winter',1)           --冬象鼻
	end
end)

--夏象
AddPrefabPostInit("koalefant_summer", function(inst)
   if inst.components.lootdropper then
      inst.components.lootdropper:AddChanceLoot('meat',1)                   --大肉
	  inst.components.lootdropper:AddChanceLoot('meat',1)
	  inst.components.lootdropper:AddChanceLoot('meat',1)
	  inst.components.lootdropper:AddChanceLoot('armorwood',0.5)            --木甲
      inst.components.lootdropper:AddChanceLoot('trunk_summer',1)           --夏象鼻
	end
end)

--高脚鸟
AddPrefabPostInit("tallbird", function(inst)
   if inst.components.lootdropper then
      inst.components.lootdropper:AddChanceLoot('meat',1)                   --大肉
	  inst.components.lootdropper:AddChanceLoot('meat',1)                   --大肉
	  inst.components.lootdropper:AddChanceLoot('armormarble',0.5)          --大理石甲
	end
end)

--触手
AddPrefabPostInit("tentacle", function(inst)
   if inst.components.lootdropper then
      inst.components.lootdropper:AddChanceLoot('tentaclespots',0.25)       --触手皮
	  inst.components.lootdropper:AddChanceLoot('spear_wathgrithr',0.5)     --战斗长矛
	end
end)

--鱼人
AddPrefabPostInit("merm", function(inst)
   if inst.components.lootdropper then
	  inst.components.lootdropper:AddChanceLoot('wathgrithrhat',0.5)        --战斗头盔
	end
end)

--蠕虫
AddPrefabPostInit("worm", function(inst)
   if inst.components.lootdropper then
	  inst.components.lootdropper:AddChanceLoot('molehat',0.5)              --鼹鼠帽
	  inst.components.lootdropper:AddChanceLoot('wormlight',1)              --发光浆果
	  inst.components.lootdropper:AddChanceLoot('wormlight',0.5)            --发光浆果
	end
end)

--猪人
AddPrefabPostInit("pigman", function(inst)
   if inst.components.lootdropper then
	  inst.components.lootdropper:AddChanceLoot('pigskin',0.5)              --猪皮
	  inst.components.lootdropper:AddChanceLoot('footballhat',0.25)          --猪皮帽
	end
end)

--蜘蛛类
local function spider_loot(inst)
   if inst.components.lootdropper then
      inst.components.lootdropper:AddChanceLoot('silk',0.15)                --蜘蛛丝
	  inst.components.lootdropper:AddChanceLoot('spidergland',0.15)         --腺体
      inst.components.lootdropper:AddChanceLoot('monstermeat',0.35)         --怪物肉
	end
end
AddPrefabPostInit("spider", spider_loot)
AddPrefabPostInit("spider_warrior", spider_loot)
AddPrefabPostInit("spider_dropper", spider_loot)
AddPrefabPostInit("spider_hider", spider_loot)
AddPrefabPostInit("spider_spitter", spider_loot)

--狗
AddPrefabPostInit("hound", function(inst)
   if inst.components.lootdropper then
      inst.components.lootdropper:AddChanceLoot('monstermeat',1)            --怪物肉
	  inst.components.lootdropper:AddChanceLoot('houndstooth',1)            --狗牙
	end
end)

--火狗
AddPrefabPostInit("firehound", function(inst)
   if inst.components.lootdropper then
      inst.components.lootdropper:AddChanceLoot('monstermeat',1)            --怪物肉
	  inst.components.lootdropper:AddChanceLoot('houndstooth',1)            --狗牙
	  inst.components.lootdropper:AddChanceLoot('redgem',0.5)               --红宝石
	  inst.components.lootdropper:AddChanceLoot('firestaff',0.1)            --火杖
	end
end)

--冰狗
AddPrefabPostInit("icehound", function(inst)
   if inst.components.lootdropper then
      inst.components.lootdropper:AddChanceLoot('monstermeat',1)            --怪物肉
	  inst.components.lootdropper:AddChanceLoot('houndstooth',1)            --狗牙
      inst.components.lootdropper:AddChanceLoot('bluegem',0.5)              --蓝宝石
      inst.components.lootdropper:AddChanceLoot('icestaff',0.1)             --冰杖
	end
end)

end