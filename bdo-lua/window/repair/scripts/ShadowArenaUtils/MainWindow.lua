MainWindow = { }

function MainWindow.DrawMainWindow()
	local valueChanged = false

    ImGui.Begin("ShadowArenaUtils")
        
    ImGui.SetWindowSize(ImVec2(500,300), ImGuiCond_FirstUseEver)
    
    valueChanged, ShadowArenaUtils.Settings.AutoLoot.Enabled = ImGui.Checkbox("AutoLoot Enabled##autoloot_enabled", ShadowArenaUtils.Settings.AutoLoot.Enabled)
    valueChanged, ShadowArenaUtils.Settings.AutoLoot.Delay = ImGui.SliderInt("AutoLoot Delay##autoloot_delay", ShadowArenaUtils.Settings.AutoLoot.Delay, 50, 1000)    
   
    ImGui.Spacing()

    valueChanged, ShadowArenaUtils.Settings.AutoEquip.Enabled = ImGui.Checkbox("AutoEquip Enabled##autoequip_enabled", ShadowArenaUtils.Settings.AutoEquip.Enabled)
    valueChanged, ShadowArenaUtils.Settings.AutoEquip.Delay = ImGui.SliderInt("AutoEquip Delay##autoequip_delay", ShadowArenaUtils.Settings.AutoEquip.Delay, 50, 1000)
    --valueChanged, ShadowArenaUtils.Settings.AutoEquip.ForceCancel = ImGui.Checkbox("AutoEquip Force Cancel##autoequip_forcecancel", ShadowArenaUtils.Settings.AutoEquip.ForceCancel)

    ImGui.End()

    if valueChanged then
    	ShadowArenaUtils.SaveSettings()
    end
end