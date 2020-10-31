local WarehouseWrapper = {}

WarehouseWrapper.deposit = function(npcActor, itemKey, itemSlot, amount, useMaid)
	PushInventoryItemToWarehouse():construct(useMaid, 0, itemKey, itemSlot, amount,
                                         	Infinity.BDO.getLocalPlayer():getActorKey(), npcActor:getActorKey()).Packet:send()
end

WarehouseWrapper.withdraw = function(npcActor, wantedKey, amount, useMaid)
	local wCount, wSlot = Warehouse.getItemDataByItemId(wantedKey, Warehouse.getCurrentWaypointKey())
	if wCount < amount then
		amount = wCount
	end

	PopWarehouseItemToInventory():construct(useMaid, wantedKey, wSlot, amount, Infinity.BDO.getLocalPlayer():getActorKey(),
                                        	npcActor:getActorKey()).Packet:send()
end

WarehouseWrapper.openFromDialog = function()
	Infinity.BDO.Lua.Execute("PaGlobal_Warehouse_All_OpenPanelFromDialog()")
end

WarehouseWrapper.openFromMaid = function()
	Infinity.BDO.Lua.Execute("PaGlobal_Warehouse_All_OpenPanelFromMaid()")
end

WarehouseWrapper.openFromDialogWithoutInventory = function()
	Infinity.BDO.Lua.Execute(
		"PaGlobal_Warehouse_All_OpenPanelFromDialogWithoutInventory(getCurrentWaypointKey(), CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc)")
end

WarehouseWrapper.closePanel = function()
	Infinity.BDO.Lua.Execute("PaGlobal_Warehouse_All_Close()")
end

MagLib.BDO.Warehouse = WarehouseWrapper
