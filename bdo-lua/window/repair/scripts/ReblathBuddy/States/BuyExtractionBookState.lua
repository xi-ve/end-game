local work = function(self)
	local settings = MagLib.Core.Settings.getSetting("ReblathBuddy")

	local wantedAmount = settings.extractionBookAmount

	local needToExtractRightNow = settings.extractAt <= MagLib.BDO.Enhance.getFailstackCount()

	-- If we need to extract right now, we may just to buy one of the currently needed keys.
	-- Else we want to buy the wanted amount of books/fill up.

	local extractionBookKey = 0
	local extractionBookFailstackNumber = 0
	if needToExtractRightNow then
		extractionBookKey, extractionBookFailstackNumber = ReblathBuddy.getCurrentlyNeededExtractionBookKey()
		wantedAmount = 1 -- We only need one
	else
		extractionBookKey, extractionBookFailstackNumber = ReblathBuddy.getWantedExtractionBookKey()
	end

	if extractionBookKey == nil then
		ReblathBuddy.running = false
		ReblathBuddy.logger.error(
			"There is no book with enough failstacks to hold your currently wanted amount of failstacks/Failstacks you currently have!")
		return false
	end

	local currentAmount = MagLib.BDO.Inventory.getItemCount_Quick(extractionBookKey)
	if currentAmount == 0 and wantedAmount == 0 then
		ReblathBuddy.logger.info("Finished extractions and no books left!")
		ReblathBuddy.running = false
		return false
	end

	if currentAmount >= wantedAmount then
		-- We have enough
		return true
	else
		local neededAmount = wantedAmount - currentAmount
		local npcData = MagLib.BDO.Navigation.Graph.Profiles.currentProfile.npcs["Repair"][1] -- Keep at 1, since we want to buy at Blacksmith
		local atNPC = MagLib.BDO.Navigation.activeMoveToNpc(npcData, 250)
		if atNPC then
			local actorId = 40008
			local npcActor = MagLib.BDO.Actors.getActorWithId(actorId, EActorType_Npc)
			ReblathBuddy.logger.info("Buying " .. neededAmount .. " extraction books")
			MagLib.BDO.NPC.Shop.buy(npcActor, extractionBookKey, neededAmount, 0, false)
			local shopSettings = MagLib.Core.Settings.getSetting("MagLib_Shop")
			local delayTime = neededAmount * shopSettings.buyDelay + 250
			-- buyDelay is the amount of time it waits after every buy. So we can calculate an estimate time it will need + some buffer
			self.wait(delayTime)
		end
	end

	return false
end

BuyExtractionBookState = MagLib.Run.States.State("BuyExtractionBookState", work)
