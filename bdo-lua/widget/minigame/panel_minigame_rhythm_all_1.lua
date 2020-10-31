function PaGlobal_MiniGame_Rhythm_All:initialize()
  if nil == Panel_MiniGame_Rhythm_All or true == PaGlobal_MiniGame_Rhythm_All._initialize then
    return
  end
  PaGlobal_MiniGame_Rhythm_All._ui.stc_rhythmBG = UI.getChildControl(Panel_MiniGame_Rhythm_All, "Static_rhythmBG")
  PaGlobal_MiniGame_Rhythm_All._ui.stc_rhythmNote = UI.getChildControl(Panel_MiniGame_Rhythm_All, "Static_rhythmNote")
  PaGlobal_MiniGame_Rhythm_All._ui.stc_rhythmCursor = UI.getChildControl(Panel_MiniGame_Rhythm_All, "Static_rhythmCursor")
  PaGlobal_MiniGame_Rhythm_All._ui.stc_mouseBody_L = UI.getChildControl(Panel_MiniGame_Rhythm_All, "Static_MouseBody_L")
  PaGlobal_MiniGame_Rhythm_All._ui.stc_mouseBody_R = UI.getChildControl(Panel_MiniGame_Rhythm_All, "Static_MouseBody_R")
  PaGlobal_MiniGame_Rhythm_All._ui.stc_mouseLeft_L = UI.getChildControl(PaGlobal_MiniGame_Rhythm_All._ui.stc_mouseBody_L, "Static_L_Btn_L")
  PaGlobal_MiniGame_Rhythm_All._ui.stc_mouseLeft_R = UI.getChildControl(PaGlobal_MiniGame_Rhythm_All._ui.stc_mouseBody_L, "Static_L_Btn_R")
  PaGlobal_MiniGame_Rhythm_All._ui.stc_mouseRight_L = UI.getChildControl(PaGlobal_MiniGame_Rhythm_All._ui.stc_mouseBody_R, "Static_R_Btn_L")
  PaGlobal_MiniGame_Rhythm_All._ui.stc_mouseRight_R = UI.getChildControl(PaGlobal_MiniGame_Rhythm_All._ui.stc_mouseBody_R, "Static_R_Btn_R")
  PaGlobal_MiniGame_Rhythm_All._ui.stc_keyguideBG = UI.getChildControl(Panel_MiniGame_Rhythm_All, "Static_Console_Control_BG")
  PaGlobal_MiniGame_Rhythm_All._ui.txt_purposeText = UI.getChildControl(Panel_MiniGame_Rhythm_All, "StaticText_Purpose")
  PaGlobal_MiniGame_Rhythm_All._ui.stc_resultGood = UI.getChildControl(Panel_MiniGame_Rhythm_All, "Static_Result_Good")
  PaGlobal_MiniGame_Rhythm_All._ui.stc_resultBad = UI.getChildControl(Panel_MiniGame_Rhythm_All, "Static_Result_Bad")
  PaGlobal_MiniGame_Rhythm_All._ui.stc_rhythmNote:SetShow(false)
  for idx = 1, PaGlobal_MiniGame_Rhythm_All._bufferMax do
    local control = UI.createControl(__ePAUIControl_Static, Panel_MiniGame_Rhythm_All, "Static_rhythmNote_" .. idx)
    CopyBaseProperty(PaGlobal_MiniGame_Rhythm_All._ui.stc_rhythmNote, control)
    control:SetShow(false)
    PaGlobal_MiniGame_Rhythm_All._noteBuffer[idx] = control
  end
  PaGlobal_MiniGame_Rhythm_All._cursorStartPos = PaGlobal_MiniGame_Rhythm_All._ui.stc_rhythmCursor:GetPosX()
  PaGlobal_MiniGame_Rhythm_All._isConsole = _ContentsGroup_UsePadSnapping
  if true == PaGlobal_MiniGame_Rhythm_All._isConsole then
    PaGlobal_MiniGame_Rhythm_All._ui.stc_mouseBody_L:SetShow(false)
    PaGlobal_MiniGame_Rhythm_All._ui.stc_mouseBody_R:SetShow(false)
    PaGlobal_MiniGame_Rhythm_All._ui.stc_keyguideBG:SetShow(true)
  else
    PaGlobal_MiniGame_Rhythm_All._ui.stc_mouseBody_L:SetShow(true)
    PaGlobal_MiniGame_Rhythm_All._ui.stc_mouseBody_R:SetShow(true)
    PaGlobal_MiniGame_Rhythm_All._ui.stc_keyguideBG:SetShow(false)
  end
  PaGlobal_MiniGame_Rhythm_All:registerEventHandler()
  PaGlobal_MiniGame_Rhythm_All:validate()
  PaGlobal_MiniGame_Rhythm_All._initialize = true
end
function PaGlobal_MiniGame_Rhythm_All:registerEventHandler()
  if nil == Panel_MiniGame_Rhythm_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Minigame_Rhythm_All_OnScreenSize")
  if true == PaGlobal_MiniGame_Rhythm_All._isConsole then
    registerEvent("EventActionMiniGamePadDownOnce", "FromClient_Minigame_Rhythm_All_KeyPress")
  end
end
function PaGlobal_MiniGame_Rhythm_All:prepareOpen()
  if nil == Panel_MiniGame_Rhythm_All then
    return
  end
  if true == PaGlobal_MiniGame_Rhythm_All._isConsole then
    PaGlobal_ConsoleQuickMenu:widgetClose()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  Panel_MiniGame_Rhythm_All:RegisterUpdateFunc("Panel_Minigame_UpdateFunc")
  FromClient_Minigame_Rhythm_All_OnScreenSize()
  PaGlobal_MiniGame_Rhythm_All:open()
end
function PaGlobal_MiniGame_Rhythm_All:open()
  if nil == Panel_MiniGame_Rhythm_All or true == Panel_MiniGame_Rhythm_All:GetShow() then
    return
  end
  Panel_MiniGame_Rhythm_All:SetShow(true)
end
function PaGlobal_MiniGame_Rhythm_All:prepareClose()
  if nil == Panel_MiniGame_Rhythm_All or false == Panel_MiniGame_Rhythm_All:GetShow() then
    return
  end
  if true == PaGlobal_MiniGame_Rhythm_All._isConsole then
    PaGlobal_ConsoleQuickMenu:widgetOpen()
  end
  Panel_MiniGame_Rhythm_All:ClearUpdateLuaFunc()
  PaGlobal_MiniGame_Rhythm_All:close()
end
function PaGlobal_MiniGame_Rhythm_All:close()
  if nil == Panel_MiniGame_Rhythm_All or false == Panel_MiniGame_Rhythm_All:GetShow() then
    return
  end
  Panel_MiniGame_Rhythm_All:SetShow(false)
end
function PaGlobal_MiniGame_Rhythm_All:rhythmCursorAlign()
  if nil == Panel_MiniGame_Rhythm_All then
    return
  end
  local lineSize = PaGlobal_MiniGame_Rhythm_All._ui.stc_rhythmBG:GetSizeX() / PaGlobal_MiniGame_Rhythm_All._lineCount
  PaGlobal_MiniGame_Rhythm_All._ui.stc_rhythmCursor:SetPosX(PaGlobal_MiniGame_Rhythm_All._ui.stc_rhythmBG:GetPosX() + lineSize * PaGlobal_MiniGame_Rhythm_All._cursorIndex - PaGlobal_MiniGame_Rhythm_All._cursorFixedValue)
end
function PaGlobal_MiniGame_Rhythm_All:getRhythm()
  if nil == Panel_MiniGame_Rhythm_All then
    return
  end
  local prevIndex = PaGlobal_MiniGame_Rhythm_All._bufferIndex
  PaGlobal_MiniGame_Rhythm_All._bufferIndex = PaGlobal_MiniGame_Rhythm_All._bufferIndex + 1
  if PaGlobal_MiniGame_Rhythm_All._bufferMax < PaGlobal_MiniGame_Rhythm_All._bufferIndex then
    PaGlobal_MiniGame_Rhythm_All._bufferIndex = 1
  end
  local rv = PaGlobal_MiniGame_Rhythm_All._noteBuffer[prevIndex]
  PaGlobal_MiniGame_Rhythm_All._notePosBuffer[prevIndex] = math.random(1, 5)
  PaGlobal_MiniGame_Rhythm_All:posSetting(rv, PaGlobal_MiniGame_Rhythm_All._notePosBuffer[prevIndex])
  return rv
end
function PaGlobal_MiniGame_Rhythm_All:posSetting(control, index)
  CopyBaseProperty(PaGlobal_MiniGame_Rhythm_All._ui.stc_rhythmNote, control)
  local lineSize = PaGlobal_MiniGame_Rhythm_All._ui.stc_rhythmBG:GetSizeX() / PaGlobal_MiniGame_Rhythm_All._lineCount
  local centerPos = PaGlobal_MiniGame_Rhythm_All._ui.stc_rhythmBG:GetPosX() + PaGlobal_MiniGame_Rhythm_All._ui.stc_rhythmBG:GetSizeX() / 2 - control:GetSizeX() / 2 - 2
  if index == 1 then
    control:SetPosX(centerPos - lineSize * 2)
  elseif index == 2 then
    control:SetPosX(centerPos - lineSize)
  elseif index == 3 then
    control:SetPosX(centerPos)
  elseif index == 4 then
    control:SetPosX(centerPos + lineSize)
  elseif index == 5 then
    control:SetPosX(centerPos + lineSize * 2)
  end
end
function PaGlobal_MiniGame_Rhythm_All:questCheck()
  for index = 0, #PaGlobal_MiniGame_Rhythm_All._rhythmQuestList do
    if questList_hasProgressQuest(PaGlobal_MiniGame_Rhythm_All._rhythmQuestList[index].questGroup, PaGlobal_MiniGame_Rhythm_All._rhythmQuestList[index].questId) then
      return true
    end
  end
  return false
end
function PaGlobal_MiniGame_Rhythm_All:validate()
  if nil == Panel_MiniGame_Rhythm_All then
    return
  end
  PaGlobal_MiniGame_Rhythm_All._ui.stc_rhythmBG:isValidate()
  PaGlobal_MiniGame_Rhythm_All._ui.stc_rhythmNote:isValidate()
  PaGlobal_MiniGame_Rhythm_All._ui.stc_rhythmCursor:isValidate()
  PaGlobal_MiniGame_Rhythm_All._ui.stc_mouseBody_L:isValidate()
  PaGlobal_MiniGame_Rhythm_All._ui.stc_mouseBody_R:isValidate()
  PaGlobal_MiniGame_Rhythm_All._ui.stc_keyguideBG:isValidate()
  PaGlobal_MiniGame_Rhythm_All._ui.txt_purposeText:isValidate()
  PaGlobal_MiniGame_Rhythm_All._ui.stc_resultGood:isValidate()
  PaGlobal_MiniGame_Rhythm_All._ui.stc_resultBad:isValidate()
end
