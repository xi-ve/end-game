GatherBuddy = {}
GatherBuddy.version = "0.14.1 Beta"

local settings = {
	-- persistent vars
	persistent_running = false,
	startHotkey = KeyCode_NUMPAD5,
	stopHotkey = KeyCode_NUMPAD6
}
MagLib.Core.Settings.addSettingsToHandler("GatherBuddy", settings)

-- Runtime vars
GatherBuddy.running = false

-- Making sure we are running after AutoLogin script starts if we were running before
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnAutoLoginAutoLoad", function()
	GatherBuddy.running = settings.persistent_running
end)

-- Loading last profile
MagLib.BDO.Navigation.Graph.Profiles.loadLastProfileFromSettings()
-- Loading CombatProfile
MagLib.BDO.Actions.Combat.CombatManager.loadProfile("AutoAttackOnly")

GatherBuddy.logger = MagLib.Core.Log.newLogger("GatherBuddy")
GatherBuddy.start = function()
	if not MagLib.BDO.Navigation.Graph.Profiles.currentProfile then
		GatherBuddy.logger.error("Please select a profile first!")
		return
	end
	-- Setting both running vars
	GatherBuddy.running = true
	settings.persistent_running = true

	GatherBuddy.logger.info("Patching CameraCursorLock!")
	Infinity.BDO.FunctionPatchManager.disableCameraCursorLock()

	MagLib.Events.triggerEvent("GatherBuddyStarted")

	-- Triggering event
	MagLib.Events.triggerEvent("OnBotStart")
end

GatherBuddy.stop = function()
	-- Stoping nav
	MagLib.BDO.Navigation.stop()

	-- Setting both running vars
	GatherBuddy.running = false
	settings.persistent_running = false

	GatherBuddy.logger.info("Reverting patch of CameraCursorLock!")
	Infinity.BDO.FunctionPatchManager.enableCameraCursorLock()

	-- Triggering event
	MagLib.Events.triggerEvent("OnBotStop")
end

local currentStartHotkey = nil
local currentStopHotkey = nil
GatherBuddy.initHotkeys = function()
	if currentStartHotkey then
		MagLib.Hotkeys.removeHotkey(nil, GatherBuddy.start)
	end

	if currentStopHotkey then
		MagLib.Hotkeys.removeHotkey(nil, GatherBuddy.stop)
	end

	if settings.startHotkey == settings.stopHotkey then
		GatherBuddy.logger.error("Start hotkey cannot be same as stop hotkey. Hotkeys will not work!")
		currentStartHotkey = nil
		currentStopHotkey = nil
		return
	end

	MagLib.Hotkeys.addHotkey(settings.startHotkey, GatherBuddy.start, MagLib.Hotkeys.KeyEvents.OnKeyDown)
	currentStartHotkey = settings.startHotkey

	MagLib.Hotkeys.addHotkey(settings.stopHotkey, GatherBuddy.stop, MagLib.Hotkeys.KeyEvents.OnKeyDown)
	currentStopHotkey = settings.stopHotkey

	GatherBuddy.logger.info("Successfully setup hotkeys!")
end
GatherBuddy.initHotkeys()

local mainStateManager = MagLib.Run.States.StateManager("GatherBuddy MainStateManager", true)
mainStateManager.addState(GatheringState, 1)
mainStateManager.addState(TownrunState, 2)

local onPulse = function()
	if MagLib.onPulse_Beginning() then
		return
	end

	if GatherBuddy.running then
		mainStateManager.run()
	end

	MagLib.onPulse_End()
end
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", onPulse)
