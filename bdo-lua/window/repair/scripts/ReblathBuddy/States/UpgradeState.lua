local work = function(self)
  local settings = MagLib.Core.Settings.getSetting("ReblathBuddy")

  local stackItems = ReblathBuddy.getToEnhanceItems()
  local stoneKey = ReblathBuddy.stoneKey

  --Check if all of them are +15, if yes then setting it to downgrade state
  local allMax = true
  for k, v in pairs(stackItems) do
    local enhanceLevel = v.enhanceLevel
    if enhanceLevel < 15 then
      allMax = false
      break
    end
  end

  if allMax then
    for k, v in pairs(stackItems) do
      if v.dura > 20 then
        ReblathBuddy.mainStateManager.setState(DowngradeState) --Setting it to Downgrade State, which as of inital version should be one before. Doing it universially here in the offchance that that changes.
        return false --Returning false to not overwrite the state again (would go one forward of DowngradeState)
      end
    end
    --We cannot downgrade right now, we should go forward
    return true
  end

  --Check if there is a enhance item with >20 max dura
  local allLowDura = true
  for k, v in pairs(stackItems) do
    local maxDura = v.maxDura
    local enhanceLevel = v.enhanceLevel
    if enhanceLevel < 15 and maxDura > 20 then
      allLowDura = false
      break
    end
  end

  if allLowDura then
    return true
  end

  --Checking if enough stones
  local currentStoneAmount = MagLib.BDO.Inventory.getItemCount_Quick(stoneKey)
  if currentStoneAmount <= 0 then
    --No stones, go further (starting from state 1 again since we need to run to storage anyways, might as well go over repair)
    return true
  end

  local currentFailstackCount = MagLib.BDO.Enhance.getFailstackCount()
  --Check if we need to extract failstacks
  if currentFailstackCount >= settings.extractAt then

    --Checking if we have the right extraction books
    local bookKey = ReblathBuddy.getCurrentlyNeededExtractionBookKey()
    local currentBookAmount = MagLib.BDO.Inventory.getItemCount_Quick(bookKey)
    if currentBookAmount <= 0 then
      --No extraction books, go further
      return true
    end

    --Extract
    ReblathBuddy.logger.info("Extracting " .. currentFailstackCount .." failstacks! :)")
    MagLib.BDO.Enhance.extractFailstacks(bookKey)
    ReblathBuddy.FSExtractedCount = ReblathBuddy.FSExtractedCount + 1
    self.wait(250)
    return false
  end

  --All good now. We can enhance!

  --Initial logic to not waste failstacks too much when upgrading new items.
  --Preference function
  local findPrefItem = function(minLevel, maxLevel)
    local min = minLevel
    local max = maxLevel
    local bestItem = nil
    for _, itemData in pairs(stackItems) do
      local enhanceLevel = itemData.enhanceLevel
      local maxDura = itemData.maxDura
      if maxDura > 20 and enhanceLevel >= min and enhanceLevel <= max and (bestItem == nil or enhanceLevel > bestItem.enhanceLevel) then
        bestItem = itemData
      end
    end

    return bestItem
  end

  local toEnhanceItem = nil
  if currentFailstackCount == 0 then
    --Prefer less than +3s
    toEnhanceItem = findPrefItem(0, 3)
  elseif currentFailstackCount <= 5 then
    --Prefer less than +7 and more than +3
    toEnhanceItem = findPrefItem(4, 7)
  elseif currentFailstackCount <= 10 then
    --Prefer less than +12 and more than +7
    toEnhanceItem = findPrefItem(8, 12)
  end

  if toEnhanceItem == nil then
    --No preference done, enhance highest non +15 items
    toEnhanceItem = findPrefItem(0, 14)
  end

  if toEnhanceItem == nil then
    ReblathBuddy.logger.warning("This should not happen. No enhanceable item found, even though we checked them earlier. Continuing...")
    return true
  end

  MagLib.BDO.Inventory.openInventory()
  local toEnhanceSlot = toEnhanceItem.slot
  MagLib.BDO.Enhance.enhance(toEnhanceSlot, stoneKey)
  local waitTime = 1000 - ((settings.enhanceSpeed - 1) * 100)
  self.wait(waitTime)

  return false
end


UpgradeState = MagLib.Run.States.State("UpgradeState", work)
