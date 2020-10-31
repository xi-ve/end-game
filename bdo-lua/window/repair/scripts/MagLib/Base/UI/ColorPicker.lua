local getColor = RenderHelper.GetColorImVec4FromHexColorString
local UI = MagLib.UI

local colorToHex = function(rgba)
	local hexColor = string.format("%02X", math.floor(rgba.w * 255)) .. string.format("%02X", math.floor(rgba.x * 255)) ..
                 		string.format("%02X", math.floor(rgba.y * 255)) .. string.format("%02X", math.floor(rgba.z * 255))
	return hexColor
end

UI.ColorPicker = function(text, state, fullLine, changeFunction, color, flags)
	local newState = state
	local spaceLeft = nil
	if color == nil then
		UI.Text(text)
	else
		if type(color) == "string" then
			color = getColor(color)
		end
		UI.TextColored(color, text)
	end
	UI.SameLine()
	if fullLine then
		spaceLeft = ImGui.GetContentRegionAvailWidth()
		local minWidth = MagLib.UI.minSliderLineWidth
		if spaceLeft < minWidth then
			spaceLeft = minWidth
		end
		ImGui.PushItemWidth(spaceLeft)
	else
		-- Text is hex value and default gives way too much space.
		-- So we set a custom size hardcoded
		ImGui.PushItemWidth(100)
	end
	local state_C = getColor(state)

	if flags == nil then
		flags = ImGuiColorEditFlags_NoLabel + ImGuiColorEditFlags_AlphaBar + ImGuiColorEditFlags_HEX -- ImGuiColorEditFlags_PickerHueWheel
	end
	if ImGui.ColorEdit3("##" .. text .. "_colorEdit", state_C, flags) then
		newState = colorToHex(state_C)
	end

	ImGui.PopItemWidth()

	if state ~= newState and changeFunction then
		changeFunction(newState)
	end

	return newState
end
