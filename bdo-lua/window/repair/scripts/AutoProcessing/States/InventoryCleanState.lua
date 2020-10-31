InventoryCleanState = {}
InventoryCleanState.__index = InventoryCleanState
InventoryCleanState.Name = "Inventory Clean"

setmetatable(InventoryCleanState, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})

function InventoryCleanState.new()
	local self = setmetatable({}, InventoryCleanState)
	self.lastValidationTick = 0
	self.cleanupList = {}

	self.localPlayer = Infinity.BDO.getLocalPlayer()
	self.currentAction = ""

	self.containerActor = Utils.findInstallation_Container()
	self.warehouseActor = Utils.findNpc_Warehouse()
	return self
end

function InventoryCleanState:getCleanupList()
	local listBuffer = {}

	local invenMaxSize = Inventory.getMaxSize()

	for i = 0, invenMaxSize - 1 do

		local name
		local itemId
		local count

		name, itemId, count = Inventory.getItemData(i)

		table.insert(listBuffer, {Count = count})
	end

	if table.length(listBuffer) > 0 then

		listBuffer[1].Count = 0
		listBuffer[2].Count = 0

		for k, material in pairs(AutoProcessing.StartProcessingState.currentRecipe.Materials) do
			listBuffer[material.Slot + 1].Count = 0
		end
	end

	self.cleanupList = listBuffer
end

function InventoryCleanState:NeedToRun()
	if self.lastValidationTick + 500 >= Infinity.Win32.GetTickCount() then
		return false
	end

	self.currentAction = Infinity.BDO.getLocalPlayer():getCharacterControler():getCurrentAnimation():getName()

	if self.currentAction ~= "WAIT" and self.currentAction ~= "WAIT2" then
		return false
	end

	-- if AutoProcessing.StartProcessingState.currentRecipe.Action == "NONE" or AutoProcessing.StartProcessingState.warehouseTransfer then
	-- return false
	-- end

	if Warehouse.getFreeSlots() == 0 then
		return false
	end

	return true
end

function InventoryCleanState:Run()
	self.lastValidationTick = Infinity.Win32.GetTickCount()

	self.containerActor = Utils.findInstallation_Container()
	self.warehouseActor = Utils.findNpc_Warehouse()

	if self.warehouseActor == nil and self.containerActor == nil then
		print("No Container/WarehouseManager found!")
		return
	end

	local invenMaxSize = Inventory.getMaxSize()

	for i = 0, invenMaxSize - 1 do

		local name
		local itemId
		local count

		name, itemId, count = Inventory.getItemData(i)

		if AutoProcessing.shouldMoveToWarehouse(itemId) then

			if self.warehouseActor ~= nil and self.warehouseActor:getPosition():getDistance(self.localPlayer:getPosition()) <
				400.0 then
				print("...moving item to warehouse")
				-- Warehouse.moveFromInventory(i, count, self.warehouseActor:getActorKey())
				PushInventoryItemToWarehouse():construct(false, 0, itemId, i, count, self.localPlayer:getActorKey(),
                                         				self.warehouseActor:getActorKey()).Packet:send()
			elseif self.containerActor ~= nil and self.containerActor:getPosition():getDistance(self.localPlayer:getPosition()) <
				400.0 then
				print("...moving item to container")
				Warehouse.moveFromInventoryByInstallation(self.containerActor:getActorKey(), i, count)
			end
			AutoProcessing.StartProcessingState.lastValidationTick = Infinity.Win32.GetTickCount() -- Making it not do shit for at least 1 seconds
		end
	end
end
