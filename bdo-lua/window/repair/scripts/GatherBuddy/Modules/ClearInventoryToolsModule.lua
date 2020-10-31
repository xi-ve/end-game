local settings = {destroyBrokenTools = false}
MagLib.Core.Settings.addSettingsToHandler("GatheringHelper_ClearInventoryTools", settings)
local toolType = MagLib.BDO.Inventory.EquipType.Tool

ClearInventoryToolsModule = MagLib.Run.Modules.RunModule("ClearInventoryToolsModule", 350, 700,
                                                         MagLib.Run.Modules.TimingMode.TimedNonCritical,
                                                         MagLib.Run.EPulseTimingMode.End)
ClearInventoryToolsModule.run = function()
	if not GatherBuddy.running or not settings.destroyBrokenTools then
		return
	end

	-- Iterator over inventory
	local iteratorFunc = function(itemData)
		if itemData.equipType == toolType and itemData.dura <= 0 and not itemData.isRepairable then
			Inventory.deleteItem(itemData.slot)
			MagLib.wait(200)
			return true
		end
		return false
	end
	MagLib.BDO.Inventory.iterator(iteratorFunc)
end
ClearInventoryToolsModule.start()
MagLib.Run.Modules.Handler.addModule(ClearInventoryToolsModule)
