MainWindow = { }

function MainWindow.DrawMainWindow()
	local valueChanged = false

    ImGui.Begin("TargetLock")
            
    ImGui.SetWindowSize(ImVec2(400,200), ImGuiCond_FirstUseEver)

    local infoText = "Started"

    if not TargetLock.Running then
    	infoText = "Stopped"
    end

    ImGui.Text("State: " .. infoText)

    valueChanged, TargetLock.Settings.SelectedVKeyIndex = ImGui.Combo("Hotkey##hotkey", TargetLock.Settings.SelectedVKeyIndex, VirtualKeys.NamesTable)

    if valueChanged then
    	TargetLock.SaveSettings()
    end

    ImGui.End()
end