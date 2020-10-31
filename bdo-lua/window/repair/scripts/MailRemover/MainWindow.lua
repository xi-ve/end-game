MainWindow = { }

function MainWindow.DrawMainWindow()
    ImGui.Begin("MailRemover")
            
    ImGui.SetWindowSize(ImVec2(100,50), ImGuiCond_FirstUseEver)

    if ImGui.Button("Clean Mails") then
        MailRemover.cleanMails()
    end

    ImGui.End()
end