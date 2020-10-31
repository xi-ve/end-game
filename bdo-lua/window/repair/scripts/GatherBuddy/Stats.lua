local Math = MagLib.Utils.Math

local settings = {doTracking = true}
MagLib.Core.Settings.addSettingsToHandler("GatherBuddy_Stats", settings)
MagLib.BDO.Events.ExpChanged.activate()

-- statics
local gatherCraftType = MagLib.BDO.Enums.CraftType.gather

-- Stats global table
local stats = {}
stats.reset = function()
	stats.initTime = MagLib.getTime()
	stats.lootedItems = {}
	stats.expGained = 0
	stats.expPerHourPct = 0
	stats.untilLevelUpTimeString = "Forever"
	stats.gatherLevelString = MagLib.BDO.Enums.LifeskillLevelStrings[MagLib.BDO.Actors.LocalPlayer.getCraftLevel(
                          		gatherCraftType)]
	stats.gatherExpPct = Math.round(MagLib.BDO.Actors.LocalPlayer.getCraftExpPercent(gatherCraftType), 2)
end
stats.reset()

local onItemsLooted = function(itemsLooted)
	if not settings.doTracking then
		return
	end

	local itemKey
	for _, itemData in pairs(itemsLooted) do
		itemKey = itemData.itemKey
		if not stats.lootedItems[itemKey] then
			stats.lootedItems[itemKey] = {count = 0, lastTime = 0, name = itemData.name}
		end

		stats.lootedItems[itemKey].count = stats.lootedItems[itemKey].count + itemData.count
		stats.lootedItems[itemKey].lastTime = MagLib.getTime()
	end
end
MagLib.Events.addEventHandler("ItemsLooted", onItemsLooted)

local onLifeSkillExpChanged = function(info)
	if info.craftType ~= gatherCraftType then
		return
	end
	stats.gatherLevelString = MagLib.BDO.Enums.LifeskillLevelStrings[info.newLevel]
	stats.gatherExpPct = Math.round(info.newPct, 2)
	stats.expGained = stats.expGained + info.expChanged
	local msRunning = (MagLib.getTime() - stats.initTime)
	local expGainedPerMs = (stats.expGained / msRunning)
	stats.expPerHourPct = Math.round((expGainedPerMs * 3600000) / info.newMaxExp * 100, 2)
	local msUntilLevelUp = (info.newMaxExp - info.newExp) / expGainedPerMs
	stats.untilLevelUpTimeString = MagLib.Utils.Time.msToTimeString(msUntilLevelUp)
end

MagLib.Events.addEventHandler("LifeSkillExpChanged", onLifeSkillExpChanged)
Stats = stats
