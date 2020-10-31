local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos

local work = function(self)
	local settings = MagLib.Core.Settings.getSetting("ReblathBuddy")

	local stackItemKey = ReblathBuddy.stackItemKey

	local stackItems = ReblathBuddy.getToEnhanceItems()
	local stackItemsNeeded = 0
	local needsRepair = false
	for k, v in pairs(stackItems) do
		local maxDura = v.maxDura
		local dura = v.dura
		if maxDura < 100 then
			local additionalStackItems = math.floor(((100 - maxDura) / 10))
			if (100 - maxDura) % 10 ~= 0 then
				additionalStackItems = additionalStackItems + 1
			end
			stackItemsNeeded = stackItemsNeeded + additionalStackItems
		end
		if dura < maxDura then
			needsRepair = true
		end
	end

	-- Are we done? All repairs done?
	if stackItemsNeeded == 0 and needsRepair == false then
		return true
	end

	local downgradeNpcData = MagLib.BDO.Navigation.Graph.Profiles.currentProfile.npcs["Downgrade"][1]
	local distanceToNpc = Vector3(downgradeNpcData.posX, downgradeNpcData.posY, downgradeNpcData.posZ):getDistance(
                      		getPPos())
	if distanceToNpc < 500 then
		-- Check if there is a level 15 item, if yes we jump to the downgrade state
		for k, v in pairs(stackItems) do
			local enhanceLevel = v.enhanceLevel
			if enhanceLevel == 15 then
				ReblathBuddy.mainStateManager.setState(DowngradeState) -- Setting DowngradeState, as we want to downgrade the last items
				return false -- Returning false to not overwrite the state again (would go one forward of DowngradeState)
			end
		end
	end

	-- Move to repair npc and repair
	local npcData = MagLib.BDO.Navigation.Graph.Profiles.currentProfile.npcs["Repair"][ReblathBuddy.repairNPCId]
	local atNPC = MagLib.BDO.Navigation.activeMoveToNpc(npcData, 250)
	if atNPC then
		local actorId = 40008
		if ReblathBuddy.repairNPCId == 2 then
			actorId = 40003
		end
		local npcActor = MagLib.BDO.Actors.getActorWithId(actorId, EActorType_Npc)

		local plusZeroStackItems = MagLib.BDO.Inventory.getAllPlusZeros(stackItemKey)
		local plusZeroStackItemsAmount = #plusZeroStackItems
		local freeSlots = Inventory.getFreeSlotCount()
		local inventoryFull = freeSlots == 0

		-- Buy more?
		local stackItemsToBuy = stackItemsNeeded - plusZeroStackItemsAmount
		if (stackItemsToBuy > 0 and inventoryFull == false) then
			local toBuyAmount = stackItemsToBuy
			local bufferDelay = 500
			if toBuyAmount > freeSlots then
				toBuyAmount = freeSlots
				bufferDelay = 0
			end
			ReblathBuddy.logger.info("Buying " .. toBuyAmount .. " stack items for repairing")
			MagLib.BDO.NPC.Shop.buy(npcActor, stackItemKey, toBuyAmount, 0, false)
			-- Wait a reasonable amount to allow it to buy everything
			local shopSettings = MagLib.Core.Settings.getSetting("MagLib_Shop")
			local delayTime = toBuyAmount * shopSettings.buyDelay + bufferDelay
			-- buyDelay is the amount of time it waits after every buy. So we can calculate an estimate time it will need + some buffer
			self.wait(delayTime)
			return false
		end

		-- Already enough stack items?
		if plusZeroStackItemsAmount >= stackItemsNeeded or (inventoryFull and plusZeroStackItemsAmount > 0) then
			-- Repair
			for index, stackItem in pairs(stackItems) do
				local maxDura = stackItem.maxDura
				if maxDura < 100 then
					local nextSub = MagLib.BDO.Inventory.getFirstPlusZero(stackItemKey)
					MagLib.BDO.NPC.Repair.repairMaxEndurance(npcActor, stackItem.slot, nextSub.slot, false)
					self.wait(100)
					return false
				end
			end
		end

		if inventoryFull and plusZeroStackItemsAmount == 0 then
			ReblathBuddy.logger.error("Inventory full and no plus zero stack items to use for repair")
			ReblathBuddy.running = false
			return false
		end

		if needsRepair then
			for k, v in pairs(stackItems) do
				local maxDura = v.maxDura
				local dura = v.dura
				if dura < maxDura then
					ReblathBuddy.logger.info("Repairing Item in slot " .. v.slot)
					MagLib.BDO.NPC.Repair.repairInInventory(npcActor, v.slot, false, nil)
					self.wait(500)
				end
			end
		end

	end
	return false

end

RepairState = MagLib.Run.States.State("RepairState", work)
