-- Runtime config stuff
MagLib.disableNav = false
MagLib.disableStats = false
MagLib.disableLogging = false

--- Configuring MagLib from settings table.
-- You can disable specific MagLib parts with this function.
---@param config the config table
-- @usage
-- local config = {
--  --Modules
--  disableInputModule = false, --Will make all MagLib.Input functionalities stop working
--  disableRegionObserver = false, --Will deactivate the "SwitchedRegion" event handling
--  disableActionSequenceManagerModule = false, --Will deactivate the ActionSequenceManager, resulting in the ActionSystem not working
--  disableNavigationD2DModule = false, --Will deactivate the Navigations Rendering
--  disableSettingsModule = false, --Will disable all settings autosave functionalities.
--
--  --Navigation
--  disableNavigationSystem = false, --Will result in the nav system of MagLib not working.
--
--  --Stats
--  disableStatKeeping = false, --Will disable all performance stat checking.
--
--  --Logging
--  disableLogging = false --Will disable logging
-- }
-- MagLib.configure(config)

function MagLib.configure(config)
	-- Module disable
	if config.disableInputModule then
		local module = MagLib.Run.Modules.Handler.getModule("Input Manager")
		if module then
			module:stop()
		end
	end

	if config.disableRegionObserver then
		local module = MagLib.Run.Modules.Handler.getModule("Region Observer")
		if module then
			module:stop()
		end
	end

	if config.disableActionSequenceManagerModule then
		local module = MagLib.Run.Modules.Handler.getModule("ActionSequenceManager")
		if module then
			module:stop()
		end
	end

	if config.disableNavigationD2DModule then
		local module = MagLib.Run.Modules.Handler.getModule("MagLib_Navigation_RenderModule Updater Module")
		if module then
			module:stop()
		end

		MagLib.RenderManager.removeModule(MagLib.BDO.Navigation.Graph.RenderD2D.renderModule)
	end

	if config.disableSettingsModule then
		local module = MagLib.Run.Modules.Handler.getModule("Settings Updater")
		if module then
			module:stop()
		end
	end

	-- Navigation
	if config.disableNavigationSystem then
		MagLib.disableNav = true
	end

	-- Stats
	if config.disableStatKeeping then
		MagLib.disableStats = true
	end

	-- Logging
	if config.disableLogging then
		MagLib.disableLogging = true
	end
end
