local ThemeEngine = {}
local settings = {lastLoadedThemeFilePath = ""}
MagLib.Core.Settings.addSettingsToHandler("MagLib_Themes", settings)

ThemeEngine.currentTheme = nil
ThemeEngine.currentThemePath = nil
ThemeEngine.currentThemeIndex = 0
ThemeEngine.selectThemeIndex = 0

ThemeEngine.availableThemes = {}

local getColorFromHex = RenderHelper.GetColorImVec4FromHexColorString
ThemeEngine.refreshThemes = function()
	ThemeEngine.availableThemes = {}
	local scriptThemeFolder = "\\Themes\\"
	local magLibThemeFolder = MagLib.Constants.magLibFolderPath .. "\\Base\\UI\\ThemeEngine\\Themes\\"

	-- Script specific files
	local scriptThemeFiles = Infinity.FileSystem.GetFiles(scriptThemeFolder .. "*.MagLibTheme")
	for k, filePath in pairs(scriptThemeFiles) do
		local name = filePath:sub(1, filePath:len() - 12)
		local themeEntry = {name = name, filePath = scriptThemeFolder .. filePath}
		table.insert(ThemeEngine.availableThemes, themeEntry)
	end

	-- MagLib files
	local magLibThemeFiles = Infinity.FileSystem.GetFiles(magLibThemeFolder .. "*.MagLibTheme")
	for k, filePath in pairs(magLibThemeFiles) do
		local name = filePath:sub(1, filePath:len() - 12)
		local themeEntry = {name = name, filePath = magLibThemeFolder .. filePath}
		table.insert(ThemeEngine.availableThemes, themeEntry)
	end
end
MagLib.Events.addEventHandler("AfterInit_Base", ThemeEngine.refreshThemes)

ThemeEngine.newTheme = function(name, folder, isAbsolute)
	if not MagLib.Utils.Strings.isEmpty(name) then
		local tmpTheme = ThemeEngine.Theme(name)
		MagLib.Utils.Json.saveTableToJsonFile(folder .. "/" .. name .. ".MagLibTheme", MagLib.Utils.Json.serialize(tmpTheme),
                                      		isAbsolute)
		ThemeEngine.refreshThemes()
		ThemeEngine.selectThemeIndex = 0
		return true
	else
		MagLib.logger.error("Please provide a proper theme name!")
		return false
	end
end

ThemeEngine.saveTheme = function(theme)
	print("Saving theme")
	local filePath = theme.filePath
	MagLib.logger.info("Saving theme at " .. filePath)
	theme.filePath = nil
	MagLib.Utils.Json.saveTableToJsonFile(filePath, MagLib.Utils.Json.serialize(theme), false)
	theme.filePath = filePath
end

ThemeEngine.selectTheme = function(index)
	print("Selecting theme")
	local filePath = ThemeEngine.availableThemes[index].filePath
	print("Filepath = " .. ThemeEngine.availableThemes[index].filePath)
	local newTheme = MagLib.Utils.Json.deserialize(MagLib.Utils.Json.loadTableFromJsonFile(filePath, false))
	newTheme.filePath = filePath
	settings.lastLoadedThemeFilePath = filePath

	ThemeEngine.currentThemeIndex = index
	ThemeEngine.selectThemeIndex = index
	if newTheme then
		print("Loading theme " .. newTheme.name)
		ThemeEngine.currentTheme = newTheme
	else
		print("ERROR: Invalid theme index!")
	end
end

ThemeEngine.pushStyle = function(theme)
	-- print("Pushing " .. table.length(theme.style.color) .. " color vars")
	for id, v in pairs(theme.style.color) do
		ImGui.PushStyleColor2(id, getColorFromHex(v))
	end

	-- print("Pushing " .. table.length(theme.style.var.number) + table.length(theme.style.var.number) .. " style vars")
	for id, v in pairs(theme.style.var.number) do
		-- print("number: " .. id .. " | " .. v)
		ImGui.PushStyleVar1(id, v)
	end

	for id, v in pairs(theme.style.var.imVec2) do
		-- print("imVec2: " .. id .. " | " .. tostring(v))
		ImGui.PushStyleVar2(id, v)
	end
end

ThemeEngine.popStyle = function(theme)
	local colorCount = table.length(theme.style.color)
	if colorCount > 0 then
		-- print("Poping " .. colorCount .. " color vars")
		ImGui.PopStyleColor(colorCount)
	end

	local varCount = table.length(theme.style.var.number) + table.length(theme.style.var.imVec2)
	if varCount > 0 then
		-- print("Poping " .. varCount .. " ui vars")
		ImGui.PopStyleVar(varCount)
	end
end

local initRefreshDone = false
ThemeEngine.drawThemeSelector = function()
	if not initRefreshDone then
		ThemeEngine.refreshThemes()
		initRefreshDone = true
	end

	ImGui.Text("Theme:")
	ImGui.SameLine()

	local changed = false
	local themeNames = {}
	for _, theme in ipairs(ThemeEngine.availableThemes) do
		table.insert(themeNames, theme.name)
	end

	changed, ThemeEngine.selectThemeIndex = ImGui.Combo("##theme_selector", ThemeEngine.selectThemeIndex, themeNames)
	if changed then
		ThemeEngine.currentThemeIndex = -1 -- Forcing a reload
		-- The actual theme loading will be done on next onGUIDraw callback to MagLib
	end
end

ThemeEngine.loadlastLoadedTheme = function()
	----Loading last theme
	if settings.lastLoadedThemeFilePath ~= nil then
		for index, theme in pairs(ThemeEngine.availableThemes) do
			if theme.filePath == settings.lastLoadedThemeFilePath then
				ThemeEngine.selectTheme(index)
				break
			end
		end
	end
end
MagLib.Events.addEventHandler("SettingsProfileLoaded", ThemeEngine.loadlastLoadedTheme)

ThemeEngine.init = function()
	ThemeEngine.loadlastLoadedTheme()
end
MagLib.Events.addEventHandler("AfterAfterInit_Base", ThemeEngine.init)

MagLib.UI.ThemeEngine = ThemeEngine
