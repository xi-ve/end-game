function PaGlobal_GuildDeposit_All:initialize()
  if true == PaGlobal_GuildDeposit_All._initialize or nil == Panel_GuildDeposit_All then
    return
  end
  self._ui.stc_titleArea = UI.getChildControl(Panel_GuildDeposit_All, "Static_TitleArea")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleArea, "Button_Close")
  self._ui.stc_mainArea = UI.getChildControl(Panel_GuildDeposit_All, "Static_MainArea")
  self._ui.edit_deposit = UI.getChildControl(self._ui.stc_mainArea, "Edit_Search_Guild")
  self._ui.btn_deposit = UI.getChildControl(self._ui.stc_mainArea, "Button_Deposit")
  self._ui.stc_descArea = UI.getChildControl(self._ui.stc_mainArea, "Static_DescEdge")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_descArea, "StaticText_Desc")
  self._ui.stc_KeyguideBg = UI.getChildControl(Panel_GuildDeposit_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyguideBg, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyguideBg, "StaticText_B_ConsoleUI")
  self._ui.edit_deposit:SetNumberMode(true)
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetAutoResize(true)
  self._ui.txt_desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDLIST_DEPOSIT_NOTIFY", "maxInput", "0"))
  self._ui.stc_descArea:SetSize(self._ui.stc_descArea:GetSizeX(), self._ui.txt_desc:GetPosY() + self._ui.txt_desc:GetSizeY() + 10)
  self._ui.stc_mainArea:SetSize(self._ui.stc_mainArea:GetSizeX(), self._ui.stc_descArea:GetPosY() + self._ui.stc_descArea:GetSizeY() + 10)
  Panel_GuildDeposit_All:SetSize(Panel_GuildDeposit_All:GetSizeX(), self._ui.stc_mainArea:GetPosY() + self._ui.stc_mainArea:GetSizeY())
  if true == _ContentsGroup_UsePadSnapping then
    self._ui.stc_KeyguideBg:SetShow(true)
    local keyTable = {
      self._ui.stc_KeyGuide_A,
      self._ui.stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyTable, self._ui.stc_KeyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    self._ui.btn_close:SetShow(false)
  end
  PaGlobal_GuildDeposit_All:validate()
  PaGlobal_GuildDeposit_All:registEvent()
end
function PaGlobal_GuildDeposit_All:validate()
  self._ui.stc_titleArea:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_mainArea:isValidate()
  self._ui.edit_deposit:isValidate()
  self._ui.btn_deposit:isValidate()
  self._ui.stc_descArea:isValidate()
  self._ui.txt_desc:isValidate()
end
function PaGlobal_GuildDeposit_All:registEvent()
  if false == _ContentsGroup_UsePadSnapping then
    self._ui.edit_deposit:addInputEvent("Mouse_LUp", "InputMLUp_Deposit_SetDeposit()")
    self._ui.edit_deposit:RegistReturnKeyEvent("InputMLUp_Deposit_Send()")
  else
    self._ui.edit_deposit:addInputEvent("Mouse_LUp", "HandlleEventPadUp_Deposit_SetDeposit()")
  end
  self._ui.btn_deposit:addInputEvent("Mouse_LUp", "InputMLUp_Deposit_Send()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_GuildDeposit_All_Close()")
end
function PaGlobal_GuildDeposit_All:prepareOpen(maxInputValue_s64)
  if nil == Panel_GuildDeposit_All then
    return
  end
  self._inputValue_s64 = Defines.s64_const.s64_0
  self._ui.edit_deposit:SetEditText("", true)
  self._maxInputValue_s64 = maxInputValue_s64
  self._ui.txt_desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDLIST_DEPOSIT_NOTIFY", "maxInput", makeDotMoney(maxInputValue_s64)))
  PaGlobal_GuildDeposit_All:open()
end
function PaGlobal_GuildDeposit_All:open()
  if nil == Panel_GuildDeposit_All then
    return
  end
  Panel_GuildDeposit_All:SetShow(true)
end
function PaGlobal_GuildDeposit_All:prepareClose()
  if nil == Panel_GuildDeposit_All then
    return
  end
  ClearFocusEdit()
  CheckChattingInput()
  PaGlobal_GuildDeposit_All:close()
end
function PaGlobal_GuildDeposit_All:close()
  if nil == Panel_GuildDeposit_All then
    return
  end
  Panel_GuildDeposit_All:SetShow(false)
end
