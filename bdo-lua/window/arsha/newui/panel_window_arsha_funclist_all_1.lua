function PaGlobal_Arsha_FuncList_All:initialize()
  if true == PaGlobal_Arsha_FuncList_All._initialize or nil == Panel_Window_Arsha_FuncList_All then
    return
  end
  self._ui.stc_titleArea = UI.getChildControl(Panel_Window_Arsha_FuncList_All, "Static_TitleArea")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_titleArea, "StaticText_TItle")
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_Arsha_FuncList_All, "Static_MainArea")
  self._ui.btn_template = UI.getChildControl(self._ui.stc_mainBg, "Button_FunctionButton_Temp")
  self._ui_console.stc_bottomGuideBg = UI.getChildControl(Panel_Window_Arsha_FuncList_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console.stc_guideA = UI.getChildControl(self._ui_console.stc_bottomGuideBg, "StaticText_A_ConsoleUI")
  self._ui_console.stc_guideB = UI.getChildControl(self._ui_console.stc_bottomGuideBg, "StaticText_B_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Arsha_FuncList_All:validate()
  PaGlobal_Arsha_FuncList_All:registEventHandler()
  PaGlobal_Arsha_FuncList_All:swichPlatform(self._isConsole)
  self._ui.btn_template:SetShow(false)
  for ii = 1, self._btnMaxCount do
    self._uiBtnList[ii] = UI.cloneControl(self._ui.btn_template, self._ui.stc_mainBg, "Button_FunctionButton_" .. ii)
    self._uiBtnList[ii]:SetShow(false)
  end
  PaGlobal_Arsha_FuncList_All._initialize = true
end
function PaGlobal_Arsha_FuncList_All:swichPlatform(isConsole)
  self._ui_console.stc_bottomGuideBg:SetShow(isConsole)
end
function PaGlobal_Arsha_FuncList_All:setAlignKeyGuide()
  local keyGuides = {
    self._ui_console.stc_guideA,
    self._ui_console.stc_guideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_Arsha_FuncList_All._ui_console.stc_bottomGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Arsha_FuncList_All:prepareOpen()
  if nil == Panel_Window_Arsha_FuncList_All then
    return
  end
  PaGlobal_Arsha_FuncList_All:open()
  PaGlobal_Arsha_FuncList_All:update()
  PaGlobal_Arsha_FuncList_All:resize()
end
function PaGlobal_Arsha_FuncList_All:dataclear()
end
function PaGlobal_Arsha_FuncList_All:open()
  if nil == Panel_Window_Arsha_FuncList_All then
    return
  end
  Panel_Window_Arsha_FuncList_All:SetShow(true)
end
function PaGlobal_Arsha_FuncList_All:prepareClose()
  if nil == Panel_Window_Arsha_FuncList_All then
    return
  end
  PaGlobal_Arsha_FuncList_All:close()
end
function PaGlobal_Arsha_FuncList_All:close()
  if nil == Panel_Window_Arsha_FuncList_All then
    return
  end
  Panel_Window_Arsha_FuncList_All:SetShow(false)
end
function PaGlobal_Arsha_FuncList_All:update()
  if nil == Panel_Window_Arsha_FuncList_All then
    return
  end
  self:setButtonList()
end
function PaGlobal_Arsha_FuncList_All:setButtonList()
  if nil == Panel_Window_Arsha_FuncList_All then
    return
  end
  local isHost = ToClient_IsCompetitionHost()
  local isSubHost = ToClient_IsCompetitionAssistant()
  local matchMode = ToClient_CompetitionMatchType()
  self._showBtnCount = 0
  for ii = 1, self._btnMaxCount do
    self._uiBtnList[ii]:SetShow(false)
  end
  local startSpanY = 10
  local gabY = 10
  local btnSizeY = self._ui.btn_template:GetSizeY()
  local function addButtonList(index)
    self._uiBtnList[index]:SetShow(true)
    self._uiBtnList[index]:SetText(self._buttonString[index])
    self._uiBtnList[index]:SetSpanSize(self._uiBtnList[index]:GetSpanSize().x, startSpanY)
    self._uiBtnList[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_FuncList_All_SelectButton(" .. index .. ")")
    self._showBtnCount = self._showBtnCount + 1
    startSpanY = startSpanY + btnSizeY + gabY
  end
  for ii = 1, #self._buttonType do
    if true == self._buttonType[ii].isHost and true == isHost then
      if 4 == ii then
        if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == matchMode or CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == matchMode then
          addButtonList(ii)
        end
      else
        addButtonList(ii)
      end
    end
    if true == self._buttonType[ii].isSubHost and true == isSubHost then
      addButtonList(ii)
    end
    if false == self._buttonType[ii].isHost and false == self._buttonType[ii].isSubHost then
      if 7 == ii or 8 == ii or 9 == ii then
        if (CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == matchMode or CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == matchMode) and true == ToClient_IsMyselfInEntryUser() then
          addButtonList(ii)
        end
      else
        addButtonList(ii)
      end
    end
  end
end
function PaGlobal_Arsha_FuncList_All:registEventHandler()
  if nil == Panel_Window_Arsha_FuncList_All then
    return
  end
end
function PaGlobal_Arsha_FuncList_All:validate()
  if nil == Panel_Window_Arsha_FuncList_All then
    return
  end
  self._ui.stc_titleArea:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.stc_mainBg:isValidate()
  self._ui.btn_template:isValidate()
  self._ui_console.stc_bottomGuideBg:isValidate()
end
function PaGlobal_Arsha_FuncList_All:resize()
  if nil == Panel_Window_Arsha_FuncList_All then
    return
  end
  local gabY = 10
  local btnSizeY = self._ui.btn_template:GetSizeY()
  local mainBgX = self._ui.stc_mainBg:GetSizeX()
  local panelX = Panel_Window_Arsha_FuncList_All:GetSizeX()
  self._ui.stc_mainBg:SetSize(mainBgX, 2 * gabY + self._showBtnCount * btnSizeY + (self._showBtnCount - 1) * gabY)
  Panel_Window_Arsha_FuncList_All:SetSize(panelX, self._ui.stc_titleArea:GetSizeY() + self._ui.stc_mainBg:GetSizeY())
  self._ui.stc_mainBg:ComputePos()
  self._ui_console.stc_bottomGuideBg:ComputePos()
  for ii = 1, self._showBtnCount do
    self._uiBtnList[ii]:ComputePos()
  end
  Panel_Window_Arsha_FuncList_All:ComputePos()
  self:setAlignKeyGuide()
end
