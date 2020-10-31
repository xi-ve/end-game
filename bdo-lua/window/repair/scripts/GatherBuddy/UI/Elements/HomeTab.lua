local UI = MagLib.UI

DrawHomeTab = function()
	local settings = MagLib.Core.Settings.getSetting("GatherBuddy")
	local changed

	UI.Settings.SettingsProfileSelector(true)

	UI.Separator()

	settings.startHotkey, changed = MagLib.UI.keySelector("Start Hotkey: ", settings.startHotkey, true)
	if changed then
		GatherBuddy.initHotkeys()
	end

	settings.stopHotkey, changed = MagLib.UI.keySelector("Stop Hotkey: ", settings.stopHotkey, true)
	if changed then
		GatherBuddy.initHotkeys()
	end

	UI.Text("Info:", "FFFF0000")
	UI.Text("As of right now GatherBuddy does not have Security nor Townrun options. \n" ..
        		"Because of that it is NOT allowed to run GatherBuddy without manual supervision! \n" ..
        		"This is just a beta and should be treated as such! \n" ..
        		"Using GatherBuddy without supervision will get you removed from our service if you get reported because of it!",
        	"FFE9F542")
end
