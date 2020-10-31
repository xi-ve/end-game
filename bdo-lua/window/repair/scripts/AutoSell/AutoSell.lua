AutoSell = {}
AutoSell.Running = false
AutoSell.Settings = Settings()
AutoSell.CurrentProfile = ProfileSettings()

AutoSell.lastTryTick = 0

local marketNpc = nil
local marketNpcDistance = 600

function AutoSell.OnAutoLoginAutoLoad()
	AutoSell.StartBot()
end

function AutoSell.StartBot()
	if AutoSell.CurrentProfile.Name == "" then
		print("No Profile Selected")
		return
	end

	print("Started!")
	AutoSell.Running = true
end

function AutoSell.StopBot()
	AutoSell.Running = false
end

function AutoSell.Start()
	AutoSell.LoadSettings()

	if AutoSell.Settings.LastProfile ~= "" then
		print("Loading Last Profile")
		AutoSell.LoadLastProfile()
	end
end

function AutoSell.Stop()
	AutoSell.Running = false

	AutoSell.SaveCurrentProfile()
	AutoSell.SaveSettings()

	print("Closing NPC Dialog and Panels")
	Interaction.hideDialog()
	Infinity.BDO.Selection.reset()

	print("Stopped!")
end

function AutoSell.getMovableItemsFromInventory()
	local items = {}

	for k, v in pairs(AutoSell.getInventoryItems()) do
		local canSell = false

		for kk, vv in pairs(AutoSell.CurrentProfile.Inventory.Items) do
			local maxCountBySlot = ItemMarket.getMaxCountBySlot(v.Slot)
			if v.ItemEnchantKey == vv.ItemEnchantKey then
				if vv.Enabled then
					if vv.MinStack == 0 or vv.MinStack >= maxCountBySlot then
						if v.Count >= maxCountBySlot then
							table.insert(items, {Slot = v.Slot, Count = v.Count, ItemId = v.ItemId, ItemEnchantKey = v.ItemEnchantKey})
						end
					elseif vv.MinStack > 0 and v.Count >= vv.MinStack then
						table.insert(items, {Slot = v.Slot, Count = vv.MinStack, ItemId = v.ItemId, ItemEnchantKey = v.ItemEnchantKey})
					end
					break
				end
			end
		end
	end

	return items
end

function AutoSell.pushInventoryItemsToCMWarehouse()

	local movableItems = AutoSell.getMovableItemsFromInventory()

	if Interaction.getTalkNpcKey() ~= 0 and table.length(movableItems) == 0 then

		print("Closing NPC Dialog and Panels")
		Interaction.hideDialog()
		Infinity.BDO.Selection.reset()
		return false
	end

	if table.length(movableItems) == 0 then
		return true
	end

	marketNpc = Utils.findNpc_ItemMarket()
	local hasMarketMaid = Maids.hasMarketMaid() and Maids.getMarketMaidCooldown() <= 0
	local isNpcInteraction = false
	if marketNpc ~= nil and marketNpc:getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition()) <=
		marketNpcDistance then

		print("Market NPC found, trying to initiate interaction by NPC")

		local rotFaceTarget = marketNpc:getPosition():getRotationToFace(Infinity.BDO.getLocalPlayer():getPosition())
		Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setRotation(rotFaceTarget)

		if Infinity.BDO.Selection.getTarget() ~= marketNpc:getActorKey() then

			Infinity.BDO.Selection.setTarget(marketNpc:getActorKey())
			return false
		else

			if Interaction.hasInteractable() and Interaction.getTalkNpcKey() == 0 then

				Infinity.BDO.getUIManager():setIsCursorActive(false)
				Interaction.interact(4)
				return false
			end
		end

		isNpcInteraction = true
	end

	if isNpcInteraction or hasMarketMaid then

		for k, v in pairs(movableItems) do

			local slotNo = v.Slot
			local itemWeight = ItemMarket.getMarketWeightForSlot(slotNo)
			local processableCount = ItemMarket.getMaxCountBySlot(slotNo)

			if v.Count < processableCount then
				processableCount = v.Count
			end

			local totalWeight = itemWeight * processableCount

			local currentWeight = ItemMarket.getCurrentWeight()
			local maxWeight = ItemMarket.getMaxWeight()
			local freeWeight = ItemMarket.getFreeWeight()

			if freeWeight < totalWeight then
				local newProcessableCount = math.floor(freeWeight / itemWeight)
				print("Current market volume (" .. currentWeight .. "VT) is less than the max volume for item on slot " .. slotNo ..
      					" (" .. processableCount .. "), adjusting to fit the available volume (" .. freeWeight .. "VT) to " ..
      					newProcessableCount .. ".")
				processableCount = math.floor(freeWeight / itemWeight)
			end

			if processableCount ~= 0 then
				print("Moving item on slot " .. v.Slot .. " with count " .. processableCount .. " to CM warehouse")
				CentralMarketWarehouse.moveFromInventory(v.Slot, processableCount, not isNpcInteraction)
				return false
			end
		end
	end
end

function AutoSell.getFilter(itemEnchantKey)
	for k, v in pairs(AutoSell.CurrentProfile.Inventory.Items) do
		if v.ItemEnchantKey == itemEnchantKey then
			return v
		end
	end

	return nil
end

function AutoSell.hasFilter(itemEnchantKey)
	return AutoSell.getFilter(itemEnchantKey) ~= nil
end

function AutoSell.canSell(itemEnchantKey)

	if Infinity.BDO.ItemMarket.getSellItemsCount():getUnsafe() <= 0 then
		return true
	end

	for k, marketItemInfo in pairs(Infinity.BDO.ItemMarket.getSellItems()) do
		if k == itemEnchantKey then
			return false
		end
	end

	return true
end

function AutoSell.getMaxCount(itemEnchantKey)

	for k, itemCount in pairs(Infinity.BDO.ItemMarket.getWarehouseItems()) do

		if k == itemEnchantKey then

			local maxCount = 100

			local itemId = Utils.getItemId(itemEnchantKey)
			local minLevel = AutoSell.getMinItemLevel(itemEnchantKey)

			local code = [[
				local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(]] .. itemId .. [[, ]] .. minLevel .. [[))
				
				if itemSSW ~= nil then
					return Int64toInt32(itemSSW:getMaxRegisterCountForWorldMarket()) * 10
				end

				return nil
			]]

			local tempCount = Infinity.BDO.Lua.Execute(code)

			if tempCount == nil then
				return maxCount
			end

			maxCount = tempCount

			if itemCount > maxCount then
				return maxCount
			else
				return itemCount
			end
		end
	end

	return 0
end

function AutoSell.getPrice(itemEnchantKey)

	local filter = AutoSell.getFilter(itemEnchantKey)

	if filter == nil or not filter.Enabled then
		return -1
	end

	return filter.CustomPriceValue
end

function AutoSell.getMinItemLevel(itemEnchantKey)
	local itemLevel = AutoSell.getItemLevel(itemEnchantKey)

	if itemLevel >= 0 and itemLevel <= 7 then
		return 0
	elseif itemLevel >= 8 and itemLevel <= 10 then
		return 8
	elseif itemLevel >= 11 and itemLevel <= 12 then
		return 11
	end

	return itemLevel
end

function AutoSell.getItemLevel(itemEnchantKey)
	return Utils.getEnchantLevel(itemEnchantKey)
end

function AutoSell.getIsSealed(itemEnchantKey)
	return false
end

function AutoSell.sellCMWarehouseItems()
	-- print("AutoSell.sellCMWarehouseItems")

	if Infinity.BDO.ItemMarket.getWarehouseItemsCount() <= 0 then
		-- print("AutoSell.sellCMWarehouseItems - no items")
		return
	end

	for itemEnchantKey, itemCount in pairs(Infinity.BDO.ItemMarket.getWarehouseItems()) do

		-- print("AutoSell.sellCMWarehouseItems - item " .. itemEnchantKey .. " " .. itemCount)

		if AutoSell.hasFilter(itemEnchantKey) and AutoSell.canSell(itemEnchantKey) then

			local price = AutoSell.getPrice(itemEnchantKey)

			if price ~= -1 then

				print("Selling item -> " .. Utils.getItemId(itemEnchantKey) .. ", " .. AutoSell.getMinItemLevel(itemEnchantKey) ..
      					", " .. AutoSell.getMaxCount(itemEnchantKey) .. ", " .. price .. ", " ..
      					AutoSell.getItemLevel(itemEnchantKey) .. ", " .. tostring(AutoSell.getIsSealed(itemEnchantKey)))
				ItemMarket.sellItemToWorldMarket(Utils.getItemId(itemEnchantKey), AutoSell.getMinItemLevel(itemEnchantKey),
                                 				AutoSell.getMaxCount(itemEnchantKey), price, AutoSell.getItemLevel(itemEnchantKey),
                                 				AutoSell.getIsSealed(itemEnchantKey))
				return
			end
		end
	end
end

function AutoSell.hasSoldItems()

	if Infinity.BDO.ItemMarket.getSellItemsCount():getUnsafe() <= 0 then
		return false
	end

	for itemId, marketItemInfo in pairs(Infinity.BDO.ItemMarket.getSellItems()) do

		if marketItemInfo:getTotalPrice():getUnsafe() ~= 0 then
			return true
		end
	end
end

function AutoSell.collectSoldBalance()

	if not AutoSell.Settings.MoneyCollect.Enabled then
		return true
	end

	if not AutoSell.hasSoldItems() then
		return true
	end

	print("Collecting balance from sold items")
	ItemMarket.getAllToWarehouse()

	return false
end

local initDone = nil
function AutoSell.OnPulse()
	-- Init
	if not initDone then
		AutoSell.updateInventoryItemsForFilter()
		initDone = true
	end

	-- Check if we are even running
	if AutoSell.Running == false then
		return
	end

	-- OnPulse
	local time = Infinity.Win32.GetTickCount()

	if AutoSell.lastTryTick + 2500 >= time then
		return
	end

	AutoSell.lastTryTick = time

	if AutoSell.collectSoldBalance() then

		if AutoSell.pushInventoryItemsToCMWarehouse() then

			AutoSell.sellCMWarehouseItems()
		end
	end
end

function AutoSell.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function AutoSell.drawNpc()
	if marketNpc == nil then
		return
	end

	local lpPos = Infinity.BDO.getLocalPlayer():getPosition()

	RenderHelper.DrawWorldCircle(marketNpc:getPosition(), 30, "FF00FF00", 1, true)

	local lineColor = "FF00FF00"

	if marketNpc:getPosition():getDistance(lpPos) > marketNpcDistance then
		lineColor = "FFFF0000"
	end

	RenderHelper.DrawWorldLine(lpPos, marketNpc:getPosition(), lineColor, 2)
	RenderHelper.DrawWorldText("AutoSell (MarketNpc)", 16, "FFFF0000", marketNpc:getPosition(), 0, 20)
end

function AutoSell.OnRenderD2D()
	if AutoSell.Settings.RenderNpcs then
		AutoSell.drawNpc()
	end
end

function AutoSell.SaveSettings()
	local json = JSON:new()
	Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(AutoSell.Settings))
end

function AutoSell.SaveCurrentProfile()
	if AutoSell.CurrentProfile.Name == "" then
		return
	end

	local json = JSON:new()
	Infinity.FileSystem.WriteFile("Profiles\\" .. AutoSell.CurrentProfile.Name .. ".json",
                              	json:encode_pretty(AutoSell.CurrentProfile))
end

function AutoSell.LoadSettings()
	local json = JSON:new()
	AutoSell.Settings = Settings()

	table.merge(AutoSell.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))
end

function AutoSell.LoadLastProfile()
	local json = JSON:new()
	AutoSell.CurrentProfile = ProfileSettings()

	table.merge(AutoSell.CurrentProfile,
            	json:decode(Infinity.FileSystem.ReadFile("Profiles\\" .. AutoSell.Settings.LastProfile)))

	-- Converting old profile
	for _, v in pairs(AutoSell.CurrentProfile.Inventory.Items) do
		if v.Enabled == nil then
			v.Enabled = true
		end
	end
end

function AutoSell.updateInventoryItemsForFilter()
	local invenMaxSize = Inventory.getMaxSize()

	if invenMaxSize == 0 then
		return
	end

	local itemTableNames = {}
	local itemTableIds = {}
	local itemTableEnchantKeys = {}
	local itemTableSlots = {}

	for i = 0, invenMaxSize - 1 do
		if Inventory.hasItemWrapper(i) then
			local name
			local itemId
			local count
			local enchantKey

			name, itemId, count, enchantKey = Inventory.getItemData(i)

			if name ~= nil and itemId ~= nil and table.find(itemTableEnchantKeys, enchantKey) == nil and
				not AutoSell.hasFilter(enchantKey) then
				local enchantLevel = Utils.getEnchantLevel(enchantKey)

				--[[local enchantLevel = Utils.getEnchantLevel(enchantKey)

					if enchantLevel > 0 then
						name = "+" .. enchantLevel .. " " .. name
					end]] --

				if (enchantLevel > 0) then
					name = name .. " +" .. enchantLevel
				end
				table.insert(itemTableNames, name)
				table.insert(itemTableIds, itemId)
				table.insert(itemTableEnchantKeys, enchantKey)
				table.insert(itemTableSlots, i)
			end
		end
	end

	MainWindow.InventoryItemsNames = itemTableNames
	MainWindow.InventoryItemsItemIds = itemTableIds
	MainWindow.InventoryItemsItemEnchantKeys = itemTableEnchantKeys
	MainWindow.InventoryItemsSlots = itemTableSlots
end

function AutoSell.getInventoryItems()
	local invenMaxSize = Inventory.getMaxSize()

	if invenMaxSize == 0 then
		return
	end

	local items = {}

	for i = 0, invenMaxSize - 1 do
		if Inventory.hasItemWrapper(i) then
			local name
			local itemId
			local count

			name, itemId, count, enchantKey = Inventory.getItemData(i)

			if name ~= nil and itemId ~= nil then
				table.insert(items, {ItemId = itemId, Slot = i, Count = count, ItemEnchantKey = enchantKey})
			end
		end
	end

	return items
end

function AutoSell.OnPacketReceive(byteBuffer)
	local packetLength = byteBuffer:getShort()
	local isEncrypted = byteBuffer:get()
	local opCode = byteBuffer:getShort()

	local name = OpCodes.getAckName(opCode)

	if name == "AddItemToInventory" or name == "EraseInventoryItem" or name == "EnchantItem" then
		AutoSell.updateInventoryItemsForFilter()
	end
end
