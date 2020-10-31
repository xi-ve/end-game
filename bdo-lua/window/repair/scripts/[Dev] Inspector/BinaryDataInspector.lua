BinaryDataInspector = { }
BinaryDataInspector.Draw = false
BinaryDataInspector.FileName = ""
BinaryDataInspector.Data = nil

function BinaryDataInspector.DrawMainWindow()
    ImGui.Begin("BinaryDataInspector")
        
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

    if BinaryDataInspector.Data ~= nil then
    	ImGui.Text(BinaryDataInspector.FileName)

    	ImGuiMemoryEditor.Draw(BinaryDataInspector.Data)
    end

    ImGui.End()
end