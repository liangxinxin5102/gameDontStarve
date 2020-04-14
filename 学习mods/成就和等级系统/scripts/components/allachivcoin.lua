local function getcoinamount(self,coinamount) self.inst.currentcoinamount:set(coinamount) end

local function currenthungerup(self,hungerupamount) self.inst.currenthungerup:set(hungerupamount) end
local function currentsanityup(self,sanityupamount) self.inst.currentsanityup:set(sanityupamount) end
local function currenthealthup(self,healthupamount) self.inst.currenthealthup:set(healthupamount) end
local function currenthealthregen(self,healthregenamount) self.inst.currenthealthregen:set(healthregenamount) end
local function currentsanityregen(self,sanityregenamount) self.inst.currentsanityregen:set(sanityregenamount) end
local function currenthungerrateup(self,hungerrateupamount) self.inst.currenthungerrateup:set(hungerrateupamount) end
local function currentspeedup(self,speedupamount) self.inst.currentspeedup:set(speedupamount) end
local function currentabsorbup(self,absorbupamount) self.inst.currentabsorbup:set(absorbupamount) end
local function currentdamageup(self,damageupamount) self.inst.currentdamageup:set(damageupamount) end
local function currentcrit(self,crit) self.inst.currentcrit:set(crit) end
local function currentlifestealup(self,lifesteal) self.inst.currentlifestealup:set(lifesteal) end
local function currentfireflylightup(self,fireflylightup) self.inst.currentfireflylightup:set(fireflylightup) end
local function currentscaleup(self,scale) self.inst.currentscaleup:set(scale) end

local function currenthungerachivcost(self,hungerachivcost) self.inst.currenthungerachivcost:set(hungerachivcost) end
local function currentsanityachivcost(self,sanityachivcost) self.inst.currentsanityachivcost:set(sanityachivcost) end
local function currenthealthachivcost(self,healthachivcost) self.inst.currenthealthachivcost:set(healthachivcost) end
local function currenthealthregenachivcost(self,healthregenachivcost) self.inst.currenthealthregenachivcost:set(healthregenachivcost) end
local function currentsanityregenachivcost(self,sanityregenachivcost) self.inst.currentsanityregenachivcost:set(sanityregenachivcost) end
local function currenthungerrateachivcost(self,hungerrateachivcost) self.inst.currenthungerrateachivcost:set(hungerrateachivcost) end
local function currentspeedachivcost(self,speedachivcost) self.inst.currentspeedachivcost:set(speedachivcost) end
local function currentabsorbachivcost(self,absorbachivcost) self.inst.currentabsorbachivcost:set(absorbachivcost) end
local function currentdamageachivcost(self,damageachivcost) self.inst.currentdamageachivcost:set(damageachivcost) end
local function currentcritachivcost(self,critachivcost) self.inst.currentcritachivcost:set(critachivcost) end
local function currentlifestealcost(self,lifestealcost) self.inst.currentlifestealcost:set(lifestealcost) end
local function currentfireflylightcost(self,fireflylightcost) self.inst.currentfireflylightcost:set(fireflylightcost) end
local function currentscalecost(self,scalecost) self.inst.currentscalecost:set(scalecost) end

local function currentdoubledrop(self,doubledrop) local c = 0 if doubledrop then c=1 end self.inst.currentdoubledrop:set(c) end
local function currentkrampusxmas(self,krampusxmas) local c = 0 if krampusxmas then c=1 end self.inst.currentkrampusxmas:set(c) end
local function currentnomoist(self,nomoist) local c = 0 if nomoist then c=1 end self.inst.currentnomoist:set(c) end
local function currentgoodman(self,goodman) local c = 0 if goodman then c=1 end self.inst.currentgoodman:set(c) end
local function currentanimallover(self,animallover) local c = 0 if animallover then c=1 end self.inst.currentanimallover:set(c) end
local function currentnanobots(self,nanobots) local c = 0 if nanobots then c=1 end self.inst.currentnanobots:set(c) end
local function currentarchmage(self,archmage) local c = 0 if archmage then c=1 end self.inst.currentarchmage:set(c) end
local function currentcheatdeath(self,cheatdeath) local c = 0 if cheatdeath then c=1 end self.inst.currentcheatdeath:set(c) end
local function currentrefresh(self,refresh) local c = 0 if refresh then c=1 end self.inst.currentrefresh:set(c) end
local function currentfishmaster(self,fishmaster) local c = 0 if fishmaster then c=1 end self.inst.currentfishmaster:set(c) end
local function currentcookmaster(self,cookmaster) local c = 0 if cookmaster then c=1 end self.inst.currentcookmaster:set(c) end
local function currentchopmaster(self,chopmaster) local c = 0 if chopmaster then c=1 end self.inst.currentchopmaster:set(c) end
local function currentpickmaster(self,pickmaster) local c = 0 if pickmaster then c=1 end self.inst.currentpickmaster:set(c) end
local function currentbuildmaster(self,buildmaster) local c = 0 if buildmaster then c=1 end self.inst.currentbuildmaster:set(c) end
local function currenticebody(self,icebody) local c = 0 if icebody then c=1 end self.inst.currenticebody:set(c) end
local function currentfirebody(self,firebody) local c = 0 if firebody then c=1 end self.inst.currentfirebody:set(c) end
local function currentsupply(self,supply) local c = 0 if supply then c=1 end self.inst.currentsupply:set(c) end
local function currentengineering(self,engineering) local c = 0 if engineering then c=1 end self.inst.currentengineering:set(c) end
local function currentnaturalist(self,naturalist) local c = 0 if naturalist then c=1 end self.inst.currentnaturalist:set(c) end
local function currentlunarcraft(self,lunarcraft) local c = 0 if lunarcraft then c=1 end self.inst.currentlunarcraft:set(c) end
local function currentshrine(self,shrine) local c = 0 if shrine then c=1 end self.inst.currentshrine:set(c) end
local function currentreader(self,reader) local c = 0 if reader then c=1 end self.inst.currentreader:set(c) end
local function currentmasterchef(self,masterchef) local c = 0 if masterchef then c=1 end self.inst.currentmasterchef:set(c) end

local function currentminemaster(self,minemaster) local c = 0 if minemaster then c=1 end self.inst.currentminemaster:set(c) end
local function currentfastworker(self,fastworker) local c = 0 if fastworker then c=1 end self.inst.currentfastworker:set(c) end
local function currentancientstation(self,ancientstation) local c = 0 if ancientstation then c=1 end self.inst.currentancientstation:set(c) end

local function findprefab(list,prefab)
    for index,value in pairs(list) do
        if value == prefab then
            return true
        end
    end
end

local allachivcoin = Class(function(self, inst)
    self.inst = inst
    self.coinamount = 0

    self.hungerupamount = 0
    self.sanityupamount = 0
    self.healthupamount = 0
    self.healthregenamount = 0
    self.sanityregenamount = 0
    self.hungerrateupamount = 0
    self.speedupamount = 0
    self.absorbupamount = 0
    self.damageupamount = 0
    self.crit = 0
	self.lifestealupamount = 0
	self.fireflylightup = 0
	self.scaleupamount = 0
	
	self.hungerachivcost = allachiv_coinuse["hungerup"]
    self.sanityachivcost = allachiv_coinuse["sanityup"]
    self.healthachivcost = allachiv_coinuse["healthup"]
    self.healthregenachivcost = allachiv_coinuse["healthregen"]
    self.sanityregenachivcost = allachiv_coinuse["sanityregen"]
    self.hungerrateachivcost = allachiv_coinuse["hungerrateup"]
    self.speedachivcost = allachiv_coinuse["speedup"]
    self.absorbachivcost = allachiv_coinuse["absorbup"]
    self.damageachivcost = allachiv_coinuse["damageup"]
    self.critachivcost = allachiv_coinuse["crit"]
	self.lifestealcost = allachiv_coinuse["lifesteal"]
	self.fireflylightcost = allachiv_coinuse["fireflylightup"]
	self.scalecost = allachiv_coinuse["scale"]
	
	self.starsspent = 0

    self.doubledrop = false
	self.krampusxmas = false
    self.nomoist = false
    self.goodman = false
	self.animallover = false
	self.nanobots = false
	self.archmage = false
	self.cheatdeath = false
    self.refresh = false
    self.fishmaster = false
    self.cookmaster = false
    self.chopmaster = false
    self.pickmaster = false
    self.buildmaster = false
    self.icebody = false
    self.firebody = false
    self.supply = false
	self.engineering = false
	self.naturalist = false
	self.lunarcraft = false
	self.shrine = false
    self.reader = false
    self.masterchef = false
	self.minemaster = false
	self.anicentstation = false
	self.fastworker = false

    self.fishtimemin = 4
    self.fishtimemax = 40
    self.maxMoistureRate = math.pi
end,
nil,
{
    coinamount = getcoinamount,

    hungerupamount = currenthungerup,
    sanityupamount = currentsanityup,
    healthupamount = currenthealthup,
    healthregenamount = currenthealthregen,
    sanityregenamount = currentsanityregen,
    hungerrateupamount = currenthungerrateup,
    speedupamount = currentspeedup,
    absorbupamount = currentabsorbup,
    damageupamount = currentdamageup,
    crit = currentcrit,
	lifestealupamount = currentlifestealup,
	fireflylightup = currentfireflylightup,
	scaleupamount = currentscaleup,
	
	hungerachivcost = currenthungerachivcost,
    sanityachivcost = currentsanityachivcost,
    healthachivcost = currenthealthachivcost,
    healthregenachivcost = currenthealthregenachivcost,
    sanityregenachivcost = currentsanityregenachivcost,
    hungerrateachivcost = currenthungerrateachivcost,
    speedachivcost = currentspeedachivcost,
    absorbachivcost = currentabsorbachivcost,
    damageachivcost = currentdamageachivcost,
    critachivcost = currentcritachivcost,
	lifestealcost = currentlifestealcost,
	fireflylightcost = currentfireflylightcost,
	scalecost = currentscalecost,
	
    doubledrop = currentdoubledrop,
	krampusxmas = currentkrampusxmas,
    nomoist = currentnomoist,
    goodman = currentgoodman,
	animallover = currentanimallover,
	nanobots = currentnanobots,
	archmage = currentarchmage,
	cheatdeath = currentcheatdeath,
    refresh = currentrefresh,
    fishmaster = currentfishmaster,
    cookmaster = currentcookmaster,
    chopmaster = currentchopmaster,
    pickmaster = currentpickmaster,
    buildmaster = currentbuildmaster,
    icebody = currenticebody,
    firebody = currentfirebody,
    supply = currentsupply,
	engineering = currentengineering,
	naturalist = currentnaturalist,
	lunarcraft = currentlunarcraft,
	shrine = currentshrine,
    reader = currentreader,
    masterchef = currentmasterchef,
	
	minemaster = currentminemaster,
	fastworker = currentfastworker,
	ancientstation = currentancientstation,
})

--保存
function allachivcoin:OnSave()
    local data = {
        coinamount = self.coinamount,
        hungerupamount = self.hungerupamount,
        sanityupamount = self.sanityupamount,
        healthupamount = self.healthupamount,
        healthregenamount = self.healthregenamount,
        sanityregenamount = self.sanityregenamount,
        hungerrateupamount = self.hungerrateupamount,
        speedupamount = self.speedupamount,
        absorbupamount = self.absorbupamount,
        damageupamount = self.damageupamount,
        crit = self.crit,
		lifestealupamount = self.lifestealupamount,
		fireflylightup = self.fireflylightup,
		scaleupamount = self.scaleupamount,
		starsspent = self.starsspent,
        doubledrop = self.doubledrop,
		krampusxmas = self.krampusxmas,
        nomoist = self.nomoist,
        goodman = self.goodman,
		animallover = self.animallover,
		nanobots = self.nanobots,
		archmage = self.archmage,
		cheatdeath = self.cheatdeath,
        refresh = self.refresh,
        fishmaster = self.fishmaster,
        cookmaster = self.cookmaster,
        chopmaster = self.chopmaster,
        pickmaster = self.pickmaster,
        buildmaster = self.buildmaster,
        icebody = self.icebody,
        firebody = self.firebody,
        supply = self.supply,
		engineering = self.engineering,
		naturalist = self.naturalist,
		lunarcraft = self.lunarcraft,
		shrine = self.shrine,
        reader = self.reader,
        masterchef = self.masterchef,
		minemaster = self.minemaster,
		fastworker = self.fastworker,
		ancientstation = self.ancientstation,
    }
    return data
end

--载入
function allachivcoin:OnLoad(data)
    self.coinamount = data.coinamount or 0

    self.hungerupamount = data.hungerupamount or 0
    self.sanityupamount = data.sanityupamount or 0
    self.healthupamount = data.healthupamount or 0
    self.healthregenamount = data.healthregenamount or 0
    self.sanityregenamount = data.sanityregenamount or 0
    self.hungerrateupamount = data.hungerrateupamount or 0
    self.speedupamount = data.speedupamount or 0
    self.absorbupamount = data.absorbupamount or 0
    self.damageupamount = data.damageupamount or 0
    self.crit = data.crit or 0
	self.lifestealupamount = data.lifestealupamount or 0
	self.fireflylightup = data.fireflylightup or 0
	self.scaleupamount = data.scaleupamount or 0
	self.hungerachivcost = allachiv_coinuse["hungerup"] + math.floor(self.hungerupamount/achievementcoststep["hungerup"])
    self.sanityachivcost = allachiv_coinuse["sanityup"] + math.floor(self.sanityupamount/achievementcoststep["sanityup"])
    self.healthachivcost = allachiv_coinuse["healthup"] + math.floor(self.healthupamount/achievementcoststep["healthup"])
    self.healthregenachivcost = allachiv_coinuse["healthregen"] + math.floor(self.healthregenamount/achievementcoststep["healthregen"])
    self.sanityregenachivcost = allachiv_coinuse["sanityregen"] + math.floor(self.sanityregenamount/achievementcoststep["sanityregen"])
    self.hungerrateachivcost = allachiv_coinuse["hungerrateup"] + math.floor(self.hungerrateupamount/achievementcoststep["hungerrateup"])
    self.speedachivcost = allachiv_coinuse["speedup"] + math.floor(self.speedupamount/achievementcoststep["speedup"])
    self.absorbachivcost = allachiv_coinuse["absorbup"] + math.floor(self.absorbupamount/achievementcoststep["absorbup"])
    self.damageachivcost = allachiv_coinuse["damageup"] + math.floor(self.damageupamount/achievementcoststep["damageup"])
    self.critachivcost = allachiv_coinuse["crit"] + math.floor(self.crit/achievementcoststep["crit"])
	self.lifestealcost = allachiv_coinuse["lifesteal"] + math.floor(self.lifestealupamount/achievementcoststep["lifesteal"])
	self.fireflylightcost = allachiv_coinuse["fireflylightup"] + math.floor(self.fireflylightup/achievementcoststep["fireflylightup"])
	self.scalecost = allachiv_coinuse["scale"] + math.floor(self.scaleupamount/achievementcoststep["scale"])
	self.starsspent = data.starsspent or 0
    self.doubledrop = data.doubledrop or false
	self.krampusxmas = data.krampusxmas or false
    self.nomoist = data.nomoist or false
    self.goodman = data.goodman or false
	self.animallover = data.animallover or false
	self.nanobots = data.nanobots or false
	self.archmage = data.archmage or false
	self.cheatdeath = data.cheatdeath or false
    self.refresh = data.refresh or false
    self.fishmaster = data.fishmaster or false
    self.cookmaster = data.cookmaster or false
    self.chopmaster = data.chopmaster or false
    self.pickmaster = data.pickmaster or false
    self.buildmaster = data.buildmaster or false
    self.icebody = data.icebody or false
    self.firebody = data.firebody or false
    self.supply = data.supply or false
	self.engineering = data.engineering or false
	self.naturalist = data.naturalist or false
	self.lunarcraft = data.lunarcraft or false
	self.shrine = data.shrine or false
    self.reader = data.reader or false
    self.masterchef = data.masterchef or false
	self.minemaster = data.minemaster or false
	self.fastworker = data.fastworker or false
	self.ancientstation = data.ancientstation or false
end

--通用效果器 获取成功
function allachivcoin:ongetcoin(inst)
    inst.SoundEmitter:PlaySound("dontstarve/HUD/research_available")
end

--通用效果器 获取失败
function allachivcoin:cantgetcoin(inst)
    --播放声音
end

function allachivcoin:coinDoDelta(value)
    self.coinamount = self.coinamount + value
end

--提升饱腹获取
function allachivcoin:hungerupcoin(inst)
    if self.coinamount >= self.hungerachivcost then
        self.hungerupamount = self.hungerupamount + 1
		
		-- stats are currently updated in levelsystem:onupdate
        -- local hunger_percent = inst.components.hunger:GetPercent()
        -- inst.components.hunger:SetMax(inst.components.hunger.max + allachiv_coindata["hungerup"])
        -- inst.components.hunger:SetPercent(hunger_percent)
        self:coinDoDelta(-self.hungerachivcost)
		self.starsspent = self.starsspent + self.hungerachivcost
		self.hungerachivcost = allachiv_coinuse["hungerup"] + math.floor(self.hungerupamount/achievementcoststep["hungerup"])
        self:ongetcoin(inst)
    end
end

--提升精神获取
function allachivcoin:sanityupcoin(inst)
    if self.coinamount >= self.sanityachivcost then
        self.sanityupamount = self.sanityupamount + 1
		-- stats are currently updated in levelsystem:onupdate
        -- local sanity_percent = inst.components.sanity:GetPercent()
        -- inst.components.sanity:SetMax(inst.components.sanity.max + allachiv_coindata["sanityup"])
        -- inst.components.sanity:SetPercent(sanity_percent)
        self:coinDoDelta(-self.sanityachivcost)
		self.starsspent = self.starsspent + self.sanityachivcost
		self.sanityachivcost = allachiv_coinuse["sanityup"] + math.floor(self.sanityupamount/achievementcoststep["sanityup"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:healthupcoin(inst)
    if self.coinamount >= self.healthachivcost then
        self.healthupamount = self.healthupamount + 1
		-- stats are currently updated in levelsystem:onupdate
        -- local health_percent = inst.components.health:GetPercent()
        -- inst.components.health:SetMaxHealth(inst.components.health.maxhealth + allachiv_coindata["healthup"])
        -- inst.components.health:SetPercent(health_percent)
        self:coinDoDelta(-self.healthachivcost)
		self.starsspent = self.starsspent + self.healthachivcost
		self.healthachivcost = allachiv_coinuse["healthup"] + math.floor(self.healthupamount/achievementcoststep["healthup"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:hungerrateupcoin(inst)
    if self.coinamount >= self.hungerrateachivcost and inst.components.hunger.hungerrate > .01 then
        self.hungerrateupamount = self.hungerrateupamount + 1
		inst.components.hunger.burnratemodifiers:SetModifier("achievementperk", 1-self.hungerrateupamount*allachiv_coindata["hungerrateup"])
        self:coinDoDelta(-self.hungerrateachivcost)
		self.starsspent = self.starsspent + self.hungerrateachivcost
		self.hungerrateachivcost = allachiv_coinuse["hungerrateup"] + math.floor(self.hungerrateupamount/achievementcoststep["hungerrateup"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:hungerratefn(inst)
	inst.components.hunger.burnratemodifiers:SetModifier("achievementperk", 1-self.hungerrateupamount*allachiv_coindata["hungerrateup"])
end

function allachivcoin:healthregencoin(inst)
    if self.coinamount >= self.healthregenachivcost then
        self.healthregenamount = self.healthregenamount + 1
        self:coinDoDelta(-self.healthregenachivcost)
		self.starsspent = self.starsspent + self.healthregenachivcost
		self.healthregenachivcost = allachiv_coinuse["healthregen"] + math.floor(self.healthregenamount/achievementcoststep["healthregen"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:healthregenfn(inst)
    inst:DoPeriodicTask(5, function()
        if inst
        and inst.components.health
        and inst.components.health.currenthealth < inst.components.health.maxhealth
        and inst.components.health.currenthealth > 0
        and self.healthregenamount > 0
        then
            inst.components.health:DoDelta(allachiv_coindata["healthregen"]*self.healthregenamount, true)
        end
    end)
end

--自动回脑获取
function allachivcoin:sanityregencoin(inst)
    if self.coinamount >= self.sanityregenachivcost then
        self.sanityregenamount = self.sanityregenamount + 1
        self:coinDoDelta(-self.sanityregenachivcost)
		self.starsspent = self.starsspent + self.sanityregenachivcost
		self.sanityregenachivcost = allachiv_coinuse["sanityregen"] + math.floor(self.sanityregenamount/achievementcoststep["sanityregen"])
        self:ongetcoin(inst)
    end
end

--自动回脑效果
function allachivcoin:sanityregenfn(inst)
    inst:DoPeriodicTask(5, function()
        if inst
        and inst.components.sanity
        and inst.components.sanity.current < inst.components.sanity.max
        and inst.components.health
        and inst.components.health.currenthealth > 0
        and self.sanityregenamount > 0
        then
            inst.components.sanity:DoDelta(allachiv_coindata["sanityregen"]*self.sanityregenamount, true)
        end
    end)
end

--提升速度获取
function allachivcoin:speedupcoin(inst)
    if self.coinamount >= self.speedachivcost then
        self.speedupamount = self.speedupamount + 1
        self:coinDoDelta(-self.speedachivcost)
		self.starsspent = self.starsspent + self.speedachivcost
		local currentSpeedMult = inst.components.locomotor:GetExternalSpeedMultiplier(inst,"speedUpgrade")
		currentSpeedMult = currentSpeedMult + allachiv_coindata["speedup"]
		inst.components.locomotor:SetExternalSpeedMultiplier(inst,"speedUpgrade", currentSpeedMult)
		self.speedachivcost = allachiv_coinuse["speedup"] + math.floor(self.speedupamount/achievementcoststep["speedup"])*2
        self:ongetcoin(inst)
    end
end


function allachivcoin:damageupcoin(inst)
    if self.coinamount >= self.damageachivcost then
        self.damageupamount = self.damageupamount + 1
        self:coinDoDelta(-self.damageachivcost)
		self.starsspent = self.starsspent + self.damageachivcost
		local currentDamageMult = inst.components.combat.externaldamagemultipliers:CalculateModifierFromSource("damageUpgrade")
		currentDamageMult = currentDamageMult + allachiv_coindata["damageup"]
		inst.components.combat.externaldamagemultipliers:SetModifier("damageUpgrade", currentDamageMult)
		self.damageachivcost = allachiv_coinuse["damageup"] + math.floor(self.damageupamount/achievementcoststep["damageup"])*2
        self:ongetcoin(inst)
    end
end

function allachivcoin:absorbupcoin(inst)
	local currentAbsorbAdd = inst.components.health.externalabsorbmodifiers:CalculateModifierFromSource("absorbUpgrade")
	if currentAbsorbAdd > 0.90 then
		return
	end
    if self.coinamount >= self.absorbachivcost then
        self.absorbupamount = self.absorbupamount + 1
        self:coinDoDelta(-self.absorbachivcost)
		self.starsspent = self.starsspent + self.absorbachivcost
		currentAbsorbAdd = currentAbsorbAdd + allachiv_coindata["absorbup"]
		inst.components.health.externalabsorbmodifiers:SetModifier("absorbUpgrade", currentAbsorbAdd)
		self.absorbachivcost = allachiv_coinuse["absorbup"] + math.floor(self.absorbupamount/achievementcoststep["absorbup"])*2
        self:ongetcoin(inst)
    end
end

function allachivcoin:critcoin(inst)
    if self.coinamount >= self.critachivcost then
        self.crit = self.crit + 1
        self:coinDoDelta(-self.critachivcost)
		self.starsspent = self.starsspent + self.critachivcost
		self.critachivcost = allachiv_coinuse["crit"] + math.floor(self.crit/achievementcoststep["crit"])*2
        self:ongetcoin(inst)
    end
end

function allachivcoin:critfn(inst)
    inst:ListenForEvent("onhitother", function(inst, data)
        local chance = allachiv_coindata["crit"]*self.crit*100
        local damage = data.damage
        local target = data.target
        if target and math.random(1,100) <= chance and not target:HasTag("wall") and self.crit > 0 and self.attackcheck ~= true and data.target.components.health and data.target.components.health.currenthealth > 0 then
            self.attackcheck = true
			target.components.combat:GetAttacked(inst, damage)
            local snap = SpawnPrefab("impact")
            snap.Transform:SetScale(3, 3, 3)
            snap.Transform:SetPosition(target.Transform:GetWorldPosition())
            if target.SoundEmitter ~= nil then
                target.SoundEmitter:PlaySound("dontstarve/common/whip_large", nil, 0.3)
            end
            -- if target.components.lootdropper and target.components.health:IsDead() then
                -- if target.components.freezable or target:HasTag("monster") then
                    -- target.components.lootdropper:DropLoot()
                -- end
            -- end
            inst:DoTaskInTime(.1, function() self.attackcheck = false end)
        end
    end)
end

function allachivcoin:lifestealupcoin(inst)
    if self.coinamount >= self.lifestealcost then
        self.lifestealupamount = self.lifestealupamount + 1
        self:coinDoDelta(-self.lifestealcost)
		self.starsspent = self.starsspent + self.lifestealcost
		self.lifestealcost = allachiv_coinuse["lifesteal"] + math.floor(self.lifestealupamount/achievementcoststep["lifesteal"])*1
        self:ongetcoin(inst)
    end
end

local function IsValidVictim(victim)
    return victim ~= nil
        and not ((victim:HasTag("prey") and not victim:HasTag("hostile")) or
                victim:HasTag("veggie") or
                victim:HasTag("structure") or
                victim:HasTag("wall") or
                victim:HasTag("balloon") or
                victim:HasTag("groundspike") or
                victim:HasTag("smashable") or
                victim:HasTag("companion"))
        and victim.components.health ~= nil
        and victim.components.combat ~= nil
end

function allachivcoin:lifestealfn(inst)
    inst:ListenForEvent("onhitother", function(inst, data)
		if self.lifestealupamount > 0 and data.target and not inst.components.health:IsDead() and IsValidVictim(data.target) then	
			local damage = inst.components.combat:CalcDamage(data.target, data.weapon)
			--local damage = data.weapon ~= nil and data.weapon.components.weapon.damage or inst.components.combat.defaultdamage
			inst.components.health:DoDelta(damage*allachiv_coindata["lifesteal"]*self.lifestealupamount, false, "lifesteal")
		end
    end)
end

function allachivcoin:scaleupcoin(inst)
    if self.coinamount >= self.scalecost then
        self.scaleupamount = self.scaleupamount + 1
        self:coinDoDelta(-self.scalecost)
		self.starsspent = self.starsspent + self.scalecost
		self.scalecost = allachiv_coinuse["scale"] + math.floor(self.scaleupamount/achievementcoststep["scale"])*2
        self:ongetcoin(inst)
		self:scalefn(inst)
    end
end

function allachivcoin:scalefn(inst)
	if self.scaleupamount > 0 then
		print(1+allachiv_coindata["scale"]*self.scaleupamount)
		inst:ApplyScale("achievementScale", 1+allachiv_coindata["scale"]*self.scaleupamount)
	end
end

function allachivcoin:fireflylightupcoin(inst)
    if self.coinamount >= self.fireflylightcost then
        self.fireflylightup = self.fireflylightup + 1
        self:coinDoDelta(-self.fireflylightcost)
		self.starsspent = self.starsspent + self.fireflylightcost
		self.fireflylightcost = allachiv_coinuse["fireflylightup"] + math.floor(self.fireflylightup/achievementcoststep["fireflylightup"])*5
        self:ongetcoin(inst)
		self:fireflylightfn(inst)
    end
end

function allachivcoin:fireflylightfn(inst)
	if inst._fireflylight then inst._fireflylight:Remove() end
    if self.fireflylightup > 0 then
        inst._fireflylight = SpawnPrefab("minerhatlight")
        inst._fireflylight.Light:SetRadius(0.5+self.fireflylightup-1)
        inst._fireflylight.Light:SetFalloff(.8)
        inst._fireflylight.Light:SetIntensity(.6)
        inst._fireflylight.Light:SetColour(255/255,255/255,255/255)
        inst._fireflylight.entity:SetParent(inst.entity)
        if TheWorld.components.worldstate.data.isday then
            inst._fireflylight.Light:SetIntensity(0)
            inst._fireflylight.Light:Enable(false)
        end
        inst:WatchWorldState("startday", function()
            for i=1, 100 do
                inst:DoTaskInTime(i/25, function()
                    inst._fireflylight.Light:SetIntensity(.5-i/100*.5)
                end)
            end
            inst:DoTaskInTime(4, function() inst._fireflylight.Light:Enable(false) end)
        end)
        inst:WatchWorldState("startdusk", function()
            inst._fireflylight.Light:Enable(true)
            for i=1, 100 do
                inst:DoTaskInTime(i/25, function()
                    inst._fireflylight.Light:SetIntensity(i/100*.5)
                end)
            end
        end)
    end
end

SetSharedLootTable( 'krampusxmas',
{
    {'monstermeat',		1.0},
    {'pumpkincookie',	1.0},
    {'krampus_sack', 	allachiv_coindata["krampusxmas"]},
})

function allachivcoin:krampusxmascoin(inst)
    if self.krampusxmas ~= true and self.coinamount >= allachiv_coinuse["krampusxmas"] then
        self.krampusxmas = true
		self.starsspent = self.starsspent + allachiv_coinuse["krampusxmas"]
        self:coinDoDelta(-allachiv_coinuse["krampusxmas"])
        self:krampusxmasfn(inst)
        self:ongetcoin(inst)
    end
end

function allachivcoin:krampusxmasfn(inst)
    inst:ListenForEvent("onhitother", function(inst, data)
	local target = data.target
        if self.krampusxmas and target.prefab == "krampus" then
			target.components.lootdropper:SetChanceLootTable('krampusxmas')
		end
    end)
end

--雨水免疫获取
function allachivcoin:nomoistcoin(inst)
    if self.nomoist ~= true and self.coinamount >= allachiv_coinuse["nomoist"] then
        self.nomoist = true
        inst.components.moisture.maxMoistureRate = 0
        self.maxMoistureRate = inst.components.moisture.maxMoistureRate
		self.starsspent = self.starsspent + allachiv_coinuse["nomoist"]
        self:coinDoDelta(-allachiv_coinuse["nomoist"])
        self:ongetcoin(inst)
    end
end

--双倍掉落获取
function allachivcoin:doubledropcoin(inst)
    if self.doubledrop ~= true and self.coinamount >= allachiv_coinuse["doubledrop"] then
        self.doubledrop = true
		self.starsspent = self.starsspent + allachiv_coinuse["doubledrop"]
        self:coinDoDelta(-allachiv_coinuse["doubledrop"])
        self:ongetcoin(inst)
    end
end

--双倍掉落效果
function allachivcoin:doubledropfn(inst)
    inst:ListenForEvent("killed", function(inst, data)
        if self.doubledrop and data.victim.components.lootdropper then
            if data.victim.components.freezable or data.victim:HasTag("monster") then
                data.victim.components.lootdropper:DropLoot()
            end
        end
    end)
end

		
function allachivcoin:goodmancoin(inst)
    if self.goodman ~= true and self.coinamount >= allachiv_coinuse["goodman"] then
        self.goodman = true
		self.starsspent = self.starsspent + allachiv_coinuse["goodman"]
        self:coinDoDelta(-allachiv_coinuse["goodman"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:goodmanfn(inst)
    inst:DoPeriodicTask(1, function()
        if self.goodman then
            local pos = Vector3(inst.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 6)
            for k,v in pairs(ents) do
                if v.prefab then
                    if v.prefab == "pigman" or v.prefab == "bunnyman" then
                        if v.components.follower.leader == nil
                        and not v:HasTag("werepig")
                        and not v:HasTag("guard") then
                            if v.components.combat:TargetIs(inst) then
                                v.components.combat:SetTarget(nil)
                            end
                            inst.components.leader:AddFollower(v)
                        end
                    end
                end
            end
        end
    end)
end

function allachivcoin:animallovercoin(inst)
    if self.animallover ~= true and self.coinamount >= allachiv_coinuse["animallover"] then
        self.animallover = true
		self.starsspent = self.starsspent + allachiv_coinuse["animallover"]
        self:coinDoDelta(-allachiv_coinuse["animallover"])
        self:ongetcoin(inst)
		self:animalloverfn(inst)
    end
end

function allachivcoin:animalloverfn(inst)
    if self.animallover then
		inst:RemoveTag("scarytoprey")
		inst:AddTag("animallover")
	end
end

--垂钓圣手获取
function allachivcoin:fishmastercoin(inst)
    if self.fishmaster ~= true and self.coinamount >= allachiv_coinuse["fishmaster"] then
        self.fishmaster = true
		self.starsspent = self.starsspent + allachiv_coinuse["fishmaster"]
        self:coinDoDelta(-allachiv_coinuse["fishmaster"])
        self:ongetcoin(inst)

        if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS).components
        and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS).components.fishingrod then
            local fishingrod = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS).components.fishingrod
            self.fishtimemin = fishingrod.minwaittime
            self.fishtimemax = fishingrod.maxwaittime
            fishingrod:SetWaitTimes(1, 1)
        end
    end
end

--垂钓圣手效果
function allachivcoin:fishmasterfn(inst)
    inst:ListenForEvent("equip", function(inst, data)
        if  self.fishmaster and data.item and data.item.components.fishingrod then
            self.fishtimemin = data.item.components.fishingrod.minwaittime
            self.fishtimemax = data.item.components.fishingrod.maxwaittime
            data.item.components.fishingrod:SetWaitTimes(1, 1)
        end
    end)
    inst:ListenForEvent("unequip", function(inst, data)
        if self.fishmaster and data.item and data.item.components.fishingrod then
            data.item.components.fishingrod:SetWaitTimes(self.fishtimemin, self.fishtimemax)
        end
    end)
end

--双倍采集获取
function allachivcoin:pickmastercoin(inst)
    if self.pickmaster ~= true and self.coinamount >= allachiv_coinuse["pickmaster"] then
        self.pickmaster = true
		self.starsspent = self.starsspent + allachiv_coinuse["pickmaster"]
        self:coinDoDelta(-allachiv_coinuse["pickmaster"])
        self:ongetcoin(inst)
    end
end

--双倍采集效果
function allachivcoin:pickmasterfn(inst)
    inst:ListenForEvent("picksomething", function(inst, data)
        if self.pickmaster and data.object and data.object.components.pickable and not data.object.components.trader then
            if data.object.components.pickable.product ~= nil then
                local item = SpawnPrefab(data.object.components.pickable.product)
                if item.components.stackable then
                    item.components.stackable:SetStackSize(data.object.components.pickable.numtoharvest)
                end
                inst.components.inventory:GiveItem(item, nil, data.object:GetPosition())
            end
        end
    end)
end

--砍树圣手获取
function allachivcoin:chopmastercoin(inst)
    if self.chopmaster ~= true and self.coinamount >= allachiv_coinuse["chopmaster"] then
        self.chopmaster = true
		self.starsspent = self.starsspent + allachiv_coinuse["chopmaster"]
        self:coinDoDelta(-allachiv_coinuse["chopmaster"])
        self:ongetcoin(inst)
    end
end

--砍树圣手效果
function allachivcoin:chopmasterfn(inst)
    inst:ListenForEvent("working", function(inst, data)
        if self.chopmaster and data.target and data.target:HasTag("tree") then
            local workable = data.target.components.workable
            --if workable.workleft >= 1 then
            --    if workable.onfinish then
                    workable.workleft = 0
            --    end
            --end
        end
    end)
end

--烹调圣手获取
function allachivcoin:cookmastercoin(inst)
    if self.cookmaster ~= true and self.coinamount >= allachiv_coinuse["cookmaster"] then
        self.cookmaster = true
		self.starsspent = self.starsspent + allachiv_coinuse["cookmaster"]
        self:coinDoDelta(-allachiv_coinuse["cookmaster"])
        self:ongetcoin(inst)
        if inst:HasTag("expertchef") ~= true then
            inst:AddTag("expertchef")
        end
    end
end

--烹调圣手效果&煮食事件内置
function allachivcoin:cookmasterfn(inst)
    if self.cookmaster == true and inst:HasTag("expertchef") ~= true then
        inst:AddTag("expertchef")
    end
    local COOK = ACTIONS.COOK
    local old_cook_fn = COOK.fn
    COOK.fn = function(act, ...)
        local result = old_cook_fn(act)
        local stewer = act.target.components.stewer
        local allachivcoin = act.doer.components.allachivcoin
        local allachivevent = act.doer.components.allachivevent
        if result and stewer ~= nil then
            if allachivevent.cookmaster ~= true or allachivevent.cookappren ~= true then
                allachivevent.cookamount = allachivevent.cookamount + 1
                if allachivevent.cookamount >= allachiv_eventdata["cookappren"] and allachivevent.cookappren ~= true then
                    allachivevent.cookappren = true
                    allachivevent:seffc(act.doer, "cookappren")
                end
                if allachivevent.cookamount >= allachiv_eventdata["cookmaster"] and allachivevent.cookmaster ~= true then
                    allachivevent.cookmaster = true
                    allachivevent:seffc(act.doer, "cookmaster")
                end
            end
            if allachivcoin.cookmaster then
                local fn = stewer.task.fn
                stewer.task:Cancel()
                fn(act.target, stewer)
            end
        end
    end
end

--节省材料获取
function allachivcoin:buildmastercoin(inst)
    if self.buildmaster ~= true and self.coinamount >= allachiv_coinuse["buildmaster"] then
        self.buildmaster = true
        inst.components.builder.ingredientmod = .5
		self.starsspent = self.starsspent + allachiv_coinuse["buildmaster"]
        self:coinDoDelta(-allachiv_coinuse["buildmaster"])
        self:buildmasterfn(inst)
        inst.components.builder.ingredientmod = .5
        self:ongetcoin(inst)
    end
end

--节省材料效果
function allachivcoin:buildmasterfn(inst)
    if self.buildmaster then
        inst.components.builder.ingredientmod = .5
    end
    inst:ListenForEvent("equip", function(inst, data)
        if self.buildmaster and data.item and data.item.prefab == "greenamulet" then
            inst.components.builder.ingredientmod = .5
        end
    end)
    inst:ListenForEvent("unequip", function(inst, data)
        if self.buildmaster and data.item and data.item.prefab == "greenamulet" then
            inst.components.builder.ingredientmod = .5
        end
    end)
end

function allachivcoin:nanobotscoin(inst)
    if self.nanobots ~= true and self.coinamount >= allachiv_coinuse["nanobots"] then
        self.nanobots = true
		self.starsspent = self.starsspent + allachiv_coinuse["nanobots"]
        self:coinDoDelta(-allachiv_coinuse["nanobots"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:nanobotsfn(inst)
    inst:DoPeriodicTask(1, function()
        if self.nanobots then
			local inventory = inst.components.inventory
			if inventory then
				for k, v in pairs(inventory.equipslots) do
					if not findprefab(magiclist, v.prefab) then
						if v.components.finiteuses then
							local p = v.components.finiteuses:GetPercent()
							p = math.min(p+0.003, 1.0)
							v.components.finiteuses:SetPercent(p)
						end
						if v.components.armor then
							local p = v.components.armor:GetPercent()
							p = math.min(p+0.003, 1.0)
							v.components.armor:SetPercent(p)
						end
						if v.components.fueled then
							local p = v.components.fueled:GetPercent()
							p = math.min(p+0.003, 1.0)
							v.components.fueled:SetPercent(p)
						end
					end
				end
			end
        end
    end)
end

function allachivcoin:archmagecoin(inst)
    if self.archmage ~= true and self.coinamount >= allachiv_coinuse["archmage"] then
        self.archmage = true
		self.starsspent = self.starsspent + allachiv_coinuse["archmage"]
        self:coinDoDelta(-allachiv_coinuse["archmage"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:archmagefn(inst)
    inst:DoPeriodicTask(10, function()
        if self.archmage then
			local inventory = inst.components.inventory
			if inventory then
				for k, v in pairs(inventory.equipslots) do
					if findprefab(magiclist, v.prefab) then  
						if v.components.finiteuses then
							local p = v.components.finiteuses:GetPercent()
							p = math.min(p+0.01, 1.0)
							v.components.finiteuses:SetPercent(p)
						end
						if v.components.armor then
							local p = v.components.armor:GetPercent()
							p = math.min(p+0.01, 1.0)
							v.components.armor:SetPercent(p)
						end
					end
				end
			end
        end
    end)
end

function allachivcoin:cheatdeathcoin(inst)
    if self.cheatdeath ~= true and self.coinamount >= allachiv_coinuse["cheatdeath"] then
        self.cheatdeath = true
		self.starsspent = self.starsspent + allachiv_coinuse["cheatdeath"]
        self:coinDoDelta(-allachiv_coinuse["cheatdeath"])
        self:ongetcoin(inst)
    end
end

function allachivcoin:cheatdeathfn(inst)
	local onCoolDown = false
	inst:ListenForEvent("minhealth", function(player, data)
		if self.cheatdeath and not onCoolDown and player.components.health.currenthealth <= 0 then
			player.components.health.currenthealth = 1
			player.components.health:SetInvincible(true)
			if player._fx ~= nil then
				player._fx:kill_fx()
			end
			player._fx = SpawnPrefab("forcefieldfx")
			player._fx.entity:SetParent(player.entity)
			player._fx.Transform:SetPosition(0, 0.2, 0)
			local b1 = SpawnPrefab("ghost_transform_overlay_fx")
			b1.entity:SetParent(player.entity)
			b1.Transform:SetPosition(0, -1.65, 0)
			local b2 = SpawnPrefab("bramblefx_trap")
			b2.entity:SetParent(player.entity)
			b2.Transform:SetPosition(0, 0, 0)
			-- local b3 = SpawnPrefab("groundpoundring_fx")
			-- b3.entity:SetParent(player.entity)
			-- b3.Transform:SetPosition(0, 2, 0)
			-- local b4 = SpawnPrefab("lavaarena_creature_teleport_small_fx")
			-- b4.entity:SetParent(player.entity)
			-- b4.Transform:SetPosition(0, 0, 0)
			local b5 = SpawnPrefab("superjump_fx")
			b5.entity:SetParent(player.entity)
			b5.Transform:SetPosition(0, 0, 0)
			player.SoundEmitter:PlaySound("dontstarve/common/lava_arena/spawn")
			
			player:DoTaskInTime(0.5, function(player)
				local angle = 0
				local pos = Vector3(inst.Transform:GetWorldPosition())
				for i=1, 12 do
					local bomb = SpawnPrefab("gunpowder")
					local z = pos.z + 2.5*math.cos(angle*math.pi/180)
					local x = pos.x + 2.5*math.sin(angle*math.pi/180)
					bomb.Transform:SetPosition(x, pos.y, z)
					bomb.components.explosive:OnBurnt()
					angle = angle + 360/12
				end
			end)
			
			player:DoTaskInTime(allachiv_coindata["cheatdeath"], function(player) 
				onCoolDown = false
				local cool = SpawnPrefab("staffcastfx")				
				cool.entity:SetParent(player.entity)
				cool.Transform:SetPosition(0, 0, 0)
				player.SoundEmitter:PlaySound("dontstarve/common/staffteleport")
			end)
			
			player:DoTaskInTime(5, function(player) 
				if player._fx ~= nil then
					player._fx:kill_fx()
					player._fx = nil
				end
				player.components.health:SetInvincible(false)
				onCoolDown = true
			end)
		end
	end)
end

function allachivcoin:refreshcoin(inst)
    if self.refresh ~= true and self.coinamount >= allachiv_coinuse["refresh"] then
        self.refresh = true
		self.starsspent = self.starsspent + allachiv_coinuse["refresh"]
        self:coinDoDelta(-allachiv_coinuse["refresh"])
        self:ongetcoin(inst)
    end
end

--携带反鲜效果
function allachivcoin:refreshfn(inst)
    inst:DoPeriodicTask(1, function()
        if self.refresh then
            --物品栏反鲜
            for k,v in pairs(inst.components.inventory.itemslots) do
                if v and v.components.perishable then
                    v.components.perishable:ReducePercent(-.005)
                end
            end
            --装备栏反鲜
            for k,v in pairs(inst.components.inventory.equipslots) do
                if v and v.components.perishable then
                    v.components.perishable:ReducePercent(-.005)
                end
            end
            --背包反鲜
            for k,v in pairs(inst.components.inventory.opencontainers) do
                if k and k:HasTag("backpack") and k.components.container then
                    for i,j in pairs(k.components.container.slots) do
                        if j and j.components.perishable then
                            j.components.perishable:ReducePercent(-.005)
                        end
                    end
                end
            end
        end
    end)
end

--低温免疫获取
function allachivcoin:icebodycoin(inst)
    if self.icebody ~= true and self.coinamount >= allachiv_coinuse["icebody"] then
        self.icebody = true
		self.starsspent = self.starsspent + allachiv_coinuse["icebody"]
        self:coinDoDelta(-allachiv_coinuse["icebody"])
        self:icebodyfn(inst)
        self:ongetcoin(inst)
    end
end

--低温免疫效果
function allachivcoin:icebodyfn(inst)
    if self.icebody == true then
        inst.components.temperature.mintemp = 5
    end
end

--高温免疫获取
function allachivcoin:firebodycoin(inst)
    if self.firebody ~= true and self.coinamount >= allachiv_coinuse["firebody"] then
        self.firebody = true
		self.starsspent = self.starsspent + allachiv_coinuse["firebody"]
        self:coinDoDelta(-allachiv_coinuse["firebody"])
        self:firebodyfn(inst)
        self:ongetcoin(inst)
    end
end

--高温免疫效果
function allachivcoin:firebodyfn(inst)
    if self.firebody == true then
        inst.components.temperature.maxtemp = 65
    end
end


function allachivcoin:supplycoin(inst)
    if self.supply ~= true and self.coinamount >= allachiv_coinuse["supply"] then
        self.supply = true
		self.starsspent = self.starsspent + allachiv_coinuse["supply"]
        self:coinDoDelta(-allachiv_coinuse["supply"])
        self:supplyfn(inst)
        local item1 = SpawnPrefab("redmooneye")
        inst.components.inventory:GiveItem(item1, nil, inst:GetPosition())
        local item2 = SpawnPrefab("bluemooneye")
        inst.components.inventory:GiveItem(item2, nil, inst:GetPosition())
        self:ongetcoin(inst)
    end
end


function allachivcoin:supplyfn(inst)
    if self.supply then
        inst:AddTag("achiveking")
    end
end

function allachivcoin:engineeringcoin(inst)
    if self.engineering ~= true and self.coinamount >= allachiv_coinuse["engineering"] then
        self.engineering = true
		self.starsspent = self.starsspent + allachiv_coinuse["engineering"]
        self:coinDoDelta(-allachiv_coinuse["engineering"])
        self:engineeringfn(inst)
        local item1 = SpawnPrefab("sewing_tape")
        item1.components.stackable:SetStackSize(4)
        inst.components.inventory:GiveItem(item1, nil, inst:GetPosition())
        self:ongetcoin(inst)
    end
end


function allachivcoin:engineeringfn(inst)
    if self.engineering then
        inst:AddTag("engineering")
    end
end

function allachivcoin:naturalistcoin(inst)
    if self.naturalist ~= true and self.coinamount >= allachiv_coinuse["naturalist"] then
        self.naturalist = true
		self.starsspent = self.starsspent + allachiv_coinuse["naturalist"]
        self:coinDoDelta(-allachiv_coinuse["naturalist"])
        self:naturalistfn(inst)
        local item1 = SpawnPrefab("livinglog")
        item1.components.stackable:SetStackSize(4)
        inst.components.inventory:GiveItem(item1, nil, inst:GetPosition())
        self:ongetcoin(inst)
    end
end


function allachivcoin:naturalistfn(inst)
    if self.naturalist then
        inst:AddTag("naturalist")
    end
end

function allachivcoin:lunarcraftcoin(inst)
    if self.lunarcraft ~= true and self.coinamount >= allachiv_coinuse["lunarcraft"] then
        self.lunarcraft = true
		self.starsspent = self.starsspent + allachiv_coinuse["lunarcraft"]
        self:coinDoDelta(-allachiv_coinuse["lunarcraft"])
        self:lunarcraftfn(inst)
        local item1 = SpawnPrefab("moonglass")
        item1.components.stackable:SetStackSize(7)
        inst.components.inventory:GiveItem(item1, nil, inst:GetPosition())
        self:ongetcoin(inst)
    end
end


function allachivcoin:lunarcraftfn(inst)
    if self.lunarcraft then
        inst:AddTag("lunarcraft")
    end
end

function allachivcoin:shrinecoin(inst)
    if self.shrine ~= true and self.coinamount >= allachiv_coinuse["shrine"] then
        self.shrine = true
		self.starsspent = self.starsspent + allachiv_coinuse["shrine"]
        self:coinDoDelta(-allachiv_coinuse["shrine"])
        self:shrinefn(inst)
        local item1 = SpawnPrefab("lucky_goldnugget")
        item1.components.stackable:SetStackSize(7)
        inst.components.inventory:GiveItem(item1, nil, inst:GetPosition())
        self:ongetcoin(inst)
    end
end


function allachivcoin:shrinefn(inst)
    if self.shrine then
        inst:AddTag("shrine")
    end
end

--书籍阅读获取
function allachivcoin:readercoin(inst)
    if self.reader ~= true and self.coinamount >= allachiv_coinuse["reader"] and inst.prefab ~= "wickerbottom" then
        self.reader = true
		self.starsspent = self.starsspent + allachiv_coinuse["reader"]
        self:coinDoDelta(-allachiv_coinuse["reader"])
        self:readerfn(inst)
        local item1 = SpawnPrefab("papyrus")
        item1.components.stackable:SetStackSize(6)
        inst.components.inventory:GiveItem(item1, nil, inst:GetPosition())
        self:ongetcoin(inst)
    end
end

--书籍阅读效果
function allachivcoin:readerfn(inst)
    if self.reader then
        inst:AddComponent("reader")
        inst:AddTag("achivbookbuilder")
		if inst.prefab == "wurt" then
			inst:RemoveTag("aspiring_bookworm")
		end
    end
end

function allachivcoin:masterchefcoin(inst)
    if self.masterchef ~= true and self.coinamount >= allachiv_coinuse["masterchef"] and inst.prefab ~= "warly" then
        self.masterchef = true
		self.starsspent = self.starsspent + allachiv_coinuse["masterchef"]
        self:coinDoDelta(-allachiv_coinuse["masterchef"])
        self:mastercheffn(inst)
        local item1 = SpawnPrefab("spice_chili")
        item1.components.stackable:SetStackSize(2)
        inst.components.inventory:GiveItem(item1, nil, inst:GetPosition())
        local item2 = SpawnPrefab("spice_garlic")
        item2.components.stackable:SetStackSize(2)
        inst.components.inventory:GiveItem(item2, nil, inst:GetPosition())
        local item3 = SpawnPrefab("spice_sugar")
        item3.components.stackable:SetStackSize(2)
        inst.components.inventory:GiveItem(item3, nil, inst:GetPosition())
        self:ongetcoin(inst)
    end
end

function allachivcoin:mastercheffn(inst)
    if self.masterchef then
        inst:AddTag("perkchef")
        inst:AddTag("masterchef")
        inst:AddTag("professionalchef")
    end
end

function allachivcoin:minemastercoin(inst)
    if self.minemaster ~= true and self.coinamount >= allachiv_coinuse["minemaster"] then
        self.minemaster = true
		self.starsspent = self.starsspent + allachiv_coinuse["minemaster"]
        self:coinDoDelta(-allachiv_coinuse["minemaster"])
        self:minemasterfn(inst)
        self:ongetcoin(inst)
    end
end

function allachivcoin:minemasterfn(inst)
    if self.minemaster then
        inst:ListenForEvent("working", function(inst, data)
			if self.minemaster and data.target and (data.target:HasTag("boulder") or data.target:HasTag("statue") or findprefab(rocklist, data.target.prefab)) then
				local workable = data.target.components.workable
				workable.workleft = 0
			end
		end)
    end
end

function allachivcoin:fastworkercoin(inst)
    if self.fastworker ~= true and self.coinamount >= allachiv_coinuse["fastworker"] then
        self.fastworker = true
		self.starsspent = self.starsspent + allachiv_coinuse["fastworker"]
        self:coinDoDelta(-allachiv_coinuse["fastworker"])
        self:fastworkerfn(inst)
        self:ongetcoin(inst)
    end
end

function allachivcoin:fastworkerfn(inst)
    if self.fastworker then
		inst:AddTag("fastpick")
		if inst:HasTag("expertchef") ~= true then
            inst:AddTag("expertchef")
        end
        if inst:HasTag("fastbuilder") ~= true then
            inst:AddTag("fastbuilder")
        end
    end
end

function allachivcoin:ancientstationcoin(inst)
    if self.ancientstation ~= true and self.coinamount >= allachiv_coinuse["ancientstation"] then
        self.ancientstation = true
		self.starsspent = self.starsspent + allachiv_coinuse["ancientstation"]
        self:coinDoDelta(-allachiv_coinuse["ancientstation"])
        self:ancientstationfn(inst)
		local item = SpawnPrefab("nightmare_timepiece")
        inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
        self:ongetcoin(inst)
    end
end

function allachivcoin:ancientstationfn(inst)
    if self.ancientstation then
		inst:AddTag("ancientstation")
    end
end

function allachivcoin:addcoins(inst)
	self.coinamount = self.coinamount + 100
end

--重置奖励
function allachivcoin:removecoin(inst)

    self.coinamount = self.coinamount + math.ceil(self.starsspent*reset_refund_percentage)
    self:resetbuff(inst)

    self.hungerupamount = 0
    self.sanityupamount = 0
    self.healthupamount = 0
    self.healthregenamount = 0
    self.sanityregenamount = 0
    self.hungerrateupamount = 0
    self.speedupamount = 0
    self.absorbupamount = 0
    self.damageupamount = 0
    self.crit = 0
	self.lifestealupamount = 0
	self.fireflylightup = 0
	self.scaleupamount = 0
    inst.components.allachivevent.starreset = 0
	
	if _G.HEALTHPENALTY then
		inst.components.health:DeltaPenalty(TUNING.REVIVE_HEALTH_PENALTY)
	end
	
	self.hungerachivcost = allachiv_coinuse["hungerup"]
    self.sanityachivcost = allachiv_coinuse["sanityup"]
    self.healthachivcost = allachiv_coinuse["healthup"]
    self.healthregenachivcost = allachiv_coinuse["healthregen"]
    self.sanityregenachivcost = allachiv_coinuse["sanityregen"]
    self.hungerrateachivcost = allachiv_coinuse["hungerrateup"]
    self.speedachivcost = allachiv_coinuse["speedup"]
    self.absorbachivcost = allachiv_coinuse["absorbup"]
    self.damageachivcost = allachiv_coinuse["damageup"]
    self.critachivcost = allachiv_coinuse["crit"]
	self.fireflylightcost = allachiv_coinuse["fireflylightup"]
	self.lifestealcost = allachiv_coinuse["lifesteal"]
	self.scalecost = allachiv_coinuse["scale"]
	self.starsspent = 0

    self.doubledrop = false
	self.krampusxmas = false
    self.nomoist = false
    self.goodman = false
	self.animallover = false
	self.nanobots = false
	self.archmage = false
	self.cheatdeath = false
    self.refresh = false
    self.fishmaster = false
    self.cookmaster = false
    self.chopmaster = false
    self.pickmaster = false
    self.buildmaster = false
    self.icebody = false
    self.firebody = false
    self.supply = false
	self.engineering = false
	self.naturalist = false
	self.lunarcraft = false
	self.shrine = false
    self.reader = false
    self.masterchef = false
	self.minemaster = false
	self.fastworker = false
	self.ancientstation = false

    if inst.components.health.currenthealth > 0 and not inst.components.rider:IsRiding() then
        inst.components.locomotor:Stop()
        inst.sg:GoToState("changeoutsidewardrobe")
    end
    SpawnPrefab("shadow_despawn").Transform:SetPosition(inst.Transform:GetWorldPosition())
    SpawnPrefab("statue_transition_2").Transform:SetPosition(inst.Transform:GetWorldPosition())
end

--重置属性
function allachivcoin:resetbuff(inst)

	inst.components.hunger.burnratemodifiers:RemoveModifier("achievementperk")

    if inst._fireflylight then inst._fireflylight:Remove() end
	
	inst:ApplyScale("achievementScale", 1)

    inst.components.temperature.mintemp = TUNING.MIN_ENTITY_TEMP
    inst.components.temperature.maxtemp = TUNING.MAX_ENTITY_TEMP

    inst:RemoveTag("achiveking")
    inst:RemoveTag("perkchef")
	inst:RemoveTag("shrine")
	inst:RemoveTag("ancientstation")
	inst:RemoveTag("engineering")
	inst:RemoveTag("naturalist")
	inst:RemoveTag("lunarcraft")
	inst:RemoveTag("fastpick")
	inst:RemoveTag("animallover")
	if self.animallover then inst:AddTag("scarytoprey") end

    if inst.prefab ~= "wickerbottom" then
        inst:RemoveComponent("reader")
        inst:RemoveTag("achivbookbuilder")
    end
	
	if inst.prefab == "wurt" then
        inst:AddTag("aspiring_bookworm")
    end

    if inst.prefab ~= "warly" and inst.prefab ~= "willow" then
        inst:RemoveTag("expertchef")
		inst:RemoveTag("fastbuilder")
    end

    if inst.prefab ~= "warly" then
        inst:RemoveTag("masterchef")
        inst:RemoveTag("professionalchef")
    end

    inst.components.moisture.maxMoistureRate = .75
    self.maxMoistureRate = inst.components.moisture.maxMoistureRate
	
	local currentDamageMult = inst.components.combat.externaldamagemultipliers:CalculateModifierFromSource("damageUpgrade")
	currentDamageMult = currentDamageMult - self.damageupamount*allachiv_coindata["damageup"]
	inst.components.combat.externaldamagemultipliers:SetModifier("damageUpgrade", currentDamageMult)
	
	local currentSpeedMult = inst.components.locomotor:GetExternalSpeedMultiplier(inst,"speedUpgrade")
	currentSpeedMult = currentSpeedMult - self.speedupamount*allachiv_coindata["speedup"]
	inst.components.locomotor:SetExternalSpeedMultiplier(inst,"speedUpgrade", currentSpeedMult)
	
	local currentAbsorbAdd = inst.components.health.externalabsorbmodifiers:CalculateModifierFromSource("absorbUpgrade")
	currentAbsorbAdd = currentAbsorbAdd - self.absorbupamount*allachiv_coindata["absorbup"]
	inst.components.health.externalabsorbmodifiers:SetModifier("absorbUpgrade", currentAbsorbAdd)

    inst.components.builder.ingredientmod = 1
end

--预运行
function allachivcoin:Init(inst)
	if _G.SYSTEM_CONFIG == "both" or _G.SYSTEM_CONFIG == "achieve" then
		inst:DoTaskInTime(.1, function()
			self:supplyfn(inst)
			self:engineeringfn(inst)
			self:naturalistfn(inst)
			self:lunarcraftfn(inst)
			self:shrinefn(inst)
			self:firebodyfn(inst)
			self:icebodyfn(inst)
			self:nanobotsfn(inst)
			self:archmagefn(inst)
			self:cheatdeathfn(inst)
			self:refreshfn(inst)
			self:buildmasterfn(inst)
			self:cookmasterfn(inst)
			self:chopmasterfn(inst)
			self:pickmasterfn(inst)
			self:fishmasterfn(inst)
			self:goodmanfn(inst)
			self:animalloverfn(inst)
			self:doubledropfn(inst)
			self:fireflylightfn(inst)
			self:krampusxmasfn(inst)
			self:critfn(inst)
			self:lifestealfn(inst)
			self:scalefn(inst)
			self:sanityregenfn(inst)
			self:healthregenfn(inst)
			self:hungerratefn(inst)
			self:readerfn(inst)
			self:mastercheffn(inst)
			self:minemasterfn(inst)
			self:fastworkerfn(inst)
			self:ancientstationfn(inst)
		end)
	end

	inst:DoTaskInTime(1.5, function()
		local currentDamageMult = inst.components.combat.externaldamagemultipliers:CalculateModifierFromSource("damageUpgrade")
		currentDamageMult = currentDamageMult + self.damageupamount*allachiv_coindata["damageup"]
		inst.components.combat.externaldamagemultipliers:SetModifier("damageUpgrade", currentDamageMult)
		local currentAbsorbAdd = inst.components.health.externalabsorbmodifiers:CalculateModifierFromSource("absorbUpgrade")
		currentAbsorbAdd = currentAbsorbAdd + self.absorbupamount*allachiv_coindata["absorbup"]
		inst.components.health.externalabsorbmodifiers:SetModifier("absorbUpgrade", currentAbsorbAdd)
		local currentSpeedMult = inst.components.locomotor:GetExternalSpeedMultiplier(inst,"speedUpgrade")
		currentSpeedMult = currentSpeedMult + self.speedupamount*allachiv_coindata["speedup"]
		inst.components.locomotor:SetExternalSpeedMultiplier(inst,"speedUpgrade", currentSpeedMult)
	end)

    inst:DoPeriodicTask(.5, function() self:onupdate(inst) end)
end

--检测非由本mod改变的数据并实时更新，同时负责载入时将奖励生效
function allachivcoin:onupdate(inst)
    --Stats are updated in the levelsystem:onupdate function
	--only moisture is here // maybe create a new component for stat updates
    if self.maxMoistureRate ~= inst.components.moisture.maxMoistureRate then
        if self.nomoist then
            inst.components.moisture.maxMoistureRate = 0
        end
    end
end


return allachivcoin