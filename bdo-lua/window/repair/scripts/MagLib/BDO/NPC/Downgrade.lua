local Downgrade = {}

-- Cleanse/Downgrade
Downgrade.downgrade = function(npcActor, itemSlot, useStorageMoney)
	local lp = MagLib.BDO.Actors.LocalPlayer.get()

	local moneyWhereType = 0
	local moneyNo = lp:getInventoryMoneyNo()
	if useStorageMoney then
		moneyWhereType = 2
		moneyNo = Infinity.BDO.Warehouse.getCurrentMoneyNoByWaypointKey(Warehouse.getCurrentWaypointKey())
	end

	CleanseItemReq():construct(npcActor:getActorKey(), moneyWhereType, moneyNo, itemSlot).Packet:send()
end

MagLib.BDO.NPC.Downgrade = Downgrade
