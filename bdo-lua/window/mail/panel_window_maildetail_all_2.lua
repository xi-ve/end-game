function PaGlobal_Window_MailDetail_All_Open(mailNo)
  if false == PaGlobal_Window_MailDetail_All._mainControl:GetShow() then
    PaGlobal_Window_MailDetail_All:prepareOpen(mailNo)
  end
  PaGlobal_Window_MailDetail_All:setMailInfo(mailNo)
end
function PaGlobal_Window_MailDetail_All_Close()
  PaGlobal_Window_MailDetail_All.openMailNo = nil
  FGlobal_CashShop_GoodsTooltipInfo_Close()
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_Window_MailDetail_All:prepareClose()
end
function HandleEventLUp_MailDetail_All_ReceiveItemConsole()
  if false == PaGlobal_Window_MailDetail_All._ui_console.txt_receiveToWarehouse:GetShow() and false == PaGlobal_Window_MailDetail_All._ui_console.txt_receiveItem:GetShow() then
    return
  end
  warehouse_requestInfoByCurrentRegionMainTown()
  local giftCount_s64 = 0
  itemWhereType = CppEnums.ItemWhereType.eInventory
  if true == PaGlobal_Window_MailDetail_All._isWarehouse then
    itemWhereType = CppEnums.ItemWhereType.eWarehouse
  end
  if PaGlobal_Window_MailDetail_All.isMassMail then
    giftCount_s64 = ToClient_GetSelectedMassMailItemCount()
    ToClient_ReceiveMassMailItem(itemWhereType)
    return
  else
    local giftCount_s64 = RequestMail_getMailItemCount()
    if giftCount_s64 > toInt64(0, 1) then
      local getMygift = function(count_s64)
        RequestMail_receiveMailItem(count_s64, itemWhereType)
        return
      end
      Panel_NumberPad_Show(true, giftCount_s64, nil, getMygift, false, nil)
    else
      RequestMail_receiveMailItem(toInt64(0, 1), itemWhereType)
      return
    end
  end
  if nil ~= PaGlobalFunc_Widget_Alert_Check_Mail then
    PaGlobalFunc_Widget_Alert_Check_Mail()
  end
end
function HandleEventLUp_MailDetail_All_Delete()
  if nil ~= PaGlobal_Window_MailDetail_All.openMailNo then
    if true == PaGlobal_Window_MailDetail_All.isMassMail then
      ToClient_RemoveMassMail(PaGlobal_Window_MailDetail_All.openMailNo)
    else
      RequestMail_removeMail(PaGlobal_Window_MailDetail_All.openMailNo, true)
    end
    PaGlobal_Window_MailDetail_All.openMailNo = nil
  end
  PaGlobal_Window_MailDetail_All_Close()
end
function HandleEventLUp_MailDetail_All_GetItemConsole(isWarehouse)
  if false == PaGlobal_Window_MailDetail_All._ui_console.txt_receiveToWarehouse:GetShow() and isWarehouse then
    return
  end
  local itemESSW
  if PaGlobal_Window_MailDetail_All.isMassMail then
    itemESSW = ToClient_GetSelectedMassMailItemStaticStatus()
  else
    itemESSW = mail_getMailItemStatic()
  end
  PaGlobal_Window_MailDetail_All._isWarehouse = isWarehouse
  if nil ~= itemESSW and 0 ~= itemESSW:get()._expirationPeriod then
    local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_MAILDETAIL_EXPIRATIONPERIOD_TITLE")
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_MAILDETAIL_EXPIRATIONPERIOD_DESC")
    local messageboxData = {
      title = messageboxTitle,
      content = messageBoxMemo,
      functionYes = HandleEventLUp_MailDetail_All_ReceiveItemConsole,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    return
  end
  HandleEventLUp_MailDetail_All_ReceiveItemConsole()
end
function HandleEventLUp_MailDetail_All_GetItem()
  local itemESSW
  if PaGlobal_Window_MailDetail_All.isMassMail then
    itemESSW = ToClient_GetSelectedMassMailItemStaticStatus()
  else
    itemESSW = mail_getMailItemStatic()
  end
  if nil ~= itemESSW and 0 ~= itemESSW:get()._expirationPeriod then
    local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_MAILDETAIL_EXPIRATIONPERIOD_TITLE")
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_MAILDETAIL_EXPIRATIONPERIOD_DESC")
    local messageboxData = {
      title = messageboxTitle,
      content = messageBoxMemo,
      functionYes = PaGlobalFunc_MailDetail_RequestMailItem,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    return
  end
  PaGlobalFunc_MailDetail_RequestMailItem()
end
function FromClient_MailDetail_All_ShowMassMailDetail(mailNo)
  if nil == PaGlobal_Window_MailDetail_All._mainControl then
    return
  end
  if false == PaGlobal_Window_MailDetail_All._mainControl:GetShow() then
    PaGlobal_Window_MailDetail_All:prepareOpen(mailNo)
  end
  FGlobal_CashShop_GoodsTooltipInfo_Close()
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_Window_MailDetail_All.openMailNo = mailNo
  PaGlobal_Window_MailDetail_All.isMassMail = true
  PaGlobal_Window_MailDetail_All._ui.txt_sender:SetText(ToClient_GetSelectedMassMailSender())
  PaGlobal_Window_MailDetail_All._ui.txt_title:SetText(ToClient_GetSelectedMassMailTitle())
  UI.setLimitTextAndAddTooltip(PaGlobal_Window_MailDetail_All._ui.txt_title, "", PaGlobal_Window_MailDetail_All._ui.txt_title:GetText())
  PaGlobal_Window_MailDetail_All._ui.txt_mailContent:SetAutoResize(true)
  PaGlobal_Window_MailDetail_All._ui.txt_mailContent:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_Window_MailDetail_All._ui.txt_mailContent:SetText(ToClient_GetSelectedMassMailContant())
  local textSizeY = PaGlobal_Window_MailDetail_All._ui.txt_mailContent:GetSizeY()
  local frameSizeY = PaGlobal_Window_MailDetail_All._ui.frame_mailText:GetSizeY()
  PaGlobal_Window_MailDetail_All._ui.frame_mailContent:SetSize(PaGlobal_Window_MailDetail_All._ui.frame_mailContent:GetSizeX(), textSizeY)
  UIScroll.SetButtonSize(PaGlobal_Window_MailDetail_All._ui.frame_vScroll, frameSizeY, textSizeY)
  PaGlobal_Window_MailDetail_All._ui.frame_vScroll:SetControlPos(0)
  PaGlobal_Window_MailDetail_All._ui.stc_MailBottomBG:SetShow(true)
  PaGlobal_Window_MailDetail_All._ui.txt_itemName:SetShow(false)
  PaGlobal_Window_MailDetail_All._ui.txt_itemCount:SetShow(false)
  PaGlobal_Window_MailDetail_All._ui.txt_itemEnClosed:SetShow(false)
  local mailItem = ToClient_GetSelectedMassMailItemStaticStatus()
  local itemCount_s64 = ToClient_GetSelectedMassMailItemCount()
  if nil ~= mailItem and 0 < Int64toInt32(itemCount_s64) then
    PaGlobal_Window_MailDetail_All._ui.stc_itemSlot:clearItem()
    PaGlobal_Window_MailDetail_All._ui.stc_itemSlot:setItemByStaticStatus(mailItem, itemCount_s64)
    PaGlobal_Window_MailDetail_All._ui.stc_itemSlotBG:SetShow(true)
    PaGlobal_Window_MailDetail_All._ui.stc_itemSlot.icon:SetShow(true)
    PaGlobal_Window_MailDetail_All._ui.txt_itemName:SetShow(true)
    PaGlobal_Window_MailDetail_All._ui.txt_itemName:SetText(mailItem:getName())
    PaGlobal_Window_MailDetail_All._ui.txt_itemEnClosed:SetShow(true)
    if false == PaGlobal_Window_MailDetail_All._isConsole then
      PaGlobal_Window_MailDetail_All._ui_pc.btn_receive:SetShow(true)
      PaGlobal_Window_MailDetail_All._ui_pc.btn_warehouse:SetCheck(false)
    else
      PaGlobal_Window_MailDetail_All._ui_console.txt_receiveItem:SetShow(true)
    end
    local itemKey = mailItem:get()._key:getItemKey()
    local silverString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MAIL_DETAIL_SILVER_COUNT_TITLE", "value", makeDotMoney(itemCount_s64))
    local itemCountString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MAIL_DETAIL_ITEM_COUNT_TITLE", "count", makeDotMoney(itemCount_s64))
    PaGlobal_Window_MailDetail_All._ui.txt_itemCount:SetShow(itemCount_s64 > toInt64(0, 1))
    if 1 == itemKey then
      PaGlobal_Window_MailDetail_All._ui.txt_itemCount:SetText(silverString)
    else
      PaGlobal_Window_MailDetail_All._ui.txt_itemCount:SetText(itemCountString)
    end
    local isMoney = mailItem:isMoney()
    if false == PaGlobal_Window_MailDetail_All._isConsole then
      if true == isMoney then
        PaGlobal_Window_MailDetail_All._ui_pc.btn_warehouse:SetShow(true)
      else
        PaGlobal_Window_MailDetail_All._ui_pc.btn_warehouse:SetShow(false)
      end
    elseif true == isMoney then
      PaGlobal_Window_MailDetail_All._ui_console.txt_receiveToWarehouse:SetShow(true)
    else
      PaGlobal_Window_MailDetail_All._ui_console.txt_receiveToWarehouse:SetShow(false)
    end
    PaGlobal_Window_MailDetail_All._ui.stc_MailBottomBG:SetShow(true)
  else
    PaGlobal_Window_MailDetail_All._ui.stc_MailBottomBG:SetShow(false)
    PaGlobal_Window_MailDetail_All._ui.stc_itemSlot:clearItem()
    PaGlobal_Window_MailDetail_All._ui.stc_itemSlotBG:SetShow(false)
    PaGlobal_Window_MailDetail_All._ui.stc_itemSlot.icon:SetShow(false)
    PaGlobal_Window_MailDetail_All._ui.txt_itemName:SetShow(false)
    PaGlobal_Window_MailDetail_All._ui.txt_itemEnClosed:SetShow(false)
    if false == PaGlobal_Window_MailDetail_All._isConsole then
      PaGlobal_Window_MailDetail_All._ui_pc.btn_receive:SetShow(false)
      PaGlobal_Window_MailDetail_All._ui_pc.btn_warehouse:SetCheck(false)
      PaGlobal_Window_MailDetail_All._ui_pc.btn_warehouse:SetShow(false)
    else
      PaGlobal_Window_MailDetail_All._ui_console.txt_receiveItem:SetShow(false)
      PaGlobal_Window_MailDetail_All._ui_console.txt_receiveToWarehouse:SetShow(false)
    end
    PaGlobal_Window_MailDetail_All._ui.txt_itemCount:SetShow(false)
  end
  PaGlobal_Window_MailDetail_All:SetDynamicPanelSize()
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_Window_MailDetail_All._ui_console.keyGuides, PaGlobal_Window_MailDetail_All._ui_console.stc_consoleBottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_LEFT)
end
function FromClient_MailDetail_All_ResponseMailGetItem(itemKey, itemCount_s64, immediateItem, isRelay)
  if 1 ~= itemKey and false == immediateItem then
    return
  end
  local itemESSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  local itemName = itemESSW:getName()
  local isWarehouse = PaGlobal_Window_MailDetail_All._ui_pc.btn_warehouse:IsCheck()
  if immediateItem then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MAIL_DETAIL_ALERT_IMMEDIATEITEM", "itemName", itemName))
  elseif 1 == itemKey and (isWarehouse or isRelay) then
    Proc_ShowMessage_Ack(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MAIL_DETAIL_ALERT_GET_WAREHOUSE", "itemName", itemName, "itemCount", makeDotMoney(itemCount_s64)))
  end
end
function FromClient_Window_MailDetail_All_ReSizePanel()
  PaGlobal_Window_MailDetail_All._mainControl:ComputePos()
  if false == PaGlobal_Window_MailDetail_All._isConsole then
    PaGlobal_Window_MailDetail_All._ui_pc.btn_close:ComputePos()
    PaGlobal_Window_MailDetail_All._ui_pc.btn_receive:ComputePos()
    PaGlobal_Window_MailDetail_All._ui_pc.btn_delete:ComputePos()
    PaGlobal_Window_MailDetail_All._ui_pc.btn_apply:ComputePos()
    PaGlobal_Window_MailDetail_All._ui_pc.btn_warehouse:ComputePos()
  else
    PaGlobal_Window_MailDetail_All._ui_console.stc_consoleBottomBG:ComputePos()
    PaGlobal_Window_MailDetail_All._ui_console.txt_receiveItem:ComputePos()
    PaGlobal_Window_MailDetail_All._ui_console.txt_receiveToWarehouse:ComputePos()
    PaGlobal_Window_MailDetail_All._ui_console.txt_close:ComputePos()
    PaGlobal_Window_MailDetail_All._ui_console.txt_mailDelete:ComputePos()
  end
  PaGlobal_Window_MailDetail_All._ui.stc_centerBG:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.stc_mailContentBG:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.txt_title:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.txt_sender:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.frame_mailText:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.frame_mailContent:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.txt_mailContent:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.frame_vScroll:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.btn_vScrollUp:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.btn_vScrollDown:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.btn_vScrollCtrl:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.frame_hScroll:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.btn_hScrollUp:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.btn_hScrollDown:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.btn_hScrollCtrl:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.stc_MailBottomBG:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.stc_itemSlotBG:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.txt_itemEnClosed:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.txt_itemName:ComputePos()
  PaGlobal_Window_MailDetail_All._ui.txt_itemCount:ComputePos()
end
function PaGlobalFunc_MailDetail_RequestMailItem()
  warehouse_requestInfoByCurrentRegionMainTown()
  local itemWhereType = CppEnums.ItemWhereType.eInventory
  local isWarehouseCheck = PaGlobal_Window_MailDetail_All._ui_pc.btn_warehouse:IsCheck()
  local giftCount_s64 = 0
  if PaGlobal_Window_MailDetail_All.isMassMail then
    giftCount_s64 = ToClient_GetSelectedMassMailItemCount()
    if true == isWarehouseCheck then
      itemWhereType = CppEnums.ItemWhereType.eWarehouse
    elseif false == isWarehouseCheck then
      itemWhereType = CppEnums.ItemWhereType.eInventory
    end
    ToClient_ReceiveMassMailItem(itemWhereType)
    return
  else
    local giftCount_s64 = RequestMail_getMailItemCount()
    if giftCount_s64 > toInt64(0, 1) then
      local function getMygift(count_s64)
        if true == isWarehouseCheck then
          itemWhereType = CppEnums.ItemWhereType.eWarehouse
        elseif false == isWarehouseCheck then
          itemWhereType = CppEnums.ItemWhereType.eInventory
        end
        RequestMail_receiveMailItem(count_s64, itemWhereType)
        return
      end
      Panel_NumberPad_Show(true, giftCount_s64, nil, getMygift, false, nil)
    else
      if true == isWarehouseCheck then
        itemWhereType = CppEnums.ItemWhereType.eWarehouse
      elseif false == isWarehouseCheck then
        itemWhereType = CppEnums.ItemWhereType.eInventory
      end
      RequestMail_receiveMailItem(toInt64(0, 1), itemWhereType)
      return
    end
  end
  if nil ~= PaGlobalFunc_Widget_Alert_Check_Mail then
    PaGlobalFunc_Widget_Alert_Check_Mail()
  end
end
function PaGlobal_Window_MailDetail_All_ShowItemToolTip()
  if nil == PaGlobal_Window_MailDetail_All._mainControl then
    return
  end
  if false == PaGlobal_Window_MailDetail_All.isMassMail then
    if 1 == RequestMail_getMailType() then
      local productKeyRaw = RequestMail_getMailCashProductNoRaw()
      FGlobal_CashShop_GoodsTooltipInfo_Open(productKeyRaw, PaGlobal_Window_MailDetail_All._ui.stc_itemSlot.icon)
    elseif 2 == RequestMail_getMailType() then
      local mailIESS = RequestMail_getMailItemWrapper()
      Panel_Tooltip_Item_Show(mailIESS, PaGlobal_Window_MailDetail_All._ui.stc_itemSlot.icon, false, true, nil)
    else
      local mailIESS = mail_getMailItemStatic()
      Panel_Tooltip_Item_Show(mailIESS, PaGlobal_Window_MailDetail_All._ui.stc_itemSlot.icon, true, false, nil)
    end
  else
    local mailIESS = ToClient_GetSelectedMassMailItem()
    Panel_Tooltip_Item_Show(mailIESS, PaGlobal_Window_MailDetail_All._ui.stc_itemSlot.icon, false, true, nil)
  end
end
function PaGlobal_Window_MailDetail_All_GetCurrentMailNo()
  return PaGlobal_Window_MailDetail_All.openMailNo
end
function PaGlobal_Window_MailDetail_All_HideItemToolTip()
  if nil == PaGlobal_Window_MailDetail_All._mainControl then
    return
  end
  if 1 == RequestMail_getMailType() then
    FGlobal_CashShop_GoodsTooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobal_Window_MailDetail_All_ShowAni()
  if nil == PaGlobal_Window_MailDetail_All._mainControl then
    return
  end
  audioPostEvent_SystemUi(1, 0)
  if true == self._isConsole then
    UIAni.fadeInSCR_Left(PaGlobal_Window_MailDetail_All._mainControl)
  end
end
function PaGlobal_Window_MailDetail_All_HideAni()
  if nil == PaGlobal_Window_MailDetail_All._mainControl then
    return
  end
  audioPostEvent_SystemUi(1, 1)
  if true == self._isConsole then
    PaGlobal_Window_MailDetail_All._mainControl:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  end
  local mailHideAni = PaGlobal_Window_MailDetail_All._mainControl:addColorAnimation(0, 0.22, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  mailHideAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  mailHideAni:SetEndColor(Defines.Color.C_00FFFFFF)
  mailHideAni:SetStartIntensity(3)
  mailHideAni:SetEndIntensity(1)
  mailHideAni.IsChangeChild = true
  mailHideAni:SetHideAtEnd(true)
  mailHideAni:SetDisableWhileAni(true)
end
