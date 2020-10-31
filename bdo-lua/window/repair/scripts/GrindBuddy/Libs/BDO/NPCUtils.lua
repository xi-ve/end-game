NPCUtils = {}
NPCUtils.shopList = {}
NPCUtils.shoplistNpcActorKey = nil
NPCUtils.shopListTotalSize = 0
NPCUtils.itemsToSell = {}
NPCUtils.itemsToSellCount = 0

NPCUtils.repairActorKey = nil
NPCUtils.repairActorIsTent = nil

NPCUtils.alchemyStoneSlot = Infinity.BDO.Lua.Execute("return CppEnums.EquipSlotNo.alchemyStone")
NPCUtils.rightHandSlot = Infinity.BDO.Lua.Execute("return CppEnums.EquipSlotNoClient.eEquipSlotNoRightHand")
NPCUtils.lastEqSlot = Infinity.BDO.Lua.Execute("return CppEnums.EquipSlotNoClient.eEquipSlotNoCount - 1")

NPCUtils.sellTempBlacklist = {}

function NPCUtils.repairEquipped(repairActor, repairActorIsTent)
  Log.debugLog("NPCUtils repairEquipped")
  repairActorIsTent = repairActorIsTent or false

  local repairActorKey = nil
  if repairActorIsTent then
    repairActorKey = Servant.getTent():getActorKey()
  else
    repairActorKey = repairActor:getActorKey()
  end


  local inventoryMoney = Inventory.getInventoryMoney()

  if Grinder.settings.use_Inventory_Money and inventoryMoney < 100000 then
    Log.log("Trying to move Silver into intenvory via maid!")

    if Maids.hasStorageMaid() then
      if Maids.getStorageMaidCooldown() <= 1 then
        local whMoneyItemCount, whMoneyItemSlot = Warehouse.getItemDataByItemId(1, Warehouse.getCurrentWaypointKeyForMaid())

        if whMoneyItemCount <= 0 then
          Log.log("No more silver availablein Warehouse!")
          return
        end

        local countToTransfer = 500000 - Inventory.getItemCountByItemId(1, 0)

        if whMoneyItemCount < countToTransfer then
          countToTransfer = whMoneyItemCount
        end

        Warehouse.moveToInventoryByMaid(whMoneyItemSlot, countToTransfer)
        Log.log("Transfered " .. countToTransfer .. " to Inventory via Maid!")

        return false
      else
        Log.log("No Free Storage Maid available!")
      end
    else
      Log.log("No Storage Maid available!")
    end
  end

  if NPCUtils.rightHandSlot < NPCUtils.lastEqSlot then

    for i = NPCUtils.rightHandSlot, NPCUtils.lastEqSlot do
      if Inventory.canRepairEquippedItem(i) then
        if i ~= NPCUtils.alchemyStoneSlot then --Cannot repair alchemy stone
          Log.log("Repairing Equipped Item on slot " .. i)
          local moneyNo = Infinity.BDO.Warehouse.getCurrentMoneyNoByWaypointKey(Warehouse.getCurrentWaypointKey())
          local moneyWhereType = 2
          if Grinder.settings.use_Inventory_Money then
            moneyNo = Player.me():getInventoryMoneyNo()
            moneyWhereType = 0
          end
          RepairItemReq():construct(0, i, moneyWhereType, 1, Player.me():getActorKey(), repairActorKey, moneyNo).Packet:send()

          Grinder.wait(333)
          return false
        end
      end
    end
  end

  repairActorKey = nil
  inventoryMoney = nil

  return true

end

function NPCUtils.repairAll(repairActor, repairActorIsTent)
  Log.debugLog("NPCUtils repairAll")

  repairActorIsTent = repairActorIsTent or false

  local repairActorKey = nil
  if repairActorIsTent then
    repairActorKey = Servant.getTent():getActorKey()
  else
    repairActorKey = repairActor:getActorKey()
  end

  local moneyNo = Infinity.BDO.Warehouse.getCurrentMoneyNoByWaypointKey(Warehouse.getCurrentWaypointKey())
  local moneyWhereType = 2
  if Grinder.settings.use_Inventory_Money then
    moneyNo = Player.me():getInventoryMoneyNo()
    moneyWhereType = 0
  end

  local repairableItems = Inventory.getRepairableItemSlots()
  if #repairableItems ~= 0 then
    for k, v in pairs(repairableItems) do
      Log.log("Repairing Inventory Slot " .. v)
      RepairItemReq():construct(0, v, moneyWhereType, 0, Player.me():getActorKey(), repairActorKey, moneyNo).Packet:send()
      Grinder.wait(100)
    end
  end

  if NPCUtils.rightHandSlot < NPCUtils.lastEqSlot then
    for i = NPCUtils.rightHandSlot, NPCUtils.lastEqSlot do
      if Inventory.canRepairEquippedItem(i) then
        if i ~= NPCUtils.alchemyStoneSlot then --Cannot repair alchemy stone
          Log.log("Repairing Equipped Item on slot " .. i)
          RepairItemReq():construct(0, i, moneyWhereType, 1, Player.me():getActorKey(), repairActorKey, moneyNo).Packet:send()

          repairActorKey = nil
          moneyNo = nil
          moneyWhereType = nil
          repairableItems = nil

          Grinder.wait(200)
          return false
        end
      end
    end
  end

  repairActorKey = nil
  moneyNo = nil
  moneyWhereType = nil
  repairableItems = nil

  return true
end



function NPCUtils.getClosestNPCFromKeylist(t)
  return ActorUtils.getClosestActorFromActorList(t)
end

NPCUtils.lastSoldSlot = -1
NPCUtils.lastSoldSlotCounter = 1

NPCUtils.lastItemSold = 0



function NPCUtils.sellAllItemsFromSettingsList(npcActor)

  if Grinder.settings.use_legacy_selling then
    return NPCUtils.sellAllItemsFromSettingsList_Legacy(npcActor)
  end
  NPCUtils.getSellItems(true)

  if (#NPCUtils.itemsToSell == 0) then
    return true
  end

  Infinity.BDO.getShopManager():requestShopData(npcActor:getActorKey())
  local moneyNo = Infinity.BDO.Warehouse.getCurrentMoneyNoByWaypointKey(Warehouse.getCurrentWaypointKey())
  local moneyWhereType = 2
  if Grinder.settings.use_Inventory_Money then
    moneyNo = Player.me():getInventoryMoneyNo()
    moneyWhereType = 0
  end

  for k, v in ipairs(NPCUtils.itemsToSell) do
    local canSell = true;
    for blacklistIndex, blacklistTable in pairs(NPCUtils.sellTempBlacklist) do
      if blacklistTable.itemId == v.itemId and blacklistTable.slot == v.slot then
        if blacklistTable.expireTime > Cache.time then
          canSell = false
        else
          table.remove(NPCUtils.sellTempBlacklist, blacklistIndex)
        end
      end
    end

    if canSell then
      if v.slot == NPCUtils.lastSoldSlot then
        if NPCUtils.lastSoldSlotCounter > 20 then --is 21 basically
          Log.log("Trying to sell same slot too often. Automatically adding item to a temporal blacklist to prevent stuck!")
          local insertTable = {
            itemId = v.itemId,
            slot = v.slot,
            expireTime = Cache.time + 60000 --1min
          }
          table.insert(NPCUtils.sellTempBlacklist, insertTable)

          moneyNo = nil
          moneyWhereType = nil
          canSell = nil
          insertTable = nil

          return false
        end
        NPCUtils.lastSoldSlotCounter = NPCUtils.lastSoldSlotCounter + 1
      else
        NPCUtils.lastSoldSlot = v.slot
        NPCUtils.lastSoldSlotCounter = 1
      end
      local shopSlotId = Infinity.BDO.getShopManager():getShopSlotId(v.itemId)
      if shopSlotId ~= 0 then
        Log.log("Selling item with key " .. Utils.getItemKeyRaw(v.itemId, 0) .. " " .. tostring(v.count) .. "x in slot " .. tostring(v.slot))
        SellItemInShop():construct(npcActor:getActorKey(), Infinity.BDO.getLocalPlayer():getActorKey(), v.itemId, v.slot, v.count, moneyNo, moneyWhereType, 0, shopSlotId).Packet:send()
        Grinder.wait(250)

        moneyNo = nil
        moneyWhereType = nil
        canSell = nil
        shopSlotId = nil

        return false
      else
        Log.log("Could not find ShopSlotId for ItemKey " .. v.itemId)
        local insertTable = {
          itemId = v.itemId,
          slot = v.slot,
          expireTime = Cache.time + 60000 --1min
        }
        table.insert(NPCUtils.sellTempBlacklist, insertTable)

        moneyNo = nil
        moneyWhereType = nil
        canSell = nil
        shopSlotId = nil

        return false
      end
    end

    canSell = nil
  end

  moneyNo = nil
  moneyWhereType = nil

  print("ERROR: NPCUtils.sell function => Should not be here... returning false")
  return false
end

function NPCUtils.sellAllItemsFromSettingsList_Legacy(npcActor)
  Log.debugLog("NPCUtils sellAllItemsFromSettingsList")
  --Needs to already have npc open
  if not NPCUtils.openNPCDialog(npcActor) then
    return false
  end

  if NPCUtils.lastItemSold + 200 > Cache.time then
    return false
  end

  NPCUtils.getSellItems(true)

  for k, v in ipairs(NPCUtils.itemsToSell) do
    if v.slot == NPCUtils.lastSoldSlot then
      if NPCUtils.lastSoldSlotCounter > 30 then --is 51 basically
        Log.log("Trying to sell same slot too often. Automatically adding item to 'Do not sell' list to prevent stuck!")
        local insertTable = {
          itemId = v.itemId,
          name = v.name
        }
        table.insert(Grinder.settings.doNotSell_items, insertTable)
        NPCUtils.getSellItems(true)

        insertTable = nil
        return false
      end
      NPCUtils.lastSoldSlotCounter = NPCUtils.lastSoldSlotCounter + 1
    else
      NPCUtils.lastSoldSlot = v.slot
      NPCUtils.lastSoldSlotCounter = 1
    end
    Log.log("Selling item with key " .. Utils.getItemKeyRaw(v.itemId, 0) .. " " .. tostring(v.count) .. "x in slot " .. tostring(v.slot))
    Infinity.BDO.Lua.Execute([[getSelfPlayer():get():requestSellItem(]] .. v.slot .. [[, ]] .. v.count .. [[, CppEnums.ItemWhereType.eInventory, CppEnums.ItemWhereType.eWarehouse, false)]])
    Grinder.wait(100)
    NPCUtils.lastItemSold = Cache.time
    return false
  end
  NPCUtils.closeNpcDialog()
  return true

end

NPCUtils.lastTimeDialogClosed = 0

function NPCUtils.closeNpcDialog_Userfriendly()

end

function NPCUtils.closeNpcDialog()
  Log.debugLog("NPCUtils closeNPCDialog")
  if NPCUtils.lastTimeDialogClosed + 18 < Cache.time then
    local code = [[
          FromClient_CancelByAttacked()
          close_WindowPanelList()
          FromClient_hideDialog(false)
        ]]
    --Log.log("here")
    Infinity.BDO.Lua.Execute(code)

    code = nil
    NPCUtils.lastTimeDialogClosed = Cache.time
    return false
  else
    return true
  end
end


NPCUtils.triedOpenNpcTime = 0
NPCUtils.successfullyOpenedNpcTime = 0

NPCUtils.lastOpenActorKey = 0
NPCUtils.lastOpenActorTime = 0
NPCUtils.lastOpenActorPos = Vector3(0, 0, 0)

NPCUtils.lastShopActorKey = nil
NPCUtils.lastShopActorUpdate = 0

function NPCUtils.resettingOpenNPCVars()
  Log.debugLog("NPCUtils resettingOpenNPCVars")
  NPCUtils.triedOpenNpcTime = 0

  NPCUtils.lastOpenActorKey = 0
  NPCUtils.lastOpenActorTime = 0
  NPCUtils.lastOpenActorPos = Vector3(0, 0, 0)

  NPCUtils.lastShopActorKey = nil
  NPCUtils.lastShopActorUpdate = 0
end

NPCUtils.lookChangedToPos = Vector3(0, 0, 0)
NPCUtils.lookChangedToTime = 0

function NPCUtils.lookAt(pos)
  Log.debugLog("NPCUtils lookAt")
  if NPCUtils.lookChangedToPos.X ~= pos.X and NPCUtils.lookChangedToPos.Y ~= pos.Y and NPCUtils.lookChangedToPos.Z ~= pos.Z then
    local PI = 3.14159265358979323846
    local rotFaceTarget = pos:getRotationToFace(Cache.playerPos)
    local yawFaceTarget = rotFaceTarget - (2 * PI)

    if Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():getRotation() ~= rotFaceTarget then
      Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setRotation(rotFaceTarget)
    end

    if Infinity.BDO.getCameraManager():getYaw() ~= yawFaceTarget then
      Infinity.BDO.getCameraManager():setYaw(yawFaceTarget)
    end

    if not Infinity.BDO.getUIManager():getIsCursorActive() then
      Infinity.BDO.getUIManager():setIsCursorActive(false)
    end

    NPCUtils.lookChangedToPos = pos

    PI = nil
    rotFaceTarget = nil
    yawFaceTarget = nil

    return false

  elseif NPCUtils.lookChangedToTime + 50 < Cache.time then
    return true
  else
    return false
  end

end


NPCUtils.shopListOpenedActor = nil
NPCUtils.shopListOpenedActorTime = 0

function NPCUtils.openNPCDialog(npcActor)
  Log.debugLog("NPCUtils openNPCDialog")
  Player.stopMoving() --Should not be moving
  local talkerKey = Infinity.BDO.Lua.Execute("return dialog_getTalker():getActorKey()")
  if nil ~= talkerKey then --talking to an npc
    Log.debugLog("talkerKey = " .. talkerKey .. " | npcKey = " .. npcActor:getActorKey())
    if talkerKey == npcActor:getActorKey() then --talking to the right npc
      Log.debugLog("NPCUtils.shopListOpenedActor: " .. (NPCUtils.shopListOpenedActor or "nil") .. " |  NPCUtils.shopListOpenedActorTime: " .. NPCUtils.shopListOpenedActorTime .. " | Cache.time: " .. Cache.time)
      if talkerKey ~= NPCUtils.shopListOpenedActor and NPCUtils.shopListOpenedActorTime + 896 < Cache.time then
        Infinity.BDO.Lua.Execute("npcShop_requestList(CppEnums.ContentsType.Contents_Shop, true)")
        NPCUtils.shopListOpenedActor = talkerKey
        NPCUtils.shopListOpenedActorTime = Cache.time
        talkerKey = nil
        return false
      end
      if NPCUtils.shopListOpenedActorTime + 250 < Cache.time and Cache.time < NPCUtils.shopListOpenedActorTime + 1000 then
        --Log.log("this")
        NPCUtils.closeNpcDialog()
        talkerKey = nil
        return true
      elseif NPCUtils.shopListOpenedActorTime + 250 > Cache.time then
        talkerKey = nil
        return false
      else
        talkerKey = nil
        return true
      end
    end
  end
  NPCUtils.closeNpcDialog()
  Infinity.BDO.getDialogManager():setTalker(npcActor)

  talkerKey = nil

  return false
end


--[[NPCUtils.lastActionTime = 0
NPCUtils.lastOpenActorPos = Vector3(0, 0, 0)
NPCUtils.lastOpenActorTime = 0

NPCUtils.openNpcWaitStartTime = 0
NPCUtils.openNpcWaited = false
NPCUtils.waitedForNpcKey = 0

NPCUtils.currentActorRequestedShoplist = false

function NPCUtils.openNPCDialog(npcActor)
    Player.stopMoving() --Should not be moving

    -- if at npc, wait 1 seconds before doing anything
    if not NPCUtils.openNpcWaited and NPCUtils.openNpcWaitStartTime + 1000 > Cache.time then
        return false
    else

    end
    if not NPCUtils.openNpcWaited and NPCUtils.waitedForNpcKey ~= npcActor:getActorKey() then
        NPCUtils.openNpcWaitStartTime = Cache.time
    end

    if NPCUtils.lastOpenActorPos.X == npcActor:getPosition().X and NPCUtils.lastOpenActorPos.Y == npcActor:getPosition().Y and NPCUtils.lastOpenActorKey and NPCUtils.lastOpenActorKey == npcActor:getActorKey() and NPCUtils.lastOpenActorTime + 10000 > Cache.time then
        return true
    end

    if NPCUtils.lastActionTime + 500 < Cache.time then

        NPCUtils.lastActionTime = Cache.time
        local talkerKey = Infinity.BDO.Lua.Execute("return dialog_getTalker():getActorKey()")

        if nil ~= talkerKey then --talking to somebody
            if talkerKey == npcActor:getActorKey() then --right NPC
                if not NPCUtils.currentActorRequestedShoplist then
                    Infinity.BDO.Lua.Execute("npcShop_requestList(CppEnums.ContentsType.Contents_Shop, true)")
                    NPCUtils.currentActorRequestedShoplist = true
                    return false
                end

                NPCUtils.lastOpenActorKey = npcActor:getActorKey()
                NPCUtils.lastOpenActorTime = Cache.time
                NPCUtils.lastOpenActorPos = npcActor:getPosition()
                NPCUtils.currentActorRequestedShoplist = false
                NPCUtils.closeNpcDialog()
                return true
            else --wrong NPC
                Log.log("Opened wrong NPC")
                NPCUtils.closeNpcDialog()
                return false
            end

            ----------------------------------------------------------
        else -- not talking to an npc, opening dialog

            NPCUtils.lookAt(npcActor:getPosition())
            Infinity.BDO.Lua.Execute("Interaction_ButtonPushed(interaction_getInteractable():getSettedFirstInteractionType())")
            return false
        end
    end
    return false
end]]

--[[function NPCUtils.openNPCDialog(npcActor)

    if NPCUtils.successfullyOpenedNpcTime + 1000 > Cache.time then
        return false
    end


    if NPCUtils.lastOpenActorPos.X == npcActor:getPosition().X and NPCUtils.lastOpenActorPos.Y == npcActor:getPosition().Y and NPCUtils.lastOpenActorKey and NPCUtils.lastOpenActorKey == npcActor:getActorKey() and NPCUtils.lastOpenActorTime + 10000 > Cache.time then
        return true
    end

    if NPCUtils.triedOpenNpcTime + 500 < Cache.time then -- Only try 9 times a second
        NPCUtils.triedOpenNpcTime = Cache.time
        local talkerKey = Infinity.BDO.Lua.Execute("return dialog_getTalker():getActorKey()")

        NPCUtils.successfullyOpenedNpcTime = Cache.time

        --Log.log("Current talkerKey: " .. talkerKey)

        if nil ~= talkerKey then
            if talkerKey == npcActor:getActorKey() then

                if NPCUtils.lastShopActorKey ~= npcActor:getActorKey() and NPCUtils.lastShopActorUpdate + 2500 < Cache.time then
                    Infinity.BDO.Lua.Execute("npcShop_requestList(CppEnums.ContentsType.Contents_Shop, true)")
                    NPCUtils.lastShopActorKey = npcActor:getActorKey()
                    NPCUtils.lastShopActorUpdate = Cache.time
                    return false
                end

                if NPCUtils.lastShopActorUpdate + 500 < Cache.time then
                    --Log.log ("Openend NPC Dialog!")
                    NPCUtils.lastOpenActorKey = npcActor:getActorKey()
                    NPCUtils.lastOpenActorTime = Cache.time
                    NPCUtils.lastOpenActorPos = npcActor:getPosition()
                    NPCUtils.closeNpcDialog()


                    return true
                else
                    return false
                end
            else
                Log.log("Opened wrong NPC")
                NPCUtils.successfullyOpenedNpcTime = Cache.time --Doing this to give it some time todo stuff
                NPCUtils.resettingOpenNPCVars()
                NPCUtils.closeNpcDialog()
                return false
            end
        end
        local PI = 3.14159265358979323846
        local rotFaceTarget = npcActor:getPosition():getRotationToFace(Cache.playerPos)
        local yawFaceTarget = rotFaceTarget - (2 * PI)

        if Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():getRotation() ~= rotFaceTarget then
            Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setRotation(rotFaceTarget)
        end

        if Infinity.BDO.getCameraManager():getYaw() ~= yawFaceTarget then
            Infinity.BDO.getCameraManager():setYaw(yawFaceTarget)
        end

        if not Infinity.BDO.getUIManager():getIsCursorActive() then
            Infinity.BDO.getUIManager():setIsCursorActive(false)
        end

        if not Infinity.BDO.Input.isEmptyQueue() then
            Infinity.BDO.Input.clearQueue()
        end

        Infinity.BDO.Lua.Execute("Interaction_ButtonPushed(interaction_getInteractable():getSettedFirstInteractionType())")
    end
    return false
end]]

function NPCUtils.onGetTradeShopItems(packet)
  --[[
    packet:parse()

    if packet.Parsed.NpcActorKey == NPCUtils.shoplistNpcActorKey then
        return
    end

    if table.length(NPCUtils.shopList) == packet.Parsed.TotalSize then
        print("ShopList alrdy populated!")
        return
    end

    NPCUtils.shopListTotalSize = packet.Parsed.TotalSize

    for k, v in pairs(packet.Parsed.Items) do
        NPCUtils.shopList[v.ItemEnchantKeyRaw] = v.ShopSlotId

        --print("Added ShopItem to ShopList! (" .. table.length(NPCUtils.shopList) .. ")")
    end
    NPCUtils.shoplistNpcActorKey = packet.Parsed.NpcActorKey
    ]]
end

NPCUtils.lastUpdatedTakeOutItems = 0
NPCUtils.itemsToTakeOut = {}
NPCUtils.itemsToTakeOutCount = {}

function NPCUtils.getTakeOutItems(force)
  Log.debugLog("NPCUtils getTakeOutItems")
  if force == nil then
    force = false
  end
  if force == false and NPCUtils.lastUpdatedTakeOutItems + 1000 > Cache.time then
    return
  end

  NPCUtils.lastUpdatedTakeOutItems = Cache.time

  local invenMaxSize = Inventory.getMaxSize()

  local tItems = {}
  local tCount = 0

  for k, v in ipairs(Grinder.settings.takeFromStorage_items) do
    local itemCount, itemSlot = Inventory.getItemDataByItemId(v.itemId)
    if (itemSlot == -1) or (not itemSlot) or (not itemCount) or (itemCount == 0) and( itemCount < v.amount and not table.find(Grinder.notInWarehouseIds, v.itemId)) then
      table.insert(tItems, {name = v.name, slot = itemSlot, itemId = v.itemId, count = itemCount})
      tCount = tCount + 1
    end

    itemCount = nil
    itemSlot = nil
  end


  NPCUtils.itemsToTakeOut = tItems
  NPCUtils.itemsToTakeOutCount = tCount

  invenMaxSize = nil
  tItems = nil
  tCount = nil


end


NPCUtils.lastUpdatedDepositItems = 0
NPCUtils.itemsToDeposit = {}
NPCUtils.itemsToDepositCount = {}

function NPCUtils.getDepositItems(force)
  Log.debugLog("NPCUtils getDepositItems")
  if force == nil then
    force = false
  end
  if force == false and NPCUtils.lastUpdatedDepositItems + 1000 > Cache.time then
    return
  end

  NPCUtils.lastUpdatedDepositItems = Cache.time

  local invenMaxSize = Inventory.getMaxSize()

  local tItems = {}
  local tCount = 0

  if invenMaxSize >= 3 then
    for i = 2, invenMaxSize - 1 do
      if Inventory.hasItemWrapper(i) then

        local name, itemId, count = Inventory.getItemData(i)

        if name ~= nil and itemId ~= nil and NPCUtils.shouldDeposit(itemId, i, name) then
          table.insert(tItems, {name = name, slot = i, itemId = itemId, count = count})
          tCount = tCount + 1
        end

        name = nil
        itemId = nil
        count = nil
      end
    end
  end


  NPCUtils.itemsToDeposit = tItems
  NPCUtils.itemsToDepositCount = tCount


  invenMaxSize = nil
  tItems = nil
  tCount = nil
end

function NPCUtils.shouldDeposit(itemId, slot, name)
  Log.debugLog("NPCUtils shouldDeposit")
  for k, v in ipairs(Grinder.settings.deposit_items) do
    if v.itemId == itemId then
      return true
    end
  end

  return false
end


NPCUtils.lastUpdatedSellItems = 0

function NPCUtils.getSellItems(force)
  Log.debugLog("NPCUtils getSellItems")
  if force == nil then
    force = false
  end
  if force == false and NPCUtils.lastUpdatedSellItems + 1000 > Cache.time then
    return
  end

  NPCUtils.lastUpdatedSellItems = Cache.time

  local invenMaxSize = Inventory.getMaxSize()

  local tItems = {}
  local tCount = 0

  if invenMaxSize >= 3 then
    for i = 2, invenMaxSize - 1 do
      if Inventory.hasItemWrapper(i) then

        local name, itemId, count = Inventory.getItemData(i)

        if name ~= nil and itemId ~= nil and NPCUtils.shouldSell(itemId, i, name) then
          table.insert(tItems, {name = name, slot = i, itemId = itemId, count = count})
          tCount = tCount + 1
        end

        name = nil
        itemId = nil
        count = nil
      end
    end
  end


  NPCUtils.itemsToSell = tItems
  NPCUtils.itemsToSellCount = tCount

  invenMaxSize = nil
  tItems = nil
  tCount = nil
end

function NPCUtils.isTradeItem(slot)
  local code = 
  [[
  local itemWrapper = getInventoryItem(]]..slot..[[)
  local itemSSW = itemWrapper:getStaticStatus()
  local isTradeItem = itemSSW:isTradeAble()
  return isTradeItem
  ]]

  return Infinity.BDO.Lua.Execute(code)

end

function NPCUtils.shouldSell(itemId, slot, name)

  Log.debugLog("NPCUtils shouldSell")

  for blacklistIndex, blacklistTable in pairs(NPCUtils.sellTempBlacklist) do
    if blacklistTable.itemId == itemId and blacklistTable.slot == slot then
      if blacklistTable.expireTime > Cache.time then
        return false
      else
        table.remove(NPCUtils.sellTempBlacklist, blacklistIndex)
      end
    end
  end

  if NPCUtils.isTradeItem(slot) then
    return false
  end

  --Return false if in doNotSell_items
  for k, v in ipairs(Grinder.settings.doNotSell_items) do
    if v.itemId == itemId then
      return false
    end
  end

  --return true if in "Always sell items"
  for k, v in ipairs(Grinder.settings.sell_items) do
    if v.itemId == itemId then
      return true
    end
  end


  if name and (string.match(name, "Feed") or string.match(name, "Pet") or string.match(name, "Purified") or string.match(name, "Tea") or string.match(name, "Meal") or string.match(name, "Beer") or string.match(name, "Event") or string.match(name, "Memory") or string.match(name, "Potion"))then
    return false
  end

  if table.find(Grinder.potionData.hp, itemId) then
    return false
  elseif table.find(Grinder.potionData.mp, itemId) then
    return false
  end

  if Inventory.getItemEnchantment(slot) > 0 then
    return false
  end

  local itemGrade = Inventory.getItemGradeBySlot(slot)

  if itemGrade == 0 and Grinder.settings.sell_white_items == true then
    itemGrade = nil
    return true
  end

  if itemGrade == 1 and Grinder.settings.sell_green_items == true then
    itemGrade = nil
    return true
  end

  itemGrade = nil

  return false
end
