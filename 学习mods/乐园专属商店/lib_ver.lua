_version = "1.05"
_G=GLOBAL
if _silence == nil then
	print(_version,modinfo.name) --Show current version of lib
end

--This is mini module for not executing library twice.

mods=_G.rawget(_G,"mods")
if not mods then
	mods={}
	_G.rawset(_G,"mods",mods)
end

if mods.lib and mods.lib.version >= _version then --Only if needed.
	--print(modinfo.name..": Using existing lib... "..mods.lib.version)
else
	--print(modinfo.name..": Initializing the lib... ".._version,mods.lib and "(old: "..mods.lib.version..")")
	modimport "lib_fn.lua"
	mods.lib.version = _version
end
	
mods.lib.ExportLib(env)
	