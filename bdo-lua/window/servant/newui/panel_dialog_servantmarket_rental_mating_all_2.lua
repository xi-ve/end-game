function PaGlobalFunc_ServantMarket_Rental_Mating_All_Open(isMatingMarket)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or true == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() or nil == isMatingMarket then
    return
  end
  PaGlobal_ServantMarket_Rental_Mating_All._isMatingMarket = isMatingMarket
  if nil ~= PaGlobal_ServantMarket_Rental_Mating_All._ui._servantSlot then
    for slotIdx = 0, PaGlobal_ServantMarket_Rental_Mating_All._MAXSLOTCOUNT - 1 do
      if nil ~= PaGlobal_ServantMarket_Rental_Mating_All._ui._servantSlot[slotIdx] then
        local slot = PaGlobal_ServantMarket_Rental_Mating_All._ui._servantSlot[slotIdx]._slot
        slot:SetShow(false)
      end
    end
  end
  if true == isMatingMarket then
    PaGlobal_ServantMarket_Rental_Mating_All._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMATING_TITLE"))
    PaGlobal_ServantMarket_Rental_Mating_All._ui._rdo_Tab_Left:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMARKET_RDOBTN_LIST"))
    PaGlobal_ServantMarket_Rental_Mating_All._ui._rdo_Tab_Center:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMARKET_RDOBTN_LISTMY"))
    PaGlobal_ServantMarket_Rental_Mating_All._ui._rdo_Tab_Right:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMATING_RDOBTN_GROUP"))
    PaGlobal_ServantMarket_Rental_Mating_All._ui._btn_Reload_PC:SetShow(false)
    PaGlobal_ServantMarket_Rental_Mating_All._ui._btn_Question_PC:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowStableMating\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(PaGlobal_ServantMarket_Rental_Mating_All._ui._btn_Question_PC, "\"PanelWindowStableMating\"")
  else
    PaGlobal_ServantMarket_Rental_Mating_All._ui._btn_Reload_PC:SetShow(true)
    PaGlobal_ServantMarket_Rental_Mating_All._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_FUNCTION_BTN_RENT"))
    PaGlobal_ServantMarket_Rental_Mating_All._ui._rdo_Tab_Left:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PROMOTEMARKET_TAPTITLE2"))
    PaGlobal_ServantMarket_Rental_Mating_All._ui._rdo_Tab_Center:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PROMOTEMARKET_TAPTITLE3"))
    PaGlobal_ServantMarket_Rental_Mating_All._ui._rdo_Tab_Right:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PROMOTEMARKET_TAPTITLE4"))
    PaGlobal_ServantMarket_Rental_Mating_All._ui._btn_Question_PC:SetShow(false)
  end
  PaGlobal_ServantMarket_Rental_Mating_All:prepareOpen()
end
function PaGlobalFunc_ServantMarket_Rental_Mating_All_Close()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  if true == Panel_Dialog_ServantOnlyList_All:GetShow() then
    PaGlobalFunc_ServantOnlyList_All_Close()
    return
  end
  PaGlobal_ServantMarket_Rental_Mating_All:prepareClose()
end
function FromClient_ServantMarket_Rental_Mating_All_OnScreenResize()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  Panel_Dialog_ServantMarket_Rental_Mating_All:ComputePos()
end
function PaGlobalFunc_ServantMarket_Rental_Mating_All_ShowAni()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All then
    return
  end
  if true == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    Panel_Dialog_ServantMarket_Rental_Mating_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
    local aniInfo1 = Panel_Dialog_ServantMarket_Rental_Mating_All:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
    aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
    aniInfo1:SetStartIntensity(3)
    aniInfo1:SetEndIntensity(1)
    aniInfo1.IsChangeChild = true
    aniInfo1:SetHideAtEnd(true)
    aniInfo1:SetDisableWhileAni(true)
  else
    UIAni.fadeInSCR_Down(Panel_Dialog_ServantMarket_Rental_Mating_All)
    Panel_Dialog_ServantMarket_Rental_Mating_All:SetShow(true, false)
  end
end
function PaGlobalFunc_ServantMarket_Rental_Mating_All_HideAni()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All then
    return
  end
  Panel_Dialog_ServantMarket_Rental_Mating_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Dialog_ServantMarket_Rental_Mating_All:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function HandleEventOn_AuctionServant_Tooltip_Open(actorKeyRaw, key32, slotIdx)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or true == PaGlobal_ServantMarket_Rental_Mating_All._isConsole then
    return
  end
  PaGlobal_ServantMarket_Rental_Mating_All:AuctionServant_Tooltip_Open(actorKeyRaw, key32, slotIdx)
end
function HandleEventOnOut_ServantMarket_Rental_Mating_All_ShowDiscountRateTooltip(isShow)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == ToClient_GetServantMarketTaxPercent() then
    return
  end
  local disCountRate = ToClient_GetServantMarketTaxPercent() / 10000
  local control = PaGlobal_ServantMarket_Rental_Mating_All._ui._stc_DescIcon
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMARKET_DISCOUNT_TOOLTIP_NAME")
  local desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEMARKET_DISCOUNT_BTN_TOOLTIP_DESC", "rate", disCountRate)
  TooltipSimple_Show(control, name, desc)
end
function FromClient_ServantMarket_Rental_Mating_All_UpdateMoney()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_Rental_Mating_All:moneyUpdate()
end
function HandleEventOnOut_ServantMarket_Rental_Mating_All_ShowSimpleTooltip(tipType, isShow)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or nil == tipType or nil == isShow or false == isShow or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_INVEN_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_INVEN_DESC")
    control = PaGlobal_ServantMarket_Rental_Mating_All._ui._txt_InvenTitle
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_WAREHOUSE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_WAREHOUSE_DESC")
    control = PaGlobal_ServantMarket_Rental_Mating_All._ui._txt_WareTitle
  end
  registTooltipControl(control, Panel_Tooltip_SimpleText)
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_ServantMarket_Rental_Mating_All_PageChange(isNext)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or nil == isNext or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  audioPostEvent_SystemUi(0, 0)
  local currentTab = PaGlobal_ServantMarket_Rental_Mating_All._currentTabIdx
  if true == isNext then
    if PaGlobal_ServantMarket_Rental_Mating_All._selectMaxPage <= PaGlobal_ServantMarket_Rental_Mating_All._selectPage then
      return
    end
    PaGlobal_ServantMarket_Rental_Mating_All._selectPage = PaGlobal_ServantMarket_Rental_Mating_All._selectPage + 1
    if false == PaGlobal_ServantMarket_Rental_Mating_All._isMatingMarket then
      if PaGlobal_ServantMarket_Rental_Mating_All._ENUM_TAB_CENTER ~= currentTab then
        RequestAuctionNextPage(currentTab, PaGlobal_ServantMarket_Rental_Mating_All._isFromNpc)
      end
      PaGlobal_ServantMarket_Rental_Mating_All:update()
    elseif PaGlobal_ServantMarket_Rental_Mating_All._ENUM_TAB_CENTER == currentTab then
      PaGlobal_ServantMarket_Rental_Mating_All:update()
    else
      local transferType = 0
      if PaGlobal_ServantMarket_Rental_Mating_All._ENUM_TAB_RIGHT == currentTab then
        transferType = CppEnums.TransferType.TransferType_Self
      end
      RequestAuctionNextPage(transferType, PaGlobal_ServantMarket_Rental_Mating_All._isFromNpc)
    end
  else
    if PaGlobal_ServantMarket_Rental_Mating_All._selectPage >= 1 then
      PaGlobal_ServantMarket_Rental_Mating_All._selectPage = PaGlobal_ServantMarket_Rental_Mating_All._selectPage - 1
    end
    if false == PaGlobal_ServantMarket_Rental_Mating_All._isMatingMarket then
      if PaGlobal_ServantMarket_Rental_Mating_All._ENUM_TAB_CENTER ~= currentTab then
        RequestAuctionPrevPage(currentTab, PaGlobal_ServantMarket_Rental_Mating_All._isFromNpc)
      end
      PaGlobal_ServantMarket_Rental_Mating_All:update()
    elseif PaGlobal_ServantMarket_Rental_Mating_All._ENUM_TAB_CENTER == currentTab then
      PaGlobal_ServantMarket_Rental_Mating_All:update()
    else
      local transferType = 0
      if PaGlobal_ServantMarket_Rental_Mating_All._ENUM_TAB_RIGHT == currentTab then
        transferType = CppEnums.TransferType.TransferType_Self
      end
      RequestAuctionPrevPage(transferType, PaGlobal_ServantMarket_Rental_Mating_All._isFromNpc)
    end
  end
end
function HandleEventLUp_ServantMarket_Rental_Mating_All_Cancel(slotNo, isMating)
  if nil == slotNo or nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  local function CancelMatingConfirm()
    stable_cancelServantFromSomeWhereElse(slotNo, CppEnums.AuctionType.AuctionGoods_ServantMating)
  end
  local function CancelRentalConfirm()
    stable_cancelServantFromSomeWhereElse(slotNo, CppEnums.AuctionType.AuctionGoods_ServantRent)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_ITEMSET_REGISTCANCEL_DO")
  local _confirmFunction
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  if true == isMating then
    _confirmFunction = CancelMatingConfirm
  else
    _confirmFunction = CancelRentalConfirm
  end
  if nil == _confirmFunction then
    return
  end
  local messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantMarket_Rental_Mating_All_RecieveMating(slotNo)
  if nil == slotNo or nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  local function receiveMoney()
    local toWhereType = MessageBoxCheck.isCheck()
    stable_popServantPrice(slotNo, CppEnums.AuctionType.AuctionGoods_ServantMating, toWhereType)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_RENTALMATING_ALL_RECEIVE_MATINGMONEY")
  local _confirmFunction = receiveMoney
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local messageboxData = {
    title = _title,
    content = _desc,
    functionApply = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBoxCheck.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantMarket_Rental_Mating_All_BuyRent(slotNo)
  if nil == slotNo or nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  local fromWhereType = CppEnums.ItemWhereType.eInventory
  local function rentingConfirm()
    local fromWhereType = MessageBoxCheck.isCheck()
    ToClient_requestBuyItNowServantForRent(slotNo, fromWhereType)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_RENTALMATING_ALL_RECEIVE_HORSE")
  local _confirmFunction = rentingConfirm
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local messageboxData = {
    title = _title,
    content = _desc,
    functionApply = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBoxCheck.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantMarket_Rental_Mating_All_ForceRentReturn(slotNo)
  if nil == slotNo or nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  local info = RequestGetAuctionInfo():getServantAuctionListAt(slotNo)
  if not info then
    return
  end
  local servantNo = info:getServantNo()
  local function forceReturn()
    stable_returnServantToSomeWhereElse(servantNo, CppEnums.AuctionType.AuctionGoods_ServantReturn, CppEnums.TransferType.TransferType_Self)
    HandleEventLUp_ServantMarket_Rental_Mating_All_Reload()
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLE_PROMOTEMARKET_FORCERETURNDESC")
  local _confirmFunction = forceReturn
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantMarket_Rental_Mating_All_BuyReturn(slotNo)
  if nil == slotNo or nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  local function rentingConfirm()
    local fromWhereType = MessageBoxCheck.isCheck()
    ToClient_requestBuyItNowServantForReturn(slotNo, fromWhereType)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_PRPOMOTEMARKET_RETURN_ALERT2")
  local _confirmFunction = rentingConfirm
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local messageboxData = {
    title = _title,
    content = _desc,
    functionApply = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBoxCheck.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantMarket_Rental_Mating_All_RecieveRental(slotNo, isRenting)
  if nil == slotNo or nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  local toWhereType = CppEnums.ItemWhereType.eInventory
  local function rentingConfirm()
    local toWhereType = MessageBoxCheck.isCheck()
    if false == isRenting then
      stable_popServantPrice(slotNo, CppEnums.AuctionType.AuctionGoods_ServantReturn, toWhereType)
    else
      stable_popServantPrice(slotNo, CppEnums.AuctionType.AuctionGoods_ServantRent, toWhereType)
    end
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_RENTALMATING_ALL_RECEIVE_RENTALMONEY")
  local _confirmFunction = rentingConfirm
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local messageboxData = {
    title = _title,
    content = _desc,
    functionApply = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBoxCheck.showMessageBox(messageboxData)
  RequestActionReloadPage(0, PaGlobal_ServantMarket_Rental_Mating_All._isFromNpc)
end
function HandleEventLUp_ServantMarket_Rental_Mating_All_Reload()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  RequestActionReloadPage(0, PaGlobal_ServantMarket_Rental_Mating_All._isFromNpc)
end
function FromClient_ServantMarket_Rental_Mating_All_ResponseServantBuyItNowFail()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  if GetUIMode() == Defines.UIMode.eUIMode_Default then
    return
  end
  RequestActionReloadPage(0, PaGlobal_ServantMarket_Rental_Mating_All._isFromNpc)
  PaGlobal_ServantMarket_Rental_Mating_All:update()
end
function FromClient_ServantMarket_Rental_Mating_All_UpdateSlot()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_Rental_Mating_All:update()
end
function HandleEventLUp_ServantMarket_Rental_Mating_All_TabChange(idx)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  if idx == PaGlobal_ServantMarket_Rental_Mating_All._currentTabIdx then
    return
  end
  PaGlobal_ServantMarket_Rental_Mating_All._currentTabIdx = idx
  local tabSpanX = 0
  if nil ~= PaGlobal_ServantMarket_Rental_Mating_All._ui._tabButtonList then
    for ii = 0, #PaGlobal_ServantMarket_Rental_Mating_All._ui._tabButtonList do
      if ii == idx then
        PaGlobal_ServantMarket_Rental_Mating_All._ui._tabButtonList[ii]:SetCheck(true)
        tabSpanX = PaGlobal_ServantMarket_Rental_Mating_All._ui._tabButtonList[ii]:GetSpanSize().x
      else
        PaGlobal_ServantMarket_Rental_Mating_All._ui._tabButtonList[ii]:SetCheck(false)
      end
    end
  end
  local selectBarY = PaGlobal_ServantMarket_Rental_Mating_All._ui._stc_SelectedLine:GetSpanSize().y
  PaGlobal_ServantMarket_Rental_Mating_All._ui._stc_SelectedLine:SetSpanSize(tabSpanX, selectBarY)
  PaGlobal_ServantMarket_Rental_Mating_All._selectPage = 0
  PaGlobal_ServantMarket_Rental_Mating_All._selectMaxPage = 0
  local isFromNpc = PaGlobal_ServantMarket_Rental_Mating_All._isFromNpc
  if true == PaGlobal_ServantMarket_Rental_Mating_All._isMatingMarket then
    if PaGlobal_ServantMarket_Rental_Mating_All._ENUM_TAB_CENTER == idx then
      requestMyServantMatingList()
    else
      local transferType = 0
      if PaGlobal_ServantMarket_Rental_Mating_All._ENUM_TAB_RIGHT == idx then
        transferType = CppEnums.TransferType.TransferType_Self
      end
      requestServantMatingListPage(transferType)
    end
  elseif PaGlobal_ServantMarket_Rental_Mating_All._ENUM_TAB_LEFT == idx then
    requestMyServantRentList(isFromNpc)
  elseif PaGlobal_ServantMarket_Rental_Mating_All._ENUM_TAB_CENTER == idx then
    requestServantReturnList(isFromNpc)
  elseif PaGlobal_ServantMarket_Rental_Mating_All._ENUM_TAB_RIGHT == idx then
    requestMyServantReturnList(isFromNpc)
  end
end
function HandleEventLUp_ServantMarket_Rental_Mating_All_Mating(slotNo)
  if nil == slotNo or nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  if nil ~= Panel_Dialog_ServantOnlyList_All then
    PaGlobalFunc_ServantOnlyList_All_Open(slotNo)
  end
end
function FromClient_ServantMarket_Rental_Mating_All_List2UpdateSlot0(content, key)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_Rental_Mating_All:list2Update(content, key, 0)
end
function FromClient_ServantMarket_Rental_Mating_All_List2UpdateSlot1(content, key)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_Rental_Mating_All:list2Update(content, key, 1)
end
function FromClient_ServantMarket_Rental_Mating_All_List2UpdateSlot2(content, key)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_Rental_Mating_All:list2Update(content, key, 2)
end
function FromClient_ServantMarket_Rental_Mating_All_List2UpdateSlot3(content, key)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_Rental_Mating_All:list2Update(content, key, 3)
end
function PaGlobalFunc_ServantMarket_Rental_Mating_All_GetCurrentTab()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return nil
  end
  return PaGlobal_ServantMarket_Rental_Mating_All._currentTabIdx
end
function PaGlobalFunc_ServantMarket_Rental_Mating_All_ChangePageByARROWKEY(deltaTime)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All and false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    Panel_Dialog_ServantMarket_Rental_Mating_All:ClearUpdateLuaFunc()
    return
  end
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_LEFT) then
    HandleEventLUp_ServantMarket_Rental_Mating_All_PageChange(false)
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_RIGHT) then
    HandleEventLUp_ServantMarket_Rental_Mating_All_PageChange(true)
  end
end
function HandleEventOnOut_Dialog_ServantMarket_RentalMating_All_ShowToolTip(slotIdx, idx, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_ServantMarket_Rental_Mating_All._ui._servantSlot[slotIdx]._tooltipControls[idx]
  if nil == control then
    return
  end
  local name = ""
  local desc = control:GetText()
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_Rental_Mating_All_MatingBtnTextChange(slotIdx, isShow, horseIdx)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() or nil == slotIdx then
    return
  end
  if false == isShow then
    local myAuctionInfo = RequestGetAuctionInfo()
    local auctionServantInfo = myAuctionInfo:getServantAuctionListAt(horseIdx)
    if nil ~= auctionServantInfo then
      PaGlobal_ServantMarket_Rental_Mating_All._ui._servantSlot[slotIdx]._btn_Confirm_PC:SetText(makeDotMoney(auctionServantInfo:getAuctoinPrice_s64()))
    end
  else
    PaGlobal_ServantMarket_Rental_Mating_All._ui._servantSlot[slotIdx]._btn_Confirm_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_MARKET_REQUEST"))
  end
end
function HandleEventPadPress_Rental_Mating_All_MatingBtnTextChange(isUp)
  local idx = PaGlobal_ServantMarket_Rental_Mating_All._currentTabIdx
  if true == isUp then
    idx = idx + 1
    if 3 <= idx then
      idx = 0
    end
  else
    idx = idx - 1
    if idx < 0 then
      idx = 2
    end
  end
  HandleEventLUp_ServantMarket_Rental_Mating_All_TabChange(idx)
end
function HandleEventPadDown_ServantMarket_Rental_Mating_All_YPressTooltipShow()
  if true == PaGlobal_ServantMarket_All._ui._stc_KeyGuide_Y_Tooltip:GetShow() then
    PaGlobal_ServantMarket_Rental_Mating_All._ui._stc_KeyGuide_Y_Tooltip:SetShow(false)
  else
    PaGlobal_ServantMarket_Rental_Mating_All._ui._stc_KeyGuide_Y_Tooltip:SetShow(true)
  end
end
function HandleEventPadDown_ServantMarket_Rental_Mating_All_YPressTooltipHide()
  PaGlobal_ServantMarket_Rental_Mating_All._ui._stc_KeyGuide_Y_Tooltip:SetShow(false)
end
function PaGlobalFunc_ServantMarket_Rental_Mating_All_SetKeyguideText(type, slotIndex)
  if nil == type then
    PaGlobal_ServantMarket_Rental_Mating_All._ui._stc_KeyGuide_A:SetShow(false)
    return
  end
  PaGlobal_ServantMarket_Rental_Mating_All._ui._stc_KeyGuide_A:SetShow(true)
  if 0 == type then
    PaGlobal_ServantMarket_Rental_Mating_All._ui._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
  elseif 1 == type then
    PaGlobal_ServantMarket_Rental_Mating_All._ui._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMARKET_BTN_RECEIVE"))
  elseif 2 == type then
    PaGlobal_ServantMarket_Rental_Mating_All._ui._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMATING_BTN_START"))
  elseif 3 == type then
    PaGlobal_ServantMarket_Rental_Mating_All._ui._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_STABLE_PROMOTEAUTH_FORCEDRETURN"))
  elseif 4 == type then
    PaGlobal_ServantMarket_Rental_Mating_All._ui._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PROMOTEMARKET_BUTTON1"))
  elseif 5 == type then
    PaGlobal_ServantMarket_Rental_Mating_All._ui._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTRENT_RECIEVEMONEYBUTTON"))
  end
  local servantSlot = PaGlobal_ServantMarket_Rental_Mating_All._ui._servantSlot[slotIndex]
  PaGlobal_ServantMarket_Rental_Mating_All._ui._stc_KeyGuide_RS:SetShow(servantSlot._list2_Control:GetVScroll():GetShow())
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_ServantMarket_Rental_Mating_All._ui._keyguides, PaGlobal_ServantMarket_Rental_Mating_All._ui._stc_Bottom_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  PaGlobal_ServantMarket_Rental_Mating_All._selectIndex = slotIndex
end
function HandleEventOut_ServantMarket_Rental_Mating_All_SkillTooltipHide()
  if true == PaGlobal_ServantMarket_Rental_Mating_All._isConsole then
    return
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    PaGlobal_Tooltip_Skill_Servant_All_Close()
  else
    PaGlobal_Tooltip_Servant_Close()
  end
end
function HandleEventScroll_ServantMarket_Rental_Mating_All_ServantSkill(isUp)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All then
    return
  end
  local servantSlot = PaGlobal_ServantMarket_Rental_Mating_All._ui._servantSlot[PaGlobal_ServantMarket_Rental_Mating_All._selectIndex]
  if nil == servantSlot then
    return
  end
  local list2 = servantSlot._list2_Control
  if true == isUp then
    list2:MouseUpScroll(list2)
  else
    list2:MouseDownScroll(list2)
  end
end
