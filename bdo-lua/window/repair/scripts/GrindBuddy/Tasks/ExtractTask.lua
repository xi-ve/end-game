ExtractTask = {}
ExtractTask.lastRun = 0

function ExtractTask.NeedToRun()
  if not Grinder.settings.extract_blackstones then
    return false
  end

  local invenMaxSize = Inventory.getMaxSize()

  if invenMaxSize == 0 then
    return false
  end

  --print("here")
  if invenMaxSize >= 3 then
    for i = 2, invenMaxSize - 1 do
      if Inventory.hasItemWrapper(i) then
        local itemGrade = Inventory.getItemGradeBySlot(i)
        if itemGrade <= 1 then --Only greens and whites
          --print("here2")
          local enchantmentLevel = Inventory.getItemEnchantment(i)
          if enchantmentLevel > 0 and enchantmentLevel <= Grinder.settings.do_not_extract_over_level and enchantmentLevel <= 15 then --Even when set over 15, we do not allow over 15 for safety reasons
            return true
          end
        end
      end
    end
  end

  return false
end

function ExtractTask.isExtractable(slot)
  local code = 
  [[
    local itemWrapper = getInventoryItem(]]..slot..[[)

  if itemWrapper ~= nil then
    local equipType = itemWrapper:getStaticStatus():getEquipType()
    if (equipType ~= 18 and equipType ~= 17 and equipType ~= 16 and equipType ~= 15) then
      return true
    end
  end

  return false
  ]]

  return Infinity.BDO.Lua.Execute(code)
end

function ExtractTask.work()
  if not Grinder.settings.extract_blackstones then
    return false
  end


  local invenMaxSize = Inventory.getMaxSize()

  if invenMaxSize == 0 then
    return false
  end

  if invenMaxSize >= 3 then
    for i = 2, invenMaxSize - 1 do
      if Inventory.hasItemWrapper(i) then
        local itemGrade = Inventory.getItemGradeBySlot(i)
        if itemGrade <= 1 then --Only greens and whites
          local enchantmentLevel = Inventory.getItemEnchantment(i)
          if enchantmentLevel > 0 and enchantmentLevel <= Grinder.settings.do_not_extract_over_level and enchantmentLevel <= 15 and ExtractTask.isExtractable(i) then --Even when set over 15, we do not allow over 15 for safety reasons
            local name, itemId, count = Inventory.getItemData(i)
            Log.log("Extracting blackstones from " .. name .. " +".. string.format("%.0f", enchantmentLevel) .. " in slot " .. i)
            Infinity.BDO.Lua.Execute("ToClient_ExtractBlackStone(0, "..i..")")
            Grinder.wait(250)


            name = nil
            itemId = nil
            count = nil
            itemGrade = nil

            return false
          end
        end

        itemGrade = nil
      end
    end
  end

  invenMaxSize = nil

  return true
end
