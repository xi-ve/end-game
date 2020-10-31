MainWindow = { }

function MainWindow.DrawMainWindow()
    local valueChanged = false

    ImGui.Begin("UserMods")
    
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

    if ImGui.CollapsingHeader("Abilities##id_abilities") then
        
        for k,v in pairs(UserMods.Settings.Abilities) do
            
            if v.Name == "Gathering" then

              valueChanged, v.Enabled = ImGui.Checkbox("##id_ability_enabled_" .. k, v.Enabled)
              ImGui.SameLine()
              valueChanged, v.Value = ImGui.SliderInt("##ability_value_" .. k, v.Value, v.MinValue, v.MaxValue)
              ImGui.SameLine()
              ImGui.Text(v.Name)
            end
        end        
    end

    --[[if ImGui.CollapsingHeader("Resistances##id_resistances") then
        
        for k,v in pairs(UserMods.Settings.Resistances) do
            
            valueChanged, v.Enabled = ImGui.Checkbox("##id_resistance_enabled_" .. k, v.Enabled)
            ImGui.SameLine()
            valueChanged, v.Value = ImGui.SliderInt("%##resistance_value_" .. k, v.Value, v.MinValue, v.MaxValue)
            ImGui.SameLine()
            ImGui.Text(v.Name)
        end        
    end]]--

    if ImGui.CollapsingHeader("Production Time Reduces##id_productions") then
        
        for k,v in pairs(UserMods.Settings.Productions) do
            
            valueChanged, v.Enabled = ImGui.Checkbox("##id_productions_enabled_" .. k, v.Enabled)
            ImGui.SameLine()
            valueChanged, v.Value = ImGui.SliderFloat("sec Reduce##productions_value_" .. k, v.Value, v.MinValue, v.MaxValue)
            ImGui.SameLine()
            ImGui.Text(v.Name)
        end        
    end

    if ImGui.CollapsingHeader("Other##id_other") then
        
        for k,v in pairs(UserMods.Settings.Others) do
            
            if v.Name == "Jump Height" then
            valueChanged, v.Enabled = ImGui.Checkbox("##id_other_enabled_" .. k, v.Enabled)
            ImGui.SameLine()
            valueChanged, v.Value = ImGui.SliderFloat("%##other_value_" .. k, v.Value, v.MinValue, v.MaxValue)
            ImGui.SameLine()
            ImGui.Text(v.Name)
          end
        end        
    end

    if ImGui.CollapsingHeader("Diving##id_diving") then
        
        valueChanged, UserMods.Settings.Diving.UnlimitedBreath = ImGui.Checkbox("UnlimitedBreath##id_diving_unlimited_breath", UserMods.Settings.Diving.UnlimitedBreath)

        --if ImGui.Button("Unstuck Swimming") then

            --BreathGaugeStateChangeAck():construct(Infinity.BDO.getLocalPlayer():getActorKey(),0,0).Packet:receive()
        --end
    end

    if ImGui.CollapsingHeader("UI-Mods##id_ui_mods") then
                
        if ImGui.Button("Patch ToolTip Skill") then
            MainWindow.patch_ToolTip_Skill()            
        end

        if ImGui.Button("Patch ToolTip Item") then
            MainWindow.patch_ToolTip_Item()            
        end
    end

    if valueChanged then
        UserMods.SaveSettings()
    end

    ImGui.End()
end

function MainWindow.patch_ToolTip_Skill()
    local code = Infinity.FileSystem.ReadFile("Patches/ToolTip_Skill.lua")
    local retval = Infinity.BDO.Lua.Execute(code)
    if retval == nil then 
      print("nil")
    elseif retval == 123 then 
      print("success")
    else
      print(retval)
    end
end

function MainWindow.patch_ToolTip_Item()
    local code = Infinity.FileSystem.ReadFile("Patches/ToolTip_Item.lua")

    Infinity.BDO.Lua.Execute(code)
end