MainWindow = { }

function MainWindow.DrawMainWindow()
	local valueChanged = false

    ImGui.Begin("AutoPuzzle")
        
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)
        
    local btnText = "Start"

    if AutoPuzzle.Running == true then
        btnText = "Stop"
    end

    if ImGui.Button(btnText) then
        if AutoPuzzle.Running == true then
            AutoPuzzle.StopBot()
        else
            AutoPuzzle.StartBot()
        end
    end
        
    valueChanged, AutoPuzzle.Settings.CombineRelics = ImGui.Checkbox("Combine Relics##id_relics", AutoPuzzle.Settings.CombineRelics)
    valueChanged, AutoPuzzle.Settings.CombineBooks = ImGui.Checkbox("Combine Books##id_books", AutoPuzzle.Settings.CombineBooks)
    valueChanged, AutoPuzzle.Settings.CombineScrolls = ImGui.Checkbox("Combine Scrolls##id_scrolls", AutoPuzzle.Settings.CombineScrolls)
    valueChanged, AutoPuzzle.Settings.CombineDolls = ImGui.Checkbox("Combine Dolls##id_dolls", AutoPuzzle.Settings.CombineDolls)
    valueChanged, AutoPuzzle.Settings.CombineEventItems = ImGui.Checkbox("Combine Event Items##id_eventitems", AutoPuzzle.Settings.CombineEventItems)
    valueChanged, AutoPuzzle.Settings.CombineUnderwaterRelic = ImGui.Checkbox("Combine Underwater Relic##id_UnderwaterRelic", AutoPuzzle.Settings.CombineUnderwaterRelic)
    
    if valueChanged then
        AutoPuzzle.SaveSettings()
    end

    ImGui.End()
end