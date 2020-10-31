function PaGlobalFunc_TradeFunction_All_Open()
  if nil == Panel_Dialog_Trade_Function_All then
    return
  end
  PaGlobal_TradeFunction_All:prepareOpen()
end
function HandleEventLUp_TradeFunction_All_Close()
  if nil == Panel_Dialog_Trade_Function_All then
    return
  end
  PaGlobal_TradeFunction_All:prepareClose()
end
function FromClient_TradeFunction_All_OnScreenResize()
  if nil == PaGlobal_TradeFunction_All or false == Panel_Dialog_Trade_Function_All:GetShow() then
    return
  end
  PaGlobal_TradeFunction_All:onScreenResize()
end
function PaGlobalFunc_TradeFunction_All_ChangeTab(idx)
  if nil == Panel_Dialog_Trade_Function_All or false == Panel_Dialog_Trade_Function_All:GetShow() or nil == idx then
    return
  end
  if PaGlobal_TradeFunction_All._currentTab ~= idx then
    PaGlobal_TradeFunction_All._ui._tabGroups[PaGlobal_TradeFunction_All._currentTab]:SetCheck(false)
  end
  if idx == PaGlobal_TradeFunction_All._ENUM_TAB_BUY then
    PaGlobal_TradeFunction_All._currentTab = PaGlobal_TradeFunction_All._ENUM_TAB_BUY
  else
    PaGlobal_TradeFunction_All._currentTab = PaGlobal_TradeFunction_All._ENUM_TAB_SELL
  end
  PaGlobal_TradeFunction_All._ui._tabGroups[PaGlobal_TradeFunction_All._currentTab]:SetCheck(true)
  local currentTab = PaGlobal_TradeFunction_All._ui._tabGroups[PaGlobal_TradeFunction_All._currentTab]
  local selectBarPosX = currentTab:GetSpanSize().x + PaGlobal_TradeFunction_All._ui._stc_SelectBar:GetSizeX() / 2 + 10
  PaGlobal_TradeFunction_All._ui._stc_SelectBar:SetSpanSize(selectBarPosX, PaGlobal_TradeFunction_All._ui._stc_SelectBar:GetSpanSize().y)
  PaGlobal_TradeFunction_All:update()
end
function PaGlobalFunc_TradeFunction_All_ChangeTabByPad(isUp)
  if nil == Panel_Dialog_Trade_Function_All or false == Panel_Dialog_Trade_Function_All:GetShow() or nil == isUp then
    return
  end
  if true == PaGlobal_TradeFunction_All._isConsole and 1 ~= PaGlobal_TradeFunction_All._buyFromNPCOrSellToNPCOrAll then
    return
  end
  local tabIdx = PaGlobal_TradeFunction_All._currentTab
  if true == isUp then
    tabIdx = tabIdx + 1
  else
    tabIdx = tabIdx - 1
  end
  if 1 < tabIdx then
    tabIdx = 0
  elseif tabIdx < 0 then
    tabIdx = 1
  end
  PaGlobalFunc_TradeFunction_All_ChangeTab(tabIdx)
end
function PaGlobalFunc_TradeFunction_All_SetIsTrading(isTrading)
  if nil == Panel_Dialog_Trade_Function_All then
    return
  end
  PaGlobal_TradeFunction_All._global._isTrading = isTrading
end
function PaGlobalFunc_TradeFunction_All_GetIsTrading()
  if nil == Panel_Dialog_Trade_Function_All or nil == PaGlobal_TradeFunction_All._global._isTrading then
    return
  end
  return PaGlobal_TradeFunction_All._global._isTrading
end
function PaGlobalFunc_TradeFunction_All_GetCurrentTab()
  if nil == Panel_Dialog_Trade_Function_All or nil == PaGlobal_TradeFunction_All._currentTab then
    return
  end
  return PaGlobal_TradeFunction_All._currentTab
end
function PaGlobalFunc_TradeMarketItemList_All_IsTerritorySupply()
  if nil == Panel_Dialog_Trade_Function_All or nil == PaGlobal_TradeFunction_All._territorySupplyCheck then
    return
  end
  return PaGlobal_TradeFunction_All._territorySupplyCheck
end
function PaGlobalFunc_TradeFunction_All_GetCurrentNPCType()
  if nil == Panel_Dialog_Trade_Function_All or nil == PaGlobal_TradeMarketItemList_All._buyFromNPCOrSellToNPCOrAll then
    return
  end
  return PaGlobal_TradeMarketItemList_All._buyFromNPCOrSellToNPCOrAll
end
function PaGlobalFunc_TradeFunction_All_BigHandCheck()
  if nil == Panel_Dialog_Trade_Function_All then
    return
  end
  PaGlobal_TradeFunction_All:bigHandCheck()
end
