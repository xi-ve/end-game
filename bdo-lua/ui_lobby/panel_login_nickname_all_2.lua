function HandleEventLUp_LoginNickname_All_ApplyNickname()
  if nil == Panel_Login_Nickname_All then
    return
  end
  PaGlobal_LoginNickname_All:applyNickname()
end
function HandleEventPad_LoginNickname_All_InputEdit()
  SetFocusEdit(PaGlobal_LoginNickname_All._ui.edit_Nickname)
end
function HandleEventPad_LoginNickname_All_KeyboardEnd(str)
  if getGameServiceTypeUserNickNameLength() < string.len(str) then
    str = string.sub(str, 1, getGameServiceTypeUserNickNameLength())
  end
  PaGlobal_LoginNickname_All._ui.edit_Nickname:SetEditText(str)
  ClearFocusEdit()
end
function PaGlobal_LoginNickname_All_Open()
  if nil == Panel_Login_Nickname_All then
    return
  end
  if Panel_Login_Nickname_All:GetShow() then
    return
  end
  PaGlobal_LoginNickname_All:prepareOpen()
end
function PaGlobal_LoginNickname_All_Close(clearStr)
  if nil == Panel_Login_Nickname_All then
    return
  end
  PaGlobal_LoginNickname_All:prepareClose(clearStr)
end
function FromClient_LoginNickname_All_ApplyCallback()
  if nil == Panel_Login_Nickname_All then
    return
  end
  PaGlobal_LoginNickname_All:applyCallback()
end
function FromClient_LoginNickname_All_Open(clearStr)
  if true == ToClient_isConsole() and (nil == clearStr or true == clearStr) then
    if _ContentsGroup_ConsoleUIResize then
      PaGlobal_ConsoleUIOffset_Open()
    else
      PaGlobalFunc_UserSetting_Open()
    end
    return
  end
  PaGlobal_LoginNickname_All_Open()
end
