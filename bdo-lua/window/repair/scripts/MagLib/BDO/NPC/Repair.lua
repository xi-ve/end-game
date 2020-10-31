local Repair = {}

Repair.repairMaxEndurance = function(npcActor, mainSlot, subSlot, subIsCashItem)
	-- Setting talker
	Infinity.BDO.getDialogManager():setTalker(npcActor)
	-- Repairing Max durability
	Infinity.BDO.Lua.Execute("repair_MaxEndurance(0, " .. mainSlot .. ",0, " .. subSlot .. ", 0," ..
                         		tostring(subIsCashItem) .. ")")
end

Repair.repairInInventory = function(npcActor, itemSlot, useStorageMoney)
	if not Repair.isRepairableBySlot(itemSlot) then
		return false
	end

	local lp = MagLib.BDO.Actors.LocalPlayer.get()

	local moneyWhereType = 0
	local moneyNo = lp:getInventoryMoneyNo()
	if useStorageMoney then
		moneyWhereType = 2
		moneyNo = Infinity.BDO.Warehouse.getCurrentMoneyNoByWaypointKey(Warehouse.getCurrentWaypointKey())
	end

	RepairItemReq():construct(0, itemSlot, moneyWhereType, 0, lp:getActorKey(), npcActor:getActorKey(), moneyNo).Packet:send()
	return true
end

Repair.isRepairableBySlot = function(itemSlot)
	return true
end

-- Returns true if all are repaired, else false
Repair.repairAllInInventory = function(npcActor, useStorageMoney)
	local repairedSth = false
	local iteratorFunc = function(itemData)
		if itemData.dura < itemData.maxDura then
			local repaired = Repair.repairInInventory(npcActor, itemData.slot, useStorageMoney)
			if repaired then
				repairedSth = true
			end
		end
	end
	MagLib.BDO.Inventory.iterator(iteratorFunc)

	if repairedSth then
		-- Waiting so it can finish repairing/sync
		MagLib.wait(250)
	end
	return not repairedSth -- If we repairedSth, return false, else true
end

MagLib.BDO.NPC.Repair = Repair
