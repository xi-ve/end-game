local Shop = {}
local lastShopOpened = {npcActorKey = nil, time = 0}
local getTime = MagLib.getTime
local shopOpenMaxTimeDiff = 2000

local settings = {buyDelay = 250}

MagLib.Core.Settings.addSettingsToHandler("MagLib_Shop", settings)

local buyFunc = function(npcActor, itemKey, amount, moneyWhereType)
	local time = getTime()
	local npcActorKey = npcActor:getActorKey()

	-- Settings the talker and requesting shop data if needed. Will do it based on last openend shop AND based on time
	if lastShopOpened.npcActorKey ~= npcActorKey or lastShopOpened.time + shopOpenMaxTimeDiff < time then
		MagLib.logger.debug("Setting Talker NPC and requesting Shop Data")
		Infinity.BDO.getDialogManager():setTalker(npcActor)
		Infinity.BDO.getShopManager():requestShopData(npcActorKey)
		Infinity.BDO.Lua.Execute("npcShop_requestList(CppEnums.ContentsType.Contents_Shop, true)")
		lastShopOpened.npcActorKey = npcActorKey
		lastShopOpened.time = time
		return false
	end

	-- Getting slot in shop of wanted item
	local slotInShop, price = Shop.getItemDataByKey(itemKey)
	if slotInShop == nil then
		MagLib.logger.warning("Could not find item with key " .. itemKey .. " in shop")
	else
		-- Buying the item
		-- MagLib.logger.debug("Buying " .. amount .. " items with the key " .. itemKey)
		Infinity.BDO.Lua.Execute("npcShop_doBuy(" .. slotInShop .. "," .. amount .. ", " .. moneyWhereType ..
                         			", CppEnums.ItemWhereType.eInventory, false)")
	end

	MagLib.BDO.NPC.closeDialog()
	return true
end

local currentlyBuying = false
local buyCompleteDelayTask = function()
	currentlyBuying = false
	MagLib.BDO.NPC.closeDialog()
	return true
end

Shop.buy = function(npcActor, itemKey, amount, moneyWhereType, isStackable)
	local taskFunc = function(self)
		local result = nil
		local actuallyBoughtSomething = true

		if currentlyBuying == true then
			return false
		end

		if isStackable or amount == 1 then
			-- If it is stackable or we just need one we just need to buy it once fully
			result = buyFunc(npcActor, itemKey, amount, moneyWhereType)
			actuallyBoughtSomething = result
		else
			-- Recursively call ourself to buy the item one at a time since it is a none stackable item.
			for i = 0, amount - 1 do
				Shop.buy(npcActor, itemKey, 1, moneyWhereType, isStackable)
			end
			result = true
			actuallyBoughtSomething = false -- We did not buy anything, so we do not want the event to trigger.
		end

		if result == true and actuallyBoughtSomething == true then
			-- Trigger Event since we bought something.
			MagLib.Events.triggerEvent("Shop_BuyComplete", {itemKey = itemKey, amount = amount})

			-- Make a delayed task to wait for a while until the next purchase
			MagLib.Run.Tasks.newDelayed("Buy complete Delay", 1 / 0, buyCompleteDelayTask, settings.buyDelay)
		end
		return result
	end

	MagLib.Run.Tasks.new("BuyTask", 1000 + settings.buyDelay, taskFunc)

	if isStackable == nil then
		isStackable = true
	end

end

-- Requires for the shopData to be already requested at least one pulse prior.
-- Returns the slot and the price of an item inside the shop (if found inside the shop)
Shop.getItemDataByKey = function(key)
	local shopSlots = Infinity.BDO.Lua.Execute("return npcShop_getBuyCount()") - 1
	if shopSlots > 0 then
		for i = 0, shopSlots do
			local code = [[
      local _shop_item_index = npcShop_getItemBuy("]] .. i .. [[")
      local _shop_item = _shop_item_index:get()
      local _shop_item_id = _shop_item_index:getStaticStatus():get()._key:getItemKey()
      local _shop_item_price = Int64toInt32(_shop_item:getItemPriceWithOption())

      return _shop_item_id, _shop_item_price
      ]]

			local shopItemKey, shopItemPrice = Infinity.BDO.Lua.Execute(code)
			if shopItemKey == key then
				return i, shopItemPrice
			end
		end
	end
end

Shop.closeShopWindow = function()
	Infinity.BDO.Lua.Execute("handleClickedNpcShow_WindowClose()")
	MagLib.BDO.NPC.closeDialog()
end

MagLib.BDO.NPC.Shop = Shop
