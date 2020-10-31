AdvancedUI = {}
local UI = MagLib.UI
-- This is on top of EVERY file to optimize performance
local _ = nil
local _Grinder = nil
local _Cache = nil

function AdvancedUI.init()
	_Grinder = Grinder
	_Cache = Cache
end

function AdvancedUI.draw(newWindow)
	if newWindow == nil then
		newWindow = true
	end
	if newWindow then
		ImGui.Begin("[Grinder] Advanced Settings")

		ImGui.PushStyleColor2(ImGuiCol_Text, RenderHelper.GetColorImVec4FromHexColorString("FFFFCC99"))
		ImGui.PushStyleColor2(ImGuiCol_Button, RenderHelper.GetColorImVec4FromHexColorString("FF990000"))
		ImGui.PushStyleColor2(ImGuiCol_CheckMark, RenderHelper.GetColorImVec4FromHexColorString("FF990000"))
	end

	if (ImGui.Checkbox("Debug", _Grinder.settings.show_debug_ui)) then
		_Grinder.settings.show_debug_ui = not _Grinder.settings.show_debug_ui
	end
	UI.Separator()
	UI.Text("Logging:")
	_, _Grinder.settings.log_verbose = ImGui.Checkbox("Show more informations in log", _Grinder.settings.log_verbose)
	_, _Grinder.settings.log_to_file = ImGui.Checkbox("Save log to extra separate files", _Grinder.settings.log_to_file)
	_, _Grinder.settings.log_buffer = ImGui.Checkbox("Allow buffer for log (Better FPS)", _Grinder.settings.log_buffer)

	UI.Separator()
	UI.Text("Other:")
	UI.Text("Skip pulses (Use with caution!)")
	UI.SameLine()
	ImGui.PushItemWidth(200)
	_, _Grinder.settings.work_on_ever_x_pulse = ImGui.InputInt("##work_on_ever_x_pulse",
                                                           	_Grinder.settings.work_on_ever_x_pulse)
	ImGui.PopItemWidth()

	UI.Text("Delay after Arriving at target (ms)")
	UI.SameLine()
	ImGui.PushItemWidth(150)
	_, _Grinder.settings.delay_battle_by_ms = ImGui.InputInt("##delay_battle_by_ms", _Grinder.settings.delay_battle_by_ms)
	ImGui.PopItemWidth()

	UI.Text("Delay after killing a target (ms)")
	UI.SameLine()
	ImGui.PushItemWidth(150)
	_, _Grinder.settings.delay_after_battle_by_ms = ImGui.InputInt("##delay_after_battle_by_ms",
                                                               	_Grinder.settings.delay_after_battle_by_ms)
	ImGui.PopItemWidth()

	UI.Separator()
	UI.Text("Hotkey:")

	local changedHotkey = false
	_Grinder.settings.hotkeys.startstop, changedHotkey = UI.keySelector("Start GrindBuddy",
                                                                    	_Grinder.settings.hotkeys.startstop, true)
	if (changedHotkey) then
		Grinder.registerHotkeys()
	end
	_Grinder.settings.hotkeys.stop, changedHotkey = UI.keySelector("Stop GrindBuddy", _Grinder.settings.hotkeys.stop, true)
	if (changedHotkey) then
		Grinder.registerHotkeys()
	end
	_Grinder.settings.hotkeys.addGrindspot, changedHotkey = UI.keySelector("Add Grindspot",
                                                                       	_Grinder.settings.hotkeys.addGrindspot, true)
	if (changedHotkey) then
		Grinder.registerHotkeys()
	end

	UI.Separator()
	UI.Text("Input:")

	ImGui.PushItemWidth(150)
	_, _Grinder.settings.secureInput = ImGui.Checkbox("Safe Input Mode (slower)##secure_input_mode",
                                                  	_Grinder.settings.secureInput)
	ImGui.PopItemWidth()

	ImGui.PushItemWidth(150)
	_, _Grinder.settings.allow_waiting_for_key_reset = ImGui.Checkbox(
                                                   		"Wait For Key Up After Skill Usage Before Doing Anything##secure_input_mode_allow_wait_for_reset",
                                                   		_Grinder.settings.allow_waiting_for_key_reset)

	local changedCameraToMovement = false
	changedCameraToMovement, _Grinder.settings.camera_to_movement =
		ImGui.Checkbox("Camera follows Player Rotation##move_camera_player_movement", _Grinder.settings.camera_to_movement)
	if changedCameraToMovement then
		_Grinder.settings.use_keyflag = false
	end

	_, _Grinder.settings.skillUse_delay = ImGui.SliderInt("Delay after Skill use##skillUse_delay",
                                                      	_Grinder.settings.skillUse_delay, 25, 500)

	local changedKeyflag = false
	changedKeyflag, _Grinder.settings.use_keyflag = ImGui.Checkbox("Use Key flag for Input##use_keyflag",
                                                               	_Grinder.settings.use_keyflag)
	if changedKeyflag then
		_Grinder.settings.camera_to_movement = false
		_Grinder.settings.camera_real_swing = false
	end

	ImGui.PopItemWidth()

	if newWindow then
		ImGui.PopStyleColor(3)
		ImGui.End()
	end
end
