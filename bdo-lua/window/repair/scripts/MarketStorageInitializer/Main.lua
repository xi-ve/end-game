local config = {
	-- Modules
	disableInputModule = true, -- Will make all MagLib.Input functionalities stop working
	disableActionSequenceManagerModule = true, -- Will deactivate the ActionSequenceManager, resulting in the ActionSystem not working
	disableNavigationD2DModule = true, -- Will deactivate the Navigations Rendering
	disableSettingsModule = true, -- Will disable all settings autosave functionalities.

	-- Navigation
	disableNavigationSystem = true, -- Will result in the nav system of MagLib not working.

	-- Stats
	disableStatKeeping = true, -- Will disable all performance stat checking.

	-- Logging
	disableLogging = true -- Will disable logging
}

MagLib.configure(config)

local closeAll = function()
	MagLib.BDO.Warehouse.closePanel()
	MagLib.BDO.Marketplace.close()
end

local initAll = function()
	MagLib.BDO.Warehouse.openFromMaid()
	MagLib.BDO.Marketplace.open_fromWorldmap()
	MagLib.Run.Tasks.newDelayed("Close Market and Storage DelayedTask", 3000, closeAll, 750)
end

MagLib.Events.addEventHandler("LuaLoaded", initAll)
MagLib.Events.addEventHandler("SwitchedRegion", initAll)

local function onPulse()
	if MagLib.onPulse_Beginning() then
		return
	end

	MagLib.onPulse_End()
end

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", onPulse)

-- initial start
initAll()
