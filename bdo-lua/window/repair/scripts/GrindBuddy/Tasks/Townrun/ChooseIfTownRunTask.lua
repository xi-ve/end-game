ChooseIfTownRunTask = {}

function ChooseIfTownRunTask.work()
  --Log.debugLog("ChooseIfTownRunTask work")

  if not Grinder.currentProfile.npcs then
    return false
  end

  if Grinder.forceTownRun then
    Log.log("Starting downrun due to a magic force forcing me.")
    return true
  end

  if Grinder.settings.doRepairRuns and Grinder.currentProfile.npcs["Repair"] and #Grinder.currentProfile.npcs["Repair"] > 0 and Inventory.isItemBelowEndurance(10) then
    Log.log("Starting downrun due to an item being lower than 10 durability")
    return true
  end

  local hpPotsAmount = RestockTask.getPotionCount(1)
  local mpPotsAmount = RestockTask.getPotionCount(2)

  if Grinder.currentProfile.npcs["Potions"] and #Grinder.currentProfile.npcs["Potions"] > 0 then
    if Grinder.settings.usePotions and ((Grinder.settings.buy_hp_potion and hpPotsAmount < 10 and hpPotsAmount < Grinder.settings.buy_hp_potion_amount) or (Grinder.settings.buy_mp_potion and mpPotsAmount < 10 and mpPotsAmount < Grinder.settings.buy_mp_potion_amount)) then
      Log.log("Starting townrun due to low potion amount")
      return true
    end
  end


  local code = [[
    local inventorySize = getSelfPlayer():get():getInventorySlotCount(false)
    local allWeight = Int64toInt32(getSelfPlayer():get():getCurrentWeight_s64())
    local maxWeight = Int64toInt32(getSelfPlayer():get():getPossessableWeight_s64())
    return inventorySize, allWeight, maxWeight
    ]]

  local inventorySize, allWeight, maxWeight = Infinity.BDO.Lua.Execute(code)

  local weight_pct = allWeight / maxWeight

  NPCUtils.getSellItems()
  if Grinder.settings.selling and (Grinder.currentProfile.npcs["Potions"] and #Grinder.currentProfile.npcs["Potions"] > 0)
  or (Grinder.currentProfile.npcs["Repair"] and #Grinder.currentProfile.npcs["Repair"] > 0)
  then
    if #NPCUtils.itemsToSell > 0 and (Inventory.getFreeSlotCount() < 2) then
      Log.log("Starting downrun due to low inventory slots and some items to sell")
      return true
    end

    if weight_pct > 0.95 and #NPCUtils.itemsToSell > 0 then
      Log.log("Starting downrun due to 95% weight and some items to sell")
      return true
    end

  end

  if (Grinder.settings.doDeposit or Grinder.settings.doTakeOut) and ( Grinder.currentProfile.npcs["Storage"] and #Grinder.currentProfile.npcs["Storage"] > 0) then
    if Grinder.forceStorage then
      Log.log("Some magic tells me todo a townrun with a storage manager being involved...")
      return true
    end

    NPCUtils.getDepositItems()
    if NPCUtils.itemsToDeposit and #NPCUtils.itemsToDeposit > 0 and (Inventory.getFreeSlotCount() < 2) then
      Log.log("Starting downrun due to low inventory slots and some items to deposit")
      return true
    end

    if NPCUtils.itemsToDeposit and #NPCUtils.itemsToDeposit > 0 and (weight_pct > 0.95) then
      Log.log("Starting downrun due to having over 95% weight and having items to deposit")
      return true
    end

    NPCUtils.getTakeOutItems()
    if NPCUtils.itemsToTakeOut and #NPCUtils.itemsToTakeOut > 0 then
      Log.log("Starting downrun due to needing to take out an item from storage")
      --Go even if only one item as missing, as this could be an important item
      return true
    end

    local silverCount, silverSlot = Inventory.getItemDataByItemId(1)
    local moneyToDeposit = 0
    if silverSlot ~= -1 and silverCount > 0 then
      moneyToDeposit = silverCount - Grinder.settings.keep_silver_amount
    end
  end

  if Grinder.settings.doMarketplace and (Grinder.currentProfile.npcs["Marketplace"] and #Grinder.currentProfile.npcs["Marketplace"] > 0) then
    -- MarketplaceTask.getItemCountAutoSellHandles() > 0 first, so it is actually called and starts the script if needed.
    if MarketplaceTask.getItemCountAutoSellHandles() > 0 and (weight_pct > 0.95 or Inventory.getFreeSlotCount() < 2) then
      return true
    end

  end


  return false
end
