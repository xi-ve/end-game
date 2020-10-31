function PaGlobalFunc_MarketItemList_All_Open()
  if nil == Panel_Dialog_Trade_MarketItemList_All then
    return
  end
  PaGlobal_TradeMarketItemList_All:prepareOpen()
end
function PaGlobalFunc_MarketItemList_All_Close()
  if nil == Panel_Dialog_Trade_MarketItemList_All then
    return
  end
  PaGlobal_TradeMarketItemList_All:prepareClose()
end
function FromClient_MarketItemList_All_OnScreenResize()
  if nil == Panel_Dialog_Trade_MarketItemList_All or false == Panel_Dialog_Trade_MarketItemList_All:GetShow() then
    return
  end
  PaGlobal_TradeMarketItemList_All:onScreenResize()
end
function FromClient_MarketItemList_All_UpdateItemList()
  if nil == Panel_Dialog_Trade_MarketItemList_All or false == Panel_Dialog_Trade_MarketItemList_All:GetShow() then
    return
  end
  PaGlobal_TradeMarketItemList_All:update()
end
function HandleEventLUp_MarketItemList_All_SelectCategoryBtn(idx)
  if nil == Panel_Dialog_Trade_MarketItemList_All or false == Panel_Dialog_Trade_MarketItemList_All:GetShow() then
    return
  end
  PaGlobal_TradeMarketItemList_All._itemSlotTable = {}
  PaGlobal_TradeMarketItemList_All._currentCategoryIdx = idx
  PaGlobal_TradeMarketItemList_All:getItemListByCurrentCategory()
end
function PaGlobalFunc_MarketItemList_All_ChangeTab()
  if nil == Panel_Dialog_Trade_MarketItemList_All then
    return
  end
  PaGlobal_TradeMarketItemList_All._itemSlotTable = {}
  PaGlobal_TradeMarketItemList_All._currentCategoryIdx = -1
  PaGlobal_TradeMarketItemList_All:update()
end
function FromClient_MarketItemList_All_List2UpdateCategoryButtonData(contents, key)
  if nil == Panel_Dialog_Trade_MarketItemList_All or false == Panel_Dialog_Trade_MarketItemList_All:GetShow() then
    return
  end
  PaGlobal_TradeMarketItemList_All:updateCategoryButtonData(contents, key)
end
function FromClient_TradeMarketItemList_All_List2UpdateTradeItemData(contents, key)
  if nil == Panel_Dialog_Trade_MarketItemList_All or false == Panel_Dialog_Trade_MarketItemList_All:GetShow() then
    return
  end
  PaGlobal_TradeMarketItemList_All:SetTradeItemData(contents, key)
end
function HandleEventLUp_MarketItemList_All_ShowTrendItemPrice(itemEnchantKey, itemKey)
  if nil == Panel_Dialog_Trade_MarketItemList_All or nil == Panel_Dialog_Trade_PriceRate_All then
    return
  end
  local talker = dialog_getTalker()
  if nil == talker or nil == itemEnchantKey then
    return
  end
  if true == Panel_NumberPad_IsPopUp() then
    Panel_NumberPad_Close()
  end
  local actorProxyWrapper = getNpcActor(talker:getActorKey())
  local actorProxy = actorProxyWrapper:get()
  local characterStaticStatus = actorProxy:getCharacterStaticStatus()
  local function showTrend()
    if nil == itemEnchantKey or nil == talker:getActorKey() then
      return
    end
    ToClient_SendTrendInfo(talker:getActorKey(), itemEnchantKey)
  end
  PaGlobal_TradeMarketItemList_All._currentItemKeyForTrendPriceView = itemKey
  if characterStaticStatus:isTerritorySupplyMerchant() or characterStaticStatus:isTerritoryTradeMerchant() then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_BUYLIST_TERRITORYSUPPLY_MEMO")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_BUYLIST_TERRITORYSUPPLY_TITLE"),
      content = messageBoxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if 1 > getSelfPlayer():getWp() then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_BUYLIST_WPCHECK_MEMO")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_BUYLIST_TERRITORYSUPPLY_TITLE"),
      content = messageBoxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  _trendIndex = index
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_BUYLIST_WPUSE_MEMO")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_BUYLIST_TERRITORYSUPPLY_TITLE"),
    content = messageBoxMemo,
    functionYes = showTrend,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_MarketItemList_All_SetItemToCart(itemKey, shopItemIdx)
  if nil == Panel_Dialog_Trade_MarketItemList_All or false == Panel_Dialog_Trade_MarketItemList_All:GetShow() then
    return
  end
  if true == Panel_NumberPad_IsPopUp() then
    Panel_NumberPad_Close()
  end
  local param = {
    [0] = itemKey,
    [1] = shopItemIdx
  }
  local tradeItemWrapper = npcShop_getTradeItem(itemKey)
  local buyableStack = tradeItemWrapper:get():calculateRemainCount()
  local cartItemCount = PaGlobalFunc_TradeMyBasket_All_GetCartItemCount(itemKey)
  local currentStack = buyableStack
  if 0 ~= cartItemCount then
    currentStack = buyableStack - cartItemCount
  end
  if toInt64(0, 0) == currentStack then
    return
  end
  Panel_NumberPad_Show(true, currentStack, param, HandleEventLUp_MarketItemList_All_SetItemToCartConfirm)
end
function HandleEventLUp_MarketItemList_All_SetItemToCartConfirm(inputNumber, param)
  if nil == Panel_Dialog_Trade_MyBasket_All or nil == Panel_Dialog_Trade_MarketItemList_All or false == Panel_Dialog_Trade_MarketItemList_All:GetShow() then
    return
  end
  if nil == param then
    return
  end
  if nil == inputNumber then
    return
  end
  PaGlobalFunc_TradeMyBasket_All_GetItemToCart(inputNumber, param[0], param[1])
  PaGlobal_TradeMarketItemList_All:update()
end
function PaGlobalFunc_MarketItemList_All_GetItemKeyForTrendPriceView()
  if nil == Panel_Dialog_Trade_MarketItemList_All or false == Panel_Dialog_Trade_MarketItemList_All:GetShow() or nil == PaGlobal_TradeMarketItemList_All._currentItemKeyForTrendPriceView then
    return
  end
  return PaGlobal_TradeMarketItemList_All._currentItemKeyForTrendPriceView
end
function PaGlobalFunc_TradeMarketItemList_All_FindClickedItem(itemSS)
  if nil == itemSS then
    return
  end
  local clickSellItemKey = itemSS:get()._key:get()
  local clickSellCommerceType = itemSS:getCommerceType()
  local tempIndex = 0
  HandleEventLUp_MarketItemList_All_SelectCategoryBtn(clickSellCommerceType)
  if nil ~= PaGlobal_TradeMarketItemList_All._itemKeyTable then
    for i = 0, #PaGlobal_TradeMarketItemList_All._itemKeyTable do
      if nil ~= PaGlobal_TradeMarketItemList_All._itemKeyTable[i] and PaGlobal_TradeMarketItemList_All._itemKeyTable[i] == clickSellItemKey then
        tempIndex = i
      end
    end
  end
  if nil ~= tempIndex then
    local finalIdx = PaGlobal_TradeMarketItemList_All._ui._list2_TradeItem_Sell:getIndexByKey(toInt64(0, tempIndex))
    PaGlobal_TradeMarketItemList_All._ui._list2_TradeItem_Sell:moveIndex(finalIdx)
  end
end
function HandleEventOnOut_TradeMarketItemList_All_SimpleTooltip(isShow, index, tipType, territorySupplyKey)
  if nil == Panel_Dialog_Trade_MarketItemList_All or false == Panel_Dialog_Trade_MarketItemList_All:GetShow() then
    return
  end
  if not isShow or nil == index or nil == PaGlobal_TradeMarketItemList_All._itemSlotTable then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_BUYLIST_TOOLTIP_PRICEENSURE")
    control = PaGlobal_TradeMarketItemList_All._itemSlotTable[index]._stc_remainTimeIcon
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_GRAPH_SIMPLETOOLTIP_NAME")
    control = PaGlobal_TradeMarketItemList_All._itemSlotTable[index]._txt_price
  elseif 3 == tipType then
    name = ""
    desc = PAGetString(Defines.StringSheet_GAME, "Lua_TradeMarketGraph_DailySupplyCountDesc")
    control = PaGlobal_TradeMarketItemList_All._ui._list2_Category_SupplyLeftBg
  elseif 4 == tipType then
    local stringTerritoryName = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_" .. tostring(territorySupplyKey))
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEMARKET_EVENTINFO_SUBTITLE_2")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEMARKET_BUYLIST_SUPPLY", "territoryName", stringTerritoryName)
    control = PaGlobal_TradeMarketItemList_All._itemSlotTable[index]._loyalSupply
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOn_TradeMarketItemList_All_SetTexture()
  PaGlobal_TradeMarketItemList_All._ui._list2_Buy_SlotBg:ChangeTextureInfoName("combine/frame/combine_frame_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(307, 1, 357, 16)
  PaGlobal_TradeMarketItemList_All._ui._list2_Buy_SlotBg:getBaseTexture():setUV(x1, y1, x2, y2)
end
function HandleEventOut_TradeMarketItemList_All_SetTexture()
  PaGlobal_TradeMarketItemList_All._ui._list2_Buy_SlotBg:ChangeTextureInfoName("combine/frame/combine_frame_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(256, 1, 306, 1)
  PaGlobal_TradeMarketItemList_All._ui._list2_Buy_SlotBg:getBaseTexture():setUV(x1, y1, x2, y2)
end
function HandleEventLUp_TradeMarketItemList_All_SetTexture()
  PaGlobal_TradeMarketItemList_All._ui._list2_Buy_SlotBg:ChangeTextureInfoName("combine/frame/combine_frame_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(358, 1, 408, 1)
  PaGlobal_TradeMarketItemList_All._ui._list2_Buy_SlotBg:getBaseTexture():setUV(x1, y1, x2, y2)
end
function PaGlobalFunc_TradeMarketItemList_All_GetCurrShopType()
  if nil == Panel_Dialog_Trade_MarketItemList_All or false == Panel_Dialog_Trade_MarketItemList_All:GetShow() then
    return nil
  end
  return PaGlobal_TradeMarketItemList_All._currShopType
end
function PaGlobalFunc_TradeMarketItemList_All_ShowKeyGuideX(set)
  if nil == Panel_Dialog_Trade_MarketItemList_All or false == Panel_Dialog_Trade_MarketItemList_All:GetShow() then
    return
  end
  if nil == set then
    return
  end
  PaGlobal_TradeMarketItemList_All._ui._stc_KeyGuide_X:SetShow(set)
end
