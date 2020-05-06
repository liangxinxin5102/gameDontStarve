--[[
	--- This is Wilson's speech file for Don't Starve Together ---
	Write your character's lines here.
	If you want to use another speech file as a base, or use a more up-to-date version, get them from data\scripts\
	
	If you want to use quotation marks in a quote, put a \ before it.
	Example:
	"Like \"this\"."
]]

return {

	ACTIONFAIL =
	{
        REPAIR =
        {
            WRONGPIECE = "Don't force it through, now.",
        },
        BUILD =
        {
            MOUNTED = "I'll need to get down first~",
            HASPET = "I already have one~",
        },
		SHAVE =
		{
			AWAKEBEEFALO = "Haha... That's a bad idea...~",
			GENERIC = "Can't do that~",
			NOBITS = "Can shave her no more now~",
		},
		STORE =
		{
			GENERIC = "It's full~",
			NOTALLOWED = "It's not the right place~",
			INUSE = "Go ahead, I can wait~",
		},
		RUMMAGE =
		{	
			GENERIC = "Can't do that~",
			INUSE = "Go ahead, I can wait~",
		},
		USEKLAUSSACKKEY =
        {
        	WRONGKEY = "Whoops, guess that's a wrong key~",
        	KLAUS = "I think the guy's coming here...",
        },
        COOK =
        {
            GENERIC = "Can't do that~",
            INUSE = "Go ahead, I can wait~",
            TOOFAR = "Muuuu... Too far...",
        },
        GIVE =
        {
            GENERIC = "I don't think it works like that, nanodesu...",
            DEAD = "Ah... He's already out...",
            SLEEPING = "Once they woke up, I guess~",
            BUSY = "He's a bit busy. Waiting patiently~",
            ABIGAILHEART = "Uhh, I need to find another way...",
            GHOSTHEART = "As much as I want to save you, I can't...",
            NOTGEM = "Don't you think it'll explode?",
            WRONGGEM = "Wrong color?",
            NOTSTAFF = "Guess it's build for a staff~",
            MUSHROOMFARM_NEEDSSHROOM = "I think a mushroom would be better...",
            MUSHROOMFARM_NEEDSLOG = "Need another fresh log, I guess~",
            SLOTFULL = "He got too much stuff in his pocket~",
            DUPLICATE = "We already got that one right here~",
            NOTSCULPTABLE = "I don't think that one is sculptable...?",
			NOTATRIUMKEY = "This isn't the key...?",
            CANTSHADOWREVIVE = "How is this supposed to work...?",
            WRONGSHADOWFORM = "This doesn't seem to work, I guess.",
        },
        GIVETOPLAYER =
        {
        	FULL = "He got too much stuff in his pocket~",
            DEAD = "Ah... He's already out...",
            SLEEPING = "Once they woke up, I guess~",
            BUSY = "He's a bit busy. Waiting patiently~",
    	},
    	GIVEALLTOPLAYER =
        {
        	FULL = "He got too much stuff in his pocket~",
            DEAD = "Ah... He's already out...",
            SLEEPING = "Once they woke up, I guess~",
            BUSY = "He's a bit busy. Waiting patiently~",
    	},
        WRITE =
        {
            GENERIC = "Can't do that now~",
            INUSE = "Go ahead, I can wait~",
        },
        DRAW =
        {
            NOIMAGE = "Uuuuu... Can't think anything to draw...",
        },
        CHANGEIN =
        {
            GENERIC = "I guess I'm not in the mood...",
            BURNING = "I'm not gonna use clothing on fire, you know.",
            INUSE = "Go ahead, I can wait~",
        },
        ATTUNE =
        {
            NOHEALTH = "I think I need a little rest first...",
        },
        MOUNT =
        {
            TARGETINCOMBAT = "They're, uhh... fighting...",
            INUSE = "Already got a rider, I see~",
        },
        SADDLE =
        {
            TARGETINCOMBAT = "They're, uhh... fighting...",
        },
        TEACH =
        {
            --Recipes/Teacher
            KNOWN = "Already inside my database~",
            CANTLEARN = "I can't compute that, somehow...",

            --MapRecorder/MapExplorer
            WRONGWORLD = "Hmmm... I think this isn't the correct place...?",
        },
        WRAPBUNDLE =
        {
            EMPTY = "There's nothing to wrap, nanodesu.",
        },
	},
	ACTIONFAIL_GENERIC = "I can't do that, nanodesu...",
	
	ANNOUNCE_DEATH = "Commander... Please... Lend me your shoulder for a moment...",
	
	--ANNOUNCE_LEVELUP_1 = "null",
	--ANNOUNCE_LEVELUP_2 = "null",
	--ANNOUNCE_LEVELUP_3 = "null",
	--ANNOUNCE_LEVELUP_4 = "null",
	--ANNOUNCE_LEVELUP_5 = "null",
	--ANNOUNCE_LEVELUP_6 = "null",
	--ANNOUNCE_LEVELUP_7 = "null",
	--ANNOUNCE_LEVELUP_8 = "null",
	--ANNOUNCE_LEVELUP_9 = "null",
	--ANNOUNCE_INAZUMAKAI = "null",
	
	ANNOUNCE_DIG_DISEASE_WARNING = "Gotta keep the grass healthy, after all~",
	ANNOUNCE_PICK_DISEASE_WARNING = "The grass doesn't look okay...",
	ANNOUNCE_ADVENTUREFAIL = "Ahahaha... Failed attemt, it seems...",
    ANNOUNCE_MOUNT_LOWHEALTH = "He didn't look fine...",
	ANNOUNCE_BEES = "AAAAAAAAHHH!! BEEEEEEES!!! ",
	ANNOUNCE_BOOMERANG = "Auu...! That hurts...",
	ANNOUNCE_CHARLIE = "The... There's someone behind me...",
	ANNOUNCE_CHARLIE_ATTACK = "Wauuw!! I'm under attack!! Heeeelp!!",
	ANNOUNCE_COLD = "Hu-uuuuuuw... I'm... freezing...!!",
	ANNOUNCE_HOT = "Hooooh... I'm overheating...",
	ANNOUNCE_CRAFTING_FAIL = "Huh...? I thought I have the correct materials?",
	ANNOUNCE_DEERCLOPS = "Guys...? I'm detecting the signal of a big... thing...",
	ANNOUNCE_CAVEIN = "Whoa, the ceiling is rumbling~",
	ANNOUNCE_ANTLION_SINKHOLE = 
	{
		"Whoa, the ground is splitting!",
	},
	ANNOUNCE_ANTLION_TRIBUTE =
	{
        "There, let's be friends now~!",
	},
	ANNOUNCE_SACREDCHEST_YES = "Is it fine, though?",
	ANNOUNCE_SACREDCHEST_NO = "Guess he didn't like it...",
	ANNOUNCE_DUSK = "Night is coming~",
	ANNOUNCE_EAT =
	{
		GENERIC = "Yum! This is some good stuff!",
		PAINFUL = "Blergh... That was bad...",
		SPOILED = "I think that was turning bad...",
		STALE = "I... don't think this is actually edible anymore...",
		INVALID = "This isn't food, dude~",
		YUCKY = "This is the worst way to kill yourself...",
	},
    ANNOUNCE_ENCUMBERED =
    {
        "Heeergh...",
        "It's pretty... heavy... don't you think...?",
        "Huff... puff...",
        "Nghh...!",
        "*gasp*... *wheeze*...!",
        "Pant... Pant...",
        "I... need a bit... rest... wuuuufffh...!",
    },
	ANNOUNCE_ATRIUM_DESTABILIZING = 
    {
		"Yep, time to get back home...~",
	},
    ANNOUNCE_RUINS_RESET = "Whoa...! They're respawned!?",
    ANNOUNCE_SNARED = "Aaah...! Heeelp!",
    ANNOUNCE_REPELLED = "Uff...! He got his force shield activated!",
	ANNOUNCE_ENTER_DARK = "I can't see anything... Hello...?",
	ANNOUNCE_ENTER_LIGHT = "Oh, light! Cool!",
	ANNOUNCE_FREEDOM = "I'm... free? Commander! I'm free!!",
	ANNOUNCE_HIGHRESEARCH = "We received new information!",
	ANNOUNCE_HOUNDS = "Get your weapons ready, guys~ Wolves is coming~",
	ANNOUNCE_WORMS = "They're attacking from the ground, guys~",
	ANNOUNCE_HUNGRY = "I'm hungry...",
	ANNOUNCE_HUNT_BEAST_NEARBY = "This careless animal was just made a huuuuge mistake~",
	ANNOUNCE_HUNT_LOST_TRAIL = "Wait, hold on! I think the trail is still... uhh...",
	ANNOUNCE_HUNT_LOST_TRAIL_SPRING = "Ugh... The ground is too wet...",
	ANNOUNCE_INV_FULL = "I got too much stuff inside my pocket~",
	ANNOUNCE_KNOCKEDOUT = "Oufffh... What happened...?",
	ANNOUNCE_LOWRESEARCH = "We failed...",
	ANNOUNCE_MOSQUITOS = "Ugh, I hate mosquitos...",
    ANNOUNCE_NOWARDROBEONFIRE = "Not into some burning clothes, dude.",
    ANNOUNCE_NODANGERGIFT = "I think there's some cheeky guy trying to steal my gift~",
    ANNOUNCE_NOMOUNTEDGIFT = "I'll need to get off my mount, first~",
	ANNOUNCE_NODANGERSLEEP = "Not a good moment to sleep, now.",
	ANNOUNCE_NODAYSLEEP = "I can't turn off the sun, haha...~",
	ANNOUNCE_NODAYSLEEP_CAVE = "I'm still up, and lively~ No need to sleep~",
	ANNOUNCE_NOHUNGERSLEEP = "I want to eat first...",
	ANNOUNCE_NOSLEEPONFIRE = "Bad day to sleep there~",
	ANNOUNCE_NODANGERSIESTA = "There's still enemy around~",
	ANNOUNCE_NONIGHTSIESTA = "Best to sleep instead at this time~",
	ANNOUNCE_NONIGHTSIESTA_CAVE = "This isn't the place to take a nap in, I guess~",
	ANNOUNCE_NOHUNGERSIESTA = "I want to eat first",
	ANNOUNCE_NODANGERAFK = "I... can't move...!",
	ANNOUNCE_NO_TRAP = "...Hueh, lucky...",
	ANNOUNCE_PECKED = "Ow ow ow!",
	ANNOUNCE_QUAKE = "Hueeeh!? An earthquake!?",
	ANNOUNCE_RESEARCH = "Researching~!",
	ANNOUNCE_SHELTER = "Huff... This is so much better.",
	ANNOUNCE_THORNS = "Auuww!",
	ANNOUNCE_BURNT = "Ah...! That burns...",
	ANNOUNCE_TORCH_OUT = "Oops, the fire is out...",
	ANNOUNCE_THURIBLE_OUT = "It's... out of fuel? I'm not good with magic...",
	ANNOUNCE_FAN_OUT = "My fan is broken...",
    ANNOUNCE_COMPASS_OUT = "The compass didn't work anymore?",
	ANNOUNCE_TRAP_WENT_OFF = "Waaaaah!!",
	ANNOUNCE_UNIMPLEMENTED = "Whoops, spoiler alert~",
	ANNOUNCE_WORMHOLE = "That was... scary...",
	ANNOUNCE_TOWNPORTALTELEPORT = "Wha... ",
	ANNOUNCE_CANFIX = "\nI can fix this with the right material~.",
	ANNOUNCE_ACCOMPLISHMENT = "Mission complete!",
	ANNOUNCE_ACCOMPLISHMENT_DONE = "Yay~!",	
	ANNOUNCE_INSUFFICIENTFERTILIZER = "I ran out of fertilizer.",
	ANNOUNCE_TOOL_SLIP = "Ah! Come back!",
	ANNOUNCE_LIGHTNING_DAMAGE_AVOIDED = "Whoa! That could've killed me outright!",
	ANNOUNCE_TOADESCAPING = "He's trying to escape!",
	ANNOUNCE_TOADESCAPED = "Target lost... sorry...",

	ANNOUNCE_DAMP = "Ufff... I don't like rain...",
	ANNOUNCE_WET = "I need to take shelter real quick...",
	ANNOUNCE_WETTER = "Uuuu... I should've brought my umberella...",
	ANNOUNCE_SOAKED = "Aaaah! I don't want to rust!",
	
	ANNOUNCE_BECOMEGHOST = "Commander... Please... Lend me your shoulder for a moment...",
	ANNOUNCE_GHOSTDRAIN = "...Brr...",
	ANNOUNCE_PETRIFED_TREES = "The trees!? What happened to it!?",
	ANNOUNCE_KLAUS_ENRAGE = "Oh, we've done it. He's angry. He's Super angry...",
	ANNOUNCE_KLAUS_UNCHAINED = "Ah, limit break~!",
	ANNOUNCE_KLAUS_CALLFORHELP = "Enemy reinforcement!",

    ANNOUNCE_ROYALTY = 
    {
    	"Mein Herr...!",
    	"Eure Hoheit...!",
    	"Your wish is my command!",
    },

	BATTLECRY =
	{
		GENERIC = "Engaging!",
		PIG = "Sorry...!",
		PREY = "Sorry...!",
		SPIDER = "Hunter hunted!",
		SPIDER_WARRIOR = "Soldier on soldier!",
	},
	COMBAT_QUIT =
	{
		GENERIC = "We drove them off~",
		PIG = "It ran away~",
		PREY = "It ran away~",
	},
	DESCRIBE =
	{
		MULTIPLAYER_PORTAL = "The gate that sent us to this dark, dark world...~",
		ANTLION = 
		{
			GENERIC = "That's some unnaturally large ant...",
			VERYHAPPY = "The big guy's now my friend as well~!",
			UNHAPPY = "Eeeeh... Did I do something wrong?",
		},
		ANTLIONTRINKET = "I think Commander ever told me about playing these with sand",
		SANDSPIKE = "So close from being stabbed~!",
        SANDBLOCK = "That thing is unexpectedly solid~",
        GLASSSPIKE = "The reflection looks cooler than I tought~",
        GLASSBLOCK = "Looks good, yeah? Hahaha~",
		ABIGAIL_FLOWER = 
		{ 
			GENERIC ="I don't have any data for this flower...?",
			HAUNTED_POCKET = "Umm... is this normal...?",
			HAUNTED_GROUND = "Wh... uuuh... Can I put this down...?",
		},

		BALLOONS_EMPTY = "Can I blow this, please~?",
		BALLOON = " It's floating~!",

		BERNIE_INACTIVE =
		{
			BROKEN = "You fight well, Bernie... Goodbye...",
			GENERIC = "...I can try to fix this poor boy, you know?",
		},

		BERNIE_ACTIVE = "The doll... is not supposed to move... right...?",
		
		BOOK_BIRDS = "Oooh~ Book about birds~!",
		BOOK_TENTACLES = "This doesn't look like that one japanese tentacle, though.",
		BOOK_GARDENING = "Ooh~! Easy steps to grow crops!",
		BOOK_SLEEP = "I want Commander to read this for me...~",
		BOOK_BRIMSTONE = "I... think we should just keep this book closed.",
		
		PLAYER =
        {
            GENERIC = "Hiya, %s~!",
            ATTACKER = "Whoawhoa, calm down %s~!",
            MURDERER = "%s has turned to traitor!",
            REVIVER = "Our savior, %s!",
            GHOST = "That floating thingy looks like %s face...",
        },
		
        MIGRATION_PORTAL = 
        {
            GENERIC = "It's a portal to another world!",
            OPEN = "Right! Towards the new world! Let's go!",
            FULL = "Looks like there's too many people over there...",
        },
		GLOMMER = "Whoa~! A floating and fluffy thingy~!",
		GLOMMERFLOWER = 
		{
			GENERIC = "Sure this flower is big~",
			DEAD = "Ah, now it's dead...",
		},
		GLOMMERWINGS = "He was a good friend...*sobs*",
		GLOMMERFUEL = "Uegh... Smells so bad I could've throw up if I were a human...",
		BELL = "Ding-a-ling~!",
		STATUEGLOMMER = 
		{	
			GENERIC = "Hahaha~ What a weird looking statue",
			EMPTY = "It's battered up already~",
		},

		LAVA_POND_ROCK = "That doesn't look very safe...",
		LAVA_POND_ROCK2 = "That doesn't look very safe...",
		LAVA_POND_ROCK3 = "That doesn't look very safe...",
		LAVA_POND_ROCK4 = "That doesn't look very safe...",
		LAVA_POND_ROCK5 = "That doesn't look very safe...",
		LAVA_POND_ROCK6 = "That doesn't look very safe...",
		LAVA_POND_ROCK7 = "That doesn't look very safe...",

		WEBBERSKULL = "Spider have... skull...?",
		WORMLIGHT = "Some unnatural looking fruit that... glows...?",
		WORMLIGHT_LESSER = "That fruit doesn't look alright...",
		WORM =
		{
		    PLANT = "Yep, it's a trap~!",
		    DIRT = "He's swimming down there...",
		    WORM = "Wuuuh~! It's bigger than I expected~!",
		},
        WORMLIGHT_PLANT = "That plant doesn't look alright...",
		MOLE =
		{
			HELD = "Hehe~! He's tickling me~!",
			UNDERGROUND = "Oho~! He's down there~!",
			ABOVEGROUND = "Awww...~ He's cute~!",
		},
		MOLEHILL = "The cute guy's small home~",
		MOLEHAT = "I should've brought my night googles instead of this...",

		EEL = "Oooh~! Some slippery guy you are~!",
		EEL_COOKED = "Mmmmm~! The smell is alluring~!",
		UNAGI = "Some delicious eel with rice~!",
		EYETURRET = "Land battery, standing by~!",
		EYETURRET_ITEM = "We can set this up somewhere near our base~!",
		MINOTAURHORN = "Wuuuh~! Pretty sharp~!",
		MINOTAURCHEST = "Now this! This must contain some good stuff~!",
		THULECITE_PIECES = "This light rock is super sturdy!",
		POND_ALGAE = "A little bit of pond algae, I think?",
		GREENSTAFF = "I can't explain how it works but... it works~!",
		GIFT = "A gift for a good girl~!",
        GIFTWRAP = "We can wrap up some nice presents~!",
		POTTEDFERN = "Small pot to make our base more lively~!",
		SUCCULENT_POTTED = "A pretty succulent in a pot~!",
		SUCCULENT_PLANT = "This plant is pretty tough, you know~!",
		SUCCULENT_PICKED = "It stores some water inside~",
		SENTRYWARD = "Functions the same as a camera~!",
        TOWNPORTAL =
        {
			GENERIC = "Some weird looking device. Possibly magic stuff?",
			ACTIVE = "Activate~!",
		},
        TOWNPORTALTALISMAN = 
        {
			GENERIC = "Some weird looking stone made from... sand?",
			ACTIVE = "Activated~!",
		},
        WETPAPER = "Can't write on a wet paper, you know~",
        WETPOUCH = "Hopefully the insides didn't get soggy.",
		MOONROCK_PIECES = "It's pretty fragile despite its appearance.",
        MOONBASE =
        {
            GENERIC = "I think we need to put something in the hole~",
            BROKEN = "It got completely smashed up...",
            STAFFED = "So, uhh... what's next?",
            WRONGSTAFF = "Nope, not this one~",
            MOONSTAFF = "Whoawhoa, it emits light!",
        },
        MOONDIAL = 
        {
			GENERIC = "I can see the moon even in the day! Cool!",
			NIGHT_NEW = "It's a new moon.",
			NIGHT_WAX = "The moon is waxing.",
			NIGHT_FULL = "It's a full moon.",
			NIGHT_WANE = "The moon is waning.",
			CAVE = "Can't check the moon from down here, I guess~",
        },
 		--MOWER = "I like the cut of this blade.",
		--MACHETE = "I like the cut of this blade.",
		--GOLDENMACHETE = "Hack in style!",
		--OBSIDIANMACHETE = "It's hot to the touch.",
		--BOOK_METEOR = "The foreword just says \"Hope you like dragoons.\"",
		THULECITE = "How come GNK didn't know this thing exist?",
		ARMORRUINS = "This is so much better than some bulleetproof vest!",
		RUINS_BAT = "Wuuuh~! Bigger and better baseball bat~!",
		RUINSHAT = "It protects the wearer magically~!",
		NIGHTMARE_TIMEPIECE =
		{
            CALM = "They went back to sleep~",
            WARN = "Ah, the magic start to wake up~",
            WAXING = "Wuuuh~! It's rapidly increasing!",
            STEADY = "Its density couldn't reach any higher.",
            WANING = "Finally start to calm down~",
            DAWN = "The magic is almost out~",
            NOMAGIC = "No trace of magic around here, at all~",
		},
		BISHOP_NIGHTMARE = "He's pretty stubborn despite his state~",
		ROOK_NIGHTMARE = "How did he still move and chagrge like crazy?",
		KNIGHT_NIGHTMARE = "I wonder how is he still moving...",
		MINOTAUR = "Wha... that's some dangerous looking magical creature...",
		SPIDER_DROPPER = "Spider ninjas!",
		NIGHTMARELIGHT = "Ugh, my body start to malfunction...",
		NIGHTSTICK = "It's full of electricity~!",
		GREENGEM = "It's a fresh green gem~!",
		RELIC = "How old was these things?",
		MULTITOOL_AXE_PICKAXE = "Aha~! Multitool~!",
		ORANGESTAFF = "Short-range teleportation~ No idea how it works though~",
		YELLOWAMULET = "It's a yellow necklace, and radiates small heat~",
		GREENAMULET = "It really gives me the power to work efficiently~!",
		SLURPERPELT = "Skinned properly~!",	

		SLURPER = "Hungry looking strange looking creature~",
		SLURPER_PELT = "Skinned properly~!",
		ARMORSLURPER = "Well, I guess I don't feel hungry anymore~",
		ORANGEAMULET = "I can feel some kind of magnetic field around me~",
		YELLOWSTAFF = "Even the wooden part feels hot.",
		YELLOWGEM = "A radiant yellow gem~",
		ORANGEGEM = "A pretty orange gem",
        OPALSTAFF = "Energy from the sky~!",
        OPALPRECIOUSGEM = "Wuuuh~ This is some nice looking gem~!",
        TELEBASE = 
		{
			VALID = "Activated~!",
			GEMS = "I think it needs fuel~",
		},
		GEMSOCKET = 
		{
			VALID = "Activated~!",
			GEMS = "I think it needs fuel~",
		},
		STAFFLIGHT = "Whu... An actual tiny sun....",
        STAFFCOLDLIGHT = "Whu... Why is the sun radiates cold instead...?",

        ANCIENT_ALTAR = "This is some weird looking tables~",

        ANCIENT_ALTAR_BROKEN = "I think this needs some fix first~",

        ANCIENT_STATUE = "This statues gave me chills...",

        LICHEN = "It's cave algae. Not tasty, though~",
		CUTLICHEN = "Just eat it all at once~",

		CAVE_BANANA = "Hahaha~ Bigger than Commander's~!",
		CAVE_BANANA_COOKED = "Mhmm~! Smells good~!",
		CAVE_BANANA_TREE = "There's still tree inside a cave?",
		ROCKY = "Haha~! He's such a gentle giant~!",
		
		COMPASS =
		{
			GENERIC="We can use this to check where we're facing~!",
			N = "North.",
			S = "South.",
			E = "East.",
			W = "West.",
			NE = "Northeast.",
			SE = "Southeast.",
			NW = "Northwest.",
			SW = "Southwest.",
		},

        HOUNDSTOOTH = "A sharp tooth from a dead wolf~!",
		ARMORSNURTLESHELL = "Snail's compact homebase~",
		BAT = "Creature of the night~ Scary~",
		BATBAT = "Does this even hurt...?",
        BATWING = "This is so fragile~",
		BATWING_COOKED = "Crispy~!",
        BATCAVE = "The homebase for the bats~",
		BEDROLL_FURRY = "Fuee...~ This might be better than my bed~",
        BUNNYMAN = "Hi, there~! Want some carrots?",
        FLOWER_CAVE = "Some weird plant that glows like a lamp~",
        FLOWER_CAVE_DOUBLE = "Some weird plant that glows like a lamp~",
        FLOWER_CAVE_TRIPLE = "Some weird plant tha glows like a lamp~",
        GUANO = "It's airborne poop~ Haha~",
        LANTERN = "Old fashioned lighting, but still works~",
        LIGHTBULB = "It's still on even though I already pick it up~",
        MANRABBIT_TAIL = "Freshly skinned rabbit tail~",
        MUSHROOMHAT = "Haha~ what a weird looking cap~",
        MUSHROOM_LIGHT2 =
        {
            ON = "Wuuuh~ Even the light looks cool~",
            OFF = "A fancy lamp for fancy living room~",
            BURNT = "It's all burnt...",
        },
        MUSHROOM_LIGHT =
        {
            ON = "Wuuuh~ Even the light looks cool~",
            OFF = "Fancy lamp for ideal living room~",
            BURNT = "It's all burnt...",
        },
        MUSHROOMBOMB = "This is much more effective than 45's bomb~!",
        SHROOM_SKIN = "It's thick and slimy~",
        TOADSTOOL_CAP =
        {
            EMPTY = "Some unnatural looking hole~",
            INGROUND = "A mushroom is growing out of it!",
            GENERIC = "This is some obvious trap...~",
        },
        TOADSTOOL =
        {
            GENERIC = "Isn't this too big for a frog...?",
            RAGE = "Wuuuh~! He's super angry~!",
        },
        MUSHROOMSPROUT =
        {
            GENERIC = "This tree is powering him up!",
            BURNT = "Better burn these things down after all~",
        },
        MUSHTREE_TALL =
        {
            GENERIC = "The mushroom is even bigger than a tree~",
            BLOOM = "It's blooming~",
        },
        MUSHTREE_MEDIUM =
        {
            GENERIC = "It this how mushroom looks like inside a cave?",
            BLOOM = "It's blooming~",
        },
        MUSHTREE_SMALL =
        {
            GENERIC = "A smaller mushroom. Still pretty big, though~",
            BLOOM = "It's blooming~",
        },
        MUSHTREE_TALL_WEBBED = "This one is invested with enemy spiders~",
        SPORE_TALL = "Haha~ *cough*",
        SPORE_MEDIUM = "Haha~ *cough*",
        SPORE_SMALL = "Haha~ *cough*",
        SPORE_TALL_INV = "It's so beautiful...",
        SPORE_MEDIUM_INV = "It's so beautiful...",
        SPORE_SMALL_INV = "It's so beautiful...",
        RABBITHOUSE =
        {
            GENERIC = "They really love carrot, they modelled their house after one~",
            BURNT = "It's all burnt...",
        },
        SLURTLE = "It's a huge snail thingy~!",
        SLURTLE_SHELLPIECES = "No wonder the snail is pretty tough~",
        SLURTLEHAT = "This helmet is stronger than Jager's helmet~!",
        SLURTLEHOLE = "What a strange looking house, haha~",
        SLURTLESLIME = "This thing is flammable, you know~",
        SNURTLE = "Wuuuh~! An actual huge snail~!",
        SPIDER_HIDER = "Heh, such tactic will not protect you forever~!",
		SPIDER_SPITTER = "This one is able to shoot~!",
		SPIDERHOLE = "This is the cave spiders' homebase. Let's destroy it~!",
        SPIDERHOLE_ROCK = "This is the cave spiders' homebase. Let's destroy it~!",
        STALAGMITE = "A small rock formation~",
        STALAGMITE_FULL = "A small rock formation~",
        STALAGMITE_LOW = "A small rock formation~",
        STALAGMITE_MED = "A small rock formation~",
        STALAGMITE_TALL = "A bigger rock formation~",
        STALAGMITE_TALL_FULL = "A bigger rock formation~",
        STALAGMITE_TALL_LOW = "A bigger rock formation~",
        STALAGMITE_TALL_MED = "A bigger rock formation~",
        TREASURECHEST_TRAP = "Don't you think this is too obvious for a trap?",

        TURF_CARPETFLOOR = "It's a comfy and warm carpet floor~!",
        TURF_CHECKERFLOOR = "Some sturdy and snazzy floor~",
        TURF_DIRT = "Just a chunk of dug up ground~",
        TURF_FOREST = "Just a chunk of dug up ground~",
        TURF_GRASS = "Just a chunk of dug up ground~",
        TURF_MARSH = "Just a chunk of dug up ground~",
        TURF_ROAD = "A path to our victory~! Hahaha~",
        TURF_ROCKY = "Just a chunk of dug up ground~",
        TURF_SAVANNA = "Just a chunk of dug up ground~",
        TURF_WOODFLOOR = "For your home floor~",

		TURF_CAVE = "Just a chunk of dug up ground~",
		TURF_FUNGUS = "Just a chunk of dug up ground~",
		TURF_SINKHOLE = "Just a chunk of dug up ground~",
		TURF_UNDERROCK = "Just a chunk of dug up ground~",
		TURF_MUD = "Just a chunk of dug up ground~",

		TURF_DECIDUOUS = "Just a chunk of dug up ground~",
		TURF_SANDY = "Just a chunk of dug up ground~",
		TURF_BADLANDS = "Just a chunk of dug up ground~",
		TURF_DESERTDIRT = "Just a chunk of dug up ground~",
		TURF_FUNGUS_GREEN = "Just a chunk of dug up ground~",
		TURF_FUNGUS_RED = "Just a chunk of dug up ground~",
		TURF_DRAGONFLY = "It's still warm, even though we made her to a floor...~",

		POWCAKE = "It's not for eating, despite its delicious appearance~",
        CAVE_ENTRANCE = "Looks like this rock is made to block something~",
        CAVE_ENTRANCE_RUINS = "Looks like this rock is made to block something~",
       
       	CAVE_ENTRANCE_OPEN = 
        {
            GENERIC = "Wanna go downstairs~?",
            OPEN = "Towards another new world~!",
            FULL = "It's pretty full there, I need to wait~",
        },
        CAVE_EXIT = 
        {
            GENERIC = "I think I don't want to go up yet~",
            OPEN = "Wanna get out and see the sun again~?",
            FULL = "They're not sunbathing, yeah?",
        },

		MAXWELLPHONOGRAPH = "The music is a bit scary, don't you think?",
		BOOMERANG = "This thing does get back when you throw it to something~!",
		PIGGUARD = "That pig guy is pretty hostile towards anything...",
		ABIGAIL = "Wuh... Ah... Hi there...? Can we be friends?",
		ADVENTURE_PORTAL = "A portal? Where does this lead?",
		AMULET = "I can feel the warmth radiating from the amulet...~",
		ANIMAL_TRACK = "Tracks left carelessly by an animal~",
		ARMORGRASS = "It's really uncomfortable...",
		ARMORMARBLE = "It's... pretty heavy for someone like me...",
		ARMORWOOD = "Aside from the looks, this is pretty snazzy~",
		ARMOR_SANITY = "Don't ask me how does this protects its wearer...",
		ASH =
		{
			GENERIC = "The remain from a fire...",
			REMAINS_GLOMMERFLOWER = "Oh no, the flower is gone...",
			REMAINS_EYE_BONE = "Oh no, the eye bone is burnt out...",
			REMAINS_THINGIE = "Nothing but ashes left...",
		},
		AXE = "A tool to cut trees so you don't punch it to oblivion~",
		BABYBEEFALO = 
		{
			GENERIC = "Aww~ It's a cute baby beefalo~",
		    SLEEPING = "Hnnggg...! I want to snuggle besides her~!",
        },
        BUNDLE = "Package bag for storing things~",
        BUNDLEWRAP = "Now we can store things more efficiently~!",
		BACKPACK = "Essential for someone who forgot their weapon case~!",
		BACONEGGS = "Perfect for your morning activity~!",
		BANDAGE = "Processed to heal bruises even better~",
		BASALT = "It's a very strong rock~",
		BEARDHAIR = "Totally not my beard~",
		BEARGER = "Whu... That's an oversized bear~! Don't play dead~!",
		BEARGERVEST = "Whu... So warm and comfy~!",
		ICEPACK = "The fur keeps the temperature inside for a while longer~",
		BEARGER_FUR = "This is perfect for winter coat~!",
		BEDROLL_STRAW = "Gotta use whatever is available~",
		BEEQUEEN = "Oooh~! Strong and menacing bee commander~!",
		BEEQUEENHIVE = 
		{
			GENERIC = "That's some huge crater she left~",
			GROWING = "Whoa~! It's already this big~?",
		},
        BEEQUEENHIVEGROWN = "Do you think the bees inside would be as bis as your head?",
        BEEGUARD = "The ruthless royal guard~!",
        HIVEHAT = "Now I'm the queen~! Myaha~!",
        MINISIGN =
        {
            GENERIC = "Hehe~ The sign is so small~",
            UNDRAWN = "I can make it cuter you know~!",
        },
        MINISIGN_ITEM = "Let's place this down and draw something on it~!",
		BEE =
		{
			GENERIC = "Haha~ Why don't you come here~?",
			HELD = "Handle this tiny guy with care~",
		},
		BEEBOX =
		{
			READY = "Aha~! Ready to harvest~!",
			FULLHONEY = "Wuuuh~! It's overflowing~!",
			GENERIC = "It's full of our bees~",
			NOHONEY = "They're still working~",
			SOMEHONEY = "Their hard work start to show up some result~!",
			BURNT = "It's all burnt...",
		},
		MUSHROOM_FARM =
		{
			STUFFED = "Wuuuh~! So many mushrooms~!",
			LOTS = "It's harvest moon~!",
			SOME = "They're growing rapidly~!",
			EMPTY = "Think we need something to plant here~",
			ROTTEN = "I guess we need some fresh log first~",
			BURNT = "It's all burnt...",
			SNOWCOVERED = "Well, I guess mushroom can't grow in snow~",
		},
		BEEFALO =
		{
			FOLLOWER = "Haha~ She's following me~",
			GENERIC = "Some hairy beefalo~",
			NAKED = "Haha~ She looks funny~",
			SLEEPING = "They're snoring pretty loud~",
            --Domesticated states:
            DOMESTICATED = "Hahaha~ We're best friends now~!",
            ORNERY = "Wuuuh~ He looks menacing than usual~!",
            RIDER = "She want me to ride her~! How kind~!",
            PUDGY = "Uhh... We give her too much food, I think?",
		},

		BEEFALOHAT = "Hat made from the strong horns~!",
		BEEFALOWOOL = "This is pretty thick and rough~",
		BEEHAT = "This only protects my head, though~",
        BEESWAX = "This still pretty slippery~",
		BEEHIVE = "Bee homebase~!",
		BEEMINE = "Hopefully not going to drop this...",
		BEEMINE_MAXWELL = "The buzzing is a little scary...",
		BERRIES = "This small berries is pretty delicious~!",
		BERRIES_COOKED = "They're a bit juicy now~!",
        BERRIES_JUICY = "These berries are super delicious~!",
        BERRIES_JUICY_COOKED = "Perfection~!",
		BERRYBUSH =
		{
			BARREN = "I think we need to fertilize this first~",
			WITHERED = "They're even dying under this condition...",
			GENERIC = "We can pick the delish berries there~",
			PICKED = "How long does it takes to grow the berries back?",
			DISEASED = "Oh no... we need to remove this one...",
			DISEASING = "Huh? I think I saw some black-ish leaves?",
			BURNING = "Whoawhoa! Put the fire out!",
		},
		BERRYBUSH_JUICY =
		{
			BARREN = "I think we need to fertilize this first~",
			WITHERED = "They're even dying under this condition...",
			GENERIC = "We can pick the delish berries there~",
			PICKED = "How long does it takes to grow the berries back?",
			DISEASED = "Oh no... we need to remove this one...",
			DISEASING = "Huh? I think I saw some black-ish leaves?",
			BURNING = "Whoawhoa! Put the fire out!",
		},
		BIGFOOT = "What is... this creature...?",
		BIRDCAGE =
		{
			GENERIC = "Now let's find some cute birdie~!",
			OCCUPIED = "Haha~! She's such a cutie~!",
			SLEEPING = "Aww, it's sleeping~",
			HUNGRY = "We need to feed her properly, now~",
			STARVING = "Oh! We need to get her some food real quick!",
			DEAD = "Oh no...",
			SKELETON = "I'm so cruel...",
		},
		BIRDTRAP = "To catch the birdies~",
		CAVE_BANANA_BURNT = "It's all burnt...",
		BIRD_EGG = "Small bird egg~",
		BIRD_EGG_COOKED = "I like it sunny side up~",
		BISHOP = "Whoawhoa~! This one shoots energy bolt!",
		BLOWDART_FIRE = "This is some fire element weapon~",
		BLOWDART_SLEEP = "To make your target fall asleep~",
		BLOWDART_PIPE = "Traditional weapon works too~",
		BLOWDART_YELLOW = "This is some cool blow dart~!",
		BLUEAMULET = "This amulet gives some cold effect to me...~",
		BLUEGEM = "It's as blue as the sky~",
		BLUEPRINT = 
		{ 
            COMMON = "Aha~ Some common blueprint for things~",
            RARE = "Wuuuh~! We need to learn how to make it~!",
        },
        SKETCH = "A sketch to make some ",
		--BELL_BLUEPRINT = "There's SCIENCE afoot!",
		BLUE_CAP = "Picked blue mushroom~",
		BLUE_CAP_COOKED = "It tastes really different than before~",
		BLUE_MUSHROOM =
		{
			GENERIC = "Just a blue mushroom~",
			INGROUND = "It's sleeping~",
			PICKED = "Pretty sure mushroom grows again later~",
		},
		BOARDS = "Some planks for various useful things~",
		BONESHARD = "Too bad dolls don't have bones~",
		BONESTEW = "This is some thick stew~",
		BUGNET = "Wanna catch some jellyfish? Haha~",
		BUSHHAT = "Infiltration at its finest~!",
		BUTTER = "But... doesn't mean it drops butter...",
		BUTTERFLY =
		{
			GENERIC = "Aha~ Butterfly~ Flutter by~",
			HELD = "It's pretty big up close~",
		},
		BUTTERFLYMUFFIN = "Is this even the correct recipe?",
		BUTTERFLYWINGS = "Butterfly wings from dead butterfly...",
		BUZZARD = "Some corpse eater bird. Won't eat me though~",

		SHADOWDIGGER = "Magic... guy... I don't know.",

		CACTUS = 
		{
			GENERIC = "Spiny and tough plant~",
			PICKED = "Awawaw...!",
		},
		CACTUS_MEAT_COOKED = "No spikes left, just the delicious meat now~",
		CACTUS_MEAT = "I can slap people with this~",
		CACTUS_FLOWER = "The flower that bloom in this harsh weather~",

		COLDFIRE =
		{
			EMBERS = "Whoawhoa~! It's dying~!",
			GENERIC = "Cold fire~!",
			HIGH = "Wuuuh... We put too much fuel...",
			LOW = "Let's put more fuel to keep the fire on~",
			NORMAL = "Cold fire~!",
			OUT = "Gotta start it up again, now~",
		},
		CAMPFIRE =
		{
			EMBERS = "Whoawhoa~! It's dying~!",
			GENERIC = "Feels like we're camping~!",
			HIGH = "Wuuuh... We put too much fuel...",
			LOW = "Let's put more fuel to keep the fire on~",
			NORMAL = "Feels like we're camping~!",
			OUT = "Gotta start it up again, now~",
		},
		CANE = "For those who can hardly walk~",
		CATCOON = "A cat? Raccoon? Uhh... my brain...",
		CATCOONDEN = 
		{
			GENERIC = "The cat thingy's home~",
			EMPTY = "The owner's gone now...",
		},
		CATCOONHAT = "Haha~! Looks like Mosin-Nagant's Hat~!",
		COONTAIL = "This tail is pretty fluff~",
		CARROT = "G11 never eat her carrot, though~",
		CARROT_COOKED = "This is better than usual carrot~!",
		CARROT_PLANTED = "Our crops is growing healthily~",
		CARROT_SEEDS = "It's a carrot seed~",
		CARTOGRAPHYDESK = 
		{	
			GENERIC = "A table to write down your adventure~!",
			BURNING = "Whoawhoa! Put the fire out!",
			BURNT = "It's all burnt...",
		},
		WATERMELON_SEEDS = "It's a watermelon seed~",
		CAVE_FERN = "It's a small cave flower~",
		CHARCOAL = "Remnants from burnable thing...",
        CHESSPIECE_PAWN = 
        {
			GENERIC = "This is pretty much decribes me, 40 and 45~",
		},
        CHESSPIECE_ROOK = 
        {
			GENERIC = "I think this represents G11? She's straight forward after all~",
			STRUGGLE = "Whoawhoa! Is this more of those magic thingy?",
		},
        CHESSPIECE_KNIGHT = 
        {
			GENERIC = "Knight is definitely HK416~! Her maneuvers is great~!",
			STRUGGLE = "Whoawhoa! Is this more of those magic thingy?",
		},
        CHESSPIECE_BISHOP = 
        {
			GENERIC = "This represents WA2000~ Snipe from afar~!",
			STRUGGLE = "Whoawhoa! Is this more of those magic thingy?",
		},
        CHESSPIECE_MUSE = 
        {
			GENERIC = "Nope, not Kalina. Definitely not her~",
			--STRUGGLE = "Something's coming!!",
		},
        CHESSPIECE_FORMAL = 
        {
			GENERIC = "King is definitely the commander~! No question needed~!",
		},
        CHESSPIECE_HORNUCOPIA = 
        {
			GENERIC = "Now I start to get hungry...",
		},
        CHESSPIECE_PIPE = 
        {
			GENERIC = "Haha~ Looks like Mr. Kyruger's pipe~!",
		},
        CHESSJUNK1 = "The chess piece is pretty much broken~",
        CHESSJUNK2 = "The chess piece is pretty much broken~",
        CHESSJUNK3 = "The chess piece is pretty much broken~",
		CHESTER = "A friend that always help you to bring your stuffs~",
		CHESTER_EYEBONE =
		{
			GENERIC = "The eye... is moving?",
			WAITING = "Oh, now it's closed?",
		},
		COOKEDMANDRAKE = "Is this even a good idea?",
		COOKEDMEAT = "Some rewarding food after hunting~!",
		COOKEDMONSTERMEAT = "This is still a bad idea...",
		COOKEDSMALLMEAT = "Works as snack in the middle of night~",
		COOKPOT =
		{
			COOKING_LONG = "We need to wait for a bit longer now~",
			COOKING_SHORT = "Food is almost done, guys~!",
			DONE = "Yay~! All the waiting paid off~!",
			EMPTY = "Let's cook something delicious~!",
			BURNT = "It's all burnt...",
		},
		CORN = "Hahaha~ I wanna try to eat this like woodpecker~",
		CORN_COOKED = "We need a bit salt and voila~!",
		CORN_SEEDS = "It's a corn seed~",
        CANARY =
		{
			GENERIC = "A cute yellow canary~",
			HELD = "It's fine, I just want to be your friend~",
		},
        CANARY_POISONED = "Oh no, she's sick!",

		CRITTERLAB = "What's inside this rock~? I'm curious~",
        CRITTER_GLOMLING = "It's a small floating fluffy fluff~!",
        CRITTER_DRAGONLING = "Schmoll dragon~ Hehe~",
		CRITTER_LAMB = "Hahaha~ He's so cute~",
        CRITTER_PUPPY = "Hnnnggg... So cuteeee...~",
        CRITTER_KITTEN = "Come to me, Catty cat~!",
		CRITTER_PERDLING = "Small pet chicken~ Cute~",
		
		CROW =
		{
			GENERIC = "They sais that bird brings bad omen~ Scary~",
			HELD = "It's fine, I just want to be your friend~",
		},
		CUTGRASS = "If you bundle this together, it's pretty sturdy~",
		CUTREEDS = "Cutten from the dangerous swamp~",
		CUTSTONE = "To make things more aesthetic~",
		DEADLYFEAST = "This means suicide. Literally.",
		DEER =
		{
			GENERIC = "How do they... see...?",
			ANTLER = "This one got horn but still got no eyes...",
		},
        DEER_ANTLER = "Some of the part is actually sharp~",
        DEER_GEMMED = "I need to shoot the gemstone!",
		DEERCLOPS = "Shoot the obvious weakspot!",
		DEERCLOPS_EYEBALL = "Ugh, this looks so gross...",
		EYEBRELLAHAT =	"No idea why do we need the eye...",
		DEPLETED_GRASS =
		{
			GENERIC = "There's no more grass...",
		},
		GOGGLESHAT = "Looking cool, eh?",
        DESERTHAT = "Now we can move in the sandstorm~!",
		DEVTOOL = "Is this Lab. 16 things?",
		DEVTOOL_NODEV = "I'm just a doll, not a game developer~",
		DIRTPILE = "Hoho~ What a careless mistake you did~",
		DIVININGROD =
		{
			COLD = "The signal is very faint.",
			GENERIC = "It's some kind of homing device.",
			HOT = "This thing's going crazy!",
			WARM = "I'm headed in the right direction.",
			WARMER = "Must be getting pretty close.",
		},
		DIVININGRODBASE =
		{
			GENERIC = "I wonder what it does.",
			READY = "It looks like it needs a large key.",
			UNLOCKED = "Now the machine can work!",
		},
		DIVININGRODSTART = "That rod looks useful!",
		DRAGONFLY = "The dragon have a glaring weakspot, just like her glare... towards... me...",
		ARMORDRAGONFLY = "This is warm, and protects you~!",
		DRAGON_SCALES = "There's still a hint of fire flickering around~",
		DRAGONFLYCHEST = "Fireproof chest~!",
		DRAGONFLYFURNACE = 
		{
			HAMMERED = "I don't think this is how it's supposed to be...",
			GENERIC = "It's still warm~", --no gems
			NORMAL = "Mmhm~ Perfect warmness~", --one gem
			HIGH = "Whoawhoa~! Too hot, too hot!", --two gems
		},
        
        HUTCH = "Haha~ What a starnge walking fish~",
        HUTCH_FISHBOWL =
        {
            GENERIC = "Whose aquarium is this?",
            WAITING = "Fish? Hello?",
        },
		LAVASPIT = 
		{
			HOT = "Whoawhoa~! That's super dangerous~!",
			COOL = "It's cold now~",
		},
		LAVA_POND = "To make the area even hotter...",
		LAVAE = "Don't be tricked, now. It's hostile~",
		LAVAE_COCOON = "I bet the insides is still super hot...~",
		LAVAE_PET = 
		{
			STARVING = "Oh no! We need to feed her! Quick!",
			HUNGRY = "Aww, want to get some food?",
			CONTENT = "Hehe~ She got his belly full~",
			GENERIC = "Hehe~ The lava cutie is my friend now~",
		},
		LAVAE_EGG = 
		{
			GENERIC = "How do you hatch a rock egg...?",
		},
		LAVAE_EGG_CRACKED =
		{
			COLD = "Umm... Make it hotter, I think?",
			COMFY = "Is this the right amount of temperature?",
		},
		LAVAE_TOOTH = "The cute lava would follow whoever bring this~",

		DRAGONFRUIT = "Aha~! Dragon fruit from dragon lands~",
		DRAGONFRUIT_COOKED = "Cooked dragon! Fruit! Haha~!",
		DRAGONFRUIT_SEEDS = "It's a dragonfruit seed~",
		DRAGONPIE = "It tastes even better than apple pie~!",
		DRUMSTICK = "Chicken legs~ Good for snack~",
		DRUMSTICK_COOKED = "Grilled chicken meat~!",
		DUG_BERRYBUSH = "Now we can put this to our private farm~",
		DUG_BERRYBUSH_JUICY = "Now we can put this to our private farm~",
		DUG_GRASS = "We can put this somewhere strategic now~",
		DUG_MARSH_BUSH = "Let's put this somewhere else~",
		DUG_SAPLING = "The twig still useful so let's keep planting it~",
		DURIAN = "Whoa~! The legendary fruit~!",
		DURIAN_COOKED = "So smelly~ Haha... Ubh...",
		DURIAN_SEEDS = "It's a durian seed~",
		EARMUFFSHAT = "It keeps my ear from freezing~",
		EGGPLANT = "Ooh, heard this is some good food~",
		EGGPLANT_COOKED = "Just need a biiiit more salt~",
		EGGPLANT_SEEDS = "It's an eggplant seed~",
		
		ENDTABLE = 
		{
			BURNT = "It's all burnt...",
			GENERIC = "A completely normal table in this crazy world~",
			EMPTY = "I think we need to put something on it~",
			WILTED = "Whoops, the light is out~",
			FRESHLIGHT = "Now it works as a table lamp~",
			OLDLIGHT = "I think we need to change the lamp~", -- will be wilted soon, light radius will be very small at this point
		},
		DECIDUOUSTREE = 
		{
			BURNING = "Whoawhoa! Put the fire out!",
			BURNT = "It's all burnt...",
			CHOPPED = "We need to plant the seeds for a better world~",
			POISON = "Whoawhoa~! The tree is super angry!",
			GENERIC = "The leaves formed a round pattern~",
		},
		ACORN = "Multifunction as more wood or more food~",
        ACORN_SAPLING = "It's still growing slowly~",
		ACORN_COOKED = "Crunchy~!",
		BIRCHNUTDRAKE = "Whoa~ Tiny angry tree~!",
		EVERGREEN =
		{
			BURNING = "Whoawhoa! Put the fire out!",
			BURNT = "It's all burnt...",
			CHOPPED = "We need to plant the seeds for a better world~",
			GENERIC = "A big and healthy pine tree~",
		},
		EVERGREEN_SPARSE =
		{
			BURNING = "Whoawhoa! Put the fire out!",
			BURNT = "It's all burnt...",
			CHOPPED = "We need to plant the seeds for a better world~",
			GENERIC = "This one doesn't look healthy than the others...",
		},
		TWIGGYTREE = 
		{
			BURNING = "Whoawhoa! Put the fire out!",
			BURNT = "It's all burnt...",
			CHOPPED = "We need to plant the seeds for a better world~",
			GENERIC = "It's a super stick-y tree~",			
			DISEASED = "Wait, there's termite eating the tree!",
		},
		TWIGGY_NUT_SAPLING = "It's still growing slowly~",
        TWIGGY_OLD = "The tree needs walking cane~ Haha~",
		TWIGGY_NUT = "There's twig growing from this nut~!",
		EYEPLANT = "Hawawa, those eyes are making me really uncomfortable...",
		INSPECTSELF = "UMP9~! Let's be friends and work together~!",
		FARMPLOT =
		{
			GENERIC = "We can grow the see we've found before~",
			GROWING = "Our crops is growing pretty nicely~!",
			NEEDSFERTILIZER = "I think it needs more fertilizer~",
			BURNT = "It's all burnt...",
		},
		FEATHERHAT = "Hat made from bird feathers~",
		FEATHER_CROW = "Crow feather also brings bad omen?",
		FEATHER_ROBIN = "A crimson red bird feather",
		FEATHER_ROBIN_WINTER = "The feather is snow colored now~",
		FEATHER_CANARY = "A beautiful canary feather~",
		FEATHERPENCIL = "What should I draw on G11's face now...~",
		FEM_PUPPET = "She's trapped?",
		FIREFLIES =
		{
			GENERIC = "Some bugs that glows in the dark~",
			HELD = "They're pretty~!",
		},
		FIREHOUND = "Fire breathing wolf~!",
		FIREPIT =
		{
			EMBERS = "Whoawhoa~! It's dying~!",
			GENERIC = "Feels like we're camping~!",
			HIGH = "Wuuuh... We put too much fuel...",
			LOW = "Let's put more fuel to keep the fire on~",
			NORMAL = "Feels like we're camping~!",
			OUT = "The fire is out, now...",
		},
		COLDFIREPIT =
		{
			EMBERS = "Whoawhoa~! It's dying~!",
			GENERIC = "Cold fire~!",
			HIGH = "Wuuuh... We put too much fuel...",
			LOW = "Let's put more fuel to keep the fire on~",
			NORMAL = "Cold fire~!",
			OUT = "The fire is out, now...",
		},
		FIRESTAFF = "Handle this with extra care~",
		FIRESUPPRESSOR = 
		{	
			ON = "No fire will be lit in this guy's watch~",
			OFF = "Conserve our precious fuel~",
			LOWFUEL = "Need some extra fuel~",
		},

		FISH = "Haha~! He's still moving~!",
		FISHINGROD = "They said fishing feels relaxing~",
		FISHSTICKS = "Commander said this food is pretty expensive~",
		FISHTACOS = "I would prefer to eat beef taco, though~",
		FISH_COOKED = "Grilled to perfectness~",
		FLINT = "A universal material for various tool~",
		FLOWER = 
		{
            GENERIC = "Flowering night~",
            ROSE = "Armed with self defense system~!",
        },
        FLOWER_WITHERED = "It's withered...",
		FLOWERHAT = "I wanted to give this to 45 as well...~",
		FLOWER_EVIL = "This isn't some normal flower...",
		FOLIAGE = "Cave flowers~",
		FOOTBALLHAT = "This is pretty sturdy to resist even a smack from KSG~",
        FOSSIL_PIECE = "Oooh~ So this is dinosaur fossils~",
        FOSSIL_STALKER =
        {
			GENERIC = "So how do you rearrange this?",
			FUNNY = "Hahaha~ It looks stupid~",
			COMPLETE = "Oooh~ It's finished~",
        },
		STALKER = "Whoawhoa~! The dinosaur is alive again!",
        STALKER_ATRIUM = "Co... Commander...? I'm scared...",
        STALKER_MINION = "They're creeping me out, nanodesu...",
        THURIBLE = "The magic is so dense even I could feel it...",
        ATRIUM_OVERGROWTH = "The light looks so... evil...",
		FROG =
		{
			DEAD = "Byebye~",
			GENERIC = "He's pretty hostile to almost everything~",
			SLEEPING = "He's pretty noisy...",
		},
		FROGGLEBUNWICH = "It's a bit chewy~",
		FROGLEGS = "Umm, we need to process this a bit more...",
		FROGLEGS_COOKED = "Doesn't look alluring, though~",
		FRUITMEDLEY = "Sweet and delicious fruits~!",
		FURTUFT = "Fur from that big bear guy~", 
		GEARS = "This isn't my gear, for your information~",
		GHOST = "So ghost does exist, after all?",
		GOLDENAXE = "I thought golden is super soft?",
		GOLDENPICKAXE = "This is supposed to break easily...",
		GOLDENPITCHFORK = "This is such a waste of resource...",
		GOLDENSHOVEL = "We'd better use this for something else, you know~",
		GOLDNUGGET = "Wuuuh~! An actual gold nugget!",
		GRASS =
		{
			BARREN = "I think we need to fertilize this first~",
			WITHERED = "They're even dying under this condition...",
			BURNING = "Whoawhoa! Put the fire out!",
			GENERIC = "Some tall grass that we could use~",
			PICKED = "How long does it takes to grow the grass back?",
			DISEASED = "Oh no... we need to remove this one...",
			DISEASING = "Huh? I think I saw some black-ish leaves?",
		},
		GRASSGEKKO = 
		{
			GENERIC = "He's faster than me~",	
			DISEASED = "He doesn't looks that fine...",
		},
		GREEN_CAP = "Umberella-shaped green mushroom~",
		GREEN_CAP_COOKED = "Tastes super sweet now~",
		GREEN_MUSHROOM =
		{
			GENERIC = "Umberella-shaped green mushroom~",
			INGROUND = "It's sleeping~",
			PICKED = "Pretty sure mushrooms will grow back~",
		},
		GUNPOWDER = "Hand-made gunpowder looks so weird~",
		HAMBAT = "Beat da meat~ Haha~",
		HAMMER = "Don't hammer other people's head, now~",
		HEALINGSALVE = "This is actually pretty cold~",
		HEATROCK =
		{
			FROZEN = "I can feel winter in this~",
			COLD = "It's pretty chilly~",
			GENERIC = "This thing can absorb the temperature around~",
			WARM = "Hehehe...~ So warm~",
			HOT = "Whoawhoa~! Too hot~!",
		},
		HOME = "Knock, knock. Who's there~",
		HOMESIGN =
		{
			GENERIC = "The sign says, \"You are here\"~",
            UNWRITTEN = "Can I write the sign? It's empty~",
			BURNT = "It's all burnt...",
		},
		ARROWSIGN_POST =
		{
			GENERIC = "The sign says, \"That way\"~",
            UNWRITTEN = "Can I write the sign? It's empty~",
			BURNT = "It's all burnt...",
		},
		ARROWSIGN_PANEL =
		{
			GENERIC = "The sign says, \"That way\"~",
            UNWRITTEN = "Can I write the sign? It's empty~",
			BURNT = "It's all burnt...",
		},
		HONEY = "Sweet, sweet~ So sweet~",
		HONEYCOMB = "This was bees home~",
		HONEYHAM = "This is so mouthwatering...~",
		HONEYNUGGETS = "Beautiful snacks~!",
		HORN = "You can actually blow this and it makes sound~!",
		HOUND = "Some hungry wolf there~",
		HOUNDBONE = "Pretty sure they're not attracted to dolls...",
		HOUNDMOUND = "It's wolf nest full of bad things...~",
		ICEBOX = "Now we can store our food longer~!",
		ICEHAT = "Hahaha~! It looks stupid~!",
		ICEHOUND = "Wuuuh~! Ice breathing wolf~!",
		INSANITYROCK =
		{
			ACTIVE = "My head... Is this some kind of virus...?",
			INACTIVE = "This pyramid looks suspicious...",
		},
		JAMMYPRESERVES = "Best eaten with bread~",

		KABOBS = "Did you hear accordion music~? Haha~",
		KILLERBEE =
		{
			GENERIC = "Wuuuh~! Angry bees~! Run awaaaay~!",
			HELD = "I got you, now~",
		},
		KNIGHT = "Funny looking machinery~",
		KOALEFANT_SUMMER = "Hahaha~ He's such a shy guy~",
		KOALEFANT_WINTER = "Hahaha~ He's such a shy guy~",
		KRAMPUS = "Aaaahh! I'm sorry! Please don't take my stuffs!",
		KRAMPUS_SACK = "What are they bringing, anyway?",
		LEIF = "Whu...! The tree...! The tree is angry!",
		LEIF_SPARSE = "Whu...! The tree...! The tree is angry!",
		LIGHTER  = "Some fancy lighter she had~",
		LIGHTNING_ROD =
		{
			CHARGED = "Look at the electricity~",
			GENERIC = "So the lightning won't strike me~",
		},
		LIGHTNINGGOAT = 
		{
			GENERIC = "Baaaah~ Hahaha~",
			CHARGED = "Ba... ah.. He's angry~",
		},
		LIGHTNINGGOATHORN = "This is some great conductor~!",
		GOATMILK = "Can I grow bigger with this~?",
		LITTLE_WALRUS = "He's still training to be a good hunter~",
		LIVINGLOG = "The face looks creepy...",
		LOG =
		{
			BURNING = "Whoawhoa! Put the fire out!",
			GENERIC = "You need this for almost anything~",
		},
		LUCY = "Whu...! The axe...! The axe is talking!",
		LUREPLANT = "This bad boy needs to be punished~",
		LUREPLANTBULB = "Why would you plant this again, though~?",
		MALE_PUPPET = "He's trapped...",

		MANDRAKE_ACTIVE = "The little guy is so active~",
		MANDRAKE_PLANTED = "This isn't carrot...?",
		MANDRAKE = "He's sleeping?",

		MANDRAKESOUP = "He looks relaxed~ Haha~",
		MANDRAKE_COOKED = "Is this counted as killing?",
		MAPSCROLL = "It's a map that needs something inside~",
		MARBLE = "Too bad this isn't round~",
		MARBLEBEAN = "How... does this... grow...?",
		MARBLEBEAN_SAPLING = "I don't know... Don't ask me...",
        MARBLESHRUB = "This marble is actually growing...",
		MARBLEPILLAR = "Some heavy and strong pillar~",
		MARBLETREE = "Marble sculpted after a tree~",
		MARSH_BUSH =
		{
			BURNING = "Whoawhoa! Put the fire out!",
			GENERIC = "Some small thorny marsh plant",
			PICKED = "Awawaw!",
		},
		BURNT_MARSH_BUSH = "It's all burnt...",
		MARSH_PLANT = "It's muddy to its core~",
		MARSH_TREE =
		{
			BURNING = "Whoawhoa! Put the fire out!",
			BURNT = "It's all burnt...",
			CHOPPED = "How do we plant them back, though?",
			GENERIC = "Spiky spike tree~",
		},
		MAXWELL = "This person looks so fishy...",
		MAXWELLHEAD = "This doesn't look good either...",
		MAXWELLLIGHT = "These are some strange light...",
		MAXWELLLOCK = "What is this? A lock?",
		MAXWELLTHRONE = "I don't want to sit there...",
		MEAT = "Fresh meat from hunting game~",
		MEATBALLS = "This isn't some snack tier food anymore~",
		MEATRACK =
		{
			DONE = "All the waiting has paid off~!",
			DRYING = "I think it needs a few more days~",
			DRYINGINRAIN = "Aww... the rain doesn't let dry...",
			GENERIC = "We can dry up our meat here~!",
			BURNT = "It's all burnt...",
		},
		MEAT_DRIED = "Crispy and salty~!",
		MERM = "A huge fish... man... thing...!",
		MERMHEAD = 
		{
			GENERIC = "What kind of civilization is this...?",
			BURNT = "It's all burnt...",
		},
		MERMHOUSE = 
		{
			GENERIC = "This house is totally ruined~",
			BURNT = "It's all burnt...",
		},
		MINERHAT = "I can see better in the night~!",
		MONKEY = "Awww~ Hi little curious guys~!",
		MONKEYBARREL = "This is definitely monkey house~!",
		MONSTERLASAGNA = "I think that tomboyish girl from naval base cooks better than this...",
		FLOWERSALAD = "Desert Salad~!",
        ICECREAM = "Oooh~ *droll*",
        WATERMELONICLE = "Popsicle~! I really love this~!",
        TRAILMIX = "All the good stuffs inside~!",
        HOTCHILI = "Want to spice things up~?",
        GUACAMOLE = "I'm pretty sure mole isn't the actual ingredient...",
		MONSTERMEAT = "Why would you eat this, though...",
		MONSTERMEAT_DRIED = "Will this still kill you...?",
		MOOSE = "Wuuuh~! Now it's a giant duck~!",
		MOOSE_NESTING_GROUND = "The nest must be gigantic as well, of course~",
		MOOSEEGG = "Huge egg for huge ducks~",
		MOSSLING = "It's super fluffy~! And dangerous~!",
		FEATHERFAN = "I wanna fly with this~",
        MINIFAN = "Keep running to keep the engine moving~",
		GOOSE_FEATHER = "This is some large feather~",
		STAFF_TORNADO = "Click this button to summon a tornado~",
		MOSQUITO =
		{
			GENERIC = "Ech... I hate mosquitos...",
			HELD = "I just want to slap this cheeky guy...",
		},
		MOSQUITOSACK = "Full of blood with various blood type~",
		MOUND =
		{
			DUG = "I'm sorry, mole-san!",
			GENERIC = "It's a treasure trove for something, nanodesu!",
		},
		NIGHTLIGHT = "Doesn't looks so good...",
		NIGHTMAREFUEL = "What... is this... thing...?",
		NIGHTSWORD = "Sword made from... dark things...",
		NITRE = "Essential for gunpowder~",
		ONEMANBAND = "G11 personal alarm~!",
		OASISLAKE = "Oasis inside a desert~",
		PANDORASCHEST = "This is gacha box~",
		PANFLUTE = "Magically put everything to sleep~",
		PAPYRUS = "Some paper sheets~",
        WAXPAPER = "Waterproof papers~",
		PENGUIN = "Hahaha~ Are they going to sing and dance?",
		PERD = "Some quicky cheeky chiken~!",
		PEROGIES = "This varenyky smells so good~",
		PETALS = "Flower taken from its main source~",
		PETALS_EVIL = "These things doesn't look... okay...",
		PHLEGM = "Ca we just... Ah...! My clothes!",
		PICKAXE = "Destroying boulder is now easier~",
		PIGGYBACK = "Pretty spacy, and heavy...~",
		PIGHEAD = 
		{	
			GENERIC = "This is some twisted up civilization...",
			BURNT = "It's all burnt...",
		},
		PIGHOUSE =
		{
			FULL = "He's inside his comfy house~",
			GENERIC = "This is those pig guys' houses~",
			LIGHTSOUT = "Haha~ You can't fool me~",
			BURNT = "It's all burnt...",
		},
		PIGKING = "I bet he's not even as strong as the other pig~",
		PIGMAN =
		{
			DEAD = "Oh no, he's dying...",
			FOLLOWER = "He's as friendly as I thought~!",
			GENERIC = "Some pig guy doing what human is supposed to do~",
			GUARD = "This one doesn't look so friendly...",
			WEREPIG = "Werepigman! Run away~!",
		},
		PIGSKIN = "His tail is still there...",
		PIGTENT = "It's just some rubbery tent~",
		PIGTORCH = "Haha~ The totem looks so stupid~",
		PINECONE = "We need to plant a fresh one~",
        PINECONE_SAPLING = "It's still growing slowly~",
        LUMPY_SAPLING = "It's still growing slowly~",
		PITCHFORK = "It's a tool for farming~ Supposedly~",
		PLANTMEAT = "Is this meat for the vegans?",
		PLANTMEAT_COOKED = "It doesn't smell like a grilled meat...",
		PLANT_NORMAL =
		{
			GENERIC = "It's a simple plant~",
			GROWING = "It's still growing slowly~",
			READY = "It's harvest moon~!",
			WITHERED = "It's too hot to grow...",
		},
		POMEGRANATE = "It's a small pomegranate fruit~",
		POMEGRANATE_COOKED = "One way to serve it, I guess?",
		POMEGRANATE_SEEDS = "It's a pomegranate seed~",
		POND = "Small pond with fish and frogs~",
		POOP = "Despite the smell... ugh... It's usefull...~",
		--PORTABLECOOKPOT_ITEM = "Now we're cookin'!",
		FERTILIZER = "A bucket full of healthy poop~",
		PUMPKIN = "It's a big pumpkin~",
		PUMPKINCOOKIE = "It's a treat for halloween~",
		PUMPKIN_COOKED = "The case acts as a pot~",
		PUMPKIN_LANTERN = "Spooky pumpkin lamp~",
		PUMPKIN_SEEDS = "It's a pumpkin seed~",
		PURPLEAMULET = "Who... Who's there!?",
		PURPLEGEM = "It's full of that magic thingy...",
		RABBIT =
		{
			GENERIC = "He's walking around cutely~",
			HELD = "Aww, don't be scared~ I just want to play with you~",
		},
		RABBITHOLE = 
		{
			GENERIC = "Does rabbit hole lead you to another world~?",
			SPRING = "It's closed for the season~",
		},
		RAINOMETER = 
		{	
			GENERIC = "So we can anticipate the rain~",
			BURNT = "It's all burnt...",
		},
		RAINCOAT = "We can go out without getting wet~",
		RAINHAT = "To protect our head from the rain~",
		RATATOUILLE = "Vegan party~!",
		RAZOR = "Dolls won't grow beard though...~",
		REDGEM = "It radiates some heat...~",
		RED_CAP = "It's a funny looking red mushroom~",
		RED_CAP_COOKED = "It's not tasty...",
		RED_MUSHROOM =
		{
			GENERIC = "It's a funny looking red mushroom~",
			INGROUND = "It's sleeping~",
			PICKED = "Pretty sure mushroom will grow back~",
		},
		REEDS =
		{
			BURNING = "Whoawhoa! Put the fire out!",
			GENERIC = "It's a muddy reeds~",
			PICKED = "How long does it takes to grow the reeds back?",
		},
        RELIC = 
        {
            GENERIC = "This is some ancient stuff from the old era~",
            BROKEN = "It's broken apart...",
        },
        RUINS_RUBBLE = "Can I try to fix this?",
        RUBBLE = "Fallen rocks~",
		RESEARCHLAB = 
		{	
			GENERIC = "This helps to make new things~!",
			BURNT = "It's all burnt...",
		},
		RESEARCHLAB2 = 
		{
			GENERIC = "Even more new things~!",
			BURNT = "It's all burnt...",
		},
		RESEARCHLAB3 = 
		{
			GENERIC = "Is this some magic trick that Commander tried to show?",
			BURNT = "It's all burnt...",
		},
		RESEARCHLAB4 = 
		{
			GENERIC = "I'm not good with magic... things...",
			BURNT = "It's all burnt...",
		},
		RESURRECTIONSTATUE = 
		{
			GENERIC = "This isn't going to work... unless it's magic...",
			BURNT = "It's all burnt...",
		},		
		RESURRECTIONSTONE = "This amulet is actually moving slowly by itself...",
		ROBIN =
		{
			GENERIC = "Red cute bird~",
			HELD = "Haha~ He's still shaking~",
		},
		ROBIN_WINTER =
		{
			GENERIC = "It's a beautiful winter bird~!",
			HELD = "Wuuuh~ He's so soft and cold~!",
		},
		ROBOT_PUPPET = "They're trapped...",
		ROCK_LIGHT =
		{
			GENERIC = "The lava is crusted over~",
			OUT = "It looks like it's going to break...",
			LOW = "It's slowly crusting over~",
			NORMAL = "It's warm~",
		},
		CAVEIN_BOULDER =
        {
            GENERIC = "It looks heavy...",
            RAISED = "I can't reach it, nanodesu!",
        },
		ROCK = "Some rock with minerals inside~",
		PETRIFIED_TREE = "Whu... What happened to the trees?",
		ROCK_PETRIFIED_TREE = "Whu... What happened to the tree?",
		ROCK_PETRIFIED_TREE_OLD = "Whu... What happened to the tree?",
		ROCK_ICE = 
		{
			GENERIC = "Ice, ice baby~",
			MELTED = "It's melting~",
		},
		ROCK_ICE_MELTED = "It's completely melted now~",
		ICE = "This'll make a great addition to our water~",
		ROCKS = "One of the super basic survival material~",
        ROOK = "Charges ahead~",
		ROPE = "A pretty stong rope to tie things~",
		ROTTENEGG = "Oh... It's already rotten...",
		ROYAL_JELLY = "Do I aquire royality by eating this~?",
        JELLYBEAN = "It's super sweet and squishy~",
        SADDLE_BASIC = "We can ride the big guy, now~!",
        SADDLE_RACE = "Made to maintain the highest speed~",
        SADDLE_WAR = "This is made for the cavalary unit~",
        SADDLEHORN = "To take off the saddles~",
        SALTLICK = "To keep the beefalo busy~",
        BRUSH = "Now we can make them beautiful as well~",
		SANITYROCK =
		{
			ACTIVE = "What... is that?",
			INACTIVE = "Wait what was that?",
		},
		SAPLING =
		{
			BURNING = "Whoawhoa! Put the fire out!",
			WITHERED = "They're even dying under this condition...",
			GENERIC = "Thhe thing couldn't grow any longer~",
			PICKED = "How long does it takes to grow the twigs back?",
			DISEASED = "Oh no... we need to remove this one...",
			DISEASING = "Huh? I think I saw some black-ish leaves?",
		},
   		SCARECROW = 
   		{
			GENERIC = "Too bad he's not alive to be my friend~",
			BURNING = "Whoawhoa! Put the fire out!",
			BURNT = "It's all burnt...",
   		},
   		SCULPTINGTABLE=
   		{
			EMPTY = "We can sculpt some cool statues~!",
			BLOCK = "It's ready to sculpt to great statues~!",
			SCULPTURE = "Mmhm~ Perfect~!",
			BURNT = "It's all burnt...",
   		},
        SCULPTURE_KNIGHTHEAD = "is that a horse head?",
		SCULPTURE_KNIGHTBODY = 
		{
			COVERED = "I think this isn't how it looks like...",
			UNCOVERED = "It's still missing something, though...",
			FINISHED = "All up and good~!",
			READY = "Whoawhoa! The magic... thing... is definitely there!",
		},
        SCULPTURE_BISHOPHEAD = "What kind of head is this?",
		SCULPTURE_BISHOPBODY = 
		{
			COVERED = "The statue is definitely deformed due to its old age~",
			UNCOVERED = "It's still missing something, though...",
			FINISHED = "All up and good~",
			READY = "Whoawhoa! The magic... thing... is definitely there!",
		},
        SCULPTURE_ROOKNOSE = "Is this just some chunk of marble?",
		SCULPTURE_ROOKBODY = 
		{
			COVERED = "It looks like a chunk of deformed marble sculpture~",
			UNCOVERED = "It's still missing something, though...",
			FINISHED = "All up and good~",
			READY = "Whoawhoa! The magic... thing.. is definitely there!",
		},
        GARGOYLE_HOUND = "The wolf is turning to stone...",
        GARGOYLE_WEREPIG = "The pigs is also turning to stone...",
		SEEDS = "What kind of seed is this~?",
		SEEDS_COOKED = "Now it's just some kind of small snack~",
		SEWING_KIT = "I can fix your torn clothes~!",
		SHOVEL = "My favorite multitool~!",
		SILK = "This is some sturdy material for various clothing~!",
		SKELETON = "Too bad they can't survive...",
		SCORCHED_SKELETON = "The worst way of dying...",
		SKULLCHEST = "That's a bit concerning...",
		SMALLBIRD =
		{
			GENERIC = "Haha~ It's so cute when it's still small~",
			HUNGRY = "I think it's time for food~",
			STARVING = "She's starving! I need to get her food!",
		},
		SMALLMEAT = "Small chunk of meat from smaller animal~",
		SMALLMEAT_DRIED = "Savor the flavor bit by bit~",
		SPAT = "Isn't he kind of sick?",
		SPEAR = "Very primitive weapon that just works~",
		SPEAR_WATHGRITHR = "Oooh~ Some aesthetic spear she did~",
		WATHGRITHRHAT = "This helmet looks menacing indeed~",
		SPIDER =
		{
			DEAD = "Byebye~",
			GENERIC = "Giant spiders inbound~",
			SLEEPING = "We still need to be careful, though~",
		},
		SPIDERDEN = "All those spider-y things inside...~",
		SPIDEREGGSACK = "Don't you think we need to throw this out?",
		SPIDERGLAND = "This has some medical properties, you know~",
		SPIDERHAT = "This hat is so smelly...",
		SPIDERQUEEN = "Whoawhoa! The lair turned to a creature!",
		SPIDER_WARRIOR =
		{
			DEAD = "Byebye~",
			GENERIC = "That's their trained soldier!",
			SLEEPING = "We still need to be careful, though~",
		},
		SPOILED_FOOD = "We've wasted our precious food...",
        STAGEHAND =
        {
			AWAKE = "What... is... that...",
			HIDING = "I can sense something below this table...",
        },
        STATUE_MARBLE = 
        {
            GENERIC = "That's a nice statue~",
            TYPE1 = "Where did the head go?",
            TYPE2 = "It's a marble vase~",
        },
		STATUEHARP = "Where did the head go, , though?",
		STATUEMAXWELL = "This person looks so fishy...",
		STEELWOOL = "This is an actual steel from a living creature...",
		STINGER = "It's still pretty sharp~",
		STRAWHAT = "I can be a farmer~",
		STUFFEDEGGPLANT = "This is pretty nice stuffed stuff...~",
		--SUNKBOAT = "It's no use out there!",
		SWEATERVEST = "Clothing for the stylish guy~",
		REFLECTIVEVEST = "It gleams in the sun~",
		HAWAIIANSHIRT = "Now we need the sunglasses~",
		TAFFY = "Don't eat too much or you'll damage your teeth~",
		TALLBIRD = "The bird is super territorial~",
		TALLBIRDEGG = "Can we try to hatch the egg~?",
		TALLBIRDEGG_COOKED = "Or maybe we can just eat this~",
		TALLBIRDEGG_CRACKED =
		{
			COLD = "Nope, it's too cold. Gotta stuff this inside my belly~",
			GENERIC = "Wuuuh~ It's start to crack~",
			HOT = "Too hot for the poor baby! Gimme some ice~!",
			LONG = "We gotta need some patience for this baby to be born~",
			SHORT = "Wuuuh~! It's going to hatch!",
		},
		TALLBIRDNEST =
		{
			GENERIC = "That's a pretty big egg!",
			PICKED = "Too bad, I'm some sneaky breeki girl~",
		},
		TEENBIRD =
		{
			GENERIC = "He's start to mature up~!",
			HUNGRY = "It's time for food~!",
			STARVING = "Aaaah! Okay, okay we need some food for him!",
		},
		TELEPORTATO_BASE =
		{
			ACTIVE = "With this I can surely pass through space and time!",
			GENERIC = "This appears to be a nexus to another world!",
			LOCKED = "There's still something missing.",
			PARTIAL = "Soon, the invention will be complete!",
		},
		TELEPORTATO_BOX = "This may control the polarity of the whole universe.",
		TELEPORTATO_CRANK = "Tough enough to handle the most intense experiments.",
		TELEPORTATO_POTATO = "This metal potato contains great and fearful power...",
		TELEPORTATO_RING = "A ring that could focus dimensional energies.",
		TELESTAFF = "This staff radiates some really strong energy...",
		TENT = 
		{
			GENERIC = "Some traditional tent, but at least it's comfortable~",
			BURNT = "It's all burnt...",
		},
		SIESTAHUT = 
		{
			GENERIC = "This place is to chill around when it's too hot~",
			BURNT = "It's all burnt...",
		},
		TENTACLE = "This is some hardcore looking tentacle with spikes~",
		TENTACLESPIKE = "This is sharper than some knives~!",
		TENTACLESPOTS = "What are these for~?",
		TENTACLE_PILLAR = "How big do you think the spike is?",
        TENTACLE_PILLAR_HOLE = "Where does this hole leads to...?",
		TENTACLE_PILLAR_ARM = "It's small tentacles... oh not again...",
		TENTACLE_GARDEN = "A tentacle~",
		TOPHAT = "Top nep~!",
		TORCH = "At least we can stay alert from the danger of night~",
		TRANSISTOR = "I think I have one of these inside my body~",
		TRAP = "It'll trap some simple creatures like rabbit~",
		TRAP_TEETH = "This is some nasty trap indeed~",
		TRAP_TEETH_MAXWELL = "That looks a little too dangerous~",
		TREASURECHEST = 
		{
			GENERIC = "The most essential thing for our base~",
			BURNT = "It's all burnt...",
		},
		TREASURECHEST_TRAP = "Triggering this means something bad...",
		TREECLUMP = "What's this doing here?",
		
		TRINKET_1 = "Can't roll them one by one...", --Melted Marbles
		TRINKET_2 = "The kazoo is totally broken...", --Fake Kazoo
		TRINKET_3 = "The mystery remains~", --Gord's Knot
		TRINKET_4 = "Can we whack this with hammer~?", --Gnome
		TRINKET_5 = "Poland can into space~!", --Toy Rocketship
		TRINKET_6 = "Just some useless junk~", --Frazzled Wires
		TRINKET_7 = "Haha~ This is hard to play~!", --Ball and Cup
		TRINKET_8 = "Now they can't have a nice bath...~", --Rubber Bung
		TRINKET_9 = "This isn't my shirt button~", --Mismatched Buttons
		TRINKET_10 = "These are strange-looking dentures...", --Dentures
		TRINKET_11 = "Good robot don't lie~ Haha~", --Lying Robot
		TRINKET_12 = "I don't want to be a victim of something bad...", --Dessicated Tentacle
		TRINKET_13 = "Can we whack this with hammer~?", --Gnomette
		TRINKET_14 = "Maybe Springfield would like to fix this~", --Leaky Teacup
		TRINKET_15 = "A bishop chesspiece~", --Pawn
		TRINKET_16 = "A bishop chesspiece~", --Pawn
		TRINKET_17 = "I can't bend it back...", --Bent Spork
		TRINKET_18 = "Infidel~! Hahaha~!", --Trojan Horse
		TRINKET_19 = "I think the guys need to nerf this~", --Unbalanced Top
		TRINKET_20 = "Now you can scratch your itchy back easily~", --Backscratcher
		TRINKET_21 = "How are you supposed to use this...?", --Egg Beater
		TRINKET_22 = "Let's give it to the cats~", --Frayed Yarn
		TRINKET_23 = "What is even this?", --Shoehorn
		TRINKET_24 = "Some chinese amulet~", --Lucky Cat Jar
		TRINKET_25 = "Defeats the whole purpose of this...~", --Air Unfreshener
		TRINKET_26 = "Is this some... cup?", --Potato Cup
		TRINKET_27 = "Aha~! I can wash my clothes easily now~", --Coat Hanger
		TRINKET_28 = "A rook chesspiece~", --Rook
        TRINKET_29 = "A rook chesspiece~", --Rook
        TRINKET_30 = "A knight chesspiece~", --Knight
        TRINKET_31 = "A knight chesspiece~", --Knight
        TRINKET_32 = "What...?", --Cubic Zirconia Ball
        TRINKET_33 = "Now my hands turned to spider~! Haha~!", --Spider Ring
        TRINKET_34 = "This hand is cursed~?", --Monkey Paw
        TRINKET_35 = "This was some magical item~", --Empty Elixir
		TRINKET_36 = "Rawr~! Fear me~ Haha~", --Faux fangs
		TRINKET_37 = "Vampires begone~!", --Broken Stake

		HALLOWEENCANDY_1 = "Ahaha~! Trick or treat~!",
        HALLOWEENCANDY_2 = "Ahaha~! Trick or treat~!",
        HALLOWEENCANDY_3 = "Ahaha~! Trick or treat~!",
        HALLOWEENCANDY_4 = "Ahaha~! Trick or treat~!",
        HALLOWEENCANDY_5 = "Ahaha~! Trick or treat~!",
        HALLOWEENCANDY_6 = "Ahaha~! Trick or treat~!",
        HALLOWEENCANDY_7 = "Ahaha~! Trick or treat~!",
        HALLOWEENCANDY_8 = "Ahaha~! Trick or treat~!",
        HALLOWEENCANDY_9 = "Ahaha~! Trick or treat~!",
        HALLOWEENCANDY_10 = "Ahaha~! Trick or treat~!",
        HALLOWEENCANDY_11 = "Ahaha~! Trick or treat~!",
        CANDYBAG = "t can hold the candies we traded~!",
		
		DRAGONHEADHAT = "I can lead the way, you know~!",
        DRAGONBODYHAT = "let's go~!",
        DRAGONTAILHAT = "I'm going to follow the lead~!",
        PERDSHRINE =
        {
            GENERIC = "It looks like it wants something from me...~",
            EMPTY = "We can put something on it~",
            BURNT = "It's all burnt...",
        },
        REDLANTERN = "Lantern for chinese festival~!",
        LUCKY_GOLDNUGGET = "It's a lucky gold coin~!",
        FIRECRACKERS = "Let's go~! Three, two, one, Fire~!",
        PERDFAN = "That fan's a little big than I thought~",
        REDPOUCH = "You want me to open this thing up~?",

		BISHOP_CHARGE_HIT = "Auuuwauw!",
		TRUNKVEST_SUMMER = "Red puffy clothes~!",
		TRUNKVEST_WINTER = "Blue puffy clothes~!",
		TRUNK_COOKED = "This is super chewy and very meaty~! And tasty~!",
		TRUNK_SUMMER = "The very useful trunk from the elephant~",
		TRUNK_WINTER = "The very useful trunk from the elephant~",
		TUMBLEWEED = "It always have something strange swept with it~",
		TURKEYDINNER = "Whole roasted chicken~!",
		TWIGS = "Small twigs used for various things~",
		UMBRELLA = "Keep us away from the direct hit of rain~",
		GRASS_UMBRELLA = "This isn't working very efficiently...",
		UNIMPLEMENTED = "Whoops, more spoiler alert~",
		WAFFLES = "Delicious Berlin waffle~!",
		WALL_HAY = 
		{	
			GENERIC = "It's just some basic base wall...~",
			BURNT = "It's all burnt...",
		},
		WALL_HAY_ITEM = "We can build the wall wherever we wish~",
		WALL_STONE = "It's a pretty strong wall~",
		WALL_STONE_ITEM = "We can build the wall wherever we wish~",
		WALL_RUINS = "This is super strong wall we have~!",
		WALL_RUINS_ITEM = "We can build the wall wherever we wish~",
		WALL_WOOD = 
		{
			GENERIC = "Keeps the unwanted things away~",
			BURNT = "It's all burnt...",
		},
		WALL_WOOD_ITEM = "We can build the wall wherever we wish~",
		WALL_MOONROCK = "Will this keep us safe from the darkness...?",
		WALL_MOONROCK_ITEM = "We can build the wall wherever we wish~",
		FENCE = "Just some wooden fence~",
        FENCE_ITEM = "We can build the fence wherever we wish~",
        FENCE_GATE = "The entrance to the comfy house~",
        FENCE_GATE_ITEM = "We can build the gate wherever we wish~",
		WALRUS = "He's a very skilled hunter~!",
		WALRUSHAT = "Looks sillier than HK416's beret~",
		WALRUS_CAMP =
		{
			EMPTY = "Home without the owner inside~",
			GENERIC = "Aha, he's inside his home~",
		},
		WALRUS_TUSK = "This tusk is pretty hard and rugged~",
		WARDROBE = 
		{
			GENERIC = "Let's change our outfit to something cuter~!",
            BURNING = "Whoawhoa! Put the fire out!",
			BURNT = "It's all burnt...",
		},
		WARG = "I... think we hunt the wrong guy...",
		WASPHIVE = "These are the bees military camp~",
		WATERBALLOON = "Can put the fire out without taking any risk~!",
		WATERMELON = "It's a large watermelon~",
		WATERMELON_COOKED = "It's turning into warm juice~",
		WATERMELONHAT = "It's going to wreck my hairs...",
		WAXWELLJOURNAL = "I... don't think I should read this...",
		WETGOOP = "Hehe... Failed attempt... Sorry...~",
        WHIP = "Now I'm the S~! Myahaha~!",
		WINTERHAT = "Pretty warm and comfy for the whole winter~",
		WINTEROMETER = 
		{
			GENERIC = "It can read the temperature around~",
			BURNT = "It's all burnt...",
		},

        WINTER_TREE =
        {
            BURNT = "it's all burnt...",
            BURNING = "Whoawhoa! Put the fire out!",
            CANDECORATE = "We wish you Merry Christmas~!",
            YOUNG = "It's still growing slowly~",
        },
		WINTER_TREESTAND = 
		{
			GENERIC = "Now we need the pine tree~",
            BURNT = "It's all burnt...",
		},
        WINTER_ORNAMENT = "Some nice decoration we have here~",
        WINTER_ORNAMENTLIGHT = "Lights to lighten up the mood~!",
        WINTER_ORNAMENTBOSS = "Wuuuh~! This is some cool ornament~!",

        WINTER_FOOD1 = "Sweet bread guy~", --gingerbread cookie
        WINTER_FOOD2 = "I like sweet cookies~ Hehe~", --sugar cookie
        WINTER_FOOD3 = "I'd like to chew down the candy~", --candy cane
        WINTER_FOOD4 = "Is this... supposed to be edible?", --fruitcake
        WINTER_FOOD5 = "It's a log from the heavens~", --yule log cake
        WINTER_FOOD6 = "It's some delish pudding~", --plum pudding
        WINTER_FOOD7 = "Sweet apple cider~", --apple cider
        WINTER_FOOD8 = "It's warm and tastes super great~!", --hot cocoa
        WINTER_FOOD9 = "Yummy~! I like milks products~!", --eggnog

        KLAUS = "Whu... Is that supposed to be Santa...?",
        KLAUS_SACK = "Oh...? How careless the guy who left this~",
		KLAUSSACKKEY = "Is this a... key?",
		WORMHOLE =
		{
			GENERIC = "Bad idea. Really bad idea...",
			OPEN = "Still a bad idea. I don't want to...",
		},
		WORMHOLE_LIMITED = "This one doesn't look healthy...",
		ACCOMPLISHMENT_SHRINE = "Let's complete all of them!",        
		LIVINGTREE = "Wuuuh~ The tree got a face~!",
		ICESTAFF = "It shoots icicle particles~!",
		REVIVER = "Live on!",
		SHADOWHEART = "Whose heart is this...?",
		ATRIUM_RUBBLE = 
        {
			LINE_1 = "The people looks starving and trying to eat... dirt... so sad...",
			LINE_2 = "The picture is a bit blurry...",
			LINE_3 = "The darkness is... creeping to the town...",
			LINE_4 = "Why...!? Why are they skinning themselves!?",
			LINE_5 = "Wuuuh~ This is even advanced than GNK or Lab.16~!",
		},
        ATRIUM_STATUE = "That statue gave me chills... I don't like this...",
        ATRIUM_LIGHT = 
        {
			ON = "This... light is making me... sick...",
			OFF = "No power generator around~",
		},
        ATRIUM_GATE =
        {
			ON = "The gateway to the new world is open~",
			OFF = "This thing could work?",
			CHARGING = "It's recharging~",
			DESTABILIZING = "Whoawhoa! It's falling apart!",
			COOLDOWN = "The gate still can't be activated for the time being~",
        },
        ATRIUM_KEY = "This is some cool looking key~",
		LIFEINJECTOR = "You're sick? Let me stab this to your but~ Haha~",
		SKELETON_PLAYER =
		{
			MALE = "Oh no, %s was killed by %s...",
			FEMALE = "Oh no, %s was killed by %s...",
			ROBOT = "Oh no, %s was killed by %s...",
			DEFAULT = "Oh no, %s was killed by %s...",
		},
		HUMANMEAT = "I... don't want to touch that...",
		HUMANMEAT_COOKED = "This still count as cannibalism, you know...",
		HUMANMEAT_DRIED = "Nope, nope, nope, nope. Not going to eat that...",
		ROCK_MOON = "Rock fell from the sky~",
		MOONROCKNUGGET = "A chunk of moon material~",
		MOONROCKCRATER = "Curiously there's a slot here~",

        REDMOONEYE = "The red marker will mark our way~",
        PURPLEMOONEYE = "The purple marker will mark our way~",
        GREENMOONEYE = "The green marker will mark our way~",
        ORANGEMOONEYE = "The orange marker will mark our way~",
        YELLOWMOONEYE = "The yellow marker will mark our way~",
        BLUEMOONEYE = "The blue marker will mark our way~",
        
	},
	DESCRIBE_GENERIC = "It's not inside my database...",
	DESCRIBE_TOODARK = "I can't see quite clearly there...~",
	DESCRIBE_SMOLDERING = "Whoawhoa! It's start to burn!",
	EAT_FOOD =
	{
		TALLBIRDEGG_CRACKED = "Yum~!",
	},
}
