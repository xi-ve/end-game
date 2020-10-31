function PaGlobalFunc_TradeMarketItemToolTip_All_Show(itemKey, isWorldMap, isBuyAble)
  if nil == Panel_Dialog_Trade_MarketItemList_All or nil == Panel_Dialog_Trade_Tooltip_All or nil == itemKey then
    return
  end
  PaGlobal_TradeMarketItemToolTip_All._currentItemKey = itemKey
  local itemESSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  local itemName = itemESSW:getName()
  local originalPrice64 = itemESSW:getOriginalPriceByInt64()
  local originalPrice = Int64toInt32(originalPrice64)
  local gotWeight = itemESSW:get()._weight
  local itemDesc = PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_DESC_TITLE") .. " " .. itemESSW:getDescription()
  local currentUI = PaGlobal_TradeMarketItemToolTip_All._ui
  currentUI._txt_ItemName:SetTextMode(__eTextMode_AutoWrap)
  currentUI._txt_ItemName:SetText(itemName)
  if true == currentUI._txt_ItemName:IsAutoWrapText() then
    currentUI._txt_Weight:SetPosY(currentUI._originWeightText + 3)
  end
  PAGlobalFunc_SetItemTextColorForNewUI(currentUI._txt_ItemName, itemESSW)
  currentUI._txt_Weight:SetText(makeWeightString(gotWeight, 1) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
  currentUI._txt_OriginalPrice:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_ORIGINALPRICE", "OriginalPrice", ""))
  currentUI._txt_OriginalPriceValue:SetText(makeDotMoney(originalPrice))
  currentUI._txt_OriginalPriceValue:SetPosX(currentUI._txt_OriginalPrice:GetPosX() + currentUI._txt_OriginalPrice:GetTextSizeX() + 3)
  currentUI._txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  currentUI._txt_Desc:SetText(itemDesc)
  PaGlobalFunc_TradeMarketItemToolTip_All_SetMoneyTexture(currentUI._txt_OriginalPriceValue)
  local icon = {}
  SlotItem.reInclude(icon, "ItemIcon_Tooltip", nil, PaGlobal_TradeMarketItemToolTip_All._ui._stc_SlotBg, PaGlobal_TradeMarketItemToolTip_All.slotConfig)
  icon:setItemByStaticStatus(itemESSW)
  local originalTextSizeY = PaGlobal_TradeMarketItemToolTip_All._ui._originalTextSizeY
  local textSizeY = currentUI._txt_Desc:GetTextSizeY()
  currentUI._txt_Desc:SetSize(currentUI._txt_Desc:GetSizeX(), textSizeY + 5)
  local adjustTextSizeY = currentUI._txt_Desc:GetPosY() + currentUI._txt_Desc:GetSizeY()
  currentUI._txt_OriginalPrice:SetPosY(adjustTextSizeY + 3)
  currentUI._txt_OriginalPriceValue:SetPosY(currentUI._txt_OriginalPrice:GetPosY() + currentUI._txt_OriginalPrice:GetSizeY() / 2 - currentUI._txt_OriginalPriceValue:GetSizeY() / 2 + 2)
  currentUI._stc_GraphBg:SetPosY(currentUI._txt_OriginalPrice:GetPosY() + currentUI._txt_OriginalPrice:GetSizeY() + 5)
  local gap = 0
  local panelSizeX = Panel_Dialog_Trade_Tooltip_All:GetSizeX()
  local panelOriginSizeY = PaGlobal_TradeMarketItemToolTip_All._ui._originalPanelSizeY
  local TooltipPosY = getScreenSizeY() / Panel_Dialog_Trade_Tooltip_All:GetSizeY() + 50
  local TooltipPosX = 0
  if false == isWorldMap or nil == isWorldMap then
    gap = currentUI._txt_Desc:GetSizeY() - originalTextSizeY - 40
    TooltipPosX = Panel_Dialog_Trade_MarketItemList_All:GetSizeX() + Panel_Dialog_Trade_MarketItemList_All:GetPosX() + Panel_Dialog_Trade_MarketItemList_All:GetSpanSize().x
    PaGlobal_TradeMarketItemToolTip_All._ui._stc_GraphBg:SetShow(true)
    PaGlobal_TradeMarketItemToolTip_All:setTooltipData()
    if true == _ContentsGroup_RenewUI and nil ~= isBuyAble then
      PaGlobalFunc_TradeMarketItemList_All_ShowKeyGuideX(isBuyAble)
    end
  else
    gap = currentUI._txt_Desc:GetSizeY() - originalTextSizeY - PaGlobal_TradeMarketItemToolTip_All._ui._stc_GraphBg:GetSizeY() - 30
    TooltipPosX = Panel_Worldmap_Trade_MarketItemList_All:GetPosX() - Panel_Dialog_Trade_Tooltip_All:GetSizeX()
    PaGlobal_TradeMarketItemToolTip_All._ui._stc_GraphBg:SetShow(false)
  end
  Panel_Dialog_Trade_Tooltip_All:SetSize(panelSizeX, panelOriginSizeY + gap)
  Panel_Dialog_Trade_Tooltip_All:SetPosX(TooltipPosX)
  Panel_Dialog_Trade_Tooltip_All:SetPosY(TooltipPosY)
  Panel_Dialog_Trade_Tooltip_All:SetShow(true)
end
function PaGlobalFunc_TradeMarketItemToolTip_All_Hide()
  if nil == Panel_Dialog_Trade_Tooltip_All or false == Panel_Dialog_Trade_Tooltip_All:GetShow() then
    return
  end
  Panel_Dialog_Trade_Tooltip_All:SetShow(false)
end
function PaGlobal_TradeMarketItemToolTip_All_OnScreenReSize()
  if nil == Panel_Dialog_Trade_Tooltip_All or false == Panel_Dialog_Trade_Tooltip_All:GetShow() then
    return
  end
  PaGlobalFunc_TradeMarketItemToolTip_All_Hide()
end
function PaGlobalFunc_TradeMarketItemToolTip_All_GraphUpdate()
  if nil == Panel_Dialog_Trade_Tooltip_All or false == Panel_Dialog_Trade_Tooltip_All:GetShow() or nil == PaGlobal_TradeMarketItemToolTip_All._currentItemKey then
    return
  end
  local currentItemKey = PaGlobal_TradeMarketItemToolTip_All._currentItemKey
  PaGlobalFunc_TradeMarketItemToolTip_All_Show(currentItemKey, false)
end
function PaGlobalFunc_TradeMarketItemToolTip_All_SetMoneyTexture(control)
  local shopType
  if nil ~= PaGlobalFunc_TradeMarketItemList_All_GetCurrShopType then
    shopType = PaGlobalFunc_TradeMarketItemList_All_GetCurrShopType()
  end
  if __eTradeSupplyShopType_Shell == shopType then
    control:ChangeTextureInfoName("Combine/Icon/Combine_Cashshop_Icon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 101, 24, 120, 43)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    control:SetSize(20, 20)
  else
    control:ChangeTextureInfoName("combine/icon/combine_basic_icon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 359, 103, 409, 153)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    control:SetSize(35, 35)
  end
end
