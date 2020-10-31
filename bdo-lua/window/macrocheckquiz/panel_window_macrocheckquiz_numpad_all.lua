PaGlobal_MacroCheckNumPad_All = {
  _ui = {
    stc_Display = nil,
    stc_CurrentQuiz = nil,
    btn_Close = nil,
    btn_Numbers = nil,
    btn_Back = nil,
    btn_Clear = nil,
    btn_Confirm = nil,
    btn_Cancel = nil,
    stc_Keyguide = nil,
    stc_Keyguide_A = nil,
    stc_Keyguide_B = nil
  },
  _config = {
    indexMax = 10,
    startX = 7,
    startY = 68,
    gapX = 67,
    gapY = 34,
    row = 4,
    column = 3
  },
  _maxPossibleInput = 6,
  _questionNumber = -1,
  _keyCount = 0,
  _currentAnswer = "",
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_MacroCheckNumPad_All")
function FromClient_MacroCheckNumPad_All()
  PaGlobal_MacroCheckNumPad_All:initialize()
end
function PaGlobal_MacroCheckNumPad_All:initialize()
  if true == PaGlobal_MacroCheckNumPad_All._initialize or nil == Panel_MacroCheckQuizPad_All or nil == Panel_MacroCheckQuiz_All then
    return
  end
  self._ui.stc_Display = UI.getChildControl(Panel_MacroCheckQuizPad_All, "Static_DisplayNumber")
  self._ui.stc_CurrentQuiz = UI.getChildControl(Panel_MacroCheckQuizPad_All, "StaticText_CurrentTypeName")
  self._ui.btn_Close = UI.getChildControl(Panel_MacroCheckQuizPad_All, "Button_Close")
  self._ui.btn_Back = UI.getChildControl(Panel_MacroCheckQuizPad_All, "Button_Back")
  self._ui.btn_Clear = UI.getChildControl(Panel_MacroCheckQuizPad_All, "Button_Clear")
  self._ui.btn_Confirm = UI.getChildControl(Panel_MacroCheckQuizPad_All, "Button_Confirm")
  self._ui.btn_Cancel = UI.getChildControl(Panel_MacroCheckQuizPad_All, "Button_Cancel")
  self._ui.stc_Keyguide = UI.getChildControl(Panel_MacroCheckQuizPad_All, "Static_BottomBg")
  self._ui.stc_Keyguide_A = UI.getChildControl(self._ui.stc_Keyguide, "StaticText_A_ConsoleUI")
  self._ui.stc_Keyguide_B = UI.getChildControl(self._ui.stc_Keyguide, "StaticText_B_ConsoleUI")
  self._ui.btn_Numbers = {}
  for idx = 0, self._config.indexMax - 1 do
    local tempTable = {displayedNum = "", control = ""}
    tempTable.displayedNum = idx
    tempTable.control = UI.getChildControl(Panel_MacroCheckQuizPad_All, "Button_" .. idx .. "_Import")
    self._ui.btn_Numbers[idx] = tempTable
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    self._ui.stc_Keyguide_B,
    self._ui.stc_Keyguide_A
  }, self._ui.stc_Keyguide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  PaGlobal_MacroCheckNumPad_All:validate()
  PaGlobal_MacroCheckNumPad_All:registEventHandler()
  PaGlobal_MacroCheckNumPad_All:swichPlatform()
  self._initialize = true
end
function PaGlobal_MacroCheckNumPad_All:registEventHandler()
  if nil == Panel_MacroCheckQuizPad_All then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    Panel_MacroCheckQuizPad_All:ignorePadSnapMoveToOtherPanel()
  end
  self._ui.btn_Clear:addInputEvent("Mouse_LUp", "HandleEventLUp_MacroCheckNumPad_All_Clear()")
  self._ui.btn_Back:addInputEvent("Mouse_LUp", "HandleEventLUp_MacroCheckNumPad_All_BackSpace()")
  self._ui.btn_Confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_MacroCheckNumPad_All_Confirm()")
  self._ui.btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_MacroCheckNumPad_All_Close()")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_MacroCheckNumPad_All_Close()")
end
function PaGlobal_MacroCheckNumPad_All:swichPlatform()
  self._ui.btn_Close:SetShow(not _ContentsGroup_UsePadSnapping)
  self._ui.stc_Keyguide:SetShow(_ContentsGroup_UsePadSnapping)
end
function PaGlobal_MacroCheckNumPad_All:prepareOpen(btnIdx, questionType)
  if nil == Panel_MacroCheckQuizPad_All then
    return
  end
  PaGlobal_MacroCheckNumPad_All:dataClear()
  PaGlobal_MacroCheckNumPad_All._questionNumber = btnIdx
  PaGlobal_MacroCheckNumPad_All:keyShuffle()
  if true == _ContentsGroup_UsePadSnapping then
    ToClient_padSnapSetTargetPanel(Panel_MacroCheckQuizPad_All)
  end
  for idx = 0, 2 do
    if idx ~= btnIdx then
      HandleEventLUp_MacroCheckQuiz_All_SetAniToCurrentBtn(idx, false)
    else
      HandleEventLUp_MacroCheckQuiz_All_SetAniToCurrentBtn(btnIdx, true)
    end
  end
  self._ui.stc_CurrentQuiz:SetText("")
  local curQuizString = PaGlobalFunc_MacroCheckQuiz_All_GetQuestion(questionType)
  self._ui.stc_CurrentQuiz:SetText(tostring(curQuizString))
  PaGlobal_MacroCheckNumPad_All:open()
end
function PaGlobal_MacroCheckNumPad_All:dataClear()
  self._currentAnswer = ""
  self._keyCount = 0
  self._ui.stc_Display:SetText("")
end
function PaGlobal_MacroCheckNumPad_All:keyShuffle()
  local rand = 0
  local posX = 0
  local posY = 0
  for idx = 0, self._config.indexMax - 1 do
    rand = getRandomValue(0, 9)
    local tempNumber = self._ui.btn_Numbers[idx].displayedNum
    self._ui.btn_Numbers[idx].displayedNum = self._ui.btn_Numbers[rand].displayedNum
    self._ui.btn_Numbers[rand].displayedNum = tempNumber
    posX = self._config.startX + self._config.gapX * (idx % self._config.column)
    posY = self._config.startY + self._config.gapY * math.floor(idx / self._config.column)
    self._ui.btn_Numbers[idx].control:SetPosX(posX)
    self._ui.btn_Numbers[idx].control:SetPosY(posY)
  end
  for idx = 0, self._config.indexMax - 1 do
    self._ui.btn_Numbers[idx].control:SetText(self._ui.btn_Numbers[idx].displayedNum)
    self._ui.btn_Numbers[idx].control:addInputEvent("Mouse_LUp", "HandleEventLUp_MacroCheckNumPad_All_NumClick(" .. self._ui.btn_Numbers[idx].displayedNum .. ")")
  end
end
function PaGlobal_MacroCheckNumPad_All:open()
  if nil == Panel_MacroCheckQuizPad_All then
    return
  end
  Panel_MacroCheckQuizPad_All:SetShow(true)
end
function PaGlobal_MacroCheckNumPad_All:prepareClose()
  if nil == Panel_MacroCheckQuizPad_All then
    return
  end
  if nil ~= PaGlobal_MacroCheckNumPad_All._questionNumber and (nil == PaGlobal_MacroCheckNumPad_All._currentAnswer or "" == PaGlobal_MacroCheckNumPad_All._currentAnswer or "" == PaGlobal_MacroCheckNumPad_All._ui.stc_Display:GetText() or nil == PaGlobal_MacroCheckNumPad_All._ui.stc_Display:GetText()) then
    PaGlobalFunc_MacroCheckQuiz_receiveAnswer(PaGlobal_MacroCheckNumPad_All._questionNumber, "")
  end
  HandleEventLUp_MacroCheckQuiz_All_SetAniToCurrentBtn(PaGlobal_MacroCheckNumPad_All._questionNumber, false)
  PaGlobal_MacroCheckNumPad_All._questionNumber = -1
  PaGlobal_MacroCheckNumPad_All:close()
end
function PaGlobal_MacroCheckNumPad_All:close()
  if nil == Panel_MacroCheckQuizPad_All then
    return
  end
  Panel_MacroCheckQuizPad_All:SetShow(false)
end
function PaGlobal_MacroCheckNumPad_All:validate()
  if nil == Panel_MacroCheckQuizPad_All then
    return
  end
  self._ui.stc_Display:isValidate()
  self._ui.stc_CurrentQuiz:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.btn_Back:isValidate()
  self._ui.btn_Clear:isValidate()
  self._ui.btn_Confirm:isValidate()
  self._ui.btn_Cancel:isValidate()
  self._ui.stc_Keyguide:isValidate()
  self._ui.stc_Keyguide_A:isValidate()
  self._ui.stc_Keyguide_B:isValidate()
  for idx = 0, 9 do
    self._ui.btn_Numbers[idx].control:isValidate()
  end
end
function PaGlobalFunc_MacroCheckNumPad_All_Open(btnIdx, questionType)
  if nil == questionType then
    return
  end
  PaGlobal_MacroCheckNumPad_All:prepareOpen(btnIdx, questionType)
end
function PaGlobalFunc_MacroCheckNumPad_All_Close()
  if nil == Panel_MacroCheckQuizPad_All then
    return
  end
  PaGlobal_MacroCheckNumPad_All:prepareClose()
end
function HandleEventLUp_MacroCheckNumPad_All_NumClick(num)
  if nil == num then
    return
  end
  if PaGlobal_MacroCheckNumPad_All._maxPossibleInput > string.len(PaGlobal_MacroCheckNumPad_All._currentAnswer) or PaGlobal_MacroCheckNumPad_All._keyCount < 0 then
    PaGlobal_MacroCheckNumPad_All._keyCount = PaGlobal_MacroCheckNumPad_All._keyCount + 1
    local inputNum = tostring(num)
    PaGlobal_MacroCheckNumPad_All._currentAnswer = PaGlobal_MacroCheckNumPad_All._currentAnswer .. inputNum
    PaGlobal_MacroCheckNumPad_All._ui.stc_Display:SetText(PaGlobal_MacroCheckNumPad_All._currentAnswer)
  end
end
function HandleEventLUp_MacroCheckNumPad_All_BackSpace()
  if 1 > PaGlobal_MacroCheckNumPad_All._keyCount then
    PaGlobal_MacroCheckNumPad_All:dataClear()
  else
    PaGlobal_MacroCheckNumPad_All._keyCount = PaGlobal_MacroCheckNumPad_All._keyCount - 1
    PaGlobal_MacroCheckNumPad_All._currentAnswer = string.sub(PaGlobal_MacroCheckNumPad_All._currentAnswer, 1, PaGlobal_MacroCheckNumPad_All._keyCount)
    PaGlobal_MacroCheckNumPad_All._ui.stc_Display:SetText(PaGlobal_MacroCheckNumPad_All._currentAnswer)
  end
end
function HandleEventLUp_MacroCheckNumPad_All_Clear()
  PaGlobal_MacroCheckNumPad_All:dataClear()
end
function HandleEventLUp_MacroCheckNumPad_All_Confirm()
  if nil == PaGlobal_MacroCheckNumPad_All._questionNumber or -1 == PaGlobal_MacroCheckNumPad_All._questionNumber then
    return
  end
  if PaGlobal_MacroCheckNumPad_All._currentAnswer ~= PaGlobal_MacroCheckNumPad_All._ui.stc_Display:GetText() then
    UI.ASSERT(false, "\235\132\152\235\178\132\237\140\168\235\147\156\236\151\144 \236\158\133\235\160\165\235\144\156 \235\139\181\236\149\136\234\179\188 \236\160\128\236\158\165\235\144\156 \235\139\181\236\149\136\236\157\180 \235\139\164\235\166\133\235\139\136\235\139\164.")
    return
  end
  PaGlobalFunc_MacroCheckQuiz_receiveAnswer(PaGlobal_MacroCheckNumPad_All._questionNumber, PaGlobal_MacroCheckNumPad_All._currentAnswer)
  PaGlobalFunc_MacroCheckNumPad_All_Close()
end
