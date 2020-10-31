Inventory = {}
CashInventory = {}
ServantInventory = {}

function Inventory.getNextFishingRodSlot()
	local code = [[
		local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

  		if inventory == nil then
    		return -1
  		end

  		local invenMaxSize = inventory:sizeXXX()

  		for ii = 0, invenMaxSize - 1 do
    		local itemWrapper = getInventoryItem(ii)

    		if itemWrapper ~= nil then
      			if (itemWrapper:getStaticStatus()):getEquipType() == 44 then
      				local endurance = (itemWrapper:get()):getEndurance()

      				if endurance > 0 then
      					return ii
      				end
      			end
        	end
      	end

        return -1
	]]

	local ret = Infinity.BDO.Lua.Execute(code)

	if ret < 0 then
		return -1
	end

	return ret
end

function Inventory.getNextFloatSlot()
	local code = [[
    local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      if inventory == nil then
        return -1
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
            if (itemWrapper:getStaticStatus()):getEquipType() == 59 then
              local endurance = (itemWrapper:get()):getEndurance()

              if endurance > 0 then
                return ii
              end
            end
          end
        end

        return -1
  ]]

	local ret = Infinity.BDO.Lua.Execute(code)

	if ret < 0 then
		return -1
	end

	return ret
end

function Inventory.getNextToolSlot()
	local code = [[
    local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      if inventory == nil then
        return -1
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
            if (itemWrapper:getStaticStatus()):getEquipType() == 46 then
              local endurance = (itemWrapper:get()):getEndurance()

              if endurance > 0 then
                return ii
              end
            end
          end
        end

        return -1
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getNextToolSlotZeroDurabilityNonRepairable()
	local code = [[
    local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      if inventory == nil then
        return -1
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
            if (itemWrapper:getStaticStatus()):getEquipType() == 46 then
              local endurance = (itemWrapper:get()):getEndurance()

              local isAble = itemWrapper:checkToRepairItem()

              if not isAble and endurance <= 0 then
                return ii
              end
            end
          end
        end

        return -1
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getAvailableFishingRodDurability()
	local code = [[
    local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      local totalDura = 0

      if inventory == nil then
        return totalDura
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
            if (itemWrapper:getStaticStatus()):getEquipType() == 44 then
              local endurance = (itemWrapper:get()):getEndurance()

              if endurance > 0 then
                totalDura = totalDura + endurance
              end
            end
          end
        end

        return totalDura
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getAvailableHarpoonDurability()
	local code = [[
    local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      local totalDura = 0

      if inventory == nil then
        return totalDura
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
            if (itemWrapper:getStaticStatus()):getEquipType() == 48 then
              local endurance = (itemWrapper:get()):getEndurance()

              if endurance > 0 then
                totalDura = totalDura + endurance
              end
            end
          end
        end

        return totalDura
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.combinePuzzle(itemId)
	local code = [[
      local ID_Relic = 40218
      local ID_Book = 40220
      local ID_Scroll = 40228
      local ID_Doll = 40383

      local iItem = ]] .. itemId .. [[

      local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      if inventory == nil then
        return
      end

      local invenMaxSize = inventory:sizeXXX()

      local tItems = {}
      local cItems = 0

      for ii = 0, invenMaxSize - 1 do

        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
            
          if ((itemWrapper:get()):getKey()):getItemKey() == iItem then
            cItems = cItems + 1
            tItems[cItems] = ii
          end
        end
      end

      if cItems >= 5 then

        local isFind = findPuzzleAndReadyMake(0)

        if isFind then

          requestMakePuzzle()
        else

          local cSlots = {3,10,11,12,19}

          if tItems[1] ~= cSlots[1] then
            inventory_swapItem(0, tItems[1], cSlots[1])
          end

          if tItems[2] ~= cSlots[2] then
            inventory_swapItem(0, tItems[2], cSlots[2])
          end

          if tItems[3] ~= cSlots[3] then
            inventory_swapItem(0, tItems[3], cSlots[3])
          end

          if tItems[4] ~= cSlots[4] then
            inventory_swapItem(0, tItems[4], cSlots[4])
          end

          if tItems[5] ~= cSlots[5] then
            inventory_swapItem(0, tItems[5], cSlots[5])
          end

          isFind = findPuzzleAndReadyMake(0)

          if isFind then

            requestMakePuzzle()
          end
        end
      end
  ]]

	Infinity.BDO.Lua.Execute(code)
end

function Inventory.hasPuzzleReady()
	return Infinity.BDO.Lua.Execute("return findPuzzleAndReadyMake(0)")
end

function Inventory.makePuzzle()
	Infinity.BDO.Lua.Execute("requestMakePuzzle()")
end

function Inventory.swapItem(fromSlot, toSlot)
	Infinity.BDO.Lua.Execute("inventory_swapItem(0, " .. fromSlot .. ", " .. toSlot .. ")")
end

function Inventory.getNextNonRepairableFishingRodSlot()
	local code = [[
    local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      if inventory == nil then
        return -1
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
            if (itemWrapper:getStaticStatus()):getEquipType() == 44 then
              local endurance = (itemWrapper:get()):getEndurance()

              if endurance == 0 then
                local isAble = itemWrapper:checkToRepairItem()

                if not isAble then
                    return ii
                end
              end
            end
          end
        end
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getNextNonRepairableHarpoonSlot()
	local code = [[
    local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      if inventory == nil then
        return -1
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
            if (itemWrapper:getStaticStatus()):getEquipType() == 48 then
              local endurance = (itemWrapper:get()):getEndurance()

              if endurance == 0 then
                local isAble = itemWrapper:checkToRepairItem()

                if not isAble then
                    return ii
                end
              end
            end
          end
        end
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getRepairableFishingRodSlots()
	local code = [[
    local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      local repairableSlots = {}

      if inventory == nil then
        return unpack(repairableSlots)
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
            if (itemWrapper:getStaticStatus()):getEquipType() == 44 then
              local endurance = (itemWrapper:get()):getEndurance()
              local maxendurance = (itemWrapper:get()):getMaxEndurance()
                local isAble = itemWrapper:checkToRepairItem()

                if isAble and endurance < maxendurance then
                    table.insert(repairableSlots, ii)
                end
              
            end
          end
        end

        return unpack(repairableSlots)
  ]]

	return {Infinity.BDO.Lua.Execute(code)}
end

function Inventory.getRepairableFloatSlots()
	local code = [[
    local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      local repairableSlots = {}

      if inventory == nil then
        return unpack(repairableSlots)
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
            if (itemWrapper:getStaticStatus()):getEquipType() == 59 then
              local endurance = (itemWrapper:get()):getEndurance()
              local maxendurance = (itemWrapper:get()):getMaxEndurance()
                local isAble = itemWrapper:checkToRepairItem()

                if isAble and endurance < maxendurance then
                    table.insert(repairableSlots, ii)
                end
              
            end
          end
        end

        return unpack(repairableSlots)
  ]]

	return {Infinity.BDO.Lua.Execute(code)}
end

function Inventory.getRepairableFishingRodSlotsByPercentage(percentage)
	local code = [[
    local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      local repairableSlots = {}

      if inventory == nil then
        return unpack(repairableSlots)
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
            if (itemWrapper:getStaticStatus()):getEquipType() == 44 then
              local endurance = (itemWrapper:get()):getEndurance()
              local maxendurance = (itemWrapper:get()):getMaxEndurance()
                local isAble = itemWrapper:checkToRepairItem()

                local pEndurance = (endurance/maxendurance)*100

                if isAble and pEndurance <= ]] .. percentage .. [[ then
                    table.insert(repairableSlots, ii)
                end
              
            end
          end
        end

        return unpack(repairableSlots)
  ]]

	return {Infinity.BDO.Lua.Execute(code)}
end

function Inventory.getRepairableFloatSlotsByPercentage(percentage)
	local code = [[
    local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      local repairableSlots = {}

      if inventory == nil then
        return unpack(repairableSlots)
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
            if (itemWrapper:getStaticStatus()):getEquipType() == 59 then
              local endurance = (itemWrapper:get()):getEndurance()
              local maxendurance = (itemWrapper:get()):getMaxEndurance()
                local isAble = itemWrapper:checkToRepairItem()

                local pEndurance = (endurance/maxendurance)*100

                if isAble and pEndurance <= ]] .. percentage .. [[ then
                    table.insert(repairableSlots, ii)
                end
              
            end
          end
        end

        return unpack(repairableSlots)
  ]]

	return {Infinity.BDO.Lua.Execute(code)}
end

function Inventory.getMaxSize()
	local code = [[
    local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      if inventory == nil then
        return 0
      end

      return inventory:sizeXXX()
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.hasItemWrapper(slot)
	local code = [[
    return getInventoryItem(]] .. slot .. [[) ~= nil
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getItemGrade(slot)
	local code = [[
    local itemWrapper = getInventoryItem(]] .. slot .. [[)

    if itemWrapper == nil then
      return false
    end

    return (itemWrapper:getStaticStatus()):getGradeType()
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.isTradeable(slot)
	local code = [[
    local itemWrapper = getInventoryItem(]] .. slot .. [[)

    if itemWrapper == nil then
      return false
    end

    return (itemWrapper:getStaticStatus()):isTradeAble()
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.isStackable(slot)
	local code = [[
    local itemWrapper = getInventoryItem(]] .. slot .. [[)

    if itemWrapper == nil then
      return false
    end

    return (itemWrapper:getStaticStatus()):isStackable()
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getItemData(slot)
	local code = [[
    local name = ""
    local itemId = -1
    local count = -1
    local itemEnchantKeyRaw = -1
    local singleItemWeight = -1

    local itemWrapper = getInventoryItem(]] .. slot .. [[)

    if itemWrapper ~= nil then
      name = (itemWrapper:getStaticStatus()):getName()
      itemId = ((itemWrapper:get()):getKey()):getItemKey()
      itemEnchantKeyRaw = (((itemWrapper:getStaticStatus()):get())._key):get()
      count = Int64toDouble((itemWrapper:get()):getCount_s64())
      singleItemWeight = itemWrapper:getStaticStatus():get()._weight / 10000
    end

    return name, itemId, count, itemEnchantKeyRaw, singleItemWeight
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getItemName(slot)
	local code = [[
    local name = nil
    
    local itemWrapper = getInventoryItem(]] .. slot .. [[)

    if itemWrapper ~= nil then
      name = (itemWrapper:getStaticStatus()):getName()      
    end

    return name
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getItemCooldownMS(slot)
	local code = [[  
    local remainTime = 0
    local itemReuseTime = 0
    local realRemainTime = 0
    local intRemainTime = 0
    
    remainTime = getItemCooltime(0, ]] .. slot .. [[)
    itemReuseTime = getItemReuseCycle(0, ]] .. slot .. [[) / 1000
    realRemainTime = remainTime * (itemReuseTime)    

    return realRemainTime * 1000
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getItemPriceData(slot)
	local code = [[  
    local minP = 0
    local maxP = 0
    local recentP = 0
    local maxRegCount = 0

    local itemWrapper = getInventoryItem(]] .. slot .. [[)

    if itemWrapper ~= nil then
      local itemSS = itemWrapper:getStaticStatus() 
      local summaryInfo = getItemMarketSummaryInClientByItemEnchantKey(((itemSS:get())._key):get())
      local masterInfo = getItemMarketMasterByItemEnchantKey(((itemSS:get())._key):get())

      if summaryInfo ~= nil and masterInfo ~= nil then 
        recentP = Int64toDouble(summaryInfo:getLastTradedOnePrice())
        maxP = Int64toDouble(masterInfo:getMaxPrice())
        minP = Int64toDouble(masterInfo:getMinPrice())
        maxRegCount = Int64toDouble(masterInfo:getMaxRegisterCount())
      end
    end

    return minP, maxP, recentP, maxRegCount
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getRelicShardCount()
	local code = [[        
      local inventory = ((getSelfPlayer()):get()):getInventoryByType(17)

      local count = 0

      if inventory == nil then
        return count
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
        
        local itemId = ((itemWrapper:get()):getKey()):getItemKey()        

          if itemId == 40218 then  

            count = count + 1
          end
        end
      end

      return count
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getCashItemSlotItemId(itemId)
	local code = [[        
      local inventory = ((getSelfPlayer()):get()):getInventoryByType(17)

      if inventory == nil then
        return 0
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItemByType(17,ii)

        if itemWrapper ~= nil then
        
        local itemId = ((itemWrapper:get()):getKey()):getItemKey()        

          if itemId == ]] .. itemId .. [[ then  

            return ii
          end
        end
      end

      return 0
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getItemSlotItemId(itemId)
	local code = [[        
      local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      if inventory == nil then
        return 0
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
        
        local itemId = ((itemWrapper:get()):getKey()):getItemKey()        

          if itemId == ]] .. itemId .. [[ then  

            return ii
          end
        end
      end

      return 0
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getItemSlotByItemEnchantKey(itemEnchantKeyRaw)
	local code = [[        
      local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      if inventory == nil then
        return 0
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
          local itemSSW = itemWrapper:getStaticStatus()
          
          if itemSSW:get()._key:get() == ]] .. itemEnchantKeyRaw .. [[ then

            return ii
          end
        end
      end

      return 0
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getInventoryWeight()
	local code = [[
    local allWeight = Int64toInt32(getSelfPlayer():get():getCurrentWeight_s64())
    return allWeight
    ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getInventoryMaxWeight()
	local code = [[
    local maxWeight = Int64toInt32(getSelfPlayer():get():getPossessableWeight_s64())
    return maxWeight
    ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getInventoryWeightPercent()
	local code = [[
    local inventorySize = getSelfPlayer():get():getInventorySlotCount(false)
    local allWeight = Int64toInt32(getSelfPlayer():get():getCurrentWeight_s64())
    local maxWeight = Int64toInt32(getSelfPlayer():get():getPossessableWeight_s64())
    return (allWeight / maxWeight) * 100
    ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getWeight(slot)
	local code = [[      
      local itemWrapper = getInventoryItem(]] .. slot .. [[)

      if itemWrapper == nil then
        return -1
      end

      local itemSSW = itemWrapper:getStaticStatus()
      return itemSSW:get()._weight / 10000
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getMarketWeight(slot)
	local code = [[      
      local itemWrapper = getInventoryItem(]] .. slot .. [[)

      if itemWrapper == nil then
        return -1
      end

      local itemSSW = itemWrapper:getStaticStatus()
      return Int64toInt32(itemSSW:getWorldMarketVolume()) / 10
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getItemDataByItemId(itemId)
	local code = [[
      local count = 0
      local slot = -1

      local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      if inventory == nil then
        return count, slot
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
        
        local itemId = ((itemWrapper:get()):getKey()):getItemKey()
        local enchantLevel = ((itemWrapper:get()):getKey()):getEnchantLevel()

          if itemId == ]] .. itemId .. [[ then
            count = Int64toDouble((itemWrapper:get()):getCount_s64())
            slot = ii

            break
          end
        end
      end

      return count, slot
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getItemCountByItemId(itemId, enchantLevel)
	local code = [[
      local count = 0

      local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      if inventory == nil then
        return count
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
        
        local itemId = ((itemWrapper:get()):getKey()):getItemKey()
        local enchantLevel = ((itemWrapper:get()):getKey()):getEnchantLevel()

          if itemId == ]] .. itemId .. [[ and enchantLevel == ]] .. enchantLevel .. [[ then
            count = count + Int64toDouble((itemWrapper:get()):getCount_s64())
          end
        end
      end

      return count
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getItemCount(slot)
	local code = [[
    local itemWrapper = getInventoryItem(]] .. slot .. [[)

    return Int64toDouble((itemWrapper:get()):getCount_s64())
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getDurability(slot)
	local code = [[
    local itemWrapper = getInventoryItem(]] .. slot .. [[)

    return (itemWrapper:get()):getEndurance()
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getEquipSlot(slot)
	local code = [[    
    local itemWrapper = getInventoryItem(]] .. slot .. [[)

    return (itemWrapper:getStaticStatus()):getEquipSlotNo()
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function CashInventory.getMaxSize()
	local code = [[
    local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eCashInventory)

      if inventory == nil then
        return 0
      end

      return inventory:sizeXXX()
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function CashInventory.hasItemWrapper(slot)
	local code = [[
    return getCashInventoryItem(]] .. slot .. [[) ~= nil
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function CashInventory.getItemCooldownMS(slot)
	local code = [[  
    local remainTime = 0
    local itemReuseTime = 0
    local realRemainTime = 0
    local intRemainTime = 0
    
    remainTime = getItemCooltime(17, ]] .. slot .. [[)
    itemReuseTime = getItemReuseCycle(17, ]] .. slot .. [[) / 1000
    realRemainTime = remainTime * (itemReuseTime)    

    return realRemainTime * 1000
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function CashInventory.getItemCountByItemId(itemId, enchantLevel)
	local code = [[
      local count = 0

      local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eCashInventory)

      if inventory == nil then
        return count
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getCashInventoryItem(ii)

        if itemWrapper ~= nil then
        
        local itemId = ((itemWrapper:get()):getKey()):getItemKey()
        local enchantLevel = ((itemWrapper:get()):getKey()):getEnchantLevel()

          if itemId == ]] .. itemId .. [[ and enchantLevel == ]] .. enchantLevel .. [[ then
            count = count + Int64toDouble((itemWrapper:get()):getCount_s64())
          end
        end
      end

      return count
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function CashInventory.getItemSlotItemId(itemId)
	local code = [[        
      local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eCashInventory)

      if inventory == nil then
        return 0
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getCashInventoryItem(ii)

        if itemWrapper ~= nil then
        
        local itemId = ((itemWrapper:get()):getKey()):getItemKey()        

          if itemId == ]] .. itemId .. [[ then  

            return ii
          end
        end
      end

      return 0
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function CashInventory.getItemData(slot)
	local code = [[
    local name = ""
    local itemId = 0
    local count = 0
    local itemEnchantKeyRaw = 0

    local itemWrapper = getCashInventoryItem(]] .. slot .. [[)

    if itemWrapper ~= nil then
      name = (itemWrapper:getStaticStatus()):getName()
      itemId = ((itemWrapper:get()):getKey()):getItemKey()
      itemEnchantKeyRaw = (((itemWrapper:getStaticStatus()):get())._key):get()
      count = Int64toDouble((itemWrapper:get()):getCount_s64())
    end

    return name, itemId, count, itemEnchantKeyRaw
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function CashInventory.getEquipSlot(slot)
	local code = [[
    local itemWrapper = getCashInventoryItem(]] .. slot .. [[)

    return (itemWrapper:getStaticStatus()):getEquipSlotNo()
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function CashInventory.getIsBound(slot)
	local code = [[
    local itemWrapper = getCashInventoryItem(]] .. slot .. [[)

    if itemWrapper == nil then
      return true
    end

    return itemWrapper:checkToClearVested()
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function CashInventory.getExtraction_CronCount(slot)
	local code = [[
    local itemWrapper = getCashInventoryItem(]] .. slot .. [[)

    return Int64toDouble(itemWrapper:getStaticStatus():getCronCount_s64())
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function CashInventory.getExtraction_ValksCount(slot)
	local code = [[
    local itemWrapper = getCashInventoryItem(]] .. slot .. [[)

    return Int64toDouble(itemWrapper:getStaticStatus():getExtractionCount_s64())
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function CashInventory.useItem(slot)
	local code = [[
      inventoryUseItem(17, ]] .. slot .. [[, nil, true)
  ]]

	Infinity.BDO.Lua.Execute(code)
end

function Inventory.getNextMainhandSlot()
	local code = [[
    local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      if inventory == nil then
        return -1
      end

      local invenMaxSize = inventory:sizeXXX()

      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItem(ii)

        if itemWrapper ~= nil then
            if (itemWrapper:getStaticStatus()):getEquipSlotNo() == 0 then
              return ii              
            end
          end
        end

        return -1
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.deleteItem(slotNo)
	local code = [[
    local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      if inventory == nil then
        return
      end

      local itemWrapper = getInventoryItem(]] .. slotNo .. [[)

      deleteItem((getSelfPlayer()):getActorKey(), CppEnums.ItemWhereType.eInventory, ]] .. slotNo ..
             		[[, (itemWrapper:get()):getCount_s64())      
  ]]

	Infinity.BDO.Lua.Execute(code)
end

function Inventory.getFreeSlotCount()
	local code = [[
      local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)

      if inventory == nil then
        return 0
      end

      return inventory:getFreeCount()
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function Inventory.useItem(slot)
	local code = [[
      inventoryUseItem(0, ]] .. slot .. [[, nil, true)
  ]]

	Infinity.BDO.Lua.Execute(code)
end

function Inventory.moveFromActorToActor(fromActorKey, toActorKey, fromWhereType, fromSlot, count)
	local code = [[
    moveInventoryItemFromActorToActor(]] .. fromActorKey .. [[, ]] .. toActorKey .. [[, ]] .. fromWhereType .. [[, ]] ..
             		fromSlot .. [[, ]] .. count .. [[)
  ]]

	Infinity.BDO.Lua.Execute(code)
end

function ServantInventory.getSlot(vehicleActorKey, itemId)
	local code = [[
    local vehicleActorWrapper = getVehicleActor(]] .. vehicleActorKey .. [[)

    if vehicleActorWrapper == nil then
      return -1
    end

    local vehicleActor = vehicleActorWrapper:get()

    if vehicleActor == nil then
      return -1
    end

    local inventory = vehicleActor:getInventory()

    if inventory == nil then
      return -1
    end

    local fullCount = inventory:size()

    for ii = 0, fullCount - 1 do    
      local itemWrapper = getServantInventoryItemBySlotNo(]] .. vehicleActorKey .. [[, ii)

      if nil ~= itemWrapper and ((itemWrapper:get()):getKey()):getItemKey() == ]] .. itemId .. [[ then
        return ii
      end
    end

    return -1
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

function ServantInventory.getCount(vehicleActorKey, slot)
	local code = [[
    local itemWrapper = getServantInventoryItemBySlotNo(]] .. vehicleActorKey .. [[, ]] .. slot .. [[)

    if nil ~= itemWrapper then
      return Int64toDouble((itemWrapper:get()):getCount_s64())
    end

    return -1
  ]]

	return Infinity.BDO.Lua.Execute(code)
end
