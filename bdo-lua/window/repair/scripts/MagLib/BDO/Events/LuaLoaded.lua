-- Registers Events on loading into the world.
MagLib.Events.addInGameEventHandler("FromClient_luaLoadComplete", function()
	MagLib.Events.triggerEvent("LuaLoaded")
end)

MagLib.Events.addInGameEventHandler("FromClient_luaLoadCompleteLateUpdate", function()
	MagLib.Events.triggerEvent("LuaLoadedLate")
end)
