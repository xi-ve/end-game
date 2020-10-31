MagLib.UI.Input = {}
local UI = MagLib.UI

local pressedColor = "FFFF0000"

local getColorForKey = function(data)
	if data and data.pressUntil > MagLib.getTime() then
		return pressedColor
	else
		return nil
	end
end

MagLib.UI.Input.drawDebugWindow = function()
	UI.newWindow("Input Debug")
	local keyData = MagLib.Input.keyData
	---First Row
	UI.Text("TAB  ", getColorForKey(keyData[KeyCode_TAB]))
	ImGui.SameLine()
	UI.Text(" Q", getColorForKey(keyData[KeyCode_Q]))
	ImGui.SameLine()
	UI.Text(" W", getColorForKey(keyData[KeyCode_W]))
	ImGui.SameLine()
	UI.Text(" E", getColorForKey(keyData[KeyCode_E]))
	ImGui.SameLine()
	UI.Text(" R", getColorForKey(keyData[KeyCode_R]))
	ImGui.SameLine()
	UI.Text(" T", getColorForKey(keyData[KeyCode_T]))
	ImGui.SameLine()
	UI.Text(" Z", getColorForKey(keyData[KeyCode_Z]))

	-- Second Row
	UI.Text("         ")
	ImGui.SameLine()
	UI.Text(" A", getColorForKey(keyData[KeyCode_A]))
	ImGui.SameLine()
	UI.Text(" S", getColorForKey(keyData[KeyCode_S]))
	ImGui.SameLine()
	UI.Text(" D", getColorForKey(keyData[KeyCode_D]))
	ImGui.SameLine()
	UI.Text(" F", getColorForKey(keyData[KeyCode_F]))
	ImGui.SameLine()
	UI.Text("          LMB", getColorForKey(keyData[KeyCode_LBUTTON]))
	ImGui.SameLine()
	UI.Text("  RMB", getColorForKey(keyData[KeyCode_RBUTTON]))

	-- Third row
	UI.Text("SHIFT", getColorForKey(keyData[KeyCode_SHIFT]))
	ImGui.SameLine()
	UI.Text(" Y", getColorForKey(keyData[KeyCode_Y]))
	ImGui.SameLine()
	UI.Text(" X", getColorForKey(keyData[KeyCode_X]))
	ImGui.SameLine()
	UI.Text(" C", getColorForKey(keyData[KeyCode_C]))
	ImGui.SameLine()
	UI.Text(" V", getColorForKey(keyData[KeyCode_V]))

	UI.Text("Keyflag Override: " .. tostring(Infinity.BDO.Input.getIsKeyInputFlagOverride()))
	UI.Text("Keyflag Value: " .. tostring(Infinity.BDO.Input.getKeyInputFlagValue()))

	UI.endWindow()
end
