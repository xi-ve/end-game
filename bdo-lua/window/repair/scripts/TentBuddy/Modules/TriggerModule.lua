TriggerModule = MagLib.Run.Modules.RunModule("TriggerModule", 250, 1000, MagLib.Run.Modules.TimingMode.TimedCritical,
                                             MagLib.Run.EPulseTimingMode.Beginning)

local settings = nil

local repairNeededResult = false
local equipRepairNeededIterator = function(item)
	if item.slot ~= MagLib.BDO.Inventory.EquipmentSlots.AlchemyStone and item:isDamaged() and item.isRepairable and
		item.dura <= settings.repair.triggerDurability then
		repairNeededResult = true
		return true
	end
end

local inventoryRepairNeededIterator = function(item)
	if not item.isAlchemyStone and item:isDamaged() and item.isRepairable and item.dura <=
		settings.repair.triggerDurability then
		repairNeededResult = true
		return true
	end
end

function TriggerModule:run()
	-- Checking all possible triggers for the tent procedure.
	if settings == nil then
		settings = MagLib.Core.Settings.getSetting("TentBuddy")
	end

	if not settings.started then
		return
	end

	if IsInTentProcedure() then
		return
	end

	-- Repair
	if settings.repair.enabled then
		repairNeededResult = false
		MagLib.BDO.Inventory.equipmentIterator(equipRepairNeededIterator)

		if repairNeededResult then
			Logger.info("Triggering Tent Procedure due to low equipment durability")
			TriggerTentProcedure()
			return
		end

		if settings.repair.repairInventoryItems then
			repairNeededResult = false
			MagLib.BDO.Inventory.iterator(inventoryRepairNeededIterator)

			if repairNeededResult then
				Logger.info("Triggering Tent Procedure due to low durability of an item in your inventory")
				TriggerTentProcedure()
				return
			end
		end
	end

	-- Shop -> Pots
	if settings.buyConfig.potions.enabled then
		for _, potInfo in pairs(settings.buyConfig.potions.pots) do
			if potInfo.enabled and MagLib.BDO.Inventory.getItemCount_Quick(potInfo.itemId) <= potInfo.triggerAmount then
				Logger.info("Triggering Tent Procedure due to low potion amount of potion " .. tostring(potInfo.itemId))
				TriggerTentProcedure()
				return
			end
		end
	end

	-- Shop -> ItemBuffs
	-- Shop -> ItemBuffs -> confidenceBuff
	if settings.buyConfig.itemBuffs.enabled then
		if settings.buyConfig.itemBuffs.confidenceBuff_enabled and
			not MagLib.BDO.Buffs.hasCollidingBuff(settings.buyConfig.itemBuffs.confidenceBuff_buffKey) then
			Logger.info("Triggering Tent Procedure due to missing confidence buff")
			TriggerTentProcedure()
			return
		end
		-- Shop -> ItemBuffs -> dropBuffs
		for _, buffInfo in pairs(settings.buyConfig.itemBuffs.dropBuffs) do
			if buffInfo.enabled then
				if not MagLib.BDO.Buffs.hasCollidingBuff(buffInfo.buffKey) then
					Logger.info("Triggering Tent Procedure due to missing drop buff")
					TriggerTentProcedure()
					return
				end
				break -- only one can be enabled
			end
		end
	end

	-- Villa buffs
	if settings.villaBuffs.enabled then
		for buffIndex, buffInfo in pairs(settings.villaBuffs.buffs) do
			if buffInfo.enabled then
				if not MagLib.BDO.Buffs.hasCollidingBuff(MagLib.BDO.Villa.buffs[buffIndex].buffKey) then
					Logger.info("Triggering Tent Procedure due to missing villa buff")
					TriggerTentProcedure()
					return
				end
				break -- only one can be enabled
			end
		end
	end

end

TriggerModule.start()
MagLib.Run.Modules.Handler.addModule(TriggerModule)
