ItemTransfer = { }
ItemTransfer.Running = false

local cached_ItemId = -1
local cached_ItemSlot = -1

local transfer_start = false
local transfer_toInventory = false
local step_warehouse = false
local step_inventory = false
local step_servantInventory = false

local lastStep = 0

ItemTransfer.running_depositWarehouseToInventory = false
ItemTransfer.running_depositInventoryToWarehouse = false
local lastDeposit = 0

function ItemTransfer.Start()
  ItemTransfer.Running = true	    
end

function ItemTransfer.Stop()
  ItemTransfer.Running = false  
end

function ItemTransfer.OnPulse()
  if ItemTransfer.Running == false then
    return
  end    
  	
  	if lastDeposit + 100 <= Infinity.Win32.GetTickCount() then

  		lastDeposit = Infinity.Win32.GetTickCount()

  		if ItemTransfer.running_depositWarehouseToInventory then
  			ItemTransfer.depositWarehouseToInventory()
  		end

  		if ItemTransfer.running_depositInventoryToWarehouse then
  			ItemTransfer.depositInventoryToWarehouse()
  		end
	end

  if not transfer_start or cached_ItemId == -1 then
  	return
  end

  if lastStep + MainWindow.stepDelay > Infinity.Win32.GetTickCount() then
  	return
  end

  lastStep = Infinity.Win32.GetTickCount()

	ItemTransfer.handleTransfer()
end

function ItemTransfer.OnRenderD2D()
end

function ItemTransfer.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function ItemTransfer.handleTransfer()
	if step_warehouse then
		print("Step -> To Inventory From Warehouse")	

		if Inventory.getItemSlotItemId(cached_ItemId) ~= 0 then
			print("Item alrdy exists in inventory. Chaning Step!")

			step_warehouse = false
			step_servantInventory = true
			step_inventory = false

			return		
		end

		if Warehouse.getItemCount(cached_ItemSlot) > 0 then
			ItemTransfer.toInventoryFromWarehouse()

			step_warehouse = false
			step_servantInventory = true
			step_inventory = false

			return
		else
			print("No more Items available in warehouse!")

			transfer_start = false

			step_warehouse = false
			step_servantInventory = false
			step_inventory = false

			return
		end	
	elseif step_inventory then
		print("Step -> To Inventory From Mount")

		if ServantInventory.getSlot(Infinity.BDO.getMyVehicle():getActorKey(), cached_ItemId) == -1 then
			print("Item does not exist in mountInventory. Changing Step!")

			if Inventory.getItemSlotItemId(cached_ItemId) == 0 then
				print("Item does not exist in inventory. Chaning Step!")

				step_warehouse = true
				step_servantInventory = false
				step_inventory = false

				return
			else
				step_warehouse = false
				step_servantInventory = true
				step_inventory = false

				return
			end			
		else
			ItemTransfer.toInventoryFromMount()

			step_warehouse = false
			step_servantInventory = true
			step_inventory = false

			return			
		end
	elseif step_servantInventory then
		print("Step -> To Mount From Inventory")

		if ServantInventory.getSlot(Infinity.BDO.getMyVehicle():getActorKey(), cached_ItemId) ~= -1 then
			print("Item alrdy exists in mountInventory. Changing Step!")

			step_warehouse = false
			step_servantInventory = false
			step_inventory = true

			return
		else

			if Inventory.getItemSlotItemId(cached_ItemId) ~= 0 then
				ItemTransfer.toMountFromInventory()

				step_warehouse = true
				step_servantInventory = false
				step_inventory = false

				return
			else
				print("No Item available in inventory. Changing Step!")

				step_warehouse = true
				step_servantInventory = false
				step_inventory = false

				return
			end
		end
	end
end

function ItemTransfer.allToInventoryViaMountInit()	
	cached_ItemId = -1
	cached_ItemSlot = -1

	transfer_toInventory = true
	step_warehouse = false
	step_inventory = false
	step_servantInventory = false

	if Infinity.BDO.getMyVehicle() == nil then
		print("Could not find Vehicle!")
		return
	end

	if Infinity.BDO.getMyVehicle():getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition()) > 500 then
		print("Vehicle is too far!")
		return
	end

	ItemTransfer.toInventoryFromWarehouse()

	step_servantInventory = true
	transfer_start = true
end

function ItemTransfer.toInventoryFromMount()
	if cached_ItemId == -1 then
		print("No Cached Item, Transfer toInventoryFromWarehouse first!")
		return
	end

	if Infinity.BDO.getMyVehicle() == nil then
		print("Could not find Vehicle!")
		return
	end

	if Infinity.BDO.getMyVehicle():getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition()) > 500 then
		print("Vehicle is too far!")
		return
	end

	local itemSlot = ServantInventory.getSlot(Infinity.BDO.getMyVehicle():getActorKey(), cached_ItemId)

	if itemSlot == -1 then
		print("Could not find item in mountInventory by itemId!")
		return
	end

	local itemCount = ServantInventory.getCount(Infinity.BDO.getMyVehicle():getActorKey(), itemSlot)

	Inventory.moveFromActorToActor(Infinity.BDO.getMyVehicle():getActorKey(), Infinity.BDO.getLocalPlayer():getActorKey(), "CppEnums.ItemWhereType.eServantInventory", itemSlot, itemCount)	
end

function ItemTransfer.toMountFromInventory()
	if cached_ItemId == -1 then
		print("No Cached Item, Transfer toInventoryFromWarehouse first!")
		return
	end

	if Infinity.BDO.getMyVehicle() == nil then
		print("Could not find Vehicle!")
		return
	end

	if Infinity.BDO.getMyVehicle():getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition()) > 500 then
		print("Vehicle is too far!")
		return
	end

	local itemSlot = Inventory.getItemSlotItemId(cached_ItemId)

	if itemSlot == 0 then
		print("Could not find item in inventory by itemId!")
		return
	end

	local itemCount = Inventory.getItemCount(itemSlot)
	
	Inventory.moveFromActorToActor(Infinity.BDO.getLocalPlayer():getActorKey(), Infinity.BDO.getMyVehicle():getActorKey(), "CppEnums.ItemWhereType.eInventory", itemSlot, itemCount)	
end

function ItemTransfer.toInventoryFromWarehouse()
	if cached_ItemId == -1 then
		local itemSlot = MainWindow.getSelectedWarehouseSlot()

		if itemSlot == -1 then
			print("No Warehouse Item selected!")
			return
		end

		cached_ItemId = Warehouse.getItemId(itemSlot)
		cached_ItemSlot = itemSlot

		return
	end

	if Warehouse.getItemId(cached_ItemSlot) ~= cached_ItemId then
		print("No more items with selected itemId available in warehouse!")
		transfer_start = false
		return
	end

	local itemWeight = Warehouse.getItemWeight(cached_ItemSlot)
	local itemCount = Warehouse.getItemCount(cached_ItemSlot)
	local cappedFreeWeight = LocalPlayer.getCappedFreeWeight()

	local transferableCount = math.floor(cappedFreeWeight/itemWeight)
	
	if itemCount < transferableCount then
		transferableCount = itemCount
	end

	print("Transfering " .. transferableCount .. " from Warehouse Slot " .. cached_ItemSlot .. " to Inventory")
	
	PopWarehouseItemToInventory():construct(false, cached_ItemId, cached_ItemSlot, transferableCount, Infinity.BDO.getLocalPlayer():getActorKey(), Utils.findNpc_Warehouse():getActorKey()).Packet:send()
	--Warehouse.moveToInventory(cached_ItemSlot, transferableCount)
end

function ItemTransfer.depositInventoryToWarehouse()
	local aStorage = Utils.findNpc_Warehouse()

	if aStorage == nil then
		print("Not close to some Storage!")
		ItemTransfer.running_depositInventoryToWarehouse = false
		return
	end

	for slot = 2, 194 do

		if Inventory.hasItemWrapper(slot) then

			local name, itemId, count = Inventory.getItemData(slot)

			PushInventoryItemToWarehouse():construct(false, 0, itemId, slot, count, Infinity.BDO.getLocalPlayer():getActorKey(), Utils.findNpc_Warehouse():getActorKey()).Packet:send()
			--Warehouse.moveFromInventory(slot, count, aStorage:getActorKey())
		end
	end
end

function ItemTransfer.depositWarehouseToInventory()
	for slot = 1, 194 do

	local code =
        [[
            local warehouseWrapper = warehouse_get(]] .. Warehouse.getCurrentWaypointKey() .. [[)
                
            if warehouseWrapper ~= nil then            
                local itemWrapper = warehouseWrapper:getItem(]] .. slot .. [[)
                local itemSSW = itemWrapper:getStaticStatus()

                if itemWrapper ~= nil and itemSSW ~= nil and not itemSSW:get():isCash() then
                    return Int64toDouble((itemWrapper:get()):getCount_s64())
                end            
            end

            return nil
        ]]

    local itemCount = Infinity.BDO.Lua.Execute(code)

    local itemWeight = Warehouse.getItemWeight(slot)	
	local cappedFreeWeight = LocalPlayer.getCappedFreeWeight()

    if itemCount ~= nil and (itemWeight * itemCount) <= cappedFreeWeight then

    	PopWarehouseItemToInventory():construct(false, Warehouse.getItemId(slot), slot, itemCount, Infinity.BDO.getLocalPlayer():getActorKey(), Utils.findNpc_Warehouse():getActorKey()).Packet:send()
        --Warehouse.moveToInventory(slot, itemCount)
    end    
	end
end