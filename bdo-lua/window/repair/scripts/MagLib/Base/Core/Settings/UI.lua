local UI = MagLib.UI

UI.Settings = {}
UI.Settings.drawSettingsEditor = function(settingsName, settings)
	if ImGui.CollapsingHeader(settingsName) then
		UI.Indent(20)
		for key, value in pairs(settings) do
			local vType = type(value)

			if vType == "number" then
				if MagLib.Utils.Math.isFloat(value) then
					settings[key] = UI.InputFloat(key .. " :", value)
				else
					settings[key] = UI.InputInt(key .. " :", value)
				end
			elseif vType == "string" then
				settings[key] = UI.InputText(key .. " :", value)
			elseif vType == "table" then
				UI.Settings.drawSettingsEditor(key, value)
			elseif vType == "boolean" then
				settings[key] = UI.Checkbox(key .. " :", value)
			end
		end
		UI.Unindent(20)
	end
end

UI.Settings.drawAllSettingsEditor = function()
	local allSettings = MagLib.Core.Settings.allSettings

	-- Iterating here rather than just doing  UI.Settings.drawSettingsEditor("All", allSettings) to save one CollapsingHeader
	for settingsName, settings in pairs(allSettings) do
		UI.Settings.drawSettingsEditor(settingsName, settings)
	end
end

local newSettingsProfilePopupOpen = false
local newSettingsProfilePopupErrorMessage = nil
local newSettingsProfilePopupColor = nil
local newSettingsProfilePopupDraw = function(self)

	ImGui.SetWindowSize(ImVec2(600, 75))

	newSettingsProfilePopupOpen = true
	self.profileName = UI.InputText("Profile name:##newSettingsProfileNameInput", self.profileName, nil, nil,
                                	newSettingsProfilePopupColor)
	UI.SameLine()
	if UI.SimpleButton("Create##createNewSettingsProfile", newSettingsProfilePopupColor) then
		local nameLen = self.profileName:len()
		for i = 1, nameLen do
			local char = self.profileName:sub(i, i)
			if (MagLib.Utils.Strings.isASpecialCharacter(char)) then
				newSettingsProfilePopupErrorMessage = "Profile name cannot contain special character " .. char
				return
			end
		end

		-- We are here, so profile name is fine
		MagLib.Core.Settings.createProfile(self.profileName)
		newSettingsProfilePopupOpen = false
		newSettingsProfilePopupErrorMessage = nil
		self.close()
	end

	UI.SameLine()

	if UI.SimpleButton("Close##closeNewSettingsProfilePopup", newSettingsProfilePopupColor) then
		newSettingsProfilePopupOpen = false
		self.close()
	end

	if newSettingsProfilePopupErrorMessage ~= nil then
		UI.Text(newSettingsProfilePopupErrorMessage, "FFFF0000")
	end
end

local deleteSettingsProfilePopupOpen = false
local deleteSettingsProfilePopupProfileName = nil
local deleteSettingsProfilePopupDraw = function(self)

	ImGui.SetWindowSize(ImVec2(375, 100))

	deleteSettingsProfilePopupOpen = true
	UI.Text("Are you sure you want to delete the Settings Profile ")
	UI.SameLine()
	UI.Text(deleteSettingsProfilePopupProfileName, "FFFFA0A0")
	UI.Text("THIS CANNOT BE UNDONE!", "FFFF0000")
	if UI.SimpleButton("Delete##deleteSettingsProfileButton", "FFFF0000") then
		MagLib.Core.Settings.deleteProfile(deleteSettingsProfilePopupProfileName)
		deleteSettingsProfilePopupOpen = false
		self.close()
	end

	UI.SameLine()

	if UI.SimpleButton("Close##closeDeleteSettingsProfilePopup", "FF00FF00") then
		deleteSettingsProfilePopupOpen = false
		self.close()
	end

end

local settingsProfileSelectorButtonSize = 50
UI.Settings.SettingsProfileSelector = function(fullLine, color, forcedWidth)
	-- Profile selector
	local currentProfileIndex = MagLib.Core.Settings.currentProfileIndex

	if fullLine then
		local spaceLeft = ImGui.GetContentRegionAvailWidth()
		local minWidth = UI.minSliderLineWidth
		if spaceLeft < minWidth then
			spaceLeft = minWidth
		end
		forcedWidth = spaceLeft
	end

	local comboForcedWith = nil
	if forcedWidth then
		comboForcedWith = forcedWidth - settingsProfileSelectorButtonSize - settingsProfileSelectorButtonSize -
                  			UI.defaultFramePadding - UI.defaultFramePadding
	end
	local newIndex, changed = MagLib.UI.Combo("Settings Profile:", currentProfileIndex, MagLib.Core.Settings.profileList,
                                          	false, nil, color, comboForcedWith)

	if changed then
		MagLib.Core.Settings.loadProfile(newIndex)
	end

	-- New profile button
	UI.SameLine()
	if UI.SimpleButton("New", color, ImVec2(settingsProfileSelectorButtonSize, 0)) then
		if not newSettingsProfilePopupOpen then
			MagLib.UI.Popups.new("New Settings Profile", newSettingsProfilePopupDraw, 1 / 0)
			newSettingsProfilePopupColor = color
		end
	end
	UI.SameLine()
	if UI.SimpleButton("Delete", color, ImVec2(settingsProfileSelectorButtonSize, 0)) then
		if not deleteSettingsProfilePopupOpen then
			deleteSettingsProfilePopupProfileName = MagLib.Core.Settings.currentProfile
			MagLib.UI.Popups.new("Delete Settings Profile", deleteSettingsProfilePopupDraw, 1 / 0)
		end
	end

end

local newSettingsInlineShowing = false
local inlineProfileName = ""
local newSettingsProfileInlineErrorMessage
local newSettingsInlineDraw = function(fullLine, color, forcedWidth)
	newSettingsInlineShowing = true

	if fullLine then
		local spaceLeft = ImGui.GetContentRegionAvailWidth()
		local minWidth = UI.minSliderLineWidth
		if spaceLeft < minWidth then
			spaceLeft = minWidth
		end
		forcedWidth = spaceLeft
	end

	local comboForcedWith = nil
	if forcedWidth then
		comboForcedWith = forcedWidth - settingsProfileSelectorButtonSize - settingsProfileSelectorButtonSize -
                  			UI.defaultFramePadding - UI.defaultFramePadding
	end

	inlineProfileName = UI.InputText("Profile name:##newSettingsProfileNameInput", inlineProfileName, false, nil, color,
                                 	nil, comboForcedWith)
	UI.SameLine()
	if UI.SimpleButton("Create##createNewSettingsProfile", color, ImVec2(settingsProfileSelectorButtonSize, 0)) then
		local nameLen = inlineProfileName:len()
		for i = 1, nameLen do
			local char = inlineProfileName:sub(i, i)
			if (MagLib.Utils.Strings.isASpecialCharacter(char)) then
				newSettingsProfileInlineErrorMessage = "Profile name cannot contain special character " .. char
				return
			end
		end

		-- We are here, so profile name is fine
		MagLib.Core.Settings.createProfile(inlineProfileName)
		newSettingsInlineShowing = false
		inlineProfileName = ""
		newSettingsProfileInlineErrorMessage = nil
	end

	UI.SameLine()

	if UI.SimpleButton("Back##closeNewSettingsProfileInline", color, ImVec2(settingsProfileSelectorButtonSize, 0)) then
		newSettingsInlineShowing = false
		inlineProfileName = ""
	end

	if newSettingsProfileInlineErrorMessage ~= nil then
		UI.Text(newSettingsProfileInlineErrorMessage, "FFFF0000")
	end
end

UI.Settings.SettingsProfileSelectorInline = function(fullLine, color, forcedWidth)
	-- Profile selector
	local currentProfileIndex = MagLib.Core.Settings.currentProfileIndex

	if fullLine then
		local spaceLeft = ImGui.GetContentRegionAvailWidth()
		local minWidth = UI.minSliderLineWidth
		if spaceLeft < minWidth then
			spaceLeft = minWidth
		end
		forcedWidth = spaceLeft
	end

	local comboForcedWith = nil
	if forcedWidth then
		comboForcedWith = forcedWidth - settingsProfileSelectorButtonSize - settingsProfileSelectorButtonSize -
                  			UI.defaultFramePadding - UI.defaultFramePadding
	end
	--  newIndex, changed
	if not newSettingsInlineShowing then
		local newIndex, changed = MagLib.UI.Combo("Settings Profile:", currentProfileIndex, MagLib.Core.Settings.profileList,
                                          		false, nil, color, comboForcedWith)
		if changed then
			MagLib.Core.Settings.loadProfile(newIndex)
		end

		-- New profile button
		UI.SameLine()
		if UI.SimpleButton("New", color, ImVec2(settingsProfileSelectorButtonSize, 0)) then
			if not newSettingsInlineShowing then
				newSettingsInlineShowing = true
			end
		end
		UI.SameLine()
		if UI.SimpleButton("Delete", color, ImVec2(settingsProfileSelectorButtonSize, 0)) then
			if not deleteSettingsProfilePopupOpen then
				deleteSettingsProfilePopupProfileName = MagLib.Core.Settings.currentProfile
				MagLib.UI.Popups.new("Delete Settings Profile", deleteSettingsProfilePopupDraw, 1 / 0)
			end
		end

	else
		newSettingsInlineDraw(fullLine, color, forcedWidth)
	end
end
