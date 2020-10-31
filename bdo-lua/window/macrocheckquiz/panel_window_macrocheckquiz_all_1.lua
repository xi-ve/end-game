function PaGlobal_MacroCheckQuiz_All:initialize()
  if true == PaGlobal_MacroCheckQuiz_All._initialize or nil == Panel_MacroCheckQuiz_All or nil == Panel_MacroCheckQuizPad_All then
    return
  end
  self._ui.stc_TitleArea = UI.getChildControl(Panel_MacroCheckQuiz_All, "Static_TitleArea")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_TitleArea, "StaticText_Title")
  self._ui.stc_BottomLine = UI.getChildControl(self._ui.stc_TitleArea, "Static_BottomLine")
  self._ui.txt_Question = UI.getChildControl(Panel_MacroCheckQuiz_All, "StaticText_QuestionTitle")
  self._ui.txt_LeftTime = UI.getChildControl(Panel_MacroCheckQuiz_All, "StaticText_TimeCount")
  self._ui.stc_ProgBg = UI.getChildControl(Panel_MacroCheckQuiz_All, "Static_ProgressBG")
  self._ui.prog2_LeftTime = UI.getChildControl(Panel_MacroCheckQuiz_All, "Progress2_limitTime")
  self._ui.stc_WarningBg = UI.getChildControl(Panel_MacroCheckQuiz_All, "Static_WarningBG")
  self._ui.txt_Warning = UI.getChildControl(self._ui.stc_WarningBg, "StaticText_Warning")
  self._ui.txt_CautionDesc = UI.getChildControl(self._ui.stc_WarningBg, "StaticText_Caution")
  self._ui.btn_Apply = UI.getChildControl(Panel_MacroCheckQuiz_All, "Button_Apply")
  self._ui.stc_KeyGuideBg = UI.getChildControl(Panel_MacroCheckQuiz_All, "Static_BottomBg")
  self._ui.stc_KeyGuideY = UI.getChildControl(self._ui.stc_KeyGuideBg, "StaticText_A_ConsoleUI")
  self._ui.stc_QuestionBg = UI.getChildControl(Panel_MacroCheckQuiz_All, "Static_QuestionBG")
  for idx = 0, 2 do
    local tempTable = {
      _bg = nil,
      _txt_Question = nil,
      _stc_AnswerBg = nil,
      _rdo_Answer = nil
    }
    tempTable._bg = UI.getChildControl(self._ui.stc_QuestionBg, "Static_QPadBG" .. idx)
    tempTable._txt_Question = UI.getChildControl(tempTable._bg, "StaticText_Question" .. idx)
    tempTable._stc_AnswerBg = UI.getChildControl(tempTable._bg, "Static_AnswerBG" .. idx)
    tempTable._rdo_Answer = UI.getChildControl(tempTable._bg, "Radiobutton_Answer" .. idx)
    self._ui.stc_AnswerPadTable[idx] = tempTable
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.txt_Question:SetTextMode(__eTextMode_AutoWrap)
  if true == self._isConsole then
    self._ui.txt_Question:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MACROCHECKQUIZ_QUESTIONTITLE_CONSOLE"))
  end
  self._ui.txt_Question:SetText(self._ui.txt_Question:GetText())
  local originSIze = self._ui.txt_Question:GetSizeY()
  if self._ui.txt_Question:GetTextSizeY() > self._ui.txt_Question:GetSizeY() then
    self._ui.txt_Question:SetSize(self._ui.txt_Question:GetSizeX(), self._ui.txt_Question:GetTextSizeY() + 5)
    local gap = self._ui.txt_Question:GetSizeY() - originSIze
    Panel_MacroCheckQuiz_All:SetSize(Panel_MacroCheckQuiz_All:GetSizeX(), Panel_MacroCheckQuiz_All:GetSizeY() + gap)
    self._ui.txt_LeftTime:SetSpanSize(self._ui.txt_LeftTime:GetSpanSize().x, self._ui.txt_LeftTime:GetSpanSize().y + gap)
    self._ui.stc_ProgBg:SetSpanSize(self._ui.stc_ProgBg:GetSpanSize().x, self._ui.stc_ProgBg:GetSpanSize().y + gap)
    self._ui.prog2_LeftTime:SetSpanSize(self._ui.prog2_LeftTime:GetSpanSize().x, self._ui.prog2_LeftTime:GetSpanSize().y + gap)
    self._ui.stc_QuestionBg:SetSpanSize(self._ui.stc_QuestionBg:GetSpanSize().x, self._ui.stc_QuestionBg:GetSpanSize().y + gap)
    self._ui.stc_WarningBg:SetSpanSize(self._ui.stc_WarningBg:GetSpanSize().x, self._ui.stc_WarningBg:GetSpanSize().y + gap)
    if self._ui.txt_CautionDesc:GetTextSizeX() > self._ui.txt_CautionDesc:GetSizeX() then
      local waringSize = self._ui.txt_CautionDesc:GetSizeY()
      self._ui.txt_CautionDesc:SetTextMode(__eTextMode_AutoWrap)
      self._ui.txt_CautionDesc:SetText(self._ui.txt_CautionDesc:GetText())
      waringSize = self._ui.txt_CautionDesc:GetTextSizeY() - waringSize
      self._ui.stc_WarningBg:SetSize(self._ui.stc_WarningBg:GetSizeX(), self._ui.stc_WarningBg:GetSizeY() + waringSize + 5)
      Panel_MacroCheckQuiz_All:SetSize(Panel_MacroCheckQuiz_All:GetSizeX(), Panel_MacroCheckQuiz_All:GetSizeY() + waringSize + 5)
      self._ui.btn_Apply:SetSpanSize(self._ui.btn_Apply:GetSpanSize().x, self._ui.btn_Apply:GetSpanSize().y + 5)
    end
    Panel_MacroCheckQuiz_All:ComputePos()
    self._ui.btn_Apply:ComputePos()
  end
  PaGlobal_MacroCheckQuiz_All:validate()
  PaGlobal_MacroCheckQuiz_All:registEventHandler()
  PaGlobal_MacroCheckQuiz_All:swichPlatform()
  ToClient_setDoingMacroCheckQuiz(false)
  PaGlobal_MacroCheckQuiz_All._initialize = true
end
function PaGlobal_MacroCheckQuiz_All:registEventHandler()
  if nil == Panel_MacroCheckQuiz_All then
    return
  end
  self._ui.btn_Apply:addInputEvent("Mouse_LUp", "HandleEventLUp_MacroCheckQuiz_All_SendAnswer()")
  if true == self._isConsole then
    Panel_MacroCheckQuiz_All:ignorePadSnapMoveToOtherPanel()
  end
  registerEvent("FromClient_receiveSecureCodeQuestion", "FromClient_MacroCheckQuiz_All_receiveSecureCodeQuestion")
  registerEvent("FromClient_receiveSecureCodeAnswer_Detail", "FromClient_MacroCheckQuiz_All_receiveResult")
  registerEvent("FromClient_receiveSecureCodeAnswer", "FromClient_MacroCheckQuiz_All_receiveSecureCodeAnswer")
  registerEvent("FromClient_receiveSecureCodeTimeOver", "FromClient_MacroCheckQuiz_All_TimeOver")
end
function PaGlobal_MacroCheckQuiz_All:swichPlatform()
  self._ui.stc_KeyGuideBg:SetShow(self._isConsole)
end
function PaGlobal_MacroCheckQuiz_All:prepareOpen()
  if nil == Panel_MacroCheckQuiz_All then
    return
  end
  PaGlobal_MacroCheckQuiz_All:dataClear()
  audioPostEvent_SystemUi(8, 16)
  _AudioPostEvent_SystemUiForXBOX(8, 16)
  if true == isPhotoMode() and false == isPhotoModeIdle() then
    ToClient_InputPhotoModeFromLua()
  end
  ToClient_setDoingMacroCheckQuiz(true)
  PaGlobal_MacroCheckQuiz_All:questionSetting()
  Panel_MacroCheckQuiz_All:RegisterUpdateFunc("PaGlobalFunc_MacroCheckQuiz_PerFrame")
  PaGlobal_MacroCheckQuiz_All:open()
  PaGlobalFunc_MacroCheckQuiz_All_OnScreenResize()
end
function PaGlobal_MacroCheckQuiz_All:questionSetting()
  for btnIdx = 0, self._maxQuestionCount - 1 do
    local getType = ToClient_getSecureCodeQuestionType(btnIdx)
    self._ui.stc_AnswerPadTable[btnIdx]._txt_Question:SetText(self._string_QuizType[getType])
    self._ui.stc_AnswerPadTable[btnIdx]._rdo_Answer:addInputEvent("Mouse_LUp", "HandleEventLUp_MacroCheckQuiz_All_OpenNumPad(" .. btnIdx .. "," .. getType .. ")")
  end
end
function PaGlobal_MacroCheckQuiz_All:dataClear()
  self._logMessage = Array.new()
  self._currentTime = 0
  for btnIdx = 0, self._maxQuestionCount - 1 do
    self._ui.stc_AnswerPadTable[btnIdx]._rdo_Answer:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MACROCHECKQUIZ_QUIZ_INPUT_TEXT"))
    self._ui.stc_AnswerPadTable[btnIdx]._stc_AnswerBg:ResetAndClearVertexAni(true)
  end
  ToClient_setDoingMacroCheckQuiz(false)
  self._ui.stc_WarningBg:SetShow(true)
  self._ui.btn_Apply:SetShow(false)
end
function PaGlobal_MacroCheckQuiz_All:update()
  local answeredCount = 0
  for idx = 0, 2 do
    local answerString = self._ui.stc_AnswerPadTable[idx]._rdo_Answer:GetText()
    local defaultText = PAGetString(Defines.StringSheet_GAME, "LUA_MACROCHECKQUIZ_QUIZ_INPUT_TEXT")
    if nil ~= answerString and "" ~= answerString and defaultText ~= answerString then
      answeredCount = answeredCount + 1
    end
  end
  self._ui.stc_WarningBg:SetShow(answeredCount < 3)
  self._ui.btn_Apply:SetShow(self._maxQuestionCount == answeredCount)
end
function PaGlobal_MacroCheckQuiz_All:open()
  if nil == Panel_MacroCheckQuiz_All then
    return
  end
  Panel_MacroCheckQuiz_All:SetShow(true)
end
function PaGlobal_MacroCheckQuiz_All:prepareClose()
  if nil == Panel_MacroCheckQuiz_All then
    return
  end
  ToClient_setDoingMacroCheckQuiz(false)
  Panel_MacroCheckQuiz_All:ClearUpdateLuaFunc()
  PaGlobalFunc_MacroCheckNumPad_All_Close()
  PaGlobal_MacroCheckQuiz_All:close()
  ToClient_padSnapResetControl()
end
function PaGlobal_MacroCheckQuiz_All:close()
  if nil == Panel_MacroCheckQuiz_All then
    return
  end
  Panel_MacroCheckQuiz_All:SetShow(false)
end
function PaGlobal_MacroCheckQuiz_All:validate()
  if nil == Panel_MacroCheckQuiz_All then
    return
  end
  self._ui.stc_TitleArea:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.stc_BottomLine:isValidate()
  self._ui.txt_Question:isValidate()
  self._ui.txt_LeftTime:isValidate()
  self._ui.stc_ProgBg:isValidate()
  self._ui.prog2_LeftTime:isValidate()
  self._ui.stc_QuestionBg:isValidate()
  self._ui.stc_WarningBg:isValidate()
  self._ui.txt_CautionDesc:isValidate()
  self._ui.btn_Apply:isValidate()
  self._ui.stc_KeyGuideBg:isValidate()
  self._ui.stc_KeyGuideY:isValidate()
  for idx = 0, 2 do
    self._ui.stc_AnswerPadTable[idx]._bg:isValidate()
    self._ui.stc_AnswerPadTable[idx]._txt_Question:isValidate()
    self._ui.stc_AnswerPadTable[idx]._stc_AnswerBg:isValidate()
    self._ui.stc_AnswerPadTable[idx]._rdo_Answer:isValidate()
  end
end
