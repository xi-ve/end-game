MainWindow = { }

local exampleImage = Infinity.Rendering.LoadTextureFromImageFile(Infinity.Scripting.CurrentScript.Directory .. "Images\\logo_lua.png")
local exampleColor = ImVec4(1.0,1.0,0.0,1.0)

function MainWindow.DrawMainWindow()
    ImGui.PushStyleVar1(ImGuiStyleVar_WindowRounding, 10)
    ImGui.PushStyleVar2(ImGuiStyleVar_WindowMinSize, ImVec2(300,200))

    ImGui.Begin("Template")
        
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)
    
    ImGui.PushStyleColor2(ImGuiCol_Text, ImVec4(1, 0.5, 0, 1))
    ImGui.PushStyleColor2(ImGuiCol_Button, ImVec4(0, 0.5, 0, 1))
   
    if ImGui.Button("Log Output") then
      print("Log Output from Template!")
    end

    ImGui.PopStyleColor(2)

    ImGui.PushStyleColor2(ImGuiCol_Text, ImVec4(0, 0.5, 0, 1))
    ImGui.PushStyleColor2(ImGuiCol_Button, ImVec4(1, 0.5, 0, 1))

    if ImGui.Button("Chat Output") then
    	Infinity.BDO.Lua.Execute("Proc_ShowMessage_Ack('Chat Output from Template!')")
    end
    
    ImGui.PopStyleColor(2)

    local bdoLuaMem = Infinity.BDO.Lua.Execute("return (collectgarbage('count')/1024)")

    ImGui.Text("BDO's Lua Mem Usage: " .. bdoLuaMem .. " MB")

    if ImGui.Button("Test Input2") then
        Infinity.BDO.Input.PressKeys_Once({KeyCode_SPACE}, 50)
    end
        
    if ImGui.Button("Test Action") then
        Actor.setAction("WAIT")
    end
       
    --if ImGui.Button("Test UseSkill") then
        --Infinity.BDO.getLocalPlayer():useSkill(124321793)
    --end

    _, Template.MeshScanDistance = ImGui.SliderFloat("Scan Distance##scan_distance", Template.MeshScanDistance, 100, 20000)
    _, Template.MeshScanSegments = ImGui.SliderInt("Scan Segments##scan_segments", Template.MeshScanSegments, 50, 1000)

    if ImGui.Button("Scan Mesh") then
        Template.ScanMesh()
    end

    ImGui.SameLine()

    if ImGui.Button("Clear Mesh") then
        Template.ClearMesh()
    end

    ImGui.Image(exampleImage, ImVec2(50,50), ImVec2(0,0), ImVec2(1,1), ImVec4(1,1,1,1), ImVec4(0,0,0,0))

    ImGui.SameLine()

    ImGui.Image(exampleImage, ImVec2(50,50), ImVec2(0.5,0.5), ImVec2(1,1), ImVec4(1,1,1,1), ImVec4(0,0,0,0))

    if ImGui.ColorEdit4("ExampleColorEdit", exampleColor, ImGuiColorEditFlags_NoInputs) then
        print("Example Color changed!")
    end

    ImGui.End()

    
    ImGui.PopStyleVar(2)
end