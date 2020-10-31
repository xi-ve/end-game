function PaGlobal_TradeMarketItemList_All:initialize()
  if true == PaGlobal_TradeMarketItemList_All._initialize or nil == Panel_Dialog_Trade_MarketItemList_All then
    return
  end
  self._ui._stc_TitleBar = UI.getChildControl(Panel_Dialog_Trade_MarketItemList_All, "Static_TitleBar")
  self._ui._txt_Title = UI.getChildControl(self._ui._stc_TitleBar, "StaticText_Title")
  self._ui._list2_TradeItem_Buy = UI.getChildControl(Panel_Dialog_Trade_MarketItemList_All, "List2_TradeItem_Buy")
  self._ui._list2_TradeItemBuy_Contents = UI.getChildControl(self._ui._list2_TradeItem_Buy, "List2_1_Content")
  self._ui._list2_Buy_ListSlotBg = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "Static_ListSlotBg")
  self._ui._list2_Buy_SlotBg = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "Static_SlotBg")
  self._ui._list2_Buy_ItemPrice = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "StaticText_Price")
  self._ui._list2_Buy_ItemName = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "StaticText_ItemName")
  self._ui._list2_Buy_RemainTime = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "StaticText_RemainTime")
  self._ui._list2_Buy_RemainCountTitle = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "StaticText_RemainCountTitle")
  self._ui._list2_Buy_RamainCountValue = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "StaticText_RemainCountValue")
  self._ui._list2_Buy_StateText = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "StaticText_State")
  self._ui._list2_Buy_ViewButton = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "Button_View")
  self._ui._list2_Buy_BuyButton = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "Button_Gather")
  self._ui._list2_Buy_RoyalSupplyIcon = UI.getChildControl(self._ui._list2_TradeItemBuy_Contents, "Static_RoyalSupplyIcon")
  self._ui._list2_Buy_VertiScroll = UI.getChildControl(self._ui._list2_TradeItem_Buy, "List2_1_VerticalScroll")
  self._ui._list2_Buy_HoriScrool = UI.getChildControl(self._ui._list2_TradeItem_Buy, "List2_1_HorizontalScroll")
  self._ui._list2_TradeItem_Sell = UI.getChildControl(Panel_Dialog_Trade_MarketItemList_All, "List2_TradeItem_Sell")
  self._ui._list2_TradeItemSell_Content = UI.getChildControl(self._ui._list2_TradeItem_Sell, "List2_1_Content")
  self._ui._list2_Sell_ListSlotBg = UI.getChildControl(self._ui._list2_TradeItemSell_Content, "Static_ListSlotBg")
  self._ui._list2_Sell_Slot = UI.getChildControl(self._ui._list2_TradeItemSell_Content, "Static_SlotBg")
  self._ui._list2_Sell_itemName = UI.getChildControl(self._ui._list2_TradeItemSell_Content, "StaticText_ItemName")
  self._ui._list2_Sell_itemPrice = UI.getChildControl(self._ui._list2_TradeItemSell_Content, "StaticText_Price")
  self._ui._list2_Sell_LeftCount = UI.getChildControl(self._ui._list2_TradeItemSell_Content, "StaticText_LeftCount")
  self._ui._list2_Sell_VetiScroll = UI.getChildControl(self._ui._list2_TradeItem_Sell, "List2_1_VerticalScroll")
  self._ui._list2_Sell_HoriScroll = UI.getChildControl(self._ui._list2_TradeItem_Sell, "List2_1_HorizontalScroll")
  self._ui._list2_Category = UI.getChildControl(Panel_Dialog_Trade_MarketItemList_All, "List2_Category")
  self._ui._list2_Category_Contents = UI.getChildControl(self._ui._list2_Category, "List2_1_Content")
  self._ui._list2_Category_SupplyLeftBg = UI.getChildControl(self._ui._list2_Category, "Static_EnableCountBg")
  self._ui._list2_Category_SupplyLeftTitle = UI.getChildControl(self._ui._list2_Category_SupplyLeftBg, "StaticText_CountTitle")
  self._ui._list2_Category_SupplyLeftValue = UI.getChildControl(self._ui._list2_Category_SupplyLeftBg, "StaticText_CountValue")
  self._ui._stc_KeyGuides = UI.getChildControl(Panel_Dialog_Trade_MarketItemList_All, "Static_BottomBG_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_KeyGuides, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_KeyGuides, "StaticText_B_ConsoleUI")
  self._ui._stc_KeyGuide_X = UI.getChildControl(self._ui._stc_KeyGuides, "StaticText_X_ConsoleUI")
  local buyIcon = {}
  SlotItem.new(buyIcon, "tradeItemBuyIcon", nil, self._ui._list2_Buy_SlotBg, self.slotConfig)
  buyIcon:createChild()
  buyIcon:clearItem()
  buyIcon.icon:SetHorizonCenter()
  buyIcon.icon:SetVerticalMiddle()
  local sellIcon = {}
  SlotItem.new(sellIcon, "tradeItemSellIcon", nil, self._ui._list2_Sell_Slot, self.slotConfig)
  sellIcon:createChild()
  sellIcon:clearItem()
  sellIcon.icon:SetHorizonCenter()
  sellIcon.icon:SetVerticalMiddle()
  self._originPanelSizeY = Panel_Dialog_Trade_MarketItemList_All:GetSizeY()
  self._originlist2_Sell = self._ui._list2_TradeItem_Sell:GetSizeY()
  self._originlist2_Buy = self._ui._list2_TradeItem_Buy:GetSizeY()
  PaGlobal_TradeMarketItemList_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_TradeMarketItemList_All:validate()
  PaGlobal_TradeMarketItemList_All:registerEventHandler()
  self._ui._stc_KeyGuides:SetShow(self._isConsole)
  if true == self._isConsole then
    PaGlobal_TradeFunction_All:keyGuideAlign()
  end
end
function PaGlobal_TradeMarketItemList_All:validate()
  if nil == Panel_Dialog_Trade_MarketItemList_All then
    return
  end
  self._ui._stc_TitleBar:isValidate()
  self._ui._txt_Title:isValidate()
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
  self._ui._list2_Buy_ViewButton:isValidate()
  self._ui._list2_Buy_BuyButton:isValidate()
  self._ui._list2_Buy_VertiScroll:isValidate()
  self._ui._list2_Buy_HoriScrool:isValidate()
  self._ui._list2_Buy_RoyalSupplyIcon:isValidate()
  self._ui._list2_TradeItem_Sell:isValidate()
  self._ui._list2_TradeItemSell_Content:isValidate()
  self._ui._list2_Sell_ListSlotBg:isValidate()
  self._ui._list2_Sell_Slot:isValidate()
  self._ui._list2_Sell_itemName:isValidate()
  self._ui._list2_Sell_itemPrice:isValidate()
  self._ui._list2_Sell_VetiScroll:isValidate()
  self._ui._list2_Sell_HoriScroll:isValidate()
  self._ui._list2_Sell_LeftCount:isValidate()
  self._ui._list2_Category:isValidate()
  self._ui._list2_Category_Contents:isValidate()
  self._ui._list2_Category_SupplyLeftBg:isValidate()
  self._ui._list2_Category_SupplyLeftTitle:isValidate()
  self._ui._list2_Category_SupplyLeftValue:isValidate()
  self._ui._stc_KeyGuides:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._stc_KeyGuide_B:isValidate()
  self._ui._stc_KeyGuide_X:isValidate()
  self._initialize = true
end
function PaGlobal_TradeMarketItemList_All:onScreenResize()
  if nil == Panel_Dialog_Trade_MarketItemList_All then
    return
  end
  Panel_Dialog_Trade_MarketItemList_All:ComputePos()
  if nil ~= Panel_Dialog_Trade_Function_All then
    local ScreenSizeY = getScreenSizeY()
    local gap = ScreenSizeY - Panel_Dialog_Trade_Function_All:GetSizeY()
    Panel_Dialog_Trade_MarketItemList_All:SetSize(Panel_Dialog_Trade_MarketItemList_All:GetSizeX(), gap)
    local list2Size = Panel_Dialog_Trade_MarketItemList_All:GetSizeY() - (self._ui._stc_TitleBar:GetSizeY() + 20)
    self._ui._list2_TradeItem_Buy:SetSize(self._ui._list2_TradeItem_Buy:GetSizeX(), list2Size)
    self._ui._list2_TradeItem_Sell:SetSize(self._ui._list2_TradeItem_Sell:GetSizeX(), list2Size)
    self._ui._stc_KeyGuides:SetSpanSize(self._ui._stc_KeyGuides:GetSpanSize().x, 0)
    Panel_Dialog_Trade_Function_All:ComputePos()
    self._ui._list2_TradeItem_Buy:ComputePos()
    self._ui._list2_TradeItem_Sell:ComputePos()
  end
end
function PaGlobal_TradeMarketItemList_All:registerEventHandler()
  if nil == Panel_Dialog_Trade_MarketItemList_All or false == PaGlobal_TradeMarketItemList_All._initialize then
    return
  end
  registerEvent("onScreenResize", "FromClient_MarketItemList_All_OnScreenResize")
  registerEvent("EventNpcShopUpdate", "FromClient_MarketItemList_All_UpdateItemList")
  registerEvent("EventNpcTradeShopUpdate", "FromClient_MarketItemList_All_UpdateItemList")
  registerEvent("EventNpcTradeShopGraphRefresh", "FromClient_MarketItemList_All_UpdateItemList")
  self._ui._list2_TradeItem_Buy:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_TradeMarketItemList_All_List2UpdateTradeItemData")
  self._ui._list2_TradeItem_Buy:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2_TradeItem_Sell:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_TradeMarketItemList_All_List2UpdateTradeItemData")
  self._ui._list2_TradeItem_Sell:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2_Category:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_MarketItemList_All_List2UpdateCategoryButtonData")
  self._ui._list2_Category:createChildContent(__ePAUIList2ElementManagerType_List)
  if true == self._isConsole then
    Panel_Dialog_Trade_MarketItemList_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "PaGlobalFunc_TradeFunction_All_ChangeTabByPad( false )")
    Panel_Dialog_Trade_MarketItemList_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "PaGlobalFunc_TradeFunction_All_ChangeTabByPad( true )")
    self._ui._list2_Buy_ListSlotBg:addInputEvent("Mouse_On", "HandleEventOn_TradeMarketItemList_All_SetTexture()")
    self._ui._list2_Buy_ListSlotBg:addInputEvent("Mouse_Out", "HandleEventOut_TradeMarketItemList_All_SetTexture()")
    self._ui._list2_Buy_ListSlotBg:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeMarketItemList_All_SetTexture()")
  else
    self._ui._list2_Category_SupplyLeftBg:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMarketItemList_All_SimpleTooltip(true,0,3)")
    self._ui._list2_Category_SupplyLeftBg:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMarketItemList_All_SimpleTooltip(false)")
  end
end
function PaGlobal_TradeMarketItemList_All:prepareOpen()
  if nil == Panel_Dialog_Trade_MarketItemList_All or nil == Panel_Dialog_Trade_MyBasket_All or nil == Panel_Dialog_Trade_PriceRate_All or nil == Panel_Dialog_Trade_Tooltip_All or nil == Panel_Dialog_Trade_Function_All then
    return
  end
  local talker = dialog_getTalker()
  if nil == talker then
    return
  end
  local npcActorproxy = talker:get()
  if nil ~= npcActorproxy then
    local npcPosition = npcActorproxy:getPosition()
    local npcRegionInfo = getRegionInfoByPosition(npcPosition)
    local npcTradeNodeName = npcRegionInfo:getTradeExplorationNodeName()
    local npcTradeOriginRegion = npcRegionInfo:get():getTradeOriginRegion()
    self._isNodeLinked = checkSelfplayerNode(npcTradeOriginRegion._waypointKey, true)
  end
  local sellCount = npcShop_getBuyCount()
  for itemOrderIndex = 0, sellCount - 1 do
    local itemwrapper = npcShop_getItemBuy(itemOrderIndex)
    local itemStatus = itemwrapper:getStaticStatus()
    local itemSS = itemStatus:get()
    local itemKey = itemSS._key:get()
    self._shopItemIndexTable[itemOrderIndex] = itemKey
  end
  self._currentCategoryIdx = -1
  local npcSSW = npcShop_getCurrentCharacterKeyForTrade():get()
  self._isFishingSupply = npcSSW:isFishSupplyMerchant()
  self._currShopType = nil
  if true == npcSSW:isSupplyMerchant() then
    local characterStaticStatusWrapper = npcShop_getCurrentCharacterKeyForTrade()
    self._currShopType = characterStaticStatusWrapper:getTradeSupplyShopType()
  end
  PaGlobal_TradeMarketItemList_All:open()
  PaGlobal_TradeMarketItemList_All:update()
end
function PaGlobal_TradeMarketItemList_All:updateCategoryButtonData(contents, key)
  if nil == Panel_Dialog_Trade_MarketItemList_All then
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
  if false == self._isConsole then
    rdoButton:addInputEvent("Mouse_LUp", "HandleEventLUp_MarketItemList_All_SelectCategoryBtn(" .. categoryIndex32 .. ")")
  else
    rdoButton:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_MarketItemList_All_SelectCategoryBtn(" .. categoryIndex32 .. ")")
  end
end
function PaGlobal_TradeMarketItemList_All:open()
  if nil == Panel_Dialog_Trade_MarketItemList_All then
    return
  end
  Panel_Dialog_Trade_MarketItemList_All:SetShow(true)
end
function PaGlobal_TradeMarketItemList_All:update()
  if nil == Panel_Dialog_Trade_MarketItemList_All then
    return
  end
  self._currentTab = PaGlobalFunc_TradeFunction_All_GetCurrentTab()
  self._ui._list2_Category_SupplyLeftBg:SetShow(false)
  local isTerritorySupplyCheck = PaGlobalFunc_TradeMarketItemList_All_IsTerritorySupply()
  if 0 == self._currentTab then
    self._currentNpcType = 1
  else
    self._currentNpcType = 2
  end
  if true == isTerritorySupplyCheck then
    self._currentNpcType = 3
    local characterStaticStatusWrapper = npcShop_getCurrentCharacterKeyForTrade()
    local characterStaticStatus = characterStaticStatusWrapper:get()
    if true == characterStaticStatus:isSupplyMerchant() then
      self._ui._list2_Category_SupplyLeftBg:SetShow(true)
      local territoryKeyRaw = ToClient_getDefaultTerritoryKey()
      local explorePoint = ToClient_getExplorePointByTerritoryRaw(territoryKeyRaw)
      local maxExpPoint = explorePoint:getAquiredPoint()
      local leftCount = tostring(ToClient_getTradeSupplyLeftCount(self._currShopType))
      local maxCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEITEMLIST_ALL_COUNT", "count", tostring(ToClient_getTradeSupplyMaxCount(self._currShopType)))
      self._ui._list2_Category_SupplyLeftValue:SetText(leftCount .. " / " .. maxCount)
    end
    self._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_KEY_7"))
  else
    self._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_KEY_8"))
  end
  local tempcategoryCount = 0
  self._ui._list2_Category:getElementManager():clearKey()
  if nil ~= enCommerceType.enCommerceType_Max and nil ~= Panel_Dialog_Scene then
    for idx = 1, enCommerceType.enCommerceType_Max - 1 do
      local itemCount = 0
      if 1 == self._currentNpcType then
        itemCount = PaGlobal_TradeMarketItemList_All:checkdataEmpty(idx, self._currentNpcType)
      else
        itemCount = npcShop_getCommerceItemSize(idx)
      end
      if 0 < itemCount then
        if -1 == self._currentCategoryIdx then
          self._currentCategoryIdx = idx
        end
        tempcategoryCount = tempcategoryCount + 1
        self._ui._list2_Category:getElementManager():pushKey(toInt64(0, idx))
      end
    end
  end
  if true == self._ui._list2_Category_SupplyLeftBg:GetShow() then
    local contentSizeY = self._ui._list2_Category_Contents:GetSizeY() * tempcategoryCount
    local supplyCountBg = self._ui._list2_Category_SupplyLeftBg
    supplyCountBg:SetPosY(contentSizeY + 10)
  end
  PaGlobal_TradeMarketItemList_All:onScreenResize()
  PaGlobal_TradeMarketItemList_All:getItemListByCurrentCategory()
  if true == self._isConsole then
    self._ui._stc_KeyGuide_X:SetShow(0 == self._currentTab)
  end
end
function PaGlobal_TradeMarketItemList_All:getItemListByCurrentCategory()
  if nil == Panel_Dialog_Trade_MarketItemList_All then
    return
  end
  local commerceCount = 0
  local currentCategoryIdx = self._currentCategoryIdx
  if nil == self._currentNpcType or nil == currentCategoryIdx then
    return
  end
  for ii = 1, enCommerceType.enCommerceType_Max - 1 do
    if nil ~= self._ui._categoryBtnGroups[ii] then
      self._ui._categoryBtnGroups[ii]:SetCheck(ii == currentCategoryIdx)
    end
  end
  self._ui._list2_TradeItem_Buy:getElementManager():clearKey()
  self._ui._list2_TradeItem_Sell:getElementManager():clearKey()
  if 1 == self._currentNpcType then
    commerceCount = PaGlobal_TradeMarketItemList_All:checkdataEmpty(currentCategoryIdx, self._currentNpcType)
    self._ui._list2_TradeItem_Buy:SetShow(true)
    self._ui._list2_TradeItem_Sell:SetShow(false)
  else
    commerceCount = npcShop_getCommerceItemSize(currentCategoryIdx)
    self._ui._list2_TradeItem_Sell:SetShow(true)
    self._ui._list2_TradeItem_Buy:SetShow(false)
  end
  for itemIdx = 0, commerceCount - 1 do
    local itemKey = npcShop_GetCommerceItemByIndexAndSellOrBuy(currentCategoryIdx, self._currentNpcType, itemIdx)
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
function PaGlobal_TradeMarketItemList_All:SetTradeItemData(contents, key)
  if nil == Panel_Dialog_Trade_MarketItemList_All then
    return
  end
  local key32 = Int64toInt32(key)
  if 1 == self._currentNpcType then
    PaGlobal_TradeMarketItemList_All:updateBuySlot(contents, key32)
  else
    PaGlobal_TradeMarketItemList_All:updateSellSlot(contents, key32)
  end
end
function PaGlobal_TradeMarketItemList_All:updateBuySlot(contents, key32)
  if nil == Panel_Dialog_Trade_MarketItemList_All then
    return
  end
  if nil == key32 then
    return
  end
  local listBg = UI.getChildControl(contents, "Static_ListSlotBg")
  local itemslotBg = UI.getChildControl(contents, "Static_SlotBg")
  local itemNameTxt = UI.getChildControl(contents, "StaticText_ItemName")
  local itemPriceTxt = UI.getChildControl(contents, "StaticText_Price")
  itemPriceTxt:SetShow(false)
  local remainTimeIcon = UI.getChildControl(contents, "StaticText_RemainTime")
  remainTimeIcon:SetShow(false)
  local txt_RemainCount = UI.getChildControl(contents, "StaticText_RemainCountValue")
  txt_RemainCount:SetShow(false)
  local txt_RemainCountTitle = UI.getChildControl(contents, "StaticText_RemainCountTitle")
  txt_RemainCountTitle:SetShow(false)
  local buyingConditionTxt = UI.getChildControl(contents, "StaticText_State")
  buyingConditionTxt:SetFontColor(Defines.Color.C_FFC4C4C4)
  buyingConditionTxt:SetShow(false)
  local marketPriceViewButton = UI.getChildControl(contents, "Button_View")
  marketPriceViewButton:SetShow(false)
  local buyButton = UI.getChildControl(contents, "Button_Gather")
  buyButton:SetShow(false)
  local loyalSupplyIcon = UI.getChildControl(contents, "Static_RoyalSupplyIcon")
  loyalSupplyIcon:SetShow(false)
  listBg:setNotImpactScrollEvent(true)
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
  local buyableStack = tradeItemWrapper:get():calculateRemainCount()
  local currentTab = self._currentTab
  loyalSupplyIcon:SetShow(false)
  buyButton:SetIgnore(true)
  local isBuyable = true
  local conditionLevel = PaGlobalFunc_Util_CraftLevelReplace(needLifeLevel + 1)
  local conditionTypeName = CppEnums.LifeExperienceString[needLifeType]
  local buyingConditionValue = ""
  if 0 == needLifeLevel or nil == needLifeLevel then
    buyingConditionTxt:SetShow(false)
  else
    local playerThisCraftLevel = getSelfPlayer():get():getLifeExperienceLevel(needLifeType)
    if needLifeLevel < playerThisCraftLevel then
      buyingConditionTxt:SetFontColor(Defines.Color.C_FFC4C4C4)
    else
      buyingConditionTxt:SetFontColor(Defines.Color.C_FFD05D48)
      isBuyable = false
    end
    buyingConditionValue = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_BUYINGCONDITION", "conditionTypeName", conditionTypeName, "conditionLevel", conditionLevel)
    buyingConditionTxt:SetShow(true)
  end
  itemNameTxt:SetTextMode(__eTextMode_LimitText)
  itemNameTxt:SetText(itemESSW:getName())
  PAGlobalFunc_SetItemTextColorForNewUI(itemNameTxt, itemESSW)
  local icon = {}
  SlotItem.reInclude(icon, "tradeItemBuyIcon", 0, itemslotBg, self.slotConfig)
  icon:setItemByStaticStatus(itemESSW)
  local priceRate_Value = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_SELLRATES", "Percent", tostring(sellRateTxt))
  if 100 < tonumber(tostring(sellRateTxt)) then
    priceRate_Value = "(<PAColor0xFF66CC33>" .. priceRate_Value .. "<PAOldColor>\226\150\178)"
  else
    priceRate_Value = "(<PAColor0xFF66CC33>" .. priceRate_Value .. "<PAOldColor>\226\150\188)"
  end
  itemPriceTxt:SetText(makeDotMoney(sellPrice) .. " " .. priceRate_Value)
  itemPriceTxt:SetShow(true)
  if 1 == self._currentNpcType then
    buyingConditionTxt:SetText(buyingConditionValue)
    local cartItemCount = PaGlobalFunc_TradeMyBasket_All_GetCartItemCount(itemKey)
    local currentStack = buyableStack
    if 0 ~= cartItemCount then
      currentStack = buyableStack - cartItemCount
    end
    txt_RemainCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEITEMLIST_ALL_COUNT", "count", tostring(currentStack)))
    txt_RemainCount:SetShow(true)
    txt_RemainCountTitle:SetShow(true)
    if toInt64(0, 0) == currentStack then
      buyButton:SetIgnore(true)
      buyButton:SetMonoTone(true)
      txt_RemainCount:SetFontColor(Defines.Color.C_FFD05D48)
    else
      buyButton:SetIgnore(false)
      buyButton:SetMonoTone(false)
      txt_RemainCount:SetFontColor(Defines.Color.C_FFF5BA3A)
    end
    if nil ~= tradeItemWrapper:getStaticStatus():get() then
      remainTimeIcon:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEITEMLIST_ALL_LEFTTIME", "time", tostring(tradeItemWrapper:getStaticStatus():get()._expirationPeriod / 60)))
      remainTimeIcon:SetShow(true)
    end
  end
  if false == tradeItemWrapper:isTradableItem() and false == self._isNodeLinked then
    if itemSS._tradeType == 1 then
      buyingConditionTxt:SetText(PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_GRAPH_TXT_PERMISSION2"))
    else
      buyingConditionTxt:SetText(PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_GRAPH_TXT_PERMISSION"))
    end
    isBuyable = false
    txt_RemainCountTitle:SetShow(false)
    buyingConditionTxt:SetShow(true)
    txt_RemainCount:SetShow(false)
    itemPriceTxt:SetShow(false)
  end
  if false == self._isConsole then
    buyButton:SetShow(isBuyable)
    marketPriceViewButton:SetShow(isBuyable)
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
  if false == self._isConsole then
    listBg:addInputEvent("Mouse_On", "PaGlobalFunc_TradeMarketItemToolTip_All_Show(" .. itemKey .. ",false)")
    listBg:addInputEvent("Mouse_Out", "PaGlobalFunc_TradeMarketItemToolTip_All_Hide()")
    marketPriceViewButton:addInputEvent("Mouse_LUp", "HandleEventLUp_MarketItemList_All_ShowTrendItemPrice(" .. enchantKey .. "," .. itemKey .. ")")
    buyButton:addInputEvent("Mouse_LUp", "HandleEventLUp_MarketItemList_All_SetItemToCart(" .. itemKey .. "," .. shopItemIdx .. ")")
    itemPriceTxt:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMarketItemList_All_SimpleTooltip(true," .. key32 .. ",1)")
    itemPriceTxt:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMarketItemList_All_SimpleTooltip(false)")
    remainTimeIcon:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMarketItemList_All_SimpleTooltip(true," .. key32 .. ",0)")
    remainTimeIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMarketItemList_All_SimpleTooltip(false)")
    if nil ~= territorySupplyKey then
      loyalSupplyIcon:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMarketItemList_All_SimpleTooltip( true, " .. key32 .. ", 4, " .. territorySupplyKey .. " )")
      loyalSupplyIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMarketItemList_All_SimpleTooltip( false, " .. key32 .. ", 4, " .. territorySupplyKey .. " )")
    end
  else
    listBg:addInputEvent("Mouse_On", "PaGlobalFunc_TradeMarketItemToolTip_All_Show(" .. itemKey .. ",false, " .. tostring(isBuyable) .. ")")
    listBg:addInputEvent("Mouse_Out", "PaGlobalFunc_TradeMarketItemToolTip_All_Hide()")
    if true == isBuyable then
      listBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_MarketItemList_All_ShowTrendItemPrice(" .. enchantKey .. "," .. itemKey .. ")")
      listBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_MarketItemList_All_SetItemToCart(" .. itemKey .. "," .. shopItemIdx .. ")")
    else
      listBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
      listBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    end
    PaGlobal_TradeFunction_All:keyGuideAlign()
    marketPriceViewButton:SetShow(false)
    buyButton:SetShow(false)
  end
end
function PaGlobal_TradeMarketItemList_All:updateSellSlot(contents, key32)
  if nil == Panel_Dialog_Trade_MarketItemList_All then
    return
  end
  if nil == key32 then
    return
  end
  local listSlotBg = UI.getChildControl(contents, "Static_ListSlotBg")
  local iconSlot = UI.getChildControl(contents, "Static_SlotBg")
  local itemName = UI.getChildControl(contents, "StaticText_ItemName")
  local itemPrice = UI.getChildControl(contents, "StaticText_Price")
  local leftCount = UI.getChildControl(contents, "StaticText_LeftCount")
  local isTerritorySupplyCheck = PaGlobalFunc_TradeMarketItemList_All_IsTerritorySupply()
  listSlotBg:setNotImpactScrollEvent(true)
  local itemKey = self._itemKeyTable[key32]
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
  if true == isTerritorySupplyCheck then
    leftCount:SetShow(true)
    local _s64_leftCount = tradeItemWrapper:getLeftCount()
    local _leftCount = Int64toInt32(_s64_leftCount)
    if Defines.s64_const.s64_0 == _s64_leftCount then
      leftCount:SetText("<PAColor0xFFDB2B2B>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEITEMLIST_ALL_COUNT", "count", _leftCount) .. "<PAOldColor>")
    else
      leftCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEITEMLIST_ALL_COUNT", "count", _leftCount))
    end
    leftCount:SetPosX(self._ui._list2_Sell_LeftCount:GetPosX() - (leftCount:GetTextSizeX() - 15))
  else
    leftCount:SetShow(false)
  end
  itemPrice:ChangeTextureInfoNameAsync("combine/icon/combine_basic_icon_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(itemPrice, 359, 103, 409, 153)
  itemPrice:getBaseTexture():setUV(x1, y1, x2, y2)
  itemPrice:setRenderTexture(itemPrice:getBaseTexture())
  itemPrice:SetFontColor(Defines.Color.C_FFFFEDD4)
  itemPrice:SetText(makeDotMoney(sellPrice) .. " " .. priceRate_Value)
  self:setMoneyTexture(itemPrice)
  local icon = {}
  SlotItem.reInclude(icon, "tradeItemSellIcon", 0, iconSlot, self.slotConfig)
  icon:setItemByStaticStatus(itemESSW)
  listSlotBg:EraseAllEffect()
  if false == self._isNodeLinked and false == self._isFishingSupply then
    itemPrice:ChangeTextureInfoNameAsync("")
    if itemSS._tradeType == 1 then
      itemPrice:SetText(PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_GRAPH_TXT_PERMISSION2"))
    else
      itemPrice:SetText(PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_GRAPH_TXT_PERMISSION"))
    end
    itemPrice:SetFontColor(Defines.Color.C_FFC4C4C4)
    leftCount:SetShow(false)
  end
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
  if false == self._isConsole then
    listSlotBg:addInputEvent("Mouse_On", "PaGlobalFunc_TradeMarketItemToolTip_All_Show(" .. itemKey .. ",false)")
    listSlotBg:addInputEvent("Mouse_Out", "PaGlobalFunc_TradeMarketItemToolTip_All_Hide()")
    itemPrice:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMarketItemList_All_SimpleTooltip(true," .. key32 .. ",1)")
    itemPrice:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMarketItemList_All_SimpleTooltip(false)")
  else
    listSlotBg:addInputEvent("Mouse_On", "PaGlobalFunc_TradeMarketItemToolTip_All_Show(" .. itemKey .. ",false)")
    listSlotBg:addInputEvent("Mouse_Out", "PaGlobalFunc_TradeMarketItemToolTip_All_Hide()")
  end
end
function PaGlobal_TradeMarketItemList_All:checkdataEmpty(currentCategoryIdx, currentNPCType)
  if nil == Panel_Dialog_Trade_MarketItemList_All then
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
function PaGlobal_TradeMarketItemList_All:setMoneyTexture(control)
  control:ComputePos()
  local originPosX = control:GetPosX()
  if __eTradeSupplyShopType_Shell == self._currShopType then
    control:ChangeTextureInfoName("Combine/Icon/Combine_Cashshop_Icon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 101, 24, 120, 43)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    control:SetSize(20, 20)
    control:SetPosY(40)
    control:SetPosX(originPosX + 5)
  else
    control:ChangeTextureInfoName("combine/icon/combine_basic_icon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 359, 103, 409, 153)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    control:SetSize(35, 35)
    control:SetPosY(37)
  end
end
function PaGlobal_TradeMarketItemList_All:prepareClose()
  if nil == Panel_Dialog_Trade_MarketItemList_All then
    return
  end
  self._itemSlotTable = {}
  self._itemKeyTable = {}
  self._shopItemIndexTable = {}
  self._currentCategoryIdx = -1
  self._currentItemKeyForTrendPriceView = -1
  self._isFishingSupply = false
  TooltipSimple_Hide()
  PaGlobal_TradeMarketItemList_All:close()
end
function PaGlobal_TradeFunction_All:keyGuideAlign()
  if false == self._isConsole then
    return
  end
  local keyGuides = {
    self._ui._stc_KeyGuide_X,
    self._ui._stc_KeyGuide_A,
    self._ui._stc_KeyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_BOTTOM)
end
function PaGlobal_TradeMarketItemList_All:close()
  if nil == Panel_Dialog_Trade_MarketItemList_All then
    return
  end
  Panel_Dialog_Trade_MarketItemList_All:SetShow(false)
end
