MainWindow = { }

function MainWindow.DrawMainWindow()
	local valueChanged = false

    ImGui.Begin("WorkerFeed")

    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

	valueChanged, WorkerFeed.Settings.RepeatAll = ImGui.Checkbox("Auto Repeat##auto_repeat_all", WorkerFeed.Settings.RepeatAll)    
    valueChanged, WorkerFeed.Settings.CheckInterval = ImGui.SliderInt("Check Interval (Minutes)##check_interval", WorkerFeed.Settings.CheckInterval, 1, 60)

    if valueChanged then
    	WorkerFeed.SaveSettings()
    end

    ImGui.End()
end