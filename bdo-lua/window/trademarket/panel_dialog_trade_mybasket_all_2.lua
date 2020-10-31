function PaGlobalFunc_TradeMyBasket_All_Open()
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  PaGlobal_TradeMyBasket_All:prepareOpen()
end
function HandleEventLUp_TradeMyBasket_All_Close()
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  PaGlobal_TradeMyBasket_All:prepareClose()
end
function FromClient_TradeMyBasket_All_OnScreenResize()
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  PaGlobal_TradeMyBasket_All:onScreenResize()
end
function FromClient_TradeMyBasket_All_List2UpdateMyBasket(content, key)
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  PaGlobal_TradeMyBasket_All:updateMyBasketData(content, key)
end
function FromClient_TradeMyBasket_All_List2UpdateMyItem(content, key)
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  PaGlobal_TradeMyBasket_All:updateMyItemData(content, key)
end
function HandleEventLUp_TradeMyBasket_All_ClearItem(slotIdx)
  if nil == slotIdx or nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  if nil == PaGlobal_TradeMyBasket_All._currentCartItemTable[slotIdx] then
    return
  end
  PaGlobal_TradeMyBasket_All._currentCartItemTable[slotIdx] = nil
  local tempTable = {}
  local tempSlotno = 0
  for i = 1, PaGlobal_TradeMyBasket_All._currentSlotCount do
    if nil ~= PaGlobal_TradeMyBasket_All._currentCartItemTable[i] then
      tempSlotno = tempSlotno + 1
      tempTable[tempSlotno] = PaGlobal_TradeMyBasket_All._currentCartItemTable[i]
    end
  end
  PaGlobal_TradeMyBasket_All._currentCartItemTable = {}
  PaGlobal_TradeMyBasket_All._currentCartItemTable = tempTable
  PaGlobal_TradeMyBasket_All._currentSlotCount = tempSlotno
  PaGlobal_TradeMyBasket_All._ui._list2_MyBasket:getElementManager():clearKey()
  for ii = 1, tempSlotno do
    PaGlobal_TradeMyBasket_All._ui._list2_MyBasket:getElementManager():pushKey(toInt64(0, ii))
  end
  PaGlobal_TradeMyBasket_All:myMoneyUpdate()
  if 0 == PaGlobal_TradeMyBasket_All._currentSlotCount then
    PaGlobal_TradeMyBasket_All:dataClear()
  end
  PaGlobal_TradeMyBasket_All:update()
  PaGlobal_TradeMyBasket_All:addCartInfo()
  PaGlobal_TradeMarketItemList_All:update()
end
function HandleEventLUp_TradeMyBasket_All_ClearAllItem()
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  PaGlobal_TradeMyBasket_All:dataClear()
  PaGlobal_TradeMyBasket_All:update()
  PaGlobal_TradeMyBasket_All:addCartInfo()
  PaGlobal_TradeMarketItemList_All:update()
end
function HandleEventLUp_TradeMyBasket_All_BuyAll()
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  if true == Panel_NumberPad_IsPopUp() then
    Panel_NumberPad_Close()
  end
  if 0 >= PaGlobal_TradeMyBasket_All._currentSlotCount then
    return
  end
  PaGlobal_TradeMyBasket_All:checkVehicle()
  if true == PaGlobal_TradeMyBasket_All._ui._rdo_LandVehicle:IsChecked() or true == PaGlobal_TradeMyBasket_All._ui._rdo_SeaVehicle:IsChecked() then
    PaGlobalFunc_TradeMyBasket_All_ToMyVehicle()
  else
    PaGlobalFunc_TradeMyBasket_All_ToMyInventory()
  end
end
function PaGlobalFunc_TradeMyBasket_All_ToMyInventory()
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "Lua_TradeMarket_BuyMsg_UseInvenTitle")
  local contentString = PAGetString(Defines.StringSheet_GAME, "Lua_TradeMarket_BuyMsg_UseInvenContent")
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = PaGlobalFunc_TradeMyBasket_All_ConfirmToMyInventory,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobalFunc_TradeMyBasket_All_ConfirmToMyInventory()
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  PaGlobalFunc_TradeMyBasket_All_Send_DoBuy(0, 0)
end
function PaGlobalFunc_TradeMyBasket_All_ToMyVehicle()
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  if PaGlobal_TradeMyBasket_All._ENUM_NO_VEHICLE == PaGlobal_TradeMyBasket_All._vehicleStatus then
    return
  end
  local myLandVehicle = getTemporaryInformationWrapper()
  local myVehicleActorKey
  local btn_Land = PaGlobal_TradeMyBasket_All._ui._rdo_LandVehicle
  local btn_Sea = PaGlobal_TradeMyBasket_All._ui._rdo_SeaVehicle
  local btn_Inven = PaGlobal_TradeMyBasket_All._ui._rdo_Inven
  if PaGlobal_TradeMyBasket_All._ENUM_ALL_VEHICLE == PaGlobal_TradeMyBasket_All._vehicleStatus then
    if true == btn_Land:IsChecked() then
      myVehicleActorKey = myLandVehicle:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle):getActorKeyRaw()
    elseif true == btn_Sea:IsChecked() then
      myVehicleActorKey = myLandVehicle:getUnsealVehicle(CppEnums.ServantType.Type_Ship):getActorKeyRaw()
    end
  elseif PaGlobal_TradeMyBasket_All._ENUM_LAND_VEHICLE == PaGlobal_TradeMyBasket_All._vehicleStatus then
    myVehicleActorKey = myLandVehicle:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle):getActorKeyRaw()
  elseif PaGlobal_TradeMyBasket_All._ENUM_SEA_VEHICLE == PaGlobal_TradeMyBasket_All._vehicleStatus then
    myVehicleActorKey = myLandVehicle:getUnsealVehicle(CppEnums.ServantType.Type_Ship):getActorKeyRaw()
  else
    return
  end
  if nil == myVehicleActorKey then
    return
  end
  local servantWrapper = getVehicleActor(myVehicleActorKey)
  local servantActor = servantWrapper:get()
  local max_weight = Int64toInt32(servantActor:getPossessableWeight_s64() / Defines.s64_const.s64_10000)
  local total_weight = Int64toInt32(servantActor:getCurrentWeight_s64() / Defines.s64_const.s64_10000)
  if max_weight - total_weight < Int64toInt32(PaGlobal_TradeMyBasket_All._totalPrice) / 10000 then
    local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_VEHICLE_MSG_TITLE")
    local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_VEHICLE_MSG_CONTENT")
    local messageboxData = {
      title = titleString,
      content = contentString,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    return
  end
  PaGlobalFunc_TradeMyBasket_All_Send_DoBuy(0, 4)
end
function PaGlobalFunc_TradeMyBasket_All_Send_DoBuy(fromWhere, toWhere)
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  local servantType = 0
  local myMoney64 = getSelfPlayer():get():getInventory():getMoney_s64()
  if nil == PaGlobal_TradeMyBasket_All._totalPrice or 0 >= PaGlobal_TradeMyBasket_All._totalPrice then
    return
  end
  if myMoney64 < toInt64(0, PaGlobal_TradeMyBasket_All._totalPrice) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "Lua_TradeMarket_Not_Enough_Money"))
    return
  end
  if (true == ToClient_IsContentsGroupOpen("576") and ToClient_IsContentsGroupOpen("504") or true == PaGlobal_TradeMyBasket_All._isConsole) and true == PaGlobal_TradeMyBasket_All._ui._rdo_SeaVehicle:IsChecked() then
    servantType = 1
  end
  for i = 1, PaGlobal_TradeMyBasket_All._currentSlotCount do
    if nil ~= PaGlobal_TradeMyBasket_All._currentCartItemTable[i] and toInt64(0, 0) ~= PaGlobal_TradeMyBasket_All._currentCartItemTable[i]._count then
      local shopItemIdx = PaGlobal_TradeMyBasket_All._currentCartItemTable[i]._shopItemidx
      local curCount = PaGlobal_TradeMyBasket_All._currentCartItemTable[i]._count
      local itemCount32 = Int64toInt32(curCount)
      if -1 == shopItemIdx or nil == shopItemIdx then
        return
      end
      for count = 1, itemCount32 do
        npcShop_doBuy(shopItemIdx, 1, fromWhere, toWhere, false, servantType)
      end
      PaGlobal_TradeMyBasket_All._buyRequest = true
    end
  end
end
function PaGlobalFunc_TradeMyBasket_All_GetCartItemCount(itemKey)
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return 0
  end
  if nil == itemKey then
    return 0
  end
  if nil ~= PaGlobal_TradeMyBasket_All._currentCartItemTable and 0 < PaGlobal_TradeMyBasket_All._currentSlotCount then
    for i = 1, PaGlobal_TradeMyBasket_All._currentSlotCount do
      if nil ~= PaGlobal_TradeMyBasket_All._currentCartItemTable[i] and itemKey == PaGlobal_TradeMyBasket_All._currentCartItemTable[i]._itemKey then
        return PaGlobal_TradeMyBasket_All._currentCartItemTable[i]._count
      end
    end
  end
  return 0
end
function PaGlobalFunc_TradeMyBasket_All_GetItemToCart(count, itemKey, shopItemIdx)
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  if nil == itemKey or nil == count or nil == shopItemIdx then
    return
  end
  if nil ~= PaGlobal_TradeMyBasket_All._currentCartItemTable and 0 < PaGlobal_TradeMyBasket_All._currentSlotCount then
    for i = 1, PaGlobal_TradeMyBasket_All._currentSlotCount do
      if nil ~= PaGlobal_TradeMyBasket_All._currentCartItemTable[i] and itemKey == PaGlobal_TradeMyBasket_All._currentCartItemTable[i]._itemKey then
        local curSlotIndex = PaGlobal_TradeMyBasket_All._currentCartItemTable[i]._slotIdx
        local curCount = PaGlobal_TradeMyBasket_All._currentCartItemTable[i]._count
        local tradeItemWrapper = npcShop_getTradeItem(itemKey)
        local buyableStack = tradeItemWrapper:get():calculateRemainCount()
        local finalCount = curCount + count
        if buyableStack < finalCount then
          finalCount = buyableStack
        end
        PaGlobal_TradeMyBasket_All._currentCartItemTable[i]._count = finalCount
        PaGlobal_TradeMyBasket_All._ui._list2_MyBasket:requestUpdateVisible()
        PaGlobal_TradeMyBasket_All:addCartInfo()
        PaGlobal_TradeMyBasket_All:myMoneyUpdate()
        return
      end
    end
  end
  local shopItemWrapper = npcShop_getTradeItem(itemKey)
  if nil == shopItemWrapper then
    return
  end
  local buyableStack = shopItemWrapper:getRemainStackCount()
  if buyableStack <= toInt64(0, 0) then
    return
  end
  PaGlobal_TradeMyBasket_All._currentSlotCount = PaGlobal_TradeMyBasket_All._currentSlotCount + 1
  local slotNo = PaGlobal_TradeMyBasket_All._currentSlotCount
  local shopItemSS = shopItemWrapper:getStaticStatus()
  local shopitemPrice64 = shopItemWrapper:getTradeSellPrice()
  local shopitemPrice32 = Int64toInt32(shopitemPrice64)
  local shopitemName = shopItemSS:getName()
  local shopitemWeight = shopItemSS:get()._weight
  local weight = toInt64(0, shopitemWeight)
  local cartItemData = {
    _itemKey = nil,
    _count = 1,
    _slotIdx = nil,
    _commerceTypeIndex = nil,
    _itemName = nil,
    _itemPrice = nil,
    _shopItemidx = nil,
    _weight = nil
  }
  cartItemData._itemKey = itemKey
  cartItemData._count = count
  cartItemData._slotIdx = slotNo
  cartItemData._commerceTypeIndex = shopItemSS:getCommerceType()
  cartItemData._itemName = shopitemName
  cartItemData._itemPrice = shopitemPrice32
  cartItemData._itemSS = shopItemSS
  cartItemData._weight = weight
  cartItemData._shopItemidx = shopItemIdx
  PaGlobal_TradeMyBasket_All._currentCartItemTable[slotNo] = cartItemData
  PaGlobal_TradeMyBasket_All._ui._list2_MyBasket:getElementManager():clearKey()
  for ii = 1, slotNo do
    PaGlobal_TradeMyBasket_All._ui._list2_MyBasket:getElementManager():pushKey(toInt64(0, ii))
  end
  PaGlobal_TradeMyBasket_All:addCartInfo()
  PaGlobal_TradeMyBasket_All:myMoneyUpdate()
  PaGlobal_TradeMyBasket_All:updatePadXEvent()
end
function HandleEventLUp_TradeMyBasket_All_ChangeItemCount(slotIndex)
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  if nil == PaGlobal_TradeMyBasket_All._currentCartItemTable[slotIndex] then
    return
  end
  if true == Panel_NumberPad_IsPopUp() then
    Panel_NumberPad_Close()
  end
  local currentItemKey = PaGlobal_TradeMyBasket_All._currentCartItemTable[slotIndex]._itemKey
  local tradeItemWrapper = npcShop_getTradeItem(currentItemKey)
  local buyableStack = tradeItemWrapper:get():calculateRemainCount()
  Panel_NumberPad_Show(true, buyableStack, slotIndex, PaGlobalFunc_TradeMyBasket_All_ChangeItemCountResult)
end
function PaGlobalFunc_TradeMyBasket_All_ChangeItemCountResult(inputNumber, slotIndex)
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  if nil == PaGlobal_TradeMyBasket_All._currentCartItemTable[slotIndex] then
    return
  end
  if nil == inputNumber or nil == slotIndex or inputNumber <= toInt64(0, 0) then
    return
  end
  PaGlobal_TradeMyBasket_All._currentCartItemTable[slotIndex]._count = inputNumber
  PaGlobal_TradeMyBasket_All._ui._list2_MyBasket:requestUpdateByKey(toInt64(0, slotIndex))
  PaGlobal_TradeMyBasket_All:addCartInfo()
  PaGlobal_TradeMyBasket_All:myMoneyUpdate()
  PaGlobal_TradeMarketItemList_All:update()
end
function HandleEventLUp_TradeMyBasket_All_SelectedItemSell(slotIdx)
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  if nil == PaGlobal_TradeMyBasket_All._myItemDataTable[slotIdx] then
    return
  end
  PaGlobal_TradeMyBasket_All._list2ScrollData._scrollPos = PaGlobal_TradeMyBasket_All._ui._list2_MyItem:GetVScroll():GetControlPos()
  PaGlobal_TradeMyBasket_All._list2ScrollData._currentIdx = PaGlobal_TradeMyBasket_All._ui._list2_MyItem:getCurrenttoIndex()
  local itemData = PaGlobal_TradeMyBasket_All._myItemDataTable[slotIdx]
  local itemCount = itemData.leftCount
  if itemCount >= toInt64(0, 1) then
    Panel_NumberPad_Show(true, itemData.leftCount, slotIdx, PaGlobalFunc_TradeMyBasket_All_ConfirmSell)
  else
    PaGlobalFunc_TradeMyBasket_All_ConfirmSell(itemCount, slotIdx)
  end
end
function PaGlobalFunc_TradeMyBasket_All_ConfirmSell(inputNumber, slotIdx)
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  local itemData = PaGlobal_TradeMyBasket_All._myItemDataTable[slotIdx]
  local inventory = getSelfPlayer():get():getInventory()
  local s64_TradeItemNo = toInt64(0, 0)
  local s64_inventoryItemCount = toInt64(0, 0)
  local itemValueType, regionInfo, itemWrapper
  local talker = dialog_getTalker()
  if nil ~= talker then
    local actorKeyRaw = talker:getActorKey()
    local actorProxy = getNpcActor(actorKeyRaw):get()
    local characterStaticStatus = actorProxy:getCharacterStaticStatus()
    if true == characterStaticStatus:isSupplyMerchant() or true == characterStaticStatus:isFishSupplyMerchant() then
      local possessableWeight = Int64toInt32(getSelfPlayer():get():getPossessableWeight_s64())
      possessableWeight = possessableWeight + math.floor(possessableWeight * (ToClient_getDecreaseWeightByFairy() / 1000000))
      if 0 < math.floor(Int64toInt32(inventory:getWeight_s64()) / possessableWeight) then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "Lua_TradeMarket_Not_Enough_Weight"))
        return
      end
    end
  end
  local eServantType = CppEnums.ServantType.Type_Vehicle
  if PaGlobal_TradeMyBasket_All._ENUM_INVENTORY == itemData.itemFromWhere then
    s64_TradeItemNo = npcShop_getItemNo(itemData.invenNum)
    s64_inventoryItemCount = inventory:getItemCountByItemNo_s64(s64_TradeItemNo)
    itemValueType = inventory:getItemByItemNo(s64_TradeItemNo)
    regionInfo = itemValueType:getItemRegionInfo()
    itemWrapper = npcShop_getItemWrapperByShopSlotNo(itemData.invenNum)
  else
    local VehicleActorKey, VehicleActorProxy
    local temporaryWrapper = getTemporaryInformationWrapper()
    local servantInfo
    if PaGlobal_TradeMyBasket_All._ENUM_LAND_VEHICLE == itemData.itemFromWhere then
      servantInfo = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
      if nil ~= servantInfo then
        s64_TradeItemNo = npcShop_getVehicleInvenItemNoByShopSlotNo(itemData.invenNum)
        VehicleActorKey = servantInfo:getActorKeyRaw()
        if nil ~= VehicleActorKey then
          VehicleActorProxy = getVehicleActor(VehicleActorKey)
        end
        local vehicleInven = VehicleActorProxy:get():getInventory()
        s64_inventoryItemCount = vehicleInven:getItemCountByItemNo_s64(s64_TradeItemNo)
        itemValueType = vehicleInven:getItemByItemNo(s64_TradeItemNo)
        regionInfo = itemValueType:getItemRegionInfo()
        itemWrapper = npcShop_getVehicleItemWrapper(itemData.invenNum)
        eServantType = CppEnums.ServantType.Type_Vehicle
      end
    elseif PaGlobal_TradeMyBasket_All._ENUM_SEA_VEHICLE == itemData.itemFromWhere then
      servantInfo = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
      if nil ~= servantInfo then
        s64_TradeItemNo = npcShop_getShipInvenItemNoByShopSlotNo(itemData.invenNum)
        VehicleActorKey = servantInfo:getActorKeyRaw()
        if nil ~= VehicleActorKey then
          VehicleActorProxy = getVehicleActor(VehicleActorKey)
        end
        local vehicleInven = VehicleActorProxy:get():getInventory()
        s64_inventoryItemCount = vehicleInven:getItemCountByItemNo_s64(s64_TradeItemNo)
        itemValueType = vehicleInven:getItemByItemNo(s64_TradeItemNo)
        regionInfo = itemValueType:getItemRegionInfo()
        itemWrapper = npcShop_getShipItemWrapper(itemData.invenNum)
        eServantType = CppEnums.ServantType.Type_Ship
      end
    end
  end
  if nil == itemWrapper then
    _PA_ASSERT(false, "itemWrapper\234\176\128 \236\152\172\235\176\148\235\165\180\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : PaGlobalFunc_TradeMyBasket_All_ConfirmSell")
    return
  end
  PaGlobal_TutorialManager:handleTradeMarketSellSomeConfirm(itemWrapper:getStaticStatus():get()._key:getItemKey())
  local tradeType = itemWrapper:getStaticStatus():get()._tradeType
  local isLinkedNode = npcShop_CheckLinkedItemExplorationNode(itemData.invenNum, itemData.inventoryType, eServantType)
  local sellData = {
    tradeType = tradeType,
    invenNum = itemData.invenNum,
    inputNumber = inputNumber,
    inventoryType = itemData.inventoryType,
    slotIndex = slotIdx,
    fromWhere = itemData.itemFromWhere
  }
  PaGlobal_TradeMyBasket_All._sellData = sellData
  if false == isLinkedNode and 0 ~= regionInfo._waypointKey then
    local characterStaticStatus = npcShop_getCurrentCharacterKeyForTrade():get()
    if true == characterStaticStatus:isSupplyMerchant() then
      PaGlobalFunc_TradeMyBasket_All_SellComplete()
      return
    end
    local isNodeFreeTrade = itemWrapper:getStaticStatus():get():isNodeFreeTrade()
    if true == isNodeFreeTrade then
      PaGlobalFunc_TradeMyBasket_All_SellComplete()
    else
      local talker = dialog_getTalker()
      local nodeString = PAGetStringParam3(Defines.StringSheet_GAME, "Lua_TradeMarketSellList_NeedNodeLink", "exploreNode1", talker:getExplorationNodeName(), "exploreNode2", itemWrapper:getProductionRegion(), "sellPercent", getNotLinkNodeSellPercent() / PaGlobal_TradeMyBasket_All._CONST_CALCULATE_PERCENT_VALUE)
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "Lua_TradeMarketSellList_NeedNodeLinkTitle"),
        content = nodeString,
        functionYes = PaGlobalFunc_TradeMyBasket_All_SellComplete,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    end
  else
    local rv
    if 5 == tradeType then
      rv = npcShop_doSellInTradeShop(itemData.invenNum, Int64toInt32(inputNumber), itemData.inventoryType, 14)
    elseif PaGlobal_TradeMyBasket_All._ENUM_INVENTORY == itemData.itemFromWhere then
      local toWhere = 0
      if __eTradeSupplyShopType_Shell == PaGlobal_TradeMyBasket_All._currShopType then
        toWhere = CppEnums.ItemWhereType.eMoneyInventory
      end
      rv = npcShop_doSellInTradeShop(itemData.invenNum, Int64toInt32(inputNumber), itemData.inventoryType, toWhere)
    elseif PaGlobal_TradeMyBasket_All._ENUM_LAND_VEHICLE == itemData.itemFromWhere then
      rv = npcShop_doSellInTradeShop(itemData.invenNum, Int64toInt32(inputNumber), itemData.inventoryType, 0, 0)
    elseif PaGlobal_TradeMyBasket_All._ENUM_SEA_VEHICLE == itemData.itemFromWhere then
      rv = npcShop_doSellInTradeShop(itemData.invenNum, Int64toInt32(inputNumber), itemData.inventoryType, 0, 1)
    end
  end
end
function PaGlobalFunc_TradeMyBasket_All_SellComplete()
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  if nil == PaGlobal_TradeMyBasket_All._sellData then
    return
  end
  local sellData = PaGlobal_TradeMyBasket_All._sellData
  if nil == sellData.tradeType then
    sellData.tradeType = 0
  end
  local sellCount = Int64toInt32(sellData.inputNumber)
  local toWhere = sellData.inventoryType
  local shopNumber = sellData.invenNum
  local slotIdx = sellData.slotIndex
  local itemFromWhere = sellData.fromWhere
  local rv
  if 5 == sellData.tradeType then
    rv = npcShop_doSellInTradeShop(shopNumber, sellCount, toWhere, 14)
  elseif PaGlobal_TradeMyBasket_All._ENUM_INVENTORY == itemFromWhere then
    local itemWhereType = 0
    if __eTradeSupplyShopType_Shell == PaGlobal_TradeMyBasket_All._currShopType then
      itemWhereType = CppEnums.ItemWhereType.eMoneyInventory
    end
    rv = npcShop_doSellInTradeShop(shopNumber, sellCount, toWhere, itemWhereType)
  elseif PaGlobal_TradeMyBasket_All._ENUM_LAND_VEHICLE == itemFromWhere then
    rv = npcShop_doSellInTradeShop(shopNumber, sellCount, toWhere, 0, 0)
  elseif PaGlobal_TradeMyBasket_All._ENUM_SEA_VEHICLE == itemFromWhere then
    rv = npcShop_doSellInTradeShop(shopNumber, sellCount, toWhere, 0, 1)
  end
  if 0 == rv then
    if 0 == PaGlobal_TradeMyBasket_All._myItemDataTable[slotIdx].leftCount then
      PaGlobal_TradeMyBasket_All._myItemDataTable[slotIdx] = nil
      PaGlobal_TradeMyBasket_All._realPriceList[slotIdx] = nil
      PaGlobal_TradeMyBasket_All._ui._list2_MyItem:getElementManager():removeKey(toInt64(0, slotIdx))
      PaGlobal_TradeMyBasket_All._myItemTotalCount = PaGlobal_TradeMyBasket_All._myItemTotalCount - 1
    else
      PaGlobal_TradeMyBasket_All._ui._list2_MyItem:requestUpdateByKey(toInt64(0, slotIdx))
    end
  end
  PaGlobal_TradeMyBasket_All:updatePadXEvent()
end
function HandleEventLUp_TradeMyBasket_All_SellAll()
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  if 0 >= PaGlobal_TradeMyBasket_All._myItemTotalCount then
    return
  end
  local messageBoxMemo = ""
  if true == PaGlobal_TradeMyBasket_All._isNoLinkedNodeOne then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "Lua_TradeMarketSellList_TradeItemAllSellQuestion_NodeLink")
  else
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "Lua_TradeMarketSellList_TradeItemAllSellQuestion")
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "Lua_TradeMarketSellList_NeedNodeLinkTitle"),
    content = messageBoxMemo,
    functionYes = PaGlobalFunc_TradeMyBasket_All_SellAllContinue,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_TradeMyBasket_All_SellAllContinue()
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  if true == Panel_NumberPad_IsPopUp() then
    Panel_NumberPad_Close()
  end
  local inventory = getSelfPlayer():get():getInventory()
  local s64_inventoryItemCount = toInt64(0, 0)
  local s64_TradeItemNo = toInt64(0, 0)
  local sellCount = 0
  local rv
  local talker = dialog_getTalker()
  if nil ~= talker then
    local actorKeyRaw = talker:getActorKey()
    local actorProxy = getNpcActor(actorKeyRaw):get()
    local characterStaticStatus = actorProxy:getCharacterStaticStatus()
    if true == characterStaticStatus:isSupplyMerchant() or true == characterStaticStatus:isFishSupplyMerchant() then
      local possessableWeight = Int64toInt32(getSelfPlayer():get():getPossessableWeight_s64())
      possessableWeight = possessableWeight + math.floor(possessableWeight * (ToClient_getDecreaseWeightByFairy() / 1000000))
      if 0 < math.floor(Int64toInt32(inventory:getWeight_s64()) / possessableWeight) then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "Lua_TradeMarket_Not_Enough_Weight"))
        return
      end
    end
  end
  local myInventortySellAbleCount = npcShop_getSellCount()
  local priceIndex = 0
  for goodsIdx = 0, myInventortySellAbleCount do
    local shopItemWrapper = npcShop_getItemSell(goodsIdx)
    if nil ~= shopItemWrapper then
      local tradeType = shopItemWrapper:getStaticStatus():get()._tradeType
      s64_TradeItemNo = npcShop_getItemNo(goodsIdx)
      s64_inventoryItemCount = inventory:getItemCountByItemNo_s64(s64_TradeItemNo)
      if 5 == tradeType then
        rv = npcShop_doSellInTradeShop(goodsIdx, Int64toInt32(s64_inventoryItemCount), 0, 14)
        priceIndex = priceIndex + 1
        sellCount = sellCount + 1
      else
        local realPrice = PaGlobal_TradeMyBasket_All._realPriceList[itemIdx]
        if nil == realPrice then
          realPrice = 150000
        end
        local myInvenMoney = Int64toInt32(getSelfPlayer():get():getInventory():getMoney_s64())
        local limitCount = math.floor((PaGlobal_TradeMyBasket_All._LIMITED_SELLMONEY - myInvenMoney) / realPrice)
        priceIndex = priceIndex + 1
        local toWhere = 0
        if __eTradeSupplyShopType_Shell == PaGlobal_TradeMyBasket_All._currShopType then
          toWhere = CppEnums.ItemWhereType.eMoneyInventory
        end
        rv = npcShop_doSellInTradeShop(goodsIdx, Int64toInt32(s64_inventoryItemCount), 0, toWhere)
        sellCount = sellCount + 1
      end
    end
  end
  local VehicleActorKey, VehicleActorProxy
  local temporaryWrapper = getTemporaryInformationWrapper()
  local servantInfo
  for servantType = 0, 1 do
    if 0 == servantType then
      servantInfo = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
    elseif true == ToClient_IsContentsGroupOpen("576") and ToClient_IsContentsGroupOpen("504") or true == PaGlobal_TradeMyBasket_All._isConsole then
      servantInfo = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
    end
    if nil ~= servantInfo then
      local servertinventory = servantInfo:getInventory()
      if nil ~= servertinventory then
        local servertInventorySize = servertinventory:size()
        local emptyCount = 0
        for slotCount = 2, servertInventorySize - 1 do
          if not servertinventory:empty(slotCount) then
            local s64_VehicleItemNo
            if 0 == servantType then
              s64_VehicleItemNo = npcShop_getVehicleInvenItemNoByShopSlotNo(slotCount - 2 - emptyCount)
            else
              s64_VehicleItemNo = npcShop_getShipInvenItemNoByShopSlotNo(slotCount - 2 - emptyCount)
            end
            if nil ~= s64_VehicleItemNo then
              local vehicleItemCount = Int64toInt32(servertinventory:getItemCountByItemNo_s64(s64_VehicleItemNo))
              local servantItemWrapper
              if 0 == servantType then
                servantItemWrapper = npcShop_getVehicleSellItem(slotCount - 2 - emptyCount)
              else
                servantItemWrapper = npcShop_getShipSellItem(slotCount - 2 - emptyCount)
              end
              if nil ~= servantItemWrapper then
                local realPrice = PaGlobal_TradeMyBasket_All._realPriceList[itemIdx]
                if nil == realPrice then
                  realPrice = 150000
                end
                local myInvenMoney = Int64toInt32(getSelfPlayer():get():getInventory():getMoney_s64())
                local limitCount = math.floor((PaGlobal_TradeMyBasket_All._LIMITED_SELLMONEY - myInvenMoney) / realPrice)
                priceIndex = priceIndex + 1
                rv = npcShop_doSellInTradeShop(slotCount - 2 - emptyCount, vehicleItemCount, 4, 0, servantType)
                sellCount = sellCount + 1
              end
            end
          else
            emptyCount = emptyCount + 1
          end
        end
      end
    end
  end
  PaGlobal_TradeMyBasket_All:getMyItem()
  if nil ~= Panel_Dialog_Trade_BiddingGame_All then
    if true == Panel_Dialog_Trade_BiddingGame_All:GetShow() then
      HandleEventLup_TradeBiddingGame_All_Close()
    end
  elseif nil ~= Panel_TradeGame and true == Panel_TradeGame:GetShow() and true == isTradeGameFinish() then
    Fglobal_TradeGame_Close()
  end
end
function PaGlobalFunc_TradeMyBasket_All_GetMySellItemCount()
  if nil == PaGlobal_TradeMyBasket_All._myItemTotalCount then
    return 0
  end
  return PaGlobal_TradeMyBasket_All._myItemTotalCount
end
function HandleEventLUp_TradeMyBasket_All_BiddingGameStart()
  if nil == Panel_Dialog_Trade_MyBasket_All or true == Panel_Dialog_Trade_BiddingGame_All:GetShow() then
    return
  end
  local talker = dialog_getTalker()
  if nil == talker then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == Panel_NumberPad_IsPopUp() then
    Panel_NumberPad_Close()
  end
  if -1 ~= ToClient_GetMyDuelCharacterIndex() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantCharacterTagSellTradeItem"))
    return
  end
  local useStartSlot = inventorySlotNoUserStart()
  local invenUseSize = selfPlayer:get():getInventorySlotCount(true)
  local inventory = selfPlayer:get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
  local invenMaxSize = inventory:sizeXXX()
  local freeCount = inventory:getFreeCount()
  if invenUseSize - useStartSlot <= invenUseSize - freeCount - useStartSlot then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_SELLLIST_DONTPLAYGAME"))
    return
  end
  if 0 >= PaGlobal_TradeMyBasket_All._myItemTotalCount then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TRADEGAME_MSG_2")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TRADEGAME_MSG_1"),
      content = messageBoxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local wp = selfPlayer:getWp()
  if wp < 5 then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TRADEGAME_MSG_3")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TRADEGAME_MSG_1"),
      content = messageBoxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local ToClient_BiddingGameStart = function()
    local talker = dialog_getTalker()
    if nil == talker then
      return
    end
    ToClient_TradeGameStart(talker:getActorKey())
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TRADEGAME_MSG_4") .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERRANDOMSELECT_NOWWP", "getWp", wp)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TRADEGAME_MSG_1"),
    content = messageBoxMemo,
    functionYes = ToClient_BiddingGameStart,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_TradeMyBasket_All_FindItemInSellList(itemKey)
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  if nil == itemKey or itemKey <= 0 then
    return
  end
  local tradeItemWrapper = npcShop_getTradeItem(itemKey)
  if nil == tradeItemWrapper then
    return
  end
  local itemSS = tradeItemWrapper:getStaticStatus()
  PaGlobalFunc_TradeMarketItemList_All_FindClickedItem(itemSS)
end
function PaGlobalFunc_TradeMyBasket_All_TabChange(idx)
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  if nil == idx then
    return
  end
  local characterStaticStatus = npcShop_getCurrentCharacterKeyForTrade():get()
  if nil == characterStaticStatus then
    return
  end
  local isFishSupplyMerchant = characterStaticStatus:isFishSupplyMerchant()
  local isSupplyMerchant = characterStaticStatus:isSupplyMerchant()
  local isLoyalFlag = true == isFishSupplyMerchant or true == isSupplyMerchant
  PaGlobal_TradeMyBasket_All:update()
  if PaGlobal_TradeMyBasket_All._ENUM_TAB_SELL == idx then
    PaGlobal_TradeMyBasket_All._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_TXT_TITLE"))
    PaGlobal_TradeMyBasket_All._ui._list2_MyBasket:SetShow(false)
    PaGlobal_TradeMyBasket_All._ui._list2_MyItem:SetShow(true)
    if false == PaGlobal_TradeMyBasket_All._isConsole then
      PaGlobal_TradeMyBasket_All._ui._btn_BuyAll_PC:SetShow(false)
      PaGlobal_TradeMyBasket_All._ui._btn_ClearALL_PC:SetShow(false)
      if true == isLoyalFlag then
        PaGlobal_TradeMyBasket_All._ui._btn_TradeGame_PC:SetShow(false)
      else
        PaGlobal_TradeMyBasket_All._ui._btn_TradeGame_PC:SetShow(true)
      end
      PaGlobal_TradeMyBasket_All._ui._btn_SellALL_PC:SetShow(true)
      PaGlobal_TradeMyBasket_All._ui._txt_NeedMoney:SetShow(false)
      PaGlobal_TradeMyBasket_All._ui._stc_NeedMoney:SetShow(false)
    end
    PaGlobal_TradeMyBasket_All:getMyItem()
    if true == PaGlobal_TradeMyBasket_All._isConsole then
      PaGlobal_TradeMyBasket_All:updatePadXEvent()
      local bigHand = 1000000 ~= getSelfPlayer():get():getlTradeItemCountRate()
      if nil ~= Panel_Dialog_Trade_BiddingGame_All then
        local isSuccess = PaGlobalFunc_TradeBiddingGame_All_IsSuccess()
        if true == isSuccess or true == bigHand or true == isLoyalFlag then
          Panel_Dialog_Trade_MyBasket_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
          PaGlobal_TradeMyBasket_All._ui._stc_KeyGuide_Y:SetShow(false)
        else
          Panel_Dialog_Trade_MyBasket_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_TradeMyBasket_All_BiddingGameStart()")
          PaGlobal_TradeMyBasket_All._ui._stc_KeyGuide_Y:SetShow(true)
        end
      elseif false == isLoyalFlag then
        Panel_Dialog_Trade_MyBasket_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_TradeMyBasket_All_BiddingGameStart()")
      else
        Panel_Dialog_Trade_MyBasket_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      end
    end
  else
    PaGlobal_TradeMyBasket_All._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_TITLE"))
    PaGlobal_TradeMyBasket_All._ui._list2_MyBasket:SetShow(true)
    PaGlobal_TradeMyBasket_All._ui._list2_MyItem:SetShow(false)
    PaGlobal_TradeMyBasket_All._ui._txt_NeedMoney:SetShow(true)
    PaGlobal_TradeMyBasket_All._ui._stc_NeedMoney:SetShow(true)
    if false == PaGlobal_TradeMyBasket_All._isConsole then
      PaGlobal_TradeMyBasket_All._ui._btn_BuyAll_PC:SetShow(true)
      PaGlobal_TradeMyBasket_All._ui._btn_ClearALL_PC:SetShow(true)
      PaGlobal_TradeMyBasket_All._ui._btn_TradeGame_PC:SetShow(false)
      PaGlobal_TradeMyBasket_All._ui._btn_SellALL_PC:SetShow(false)
    else
      Panel_Dialog_Trade_MyBasket_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_TradeMyBasket_All_ClearAllItem()")
      PaGlobal_TradeMyBasket_All:updatePadXEvent()
    end
  end
  PaGlobal_TradeMyBasket_All:setKeyGuides(isLoyalFlag)
  PaGlobal_TradeMyBasket_All:addCartInfo()
end
function HandleEventPadPress_TradeBiddingGame_All_ClickRdoBtn(idx)
  if false == PaGlobal_TradeMyBasket_All._isConsole then
    return
  end
  PaGlobal_TradeMyBasket_All._ui._rdo_Inven:SetCheck(false)
  PaGlobal_TradeMyBasket_All._ui._rdo_LandVehicle:SetCheck(false)
  PaGlobal_TradeMyBasket_All._ui._rdo_SeaVehicle:SetCheck(false)
  if 0 == idx then
    PaGlobal_TradeMyBasket_All._ui._rdo_Inven:SetCheck(true)
  elseif 1 == idx then
    PaGlobal_TradeMyBasket_All._ui._rdo_LandVehicle:SetCheck(true)
  else
    PaGlobal_TradeMyBasket_All._ui._rdo_SeaVehicle:SetCheck(true)
  end
  HandleEventLup_TradeMyBasket_All_CarriageDataUpdate()
end
function HandleEventLup_TradeMyBasket_All_CarriageDataUpdate()
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  if nil == PaGlobal_TradeMyBasket_All._totalWeight and nil == PaGlobal_TradeMyBasket_All._totalSlot then
    PaGlobal_TradeMyBasket_All._totalWeight = 0
    PaGlobal_TradeMyBasket_All._totalSlot = 0
  end
  local rdo_inven = PaGlobal_TradeMyBasket_All._ui._rdo_Inven
  if true == rdo_inven:IsCheck() then
    PaGlobal_TradeMyBasket_All:inventoryUpdate(PaGlobal_TradeMyBasket_All._totalSlot, PaGlobal_TradeMyBasket_All._totalWeight)
    PaGlobal_TradeMyBasket_All:checkVehicle()
  else
    PaGlobal_TradeMyBasket_All:inventoryUpdate()
    PaGlobal_TradeMyBasket_All:checkVehicle(PaGlobal_TradeMyBasket_All._totalSlot, PaGlobal_TradeMyBasket_All._totalWeight)
  end
end
function PaGlobalFunc_TradeMyBasket_All_UpdateMySellItem()
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  PaGlobal_TradeMyBasket_All:getMyItem()
end
function PaGlobalFunc_TradeMyBasket_All_GetCurrentItemCount()
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  if nil == PaGlobal_TradeMyBasket_All._myItemTotalCount or PaGlobal_TradeMyBasket_All._myItemTotalCount <= -1 then
    return 0
  else
    return PaGlobal_TradeMyBasket_All._myItemTotalCount
  end
end
function FromClient_TradeMyBasket_All_CheckServant()
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  if true == PaGlobal_TradeMyBasket_All._buyRequest then
    PaGlobal_TradeMyBasket_All:dataClear()
    PaGlobal_TradeMyBasket_All:update()
  else
    PaGlobal_TradeMyBasket_All:getMyItem()
  end
  PaGlobalFunc_TradeFunction_All_BigHandCheck()
  PaGlobal_TradeMyBasket_All:checkVehicle()
end
function FromClient_TradeMyBasket_All_InventoryUpdate()
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return
  end
  if true == PaGlobal_TradeMyBasket_All._buyRequest then
    PaGlobal_TradeMyBasket_All:dataClear()
    PaGlobal_TradeMyBasket_All:update()
  end
  PaGlobalFunc_TradeFunction_All_BigHandCheck()
  PaGlobal_TradeMyBasket_All:myMoneyUpdate()
  PaGlobal_TradeMyBasket_All:inventoryUpdate()
end
function HandleEventOnOut_TradeMyBasket_All_SimpleTooltip(isShow, tipType, index)
  if nil == isShow or false == isShow or nil == tipType or nil == index then
    TooltipSimple_Hide()
    return
  end
  local name, control, desc
  local myItemSlotTable = PaGlobal_TradeMyBasket_All._myItemSlotTable[index]
  if nil == myItemSlotTable then
    return
  end
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TOOLTIP_TRADEPRICE") .. " / " .. PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_MARKETPRICE")
    control = myItemSlotTable._txt_ItemPrice
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TOOLTIP_PROFITSTATIC")
    control = myItemSlotTable._txt_Profit
  elseif 3 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TOOLTIP_DISTANCEBONUS")
    control = myItemSlotTable._txt_DistanceBonus
  elseif 4 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TOOLTIP_NOLINK")
    control = myItemSlotTable._icon_Origin
  elseif 5 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TOOLTIP_EXPIRATION")
    control = myItemSlotTable._txt_Period
  elseif 6 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_NOTDISTANCEBONUS")
    control = myItemSlotTable._txt_DistanceBonus
  elseif 7 == tipType then
  elseif 8 == tipType then
    name = myItemSlotTable._itemName
    control = myItemSlotTable.txt_ItemName
  elseif 9 == tipType then
  elseif 10 == tipType then
  elseif 11 == tipType then
    name = myItemSlotTable._txt_Origin:GetText()
    control = myItemSlotTable._txt_Origin
  elseif 12 == tipType then
    name = myItemSlotTable._txt_DistanceBonus:GetText()
    control = myItemSlotTable._txt_DistanceBonus
  end
  if nil == name or nil == control then
    TooltipSimple_Hide()
    return
  end
  if true == isShow then
    registTooltipControl(control, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(control, name, desc)
  end
end
function HandleEventOnOut_TradeMyBasket_All_ItemIconTooltip(slotNo, toolTipType)
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() or nil == slotNo or nil == toolTipType then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if 0 == toolTipType then
    Panel_Tooltip_Item_Show_GeneralStatic(slotNo, tostring(PaGlobal_TradeMyBasket_All._tooltipType[toolTipType]), true)
  else
    Panel_Tooltip_Item_Show_GeneralNormal(slotNo, tostring(PaGlobal_TradeMyBasket_All._tooltipType[toolTipType]), true)
  end
end
function HandleEventOnOut_TradeMyBasket_All_LimitTextTooltip(index, show, isBuy)
  if nil == index or false == show then
    TooltipSimple_Hide()
    return
  end
  local content
  local name = ""
  local desc = ""
  if true == isBuy then
    content = PaGlobal_TradeMyBasket_All._ui._list2_MyBasket:GetContentByKey(index)
  else
    content = PaGlobal_TradeMyBasket_All._ui._list2_MyItem:GetContentByKey(index)
  end
  if nil ~= content then
    local txt_itemName = UI.getChildControl(content, "StaticText_ItemName")
    control = txt_itemName
    name = txt_itemName:GetText()
    TooltipSimple_Show(control, name, desc)
  end
end
function PaGlobalFunc_TradeMyBasket_All_SetInvenIconEvent(isOver)
  if true == isOver then
    PaGlobal_TradeMyBasket_All._ui._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_SELECT"))
  elseif PaGlobalFunc_TradeFunction_All_GetCurrentTab() == PaGlobal_TradeMyBasket_All._ENUM_TAB_SELL then
    PaGlobal_TradeMyBasket_All._ui._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEMARKET_BTN_SELL"))
  else
    PaGlobal_TradeMyBasket_All._ui._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_MARKETPLACE_KEYGUIDE_VALUECHANGE"))
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    PaGlobal_TradeMyBasket_All._ui._stc_KeyGuide_A,
    PaGlobal_TradeMyBasket_All._ui._stc_KeyGuide_B
  }, PaGlobal_TradeMyBasket_All._ui._stc_Keyguides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobalFunc_TradeMyBasket_All_GetCurrShopType()
  if nil == Panel_Dialog_Trade_MyBasket_All or false == Panel_Dialog_Trade_MyBasket_All:GetShow() then
    return nil
  end
  return PaGlobal_TradeMyBasket_All._currShopType
end
