MainWindow = { }

function MainWindow.DrawMainWindow()
    ImGui.Begin("OutfitExtraction")
            
    ImGui.SetWindowSize(ImVec2(100,50), ImGuiCond_FirstUseEver)

    if ImGui.Button("Extract CronStones (All not bound Pearl Outfits will get destroyed!)") then
        OutfitExtraction.extract_allCronStones()
    end

    ImGui.End()
end