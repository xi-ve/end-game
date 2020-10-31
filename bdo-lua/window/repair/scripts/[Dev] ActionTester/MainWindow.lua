MainWindow = { }

function MainWindow.DrawMainWindow()    
    ImGui.Begin("ActionTester")
        
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)
        
    if ImGui.TreeNode("Action Log##actiontester_action_log") then

        if ImGui.SmallButton("Clear") then
            ActionTester.Cache_Actions = {}
        end

        for k,actionObject in pairs(ActionTester.Cache_Actions) do
        
            ImGui.Text(actionObject.Name)

            ImGui.SameLine()

            if ImGui.SmallButton("Set##action_set_" .. k) then
                Infinity.BDO.ActionBranchManager.queueNextAction(actionObject.Branch)
            end

            ImGui.SameLine()

            if ImGui.SmallButton("Queue##action_queue_" .. k) then
                table.insert(ActionTester.Queue_Actions, actionObject)
            end
        end
        ImGui.TreePop()
    end

    if ImGui.TreeNode("Action Queue##actiontester_action_queue") then

        ImGui.Columns(2)
        ImGui.SetColumnWidth(0, 50)
        ImGui.SetColumnWidth(1, 450)

        ImGui.Text("")
        ImGui.NextColumn()
        ImGui.Text("Action")
        ImGui.NextColumn()

        for k,actionObject in pairs(ActionTester.Queue_Actions) do
        
            if ImGui.SmallButton("X##delete_queue_item_" .. k) then
                table.remove(ActionTester.Queue_Actions, k)
                break
            end

            ImGui.NextColumn()
            ImGui.Text(actionObject.Name)
            ImGui.NextColumn()
        end
        
        ImGui.Columns(1)
        ImGui.TreePop()
    end
    
    ImGui.End()
end