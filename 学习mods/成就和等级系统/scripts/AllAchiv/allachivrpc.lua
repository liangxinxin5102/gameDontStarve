--SendModRPCToServer(MOD_RPC["DSTAchievement"]["healthup"])
--modname的名字不能有中文！！！

AddModRPCHandler("DSTAchievement", "hungerup", function(player)
	player.components.allachivcoin:hungerupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "sanityup", function(player)
	player.components.allachivcoin:sanityupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "healthup", function(player)
	player.components.allachivcoin:healthupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "hungerrateup", function(player)
	player.components.allachivcoin:hungerrateupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "healthregen", function(player)
	player.components.allachivcoin:healthregencoin(player)
end)

AddModRPCHandler("DSTAchievement", "sanityregen", function(player)
	player.components.allachivcoin:sanityregencoin(player)
end)

AddModRPCHandler("DSTAchievement", "speedup", function(player)
	player.components.allachivcoin:speedupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "damageup", function(player)
	player.components.allachivcoin:damageupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "absorbup", function(player)
	player.components.allachivcoin:absorbupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "crit", function(player)
	player.components.allachivcoin:critcoin(player)
end)

AddModRPCHandler("DSTAchievement", "lifesteal", function(player)
	player.components.allachivcoin:lifestealupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "fireflylightup", function(player)
	player.components.allachivcoin:fireflylightupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "scale", function(player)
	player.components.allachivcoin:scaleupcoin(player)
end)

AddModRPCHandler("DSTAchievement", "krampusxmas", function(player)
	player.components.allachivcoin:krampusxmascoin(player)
end)

AddModRPCHandler("DSTAchievement", "nomoist", function(player)
	player.components.allachivcoin:nomoistcoin(player)
end)

AddModRPCHandler("DSTAchievement", "doubledrop", function(player)
	player.components.allachivcoin:doubledropcoin(player)
end)

AddModRPCHandler("DSTAchievement", "goodman", function(player)
	player.components.allachivcoin:goodmancoin(player)
end)

AddModRPCHandler("DSTAchievement", "animallover", function(player)
	player.components.allachivcoin:animallovercoin(player)
end)

AddModRPCHandler("DSTAchievement", "fishmaster", function(player)
	player.components.allachivcoin:fishmastercoin(player)
end)

AddModRPCHandler("DSTAchievement", "pickmaster", function(player)
	player.components.allachivcoin:pickmastercoin(player)
end)

AddModRPCHandler("DSTAchievement", "chopmaster", function(player)
	player.components.allachivcoin:chopmastercoin(player)
end)

AddModRPCHandler("DSTAchievement", "cookmaster", function(player)
	player.components.allachivcoin:cookmastercoin(player)
end)

AddModRPCHandler("DSTAchievement", "buildmaster", function(player)
	player.components.allachivcoin:buildmastercoin(player)
end)

AddModRPCHandler("DSTAchievement", "nanobots", function(player)
	player.components.allachivcoin:nanobotscoin(player)
end)

AddModRPCHandler("DSTAchievement", "archmage", function(player)
	player.components.allachivcoin:archmagecoin(player)
end)

AddModRPCHandler("DSTAchievement", "cheatdeath", function(player)
	player.components.allachivcoin:cheatdeathcoin(player)
end)

AddModRPCHandler("DSTAchievement", "refresh", function(player)
	player.components.allachivcoin:refreshcoin(player)
end)

AddModRPCHandler("DSTAchievement", "icebody", function(player)
	player.components.allachivcoin:icebodycoin(player)
end)

AddModRPCHandler("DSTAchievement", "firebody", function(player)
	player.components.allachivcoin:firebodycoin(player)
end)

AddModRPCHandler("DSTAchievement", "supply", function(player)
	player.components.allachivcoin:supplycoin(player)
end)

AddModRPCHandler("DSTAchievement", "engineering", function(player)
	player.components.allachivcoin:engineeringcoin(player)
end)

AddModRPCHandler("DSTAchievement", "naturalist", function(player)
	player.components.allachivcoin:naturalistcoin(player)
end)

AddModRPCHandler("DSTAchievement", "lunarcraft", function(player)
	player.components.allachivcoin:lunarcraftcoin(player)
end)

AddModRPCHandler("DSTAchievement", "shrine", function(player)
	player.components.allachivcoin:shrinecoin(player)
end)

AddModRPCHandler("DSTAchievement", "reader", function(player)
	player.components.allachivcoin:readercoin(player)
end)

AddModRPCHandler("DSTAchievement", "minemaster", function(player)
	player.components.allachivcoin:minemastercoin(player)
end)

AddModRPCHandler("DSTAchievement", "fastworker", function(player)
	player.components.allachivcoin:fastworkercoin(player)
end)

AddModRPCHandler("DSTAchievement", "ancientstation", function(player)
	player.components.allachivcoin:ancientstationcoin(player)
end)

AddModRPCHandler("DSTAchievement", "masterchef", function(player)
	player.components.allachivcoin:masterchefcoin(player)
end)

AddModRPCHandler("DSTAchievement", "removecoin", function(player)
	player.components.allachivcoin:removecoin(player)
end)

AddModRPCHandler("DSTAchievement", "hungeruplevel", function(player)
	player.components.levelsystem:hungeruplevel(player)
end)

AddModRPCHandler("DSTAchievement", "sanityuplevel", function(player)
	player.components.levelsystem:sanityuplevel(player)
end)

AddModRPCHandler("DSTAchievement", "healthuplevel", function(player)
	player.components.levelsystem:healthuplevel(player)
end)

AddModRPCHandler("DSTAchievement", "speeduplevel", function(player)
	player.components.levelsystem:speeduplevel(player)
end)

AddModRPCHandler("DSTAchievement", "damageuplevel", function(player)
	player.components.levelsystem:damageuplevel(player)
end)

AddModRPCHandler("DSTAchievement", "absorbuplevel", function(player)
	player.components.levelsystem:absorbuplevel(player)
end)

AddModRPCHandler("DSTAchievement", "insulationuplevel", function(player)
	player.components.levelsystem:insulationuplevel(player)
end)

AddModRPCHandler("DSTAchievement", "insulationsummeruplevel", function(player)
	player.components.levelsystem:insulationsummeruplevel(player)
end)

AddModRPCHandler("DSTAchievement", "removeattributepoints", function(player)
	player.components.levelsystem:removeattributepoints(player)
end)

-- AddModRPCHandler("DSTAchievement", "addxp", function(player)
	-- player.components.levelsystem:addxp(player)
-- end)

-- AddModRPCHandler("DSTAchievement", "addcoins", function(player)
	-- player.components.allachivcoin:addcoins(player)
-- end)

AddModRPCHandler("DSTAchievement", "saveZoomlevel", function(player, zoomlevel)
	player.components.levelsystem:saveZoomLevel(player, zoomlevel)
end)

AddModRPCHandler("DSTAchievement", "saveWidgetXPos", function(player, xpos)
	player.components.levelsystem:savewidgetXPos(player, xpos)
end)

AddModRPCHandler("DSTAchievement", "saveLanguage", function(player, language)
	player.components.levelsystem:saveLanguage(player, language)
end)