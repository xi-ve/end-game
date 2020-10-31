function PaGlobal_Tooltip_Control_All:initialize()
  if true == self._initialize then
    return
  end
  self._firstTradeInfoData = nil
  self._secondTradeInfoData = nil
  self._NORMALTOOLTIP = PaGlobal_Tooltip_Item_All
  self._EQUIPTOOLTIP = PaGlobal_Tooltip_Item_Equip_All
  self._LINKEDTOOLTIP = PaGlobal_Tooltip_Item_LinkedItem_All
  self._LINKEDCLICKTOOLTIP = PaGlobal_Tooltip_Item_LinkedClickItem_All
  self:setSkillTooltipPos()
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_Tooltip_Control_All:registEventHandler()
  registerEvent("FromClient_responseTradePrice", "FromClient_Tooltip_Control_All_ResponseTradePrice")
end
function PaGlobal_Tooltip_Control_All:show(itemStaticStatus, uiBase, isSSW, isItemWrapper, chattingLinkedItem, index, isItemMarket, invenSlotNo, tooltipType, indexForNaming)
  self._dataObject.itemMarket = isItemMarket
  self._dataObject.inventory = nil
  local itemNamingStr
  if nil ~= tooltipType and nil ~= indexForNaming then
    if "Dye" == tooltipType then
      itemNamingStr = getItemNaming(getTItemNoBySlotNo(indexForNaming, true))
    elseif "Improve" == tooltipType then
      itemNamingStr = getItemNaming(getTItemNoBySlotNo(indexForNaming, false))
    elseif "InventoryBag" == tooltipType then
      itemNamingStr = getItemNaming(indexForNaming)
    elseif "WeaponChange" == tooltipType then
      itemNamingStr = getItemNaming(getTItemNoBySlotNo(indexForNaming, false))
    elseif "Delivery" == tooltipType then
      itemNamingStr = getItemNaming(indexForNaming)
    end
  end
  local isEquipableItem, servantItem = self:setTooltip(self._NORMALTOOLTIP, itemStaticStatus, isSSW, isItemWrapper, chattingLinkedItem, index, nil, invenSlotNo, itemNamingStr)
  local equipItemWrapper
  if isEquipableItem and not servantItem and isItemMarket then
    if isSSW then
      equipItemWrapper = ToClient_getEquipmentItem(itemStaticStatus:getEquipSlotNo())
    else
      equipItemWrapper = ToClient_getEquipmentItem(itemStaticStatus:getStaticStatus():getEquipSlotNo())
    end
    if nil ~= equipItemWrapper then
      self:setTooltip(self._NORMALTOOLTIP, equipItemWrapper, false, true)
    end
  end
  if uiBase:IsUISubApp() then
    self:setPosition_UISubApp(uiBase)
    self._NORMALTOOLTIP._mainPanel:OpenUISubApp()
    if nil ~= equipItemWrapper then
      self._EQUIPTOOLTIP._mainPanel:OpenUISubApp()
    end
  else
    self:setPosition(uiBase)
  end
end
function PaGlobal_Tooltip_Control_All:showGeneralNormal(slotNo, slotType, isOn, index, targetX, targetY, uiBase, addPosX, addPosY)
  self._dataObject.itemMarket = nil
  self._equipItemLock.equipment = false
  self._clothBagSlotNo = nil
  self._bagInWarehouse = "WareHouse" == slotType
  if false == self:setDataObject(slotNo, slotType, isOn, true, index) then
    return
  end
  local slot = self._dataObject.slotData[slotType][slotNo]
  local itemInfo = self:getItemNormalInfo(slotNo, slotType, index)
  if nil == itemInfo then
    return
  end
  local parent = itemInfo.parent
  local inven = itemInfo.inven
  local actorKey = itemInfo.actorKey
  local isEquipOn = itemInfo.isEquipOn
  local isServantEquipOn = itemInfo.isServantEquipOn
  local deliveryItemNo = itemInfo.deliveryItemNo
  local itemWrapper = itemInfo.itemWrapper
  if nil == itemWrapper then
    return
  end
  local itemNamingStr = self:getItemName(slotNo, slotType, index, isEquipOn, actorKey, DeliveryItemNo, slotNumber)
  local isEquipableItem = false
  local servantItem = false
  local skillKey = SkillKey()
  self._dataObject.isSkill = false
  if itemWrapper:getStaticStatus():isSkillBook(skillKey) then
    self._dataObject.skillSlot = slot
    self._dataObject.isSkill = true
    Panel_SkillTooltip_Show(skillKey:getSkillNo(), false, "itemToSkill", false)
    return
  elseif not isEquipOn then
    local itemSSW = itemWrapper:getStaticStatus()
    if not itemSSW:isEquipable() then
      isEquipableItem, servantItem = self:setTooltip(self._NORMALTOOLTIP, itemWrapper, false, true, nil, nil, nil, nil, itemNamingStr)
    else
      isEquipableItem, servantItem = self:setTooltip(self._NORMALTOOLTIP, itemWrapper, false, true, nil, slotNo, nil, nil, itemNamingStr)
    end
  else
    self:setTooltip(self._EQUIPTOOLTIP, itemWrapper, false, true, nil, nil, nil, nil, itemNamingStr)
  end
  if isEquipableItem and not isEquipOn then
    local equipItemWrapper, campingItemWrapper
    if servantItem or isServantEquipOn then
      local temporaryWrapper = getTemporaryInformationWrapper()
      if nil ~= temporaryWrapper then
        local campingWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_CampingTent)
        if nil ~= campingWrapper then
          local servantKind = campingWrapper:getServantKind()
          if itemWrapper:getStaticStatus():get():isServantTypeUsable(servantKind) then
            campingItemWrapper = campingWrapper:getEquipItem(itemWrapper:getStaticStatus():getEquipSlotNo())
          end
        else
          local servantWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
          if nil ~= servantWrapper then
            local servantKind = servantWrapper:getServantKind()
            if itemWrapper:getStaticStatus():get():isServantTypeUsable(servantKind) then
              equipItemWrapper = servantWrapper:getEquipItem(itemWrapper:getStaticStatus():getEquipSlotNo())
            end
          end
        end
      end
    else
      local accSlotNo
      if true == _ContentsGroup_NewUI_Equipment_All then
        accSlotNo = PaGlobalFunc_Equipment_All_AccSlotNo(itemWrapper)
      else
        accSlotNo = FGlobal_AccSlotNo(itemWrapper)
      end
      if "betterItemList" == slotType then
        accSlotNo = PaGlobalFunc_GetAccesoryWorseEquipment_Key(itemWrapper)
      end
      if nil ~= accSlotNo then
        self._equipItemLock.itemAccNo = accSlotNo
        equipItemWrapper = ToClient_getEquipmentItem(accSlotNo)
      else
        self._equipItemLock.itemAccNo = -1
        equipItemWrapper = ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo())
      end
    end
    if nil ~= equipItemWrapper and "Enchant" ~= slotType then
      local equipNamingStr = ""
      equipNamingStr = getItemNaming(getTItemNoBySlotNo(equipItemWrapper:getStaticStatus():getEquipSlotNo(), true))
      self:setTooltip(self._EQUIPTOOLTIP, equipItemWrapper, false, true, nil, nil, nil, nil, equipNamingStr)
      local x1, y1, x2, y2 = setTextureUV_Func(self._EQUIPTOOLTIP._ui.stc_arrow, 263, 434, 291, 462)
      self._EQUIPTOOLTIP._ui.stc_arrow:getBaseTexture():setUV(x1, y1, x2, y2)
      self._EQUIPTOOLTIP._ui.stc_arrow:setRenderTexture(self._EQUIPTOOLTIP._ui.stc_arrow:getBaseTexture())
    end
    if nil ~= campingItemWrapper and "Enchant" ~= slotType then
      self:setTooltip(self._EQUIPTOOLTIP, campingItemWrapper, false, true)
      local x1, y1, x2, y2 = setTextureUV_Func(self._EQUIPTOOLTIP._ui.stc_arrow, 263, 434, 291, 462)
      self._EQUIPTOOLTIP._ui.stc_arrow:getBaseTexture():setUV(x1, y1, x2, y2)
      self._EQUIPTOOLTIP._ui.stc_arrow:setRenderTexture(self._EQUIPTOOLTIP._ui.stc_arrow:getBaseTexture())
    end
    if "Enchant" == slotType then
      local isCash = itemWrapper:getStaticStatus():get():isCash()
      local balksCount = itemWrapper:getStaticStatus():getExtractionCount_s64()
      local cronsCount = itemWrapper:getStaticStatus():getCronCount_s64()
      if false ~= isCash or nil ~= balksCount and toInt64(0, 0) ~= balksCount and nil ~= cronsCount and toInt64(0, 0) ~= cronsCount then
      else
        self:setTooltip(self._EQUIPTOOLTIP, itemWrapper, false, true, nil, nil, true, nil, itemNamingStr)
      end
      local x1, y1, x2, y2 = setTextureUV_Func(self._EQUIPTOOLTIP._ui.stc_arrow, 291, 434, 263, 462)
      self._EQUIPTOOLTIP._ui.stc_arrow:getBaseTexture():setUV(x1, y1, x2, y2)
      self._EQUIPTOOLTIP._ui.stc_arrow:setRenderTexture(self._EQUIPTOOLTIP._ui.stc_arrow:getBaseTexture())
    end
  end
  if slot.icon:getParent():IsUISubApp() then
    if nil ~= uiBase then
      self:setPanelPosition(uiBase, addPosX, addPosY)
    else
      self:setPosition_UISubApp(slot.icon, parent, inven)
    end
    self._EQUIPTOOLTIP._mainPanel:OpenUISubApp()
    if not isEquipOn then
      self._NORMALTOOLTIP._mainPanel:OpenUISubApp()
    end
  elseif nil ~= uiBase then
    self:setPanelPosition(uiBase, addPosX, addPosY)
  else
    self:setPosition(slot.icon, parent, inven, targetX, targetY)
  end
end
function PaGlobal_Tooltip_Control_All:showGeneralStatic(slotNo, slotType, isOn, index, targetX, targetY)
  self._dataObject.itemMarket = nil
  self._dataObject.inventory = nil
  if false == self:setDataObject(slotNo, slotType, isOn, false, index) then
    return
  end
  local slot = self._dataObject.slotData[slotType][slotNo]
  local itemInfo = self:getItemStaticInfo(slotNo, slotType, index)
  if nil == itemInfo then
    return
  end
  local isSSW = itemInfo.isSSW
  local isItemWrapper = itemInfo.isItemWrapper
  local inven = itemInfo.inven
  local parent = itemInfo.parent
  local itemSSW = itemInfo.itemSSW
  if nil == itemSSW then
    return
  end
  local skillKey = SkillKey()
  local isSkillBook = false
  if true == isSSW and false == isItemWrapper then
    isSkillBook = itemSSW:isSkillBook(skillKey)
  else
    isSkillBook = itemSSW:getStaticStatus():isSkillBook(skillKey)
  end
  if isSkillBook then
    self._dataObject.isSkill = true
    self._dataObject.skillSlot = slot
    Panel_SkillTooltip_Show(skillKey:getSkillNo(), false, "itemToSkill", false)
    return
  end
  self._dataObject.isSkill = false
  local isEquipableItem, servantItem = self:setTooltip(self._NORMALTOOLTIP, itemSSW, isSSW, isItemWrapper)
  if isEquipableItem then
    local equipItemWrapper
    if servantItem then
      local temporaryWrapper = getTemporaryInformationWrapper()
      if nil ~= temporaryWrapper and temporaryWrapper:isSelfVehicle() then
        if isItemWrapper or not isSSW then
          equipItemWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle):getEquipItem(itemSSW:getStaticStatus():getEquipSlotNo())
        else
          equipItemWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle):getEquipItem(itemSSW:getEquipSlotNo())
        end
      end
    elseif isItemWrapper or not isSSW then
      equipItemWrapper = ToClient_getEquipmentItem(itemSSW:getStaticStatus():getEquipSlotNo())
    else
      equipItemWrapper = ToClient_getEquipmentItem(itemSSW:getEquipSlotNo())
    end
    if nil ~= equipItemWrapper and not servantItem then
      self:setTooltip(self._EQUIPTOOLTIP, equipItemWrapper, false, true)
    end
  end
  if slot.icon:getParent():IsUISubApp() then
    self:setPosition_UISubApp(slot.icon:getParent())
    self._NORMALTOOLTIP._mainPanel:OpenUISubApp()
    if nil ~= equipItemWrapper then
      self._EQUIPTOOLTIP._mainPanel:OpenUISubApp()
    end
  elseif nil ~= targetX and nil ~= targetY then
    self:setPosition(slot.icon:getParent(), nil, nil, targetX, targetY, false)
  else
    self:setPosition(slot.icon:getParent())
  end
end
function PaGlobal_Tooltip_Control_All:hide()
  if PaGlobal_Tooltip_Control_All._dataObject.isSkill then
    Panel_SkillTooltip_Hide()
    return
  end
  if PaGlobalFunc_Tooltip_Item_All_GetShow() then
    PaGlobalFunc_Tooltip_Item_All_Close()
    self._dataObject.currentSlotNo = -1
  end
  if PaGlobalFunc_Tooltip_Item_Equip_All_GetShow() then
    PaGlobalFunc_Tooltip_Item_Equip_All_Close()
    self._dataObject.currentSlotNo = -1
  end
  if PaGlobalFunc_Tooltip_Item_LinkedItem_All_GetShow() then
    PaGlobalFunc_Tooltip_Item_LinkedItem_All_Close()
    self._dataObject.currentSlotNo = -1
  end
  self._firstTradeInfoData = nil
  self._secondTradeInfoData = nil
end
function PaGlobal_Tooltip_Control_All:setDataObject(slotNo, slotType, isOn, isNormal, index)
  self._dataObject.itemMarket = nil
  self._dataObject.inventory = nil
  if true ~= isOn then
    if self._dataObject.currentSlotNo == slotNo then
      PaGlobalFunc_Tooltip_Control_All_Hide()
      self._dataObject.currentSlotNo = -1
      self._dataObject.currentSlotType = ""
      self._dataObject.index = -1
    end
    return false
  end
  if slotNo < 0 then
    return false
  end
  PaGlobalFunc_Tooltip_Control_All_Hide()
  self._dataObject.currentSlotNo = slotNo
  self._dataObject.currentSlotType = slotType
  self._dataObject.index = index
  self._dataObject.isNormal = isNormal
  self._NORMALTOOLTIP.deltaTime = 0
  self._EQUIPTOOLTIP.deltaTime = 0
  local slot = self._dataObject.slotData[slotType][slotNo]
  if nil == slot then
    return false
  end
  if nil ~= slot._type and (__eRewardExp == slot._type or __eRewardSkillExp == slot._type or __eRewardLifeExp == slot._type) then
    return false
  end
  return true
end
function PaGlobal_Tooltip_Control_All:setTooltip(target, itemWrapper, isSSW, isItemWrapper, chattingLinkedItem, index, isNextEnchantInfo, invenSlotNo, itemNamingStr)
  audioPostEvent_SystemUi(1, 13)
  _AudioPostEvent_SystemUiForXBOX(1, 13)
  target._mainPanel:SetShow(true, false)
  local ret, ret2 = self:setTooltipInfo(target, itemWrapper, isSSW, isItemWrapper, chattingLinkedItem, index, isNextEnchantInfo, invenSlotNo, itemNamingStr)
  return ret, ret2
end
function PaGlobal_Tooltip_Control_All:getItemNormalInfo(slotNo, slotType, index)
  local slot = self._dataObject.slotData[slotType][slotNo]
  local parent = false
  local inven = false
  local actorKey, itemWrapper
  local isEquipOn = false
  local isServantEquipOn = false
  local deliveryItemNo
  if "servant_inventory" == slotType then
    if true == _ContentsGroup_RenewUI_InventoryEquip then
      actorKey = PaGlobalFunc_InventoryInfo_GetServantActorKey()
    else
      actorKey = ServantInventory_GetActorKeyRawFromIndex(0)
    end
    if slotNo >= getServantInventorySize(actorKey) then
      return
    end
    parent = true
  elseif "servant_inventoryView" == slotType then
    if true == _ContentsGroup_OceanCurrent and true == _ContentsGroup_Sailor and true == Panel_Window_ShipInfo_All:GetShow() then
      actorKey = PaGlobal_ShipInfo_All._actorKeyRaw
    elseif true == _ContentsGroup_NewUI_ServantInfo_All and true == PaGlobal_VehicleInfo_All_GetPanelShow() then
      actorKey = PaGlobal_VehicleInfo_All_GetActorKeyRaw()
    end
    if slotNo >= getServantInventorySize(actorKey) then
      return
    end
    parent = true
  elseif "inventory" == slotType then
    self._dataObject.inventory = true
    local selfPlayerWrapper = getSelfPlayer()
    if nil == selfPlayerWrapper then
      return
    end
    local selfPlayer = selfPlayerWrapper:get()
    if nil == selfPlayer then
      return
    end
    local inventory = Inventory_GetCurrentInventory()
    local inventorySlotNo = slotNo + inventorySlotNoUserStart()
    if true == _ContentsGroup_NewUI_Inventory_All then
      inventorySlotNo = inventorySlotNo + PaGlobalFunc_Inventory_All_GetStartIndex()
      self._clothBagSlotNo = PaGlobalFunc_Inventory_All_GetInventorySlotNoByNotSorted(slotNo)
    else
      inventorySlotNo = inventorySlotNo + Inventory_GetStartIndex() - 1
      self._clothBagSlotNo = Global_GetInventorySlotNoByNotSorted(slotNo)
    end
    if inventorySlotNo >= inventory:sizeXXX() then
      return
    end
    parent = true
    inven = true
  elseif "Auction" == slotType then
    local myAuctionInfo = RequestGetAuctionInfo()
    local auctionType = myAuctionInfo:getAuctionType()
    local itemCount = 0
    if auctionType == 0 then
      itemCount = myAuctionInfo:getItemAuctionListCount()
    elseif auctionType == 4 then
      itemCount = myAuctionInfo:getMySellingItemAuctionCount()
    elseif auctionType == 6 then
      itemCount = myAuctionInfo:getMyItemBidListCount()
    end
    if slotNo > itemCount then
      return
    end
  end
  if "servant_inventory" == slotType then
    if true == _ContentsGroup_RenewUI_InventoryEquip then
      actorKey = PaGlobalFunc_InventoryInfo_GetServantActorKey()
    else
      actorKey = ServantInventory_GetActorKeyRawFromIndex(index)
    end
    itemWrapper = getServantInventoryItemBySlotNo(actorKey, slotNo)
    inven = true
  elseif "servant_inventoryView" == slotType then
    if true == _ContentsGroup_OceanCurrent and true == _ContentsGroup_Sailor and true == Panel_Window_ShipInfo_All:GetShow() then
      actorKey = PaGlobal_ShipInfo_All._actorKeyRaw
    end
    itemWrapper = getServantInventoryItemBySlotNo(actorKey, slotNo)
    inven = true
  elseif "QuickSlot" == slotType then
    local quickSlotInfo = getQuickSlotItem(slotNo)
    if nil == quickSlotInfo then
      return
    end
    local selfPlayerWrapper = getSelfPlayer()
    if nil == selfPlayerWrapper then
      return
    end
    local selfPlayer = selfPlayerWrapper:get()
    if nil == selfPlayer then
      return
    end
    local whereType = QuickSlot_GetInventoryTypeFrom(quickSlotInfo._type)
    local inventory = selfPlayer:getInventoryByType(whereType)
    local invenSlotNo = inventory:getSlot(quickSlotInfo._itemKey)
    if invenSlotNo >= inventory:sizeXXX() then
      return
    end
    itemWrapper = getInventoryItemByType(whereType, invenSlotNo)
    if CppEnums.ContentsEventType.ContentsType_InventoryBag == itemWrapper:getStaticStatus():get():getContentsEventType() then
      invenSlotNo = ToClient_GetItemNoByInventory(whereType, quickSlotInfo._itemNo_s64)
      itemWrapper = getInventoryItemByType(whereType, invenSlotNo)
      self._clothBagSlotNo = invenSlotNo
    end
  elseif "betterItemList" == slotType then
    itemWrapper = PaGlobal_BetterEquipment_GetItemWrapper(slotNo)
  elseif "inventory" == slotType then
    if true == _ContentsGroup_NewUI_Inventory_All then
      itemWrapper = PaGlobalFunc_Inventory_All_GetToopTipItem()
    else
      itemWrapper = Inventory_GetToopTipItem()
    end
  elseif "Enchant" == slotType then
    if true == _ContentsGroup_NewUI_SpiritEnchant_All then
      itemWrapper = PaGlobalFunc_SpiritEnchant_All_GetItemWrapper()
    elseif 0 == slotNo then
      itemWrapper = PaGlobal_Enchant:enchantItem_ToItemWrapper()
    else
      itemWrapper = PaGlobal_Enchant:enchantItem_FromItemWrapper()
    end
  elseif "SocketItem" == slotType then
    itemWrapper = getInventoryItemByType(slot.whereType, slot.slotNo)
    isEquipOn = true
  elseif "WareHouse" == slotType then
    if _ContentsGroup_NewUI_WareHouse_All then
      itemWrapper = PaGlobal_Warehouse_All_GetToopTipItem()
    else
      itemWrapper = Warehouse_GetToopTipItem()
    end
    if itemWrapper and CppEnums.ContentsEventType.ContentsType_InventoryBag == itemWrapper:getStaticStatus():get():getContentsEventType() then
      if _ContentsGroup_NewUI_WareHouse_All then
        self._clothBagSlotNo = PaGlobal_Warehouse_All_GetToolTipItemSlotNo()
      else
        self._clothBagSlotNo = FGlobal_Warehouse_GetToolTipItemSlotNo()
      end
    end
    parent = true
    inven = true
  elseif "CargoLoadingWarehouse" == slotType then
    itemWrapper = PaGlobal_CargoLoadding_GetTooltipWareHouseItem(slotNo)
  elseif "CargoLoadingServant" == slotType then
    itemWrapper = PaGlobal_CargoLoading_GetTooltipServantItem(slotNo)
  elseif "looting" == slotType then
    itemWrapper = looting_getItem(slotNo)
  elseif "equipment" == slotType then
    itemWrapper = ToClient_getEquipmentItem(slotNo)
    self._equipItemLock.equipment = true
    self._equipItemLock.itemLock = ToClient_EquipSlot_CheckItemLock(slotNo, 1)
    isEquipOn = true
    parent = true
    inven = true
  elseif "disassemble_source" == slotType then
    itemWrapper = disassemble_GetSourceItem(slotNo)
  elseif "disassemble_result" == slotType then
    itemWrapper = disassemble_GetResultItem(slotNo)
  elseif "product_recipe" == slotType then
    itemWrapper = product_GetRecipeItem(0)
  elseif "product_result" == slotType then
    itemWrapper = product_GetResultItem(slotNo)
  elseif "ServantEquipment" == slotType then
    if true == _ContentsGroup_NewUI_ServantInfo_All then
      actorKey = PaGlobal_VehicleInfo_All_GetActorKeyRaw()
    elseif true == _ContentsGroup_RenewUI_InventoryEquip then
      actorKey = PaGlobalFunc_InventoryInfo_GetServantActorKey()
    else
      actorKey = Servant_GetActorKeyFromItemToolTip()
    end
    local servantWrapper = getServantInfoFromActorKey(actorKey)
    if nil ~= servantWrapper then
      itemWrapper = servantWrapper:getEquipItem(slotNo)
    end
    isEquipOn = true
    isServantEquipOn = false
  elseif "ServantShipEquipment" == slotType then
    if true == _ContentsGroup_OceanCurrent and true == _ContentsGroup_Sailor and true == Panel_Window_ShipInfo_All:GetShow() then
      actorKey = PaGlobal_ShipInfo_All._actorKeyRaw
    elseif true == _ContentsGroup_OceanCurrent and Panel_Window_ShipEquipManagement_ALL:GetShow() then
      actorKey = PaGlobal_ShipEquipManagement_GetActorKey()
    elseif true == _ContentsGroup_NewUI_ServantInfo_All then
      actorKey = PaGlobal_VehicleInfo_All_GetActorKeyRaw()
    elseif true == _ContentsGroup_RenewUI_InventoryEquip then
      actorKey = PaGlobalFunc_InventoryInfo_GetServantActorKey()
    else
      actorKey = Servant_GetActorKeyFromItemToolTip()
    end
    local servantWrapper = getServantInfoFromActorKey(actorKey)
    if nil ~= servantWrapper then
      itemWrapper = servantWrapper:getEquipItem(slotNo)
    end
    isEquipOn = true
    isServantEquipOn = true
  elseif "StableEquipment" == slotType then
    local servantInfo = stable_getServant(StableList_SelectSlotNo())
    if nil ~= servantInfo then
      itemWrapper = servantInfo:getEquipItem(slotNo)
    end
  elseif "LinkedHorseEquip" == slotType then
    local servantInfo
    if true == _ContentsGroup_NewUI_ServantInfo_All then
      actorKey = PaGlobal_VehicleInfo_All_GetActorKeyRaw()
      servantInfo = PaGlobal_LinkedSkill_All_GetServantInfo()
    else
      if true == _ContentsGroup_RenewUI_InventoryEquip then
        actorKey = PaGlobalFunc_InventoryInfo_GetServantActorKey()
      else
        actorKey = Servant_GetActorKeyFromItemToolTip()
      end
      local servantWrapper = getServantInfoFromActorKey(actorKey)
      servantInfo = stable_getServantFromOwnerServant(servantWrapper:getServantNo(), FGlobal_LinkedHorse_SelectedIndex())
    end
    if nil ~= servantInfo then
      itemWrapper = servantInfo:getEquipItem(slotNo)
    end
  elseif "exchangeOther" == slotType then
    itemWrapper = tradePC_GetOtherItem(slotNo)
  elseif "tradeMarket_Sell" == slotType then
    itemWrapper = npcShop_getItemWrapperByShopSlotNo(slotNo)
  elseif "tradeMarket_VehicleSell" == slotType then
    itemWrapper = npcShop_getVehicleItemWrapper(slotNo)
  elseif "tradeMarket_ShipSell" == slotType then
    itemWrapper = npcShop_getShipItemWrapper(slotNo)
  elseif "exchangeSelf" == slotType then
    itemWrapper = tradePC_GetMyItem(slotNo)
  elseif "DeliveryInformation" == slotType then
    local deliverySlotNo = DeliveryInformation_SlotIndex(slotNo)
    local deliveryList = delivery_list(DeliveryInformation_WaypointKey())
    if nil ~= deliveryList and deliverySlotNo < deliveryList:size() then
      local deliveryInfo = deliveryList:atPointer(deliverySlotNo)
      if nil ~= deliveryInfo then
        itemWrapper = deliveryInfo:getItemWrapper(deliverySlotNo)
      end
    end
  elseif "DeliveryCarriageInformation" == slotType then
    local deliverySlotNo = DeliveryCarriageInformation_SlotIndex(slotNo)
    local deliveryList = deliveryCarriage_dlieveryList(DeliveryCarriageInformation_ObjectID())
    if nil ~= deliveryList and deliverySlotNo < deliveryList:size() then
      local deliveryInfo = deliveryList:atPointer(deliverySlotNo)
      if nil ~= deliveryInfo then
        itemWrapper = deliveryInfo:getItemWrapper(deliverySlotNo)
        deliveryItemNo = deliveryInfo:getItemNo()
      end
    end
  elseif "DeliveryRequest" == slotType then
    if true == _ContentsGroup_NewDelivery then
      itemWrapper = ToClient_NewDeliveryGetPackItemBySlotNo(slotNo)
    else
      itemWrapper = delivery_packItem(slotNo)
    end
  elseif "Auction" == slotType then
    local myAuctionInfo = RequestGetAuctionInfo()
    local auctionType = myAuctionInfo:getAuctionType()
    local itemAuctionData
    if auctionType == 0 then
      itemAuctionData = myAuctionInfo:getItemAuctionListAt(slotNo - 1)
    elseif auctionType == 4 then
      itemAuctionData = myAuctionInfo:getMySellingItemAuctionAt(slotNo - 1)
    elseif auctionType == 6 then
      itemAuctionData = myAuctionInfo:getMyItemBidListAt(slotNo - 1)
    end
    if nil ~= itemAuctionData then
      itemWrapper = itemAuctionData:getItem()
    end
  elseif "AuctionRegister" == slotType then
    slotNo = Auction_GetSeletedItemSlot()
    if -1 ~= slotNo then
      itemWrapper = getInventoryItem(slotNo)
    end
  elseif "Socket" == slotType then
    slotNo = Socket_GetSlotNo()
    if -1 ~= slotNo then
      itemWrapper = getInventoryItem(slotNo)
    end
  elseif "HousingMode" == slotType then
    local realSlotNo = Panel_Housing_SlotNo(slotNo)
    if -1 ~= realSlotNo then
      itemWrapper = getInventoryItem(realSlotNo)
    end
  elseif "FixEquip" == slotType then
    local slotNumber = 0
    if slotNo == 0 then
      slotNumber = PaGlobal_FixEquip:fixEquip_GetMainSlotNo()
      if nil ~= slotNumber then
        itemWrapper = getInventoryItem(slotNumber)
      end
    else
      slotNumber = PaGlobal_FixEquip:fixEquip_GetSubSlotNo()
      if nil ~= slotNumber then
        itemWrapper = getInventoryItem(slotNumber)
      end
    end
  elseif "DailyStamp" == slotType then
    itemWrapper = ToClient_getRewardItem(slotNo)
  elseif "clothExtraction" == slotType then
    local isWhereType = Inventory_GetCurrentInventoryType()
    if CppEnums.ItemWhereType.eInventory == isWhereType then
      itemWrapper = getInventoryItem(slotNo)
    elseif CppEnums.ItemWhereType.eCashInventory == isWhereType then
      itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, slotNo)
    end
  elseif "CampEquip" == slotType then
    local actorKeyRaw
    if true == _ContentsGroup_NewUI_Camp_All then
      actorKeyRaw = PaGlobalFunc_Camp_All_GetActorKeyRaw()
    else
      actorKeyRaw = PaGlobal_Camp:getActorKeyRaw()
    end
    local servantWrapper = getServantInfoFromActorKey(actorKeyRaw)
    if nil ~= servantWrapper then
      itemWrapper = servantWrapper:getEquipItem(slotNo)
    end
    if nil ~= itemWrapper then
      isEquipOn = true
      isServantEquipOn = true
    end
  elseif "ShipEquipManagementInventory" == slotType then
    itemWrapper = PaGlobal_ShipEquipManagement_GetInventoryItem(slotNo)
  else
    UI.ASSERT(false, "showTooltip(normal)\236\156\188\235\161\156 \236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 slot\237\131\128\236\158\133(" .. slotType .. ")\236\157\180 \235\147\164\236\150\180\236\153\148\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148.")
    return
  end
  local itemInfo = {
    parent = parent,
    inven = inven,
    actorKey = actorKey,
    isEquipOn = isEquipOn,
    isServantEquipOn = isServantEquipOn,
    deliveryItemNo = deliveryItemNo,
    itemWrapper = itemWrapper
  }
  return itemInfo
end
function PaGlobal_Tooltip_Control_All:getItemStaticInfo(slotNo, slotType, index)
  local slot = self._dataObject.slotData[slotType][slotNo]
  local isSSW = true
  local isItemWrapper = false
  local inven = false
  local parent = false
  local itemSSW
  if "QuestReward_Base" == slotType or "QuestReward_Select" == slotType or "Dialog_QuestReward_Base" == slotType or "Dialog_QuestReward_Select" == slotType or "Dialog_GuildQuestReward_Base" == slotType or "Dialog_GuildQuestReward_Money" == slotType or "AccesoryQuest_Base" == slotType or "betterItemList" == slotType or "totalReward" == slotType then
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(slot._item))
  elseif "shop" == slotType then
    if true == _ContentsGroup_NewUI_NpcShop_All and nil ~= Panel_Dialog_NPCShop_All then
      local currentTabIdx = PaGlobalFunc_NPCShop_ALL_GetCurrentTabIndex()
      if nil ~= currentTabIdx then
        local shopItemWrapper
        if 0 == currentTabIdx or nil == currentTabIdx then
          shopItemWrapper = npcShop_getItemBuy(slotNo)
          if nil ~= shopItemWrapper then
            itemSSW = shopItemWrapper:getStaticStatus()
          end
        elseif 1 == currentTabIdx then
          itemSSW = npcShop_getItemWrapperByShopSlotNo(slotNo)
          isSSW = false
        else
          itemSSW = npcShop_getItemRepurchaseForToolTip(slotNo)
          isItemWrapper = true
          isSSW = false
        end
        inven = true
        parent = true
      end
    elseif true == _ContentsGroup_RenewUI_NpcShop then
      local NPCShopInfo = PaGlobalFunc_Dialog_NPCShop_GetNPCShop()
      local shopItemWrapper
      if 0 == NPCShopInfo._value.lastTabIndex or nil == NPCShopInfo._value.lastTabIndex then
        shopItemWrapper = npcShop_getItemBuy(slotNo)
        if nil ~= shopItemWrapper then
          itemSSW = shopItemWrapper:getStaticStatus()
        end
      elseif 1 == NPCShopInfo._value.lastTabIndex then
        itemSSW = npcShop_getItemWrapperByShopSlotNo(slotNo)
        isSSW = false
      else
        itemSSW = npcShop_getItemRepurchaseForToolTip(slotNo)
        isItemWrapper = true
        isSSW = false
      end
      inven = true
      parent = true
    else
      local shopItemWrapper
      if 0 == Panel_Window_NpcShop.npcShop.lastTabIndex or nil == Panel_Window_NpcShop.npcShop.lastTabIndex then
        shopItemWrapper = npcShop_getItemBuy(slotNo)
        if nil ~= shopItemWrapper then
          itemSSW = shopItemWrapper:getStaticStatus()
        end
      elseif 1 == Panel_Window_NpcShop.npcShop.lastTabIndex then
        itemSSW = npcShop_getItemWrapperByShopSlotNo(slotNo)
        isSSW = false
      else
        itemSSW = npcShop_getItemRepurchaseForToolTip(slotNo)
        isItemWrapper = true
        isSSW = false
      end
      inven = true
      parent = true
    end
  elseif "workListMilibogi" == slotType then
    itemSSW = HouseControl_getItemStaticStatusByIndex(slotNo)
  elseif "tradeMarket" == slotType then
    itemSSW = global_TradeMarketGraph_StaticStatus(slotNo)
  elseif "tradeMarket_Buy" == slotType then
    itemSSW = npcShop_getItemBuy(slotNo):getStaticStatus()
  elseif "tradeSupply" == slotType then
    local shopItemWrapper = ToClient_worldmap_getTradeSupplyItem(TradeNpcItemInfo_getTerritoryKey(), slotNo - 1)
    if nil ~= shopItemWrapper then
      itemSSW = shopItemWrapper:getStaticStatus()
    end
  elseif "tradeEventInfo" == slotType then
    local shopItemWrapper = ToClient_worldmap_getTradeSupplyItem(index, slotNo)
    if nil ~= shopItemWrapper then
      itemSSW = shopItemWrapper:getStaticStatus()
    end
  elseif "product_source" == slotType then
    local informationWrapper = product_GetSourceItem(slotNo)
    if nil ~= informationWrapper then
      itemSSW = informationWrapper:getStaticStatus()
      if nil ~= itemSSW then
        showTooltip_Item(normalTooltip, itemSSW, true, false)
      end
    end
  elseif "Socket_Insert" == slotType then
    local mainSlotNo = Socket_GetSlotNo()
    local invenItemWrapper = getInventoryItem(mainSlotNo)
    if nil ~= invenItemWrapper then
      itemSSW = invenItemWrapper:getPushedItem(slotNo - 1)
    end
  elseif "Socket_InsertExtraction" == slotType then
    local mainSlotNo = Socket_GetExtractionSlotNo()
    local invenItemWrapper = getInventoryItem(mainSlotNo)
    if nil ~= invenItemWrapper then
      itemSSW = invenItemWrapper:getPushedItem(slotNo - 1)
    end
  elseif "popupItem" == slotType then
    local ESSWrapper
    if false == _ContentsGroup_NewUI_UseItem_All then
      ESSWrapper = getPopupIteWrapper()
    else
      ESSWrapper = PaGlobal_UseItem_All_GetPopupItemWrapper()
    end
    if nil ~= ESSWrapper then
      itemSSW = ESSWrapper:getPopupItemAt(slotNo - 1)
    end
  elseif "TerritoryAuth_Auction" == slotType then
    local myAuctionInfo = RequestGetAuctionInfo()
    itemSSW = myAuctionInfo:getTerritoryTradeitem(slotNo)
  elseif "Dialog_ChallengeReward_Base" == slotType or "Dialog_ChallengeReward_Select" == slotType then
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(slot._item))
  elseif "Dialog_ChallengePcroomReward_Base" == slotType or "Dialog_ChallengePcroomReward_Select" == slotType then
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(slot._item))
  elseif "DailyStamp" == slotType then
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(slotNo))
  elseif "masterpiecdAuction" == slotType then
    local myAuctionInfo = RequestGetAuctionInfo()
    local goodsInfo
    if CppEnums.AuctionTabType.AuctionTab_SellItem == index then
      goodsInfo = myAuctionInfo:getItemAuctionListAt(slotNo)
    elseif CppEnums.AuctionTabType.AuctionTab_MySellPage == index then
      goodsInfo = myAuctionInfo:getMySellingItemAuctionAt(slotNo)
    elseif CppEnums.AuctionTabType.AuctionTab_MyBidPage == index then
      goodsInfo = myAuctionInfo:getMyItemBidListAt(slotNo)
    end
    if nil == goodsInfo then
      return
    end
    local itemWrapper = goodsInfo:getItem()
    itemSSW = itemWrapper:getStaticStatus()
  else
    UI.ASSERT(false, "showTooltip(static)\236\156\188\235\161\156 \236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 slot\237\131\128\236\158\133(" .. slotType .. ")\236\157\180 \235\147\164\236\150\180\236\153\148\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148.")
    return
  end
  local itemInfo = {
    parent = parent,
    inven = inven,
    isItemWrapper = isItemWrapper,
    isSSW = isSSW,
    itemSSW = itemSSW
  }
  return itemInfo
end
function PaGlobal_Tooltip_Control_All:getItemName(slotNo, slotType, isEquipOn, actorKey, DeliveryItemNo, slotNumber)
  if nil == slotNo or nil == slotType then
    return
  end
  local itemNamingStr, actorKey
  if isEquipOn and "SocketItem" ~= slotType then
    itemNamingStr = getItemNaming(getTItemNoBySlotNo(slotNo, true))
  elseif "Enchant" == slotType then
    if true == _ContentsGroup_NewUI_SpiritEnchant_All then
      itemNamingStr = getItemNaming(PaGlobalFunc_SpiritEnchant_All_GetItemWrapper())
    else
      itemNamingStr = getItemNaming(PaGlobal_Enchant:enchantItem_ToItemNo())
    end
  elseif "WareHouse" == slotType then
    local warehouseItemNo
    if _ContentsGroup_NewUI_WareHouse_All then
      warehouseItemNo = PaGlobal_Warehouse_All_GetToolTipItemNo()
    else
      warehouseItemNo = Warehouse_GetToolTipItemNo()
    end
    if nil ~= warehouseItemNo then
      itemNamingStr = getItemNaming(warehouseItemNo)
    end
  elseif "servant_inventory" == slotType then
    if true == _ContentsGroup_RenewUI_InventoryEquip then
      actorKey = PaGlobalFunc_InventoryInfo_GetServantActorKey()
    else
      actorKey = ServantInventory_GetActorKeyRawFromIndex(index)
    end
    itemNamingStr = getItemNaming(servantInventory_getItemNoBySlotNo(actorKey, slotNo))
  elseif "servant_inventoryView" == slotType then
    if true == _ContentsGroup_OceanCurrent and true == _ContentsGroup_Sailor and true == Panel_Window_ShipInfo_All:GetShow() then
      actorKey = PaGlobal_ShipInfo_All._actorKeyRaw
    end
    itemNamingStr = getItemNaming(servantInventory_getItemNoBySlotNo(actorKey, slotNo))
  elseif "SocketItem" == slotType then
    itemNamingStr = getItemNaming(getTItemNoBySlotNo(slotNo, false))
  elseif "FixEquip" == slotType then
    slotNumber = PaGlobal_FixEquip:fixEquip_GetMainSlotNo()
    if nil ~= slotNumber then
      itemNamingStr = getItemNaming(getTItemNoBySlotNo(slotNumber, false))
    end
  elseif "DeliveryRequest" == slotType then
    if true == _ContentsGroup_NewDelivery then
      itemNamingStr = getItemNaming(ToClient_NewDeliveryGetPackItemNoBySlotNo(slotNo))
    else
      itemNamingStr = getItemNaming(delivery_packItemNoByIndex(slotNo))
    end
  elseif "DeliveryCarriageInformation" == slotType then
    if nil ~= DeliveryItemNo then
      itemNamingStr = getItemNaming(DeliveryItemNo)
    end
  else
    local realSlotNo
    if true == _ContentsGroup_NewUI_Inventory_All then
      realSlotNo = PaGlobalFunc_Inventory_All_GetRealSlotNo(slotNo)
    else
      realSlotNo = getInventory_RealSlotNo(slotNo)
    end
    itemNamingStr = getItemNaming(getTItemNoBySlotNo(realSlotNo, false))
  end
  return itemNamingStr
end
function PaGlobal_Tooltip_Control_All:initPanel(panel, target)
  panel:SetShow(false, false)
  panel:setMaskingChild(true)
  panel:SetIgnore(true)
  panel:SetIgnoreChild(true)
  panel:setGlassBackground(true)
  self:initControl(target)
end
function PaGlobal_Tooltip_Control_All:initControl(target)
  if nil == target then
    UI.ASSERT(false, "PaGlobal_Tooltip_Control_All:setTextWrap(target) , target nil")
    return
  end
  self:setTextWrap(target._ui.txt_itemType)
  self:setTextWrap(target._ui.txt_maxEnchanter)
  self:setTextWrap(target._ui.txt_isEnchantable)
  self:setTextWrap(target._ui.txt_isRepair)
  self:setTextWrap(target._ui.txt_isSealed)
  self:setTextWrap(target._ui.txt_useLimit_category)
  self:setTextWrap(target._ui.txt_useLimit_level)
  self:setTextWrap(target._ui.txt_useLimit_extendedslot)
  self:setTextWrap(target._ui.txt_useLimit_extendedslot_value)
  self:setTextWrap(target._ui.txt_useLimit_class)
  self:setTextWrap(target._ui.txt_useLimit_class_value)
  self:setTextWrap(target._ui.txt_useLimit_exp)
  self:setTextWrap(target._ui.txt_useLimit_exp_value)
  self:setTextWrap(target._ui.txt_useLimit_endurance)
  self:setTextWrap(target._ui.txt_useLimit_endurance_value)
  self:setTextWrap(target._ui.txt_remainTime)
  self:setTextWrap(target._ui.txt_remainTime_value)
  self:setTextWrap(target._ui.txt_defaultEffect_category)
  self:setTextWrap(target._ui.txt_attack)
  self:setTextWrap(target._ui.txt_attack_value)
  self:setTextWrap(target._ui.txt_attack_diffValue)
  self:setTextWrap(target._ui.txt_statExtraParam1)
  self:setTextWrap(target._ui.txt_statExtraParam1_value)
  self:setTextWrap(target._ui.txt_statExtraParam1_diffValue)
  self:setTextWrap(target._ui.txt_statExtraParam2)
  self:setTextWrap(target._ui.txt_statExtraParam2_value)
  self:setTextWrap(target._ui.txt_statExtraParam2_diffValue)
  self:setTextWrap(target._ui.txt_statExtraParam3)
  self:setTextWrap(target._ui.txt_statExtraParam3_value)
  self:setTextWrap(target._ui.txt_statExtraParam3_diffValue)
  self:setTextWrap(target._ui.txt_defense)
  self:setTextWrap(target._ui.txt_defense_value)
  self:setTextWrap(target._ui.txt_defense_diffValue)
  self:setTextWrap(target._ui.txt_hit)
  self:setTextWrap(target._ui.txt_hit_value)
  self:setTextWrap(target._ui.txt_hit_diffValue)
  self:setTextWrap(target._ui.txt_dv)
  self:setTextWrap(target._ui.txt_dv_value)
  self:setTextWrap(target._ui.txt_dv_diffValue)
  self:setTextWrap(target._ui.txt_pv)
  self:setTextWrap(target._ui.txt_pv_value)
  self:setTextWrap(target._ui.txt_pv_diffValue)
  self:setTextWrap(target._ui.txt_weight)
  self:setTextWrap(target._ui.txt_weight_value)
  self:setTextWrap(target._ui.txt_weight_diffValue)
  self:setTextWrap(target._ui.txt_itemProducedPlace)
  self:setTextWrap(target._ui.txt_itemDescription)
  self:setTextWrap(target._ui.txt_tradeInfo_title)
  self:setTextWrap(target._ui.txt_tradeInfo_value)
  self:setTextWrap(target._ui.txt_equipSlotName)
  self:setTextWrap(target._ui.txt_exchangeDesc)
  self:setTextWrap(target._ui.txt_productNotify)
  self:setTextWrap(target._ui.txt_itemLockNotify)
  self:setTextWrap(target._ui.txt_isItemLock)
  self:setTextWrap(target._ui.txt_recoveryDesc)
  self:setTextWrap(target._ui.txt_supplyValue)
  for idx = 1, 6 do
    self:setTextWrap(target._ui.txt_soketName[idx])
    self:setTextWrap(target._ui.txt_soketEffect[idx])
  end
end
function PaGlobal_Tooltip_Control_All:setTextWrap(control)
  if nil == control then
    return
  end
  control:SetTextMode(__eTextMode_AutoWrap)
  control:SetAutoResize(true)
end
function PaGlobal_Tooltip_Control_All:setPosition(positionData, parent, inven, targetX, targetY, absolutLeft)
  local itemShow = PaGlobalFunc_Tooltip_Item_All_GetShow()
  local equipItemShow = PaGlobalFunc_Tooltip_Item_Equip_All_GetShow()
  if not itemShow and not equipItemShow then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local itemPosX = self._NORMALTOOLTIP._mainPanel:GetSizeX()
  local itemPosY = self._NORMALTOOLTIP._mainPanel:GetSizeY()
  local itemEquipPosX = self._EQUIPTOOLTIP._mainPanel:GetSizeX()
  local itemEquipPosY = self._EQUIPTOOLTIP._mainPanel:GetSizeY()
  local posX = positionData:GetParentPosX()
  local posY = positionData:GetParentPosY()
  if parent and inven then
    if equipItemShow and not itemShow then
      posX = positionData:getParent():getParent():GetParentPosX()
      posY = positionData:getParent():getParent():GetParentPosY() + 10
    else
      posX = positionData:getParent():GetParentPosX() + 0
      posY = positionData:getParent():GetParentPosY() + 10
    end
  elseif parent then
    posX = positionData:getParent():GetParentPosX()
    posY = positionData:getParent():GetParentPosY() - 500
  end
  local isLeft = posX > screenSizeX / 2
  local isTop = posY > screenSizeY / 2
  if nil ~= targetX and nil ~= targetY then
    isLeft = targetX > screenSizeX / 2
    isTop = targetY > screenSizeY / 2
  end
  if nil ~= absolutLeft then
    isLeft = absolutLeft
  end
  local tooltipSize = {width = 0, height = 0}
  local tooltipEquipped = {width = 0, height = 0}
  local sumSize = {width = 0, height = 0}
  if itemShow then
    tooltipSize.width = self._NORMALTOOLTIP._mainPanel:GetSizeX()
    tooltipSize.height = self._NORMALTOOLTIP._mainPanel:GetSizeY()
    sumSize.width = sumSize.width + tooltipSize.width
    sumSize.height = math.max(sumSize.height, tooltipSize.height)
  end
  if equipItemShow then
    tooltipEquipped.width = self._EQUIPTOOLTIP._mainPanel:GetSizeX()
    tooltipEquipped.height = self._EQUIPTOOLTIP._mainPanel:GetSizeY()
    sumSize.width = sumSize.width + tooltipEquipped.width
    sumSize.height = math.max(sumSize.height, tooltipEquipped.height)
  end
  if not isLeft then
    if parent and inven then
      if equipItemShow and not itemShow then
        posX = positionData:getParent():getParent():GetParentPosX() + positionData:getParent():getParent():GetSizeX()
      else
        posX = positionData:getParent():GetParentPosX() + positionData:getParent():GetSizeX()
      end
    else
      posX = posX + positionData:GetSizeX()
    end
  end
  if isTop then
    posY = posY + positionData:GetSizeY()
    local yDiff = posY - sumSize.height
    if yDiff < 0 then
      posY = posY - yDiff
    end
  else
    local yDiff = screenSizeY - (posY + sumSize.height)
    if yDiff < 0 then
      posY = posY + yDiff
    end
  end
  if nil ~= targetX and nil ~= targetY then
    posX, posY = targetX, targetY
  end
  if itemShow then
    if isLeft then
      posX = posX - tooltipSize.width
    end
    local yTmp = posY
    if isTop then
      yTmp = yTmp - tooltipSize.height
    end
    self._NORMALTOOLTIP._mainPanel:SetPosX(posX)
    self._NORMALTOOLTIP._mainPanel:SetPosY(yTmp)
  end
  if equipItemShow then
    if isLeft then
      posX = posX - tooltipEquipped.width
    else
      posX = posX + tooltipSize.width
    end
    local yTmp = posY
    if isTop then
      yTmp = yTmp - tooltipEquipped.height
    end
    self._EQUIPTOOLTIP._mainPanel:SetPosX(posX)
    self._EQUIPTOOLTIP._mainPanel:SetPosY(yTmp)
  end
  if itemShow and equipItemShow then
    local arrow = self._EQUIPTOOLTIP._ui.stc_arrow
    if self._NORMALTOOLTIP._mainPanel:GetPosX() < self._EQUIPTOOLTIP._mainPanel:GetPosX() then
      self._EQUIPTOOLTIP._ui.stc_arrow:SetShow(false)
      arrow = self._EQUIPTOOLTIP._ui.stc_arrow_L
      arrow:SetShow(true)
      arrow:SetPosY(self._EQUIPTOOLTIP._ui.stc_itemIcon:GetPosY())
      arrow:SetPosX(-arrow:GetSizeX() / 2)
    else
      self._EQUIPTOOLTIP._ui.stc_arrow_L:SetShow(false)
      arrow = self._EQUIPTOOLTIP._ui.stc_arrow
      arrow:SetShow(true)
      arrow:SetPosY(self._EQUIPTOOLTIP._ui.stc_itemIcon:GetPosY())
      arrow:SetPosX(self._EQUIPTOOLTIP._mainPanel:GetSizeX() - arrow:GetSizeX() / 2)
    end
  else
    self._EQUIPTOOLTIP._ui.stc_arrow:SetShow(false)
    self._EQUIPTOOLTIP._ui.stc_arrow_L:SetShow(false)
  end
end
function PaGlobal_Tooltip_Control_All:setPosition_UISubApp(positionData, parent, inven)
  local itemShow = PaGlobalFunc_Tooltip_Item_All_GetShow()
  local equipItemShow = PaGlobalFunc_Tooltip_Item_Equip_All_GetShow()
  if not itemShow and not equipItemShow then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local posX = positionData:GetScreenParentPosX()
  local posY = positionData:GetScreenParentPosY()
  if parent and inven then
    if equipItemShow and not itemShow then
      posX = positionData:getParent():getParent():GetScreenParentPosX()
      posY = positionData:getParent():getParent():GetScreenParentPosY() + 10
    else
      posX = positionData:getParent():GetScreenParentPosX()
      posY = positionData:getParent():GetScreenParentPosY() + 10
    end
  elseif parent then
    posX = positionData:getParent():GetScreenParentPosX()
    posY = positionData:getParent():GetScreenParentPosY() - 500
  end
  local isLeft = posX > screenSizeX / 2
  local isTop = posY > screenSizeY / 2
  local tooltipSize = {width = 0, height = 0}
  local tooltipEquipped = {width = 0, height = 0}
  if itemShow then
    tooltipSize.width = self._NORMALTOOLTIP._mainPanel:GetSizeX()
    tooltipSize.height = self._NORMALTOOLTIP._mainPanel:GetSizeY()
  end
  if equipItemShow then
    tooltipEquipped.width = self._EQUIPTOOLTIP._mainPanel:GetSizeX()
    tooltipEquipped.height = self._EQUIPTOOLTIP._mainPanel:GetSizeY()
  end
  if not isLeft then
    if parent and inven then
      if equipItemShow and not itemShow then
        posX = positionData:getParent():getParent():GetSizeX() + posX
      else
        posX = positionData:getParent():GetSizeX() + posX
      end
    elseif nil ~= positionData:getParent() then
      posX = posX + positionData:getParent():GetSizeX() + positionData:GetSizeX()
    else
      posX = posX + positionData:GetSizeX()
    end
  end
  if itemShow then
    if isLeft then
      posX = posX - tooltipSize.width
    end
    local yTmp = posY
    self._NORMALTOOLTIP._mainPanel:SetPosX(posX)
    self._NORMALTOOLTIP._mainPanel:SetPosY(yTmp)
  end
  if equipItemShow then
    if isLeft then
      posX = posX - tooltipEquipped.width
    else
      posX = posX + tooltipSize.width
    end
    local yTmp = posY
    self._EQUIPTOOLTIP._mainPanel:SetPosX(posX)
    self._EQUIPTOOLTIP._mainPanel:SetPosY(yTmp)
  end
  if itemShow and equipItemShow then
    local arrow = self._EQUIPTOOLTIP._ui.stc_arrow
    if self._NORMALTOOLTIP._mainPanel:GetPosX() < self._EQUIPTOOLTIP._mainPanel:GetPosX() then
      self._EQUIPTOOLTIP._ui.stc_arrow:SetShow(false)
      arrow = self._EQUIPTOOLTIP._ui.stc_arrow_L
      arrow:SetShow(true)
      arrow:SetPosY(self._EQUIPTOOLTIP._ui.stc_itemIcon:GetPosY())
      arrow:SetPosX(-arrow:GetSizeX() / 2)
    else
      self._EQUIPTOOLTIP._ui.stc_arrow_L:SetShow(false)
      arrow = self._EQUIPTOOLTIP._ui.stc_arrow
      arrow:SetShow(true)
      arrow:SetPosY(self._EQUIPTOOLTIP._ui.stc_itemIcon:GetPosY())
      arrow:SetPosX(self._EQUIPTOOLTIP._mainPanel:GetSizeX() - arrow:GetSizeX() / 2)
    end
  else
    self._EQUIPTOOLTIP._ui.stc_arrow:SetShow(false)
    self._EQUIPTOOLTIP._ui.stc_arrow_L:SetShow(false)
  end
end
function PaGlobal_Tooltip_Control_All:setPosition_LinkedItem(positionData, isClicked)
  local target
  if isClicked then
    target = Panel_Widget_Tooltip_Item_LinkedClickItem_All
    self._linkItemTooltipParent = positionData
  else
    target = Panel_Widget_Tooltip_Item_LinkedItem_All
  end
  local chattingLinkedItemShow = target:GetShow()
  if not chattingLinkedItemShow then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local itemLinkedPosX = target:GetSizeX()
  local itemLinkedPosY = target:GetSizeY()
  local posX = positionData:GetParentPosX()
  local posY = positionData:GetParentPosY()
  local isLeft = posX > screenSizeX / 2
  local isTop = posY > screenSizeY / 2
  if not isLeft then
    posX = posX + positionData:GetSizeX()
  end
  if isTop then
    posY = posY + positionData:GetSizeY()
    local yDiff = posY - itemLinkedPosY
    if yDiff < 0 then
      posY = posY - yDiff
    end
  else
    local yDiff = screenSizeY - (posY + itemLinkedPosY)
    if yDiff < 0 then
      posY = posY + yDiff
    end
  end
  if isLeft then
    posX = posX - itemLinkedPosX
  end
  local yTmp = posY
  if isTop then
    yTmp = yTmp - itemLinkedPosY
  end
  target:SetPosX(posX)
  target:SetPosY(yTmp)
  if Panel_Widget_Tooltip_Item_LinkedClickItem_All:GetShow() and target ~= Panel_Widget_Tooltip_Item_LinkedClickItem_All then
    if positionData == self._linkItemTooltipParent then
      if isLeft then
        target:SetPosX(posX - Panel_Widget_Tooltip_Item_LinkedClickItem_All:GetSizeX())
      else
        target:SetPosX(posX + Panel_Widget_Tooltip_Item_LinkedClickItem_All:GetSizeX())
      end
    else
      target:SetPosX(posX)
    end
    target:SetPosY(yTmp)
  end
end
function PaGlobal_Tooltip_Control_All:setPanelPosition(control, addX, addY, absoluteLeft, absoluteTop)
  local itemShow = PaGlobalFunc_Tooltip_Item_All_GetShow()
  local equipItemShow = PaGlobalFunc_Tooltip_Item_Equip_All_GetShow()
  if not itemShow and not equipItemShow then
    return
  end
  if nil == control then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local posX = control:GetPosX()
  local posY = control:GetPosY()
  if true == control:IsUISubApp() then
    posX = control:GetScreenParentPosX()
    posY = control:GetScreenParentPosY()
  end
  local isLeft = posX > screenSizeX / 2
  local isTop = posY > screenSizeY / 2
  if nil ~= absoluteLeft then
    isLeft = absoluteLeft
  end
  if nil ~= absoluteTop then
    isTop = absoluteTop
  end
  if nil ~= addX then
    if true == isLeft then
      posX = posX + addX
    else
      posX = posX - addX
    end
  end
  if nil ~= addY then
    posY = posY + addY
  end
  local tooltipSize = {width = 0, height = 0}
  local tooltipEquipped = {width = 0, height = 0}
  local sumSize = {width = 0, height = 0}
  if itemShow then
    tooltipSize.width = self._NORMALTOOLTIP._mainPanel:GetSizeX()
    tooltipSize.height = self._NORMALTOOLTIP._mainPanel:GetSizeY()
    sumSize.width = sumSize.width + tooltipSize.width
    sumSize.height = math.max(sumSize.height, tooltipSize.height)
  end
  if equipItemShow then
    tooltipEquipped.width = self._EQUIPTOOLTIP._mainPanel:GetSizeX()
    tooltipEquipped.height = self._EQUIPTOOLTIP._mainPanel:GetSizeY()
    sumSize.width = sumSize.width + tooltipEquipped.width
    sumSize.height = math.max(sumSize.height, tooltipEquipped.height)
  end
  if false == isLeft then
    posX = posX + control:GetSizeX()
  else
    posX = posX - tooltipSize.width
  end
  if true == isTop then
    posY = posY - sumSize.height
  end
  if posY < 0 then
    posY = 0
  elseif screenSizeY < posY + sumSize.height then
    local gap = posY + sumSize.height - screenSizeY
    posY = posY - gap
  end
  if itemShow then
    self._NORMALTOOLTIP._mainPanel:SetPosX(posX)
    self._NORMALTOOLTIP._mainPanel:SetPosY(posY)
  end
  if equipItemShow then
    if false == isLeft then
      posX = posX + tooltipSize.width
    else
      posX = posX - tooltipEquipped.width
    end
    self._EQUIPTOOLTIP._mainPanel:SetPosX(posX)
    self._EQUIPTOOLTIP._mainPanel:SetPosY(posY)
  end
  if itemShow and equipItemShow then
    local arrow = self._EQUIPTOOLTIP._ui.stc_arrow
    if self._NORMALTOOLTIP._mainPanel:GetPosX() < self._EQUIPTOOLTIP._mainPanel:GetPosX() then
      self._EQUIPTOOLTIP._ui.stc_arrow:SetShow(false)
      arrow = self._EQUIPTOOLTIP._ui.stc_arrow_L
      arrow:SetShow(true)
      arrow:SetPosY(self._EQUIPTOOLTIP._ui.stc_itemIcon:GetPosY())
      arrow:SetPosX(-arrow:GetSizeX() / 2)
    else
      self._EQUIPTOOLTIP._ui.stc_arrow_L:SetShow(false)
      arrow = self._EQUIPTOOLTIP._ui.stc_arrow
      arrow:SetShow(true)
      arrow:SetPosY(self._EQUIPTOOLTIP._ui.stc_itemIcon:GetPosY())
      arrow:SetPosX(self._EQUIPTOOLTIP._mainPanel:GetSizeX() - arrow:GetSizeX() / 2)
    end
  else
    self._EQUIPTOOLTIP._ui.stc_arrow:SetShow(false)
    self._EQUIPTOOLTIP._ui.stc_arrow_L:SetShow(false)
  end
end
function PaGlobal_Tooltip_Control_All:setSkillTooltipPos()
  local skillTooltipFunctionList = {
    GetParentPosX = function()
      local slot = self._dataObject.skillSlot
      return slot.icon:GetParentPosX()
    end,
    GetParentPosY = function()
      local slot = self._dataObject.skillSlot
      return slot.icon:GetParentPosY()
    end,
    GetSizeX = function()
      local slot = self._dataObject.skillSlot
      return slot.icon:GetSizeX()
    end,
    GetSizeY = function()
      local slot = self._dataObject.skillSlot
      return slot.icon:GetSizeY()
    end,
    GetParentPanel = function()
      local slot = self._dataObject.skillSlot
      return slot.icon:GetParentPanel()
    end
  }
  if nil ~= Panel_SkillTooltip_SetPosition and false == _ContentsGroup_UISkillGroupTreeLayOut then
    Panel_SkillTooltip_SetPosition(1, skillTooltipFunctionList, "itemToSkill")
  end
end
function PaGlobal_Tooltip_Control_All:getBottomPos(control, isText)
  if nil == control then
    UI.ASSERT(false, "PaGlobal_Tooltip_Control_All:getBottomPos(control) , control nil")
    return
  end
  local controlSizeY = 0
  if isText then
    controlSizeY = control:GetPosY() + control:GetTextSizeY()
  else
    controlSizeY = control:GetPosY() + control:GetSizeY()
  end
  return controlSizeY
end
function PaGlobal_Tooltip_Control_All:responseTradePrice(price, key, enchantLevel)
  local enchantKey = ItemEnchantKey(key, enchantLevel)
  local enchantKeyRaw = enchantKey:get()
  local itemSSW = getItemEnchantStaticStatus(enchantKey)
  local s32_itemWieght = Int64toInt32(itemSSW:getWorldMarketVolume()) * 1000
  local str_itemWeight = makeWeightString(toInt64(0, s32_itemWieght), 2)
  local data
  if nil ~= self._firstTradeInfoData and self._firstTradeInfoData.key == enchantKeyRaw then
    data = self._firstTradeInfoData
    self._firstTradeInfoData.key = 0
  elseif nil ~= self._secondTradeInfoData and self._secondTradeInfoData.key == enchantKeyRaw then
    data = self._secondTradeInfoData
    self._secondTradeInfoData.key = 0
  else
    return
  end
  if nil == data then
    return
  end
  local txt = data.txt_valuePrice
  txt:SetShow(true)
  data.pendingAnimation:SetShow(false)
  if price <= Defines.s64_const.s64_0 then
    txt:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_TRADEPRICE_TITLE") .. " " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MARKET_PLACE_NO_PRICE_INFO") .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MARKETPLACE_CARRYING_CAPACITY") .. " : " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MARKETPLACE_VOLUME_VT_PARAM_NONCOLOR", "Weight", str_itemWeight))
  else
    txt:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_TRADEPRICE_TITLE") .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_MASTER_MONEY", "money", makeDotMoney(price)) .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MARKETPLACE_CARRYING_CAPACITY") .. " : " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MARKETPLACE_VOLUME_VT_PARAM_NONCOLOR", "Weight", str_itemWeight))
  end
end
function PaGlobal_Tooltip_Control_All:changeDyeInfoTexture(target, bEmpty, dyeingPartIndex, dyeingPartColor)
  local texturePath = "New_UI_Common_forLua/Widget/ToolTip/ToolTip_00.dds"
  local control = target._ui.stc_useDyeColorIcon_part[dyeingPartIndex]
  if not bEmpty then
    control:ChangeTextureInfoName(texturePath)
    local x1, y1, x2, y2 = setTextureUV_Func(control, 75, 43, 93, 61)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    control:SetAlphaIgnore(true)
    control:SetColor(dyeingPartColor)
  else
    control:ChangeTextureInfoName(texturePath)
    local x1, y1, x2, y2 = setTextureUV_Func(control, 98, 43, 116, 61)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    control:SetAlphaIgnore(true)
    control:SetColor(Defines.Color.C_FFFFFFFF)
  end
end
function PaGlobal_Tooltip_Control_All:setRepairInfo(target, equipType, enduranceLimit, repairPriceByNpc_s64)
  if 0 ~= equipType and 0 ~= enduranceLimit then
    target._ui.txt_isRepair:SetShow(true)
    if toInt64(0, 0) ~= repairPriceByNpc_s64 then
      target._ui.txt_isRepair:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_ABLE_REPAIR"))
    else
      target._ui.txt_isRepair:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_DISABLE_REPAIR"))
    end
  end
end
function PaGlobal_Tooltip_Control_All:getUsableServantType(itemSSW)
  if nil == itemSSW then
    return
  end
  local servantKind = CppEnums.ServantKind
  local servantKindType
  for index = 0, servantKind.Type_Count - 1 do
    if itemSSW:get():isServantTypeUsable(index) then
      if servantKind.Type_Horse == index or servantKind.Type_Camel == index or servantKind.Type_Donkey == index or servantKind.Type_Elephant == index then
        servantKindType = 0
      elseif servantKind.Type_TwoWheelCarriage == index or servantKind.Type_FourWheeledCarriage == index then
        servantKindType = 1
      elseif servantKind.Type_Ship == index or servantKind.Type_Raft == index or servantKind.Type_PersonalTradeShip == index or servantKind.Type_PersonalBattleShip == index or servantKind.Type_PersonalBoat == index or servantKind.Type_FastShip == index or servantKind.Type_CashPersonalTradeShip == index or servantKind.Type_CashPersonalBattleShip == index or servantKindType_GalleyShipSolo == index or servantKind.Type_PersonalTradeShipSolo2 == index or servantKind.Type_PersonalBattleShipSolo2 == index or servantKind.Type_PersonalTradeShipSolo1 == index or servantKind.Type_PersonalBattleShipSolo1 == index or servantKind.Type_FishingBoat == index then
      elseif servantKind.Type_Carrack == index then
        servantKindType = 3
      end
    end
  end
  return servantKindType
end
function PaGlobal_Tooltip_Control_All:getIsUsableClassType(itemSSW)
  if nil == itemSSW then
    return
  end
  local isUsable = false
  for idx = 0, getCharacterClassCount() - 1 do
    local classType = getCharacterClassTypeByIndex(idx)
    if itemSSW:get()._usableClassType:isOn(classType) then
      isUsable = true
      break
    end
  end
  return isUsable
end
function PaGlobal_Tooltip_Control_All:showKey(key)
  if false == isGameServiceTypeDev() then
    return ""
  end
  if nil == key then
    return ""
  end
  local returnValue = " (" .. key .. ")"
  return returnValue
end
