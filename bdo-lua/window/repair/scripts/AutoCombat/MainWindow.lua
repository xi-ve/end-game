MainWindow = { }
MainWindow.AvailablesRoutines = {}
MainWindow.Routines_SelectedIndex = 1

function MainWindow.DrawMainWindow()
	local valueChanged = false

    ImGui.Begin("AutoCombat")

    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

    valueChanged, MainWindow.Routines_SelectedIndex = ImGui.Combo("Combat Routine##id_combat_routine", table.findIndex(MainWindow.AvailablesRoutines, AutoCombat.Settings.LastRoutine), MainWindow.AvailablesRoutines)

    if valueChanged then
        AutoCombat.Settings.LastRoutine = MainWindow.AvailablesRoutines[MainWindow.Routines_SelectedIndex]
        print("Combat Routine selected : " .. AutoCombat.Settings.LastRoutine)

        AutoCombat.LoadRoutine()
        AutoCombat.SaveSettings()
    end
    
    ImGui.End()
end

function MainWindow.RefreshAvailableCombatRoutines()
    MainWindow.AvailablesRoutines = { }

    for k, v in pairs(Infinity.FileSystem.GetFiles("Routines\\*.lua")) do
        table.insert(MainWindow.AvailablesRoutines, v)

    end
end

MainWindow.RefreshAvailableCombatRoutines()