function PaGlobalFunc_MacroCheckQuiz_All_OnScreenResize()
  if nil == Panel_MacroCheckQuiz_All then
    return
  end
  Panel_MacroCheckQuiz_All:ComputePos()
  PaGlobal_MacroCheckQuiz_All._ui.stc_KeyGuideBg:ComputePos()
end
function PaGlobalFunc_MacroCheckQuiz_All_Close()
  if nil == Panel_MacroCheckQuiz_All then
    return
  end
  PaGlobal_MacroCheckQuiz_All:prepareClose()
end
function PaGlobalFunc_MacroCheckQuiz_PerFrame(deltaT)
  if nil == Panel_MacroCheckQuiz_All or false == Panel_MacroCheckQuiz_All:GetShow() then
    return
  end
  PaGlobal_MacroCheckQuiz_All._currentTime = PaGlobal_MacroCheckQuiz_All._currentTime + deltaT
  local clockMinutes = tonumber(math.floor((PaGlobal_MacroCheckQuiz_All._limitTime - PaGlobal_MacroCheckQuiz_All._currentTime) / 60))
  local clockSeconds = tonumber(math.floor((PaGlobal_MacroCheckQuiz_All._limitTime - PaGlobal_MacroCheckQuiz_All._currentTime) % 60))
  if 9 < clockSeconds then
    PaGlobal_MacroCheckQuiz_All._ui.txt_LeftTime:SetText("0" .. clockMinutes .. " : " .. clockSeconds)
  else
    PaGlobal_MacroCheckQuiz_All._ui.txt_LeftTime:SetText("0" .. clockMinutes .. " : 0" .. clockSeconds)
  end
  local _last = (PaGlobal_MacroCheckQuiz_All._limitTime - PaGlobal_MacroCheckQuiz_All._currentTime) / 180 * 100
  PaGlobal_MacroCheckQuiz_All._ui.prog2_LeftTime:SetProgressRate(_last)
  if _last <= 0 then
    PaGlobal_MacroCheckQuiz_All:prepareClose()
  end
end
function FromClient_MacroCheckQuiz_All_TimeOver(name)
  local _sendToGMMessage = "PlayerName = " .. tostring(name) .. ",   Time Out"
  Proc_ShowMessage_Ack(_sendToGMMessage)
end
function FromClient_MacroCheckQuiz_All_receiveSecureCodeQuestion(name, isAdmin, type)
  PaGlobal_MacroCheckQuiz_All._playerName = tostring(name)
  if false == isAdmin then
    if true == PaGlobal_MacroCheckQuiz_All._isConsole then
      if nil ~= PaGlobalFunc_WorldMap_PopClose then
        PaGlobalFunc_WorldMap_PopClose()
      end
      PaGlobal_MacroCheckQuiz_All:prepareOpen()
      ToClient_padSnapSetTargetPanel(Panel_MacroCheckQuiz_All)
    else
      PaGlobal_MacroCheckQuiz_All:prepareOpen()
    end
  else
    Proc_ShowMessage_Ack(" GM Send the MacroCheckQuiz to ' " .. tostring(name) .. " '")
  end
end
function FromClient_MacroCheckQuiz_All_receiveResult(isCorrect, type, value, correctAnswer)
  local _typName = PaGlobal_MacroCheckQuiz_All._string_QuizType[type]
  local log = "Player Name = " .. tostring(PaGlobal_MacroCheckQuiz_All._playerName) .. " IsCorrect = " .. tostring(isCorrect) .. " QuestionType = " .. tostring(_typName) .. " UserAnswer = " .. tostring(value) .. " CorrectAnswer = " .. tostring(correctAnswer)
  PaGlobal_MacroCheckQuiz_All._messageNo = PaGlobal_MacroCheckQuiz_All._messageNo + 1
  PaGlobal_MacroCheckQuiz_All._logMessage[PaGlobal_MacroCheckQuiz_All._messageNo] = log
  if __eSecureCodeQuestion_TotalCount == #PaGlobal_MacroCheckQuiz_All._logMessage then
    PaGlobal_MacroCheckQuiz_All_SendGMtoMsg()
  end
end
function PaGlobal_MacroCheckQuiz_All_SendGMtoMsg()
  local _sendToGMMessage = ""
  for idx = 1, PaGlobal_MacroCheckQuiz_All._maxQuestionCount do
    _sendToGMMessage = tostring(_sendToGMMessage .. PaGlobal_MacroCheckQuiz_All._logMessage[idx] .. "\n")
  end
  Proc_ShowMessage_Ack(_sendToGMMessage)
  PaGlobal_MacroCheckQuiz_All._messageNo = 0
  PaGlobal_MacroCheckQuiz_All._logMessage = {}
end
function PaGlobalFunc_MacroCheckQuiz_All_GetQuestion(idx)
  if nil == idx or false == Panel_MacroCheckQuiz_All:GetShow() then
    return ""
  end
  return PaGlobal_MacroCheckQuiz_All._string_QuizType[idx]
end
function HandleEventLUp_MacroCheckQuiz_All_OpenNumPad(btnIdx, questionType)
  if nil == btnIdx or nil == questionType then
    return
  end
  for idx = 0, 2 do
    if idx == btnIdx then
      PaGlobal_MacroCheckQuiz_All._ui.stc_AnswerPadTable[idx]._rdo_Answer:SetText("")
    else
      local getText = PaGlobal_MacroCheckQuiz_All._ui.stc_AnswerPadTable[idx]._rdo_Answer:GetText()
      local defaultText = PAGetString(Defines.StringSheet_GAME, "LUA_MACROCHECKQUIZ_QUIZ_INPUT_TEXT")
      if "" == getText then
        PaGlobal_MacroCheckQuiz_All._ui.stc_AnswerPadTable[idx]._rdo_Answer:SetText(defaultText)
      end
    end
  end
  PaGlobalFunc_MacroCheckNumPad_All_Open(btnIdx, questionType)
end
function PaGlobalFunc_MacroCheckQuiz_receiveAnswer(btnIdx, string)
  if nil == btnIdx or nil == string then
    return
  end
  if true == PaGlobal_MacroCheckQuiz_All._isConsole then
    ToClient_padSnapSetTargetPanel(Panel_MacroCheckQuiz_All)
  end
  if "" == string then
    string = PAGetString(Defines.StringSheet_GAME, "LUA_MACROCHECKQUIZ_QUIZ_INPUT_TEXT")
  end
  if nil ~= PaGlobal_MacroCheckQuiz_All._ui.stc_AnswerPadTable[btnIdx] then
    PaGlobal_MacroCheckQuiz_All._ui.stc_AnswerPadTable[btnIdx]._rdo_Answer:SetText(string)
    PaGlobal_MacroCheckQuiz_All:update()
  end
end
function HandleEventLUp_MacroCheckQuiz_All_SendAnswer()
  if false == Panel_MacroCheckQuiz_All:GetShow() then
    return
  end
  for idx = 0, 2 do
    local answerString = PaGlobal_MacroCheckQuiz_All._ui.stc_AnswerPadTable[idx]._rdo_Answer:GetText()
    local defaultText = PAGetString(Defines.StringSheet_GAME, "LUA_MACROCHECKQUIZ_QUIZ_INPUT_TEXT")
    local finalAnswer = 0
    if nil ~= answerString and "" ~= answerString and defaultText ~= answerString then
      finalAnswer = tonumber(answerString)
    end
    ToClient_setSecureCodeAnswer(idx, finalAnswer)
  end
  ToClient_sendSecureCodeAnswer()
  local _sendToPlayermessage = PAGetString(Defines.StringSheet_GAME, "LUA_MACROCHECKQUIZ_QUIZ_FEEDBACK_TEXT")
  Proc_ShowMessage_Ack(_sendToPlayermessage)
  PaGlobal_MacroCheckQuiz_All:prepareClose()
end
function HandleEventLUp_MacroCheckQuiz_All_SetAniToCurrentBtn(idx, show)
  if nil == idx or nil == PaGlobal_MacroCheckQuiz_All._ui.stc_AnswerPadTable[idx] then
    return
  end
  if true == show then
    PaGlobal_MacroCheckQuiz_All._ui.stc_AnswerPadTable[idx]._stc_AnswerBg:SetVertexAniRun("Ani_Color", true)
  else
    PaGlobal_MacroCheckQuiz_All._ui.stc_AnswerPadTable[idx]._stc_AnswerBg:ResetAndClearVertexAni(true)
  end
end
function FromClient_MacroCheckQuiz_All_receiveSecureCodeAnswer(correctCount, name)
  PaGlobal_MacroCheckQuiz_All._playerName = name
end
