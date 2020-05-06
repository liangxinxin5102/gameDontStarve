local assets =
{
	Asset( "ANIM", "anim/nine.zip" ),
	Asset( "ANIM", "anim/ghost_nine_build.zip" ),
}

local skins =
{
	normal_skin = "nine",
	ghost_skin = "ghost_nine_build",
}

local base_prefab = "nine"

local tags = {"NINE", "NINE"}

return CreatePrefabSkin("nine_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})