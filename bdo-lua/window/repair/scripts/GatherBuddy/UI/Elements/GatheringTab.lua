local UI = MagLib.UI

DrawGatheringTab = function()
    local clearToolSettings = MagLib.Core.Settings.getSetting("GatheringHelper_ClearInventoryTools")
    clearToolSettings.destroyBrokenTools = UI.Checkbox("Destroy broken tools", clearToolSettings.destroyBrokenTools)
end