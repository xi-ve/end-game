local Worldmap = {}

---Returns if the worldmap is currently openend
---@return boolean true if the worldmap is open
Worldmap.isOpen = function()
	return Infinity.BDO.Lua.Execute("return ToClient_WorldMapIsShow()")
end

MagLib.BDO.Worldmap = Worldmap
