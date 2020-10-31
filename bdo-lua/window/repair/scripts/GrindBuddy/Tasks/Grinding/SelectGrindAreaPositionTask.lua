SelectGrindAreaPositionTask = {}
SelectGrindAreaPositionTask._profile = nil
SelectGrindAreaPositionTask._areas = nil
SelectGrindAreaPositionTask._currentAreaId = nil
SelectGrindAreaPositionTask._currentSpotId = nil

function SelectGrindAreaPositionTask.work()
  Log.debugLog("SelectGrindAreaPositionTask work")
  SelectGrindAreaPositionTask._profile = Grinder.currentProfile
  SelectGrindAreaPositionTask._areas = SelectGrindAreaPositionTask._profile.areas

  if not Cache.playerPos then
    return nil
  end

  local selectedAreaId = SelectGrindAreaPositionTask.selectAreaId()
  if selectedAreaId == nil then
    Log.log("No area found to grind at :(")
    return nil
  end

  if selectedAreaId ~= SelectGrindAreaPositionTask._currentAreaId then
    SelectGrindAreaPositionTask._currentAreaId = selectedAreaId
    SelectGrindAreaPositionTask._currentSpotId = nil
    if Grinder.settings.log_verbose then
      Log.log("Switching to area #"..tostring(SelectGrindAreaPositionTask._currentAreaId))
    end
    Grinder.notInWarehouseIds = {} --Resetting warehouse, as it could be a new storage
    return true
  end

  --Setting SelectGrindAreaPositionTask._currentSpotId to closest grindspot in current profile
  if SelectGrindAreaPositionTask._currentSpotId == nil then
    --Finding closest grindspot..unclean code, who cares...this whole file is fcking horribly coded anyways. Magxm November/December 2018 was bad at lua
    print("Finding closest Grindspot to start at...")
    local pPos = Cache.playerPos
    local closestGrindSpotId = nil
    local closestGrindSpotDistance = 1 / 0
    for id, spot in pairs(SelectGrindAreaPositionTask._areas[SelectGrindAreaPositionTask._currentAreaId].spots) do
      local dist = pPos:getDistance(Vector3(spot.X, spot.Y, spot.Z))
      if (dist < closestGrindSpotDistance) then
        closestGrindSpotId = id
        closestGrindSpotDistance = dist
      end
    end

    if closestGrindSpotId ~= nil then --Should never be nil, since a valid area should have been selected. but just to check.
      SelectGrindAreaPositionTask._currentSpotId = closestGrindSpotId
      print("Starting at spot #" .. closestGrindSpotId)
    end

  end

  if SelectGrindAreaPositionTask._currentSpotId == 0 or SelectGrindAreaPositionTask._areas[SelectGrindAreaPositionTask._currentAreaId].spots[SelectGrindAreaPositionTask._currentSpotId] and Cache.playerPos:getDistance(VectorUtils.tableToVector3(SelectGrindAreaPositionTask._areas[SelectGrindAreaPositionTask._currentAreaId].spots[SelectGrindAreaPositionTask._currentSpotId])) < 400 then
    --Close to grind spot
    if SelectGrindAreaPositionTask._currentSpotId < table.length(SelectGrindAreaPositionTask._areas[SelectGrindAreaPositionTask._currentAreaId].spots) then
      SelectGrindAreaPositionTask._currentSpotId = SelectGrindAreaPositionTask._currentSpotId + 1
      for i = SelectGrindAreaPositionTask._currentSpotId, table.length(SelectGrindAreaPositionTask._areas[SelectGrindAreaPositionTask._currentAreaId].spots) do
        if Grinder.settings.grindSpot_min_mob_amount <= 0 then
          SelectGrindAreaPositionTask._currentSpotId = i
          break
        end
        local spot = SelectGrindAreaPositionTask._areas[SelectGrindAreaPositionTask._currentAreaId].spots[i]
        local spotVec = Vector3(spot.X, spot.Y, spot.Z)

        spot = nil

        if spotVec:getDistance(Cache.playerPos) < 2500 then

          local mobsInRange = TargetHelper.getMonstersInRangeOfLocation(spotVec, Grinder.settings.attack_mob_from_grindSpot_range)
          if #mobsInRange >= Grinder.settings.grindSpot_min_mob_amount then
            SelectGrindAreaPositionTask._currentSpotId = i
            mobsInRange = nil
            spotVec = nil
            break
          end


          mobsInRange = nil
        else
          spotVec = nil

          SelectGrindAreaPositionTask._currentSpotId = i
          break
        end

        spotVec = nil
      end
    else
      for k, v in pairs(SelectGrindAreaPositionTask._areas[SelectGrindAreaPositionTask._currentAreaId].spots) do
        SelectGrindAreaPositionTask._currentSpotId = k
        break
      end

    end
    Log.log("Switching to spot #" .. tostring(SelectGrindAreaPositionTask._currentSpotId))
    --Move to current spot
    Grinder.currentDest = SelectGrindAreaPositionTask._areas[SelectGrindAreaPositionTask._currentAreaId].spots[SelectGrindAreaPositionTask._currentSpotId]
    Grinder.currentDestIsNode = true


    selectedAreaId = nil

    return true
  else
    --Move to current spot
    Grinder.currentDest = SelectGrindAreaPositionTask._areas[SelectGrindAreaPositionTask._currentAreaId].spots[SelectGrindAreaPositionTask._currentSpotId]
    Grinder.currentDestIsNode = true

    selectedAreaId = nil

    return false
  end
end

function SelectGrindAreaPositionTask.selectAreaId()
  --Log.debugLog("selectAreaId")
  for areaId, areaData in pairs(SelectGrindAreaPositionTask._areas) do
    if table.length(areaData.spots) > 0 and
    Cache.playerLevel >= areaData.minLevel and
    Cache.playerLevel <= areaData.maxLevel
    then
      return areaId
    end
  end

  return nil
end
