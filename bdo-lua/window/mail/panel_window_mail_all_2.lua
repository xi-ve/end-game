function PaGlobal_Window_Mail_All_Open()
  if true == PaGlobal_Window_Mail_All._isWithReward and false == _ContentsGroup_UsePadSnapping and true == _ContentsGroup_NewUI_TotalReward_All then
    PaGlobal_Window_Mail_All:rePosition()
    PaGlobal_TotalReward_All_OpenWhenMailOpen()
  end
  PaGlobal_Window_Mail_All:prepareOpen()
end
function PaGlobal_Window_Mail_All_Close()
  if true == Panel_Window_MailDetail_All:GetShow() then
    PaGlobal_Window_MailDetail_All_Close()
  end
  PaGlobal_Window_Mail_All:prepareClose()
  if true == PaGlobal_Window_Mail_All._isWithReward and false == _ContentsGroup_UsePadSnapping and true == _ContentsGroup_NewUI_TotalReward_All then
    PaGlobal_TotalReward_All_Close()
  end
end
function PaGlobal_Window_Mail_All_WithRewardOpen(bWith)
  PaGlobal_Window_Mail_All._isWithReward = bWith
end
function MailList_RefreshPS4CacheMail()
  local coolTime = Int64toInt32(ToClient_getCoolTimeRefreshCashMail())
  if coolTime <= 0 then
    ToClient_RefreshPS4CashMail()
  else
    local remainTimeString = PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_SECOND", "time_second", tostring(coolTime))
    local showMessage = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_COOLTIME") .. "( " .. remainTimeString .. " )"
    Proc_ShowMessage_Ack(showMessage)
  end
end
function HandleEventLUp_Mail_All_Close()
  if true == Panel_Window_MailDetail_All:GetShow() then
    PaGlobal_Window_MailDetail_All_Close()
  end
  PaGlobal_Window_Mail_All:prepareClose()
end
function HandleEventLUp_Mail_All_CheckMail(index)
  if false == PaGlobal_Window_Mail_All._ui._mail[index].btn_check:GetShow() then
    return
  end
  PaGlobal_Window_Mail_All._ui._mail[index].btn_check:SetCheck(false == PaGlobal_Window_Mail_All._ui._mail[index].btn_check:IsCheck())
end
function HandleEventLUp_Mail_All_ChangePage(isNext)
  if true == isNext then
    if PaGlobal_Window_Mail_All._Page_Current + 1 > PaGlobal_Window_Mail_All._Page_Total then
      if nil ~= Panel_Window_MailDetail_All and true == Panel_Window_MailDetail_All:GetShow() then
        ToClient_padSnapSetTargetPanel(Panel_Window_MailDetail_All)
      end
      return
    else
      PaGlobal_Window_Mail_All._Page_Current = PaGlobal_Window_Mail_All._Page_Current + 1
    end
  elseif false == isNext then
    if PaGlobal_Window_Mail_All._Page_Current - 1 < 1 then
      return
    else
      PaGlobal_Window_Mail_All._Page_Current = PaGlobal_Window_Mail_All._Page_Current - 1
    end
  end
  PaGlobal_Window_Mail_All._isSelectAll = false
  PaGlobal_Window_Mail_All._ui.btn_selectAll:SetCheck(PaGlobal_Window_Mail_All._isSelectAll)
  PaGlobal_Window_Mail_All:updateMailControl()
end
function HandleEventLUp_Mail_All_SelectDelect()
  local pageNo = PaGlobal_Window_Mail_All._Page_Current
  local massMailCount = ToClient_GetMassMailCount()
  local lastMailIndex = 0
  for index = 1, PaGlobal_Window_Mail_All._rowMax do
    if nil == PaGlobal_Window_Mail_All._mailData[pageNo] or nil == PaGlobal_Window_Mail_All._mailData[pageNo][index] then
      break
    end
    if PaGlobal_Window_Mail_All._ui._mail[index].btn_check:IsCheck() and false == PaGlobal_Window_Mail_All._mailData[pageNo][index]._mail_GetItem then
      lastMailIndex = index
    end
  end
  PaGlobal_Window_Mail_All._isSelectAll = false
  for index = 1, PaGlobal_Window_Mail_All._rowMax do
    if nil == PaGlobal_Window_Mail_All._mailData[pageNo] or nil == PaGlobal_Window_Mail_All._mailData[pageNo][index] then
      break
    end
    if PaGlobal_Window_Mail_All._ui._mail[index].btn_check:GetShow() then
      if PaGlobal_Window_Mail_All._ui._mail[index].btn_check:IsCheck() then
        local mailNo = PaGlobal_Window_Mail_All._mailData[pageNo][index]._mail_No
        RequestMail_removeMail(mailNo, index == lastMailIndex)
      end
      PaGlobal_Window_Mail_All._ui._mail[index].btn_check:SetCheck(PaGlobal_Window_Mail_All._isSelectAll)
    end
  end
  PaGlobal_Window_Mail_All._ui.btn_selectAll:SetCheck(false)
end
function HandleEventLUp_Mail_All_SelectAll()
  for index = 1, PaGlobal_Window_Mail_All._rowMax do
    if PaGlobal_Window_Mail_All._ui._mail[index].btn_check:GetShow() then
      PaGlobal_Window_Mail_All._ui._mail[index].btn_check:SetCheck(false == PaGlobal_Window_Mail_All._isSelectAll)
    end
  end
  PaGlobal_Window_Mail_All._isSelectAll = false == PaGlobal_Window_Mail_All._isSelectAll
end
function HandleEventLUp_Mail_All_allRecieve()
  local recievemail = function()
    RequestMail_receiveAllMailItem()
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_MAIL_GETALL_MESSAGEBOX_MEMO")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MAIL_GETALL_MESSAGEBOX_TITLE"),
    content = messageBoxMemo,
    functionYes = recievemail,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_Mail_All_GetDetail(index)
  if PaGlobal_Window_Mail_All._isConsole and isPadPressed(__eJoyPadInputType_LeftTrigger) then
    return
  end
  if PaGlobal_Window_Mail_All._Page_Current < 1 then
    return
  end
  ToClient_padSnapSetTargetPanel(Panel_Window_MailDetail_All)
  local realIndex = PaGlobal_Window_Mail_All._mailData[PaGlobal_Window_Mail_All._Page_Current][index]._indx
  local isMassMail = PaGlobal_Window_Mail_All._mailData[PaGlobal_Window_Mail_All._Page_Current][index]._isMassMail
  PaGlobal_Window_Mail_All._selectedMail._indx = PaGlobal_Window_Mail_All._mailData[PaGlobal_Window_Mail_All._Page_Current][index]._indx
  PaGlobal_Window_Mail_All._selectedMail._sender_Name = PaGlobal_Window_Mail_All._mailData[PaGlobal_Window_Mail_All._Page_Current][index]._sender_Name
  PaGlobal_Window_Mail_All._selectedMail._mail_Title = PaGlobal_Window_Mail_All._mailData[PaGlobal_Window_Mail_All._Page_Current][index]._mail_Title
  if true == isMassMail then
    ToClient_RequestMassMailDetail(PaGlobal_Window_Mail_All._mailData[PaGlobal_Window_Mail_All._Page_Current][index]._mail_No)
  else
    RequestMail_getMailDetail(realIndex)
  end
end
function HandleEventLUp_Mail_All_QNA()
  FGlobal_QnAWebLink_Open()
end
function FromClient_Mail_All_NewMail()
  if true == PaGlobal_Window_Mail_All._isConsole then
    return
  end
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "FROMCLIENT_NEWMAIL"))
  if false == _ContentsGroup_RemasterUI_Main_Alert then
    if nil == Panel_UIMain then
      return
    end
    local newMailEffectIcon = UI.getChildControl(Panel_UIMain, "Button_Mail")
    if nil == newMailEffectIcon then
      return
    end
    if 0 == isColorBlindMode then
      newMailEffectIcon:EraseAllEffect()
      newMailEffectIcon:AddEffect("fUI_Letter_01A", true, 0, 2.1)
    elseif 1 == isColorBlindMode then
      newMailEffectIcon:EraseAllEffect()
      newMailEffectIcon:AddEffect("fUI_Letter_01B", true, 0, 2.1)
    elseif 2 == isColorBlindMode then
      newMailEffectIcon:EraseAllEffect()
      newMailEffectIcon:AddEffect("fUI_Letter_01B", true, 0, 2.1)
    end
  end
end
function PaGlobal_Window_Mail_UpdateList()
  if false == _ContentsGroup_RemasterUI_Main_Alert and false == PaGlobal_Window_Mail_All._isConsole and nil ~= Panel_UIMain then
    local newMailEffectIcon = UI.getChildControl(Panel_UIMain, "Button_Mail")
    if nil ~= newMailEffectIcon then
      newMailEffectIcon:EraseAllEffect()
    end
  end
  PaGlobal_Window_Mail_All:updateMailData()
  PaGlobal_Window_Mail_All:updateMailControl()
end
function FromClient_Window_Mail_All_ReSizePanel()
  if false == PaGlobal_Window_Mail_All._isConsole then
    PaGlobal_Window_Mail_All._ui_pc.btn_close:ComputePos()
    PaGlobal_Window_Mail_All._ui_pc.btn_question:ComputePos()
    PaGlobal_Window_Mail_All._ui_pc.btn_prePage:ComputePos()
    PaGlobal_Window_Mail_All._ui_pc.btn_nextPage:ComputePos()
    PaGlobal_Window_Mail_All._ui_pc.btn_selectDelect:ComputePos()
    PaGlobal_Window_Mail_All._ui_pc.btn_allRecieve:ComputePos()
    PaGlobal_Window_Mail_All._ui_pc.btn_QNA:ComputePos()
  else
    PaGlobal_Window_Mail_All._ui_console.stc_leftIcon:ComputePos()
    PaGlobal_Window_Mail_All._ui_console.stc_rightIcon:ComputePos()
    PaGlobal_Window_Mail_All._ui_console.stc_bottomBG:ComputePos()
  end
  PaGlobal_Window_Mail_All._ui.stc_topBG:ComputePos()
  PaGlobal_Window_Mail_All._ui.txt_pageNumber:ComputePos()
  PaGlobal_Window_Mail_All._ui.btn_selectAll:ComputePos()
  PaGlobal_Window_Mail_All._ui.txt_mailCount:ComputePos()
  PaGlobal_Window_Mail_All._ui.btn_mail:ComputePos()
end
function PaGlobal_Window_Mail_All_ShowAni()
  if nil == Panel_Window_Mail_All then
    return
  end
  UIAni.fadeInSCR_Left(Panel_Window_Mail_All)
  local aniInfo1 = Panel_Window_Mail_All:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_Mail_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_Mail_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_Mail_All:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_Mail_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_Mail_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobal_Window_Mail_All_HideAni()
  if nil == Panel_Window_Mail_All then
    return
  end
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_Mail_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
