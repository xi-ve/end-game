function PaGlobal_WorldMap_TradeItemList_All:initialize()
  if true == PaGlobal_WorldMap_TradeItemList_All._initialize or nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  self._ui._stc_TitleBar = UI.getChildControl(Panel_Worldmap_Trade_MarketItemList_All, "Static_TitleBar")
  self._ui._txt_Title = UI.getChildControl(self._ui._stc_TitleBar, "StaticText_Title")
  self._ui._stc_TabGroup = UI.getChildControl(Panel_Worldmap_Trade_MarketItemList_All, "Static_TabGroup")
  self._ui._rdo_Tab_Buy = UI.getChildControl(self._ui._stc_TabGroup, "RadioButton_Buy")
  self._ui._rdo_Tab_Sell = UI.getChildControl(self._ui._stc_TabGroup, "RadioButton_Sell")
  self._ui._stc_Selected_Line = UI.getChildControl(self._ui._stc_TabGroup, "Static_SelectedLine")
  self._ui._stc_KeyGuide_LB = UI.getChildControl(self._ui._stc_TabGroup, "StaticText_LB_ConsoleUI")
  self._ui._stc_KeyGuide_RB = UI.getChildControl(self._ui._stc_TabGroup, "StaticText_RB_ConsoleUI")
  self._ui._list2_TradeItem_Buy = UI.getChildControl(Panel_Worldmap_Trade_MarketItemList_All, "List2_TradeItem_Buy")
  self._ui._list2_TradeItemBuy_Contents = UI.getChildControl(self._ui._list2_TradeItem_Buy, "List2_1_Content")
  self._ui._list2_Buy_ListSlotBg = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "Static_ListSlotBg")
  self._ui._list2_Buy_SlotBg = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "Static_SlotBg")
  self._ui._list2_Buy_ItemPrice = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "StaticText_Price")
  self._ui._list2_Buy_ItemName = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "StaticText_ItemName")
  self._ui._list2_Buy_RemainTime = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "StaticText_RemainTime")
  self._ui._list2_Buy_RemainCountTitle = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "StaticText_RemainCountTitle")
  self._ui._list2_Buy_RamainCountValue = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "StaticText_RemainCountTitle")
  self._ui._list2_Buy_StateText = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "StaticText_State")
  self._ui._list2_Buy_RoyalSupplyIcon = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "Static_RoyalSupplyIcon")
  self._ui._list2_Buy_VertiScroll = UI.getChildControl(self._ui._list2_TradeItem_Buy, "List2_1_VerticalScroll")
  self._ui._list2_Buy_HoriScrool = UI.getChildControl(self._ui._list2_TradeItem_Buy, "List2_1_HorizontalScroll")
  self._ui._list2_Buy_GraphBg = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "Static_GraphBg")
  self._ui._list2_Buy_GraphLow = UI.getChildControl(self._ui._list2_Buy_GraphBg, "Staic_LowestPoint")
  self._ui._list2_Buy_GraphHigh = UI.getChildControl(self._ui._list2_Buy_GraphBg, "Static_highestPoint")
  self._ui._list2_Buy_GraphCurrnet = UI.getChildControl(self._ui._list2_Buy_GraphBg, "Static_currentPoint")
  self._ui._list2_Buy_GraphCenter = UI.getChildControl(self._ui._list2_Buy_GraphBg, "Static_CenterLine")
  self._ui._list2_TradeItem_Sell = UI.getChildControl(Panel_Worldmap_Trade_MarketItemList_All, "List2_TradeItem_Sell")
  self._ui._list2_TradeItemSell_Content = UI.getChildControl(self._ui._list2_TradeItem_Sell, "List2_1_Content")
  self._ui._list2_Sell_ListSlotBg = UI.getChildControl(self._ui._list2_TradeItemSell_Content, "Static_ListSlotBg")
  self._ui._list2_Sell_Slot = UI.getChildControl(self._ui._list2_TradeItemSell_Content, "Static_SlotBg")
  self._ui._list2_Sell_itemName = UI.getChildControl(self._ui._list2_TradeItemSell_Content, "StaticText_ItemName")
  self._ui._list2_Sell_itemPrice = UI.getChildControl(self._ui._list2_TradeItemSell_Content, "StaticText_Price")
  self._ui._list2_Sell_VetiScroll = UI.getChildControl(self._ui._list2_TradeItem_Sell, "List2_1_VerticalScroll")
  self._ui._list2_Sell_HoriScroll = UI.getChildControl(self._ui._list2_TradeItem_Sell, "List2_1_HorizontalScroll")
  self._ui._list2_Sell_GraphBg = UI.getChildControl(self._ui._list2_TradeItemSell_Content, "Static_GraphBg")
  self._ui._list2_Sell_GraphLow = UI.getChildControl(self._ui._list2_Sell_GraphBg, "Staic_LowestPoint")
  self._ui._list2_Sell_GraphHigh = UI.getChildControl(self._ui._list2_Sell_GraphBg, "Static_highestPoint")
  self._ui._list2_Sell_GraphCurrnet = UI.getChildControl(self._ui._list2_Sell_GraphBg, "Static_currentPoint")
  self._ui._list2_Sell_GraphCenter = UI.getChildControl(self._ui._list2_Sell_GraphBg, "Static_CenterLine")
  self._ui._list2_Category = UI.getChildControl(Panel_Worldmap_Trade_MarketItemList_All, "List2_Category")
  self._ui._list2_Category_Contents = UI.getChildControl(self._ui._list2_Category, "List2_1_Content")
  self._ui._list2_Category_rdoButton = UI.getChildControl(self._ui._list2_Category_Contents, "RadioButton_Category")
  self._ui._stc_KeyGuides = UI.getChildControl(Panel_Worldmap_Trade_MarketItemList_All, "Static_BottomBG_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_KeyGuides, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_KeyGuides, "StaticText_B_ConsoleUI")
  self._ui._tabBtnGroups[0] = self._ui._rdo_Tab_Buy
  self._ui._tabBtnGroups[1] = self._ui._rdo_Tab_Sell
  local buyIcon = {}
  SlotItem.new(buyIcon, "WorldMapItemBuyIcon", nil, self._ui._list2_Buy_SlotBg, self.slotConfig)
  buyIcon:createChild()
  buyIcon:clearItem()
  buyIcon.icon:SetHorizonCenter()
  buyIcon.icon:SetVerticalMiddle()
  local sellIcon = {}
  SlotItem.new(sellIcon, "WorldMapItemSellIcon", nil, self._ui._list2_Sell_Slot, self.slotConfig)
  sellIcon:createChild()
  sellIcon:clearItem()
  sellIcon.icon:SetHorizonCenter()
  sellIcon.icon:SetVerticalMiddle()
  PaGlobal_WorldMap_TradeItemList_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_WorldMap_TradeItemList_All:validate()
  PaGlobal_WorldMap_TradeItemList_All:registerEventHandler()
  if false == self._isConsole then
    self._ui._stc_KeyGuides:SetShow(false)
    self._ui._stc_KeyGuide_LB:SetShow(false)
    self._ui._stc_KeyGuide_RB:SetShow(false)
  else
    local keyGuides = {
      self._ui._stc_KeyGuide_A,
      self._ui._stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
end
function PaGlobal_WorldMap_TradeItemList_All:validate()
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  self._ui._stc_TitleBar:isValidate()
  self._ui._txt_Title:isValidate()
  self._ui._stc_TabGroup:isValidate()
  self._ui._rdo_Tab_Buy:isValidate()
  self._ui._rdo_Tab_Sell:isValidate()
  self._ui._stc_Selected_Line:isValidate()
  self._ui._stc_KeyGuide_LB:isValidate()
  self._ui._stc_KeyGuide_RB:isValidate()
  self._ui._list2_TradeItem_Buy:isValidate()
  self._ui._list2_TradeItemBuy_Contents:isValidate()
  self._ui._list2_Buy_ListSlotBg:isValidate()
  self._ui._list2_Buy_SlotBg:isValidate()
  self._ui._list2_Buy_ItemPrice:isValidate()
  self._ui._list2_Buy_ItemName:isValidate()
  self._ui._list2_Buy_RemainTime:isValidate()
  self._ui._list2_Buy_RemainCountTitle:isValidate()
  self._ui._list2_Buy_RamainCountValue:isValidate()
  self._ui._list2_Buy_StateText:isValidate()
  self._ui._list2_Buy_VertiScroll:isValidate()
  self._ui._list2_Buy_HoriScrool:isValidate()
  self._ui._list2_Buy_RoyalSupplyIcon:isValidate()
  self._ui._list2_Buy_GraphBg:isValidate()
  self._ui._list2_Buy_GraphLow:isValidate()
  self._ui._list2_Buy_GraphHigh:isValidate()
  self._ui._list2_Buy_GraphCurrnet:isValidate()
  self._ui._list2_Buy_GraphCenter:isValidate()
  self._ui._list2_TradeItem_Sell:isValidate()
  self._ui._list2_TradeItemSell_Content:isValidate()
  self._ui._list2_Sell_ListSlotBg:isValidate()
  self._ui._list2_Sell_Slot:isValidate()
  self._ui._list2_Sell_itemName:isValidate()
  self._ui._list2_Sell_itemPrice:isValidate()
  self._ui._list2_Sell_VetiScroll:isValidate()
  self._ui._list2_Sell_HoriScroll:isValidate()
  self._ui._list2_Sell_GraphBg:isValidate()
  self._ui._list2_Sell_GraphLow:isValidate()
  self._ui._list2_Sell_GraphHigh:isValidate()
  self._ui._list2_Sell_GraphCurrnet:isValidate()
  self._ui._list2_Sell_GraphCenter:isValidate()
  self._ui._list2_Category:isValidate()
  self._ui._list2_Category_Contents:isValidate()
  self._ui._list2_Category_rdoButton:isValidate()
  self._ui._stc_KeyGuides:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._stc_KeyGuide_B:isValidate()
  self._initialize = true
end
function PaGlobal_WorldMap_TradeItemList_All:onScreenResize()
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  Panel_Worldmap_Trade_MarketItemList_All:ComputePos()
end
function PaGlobal_WorldMap_TradeItemList_All:registerEventHandler()
  if nil == Panel_Worldmap_Trade_MarketItemList_All or false == PaGlobal_WorldMap_TradeItemList_All._initialize then
    return
  end
  registerEvent("onScreenResize", "FromClient_WorldMapItemList_All_OnScreenResize")
  registerEvent("EventNpcTradeShopUpdate", "FromClient_WorldMapItemList_All_UpdateItemList")
  registerEvent("EventNpcTradeShopGraphRefresh", "FromClient_WorldMapItemList_All_UpdateItemList")
  self._ui._list2_TradeItem_Buy:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_WorldMapItemList_All_List2UpdateTradeItemData")
  self._ui._list2_TradeItem_Buy:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2_TradeItem_Sell:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_WorldMapItemList_All_List2UpdateTradeItemData")
  self._ui._list2_TradeItem_Sell:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2_Category:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_WorldMapItemList_All_List2UpdateCategoryButtonData")
  self._ui._list2_Category:createChildContent(__ePAUIList2ElementManagerType_List)
  if true == self._isConsole then
  else
    self._ui._rdo_Tab_Buy:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldMapItemList_All_ChangeTab(0)")
    self._ui._rdo_Tab_Sell:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldMapItemList_All_ChangeTab(1)")
  end
end
function PaGlobal_WorldMap_TradeItemList_All:prepareOpen()
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  local characterStaticStatusWrapper = npcShop_getCurrentCharacterKeyForTrade()
  local characterStaticStatus = characterStaticStatusWrapper:get()
  local territorySupplyCheck = false
  if characterStaticStatus:isTerritorySupplyMerchant() then
    self._currentNpcType = 2
    territorySupplyCheck = true
  elseif characterStaticStatus:isTerritoryTradeMerchant() then
    self._currentNpcType = 1
    territorySupplyCheck = false
  elseif characterStaticStatus:isSupplyMerchant() or characterStaticStatus:isFishSupplyMerchant() or characterStaticStatus:isGuildSupplyShopMerchant() then
    self._currentNpcType = 3
    if characterStaticStatus:isGuildSupplyShopMerchant() then
      territorySupplyCheck = false
    end
    territorySupplyCheck = true
  else
    self._currentNpcType = 1
    territorySupplyCheck = false
  end
  if true == territorySupplyCheck then
    self._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_KEY_7"))
  else
    self._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_KEY_8"))
  end
  self._currentCategoryIdx = -1
  Panel_Worldmap_Trade_MarketItemList_All:SetHorizonRight()
  self._currentTab = 0
  if 0 == self._currentTab then
    self._currentNpcType = 1
  else
    self._currentNpcType = 2
  end
  local selectBarPosX = PaGlobal_WorldMap_TradeItemList_All._ui._tabBtnGroups[self._currentTab]:GetSpanSize().x
  local selectBarPosY = PaGlobal_WorldMap_TradeItemList_All._ui._stc_Selected_Line:GetSpanSize().y
  self._ui._stc_Selected_Line:SetSpanSize(selectBarPosX, selectBarPosY)
  local sellCount = npcShop_getBuyCount()
  for itemOrderIndex = 0, sellCount - 1 do
    local itemwrapper = npcShop_getItemBuy(itemOrderIndex)
    local itemStatus = itemwrapper:getStaticStatus()
    local itemSS = itemStatus:get()
    local itemKey = itemSS._key:get()
    self._shopItemIndexTable[itemOrderIndex] = itemKey
  end
  PaGlobal_WorldMap_TradeItemList_All:open()
  HandleEventLUp_WorldMapItemList_All_ChangeTab(self._currentTab)
end
function PaGlobal_WorldMap_TradeItemList_All:updateCategoryButtonData(contents, key)
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  local categoryIndex32 = Int64toInt32(key)
  local rdoButton = UI.getChildControl(contents, "RadioButton_Category")
  rdoButton:SetTextMode(__eTextMode_LimitText)
  rdoButton:SetText(self._commerceStringTable[categoryIndex32])
  rdoButton:SetShow(true)
  self._currentCategoryBtnCount = self._currentCategoryBtnCount + 1
  self._ui._categoryBtnGroups[categoryIndex32] = rdoButton
  if nil ~= self._currentCategoryIdx or -1 == self._currentCategoryIdx then
    if categoryIndex32 == self._currentCategoryIdx then
      rdoButton:SetCheck(true)
    else
      rdoButton:SetCheck(false)
    end
  end
  if false == PaGlobal_TradeFunction_All._isConsole then
    rdoButton:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldMapItemList_All_SelectCategoryBtn(" .. categoryIndex32 .. ")")
  else
  end
end
function PaGlobal_WorldMap_TradeItemList_All:open()
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  Panel_Worldmap_Trade_MarketItemList_All:SetShow(true)
end
function PaGlobal_WorldMap_TradeItemList_All:update()
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  self._ui._list2_Category:getElementManager():clearKey()
  if nil ~= enCommerceType.enCommerceType_Max and nil ~= Panel_Dialog_Scene then
    for idx = 1, enCommerceType.enCommerceType_Max - 1 do
      local itemCount = 0
      if 1 == self._currentNpcType then
        itemCount = PaGlobal_WorldMap_TradeItemList_All:checkdataEmpty(idx, self._currentNpcType)
      else
        itemCount = npcShop_getCommerceItemSize(idx)
      end
      if 0 < itemCount then
        if -1 == self._currentCategoryIdx then
          self._currentCategoryIdx = idx
        end
        self._ui._list2_Category:getElementManager():pushKey(toInt64(0, idx))
      end
    end
  end
  PaGlobal_WorldMap_TradeItemList_All:onScreenResize()
  PaGlobal_WorldMap_TradeItemList_All:getItemListByCurrentCategory()
end
function PaGlobal_WorldMap_TradeItemList_All:getItemListByCurrentCategory()
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  local commerceCount = 0
  if nil == self._currentNpcType or nil == self._currentCategoryIdx then
    return
  end
  self._ui._list2_TradeItem_Buy:getElementManager():clearKey()
  self._ui._list2_TradeItem_Sell:getElementManager():clearKey()
  if 1 == self._currentNpcType then
    commerceCount = PaGlobal_WorldMap_TradeItemList_All:checkdataEmpty(self._currentCategoryIdx, self._currentNpcType)
    self._ui._list2_TradeItem_Buy:SetShow(true)
    self._ui._list2_TradeItem_Sell:SetShow(false)
  else
    commerceCount = npcShop_getCommerceItemSize(self._currentCategoryIdx)
    self._ui._list2_TradeItem_Sell:SetShow(true)
    self._ui._list2_TradeItem_Buy:SetShow(false)
  end
  for itemIdx = 0, commerceCount - 1 do
    local itemKey = npcShop_GetCommerceItemByIndexAndSellOrBuy(self._currentCategoryIdx, self._currentNpcType, itemIdx)
    self._itemKeyTable[itemIdx] = itemKey
    if 0 ~= itemKey then
      if 1 == self._currentNpcType then
        self._ui._list2_TradeItem_Buy:getElementManager():pushKey(toInt64(0, itemIdx))
      else
        self._ui._list2_TradeItem_Sell:getElementManager():pushKey(toInt64(0, itemIdx))
      end
    end
  end
end
function PaGlobal_WorldMap_TradeItemList_All:setTradeItemData(contents, key)
  if nil == Panel_Worldmap_Trade_MarketItemList_All or nil == key then
    return
  end
  local key32 = Int64toInt32(key)
  if 1 == self._currentNpcType then
    self:updateBuySlot(contents, key32)
  else
    self:updateSellSlot(contents, key32)
  end
end
function PaGlobal_WorldMap_TradeItemList_All:updateBuySlot(contents, key32)
  if nil == Panel_Worldmap_Trade_MarketItemList_All or nil == key32 then
    return
  end
  local listBg = UI.getChildControl(contents, "Static_ListSlotBg")
  local itemslotBg = UI.getChildControl(contents, "Static_SlotBg")
  local itemNameTxt = UI.getChildControl(contents, "StaticText_ItemName")
  local itemPriceTxt = UI.getChildControl(contents, "StaticText_Price")
  local remainTimeIcon = UI.getChildControl(contents, "StaticText_RemainTime")
  local txt_RemainCount = UI.getChildControl(contents, "StaticText_RemainCountValue")
  local txt_RemainCountTitle = UI.getChildControl(contents, "StaticText_RemainCountTitle")
  local buyingConditionTxt = UI.getChildControl(contents, "StaticText_State")
  local loyalSupplyIcon = UI.getChildControl(contents, "Static_RoyalSupplyIcon")
  local itemKey = self._itemKeyTable[key32]
  local itemESSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  local itemSS = itemESSW:get()
  local enchantKey = itemSS._key:get()
  local sellRateTxt = string.format("%.f", npcShop_GetTradeGraphRateOfPrice(itemKey))
  local tradeItemWrapper = npcShop_getTradeItem(itemKey)
  local needLifeLevel = tradeItemWrapper:get():getNeedLifeLevel()
  local needLifeType = tradeItemWrapper:get():getNeedLifeType()
  local sellPrice = tradeItemWrapper:getTradeSellPrice()
  local originalPrice64 = itemESSW:getOriginalPriceByInt64()
  local originalPrice = Int64toInt32(originalPrice64)
  local upperPrice = tradeItemWrapper:getUpperLimitPrice()
  local underprice = tradeItemWrapper:getUnderLimitPrice()
  local buyableStack = tradeItemWrapper:get():calculateRemainCount()
  local currentTab = PaGlobal_WorldMap_TradeItemList_All._currentTab
  local conditionLevel = PaGlobalFunc_Util_CraftLevelReplace(needLifeLevel + 1)
  local conditionTypeName = CppEnums.LifeExperienceString[needLifeType]
  local buyingConditionValue = ""
  if 0 == needLifeLevel or nil == needLifeLevel then
    buyingConditionTxt:SetShow(false)
    buyingConditionValue = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_GRAPH_NOPE")
  else
    local playerThisCraftLevel = getSelfPlayer():get():getLifeExperienceLevel(needLifeType)
    if needLifeLevel < playerThisCraftLevel then
      buyingConditionTxt:SetFontColor(Defines.Color.C_FFC4C4C4)
    else
      buyingConditionTxt:SetFontColor(Defines.Color.C_FFD05D48)
    end
    buyingConditionValue = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_BUYINGCONDITION", "conditionTypeName", conditionTypeName, "conditionLevel", conditionLevel)
    buyingConditionTxt:SetText(buyingConditionValue)
    buyingConditionTxt:SetShow(true)
  end
  itemNameTxt:SetTextMode(__eTextMode_LimitText)
  itemNameTxt:SetText(itemESSW:getName())
  PAGlobalFunc_SetItemTextColorForNewUI(itemNameTxt, itemESSW)
  local priceRate_Value = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_SELLRATES", "Percent", tostring(sellRateTxt))
  if 100 < tonumber(tostring(sellRateTxt)) then
    priceRate_Value = "(<PAColor0xFF66CC33>" .. priceRate_Value .. "<PAOldColor>\226\150\178)"
  else
    priceRate_Value = "(<PAColor0xFF66CC33>" .. priceRate_Value .. "<PAOldColor>\226\150\188)"
  end
  itemPriceTxt:SetText(makeDotMoney(sellPrice) .. " " .. priceRate_Value)
  local icon = {}
  SlotItem.reInclude(icon, "WorldMapItemBuyIcon", key32, itemslotBg, PaGlobal_WorldMap_TradeItemList_All.slotConfig)
  icon:setItemByStaticStatus(itemESSW)
  if 1 == self._currentNpcType then
    txt_RemainCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEITEMLIST_ALL_COUNT", "count", tostring(buyableStack)))
    txt_RemainCount:SetShow(true)
    txt_RemainCountTitle:SetShow(true)
    if toInt64(0, 0) == buyableStack then
      txt_RemainCount:SetFontColor(Defines.Color.C_FFD05D48)
    else
      txt_RemainCount:SetFontColor(Defines.Color.C_FFF5BA3A)
    end
    remainTimeIcon:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEITEMLIST_ALL_LEFTTIME", "time", tostring(tradeItemWrapper:getStaticStatus():get()._expirationPeriod / 60)))
    remainTimeIcon:SetShow(true)
  end
  local shopItemIdx = -1
  for i = 0, #self._shopItemIndexTable do
    if self._shopItemIndexTable[i] == itemKey then
      shopItemIdx = i
    end
  end
  loyalSupplyIcon:SetShow(false)
  local territorySupplyKey
  if true == _ContentsGroup_NewUI_TradeEventNotice_All then
    territorySupplyKey = PaGloabl_TradeEventNotice_Renewal_All_GetTerritorySupplyIndex(itemKey)
  else
    territorySupplyKey = FGlobal_TradeEventNotice_Renewal_GetTerritorySupplyIndex(itemKey)
  end
  if nil ~= territorySupplyKey then
    loyalSupplyIcon:SetShow(true)
  end
  local slotTable = {
    _itemKey = nil,
    _txt_price = nil,
    _stc_remainTimeIcon = nil,
    _slotIndex = nil,
    _loyalSupply = nil
  }
  slotTable._itemKey = itemKey
  slotTable._txt_price = itemPriceTxt
  slotTable._stc_remainTimeIcon = remainTimeIcon
  slotTable._slotIndex = key32
  slotTable._loyalSupply = loyalSupplyIcon
  self._itemSlotTable[key32] = slotTable
  if false == PaGlobal_WorldMap_TradeItemList_All._isConsole then
    icon.icon:addInputEvent("Mouse_On", "PaGlobalFunc_TradeMarketItemToolTip_All_Show(" .. itemKey .. ",true)")
    icon.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_TradeMarketItemToolTip_All_Hide()")
    listBg:addInputEvent("Mouse_On", "PaGlobalFunc_TradeMarketItemToolTip_All_Show(" .. itemKey .. ",true)")
    listBg:addInputEvent("Mouse_Out", "PaGlobalFunc_TradeMarketItemToolTip_All_Hide()")
    itemPriceTxt:addInputEvent("Mouse_On", "HandleEventOnOut_WorldMapItemList_All_SimpleTooltip(true," .. key32 .. ",1)")
    itemPriceTxt:addInputEvent("Mouse_Out", "HandleEventOnOut_WorldMapItemList_All_SimpleTooltip(false)")
    remainTimeIcon:addInputEvent("Mouse_On", "HandleEventOnOut_WorldMapItemList_All_SimpleTooltip(true," .. key32 .. ",0)")
    remainTimeIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_WorldMapItemList_All_SimpleTooltip(false)")
    if nil ~= territorySupplyKey then
      loyalSupplyIcon:addInputEvent("Mouse_On", "HandleEventOnOut_WorldMapItemList_All_SimpleTooltip( true, " .. key32 .. ", 2, " .. territorySupplyKey .. " )")
      loyalSupplyIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_WorldMapItemList_All_SimpleTooltip( false, " .. key32 .. ", 2, " .. territorySupplyKey .. " )")
    else
    end
  end
  PaGlobal_WorldMap_TradeItemList_All:setGraphData(contents, itemKey)
end
function PaGlobal_WorldMap_TradeItemList_All:updateSellSlot(contents, key32)
  if nil == Panel_Worldmap_Trade_MarketItemList_All or nil == key32 then
    return
  end
  local listSlotBg = UI.getChildControl(contents, "Static_ListSlotBg")
  local iconSlot = UI.getChildControl(contents, "Static_SlotBg")
  local itemName = UI.getChildControl(contents, "StaticText_ItemName")
  local itemPrice = UI.getChildControl(contents, "StaticText_Price")
  local itemKey = PaGlobal_WorldMap_TradeItemList_All._itemKeyTable[key32]
  local itemESSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  local itemSS = itemESSW:get()
  local sellRateTxt = string.format("%.f", npcShop_GetTradeGraphRateOfPrice(itemKey))
  local tradeItemWrapper = npcShop_getTradeItem(itemKey)
  local sellPrice = tradeItemWrapper:getTradeSellPrice()
  itemName:SetTextMode(__eTextMode_LimitText)
  itemName:SetText(itemESSW:getName())
  PAGlobalFunc_SetItemTextColorForNewUI(itemName, itemESSW)
  local priceRate_Value = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_SELLRATES", "Percent", tostring(sellRateTxt))
  if 100 < tonumber(tostring(sellRateTxt)) then
    priceRate_Value = "(<PAColor0xFF66CC33>" .. priceRate_Value .. "<PAOldColor>\226\150\178)"
  else
    priceRate_Value = "(<PAColor0xFF66CC33>" .. priceRate_Value .. "<PAOldColor>\226\150\188)"
  end
  itemPrice:SetText(makeDotMoney(sellPrice) .. " " .. priceRate_Value)
  local icon = {}
  SlotItem.reInclude(icon, "WorldMapItemSellIcon", 0, iconSlot, self.slotConfig)
  icon:setItemByStaticStatus(itemESSW)
  PaGlobal_WorldMap_TradeItemList_All:setGraphData(contents, itemKey)
  local slotTable = {
    _itemKey = nil,
    _txt_price = nil,
    _stc_remainTimeIcon = nil,
    _slotIndex = nil
  }
  slotTable._itemKey = itemKey
  slotTable._txt_price = itemPrice
  slotTable._slotIndex = key32
  self._itemSlotTable[key32] = slotTable
  if false == PaGlobal_WorldMap_TradeItemList_All._isConsole then
    icon.icon:addInputEvent("Mouse_On", "PaGlobalFunc_TradeMarketItemToolTip_All_Show(" .. itemKey .. ",true)")
    icon.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_TradeMarketItemToolTip_All_Hide()")
    listSlotBg:addInputEvent("Mouse_On", "PaGlobalFunc_TradeMarketItemToolTip_All_Show(" .. itemKey .. ",true)")
    listSlotBg:addInputEvent("Mouse_Out", "PaGlobalFunc_TradeMarketItemToolTip_All_Hide()")
    itemPrice:addInputEvent("Mouse_On", "HandleEventOnOut_WorldMapItemList_All_SimpleTooltip(true," .. key32 .. ",1)")
    itemPrice:addInputEvent("Mouse_Out", "HandleEventOnOut_WorldMapItemList_All_SimpleTooltip(false)")
  else
  end
end
function PaGlobal_WorldMap_TradeItemList_All:checkdataEmpty(currentCategoryIdx, currentNPCType)
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  local commerceItemSize = npcShop_getCommerceItemSize(currentCategoryIdx)
  local uiCount = 0
  local isItemSellorBuy_ByKey = function(currentCategoryIdx, idx, currentNPCType)
    local itemKey = npcShop_GetCommerceItemByIndex(currentCategoryIdx, idx - 1)
    local checkResult = false
    if 0 ~= itemKey then
      if 1 == currentNPCType then
        checkResult = npcShop_CheckBuyFromNPCItem(itemKey)
      elseif 2 == currentNPCType then
        checkResult = npcShop_CheckSellToNPCItem(itemKey)
      elseif 3 == currentNPCType then
        checkResult = true
      else
        UI.ASSERT(false, "\235\185\132\236\160\149\236\131\129\236\160\129\236\157\184 \234\176\146\236\158\133\235\139\136\235\139\164.")
      end
    end
    return checkResult
  end
  for idx = 1, commerceItemSize do
    local boolValue = isItemSellorBuy_ByKey(currentCategoryIdx, idx, currentNPCType)
    if true == boolValue then
      uiCount = uiCount + 1
    end
  end
  return uiCount
end
function PaGlobal_WorldMap_TradeItemList_All:prepareClose()
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  self._itemSlotTable = {}
  self._itemKeyTable = {}
  self._shopItemIndexTable = {}
  self._currentCategoryIdx = -1
  if true == Panel_Dialog_Trade_Tooltip_All:GetShow() then
    PaGlobalFunc_TradeMarketItemToolTip_All_Hide()
  end
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  PaGlobal_WorldMap_TradeItemList_All:close()
end
function PaGlobal_WorldMap_TradeItemList_All:setGraphData(contents, itemKey)
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  if nil == itemKey or nil == contents then
    return
  end
  local graphBg = UI.getChildControl(contents, "Static_GraphBg")
  local LowPoint = UI.getChildControl(graphBg, "Staic_LowestPoint")
  local highestPoint = UI.getChildControl(graphBg, "Static_highestPoint")
  local curPoint = UI.getChildControl(graphBg, "Static_currentPoint")
  local centerLine = UI.getChildControl(graphBg, "Static_CenterLine")
  local itemESSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  local tradeItemWrapper = npcShop_getTradeItem(itemKey)
  local intervalPosY = graphBg:GetSizeY() / 2
  local priceCountSize = tradeItemWrapper:getGraphSize()
  local originalPrice64 = itemESSW:getOriginalPriceByInt64()
  local originalPrice = Int64toInt32(originalPrice64)
  local upperPrice = tradeItemWrapper:getUpperLimitPrice()
  local underprice = tradeItemWrapper:getUnderLimitPrice()
  local variablePrice
  self._minPricePosY = 9999
  self._maxPricePosY = -9999
  self._minPricePosX = -1
  self._maxPricePosX = -1
  local drawPos = tradeItemWrapper:getGraphPosAt(0)
  if nil == drawPos then
    return
  end
  self._minPricePosX = self._graphIntervalValue
  self._maxPricePosX = self._graphIntervalValue
  graphBg:ClearGraphList()
  graphBg:SetGraphMode(true)
  for count = 1, priceCountSize do
    drawPos = tradeItemWrapper:getGraphPosAt(count - 1)
    if drawPos.y > 100 then
      drawPos.y = 100
    end
    if drawPos.y < -100 then
      drawPos.y = -100
    end
    if 0 < drawPos.y then
      variablePrice = upperPrice - originalPrice
    else
      variablePrice = originalPrice - underprice
    end
    drawPos.x = self._graphIntervalValue * count
    local yPos = drawPos.y * intervalPosY / 100
    local pricePercent = drawPos.y
    if intervalPosY <= yPos then
      yPos = yPos - intervalPosY
    elseif intervalPosY >= yPos then
      yPos = intervalPosY - yPos
    else
      yPos = intervalPosY
    end
    drawPos.y = yPos
    graphBg:AddGraphPos(drawPos)
    if self._maxPricePosY <= drawPos.y then
      self._maxPricePosX = drawPos.x
      self._maxPricePosY = drawPos.y
    end
    if self._minPricePosY > drawPos.y then
      self._minPricePosX = drawPos.x
      self._minPricePosY = drawPos.y
    end
  end
  graphBg:interpolationGraph()
  centerLine:ComputePos()
  centerLine:SetShow(true)
  curPoint:SetPosX(drawPos.x - curPoint:GetSizeX() / 2)
  curPoint:SetPosY(drawPos.y - curPoint:GetSizeX() / 2)
  curPoint:SetShow(tradeItemWrapper:isTradableItem())
  LowPoint:SetShow(false)
  highestPoint:SetShow(false)
  if 2 < priceCountSize then
    if drawPos.y ~= self._minPricePosY then
      local graphPosY = graphBg:getinterpolationGraphValue(self._minPricePosX)
      self._minPricePosX = self._minPricePosX - LowPoint:GetSizeX() / 2
      LowPoint:SetPosX(self._minPricePosX)
      LowPoint:SetPosY(graphPosY - LowPoint:GetSizeY() / 2)
      LowPoint:SetShow(true)
    end
    if drawPos.y ~= self._maxPricePosY then
      local graphPosY = graphBg:getinterpolationGraphValue(self._maxPricePosX)
      self._maxPricePosX = self._maxPricePosX - highestPoint:GetSizeX() / 2
      highestPoint:SetPosX(self._maxPricePosX)
      highestPoint:SetPosY(graphPosY - highestPoint:GetSizeY() / 2)
      highestPoint:SetShow(true)
    end
  end
end
function PaGlobal_WorldMap_TradeItemList_All:close()
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  Panel_Worldmap_Trade_MarketItemList_All:SetShow(false)
end
