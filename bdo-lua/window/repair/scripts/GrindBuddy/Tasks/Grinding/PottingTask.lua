PottingTask = {}

PottingTask.hpPotionSlot = nil
PottingTask.mpPotionSlot = nil

PottingTask.potionSlotUpdateTime = 0
PottingTask.lastWorkedTime = 0

function PottingTask.work()
  if not Grinder.settings.usePotions then 
    return
  end

  --Log.debugLog("PottinTask work")
  if PottingTask.lastWorkedTime + 105 < Cache.time then
    PottingTask.lastWorkedTime = Cache.time
    if PottingTask.potionSlotUpdateTime + 2556 < Cache.time then
      PottingTask.updatePotionSlots()
    end

    if Player.getHpPercent() < Grinder.settings.useHpPotAt then
      --Log.log("HP Percent: " .. Player.getHpPercent())
      PottingTask.usePotion(1)
    elseif Player.getMpPercent() < Grinder.settings.useMpPotAt then
      --Log.log("MP Percent: " .. Player.getMpPercent())
      PottingTask.usePotion(2)
    end
  end
  return
end

function PottingTask.updatePotionSlots()
  --Log.debugLog("PottinTask updatePotionSlots")

  PottingTask.hpPotionSlot = nil
  for _, v in ipairs(Grinder.potionData.hp) do
    local count, slot = Inventory.getItemDataByItemId(v)
    if count and count > 0 then
      PottingTask.hpPotionSlot = slot
      --return ??? why?
    end

    count = nil
    slot = nil
  end

  PottingTask.mpPotionSlot = nil
  for _, v in ipairs(Grinder.potionData.mp) do
    local count, slot = Inventory.getItemDataByItemId(v)
    if count and count > 0 then
      PottingTask.mpPotionSlot = slot
      --return ??? why?
    end

    count = nil
    slot = nil
  end

  PottingTask.potionSlotUpdateTime = Cache.time

end


function PottingTask.usePotion(type)
  Log.debugLog("PottingTask usePotion")
  local potSlot = nil

  if (type == 1) then
    potSlot = PottingTask.hpPotionSlot
  elseif (type == 2) then
    potSlot = PottingTask.mpPotionSlot
  end

  if potSlot ~= nil then
    Inventory.useItem(potSlot)
  end

  potSlot = nil
end
