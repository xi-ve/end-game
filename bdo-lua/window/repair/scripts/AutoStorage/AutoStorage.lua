AutoStorage = {}
AutoStorage.Running = false
AutoStorage.Settings = Settings()
AutoStorage.CurrentProfile = ProfileSettings()

function AutoStorage.OnAutoLoginAutoLoad()
	AutoStorage.StartBot()
end

function AutoStorage.Start()
	AutoStorage.LoadSettings()

	if AutoStorage.Settings.LastProfile ~= "" then
		print("Loading Last Profile")
		AutoStorage.LoadLastProfile()
	end
end

function AutoStorage.Stop()

	AutoStorage.SaveCurrentProfile()
	AutoStorage.SaveSettings()
end

function AutoStorage.StartBot()
	if AutoStorage.CurrentProfile.Name == "" then
		print("No Profile Selected")
		return
	end

	AutoStorage.Running = true
end

function AutoStorage.StopBot()
	AutoStorage.Running = false
end

local lastProcessed = 0
function AutoStorage.OnPulse()
	if not AutoStorage.Running then
		return
	end

	local time = Infinity.Win32.GetPerformanceCounter()
	if time < lastProcessed + 1000 then
		return
	end

	lastProcessed = time
	AutoStorage.processInventoryItems()
end

function AutoStorage.hasAvailableStorageMaid()
	return Maids.hasStorageMaid() and Maids.getStorageMaidCooldown() <= 0
end

function AutoStorage.getFilter(itemEnchantKey)
	return AutoStorage.CurrentProfile.ItemFilters[tostring(itemEnchantKey)]
end

local noPushToWarehouseUntil = 0

function AutoStorage.processInventoryItems()
	if not AutoStorage.hasAvailableStorageMaid() then
		return
	end

	local invenMaxSize = Inventory.getMaxSize()
	if invenMaxSize == 0 then
		return
	end

	local currentWeightPct = Inventory.getInventoryWeightPercent()
	local forcePush = currentWeightPct >= AutoStorage.CurrentProfile.forceClearWeightPctThreshold

	local bestItemToForceSlot = nil
	local bestItemToForceWeight = 0
	local pushedSomething = false

	local time = Infinity.Win32.GetPerformanceCounter()
	if AutoStorage.CurrentProfile.enableRandomWaits and (time < noPushToWarehouseUntil) and not forcePush then
		return
	end

	for i = 0, invenMaxSize - 1 do
		local name
		local itemId
		local count
		local enchantKey
		local singleItemWeight
		name, itemId, count, enchantKey, singleItemWeight = Inventory.getItemData(i)

		local maxPushAmount = 100 / singleItemWeight
		if itemId ~= -1 then
			local filter = AutoStorage.getFilter(enchantKey)
			-- print("Up until 2 " .. Infinity.Win32.GetPerformanceCounter() - sTime .. " ms")

			-- Just needed if we use a profile with old entries pre PushableAmount update. it is only updated for UI reasons
			if filter ~= nil and filter.PushableAmount == nil then
				filter.PushableAmount = maxPushAmount
				AutoStorage.SaveCurrentProfile()
			end

			if filter ~= nil and filter.Enabled then
				if count >= filter.MinStack then
					local pushAmount = count
					if pushAmount > maxPushAmount then
						pushAmount = maxPushAmount
					end

					PushInventoryItemToWarehouse():construct(true, 0, enchantKey, i, pushAmount,
                                         					Infinity.BDO.getLocalPlayer():getActorKey(), 0).Packet:send()

					pushedSomething = true
					-- Calculating a new timing for next push
					if AutoStorage.CurrentProfile.enableRandomWaits then
						local randomNumber = math.random()
						local diff = AutoStorage.CurrentProfile.maxWaitPushingToWarehouse -
             							AutoStorage.CurrentProfile.minWaitPushingToWarehouse
						local randomWaitDelay = AutoStorage.CurrentProfile.minWaitPushingToWarehouse + (randomNumber * diff)
						noPushToWarehouseUntil = time + randomWaitDelay
						-- Breaking only if we need to wait. Otherwise sending one packet per pulse or all at once makes no difference to begin with
						break
					end
				else
					if forcePush and not pushedSomething then
						-- We remember what the best to push is (aka the highest weight we can push at once) because we are over the threshold and need to push something
						local pushableWeight = count * singleItemWeight
						if pushableWeight > bestItemToForceWeight then
							bestItemToForceWeight = pushableWeight
							bestItemToForceSlot = i
						end
					end
				end
			end
		end
	end

	if (not pushedSomething and bestItemToForceSlot ~= nil and bestItemToForceWeight > 0) then
		-- We did not push anything, but we need to, so we just push the best item
		local name
		local itemId
		local count
		local enchantKey
		local singleItemWeight

		name, itemId, count, enchantKey, singleItemWeight = Inventory.getItemData(bestItemToForceSlot)

		local maxPushAmount = 100 / singleItemWeight
		local pushAmount = count
		if pushAmount > maxPushAmount then
			pushAmount = maxPushAmount
		end
		local maxPushAmount = 100 / singleItemWeight

		PushInventoryItemToWarehouse():construct(true, 0, enchantKey, bestItemToForceSlot, pushAmount,
                                         		Infinity.BDO.getLocalPlayer():getActorKey(), 0).Packet:send()
	end
end

--[[
function AutoStorage.onAddItemToInventory(packet)
	if not AutoStorage.Running then
		return
	end

	AutoStorage.processInventoryItems()
end

function AutoStorage.OnPacketReceive(byteBuffer)
	local packetLength = byteBuffer:getShort()
	local isEncrypted = byteBuffer:get()
	local opCode = byteBuffer:getShort()

	local name = OpCodes.getAckName(opCode)

	if name == "AddItemToInventory" then
		AutoStorage.onAddItemToInventory(AddItemToInventoryAck(byteBuffer))
	end
end
]]

function AutoStorage.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function AutoStorage.OnRenderD2D()
end

function AutoStorage.SaveSettings()
	local json = JSON:new()
	Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(AutoStorage.Settings))
end

function AutoStorage.LoadSettings()
	local json = JSON:new()
	AutoStorage.Settings = Settings()
	table.merge(AutoStorage.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))
end

function AutoStorage.SaveCurrentProfile()
	if AutoStorage.CurrentProfile.Name == "" then
		return
	end

	local json = JSON:new()
	Infinity.FileSystem.WriteFile("Profiles\\" .. AutoStorage.CurrentProfile.Name .. ".json",
                              	json:encode_pretty(AutoStorage.CurrentProfile))
end

function AutoStorage.LoadLastProfile()
	local json = JSON:new()
	AutoStorage.CurrentProfile = ProfileSettings()
	local loadedTable = json:decode(Infinity.FileSystem.ReadFile("Profiles\\" .. AutoStorage.Settings.LastProfile))
	table.merge(AutoStorage.CurrentProfile, loadedTable)
	print(loadedTable.ProfileVersion)
	-- Checking that Profile Version is right
	if loadedTable.ProfileVersion == nil or AutoStorage.CurrentProfile.ProfileVersion == 0 then
		-- Updating to Version 1
		-- Updating from old ItemFilters list to ItemFilters hashmap
		local n = {}
		for _, v in pairs(AutoStorage.CurrentProfile.ItemFilters) do
			n[tostring(v.ItemEnchantKey)] = v
		end
		AutoStorage.CurrentProfile.ItemFilters = n
		AutoStorage.CurrentProfile.ProfileVersion = 1
		AutoStorage.SaveCurrentProfile()
	end

end
