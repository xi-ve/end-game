MainWindow = { }

function MainWindow.DrawMainWindow()
	local valueChanged = false

    ImGui.Begin("PetFeed")
    
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)
    
    valueChanged, PetFeed.Settings.CheckInterval = ImGui.SliderInt("Check Interval (Minutes)##check_interval", PetFeed.Settings.CheckInterval, 1, 60)

    if valueChanged then
    	PetFeed.SaveSettings()
    end

    ImGui.End()
end