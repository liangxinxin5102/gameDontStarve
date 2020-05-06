local assets =
{
	Asset( "ANIM", "anim/esctemplate.zip" ),
	Asset( "ANIM", "anim/ghost_esctemplate_build.zip" ),
}

local skins =
{
	normal_skin = "esctemplate",
	ghost_skin = "ghost_esctemplate_build",
}

local base_prefab = "esctemplate"

local tags = {"BASE" ,"ESCTEMPLATE", "CHARACTER"}

return CreatePrefabSkin("esctemplate_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	skin_tags = tags,
	
	build_name_override = "esctemplate",
	rarity = "Character",
})