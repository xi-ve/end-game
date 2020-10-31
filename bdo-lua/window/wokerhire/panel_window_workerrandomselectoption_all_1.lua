function PaGlobal_WorkerRandomSelectOption_All:initialize()
  if nil == Panel_Window_WorkerRandomSelectOption_All or true == PaGlobal_WorkerRandomSelectOption_All._initialize or nil == Panel_Window_WorkerRandomSelectOption_Grade_All then
    return
  end
  self._ui._stc_TitleBg = UI.getChildControl(Panel_Window_WorkerRandomSelectOption_All, "Static_MainTitleBar")
  self._ui._btn_Close_PC = UI.getChildControl(self._ui._stc_TitleBg, "Button_Close_PCUI")
  self._ui._btn_Continue_PC = UI.getChildControl(Panel_Window_WorkerRandomSelectOption_All, "Button_Continue")
  self._ui._btn_Cancel_PC = UI.getChildControl(Panel_Window_WorkerRandomSelectOption_All, "Button_Cancel")
  self._ui._stc_MainBg_KeyGuide = UI.getChildControl(Panel_Window_WorkerRandomSelectOption_All, "Static_BottomBG_ConsoleUI")
  self._ui._stc_MainBg_KeyGuide_A = UI.getChildControl(self._ui._stc_MainBg_KeyGuide, "StaticText_A_ConsoleUI")
  self._ui._stc_MainBg_KeyGudie_B = UI.getChildControl(self._ui._stc_MainBg_KeyGuide, "StaticText_B_ConsoleUI")
  self._ui._stc_MainBg_KeyGudie_Y = UI.getChildControl(self._ui._stc_MainBg_KeyGuide, "StaticText_Y_ConsoleUI")
  self._ui._stc_MainDescBg = UI.getChildControl(Panel_Window_WorkerRandomSelectOption_All, "Static_DescBg")
  self._ui._txt_MainDesc = UI.getChildControl(self._ui._stc_MainDescBg, "StaticText_Desc")
  self._ui._btn_WorkerGrade = UI.getChildControl(Panel_Window_WorkerRandomSelectOption_All, "Button_WorkerGrade")
  self._ui._txt_WorkerGrade = UI.getChildControl(self._ui._btn_WorkerGrade, "StaticText_SelectGrade")
  self._ui._btn_WorkerCount = UI.getChildControl(Panel_Window_WorkerRandomSelectOption_All, "Button_Count")
  self._ui._txt_workerCount = UI.getChildControl(self._ui._btn_WorkerCount, "StaticText_Count")
  self._isConsole = _ContentsGroup_UsePadSnapping
  if false == self._isConsole then
    self._ui._workerGrade_Panel = Panel_Window_WorkerRandomSelectOption_All
  else
    self._ui._workerGrade_Panel = Panel_Window_WorkerRandomSelectOption_Grade_All
  end
  self._ui._stc_GradeSelectBg = UI.getChildControl(self._ui._workerGrade_Panel, "Static_GradeSelectBg")
  for i = self._ENUM_GRADE._NORMAL, self._ENUM_GRADE._LOOPCOUNT do
    local index = i + 1
    self._gradeButtons[i] = UI.getChildControl(self._ui._stc_GradeSelectBg, "RadioButton_" .. index)
    self._gradeTexts[i] = UI.getChildControl(self._gradeButtons[i], "StaticText_" .. index)
    self._gradeTexts[i]:SetTextMode(__eTextMode_LimitText)
    self._gradeTexts[i]:SetText(self._gradeTexts[i]:GetText())
  end
  self._ui._stc_MainBg_KeyGuide:SetShow(self._isConsole)
  self._ui._btn_Close_PC:SetShow(not self._isConsole)
  self._ui._btn_Continue_PC:SetShow(not self._isConsole)
  self._ui._btn_Cancel_PC:SetShow(not self._isConsole)
  Panel_Window_WorkerRandomSelectOption_Grade_All:SetSpanSize(425, 0)
  if true == self._isConsole then
    local panelSizeX = Panel_Window_WorkerRandomSelectOption_All:GetSizeX()
    local panelSizeY = Panel_Window_WorkerRandomSelectOption_All:GetSizeY()
    local mainBgBtnSizeX = self._ui._btn_Continue_PC:GetSizeX()
    local mainBgBtnSizeY = self._ui._btn_Continue_PC:GetSizeY()
    local gradeOptionSizeX = self._ui._stc_GradeSelectBg:GetSizeX()
    local gradeOptionSizeY = self._ui._stc_GradeSelectBg:GetSizeY()
    Panel_Window_WorkerRandomSelectOption_All:SetSize(panelSizeX, panelSizeY - (mainBgBtnSizeY + 10))
    self._ui._stc_MainBg_KeyGuide:SetPosY(Panel_Window_WorkerRandomSelectOption_All:GetSizeY())
    self._ui._stc_GradeSelectBg:SetSize(gradeOptionSizeX, gradeOptionSizeY)
    local keyguide = {
      self._ui._stc_MainBg_KeyGudie_Y,
      self._ui._stc_MainBg_KeyGuide_A,
      self._ui._stc_MainBg_KeyGudie_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui._stc_MainBg_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  if self._ui._txt_MainDesc:GetSizeX() < self._ui._txt_MainDesc:GetTextSizeX() then
    self._ui._txt_MainDesc:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_MainDesc:SetText(self._ui._txt_MainDesc:GetText())
  end
  PaGlobal_WorkerRandomSelectOption_All:validate()
  PaGlobal_WorkerRandomSelectOption_All:registerEventHandler()
end
function PaGlobal_WorkerRandomSelectOption_All:validate()
  if nil == Panel_Window_WorkerRandomSelectOption_All then
    return
  end
  self._ui._stc_TitleBg:isValidate()
  self._ui._btn_Close_PC:isValidate()
  self._ui._btn_Continue_PC:isValidate()
  self._ui._btn_Cancel_PC:isValidate()
  self._ui._stc_MainBg_KeyGuide:isValidate()
  self._ui._stc_MainBg_KeyGuide_A:isValidate()
  self._ui._stc_MainBg_KeyGudie_B:isValidate()
  self._ui._stc_MainDescBg:isValidate()
  self._ui._txt_MainDesc:isValidate()
  self._ui._btn_WorkerGrade:isValidate()
  self._ui._txt_WorkerGrade:isValidate()
  self._ui._btn_WorkerCount:isValidate()
  self._ui._txt_workerCount:isValidate()
  self._ui._stc_GradeSelectBg:isValidate()
  for i = self._ENUM_GRADE._NORMAL, self._ENUM_GRADE._LOOPCOUNT do
    local index = i + 1
    self._gradeButtons[i]:isValidate()
    self._gradeTexts[i]:isValidate()
  end
  self._initialize = true
end
function PaGlobal_WorkerRandomSelectOption_All:registerEventHandler()
  if nil == Panel_Window_WorkerRandomSelectOption_All and false == PaGlobal_WorkerRandomSelectOption_All._initialize then
    return
  end
  registerEvent("onScreenResize", "FromClient_WorkerRandomSelectOption_OnScreenResize()")
  if false == self._isConsole then
    self._ui._btn_WorkerGrade:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerRandomSelectOption_All_OptionOpen( 0 )")
    self._ui._btn_WorkerCount:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerRandomSelectOption_All_OptionOpen( 1 )")
    self._ui._btn_Continue_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerRandomSelectOption_All_ContinueSelectStart()")
    self._ui._btn_Cancel_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerRandomSelectOption_All_Close()")
    self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerRandomSelectOption_All_Close()")
    for i = 0, #self._gradeButtons do
      self._gradeButtons[i]:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerRandomSelectOption_All_SelectGradeConfirm(" .. i .. ")")
      if true == self._gradeTexts[i]:IsLimitText() then
        self._gradeButtons[i]:addInputEvent("Mouse_On", "HandleEventOn_WorkerRandomSelectOption_All_LimitTextTooltip(" .. i .. ")")
        self._gradeButtons[i]:addInputEvent("Mouse_Out", "HandleEventOut_WorkerRandomSelectOption_All_LimitTextTooltip()")
      end
    end
  else
    Panel_Window_WorkerRandomSelectOption_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_WorkerRandomSelectOption_All_ContinueSelectStart()")
    self._ui._btn_WorkerGrade:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerRandomSelectOption_All_OptionOpen( 0 )")
    self._ui._btn_WorkerCount:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerRandomSelectOption_All_OptionOpen( 1 )")
    for i = 0, #self._gradeButtons do
      self._gradeButtons[i]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerRandomSelectOption_All_SelectGradeConfirm(" .. i .. ")")
    end
  end
end
function PaGlobal_WorkerRandomSelectOption_All:onScreenResize()
  if nil == Panel_Window_WorkerRandomSelectOption_All or false == Panel_Window_WorkerRandomSelectOption_All:GetShow() then
    return
  end
  Panel_Window_WorkerRandomSelectOption_All:ComputePos()
end
function PaGlobal_WorkerRandomSelectOption_All:clearData()
  if nil == Panel_Window_WorkerRandomSelectOption_All or false == Panel_Window_WorkerRandomSelectOption_All:GetShow() then
    return
  end
  self._config._repetitionCount = 1
  self._config._workerGrade = 0
end
function PaGlobal_WorkerRandomSelectOption_All:prepareClose()
  if nil == Panel_Window_WorkerRandomSelectOption_All or false == Panel_Window_WorkerRandomSelectOption_All:GetShow() then
    return
  end
  if false == self._isConsole then
    Panel_Window_WorkerRandomSelect_All:SetIgnoreChild(false)
  end
  PaGlobal_WorkerRandomSelectOption_All:clearData()
  PaGlobal_WorkerRandomSelectOption_All:close()
  PaGlobalFunc_WorkerRandomSelect_All_SetSnapToThisPanel()
end
function PaGlobal_WorkerRandomSelectOption_All:prepareOpen()
  if nil == Panel_Window_WorkerRandomSelectOption_All or true == Panel_Window_WorkerRandomSelectOption_All:GetShow() then
    return
  end
  if false == self._isConsole then
    Panel_Window_WorkerRandomSelect_All:SetIgnoreChild(true)
  end
  PaGlobal_WorkerRandomSelectOption_All:clearData()
  PaGlobal_WorkerRandomSelectOption_All:open()
  PaGlobal_WorkerRandomSelectOption_All:onScreenResize()
  PaGlobal_WorkerRandomSelectOption_All:update()
end
function PaGlobal_WorkerRandomSelectOption_All:open()
  if nil == Panel_Window_WorkerRandomSelectOption_All then
    return
  end
  Panel_Window_WorkerRandomSelectOption_All:SetShow(true)
end
function PaGlobal_WorkerRandomSelectOption_All:close()
  if nil == Panel_Window_WorkerRandomSelectOption_All then
    return
  end
  Panel_Window_WorkerRandomSelectOption_All:SetShow(false)
end
function PaGlobal_WorkerRandomSelectOption_All:update()
  if nil == Panel_Window_WorkerRandomSelectOption_All then
    return
  end
  local config = self._config
  local gradeButtons = self._gradeButtons
  if nil ~= config._repetitionCount and config._repetitionCount > -1 then
    self._ui._txt_workerCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERRANDOMSELECT_COUNT", "count", tostring(config._repetitionCount)))
  end
  if nil ~= config._workerGrade and -1 < config._workerGrade then
    self:setGradeText(config._workerGrade)
    if nil ~= self._selectedButton then
      self._selectedButton:SetCheck(false)
    end
    self._selectedButton = gradeButtons[config._workerGrade]
    gradeButtons[config._workerGrade]:SetCheck(true)
  end
end
function PaGlobal_WorkerRandomSelectOption_All:setGradeText(idx)
  if nil ~= idx then
    if self._ENUM_GRADE._NORMAL == idx then
      self._ui._txt_WorkerGrade:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERRANDOMSELECT_GRADE_NORMAL"))
      self._ui._txt_WorkerGrade:SetFontColor(Defines.Color.C_FF83A543)
    elseif self._ENUM_GRADE._SKILLED == idx then
      self._ui._txt_WorkerGrade:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERRANDOMSELECT_GRADE_SKILLED"))
      self._ui._txt_WorkerGrade:SetFontColor(Defines.Color.C_FF438DCC)
    elseif self._ENUM_GRADE._EXPERT == idx then
      self._ui._txt_WorkerGrade:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERRANDOMSELECT_GRADE_EXPERT"))
      self._ui._txt_WorkerGrade:SetFontColor(Defines.Color.C_FFF5BA3A)
    elseif self._ENUM_GRADE._ONLYMASTER == idx then
      self._ui._txt_WorkerGrade:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERRANDOMSELECT_GRADE_MASTER"))
      self._ui._txt_WorkerGrade:SetFontColor(Defines.Color.C_FFD05D48)
    end
  end
end
function PaGlobal_WorkerRandomSelectOption_All:gradePanelSetShow(show)
  if true == self._isConsole then
    Panel_Window_WorkerRandomSelectOption_Grade_All:SetShow(show)
  else
    self._ui._stc_GradeSelectBg:SetShow(show)
  end
end
