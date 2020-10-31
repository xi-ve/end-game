MainWindow = { }
MainWindow.AvailablesRoutines = {}
MainWindow.Routines_SelectedIndex = 1

function MainWindow.DrawMainWindow()
	local valueChanged = false

    ImGui.Begin("Grinder")
    
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

    local btnText = "Start"

    if Grinder.Running then
        btnText = "Stop"
    end

    if ImGui.Button(btnText) then
        if Grinder.Running then
            Grinder.StopBot()
        else
            Grinder.StartBot()
        end
    end

    if ImGui.Button("Show Navigator") then

        if not Grinder.Navigator.ShowGui then

            Grinder.Navigator.ShowGui = true
        end
    end

    valueChanged, MainWindow.Routines_SelectedIndex = ImGui.Combo("Combat Routine##id_combat_routine", table.findIndex(MainWindow.AvailablesRoutines, Grinder.Settings.LastRoutine), MainWindow.AvailablesRoutines)

    if valueChanged then
        Grinder.Settings.LastRoutine = MainWindow.AvailablesRoutines[MainWindow.Routines_SelectedIndex]
        print("Combat Routine selected : " .. Grinder.Settings.LastRoutine)

        Grinder.LoadRoutine()
        Grinder.SaveSettings()
    end

    valueChanged, Grinder.Settings.UseTpNav = ImGui.Checkbox("Use TP Nav##use_tp_nav", Grinder.Settings.UseTpNav)

    if valueChanged == true then
        Grinder.SaveSettings()
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