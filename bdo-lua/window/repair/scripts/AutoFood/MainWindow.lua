MainWindow = { }

function MainWindow.DrawMainWindow()
	local valueChanged = false

    ImGui.Begin("AutoFood")
        
    ImGui.SetWindowSize(ImVec2(1400,500), ImGuiCond_FirstUseEver)

    local btnText = "Start"

    if AutoFood.Running == true then
        btnText = "Stop"
    end

    if ImGui.Button(btnText) then
        if AutoFood.Running == true then
            AutoFood.StopBot()
        else
            AutoFood.StartBot()
        end
    end

    ImGui.Spacing()
    ImGui.Spacing()

    if ImGui.Button("New Conditional Buff##new_condition") then
        if not NewConditionWindow.Show then
            NewConditionWindow.Show = true

            AutoFood.StopBot()
        end
    end

    ImGui.Spacing()

    ImGui.Columns(4)

    ImGui.SetColumnWidth(0,65)
    ImGui.SetColumnWidth(1,250)
    ImGui.SetColumnWidth(2,1000)
    ImGui.SetColumnWidth(3,65)

    ImGui.Text("Enabled")
    ImGui.NextColumn()
    ImGui.Text("Item")
    ImGui.NextColumn()
    ImGui.Text("Conditions")
    ImGui.NextColumn() 
    ImGui.Text("Remove")
    ImGui.NextColumn() 

    for k,v in pairs(AutoFood.Settings.ConditionalBuffs) do
        
        local checkedChanged = false
        checkedChanged, v.Enabled = ImGui.Checkbox("##id_condition_enabled_" .. k, v.Enabled)        

        if checkedChanged then
            valueChanged = true
            AutoFood.StopBot()
        end

        ImGui.NextColumn()
        ImGui.Text(v.Name)
        ImGui.NextColumn()
        ImGui.Text(MainWindow.tableToString(v.Conditions))
        ImGui.NextColumn() 

        if ImGui.Button("X##conditional_buff_remove_" .. k) then
            table.remove(AutoFood.Settings.ConditionalBuffs, k)

            valueChanged = true
            break
        end
        ImGui.NextColumn() 

    end

    if valueChanged == true then
        AutoFood.SaveSettings()
    end

    ImGui.End()
end

function MainWindow.tableToString(t)
    local s = ""

    for k,v in pairs(t) do
        if s:len() == 0 then
            s = v.Condition .. "(" .. table.combinestring(v.Value, ";") .. ")"
        else
            s = s .. " and " .. v.Condition .. "(" .. table.combinestring(v.Value, ";") .. ")"
        end
    end

    return s
end