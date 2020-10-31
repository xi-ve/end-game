function HandleEventLUp_LoginPassword_All_Back()
  lobbyPassword_BackIndexString(PaGlobal_LoginPassword_All:isStateTypeReconfirm())
  PaGlobal_LoginPassword_All:updatePassward()
end
function HandleEventLUp_LoginPassword_All_Clear()
  lobbyPassword_ClearIndexString(PaGlobal_LoginPassword_All:isStateTypeReconfirm())
  PaGlobal_LoginPassword_All:updatePassward()
end
function HandleEventLUp_LoginPassword_All_Apply()
  PaGlobal_LoginPassword_All:Apply()
end
function HandleEventLUp_LoginPassword_All_Cancel()
  if true == isGameServiceTypeDev() then
    PaGlobal_LoginPassword_All:prepareClose()
  else
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "GAME_EXIT_MESSAGEBOX_MEMO")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "GAME_EXIT_MESSAGEBOX_TITLE"),
      content = messageBoxMemo,
      functionYes = PaGlobal_LoginPassword_All_CancelEnd,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function HandleEventLUp_LoginPassword_All_ShowNum()
  audioPostEvent_SystemUi(0, 0)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobal_LoginPassword_All:updatePassward()
  PaGlobal_LoginPassword_All:showPasswardTooltip(true)
end
function HandleEventOut_LoginPasseword_All_NumBtnTextUpdate(index)
  PaGlobal_LoginPassword_All:updateButtonTextAll(true)
end
function HandleEventLDown_LoginPassword_All_NumBtnTextUpdate(index)
  PaGlobal_LoginPassword_All:updateButtonTextAll(false)
end
function HandleEventLUp_LoginPassword_All_NumBtnInput(index)
  local isTemporary = PaGlobal_LoginPassword_All:isStateTypeReconfirm()
  PaGlobal_LoginPassword_All:updateButtonTextAll(true)
  lobbyPassword_AddIndexString(index, isTemporary)
  PaGlobal_LoginPassword_All:updatePassward()
end
function HandleEventOnOut_LoginPassword_All_ShowPasswordTooltip(isShow)
  PaGlobal_LoginPassword_All:showPasswardTooltip(isShow)
end
function PaGlobal_LoginPassword_All_ShowAni()
  if nil == Panel_Login_Password_All then
    return
  end
end
function PaGlobal_LoginPassword_All_HideAni()
  if nil == Panel_Login_Password_All then
    return
  end
end
function FromClient_LoginPassword_All_OpenPassword(isCreatePassword)
  PaGlobal_LoginPassword_All:prepareOpen(isCreatePassword)
end
function PaGlobal_LoginPassword_All_CancelEnd()
  disConnectToGame()
  GlobalExitGameClient()
end
