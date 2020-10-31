local Settings = {}

local getTime = MagLib.getTime

Settings.currentProfile = nil
Settings.currentProfileIndex = -1
Settings.profileList = {}

local loadedProfileSettings = {profileName = "Default"}

local allSettings = {}
Settings.allSettings = allSettings
local savedSettings = {}
local defaultSettings = {}

-- Profile functions
local function updateProfileList()
	Settings.profileList = {}
	local files = Infinity.FileSystem.GetAllFiles("Settings")
	for _, file in pairs(files) do
		local tmp = MagLib.Utils.Strings.split(file, "\\")
		local directoryName = tmp[#tmp - 1]
		if directoryName ~= nil and directoryName ~= "Settings" then
			if not table.find(Settings.profileList, directoryName) then
				table.insert(Settings.profileList, directoryName)
			end
		end
	end
end

-- Settings functions
Settings.createProfile = function(name)
	if MagLib.Core.IO.existsDirectory(Infinity.Scripting.CurrentScript.Directory .. "\\Settings") then
		local nameLen = name:len()
		for i = 1, nameLen do
			local char = name:sub(i, i)
			if (MagLib.Utils.Strings.isASpecialCharacter(char)) then
				MagLib.logger.error("Profile name cannot contain special character " .. char)
				return
			end
		end

		local command = "cd /d \"" .. Infinity.Scripting.CurrentScript.Directory .. "/Settings\" & mkdir \"" .. name .. "\""
		os.execute(command)

		Infinity.FileSystem.WriteFile("Settings/" .. name .. "/SettingsGoHere.txt", "")

		updateProfileList()
	else
		MagLib.logger.warning("Could not create Profile: No Settings folder found! Assuming settings should not be saved")
	end
end

Settings.loadProfile = function(profileName_or_index)
	local profileName = profileName_or_index
	-- check if given is an index
	if type(profileName) == "number" then
		profileName = Settings.profileList[profileName]
	end

	MagLib.logger.info("Loading Settings Profile " .. profileName)
	for settingsName, settings in pairs(Settings.allSettings) do
		Settings.saveSetting(settingsName)
		-- Loading settings from file if they exists
		if MagLib.Core.IO.fileNonEmpty("Settings/" .. profileName .. "/" .. settingsName .. ".json") then
			local savedSettings = MagLib.Utils.Json.loadTableFromJsonFile(
                      				"Settings/" .. profileName .. "/" .. settingsName .. ".json")

			local newSettings = MagLib.Utils.Table.copy(defaultSettings[settingsName])
			table.merge(newSettings, savedSettings)
			MagLib.Utils.Table.clear(Settings.allSettings[settingsName])
			table.merge(Settings.allSettings[settingsName], newSettings)
		else
			-- The setting doesn't exist in the profile, we just load default one
			MagLib.Utils.Table.clear(Settings.allSettings[settingsName])
			table.merge(Settings.allSettings[settingsName], defaultSettings[settingsName])
		end
	end

	Settings.currentProfile = profileName
	Settings.currentProfileIndex = table.find(Settings.profileList, Settings.currentProfile)

	loadedProfileSettings.profileName = profileName
	MagLib.Utils.Json.saveTableToJsonFile("Settings/LastLoadedProfile.json", loadedProfileSettings)

	for settingsName, settings in pairs(Settings.allSettings) do
		Settings.saveSetting(settingsName)
	end

	MagLib.Events.triggerEvent("SettingsProfileLoaded", profileName)
end

Settings.deleteProfile = function(profileName_or_index)
	local profileName = profileName_or_index
	-- check if given is an index
	if type(profileName) == "number" then
		profileName = Settings.profileList[profileName]
	end

	MagLib.logger.info("Deleting Settings Profile " .. profileName)

	local command = "cd /d \"" .. Infinity.Scripting.CurrentScript.Directory .. "/Settings\" & rmdir /q /s \"" ..
                		profileName .. "\""

	os.execute(command)

	updateProfileList()
	-- Swapping to Default Profile if we just deleted the profile we were on
	if Settings.currentProfile == profileName then
		local defaultProfileIndex = table.find(Settings.profileList, "Default")
		if not defaultProfileIndex then
			Settings.createProfile("Default")
			updateProfileList()
			defaultProfileIndex = table.find(Settings.profileList, "Default")
		end
		Settings.loadProfile(defaultProfileIndex)
	end
end

-- Settings functions
Settings.addSettingsToHandler = function(name, defaultSetting)
	local savedSetting = {}

	-- Keeping a copy of the default settings
	defaultSettings[name] = MagLib.Utils.Table.copy(defaultSetting)

	if MagLib.Core.IO.existsDirectory(Infinity.Scripting.CurrentScript.Directory .. "\\Settings") then
		-- Loading settings from file if they exists
		if MagLib.Core.IO.fileNonEmpty("Settings/" .. Settings.currentProfile .. "/" .. name .. ".json") then
			savedSetting = MagLib.Utils.Json.loadTableFromJsonFile("Settings/" .. Settings.currentProfile .. "/" .. name ..
                                                       				".json")
			table.merge(defaultSetting, savedSetting)
		end
	end

	--
	allSettings[name] = defaultSetting

	-- Saving in case stuff changed (for example new entries in default settings)
	Settings.saveSetting(name)
end

local lastTimeFlushed = 0
Settings.flushAllChanges = function()
	for name, setting in pairs(allSettings) do
		local savedSetting = savedSettings[name]
		local diff1 = MagLib.Utils.Table.deepDiff(savedSetting, setting)
		local diff2 = MagLib.Utils.Table.deepDiff(setting, savedSetting)
		if #diff1 > 0 or #diff2 > 0 then
			MagLib.logger.info("Saving Setting " .. name)
			Settings.saveSetting(name)
		end
	end

	lastTimeFlushed = getTime()
end

---Inits MagLibs Settings Module
-- If MagLib.Run.Modules is not loaded (For example in the uionly.def version of MagLib), it will register it's own onPulse callback

Settings.init = function()
	if MagLib.Run and MagLib.Run.Modules then
		local settingsUpdater = MagLib.Run.Modules.RunModule("Settings Updater", 750, 2000,
                                                     		MagLib.Run.Modules.TimingMode.TimedNonCritical,
                                                     		MagLib.Run.EPulseTimingMode.End)
		settingsUpdater.run = function()
			Settings.flushAllChanges()
		end

		MagLib.Run.Modules.Handler.addModule(settingsUpdater)
		settingsUpdater.start()
	else
		-- Modules is not loaded, hence we add a onPulse callback
		local lastFlushed = 0
		local f = function()
			local time = getTime()
			if lastFlushed + 2000 < time then
				lastFlushed = time
				Settings.flushAllChanges()
			end
		end
		Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", f)
	end
end

Settings.saveSetting = function(name)
	local setting = allSettings[name]
	if MagLib.Core.IO.existsDirectory(Infinity.Scripting.CurrentScript.Directory .. "\\Settings") then
		MagLib.Utils.Json.saveTableToJsonFile("Settings/" .. Settings.currentProfile .. "/" .. name .. ".json", setting)
	end
	savedSettings[name] = MagLib.Utils.Table.copy(setting)
end

Settings.getSetting = function(name)
	return allSettings[name]
end

MagLib.Core.Settings = Settings
---------------------------------------------------------------------------------------------------------------------------------
-- Init code.
-- Check for old settings .jsons and move them into default
local files = Infinity.FileSystem.GetFiles("Settings/*.json")
local copyCommand = ""
for _, file in pairs(files) do
	if file ~= "LastLoadedProfile.json" then
		print("Found old settings file " .. file .. "! Moving into Default Profile")
		copyCommand = copyCommand .. "& move \"" .. file .. "\" Default "

	end
end

if copyCommand ~= "" then
	copyCommand = "cd /d \"" .. Infinity.Scripting.CurrentScript.Directory .. "/Settings\" & " .. "mkdir Default " ..
              		copyCommand

	os.execute(copyCommand)
end

if MagLib.Core.IO.existsDirectory(Infinity.Scripting.CurrentScript.Directory .. "\\Settings") then
	updateProfileList()

	-- Loading last profile
	if (MagLib.Core.IO.fileNonEmpty("Settings/LastLoadedProfile.json")) then
		local loadedProfileSettingsFile = MagLib.Utils.Json.loadTableFromJsonFile("Settings/LastLoadedProfile.json")
		table.merge(loadedProfileSettings, loadedProfileSettingsFile);
	else
		MagLib.Utils.Json.saveTableToJsonFile("Settings/LastLoadedProfile.json", loadedProfileSettings)
	end

	local profileIndex = table.find(Settings.profileList, loadedProfileSettings.profileName)
	if not profileIndex then
		-- print("Could not find SettingsProfile " .. loadedProfileSettings.profileName .. "! Loading Default SettingsProfile")
		loadedProfileSettings.profileName = "Default"
		profileIndex = table.find(Settings.profileList, "Default")
		if not profileIndex then
			Settings.createProfile("Default")
			updateProfileList()
			profileIndex = table.find(Settings.profileList, "Default")
		end
	end

	Settings.currentProfile = loadedProfileSettings.profileName
	Settings.currentProfileIndex = profileIndex
else
	Settings.currentProfile = "None"
	Settings.currentProfileIndex = 0
end
