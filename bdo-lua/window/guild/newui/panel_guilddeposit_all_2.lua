function InputMLUp_Deposit_SetDeposit()
  if nil == Panel_GuildDeposit_All then
    return
  end
  PaGlobal_GuildDeposit_All._inputValue_s64 = Defines.s64_const.s64_0
  PaGlobal_GuildDeposit_All._ui.edit_deposit:SetEditText("", true)
  PaGlobal_GuildDeposit_All._ui.edit_deposit:SetNumberMode(true)
  SetFocusEdit(PaGlobal_GuildDeposit_All._ui.edit_deposit)
end
function HandlleEventPadUp_Deposit_SetDeposit()
  if nil == Panel_GuildDeposit_All then
    return
  end
  PaGlobal_GuildDeposit_All._inputValue_s64 = Defines.s64_const.s64_0
  PaGlobal_GuildDeposit_All._ui.edit_deposit:SetEditText("", true)
  Panel_NumberPad_Show(true, PaGlobal_GuildDeposit_All._maxInputValue_s64, 0, PaGlobal_Deposit_CloseNumPadDeposit)
end
function PaGlobal_Deposit_CloseNumPadDeposit(inputNumber64)
  if nil == Panel_GuildDeposit_All or false == Panel_GuildDeposit_All:GetShow() or nil == inputNumber64 then
    return
  end
  PaGlobal_GuildDeposit_All._ui.edit_deposit:SetEditText(inputNumber64, true)
  PaGlobal_GuildDeposit_All._inputValue_s64 = inputNumber64
end
function InputMLUp_Deposit_Send()
  if nil == Panel_GuildDeposit_All then
    return
  end
  local tempMoney = PaGlobal_GuildDeposit_All._inputValue_s64
  if nil == tempMoney or tempMoney <= Defines.s64_const.s64_0 or tempMoney == "" then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_VENDINGMACHINE_PERFORM_MESSAGE_0"))
    ClearFocusEdit()
    return
  end
  ToClient_DepositToGuildWareHouse(tempMoney)
  PaGlobal_GuildDeposit_All_Close()
end
function PaGlobal_GuildDeposit_All_Open(maxInputValue_s64)
  if nil == Panel_GuildDeposit_All or nil == maxInputValue_s64 then
    return
  end
  PaGlobal_GuildDeposit_All:prepareOpen(maxInputValue_s64)
end
function PaGlobal_GuildDeposit_All_Close()
  if nil == Panel_GuildDeposit_All then
    return
  end
  PaGlobal_GuildDeposit_All:prepareClose()
end
function PaGlobal_GuildDeposit_All_CheckUiEdit(targetUI)
  if nil == Panel_GuildDeposit_All then
    return false
  end
  return nil ~= targetUI and targetUI:GetKey() == PaGlobal_GuildDeposit_All._ui.edit_deposit:GetKey()
end
local numberKeyCode = {
  CppEnums.VirtualKeyCode.KeyCode_0,
  CppEnums.VirtualKeyCode.KeyCode_1,
  CppEnums.VirtualKeyCode.KeyCode_2,
  CppEnums.VirtualKeyCode.KeyCode_3,
  CppEnums.VirtualKeyCode.KeyCode_4,
  CppEnums.VirtualKeyCode.KeyCode_5,
  CppEnums.VirtualKeyCode.KeyCode_6,
  CppEnums.VirtualKeyCode.KeyCode_7,
  CppEnums.VirtualKeyCode.KeyCode_8,
  CppEnums.VirtualKeyCode.KeyCode_9,
  CppEnums.VirtualKeyCode.KeyCode_NUMPAD0,
  CppEnums.VirtualKeyCode.KeyCode_NUMPAD1,
  CppEnums.VirtualKeyCode.KeyCode_NUMPAD2,
  CppEnums.VirtualKeyCode.KeyCode_NUMPAD3,
  CppEnums.VirtualKeyCode.KeyCode_NUMPAD4,
  CppEnums.VirtualKeyCode.KeyCode_NUMPAD5,
  CppEnums.VirtualKeyCode.KeyCode_NUMPAD6,
  CppEnums.VirtualKeyCode.KeyCode_NUMPAD7,
  CppEnums.VirtualKeyCode.KeyCode_NUMPAD8,
  CppEnums.VirtualKeyCode.KeyCode_NUMPAD9
}
function PaGlobal_GuildDeposit_All_InputCheck()
  for idx, val in ipairs(numberKeyCode) do
    if isKeyUpFor(val) then
      if 10 < idx then
        PaGlobal_GuildDeposit_All_InputCheck_Command(idx - 11)
      else
        PaGlobal_GuildDeposit_All_InputCheck_Command(idx - 1)
      end
    end
  end
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_BACK) then
    PaGlobal_GuildDeposit_All_InputCheck_BackSpaceCommand()
  end
  PaGlobal_GuildDeposit_All._ui.edit_deposit:SetEditText(makeDotMoney(PaGlobal_GuildDeposit_All._inputValue_s64), true)
end
function PaGlobal_GuildDeposit_All_InputCheck_Command(number)
  if nil == Panel_GuildDeposit_All then
    return
  end
  local str = "0"
  if nil ~= PaGlobal_GuildDeposit_All._inputValue_s64 then
    str = tostring(PaGlobal_GuildDeposit_All._inputValue_s64)
  end
  local newStr = str .. tostring(number)
  local s64_newNumber = tonumber64(newStr)
  local s64_MAX = PaGlobal_GuildDeposit_All._maxInputValue_s64
  if s64_newNumber > s64_MAX then
    PaGlobal_GuildDeposit_All._inputValue_s64 = PaGlobal_GuildDeposit_All._maxInputValue_s64
  else
    PaGlobal_GuildDeposit_All._inputValue_s64 = s64_newNumber
  end
end
function PaGlobal_GuildDeposit_All_InputCheck_BackSpaceCommand()
  if nil == Panel_GuildDeposit_All then
    return
  end
  local str = "0"
  if nil ~= PaGlobal_GuildDeposit_All._inputValue_s64 then
    str = tostring(PaGlobal_GuildDeposit_All._inputValue_s64)
  end
  local length = string.len(str)
  local newStr = ""
  if 1 < length then
    newStr = string.sub(str, 1, length - 1)
    PaGlobal_GuildDeposit_All._inputValue_s64 = tonumber64(newStr)
  else
    newStr = "0"
    PaGlobal_GuildDeposit_All._inputValue_s64 = Defines.s64_const.s64_0
  end
end
