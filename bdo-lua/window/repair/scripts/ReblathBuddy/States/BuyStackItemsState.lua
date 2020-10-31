local work = function(self)
	local settings = MagLib.Core.Settings.getSetting("ReblathBuddy")

	local stackItemKey = ReblathBuddy.stackItemKey
	local wantedAmountOfItemsToStackOn = settings.amountOfItemsToStackOn
	local amountOfItemsToStackOn = MagLib.BDO.Inventory.getItemCount(stackItemKey)
	if amountOfItemsToStackOn >= wantedAmountOfItemsToStackOn then
		return true
	end

	local stackItemsToBuy = wantedAmountOfItemsToStackOn - amountOfItemsToStackOn
	if stackItemsToBuy > 0 then
		local npcData = MagLib.BDO.Navigation.Graph.Profiles.currentProfile.npcs["Repair"][ReblathBuddy.repairNPCId]
		local atNPC = MagLib.BDO.Navigation.activeMoveToNpc(npcData, 250)
		if atNPC then
			local actorId = 40008
			if ReblathBuddy.repairNPCId == 2 then
				actorId = 40003
			end
			local npcActor = MagLib.BDO.Actors.getActorWithId(actorId, EActorType_Npc)
			ReblathBuddy.logger.info("Buying " .. stackItemsToBuy .. " stack items for upgrading")
			MagLib.BDO.NPC.Shop.buy(npcActor, stackItemKey, stackItemsToBuy, 0, false)
			-- Wait a reasonable amount to allow it to buy everything
			local shopSettings = MagLib.Core.Settings.getSetting("MagLib_Shop")
			local delayTime = stackItemsToBuy * shopSettings.buyDelay + 1000
			-- buyDelay is the amount of time it waits after every buy. So we can calculate an estimate time it will need + some buffer
			self.wait(delayTime)
		end
	end
	return false
end

BuyStackItemState = MagLib.Run.States.State("BuyStackItemState", work)
