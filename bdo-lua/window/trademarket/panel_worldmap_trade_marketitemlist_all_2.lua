function PaGlobalFunc_WorldMapItemList_All_OpenByWorldMap()
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  PaGlobal_WorldMap_TradeItemList_All:prepareOpen()
end
function PaGlobalFunc_WorldMapItemList_All_Close()
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  PaGlobal_WorldMap_TradeItemList_All:prepareClose()
end
function FromClient_WorldMapItemList_All_OnScreenResize()
  if nil == Panel_Worldmap_Trade_MarketItemList_All or false == Panel_Worldmap_Trade_MarketItemList_All:GetShow() then
    return
  end
  PaGlobal_WorldMap_TradeItemList_All:onScreenResize()
end
function FromClient_WorldMapItemList_All_UpdateItemList()
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  PaGlobal_WorldMap_TradeItemList_All:update()
end
function HandleEventLUp_WorldMapItemList_All_SelectCategoryBtn(idx)
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  if idx == PaGlobal_WorldMap_TradeItemList_All._currentCategoryIdx then
    return
  end
  PaGlobal_WorldMap_TradeItemList_All._itemSlotTable = {}
  PaGlobal_WorldMap_TradeItemList_All._currentCategoryIdx = idx
  PaGlobal_WorldMap_TradeItemList_All:getItemListByCurrentCategory()
end
function HandleEventLUp_WorldMapItemList_All_ChangeTab(idx)
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  PaGlobal_WorldMap_TradeItemList_All._itemSlotTable = {}
  for tabIdx = 0, #PaGlobal_WorldMap_TradeItemList_All._ui._tabBtnGroups - 1 do
    if idx == tabIdx then
      PaGlobal_WorldMap_TradeItemList_All._ui._tabBtnGroups[tabIdx]:SetCheck(true)
    else
      PaGlobal_WorldMap_TradeItemList_All._ui._tabBtnGroups[tabIdx]:SetCheck(false)
    end
  end
  local selectBarPosX = PaGlobal_WorldMap_TradeItemList_All._ui._tabBtnGroups[idx]:GetSpanSize().x
  local selectBarPosY = PaGlobal_WorldMap_TradeItemList_All._ui._stc_Selected_Line:GetSpanSize().y
  PaGlobal_WorldMap_TradeItemList_All._ui._stc_Selected_Line:SetSpanSize(selectBarPosX, selectBarPosY)
  PaGlobal_WorldMap_TradeItemList_All._currentTab = idx
  PaGlobal_WorldMap_TradeItemList_All._currentCategoryIdx = -1
  if 0 == PaGlobal_WorldMap_TradeItemList_All._currentTab then
    PaGlobal_WorldMap_TradeItemList_All._currentNpcType = 1
  else
    PaGlobal_WorldMap_TradeItemList_All._currentNpcType = 2
  end
  PaGlobal_WorldMap_TradeItemList_All:update()
end
function FromClient_WorldMapItemList_All_List2UpdateCategoryButtonData(contents, key)
  if nil == Panel_Worldmap_Trade_MarketItemList_All or false == Panel_Worldmap_Trade_MarketItemList_All:GetShow() then
    return
  end
  PaGlobal_WorldMap_TradeItemList_All:updateCategoryButtonData(contents, key)
end
function FromClient_WorldMapItemList_All_List2UpdateTradeItemData(contents, key)
  if nil == Panel_Worldmap_Trade_MarketItemList_All then
    return
  end
  PaGlobal_WorldMap_TradeItemList_All:setTradeItemData(contents, key)
end
function HandleEventOnOut_WorldMapItemList_All_SimpleTooltip(isShow, index, tipType, territorySupplyKey)
  if nil == Panel_Worldmap_Trade_MarketItemList_All or false == Panel_Worldmap_Trade_MarketItemList_All:GetShow() then
    return
  end
  if not isShow or nil == index or nil == PaGlobal_WorldMap_TradeItemList_All._itemSlotTable then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_BUYLIST_TOOLTIP_PRICEENSURE")
    control = PaGlobal_WorldMap_TradeItemList_All._itemSlotTable[index]._stc_remainTimeIcon
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_GRAPH_SIMPLETOOLTIP_NAME")
    control = PaGlobal_WorldMap_TradeItemList_All._itemSlotTable[index]._txt_price
  elseif 2 == tipType then
    local stringTerritoryName = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_" .. tostring(territorySupplyKey))
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEMARKET_EVENTINFO_SUBTITLE_2")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEMARKET_BUYLIST_SUPPLY", "territoryName", stringTerritoryName)
    control = PaGlobal_WorldMap_TradeItemList_All._itemSlotTable[index]._loyalSupply
  end
  TooltipSimple_Show(control, name, desc)
end
