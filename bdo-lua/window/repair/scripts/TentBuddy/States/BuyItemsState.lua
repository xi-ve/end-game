BuyItemsState = MagLib.Run.States.State("BuyItemsState")

function BuyItemsState:work()
	-- Buying Pots
	local buySettings = MagLib.Core.Settings.getSetting("TentBuddy").buyConfig

	if buySettings.potions.enabled then
		for _, potInfo in pairs(buySettings.potions.pots) do
			if (potInfo.enabled) then
				local amount = MagLib.BDO.Inventory.getItemCount_Quick(potInfo.itemId)
				local diff = potInfo.wantedAmount - amount
				if diff > 0 then
					MagLib.BDO.Tent.buyItem(potInfo.itemId, diff)
				end
			end
		end
	end

	-- Buying ItemBuffs
	if buySettings.itemBuffs.enabled then
		-- Checking Confidence Buff
		if buySettings.itemBuffs.confidenceBuff_enabled and
			not MagLib.BDO.Buffs.hasCollidingBuff(buySettings.itemBuffs.confidenceBuff_buffKey) then
			MagLib.BDO.Tent.buyItem(buySettings.itemBuffs.confidenceBuff_itemId, 1)
		end
		-- Checking Adventurer's Luck Buff
		for _, itemBuff in pairs(buySettings.itemBuffs.dropBuffs) do
			if itemBuff.enabled then
				if not MagLib.BDO.Buffs.hasCollidingBuff(itemBuff.buffKey) then
					MagLib.BDO.Tent.buyItem(itemBuff.itemId, 1)
				end
				break -- There can only be one buff enabled, no need checking the others
			end
		end
	end

	return true
end
