function PaGlobalFunc_TradeEventNotice_Renewal_All_Open()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All:prepareOpen()
end
function PaGlobalFunc_TradeEventNotice_Renewal_All_Close()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All:prepareClose()
end
function PaGloabl_TradeEventNotice_Renewal_ShowAni()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All:ShowAni()
end
function PaGloabl_TradeEventNotice_Renewal_HideAni()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All:HideAni()
end
function PaGloabl_TradeEventNotice_Renewal_All_GetTerritorySupplyIndex(itemKey)
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  return PaGlobal_TradeEventNotice_All:GetTerritorySupplyIndex(itemKey)
end
function HandleEventLUp_TradeEventNotice_Renewal_All_PopUp()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All:PopUp()
end
function HandleEventOn_TradeEventNotice_Renewal_All_ShowPopUpToolTip()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All:ShowPopUpToolTip()
end
function HandleEventLUp_TradeEventNotice_Renewal_All_ShowPopUpToolTip(tabState)
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All:HandleClicked_Tab(tabState)
end
function HandleEventOn_TradeEventNotice_Renewal_All_ShowRadioButtonSimpleToolTip(tabState)
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All:ShowRadioButtonSimpleToolTip(tabState)
end
function HandleEventLUp_TradeEventNotice_Renewal_All_TradeEventNPCNaviStart()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All:TradeEventNPCNaviStart()
end
function HandleEventLUp_TradeEventNotice_Renewal_All_SupplyNPCNaviStart(terrIndex)
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All:SupplyNPCNaviStart(terrIndex)
end
function HandleEventOn_TradeEventNotice_Renewal_All_ShowSimpleToolTip(terrIndex, itemIndex, tabState)
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All:ShowItemToolTip(terrIndex, itemIndex, tabState)
end
function HandleEventOn_TradeEventNotice_Renewal_All_ShowTooltipName(terrIndex)
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All:ShowTooltipName(terrIndex)
end
function HandleEventOn_TradeEventNotice_Renewal_All_SetShowKeyGuide(terrIndex)
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  local isShow = PaGlobal_TradeEventNotice_All._ETerritory._margoria ~= terrIndex
  PaGlobal_TradeEventNotice_All._ui._stcText_Navi:SetShow(isShow)
  PaGlobal_TradeEventNotice_All:keyAlign()
end
function FromClient_TradeEventNotice_Renewal_All_UpdateTradeEventInfo()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All._needTradeEventUpdate = true
  if Panel_Window_TradeEventNotice_Renewal_All:GetShow() then
    PaGlobal_TradeEventNotice_All:UpdateTradeEventInfo()
  end
end
function FromClient_TradeEventNotice_Renewal_All_UpdateSupplyInfo()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All._needSupplyUpdate = true
  if Panel_Window_TradeEventNotice_Renewal_All:GetShow() then
    PaGlobal_TradeEventNotice_All:UpdateSupplyInfo()
  end
end
function FromClient_TradeEventNotice_Renewal_All_Resize()
  if nil == Panel_Window_TradeEventNotice_Renewal_All then
    return
  end
  PaGlobal_TradeEventNotice_All:Resize()
end
