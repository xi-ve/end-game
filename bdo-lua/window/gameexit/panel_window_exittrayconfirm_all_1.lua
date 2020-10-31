function PaGlobal_ExitTrayConfirm_All:initialize()
  if true == PaGlobal_ExitTrayConfirm_All._initialize or nil == Panel_Window_TrayConfirm_All then
    return
  end
  self._ui.stc_title = UI.getChildControl(Panel_Window_TrayConfirm_All, "StaticText_TitleArea")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_title, "StaticText_Title")
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_TrayConfirm_All, "Static_BG")
  self._ui.txt_gameExit = UI.getChildControl(self._ui.stc_mainBg, "StaticText_GameExit")
  self._ui.txt_trayHelp = UI.getChildControl(self._ui.stc_mainBg, "StaticText_TrayHelp")
  self._ui.chk_tray = UI.getChildControl(self._ui.stc_mainBg, "CheckButton_Tray")
  local chkTextSpanX = self._ui.chk_tray:GetTextSpan().x
  local chkTextSpanY = self._ui.chk_tray:GetTextSpan().y
  self._ui.chk_tray:SetTextSpan((self._ui.chk_tray:GetSizeX() + 25) / 2 - self._ui.chk_tray:GetTextSizeX() / 2, chkTextSpanY)
  self._ui.btn_confirm = UI.getChildControl(Panel_Window_TrayConfirm_All, "Button_Confirm")
  self._ui.btn_cancle = UI.getChildControl(Panel_Window_TrayConfirm_All, "Button_Cancle")
  self._ui.txt_trayHelp:SetShow(true)
  self._ui.txt_trayHelp:SetTextVerticalTop()
  self._ui.txt_trayHelp:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_trayHelp:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXITTRAY_TRAYHELP"))
  self._ui.txt_trayHelp:SetSize(self._ui.txt_trayHelp:GetSizeX(), self._ui.txt_trayHelp:GetTextSizeY() + 5)
  self._ui.chk_tray:SetCheck(false)
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ExitTrayConfirm_All:resize()
  PaGlobal_ExitTrayConfirm_All:validate()
  PaGlobal_ExitTrayConfirm_All:registEventHandler()
  PaGlobal_ExitTrayConfirm_All._initialize = true
end
function PaGlobal_ExitTrayConfirm_All:prepareOpen(openType)
  if nil == Panel_Window_TrayConfirm_All then
    return
  end
  if openType == self._openType.EXIT then
    PaGlobal_ExitTrayConfirm_All._ui.txt_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "GAMEEXIT_PRE_TEXT_TITLE"))
    PaGlobal_ExitTrayConfirm_All._ui.txt_gameExit:SetTextMode(__eTextMode_AutoWrap)
    PaGlobal_ExitTrayConfirm_All._ui.txt_gameExit:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEEXIT_DESC"))
  else
    PaGlobal_ExitTrayConfirm_All._ui.txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXITCONFIRM_TITLE"))
    PaGlobal_ExitTrayConfirm_All._ui.txt_gameExit:SetTextMode(__eTextMode_AutoWrap)
    PaGlobal_ExitTrayConfirm_All._ui.txt_gameExit:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_GAMEEXIT_TRAY_ASK2"))
  end
  PaGlobal_ExitTrayConfirm_All:open()
  PaGlobal_ExitTrayConfirm_All:update()
end
function PaGlobal_ExitTrayConfirm_All:open()
  if nil == Panel_Window_TrayConfirm_All then
    return
  end
  Panel_Window_TrayConfirm_All:SetShow(true)
end
function PaGlobal_ExitTrayConfirm_All:prepareClose()
  if nil == Panel_Window_TrayConfirm_All then
    return
  end
  PaGlobal_ExitTrayConfirm_All:close()
end
function PaGlobal_ExitTrayConfirm_All:close()
  if nil == Panel_Window_TrayConfirm_All then
    return
  end
  Panel_Window_TrayConfirm_All:SetShow(false)
end
function PaGlobal_ExitTrayConfirm_All:update()
end
function PaGlobal_ExitTrayConfirm_All:registEventHandler()
  if nil == Panel_Window_TrayConfirm_All then
    return
  end
  self._ui.btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_ExitTrayConfirm_All_Confirm()")
  self._ui.btn_cancle:addInputEvent("Mouse_LUp", "HandleEventLUp_ExitTrayConfirm_All_Close()")
end
function PaGlobal_ExitTrayConfirm_All:validate()
  if nil == Panel_Window_TrayConfirm_All then
    return
  end
  self._ui.stc_title:isValidate()
  self._ui.stc_mainBg:isValidate()
  self._ui.txt_gameExit:isValidate()
  self._ui.txt_trayHelp:isValidate()
  self._ui.chk_tray:isValidate()
  self._ui.btn_confirm:isValidate()
  self._ui.btn_cancle:isValidate()
end
function PaGlobal_ExitTrayConfirm_All:resize()
  if nil == Panel_Window_TrayConfirm_All then
    return
  end
  local baseMaxY = 80
  if baseMaxY < self._ui.txt_trayHelp:GetSizeY() then
    local addedSizeY = self._ui.txt_trayHelp:GetSizeY() - baseMaxY
    Panel_Window_TrayConfirm_All:SetSize(Panel_Window_TrayConfirm_All:GetSizeX(), Panel_Window_TrayConfirm_All:GetSizeY() + addedSizeY)
    self._ui.stc_mainBg:SetSize(self._ui.stc_mainBg:GetSizeX(), self._ui.stc_mainBg:GetSizeY() + addedSizeY)
    self._ui.stc_mainBg:ComputePos()
    self._ui.chk_tray:ComputePos()
    self._ui.btn_confirm:ComputePos()
    self._ui.btn_cancle:ComputePos()
  end
end
