local UI = MagLib.UI
local Math = MagLib.Utils.Math

DrawStatsTab = function()
    local settings = MagLib.Core.Settings.getSetting("GatherBuddy_Stats")

    settings.doTracking = UI.Checkbox("Track Stats", settings.doTracking, Stats.reset)

    if settings.doTracking then 
        --Gather exp
        UI.Text("Gatherlevel: " .. Stats.gatherLevelString .. " " .. Stats.gatherExpPct .. "%%")
        UI.Text("Per Hour: " .. Stats.expPerHourPct .. " %%")
        UI.Text("Until next levelup: " .. Stats.untilLevelUpTimeString)

        --Looted items
        UI.Columns(4, {100, 150, 100, 100}, {"Item key", "Name", "Amount", "Per Hour"})
        local lootedItems = Stats.lootedItems
        local timePast = MagLib.getTime() - Stats.initTime
        for itemKey, lootStats in pairs(lootedItems) do 
            --Item Key
            UI.Text(itemKey)
            UI.NextColumn()
            --Item Name
            UI.Text(lootStats.name)
            UI.NextColumn()
            --Amount
            UI.Text(lootStats.count)
            UI.NextColumn()
            --Per hour
            UI.Text(Math.round((lootStats.count/timePast)*3600000, 1))
            UI.NextColumn()
        end

        UI.EndColumns()
    end
end