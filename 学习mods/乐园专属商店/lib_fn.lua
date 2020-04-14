
if _silence == nil then
	print(_version,modinfo.name) 
end

local old_lib = mods.lib or {} 

if old_lib._libStopWorking then
	old_lib._libStopWorking()
end

local IS_ACTIVE = true 
local function _libStopWorking()
	IS_ACTIVE = nil
end

local function GetGlobal(gname,default)
	local res=_G.rawget(_G,gname)
	if res == nil and default ~= nil then
		_G.rawset(_G,gname,default)
		return default
	else
		return res
	end
end

if not mods.player_preinit_fns then
	mods.player_preinit_fns={}
	local old_MakePlayerCharacter = _G.require("prefabs/player_common")
	local function new_MakePlayerCharacter(...)
		local inst=old_MakePlayerCharacter(...)
		for _,v in ipairs(mods.player_preinit_fns) do
			v(inst)
		end
		return inst
	end
	_G.package.loaded["prefabs/player_common"] = new_MakePlayerCharacter
end

function AddPlayersPreInit(fn)
	table.insert(mods.player_preinit_fns,fn)
end

local player_postinit_fns = {}
function AddPlayersPostInit(fn) -- <<<--------- Вот она!
	table.insert(player_postinit_fns,fn)
end

local done_players = {}
AddPlayersPreInit(function(inst)
	local s = inst.prefab or inst.name
	if not done_players[s] then
		done_players[s] = true
		AddPrefabPostInit(s,function(inst)
			for _,v in ipairs(player_postinit_fns) do
				v(inst)
			end
		end)
	end
end)

local player_afterinit_fns = {}
function AddPlayersAfterInit(fn) --Нулевой таймер после
	table.insert(player_afterinit_fns,fn)
end
AddPlayersPostInit(function(inst) --Задаем нулевой таймер
	if #player_afterinit_fns > 0 then
		inst:DoTaskInTime(0,function(inst)
			for i=1,#player_afterinit_fns do
				player_afterinit_fns[i](inst)
			end
		end)
	end
end)


--Инициализация мира (совместимость со всеми известными ветками ДСТ)
--(переменная mods должна быть уже определена в lib_ver)
local world_init_fns = {} --old_lib.world_init_fns or {} --Нет
--Нет, нам нельзя ссылаться на старую либу, иначе это породит многократную инициализацию.
--Ничего страшного. Старый инициализатор проинициализирует старые функции, а новый - новые.

local function AddWorldPostInit(fn) --> Добавляет функцию в список функций для инициализации мира.
	table.insert(world_init_fns,fn)
end
local was_forest
local function world_init(inst) --> Собственно сама функция инициализации.
	if was_forest then
		return
	end
	was_forest = true
	for i=1,#world_init_fns do
		world_init_fns[i](inst)
	end
end
AddPrefabPostInit("world",world_init)
--AddPrefabPostInit("forest",world_init)
--По большому счету это рудимент, т.к. история с forest закончилась.


--Пустая функция. Иногда нужно заткнуть кого-то или что-то, чтоб они думали, что продолжают делать что-то важное.
local EmptyFunction = function() end
--переменная mods должна быть уже определена в lib_ver
local static = old_lib.static or {} --Таблица с неизменными функциями (которые нельзя инициализировать дважды).
--jj: А такие есть?

--Список пространств имен модов, которые заюзали библиотеку. Нужно для инициализации TheWorld
local _mods = old_lib._mods or {}


local TheSim=_G.TheSim
local TheNet=_G.TheNet
local require=_G.require
local SpawnPrefab=_G.SpawnPrefab
local p=GetGlobal("p",EmptyFunction) --import from Cheats
local arr=GetGlobal("arr",EmptyFunction) --import from Cheats
local SetSharedLootTable=_G.SetSharedLootTable
local Vector3=_G.Vector3
local SEASONS = _G.SEASONS
local FUELTYPE = _G.FUELTYPE
local ACTIONS = _G.ACTIONS
local GetTime = _G.GetTime
local AllPlayers = _G.AllPlayers

--Базовые (библиотечные) вспомогательные функции для эффективного перехвата

--Получить указатель на функция из WatchWorldState
-- inst - префаб, у которого тырим функцию. event - имя события. num по умолчанию 0 - глубина вытягивания.
--Следует помнить, что функция основана на порядке добавления в массив и должна вызываться сразу после изменений массива функций.
local function GetWatchWorldStateFn(inst,event,num)
	num = num or 0
	local w = inst.worldstatewatching
	if w and w[event] then
		local count = #w[event] - num
		if count > 0 then
			local fn = w[event][count] --Берём последнюю, т.к. скорее всего это она. Ну или будет фигово.
			return fn, w[event], count
		end
	end
	return EmptyFunction, false
end
--Проверку корректности можно осуществлять путем сравнения с EmptyFunction, но это нужно редко.


--Вытянуть (вернуть) функцию после ListenForEvent
local function GetListener(inst,event,source,offset) --аналогично предыдущей функции
	--source - источник (проблем). То, что указывается в листенере при добавлении. Важно знать (если он указан вообще).
	source = source or inst
	offset = offset or 0
	local w = inst.event_listeners --event_listening --Напоминаю, что у источника есть "event_listeners"
	--arr(w)
	if w and w[event] then
		local fns = w[event][source]
		if fns ~= nil then
			if offset == -1 and #fns > 0 then
				return fns[1], fns, 1 --заработает в версии 1.06
			elseif #fns > offset then
				local fn = fns[#fns-offset]
				return fn, fns, (#fns-offset)
			end
		end
	end
	return EmptyFunction, false
end


--Эти две функции необходимы для перехвата последнего добавленного таймера у префаба.
--Если в конструкторе префаба более одного таймера, то результат НЕ ОПРЕДЕЛЕН!
local saved_timers
local function SaveTimers(inst)
	saved_tasks = {}
	if inst.pendingtasks then
		for k,v in pairs(inst.pendingtasks) do
			saved_tasks[k]=true
		end
	end
end

local function GetLastTimer(inst)
	if inst.pendingtasks then
		for k,v in pairs(inst.pendingtasks) do
			if not saved_tasks[k] then
				return k
			end
		end
	end
end

local function GetLastTimerFn(inst)
	local timer = GetLastTimer(inst)
	return timer and timer.fn
end

--Добавляет хук на последний таймер в конструкторе компонента (ваще жесть).
--Хук срабатывает ПОСЛЕ функции таймера.
local function AddHookOnLastTask(component_name, new_fn)
	local comp = require("components/"..component_name)
	local old_ctor = comp._ctor
	local old_fn
	function comp._ctor(self, inst, ...)
		SaveTimers(inst)
		old_ctor(self, inst, ...)
		local task = GetLastTimer(inst)
		old_fn = task.fn
		task.fn = function(...)
			old_fn(...)
			new_fn(...)
		end
	end
end

--Добавить две функции: до и после конструктора компонента
local function AddHookOnComponent(component_name, before_fn, after_fn)
	local comp = require("components/"..component_name)
	local old_ctor = comp._ctor
	function comp._ctor(self, inst, ...)
		if before_fn then
			before_fn(self,inst,old_ctor)
		end
		local res = old_ctor(self, inst, ...)
		if after_fn then
			after_fn(self,inst,old_ctor)
		end
		return res
	end
end

--our naming conventions aren't completely consistent, sadly
local cook_aliases=
{
	cookedsmallmeat = "smallmeat_cooked",
	cookedmonstermeat = "monstermeat_cooked",
	cookedmeat = "meat_cooked"
}
local cooking = require("cooking")
local ingredients = cooking.ingredients
local function GetTags(prefab) --Возвращает значение из казана
	if cook_aliases[prefab] and not ingredients[prefab] then
		prefab = cook_aliases[prefab] --Костыль на костыль, однако.
	end
	return ingredients[prefab] and ingredients[prefab].tags or {}
end


--Сохранение и загрузка переменных для игрового мира (в существующем компоненте, который никогда не удалят).
--Например, - birdspawner.
--NB: !!!! Чтобы использовать эти функции, их необходимо обернуть в AddPlayersAfterInit (выполняется в следующий тик после инициализации).
--Свою реализацию следующего тика делать нельзя, т.к. очередность становится неопределенной.
local data_players,w = old_lib.data_players or {}
local SaveOption = function(player,option_name,value)
	player.data_player[option_name] = value
end

local LoadOption = function(player,option_name)
	return player.data_player[option_name]
end

--Получение информации в обход существующей системы. Нужны все дополнительные проверки.
--Нужно для извлечения информации об игроке до захода в мир (при условии, что она была ранее сохранена).
local GetOption = function(userid,option_name)
	return data_players[userid] and data_players[userid][option_name]
end

AddPlayersAfterInit(function(inst) --Создаем глобальную ссылку в самом префабе игрока
	--Первым делом делаем связную ссылку на БД.
	--Этот вызов будет самым первым по отношению ко всем остальным AddPlayersAfterInit.
	local data = data_players[inst.userid] --До "after" не доступен userid
	if not data then --В первый раз
		data = {}
		data_players[inst.userid] = data
	end
	inst.data_player = data -----> Сама привязка игрока к его БД.
end)


--Обновление игроков, когда они сравниваются друг с другом.
--Функционал заморожен до первого обращения к функции регистрации

--Функции обновления игроков.
--Каждая функция принимает на вход 2 параметра - игрок1 и игрок2.
--Массив организован в виде функций-ключей, а значения - это рейндж (в квадрате)
local players_update_fns = {}
local players_update_MAXRANGE = 0 --Квадрат максимального расстояния (чтобы сразу исключить неподходящие пары).

--Инициализирует сам апдейт (вызывается только 1 раз при первом вызове регистрации)
local function InitializePlayersUpdate()
	--print("InitializePlayersUpdate")
	AddWorldPostInit(function(w)
		--print("My AddWorldPostInit")
		w:DoPeriodicTask(0.5 + math.random()*0.1,function(w)
			--print("upd0")
			if #AllPlayers > 1 then
				--print("upd1")
				local time_now = GetTime()
				for i=1,#AllPlayers-1 do
					local inst1 = AllPlayers[i]
					for j=i+1,#AllPlayers do
						local inst2 = AllPlayers[j]
						local dist = inst1:GetDistanceSqToInst(inst2)
						--print("upd2 = "..tostring(dist).." "..tostring(players_update_MAXRANGE))
						if dist <= players_update_MAXRANGE then --В пределах досягаемости хотя бы одной функции
							for fn,dst in pairs(players_update_fns) do
								if dist <= dst then
									--print("call fn")
									fn(inst1,inst2,dist,time_now)
								end
							end
						end
					end
				end
			end
		end)
	end)
end

--Функция регистрации сравнения игроков.
--range - расстояние между игроками, на котором должна срабатывать функция fn каждые 0.5 сек
--ВАЖНО: Чтобы эта функция (хотя бы один вызов) была вызвана на стадии AddPrefabPostInit, потому что динамически инициировать нельзя.
local function RegisterPlayersUpdate(range,fn)
	--print("RegisterPlayersUpdate")
	if #players_update_fns == 0 then
		InitializePlayersUpdate() --Первичная инициализация (т.к. есть, что обновлять)
	end
	local new_range = range*range
	players_update_fns[fn] = new_range --Сразу возводим в квадрат, чтоб каждый раз не считать.
	if new_range > players_update_MAXRANGE then
		players_update_MAXRANGE = new_range
	end
end

--Возможно, понадобится (хотя пока не ясно, зачем)
local function UnRegisterPlayersUpdate(fn)
	players_update_fns[fn] = nil
end


--Работа с модами. Нужно знать, какие активны в данной сессии.

--mods.active_mods_by_name = {} --Активные моды (ассоциативный массив по НАСТОЯЩЕМУ имени). Инициализируется только по запросу.
local function SearchForModsByName()
	if mods.active_mods_by_name then
		return --Уже проинициализировано. Либо полная несовместимость.
	end
	mods.active_mods_by_name = {}
	if not (_G.KnownModIndex and _G.KnownModIndex.savedata and _G.KnownModIndex.savedata.known_mods) then
		print("ERROR COMMON LIB: Can't find KnownModIndex!")
		return
	end
	for name,mod in pairs(_G.KnownModIndex.savedata.known_mods) do
		if (mod.enabled or mod.temp_enabled or _G.KnownModIndex:IsModForceEnabled(name)) --Мод активен
			and not mod.temp_disabled --И не отключен
		then
			mods.active_mods_by_name[mod.modinfo.name] = true
		end
	end
end


----Мягкое добавление ингредиентов казана.
--local cooking = require("cooking") --Уже есть для GetTags
--Accurate adding of ingredients. No breaking other scales.
local AddIngredientValues = function(names, tags, cancook, candry)
	for _,name in pairs(names) do
		if not ingredients[name] then --No breaking!
			ingredients[name] = { tags= {}}
		end
		if cancook and not ingredients[name.."_cooked"] then --No breaking!
			ingredients[name.."_cooked"] = {tags={}}
		end
		if candry and not ingredients[name.."_dried"] then --No breaking!
			ingredients[name.."_dried"] = {tags={}}
		end
		for k,v in pairs(tags) do
			ingredients[name].tags[k] = v
			if cancook then
				ingredients[name.."_cooked"].tags.precook = 1
				ingredients[name.."_cooked"].tags[k] = v
			end
			if candry then
				ingredients[name.."_dried"].tags.dried = 1
				ingredients[name.."_dried"].tags[k] = v
			end
		end
	end
end



--Меняем стеки для stackable (на самом деле перемещаемся в inventoryitem, там удобнее)
--Необходимо передать две функции: comgine(a,b,num_a,num_b,num_total) и get(new,old,num,num_old).
--Первая - комбинирует два стака (нужно просумирровать всё необходимое).
--Вторая - получает "свежий" префаб new, в который надо перебросить часть свойств из old. Берется num предметов.
local join_fns = {} --Функции присоединения стаков.
local split_fns = {} --Функции разбиения стаков.
local function ImproveStacks() --улучшить стаки.
	--print("ImproveStacks")
	if mods.improved_stacks ~= nil then --Берем старые ссылки. Ссылки всегда наследуются.
		--print("existing improved_stacks")
		join_fns = mods.improved_stacks.join_fns
		split_fns = mods.improved_stacks.split_fns --используем существующие массивы.
		return
	end
	mods.improved_stacks = {join_fns=join_fns,split_fns=split_fns} --print("init mods.improved_stacks")
	local comp_it = require "components/inventoryitem"
	
	local old_DiluteMoisture = comp_it.DiluteMoisture
	function comp_it:DiluteMoisture(item, count,...) --item будет удален (скорее всего, но не факт) после объединения.
		--print("Custom DiluteMoisture")
		--У нас есть ссылка на item и количество присоединяемых. Проще простого!
		--Базовая вещь - inst.self
		if IS_ACTIVE and item.components.stackable ~= nil then
			local stack1,stack2 = self.inst.components.stackable.stacksize, item.components.stackable.stacksize --Размеры стаков.
			local new_total = stack1 + stack2 --Новый размер стака
			for i,fn in ipairs(join_fns) do
				--print("Calling custom fn...")
				fn(self.inst,item,stack1,stack2,new_total) --объединяем свойства.
			end
		end
		return old_DiluteMoisture(self,item, count,...)
	end
	
	--local old_InheritMoisture --А вот это не выйдет. Ссылки сюдла не передаются.
	--придется инжектится в Stackable:Get(num)
	
	local comp_stack = require "components/stackable"
	local old_Get = comp_stack.Get
	function comp_stack:Get(num,...) --item will be retured. And self.inst probably removed...
		--print("Custom Get")
		local item = old_Get(self,num,...) --формируем вещь старым способом. Получаем ссылку на нее!
		--Обрабатываем новую ссылку.
		--item.components.stackable --100% exists!
		if IS_ACTIVE and item ~= self.inst then --Нет смысла, если передается весь стак целиком, без разделения.
			for i,fn in ipairs(split_fns) do
				--print("Calling custom fn...")
				fn(item,self.inst,item.components.stackable.stacksize,self.inst.components.stackable.stacksize) --перекачиваем войства
			end
		end
		return item --И передаем дальше.
	end
end

--fn: comgine(a,b,num_a,num_b,num_total)
--print("Declaring RegisterJoinStacksFn")
local function RegisterJoinStacksFn(fn)
	--print("RegisterJoinStacksFn")
	if mods.improved_stacks == nil then
		--print("improved_stacks == nil")
		ImproveStacks()
	end
	table.insert(join_fns,fn)
end

--fn: get(new,old,num,num_old).
local function RegisterSplitStacksFn(fn)
	if mods.improved_stacks == nil then
		ImproveStacks()
	end
	table.insert(split_fns,fn)
end


--------------------------------------------------------- Q -----------------------------------------------------------------
--Нужно учитывать, что содержимое данной конкретной таблицы будет раскопировано на несколько модов.
local q = {

initialized_by = modinfo.name,

--Простые переменные

world_init_fns = world_init_fns,
AddWorldPostInit = AddWorldPostInit,
GetGlobal=GetGlobal,
EmptyFunction=EmptyFunction,
TheSim=TheSim,
TheNet=TheNet,
require=require,
SpawnPrefab=SpawnPrefab,
p=p,
arr=arr,
SetSharedLootTable=SetSharedLootTable,
Vector3=Vector3,
SEASONS = SEASONS,
FUELTYPE = FUELTYPE,
ACTIONS = ACTIONS,
GetTime = GetTime,
clock = _G.os.clock,
AllPlayers = AllPlayers,
SaveOption = SaveOption,
LoadOption = LoadOption,
GetOption = GetOption,
RegisterPlayersUpdate = RegisterPlayersUpdate,
UnRegisterPlayersUpdate = UnRegisterPlayersUpdate,
data_players = data_players, --Данные игроков в мире. Общие для всех вресих модуля.
_mods = _mods, --моды, также запросившие данную библиотеку (точнее их пространства имен в простом индексированном массиве)
static = static or {
--Статичные переменные и функции. Инициализируются лишь однажды. Использовать придется через ключевое слово static

}, --End of static functions



--Вытягивает локальные переменные из модуля по содержащейся в нем функции.
--member_check - свойство таблицы, чтобы иметь полную уверенность, что это та самая таблица.
FindUpvalue = function(fn, upvalue_name, member_check, no_print)
	local info = _G.debug.getinfo(fn, "u")
	local nups = info and info.nups
	if not nups then return end
	local getupvalue = _G.debug.getupvalue
	local s = ''
	--print("FIND "..upvalue_name.."; nups = "..nups)
	for i = 1, nups do
		local name, val = getupvalue(fn, i)
		s = s .. "\t" .. name .. ": " .. type(val) .. "\n"
		if (name == upvalue_name)
			and ((not member_check) or (type(val)=="table" and val[member_check] ~= nil)) --Надежная проверка
		then
			--print(s.."FOUND "..tostring(val))
			return val, true
		end
	end
	if no_print == nil then
		print("CRITICAL ERROR: Can't find variable "..tostring(upvalue_name).."!")
		print(s)
	end
end,
--Если второе возвращаемое значение nil, то переменная не найдена (иначе она может быть false).
--Также если есть полная уверенность в том, что значение переменной не может быть nil, то можно проверять и первое значение.


--Простая функция инициализации. Совместима с большинством персонажей, ибо их приоритет обычно 0.
--[[AddPlayersPostInitEasy = function(fn)
	for i,v in ipairs(_G.DST_CHARACTERLIST) do
		AddPrefabPostInit(v,fn)
	end
	for i,v in ipairs(_G.MODCHARACTERLIST) do
		AddPrefabPostInit(v,fn)
	end
end,--]]
--Никогда, слышите? Никогда, не используйте этот костыль. Я несколько раз уже наступал на эти грабли, не понимая в чем же дело.


--Только правильный инжект!
AddPlayersPostInit = AddPlayersPostInit,
AddPlayersAfterInit = AddPlayersAfterInit,

--Остальное
GetWatchWorldStateFn = GetWatchWorldStateFn,
GetListener = GetListener,
SaveTimers = SaveTimers,
GetLastTimer = GetLastTimer,
GetLastTimerFn = GetLastTimerFn,
AddHookOnLastTask = AddHookOnLastTask,
AddHookOnComponent = AddHookOnComponent,
GetTags = GetTags,
SearchForModsByName = SearchForModsByName,
AddIngredientValues = AddIngredientValues,
RegisterJoinStacksFn = RegisterJoinStacksFn,
RegisterSplitStacksFn = RegisterSplitStacksFn,
_libStopWorking = _libStopWorking, --возможность отключить инициализацию извне.



--Экспортирует структуру переменных на заданное пространство имен.
--По сути просто копия содержания таблицы.
ExportLib = function(env)
	for k,v in pairs(mods.lib) do
		env[k]=v
	end
	table.insert(_mods,env) --запоминаем пространство имен мода
end,
--По факту вызывается для текущего мода. А также для всех, кто захочет в будущем.


} --конец структуры q
q.q = q --Ссылка на саму себя, чтобы выделить отдельное пространство имен в случае конфликтов.

--Но продолжаем инициализацию
if TheNet:GetIsServer() then
	q.SERVER_SIDE = true
	if TheNet:IsDedicated() then
		--Нельзя использовать GetServerIsDedicated, т.к. это лишь сообщает о сервере, а не о текущей машине.
		--Хотя... Не суть. Все равно же проходим через GetIsServer.
		q.DEDICATED_SIDE = true
	else
		q.CLIENT_SIDE = true --А это оригинальное решение вечной проблемы "ismastersim".
		--Следует использовать только для инициализации сетевых переменных, не совмещая с "return" выходом из префаба!!
	end
elseif TheNet:GetIsClient() then
	q.SERVER_SIDE = false
	q.CLIENT_SIDE = true
	q.ONLY_CLIENT_SIDE = true
end
--Если на экране заставки, или первая загрузка на dedicated, то SERVER_SIDE будет nil (то есть не известно).


--Функции сохранения/загрузки мира
local old_OnSaveWorld
local old_OnLoadWorld
local function new_OnSaveWorld(...)
	local data = old_OnSaveWorld(...)
	data.data_players = w.data_players
    return data
end

function new_OnLoadWorld(self,data)
	if data.data_players then
		w.data_players = data.data_players
		data_players = data.data_players
	end
	return old_OnLoadWorld(self,data)
end



--if not (mods.lib and mods.lib.AddWorldPostInit) then --Делаем только в том случае, если в другом моде не делается то же самое?
--Это было бы глупо! Лучше старый модуль пусть пользуется новым функционалом, чем наоборот.
--Накрайняк пусть все останутся при своих.


--Делаем в любом случае. Накрайняк есть страховка от двойного использования в самой AddWorldPostInit
AddPrefabPostInit("world",function(inst)
	w=inst --Локальная инициализация мира (чтобы работали кое-какие процедуры).
	if IS_ACTIVE == nil then --Опа. Новый модуль смог предложить более крутую версию.
		return --Вот пусть и работает.
	end
	w.data_players = data_players --База данных игроков (долгосрочное общедоступное хранение инфы).
	--Добавляем возможность сохранения/загрузки данных игрока
	if inst.components.worldstate then
		if inst.components.worldstate.OnSave == old_OnSaveWorld then --Защита от дурака, т.е. от меня.
			print("ERROR: worldstate is already patched in the same lib module!")
			return
		end
		old_OnSaveWorld = inst.components.worldstate.OnSave
		old_OnLoadWorld = inst.components.worldstate.OnLoad
		inst.components.worldstate.OnSave = new_OnSaveWorld
		inst.components.worldstate.OnLoad = new_OnLoadWorld
	else
		print("ERROR: no worldstate in TheWorld")
		q.SaveOption = EmptyFunction
		q.LoadOption = EmptyFunction
	end
	--Инициализация пространств имен модов.
	for i,v in ipairs(_mods) do
		v.TheWorld = inst
		v.w = inst
		v.state = inst.state --TheWorld.state
		v.ww = v.state
	end
end)
--Есть небольшая опасность, что в старом моде будут использоваться новые функции. Старый мод привыкнет
--и перестанет работать при отсутствии более нового. Но шансы очень малы, т.к. при обновлении старого
--мода он обязан стать новым и обновить библиотеку.

--Также не пользуемся AddWorldPostInit, потому что это просто рудимент. Если пользоваться, то будут сложности с 1.04


mods.lib = q








