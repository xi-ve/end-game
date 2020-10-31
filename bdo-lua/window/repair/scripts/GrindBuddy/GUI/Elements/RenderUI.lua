RenderUI = {}
local UI = MagLib.UI

function RenderUI.draw()
    --MagLib Theme Engine stuff
    UI.ThemeEngine.drawThemeSelector()
    UI.Separator()

    --Nav Render shit
    _, Grinder.settings.draw_navigation =
        ImGui.Checkbox("Render Navigation##bpt_render_nav", Grinder.settings.draw_navigation)
    if Grinder.settings.draw_navigation then
        _, Grinder.settings.renderT1 = ImGui.Checkbox("Render T1 Nodes##render_t1", Grinder.settings.renderT1)
        ImGui.SameLine()
        _, Grinder.settings.renderT2 = ImGui.Checkbox("Render T2 Nodes##render_t2", Grinder.settings.renderT2)
    end
    _, Grinder.settings.draw_navigation_numbers =
        ImGui.Checkbox(
        "Render Navigation Node Numbers##bpt_render_nav_numbers",
        Grinder.settings.draw_navigation_numbers
    )

    ImGui.Text("Render Distance: ")
    ImGui.SameLine()
    _, Grinder.settings.render_navigation_distance = ImGui.InputInt("", Grinder.settings.render_navigation_distance)

    _, Grinder.settings.draw_grindSpots =
        ImGui.Checkbox("Render Grindspots##bpt_render_gspot", Grinder.settings.draw_grindSpots)
    _, Grinder.settings.draw_grindArea =
        ImGui.Checkbox("Render Grindarea (CAUTION: FPS DROP)##bpt_render_gspot", Grinder.settings.draw_grindArea)
    _, Grinder.settings.draw_destination =
        ImGui.Checkbox("Render Destination##bpt_render_destination", Grinder.settings.draw_destination)
    _, Grinder.settings.draw_destination_path =
        ImGui.Checkbox(
        "Render Path To Destination##bpt_render_destination_path",
        Grinder.settings.draw_destination_path
    )
    _, Grinder.settings.draw_destination_collision_point =
        ImGui.Checkbox(
        "Render Raycast Collisions For Other Renders##bpt_render_collisions",
        Grinder.settings.draw_destination_collision_point
    )
    _, Grinder.settings.draw_freeMove_path =
        ImGui.Checkbox("Render Path When Freemoving##bpt_render_freemoving", Grinder.settings.draw_freeMove_path)
end

--Setting default theme
local themeSettings = MagLib.Core.Settings.getSetting("MagLib_Themes")
if themeSettings.lastLoadedThemeFilePath == "" then
    --Setting theme path
    themeSettings.lastLoadedThemeFilePath = "../MagLib\\UI\\ThemeEngine\\Themes\\GrindBuddy.MagLibTheme"
    --Reiniting MagLib ThemeEngine, it will load the lastLoadedThemeFilePath as theme and we just set the GB theme
    MagLib.UI.ThemeEngine.init()
end
