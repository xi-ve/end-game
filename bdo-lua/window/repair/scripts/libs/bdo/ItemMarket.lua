ItemMarket = {}

function ItemMarket.getSilver()
    local code = [[
      local silverInfo = getWorldMarketSilverInfo()

      if silverInfo ~= nil then
        return tostring(silverInfo:getItemCount())
      end

      return -1
  ]]

    return tonumber(Infinity.BDO.Lua.Execute(code))
end

function ItemMarket.getCurrentWeight()
    local code = [[
      local currentWeight = getWorldMarketCurrentWeight()

      if currentWeight ~= nil then
        return currentWeight
      end

      return -1
  ]]

    return Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.getWeights()
    local code = [[
    local maxWeight = getWorldMarketMaxWeight()
    local additionalWeight = getWorldMarketAddWeight()
    local buffWeight = PaGlobalFunc_WorldMarket_GetAddWeightByBuff()
    
    if nil ~= maxWeight and nil ~= additionalWeight and nil ~= buffWeight then
      return maxWeight, additionalWeight, buffWeight
    end

    return 0, 0, 0
  ]]

    return Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.getFreeWeight()
  return ItemMarket.getMaxWeight() - ItemMarket.getCurrentWeight()
end

function ItemMarket.getMaxWeight()
    local code = [[
    local maxWeight = getWorldMarketMaxWeight()
    local additionalWeight = getWorldMarketAddWeight()
    local buffWeight = PaGlobalFunc_WorldMarket_GetAddWeightByBuff()
    
    if nil ~= maxWeight and nil ~= additionalWeight and nil ~= buffWeight then
      return maxWeight + additionalWeight + buffWeight
    end

    return 0
  ]]

    return Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.getMaxVolumeByMaid()
    local code = [[
    local hasKama = getSelfPlayer():get():isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_StarterPackage)

    local buffRate = 1
    if hasKama then
      buffRate = 2
    end

    local maxVT = __eTWorldTradeMarketMaxVolumeByMaid * buffRate
    return maxVT
  ]]

    return Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.getMaxVolumeBySlot(slotNo)
    local code = [[
    local itemWrapper = getInventoryItemByType(PaGlobalFunc_MarketPlace_GetMyInvenTab(), ]] ..
                     slotNo .. [[)
    if nil == itemWrapper then
      return 0
    end

    local volume = Int64toInt32(itemWrapper:getStaticStatus():getWorldMarketVolume())
    local itemCount = Int64toInt32(itemWrapper:get():getCount_s64())
    local maxCountByVolume = ]] .. ItemMarket.getMaxVolumeByMaid() .. [[ / volume

    return maxCountByVolume
  ]]
  

    return Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.getMaxCountBySlot(slotNo)
    local code = [[
    local itemWrapper = getInventoryItemByType(PaGlobalFunc_MarketPlace_GetMyInvenTab(), ]] ..
                     slotNo .. [[)
    if nil == itemWrapper then
      return 0
    end

    local isStackable = itemWrapper:getStaticStatus():isStackable()
    if false == isStackable then
      return 1
    else
      return ]] .. ItemMarket.getMaxVolumeBySlot(slotNo) .. [[
    end
  ]]

    return Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.getMarketWeightForSlot(slotNo)
    local code = [[
    local itemWrapper = getInventoryItemByType(PaGlobalFunc_MarketPlace_GetMyInvenTab(), ]] ..
                     slotNo .. [[)

    if nil == itemWrapper then
      return -1
    end
      return Int64toInt32(itemWrapper:getStaticStatus():getWorldMarketVolume())
  ]]

    return Infinity.BDO.Lua.Execute(code)
end


---
function ItemMarket.exists(itemId)
  local code =
  [[
      local itemMarketSummaryInfo = getItemMarketSummaryInClientByItemEnchantKey(]] .. itemId .. [[)

      if itemMarketSummaryInfo ~= nil then
        return true
      end

      return false
  ]]

  return Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.getItemEntryCount(itemId)
  local code =
  [[
      return getItemMarketSellInfoInClientCount(0, ]] .. itemId .. [[)
  ]]

  return Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.getReservationCount()
  local code =
  [[
      return ToClient_GetItemMarketMyReservationsCount()
  ]]

  return Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.getSpecialDealsCount(itemId)
  local code =
  [[
      return ToClient_requestGetItemCountByItemEnchantKeyRaw(]] .. itemId .. [[)
  ]]

  return Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.getItemData(itemId)
  local code =
  [[
      local name = ""

      local itemMarketSummaryInfo = getItemMarketSummaryInClientByItemEnchantKey(]] .. itemId .. [[)

      if itemMarketSummaryInfo ~= nil then
        local iess = itemMarketSummaryInfo:getItemEnchantStaticStatusWrapper()
        
        name = iess:getName()
      end

      return name
  ]]

  return Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.getSellData(itemKeyRaw, index)
  local code =
  [[
      local singlePrice = 0
      local count = 0
      local isBiddingTime = false
      local isBiddingJoinTime = false
      local joinedBidding = false

      local sellInfo = getItemMarketSellInfoInClientByIndex(0, ]] .. itemKeyRaw .. [[, ]] .. index .. [[)

      if sellInfo ~= nil then
        singlePrice = Int64toInt32(sellInfo:getTotalPrice() / sellInfo:getCount())
        count = Int64toInt32(sellInfo:getCount())
        isBiddingTime = sellInfo:isBiddingItem()
        isBiddingJoinTime = sellInfo:isBiddingJoinTime()
        joinedBidding = isBiddingJoinItem(sellInfo:getItemMarketNo())
      end

      return singlePrice, count, isBiddingTime, isBiddingJoinTime, joinedBidding
  ]]

  return Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.getRegistredCount()
	return Infinity.BDO.Lua.Execute("return getItemMarketMyItemsCount()")
end

function ItemMarket.getSaleInfo(idx)
  local code =
  [[
        local isTraded = false
        local itemEnchantKey = 0        
        local totalPrice = 0
        local tradedTotalPrice = 0

        local myItemInfo = getItemMarketMyItemByIndex(]] .. idx .. [[)

        if myItemInfo ~= nil then

            local iess = myItemInfo:getItemEnchantStaticStatusWrapper()

            isTraded = myItemInfo:isTraded()
            itemEnchantKey = ((iess:get())._key):get()
            --enchantLevel = iess:get()._key:getEnchantLevel()
            totalPrice = Int64toInt32(myItemInfo:getTotalPrice())
            tradedTotalPrice = Int64toInt32(myItemInfo:getTradedTotalPrice())
        end

        return isTraded, itemEnchantKey, totalPrice, tradedTotalPrice
  ]]

  return Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.getSaleCount()
	local code =
	[[
		local saleCount = 0

  		local totalCount = getItemMarketMyItemsCount()

  		for idx = 0, totalCount - 1 do
    		local myItemInfo = getItemMarketMyItemByIndex(idx)

    		if myItemInfo ~= nil and myItemInfo:isTraded() then
      			saleCount = saleCount + 1
    		end
  		end

  		return saleCount
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.getAllToWarehouse()
	local code =
	[[
		ToClient_CalculateAllMyBidding(false)
	]]

	Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.getNextSoldItem()
  local code =
  [[
      local myItemCount = (getItemMarketMyItemsCount())
      
      for i = 0, myItemCount - 1 do
        local myItemInfo = getItemMarketMyItemByIndex(i)

        if myItemInfo ~= nil then
            local iess = myItemInfo:getItemEnchantStaticStatusWrapper()

            if iess ~= nil and myItemInfo:isTraded() then
              return ((iess:get())._key):get()
            end
        end
      end

      return 0
  ]]

  return Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.registerItemFromInventory(slotNo, price, count)
  local code =
  [[
    requestRegisterItemForItemMarket(0, ]] .. slotNo .. [[, ]] .. count .. [[, ]] .. price .. [[, 0)
  ]]

  Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.sellItemToWorldMarket(itemId, minLevel, count, price, itemLevel, isSealed)
  local code =
  [[
    ToClient_requestSellItemToWorldMarket(]] .. itemId .. [[, ]] .. minLevel .. [[, ]] .. count .. [[, ]] .. price .. [[, ]] .. itemLevel .. [[, ]] .. tostring(isSealed) .. [[)
  ]]

  Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.buyItem(itemKeyRaw, moneyWhereType, slot, count)
  local code =
  [[
    requestBuyItemForItemMarket(]] .. moneyWhereType .. [[, ]] .. itemKeyRaw .. [[, ]] .. slot .. [[, ]] .. count .. [[, 0)
  ]]

  Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.buyItemByMaid(itemKeyRaw, moneyWhereType, slot, count)
  local code =
  [[
    requestBuyItemForItemMarketByMaid(]] .. moneyWhereType .. [[, ]] .. itemKeyRaw .. [[, ]] .. slot .. [[, ]] .. count .. [[, 0)
  ]]

  Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.buyItemFromSpecialDeals(itemKeyRaw, moneyWhereType, slot)
  local code =
  [[
    ToClient_requestBuyItemAtItemMarketByParty(]] .. moneyWhereType .. [[, ]] .. itemKeyRaw .. [[, ]] .. slot .. [[)
  ]]

  Infinity.BDO.Lua.Execute(code)
end

function ItemMarket.buyItemFromSpecialDealsByMaid(itemKeyRaw, moneyWhereType, slot)
  local code =
  [[
    ToClient_requestBuyItemAtItemMarketByPartyByMaid(]] .. moneyWhereType .. [[, ]] .. itemKeyRaw .. [[, ]] .. slot .. [[)
  ]]

  Infinity.BDO.Lua.Execute(code)
end