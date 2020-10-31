--[[function Warehouse.getCurrentSilverCount()
    Log.debugLog("Warehouse getCurrentSilverCount")
    local code =
    [[

  		local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(((getSelfPlayer()):get()):getPosition())
  		local waypointKey = (regionInfoWrapper:getPlantKeyByWaypointKey()):getWaypointKey()

		local warehouseWrapper = warehouse_get(]] --[[.. Warehouse.getCurrentWaypointKey() .. --[[)

    if warehouseWrapper ~= nil then


        local itemWrapper = warehouseWrapper:getItem(0)

        if itemWrapper ~= nil then

            return Int64toDouble((itemWrapper:get()):getCount_s64())
        end

    end

    return - 1
    ]]

    --return Infinity.BDO.Lua.Execute(code)
    --end

    --function Warehouse.moveToInventory(slot, count)
    --    local code = [[
--    warehouse_requestInfo(getCurrentWaypointKey())
--		warehouse_popToInventoryByNpc(]] .. slot .. "," .. count .. [[,((getSelfPlayer()):get()):getActorKeyRaw())]]

    --    Infinity.BDO.Lua.Execute(code)
    --end

    --function Warehouse.moveFromInventory(slot, count, whManagerKey)
    --    local code = [[
--    warehouse_requestInfo(getCurrentWaypointKey())
--		warehouse_pushFromInventoryItemByNpc(CppEnums.ItemWhereType.eInventory, ]] .. slot .. ", " .. count .. ", " .. whManagerKey .. [[)]]

    --    Infinity.BDO.Lua.Execute(code)
    --end
