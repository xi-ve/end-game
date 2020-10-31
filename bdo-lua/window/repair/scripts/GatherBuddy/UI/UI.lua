local UI = MagLib.UI

local menuBar = MagLib.UI.MenuBar()
menuBar.addTab("Home", DrawHomeTab)
menuBar.addTab("Profile", DrawProfileTab)
menuBar.addTab("Gathering",DrawGatheringTab)
menuBar.addTab("Combat", DrawCombatTab)
menuBar.addTab("Render", DrawRenderTab)
menuBar.addTab("Navigation", DrawNavigationTab)
menuBar.addTab("Looting", DrawLootingTab)
menuBar.addTab("Stats", DrawStatsTab)

local drawUI = function()
    --Push minimum window size
    ImGui.PushStyleVar2(ImGuiStyleVar_WindowMinSize, ImVec2(700, 300))

    UI.newWindow("GatherBuddy V" .. GatherBuddy.version, nil,  ImGuiWindowFlags_MenuBar)

    --Menu Bar
    menuBar.drawMenuBar()

    local settings = MagLib.Core.Settings.getSetting("GatherBuddy")
    --Start/Stop Button
    local text
    if GatherBuddy.running then 
        text = "Stop"
    else 
        text = "Start"
    end
    if UI.SimpleButton(text, "FF4ef542") then
        if GatherBuddy.running then 
            GatherBuddy.stop()
        else
            GatherBuddy.start()
        end
    end
    UI.SameLine(nil, 590)
    if UI.SimpleButton("Exit##script_exit_btn") then 
        MagLib.endScript()
    end

    ImGui.Separator()
    menuBar.drawCurrentTab()

    UI.endWindow()

    ImGui.PopStyleVar(1)
end

local draw = true
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", function()
    if not draw then return end

    MagLib.Core.Try(drawUI, function()
        draw = false
    end, false)
end)