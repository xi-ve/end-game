StartProcessingState = {}
StartProcessingState.__index = StartProcessingState
StartProcessingState.Name = "Start Processing"

setmetatable(StartProcessingState, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})

function StartProcessingState.new()
	local self = setmetatable({}, StartProcessingState)
	self.lastValidationTick = 0
	self.currentAction = ""
	self.currentRecipe = {Action = "NONE", Materials = {}}
	self.warehouseTransfer = false

	self.localPlayer = Infinity.BDO.getLocalPlayer()

	self.containerActor = Utils.findInstallation_Container()
	self.warehouseActor = Utils.findNpc_Warehouse()
	return self
end

function StartProcessingState:getWarehouseItemData(itemId)
	return Warehouse.getItemDataByItemId(itemId)
end

function StartProcessingState:pickRecipe()
	local recipeBuffer = {Action = "NONE", Materials = {}}
	self.warehouseTransfer = false

	self.containerActor = Utils.findInstallation_Container()
	self.warehouseActor = Utils.findNpc_Warehouse()

	local isContainer = self.containerActor ~= nil and
                    		self.containerActor:getPosition():getDistance(self.localPlayer:getPosition()) < 400.0

	local currentAction = Infinity.BDO.getLocalPlayer():getCharacterControler():getCurrentAnimation():getName()

	for kr, recipe in pairs(AutoProcessing.Settings.Recipes) do

		if recipe.Enabled then

			local hasAllMaterials = true

			for km, material in pairs(recipe.Materials) do

				local count, slot = Inventory.getItemDataByItemId(material.ItemId)

				if count == 0 or slot == -1 then -- no item in inventory

					hasAllMaterials = false
					if currentAction == "WAIT" or currentAction == "WAIT2" then
						count, slot = self:getWarehouseItemData(material.ItemId) -- checking warehouse

						if count > 0 and slot ~= -1 then -- warehouse has item

							if count >= material.MinCount then

								if not isContainer then
									print("...moving item from warehouse to inventory")
									Warehouse.moveToInventory(slot, material.MinCount) -- move to inventory
								else
									print("...moving item from container to inventory")
									Warehouse.moveToInventoryByInstallation(self.containerActor:getActorKey(), slot, material.MinCount)
								end

								self.warehouseTransfer = true
							else
								-- itemCount in warehouse is not enough
							end
						else
							-- do something if material is not in inventory nor warehouse
						end
					end
				else -- inventory has item

					if count < material.MinCount then -- check warehouse for item  if count is less then required count
						hasAllMaterials = false
						if currentAction == "WAIT" or currentAction == "WAIT2" then

							local whCount, whSlot = self:getWarehouseItemData(material.ItemId)

							if whCount > 0 and whSlot ~= -1 then

								if not isContainer then
									print("...moving item from warehouse to inventory")
									Warehouse.moveToInventory(whSlot, material.MinCount - count)
								else
									print("...moving item from container to inventory")
									Warehouse.moveToInventoryByInstallation(self.containerActor:getActorKey(), whSlot, material.MinCount - count)
								end

								self.warehouseTransfer = true
							else
								-- no item in warehouse
							end
						end
					else
						table.insert(recipeBuffer.Materials, {Slot = slot, Count = count})
					end
				end
			end

			if self.warehouseTransfer then
				break
			end

			if hasAllMaterials then
				recipeBuffer.Action = recipe.Action

				break
			end
		end
	end

	self.currentRecipe = recipeBuffer
end

function StartProcessingState:NeedToRun()
	if self.lastValidationTick + 1000 >= Infinity.Win32.GetTickCount() then
		return false
	end
	self.lastValidationTick = Infinity.Win32.GetTickCount()

	self:pickRecipe()

	if self.currentRecipe.Action == "NONE" and not self.warehouseTransfer then
		-- AutoProcessing.StopBot()
		-- print("Stopped cause no materials for recipes were found! (Open Warehouse + Inventory once so they get buffered inside the game)")
		return false
	end

	self.currentAction = Infinity.BDO.getLocalPlayer():getCharacterControler():getCurrentAnimation():getName()

	return self.currentAction == "WAIT" or self.currentAction == "WAIT2"
end

function StartProcessingState:Run()

	local materialList = {255, 255, 255, 255, 255}

	for k, v in pairs(self.currentRecipe.Materials) do
		materialList[k] = v.Slot
	end

	Processing.startInventoryManufacture(self.currentRecipe.Action, materialList[1], materialList[2], materialList[3],
                                     	materialList[4], materialList[5])
end
