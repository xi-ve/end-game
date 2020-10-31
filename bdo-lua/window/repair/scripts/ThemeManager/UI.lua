local UI = MagLib.UI
local defaultTheme = MagLib.UI.ThemeEngine.Theme("Default")
defaultTheme.style.color[ImGuiCol_WindowBg] = "FF111114"
defaultTheme.style.color[ImGuiCol_Button] = "FF365db3"
defaultTheme.style.color[ImGuiCol_Text] = "FFFFFFFF"


local newThemePopupOpen = false
local newThemePopupName = ""
local newThemePopupDraw = function(self)
    newThemePopupOpen = true
    newThemePopupName = UI.InputText("Theme name: ", newThemePopupName)
    if UI.SimpleButton("Create") then 
        if MagLib.UI.ThemeEngine.newTheme(newThemePopupName,"/Themes/", false) then
            self.close()
        end
    end
end

local drawThemeManagerUI = function()
    UI.newWindow("Theme Manager", defaultTheme)
    MagLib.UI.ThemeEngine.drawThemeSelector()
    UI.SameLine()
    if UI.SimpleButton("Save##save_theme") then
        MagLib.UI.ThemeEngine.saveTheme(MagLib.UI.ThemeEngine.currentTheme)
    end

    UI.SameLine()
    if UI.SimpleButton("New Theme") then 
        if not newThemePopupOpen then 
            newThemePopupName = ""
            UI.Popups.new("New Theme name", newThemePopupDraw)
        end
    end

    UI.Separator()

    DrawEditorUI()

    if UI.SimpleButton("Apply Theme to Infinity") then
        local currentTheme = MagLib.UI.ThemeEngine.currentTheme
        --Resetting theme
        Infinity.Theming.Reset()
        --Pushing all color vars
        for id, value in pairs(currentTheme.style.color) do 
            Infinity.Theming.AddStyleColor(id, ImGui.ColorConvertFloat4ToU32(RenderHelper.GetColorImVec4FromHexColorString(value)))
        end

        for id, value in pairs(currentTheme.style.var.number) do
            Infinity.Theming.AddStyleVar(id, value)
        end
    end

    if UI.SimpleButton("Reset Infinity Theme") then 
        Infinity.Theming.Reset()
    end

    UI.endWindow(defaultTheme)
end

local exampleText = ""
local exampleNumber = 0
local exampleFloat = 0.0
local exampleBool = false
local exampleComboContent = {"First Item", "Second Item", "Third Item"}
local exampleComboSelectedIndex = 0
local drawExampleUI = function()
    UI.newWindow("Example Window")
    if ImGui.BeginMenu("Example Menu", true) then 
        ImGui.MenuItem("Example Menu Item 1", "")
        ImGui.MenuItem("Example Menu Item 2", "")

        ImGui.EndMenu()
    end
    UI.Separator()

    UI.SimpleButton("Test")

    UI.Separator()
    
    UI.Text("This is a text")

    UI.Separator()

    exampleNumber = UI.SliderInt("SliderInt", exampleNumber, 0, 1000)
    exampleNumber = UI.InputInt("InputInt", exampleNumber)

    UI.Separator()

    exampleFloat = UI.SliderFloat("SliderFloat", exampleFloat, 0, 1000)
    exampleFloat = UI.InputFloat("InputFloat", exampleFloat)

    UI.Separator()

    exampleText = UI.InputText("InputText", exampleText)

    UI.Separator()

    exampleBool = UI.Checkbox("Checkbox", exampleBool)

    UI.Separator()

    exampleComboSelectedIndex = UI.Combo("Combo", exampleComboSelectedIndex, exampleComboContent)

    UI.endWindow()
end

local onGuiDraw = function()
    drawThemeManagerUI()
    if MagLib.UI.ThemeEngine.currentTheme then
        drawExampleUI()
    end
end



DrawUI = true
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", function()
    if DrawUI then 
        MagLib.Core.Try(onGuiDraw, function()
            DrawUI = false
        end)
    end
end)


Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", function()
    if MagLib.onPulse_Beginning() then return end 
    MagLib.onPulse_End()
end)