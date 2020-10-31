function PaGlobal_Tooltip_Control_All:setTooltipInfo(target, inputValue, isSSW, isItemWrapper, chattingLinkedItem, index, isNextEnchantInfo, invenSlotNo, itemNamingStr)
  target._ui.stc_expireIcon_white:SetShow(false)
  target._ui.stc_expireIcon_red:SetShow(false)
  target._ui.stc_expireIcon_end:SetShow(false)
  local itemSSW, itemWrapper, item, itemKeyForTradeInfo
  if isSSW and not isItemWrapper then
    itemSSW = inputValue
    if nil == itemSSW then
      target._mainPanel:SetShow(false, false)
      target._mainPanel:CloseUISubApp()
      return false, false
    end
    item = itemSSW:get()
    itemKeyForTradeInfo = itemSSW:get()._key:get()
  else
    itemWrapper = inputValue
    if nil == itemWrapper then
      target._mainPanel:SetShow(false, false)
      target._mainPanel:CloseUISubApp()
      return false, false
    end
    itemSSW = itemWrapper:getStaticStatus()
    item = itemWrapper:get()
    itemKeyForTradeInfo = itemSSW:get()._key:get()
  end
  if self._EQUIPTOOLTIP == target and true == isNextEnchantInfo then
    self._EQUIPTOOLTIP._ui.txt_equippedTag:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_NEXT_ENCHANT"))
    local nextEnchantLevel = itemSSW:get()._key:getEnchantLevel() + 1
    if 20 < nextEnchantLevel then
      target._mainPanel:SetShow(false, false)
      target._mainPanel:CloseUISubApp()
      return false, false
    end
    local enchantItemKey = ItemEnchantKey(itemSSW:get()._key:getItemKey(), nextEnchantLevel)
    enchantItemKey:set(itemSSW:get()._key:getItemKey(), nextEnchantLevel)
    itemSSW = getItemEnchantStaticStatus(enchantItemKey)
    if nil == itemSSW or nil == itemSSW:get() then
      target._mainPanel:SetShow(false, false)
      target._mainPanel:CloseUISubApp()
      return false, false
    end
    itemKeyForTradeInfo = itemSSW:get()._key:get()
  else
    self._EQUIPTOOLTIP._ui.txt_equippedTag:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_CURRENT_EQUIP"))
  end
  if nil ~= invenSlotNo then
    self._clothBagSlotNo = invenSlotNo
  end
  if self._NORMALTOOLTIP == target then
    self._NORMALTOOLTIP._ui.txt_bagSize:SetShow(false)
    self._NORMALTOOLTIP._ui.txt_equipmentInBag:SetShow(false)
    if CppEnums.ContentsEventType.ContentsType_InventoryBag == itemSSW:get():getContentsEventType() and nil ~= self._clothBagSlotNo then
      local bagSize = itemSSW:getContentsEventParam2()
      self._NORMALTOOLTIP._ui.txt_bagSize:SetShow(true)
      self._NORMALTOOLTIP._ui.txt_bagSize:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_BAGSIZE", "size", bagSize))
      local itemNameinBag = ""
      for index = 0, bagSize - 1 do
        local bagItemWrapper
        if self._bagInWarehouse then
          if _ContentsGroup_NewUI_WareHouse_All then
            bagItemWrapper = PaGlobal_Warehouse_All_GetWarehouseWarpper():getItemInBag(self._clothBagSlotNo, index)
          else
            bagItemWrapper = Warehouse_GetWarehouseWarpper():getItemInBag(self._clothBagSlotNo, index)
          end
        else
          local whereType = CppEnums.ItemWhereType.eInventory
          if itemSSW:get():isCash() then
            whereType = CppEnums.ItemWhereType.eCashInventory
          end
          bagItemWrapper = getInventoryBagItemByType(whereType, self._clothBagSlotNo, index)
        end
        if nil ~= bagItemWrapper then
          if "" == itemNameinBag then
            itemNameinBag = tostring(bagItemWrapper:getStaticStatus():getName())
          else
            itemNameinBag = itemNameinBag .. "\n" .. tostring(bagItemWrapper:getStaticStatus():getName())
          end
        end
      end
      if "" == itemNameinBag then
        self._NORMALTOOLTIP._ui.txt_equipmentInBag:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_BAG_EMPTY"))
      else
        self._NORMALTOOLTIP._ui.txt_equipmentInBag:SetText(itemNameinBag)
      end
      self._NORMALTOOLTIP._ui.txt_equipmentInBag:SetShow(true)
    end
  end
  if true == _ContentsGroup_ItemRandomOption and nil ~= itemWrapper and false == itemWrapper:isEmptyRandomOption() then
    target._ui.stc_tradeInfo_panel:SetShow(false)
    target._ui.txt_tradeInfo_title:SetShow(false)
    target._ui.txt_tradeInfo_value:SetShow(false)
  else
    if true == _ContentsGroup_RenewUI_ItemMarketPlace then
      local itemKey = itemSSW:get()._key:getItemKey()
      local enchantLevel = itemSSW:get()._key:getEnchantLevel()
      local enchantKey = ItemEnchantKey(itemKey, enchantLevel)
      local isAble = requestIsRegisterItemForItemMarket(itemSSW:get()._key)
      if isAble then
        local enchantKeyRaw = enchantKey:get()
        if nil == self._firstTradeInfoData then
          target._ui.stc_tradeInfo_panel:SetShow(true)
          target._ui.txt_tradeInfo_title:SetShow(true)
          target._ui.txt_tradeInfo_value:SetShow(true)
          target._ui.txt_tradeInfo_value:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_TRADEPRICE_TITLE"))
          target._ui.stc_tradeInfo_panel:SetSize(target._ui.stc_tradeInfo_panel:GetSizeX(), target._ui.txt_tradeInfo_title:GetTextSizeY() + target._ui.txt_tradeInfo_value:GetTextSizeY() + 20)
          target._ui.stc_tradeInfo_ani:SetShow(true)
          target._ui.stc_tradeInfo_ani:SetPosX(target._ui.txt_tradeInfo_value:GetTextSizeX() + 10)
          self._firstTradeInfoData = {}
          self._firstTradeInfoData.key = enchantKeyRaw
          self._firstTradeInfoData.txt_valuePrice = target._ui.txt_tradeInfo_value
          self._firstTradeInfoData.pendingAnimation = target._ui.stc_tradeInfo_ani
          ToClient_getWorldMarketTradePrice(enchantKeyRaw)
        elseif nil == self._secondTradeInfoData then
          target._ui.stc_tradeInfo_panel:SetShow(true)
          target._ui.txt_tradeInfo_title:SetShow(true)
          target._ui.txt_tradeInfo_value:SetShow(true)
          target._ui.txt_tradeInfo_value:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_TRADEPRICE_TITLE"))
          target._ui.stc_tradeInfo_panel:SetSize(target._ui.stc_tradeInfo_panel:GetSizeX(), target._ui.txt_tradeInfo_title:GetTextSizeY() + target._ui.txt_tradeInfo_value:GetTextSizeY() + 20)
          target._ui.stc_tradeInfo_ani:SetShow(true)
          target._ui.stc_tradeInfo_ani:SetPosX(target._ui.txt_tradeInfo_value:GetTextSizeX() + 10)
          self._secondTradeInfoData = {}
          self._secondTradeInfoData.key = enchantKeyRaw
          self._secondTradeInfoData.txt_valuePrice = target._ui.txt_tradeInfo_value
          self._secondTradeInfoData.pendingAnimation = target._ui.stc_tradeInfo_ani
          ToClient_getWorldMarketTradePrice(enchantKeyRaw)
        else
          self._firstTradeInfoData = nil
          self._secondTradeInfoData = nil
        end
      else
        target._ui.stc_tradeInfo_panel:SetShow(false)
        target._ui.txt_tradeInfo_title:SetShow(false)
        target._ui.txt_tradeInfo_value:SetShow(false)
        target._ui.stc_tradeInfo_ani:SetShow(false)
      end
    else
      target._ui.stc_tradeInfo_ani:SetShow(false)
      local tradeInfo
      local tradeSummaryInfo = getItemMarketSummaryInClientByItemEnchantKey(itemKeyForTradeInfo)
      local tradeMasterInfo = getItemMarketMasterByItemEnchantKey(itemKeyForTradeInfo)
      local itemClassifyType = itemSSW:getItemClassify()
      if nil ~= tradeSummaryInfo then
        tradeInfo = tradeSummaryInfo
      elseif nil ~= tradeMasterInfo then
        tradeInfo = tradeMasterInfo
      else
        tradeInfo = nil
      end
      if nil ~= tradeInfo and not _ContentsGroup_RenewUI then
        local tradeMasterItemName = tradeInfo:getItemEnchantStaticStatusWrapper():getName()
        if nil ~= tradeSummaryInfo and toInt64(0, 0) ~= tradeSummaryInfo:getDisplayedTotalAmount() then
          target._ui.txt_tradeInfo_value:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_TRADEINFO_REGISTPRICE", "highestOnePrice", makeDotMoney(tradeInfo:getDisplayedHighestOnePrice()), "LowestOnePrice", makeDotMoney(tradeInfo:getDisplayedLowestOnePrice())))
        else
          target._ui.txt_tradeInfo_value:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_TRADEINFO_HIGHANDLOWPRICE", "getMaxPrice", makeDotMoney(tradeMasterInfo:getMaxPrice()), "getMinPrice", makeDotMoney(tradeMasterInfo:getMinPrice())))
        end
        target._ui.stc_tradeInfo_panel:SetSize(target._ui.stc_tradeInfo_panel:GetSizeX(), target._ui.txt_tradeInfo_title:GetTextSizeY() + target._ui.txt_tradeInfo_value:GetTextSizeY() + 10)
        target._ui.stc_tradeInfo_panel:SetShow(true)
        target._ui.txt_tradeInfo_title:SetShow(true)
        target._ui.txt_tradeInfo_value:SetShow(true)
      else
        target._ui.stc_tradeInfo_panel:SetShow(false)
        target._ui.txt_tradeInfo_title:SetShow(false)
        target._ui.txt_tradeInfo_value:SetShow(false)
      end
    end
    target._ui.txt_equipSlotName:SetShow(false)
    if 1 == itemSSW:getItemType() then
      local EquipslotNo = itemSSW:getEquipSlotNo()
      if 21 == EquipslotNo then
        target._ui.txt_equipSlotName:SetShow(true)
        target._ui.txt_equipSlotName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_EQUIPSLOTNAME_HEAD"))
      elseif 22 == EquipslotNo then
        target._ui.txt_equipSlotName:SetShow(true)
        target._ui.txt_equipSlotName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_EQUIPSLOTNAME_EYES"))
      elseif 23 == EquipslotNo then
        target._ui.txt_equipSlotName:SetShow(true)
        target._ui.txt_equipSlotName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_EQUIPSLOTNAME_MOUSE"))
      end
    end
  end
  local nameColorGrade = itemSSW:getGradeType()
  if 0 == nameColorGrade then
    target._ui.txt_itemName:SetFontColor(Defines.Color.C_FFC4C4C4)
  elseif 1 == nameColorGrade then
    target._ui.txt_itemName:SetFontColor(Defines.Color.C_FF83A543)
  elseif 2 == nameColorGrade then
    target._ui.txt_itemName:SetFontColor(Defines.Color.C_FF438DCC)
  elseif 3 == nameColorGrade then
    target._ui.txt_itemName:SetFontColor(Defines.Color.C_FFF5BA3A)
  elseif 4 == nameColorGrade then
    target._ui.txt_itemName:SetFontColor(Defines.Color.C_FFD05D48)
  else
    target._ui.txt_itemName:SetFontColor(Defines.Color.C_FFC4C4C4)
  end
  target._ui.stc_itemIcon:ChangeTextureInfoName("icon/" .. itemSSW:getIconPath())
  if nil ~= itemWrapper then
    local isSoulCollector = itemWrapper:isSoulCollector()
    local isCurrentSoulCount = itemWrapper:getSoulCollectorCount()
    local isMaxSoulCount = itemWrapper:getSoulCollectorMaxCount()
    if isSoulCollector then
      target._ui.stc_itemIcon:ChangeTextureInfoName("icon/" .. itemWrapper:getStaticStatus():getIconPath())
      if 0 == isCurrentSoulCount then
        target._ui.stc_itemIcon:ChangeTextureInfoName("icon/" .. itemWrapper:getStaticStatus():getIconPath())
      end
      if 0 < isCurrentSoulCount then
        target._ui.stc_itemIcon:ChangeTextureInfoName("New_UI_Common_forLua/ExceptionIcon/00040351_1.dds")
      end
      if isCurrentSoulCount == isMaxSoulCount then
        target._ui.stc_itemIcon:ChangeTextureInfoName("New_UI_Common_forLua/ExceptionIcon/00040351_2.dds")
      end
    end
  end
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  self:setEnchantLevel(target, itemSSW)
  if itemSSW:get():isCash() then
    target._ui.txt_enchantLevel:SetShow(false)
  end
  local isCash = itemSSW:get():isCash()
  local balksCount = itemSSW:getExtractionCount_s64()
  local cronsCount = itemSSW:getCronCount_s64()
  if false == isCash and nil ~= balksCount and toInt64(0, 0) ~= balksCount and nil ~= cronsCount and toInt64(0, 0) ~= cronsCount then
    target._ui.txt_enchantLevel:SetShow(false)
  end
  target._ui.txt_maxEnchanter:SetShow(false)
  local showItemKey = itemSSW:get()._key:getItemKey()
  local devShowItemKey = self:showKey(showItemKey)
  target._ui.txt_itemName:SetTextMode(__eTextMode_AutoWrap)
  if 1 == itemSSW:getItemType() and 15 < enchantLevel then
    local itemAndEnchantName = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemSSW:getName() .. devShowItemKey
    if nil ~= itemNamingStr and true == isEnchantLevel5 then
      target._ui.txt_itemName:SetText(itemAndEnchantName)
      target._ui.txt_maxEnchanter:SetShow(_ContentsGroup_MaxEnchanterEnable)
      target._ui.txt_maxEnchanter:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_MAXENCHANTER", "name", itemNamingStr))
    elseif nil ~= chattingLinkedItem and "" ~= chattingLinkedItem:getItemNamingUserName() then
      target._ui.txt_itemName:SetText(itemAndEnchantName)
      target._ui.txt_maxEnchanter:SetShow(_ContentsGroup_MaxEnchanterEnable)
      target._ui.txt_maxEnchanter:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_MAXENCHANTER", "name", chattingLinkedItem:getItemNamingUserName()))
    else
      target._ui.txt_itemName:SetText(itemAndEnchantName)
    end
  elseif 0 < enchantLevel and CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() and false == itemSSW:isSpecialEnchantItem() then
    local itemAndEnchantName = HighEnchantLevel_ReplaceString(enchantLevel + 15) .. " " .. itemSSW:getName() .. devShowItemKey
    if nil ~= itemNamingStr and true == isEnchantLevel5 then
      target._ui.txt_itemName:SetText(itemAndEnchantName)
      target._ui.txt_maxEnchanter:SetShow(_ContentsGroup_MaxEnchanterEnable)
      target._ui.txt_maxEnchanter:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_MAXENCHANTER", "name", itemNamingStr))
    elseif nil ~= chattingLinkedItem and "" ~= chattingLinkedItem:getItemNamingUserName() then
      target._ui.txt_itemName:SetText(itemAndEnchantName)
      target._ui.txt_maxEnchanter:SetShow(_ContentsGroup_MaxEnchanterEnable)
      target._ui.txt_maxEnchanter:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_MAXENCHANTER", "name", chattingLinkedItem:getItemNamingUserName()))
    else
      target._ui.txt_itemName:SetText(itemAndEnchantName)
    end
  elseif nil ~= itemNamingStr and true == isEnchantLevel5 then
    target._ui.txt_itemName:SetText(itemSSW:getName() .. devShowItemKey)
    target._ui.txt_maxEnchanter:SetShow(_ContentsGroup_MaxEnchanterEnable)
    target._ui.txt_maxEnchanter:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_MAXENCHANTER", "name", itemNamingStr))
  elseif nil ~= chattingLinkedItem and "" ~= chattingLinkedItem:getItemNamingUserName() then
    target._ui.txt_itemName:SetText(itemSSW:getName() .. devShowItemKey)
    target._ui.txt_maxEnchanter:SetShow(_ContentsGroup_MaxEnchanterEnable)
    target._ui.txt_maxEnchanter:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_MAXENCHANTER", "name", chattingLinkedItem:getItemNamingUserName()))
  else
    target._ui.txt_itemName:SetText(itemSSW:getName() .. devShowItemKey)
  end
  local changeItemNamePos = 50
  local iconMovePos = 0
  if 1 < target._ui.txt_itemName:GetLineCount() then
    changeItemNamePos = (target._ui.txt_itemName:GetLineCount() - 1) * 11 + target._ui.txt_itemName:GetTextSizeY()
    iconMovePos = -30
  elseif 3 == target._ui.txt_itemName:GetLineCount() then
    changeItemNamePos = (target._ui.txt_itemName:GetLineCount() - 1) * 11 + target._ui.txt_itemName:GetTextSizeY()
    iconMovePos = -60
  elseif 4 == target._ui.txt_itemName:GetLineCount() then
    changeItemNamePos = (target._ui.txt_itemName:GetLineCount() - 1) * 11 + target._ui.txt_itemName:GetTextSizeY()
    iconMovePos = -90
  end
  local itemType = itemSSW:getItemType()
  local isTradeItem = itemSSW:isTradeAble()
  if itemType == 1 then
    target._ui.txt_itemType:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIPMENT"))
  elseif itemType == 2 then
    if isTradeItem == true then
      target._ui.txt_itemType:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_TRADE_ITEM"))
    else
      target._ui.txt_itemType:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_CONSUME"))
    end
  elseif itemType == 3 then
    target._ui.txt_itemType:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_TENT_TOOL"))
  elseif itemType == 4 then
    target._ui.txt_itemType:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_INSTALL_TOOL"))
  elseif itemType == 5 then
    target._ui.txt_itemType:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_SOCKET_ITEM"))
  elseif itemType == 6 then
    target._ui.txt_itemType:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_CANNONBALL"))
  elseif itemType == 7 then
    target._ui.txt_itemType:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_LICENCE"))
  elseif itemType == 8 then
    target._ui.txt_itemType:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_PRODUCTION"))
  elseif itemType == 9 then
    target._ui.txt_itemType:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_ENTER_AIR"))
  elseif itemType == 10 then
    target._ui.txt_itemType:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_SPECIAL_PRODUCTION"))
  elseif true == itemSSW:get():isForJustTrade() then
    target._ui.txt_itemType:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_NOMAL") .. "/" .. PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_TRADE_ITEM"))
  else
    target._ui.txt_itemType:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_NOMAL"))
  end
  if itemType == 8 and true == itemSSW:get():isForJustTrade() then
    target._ui.txt_itemType:SetText(target._ui.txt_itemType:GetText() .. "/" .. PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_TRADE_ITEM"))
  end
  target._ui.txt_isSealed:SetShow(false)
  if itemSSW:isEquipable() and not isSSW and not itemSSW:get():isCash() and item:isSealed() then
    target._ui.txt_isSealed:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_ISEQUIPSEAL"))
    target._ui.txt_isSealed:SetShow(true)
  end
  local isAble = false
  if nil ~= itemWrapper then
    isAble = requestIsRegisterItemForItemMarket(itemWrapper:get():getKey())
  end
  if itemSSW:get():isCash() and not isSSW and isAble and item:isSealed() and not itemSSW:isStackable() and not item:isVested() then
    target._ui.txt_isSealed:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_TAXFREE"))
    target._ui.txt_isSealed:SetShow(true)
  end
  target._ui.txt_isEnchantable:SetShow(false)
  local isPossibleToEnchant = itemSSW:get():isEnchantable()
  if itemSSW:isEquipable() then
    if isPossibleToEnchant == false then
      target._ui.txt_isEnchantable:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_NOT_ENCHANT"))
      target._ui.txt_isEnchantable:SetShow(true)
    else
      target._ui.txt_isEnchantable:SetShow(false)
    end
  end
  local interiorPoint = 0
  if itemSSW:get():isItemInstallation() then
    interiorPoint = itemSSW:getCharacterStaticStatus():getObjectStaticStatus():getInteriorSensPoint()
    if 0 < interiorPoint then
      target._ui.txt_isEnchantable:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_INTERIOR_POINT") .. interiorPoint .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_POINT"))
      target._ui.txt_isEnchantable:SetShow(true)
    end
  elseif not target._ui.txt_isEnchantable:GetShow() then
    target._ui.txt_isEnchantable:SetShow(false)
  end
  local itemBindType = itemSSW:get()._vestedType:getItemKey()
  if not isSSW and item:isVested() then
    if itemSSW:isUserVested() then
      target._ui.txt_bindType:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_HOLDED_FAMILYACOUNT"))
    else
      target._ui.txt_bindType:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_HOLDED"))
    end
    target._ui.txt_bindType:SetShow(true)
  elseif itemSSW:isGuildStockable() then
    target._ui.txt_bindType:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_HOLDED_GUILD"))
    target._ui.txt_bindType:SetShow(true)
  elseif itemBindType == 1 then
    if isSSW and itemSSW:isUserVested() then
      target._ui.txt_bindType:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_GETBIND_FAMILY"))
      target._ui.txt_bindType:SetShow(true)
    else
      target._ui.txt_bindType:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_GETBIND_CHARACTER"))
      target._ui.txt_bindType:SetShow(true)
    end
  elseif itemBindType == 2 then
    if true == itemSSW:isUserVested() then
      target._ui.txt_bindType:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_EQUIPBIND_FAMILY"))
      target._ui.txt_bindType:SetShow(true)
    else
      target._ui.txt_bindType:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_EQUIPBIND_CHARACTER"))
      target._ui.txt_bindType:SetShow(true)
    end
  else
    target._ui.txt_bindType:SetShow(false)
  end
  local balksCount = itemSSW:getExtractionCount_s64()
  local cronsCount = itemSSW:getCronCount_s64()
  if nil ~= balksCount and toInt64(0, 0) ~= balksCount and (_ContentsGroup_ExtractionCommon or _ContentsGroup_ExtractionJapan) then
    target._ui.txt_balksExtraction:SetShow(true)
    target._ui.txt_balksExtraction:SetFontColor(Defines.Color.C_FFBC56E1)
    target._ui.txt_balksExtraction:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_BALKS_EXTRACTION", "balksCount", Int64toInt32(balksCount)))
  else
    target._ui.txt_balksExtraction:SetShow(false)
  end
  if nil ~= cronsCount and toInt64(0, 0) ~= cronsCount and _ContentsGroup_CronStone and (_ContentsGroup_ExtractionJapan or _ContentsGroup_ExtractionCommon) then
    target._ui.txt_cronsExtraction:SetShow(true)
    target._ui.txt_cronsExtraction:SetFontColor(Defines.Color.C_FFBC56E1)
    target._ui.txt_cronsExtraction:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_CRONS_EXTRACTION", "cronsCount", Int64toInt32(cronsCount)))
  else
    target._ui.txt_cronsExtraction:SetShow(false)
  end
  target._ui.txt_isPersonalTrade:SetShow(false)
  if isUsePcExchangeInLocalizingValue() and CppEnums.CountryType.DEV ~= getGameServiceType() then
    target._ui.txt_isPersonalTrade:SetShow(true)
    if nil ~= itemWrapper then
      if itemSSW:isPersonalTrade() and not itemWrapper:get():isVested() then
        target._ui.txt_isPersonalTrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_PERSONALTRADE_ENABLE"))
      else
        target._ui.txt_isPersonalTrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_PERSONALTRADE_DISABLE"))
      end
    elseif nil ~= itemSSW then
      if itemSSW:isPersonalTrade() then
        target._ui.txt_isPersonalTrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_PERSONALTRADE_ENABLE"))
      else
        target._ui.txt_isPersonalTrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_PERSONALTRADE_DISABLE"))
      end
    end
  end
  target._ui.txt_cronStoneEnchant:SetShow(false)
  target._ui.txt_cronStoneValue:SetShow(false)
  target._ui.txt_cronStoneValue:SetSize(300, target._ui.txt_cronStoneValue:GetSizeY())
  target._ui.txt_cronStoneValue:SetTextMode(__eTextMode_AutoWrap)
  local itemaddedDD = 0
  local itemaddedHit = 0
  local itemaddedDV = 0
  local itemaddedHDV = 0
  local itemaddedPV = 0
  local itemaddedHPV = 0
  if (self._EQUIPTOOLTIP ~= target or true ~= isNextEnchantInfo) and (true ~= ItemMarket_getIsMarketItem() or self._EQUIPTOOLTIP == target) then
    local currentEnchantFailCount = 0
    if nil ~= itemWrapper then
      currentEnchantFailCount = itemWrapper:getCronEnchantFailCount()
    elseif nil ~= chattingLinkedItem then
      currentEnchantFailCount = chattingLinkedItem:getItemParam(0)
    end
    if 0 < currentEnchantFailCount then
      local itemSSW, itemEnchantWrapper
      if nil ~= itemWrapper then
        itemSSW = itemWrapper:getStaticStatus()
        itemEnchantWrapper = itemWrapper
      elseif nil ~= chattingLinkedItem then
        itemSSW = chattingLinkedItem:getLinkedItemStaticStatus()
        itemEnchantWrapper = chattingLinkedItem
      end
      local cronKey = itemSSW:getCronKey()
      local enchantLevel = itemSSW:get()._key:getEnchantLevel()
      local gradeCount = ToClient_GetCronEnchnatInfoCount(cronKey, enchantLevel)
      local startPosX = 2
      local lastCount = 0
      local currentGrade = 0
      local lastIndex = gradeCount - 1
      if 0 < gradeCount then
        local cronEnchantSSW = ToClient_GetCronEnchantWrapper(cronKey, enchantLevel, lastIndex)
        local enchantablelastCount = cronEnchantSSW:getCount()
        if 0 < currentEnchantFailCount then
          for gradeIndex = 0, gradeCount - 1 do
            local cronEnchantSSW = ToClient_GetCronEnchantWrapper(cronKey, enchantLevel, gradeIndex)
            local enchantableCount = cronEnchantSSW:getCount()
            if currentEnchantFailCount < enchantableCount then
            else
              currentGrade = currentGrade + 1
            end
            if gradeCount - 1 == gradeIndex then
              lastCount = enchantableCount
            end
          end
        end
        currentEnchantFailCount = math.min(currentEnchantFailCount, lastCount)
        local bonusText = ""
        itemaddedDD = itemEnchantWrapper:getAddedDD()
        itemaddedHit = itemEnchantWrapper:getAddedHIT()
        itemaddedDV = itemEnchantWrapper:getAddedDV()
        itemaddedHDV = itemEnchantWrapper:getCronHDV()
        itemaddedPV = itemEnchantWrapper:getAddedPV()
        itemaddedHPV = itemEnchantWrapper:getCronHPV()
        local itemMaxHp = itemEnchantWrapper:getAddedMaxHP()
        local itemMaxMp = itemEnchantWrapper:getAddedMaxMP()
        if 0 < itemaddedDD then
          if "" == bonusText then
            bonusText = bonusText .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_ATTACK", "value", itemaddedDD)
          else
            bonusText = bonusText .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_ATTACKB", "value", itemaddedDD)
          end
        end
        if 0 < math.floor(itemaddedHit) then
          if "" == bonusText then
            bonusText = bonusText .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_HIT", "value", math.floor(itemaddedHit))
          else
            bonusText = bonusText .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_HITB", "value", math.floor(itemaddedHit))
          end
        end
        if 0 < itemaddedDV then
          if "" == bonusText then
            bonusText = bonusText .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_DODGE", "value", itemaddedDV)
          else
            bonusText = bonusText .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_DODGEB", "value", itemaddedDV)
          end
        end
        if 0 < itemaddedHDV then
          if 0 == itemaddedDV then
            if "" == bonusText then
              bonusText = bonusText .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_DODGE", "value", 0) .. "(+" .. tostring(itemaddedHDV) .. ")"
            else
              bonusText = bonusText .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_DODGEB", "value", 0) .. "(+" .. tostring(itemaddedHDV) .. ")"
            end
          else
            bonusText = bonusText .. "(+" .. tostring(itemaddedHDV) .. ")"
          end
        end
        if 0 < itemaddedPV then
          if "" == bonusText then
            bonusText = bonusText .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_REDUCE", "value", itemaddedPV)
          else
            bonusText = bonusText .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_REDUCEB", "value", itemaddedPV)
          end
        end
        if 0 < itemaddedHPV then
          if 0 == itemaddedPV then
            if "" == bonusText then
              bonusText = bonusText .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_REDUCE", "value", 0) .. "(+" .. tostring(itemaddedHPV) .. ")"
            else
              bonusText = bonusText .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_REDUCEB", "value", 0) .. "(+" .. tostring(itemaddedHPV) .. ")"
            end
          else
            bonusText = bonusText .. "(+" .. tostring(itemaddedHPV) .. ")"
          end
        end
        if 0 < itemMaxHp then
          if "" == bonusText then
            bonusText = bonusText .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_HP", "value", itemMaxHp)
          else
            bonusText = bonusText .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_HPB", "value", itemMaxHp)
          end
        end
        if 0 < itemMaxMp then
          if "" == bonusText then
            bonusText = bonusText .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_MP", "value", itemMaxMp)
          else
            bonusText = bonusText .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_MPB", "value", itemMaxMp)
          end
        end
        if "" == bonusText then
          bonusText = PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_NOTHING")
        end
        target._ui.txt_cronStoneEnchant:SetShow(true)
        target._ui.txt_cronStoneValue:SetShow(true)
        target._ui.txt_cronStoneEnchant:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANTGRADE_CAPHRAS", "grade", currentGrade))
        target._ui.txt_cronStoneValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_BONUS", "bonusText", bonusText))
      end
    end
  end
  local itemRandomAddedDD = 0
  local itemRandomAddedHit = 0
  local itemRandomAddedDV = 0
  local itemRandomAddedHDV = 0
  local itemRandomAddedPV = 0
  local itemRandomAddedHPV = 0
  target._ui.txt_randomOptionTitle:SetShow(false)
  for index = 0, __eMaxItemOptionCount - 1 do
    target._ui.txt_randomOptionValue[index]:SetShow(false)
  end
  target._ui.txt_randomOptionTitle:SetSize(300, target._ui.txt_randomOptionTitle:GetSizeY())
  target._ui.txt_randomOptionTitle:SetTextMode(__eTextMode_AutoWrap)
  if true == _ContentsGroup_ItemRandomOption and nil ~= itemWrapper and true == itemWrapper:isRandomOptionTarget() then
    target._ui.txt_randomOptionTitle:SetShow(true)
    if true == itemWrapper:isEmptyRandomOption() then
      for index = 0, __eMaxItemOptionCount - 1 do
        if 0 == index then
          local randomOptionStr = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_BREAK_AVAILABLE")
          target._ui.txt_randomOptionValue[index]:SetText(randomOptionStr)
          target._ui.txt_randomOptionValue[index]:SetShow(true)
        else
          target._ui.txt_randomOptionValue[index]:SetShow(false)
        end
      end
    else
      local randomStatList = {}
      for index = 0, __eMaxItemOptionCount - 1 do
        local rnadomType = itemWrapper:getRandomOptionType(index)
        if 0 ~= rnadomType then
          local statValue = itemWrapper:getRandomOptionValue(index)
          statValue = math.floor(statValue * 10 + 0.5) / 10
          local randomTypeWrapper = ToClient_GetRandomOptionTypeByKey(itemWrapper:getRandomOptionType(index))
          if nil ~= randomTypeWrapper then
            local randomStatInfo = {}
            randomStatInfo._statType = rnadomType
            randomStatInfo._statValueStr = randomTypeWrapper:getRandomOptionTypeName() .. " +" .. tostring(statValue)
            if __eRandomOptionStatType_DD == randomStatInfo._statType then
              itemRandomAddedDD = statValue
            elseif __eRandomOptionStatType_HIT == randomStatInfo._statType then
              itemRandomAddedHit = statValue
            elseif __eRandomOptionStatType_PV == randomStatInfo._statType then
              itemRandomAddedPV = statValue
            elseif __eRandomOptionStatType_DV == randomStatInfo._statType then
              itemRandomAddedDV = statValue
            end
            randomStatInfo._statValueStr = randomStatInfo._statValueStr .. randomTypeWrapper:getUnitForRandomOption()
            table.insert(randomStatList, randomStatInfo)
          end
        end
      end
      local sortFunc = function(a, b)
        return a._statType < b._statType
      end
      table.sort(randomStatList, sortFunc)
      for index = 0, __eMaxItemOptionCount - 1 do
        if index <= #randomStatList then
          target._ui.txt_randomOptionValue[index]:SetText(randomStatList[index + 1]._statValueStr)
          target._ui.txt_randomOptionValue[index]:SetShow(true)
        else
          target._ui.txt_randomOptionValue[index]:SetShow(false)
        end
      end
    end
  end
  target._ui.txt_isItemLock:SetShow(false)
  if true == self._dataObject.inventory and true == _ContentsGroup_ItemLock and not self._EQUIPTOOLTIP._mainPanel:GetShow() then
    local itemSSW = itemWrapper:getStaticStatus()
    local slotNo
    if true == _ContentsGroup_NewUI_Inventory_All then
      slotNo = PaGlobalFunc_Inventory_All_GetToolTipItemSlotNo()
    else
      slotNo = Inventory_GetToolTipItemSlotNo()
    end
    if ToClient_Inventory_CheckItemLock(slotNo) and false == itemSSW:get():isCash() then
      target._ui.txt_isItemLock:SetShow(true)
      target._ui.txt_isItemLock:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOOLTIP_ITEM_ITEMLOCK"))
      target._ui.txt_productNotify:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_TOOLTIP_ITEM_SHIFTCLICK") .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOOLTIP_ITEM_SHIFTRCLICK_UNLOCK"))
    else
      target._ui.txt_isItemLock:SetShow(false)
      target._ui.txt_productNotify:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_TOOLTIP_ITEM_SHIFTCLICK") .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOOLTIP_ITEM_SHIFTRCLICK_LOCK"))
    end
  elseif true == self._equipItemLock.equipment then
    if self._equipItemLock.itemLock then
      target._ui.txt_isItemLock:SetShow(true)
      target._ui.txt_isItemLock:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOOLTIP_ITEM_ITEMLOCK"))
    else
      target._ui.txt_isItemLock:SetShow(false)
    end
  else
    local itemCheckLock = false
    if -1 ~= self._equipItemLock.itemAccNo then
      itemCheckLock = ToClient_EquipSlot_CheckItemLock(self._equipItemLock.itemAccNo, 1)
      if itemCheckLock then
        self._EQUIPTOOLTIP._ui.txt_isItemLock:SetShow(true)
        self._EQUIPTOOLTIP._ui.txt_isItemLock:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOOLTIP_ITEM_ITEMLOCK"))
      else
        self._EQUIPTOOLTIP._ui.txt_isItemLock:SetShow(false)
      end
    end
  end
  target._ui.txt_useDyeColorTitle:SetShow(false)
  for index = 0, #target._ui.stc_useDyeColorIcon_part do
    target._ui.stc_useDyeColorIcon_part[index]:SetShow(false)
  end
  target._ui.txt_dying:SetShow(false)
  if nil ~= itemWrapper or nil ~= chattingLinkedItem then
    local dyeAble = itemSSW:isDyeable()
    if itemSSW:isEquipable() then
      local dyeingPartCount = 0
      if nil ~= itemWrapper then
        dyeingPartCount = itemWrapper:getDyeingPartCount()
      elseif nil ~= chattingLinkedItem then
        dyeingPartCount = chattingLinkedItem:getDyeingPartCount()
      end
      if true == dyeAble then
        for dyeingPart_Index = 0, dyeingPartCount - 1 do
          local bEmpty = false
          if nil ~= itemWrapper then
            bEmpty = itemWrapper:isEmptyDyeingPartColorAt(dyeingPart_Index)
            if not itemWrapper:isAllreadyDyeingSlot(dyeingPart_Index) then
              bEmpty = true
            end
          elseif nil ~= chattingLinkedItem then
            bEmpty = chattingLinkedItem:isEmptyDyeingPartColorAt(dyeingPart_Index)
            if not chattingLinkedItem:isAllreadyDyeingSlot(dyeingPart_Index) then
              bEmpty = true
            end
          end
          if not bEmpty then
            target._ui.txt_dying:SetShow(true)
            local dyeingPartColor
            if nil ~= itemWrapper then
              dyeingPartColor = itemWrapper:getDyeingPartColorAt(dyeingPart_Index)
            elseif nil ~= chattingLinkedItem then
              dyeingPartColor = chattingLinkedItem:getDyeingPartColorAt(dyeingPart_Index)
            end
            self:changeDyeInfoTexture(target, bEmpty, dyeingPart_Index, dyeingPartColor)
          else
            self:changeDyeInfoTexture(target, bEmpty, dyeingPart_Index, Defines.Color.C_FFFFFFFF)
          end
          target._ui.stc_useDyeColorIcon_part[dyeingPart_Index]:SetShow(true)
        end
        if dyeingPartCount > 0 then
          local isPearlPallete = ""
          if nil ~= itemWrapper and itemWrapper:isExpirationDyeing() then
            isPearlPallete = "(" .. PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAUGE_DYEINGPACKEAGE_TITLE") .. ")"
          end
          target._ui.txt_useDyeColorTitle:SetShow(true)
          target._ui.txt_useDyeColorTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_DYE_DYEINFO") .. isPearlPallete)
        end
      else
        target._ui.txt_useDyeColorTitle:SetShow(true)
        target._ui.txt_useDyeColorTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_DYE_DYEIMPOSSIBLE"))
      end
    end
    if _ContentsGroup_RenewUI then
      target._ui.txt_useDyeColorTitle:SetShow(false)
      for index = 0, #target._ui.stc_useDyeColorIcon_part do
        target._ui.stc_useDyeColorIcon_part[index]:SetShow(false)
      end
      target._ui.txt_dying:SetShow(false)
    end
  end
  target._ui.txt_isRepair:SetShow(false)
  if nil ~= itemSSW and nil ~= item then
    local equipType = itemSSW:getEquipType()
    local enduranceLimit = item:getMaxEndurance()
    local repairPriceByNpc_s64 = itemSSW:isRepairPriceByNpc()
    self:setRepairInfo(target, equipType, enduranceLimit, repairPriceByNpc_s64)
  end
  local useLimitShow = false
  local minLevel = itemSSW:get()._minLevel
  local isExistMaxLevel = itemSSW:get():isMaxLevelRestricted()
  local myInfo = getSelfPlayer()
  local myLevel = myInfo:get():getLevel()
  local minLevelString = tostring(minLevel)
  local jewelLevel = 0
  local maxLevel = itemSSW:get()._maxLevel
  local maxLevelString = tostring(maxLevel)
  if not isSSW then
    jewelLevel = item:getJewelValidLevel()
    if 0 ~= jewelLevel then
      minLevelString = minLevelString .. "(" .. tostring(minLevel + jewelLevel) .. ")"
    end
  end
  if isExistMaxLevel == true then
    if not isSSW and 0 ~= jewelLevel then
      maxLevelString = maxLevelString .. "(" .. tostring(maxLevel + jewelLevel) .. ")"
    end
    target._ui.txt_useLimit_level_value:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "PANEL_TOOLTIP_USEITEM_LIMIT", "minLevel", minLevelString, "maxLevel", maxLevelString))
    target._ui.txt_useLimit_level_value:SetShow(true)
    target._ui.txt_useLimit_level:SetShow(true)
    useLimitShow = true
    if myLevel < maxLevel then
      target._ui.txt_useLimit_level_value:SetFontColor(Defines.Color.C_FFC4BEBE)
    end
  elseif minLevel > 1 then
    if minLevel > myLevel then
      target._ui.txt_useLimit_level_value:SetFontColor(Defines.Color.C_FFF26A6A)
    else
      target._ui.txt_useLimit_level_value:SetFontColor(Defines.Color.C_FFC4BEBE)
    end
    target._ui.txt_useLimit_level_value:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_TOOLTIP_USEITEM_FROM", "limitLevel", minLevelString))
    target._ui.txt_useLimit_level_value:SetShow(true)
    target._ui.txt_useLimit_level:SetShow(true)
    useLimitShow = true
  else
    target._ui.txt_useLimit_level_value:SetShow(false)
    target._ui.txt_useLimit_level:SetShow(false)
  end
  local craftType
  local gather = 0
  fishing = 1
  hunting = 2
  cooking = 3
  alchemy = 4
  manufacture = 5
  training = 6
  trade = 7
  growth = 8
  sail = 9
  local lifeminLevel = 0
  local lifeType = {
    [0] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_GATHERING"),
    [1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_FISHING"),
    [2] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_HUNTING"),
    [3] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_COOKING"),
    [4] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_ALCHEMY"),
    [5] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_PROCESSING"),
    [6] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_OBEDIENCE"),
    [7] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_TRADE"),
    [8] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_GROWTH"),
    [9] = PAGetString(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_SAIL")
  }
  local craftType = itemSSW:get():getLifeExperienceType()
  local lifeminLevel = itemSSW:get():getLifeMinLevel(craftType)
  if lifeminLevel > 0 then
    local myLifeLevel = myInfo:get():getLifeExperienceLevel(craftType)
    if true == _ContentsGroup_RenewUI then
      target._ui.txt_useLimit_level_value:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "PANEL_TOOLTIP_USELIMIT_LEVEL_VALUE", "craftType", lifeType[craftType], "lifeminLevel", PaGlobalFunc_CharacterLifeInfo_CraftLevel_Replace(lifeminLevel, craftType)))
    else
      target._ui.txt_useLimit_level_value:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "PANEL_TOOLTIP_USELIMIT_LEVEL_VALUE", "craftType", lifeType[craftType], "lifeminLevel", PaGlobalFunc_Util_CraftLevelReplace(lifeminLevel)))
    end
    target._ui.txt_useLimit_level_value:SetShow(true)
    target._ui.txt_useLimit_level:SetShow(true)
    useLimitShow = true
    if lifeminLevel > myLifeLevel then
      target._ui.txt_useLimit_level_value:SetFontColor(Defines.Color.C_FFF26A6A)
    else
      target._ui.txt_useLimit_level_value:SetFontColor(Defines.Color.C_FFC4BEBE)
    end
  end
  local itemType = itemSSW:getItemType()
  local equip = {
    slotNoId = {
      [0] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_MAINHAND"),
      [1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_SUBHAND"),
      [2] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_PICKINGTOOLS"),
      [3] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_UPPERBODY"),
      [4] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_GLOVES"),
      [5] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_BOOTS"),
      [6] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_HELM"),
      [7] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_NECKLACE"),
      [8] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_RING"),
      [9] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_RING"),
      [10] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EARRING"),
      [11] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EARRING"),
      [12] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_WAISTBAND"),
      [13] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_LANTERN"),
      [14] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_AVATAR_UPPERBODY"),
      [15] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_AVATAR_GLOVES"),
      [16] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_AVATAR_BOOTS"),
      [17] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_AVATAR_HELM"),
      [18] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_AVATAR_MAINHAND"),
      [19] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_AVATAR_SUBHAND"),
      [29] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_awakenWeapon")
    },
    extendedSlotInfoArray = {},
    checkExtendedSlot = 0
  }
  target._ui.txt_useLimit_extendedslot_value:SetShow(false)
  if 1 == itemType then
    if self:getIsUsableClassType(itemSSW) then
      local itemName = itemSSW:getName()
      local slotNoMax = itemSSW:getExtendedSlotCount()
      local extendedSlotString = ""
      local compareSlot = {}
      local servantKindType = self:getUsableServantType(itemSSW)
      for i = 1, slotNoMax do
        local extendSlotNo = itemSSW:getExtendedSlotIndex(i - 1)
        if slotNoMax ~= extendSlotNo then
          equip.extendedSlotInfoArray[extendSlotNo] = i
          equip.checkExtendedSlot = 1
          compareSlot[i] = extendSlotNo
          local compareCheck = false
          if nil ~= servantKindType then
            if 1 == i then
              extendedSlotString = extendedSlotString .. ", " .. self._servantKindTypeString[servantKindType][extendSlotNo]
            elseif i > 1 then
              extendedSlotString = extendedSlotString .. ", " .. self._servantKindTypeString[servantKindType][extendSlotNo]
            end
          elseif 1 == i then
            extendedSlotString = extendedSlotString .. ", " .. equip.slotNoId[extendSlotNo]
          elseif i > 1 then
            extendedSlotString = extendedSlotString .. ", " .. equip.slotNoId[extendSlotNo]
          end
        end
      end
      if 1 == equip.checkExtendedSlot then
        local selfSlotNo = itemSSW:getEquipSlotNo()
        equip.extendedSlotInfoArray[selfSlotNo] = selfSlotNo
        if nil ~= servantKindType then
          target._ui.txt_useLimit_extendedslot_value:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EXTENDEDSLOT", "selfSlotNo", self._servantKindTypeString[servantKindType][selfSlotNo], "extendedSlotString", extendedSlotString))
        else
          target._ui.txt_useLimit_extendedslot_value:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EXTENDEDSLOT", "selfSlotNo", equip.slotNoId[selfSlotNo], "extendedSlotString", extendedSlotString))
        end
        target._ui.txt_useLimit_extendedslot_value:SetShow(true)
        useLimitShow = true
      else
        target._ui.txt_useLimit_extendedslot_value:SetShow(false)
      end
    else
      local itemName = itemSSW:getName()
      local slotNoMax = itemSSW:getExtendedSlotCount()
      local extendedSlotString = ""
      local compareSlot = {}
      local servantKindType = self:getUsableServantType(itemSSW)
      if nil ~= servantKindType then
        for i = 1, slotNoMax do
          local extendSlotNo = itemSSW:getExtendedSlotIndex(i - 1)
          if slotNoMax ~= extendSlotNo then
            equip.extendedSlotInfoArray[extendSlotNo] = i
            equip.checkExtendedSlot = 1
            compareSlot[i] = extendSlotNo
            local compareCheck = false
            if 1 == i then
              extendedSlotString = extendedSlotString .. ", " .. servantKindTypeString[servantKindType][extendSlotNo]
            elseif i > 1 then
              extendedSlotString = extendedSlotString .. ", " .. servantKindTypeString[servantKindType][extendSlotNo]
            end
          end
        end
      end
      if 1 == equip.checkExtendedSlot then
        local selfSlotNo = itemSSW:getEquipSlotNo()
        equip.extendedSlotInfoArray[selfSlotNo] = selfSlotNo
        target._ui.txt_useLimit_extendedslot_value:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EXTENDEDSLOT", "selfSlotNo", servantKindTypeString[servantKindType][selfSlotNo], "extendedSlotString", extendedSlotString))
        target._ui.txt_useLimit_extendedslot_value:SetShow(true)
        useLimitShow = true
      else
        target._ui.txt_useLimit_extendedslot_value:SetShow(false)
      end
    end
  end
  local classType = getSelfPlayer():getClassType()
  local isAllClass = true
  local classNameList
  for idx = 0, getCharacterClassCount() - 1 do
    local classType = getCharacterClassTypeByIndex(idx)
    local className = getCharacterClassName(classType)
    if nil ~= className and "" ~= className and " " ~= className then
      if itemSSW:get()._usableClassType:isOn(classType) then
        if nil == classNameList then
          classNameList = className
        else
          classNameList = classNameList .. ", " .. className
        end
      else
        isAllClass = false
      end
    end
  end
  if isAllClass or nil == classNameList then
    target._ui.txt_useLimit_class_value:SetShow(false)
    target._ui.txt_useLimit_class:SetShow(false)
  else
    useLimitShow = true
    target._ui.txt_useLimit_class_value:SetTextMode(__eTextMode_AutoWrap)
    target._ui.txt_useLimit_class_value:SetShow(true)
    target._ui.txt_useLimit_class:SetShow(true)
    local isUsableClass = itemSSW:get()._usableClassType:isOn(classType)
    if false == isUsableClass then
      target._ui.txt_useLimit_class_value:SetFontColor(Defines.Color.C_FFF26A6A)
    else
      target._ui.txt_useLimit_class_value:SetFontColor(Defines.Color.C_FFC4BEBE)
    end
    if nil ~= classNameList then
      target._ui.txt_useLimit_class_value:SetText("- " .. classNameList .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_CLASSONLY"))
    else
      target._ui.txt_useLimit_class_value:SetText(" ")
    end
  end
  if not isSSW then
    if item:getExpirationDate():isIndefinite() then
      target._ui.txt_remainTime_value:SetShow(false)
      target._ui.txt_remainTime:SetShow(false)
    else
      local s64_remainingTime = getLeftSecond_s64(item:getExpirationDate())
      local fontColor = Defines.Color.C_FFC4BEBE
      local itemExpiration = item:getExpirationDate()
      local leftPeriod = FromClient_getTradeItemExpirationDate(itemExpiration, itemWrapper:getStaticStatus():get()._expirationPeriod)
      if not itemSSW:get():isCash() and itemSSW:isTradeAble() then
        target._ui.txt_remainTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_REMAINTIME_PRICEREMAIN"))
      else
        target._ui.txt_remainTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_REMAINTIME_REMAINTIME"))
      end
      if Defines.s64_const.s64_0 == s64_remainingTime then
        if not itemSSW:get():isCash() and itemSSW:isTradeAble() then
          target._ui.txt_remainTime_value:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_REMAIN_TIME") .. " (" .. PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_MARKETPRICE") .. " : " .. leftPeriod / 10000 .. " %)")
        else
          target._ui.txt_remainTime_value:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_REMAIN_TIME"))
        end
        fontColor = Defines.Color.C_FFF26A6A
      elseif not itemSSW:get():isCash() and itemSSW:isTradeAble() then
        target._ui.txt_remainTime_value:SetText(convertStringFromDatetime(s64_remainingTime) .. " (" .. PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_MARKETPRICE") .. " : " .. leftPeriod / 10000 .. " %)")
      else
        target._ui.txt_remainTime_value:SetText(convertStringFromDatetime(s64_remainingTime))
      end
      target._ui.txt_remainTime_value:SetFontColor(fontColor)
      target._ui.txt_remainTime_value:SetShow(true)
      target._ui.txt_remainTime:SetShow(true)
      useLimitShow = true
    end
  else
    target._ui.txt_remainTime_value:SetShow(false)
    target._ui.txt_remainTime:SetShow(false)
  end
  target._ui.txt_useLimit_category:SetShow(false)
  target._ui.stc_useLimit_panel:SetShow(useLimitShow)
  local attackShow = false
  local statExtraParam1Show = false
  local statExtraParam2Show = false
  local statExtraParam3Show = false
  local defenseShow = false
  local attackString = ""
  local minAttack = 0
  local maxAttack = 0
  for idx = 0, 2 do
    local currentMin = itemSSW:getMinDamage(idx)
    if minAttack < currentMin then
      minAttack = currentMin
    end
    local currentMax = itemSSW:getMaxDamage(idx)
    if maxAttack < currentMax then
      maxAttack = currentMax
    end
  end
  if 0 ~= maxAttack and 0 ~= minAttack then
    attackShow = true
  end
  if 1 == itemSSW:getItemType() and 36 == itemSSW:getEquipType() then
    minAttack = itemSSW:getMinDamage(0)
    maxAttack = itemSSW:getMaxDamage(0)
  end
  minAttack = minAttack + itemaddedDD + itemRandomAddedDD
  maxAttack = maxAttack + itemaddedDD + itemRandomAddedDD
  if 57 == itemSSW:getEquipType() and true == itemSSW:get()._usableClassType:isOn(__eClassType_ShyWaman) then
    attackShow = false
    statExtraParam1Show = true
  end
  attackString = tostring(minAttack) .. " ~ " .. tostring(maxAttack)
  target._ui.txt_attack_value:SetText(attackString)
  target._ui.txt_attack_value:SetShow(attackShow)
  target._ui.txt_attack:SetShow(attackShow)
  target._att_Value = (maxAttack + minAttack) / 2
  target._ui.txt_statExtraParam1_value:SetText(attackString)
  target._ui.txt_statExtraParam1_value:SetShow(statExtraParam1Show)
  target._ui.txt_statExtraParam1:SetShow(statExtraParam1Show)
  target._ui.txt_statExtraParam2_value:SetShow(false)
  target._ui.txt_statExtraParam2:SetShow(false)
  target._ui.txt_statExtraParam3_value:SetShow(false)
  target._ui.txt_statExtraParam3:SetShow(false)
  local defenseString = ""
  local def_value = 0
  if itemType == 1 then
    for idx = 0, 2 do
      local currentdef_value = itemSSW:getDefence(idx) + itemaddedDV + itemaddedPV + itemRandomAddedDV + itemRandomAddedPV
      if 0 ~= currentdef_value then
        def_value = currentdef_value
      end
    end
  end
  if 0 ~= def_value then
    defenseShow = true
  end
  defenseString = tostring(def_value)
  target._ui.txt_defense_value:SetText(defenseString)
  target._ui.txt_defense_value:SetShow(defenseShow)
  target._ui.txt_defense:SetShow(defenseShow)
  target._def_Value = def_value
  local gotWeight = itemSSW:get()._weight
  local hit = 0
  local hitShow = false
  local hitString = ""
  for idx = 0, 2 do
    local currentHit = itemSSW:ToClient_getHit(idx)
    if hit < currentHit then
      hit = currentHit
    end
  end
  if 1 == itemSSW:getItemType() and 36 == itemSSW:getEquipType() then
    hit = itemSSW:ToClient_getHit(0)
  end
  hit = hit + itemaddedHit + itemRandomAddedHit
  if 0 ~= hit then
    hitShow = true
  end
  hitString = tostring(hit)
  target._ui.txt_hit_value:SetText(hitString)
  target._ui.txt_hit_value:SetShow(hitShow)
  target._ui.txt_hit:SetShow(hitShow)
  local dv = 0
  local hdv = 0
  local dvShow = false
  local dvString = ""
  if itemType == 1 then
    for idx = 0, 2 do
      local currnetDv = itemSSW:ToClient_getDV(idx)
      if 0 ~= currnetDv then
        dv = currnetDv
      end
      local currentHDV = itemSSW:ToClient_getHDV(idx)
      if 0 ~= currentHDV then
        hdv = currentHDV
      end
    end
  end
  dv = dv + itemaddedDV + itemRandomAddedDV
  if 0 ~= dv + hdv + itemaddedHDV + itemRandomAddedHDV then
    dvShow = true
  end
  if 0 ~= hdv + itemaddedHDV + itemRandomAddedHDV then
    dvString = tostring(dv) .. " (+" .. tostring(hdv + itemaddedHDV + itemRandomAddedHDV) .. ")"
  else
    dvString = tostring(dv)
  end
  target._ui.txt_dv_value:SetText(dvString)
  target._ui.txt_dv_value:SetShow(dvShow)
  target._ui.txt_dv:SetShow(dvShow)
  local pv = 0
  local hpv = 0
  local pvShow = false
  local pvString = ""
  if itemType == 1 then
    for idx = 0, 2 do
      local currentPv = itemSSW:ToClient_getPV(idx)
      if 0 ~= currentPv then
        pv = currentPv
      end
      local currentHPv = itemSSW:ToClient_getHPV(idx)
      if 0 ~= currentHPv then
        hpv = currentHPv
      end
    end
  end
  pv = pv + itemaddedPV + itemRandomAddedPV
  if 0 ~= pv + hpv + itemaddedHPV then
    pvShow = true
  end
  if 0 ~= hpv + itemaddedHPV + itemRandomAddedHPV then
    pvString = tostring(pv) .. " (+" .. tostring(hpv + itemaddedHPV + itemRandomAddedHPV) .. ")"
  else
    pvString = tostring(pv)
  end
  target._ui.txt_pv_value:SetText(pvString)
  target._ui.txt_pv_value:SetShow(pvShow)
  target._ui.txt_pv:SetShow(pvShow)
  if gotWeight > 99 then
    target._ui.txt_weight:SetShow(true)
    target._ui.txt_weight_value:SetShow(true)
    target._ui.txt_weight_value:SetText(makeWeightString(gotWeight, 2) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
  else
    target._ui.txt_weight:SetShow(true)
    target._ui.txt_weight_value:SetShow(true)
    target._ui.txt_weight_value:SetText(makeWeightString(gotWeight, 2) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
  end
  target._wei_Value = gotWeight / 10000
  if itemSSW:get():isCash() then
    target._ui.txt_weight:SetShow(false)
    target._ui.txt_weight_value:SetShow(false)
  end
  if self._EQUIPTOOLTIP._mainPanel:GetShow() then
    local _weightPoint = 0
    local _offencePoint = 0
    local _defencePoint = 0
    if 0 == self._NORMALTOOLTIP._att_Value then
      _offencePoint = 0
    else
      _offencePoint = self._NORMALTOOLTIP._att_Value - self._EQUIPTOOLTIP._att_Value
    end
    if 0 == self._NORMALTOOLTIP._def_Value then
      _defencePoint = 0
    else
      _defencePoint = self._NORMALTOOLTIP._def_Value - self._EQUIPTOOLTIP._def_Value
    end
    _weightPoint = self._NORMALTOOLTIP._wei_Value - self._EQUIPTOOLTIP._wei_Value
    if _weightPoint > 0 then
      _weightPoint = "<PAColor0xFFFF0000>\226\150\178" .. string.format("%.2f", _weightPoint) .. "<PAOldColor>"
    elseif _weightPoint < 0 then
      _weightPoint = "<PAColor0xFFFFCE22>\226\150\188" .. string.format("%.2f", _weightPoint * -1) .. "<PAOldColor>"
    end
    if 0 ~= _offencePoint and 0 == _defencePoint then
      if _offencePoint > 0 then
        _offencePoint = "<PAColor0xFFFFCE22>\226\150\178" .. _offencePoint .. "<PAOldColor>"
      elseif _offencePoint < 0 then
        _offencePoint = "<PAColor0xFFFF0000>\226\150\188" .. _offencePoint * -1 .. "<PAOldColor>"
      end
      attackString = "(" .. _offencePoint .. " )"
      self._NORMALTOOLTIP._ui.txt_attack_diffValue:SetText(attackString)
      self._NORMALTOOLTIP._ui.txt_attack_diffValue:SetShow(true)
      self._NORMALTOOLTIP._ui.txt_defense_diffValue:SetText("")
      self._NORMALTOOLTIP._ui.txt_defense_diffValue:SetShow(false)
    elseif 0 ~= _offencePoint and 0 ~= _defencePoint then
      if _offencePoint > 0 then
        _offencePoint = "<PAColor0xFFFFCE22>\226\150\178" .. _offencePoint .. "<PAOldColor>"
      elseif _offencePoint < 0 then
        _offencePoint = "<PAColor0xFFFF0000>\226\150\188" .. _offencePoint * -1 .. "<PAOldColor>"
      end
      if _defencePoint > 0 then
        _defencePoint = "<PAColor0xFFFFCE22>\226\150\178" .. _defencePoint .. "<PAOldColor>"
      elseif _defencePoint < 0 then
        _defencePoint = "<PAColor0xFFFF0000>\226\150\188" .. _defencePoint * -1 .. "<PAOldColor>"
      end
      attackString = "(" .. _offencePoint .. " )"
      self._NORMALTOOLTIP._ui.txt_attack_diffValue:SetText(attackString)
      defenseString = "(" .. _defencePoint .. " )"
      self._NORMALTOOLTIP._ui.txt_defense_diffValue:SetText(defenseString)
      self._NORMALTOOLTIP._ui.txt_attack_diffValue:SetShow(true)
      self._NORMALTOOLTIP._ui.txt_defense_diffValue:SetShow(true)
    elseif 0 == _offencePoint and 0 ~= _defencePoint then
      if _defencePoint > 0 then
        _defencePoint = "<PAColor0xFFFFCE22>\226\150\178" .. _defencePoint .. "<PAOldColor>"
      elseif _defencePoint < 0 then
        _defencePoint = "<PAColor0xFFFF0000>\226\150\188" .. _defencePoint * -1 .. "<PAOldColor>"
      end
      defenseString = "(" .. _defencePoint .. " )"
      self._NORMALTOOLTIP._ui.txt_defense_diffValue:SetText(defenseString)
      self._NORMALTOOLTIP._ui.txt_attack_diffValue:SetText("")
      self._NORMALTOOLTIP._ui.txt_attack_diffValue:SetShow(false)
      self._NORMALTOOLTIP._ui.txt_defense_diffValue:SetShow(true)
    else
      self._NORMALTOOLTIP._ui.txt_attack_diffValue:SetShow(false)
      self._NORMALTOOLTIP._ui.txt_defense_diffValue:SetShow(false)
    end
    if 0 ~= _weightPoint then
      self._NORMALTOOLTIP._ui.txt_weight_diffValue:SetText(" (" .. _weightPoint .. " )")
      self._NORMALTOOLTIP._ui.txt_weight_diffValue:SetShow(true)
    end
    if 0 == self._NORMALTOOLTIP._att_Value and 0 == self._NORMALTOOLTIP._def_Value then
      self._NORMALTOOLTIP._ui.txt_attack_diffValue:SetShow(false)
      self._NORMALTOOLTIP._ui.txt_defense_diffValue:SetShow(false)
      self._NORMALTOOLTIP._ui.txt_weight_diffValue:SetShow(false)
    end
  else
    self._NORMALTOOLTIP._ui.txt_attack_diffValue:SetShow(false)
    self._NORMALTOOLTIP._ui.txt_defense_diffValue:SetShow(false)
    self._NORMALTOOLTIP._ui.txt_weight_diffValue:SetShow(false)
  end
  local soketCount = 0
  if false == itemSSW:get():getEnchant():empty() then
    soketCount = itemSSW:get():getEnchant()._socketCount
  end
  local itemEnchantSSW
  if not isSSW then
    soketCount = item:getUsableItemSocketCount()
  end
  local socketMaxCount = ToClient_GetMaxItemSocketCount()
  for jewelIdx = 0, 5 do
    if jewelIdx < socketMaxCount - 1 then
      if not isSSW then
        itemEnchantSSW = itemWrapper:getPushedItem(jewelIdx)
      else
        itemEnchantSSW = nil
        if isItemWrapper or nil ~= chattingLinkedItem then
          local pushedKey
          if isItemWrapper then
            pushedKey = item:getPushedKey(jewelIdx)
          elseif nil ~= chattingLinkedItem then
            pushedKey = chattingLinkedItem:getPushedKey(jewelIdx)
          end
          if pushedKey ~= nil and 0 < pushedKey:get() then
            itemEnchantSSW = getItemEnchantStaticStatus(pushedKey)
          end
        end
      end
      if target ~= self._EQUIPTOOLTIP and nil ~= self._dataObject.itemMarket then
        itemEnchantSSW = nil
      end
      if jewelIdx >= soketCount then
        target._ui.txt_soketName[jewelIdx + 1]:SetShow(false)
        target._ui.txt_soketEffect[jewelIdx + 1]:SetShow(false)
        target._ui.stc_soketSlot[jewelIdx + 1]:SetShow(false)
      elseif nil ~= itemEnchantSSW then
        target._ui.txt_soketName[jewelIdx + 1]:SetShow(true)
        target._ui.txt_soketEffect[jewelIdx + 1]:SetShow(true)
        target._ui.stc_soketSlot[jewelIdx + 1]:SetShow(true)
        target._ui.txt_soketName[jewelIdx + 1]:SetText(itemEnchantSSW:getName())
        target._ui.stc_soketSlot[jewelIdx + 1]:ChangeTextureInfoName("icon/" .. itemEnchantSSW:getIconPath())
        local x1, y1, x2, y2 = setTextureUV_Func(target._ui.stc_soketSlot[jewelIdx + 1], 0, 0, 42, 42)
        target._ui.stc_soketSlot[jewelIdx + 1]:getBaseTexture():setUV(x1, y1, x2, y2)
        target._ui.stc_soketSlot[jewelIdx + 1]:setRenderTexture(target._ui.stc_soketSlot[jewelIdx + 1]:getBaseTexture())
        local skillSSW
        if nil ~= itemEnchantSSW and nil ~= classType then
          skillSSW = itemEnchantSSW:getSkillByIdx(classType)
        end
        if nil == skillSSW then
          target._ui.txt_soketEffect[jewelIdx + 1]:SetText(" ")
        else
          local buffList = ""
          for buffIdx = 0, skillSSW:getBuffCount() - 1 do
            local desc = skillSSW:getBuffDescription(buffIdx)
            if nil == desc or "" == desc then
              break
            end
            if nil == buffList or "" == buffList then
              buffList = desc
            else
              buffList = buffList .. " / " .. desc
            end
          end
          target._ui.txt_soketEffect[jewelIdx + 1]:SetText(buffList)
        end
      else
        target._ui.txt_soketName[jewelIdx + 1]:SetShow(true)
        target._ui.txt_soketEffect[jewelIdx + 1]:SetShow(true)
        target._ui.stc_soketSlot[jewelIdx + 1]:SetShow(true)
        target._ui.txt_soketName[jewelIdx + 1]:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EMPTY_SLOT"))
        target._ui.txt_soketEffect[jewelIdx + 1]:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EMPTY_SLOT_DESC"))
        target._ui.stc_soketSlot[jewelIdx + 1]:ChangeTextureInfoName(" ")
      end
    else
      target._ui.txt_soketName[jewelIdx + 1]:SetShow(false)
      target._ui.txt_soketEffect[jewelIdx + 1]:SetShow(false)
      target._ui.stc_soketSlot[jewelIdx + 1]:SetShow(false)
    end
  end
  target._ui.stc_soketOption_panel:SetShow(0 ~= soketCount)
  target._ui.txt_useLimit_exp:SetShow(false)
  target._ui.stc_useLimit_exp_gage:SetShow(false)
  target._ui.progress_useLimit_exp:SetShow(false)
  target._ui.txt_useLimit_exp_value:SetShow(false)
  if _ContentsGroup_AlchemyStone or _ContentsGroup_AlchemyFigureHead or _ContentsGroup_QuestBook then
    if nil ~= itemWrapper and (32 == itemSSW:get():getContentsEventType() or 37 == itemSSW:get():getContentsEventType()) then
      local alchemyStoneType = itemWrapper:getStaticStatus():get()._contentsEventParam1
      if alchemyStoneType < 3 then
        local alchemystoneExp = itemWrapper:getExperience() / 10000
        target._ui.txt_useLimit_exp:SetShow(true)
        target._ui.stc_useLimit_exp_gage:SetShow(true)
        target._ui.progress_useLimit_exp:SetShow(true)
        target._ui.txt_useLimit_exp_value:SetShow(true)
        target._ui.txt_useLimit_exp_value:SetText(string.format("%.2f", alchemystoneExp) .. "%")
        target._ui.progress_useLimit_exp:SetCurrentProgressRate(alchemystoneExp)
        target._ui.progress_useLimit_exp:SetProgressRate(alchemystoneExp)
        target._ui.progress_useLimit_exp:SetAniSpeed(0)
      end
    elseif nil ~= itemWrapper and CppEnums.ContentsEventType.ContentsType_QuestBook == itemSSW:get():getContentsEventType() then
      local dstExp = itemWrapper:getExperience() / 15000
      target._ui.txt_useLimit_exp:SetShow(true)
      target._ui.stc_useLimit_exp_gage:SetShow(true)
      target._ui.progress_useLimit_exp:SetShow(true)
      target._ui.txt_useLimit_exp_value:SetShow(true)
      target._ui.txt_useLimit_exp_value:SetText(string.format("%.2f", dstExp) .. "%")
      target._ui.progress_useLimit_exp:SetCurrentProgressRate(dstExp)
      target._ui.progress_useLimit_exp:SetProgressRate(dstExp)
      target._ui.progress_useLimit_exp:SetAniSpeed(0)
    end
  end
  local maxEndurance = 32767
  local dynamicMaxEndurance = 32767
  if false == itemSSW:get():isUnbreakable() then
    maxEndurance = itemSSW:get():getMaxEndurance()
  end
  if not isSSW then
    dynamicMaxEndurance = item:getMaxEndurance()
  end
  local currentEndurance = maxEndurance
  if not isSSW then
    currentEndurance = item:getEndurance()
  end
  local calcEndurance = currentEndurance / maxEndurance
  local calcDynamicEndurance = dynamicMaxEndurance / maxEndurance
  target._ui.progress_useLimit_endurance:SetCurrentProgressRate(calcEndurance * 100)
  target._ui.progress_useLimit_endurance:SetProgressRate(calcEndurance * 100)
  target._ui.progress_useLimit_endurance:SetAniSpeed(0)
  target._ui.progress_useLimit_maxEurance:SetCurrentProgressRate(calcDynamicEndurance * 100)
  target._ui.progress_useLimit_maxEurance:SetProgressRate(calcDynamicEndurance * 100)
  target._ui.progress_useLimit_maxEurance:SetAniSpeed(0)
  if 32767 ~= dynamicMaxEndurance then
    target._ui.txt_useLimit_endurance_value:SetText(currentEndurance .. " / " .. dynamicMaxEndurance .. "  [" .. maxEndurance .. "]")
    target._ui.txt_useLimit_endurance:SetShow(true)
    target._ui.txt_useLimit_endurance_value:SetShow(true)
    target._ui.progress_useLimit_endurance:SetShow(true)
    target._ui.progress_useLimit_maxEurance:SetShow(true)
    target._ui.stc_useLimit_endurance_gage:SetShow(true)
  elseif 32767 ~= maxEndurance then
    target._ui.txt_useLimit_endurance_value:SetText(currentEndurance .. " / " .. maxEndurance)
    target._ui.txt_useLimit_endurance:SetShow(true)
    target._ui.txt_useLimit_endurance_value:SetShow(true)
    target._ui.progress_useLimit_endurance:SetShow(true)
    target._ui.progress_useLimit_maxEurance:SetShow(false)
    target._ui.stc_useLimit_endurance_gage:SetShow(true)
  else
    target._ui.txt_useLimit_endurance:SetShow(false)
    target._ui.txt_useLimit_endurance_value:SetShow(false)
    target._ui.progress_useLimit_endurance:SetShow(false)
    target._ui.progress_useLimit_maxEurance:SetShow(false)
    target._ui.stc_useLimit_endurance_gage:SetShow(false)
  end
  if true == _ContentsGroup_NewUI_InstallMode_All then
    if true == PaGlobal_House_Installation_All_GetPanelShow() then
      target._ui.txt_useLimit_endurance:SetShow(false)
      target._ui.txt_useLimit_endurance_value:SetShow(false)
      target._ui.progress_useLimit_endurance:SetShow(false)
      target._ui.progress_useLimit_maxEurance:SetShow(false)
      target._ui.stc_useLimit_endurance_gage:SetShow(false)
    end
  elseif Panel_House_InstallationMode:GetShow() then
    target._ui.txt_useLimit_endurance:SetShow(false)
    target._ui.txt_useLimit_endurance_value:SetShow(false)
    target._ui.progress_useLimit_endurance:SetShow(false)
    target._ui.progress_useLimit_maxEurance:SetShow(false)
    target._ui.stc_useLimit_endurance_gage:SetShow(false)
  end
  local checkEnduranceShowItem = function(itemKey)
    if 17591 == itemKey or 17592 == itemKey or 17596 == itemKey or 17612 == itemKey or 17613 == itemKey or 17669 == itemKey or 570001 == itemKey or 570002 == itemKey or 18861 == itemKey or 18862 == itemKey then
      return true
    else
      return false
    end
  end
  if nil ~= itemWrapper then
    local isCash = itemWrapper:getStaticStatus():get():isCash()
    if true == isCash and false == checkEnduranceShowItem(itemSSW:get()._key:getItemKey()) then
      target._ui.txt_useLimit_endurance:SetShow(false)
      target._ui.txt_useLimit_endurance_value:SetShow(false)
      target._ui.progress_useLimit_endurance:SetShow(false)
      target._ui.progress_useLimit_maxEurance:SetShow(false)
      target._ui.stc_useLimit_endurance_gage:SetShow(false)
    end
  end
  if nil ~= itemSSW then
    local isCash = itemSSW:get():isCash()
    local balksCount = itemSSW:getExtractionCount_s64()
    local cronsCount = itemSSW:getCronCount_s64()
    if true == isCash and false == checkEnduranceShowItem(itemSSW:get()._key:getItemKey()) then
      target._ui.txt_useLimit_endurance:SetShow(false)
      target._ui.txt_useLimit_endurance_value:SetShow(false)
      target._ui.progress_useLimit_endurance:SetShow(false)
      target._ui.progress_useLimit_maxEurance:SetShow(false)
      target._ui.stc_useLimit_endurance_gage:SetShow(false)
    end
    if false == isCash and nil ~= balksCount and toInt64(0, 0) ~= balksCount and nil ~= cronsCount and toInt64(0, 0) ~= cronsCount then
      target._ui.txt_useLimit_endurance:SetShow(false)
      target._ui.txt_useLimit_endurance_value:SetShow(false)
      target._ui.progress_useLimit_endurance:SetShow(false)
      target._ui.progress_useLimit_maxEurance:SetShow(false)
      target._ui.stc_useLimit_endurance_gage:SetShow(false)
    end
  end
  target._ui.txt_enchantDifficulty:SetShow(false)
  if nil ~= itemSSW then
    local enchantDifficulty = itemSSW:get():getEnchantDifficulty()
    if enchantDifficulty > __eEnchantDifficulty_None and not _ContentsGroup_RenewUI then
      target._ui.txt_enchantDifficulty:SetShow(true)
      if __eEnchantDifficulty_Easy == enchantDifficulty then
        target._ui.txt_enchantDifficulty:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ENCHANTDIFFICULTY_EASY"))
      elseif __eEnchantDifficulty_Normal == enchantDifficulty then
        target._ui.txt_enchantDifficulty:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ENCHANTDIFFICULTY_NORMAL"))
      elseif __eEnchantDifficulty_Hard == enchantDifficulty or __eEnchantDifficulty_NotExtractHard == enchantDifficulty then
        target._ui.txt_enchantDifficulty:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ENCHANTDIFFICULTY_HARD"))
      end
    end
  end
  target._ui.txt_soulCollector:SetShow(false)
  if true == self._dataObject.inventory and nil ~= itemWrapper then
    local isSoulCollecTor = itemWrapper:isSoulCollector()
    if true == isSoulCollecTor then
      target._ui.txt_soulCollector:SetShow(true)
      local countSoul
      if itemWrapper:getSoulCollectorMaxCount() < itemWrapper:getSoulCollectorCount() then
        countSoul = itemWrapper:getSoulCollectorMaxCount()
      else
        countSoul = itemWrapper:getSoulCollectorCount()
      end
      target._ui.txt_soulCollector:SetText("- " .. PAGetString(Defines.StringSheet_GAME, "LUA_SOULCOLLECTOR_STATE") .. " : " .. tostring(countSoul) .. "/" .. tostring(itemWrapper:getSoulCollectorMaxCount()))
    end
  end
  local isNodeFreeTrade = itemSSW:get():isNodeFreeTrade()
  if true == itemSSW:get():isForJustTrade() and not isSSW then
    if isNodeFreeTrade then
      target._ui.txt_itemProducedPlace:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_PRODUCT_PLACE") .. " : " .. itemWrapper:getProductionRegion())
    else
      local nodeLevel = ToClient_GetNodeLevel(itemWrapper:getProductionRegionKey())
      if nodeLevel >= 1 then
        target._ui.txt_itemProducedPlace:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_PRODUCT_PLACE") .. " : " .. itemWrapper:getProductionRegion() .. " (" .. PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_LINK") .. ")")
      else
        target._ui.txt_itemProducedPlace:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_PRODUCT_PLACE") .. " : " .. itemWrapper:getProductionRegion() .. " (" .. PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_NOLINK") .. ")")
      end
    end
  else
    target._ui.txt_itemProducedPlace:SetText("")
  end
  if true == _ContentsGroup_OceanCurrent then
    if __eServantSupplyItemType_Food == itemSSW:getServantSupplyItemType() then
      target._ui.txt_supplyValue:SetShow(true)
      target._ui.txt_supplyValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_SUPPLYITEM_FOOD", "value", makeDotMoney(itemSSW:getServantSupplyItemValue())))
    elseif __eServantSupplyItemType_Cannon == itemSSW:getServantSupplyItemType() then
      target._ui.txt_supplyValue:SetShow(true)
      target._ui.txt_supplyValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_SUPPLYITEM_CANNON", "value", makeDotMoney(itemSSW:getServantSupplyItemValue())))
    else
      target._ui.txt_supplyValue:SetShow(false)
    end
  else
    target._ui.txt_supplyValue:SetShow(false)
  end
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_DESC_TITLE") .. " " .. itemSSW:getDescription()
  if isNodeFreeTrade then
    _desc = _desc .. " " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOOLTIP_ITEM_NODEFREETRADE_DESC")
  end
  if itemType == 2 and true == itemSSW:get():isForJustTrade() then
    _desc = _desc .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_DESC_TRADEITEM")
  end
  if "" ~= itemSSW:getEnchantDescription() then
    _desc = _desc .. [[


- ]] .. itemSSW:getEnchantDescription()
  end
  target._ui.txt_itemDescription:SetText(_desc)
  if _ContentsGroup_RenewUI then
    target._ui.txt_itemDescription:SetShow(false)
  end
  local isExchangeItem = itemSSW:isExchangeItem()
  local exchangeDesc = ""
  if isExchangeItem and not _ContentsGroup_RenewUI then
    target._ui.txt_exchangeTitle:SetShow(true)
    target._ui.txt_exchangeDesc:SetShow(true)
    target._ui.txt_exchangeDesc:SetText(itemSSW:getExchangeDescription())
  else
    target._ui.txt_exchangeTitle:SetShow(false)
    target._ui.txt_exchangeDesc:SetShow(false)
    target._ui.txt_exchangeDesc:SetText("")
  end
  local _const = Defines.s64_const
  local isTradeItem = itemSSW:isTradeAble()
  if isTradeItem == true and not isSSW then
    if item:getBuyingPrice_s64() > _const.s64_0 then
      target._ui.txt_itemPrice_transportBuy_value:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_AUCTION_GOLDTEXT") .. " " .. tostring(makeDotMoney(item:getBuyingPrice_s64())))
    else
      target._ui.txt_itemPrice_transportBuy_value:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_NOTHING"))
    end
    target._ui.txt_itemPrice_transportBuy:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_TRADE_BUY_PRICE") .. " : ")
    target._ui.txt_itemPrice_transportBuy:SetFontColor(4287137928)
    target._ui.txt_itemPrice_transportBuy:SetShow(true)
    target._ui.txt_itemPrice_transportBuy_value:SetShow(true)
    target._ui.stc_itemPrice_panel:SetSize(target._ui.stc_itemPrice_panel:GetSizeX(), 50)
    target._ui.txt_itemPrice_transportBuy_value:SetSpanSize(target._ui.txt_itemPrice_transportBuy:GetTextSizeX() + 20, 0)
  else
    target._ui.txt_itemPrice_transportBuy:SetText("")
    target._ui.txt_itemPrice_transportBuy:SetFontColor(4290733156)
    target._ui.txt_itemPrice_transportBuy:SetShow(true)
    target._ui.txt_itemPrice_transportBuy_value:SetShow(false)
    target._ui.stc_itemPrice_panel:SetSize(target._ui.stc_itemPrice_panel:GetSizeX(), 30)
    target._ui.txt_itemPrice_transportBuy_value:SetSpanSize(target._ui.txt_itemPrice_transportBuy:GetTextSizeX() + 20, 0)
  end
  local s64_originalPrice = itemSSW:get()._originalPrice_s64
  local s64_sellPrice = itemSSW:get()._sellPriceToNpc_s64
  if isTradeItem then
    target._ui.txt_itemPrice_storeSell:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_TRADE_ORIGINAL_PRICE") .. ":")
    if s64_originalPrice > _const.s64_0 and 0 == enchantLevel then
      if __ePriceType_Shell == itemSSW:getTradePriceType() then
        target._ui.txt_itemPrice_storeSell_value:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_AUCTION_SEASHELL") .. " " .. tostring(makeDotMoney(s64_originalPrice)))
      else
        target._ui.txt_itemPrice_storeSell_value:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_AUCTION_GOLDTEXT") .. " " .. tostring(makeDotMoney(s64_originalPrice)))
      end
      target._ui.txt_itemPrice_storeSell_value:SetFontColor(4292726146)
    else
      target._ui.txt_itemPrice_storeSell_value:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_NOT_SELLING_ITEM"))
      target._ui.txt_itemPrice_storeSell_value:SetFontColor(4290733156)
    end
  else
    target._ui.txt_itemPrice_storeSell:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_SELL_PRICE") .. " : ")
    if s64_sellPrice > _const.s64_0 and 0 == enchantLevel then
      local priceString = "LUA_AUCTION_GOLDTEXT"
      if true == itemSSW:isTradePrice() then
        priceString = "LUA_AUCTION_SEASHELL"
      end
      target._ui.txt_itemPrice_storeSell_value:SetText(PAGetString(Defines.StringSheet_GAME, priceString) .. " " .. tostring(makeDotMoney(s64_sellPrice)))
      target._ui.txt_itemPrice_storeSell_value:SetFontColor(4292726146)
    else
      target._ui.txt_itemPrice_storeSell_value:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_NOT_SELLING_ITEM"))
      target._ui.txt_itemPrice_storeSell_value:SetFontColor(4290733156)
    end
  end
  target._ui.txt_itemPrice_storeSell_value:SetSpanSize(target._ui.txt_itemPrice_storeSell:GetTextSizeX() + 20, 0)
  local bottomTarget = self:showPosisionSetting(target, attackShow, defenseShow, hitShow, dvShow, pvShow, statExtraParam1Show, statExtraParam2Show, statExtraParam3Show, changeItemNamePos)
  self:setTooltipPos(target, item, itemSSW, itemWrapper, bottomTarget, changeItemNamePos, iconMovePos, elementgap, dynamicMaxEndurance, chattingLinkedItem, useLimitShow, soketCount)
  return itemType == 1, (itemSSW:isUsableServant())
end
function PaGlobal_Tooltip_Control_All:setEnchantLevel(target, itemSSW)
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  if 0 < ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key) then
    enchantLevel = ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key)
  end
  local isEnchantLevel5 = false
  if 0 < enchantLevel and enchantLevel < 16 then
    target._ui.txt_enchantLevel:SetText("+" .. tostring(enchantLevel))
    target._ui.txt_enchantLevel:SetShow(true)
  elseif 16 == enchantLevel then
    target._ui.txt_enchantLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_1"))
    if true == _ContentsGroup_KoreanEnchantGrade then
      target._ui.txt_enchantLevel:SetText("\236\158\165")
    end
    target._ui.txt_enchantLevel:SetShow(true)
  elseif 17 == enchantLevel then
    target._ui.txt_enchantLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_2"))
    if true == _ContentsGroup_KoreanEnchantGrade then
      target._ui.txt_enchantLevel:SetText("\234\180\145")
    end
    target._ui.txt_enchantLevel:SetShow(true)
  elseif 18 == enchantLevel then
    target._ui.txt_enchantLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_3"))
    if true == _ContentsGroup_KoreanEnchantGrade then
      target._ui.txt_enchantLevel:SetText("\234\179\160")
    end
    target._ui.txt_enchantLevel:SetShow(true)
  elseif 19 == enchantLevel then
    target._ui.txt_enchantLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_4"))
    if true == _ContentsGroup_KoreanEnchantGrade then
      target._ui.txt_enchantLevel:SetText("\236\156\160")
    end
    target._ui.txt_enchantLevel:SetShow(true)
  elseif 20 == enchantLevel then
    target._ui.txt_enchantLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_5"))
    if true == _ContentsGroup_KoreanEnchantGrade then
      target._ui.txt_enchantLevel:SetText("\235\143\153")
    end
    target._ui.txt_enchantLevel:SetShow(true)
    isEnchantLevel5 = true
  else
    target._ui.txt_enchantLevel:SetShow(false)
  end
  if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() and false == itemSSW:isSpecialEnchantItem() then
    if 1 == enchantLevel then
      target._ui.txt_enchantLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_1"))
      if true == _ContentsGroup_KoreanEnchantGrade then
        target._ui.txt_enchantLevel:SetText("\236\158\165")
      end
      target._ui.txt_enchantLevel:SetShow(true)
    elseif 2 == enchantLevel then
      target._ui.txt_enchantLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_2"))
      if true == _ContentsGroup_KoreanEnchantGrade then
        target._ui.txt_enchantLevel:SetText("\234\180\145")
      end
      target._ui.txt_enchantLevel:SetShow(true)
    elseif 3 == enchantLevel then
      target._ui.txt_enchantLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_3"))
      if true == _ContentsGroup_KoreanEnchantGrade then
        target._ui.txt_enchantLevel:SetText("\234\179\160")
      end
      target._ui.txt_enchantLevel:SetShow(true)
    elseif 4 == enchantLevel then
      target._ui.txt_enchantLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_4"))
      if true == _ContentsGroup_KoreanEnchantGrade then
        target._ui.txt_enchantLevel:SetText("\236\156\160")
      end
      target._ui.txt_enchantLevel:SetShow(true)
    elseif 5 == enchantLevel then
      target._ui.txt_enchantLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_5"))
      if true == _ContentsGroup_KoreanEnchantGrade then
        target._ui.txt_enchantLevel:SetText("\235\143\153")
      end
      target._ui.txt_enchantLevel:SetShow(true)
      isEnchantLevel5 = true
    end
  end
end
function PaGlobal_Tooltip_Control_All:setTooltipPos(target, item, itemSSW, itemWrapper, bottomTarget, changeItemNamePos, iconMovePos, elementgap, dynamicMaxEndurance, chattingLinkedItem, useLimitShow, soketCount)
  local elementBiggap = 10
  local elementgap = 2
  local TooltipYPos = 10
  target._mainPanel:SetSize(target._mainPanel:GetSizeX(), target._panelSize - 30 * (6 - soketCount - 1))
  target._ui.stc_soketOption_panel:SetSize(target._ui.stc_soketOption_panel:GetSizeX(), target._socketSize - 30 * (6 - soketCount))
  target._ui.txt_itemProducedPlace:ComputePos()
  target._ui.txt_itemDescription:ComputePos()
  target._ui.stc_itemPrice_panel:ComputePos()
  target._ui.txt_itemPrice_transportBuy:ComputePos()
  target._ui.txt_itemPrice_transportBuy_value:ComputePos()
  target._ui.txt_itemPrice_storeSell:ComputePos()
  target._ui.txt_itemPrice_storeSell_value:ComputePos()
  target._ui.txt_supplyValue:ComputePos()
  target._ui.txt_itemType:SetPosY(8)
  if 0 == bottomTarget then
    local iconPosY = target._ui.txt_itemName:GetPosY() + target._ui.txt_itemName:GetTextSizeY()
    target._ui.stc_itemIcon:SetPosY(iconPosY + 5)
    local iconPosY = target._ui.stc_itemIcon:GetPosY()
    local iconSizeY = target._ui.stc_itemIcon:GetSizeY()
    target._ui.txt_weight:SetPosY(iconPosY + iconSizeY - 15)
    target._ui.txt_weight_value:SetPosY(iconPosY + iconSizeY - 15)
  else
    if 1 == bottomTarget then
      TooltipYPos = self:getBottomPos(target._ui.txt_attack) + elementgap
    elseif 2 == bottomTarget then
      TooltipYPos = self:getBottomPos(target._ui.txt_hit) + elementgap
    elseif 3 == bottomTarget then
      TooltipYPos = self:getBottomPos(target._ui.txt_defense) + elementgap
    elseif 4 == bottomTarget then
      TooltipYPos = self:getBottomPos(target._ui.txt_dv) + elementgap
    elseif 5 == bottomTarget then
      TooltipYPos = self:getBottomPos(target._ui.txt_pv) + elementgap
    elseif 6 == bottomTarget then
      TooltipYPos = self:getBottomPos(target._ui.txt_statExtraParam1) + elementgap
    elseif 7 == bottomTarget then
      TooltipYPos = self:getBottomPos(target._ui.txt_statExtraParam2) + elementgap
    elseif 8 == bottomTarget then
      TooltipYPos = self:getBottomPos(target._ui.txt_statExtraParam3) + elementgap
    end
    local iconSizeY = target._ui.stc_itemIcon:GetSizeY()
    local iconPosY = target._ui.txt_itemName:GetPosY() + target._ui.txt_itemName:GetTextSizeY()
    target._ui.stc_itemIcon:SetPosY((iconPosY + TooltipYPos) / 2 - 10)
    target._ui.txt_weight:SetPosY(TooltipYPos)
    target._ui.txt_weight_value:SetPosY(TooltipYPos - 20)
  end
  target._ui.txt_dying:SetPosY(target._ui.txt_weight_value:GetPosY() + target._ui.txt_weight_value:GetTextSizeY() + elementgap)
  TooltipYPos = self:getBottomPos(target._ui.txt_weight_value) + elementgap
  local itemiconPosY = self:getBottomPos(target._ui.stc_itemIcon) + elementgap
  if TooltipYPos < itemiconPosY then
    TooltipYPos = itemiconPosY
  end
  local iconPosY = target._ui.stc_itemIcon:GetPosY()
  local iconSizeY = target._ui.stc_itemIcon:GetSizeY()
  local enchantSizeY = target._ui.txt_enchantLevel:GetSizeY()
  target._ui.txt_enchantLevel:SetPosY(iconPosY)
  if self._NORMALTOOLTIP._ui.txt_attack_diffValue:GetShow() then
    self._NORMALTOOLTIP._ui.txt_attack_diffValue:SetPosX(self._NORMALTOOLTIP._ui.txt_attack_value:GetPosX() + self._NORMALTOOLTIP._ui.txt_attack_value:GetTextSizeX() + 10)
    self._NORMALTOOLTIP._ui.txt_attack_diffValue:SetPosY(self._NORMALTOOLTIP._ui.txt_attack_value:GetPosY() + 7)
  end
  if self._NORMALTOOLTIP._ui.txt_defense_diffValue:GetShow() then
    self._NORMALTOOLTIP._ui.txt_defense_diffValue:SetPosX(self._NORMALTOOLTIP._ui.txt_defense_value:GetPosX() + self._NORMALTOOLTIP._ui.txt_defense_value:GetTextSizeX() + 10)
    self._NORMALTOOLTIP._ui.txt_defense_diffValue:SetPosY(self._NORMALTOOLTIP._ui.txt_defense_value:GetPosY() + 7)
  end
  self._NORMALTOOLTIP._ui.txt_weight_value:ComputePos()
  if self._NORMALTOOLTIP._ui.txt_weight_diffValue:GetShow() then
    self._NORMALTOOLTIP._ui.txt_weight_diffValue:SetPosY(self._NORMALTOOLTIP._ui.txt_weight_value:GetPosY())
    self._NORMALTOOLTIP._ui.txt_weight_value:SetPosX(self._NORMALTOOLTIP._ui.txt_weight_value:GetPosX() - self._NORMALTOOLTIP._ui.txt_weight_diffValue:GetTextSizeX())
  end
  if self._NORMALTOOLTIP._ui.txt_statExtraParam1_diffValue:GetShow() then
    self._NORMALTOOLTIP._ui.txt_statExtraParam1_diffValue:SetPosX(self._NORMALTOOLTIP._ui.txt_statExtraParam1_value:GetPosX() + self._NORMALTOOLTIP._ui.txt_statExtraParam1_value:GetTextSizeX() + 10)
    self._NORMALTOOLTIP._ui.txt_statExtraParam1_diffValue:SetPosY(self._NORMALTOOLTIP._ui.txt_statExtraParam1_value:GetPosY() + 7)
  end
  if self._NORMALTOOLTIP._ui.txt_statExtraParam2_diffValue:GetShow() then
    self._NORMALTOOLTIP._ui.txt_statExtraParam2_diffValue:SetPosX(self._NORMALTOOLTIP._ui.txt_statExtraParam2_value:GetPosX() + self._NORMALTOOLTIP._ui.txt_statExtraParam2_value:GetTextSizeX() + 10)
    self._NORMALTOOLTIP._ui.txt_statExtraParam2_diffValue:SetPosY(self._NORMALTOOLTIP._ui.txt_statExtraParam2_value:GetPosY() + 7)
  end
  if self._NORMALTOOLTIP._ui.txt_statExtraParam3_diffValue:GetShow() then
    self._NORMALTOOLTIP._ui.txt_statExtraParam3_diffValue:SetPosX(self._NORMALTOOLTIP._ui.txt_statExtraParam3_value:GetPosX() + self._NORMALTOOLTIP._ui.txt_statExtraParam3_value:GetTextSizeX() + 10)
    self._NORMALTOOLTIP._ui.txt_statExtraParam3_diffValue:SetPosY(self._NORMALTOOLTIP._ui.txt_statExtraParam3_value:GetPosY() + 7)
  end
  if target._ui.txt_maxEnchanter:GetShow() then
    target._ui.txt_maxEnchanter:SetPosY(TooltipYPos + 5)
    TooltipYPos = self:getBottomPos(target._ui.txt_maxEnchanter) + elementgap
  end
  if target._ui.txt_isEnchantable:GetShow() then
    target._ui.txt_isEnchantable:SetPosY(TooltipYPos + 5)
    TooltipYPos = self:getBottomPos(target._ui.txt_isEnchantable) + elementgap
  end
  if target._ui.txt_isRepair:GetShow() then
    target._ui.txt_isRepair:SetPosY(TooltipYPos)
    TooltipYPos = self:getBottomPos(target._ui.txt_isRepair) + elementgap
  end
  if target._ui.txt_isSealed:GetShow() then
    target._ui.txt_isSealed:SetPosY(TooltipYPos + 5)
    TooltipYPos = self:getBottomPos(target._ui.txt_isSealed) + elementgap
  end
  if target._ui.txt_bindType:GetShow() then
    target._ui.txt_bindType:SetPosY(TooltipYPos)
    TooltipYPos = self:getBottomPos(target._ui.txt_bindType) + elementgap
  end
  if target._ui.txt_cronStoneEnchant:GetShow() then
    target._ui.txt_cronStoneEnchant:SetPosY(TooltipYPos + 5)
    TooltipYPos = self:getBottomPos(target._ui.txt_cronStoneEnchant, true)
    target._ui.txt_cronStoneValue:SetPosY(TooltipYPos + 5)
    TooltipYPos = self:getBottomPos(target._ui.txt_cronStoneValue, true)
  end
  if target._ui.txt_randomOptionTitle:GetShow() then
    target._ui.txt_randomOptionTitle:SetPosY(TooltipYPos + 5)
    TooltipYPos = self:getBottomPos(target._ui.txt_randomOptionTitle, true)
    for index = 0, 4 do
      if target._ui.txt_randomOptionValue[index]:GetShow() then
        target._ui.txt_randomOptionValue[index]:SetPosX(target._ui.txt_randomOptionTitle:GetPosX() + 10)
        target._ui.txt_randomOptionValue[index]:SetPosY(TooltipYPos + 1)
        TooltipYPos = self:getBottomPos(target._ui.txt_randomOptionValue[index], true)
      end
    end
    TooltipYPos = TooltipYPos + 15
  end
  if target._ui.txt_isPersonalTrade:GetShow() then
    target._ui.txt_isPersonalTrade:SetPosY(TooltipYPos + 5)
    TooltipYPos = self:getBottomPos(target._ui.txt_isPersonalTrade) + elementgap
  end
  if target._ui.txt_enchantDifficulty:GetShow() then
    target._ui.txt_enchantDifficulty:SetPosY(TooltipYPos + 5)
    TooltipYPos = self:getBottomPos(target._ui.txt_enchantDifficulty) + elementgap
  end
  if target._ui.txt_isItemLock:GetShow() then
    target._ui.txt_isItemLock:SetPosY(TooltipYPos)
    TooltipYPos = self:getBottomPos(target._ui.txt_isItemLock) + elementgap
  end
  if target._ui.txt_soulCollector:GetShow() then
    target._ui.txt_soulCollector:SetPosY(TooltipYPos)
    TooltipYPos = self:getBottomPos(target._ui.txt_soulCollector) + elementgap
  end
  if target._ui.stc_tradeInfo_panel:GetShow() then
    target._ui.stc_tradeInfo_panel:SetPosY(TooltipYPos)
    target._ui.txt_tradeInfo_title:SetPosY(TooltipYPos + 5)
    target._ui.txt_tradeInfo_value:SetPosY(TooltipYPos + target._ui.txt_tradeInfo_title:GetSizeY() + 5)
    target._ui.stc_tradeInfo_ani:SetPosY(0)
    TooltipYPos = self:getBottomPos(target._ui.stc_tradeInfo_panel) + elementgap
  end
  if target._ui.txt_balksExtraction:GetShow() then
    target._ui.txt_balksExtraction:SetPosY(TooltipYPos)
    TooltipYPos = self:getBottomPos(target._ui.txt_balksExtraction) + elementgap
  end
  if target._ui.txt_cronsExtraction:GetShow() then
    target._ui.txt_cronsExtraction:SetPosY(TooltipYPos - 5)
    TooltipYPos = self:getBottomPos(target._ui.txt_cronsExtraction) + elementgap
  end
  if true == _ContentsGroup_OceanCurrent and target._ui.txt_supplyValue:GetShow() then
    target._ui.txt_supplyValue:SetPosY(TooltipYPos)
    TooltipYPos = self:getBottomPos(target._ui.txt_supplyValue) + elementgap
  end
  if true == itemSSW:isEquipable() then
    local dyeingPartCount = 0
    if nil ~= itemWrapper then
      dyeingPartCount = itemWrapper:getDyeingPartCount()
    elseif nil ~= chattingLinkedItem then
      dyeingPartCount = chattingLinkedItem:getDyeingPartCount()
    end
    if true == itemSSW:isDyeable() then
      if true == target._ui.txt_useDyeColorTitle:GetShow() then
        target._ui.txt_useDyeColorTitle:SetPosY(TooltipYPos + elementgap)
        TooltipYPos = self:getBottomPos(target._ui.txt_useDyeColorTitle) + elementgap
      end
      for dyeingPart_Index = 0, dyeingPartCount - 1 do
        target._ui.stc_useDyeColorIcon_part[dyeingPart_Index]:SetPosY(TooltipYPos)
        if 0 == dyeingPart_Index then
          target._ui.stc_useDyeColorIcon_part[dyeingPart_Index]:SetPosX(15)
        else
          target._ui.stc_useDyeColorIcon_part[dyeingPart_Index]:SetPosX(target._ui.stc_useDyeColorIcon_part[dyeingPart_Index - 1]:GetPosX() + target._ui.stc_useDyeColorIcon_part[dyeingPart_Index]:GetSizeX() + 6)
        end
      end
      if 0 < dyeingPartCount then
        TooltipYPos = self:getBottomPos(target._ui.stc_useDyeColorIcon_part[0]) + elementgap + 10
      else
        target._ui.txt_useDyeColorTitle:SetShow(true)
        target._ui.txt_useDyeColorTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_DYE_DYEPOSSIBLE"))
        target._ui.txt_useDyeColorTitle:SetPosY(TooltipYPos + elementgap)
        TooltipYPos = self:getBottomPos(target._ui.txt_useDyeColorTitle) + elementgap
      end
    else
      target._ui.txt_useDyeColorTitle:SetShow(true)
      target._ui.txt_useDyeColorTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_ITEM_DYE_DYEIMPOSSIBLE"))
      if true == target._ui.txt_useDyeColorTitle:GetShow() then
        target._ui.txt_useDyeColorTitle:SetPosY(TooltipYPos + elementgap)
        TooltipYPos = self:getBottomPos(target._ui.txt_useDyeColorTitle) + elementgap
      end
    end
  end
  if useLimitShow == true then
    target._ui.txt_useLimit_category:SetShow(true)
    if target._ui.txt_useLimit_category:GetShow() then
      target._ui.stc_useLimit_panel:SetPosY(TooltipYPos)
      target._ui.txt_useLimit_category:SetPosY(TooltipYPos)
      TooltipYPos = TooltipYPos + elementgap
      if target._ui.txt_useLimit_class_value:GetShow() then
        target._ui.txt_useLimit_class_value:SetPosY(TooltipYPos + 4)
        TooltipYPos = self:getBottomPos(target._ui.txt_useLimit_class_value) + elementgap
      end
      if target._ui.txt_useLimit_level_value:GetShow() then
        target._ui.txt_useLimit_level_value:SetPosY(TooltipYPos + 4)
        TooltipYPos = self:getBottomPos(target._ui.txt_useLimit_level_value) + elementgap
      end
      if target._ui.txt_useLimit_extendedslot_value:GetShow() then
        target._ui.txt_useLimit_extendedslot_value:SetPosY(TooltipYPos)
        TooltipYPos = self:getBottomPos(target._ui.txt_useLimit_extendedslot_value) + elementgap
      end
      if target._ui.txt_remainTime:GetShow() then
        target._ui.txt_remainTime:SetPosY(TooltipYPos)
        target._ui.txt_remainTime_value:SetPosY(TooltipYPos)
        TooltipYPos = self:getBottomPos(target._ui.txt_remainTime_value) + elementgap
        local s64_remainingTime = getLeftSecond_s64(item:getExpirationDate())
        if Defines.s64_const.s64_0 == s64_remainingTime then
          target._ui.stc_expireIcon_end:SetShow(true)
          target._ui.stc_expireIcon_end:SetPosX(target._ui.txt_remainTime_value:GetPosX() - 20)
          target._ui.stc_expireIcon_end:SetPosY(target._ui.txt_remainTime_value:GetPosY() + (target._ui.txt_remainTime_value:GetSizeY() - target._ui.stc_expireIcon_end:GetSizeY()) / 2)
        elseif Int64toInt32(s64_remainingTime) <= 7200 then
          target._ui.stc_expireIcon_red:SetShow(true)
          target._ui.stc_expireIcon_red:SetPosX(target._ui.txt_remainTime_value:GetPosX() - 20)
          target._ui.stc_expireIcon_red:SetPosY(target._ui.txt_remainTime_value:GetPosY() + (target._ui.txt_remainTime_value:GetSizeY() - target._ui.stc_expireIcon_red:GetSizeY()) / 2)
          target._ui.stc_expireIcon_red:SetPosY(TooltipYPos - 20)
        else
          target._ui.stc_expireIcon_white:SetShow(true)
          target._ui.stc_expireIcon_white:SetPosX(target._ui.txt_remainTime_value:GetPosX() - 20)
          target._ui.stc_expireIcon_white:SetPosY(target._ui.txt_remainTime_value:GetPosY() + (target._ui.txt_remainTime_value:GetSizeY() - target._ui.stc_expireIcon_white:GetSizeY()) / 2)
          target._ui.stc_expireIcon_white:SetPosY(TooltipYPos - 20)
        end
      else
        target._ui.stc_expireIcon_white:SetShow(false)
        target._ui.stc_expireIcon_red:SetShow(false)
        target._ui.stc_expireIcon_end:SetShow(false)
      end
      target._ui.stc_useLimit_panel:SetSize(target._ui.stc_useLimit_panel:GetSizeX(), TooltipYPos - target._ui.stc_useLimit_panel:GetPosY() + elementBiggap / 2)
      TooltipYPos = self:getBottomPos(target._ui.stc_useLimit_panel) + elementBiggap / 2
    end
  end
  if target._ui.stc_soketOption_panel:GetShow() then
    target._ui.stc_soketOption_panel:SetPosY(TooltipYPos)
    TooltipYPos = TooltipYPos + elementgap
    for idx = 1, 6 do
      if target._ui.stc_soketSlot[idx]:GetShow() then
        target._ui.stc_soketSlot[idx]:SetPosY(TooltipYPos + 1)
        target._ui.txt_soketName[idx]:SetPosY(TooltipYPos)
        TooltipYPos = self:getBottomPos(target._ui.txt_soketName[idx]) + elementgap
        target._ui.txt_soketEffect[idx]:SetPosY(TooltipYPos)
        TooltipYPos = self:getBottomPos(target._ui.txt_soketEffect[idx]) + elementgap
        TooltipYPos = TooltipYPos + elementBiggap
      end
    end
    target._ui.stc_soketOption_panel:SetSize(target._ui.stc_soketOption_panel:GetSizeX(), TooltipYPos - target._ui.stc_soketOption_panel:GetPosY() - elementBiggap / 2)
    TooltipYPos = self:getBottomPos(target._ui.stc_soketOption_panel) + elementBiggap
  end
  if true == itemSSW:get():isForJustTrade() and not isSSW then
    target._ui.txt_itemProducedPlace:SetPosY(TooltipYPos)
    TooltipYPos = self:getBottomPos(target._ui.txt_itemProducedPlace) + elementBiggap
  end
  if self._NORMALTOOLTIP == target and target._ui.txt_bagSize:GetShow() then
    target._ui.txt_bagSize:SetPosY(TooltipYPos)
    TooltipYPos = self:getBottomPos(target._ui.txt_bagSize)
    if target._ui.txt_equipmentInBag:GetShow() then
      target._ui.txt_equipmentInBag:SetPosY(TooltipYPos)
      TooltipYPos = self:getBottomPos(target._ui.txt_equipmentInBag) + elementBiggap
    end
  end
  if target._ui.txt_itemDescription:GetShow() and false == _ContentsGroup_RenewUI then
    target._ui.txt_itemDescription:SetPosY(TooltipYPos)
    TooltipYPos = self:getBottomPos(target._ui.txt_itemDescription) + elementgap
  end
  if target._ui.txt_exchangeTitle:GetShow() then
    target._ui.txt_exchangeTitle:SetPosY(TooltipYPos)
    TooltipYPos = self:getBottomPos(target._ui.txt_exchangeTitle) + elementgap
    target._ui.txt_exchangeDesc:SetPosY(TooltipYPos)
    TooltipYPos = self:getBottomPos(target._ui.txt_exchangeDesc) + elementgap
  end
  if target._ui.txt_equipSlotName:GetShow() then
    target._ui.txt_equipSlotName:SetPosY(TooltipYPos)
    TooltipYPos = self:getBottomPos(target._ui.txt_equipSlotName) + elementgap
  end
  target._ui.stc_itemPrice_panel:SetPosY(TooltipYPos)
  TooltipYPos = TooltipYPos + elementgap * 2
  target._ui.txt_itemPrice_transportBuy:SetPosY(TooltipYPos + 20)
  target._ui.txt_itemPrice_transportBuy_value:SetPosY(TooltipYPos + 20)
  target._ui.txt_itemPrice_storeSell:SetPosY(TooltipYPos)
  target._ui.txt_itemPrice_storeSell_value:SetPosY(TooltipYPos)
  TooltipYPos = self:getBottomPos(target._ui.txt_itemPrice_storeSell_value) + elementBiggap
  TooltipYPos = self:getBottomPos(target._ui.stc_itemPrice_panel) + elementBiggap / 2
  if target._ui.txt_useLimit_exp:GetShow() then
    target._ui.txt_useLimit_exp:SetPosY(TooltipYPos + elementgap)
    target._ui.stc_useLimit_exp_gage:SetPosY(TooltipYPos + 22)
    target._ui.progress_useLimit_exp:SetPosY(TooltipYPos + 22)
    target._ui.txt_useLimit_exp_value:SetPosY(TooltipYPos + 15 + (target._ui.stc_useLimit_exp_gage:GetSizeY() - target._ui.txt_useLimit_exp_value:GetSizeY()) / 2)
    TooltipYPos = self:getBottomPos(target._ui.txt_useLimit_exp) + elementBiggap
  end
  if target._ui.txt_useLimit_endurance:GetShow() then
    target._ui.txt_useLimit_endurance:SetPosY(TooltipYPos + elementgap)
    target._ui.stc_useLimit_endurance_gage:SetPosY(TooltipYPos + 22)
    target._ui.txt_useLimit_endurance_value:SetPosY(TooltipYPos + 15)
    target._ui.progress_useLimit_endurance:SetPosY(TooltipYPos + 22 + (target._ui.stc_useLimit_endurance_gage:GetSizeY() - target._ui.progress_useLimit_endurance:GetSizeY()) / 2)
    target._ui.progress_useLimit_maxEurance:SetPosY(TooltipYPos + 22 + (target._ui.stc_useLimit_endurance_gage:GetSizeY() - target._ui.progress_useLimit_maxEurance:GetSizeY()) / 2)
    TooltipYPos = self:getBottomPos(target._ui.txt_useLimit_endurance) + elementBiggap
  end
  target._ui.txt_itemLockNotify:SetShow(false)
  target._ui.txt_productNotify:SetText(target._ui.txt_productNotify:GetText())
  if self._NORMALTOOLTIP == target and true == self._dataObject.inventory then
    if (isGameTypeKorea() or isGameTypeJapan() or isGameTypeRussia() or isGameTypeEnglish() or isGameTypeTaiwan()) and getContentsServiceType() ~= CppEnums.ContentsServiceType.eContentsServiceType_CBT then
      if false == itemSSW:get():isCash() and false == itemWrapper:isSoulCollector() and not _ContentsGroup_RenewUI then
        target._ui.txt_productNotify:SetShow(true)
      else
        target._ui.txt_productNotify:SetShow(false)
      end
    else
      target._ui.txt_productNotify:SetShow(false)
    end
    if true == _ContentsGroup_ItemLock and not itemSSW:get():isCash() then
      target._ui.txt_itemLockNotify:SetShow(false)
      if false == itemWrapper:getStaticStatus():isStackable() then
        local slotNo
        if true == _ContentsGroup_NewUI_Inventory_All then
          slotNo = PaGlobalFunc_Inventory_All_GetToolTipItemSlotNo()
        else
          slotNo = Inventory_GetToolTipItemSlotNo()
        end
        if ToClient_Inventory_CheckItemLock(slotNo) then
          if false == itemWrapper:getStaticStatus():get()._hideFromNote then
            target._ui.txt_productNotify:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_TOOLTIP_ITEM_SHIFTCLICK") .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOOLTIP_ITEM_SHIFTRCLICK_UNLOCK"))
          else
            target._ui.txt_productNotify:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOOLTIP_ITEM_SHIFTRCLICK_UNLOCK"))
          end
        elseif false == itemWrapper:getStaticStatus():get()._hideFromNote then
          target._ui.txt_productNotify:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_TOOLTIP_ITEM_SHIFTCLICK") .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOOLTIP_ITEM_SHIFTRCLICK_LOCK"))
        else
          target._ui.txt_productNotify:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOOLTIP_ITEM_SHIFTRCLICK_LOCK"))
        end
      elseif false == itemWrapper:getStaticStatus():get()._hideFromNote then
        target._ui.txt_productNotify:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_TOOLTIP_ITEM_SHIFTCLICK"))
      else
        target._ui.txt_productNotify:SetShow(false)
      end
    end
  else
    target._ui.txt_productNotify:SetShow(false)
    target._ui.txt_itemLockNotify:SetShow(false)
  end
  target._ui.txt_recoveryDesc:SetShow(false)
  if not itemSSW:get():isCash() then
    if itemSSW:isEquipable() and 0 < itemSSW:getRecoveryMaxEndurance() and dynamicMaxEndurance <= 50 and 16145 ~= itemSSW:get()._key:getItemKey() and not _ContentsGroup_RenewUI then
      target._ui.txt_recoveryDesc:SetShow(true)
      target._ui.txt_recoveryDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_RECOVOERYDESC"))
    else
      target._ui.txt_recoveryDesc:SetShow(false)
    end
  end
  if target._ui.txt_productNotify:GetShow() then
    target._ui.txt_productNotify:SetPosY(TooltipYPos + elementgap)
    TooltipYPos = self:getBottomPos(target._ui.txt_productNotify) + elementgap
  end
  if target._ui.txt_itemLockNotify:GetShow() then
    target._ui.txt_itemLockNotify:SetPosY(TooltipYPos + elementgap)
    TooltipYPos = self:getBottomPos(target._ui.txt_itemLockNotify) + elementgap
  end
  if target._ui.txt_recoveryDesc:GetShow() then
    target._ui.txt_recoveryDesc:SetPosY(TooltipYPos + elementgap)
    TooltipYPos = self:getBottomPos(target._ui.txt_recoveryDesc) + elementgap
  end
  target._mainPanel:SetSize(target._mainPanel:GetSizeX(), TooltipYPos + elementBiggap / 2)
  if true == _ContentsGroup_RenewUI then
    target._ui.txt_productNotify:SetShow(false)
  end
end
function PaGlobal_Tooltip_Control_All:showPosisionSetting(target, attackShow, defenseShow, hitShow, dvShow, pvShow, statExtraParam1Show, statExtraParam2Show, statExtraParam3Show, changeItemNamePos)
  local index = -1
  local bottomTarget = 0
  local stringPos = 11
  local stringInterval = 22
  local valuePos = 0
  local valueInterval = 22
  local resultStringPos = 0
  local resultValuePos = 0
  changeItemNamePos = target._ui.txt_itemName:GetPosY() + target._ui.txt_itemName:GetTextSizeY()
  if true == attackShow then
    index = index + 1
    bottomTarget = 1
    resultStringPos = stringPos + stringInterval * index
    resultValuePos = valuePos + valueInterval * index
    target._ui.txt_attack:SetPosY(resultStringPos + changeItemNamePos)
    target._ui.txt_attack_value:SetPosY(resultValuePos + changeItemNamePos)
  end
  if true == statExtraParam1Show then
    index = index + 1
    bottomTarget = 6
    resultStringPos = stringPos + stringInterval * index
    resultValuePos = valuePos + valueInterval * index
    target._ui.txt_statExtraParam1:SetPosY(resultStringPos + changeItemNamePos)
    target._ui.txt_statExtraParam1_value:SetPosY(resultValuePos + changeItemNamePos)
  end
  if true == statExtraParam2Show then
    index = index + 1
    bottomTarget = 7
    resultStringPos = stringPos + stringInterval * index
    resultValuePos = valuePos + valueInterval * index
    target._ui.txt_statExtraParam2:SetPosY(resultStringPos + changeItemNamePos)
    target._ui.txt_statExtraParam2_value:SetPosY(resultValuePos + changeItemNamePos)
  end
  if true == statExtraParam3Show then
    index = index + 1
    bottomTarget = 8
    resultStringPos = stringPos + stringInterval * index
    resultValuePos = valuePos + valueInterval * index
    target._ui.txt_statExtraParam3:SetPosY(resultStringPos + changeItemNamePos)
    target._ui.txt_statExtraParam3_value:SetPosY(resultValuePos + changeItemNamePos)
  end
  if true == hitShow then
    index = index + 1
    bottomTarget = 2
    resultStringPos = stringPos + stringInterval * index
    resultValuePos = valuePos + valueInterval * index
    target._ui.txt_hit:SetPosY(resultStringPos + changeItemNamePos)
    target._ui.txt_hit_value:SetPosY(resultValuePos + changeItemNamePos)
  end
  if true == defenseShow then
    index = index + 1
    bottomTarget = 3
    resultStringPos = stringPos + stringInterval * index
    resultValuePos = valuePos + valueInterval * index
    target._ui.txt_defense:SetPosY(resultStringPos + changeItemNamePos)
    target._ui.txt_defense_value:SetPosY(resultValuePos + changeItemNamePos)
  end
  if true == dvShow then
    index = index + 1
    bottomTarget = 4
    resultStringPos = stringPos + stringInterval * index
    resultValuePos = valuePos + valueInterval * index
    target._ui.txt_dv:SetPosY(resultStringPos + changeItemNamePos)
    target._ui.txt_dv_value:SetPosY(resultValuePos + changeItemNamePos + 4)
    target._ui.txt_dv_value:SetPosX(target._ui.txt_dv:GetPosX() + target._ui.txt_dv:GetTextSizeX() + 10)
  end
  if true == pvShow then
    index = index + 1
    bottomTarget = 5
    resultStringPos = stringPos + stringInterval * index
    resultValuePos = valuePos + valueInterval * index
    target._ui.txt_pv:SetPosY(resultStringPos + changeItemNamePos)
    target._ui.txt_pv_value:SetPosY(resultValuePos + changeItemNamePos + 4)
    target._ui.txt_pv_value:SetPosX(target._ui.txt_pv:GetPosX() + target._ui.txt_pv:GetTextSizeX() + 10)
  end
  return bottomTarget
end
