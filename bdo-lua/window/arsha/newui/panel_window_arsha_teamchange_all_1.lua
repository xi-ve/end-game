function PaGlobal_Arsha_TeamChange_All:initialize()
  if true == PaGlobal_Arsha_TeamChange_All._initialize or nil == Panel_Window_Arsha_TeamChangeControl_All then
    return
  end
  self._ui.stc_titleArea = UI.getChildControl(Panel_Window_Arsha_TeamChangeControl_All, "Static_TitleArea")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_titleArea, "StaticText_Title")
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_Arsha_TeamChangeControl_All, "Static_MainBG")
  self._ui.txt_desc = UI.getChildControl(Panel_Window_Arsha_TeamChangeControl_All, "StaticText_Desc")
  self._ui.rdo_teamA = UI.getChildControl(Panel_Window_Arsha_TeamChangeControl_All, "Radiobutton_SetTeamA")
  self._ui.rdo_teamB = UI.getChildControl(Panel_Window_Arsha_TeamChangeControl_All, "Radiobutton_SetTeamB")
  self._ui.rdo_teamW = UI.getChildControl(Panel_Window_Arsha_TeamChangeControl_All, "Radiobutton_SetTeamWait")
  self._ui.rdo_teamA:SetTextSpan((self._ui.rdo_teamA:GetSizeX() + 25) / 2 - self._ui.rdo_teamA:GetTextSizeX() / 2, 0)
  self._ui.rdo_teamB:SetTextSpan((self._ui.rdo_teamB:GetSizeX() + 25) / 2 - self._ui.rdo_teamB:GetTextSizeX() / 2, 0)
  self._ui.rdo_teamW:SetTextSpan((self._ui.rdo_teamW:GetSizeX() + 25) / 2 - self._ui.rdo_teamW:GetTextSizeX() / 2, 0)
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleArea, "Button_Close")
  self._ui_pc.btn_apply = UI.getChildControl(Panel_Window_Arsha_TeamChangeControl_All, "Button_Apply")
  self._ui_pc.btn_cancle = UI.getChildControl(Panel_Window_Arsha_TeamChangeControl_All, "Button_Cancel")
  self._ui_console.stc_keyGuideBg = UI.getChildControl(Panel_Window_Arsha_TeamChangeControl_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console.txt_keyGuideY = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Y_ConsoleUI")
  self._ui_console.txt_keyGuideA = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_A_ConsoleUI")
  self._ui_console.txt_keyGuideB = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_B_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Arsha_TeamChange_All:validate()
  PaGlobal_Arsha_TeamChange_All:registEventHandler()
  PaGlobal_Arsha_TeamChange_All:swichPlatform(self._isConsole)
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARSHA_TEAMCHANGECONTROL_DESC"))
  PaGlobal_Arsha_TeamChange_All._initialize = true
end
function PaGlobal_Arsha_TeamChange_All:swichPlatform(isConsole)
  self._ui_pc.btn_close:SetShow(not isConsole)
  self._ui_pc.btn_apply:SetShow(not isConsole)
  self._ui_pc.btn_cancle:SetShow(not isConsole)
  self._ui_console.stc_keyGuideBg:SetShow(isConsole)
  if true == isConsole then
    Panel_Window_Arsha_TeamChangeControl_All:SetSize(Panel_Window_Arsha_TeamChangeControl_All:GetSizeX(), self._ui.stc_mainBg:GetSizeY() + 50)
    self._ui_console.stc_keyGuideBg:ComputePos()
    self:setAlignKeyGuide()
  end
end
function PaGlobal_Arsha_TeamChange_All:prepareOpen(idx, userNo_Str, isObserver)
  if nil == Panel_Window_Arsha_TeamChangeControl_All then
    return
  end
  self._savedIdx = userNo_Str
  self._savedObserver = isObserver
  self._ui.rdo_teamA:SetCheck(false)
  self._ui.rdo_teamB:SetCheck(false)
  self._ui.rdo_teamW:SetCheck(true)
  PaGlobal_Arsha_TeamChange_All:open()
  PaGlobal_Arsha_TeamChange_All:resize()
end
function PaGlobal_Arsha_TeamChange_All:dataclear()
end
function PaGlobal_Arsha_TeamChange_All:open()
  if nil == Panel_Window_Arsha_TeamChangeControl_All then
    return
  end
  Panel_Window_Arsha_TeamChangeControl_All:SetShow(true)
end
function PaGlobal_Arsha_TeamChange_All:prepareClose()
  if nil == Panel_Window_Arsha_TeamChangeControl_All then
    return
  end
  PaGlobal_Arsha_TeamChange_All:close()
end
function PaGlobal_Arsha_TeamChange_All:close()
  if nil == Panel_Window_Arsha_TeamChangeControl_All then
    return
  end
  Panel_Window_Arsha_TeamChangeControl_All:SetShow(false)
end
function PaGlobal_Arsha_TeamChange_All:setAlignKeyGuide()
  local keyGuides = {
    PaGlobal_Arsha_TeamChange_All._ui_console.txt_keyGuideY,
    PaGlobal_Arsha_TeamChange_All._ui_console.txt_keyGuideA,
    PaGlobal_Arsha_TeamChange_All._ui_console.txt_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_Arsha_TeamChange_All._ui_console.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Arsha_TeamChange_All:registEventHandler()
  if nil == Panel_Window_Arsha_TeamChangeControl_All then
    return
  end
  if true == self._isConsole then
    Panel_Window_Arsha_TeamChangeControl_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Arsha_TeamChange_All_Confirm()")
  else
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_TeamChange_All_Close()")
    self._ui_pc.btn_cancle:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_TeamChange_All_Close()")
    self._ui_pc.btn_apply:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_TeamChange_All_Confirm()")
  end
end
function PaGlobal_Arsha_TeamChange_All:validate()
  if nil == Panel_Window_Arsha_TeamChangeControl_All then
    return
  end
  self._ui.stc_titleArea:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.stc_mainBg:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.rdo_teamA:isValidate()
  self._ui.rdo_teamB:isValidate()
  self._ui.rdo_teamW:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_apply:isValidate()
  self._ui_pc.btn_cancle:isValidate()
  self._ui_console.stc_keyGuideBg:isValidate()
  self._ui_console.txt_keyGuideY:isValidate()
  self._ui_console.txt_keyGuideA:isValidate()
  self._ui_console.txt_keyGuideB:isValidate()
end
function PaGlobal_Arsha_TeamChange_All:resize()
  if nil == Panel_Window_Arsha_TeamChangeControl_All then
    return
  end
  Panel_Window_Arsha_TeamChangeControl_All:ComputePos()
end
