function PaGlobal_Invitation_All:initialize()
  if true == PaGlobal_Invitation_All._initialize then
    return
  end
  self._ui.btn_Close = UI.getChildControl(Panel_Window_Invitation_All, "Button_Close")
  self._ui.txt_Contents = UI.getChildControl(Panel_Window_Invitation_All, "StaticText_Contents")
  self._ui.stc_keyGuideConsoleBg = UI.getChildControl(Panel_Window_Invitation_All, "Static_KeyGuide_Console")
  self._ui.stc_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideConsoleBg, "StaticText_B_Close")
  self._ui.txt_Contents:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_Invitation_All:registEventHandler()
  PaGlobal_Invitation_All:validate()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.btn_Close:SetShow(not self._isConsole)
  self._ui.stc_keyGuideConsoleBg:SetShow(self._isConsole)
  PaGlobal_Invitation_All._initialize = true
end
function PaGlobal_Invitation_All:registEventHandler()
  if nil == Panel_Window_Invitation_All then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_Invitation_All_Close()")
end
function PaGlobal_Invitation_All:prepareOpen(eType)
  if nil == Panel_Window_Invitation_All then
    return
  end
  self:initTextDesc(eType)
  PaGlobal_Invitation_All:open()
  self:setAlignKeyGuide()
end
function PaGlobal_Invitation_All:open()
  if nil == Panel_Window_Invitation_All then
    return
  end
  Panel_Window_Invitation_All:SetShow(true)
end
function PaGlobal_Invitation_All:prepareClose()
  if nil == Panel_Window_Invitation_All then
    return
  end
  PaGlobal_Invitation_All:close()
end
function PaGlobal_Invitation_All:close()
  if nil == Panel_Window_Invitation_All then
    return
  end
  Panel_Window_Invitation_All:SetShow(false)
end
function PaGlobal_Invitation_All:setAlignKeyGuide()
  local keyGuides = {
    self._ui.stc_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuideConsoleBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Invitation_All:update()
  if nil == Panel_Window_Invitation_All then
    return
  end
end
function PaGlobal_Invitation_All:validate()
  if nil == Panel_Window_Invitation_All then
    return
  end
  self._ui.btn_Close:isValidate()
  self._ui.txt_Contents:isValidate()
end
function PaGlobal_Invitation_All:initTextDesc(eType)
  if self._eType.invitation == eType then
    self._ui.txt_Contents:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LETTER_JARETT_DESC"))
  end
end
