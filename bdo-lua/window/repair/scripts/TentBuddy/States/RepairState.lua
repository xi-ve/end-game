RepairState = MagLib.Run.States.State("RepairState")

function RepairState:work()
	local repairSettings = MagLib.Core.Settings.getSetting("TentBuddy").repair
	if repairSettings.enabled then
		MagLib.BDO.Tent.repairAllEquipped()
		if repairSettings.repairInventoryItems then
			MagLib.BDO.Tent.repairAllInventoryItems()
		end
	end
	return true
end
