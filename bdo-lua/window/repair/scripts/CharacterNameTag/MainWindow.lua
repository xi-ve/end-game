MainWindow = { }

function MainWindow.DrawMainWindow()
    local valueChanged = false

    ImGui.Begin("[Lua Mod] CharacterNameTag")
    
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

    for k,var in pairs(App.Settings.Vars) do
        
        valueChanged, var.Value = ImGui.Checkbox(var.VarName .. "##id_var_" .. k, var.Value)

        if valueChanged then
            break
        end
    end

    if valueChanged then
        App.SaveSettings()

        App.applyVars()
    end

    ImGui.End()
end