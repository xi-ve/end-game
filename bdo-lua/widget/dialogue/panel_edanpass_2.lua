function PaGlobalFunc_EdanPass_Open()
  PaGlobal_EdanPass:prepareOpen()
end
function PaGlobalFunc_EdanPass_Close()
  PaGlobal_EdanPass:prepareClose()
end
function HandleEventEnter_EdanPass_ClickOK()
  local _doConfirmYes = function()
    PaGlobalFunc_EdanPass_Close()
  end
  local _doConfirmNo = function()
  end
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_UNDERTHESEA_OK_TITLE")
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_UNDERTHESEA_OK_MESSAGE")
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = _doConfirmYes,
    functionNo = _doConfirmNo,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "middle")
end
function HandleEventEnter_EdanPass_ClickClose()
  PaGlobalFunc_EdanPass_Close()
end
function HandleEventEnter_EdanPass_ClickEdanPass(index)
  if nil == PaGlobal_EdanPass then
    return
  end
  local function _doConfirmYes()
    local regionKey = ToClient_GetEdanPassListElement(index)
    ToClient_RequestEdanPass(regionKey)
  end
  local edanPassName = ToClient_GetEdanPassListElementString(index)
  local _doConfirmNo = function()
  end
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_UNDERTHESEA_TITLE")
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TO_UNDERTHESEA", "to", edanPassName)
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = _doConfirmYes,
    functionNo = _doConfirmNo,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "middle")
end
function PaGlobal_SA_Widget_EdanPass_CreateListControl(control, idx)
  PaGlobal_EdanPass:edanPassListUpdate(control, idx)
end
function FromClient_EdanPass_ReSizePanel()
  Panel_UndertheSea:ComputePos()
end
