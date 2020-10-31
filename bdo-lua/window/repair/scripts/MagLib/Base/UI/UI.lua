local getColor = RenderHelper.GetColorImVec4FromHexColorString

local UI = {}

UI.defaultFramePadding = 5

UI.parsePlainUIText = function(text)
	if text == nil then
		return ""
	end

	local pos = string.find(text, "##")
	local parsedText = ""
	if not pos then
		parsedText = text
	else
		parsedText = string.sub(text, 1, pos - 1)
	end

	return parsedText
end

UI.newWindow = function(name, theme, flags)
	theme = theme or MagLib.UI.ThemeEngine.currentTheme
	if theme then
		MagLib.UI.ThemeEngine.pushStyle(theme)
	end

	ImGui.Begin(name, true, flags)
end
UI.Begin = UI.newWindow

UI.endWindow = function(theme)
	ImGui.End()

	theme = theme or MagLib.UI.ThemeEngine.currentTheme
	if theme then
		MagLib.UI.ThemeEngine.popStyle(theme)
	end
end
UI.End = UI.endWindow

UI.getWindowPos = function()
	local ImVec = ImGui.GetWindowPos()
	return Vector2(math.floor(tonumber(ImVec.x)), math.floor(tonumber(ImVec.y)))
end

UI.getAvailWidth = function()
	return ImGui.GetContentRegionAvail().X
end

UI.getAvailHeight = function()
	return ImGui.GetContentRegionAvail().Y
end

UI.Text = function(text, color)
	if text == nil then
		text = ""
	end
	local actualText = UI.parsePlainUIText(text)
	if color == nil then
		ImGui.Text(actualText)
	else
		if type(color) == "string" then
			color = getColor(color)
		end
		ImGui.TextColored(color, actualText)
	end
end

UI.SimpleButton = function(text, color, size)
	if color then
		if type(color) == "string" then
			color = getColor(color)
		end
		ImGui.PushStyleColor2(ImGuiCol_Button, color)
	end

	local returnValue
	if size then
		returnValue = ImGui.Button(text, size)
	else
		returnValue = ImGui.Button(text)
	end

	if color then
		ImGui.PopStyleColor(1)
	end

	return returnValue
end

UI.Button = function(text, pressFunc, color, size)
	if color then
		if type(color) == "string" then
			color = getColor(color)
		end
		ImGui.PushStyleColor2(ImGuiCol_Button, color)
	end

	if size then
		if ImGui.Button(text, size) then
			pressFunc()
		end
	else
		if ImGui.Button(text) then
			pressFunc()
		end
	end

	if color then
		ImGui.PopStyleColor(1)
	end
end

UI.endScriptButton = function(customText, customPreFunc, color, size)
	if color then
		if type(color) == "string" then
			color = getColor(color)
		end
		ImGui.PushStyleColor2(ImGuiCol_Button, color)
	end

	local text
	if customText then
		text = customText
	else
		text = "End Script"
	end

	if not size then
		size = ImVec2(50, 0)
	end

	if ImGui.Button(text, size) then
		if customPreFunc then
			customPreFunc()
		end
		MagLib.EndScript()
	end

	if color then
		ImGui.PopStyleColor(1)
	end
end

UI.Checkbox = function(text, state, changeFunction, color, shouldTextLeft)
	local changed = nil
	local newState = nil
	if shouldTextLeft then
		UI.Text(text, color)
		UI.SameLine()
		changed, newState = ImGui.Checkbox("##" .. text .. "_checkbox", state)
	else
		changed, newState = ImGui.Checkbox("##" .. text .. "_checkbox", state)
		UI.SameLine()
		UI.Text(text, color)
	end

	if changed and changeFunction then
		changeFunction(newState)
	end
	return newState, changed
end

UI.minInputWidth = 100
UI.InputText = function(text, content, fullLine, changeFunc, color, flags, forcedWidth)
	if content == nil then
		content = "" -- So you can give a var that is nil as parameter and it will be "" after first run.
	end

	local prevAvailableWidth = ImGui.GetContentRegionAvailWidth()
	if color == nil then
		UI.Text(text)
	else
		if type(color) == "string" then
			color = getColor(color)
		end
		UI.Text(text, color)
	end
	UI.SameLine()
	local textSize = prevAvailableWidth - ImGui.GetContentRegionAvailWidth() + UI.defaultFramePadding

	if fullLine then
		local spaceLeft = ImGui.GetContentRegionAvailWidth()
		local minWidth = UI.minInputWidth
		if spaceLeft < minWidth then
			spaceLeft = minWidth
		end
		ImGui.PushItemWidth(spaceLeft)
	elseif forcedWidth then
		ImGui.PushItemWidth(forcedWidth - textSize)
	end

	local newState, changed
	changed, newState = ImGui.InputText("##" .. text .. "_textInput", content, nil, flags)

	if fullLine or forcedWidth then
		ImGui.PopItemWidth()
	end

	if changed and changeFunc then
		changeFunc()
	end

	return newState, changed
end

UI.InputInt = function(text, content, stepSize, fastStepSize, fullLine, changeFunc, color, flags, forcedWidth)

	local prevAvailableWidth = ImGui.GetContentRegionAvailWidth()
	if color == nil then
		UI.Text(text)
	else
		if type(color) == "string" then
			color = getColor(color)
		end
		UI.Text(text, color)
	end
	UI.SameLine()
	local textSize = prevAvailableWidth - ImGui.GetContentRegionAvailWidth() + UI.defaultFramePadding

	if fullLine then
		local spaceLeft = ImGui.GetContentRegionAvailWidth()
		local minWidth = UI.minInputWidth
		if spaceLeft < minWidth then
			spaceLeft = minWidth
		end
		ImGui.PushItemWidth(spaceLeft)
	elseif forcedWidth then
		ImGui.PushItemWidth(forcedWidth - textSize)
	end

	local newState = nil
	local changed = nil
	changed, newState = ImGui.InputInt("##" .. text .. "_textInput", content, stepSize, fastStepSize, flags)

	if fullLine or forcedWidth then
		ImGui.PopItemWidth()
	end

	if changed and changeFunc then
		changeFunc()
	end

	return newState, changed
end

UI.InputFloat = function(text, content, stepSize, fastStepSize, fullLine, changeFunc, color, flags, forcedWidth)

	local prevAvailableWidth = ImGui.GetContentRegionAvailWidth()
	if color == nil then
		UI.Text(text)
	else
		if type(color) == "string" then
			color = getColor(color)
		end
		UI.Text(text, color)
	end
	UI.SameLine()
	local textSize = prevAvailableWidth - ImGui.GetContentRegionAvailWidth() + UI.defaultFramePadding

	if fullLine then
		local spaceLeft = ImGui.GetContentRegionAvailWidth()
		local minWidth = UI.minInputWidth
		if spaceLeft < minWidth then
			spaceLeft = minWidth
		end
		ImGui.PushItemWidth(spaceLeft)
	elseif forcedWidth then
		ImGui.PushItemWidth(forcedWidth - textSize)
	end

	local newState = nil
	local changed = nil
	changed, newState = ImGui.InputFloat("##" .. text .. "_textInput", content, stepSize, fastStepSize, flags)

	if fullLine or forcedWidth then
		ImGui.PopItemWidth()
	end

	if changed and changeFunc then
		changeFunc()
	end

	return newState, changed
end

UI.minSliderLineWidth = 200
UI.SliderInt = function(text, state, min, max, fullLine, changeFunction, color, forcedWidth)
	local changed = nil
	local newState = nil
	local spaceLeft = nil

	local prevAvailableWidth = ImGui.GetContentRegionAvailWidth()
	if color == nil then
		UI.Text(text)
	else
		if type(color) == "string" then
			color = getColor(color)
		end
		UI.Text(text, color)
	end
	UI.SameLine()
	local textSize = prevAvailableWidth - ImGui.GetContentRegionAvailWidth() + UI.defaultFramePadding

	if fullLine then
		local spaceLeft = ImGui.GetContentRegionAvailWidth()
		local minWidth = UI.minSliderLineWidth
		if spaceLeft < minWidth then
			spaceLeft = minWidth
		end
		ImGui.PushItemWidth(spaceLeft)
	elseif forcedWidth then
		ImGui.PushItemWidth(forcedWidth - textSize)
	end

	changed, newState = ImGui.SliderInt("##" .. text .. "_intSlider", state, min, max)

	if fullLine or forcedWidth then
		ImGui.PopItemWidth()
	end

	if changed and changeFunction then
		changeFunction(newState)
	end
	return newState, changed
end

UI.SliderFloat = function(text, state, min, max, fullLine, changeFunction, color, forcedWidth)
	local changed = nil
	local newState = nil
	local spaceLeft = nil

	local prevAvailableWidth = ImGui.GetContentRegionAvailWidth()
	if color == nil then
		UI.Text(text)
	else
		if type(color) == "string" then
			color = getColor(color)
		end
		UI.Text(text, color)
	end
	UI.SameLine()
	local textSize = prevAvailableWidth - ImGui.GetContentRegionAvailWidth() + UI.defaultFramePadding

	if fullLine then
		local spaceLeft = ImGui.GetContentRegionAvailWidth()
		local minWidth = UI.minSliderLineWidth
		if spaceLeft < minWidth then
			spaceLeft = minWidth
		end
		ImGui.PushItemWidth(spaceLeft)
	elseif forcedWidth then
		ImGui.PushItemWidth(forcedWidth - textSize)
	end

	changed, newState = ImGui.SliderFloat("##" .. text .. "_intSlider", state, min, max)

	if fullLine or forcedWidth then
		ImGui.PopItemWidth()
	end

	if changed and changeFunction then
		changeFunction(newState)
	end
	return newState, changed
end

UI.minComboLineWidth = 150
UI.Combo = function(text, currentIndex, list, fullLine, changeFunction, color, forcedWidth)
	local changed = nil
	local newIndex = nil

	local prevAvailableWidth = ImGui.GetContentRegionAvailWidth()
	if color == nil then
		UI.Text(text)
	else
		if type(color) == "string" then
			color = getColor(color)
		end
		UI.Text(text, color)
	end
	UI.SameLine()
	local textSize = prevAvailableWidth - ImGui.GetContentRegionAvailWidth() + UI.defaultFramePadding

	if fullLine then
		local spaceLeft = ImGui.GetContentRegionAvailWidth()
		local minWidth = UI.minComboLineWidth
		if spaceLeft < minWidth then
			spaceLeft = minWidth
		end
		ImGui.PushItemWidth(spaceLeft)
	elseif forcedWidth then
		ImGui.PushItemWidth(forcedWidth - textSize)
	end

	changed, newIndex = ImGui.Combo("##" .. text .. "_combo", currentIndex, list)

	if fullLine or forcedWidth then
		ImGui.PopItemWidth()
	end

	if changed and changeFunction then
		changeFunction(newIndex)
	end

	return newIndex, changed
end

UI.ImVec2Editor = function(text, imVec2, color)
	if color == nil then
		UI.Text(text)
	else
		if type(color) == "string" then
			color = getColor(color)
		end
		UI.Text(text, color)
	end
	UI.SameLine()

	imVec2.x = UI.InputFloat("X: ##x_" .. text, imVec2.x, nil, nil, nil, nil, color, nil, 100)
	UI.SameLine()
	imVec2.y = UI.InputFloat("Y: ##y_" .. text, imVec2.y, nil, nil, nil, nil, color, nil, 100)

	return imVec2
end

UI.Columns = function(amount, spaces, titles, id, shouldBorder)
	if shouldBorder == nil then
		shouldBorder = true
	end

	ImGui.Columns(amount, id, shouldBorder)

	for i = 0, (amount - 1) do
		ImGui.SetColumnWidth(i, spaces[i + 1])
	end

	for i = 1, amount do
		UI.Text(titles[i])
		ImGui.NextColumn()
	end

	UI.Separator()
end

UI.NextColumn = function()
	ImGui.NextColumn()
end

UI.EndColumns = function()
	ImGui.Columns(1)
	UI.Separator()
end

UI.SameLine = function(local_pos_x, spacing_w)
	ImGui.SameLine(local_pos_x, spacing_w)
end

UI.IndentSize = {Small = 10, Medium = 25, Large = 50}

UI.Indent = function(px)
	ImGui.Indent(px)
end

UI.Unindent = function(px)
	ImGui.Unindent(px)
end

UI.Separator = function()
	ImGui.Separator()
end

-- Key selector
local keyNames = {}
local keyValues = {}
for value, name in pairs(MagLib.Constants.keyStrings) do
	table.insert(keyNames, name)
	table.insert(keyValues, value)
end
UI.keySelector = function(text, currentKeyValue, fullLine, changeFunction, color, forcedWidth)
	currentKeyValue = currentKeyValue or -1 -- To make sure no error is thrown on getting a nil value
	-- Getting the current index in the keyValues table, which is also representative of the keyNames table
	local currentIndex = table.find(keyValues, currentKeyValue)

	-- If it is not a proper key
	if not currentIndex then
		currentIndex = 0
	end

	--
	local newIndex, changed = MagLib.UI.Combo(text, currentIndex, keyNames, fullLine, changeFunction, color, forcedWidth)

	return keyValues[newIndex], changed
end

MagLib.UI = UI
