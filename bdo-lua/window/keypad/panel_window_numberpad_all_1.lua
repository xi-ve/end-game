function PaGlobal_NumberPad_All:initialize()
  if nil == Panel_Window_NumberPad_All then
    return
  end
  if true == PaGlobal_NumberPad_All._initialize then
    return
  end
  PaGlobal_NumberPad_All._ui.stc_title = UI.getChildControl(Panel_Window_NumberPad_All, "Static_Text_Title")
  PaGlobal_NumberPad_All._ui.btn_close = UI.getChildControl(PaGlobal_NumberPad_All._ui.stc_title, "Button_Close")
  PaGlobal_NumberPad_All._ui.edit_displayNumber = UI.getChildControl(Panel_Window_NumberPad_All, "Static_DisplayNumber")
  PaGlobal_NumberPad_All._ui.btn_confirm = UI.getChildControl(Panel_Window_NumberPad_All, "Button_Apply")
  PaGlobal_NumberPad_All._ui.btn_cancel = UI.getChildControl(Panel_Window_NumberPad_All, "Button_Cancel")
  PaGlobal_NumberPad_All._ui.btn_backspace = UI.getChildControl(Panel_Window_NumberPad_All, "Button_Back")
  PaGlobal_NumberPad_All._ui.btn_clear = UI.getChildControl(Panel_Window_NumberPad_All, "Button_Clear")
  if true == isGameTypeKR2() then
    PaGlobal_NumberPad_All._ui.btn_clear:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EXCHANGE_CLEAR"))
  else
    PaGlobal_NumberPad_All._ui.btn_clear:SetText("Clear")
  end
  PaGlobal_NumberPad_All._ui.btn_moneyAllSelect = UI.getChildControl(Panel_Window_NumberPad_All, "Button_MoneyAllSelect")
  PaGlobal_NumberPad_All._ui.btn_weightAllSelect = UI.getChildControl(Panel_Window_NumberPad_All, "Button_WeightAllSelect")
  PaGlobal_NumberPad_All._ui.chk_maxCount = UI.getChildControl(Panel_Window_NumberPad_All, "CheckButton_MaxCount_PCUI")
  PaGlobal_NumberPad_All._ui.chk_maxCount:SetCheck(false)
  PaGlobal_NumberPad_All._ui.chk_maxCount:SetEnableArea(0, 0, PaGlobal_NumberPad_All._ui.chk_maxCount:GetSizeX() + PaGlobal_NumberPad_All._ui.chk_maxCount:GetTextSizeX(), PaGlobal_NumberPad_All._ui.chk_maxCount:GetSizeY())
  for ii = 1, PaGlobal_NumberPad_All.MAX_NUMBER_BTN_COUNT do
    PaGlobal_NumberPad_All._ui.btn_numbers[ii] = UI.getChildControl(Panel_Window_NumberPad_All, "Button_" .. ii - 1)
  end
  PaGlobal_NumberPad_All._ui.stc_keyGuideBg = UI.getChildControl(Panel_Window_NumberPad_All, "Static_KeyGuideBg_ConsoleUI")
  PaGlobal_NumberPad_All._ui.btn_confirm_consoleUI = UI.getChildControl(PaGlobal_NumberPad_All._ui.stc_keyGuideBg, "StaticText_Y_ConsoleUI")
  PaGlobal_NumberPad_All._ui.btn_cancel_consoleUI = UI.getChildControl(PaGlobal_NumberPad_All._ui.stc_keyGuideBg, "StaticText_B_ConsoleUI")
  Panel_Window_NumberPad_All:setMaskingChild(true)
  Panel_Window_NumberPad_All:setGlassBackground(true)
  PaGlobal_NumberPad_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_NumberPad_All:setConsoleUI()
  PaGlobal_NumberPad_All:registEventHandler()
  PaGlobal_NumberPad_All:validate()
  PaGlobal_NumberPad_All._initialize = true
end
function PaGlobal_NumberPad_All:setConsoleUI()
  if nil == Panel_Window_NumberPad_All then
    return
  end
  if true == PaGlobal_NumberPad_All._isConsole then
    self._ui.stc_keyGuideBg:SetShow(true)
    self._ui.btn_confirm:SetShow(false)
    self._ui.btn_cancel:SetShow(false)
    Panel_Window_NumberPad_All:ignorePadSnapMoveToOtherPanel()
    self._ui.btn_moneyAllSelect:SetText("All")
    Panel_Window_NumberPad_All:SetSize(Panel_Window_NumberPad_All:GetSizeX(), Panel_Window_NumberPad_All:GetSizeY() - self._ui.btn_confirm:GetSizeY() - 5)
    self._ui.stc_keyGuideBg:SetPosY(Panel_Window_NumberPad_All:GetSizeY())
    local keyGuideSizeX = self._ui.btn_confirm_consoleUI:GetSizeX() + self._ui.btn_confirm_consoleUI:GetTextSizeX() + self._ui.btn_cancel_consoleUI:GetSizeX() + self._ui.btn_cancel_consoleUI:GetTextSizeX()
    local keyGuides = {
      self._ui.btn_confirm_consoleUI,
      self._ui.btn_cancel_consoleUI
    }
    if keyGuideSizeX < self._ui.stc_keyGuideBg:GetSizeX() then
      local gapX = (Panel_Window_NumberPad_All:GetSizeX() - keyGuideSizeX) / 3
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT, nil, gapX)
    else
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    end
  else
    self._ui.stc_keyGuideBg:SetShow(false)
    self._ui.btn_confirm:SetShow(true)
    self._ui.btn_cancel:SetShow(true)
  end
end
function PaGlobal_NumberPad_All:registEventHandler()
  if nil == Panel_Window_NumberPad_All then
    return
  end
  Panel_Window_NumberPad_All:RegisterShowEventFunc(true, "PaGlobal_NumberPad_All_ShowAni()")
  Panel_Window_NumberPad_All:RegisterShowEventFunc(false, "PaGlobal_NumberPad_All_HideAni()")
  PaGlobal_NumberPad_All._ui.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_NumberPad_All_CancelButton_Click()")
  PaGlobal_NumberPad_All._ui.chk_maxCount:addInputEvent("Mouse_LUp", "HandleEventLUp_NumberPad_All_AllButton_Click(1)")
  PaGlobal_NumberPad_All._ui.btn_moneyAllSelect:addInputEvent("Mouse_LUp", "HandleEventLUp_NumberPad_All_AllButton_Click(0)")
  PaGlobal_NumberPad_All._ui.btn_weightAllSelect:addInputEvent("Mouse_LUp", "HandleEventLUp_NumberPad_All_AllButton_Click(2)")
  PaGlobal_NumberPad_All._ui.btn_clear:addInputEvent("Mouse_LUp", "HandleEventLUp_NumberPad_All_ClearButton_Click()")
  PaGlobal_NumberPad_All._ui.btn_backspace:addInputEvent("Mouse_LUp", "HandleEventLUp_NumberPad_All_BackSpaceButton_Click(false)")
  PaGlobal_NumberPad_All._ui.btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_NumberPad_All_ConfirmButton_Click()")
  PaGlobal_NumberPad_All._ui.btn_cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_NumberPad_All_CancelButton_Click()")
  local scrollEventControls = {
    Panel_Window_NumberPad_All,
    PaGlobal_NumberPad_All._ui.btn_close,
    PaGlobal_NumberPad_All._ui.chk_maxCount,
    PaGlobal_NumberPad_All._ui.edit_displayNumber,
    PaGlobal_NumberPad_All._ui.btn_confirm,
    PaGlobal_NumberPad_All._ui.btn_cancel,
    PaGlobal_NumberPad_All._ui.btn_backspace,
    PaGlobal_NumberPad_All._ui.btn_clear,
    PaGlobal_NumberPad_All._ui.btn_moneyAllSelect,
    PaGlobal_NumberPad_All._ui.btn_weightAllSelect
  }
  for ii = 1, #scrollEventControls do
    scrollEventControls[ii]:addInputEvent("Mouse_UpScroll", "HandleEventScroll_NumberPad_All_ChangeCount(true)")
    scrollEventControls[ii]:addInputEvent("Mouse_DownScroll", "HandleEventScroll_NumberPad_All_ChangeCount(false)")
  end
  for ii = 1, PaGlobal_NumberPad_All.MAX_NUMBER_BTN_COUNT do
    PaGlobal_NumberPad_All._ui.btn_numbers[ii]:addInputEvent("Mouse_LUp", "HandleEventLUp_NumberPad_All_NumberButton_Click(" .. ii - 1 .. ")")
    PaGlobal_NumberPad_All._ui.btn_numbers[ii]:addInputEvent("Mouse_UpScroll", "HandleEventScroll_NumberPad_All_ChangeCount(true)")
    PaGlobal_NumberPad_All._ui.btn_numbers[ii]:addInputEvent("Mouse_DownScroll", "HandleEventScroll_NumberPad_All_ChangeCount(false)")
  end
  PaGlobal_NumberPad_All._ui.edit_displayNumber:RegistAllKeyEvent("HandleEventLUp_NumberPad_All_NumberButton_Click(nil)")
end
function PaGlobal_NumberPad_All:prepareOpen()
  if nil == Panel_Window_NumberPad_All then
    return
  end
  PaGlobal_NumberPad_All:open()
end
function PaGlobal_NumberPad_All:open()
  if nil == Panel_Window_NumberPad_All then
    return
  end
  Panel_Window_NumberPad_All:SetShow(true, true)
end
function PaGlobal_NumberPad_All:prepareClose()
  if nil == Panel_Window_NumberPad_All then
    return
  end
  local numberPad = PaGlobal_NumberPad_All._numberPad
  numberPad.s64_moneyMaxNumber = Defines.s64_const.s64_0
  numberPad.s64_weightMaxNumber = Defines.s64_const.s64_0
  numberPad.s64_inputNumber = Defines.s64_const.s64_0
  numberPad.param0 = nil
  numberPad.param1 = nil
  numberPad.param2 = nil
  numberPad.confirmFunction = nil
  numberPad.cancleFunction = nil
  PaGlobal_NumberPad_All:close()
end
function PaGlobal_NumberPad_All:close()
  if nil == Panel_Window_NumberPad_All then
    return
  end
  Panel_Window_NumberPad_All:SetShow(false, true)
end
function PaGlobal_NumberPad_All:validate()
  if nil == Panel_Window_NumberPad_All then
    return
  end
  PaGlobal_NumberPad_All._ui.stc_title:isValidate()
  PaGlobal_NumberPad_All._ui.btn_close:isValidate()
  PaGlobal_NumberPad_All._ui.edit_displayNumber:isValidate()
  PaGlobal_NumberPad_All._ui.btn_confirm:isValidate()
  PaGlobal_NumberPad_All._ui.btn_cancel:isValidate()
  PaGlobal_NumberPad_All._ui.btn_backspace:isValidate()
  PaGlobal_NumberPad_All._ui.btn_clear:isValidate()
  PaGlobal_NumberPad_All._ui.btn_moneyAllSelect:isValidate()
  PaGlobal_NumberPad_All._ui.btn_weightAllSelect:isValidate()
  PaGlobal_NumberPad_All._ui.chk_maxCount:isValidate()
end
function PaGlobal_NumberPad_All:checkButtonShow(isShow)
  PaGlobal_NumberPad_All._ui.chk_maxCount:SetShow(isShow)
end
function PaGlobal_NumberPad_All:checkConfirmEnable()
  return Defines.s64_const.s64_0 < tonumber64(tostring(PaGlobal_NumberPad_All._numberPad.s64_inputNumber))
end
function PaGlobal_NumberPad_All:updateConfirmButton(isEnable)
  if isEnable or PaGlobal_NumberPad_All:checkConfirmEnable() then
    if false == PaGlobal_NumberPad_All._isConsole then
      PaGlobal_NumberPad_All._ui.btn_confirm:SetEnable(true)
      PaGlobal_NumberPad_All._ui.btn_confirm:SetMonoTone(false)
      PaGlobal_NumberPad_All._ui.btn_confirm:SetFontColor(Defines.Color.C_FFFFFFFF)
    else
      PaGlobal_NumberPad_All._ui.btn_confirm_consoleUI:SetMonoTone(false)
    end
  elseif false == PaGlobal_NumberPad_All._isConsole then
    PaGlobal_NumberPad_All._ui.btn_confirm:SetEnable(false)
    PaGlobal_NumberPad_All._ui.btn_confirm:SetMonoTone(true)
    PaGlobal_NumberPad_All._ui.btn_confirm:SetFontColor(Defines.Color.C_FFC4BEBE)
  else
    PaGlobal_NumberPad_All._ui.btn_confirm_consoleUI:SetMonoTone(true)
  end
end
function PaGlobal_NumberPad_All:openSetting(param0, confirmFunction, isShow, param1, param2)
  local numberPad = PaGlobal_NumberPad_All._numberPad
  numberPad.param0 = param0
  numberPad.param1 = param1
  numberPad.param2 = param2
  numberPad.confirmFunction = confirmFunction
  numberPad.init_Number = true
  numberPad._type = ""
  PaGlobal_NumberPad_All._ui.edit_displayNumber:SetEditText(tostring(numberPad.s64_inputNumber))
  PaGlobal_NumberPad_All._ui.edit_displayNumber:SetNumberMode(true)
  PaGlobal_NumberPad_All:updateConfirmButton(true)
  if false == Panel_Window_NumberPad_All:GetShow() then
    if PaGlobal_NumberPad_All._isConsole then
      local snappedControl = ToClient_getSnappedControl()
      if nil ~= snappedControl then
        Panel_Window_NumberPad_All:SetPosX(getMousePosX())
        Panel_Window_NumberPad_All:SetPosY(getMousePosY())
      else
        Panel_Window_NumberPad_All:SetPosX(getOriginScreenSizeX() / 2 - Panel_Window_NumberPad_All:GetSizeX() / 2)
        Panel_Window_NumberPad_All:SetPosY(getOriginScreenSizeY() / 2 - Panel_Window_NumberPad_All:GetSizeY() / 2)
      end
    else
      Panel_Window_NumberPad_All:SetPosX(getMousePosX())
      Panel_Window_NumberPad_All:SetPosY(getMousePosY())
    end
  end
  if false == PaGlobal_NumberPad_All._isConsole then
    if Panel_Window_NumberPad_All:GetPosY() + Panel_Window_NumberPad_All:GetSizeY() > getScreenSizeY() then
      Panel_Window_NumberPad_All:SetPosY(getScreenSizeY() - Panel_Window_NumberPad_All:GetSizeY() - 30)
    end
  elseif Panel_Window_NumberPad_All:GetPosY() + Panel_Window_NumberPad_All:GetSizeY() + PaGlobal_NumberPad_All._ui.stc_keyGuideBg:GetSizeY() > getScreenSizeY() then
    Panel_Window_NumberPad_All:SetPosY(getScreenSizeY() - Panel_Window_NumberPad_All:GetSizeY() - PaGlobal_NumberPad_All._ui.stc_keyGuideBg:GetSizeY() - 30)
  end
  if Panel_Window_NumberPad_All:GetPosX() + Panel_Window_NumberPad_All:GetSizeX() > getScreenSizeX() then
    Panel_Window_NumberPad_All:SetPosX(getScreenSizeX() - Panel_Window_NumberPad_All:GetSizeX())
  end
  if true == isShow then
    PaGlobal_NumberPad_All:prepareOpen()
  end
end
function PaGlobal_NumberPad_All:cancleSetting(cancleFunction)
  local numberPad = PaGlobal_NumberPad_All._numberPad
  numberPad.cancleFunction = cancleFunction
end
