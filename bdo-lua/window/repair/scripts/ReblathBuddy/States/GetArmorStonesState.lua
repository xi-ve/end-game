local work = function(self)
	local settings = MagLib.Core.Settings.getSetting("ReblathBuddy")

	local minStones = settings.minStonesBeforeCheckingStorage
	local stonesWanted = settings.stonesToKeep
	local stoneKey = ReblathBuddy.stoneKey

	local currentAmount = MagLib.BDO.Inventory.getItemCount_Quick(stoneKey)
	if currentAmount >= minStones then
		return true
	end

	if currentAmount < minStones then
		local wStoneCount = Warehouse.getItemDataByItemId(stoneKey, Warehouse.getCurrentWaypointKey())
		if wStoneCount == 0 then
			if currentAmount > 0 then
				return true
			else
				ReblathBuddy.logger.error("No more stones in the warehouse.")
				ReblathBuddy.running = false
				return false
			end
		end

		local npcData = MagLib.BDO.Navigation.Graph.Profiles.currentProfile.npcs["Storage"][1]
		local atNPC = MagLib.BDO.Navigation.activeMoveToNpc(npcData, 250)
		if atNPC then
			local actorId = 40044
			local npcActor = MagLib.BDO.Actors.getActorWithId(actorId, EActorType_Npc)
			local stonesNeeded = stonesWanted - currentAmount
			ReblathBuddy.logger.info("Getting " .. stonesNeeded .. " stones from the storage")
			MagLib.BDO.Warehouse.withdraw(npcActor, stoneKey, stonesNeeded, false)
			self.wait(250)
		end
	end

	return false
end

GetArmorStonesState = MagLib.Run.States.State("GetArmorStonesState", work)
