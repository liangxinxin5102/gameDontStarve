name = "储藏室（地窖）"
version = "2.1b.h.0.2"
--thanks Some1
desc_variant = {en = "建造一个更大的储存空间！\n或者你可以设置为一个超大的冰箱\n还可以设置为永久保鲜、食物反鲜等\n本MOD由Anydong汉化并添加食物反鲜功能\n如有使用问题请及时联系QQ506557256"..version,
		ru = "Твоё личное пространство.\nВерсия мода: "..version}
description = desc_variant[language] or desc_variant["en"]

author = "MrM Anydong汉化更改"
forumthread = ""
api_version = 10

all_clients_require_mod = true
client_only_mod = false
dst_compatible = true

server_filter_tags = {"storeroom"}

icon_atlas = "storeroom.xml"
icon = "storeroom.tex"
----------------------

local russian = language == "ru"

configuration_options =
{
	{
		name = "Craft",
		label = russian and "Создание" or "建造难度",
		hover = "设置建造难度，默认为正常",
		options =
	{
		{description = russian and "Лёгкое" or "简单", data = "Easy"},
		{description = russian and "Нормальное" or "正常", data = "Normal"},
		{description = russian and "Сложное" or "困难", data = "Hard"},
	},
		default = "Normal",
	},

	{
		name = "Slots",
		label = russian and "Слоты" or "格子数量",
		hover = "设置建造储藏室格子的数量，默认为80格",
		options =
	{
		{description = "20", data = 20},
		{description = "40", data = 40},
		{description = "60", data = 60},
		{description = "80", data = 80},
	},
		default = 80,
	},

	{
		name = "Position",
		label = russian and "Позиция" or "显示位置",
		hover = "设置开箱格子显示的位置，默认为居中",
		options =
	{
		{description = russian and "Слева" or "靠左", data = "Left"},
		{description = russian and "По центру" or "居中", data = "Center"},
	},
		default = "Center",
	},

	{
		name = "Destroyable",
		label = russian and "Разрушаемость" or "是否可破坏",
		hover = "设置储存室是否可破坏，默认为可破坏",
		options =
	{
		{description = russian and "Включена" or "可破坏", data = "yees"},
		{description = russian and "Выключена" or "不可破坏", data = "noo"},
	},
		default = "yees",
	},
	{
		name = "FoodSpoilage",
		label = russian and "Порча еды" or "食物保鲜",
		options =
	{
		{description = russian and "Обычно" or "正常腐烂", data = 1, hover = "正常类似放入背包一样腐烂"},
		{description = russian and "Немного медленней" or "慢点腐烂", data = 0.85, hover = russian and "Немного медленней" or "腐烂速度慢点"},
		{description = russian and "Как зимой" or "冬季保鲜", data = 0.75, hover = "腐烂速度等于冬季腐烂速度"},
		{description = russian and "Как в холодильнике" or "冰箱保鲜", data = 0.5, hover = russian and "Как в холодильнике" or "与冰箱的保鲜相同"},
		{description = russian and "Лучше чем в холодильнике" or "大于冰箱", data = 0.25, hover = russian and "Лучше чем в холодильнике" or "比冰箱保鲜更持久"},
		{description = russian and "Не портится" or "永久保鲜", data = 0, hover = russian and "Сохраняйте спокойствие и смотрите на гниение" or "放入食物永远不会腐烂"},
		{description = russian and "обратная свежие" or "食物反鲜并保鲜", data = -10, hover = russian and "Сохраняйте спокойствие и смотрите на гниение" or "快腐烂的食物放入后会返回最保鲜的状态，并且永远不会腐烂"},
		{description = russian and "ВТФ?!??" or "立刻腐烂", data = 999, hover = russian and "Сохраняйте спокойствие и смотрите на гниение" or "放入食物你就静静的看着它腐烂"},
	},
		default = 1,
	},
	{
		name = "Language",
		label = russian and "Язык" or "语言设置",
		options =
	{
		{description = russian and "Русский" or "简体中文", data = "En"},
		{description = "Francais", data = "Fr"},
		{description = "German", data = "Gr"},
		{description = "Portuguese", data = "Pr"},
		{description = "Swedish", data = "Sw"},
		{description = "Turkish", data = "Tr"},
	},
		default = "En",
	},
}
