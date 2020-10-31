function HandleEventLUp_Login_All_LoginStart()
  local serviceType = getGameServiceType()
  if (isGameTypeTaiwan() or isGameTypeGT() or isGameTypeKorea()) and 1 ~= serviceType then
    FGlobal_TermsofGameUse_Open()
  else
    PaGlobal_Login_All:enterLogin()
  end
end
function HandleEventLUp_Login_All_GameExit()
  local _title = ""
  local _desc = PAGetString(Defines.StringSheet_GAME, "PANEL_GAMEEXIT_TRAY_ASK")
  local _confirmFunction = GlobalExitGameClient
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority,
    exitButton = true
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_Login_All_ChangeAccount()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_CHANGEACCOUNT_MSGBOX")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = PaGlobal_Login_All_ChangeAccount,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "top")
end
function HandleEventLUp_Login_All_GameOption()
  showGameOption()
end
function PaGlobal_Login_All_ShowAni()
  if nil == Panel_Lobby_Login_All then
    return
  end
end
function PaGlobal_Login_All_HideAni()
  if nil == Panel_Lobby_Login_All then
    return
  end
end
function FromClient_Login_All_OnMovieEvent(param)
  PaGlobal_Login_All:onMovieEvent(param)
end
function FromClient_Login_All_onScreenResize()
  PaGlobal_Login_All:onScreenResize()
end
function FromClient_Login_All_InitLoginMovie()
  PaGlobal_Login_All:initLoginMovie()
end
function FromClient_Login_All_ClickToLogin()
  HandleEventLUp_Login_All_LoginStart()
end
function PaGlobal_Login_All_ChangeAccount()
  ToClient_ChangeAccount()
end
function PaGlobal_Login_All_LoginButtonDisable(isDisable)
  PaGlobal_Login_All:updateButtonDisable(isDisable)
end
function PaGlobal_Login_All_LoginEnter()
  _AudioPostEvent_SystemUiForXBOX(50, 8)
  PaGlobal_Login_All:enterLogin()
end
