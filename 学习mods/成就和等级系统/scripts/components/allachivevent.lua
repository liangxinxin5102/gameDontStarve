require "components/eventfunctions" 

--Basics
local function findprefab(list,prefab)
    for index,value in pairs(list) do
        if value == prefab then
            return true
        end
    end
end

local function findindex(list,prefab)
    for index,value in pairs(list) do
        if value == prefab then
            return index
        end
    end
end

local function copylist(list)
	local tmp = {}
	for index,value in pairs(list) do
		table.insert(tmp,list[index])
	end
	return tmp
end

local allachivevent = Class(function(self, inst)
    self.inst = inst
    self.intogame = false
    self.firsteat = false
    self.supereat = false
    self.eatamount = 0
    self.danding = false
    self.eatmonsterlasagna = 0
    self.messiah = false
    self.respawnamount = 0
    self.walktime = 0
    self.stoptime = 0
	self.citrins = 0
	self.ambers = 0
	self.saddles = 0
	self.bananas = 0
	self.spores = 0
	self.blueprints = 0
	self.boats = 0
	self.moonrocks = 0
	self.gnomes = 0
	self.mosquitos	= 0
	self.citrin = false
	self.amber = false
	self.saddle = false
	self.banana = false
	self.spore = false
	self.blueprint = false
	self.boat = false
	self.moonrock = false
	self.gnome = false
	self.mosquito = false
	self.emeralds = 0
	self.emerald = false
    self.walkalot = false
    self.stopalot = false
    self.tooyoung = false
    self.evil = false
    self.evilamount = 0
    self.snake = false
    self.deathalot = false
    self.deathamouth = 0
    self.nosanity = false
    self.nosanitytime = 0
    self.sick = false
    self.coldblood = false
    self.snakeamount = 0
    self.burn = false
    self.freeze = false
    self.goodman = false
    self.brother = false
    self.friendpig = 0
    self.friendbunny = 0
    self.fishmaster = false
    self.fishamount = 0
    self.pickmaster = false
	self.pickappren = false
    self.pickamount = 0
    self.chopmaster = false
	self.chopappren = false
    self.chopamount = 0
    self.noob = false
    self.cookmaster = false
	self.cookappren = false
    self.cookamount = 0
	self.minemaster = false
	self.mineappren = false
	self.mineamount = 0
    self.longage = false
    self.age = 1
    self.luck = false
    self.black = false
    self.buildmaster = false
	self.buildappren = false
    self.buildamount = 0
    self.tank = false
    self.angry = false
    self.attackeddamage = 0
    self.onhitdamage = 0
    self.icebody = false
    self.firebody = false
    self.moistbody = false
    self.icetime = 0
    self.firetime = 0
    self.moisttime = 0
    self.rigid = false
    self.ancient = false
    self.queen = false
    self.bosswinter = false
    self.bossspring = false
    self.bossantlion = false
    self.bossautumn = false
    self.king = false
    self.all = false
	self.minotaur = false
    self.rook = false
    self.knight = false
    self.bishop = false
    self.santa = false
	self.starve = false
	self.starvetime = 0
	self.catperson = false
	self.friendcat = 0
	self.rose = false
    self.butcher = false
    self.mossling = false
    self.weetusk = false
    self.goatperd = false
    self.butcheramount = 0
    self.goatperdamount = 0
    self.weetuskamount = 0
    self.mosslingamount = 0
	self.secondchance = false
	self.nature = false
	self.natureamount = 0
	self.spooder = false
	self.friendspider = 0
	self.hentai = false
	self.hentaiamount = 0
	self.hutch = false
    self.alldiet = false
    self.eatlist = copylist(foodmenu)
    self.eatall = 0
	self.dragonfly = false
	self.malbatross = false
	self.sleep = false
	self.trader = false
	self.tradeamount = 0
	self.fuzzy = false
	self.fuzzyamount = 0
    self.pet = false
    self.caveage = false
    self.cavetime = 0
    self.birdclop = false
    self.eattemp = false
    self.eathot = false
    self.eatcold = false
    self.eathotamount = 0
    self.eatcoldamount = 0
    self.rot = false
    self.knowledge = false
    self.dance = false
    self.danceamount = 0
    self.agereset = 0
    self.oldage = false
    self.rocklob = false
    self.friendrocky = 0
    self.superstar = false
    self.starspent = 0
    self.teleport = false
    self.teleportamount = 0
    self.starreset = 0
    self.knowledgeamount = 0
	
	self.eatfish = false
	self.eatfishamount = 0
	self.eatturkey = false
	self.eatturkeyamount = 0
	self.eatpepper = false
	self.eatpepperamount = 0
	self.eatbacon = false
	self.eatbaconamount = 0
	self.eatmole = false
	self.eatmoleamount = 0
	self.sleeptent = false
	self.sleeptentamount = 0
	self.sleepsiesta = false
	self.sleepsiestaamount = 0
	self.reviveamulet = false
	self.reviveamuletamount = 0
	self.feedplayer = false
	self.feedplayeramount = 0
	self.bathbomb = false
	self.bathbombamount = 0
	self.shadowchester = false
	self.snowchester = false
	self.musichutch = false
	self.lavae = false
	self.evilflower = false
	self.evilfloweramount = 0
	self.roses = false
	self.rosesamount = 0
	self.drown = false
	self.dmgnodmg = false
	self.dmgnodmgamount = 0
	self.bullkelp = false
	self.bullkelpamount = 0
	self.horrorhound = false
	self.horrorhoundamount = 0
	self.slurtle = false
	self.slurtleamount = 0
	self.werepig = false
	self.werepigamount = 0
	self.fruitdragon = false
	self.fruitdragonamount = 0
	self.treeguard = false
	self.treeguardamount = 0
	self.spiderqueen = false
	self.spiderqueenamount = 0
	self.varg = false
	self.vargamount = 0
	self.koaelefant = false
	self.koaelefantamount = 0
	self.monkey = false
	self.monkeyamount = 0
	self.lightning = false
	self.birchnut = false
	self.birchnutamount = 0
	self.rider = false
	self.rideramount = 0
	self.fullsanity = false
	self.fullsanityamount = 0
	self.fullhunger = false
	self.fullhungeramount = 0
	self.pacifist = false
	self.pacifistamount = 0
	
	self.runcount = 0
end,
nil,
{
    intogame = checkintogame,
    firsteat = checkfirsteat,
    supereat = checksupereat,
    danding = checkdanding,
    messiah = checkmessiah,
	emerald = checkemerald,
    walkalot = checkwalkalot,
    stopalot = checkstopalot,
    tooyoung = checktooyoung,
    evil = checkevil,
    snake = checksnake,
    deathalot = checkdeathalot,
    nosanity = checknosanity,
    sick = checksick,
    coldblood = checkcoldblood,
    burn = checkburn,
    freeze = checkfreeze,
    goodman = checkgoodman,
    brother = checkbrother,
    fishmaster = checkfishmaster,
    pickmaster = checkpickmaster,
	pickappren = checkpickappren,
    chopmaster = checkchopmaster,
	chopappren = checkchopappren,
    noob = checknoob,
    cookmaster = checkcookmaster,
	cookappren = checkcookappren,
    longage = checklongage,
    luck = checkluck,
    black = checkblack,
    buildmaster = checkbuildmaster,
	buildappren = checkbuildappren,
	mineappren = checkmineappren,
	minemaster = checkminemaster,
    tank = checktank,
    angry = checkangry,
    icebody = checkicebody,
    firebody = checkfirebody,
    rigid = checkrigid,
    ancient = checkancient,
    queen = checkqueen,
    king = checkking,
    moistbody = checkmoistbody,
    all = checkall,
	minotaur = checkminotaur,
    knight = checkknight,
    bishop = checkbishop,
    rook = checkrook,
    santa = checksanta,
	starve = checkstarve,
	catperson = checkcatperson,
	rose = checkrose,
    mossling = checkmossling,
    weetusk = checkweetusk,
    butcher = checkbutcher,
    goatperd = checkgoatperd,
	secondchance = checksecondchance,
	nature = checknature,
    alldiet = checkalldiet,
	hutch = checkhutch,
	spooder = checkspooder,
	hentai = checkhentai,
	dragonfly = checkdragonfly,
	malbatross = checkmalbatross,
	sleep = checksleep,
	trader = checktrader,
	fuzzy = checkfuzzy,
    pet = checkpet,
    birdclop = checkbirdclop,
    caveage = checkcaveage,
    eathot = checkeathot,
    eatcold = checkeatcold,
    rot = checkrot,
    knowledge = checkknowledge,
    dance = checkdance,
    oldage = checkoldage,
    superstar = checksuperstar,
    rocklob = checkrocklob,
    teleport = checkteleport,
	citrin = checkcitrin,
	amber = checkamber,
	saddle = checksaddle,
	banana = checkbanana,
	spore = checkspore,
	blueprint = checkblueprint,
	boat = checkboat,
	moonrock = checkmoonrock,
	gnome = checkgnome,
	mosquito = checkmosquito,
    eatamount = currenteatamount,
    eatmonsterlasagna = currenteatmonsterlasagna,
    respawnamount = currentrespawnamount,
    walktime = currentwalktime,
	emeralds = currentemeralds,
    stoptime = currentstoptime,
    evilamount = currentevilamount,
    deathamouth = currentdeathamouth,
    nosanitytime = currentnosanitytime,
    snakeamount = currentsnakeamount,
    friendpig = currentfriendpig,
    friendbunny = currentfriendbunny,
    fishamount = currentfishamount,
    pickamount = currentpickamount,
    chopamount = currentchopamount,
    cookamount = currentcookamount,
    buildamount = currentbuildamount,
	mineamount = currentmineamount,
    attackeddamage = currentattackeddamage,
    onhitdamage = currentonhitdamage,
    icetime = currenticetime,
    firetime = currentfiretime,
    moisttime = currentmoisttime,
	starvetime = currentstarvetime,
    age = currentage,
	friendcat = currentfriendcat,
    butcheramount = currentbutcheramount,
    weetuskamount = currentweetuskamount,
    mosslingamount = currentmosslingamount,
    goatperdamount = currentgoatperdamount,
	natureamount = currentnatureamount,
    eatall = currenteatall,
	eatlist = currenteatlist,
	hentaiamount = currenthentaiamount,
	friendspider = currentfriendspider,
	tradeamount = currenttradeamount,
	fuzzyamount = currentfuzzyamount,
    cavetime = currentcavetime,
    eathotamount = currenteathotamount,
    eatcoldamount = currenteatcoldamount,
    danceamount = currentdanceamount,
    friendrocky = currentfriendrocky,
    teleportamount = currentteleportamount,
    starspent = currentstarspent,
    bosswinter = checkbosswinter,
    bossspring = checkbossspring,
    bossantlion = checkbossantlion,
    bossautumn = checkbossautumn,
	citrins = currentcitrins,
	ambers = currentambers,
	saddles = currentsaddles,
	bananas = currentbananas,
	spores = currentspores,
	blueprints = currentblueprints,
	boats = currentboats,
	moonrocks = currentmoonrocks,
	gnomes = currentgnomes,
	mosquitos = currentmosquitos,
	runcount = currentruncount,
	
	eatfish = checkeatfish,
	eatfishamount = currenteatfish,
	eatturkey = checkeatturkey,
	eatturkeyamount = currenteatturkey,
	eatpepper = checkeatpepper,
	eatpepperamount = currenteatpepper,
	eatbacon = checkeatbacon,
	eatbaconamount = currenteatbacon,
	eatmole = checkeatmole,
	eatmoleamount = currenteatmole,
	sleeptent = checksleeptent,
	sleeptentamount = currentsleeptent,
	sleepsiesta = checksleepsiesta,
	sleepsiestaamount = currentsleepsiesta,
	reviveamulet = checkreviveamulet,
	reviveamuletamount = currentreviveamulet,
	feedplayer = checkfeedplayer,
	feedplayeramount = currentfeedplayer,
	bathbomb = checkbathbomb,
	bathbombamount = currentbathbomb,
	shadowchester = checkshadowchester,
	snowchester = checksnowchester,
	musichutch = checkmusichutch,
	lavae = checklavae,
	evilflower = checkevilflower,
	evilfloweramount = currentevilflower,
	roses = checkroses,
	rosesamount = currentroses,
	drown = checkdrown,
	dmgnodmg = checkdmgnodmg,
	dmgnodmgamount = currentdmgnodmg,
	bullkelp = checkbullkelp,
	bullkelpamount = currentbullkelp,
	horrorhound = checkhorrorhound,
	horrorhoundamount = currenthorrorhound,
	slurtle = checkslurtle,
	slurtleamount = currentslurtle,
	werepig = checkwerepig,
	werepigamount = currentwerepig,
	fruitdragon = checkfruitdragon,
	fruitdragonamount = currentfruitdragon,
	treeguard = checktreeguard,
	treeguardamount = currenttreeguard,
	spiderqueen = checkspiderqueen,
	spiderqueenamount = currentspiderqueen,
	varg = checkvarg,
	vargamount = currentvarg,
	koaelefant = checkkoaelefant,
	koaelefantamount = currentkoaelefant,
	monkey = checkmonkey,
	monkeyamount = currentmonkey,
	lightning = checklightning,
	birchnut = checkbirchnut,
	birchnutamount = currentbirchnut,
	rider = checkrider,
	rideramount = currentrider,
	fullsanity = checkfullsanity,
	fullsanityamount = currentfullsanity,
	fullhunger = checkfullhunger,
	fullhungeramount = currentfullhunger,
	pacifist = checkpacifist,
	pacifistamount = currentpacifist,
})

--Save
function allachivevent:OnSave()
    local data = {
        intogame = self.intogame,
        firsteat = self.firsteat,
        supereat = self.supereat,
        eatamount = self.eatamount,
        danding = self.danding,
        eatmonsterlasagna = self.eatmonsterlasagna,
        messiah = self.messiah,
        respawnamount = self.respawnamount,
        walktime = self.walktime,
        stoptime = self.stoptime,
		emeralds = self.emeralds,
		emerald = self.emerald,
		citrin = self.citrin,
		amber = self.amber,
		saddle = self.saddle,
		banana = self.banana,
		spore = self.spore,
		blueprint = self.blueprint,
		boat = self.boat,
		moonrock = self.moonrock, 
		gnome = self.gnome,
		mosquito = self.mosquito,
		citrins = self.citrins,
		ambers = self.ambers,
		saddles = self.saddles,
		bananas = self.bananas,
		spores = self.spores,
		blueprints = self.blueprints,
		boats = self.boats,
		moonrocks = self.moonrocks,
		gnomes = self.gnomes,
		mosquitos = self.mosquitos, 
        walkalot = self.walkalot,
        stopalot = self.stopalot,
        tooyoung = self.tooyoung,
        evil = self.evil,
        evilamount = self.evilamount,
        snake = self.snake,
        deathalot = self.deathalot,
        deathamouth = self.deathamouth,
        nosanity = self.nosanity,
        nosanitytime = self.nosanitytime,
        sick = self.sick,
        coldblood = self.coldblood,
        snakeamount = self.snakeamount,
        burn = self.burn,
        freeze = self.freeze,
        goodman = self.goodman,
        brother = self.brother,
        friendpig = self.friendpig,
        friendbunny = self.friendbunny,
        fishmaster = self.fishmaster,
        fishamount = self.fishamount,
        pickmaster = self.pickmaster,
		pickappren = self.pickappren,
        pickamount = self.pickamount,
        chopmaster = self.chopmaster,
		chopappren = self.chopappren,
        chopamount = self.chopamount,
		minemaster = self.minemaster,
		mineappren = self.mineappren,
		mineamount = self.mineamount,
        noob = self.noob,
        cookmaster = self.cookmaster,
		cookappren = self.cookappren,
        cookamount = self.cookamount,
        longage = self.longage,
        luck = self.luck,
        black = self.black,
        buildmaster = self.buildmaster,
		buildappren = self.buildappren,
        buildamount = self.buildamount,
        tank = self.tank,
        angry = self.angry,
        attackeddamage = self.attackeddamage,
        onhitdamage = self.onhitdamage,
        icebody = self.icebody,
        firebody = self.firebody,
        moistbody = self.moistbody,
        icetime = self.icetime,
        firetime = self.firetime,
        moisttime = self.moisttime,
        rigid = self.rigid,
        ancient = self.ancient,
        queen = self.queen,
        bosswinter = self.bosswinter,
        bossspring = self.bossspring,
        bossantlion = self.bossantlion,
        bossautumn = self.bossautumn,
        king = self.king,
        all = self.all,
		minotaur = self.minotaur,
        santa = self.santa,
        knight = self.knight,
        rook = self.rook,
        bishop = self.bishop,
		starve = self.starve,
		starvetime = self.starvetime,
		catperson = self.catperson,
		friendcat = self.friendcat,
		rose = self.rose,
        butcher = self.butcher,
        goatperd = self.goatperd,
        mossling = self.mossling,
        weetusk = self.weetusk,
        butcheramount = self.butcheramount,
        goatperdamount = self.goatperdamount,
        mosslingamount = self.mosslingamount,
        weetuskamount = self.weetuskamount,
		secondchance = self.secondchance,
		nature = self.nature,
		natureamount = self.natureamount,
		alldiet = self.alldiet,
        eatall = self.eatall,
        eatlist = self.eatlist,
		hentai = self.hentai,
		hentaiamount = self.hentaiamount,
		hutch = self.hutch,
		spooder = self.spooder,
		friendspider = self.friendspider,
		dragonfly = self.dragonfly,
		malbatross = self.malbatross,
		sleep = self.sleep,
		trader = self.trader,
		tradeamount = self.tradeamount,
		fuzzyamount = self.fuzzyamount,
		fuzzy = self.fuzzy,
        pet = self.pet,
        caveage = self.caveage,
        cavetime = self.cavetime,
        birdclop = self.birdclop,
        eattemp = self.eattemp,
        eathot = self.eathot,
        eathotamount = self.eathotamount,
        eatcold = self.eatcold,
        eatcoldamount = self.eatcoldamount,
        rot = self.rot,
        knowledge = self.knowledge,
        dance = self.dance,
        danceamount = self.danceamount,
        agereset = self.agereset,
        oldage = self.oldage,
        rocklob = self.rocklob,
        superstar = self.superstar,
        teleport = self.teleport,
        friendrocky = self.friendrocky,
        starspent = self.starspent,
        teleportamount = self.teleportamount,
        starreset = self.starreset,
        knowledgeamount = self.knowledgeamount,
		
		runcount = self.runcount,
		
		eatfish = self.eatfish,
		eatfishamount = self.eatfishamount,
		eatturkey = self.eatturkey,
		eatturkeyamount = self.eatturkeyamount,
		eatpepper = self.eatpepper,
		eatpepperamount = self.eatpepperamount,
		eatbacon = self.eatbacon,
		eatbaconamount = self.eatbaconamount,
		eatmole = self.eatmole,
		eatmoleamount = self.eatmoleamount,
		sleeptent = self.sleeptent,
		sleeptentamount = self.sleeptentamount,
		sleepsiesta = self.sleepsiesta,
		sleepsiestaamount = self.sleepsiestaamount,
		reviveamulet = self.reviveamulet,
		reviveamuletamount = self.reviveamuletamount,
		feedplayer = self.feedplayer,
		feedplayeramount = self.feedplayeramount,
		bathbomb = self.bathbomb,
		bathbombamount = self.bathbombamount,
		shadowchester = self.shadowchester,
		snowchester = self.snowchester,
		musichutch = self.musichutch,
		lavae = self.lavae,
		evilflower = self.evilflower,
		evilfloweramount = self.evilfloweramount,
		roses = self.roses,
		rosesamount = self.rosesamount,
		drown = self.drown,
		dmgnodmg = self.dmgnodmg,
		dmgnodmgamount = self.dmgnodmgamount,
		bullkelp = self.bullkelp,
		bullkelpamount = self.bullkelpamount,
		horrorhound = self.horrorhound,
		horrorhoundamount = self.horrorhoundamount,
		slurtle = self.slurtle,
		slurtleamount = self.slurtleamount,
		werepig = self.werepig,
		werepigamount = self.werepigamount,
		fruitdragon = self.fruitdragon,
		fruitdragonamount = self.fruitdragonamount,
		treeguard = self.treeguard,
		treeguardamount = self.treeguardamount,
		spiderqueen = self.spiderqueen,
		spiderqueenamount = self.spiderqueenamount,
		varg = self.varg,
		vargamount = self.vargamount,
		koaelefant = self.koaelefant,
		koaelefantamount = self.koaelefantamount,
		monkey = self.monkey,
		monkeyamount = self.monkeyamount,
		lightning = self.lightning,
		birchnut = self.birchnut,
		birchnutamount = self.birchnutamount,
		rider = self.rider,
		rideramount = self.rideramount,
		fullsanity = self.fullsanity,
		fullsanityamount = self.fullsanityamount,
		fullhunger = self.fullhunger,
		fullhungeramount = self.fullhungeramount,
		pacifist = self.pacifist,
		pacifistamount = self.pacifistamount,
    }
    return data
end

--Load
function allachivevent:OnLoad(data)
    self.intogame = data.intogame or false
    self.firsteat = data.firsteat or false
    self.supereat = data.supereat or false
    self.eatamount = data.eatamount or 0
    self.danding = data.danding or false
    self.eatmonsterlasagna = data.eatmonsterlasagna or 0
    self.messiah = data.messiah or false
    self.respawnamount = data.respawnamount or 0
    self.walktime = data.walktime or 0
    self.stoptime = data.stoptime or 0
	self.emeralds = data.emeralds or 0
	self.emerald = data.emerald or false
	self.citrin = data.citrin or false
	self.amber = data.amber or false
	self.saddle = data.saddle or false 
	self.banana = data.banana or false
	self.spore = data.spore or false
	self.blueprint = data.blueprint or false
	self.boat = data.boat or false
	self.moonrock = data.moonrock or false
	self.gnome = data.gnome or false
	self.mosquito = data.mosquito or false 
	self.citrins = data.citrins or 0
	self.ambers = data.ambers or 0
	self.saddles = data.saddles or 0
	self.bananas = data.bananas or 0
	self.spores = data.spores or 0
	self.blueprints = data.blueprints or 0
	self.boats = data.boats or 0
	self.moonrocks = data.moonrocks or 0 
	self.gnomes = data.gnomes or 0
	self.mosquitos = data.mosquitos or 0
    self.walkalot = data.walkalot or false
    self.stopalot = data.stopalot or false
    self.tooyoung = data.tooyoung or false
    self.evil = data.evil or false
    self.evilamount = data.evilamount or 0
    self.snake = data.snake or false
    self.deathalot = data.deathalot or false
    self.deathamouth = data.deathamouth or 0
    self.nosanity = data.nosanity or false
    self.nosanitytime = data.nosanitytime or 0
    self.sick = data.sick or false
    self.coldblood = data.coldblood or false
    self.snakeamount = data.snakeamount or 0
    self.burn = data.burn or false
    self.freeze = data.freeze or false
    self.goodman = data.goodman or false
    self.brother = data.brother or false
    self.friendpig = data.friendpig or 0
    self.friendbunny = data.friendbunny or 0
    self.fishmaster = data.fishmaster or false
    self.fishamount = data.fishamount or 0
    self.pickmaster = data.pickmaster or false
	self.pickappren = data.pickappren or false
    self.pickamount = data.pickamount or 0
    self.chopmaster = data.chopmaster or false
	self.chopappren = data.chopappren or false
    self.chopamount = data.chopamount or 0
    self.noob = data.noob or false
    self.cookmaster = data.cookmaster or false
	self.cookappren = data.cookappren or false
    self.cookamount = data.cookamount or 0
    self.minemaster = data.minemaster or false
	self.mineappren = data.mineappren or false
    self.mineamount = data.mineamount or 0
    self.longage = data.longage or false
    self.luck = data.luck or false
    self.black = data.black or false
    self.buildmaster = data.buildmaster or false
	self.buildappren = data.buildappren or false
    self.buildamount = data.buildamount or 0
    self.tank = data.tank or false
    self.angry = data.angry or false
    self.attackeddamage = data.attackeddamage or 0
    self.onhitdamage = data.onhitdamage or 0
    self.icebody = data.icebody or false
    self.firebody = data.firebody or false
    self.moistbody = data.moistbody or false
    self.icetime = data.icetime or 0
    self.firetime = data.firetime or 0
    self.moisttime = data.moisttime or 0
    self.rigid = data.rigid or false
    self.ancient = data.ancient or false
    self.queen = data.queen or false
    self.bosswinter = data.bosswinter or false
    self.bossspring = data.bossspring or false
    self.bossantlion = data.bossantlion or false
    self.bossautumn = data.bossautumn or false
    self.king = data.king or false
    self.all = data.all or false
	self.minotaur = data.minotaur or false
    self.santa = data.santa or false
    self.knight = data.knight or false
    self.bishop = data.bishop or false
    self.rook = data.rook or false
	self.starve = data.starve or false
	self.starvetime = data.starvetime or 0
	self.catperson = data.catperson or false
	self.friendcat = data.friendcat or 0
	self.rose = data.rose or false
    self.mossling = data.mossling or false
    self.weetusk = data.weetusk or false
    self.butcher = data.butcher or false
    self.goatperd = data.goatperd or false
    self.mosslingamount = data.mosslingamount or 0
    self.weetuskamount = data.weetuskamount or 0
    self.butcheramount = data.butcheramount or 0
    self.goatperdamount = data.goatperdamount or 0
	self.secondchance = data.secondchance or false
	self.nature = data.nature or false
	self.natureamount = data.natureamount or 0
    self.alldiet = data.alldiet or false
    self.eatall = data.eatall or 0
    self.eatlist = data.eatlist or copylist(foodmenu)
	self.hutch = data.hutch or false
	self.hentai = data.hentai or false
	self.hentaiamount = data.hentaiamount or 0
	self.spooder = data.spooder or false
	self.friendspider = data.friendspider or 0
	self.dragonfly = data.dragonfly or false
	self.malbatross = data.malbatross or false
	self.sleep = data.sleep or false
	self.trader = data.trader or false
	self.tradeamount = data.tradeamount or 0
	self.fuzzy = data.fuzzy or false
	self.fuzzyamount = data.fuzzyamount or 0
    self.pet = data.pet or false
    self.caveage = data.caveage or false
    self.cavetime = data.cavetime or 0
    self.birdclop = data.birdclop or false
    self.eattemp = data.eattemp or false
    self.eathot = data.eathot or false
    self.eatcold = data.eatcold or false
    self.eathotamount = data.eathotamount or 0
    self.eatcoldamount = data.eatcoldamount or 0
    self.rot = data.rot or false
    self.knowledge = data.knowledge or false
    self.dance = data.dance or false
    self.danceamount = data.danceamount or 0
    self.agereset = data.agereset or 0
    self.oldage = data.oldage or false
    self.superstar = data.superstar or false
    self.rocklob = data.rocklob or false
    self.teleport = data.teleport or false
    self.starspent = data.starspent or 0
    self.friendrocky = data.friendrocky or 0
    self.teleportamount = data.teleportamount or 0
    self.starreset = data.starreset or 0
    self.knowledgeamount = data.knowledgeamount or 0
	
	self.runcount = data.runcount or 0
	
	self.eatfish = data.eatfish or false
	self.eatfishamount = data.eatfishamount or 0
	self.eatturkey = data.eatturkey or false
	self.eatturkeyamount = data.eatturkeyamount or 0
	self.eatpepper = data.eatpepper or false
	self.eatpepperamount = data.eatpepperamount or 0
	self.eatbacon = data.eatbacon or false
	self.eatbaconamount = data.eatbaconamount or 0
	self.eatmole = data.eatmole or false
	self.eatmoleamount = data.eatmoleamount or 0
	self.sleeptent = data.sleeptent or false
	self.sleeptentamount = data.sleeptentamount or 0
	self.sleepsiesta = data.sleepsiesta or false
	self.sleepsiestaamount = data.sleepsiestaamount or 0
	self.reviveamulet = data.reviveamulet or false
	self.reviveamuletamount = data.reviveamuletamount or 0
	self.feedplayer = data.feedplayer or false
	self.feedplayeramount = data.feedplayeramount or 0
	self.bathbomb = data.bathbomb or false
	self.bathbombamount = data.bathbombamount or 0
	self.shadowchester = data.shadowchester or false
	self.snowchester = data.snowchester or false
	self.musichutch = data.musichutch or false
	self.lavae = data.lavae or false
	self.evilflower = data.evilflower or false
	self.evilfloweramount = data.evilfloweramount or 0
	self.roses = data.roses or false
	self.rosesamount = data.rosesamount or 0
	self.drown = data.drown or false
	self.dmgnodmg = data.dmgnodmg or false
	self.dmgnodmgamount = data.dmgnodmgamount or 0
	self.bullkelp = data.bullkelp or false
	self.bullkelpamount = data.bullkelpamount or 0
	self.horrorhound = data.horrorhound or false
	self.horrorhoundamount = data.horrorhoundamount or 0
	self.slurtle = data.slurtle or false
	self.slurtleamount = data.slurtleamount or 0
	self.werepig = data.werepig or false
	self.werepigamount = data.werepigamount or 0
	self.fruitdragon = data.fruitdragon or false
	self.fruitdragonamount = data.fruitdragonamount or 0
	self.treeguard = data.treeguard or false
	self.treeguardamount = data.treeguardamount or 0
	self.spiderqueen = data.spiderqueen or false
	self.spiderqueenamount = data.spiderqueenamount or 0
	self.varg = data.varg or false
	self.vargamount = data.vargamount or 0
	self.koaelefant = data.koaelefant or false
	self.koaelefantamount = data.koaelefantamount or 0
	self.monkey = data.monkey or false
	self.monkeyamount = data.monkeyamount or 0
	self.lightning = data.lightning or false
	self.birchnut = data.birchnut or false
	self.birchnutamount = data.birchnutamount or 0
	self.rider = data.rider or false
	self.rideramount = data.rideramount or 0
	self.fullsanity = data.fullsanity or false
	self.fullsanityamount = data.fullsanityamount or 0
	self.fullhunger = data.fullhunger or false
	self.fullhungeramount = data.fullhungeramount or 0
	self.pacifist = data.pacifist or false
	self.pacifistamount = data.pacifistamount or 0
end

--Grant Reward
function allachivevent:seffc(inst, tag)
    SpawnPrefab("seffc").entity:SetParent(inst.entity)
    local str0 = STRINGS.ALLACHIVCURRENCY
    local strname = STRINGS.ALLACHIVNAME
    local strinfo = STRINGS.ALLACHIVINFO
    local strcoin = STRINGS.ALLACHIVCOIN
    if tag == "intogame" and self.all == true then
        TheNet:Announce(inst:GetDisplayName().."   "..strinfo["intogameafterall"]..str0[3]..str0[1]..strname[tag]..str0[2])
    else--if tag == "black" and self.blacktile == "spat" then
        --TheNet:Announce(inst:GetDisplayName().."   "..strinfo["blackspat"]..str0[3]..str0[1]..strname[tag]..str0[2])
    --else
        TheNet:Announce(inst:GetDisplayName().."   "..strinfo[tag]..str0[3]..str0[1]..strname[tag]..str0[2])
    end
    inst.components.talker:Say(str0[6]..strname[tag]..str0[2].."\n"..str0[4]..allachiv_coinget[tag]..str0[5])
    inst.components.allachivcoin:coinDoDelta(allachiv_coinget[tag])
end

--Enter Game
function allachivevent:intogamefn(inst)
    inst:DoTaskInTime(3, function()
        if self.intogame ~= true then
            self.intogame = true
            if AchievementData[inst:GetDisplayName()] ~= nil then
                --print("LOAD")
				local achievements = AchievementData[inst:GetDisplayName()]
                self.firsteat = achievements["firsteat"]
                self.supereat = achievements["supereat"]
                self.eatamount = achievements["eatamount"]
                self.danding = achievements["danding"]
                self.eatmonsterlasagna = achievements["eatmonsterlasagna"]
                self.messiah = achievements["messiah"]
                self.respawnamount = achievements["respawnamount"]
                self.walktime = achievements["walktime"]
                self.stoptime = achievements["stoptime"]
				self.emeralds = achievements["emeralds"]
				self.emerald = achievements["emerald"]
				self.citrin = achievements["citrin"]
				self.amber = achievements["amber"] 
				self.saddle = achievements["saddle"]  
				self.banana = achievements["banana"] 
				self.spore = achievements["spore"] 
				self.blueprint = achievements["blueprint"] 
				self.boat = achievements["boat"] 
				self.moonrock = achievements["moonrock"] 
				self.gnome = achievements["gnome"] 
				self.mosquito = achievements["mosquito"]  
				self.citrins = achievements["citrins"] 
				self.ambers = achievements["ambers"] 
				self.saddles = achievements["saddles"] 
				self.bananas = achievements["bananas"] 
				self.spores = achievements["spores"] 
				self.blueprints = achievements["blueprints"] 
				self.boats = achievements["boats"] 
				self.moonrocks = achievements["moonrocks"]  
				self.gnomes = achievements["gnomes"] 
				self.mosquitos = achievements["mosquitos"] 
                self.walkalot = achievements["walkalot"]
                self.stopalot = achievements["stopalot"]
                self.tooyoung = achievements["tooyoung"]
                self.evil = achievements["evil"]
                self.evilamount = achievements["evilamount"]
                self.snake = achievements["snake"]
                self.deathalot = achievements["deathalot"]
                self.deathamouth = achievements["deathamouth"]
                self.nosanity = achievements["nosanity"]
                self.nosanitytime = achievements["nosanitytime"]
                self.sick = achievements["sick"]
                self.coldblood = achievements["coldblood"]
                self.snakeamount = achievements["snakeamount"]
                self.burn = achievements["burn"]
                self.freeze = achievements["freeze"]
                self.goodman = achievements["goodman"]
                self.brother = achievements["brother"]
                self.friendpig = achievements["friendpig"]
                self.friendbunny = achievements["friendbunny"]
                self.fishmaster = achievements["fishmaster"]
                self.fishamount = achievements["fishamount"]
                self.pickmaster = achievements["pickmaster"]
                self.pickappren = achievements["pickappren"]
                self.pickamount = achievements["pickamount"]
                self.chopmaster = achievements["chopmaster"]
                self.chopappren = achievements["chopappren"]
                self.chopamount = achievements["chopamount"]
                self.noob = achievements["noob"]
                self.cookmaster = achievements["cookmaster"]
                self.cookappren = achievements["cookappren"]
                self.cookamount = achievements["cookamount"]
                self.minemaster = achievements["minemaster"]
                self.mineappren = achievements["mineappren"]
                self.mineamount = achievements["mineamount"]
                self.longage = achievements["longage"]
                self.luck = achievements["luck"]
                self.black = achievements["black"]
                self.buildmaster = achievements["buildmaster"]
                self.buildappren = achievements["buildappren"]
                self.buildamount = achievements["buildamount"]
                self.tank = achievements["tank"]
                self.angry = achievements["angry"]
                self.attackeddamage = achievements["attackeddamage"]
                self.onhitdamage = achievements["onhitdamage"]
                self.icebody = achievements["icebody"]
                self.firebody = achievements["firebody"]
                self.moistbody = achievements["moistbody"]
                self.icetime = achievements["icetime"]
                self.firetime = achievements["firetime"]
                self.moisttime = achievements["moisttime"]
                self.rigid = achievements["rigid"]
                self.ancient = achievements["ancient"]
                self.queen = achievements["queen"]
                self.bosswinter = achievements["bosswinter"]
                self.bossspring = achievements["bossspring"]
                self.bossantlion = achievements["bossantlion"]
                self.bossautumn = achievements["bossautumn"]
                self.king = achievements["king"]
                self.all = achievements["all"]
                self.minotaur = achievements["minotaur"]
                self.santa = achievements["santa"]
                self.knight = achievements["knight"]
                self.bishop = achievements["bishop"]
                self.rook = achievements["rook"]
                self.starve = achievements["starve"]
                self.starvetime = achievements["starvetime"]
                self.catperson = achievements["catperson"]
                self.friendcat = achievements["friendcat"]
                self.rose = achievements["rose"]
                self.mossling = achievements["mossling"]
                self.weetusk = achievements["weetusk"]
                self.butcher = achievements["butcher"]
                self.goatperd = achievements["goatperd"]
                self.mosslingamount = achievements["mosslingamount"]
                self.weetuskamount = achievements["weetuskamount"]
                self.butcheramount = achievements["butcheramount"]
                self.goatperdamount = achievements["goatperdamount"]
                self.secondchance = achievements["secondchance"]
                self.nature = achievements["nature"]
                self.natureamount = achievements["natureamount"]
                self.alldiet = achievements["alldiet"]
                self.eatall = achievements["eatall"]
                self.eatlist = achievements["eatlist"]
                self.hutch = achievements["hutch"]
                self.hentai = achievements["hentai"]
                self.hentaiamount = achievements["hentaiamount"]
                self.spooder = achievements["spooder"]
                self.friendspider = achievements["friendspider"]
                self.dragonfly = achievements["dragonfly"]
				self.malbatross = achievements["malbatross"]
                self.sleep = achievements["sleep"]
                self.trader = achievements["trader"]
                self.tradeamount = achievements["tradeamount"]
                self.fuzzy = achievements["fuzzy"]
                self.fuzzyamount = achievements["fuzzyamount"]
                self.pet = achievements["pet"]
                self.caveage = achievements["caveage"]
                self.cavetime = achievements["cavetime"]
                self.birdclop = achievements["birdclop"]
                self.eattemp = achievements["eattemp"]
                self.eathot = achievements["eathot"]
                self.eatcold = achievements["eatcold"]
                self.eathotamount = achievements["eathotamount"]
                self.eatcoldamount = achievements["eatcoldamount"]
                self.rot = achievements["rot"]
                self.knowledge = achievements["knowledge"]
                self.dance = achievements["dance"]
                self.danceamount = achievements["danceamount"]
                self.agereset = achievements["agereset"]
                self.oldage = achievements["oldage"]
                self.superstar = achievements["superstar"]
                self.rocklob = achievements["rocklob"]
                self.teleport = achievements["teleport"]
                self.starspent = achievements["starspent"]
                self.friendrocky = achievements["friendrocky"]
                self.teleportamount = achievements["teleportamount"]
                self.starreset = achievements["starreset"]
                self.knowledgeamount = achievements["knowledgeamount"]
				self.runcount = achievements["runcount"]
				self.eatfish = achievements["eatfish"]
				self.eatfishamount = achievements["eatfishamount"]
				self.eatturkey = achievements["eatturkey"]
				self.eatturkeyamount = achievements["eatturkeyamount"]
				self.eatpepper = achievements["eatpepper"]
				self.eatpepperamount = achievements["eatpepperamount"]
				self.eatbacon = achievements["eatbacon"]
				self.eatbaconamount = achievements["eatbaconamount"]
				self.eatmole = achievements["eatmole"]
				self.eatmoleamount = achievements["eatmoleamount"]
				self.sleeptent = achievements["sleeptent"]
				self.sleeptentamount = achievements["sleeptentamount"]
				self.sleepsiesta = achievements["sleepsiesta"]
				self.sleepsiestaamount = achievements["sleepsiestaamount"]
				self.reviveamulet = achievements["reviveamulet"]
				self.reviveamuletamount = achievements["reviveamuletamount"]
				self.feedplayer = achievements["feedplayer"]
				self.feedplayeramount = achievements["feedplayeramount"]
				self.bathbomb = achievements["bathbomb"]
				self.bathbombamount = achievements["bathbombamount"]
				self.shadowchester = achievements["shadowchester"]
				self.snowchester = achievements["snowchester"]
				self.musichutch = achievements["musichutch"]
				self.lavae = achievements["lavae"]
				self.evilflower = achievements["evilflower"]
				self.evilfloweramount = achievements["evilfloweramount"]
				self.roses = achievements["roses"]
				self.rosesamount = achievements["rosesamount"]
				self.drown = achievements["drown"]
				self.dmgnodmg = achievements["dmgnodmg"]
				self.dmgnodmgamount = achievements["dmgnodmgamount"]
				self.bullkelp = achievements["bullkelp"]
				self.bullkelpamount = achievements["bullkelpamount"]
				self.horrorhound = achievements["horrorhound"]
				self.horrorhoundamount = achievements["horrorhoundamount"]
				self.slurtle = achievements["slurtle"]
				self.slurtleamount = achievements["slurtleamount"]
				self.werepig = achievements["werepig"]
				self.werepigamount = achievements["werepigamount"]
				self.fruitdragon = achievements["fruitdragon"]
				self.fruitdragonamount = achievements["fruitdragonamount"]
				self.treeguard = achievements["treeguard"]
				self.treeguardamount = achievements["treeguardamount"]
				self.spiderqueen = achievements["spiderqueen"]
				self.spiderqueenamount = achievements["spiderqueenamount"]
				self.varg = achievements["varg"]
				self.vargamount = achievements["vargamount"]
				self.koaelefant = achievements["koaelefant"]
				self.koaelefantamount = achievements["koaelefantamount"]
				self.monkey = achievements["monkey"]
				self.monkeyamount = achievements["monkeyamount"]
				self.lightning = achievements["lightning"]
				self.birchnut = achievements["birchnut"]
				self.birchnutamount = achievements["birchnutamount"]
				self.rider = achievements["rider"]
				self.rideramount = achievements["rideramount"]
				self.fullsanity = achievements["fullsanity"]
				self.fullsanityamount = achievements["fullsanityamount"]
				self.fullhunger = achievements["fullhunger"]
				self.fullhungeramount = achievements["fullhungeramount"]
				self.pacifist = achievements["pacifist"]
				self.pacifistamount = achievements["pacifistamount"]
                inst.components.allachivcoin.coinamount  = achievements["totalstar"]
                AchievementData[inst:GetDisplayName()] = nil
            else
                self:seffc(inst, "intogame")

                if self.all ~= true then
                    inst:DoTaskInTime(2, function()
						if _G.STARTGEAR_CONFIG == "fight" then 
							local item = SpawnPrefab("spear")				  
                            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
                            item = SpawnPrefab("armorwood")
                            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
							item = SpawnPrefab("boomerang")
                            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
						end
						if _G.STARTGEAR_CONFIG == "survive" then
							local item = SpawnPrefab("axe")
                            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
							item = SpawnPrefab("bonestew")				  
                            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
                            item = SpawnPrefab("backpack_blueprint")
                            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
							item = SpawnPrefab("bedroll_furry")
                            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
							item = SpawnPrefab("torch")
                            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
						end												
                    end)
                end
            end
        end
		if(_G.CAVES_CONFIG == false) then
			self.tooyoung = true
			self.banana = true
			self.spore = true
			self.rot = true
			self.hutch = true
			self.hentai = true
			self.rigid = true
			self.ancient = true
			self.minotaur = true
			self.brother = true
			self.rocklob = true
			self.caveage = true
			self.knowledge = true
			self.slurtle = true
			self.monkey = true
		end
		if inst.prefab == "wickerbottom" then
			self.sleeptent = true
			self.sleeptentamount = 12
			self.sleepsiesta = true
			self.sleepsiestaamount = 12
		end
    end)
end

--Eat Achievement
function allachivevent:eatfn(inst)
	inst:ListenForEvent("oneat", function(inst, data)
		if inst:GetDisplayName() ~= data.feeder:GetDisplayName() and data.feeder.components.allachivevent.feedplayer ~= true and findprefab(foodmenu, data.food.prefab) then
			data.feeder.components.allachivevent.feedplayeramount = data.feeder.components.allachivevent.feedplayeramount + 1
			if data.feeder.components.allachivevent.feedplayeramount >= allachiv_eventdata["feedplayer"] then
				data.feeder.components.allachivevent.feedplayer = true
				data.feeder.components.allachivevent:seffc(data.feeder, "feedplayer")
			end
		end
		if self.feedplayer ~= true and data.food.prefab == "monsterlasagna" then
			self.feedplayeramount = self.feedplayeramount + 0.5
			if self.feedplayeramount >= allachiv_eventdata["feedplayer"] then
				self.feedplayer = true
				self:seffc(inst, "feedplayer")
			end
		end
		local food = data.food
		--First Eat
		if self.firsteat ~= true then
			self.firsteat = true
			self:seffc(inst, "firsteat")
		end
		--Eat 100
		if self.supereat ~= true then
			self.eatamount = self.eatamount + 1
			if self.eatamount >= allachiv_eventdata["supereat"] then
				self.supereat = true
				self:seffc(inst, "supereat")
			end
		end
		--Eat Lasagna
		if self.danding ~= true and food.prefab == "monsterlasagna" then
			self.eatmonsterlasagna = self.eatmonsterlasagna + 1
			if self.eatmonsterlasagna >= allachiv_eventdata["danding"] then
				self.danding = true
				self:seffc(inst, "danding")
			end
		end
		--Warm Up
		if inst.components.temperature.current <= 0 and inst.components.health.currenthealth > 0
			and findprefab(heatfood, food.prefab) and self.eathot ~= true and self.eattemp ~= true then
			self.eathotamount = self.eathotamount + 1
			self.eattemp = true
			if self.eathotamount >= allachiv_eventdata["eathot"] then
				self.eathot = true
				self:seffc(inst,"eathot")
			end
			inst:DoTaskInTime(5, function()
				self.eattemp = false
			end)
		end

		--Cool Down
		if inst.components.temperature.current >= 70 and inst.components.health.currenthealth > 0
			and findprefab(coldfood, food.prefab) and self.eatcold ~= true and self.eattemp ~= true then
			self.eatcoldamount = self.eatcoldamount + 1
			self.eattemp = true
			if self.eatcoldamount >= allachiv_eventdata["eatcold"] then
				self.eatcold = true
				self:seffc(inst,"eatcold")
			end
			inst:DoTaskInTime(5, function()
				self.eattemp = false
			end)
		end
		
		--Eat Fish
		if self.eatfish ~= true and food.prefab == "fishsticks" then
			self.eatfishamount = self.eatfishamount + 1
			if self.eatfishamount >= allachiv_eventdata["eatfish"] then
				self.eatfish = true
				self:seffc(inst, "eatfish")
			end
		end
		--Eat Turkey
		if self.eatturkey ~= true and food.prefab == "turkeydinner" then
			self.eatturkeyamount = self.eatturkeyamount + 1
			if self.eatturkeyamount >= allachiv_eventdata["eatturkey"] then
				self.eatturkey = true
				self:seffc(inst, "eatturkey")
			end
		end
		--Eat Pepper
		if self.eatpepper ~= true and food.prefab == "pepperpopper" then
			self.eatpepperamount = self.eatpepperamount + 1
			if self.eatpepperamount >= allachiv_eventdata["eatpepper"] then
				self.eatpepper = true
				self:seffc(inst, "eatpepper")
			end
		end
		--Eat Bacon
		if self.eatbacon ~= true and food.prefab == "baconeggs" then
			self.eatbaconamount = self.eatbaconamount + 1
			if self.eatbaconamount >= allachiv_eventdata["eatbacon"] then
				self.eatbacon = true
				self:seffc(inst, "eatbacon")
			end
		end
		--Eat Guacamole
		if self.eatmole ~= true and food.prefab == "guacamole" then
			self.eatmoleamount = self.eatmoleamount + 1
			if self.eatmoleamount >= allachiv_eventdata["eatmole"] then
				self.eatmole = true
				self:seffc(inst, "eatmole")
			end
		end
		--All Crockpot Food
		if self.alldiet ~= true then
			if findprefab(self.eatlist,food.prefab) then
				self.eatall = self.eatall + 1
				table.remove(self.eatlist,findindex(self.eatlist,food.prefab))
				currenteatlist(self,self.eatlist)
				if next(self.eatlist) == nil then
					self.eatall = 40
					self.alldiet = true
					self:seffc(inst, "alldiet")
				end
			end
		end
	end)
	
    inst:DoTaskInTime(1, function()
        --Meatatarian case -> remove the veggie dishes from the eatlist.
		if inst.prefab == "wathgrithr" then
			self:updateMeatatarianFoodList()
		end
    end)
end

function allachivevent:updateMeatatarianFoodList()
	for index,value in pairs(veggie) do
		if findprefab(self.eatlist,value) then
			table.remove(self.eatlist,findindex(self.eatlist,value))
			self.eatall = self.eatall + 1
		end
	end
	currenteatlist(self,self.eatlist)
end

--Have in inventory
function allachivevent:onhavefn(inst)
	inst:DoPeriodicTask(5, function()
		-- Green Gem
		if self.emerald ~= true then
			local items = inst.components.inventory:FindItems(function(item) return item.prefab=="greengem" end)
			local count = 0
			for i, item in ipairs(items) do
				count = count + (item.components.stackable ~= nil and item.components.stackable:StackSize() or 1)
			end
			self.emeralds = count
			if(count >= allachiv_eventdata["emerald"]) then
				self.emerald = true
				self:seffc(inst, "emerald")
			end
		end
		-- Yellow Gem - yellowgem
		if self.citrin ~= true then
			local items = inst.components.inventory:FindItems(function(item) return item.prefab=="yellowgem" end)
			local count = 0
			for i, item in ipairs(items) do
				count = count + (item.components.stackable ~= nil and item.components.stackable:StackSize() or 1)
			end
			self.citrins = count
			if(count >= allachiv_eventdata["citrin"]) then
				self.citrin = true
				self:seffc(inst, "citrin")
			end
		end
		-- Orange Gem - orangegem
		if self.amber ~= true then
			local items = inst.components.inventory:FindItems(function(item) return item.prefab=="orangegem" end)
			local count = 0
			for i, item in ipairs(items) do
				count = count + (item.components.stackable ~= nil and item.components.stackable:StackSize() or 1)
			end
			self.ambers = count
			if(count >= allachiv_eventdata["amber"]) then
				self.amber = true
				self:seffc(inst, "amber")
			end
		end
		-- Glossamer Saddle - saddle_race
		if self.saddle ~= true then
			local item = inst.components.inventory:FindItem(function(item) return item.prefab=="saddle_race" end)
			if(item ~= nil) then
				self.saddles = 1
				self.saddle = true
				self:seffc(inst, "saddle")
			end
		end
		-- Cooked Cave Banana - cave_banana_cooked
		if self.banana ~= true then
			local items = inst.components.inventory:FindItems(function(item) return item.prefab=="cave_banana_cooked" end)
			local count = 0
			for i, item in ipairs(items) do
				count = count + (item.components.stackable ~= nil and item.components.stackable:StackSize() or 1)
			end
			self.bananas = count
			if(count >= allachiv_eventdata["banana"]) then
				self.banana = true
				self:seffc(inst, "banana")
			end
		end
		-- Green Blue Red Spores - spore_small, spore_tall, spore_medium
		if self.spore ~= true then
			local items = inst.components.inventory:FindItems(function(item) return item.prefab=="spore_small" end)
			local countgreen = 0
			for i, item in ipairs(items) do
				countgreen = countgreen + (item.components.stackable ~= nil and item.components.stackable:StackSize() or 1)
			end
			items = inst.components.inventory:FindItems(function(item) return item.prefab=="spore_medium" end)
			local countred = 0
			for i, item in ipairs(items) do
				countred = countred + (item.components.stackable ~= nil and item.components.stackable:StackSize() or 1)
			end
			items = inst.components.inventory:FindItems(function(item) return item.prefab=="spore_tall" end)
			local countblue = 0
			for i, item in ipairs(items) do
				countblue = countblue + (item.components.stackable ~= nil and item.components.stackable:StackSize() or 1)
			end
			
			self.spores = math.min(countgreen, countred, countblue)
			if(countgreen >= allachiv_eventdata["spore"] and countred >= allachiv_eventdata["spore"] and countblue >= allachiv_eventdata["spore"]) then
				self.spore = true
				self:seffc(inst, "spore")
			end
		end
		-- Blueprints (string.match(str, "blueprint"))
		if self.blueprint ~= true then
			local items = inst.components.inventory:FindItems(function(item) return string.match(item.prefab, "blueprint?") == "blueprint" end)
			local count = 0
			for i, item in ipairs(items) do
				count = count + (item.components.stackable ~= nil and item.components.stackable:StackSize() or 1)
			end
			self.blueprints = count
			if(count >= allachiv_eventdata["blueprint"]) then
				self.blueprint = true
				self:seffc(inst, "blueprint")
			end
		end
		-- All boatpieces - steeringwheel_item, mast_item, anchor_item, oar, boat_item
		if self.boat ~= true then
			local itemWheel = inst.components.inventory:FindItem(function(item) return item.prefab=="steeringwheel_item" end)
			local itemMast = inst.components.inventory:FindItem(function(item) return item.prefab=="mast_item" end)
			local itemAnchor = inst.components.inventory:FindItem(function(item) return item.prefab=="anchor_item" end)
			local itemOar = inst.components.inventory:FindItem(function(item) return item.prefab=="oar" end)
			local itemBoat = inst.components.inventory:FindItem(function(item) return item.prefab=="boat_item" end)
			local count = 0
			if itemWheel ~= nil then count = count + 1 end
			if itemMast ~= nil then count = count + 1 end
			if itemAnchor ~= nil then count = count + 1 end
			if itemOar ~= nil then count = count + 1 end
			if itemBoat ~= nil then count = count + 1 end
			self.boats = count
			if(count >= 5) then
				self.boat = true
				self:seffc(inst, "boat")
			end
		end
		-- Moonrock - moonrocknugget
		if self.moonrock ~= true then
			local items = inst.components.inventory:FindItems(function(item) return item.prefab=="moonrocknugget" end)
			local count = 0
			for i, item in ipairs(items) do
				count = count + (item.components.stackable ~= nil and item.components.stackable:StackSize() or 1)
			end
			self.moonrocks = count
			if(count >= allachiv_eventdata["moonrock"]) then
				self.moonrock = true
				self:seffc(inst, "moonrock")
			end
		end
		-- Gnomes - trinket_4 and trinket_13
		if self.gnome ~= true then
			local items = inst.components.inventory:FindItems(function(item) return item.prefab=="trinket_4" or item.prefab=="trinket_13" end)
			local count = 0
			for i, item in ipairs(items) do
				count = count + (item.components.stackable ~= nil and item.components.stackable:StackSize() or 1)
			end
			self.gnomes = count
			if(count >= allachiv_eventdata["gnome"]) then
				self.gnome = true
				self:seffc(inst, "gnome")
			end
		end
		-- Mosquitos - mosquito
		if self.mosquito ~= true then
			local items = inst.components.inventory:FindItems(function(item) return item.prefab=="mosquito" end)
			local count = 0
			for i, item in ipairs(items) do
				count = count + (item.components.stackable ~= nil and item.components.stackable:StackSize() or 1)
			end
			self.mosquitos = count
			if(count >= allachiv_eventdata["mosquito"]) then
				self.mosquito = true
				self:seffc(inst, "mosquito")
			end
		end
		-- Bathbomb - bathbomb
		if self.bathbomb ~= true then
			local items = inst.components.inventory:FindItems(function(item) return item.prefab=="bathbomb" end)
			local count = 0
			for i, item in ipairs(items) do
				count = count + (item.components.stackable ~= nil and item.components.stackable:StackSize() or 1)
			end
			self.bathbombamount = count
			if(count >= allachiv_eventdata["bathbomb"]) then
				self.bathbomb = true
				self:seffc(inst, "bathbomb")
			end
		end
	end)
end

--Movement
function allachivevent:onwalkfn(inst)
    inst:DoPeriodicTask(1, function()
        if inst:HasTag("playerghost") then return end
		if self.pacifist ~= true then
			self.pacifistamount = self.pacifistamount + 1
					if self.pacifistamount >= allachiv_eventdata["pacifist"] then
						self.pacifist = true
						self:seffc(inst, "pacifist")
					end
		end
        if inst.components.locomotor.wantstomoveforward then
            --Walk or Ride
			if inst.components.rider ~= nil and inst.components.rider:IsRiding() and inst.components.rider.mount ~= nil and inst.components.rider.mount.prefab == "beefalo" then
				if self.rider ~= true then
					self.rideramount = self.rideramount + 1
					if self.rideramount >= allachiv_eventdata["rider"] then
						self.rider = true
						self:seffc(inst, "rider")
					end
				end
			else
				if self.walkalot ~= true then
					self.walktime = self.walktime + 1
					if self.walktime >= allachiv_eventdata["walkalot"] then
						self.walkalot = true
						self:seffc(inst, "walkalot")
					end
				end
			end
            
        else
            --Stop
            if self.stopalot ~= true then
                self.stoptime = self.stoptime + 1
                if self.stoptime >= allachiv_eventdata["stopalot"] then
                    self.stopalot = true
                    self:seffc(inst, "stopalot")
                end
            end
        end
    end)
end
--Death
function allachivevent:onkilled(inst)
    inst:ListenForEvent("death", function(inst, data)
        local attacker = inst.components.combat.lastattacker
        --Cave Earthquake
        if attacker and attacker.prefab and attacker:IsValid() and self.tooyoung ~= true then
            if attacker.prefab == "flint"
            or attacker.prefab == "rocks"
            or attacker.prefab == "redgem"
            or attacker.prefab == "bluegem"
            or attacker.prefab == "goldnugget"
            or attacker.prefab == "nitre"
            or attacker.prefab == "marble" then
                inst:DoTaskInTime(2, function()
                    self.tooyoung = true
                    self:seffc(inst, "tooyoung")
                end)
            end
        end
        --Die 10 times
        if self.deathalot ~= true then
            self.deathamouth = self.deathamouth + 1
            if self.deathamouth >= allachiv_eventdata["deathalot"] then
                inst:DoTaskInTime(2, function()
                    self.deathalot = true
                    self:seffc(inst, "deathalot")
                end)
            end
        end
        --Charlie
        if data and data.cause and data.cause == "NIL" and self.noob ~= true then
            inst:DoTaskInTime(2, function()
                self.noob = true
                self:seffc(inst, "noob")
            end)
        end
        --Rose
        if data and data.cause and data.cause == "flower" and self.rose ~= true then
            inst:DoTaskInTime(2, function()
                self.rose = true
                self:seffc(inst, "rose")
            end)
        end
        --Spore Cloud
        if data and data.cause and data.cause == "sporecloud" and self.rot ~= true then
            inst:DoTaskInTime(2, function()
                self.rot = true
                self:seffc(inst, "rot")
            end)
        end
        --Electrocuted
        -- if data and data.cause and data.cause == "lightning" and self.black ~= true then
            -- inst:DoTaskInTime(2, function()
                -- self.black = true
                -- self.blacktile = "thunder"
                -- self:seffc(inst, "black")
            -- end)
        -- end
    end)
end

--Zero Sanity
function allachivevent:sanitycheck(inst)
    inst:DoPeriodicTask(1, function()
        if inst.components.sanity.current < 1 and self.nosanity ~= true and inst.components.health.currenthealth > 0 then
            self.nosanitytime = self.nosanitytime + 1
            if self.nosanitytime >= allachiv_eventdata["nosanity"] then
                self.nosanity = true
                self:seffc(inst, "nosanity")
            end
        end
		if inst.components.sanity.current >= inst.components.sanity.max*0.95 and self.fullsanity ~= true and inst.components.health.currenthealth > 0 then
            self.fullsanityamount = self.fullsanityamount + 1
            if self.fullsanityamount >= allachiv_eventdata["fullsanity"] then
                self.fullsanity = true
                self:seffc(inst, "fullsanity")
            end
        end
    end)
end

--high hunger
function allachivevent:hungercheck(inst)
    inst:DoPeriodicTask(1, function()
		if inst.components.hunger.current >= inst.components.hunger.max*0.95 and self.fullhunger ~= true and inst.components.health.currenthealth > 0 then
            self.fullhungeramount = self.fullhungeramount + 1
            if self.fullhungeramount >= allachiv_eventdata["fullhunger"] then
                self.fullhunger = true
                self:seffc(inst, "fullhunger")
            end
        end
    end)
end

--Killing
function allachivevent:onkilledother(inst)
    inst:ListenForEvent("killed", function(inst, data)
        local victim = data.victim
        --Glommer
        if victim and victim.prefab == "glommer" then
			local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if v.components.allachivevent.sick ~= true then
						v.components.allachivevent.sick = true
						v.components.allachivevent:seffc(v, "sick")
					end
                end
            end
        end
        --Chester
        if victim and victim.prefab == "chester" and self.coldblood ~= true then
            self.coldblood = true
            self:seffc(inst, "coldblood")
        end
		--Fugu Hutch
		if victim and victim.prefab == "hutch" and victim.components.amorphous:GetCurrentForm() == "FUGU" and self.hutch ~= true and inst.components.health.currenthealth <= 10  then 
            self.hutch = true
            self:seffc(inst, "hutch")
        end
        --Tentapillar
        if victim and victim.prefab == "tentacle_pillar" and self.hentai ~= true then
            local single = true
            local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 15)
            for k,v in pairs(ents) do
                if (v:HasTag("player") or v.prefab == "bunnyman" or v.prefab == "hutch" or v.prefab == "rocky" or v.prefab == "pigman" or v.prefab == "abigail") and v ~= inst then
                    single = false
                end
            end
            if single == true then
				self.hentaiamount = self.hentaiamount + 1
				if self.hentaiamount >= allachiv_eventdata["hentai"] then
					self.hentai = true
					self:seffc(inst, "hentai")
				end
            end
        end
        --Tentacle
        if victim and victim.prefab == "tentacle" and self.snake ~= true then
            self.snakeamount = self.snakeamount + 1
            if self.snakeamount >= allachiv_eventdata["snake"] then
                self.snake = true
                self:seffc(inst, "snake")
            end
        end
        --WeeTusk
        if victim and victim.prefab == "little_walrus" then
			local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if not v.components.allachivevent.weetusk then
						v.components.allachivevent.weetuskamount = v.components.allachivevent.weetuskamount + 1
						if v.components.allachivevent.weetuskamount >= allachiv_eventdata["weetusk"] then
							v.components.allachivevent.weetusk = true
							v.components.allachivevent:seffc(v, "weetusk")
						end
					end
                end
            end
        end
        --Mossling
		if victim and victim.prefab == "mossling" then
			local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if not v.components.allachivevent.mossling then
						v.components.allachivevent.mosslingamount = v.components.allachivevent.mosslingamount + 1
						if v.components.allachivevent.mosslingamount >= allachiv_eventdata["mossling"] then
							v.components.allachivevent.mossling = true
							v.components.allachivevent:seffc(v, "mossling")
						end
					end
                end
            end
        end
        --Goat
		if victim and victim.prefab == "lightninggoat" and victim:HasTag("charged") == true then
			local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if not v.components.allachivevent.goatperd then
						v.components.allachivevent.goatperdamount = v.components.allachivevent.goatperdamount + 1
						if v.components.allachivevent.goatperdamount >= allachiv_eventdata["goatperd"] then
							v.components.allachivevent.goatperd = true
							v.components.allachivevent:seffc(v, "goatperd")
						end
					end
                end
            end
        end
        --Beefalo
		if victim and victim.prefab == "beefalo" and victim:HasTag("scarytoprey") == true then
			local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if not v.components.allachivevent.butcher then
						v.components.allachivevent.butcheramount = v.components.allachivevent.butcheramount + 1
						if v.components.allachivevent.butcheramount >= allachiv_eventdata["butcher"] then
							v.components.allachivevent.butcher = true
							v.components.allachivevent:seffc(v, "butcher")
						end
					end
                end
            end
        end
		--horror hound
		if victim and victim.prefab == "mutatedhound" then
			local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if not v.components.allachivevent.horrorhound then
						v.components.allachivevent.horrorhoundamount = v.components.allachivevent.horrorhoundamount + 1
						if v.components.allachivevent.horrorhoundamount >= allachiv_eventdata["horrorhound"] then
							v.components.allachivevent.horrorhound = true
							v.components.allachivevent:seffc(v, "horrorhound")
						end
					end
                end
            end
        end
		--slurtle
		if victim and victim.prefab == "slurtle" then
			local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if not v.components.allachivevent.slurtle then
						v.components.allachivevent.slurtleamount = v.components.allachivevent.slurtleamount + 1
						if v.components.allachivevent.slurtleamount >= allachiv_eventdata["slurtle"] then
							v.components.allachivevent.slurtle = true
							v.components.allachivevent:seffc(v, "slurtle")
						end
					end
                end
            end
        end
		--werepig
		if victim and (victim.prefab == "moonpig" or (victim.prefab == "pigman" and victim.components.werebeast:IsInWereState())) then
			local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if not v.components.allachivevent.werepig then
						v.components.allachivevent.werepigamount = v.components.allachivevent.werepigamount + 1
						if v.components.allachivevent.werepigamount >= allachiv_eventdata["werepig"] then
							v.components.allachivevent.werepig = true
							v.components.allachivevent:seffc(v, "werepig")
						end
					end
                end
            end
        end
		--fruitdragon
		if victim and victim.prefab == "fruitdragon" and victim._is_ripe then
			local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if not v.components.allachivevent.fruitdragon then
						v.components.allachivevent.fruitdragonamount = v.components.allachivevent.fruitdragonamount + 1
						if v.components.allachivevent.fruitdragonamount >= allachiv_eventdata["fruitdragon"] then
							v.components.allachivevent.fruitdragon = true
							v.components.allachivevent:seffc(v, "fruitdragon")
						end
					end
                end
            end
        end
		--treeguards
		if victim and victim.prefab == "leif" or victim.prefab == "leif_sparse" then
			local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if not v.components.allachivevent.treeguard then
						v.components.allachivevent.treeguardamount = v.components.allachivevent.treeguardamount + 1
						if v.components.allachivevent.treeguardamount >= allachiv_eventdata["treeguard"] then
							v.components.allachivevent.treeguard = true
							v.components.allachivevent:seffc(v, "treeguard")
						end
					end
                end
            end
        end
		--spiderqueen
		if victim and victim.prefab == "spiderqueen" then
			local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if not v.components.allachivevent.spiderqueen then
						v.components.allachivevent.spiderqueenamount = v.components.allachivevent.spiderqueenamount + 1
						if v.components.allachivevent.spiderqueenamount >= allachiv_eventdata["spiderqueen"] then
							v.components.allachivevent.spiderqueen = true
							v.components.allachivevent:seffc(v, "spiderqueen")
						end
					end
                end
            end
        end
		--varg
		if victim and victim.prefab == "warg" then
			local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if not v.components.allachivevent.varg then
						v.components.allachivevent.vargamount = v.components.allachivevent.vargamount + 1
						if v.components.allachivevent.vargamount >= allachiv_eventdata["varg"] then
							v.components.allachivevent.varg = true
							v.components.allachivevent:seffc(v, "varg")
						end
					end
                end
            end
        end
		--koaelefant
		if victim and victim.prefab == "koalefant_summer" or victim.prefab == "koalefant_winter" then
			local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if not v.components.allachivevent.koaelefant then
						v.components.allachivevent.koaelefantamount = v.components.allachivevent.koaelefantamount + 1
						if v.components.allachivevent.koaelefantamount >= allachiv_eventdata["koaelefant"] then
							v.components.allachivevent.koaelefant = true
							v.components.allachivevent:seffc(v, "koaelefant")
						end
					end
                end
            end
        end
		--monkey
		if victim and victim.prefab == "monkey" then
			local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if not v.components.allachivevent.monkey then
						v.components.allachivevent.monkeyamount = v.components.allachivevent.monkeyamount + 1
						if v.components.allachivevent.monkeyamount >= allachiv_eventdata["monkey"] then
							v.components.allachivevent.monkey = true
							v.components.allachivevent:seffc(v, "monkey")
						end
					end
                end
            end
        end
        --Krampus
        if victim and victim.prefab == "krampus" then
            local pos = Vector3(victim.Transform:GetWorldPosition())
            inst:DoTaskInTime(.1, function()
                local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 3)
                for k,v in pairs(ents) do
                    if v.prefab == "krampus_sack"
                    and v.components.inventoryitem.owner == nil
                    and v.components.ksmark.mark == false then
                        v.components.ksmark.mark = true
                        if self.luck ~= true then
                            self.luck = true
                            self:seffc(inst, "luck")
                        end
                    end
                end
            end)
        end
        --Klaus
        if victim and victim.prefab == "klaus" then
            local pos = Vector3(victim.Transform:GetWorldPosition())
            inst:DoTaskInTime(1, function()
                local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 5)
                for k,v in pairs(ents) do
                    if v.prefab == "klaussackkey"
                    and v.components.inventoryitem.owner == nil
                    and v.components.ksmark.mark == false then
                        v.components.ksmark.mark = true
                        ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
                        for k,v in pairs(ents) do
                            if v:HasTag("player") then
                                if v.components.allachivevent.santa ~= true then
                                    v.components.allachivevent.santa = true
                                    v.components.allachivevent:seffc(v, "santa")
                                end
                            end
                        end
                    end
                end
            end)
        end
        --Shadow Chess
        if victim and (victim.prefab == "shadow_knight" or victim.prefab == "shadow_rook" or victim.prefab == "shadow_bishop") and victim.level == 3 then
            local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            inst:DoTaskInTime(2, function()
                for k,v in pairs(ents) do
                    if v:HasTag("player") then
                        if v.components.allachivevent.knight ~= true and victim.prefab == "shadow_knight" then
                            v.components.allachivevent.knight = true
                            v.components.allachivevent:seffc(v, "knight")
                        end
                        if v.components.allachivevent.bishop ~= true and victim.prefab == "shadow_bishop" then
                            v.components.allachivevent.bishop = true
                            v.components.allachivevent:seffc(v, "bishop")
                        end
                        if v.components.allachivevent.rook ~= true and victim.prefab == "shadow_rook" then
                            v.components.allachivevent.rook = true
                            v.components.allachivevent:seffc(v, "rook")
                        end
                    end
                end
                --local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 5)
                --for k,v in pairs(ents) do
                    --if v.prefab == "shadowheart"
                    --and v.components.inventoryitem.owner == nil
                    --and v.components.ksmark.mark == false then
                        --v.components.ksmark.mark = true
                        --ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
                        --for k,v in pairs(ents) do
                            --if v:HasTag("player") then
                                --if v.components.allachivevent.knight ~= true and victim.prefab == "shadow_knight" then
                                    --v.components.allachivevent.knight = true
                                    --v.components.allachivevent:seffc(v, "knight")
                                --end
                                --if v.components.allachivevent.bishop ~= true and victim.prefab == "shadow_bishop" then
                                    --v.components.allachivevent.bishop = true
                                    --v.components.allachivevent:seffc(v, "bishop")
                                --end
                                --if v.components.allachivevent.rook ~= true and victim.prefab == "shadow_rook" then
                                    --v.components.allachivevent.rook = true
                                    --v.components.allachivevent:seffc(v, "rook")
                                --end
                            --end
                        --end
                    --end
                --end
            end)
        end
        --Ewecus
        if victim and victim.prefab == "spat" and self.black ~= true then
            local single = true
            local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 15)
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    single = false
                end
            end
            if single == true then
                self.black = true
                self.blacktile = "spat"
                self:seffc(inst, "black")
            end
        end
        --Misery Toad
        if victim and victim.prefab == "toadstool_dark" then
            local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if v.components.allachivevent.rigid ~= true then
						v.components.allachivevent.rigid = true
						v.components.allachivevent:seffc(v, "rigid")
					end
                end
            end
        end
        --AF
        if victim and victim.prefab == "stalker_atrium" then
            local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if v.components.allachivevent.ancient ~= true then
						v.components.allachivevent.ancient = true
						v.components.allachivevent:seffc(v, "ancient")
					end
                end
            end
        end
        --Minotaur
        if victim and victim.prefab == "minotaur" then
            local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if v.components.allachivevent.minotaur ~= true then
						v.components.allachivevent.minotaur = true
						v.components.allachivevent:seffc(v, "minotaur")
					end
                end
            end
        end
        --Dragonfly
        if victim and victim.prefab == "dragonfly" then
            local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if v.components.allachivevent.dragonfly ~= true then
						v.components.allachivevent.dragonfly = true
						v.components.allachivevent:seffc(v, "dragonfly")
					end
                end
            end
        end
		--Malbatross
        if victim and victim.prefab == "malbatross" then
            local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if v.components.allachivevent.malbatross ~= true then
						v.components.allachivevent.malbatross = true
						v.components.allachivevent:seffc(v, "malbatross")
					end
                end
            end
        end
        --Bee Queen
        if victim and victim.prefab == "beequeen" then
            local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            for k,v in pairs(ents) do
                if v:HasTag("player") then
					if v.components.allachivevent.queen ~= true then
						v.components.allachivevent.queen = true
						v.components.allachivevent:seffc(v, "queen")
					end
                end
            end
        end
        --Season Bosses
        if victim and victim.prefab == "deerclops" then
			local pos = Vector3(victim.Transform:GetWorldPosition())
			local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
			for k,v in pairs(ents) do
				if v:HasTag("player") then
					if v.components.allachivevent.bosswinter ~= true then
						v.components.allachivevent.bosswinter = true
					end
					if v.components.allachivevent.bossautumn and v.components.allachivevent.bossantlion and v.components.allachivevent.bossspring and v.components.allachivevent.bosswinter and v.components.allachivevent.king ~= true then
						v.components.allachivevent.king = true
						v.components.allachivevent:seffc(v, "king")
					end
				end
			end
        end
        if victim and victim.prefab == "moose" then
			local pos = Vector3(victim.Transform:GetWorldPosition())
			local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
			for k,v in pairs(ents) do
				if v:HasTag("player") then
					if v.components.allachivevent.bossspring ~= true then
						v.components.allachivevent.bossspring = true
					end
					if v.components.allachivevent.bossautumn and v.components.allachivevent.bossantlion and v.components.allachivevent.bossspring and v.components.allachivevent.bosswinter and v.components.allachivevent.king ~= true then
						v.components.allachivevent.king = true
						v.components.allachivevent:seffc(v, "king")
					end
				end
			end
        end
        if victim and victim.prefab == "antlion" then
			local pos = Vector3(victim.Transform:GetWorldPosition())
			local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
			for k,v in pairs(ents) do
				if v:HasTag("player") then
					if v.components.allachivevent.bossantlion ~= true then
						v.components.allachivevent.bossantlion = true
					end
					if v.components.allachivevent.bossautumn and v.components.allachivevent.bossantlion and v.components.allachivevent.bossspring and v.components.allachivevent.bosswinter and v.components.allachivevent.king ~= true then
						v.components.allachivevent.king = true
						v.components.allachivevent:seffc(v, "king")
					end
					
				end
			end
        end
        if victim and victim.prefab == "bearger" then
			local pos = Vector3(victim.Transform:GetWorldPosition())
			local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
			for k,v in pairs(ents) do
				if v:HasTag("player") then
					if v.components.allachivevent.bossautumn ~= true then
						v.components.allachivevent.bossautumn = true
					end
					if v.components.allachivevent.bossautumn and v.components.allachivevent.bossantlion and v.components.allachivevent.bossspring and v.components.allachivevent.bosswinter and v.components.allachivevent.king ~= true then
						v.components.allachivevent.king = true
						v.components.allachivevent:seffc(v, "king")
					end
				end
			end
        end
    end)
end

--Lightning Listener
function allachivevent:lightningListener(inst)
    inst:ListenForEvent("healthdelta", function(inst, data)
        if self.lightning ~= true and data.cause == "lightning" then
			self.lightning = true
			self:seffc(inst, "lightning")
		end
    end)
end


--Drown Listener
function allachivevent:drownListener(inst)
    inst:ListenForEvent("on_washed_ashore", function(inst, data)
        if self.drown ~= true then
			self.drown = true
			self:seffc(inst, "drown")
		end
    end)
end

--Wake up listener
function allachivevent:wakeupListener(inst)
    inst:ListenForEvent("wakeup", function(inst, data)
        if self.sleeptent ~= true and data == "tent" then
			self.sleeptentamount = self.sleeptentamount + 1
			if self.sleeptentamount >= allachiv_eventdata["sleeptent"] then
				self.sleeptent = true
				self:seffc(inst, "sleeptent")
			end
		end
		
		if self.sleepsiesta ~= true and data == "siestahut" then
			self.sleepsiestaamount = self.sleepsiestaamount + 1
			if self.sleepsiestaamount >= allachiv_eventdata["sleepsiesta"] then
				self.sleepsiesta = true
				self:seffc(inst, "sleepsiesta")
			end
		end
    end)
end

--Burn Freeze Sleep
function allachivevent:burnorfreezeorsleep(inst)
    inst:ListenForEvent("onignite", function(inst)
        if self.burn ~= true then
            self.burn = true
            self:seffc(inst, "burn")
        end
    end)
    inst:ListenForEvent("freeze", function(inst)
        if self.freeze ~= true then
            self.freeze = true
            self:seffc(inst, "freeze")
        end
    end)
	inst:ListenForEvent("knockedout", function(inst)
		if self.sleep ~= true then
			self.sleep = true
			self:seffc(inst, "sleep")
		end
	end)
end

--BeFriend
function allachivevent:makefriend(inst)
    function inst.components.leader:AddFollower(follower)
        if self.followers[follower] == nil and follower.components.follower ~= nil then
            local achiv = inst.components.allachivevent
            --Pigman
            if follower.prefab == "pigman" and achiv.goodman ~= true then
                achiv.friendpig = achiv.friendpig + 1
                if achiv.friendpig >= allachiv_eventdata["goodman"] then
                    achiv.goodman = true
                    achiv:seffc(inst, "goodman")
                end
            end
            --Bunnyman
            if follower.prefab == "bunnyman" and achiv.brother ~= true then
                achiv.friendbunny = achiv.friendbunny + 1
                if achiv.friendbunny >= allachiv_eventdata["brother"] then
                    achiv.brother = true
                    achiv:seffc(inst, "brother")
                end
            end
            --Catcoon
            if follower.prefab == "catcoon" and achiv.catperson ~= true then
                achiv.friendcat = achiv.friendcat + 1
                if achiv.friendcat >= allachiv_eventdata["catperson"] then
                    achiv.catperson = true
                    achiv:seffc(inst, "catperson")
                end
            end
            --Spooders
            if (follower.prefab == "spider" or 
				follower.prefab == "spider_dropper" or 
				follower.prefab == "spider_warrior" or 
				follower.prefab == "spider_hider" or 
				follower.prefab == "spider_spitter") and achiv.spooder ~= true then
                achiv.friendspider = achiv.friendspider + 1
                if achiv.friendspider >= allachiv_eventdata["spooder"] then
                    achiv.spooder = true
                    achiv:seffc(inst, "spooder")
                end
            end
            --Mandrake
            if follower.prefab == "mandrake_active" and achiv.evil ~= true and not TheWorld.components.worldstate.data.isday then
                achiv.evilamount = achiv.evilamount + 1
                if achiv.evilamount >= allachiv_eventdata["evil"] then
                    achiv.evil = true
                    achiv:seffc(inst, "evil")
                end
            end
            --TallBirb
            if follower.prefab == "smallbird" and achiv.birdclop ~= true then
                achiv.birdclop = true
                achiv:seffc(inst, "birdclop")
            end
            --RockLobster
            if follower.prefab == "rocky" and achiv.rocklob ~= true then
                achiv.friendrocky = achiv.friendrocky + 1
                if achiv.friendrocky >= allachiv_eventdata["rocklob"] then
                    achiv.rocklob = true
                    achiv:seffc(inst, "rocklob")
                end
            end

            self.followers[follower] = true
            self.numfollowers = self.numfollowers + 1
            follower.components.follower:SetLeader(self.inst)
            follower:PushEvent("startfollowing", { leader = self.inst })

            if not follower.components.follower.keepdeadleader then
                self.inst:ListenForEvent("death", self._onfollowerdied, follower)
            end

            self.inst:ListenForEvent("onremove", self._onfollowerremoved, follower)

            if self.inst:HasTag("player") and follower.prefab ~= nil then
                ProfileStatsAdd("befriend_"..follower.prefab)
            end
        end
    end
end

--Fish
function allachivevent:onhook(inst)
    inst:ListenForEvent("fishingstrain", function()
        if self.fishmaster ~= true then
            self.fishamount = self.fishamount + 1
            if self.fishamount >= allachiv_eventdata["fishmaster"] then
                self.fishmaster = true
                self:seffc(inst, "fishmaster")
            end
        end
    end)
end

--Pick
function allachivevent:onpick(inst)
    inst:ListenForEvent("picksomething", function(inst, data)
        if data.object and data.object.components.pickable and not data.object.components.trader then
			if data.object.prefab == "flower_evil" and self.evilflower ~= true then
				self.evilfloweramount = self.evilfloweramount + 1
				if self.evilfloweramount >= allachiv_eventdata["evilflower"] then
					self.evilflower = true
					self:seffc(inst, "evilflower")
				end
			end
            if self.pickmaster ~= true or self.pickappren ~= true then
                self.pickamount = self.pickamount + 1
				if self.pickamount >= allachiv_eventdata["pickappren"] and self.pickappren ~= true then
					self.pickappren = true
					self:seffc(inst, "pickappren")
				end
                if self.pickamount >= allachiv_eventdata["pickmaster"] and self.pickmaster ~= true then
                    self.pickmaster = true
                    self:seffc(inst, "pickmaster")
                end
            end
        end
    end)
end

--Chop
function allachivevent:chopper(inst)
    inst:ListenForEvent("finishedwork", function(inst, data)
		if self.birchnut ~= true and data.target and data.target.prefab == "deciduoustree" and data.target.monster then
			self.birchnutamount = self.birchnutamount + 1
				if self.birchnutamount >= allachiv_eventdata["birchnut"] then
					self.birchnut = true
					self:seffc(inst, "birchnut")
				end
		end
        if data.target and data.target:HasTag("tree") then
            if self.chopmaster ~= true or self.chopappren ~= true then
                self.chopamount = self.chopamount + 1
				if self.chopamount >= allachiv_eventdata["chopappren"] and self.chopappren ~= true then
					self.chopappren = true
					self:seffc(inst, "chopappren")
				end
                if self.chopamount >= allachiv_eventdata["chopmaster"] and self.chopmaster ~= true then
                    self.chopmaster = true
                    self:seffc(inst, "chopmaster")
                end
            end
        end
    end)
end



--Mine
function allachivevent:miner(inst)
    inst:ListenForEvent("finishedwork", function(inst, data)
        if data.target and (data.target:HasTag("boulder") or 
							data.target:HasTag("statue") or 
							findprefab(rocklist, data.target.prefab)) then
            if self.minemaster ~= true or self.mineappren ~= true then
                self.mineamount = self.mineamount + 1
				if self.mineamount >= allachiv_eventdata["mineappren"] and self.mineappren ~= true then
					self.mineappren = true
					self:seffc(inst, "mineappren")
				end
                if self.mineamount >= allachiv_eventdata["minemaster"] and self.minemaster ~= true then
                    self.minemaster = true
                    self:seffc(inst, "minemaster")
                end
            end
        end
    end)
end

--Revive
function allachivevent:respawn(inst)
    inst:ListenForEvent("respawnfromghost", function(inst, data)
		--singleplayer addition to messiah
		if data and data.source and data.source.prefab == "resurrectionstone" and self.messiah ~= true then
			self.respawnamount = self.respawnamount + 1
			if self.respawnamount >= allachiv_eventdata["messiah"] then
				inst:DoTaskInTime(5, function()
					self.messiah = true
					self:seffc(inst, "messiah")
				end)
			end
        end
        if data and data.user and data.user.components.allachivevent then
            local allachivevent = data.user.components.allachivevent
            if allachivevent.messiah ~= true then
                allachivevent.respawnamount = allachivevent.respawnamount + 1
                if allachivevent.respawnamount >= allachiv_eventdata["messiah"] then
                    allachivevent.messiah = true
                    allachivevent:seffc(data.user, "messiah")
                end
            end
        end
        if data and data.source and data.source.prefab == "resurrectionstatue" and self.secondchance ~= true then
            inst:DoTaskInTime(2, function()
                self.secondchance = true
                self:seffc(inst, "secondchance")
            end)
        end
		if data and data.source and data.source.prefab == "amulet" and self.reviveamulet ~= true then
			self.reviveamuletamount = self.reviveamuletamount + 1
			if self.reviveamuletamount >= allachiv_eventdata["reviveamulet"] then
				inst:DoTaskInTime(2, function()
					self.reviveamulet = true
					self:seffc(inst, "reviveamulet")
				end)
			end
        end
    end)
end
--Age and SuperStar
function allachivevent:ontimepass(inst)
    inst:DoPeriodicTask(5, function(inst)
        --Age
        if self.longage ~= true or self.oldage ~= true then
            if self.all ~= true then
                self.age = math.ceil(inst.components.age:GetAge() / TUNING.TOTAL_DAY_TIME)
            else
                self.age = math.ceil(inst.components.age:GetAge() / TUNING.TOTAL_DAY_TIME) - self.agereset + 1
            end
            if self.age >= allachiv_eventdata["longage"] and self.longage ~= true then
                self.longage = true
                self:seffc(inst, "longage")
            end
            if self.age >= allachiv_eventdata["oldage"] and self.oldage ~= true then
                self.oldage = true
                self:seffc(inst,"oldage")
            end
        end
        --Critters
        if self.pet ~= true then
            if inst.components.leader:IsBeingFollowedBy("critter_lamb") or
               inst.components.leader:IsBeingFollowedBy("critter_puppy") or
               inst.components.leader:IsBeingFollowedBy("critter_kitten") or
               inst.components.leader:IsBeingFollowedBy("critter_perdling") or
               inst.components.leader:IsBeingFollowedBy("critter_dragonling") or
               inst.components.leader:IsBeingFollowedBy("critter_glomling") or
               inst.components.leader:IsBeingFollowedBy("critter_lunarmothling") then
                self.pet = true
                self:seffc(inst, "pet")
            end
        end
		--Lavae
		if self.lavae ~= true then 
			local tooth = inst.components.inventory:FindItem(function(item) return item.prefab=="lavae_tooth" end)
			if tooth and tooth.components.leader:IsBeingFollowedBy("lavae_pet") then
				self.lavae = true
				self:seffc(inst, "lavae")
			end
		end
		--Music Hutch
		if self.musichutch ~= true then
			local bowl = inst.components.inventory:FindItem(function(item) return item.prefab=="hutch_fishbowl" end)
			local hutch = nil
			if bowl then 
				hutch = TheSim:FindFirstEntityWithTag("hutch")
			end
			if bowl and hutch and hutch.components.amorphous:GetCurrentForm() == "MUSIC" then
				self.musichutch = true
				self:seffc(inst, "musichutch")
			end
		end
		--Shadow Chester
		if self.shadowchester ~= true then
			local eyebone = inst.components.inventory:FindItem(function(item) return item.prefab=="chester_eyebone" end)
			local chester = nil
			if eyebone then 
				chester = TheSim:FindFirstEntityWithTag("chester")
			end
			if eyebone and chester and chester.ChesterState == "SHADOW" then
				self.shadowchester = true
				self:seffc(inst, "shadowchester")
			end
		end
		--Snow Chester
		if self.snowchester ~= true then
			local eyebone = inst.components.inventory:FindItem(function(item) return item.prefab=="chester_eyebone" end)
			local chester = nil
			if eyebone then 
				chester = TheSim:FindFirstEntityWithTag("chester")
			end
			if eyebone and chester and chester.ChesterState == "SNOW" then
				self.snowchester = true
				self:seffc(inst, "snowchester")
			end
		end		
        --Super Star
        if self.superstar ~= true then
            self.starspent = inst.components.allachivcoin.starsspent
            --Star
            self.starspent = self.starspent - self.starreset
            if self.starspent >= allachiv_eventdata["superstar"] then
                self.starspent = allachiv_eventdata["superstar"]
                self.superstar = true
                self:seffc(inst,"superstar")
            end
        end
        --Give Achievements
        if inst.components.allachivcoin.fireflylightup > 0 and self.noob ~= true then
            self.noob = true
            self:seffc(inst,"noob")
        end
        if inst.components.allachivcoin.firebody == true and self.firebody ~= true then
            self.firebody = true
            self:seffc(inst,"firebody")
        end
        if inst.components.allachivcoin.firebody == true and self.eatcold ~= true then
            self.eatcold = true
            self:seffc(inst,"eatcold")
        end
        if inst.components.allachivcoin.icebody == true and self.icebody ~= true then
            self.icebody = true
            self:seffc(inst,"icebody")
        end
        if inst.components.allachivcoin.icebody == true and self.eathot ~= true then
            self.eathot = true
            self:seffc(inst,"eathot")
        end
        if inst.components.allachivcoin.nomoist == true and self.moistbody ~= true then
            self.moistbody = true
            self:seffc(inst,"moistbody")
        end
        if inst.components.allachivcoin.sanityregenamount >= 25 and self.nosanity ~= true then
            self.nosanity = true
            self:seffc(inst,"nosanity")
        end
        if inst.components.allachivcoin.healthregenamount >= 25 and self.hutch ~= true then
            self.hutch = true
            self:seffc(inst,"hutch")
        end
        if inst.components.allachivcoin.healthregenamount >= 25 and self.rose ~= true then
            self.rose = true
            self:seffc(inst,"rose")
        end
        if self.knowledgeamount == 6 and self.knowledge ~= true then
            self.knowledge = true
            self:seffc(inst,"knowledge")
        end
    end)
end

--Craft
function allachivevent:onbuild(inst)
    inst:ListenForEvent("consumeingredients", function(inst)
        if self.buildmaster ~= true or self.buildappren ~= true then
            self.buildamount = self.buildamount + 1
			if self.buildamount >= allachiv_eventdata["buildappren"] and self.buildappren ~= true then
				self.buildappren = true
				self:seffc(inst, "buildappren")
			end
            if self.buildamount >= allachiv_eventdata["buildmaster"] and self.buildmaster ~= true then
                self.buildmaster = true
                self:seffc(inst, "buildmaster")
            end
        end
    end)
end

--Plant
function allachivevent:onplant(inst)
    inst:ListenForEvent("deployitem", function(inst,data)
        if (data.prefab == "pinecone" or data.prefab == "twiggy_nut" or data.prefab == "seeds" or data.prefab == "acorn") and self.nature ~= true then
            self.natureamount = self.natureamount + 1
            if self.natureamount >= allachiv_eventdata["nature"] then
                self.nature = true
                self:seffc(inst, "nature")
            end
        end
    end)
end

--Tank
function allachivevent:onattacked(inst)
    inst:ListenForEvent("attacked", function(inst, data)
		if self.dmgnodmg ~= true then
			self.dmgnodmgamount = 0
		end
		if self.roses ~= true and data.attacker and data.attacker.prefab == "flower" then
			self.rosesamount = self.rosesamount + 1
			if self.rosesamount >= allachiv_eventdata["roses"] then
				self.roses = true
				self:seffc(inst, "roses")
			end
		end
        if self.tank ~= true then
            if data.damage and data.damage >= 0 then
                self.attackeddamage = math.ceil(self.attackeddamage + data.damage)
	            if self.attackeddamage >= allachiv_eventdata["tank"] then
                    self.attackeddamage = allachiv_eventdata["tank"]
	                self.tank = true
	                self:seffc(inst, "tank")
	            end
	        end
        end
    end)
end

--Damage
function allachivevent:hitother(inst)
    inst:ListenForEvent("onhitother", function(inst, data)
		if self.pacifist ~= true and data.damage and data.damage >= 0 then
			self.pacifistamount = 0
		end
		if self.dmgnodmg ~= true and data.damage and data.damage >= 0 then
			self.dmgnodmgamount = math.ceil(self.dmgnodmgamount + data.damage)
			if self.dmgnodmgamount >= allachiv_eventdata["dmgnodmg"] then
                self.dmgnodmgamount = allachiv_eventdata["dmgnodmg"]
                self.dmgnodmg = true
                self:seffc(inst, "dmgnodmg")
            end
		end
		if self.bullkelp ~= true and data.weapon and data.weapon.prefab == "bullkelp_root" then
			if data.damage and data.damage >= 0 then
                self.bullkelpamount = math.ceil(self.bullkelpamount + data.damage)
            end
			if self.bullkelpamount >= allachiv_eventdata["bullkelp"] then
                self.bullkelpamount = allachiv_eventdata["bullkelp"]
                self.bullkelp = true
                self:seffc(inst, "bullkelp")
            end
		end
        if self.angry ~= true then
            if data.damage and data.damage >= 0 then
                self.onhitdamage = math.ceil(self.onhitdamage + data.damage)
            end
            if self.onhitdamage >= allachiv_eventdata["angry"] then
                self.onhitdamage = allachiv_eventdata["angry"]
                self.angry = true
                self:seffc(inst, "angry")
            end
        end
    end)
end

--Freeze/Overheat
function allachivevent:ontemperature(inst)
    inst:DoPeriodicTask(1, function()
        if inst.components.temperature.current <= 0
        and self.icebody ~= true
        and inst.components.health.currenthealth > 0 then
            self.icetime = self.icetime + 1
            if self.icetime >= allachiv_eventdata["icebody"] then
                self.icebody = true
                self:seffc(inst, "icebody")
            end
        end
    end)
    inst:DoPeriodicTask(1, function()
        if inst.components.temperature.current >= 70
        and self.firebody ~= true
        and inst.components.health.currenthealth > 0 then
            self.firetime = self.firetime + 1
            if self.firetime >= allachiv_eventdata["firebody"] then
                self.firebody = true
                self:seffc(inst, "firebody")
            end
        end
    end)
end

--Live in Cave
function allachivevent:incave(inst)
    inst:DoPeriodicTask(1, function()
        if TheWorld:HasTag("cave") and inst:HasTag("playerghost") ~= true
        and self.caveage ~= true then
            self.cavetime = self.cavetime + 1
            if self.cavetime >= allachiv_eventdata["caveage"] then
                self.caveage = true
                self:seffc(inst, "caveage")
            end
        end
    end)
end

--Starving
function allachivevent:onhunger(inst)
    inst:DoPeriodicTask(1, function()
        if inst.components.hunger.current <= 0
        and self.starve ~= true
        and inst.components.health.currenthealth > 0 then
            self.starvetime = self.starvetime + 1
            if self.starvetime >= allachiv_eventdata["starve"] then
                self.starve = true
                self:seffc(inst, "starve")
            end
        end
    end)
end

--Full Wet
function allachivevent:moist(inst)
	inst:DoPeriodicTask(1, function()
		if self.moistbody ~= true and inst.components.moisture.moisture == 100 then
			self.moisttime = self.moisttime + 1
			if self.moisttime >= allachiv_eventdata["moistbody"] then
				self.moistbody = true
				self:seffc(inst, "moistbody")
			end
		end
	end)
end

--Learn Blueprint
function allachivevent:onlearn(inst)
    inst:ListenForEvent("learnrecipe", function(inst,data)
        local blueprint_str = data.recipe
        if blueprint_str:sub(-9):lower() == "blueprint" then
            blueprint_str = blueprint_str:sub(1,-11)
        end
        if blueprint_str == "ruinsrelic_table" or 
           blueprint_str == "ruinsrelic_chair" or 
           blueprint_str == "ruinsrelic_vase" or
           blueprint_str == "ruinsrelic_plate" or
           blueprint_str == "ruinsrelic_bowl" or
           blueprint_str == "ruinsrelic_chipbowl" then
            self.knowledgeamount = self.knowledgeamount + 1
            if self.knowledge ~= true then
                self.knowledge = true
                self:seffc(inst, "knowledge")
            end
        end
    end)
end

--Do Emotes
function allachivevent:doemote(inst)
    inst:ListenForEvent("emote", function()
        if self.dance ~= true then
            local single = true
            local pos = Vector3(inst.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 15)
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    single = false
                end
				--singleplayer addition
				if v.prefab == "resurrectionstatue" then
                    single = false
                end
            end
            if single == false then
                self.danceamount = self.danceamount + 1
                if self.danceamount >= allachiv_eventdata["dance"] then
                    self.dance = true
                    self:seffc(inst, "dance")
                end
            end
        end
    end)
end

--Teleport
function allachivevent:onteleport(inst)
    inst:ListenForEvent("wormholetravel", function(inst)
        if self.teleport ~= true then
            self.teleportamount = self.teleportamount + 1
            if self.teleportamount >= allachiv_eventdata["teleport"] then
                self.teleport = true
                self:seffc(inst, "teleport")
            end
        end
    end)
    inst:ListenForEvent("soulhop", function(inst)
        if self.teleport ~= true then
            self.teleportamount = self.teleportamount + 1
            if self.teleportamount >= allachiv_eventdata["teleport"] then
                self.teleport = true
                self:seffc(inst, "teleport")
            end
        end
    end)
    inst:ListenForEvent("townportalteleport", function(inst)
        if self.teleport ~= true then
            self.teleportamount = self.teleportamount + 1
            if self.teleportamount >= allachiv_eventdata["teleport"] then
                self.teleport = true
                self:seffc(inst, "teleport")
            end
        end
    end)
end

function allachivevent:onreroll(inst)
    inst:ListenForEvent("ms_playerreroll", function(inst)
                local SaveAchieve = {}
                SaveAchieve["intogame"] = self.intogame or false
                SaveAchieve["firsteat"] = self.firsteat or false
                SaveAchieve["supereat"] = self.supereat or false
                SaveAchieve["eatamount"] = self.eatamount or 0
                SaveAchieve["danding"] = self.danding or false
                SaveAchieve["eatmonsterlasagna"] = self.eatmonsterlasagna or 0
                SaveAchieve["messiah"] = self.messiah or false
                SaveAchieve["respawnamount"] = self.respawnamount or 0
                SaveAchieve["walktime"] = self.walktime or 0
                SaveAchieve["stoptime"] = self.stoptime or 0
                SaveAchieve["walkalot"] = self.walkalot or false
				SaveAchieve["emeralds"] = self.emeralds or 0
				SaveAchieve["emerald"] = self.emerald or false
				SaveAchieve["citrin"] = self.citrin or false
				SaveAchieve["amber"] = self.amber or false 
				SaveAchieve["saddle"] = self.saddle or false
				SaveAchieve["banana"] = self.banana or false
				SaveAchieve["spore"] = self.spore or false 
				SaveAchieve["blueprint"] = self.blueprint or false
				SaveAchieve["boat"] = self.boat or false 
				SaveAchieve["moonrock"] = self.moonrock or false
				SaveAchieve["gnome"] = self.gnome or false
				SaveAchieve["mosquito"] = self.mosquito or false
				SaveAchieve["citrins"] = self.citrins or 0 
				SaveAchieve["ambers"] = self.ambers or 0
				SaveAchieve["saddles"] = self.saddles or 0 
				SaveAchieve["bananas"] = self.bananas or 0 
				SaveAchieve["spores"] = self.spores or 0
				SaveAchieve["blueprints"] = self.blueprints or 0
				SaveAchieve["boats"] = self.boats or 0
				SaveAchieve["moonrocks"] = self.moonrocks or 0
				SaveAchieve["gnomes"] = self.gnomes or 0
				SaveAchieve["mosquitos"] = self.mosquitos or 0
                SaveAchieve["stopalot"] = self.stopalot or false
                SaveAchieve["tooyoung"] = self.tooyoung or false
                SaveAchieve["evil"] = self.evil or false
                SaveAchieve["evilamount"] = self.evilamount or 0
                SaveAchieve["snake"] = self.snake or false
                SaveAchieve["deathalot"] = self.deathalot or false
                SaveAchieve["deathamouth"] = self.deathamouth or 0
                SaveAchieve["nosanity"] = self.nosanity or false
                SaveAchieve["nosanitytime"] = self.nosanitytime or 0
                SaveAchieve["sick"] = self.sick or false
                SaveAchieve["coldblood"] = self.coldblood or false
                SaveAchieve["snakeamount"] = self.snakeamount or 0
                SaveAchieve["burn"] = self.burn or false
                SaveAchieve["freeze"] = self.freeze or false
                SaveAchieve["goodman"] = self.goodman or false
                SaveAchieve["brother"] = self.brother or false
                SaveAchieve["friendpig"] = self.friendpig or 0
                SaveAchieve["friendbunny"] = self.friendbunny or 0
                SaveAchieve["fishmaster"] = self.fishmaster or false
                SaveAchieve["fishamount"] = self.fishamount or 0
                SaveAchieve["pickmaster"] = self.pickmaster or false
                SaveAchieve["pickappren"] = self.pickappren or false
                SaveAchieve["pickamount"] = self.pickamount or 0
                SaveAchieve["chopmaster"] = self.chopmaster or false
                SaveAchieve["chopappren"] = self.chopappren or false
                SaveAchieve["chopamount"] = self.chopamount or 0
                SaveAchieve["noob"] = self.noob or false
                SaveAchieve["cookmaster"] = self.cookmaster or false
                SaveAchieve["cookappren"] = self.cookappren or false
                SaveAchieve["cookamount"] = self.cookamount or 0
                SaveAchieve["minemaster"] = self.minemaster or false
                SaveAchieve["mineappren"] = self.mineappren or false
                SaveAchieve["mineamount"] = self.mineamount or 0
                SaveAchieve["longage"] = self.longage or false
                SaveAchieve["luck"] = self.luck or false
                SaveAchieve["black"] = self.black or false
                SaveAchieve["buildmaster"] = self.buildmaster or false
                SaveAchieve["buildappren"] = self.buildappren or false
                SaveAchieve["buildamount"] = self.buildamount or 0
                SaveAchieve["tank"] = self.tank or false
                SaveAchieve["angry"] = self.angry or false
                SaveAchieve["attackeddamage"] = self.attackeddamage or 0
                SaveAchieve["onhitdamage"] = self.onhitdamage or 0
                SaveAchieve["icebody"] = self.icebody or false
                SaveAchieve["firebody"] = self.firebody or false
                SaveAchieve["moistbody"] = self.moistbody or false
                SaveAchieve["icetime"] = self.icetime or 0
                SaveAchieve["firetime"] = self.firetime or 0
                SaveAchieve["moisttime"] = self.moisttime or 0
                SaveAchieve["rigid"] = self.rigid or false
                SaveAchieve["ancient"] = self.ancient or false
                SaveAchieve["queen"] = self.queen or false
                SaveAchieve["bosswinter"] = self.bosswinter or false
                SaveAchieve["bossspring"] = self.bossspring or false
                SaveAchieve["bossantlion"] = self.bossantlion or false
                SaveAchieve["bossautumn"] = self.bossautumn or false
                SaveAchieve["king"] = self.king or false
                SaveAchieve["all"] = self.all or false
                SaveAchieve["minotaur"] = self.minotaur or false
                SaveAchieve["santa"] = self.santa or false
                SaveAchieve["knight"] = self.knight or false
                SaveAchieve["bishop"] = self.bishop or false
                SaveAchieve["rook"] = self.rook or false
                SaveAchieve["starve"] = self.starve or false
                SaveAchieve["starvetime"] = self.starvetime or 0
                SaveAchieve["catperson"] = self.catperson or false
                SaveAchieve["friendcat"] = self.friendcat or 0
                SaveAchieve["rose"] = self.rose or false
                SaveAchieve["mossling"] = self.mossling or false
                SaveAchieve["weetusk"] = self.weetusk or false
                SaveAchieve["butcher"] = self.butcher or false
                SaveAchieve["goatperd"] = self.goatperd or false
                SaveAchieve["mosslingamount"] = self.mosslingamount or 0
                SaveAchieve["weetuskamount"] = self.weetuskamount or 0
                SaveAchieve["butcheramount"] = self.butcheramount or 0
                SaveAchieve["goatperdamount"] = self.goatperdamount or 0
                SaveAchieve["secondchance"] = self.secondchance or false
                SaveAchieve["nature"] = self.nature or false
                SaveAchieve["natureamount"] = self.natureamount or 0
                SaveAchieve["alldiet"] = self.alldiet or false
                SaveAchieve["eatall"] = self.eatall or 0
                SaveAchieve["eatlist"] = self.eatlist or copylist(foodmenu)
                SaveAchieve["hutch"] = self.hutch or false
                SaveAchieve["hentai"] = self.hentai or false
                SaveAchieve["hentaiamount"] = self.hentaiamount or 0
                SaveAchieve["spooder"] = self.spooder or false
                SaveAchieve["friendspider"] = self.friendspider or 0
                SaveAchieve["dragonfly"] = self.dragonfly or false
				SaveAchieve["malbatross"] = self.malbatross or false
                SaveAchieve["sleep"] = self.sleep or false
                SaveAchieve["trader"] = self.trader or false
                SaveAchieve["tradeamount"] = self.tradeamount or 0
                SaveAchieve["fuzzy"] = self.fuzzy or false
                SaveAchieve["fuzzyamount"] = self.fuzzyamount or 0
                SaveAchieve["pet"] = self.pet or false
                SaveAchieve["caveage"] = self.caveage or false
                SaveAchieve["cavetime"] = self.cavetime or 0
                SaveAchieve["birdclop"] = self.birdclop or false
                SaveAchieve["eattemp"] = self.eattemp or false
                SaveAchieve["eathot"] = self.eathot or false
                SaveAchieve["eatcold"] = self.eatcold or false
                SaveAchieve["eathotamount"] = self.eathotamount or 0
                SaveAchieve["eatcoldamount"] = self.eatcoldamount or 0
                SaveAchieve["rot"] = self.rot or false
                SaveAchieve["knowledge"] = self.knowledge or false
                SaveAchieve["dance"] = self.dance or false
                SaveAchieve["danceamount"] = self.danceamount or 0
                SaveAchieve["agereset"] = self.agereset or 0
                SaveAchieve["oldage"] = self.oldage or false
                SaveAchieve["superstar"] = self.superstar or false
                SaveAchieve["rocklob"] = self.rocklob or false
                SaveAchieve["teleport"] = self.teleport or false
                SaveAchieve["starspent"] = self.starspent or 0
                SaveAchieve["friendrocky"] = self.friendrocky or 0
                SaveAchieve["teleportamount"] = self.teleportamount or 0
                SaveAchieve["starreset"] = self.starreset or 0
                SaveAchieve["knowledgeamount"] = self.knowledgeamount or 0
				SaveAchieve["runcount"] = self.runcount or 0
				SaveAchieve["eatfish"] = self.eatfish or false
				SaveAchieve["eatfishamount"] = self.eatfishamount or 0
				SaveAchieve["eatturkey"] = self.eatturkey or false
				SaveAchieve["eatturkeyamount"] = self.eatturkeyamount or 0
				SaveAchieve["eatpepper"] = self.eatpepper or false
				SaveAchieve["eatpepperamount"] = self.eatpepperamount or 0
				SaveAchieve["eatbacon"] = self.eatbacon or false
				SaveAchieve["eatbaconamount"] = self.eatbaconamount or 0
				SaveAchieve["eatmole"] = self.eatmole or false
				SaveAchieve["eatmoleamount"] = self.eatmoleamount or 0
				SaveAchieve["sleeptent"] = self.sleeptent or false
				SaveAchieve["sleeptentamount"] = self.sleeptentamount or 0
				SaveAchieve["sleepsiesta"] = self.sleepsiesta or false
				SaveAchieve["sleepsiestaamount"] = self.sleepsiestaamount or 0
				SaveAchieve["reviveamulet"] = self.reviveamulet or false
				SaveAchieve["reviveamuletamount"] = self.reviveamuletamount or 0
				SaveAchieve["feedplayer"] = self.feedplayer or false
				SaveAchieve["feedplayeramount"] = self.feedplayeramount or 0
				SaveAchieve["bathbomb"] = self.bathbomb or false
				SaveAchieve["bathbombamount"] = self.bathbombamount or 0
				SaveAchieve["shadowchester"] = self.shadowchester or false
				SaveAchieve["snowchester"] = self.snowchester or false
				SaveAchieve["musichutch"] = self.musichutch or false
				SaveAchieve["lavae"] = self.lavae or false
				SaveAchieve["evilflower"] = self.evilflower or false
				SaveAchieve["evilfloweramount"] = self.evilfloweramount or 0
				SaveAchieve["roses"] = self.roses or false
				SaveAchieve["rosesamount"] = self.rosesamount or 0
				SaveAchieve["drown"] = self.drown or false
				SaveAchieve["dmgnodmg"] = self.dmgnodmg or false
				SaveAchieve["dmgnodmgamount"] = self.dmgnodmgamount or 0
				SaveAchieve["bullkelp"] = self.bullkelp or false
				SaveAchieve["bullkelpamount"] = self.bullkelpamount or 0
				SaveAchieve["horrorhound"] = self.horrorhound or false
				SaveAchieve["horrorhoundamount"] = self.horrorhoundamount or 0
				SaveAchieve["slurtle"] = self.slurtle or false
				SaveAchieve["slurtleamount"] = self.slurtleamount or 0
				SaveAchieve["werepig"] = self.werepig or false
				SaveAchieve["werepigamount"] = self.werepigamount or 0
				SaveAchieve["fruitdragon"] = self.fruitdragon or false
				SaveAchieve["fruitdragonamount"] = self.fruitdragonamount or 0
				SaveAchieve["treeguard"] = self.treeguard or false
				SaveAchieve["treeguardamount"] = self.treeguardamount or 0
				SaveAchieve["spiderqueen"] = self.spiderqueen or false
				SaveAchieve["spiderqueenamount"] = self.spiderqueenamount or 0
				SaveAchieve["varg"] = self.varg or false
				SaveAchieve["vargamount"] = self.vargamount or 0
				SaveAchieve["koaelefant"] = self.koaelefant or false
				SaveAchieve["koaelefantamount"] = self.koaelefantamount or 0
				SaveAchieve["monkey"] = self.monkey or false
				SaveAchieve["monkeyamount"] = self.monkeyamount or 0
				SaveAchieve["lightning"] = self.lightning or false
				SaveAchieve["birchnut"] = self.birchnut or false
				SaveAchieve["birchnutamount"] = self.birchnutamount or 0
				SaveAchieve["rider"] = self.rider or false
				SaveAchieve["rideramount"] = self.rideramount or 0
				SaveAchieve["fullsanity"] = self.fullsanity or false
				SaveAchieve["fullsanityamount"] = self.fullsanityamount or 0
				SaveAchieve["fullhunger"] = self.fullhunger or false
				SaveAchieve["fullhungeramount"] = self.fullhungeramount or 0
				SaveAchieve["pacifist"] = self.pacifist or false
				SaveAchieve["pacifistamount"] = self.pacifistamount or 0
                SaveAchieve["totalstar"] = inst.components.allachivcoin.coinamount + math.ceil(inst.components.allachivcoin.starsspent)
				AchievementData[inst:GetDisplayName()] = SaveAchieve
                --print("SAVED")
    end)
end
--Init
function allachivevent:Init(inst)
	if _G.SYSTEM_CONFIG == "both" or _G.SYSTEM_CONFIG == "achieve" then
		inst:DoTaskInTime(.1, function()
			self:intogamefn(inst)
			self:eatfn(inst)
			self:onhavefn(inst)
			self:onwalkfn(inst)
			self:onkilled(inst)
			self:onkilledother(inst)
			self:wakeupListener(inst)
			self:drownListener(inst)
			self:lightningListener(inst)
			self:burnorfreezeorsleep(inst)
			self:makefriend(inst)
			self:onhook(inst)
			self:onpick(inst)
			self:chopper(inst)
			self:incave(inst)
			self:miner(inst)
			self:respawn(inst)
			self:ontimepass(inst)
			self:onbuild(inst)
			self:onattacked(inst)
			self:hitother(inst)
			self:sanitycheck(inst)
			self:hungercheck(inst)
			self:ontemperature(inst)
			self:onhunger(inst)
			self:moist(inst)
			self:allget(inst)
			self:onplant(inst)
			self:onlearn(inst)
			self:doemote(inst)
			self:onteleport(inst)
			self:onreroll(inst)			   
		end)
	end

    --inst.components.combat.damagemultiplier = inst.components.combat.damagemultiplier or 1
end

--only for debug purposes
-- AllPlayers[1].components.allachivcoin.coinamount = 200
-- AllPlayers[1].components.allachivevent:grantAll(AllPlayers[1])
-- AllPlayers[1]:ApplyScale("grow",2)
function allachivevent:grantAll(inst)
	self.intogame = true
	self.firsteat = true
	self.supereat = true
	self.danding = true
	self.messiah = true
	self.emerald = true
	self.citrin = true
	self.amber = true
	self.saddle = true
	self.banana = true
	self.spore = true
	self.blueprint = true
	self.boat = true
	self.moonrock = true
	self.gnome = true
	self.mosquito = true
	self.walkalot = true
	self.stopalot = true
	self.tooyoung = true
	self.evil = true
	self.snake = true
	self.deathalot = true
	self.nosanity = true
	self.sick = true
	self.coldblood = true
	self.burn = true
	self.freeze = true
	self.goodman = true
	self.brother = true
	self.fishmaster = true
	self.pickmaster = true
	self.pickappren = true
	self.chopmaster = true
	self.chopappren = true
	self.noob = true
	self.cookmaster = true
	self.cookappren = true
	self.longage = true
	self.luck = true
	self.black = true
	self.buildmaster = true
	self.buildappren = true
	self.minemaster = true
	self.mineappren = true
	self.tank = true
	self.angry = true
	self.icebody = true
	self.firebody = true
	self.rigid = true
	self.ancient = true
	self.queen = true
	self.moistbody = true
	self.king = true
	self.santa = true
	self.knight = true
	self.bishop = true
	self.rook = true
	self.starve = true
	self.catperson = true
	self.rose = true
	self.butcher = true
	self.goatperd = true
	self.mossling = true
	self.weetusk = true
	self.secondchance = true
	self.nature = true
	self.alldiet = true
	self.hentai = true
	self.hutch = true
	self.spooder = true
	self.minotaur = true
	self.dragonfly = true
	self.malbatross = true
	self.sleep = true
	self.trader = true
	self.fuzzy = true
	self.pet = true
	self.caveage = true
	self.birdclop = true
	self.eathot = true
	self.eatcold = true
	self.rot = true
	self.knowledge = true
	self.dance = true
	self.oldage = true
	self.superstar = true
	self.rocklob = true
	self.teleport = true
	self.eatfish = true
	self.eatturkey = true
	self.eatpepper = true
	self.eatbacon = true
	self.eatmole = true
	self.sleeptent = true
	self.sleepsiesta = true
	self.reviveamulet = true
	self.feedplayer = true
	self.bathbomb = true
	self.shadowchester = true
	self.snowchester = true
	self.musichutch = true
	self.lavae = true
	self.evilflower = true
	self.roses = true
	self.drown = true
	self.dmgnodmg = true
	self.bullkelp = true
	self.horrorhound = true
	self.slurtle = true
	self.werepig = true
	self.fruitdragon = true
	self.treeguard = true
	self.spiderqueen = true
	self.varg = true
	self.koaelefant = true
	self.monkey = true
	self.lightning = true
	self.birchnut = true
	self.rider = true
	self.fullsanity = true
	self.fullhunger = true
	self.pacifist = true
end

--All Star
function allachivevent:allget(inst)
    if self.all ~= true then
        inst:DoPeriodicTask(1, function()
            if self.all ~= true then
                if  self.intogame
                and self.firsteat
                and self.supereat
                and self.danding
                and self.messiah
				and self.emerald
				and self.citrin 
				and self.amber
				and self.saddle
				and self.banana
				and self.spore
				and self.blueprint
				and self.boat
				and self.moonrock 
				and self.gnome
				and self.mosquito 
                and self.walkalot
                and self.stopalot
                and self.tooyoung
                and self.evil
                and self.snake
                and self.deathalot
                and self.nosanity
                and self.sick
                and self.coldblood
                and self.burn
                and self.freeze
                and self.goodman
                and self.brother
                and self.fishmaster
                and self.pickmaster
				and self.pickappren
                and self.chopmaster
				and self.chopappren
                and self.noob
                and self.cookmaster
				and self.cookappren
                and self.longage
                and self.luck
                and self.black
                and self.buildmaster
				and self.buildappren
				and self.minemaster
				and self.mineappren
                and self.tank
                and self.angry
                and self.icebody
                and self.firebody
                and self.rigid
                and self.ancient
                and self.queen
                and self.moistbody
                and self.king
				and self.santa
				and self.knight
				and self.bishop
				and self.rook
				and self.starve
				and self.catperson
				and self.rose
				and self.butcher
				and self.goatperd
				and self.mossling
				and self.weetusk
				and self.secondchance
				and self.nature
				and self.alldiet
				and self.hentai
				and self.hutch
				and self.spooder
				and self.minotaur
				and self.dragonfly
				and self.malbatross
				and self.sleep
				and self.trader
				and self.fuzzy
                and self.pet
                and self.caveage
                and self.birdclop
                and self.eathot
                and self.eatcold
                and self.rot
                and self.knowledge
                and self.dance
                and self.oldage
                and self.superstar
                and self.rocklob
                and self.teleport
				and self.eatfish
				and self.eatturkey
				and self.eatpepper
				and self.eatbacon
				and self.eatmole
				and self.sleeptent
				and self.sleepsiesta
				and self.reviveamulet
				and self.feedplayer
				and self.bathbomb
				and self.shadowchester
				and self.snowchester
				and self.musichutch
				and self.lavae
				and self.evilflower
				and self.roses
				and self.drown
				and self.dmgnodmg
				and self.bullkelp
				and self.horrorhound
				and self.slurtle
				and self.werepig
				and self.fruitdragon
				and self.treeguard
				and self.spiderqueen
				and self.varg
				and self.koaelefant
				and self.monkey
				and self.lightning
				and self.birchnut
				and self.rider
				and self.fullsanity
				and self.fullhunger
				and self.pacifist
                then
                    self.all = true
                    inst:DoTaskInTime(2.5, function()
                        self:seffc(inst, "all")
                        inst:DoTaskInTime(.3, function()
                            inst.sg:GoToState("mime")
                            if not inst.components.locomotor.wantstomoveforward then inst.sg:AddStateTag("busy") end
                            for i=1, 25 do
                                inst:DoTaskInTime(i/25*3, function()
                                    local pos = Vector3(inst.Transform:GetWorldPosition())
                                    SpawnPrefab("explode_firecrackers").Transform:SetPosition(pos.x+math.random(-3,3), pos.y, pos.z+math.random(-3,3))
                                end)
                            end
                        end)
						print(self.runcount, _G._G.PLAYS_CONFIG)
						if self.runcount < _G.PLAYS_CONFIG then
							self.runcount = self.runcount + 1
							self.all = false						
							self.intogame = true
							self.firsteat = false
							self.supereat = false
							self.eatamount = 0
							self.danding = false
							self.eatmonsterlasagna = 0
							self.messiah = false
							self.respawnamount = 0
							self.walktime = 0
							self.stoptime = 0
							self.emeralds = 0
							self.emerald = false
							self.citrin = false
							self.amber = false
							self.saddle = false
							self.banana = false
							self.spore = false
							self.blueprint = false
							self.boat = false
							self.moonrock = false
							self.gnome = false
							self.mosquito = false
							self.citrins = 0
							self.ambers = 0
							self.saddles = 0
							self.bananas = 0
							self.spores = 0
							self.blueprints = 0
							self.boats = 0
							self.moonrocks = 0
							self.gnomes = 0
							self.mosquitos = 0
							self.walkalot = false
							self.stopalot = false
							self.tooyoung = false
							self.evil = false
							self.evilamount = 0
							self.snake = false
							self.deathalot = false
							self.deathamouth = 0
							self.nosanity = false
							self.nosanitytime = 0
							self.sick = false
							self.coldblood = false
							self.snakeamount = 0
							self.burn = false
							self.freeze = false
							self.goodman = false
							self.brother = false
							self.friendpig = 0
							self.friendbunny = 0
							self.fishmaster = false
							self.fishamount = 0
							self.pickmaster = false
							self.pickappren = false
							self.pickamount = 0
							self.chopmaster = false
							self.chopappren = false
							self.chopamount = 0
							self.noob = false
							self.cookmaster = false
							self.cookappren = false
							self.cookamount = 0
							self.minemaster = false
							self.mineappren = false
							self.mineamount = 0
							self.longage = false
							self.age = 1
							self.luck = false
							self.black = false
							self.buildmaster = false
							self.buildappren = false
							self.buildamount = 0
							self.tank = false
							self.angry = false
							self.attackeddamage = 0
							self.onhitdamage = 0
							self.icebody = false
							self.firebody = false
							self.moistbody = false
							self.starve = false
							self.icetime = 0
							self.firetime = 0
							self.moisttime = 0
							self.starvetime = 0
							self.rigid = false
							self.ancient = false
							self.queen = false
							self.bosswinter = false
							self.bossspring = false
							self.bossantlion = false
							self.bossautumn = false
							self.king = false
							self.santa = false
							self.knight = false
							self.bishop = false
							self.rook = false
							self.catperson = false
							self.friendcat = 0
							self.rose = false
							self.butcher = false
							self.goatperd = false
							self.mossling = false
							self.weetusk = false
							self.butcheramount = 0
							self.goatperdamount = 0
							self.mosslingamount = 0
							self.weetuskamount = 0
							self.secondchance = false
							self.nature = false
							self.natureamount = 0
							self.alldiet = false
							self.eatall = 0
							self.eatlist = copylist(foodmenu)
							self:updateMeatatarianFoodList()
							self.spooder = false
							self.friendspider = 0
							self.hentai = false
							self.hentaiamount = 0
							self.hutch = false
							self.minotaur = false
							self.dragonfly = false
							self.malbatross = false
							self.sleep = false
							self.trader = false
							self.tradeamount = 0
							self.fuzzy = false
							self.fuzzyamount = 0
							self.pet = false
							self.caveage = false
							self.cavetime = 0
							self.birdclop = false
							self.eathot = false
							self.eatcold = false
							self.eathotamount = 0
							self.eatcoldamount = 0
							self.rot = false
							self.knowledge = false
							self.dance = false
							self.danceamount = 0
							self.oldage = false
							self.rocklob = false
							self.friendrocky = 0
							self.superstar = false
							self.starspent = 0
							self.teleport = false
							self.teleportamount = 0
							self.eatfish = false
							self.eatfishamount = 0
							self.eatturkey = false
							self.eatturkeyamount = 0
							self.eatpepper = false
							self.eatpepperamount = 0
							self.eatbacon = false
							self.eatbaconamount = 0
							self.eatmole = false
							self.eatmoleamount = 0
							self.sleeptent = false
							self.sleeptentamount = 0
							self.sleepsiesta = false
							self.sleepsiestaamount = 0
							self.reviveamulet = false
							self.reviveamuletamount = 0
							self.feedplayer = false
							self.feedplayeramount = 0
							self.bathbomb = false
							self.bathbombamount = 0
							self.shadowchester = false
							self.snowchester = false
							self.musichutch = false
							self.lavae = false
							self.evilflower = false
							self.evilfloweramount = 0
							self.roses = false
							self.rosesamount = 0
							self.drown = false
							self.dmgnodmg = false
							self.dmgnodmgamount = 0
							self.bullkelp = false
							self.bullkelpamount = 0
							self.horrorhound = false
							self.horrorhoundamount = 0
							self.slurtle = false
							self.slurtleamount = 0
							self.werepig = false
							self.werepigamount = 0
							self.fruitdragon = false
							self.fruitdragonamount = 0
							self.treeguard = false
							self.treeguardamount = 0
							self.spiderqueen = false
							self.spiderqueenamount = 0
							self.varg = false
							self.vargamount = 0
							self.koaelefant = false
							self.koaelefantamount = 0
							self.monkey = false
							self.monkeyamount = 0
							self.lightning = false
							self.birchnut = false
							self.birchnutamount = 0
							self.rider = false
							self.rideramount = 0
							self.fullsanity = false
							self.fullsanityamount = 0
							self.fullhunger = false
							self.fullhungeramount = 0
							self.pacifist = false
							self.pacifistamount = 0

							self.starreset = inst.components.allachivcoin.starsspent
							self.agereset = math.ceil(inst.components.age:GetAge() / TUNING.TOTAL_DAY_TIME)
							self:intogamefn(inst)
						end
                    end)
                end
            end
        end)
    end
end

return allachivevent