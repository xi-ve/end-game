Warehouse = {}
CentralMarketWarehouse = {}

function Warehouse.getCurrentWaypointKey()
	local code =
	[[
		local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(((getSelfPlayer()):get()):getPosition())
  		return (regionInfoWrapper:getPlantKeyByWaypointKey()):getWaypointKey()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Warehouse.getCurrentWaypointKey2()
	local code =
	[[
		local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if nil == regionInfo then
    return
  end
  local myAffiliatedTownRegionKey = regionInfo:getAffiliatedTownRegionKey()
  local regionInfoWrapper = getRegionInfoWrapper(myAffiliatedTownRegionKey)
  local wayPointKey = regionInfoWrapper:getPlantKeyByWaypointKey():getWaypointKey()
  local wayKey = getCurrentWaypointKey()
  if ToClient_IsAccessibleRegionKey(myAffiliatedTownRegionKey) == false then
    local plantWayKey = ToClient_GetOtherRegionKey_NeerByTownRegionKey()
    local newRegionInfo = ToClient_getRegionInfoWrapperByWaypoint(plantWayKey)
    if nil == newRegionInfo then
      return
    end
    wayKey = newRegionInfo:get()._waypointKey
    if 0 == wayKey then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CANTFIND_WAREHOUSE_INTERRITORY"))
      return
    end
    wayPointKey = wayKey
  end

  return wayPointKey
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Warehouse.getCurrentWaypointKeyForMaid()
	local code =
	[[
		local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())

 		if nil == regionInfo then
    		return 0
  		end

  		local regionInfoWrapper = getRegionInfoWrapper(regionInfo:getAffiliatedTownRegionKey())
  		local plantWayKey = regionInfoWrapper:getPlantKeyByWaypointKey():getWaypointKey()
  		local regionKey = regionInfoWrapper:getRegionKey()

  		if ToClient_IsAccessibleRegionKey(regionKey) == false then
    		plantWayKey = ToClient_GetOtherRegionKey_NeerByTownRegionKey()

    		if 0 == plantWayKey then      		
      			return 0
    		end
  		end

  		return plantWayKey
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Warehouse.RequestCurrentRegionWarehouseInfo()
	local code = 
	[[
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if nil == regionInfo then
    return
  end
  local myAffiliatedTownRegionKey = regionInfo:getAffiliatedTownRegionKey()
  local regionInfoWrapper = getRegionInfoWrapper(myAffiliatedTownRegionKey)
  local wayPointKey = regionInfoWrapper:getPlantKeyByWaypointKey():getWaypointKey()
  local wayKey = getCurrentWaypointKey()
  if ToClient_IsAccessibleRegionKey(myAffiliatedTownRegionKey) == false then
    local plantWayKey = ToClient_GetOtherRegionKey_NeerByTownRegionKey()
    local newRegionInfo = ToClient_getRegionInfoWrapperByWaypoint(plantWayKey)
    if nil == newRegionInfo then
      return
    end
    wayKey = newRegionInfo:get()._waypointKey
    if 0 == wayKey then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CANTFIND_WAREHOUSE_INTERRITORY"))
      return
    end
    wayPointKey = wayKey
  end
  warehouse_requestInfo(wayPointKey)
  ]]

  Infinity.BDO.Lua.Execute(code)
end

function Warehouse.GetCurrentRegionWarehouseSilver()
	local code =
	[[	 	
		
  		local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if nil == regionInfo then
    return
  end
  local myAffiliatedTownRegionKey = regionInfo:getAffiliatedTownRegionKey()
  local regionInfoWrapper = getRegionInfoWrapper(myAffiliatedTownRegionKey)
  if ToClient_IsAccessibleRegionKey(regionInfo:getAffiliatedTownRegionKey()) == false then
    local plantWayKey = ToClient_GetOtherRegionKey_NeerByTownRegionKey()
    local newRegionInfo = ToClient_getRegionInfoWrapperByWaypoint(plantWayKey)
    if newRegionInfo == nil then
      --Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CANTFIND_WAREHOUSE_INTERRITORY"))
      return
    end
    myAffiliatedTownRegionKey = newRegionInfo:getRegionKey()
    if 0 == myAffiliatedTownRegionKey then
      --Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CANTFIND_WAREHOUSE_INTERRITORY"))
      return
    end
  end
  return Int64toDouble(warehouse_moneyFromRegionKey_s64(myAffiliatedTownRegionKey))
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Warehouse.getCurrentSilverCount()
	local code =
	[[	 	
		
  		local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(((getSelfPlayer()):get()):getPosition())
  		local waypointKey = (regionInfoWrapper:getPlantKeyByWaypointKey()):getWaypointKey()

		local warehouseWrapper = warehouse_get(]] .. Warehouse.getCurrentWaypointKeyForMaid() .. [[)
				
		if warehouseWrapper ~= nil then

			
				local itemWrapper = warehouseWrapper:getItem(0)

				if itemWrapper ~= nil then

					return Int64toDouble((itemWrapper:get()):getCount_s64())
				end
			
		end

		return -1
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Warehouse.getItemWeight(slot)
	local code =
	[[	 	
		
  		local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(((getSelfPlayer()):get()):getPosition())
  		local waypointKey = (regionInfoWrapper:getPlantKeyByWaypointKey()):getWaypointKey()

		local warehouseWrapper = warehouse_get(]] .. Warehouse.getCurrentWaypointKey() .. [[)
				
		if warehouseWrapper ~= nil then

			
				local itemWrapper = warehouseWrapper:getItem(]] .. slot .. [[)

				if itemWrapper ~= nil then
					local itemSSW = itemWrapper:getStaticStatus()
					return itemSSW:get()._weight / 10000
				end
			
		end

		return -1
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Warehouse.getItemCount(slot)
	local code =
	[[	 	
		
  		local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(((getSelfPlayer()):get()):getPosition())
  		local waypointKey = (regionInfoWrapper:getPlantKeyByWaypointKey()):getWaypointKey()

		local warehouseWrapper = warehouse_get(]] .. Warehouse.getCurrentWaypointKey() .. [[)
				
		if warehouseWrapper ~= nil then

			
				local itemWrapper = warehouseWrapper:getItem(]] .. slot .. [[)

				if itemWrapper ~= nil then
					return Int64toDouble((itemWrapper:get()):getCount_s64())
				end
			
		end

		return -1
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Warehouse.isStackable(slot)
	local code =
	[[	 	
		
  		local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(((getSelfPlayer()):get()):getPosition())
  		local waypointKey = (regionInfoWrapper:getPlantKeyByWaypointKey()):getWaypointKey()

		local warehouseWrapper = warehouse_get(]] .. Warehouse.getCurrentWaypointKey() .. [[)
				
		if warehouseWrapper ~= nil then

			
				local itemWrapper = warehouseWrapper:getItem(]] .. slot .. [[)

				if itemWrapper ~= nil then
					return itemWrapper:getStaticStatus():isStackable()
				end
			
		end

		return nil
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Warehouse.getItemId(slot)
	local code =
	[[	 	
		
  		local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(((getSelfPlayer()):get()):getPosition())
  		local waypointKey = (regionInfoWrapper:getPlantKeyByWaypointKey()):getWaypointKey()

		local warehouseWrapper = warehouse_get(]] .. Warehouse.getCurrentWaypointKey() .. [[)
				
		if warehouseWrapper ~= nil then

			
				local itemWrapper = warehouseWrapper:getItem(]] .. slot .. [[)

				if itemWrapper ~= nil then
					return ((itemWrapper:get()):getKey()):getItemKey()
				end
			
		end

		return -1
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Warehouse.getItemDataByItemId(itemId, wpKey)
	local wpOverrideA = -1

	if wpKey ~= nil then
		wpOverrideA = wpKey
	end

	local code =
	[[		  	
		local count = 0
		local slot = -1

		local waypointOverride = ]] .. wpOverrideA .. [[

  		local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(((getSelfPlayer()):get()):getPosition())
  		local waypointKey = (regionInfoWrapper:getPlantKeyByWaypointKey()):getWaypointKey()

  		warehouse_requestInfo(waypointKey)
		local warehouseWrapper = warehouse_get(waypointKey)

		if waypointOverride ~= -1 then
			warehouse_requestInfo(waypointOverride)
			warehouseWrapper = warehouse_get(waypointOverride)
		end
		
		if warehouseWrapper ~= nil then

			local maxCount = warehouseWrapper:getMaxCount()

			for i=0, maxCount do

				local itemWrapper = warehouseWrapper:getItem(i)

				if itemWrapper ~= nil then

					local itemSSW = itemWrapper:getStaticStatus()
            		local itemId = ((itemWrapper:get()):getKey()):getItemKey()

            		if itemId == ]] .. itemId .. [[ then

            			count = Int64toDouble((itemWrapper:get()):getCount_s64())
            			slot = i

            			break
            		end
				end
			end
		end

		return count, slot
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Warehouse.getFreeSlots()
	local code =
	[[  		
		local warehouseWrapper = warehouse_get(]] .. Warehouse.getCurrentWaypointKey() .. [[)

		local freeSlots = 0

		if warehouseWrapper ~= nil then
			freeSlots = warehouseWrapper:getFreeCount()
		end

		return freeSlots
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Warehouse.moveToInventory(slot, count)
	local code =
	[[
		warehouse_popToInventoryByNpc(]] .. slot .. [[, ]] .. count .. [[, ((getSelfPlayer()):get()):getActorKeyRaw())
	]]

	Infinity.BDO.Lua.Execute(code)
end

function Warehouse.moveToInventoryByMaid(slot, count)
	local code =
	[[
		warehouse_requestInfo(]] .. Warehouse.getCurrentWaypointKeyForMaid() .. [[)
		warehouse_popToInventoryByMaid(]] .. slot .. [[, ]] .. count .. [[, ((getSelfPlayer()):get()):getActorKeyRaw())
	]]

	Infinity.BDO.Lua.Execute(code)
end

function Warehouse.moveToInventoryByInstallation(installationActorKey, slot, count)
	local code =
	[[
		warehouse_popToInventoryByInstallation(]] .. installationActorKey .. [[, ]] .. slot .. [[, ]] .. count .. [[, ((getSelfPlayer()):get()):getActorKeyRaw())
	]]

	Infinity.BDO.Lua.Execute(code)
end

function Warehouse.moveFromInventory(slot, count, whManagerKey)
	local code =
	[[
		warehouse_pushFromInventoryItemByNpc(0, ]] .. slot .. [[, ]] .. count .. [[, ]] .. whManagerKey .. [[)
	]]

	Infinity.BDO.Lua.Execute(code)
end

function Warehouse.moveFromInventoryByInstallation(installationActorKey, slot, count)
	local code =
	[[
		warehouse_pushFromInventoryItemByInstallation(]] .. installationActorKey .. [[, 0, ]] .. slot .. [[, ]] .. count .. [[, ((getSelfPlayer()):get()):getActorKeyRaw())		
	]]

	Infinity.BDO.Lua.Execute(code)
end

function CentralMarketWarehouse.moveFromInventory(slot, count, isMaid)
	local code = 
	[[
		requestMoveItemInventoryToWallet(0, ]] .. slot .. [[, ]] .. count .. [[, ]] .. tostring(isMaid) .. [[)
	]]

	Infinity.BDO.Lua.Execute(code)
end

function Warehouse.getWarehouseItemNoBySlotAndWaypointKey(whSlot, whKey)

	local code =
	[[ 
		local warehouseWrapper = warehouse_get(]] .. whKey .. [[)
		
		if warehouseWrapper ~= nil then
			local itemNo = warehouseWrapper:getItemNoBySlotNo(]] .. whSlot ..[[)
			if itemNo ~= nil then
				return tostring(itemNo)
			end
		end
		
		return -1
	]]

	return tonumber(Infinity.BDO.Lua.Execute(code))
end