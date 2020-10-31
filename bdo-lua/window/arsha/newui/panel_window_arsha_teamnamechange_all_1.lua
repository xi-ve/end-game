function PaGlobal_Arsha_TeamNameChange_All:initialize()
  if true == PaGlobal_Arsha_TeamNameChange_All._initialize or nil == Panel_Window_Arsha_TeamNameChange_All then
    return
  end
  self._ui.stc_titleArea = UI.getChildControl(Panel_Window_Arsha_TeamNameChange_All, "Static_TitleArea")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_titleArea, "StaticText_Title")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleArea, "Button_Close")
  self._ui.stc_subFrameBg = UI.getChildControl(Panel_Window_Arsha_TeamNameChange_All, "Static_SubFrameBg")
  self._ui.txt_explain = UI.getChildControl(Panel_Window_Arsha_TeamNameChange_All, "StaticText_Explain")
  self._ui.txt_teamA = UI.getChildControl(Panel_Window_Arsha_TeamNameChange_All, "StaticText_ATeam")
  self._ui.edit_teamA = UI.getChildControl(Panel_Window_Arsha_TeamNameChange_All, "Edit_TeamA_Name")
  self._ui.txt_teamB = UI.getChildControl(Panel_Window_Arsha_TeamNameChange_All, "StaticText_BTeam")
  self._ui.edit_teamB = UI.getChildControl(Panel_Window_Arsha_TeamNameChange_All, "Edit_TeamB_Name")
  self._ui.btn_confirm = UI.getChildControl(Panel_Window_Arsha_TeamNameChange_All, "Button_Admin")
  self._ui.txt_teamA:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_A_TEAM"))
  self._ui.txt_teamB:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_B_TEAM"))
  self._ui_console.stc_keyGuideBg = UI.getChildControl(Panel_Window_Arsha_TeamNameChange_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console.txt_keyGuideY = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Y_ConsoleUI")
  self._ui_console.txt_keyGuideA = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_A_ConsoleUI")
  self._ui_console.txt_keyGuideB = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_B_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Arsha_TeamNameChange_All:validate()
  PaGlobal_Arsha_TeamNameChange_All:registEventHandler()
  PaGlobal_Arsha_TeamNameChange_All:swichPlatform(self._isConsole)
  PaGlobal_Arsha_TeamNameChange_All._initialize = true
end
function PaGlobal_Arsha_TeamNameChange_All:swichPlatform(isConsole)
  if nil == Panel_Window_Arsha_TeamNameChange_All then
    return
  end
  self._ui.btn_close:SetShow(not isConsole)
  self._ui.btn_confirm:SetShow(not isConsole)
  self._ui_console.stc_keyGuideBg:SetShow(isConsole)
  if true == isConsole then
    Panel_Window_Arsha_TeamNameChange_All:SetSize(Panel_Window_Arsha_TeamNameChange_All:GetSizeX(), self._ui.stc_titleArea:GetSizeY() + self._ui.stc_subFrameBg:GetSizeY())
    self._ui_console.stc_keyGuideBg:ComputePos()
    self:setAlignKeyGuide()
  end
end
function PaGlobal_Arsha_TeamNameChange_All:prepareOpen(editTeamIdx)
  if nil == Panel_Window_Arsha_TeamNameChange_All then
    return
  end
  local teamA_Info = ToClient_GetTeamListAt(0)
  local teamB_Info = ToClient_GetTeamListAt(1)
  local teamA_Name = ""
  local teamB_Name = ""
  if nil ~= teamA_Info and nil ~= teamB_Info then
    teamA_Name = teamA_Info:getTeamName()
    teamB_Name = teamB_Info:getTeamName()
  end
  if "" == teamA_Name or "" == teamB_Name then
    teamA_Name = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_A")
    teamB_Name = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_B")
  end
  self._ui.edit_teamA:SetEditText(teamA_Name)
  self._ui.edit_teamB:SetEditText(teamB_Name)
  if 1 == editTeamIdx then
    SetFocusEdit(self._ui.edit_teamA)
  elseif 2 == editTeamIdx then
    SetFocusEdit(self._ui.edit_teamB)
  end
  PaGlobal_Arsha_TeamNameChange_All:open()
  PaGlobal_Arsha_TeamNameChange_All:resize()
end
function PaGlobal_Arsha_TeamNameChange_All:dataclear()
  if nil == Panel_Window_Arsha_TeamNameChange_All then
    return
  end
  self._ui.edit_teamA:SetEditText("")
  self._ui.edit_teamB:SetEditText("")
end
function PaGlobal_Arsha_TeamNameChange_All:open()
  if nil == Panel_Window_Arsha_TeamNameChange_All then
    return
  end
  Panel_Window_Arsha_TeamNameChange_All:SetShow(true)
end
function PaGlobal_Arsha_TeamNameChange_All:prepareClose()
  if nil == Panel_Window_Arsha_TeamNameChange_All then
    return
  end
  self:dataclear()
  PaGlobal_Arsha_TeamNameChange_All:close()
end
function PaGlobal_Arsha_TeamNameChange_All:close()
  if nil == Panel_Window_Arsha_TeamNameChange_All then
    return
  end
  Panel_Window_Arsha_TeamNameChange_All:SetShow(false)
end
function PaGlobal_Arsha_TeamNameChange_All:setAlignKeyGuide()
  local keyGuides = {
    PaGlobal_Arsha_TeamNameChange_All._ui_console.txt_keyGuideY,
    PaGlobal_Arsha_TeamNameChange_All._ui_console.txt_keyGuideA,
    PaGlobal_Arsha_TeamNameChange_All._ui_console.txt_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_Arsha_TeamNameChange_All._ui_console.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Arsha_TeamNameChange_All:confirm()
  if nil == Panel_Window_Arsha_TeamNameChange_All then
    return
  end
  local nameA = self._ui.edit_teamA:GetEditText()
  local nameB = self._ui.edit_teamB:GetEditText()
  ToClient_changeTeamName(nameA, nameB)
  local teamA_Info = ToClient_GetTeamListAt(0)
  local teamB_Info = ToClient_GetTeamListAt(1)
  if teamA_Info == nil or teamB_Info == nil then
    PaGlobalFunc_Arsha_TeamNameChange_All_Close()
    return
  end
  PaGlobalFunc_Arsha_TeamNameChange_All_Close()
end
function PaGlobal_Arsha_TeamNameChange_All:registEventHandler()
  if nil == Panel_Window_Arsha_TeamNameChange_All then
    return
  end
  if true == self._isConsole then
    Panel_Window_Arsha_TeamNameChange_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Arsha_TeamNameChange_All_Confirm()")
    Panel_Window_Arsha_TeamNameChange_All:ignorePadSnapMoveToOtherPanel()
    self._ui.edit_teamA:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_Arsha_TeamNameChange_All_VirtualKeyboardEnd_A")
    self._ui.edit_teamB:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_Arsha_TeamNameChange_All_VirtualKeyboardEnd_B")
  else
    self._ui.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_TeamNameChange_All_Close()")
    self._ui.btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_TeamNameChange_All_Confirm()")
  end
end
function PaGlobal_Arsha_TeamNameChange_All:validate()
  if nil == Panel_Window_Arsha_TeamNameChange_All then
    return
  end
  self._ui.stc_titleArea:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_subFrameBg:isValidate()
  self._ui.txt_explain:isValidate()
  self._ui.txt_teamA:isValidate()
  self._ui.edit_teamA:isValidate()
  self._ui.txt_teamB:isValidate()
  self._ui.edit_teamB:isValidate()
  self._ui.btn_confirm:isValidate()
  self._ui_console.stc_keyGuideBg:isValidate()
  self._ui_console.txt_keyGuideY:isValidate()
  self._ui_console.txt_keyGuideA:isValidate()
  self._ui_console.txt_keyGuideB:isValidate()
end
function PaGlobal_Arsha_TeamNameChange_All:resize()
  if nil == Panel_Window_Arsha_TeamNameChange_All then
    return
  end
  Panel_Window_Arsha_TeamNameChange_All:ComputePos()
end
