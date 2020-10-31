local UI = MagLib.UI

DrawLootingTab = function()
    local lootSettings = MagLib.Core.Settings.getSetting("GatherBuddy_LootingModule")

    --Blacklist 
    MagLib.UI.Inventory.drawItemTableSelector("Blacklist:", "gatherbuddy_looting_blacklist", lootSettings.blacklist, 0, true)
end