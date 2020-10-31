local settings = {blacklist = {}}
MagLib.Core.Settings.addSettingsToHandler("GatherBuddy_LootingModule", settings)

local shouldLoot = function(itemData)
	for _, blacklistedItemData in pairs(settings.blacklist) do
		if blacklistedItemData.itemKey == itemData.itemKey then
			return false
		end
	end

	return true
end

LootingUtils = {}

---Handles looting
---@return boolean true if something was looted, else false
local handleLooting = function()
	if GatherBuddy.running and MagLib.BDO.Looting.isLootingWindowOpen() then
		MagLib.BDO.Looting.lootAllWithFilter(shouldLoot)
	end
end

LootingModule = MagLib.Run.Modules.RunModule("LootingModule", 75, 150, MagLib.Run.Modules.TimingMode.Exact,
                                             MagLib.Run.EPulseTimingMode.Beginning)
LootingModule.run = handleLooting
LootingModule.start()
MagLib.Run.Modules.Handler.addModule(LootingModule)
