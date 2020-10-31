function PaGlobal_LoginPassword_All:initialize()
  if true == PaGlobal_LoginPassword_All._initialize then
    return
  end
  Panel_Login_Password_All:SetShow(false, false)
  Panel_Login_Password_All:setGlassBackground(true)
  local _titleGroup = UI.getChildControl(Panel_Login_Password_All, "Static_TitleGroup")
  self._ui._txt_titleImport = UI.getChildControl(_titleGroup, "Static_Text_Title_Import")
  local noPadBg = UI.getChildControl(Panel_Login_Password_All, "Static_NoPadBG")
  local displayArea = UI.getChildControl(noPadBg, "Static_DisplayArea")
  self._ui._txt_displayNum = UI.getChildControl(displayArea, "StaticText_DisplayNum")
  self._ui._chk_showNum = UI.getChildControl(displayArea, "CheckButton_ShowNum")
  self._ui._btn_backImport = UI.getChildControl(noPadBg, "Button_Back_Import")
  self._ui._btn_clearImport = UI.getChildControl(noPadBg, "Button_Clear_Import")
  self._ui._btn_applyImport = UI.getChildControl(Panel_Login_Password_All, "Button_Apply_Import")
  self._ui._btn_cancelImport = UI.getChildControl(Panel_Login_Password_All, "Button_Cancel_Import")
  self._ui._btn_numSlots = {}
  for i = 0, self._numSlotMax - 1 do
    local num = {}
    num.index = i
    num.button = UI.getChildControl(noPadBg, "Button_" .. i .. "_Import")
    if true == _ContentsGroup_UsePadSnapping then
      num.button:registerPadEvent(__eConsoleUIPadEvent_A, "HandleEventLDown_LoginPassword_All_NumBtnTextUpdate(" .. i .. ")")
      num.button:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_LoginPassword_All_NumBtnInput(" .. i .. ")")
    else
      num.button:addInputEvent("Mouse_LUp", "HandleEventLUp_LoginPassword_All_NumBtnInput(" .. i .. ")")
      num.button:addInputEvent("Mouse_LDown", "HandleEventLDown_LoginPassword_All_NumBtnTextUpdate(" .. i .. ")")
    end
    num.button:addInputEvent("Mouse_Out", "HandleEventOut_LoginPasseword_All_NumBtnTextUpdate(" .. i .. ")")
    num.button:SetAutoDisableTime(0)
    num.baseText = tostring(i)
    UI.ASSERT(nil ~= num.button and "number" ~= type(num.button), "Button_" .. i .. "_Import")
    self._ui._btn_numSlots[i] = num
  end
  self._ui._btn_backImport:SetAutoDisableTime(0)
  self._ui._btn_applyImport:ActiveMouseEventEffect(true)
  self._ui._btn_cancelImport:ActiveMouseEventEffect(true)
  PaGlobal_LoginPassword_All:registEventHandler()
  PaGlobal_LoginPassword_All:validate()
  PaGlobal_LoginPassword_All._initialize = true
end
function PaGlobal_LoginPassword_All:registEventHandler()
  if nil == Panel_Login_Password_All then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._btn_backImport:addInputEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_LoginPassword_All_Back()")
    self._ui._btn_clearImport:addInputEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_LoginPassword_All_Clear()")
    self._ui._btn_applyImport:addInputEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_LoginPassword_All_Apply()")
    self._ui._btn_cancelImport:addInputEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_LoginPassword_All_Cancel()")
    self._ui._chk_showNum:addInputEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_LoginPassword_All_ShowNum()")
  else
    self._ui._btn_backImport:addInputEvent("Mouse_LUp", "HandleEventLUp_LoginPassword_All_Back()")
    self._ui._btn_clearImport:addInputEvent("Mouse_LUp", "HandleEventLUp_LoginPassword_All_Clear()")
    self._ui._btn_applyImport:addInputEvent("Mouse_LUp", "HandleEventLUp_LoginPassword_All_Apply()")
    self._ui._btn_cancelImport:addInputEvent("Mouse_LUp", "HandleEventLUp_LoginPassword_All_Cancel()")
    self._ui._chk_showNum:addInputEvent("Mouse_LUp", "HandleEventLUp_LoginPassword_All_ShowNum()")
  end
  self._ui._chk_showNum:addInputEvent("Mouse_On", "HandleEventOnOut_LoginPassword_All_ShowPasswordTooltip(true)")
  self._ui._chk_showNum:addInputEvent("Mouse_Out", "HandleEventOnOut_LoginPassword_All_ShowPasswordTooltip(false)")
  registerEvent("EventOpenPassword", "FromClient_LoginPassword_All_OpenPassword")
end
function PaGlobal_LoginPassword_All:prepareOpen(isCreatePassword)
  if nil == Panel_Login_Password_All then
    return
  end
  if true == _ContentsGroup_NewUI_Login_All then
    PaGlobal_LoginNickname_All_Close()
  else
    LoginNickname_Close()
  end
  if not lobbyPassword_UsePassword() then
    loginToGame()
    return
  end
  if isGameServiceTypeDev() and ToClient_UseConfigPassword() then
    loginToGame()
    return
  end
  lobbyPassword_ClearIndexString(true)
  lobbyPassword_ClearIndexString(false)
  if true == isCreatePassword then
    self._stateType = self._state._type_CreatePassword
    self._ui._txt_titleImport:SetText(PAGetString(Defines.StringSheet_GAME, "SECONDARYPASSWORD_CREATE"))
  else
    self._stateType = self._state._type_Authentic
    self._ui._txt_titleImport:SetText(PAGetString(Defines.StringSheet_GAME, "SECONDARYPASSWORD_INPUT"))
  end
  self:initSuffle()
  self:updatePassward()
  PaGlobal_Login_All_LoginButtonDisable(true)
  PaGlobal_LoginPassword_All:open()
end
function PaGlobal_LoginPassword_All:open()
  if nil == Panel_Login_Password_All then
    return
  end
  Panel_Login_Password_All:SetShow(true)
end
function PaGlobal_LoginPassword_All:prepareClose()
  if nil == Panel_Login_Password_All then
    return
  end
  lobbyPassword_ClearIndexString(true)
  lobbyPassword_ClearIndexString(false)
  PaGlobal_Login_All_LoginButtonDisable(false)
  TooltipSimple_Hide()
  PaGlobal_LoginPassword_All:close()
end
function PaGlobal_LoginPassword_All:close()
  if nil == Panel_Login_Password_All then
    return
  end
  Panel_Login_Password_All:SetShow(false)
end
function PaGlobal_LoginPassword_All:update()
  if nil == Panel_Login_Password_All then
    return
  end
end
function PaGlobal_LoginPassword_All:validate()
  if nil == Panel_Login_Password_All then
    return
  end
end
function PaGlobal_LoginPassword_All:initSuffle()
  for i = 0, self._numSlotMax - 1 do
    local shuffleIndex = lobbyPassword_getShuffleIndex(i)
    self._ui._btn_numSlots[i].index = shuffleIndex
    local baseText = tostring(shuffleIndex)
    self._ui._btn_numSlots[i].baseText = baseText
    self._ui._btn_numSlots[i].button:SetText(baseText)
  end
end
function PaGlobal_LoginPassword_All:updateButtonTextAll(isShow)
  for i = 0, self._numSlotMax - 1 do
    self:updateButtonText(i, isShow)
  end
end
function PaGlobal_LoginPassword_All:updateButtonText(index, isShow)
  if true == isShow then
    self._ui._btn_numSlots[index].button:SetText(self._ui._btn_numSlots[index].baseText)
  else
    self._ui._btn_numSlots[index].button:SetText("")
  end
end
function PaGlobal_LoginPassword_All:updatePassward()
  self._ui._txt_displayNum:SetText(lobbyPassword_GetIndexString(not self._ui._chk_showNum:IsCheck(), self:isStateTypeReconfirm()))
end
function PaGlobal_LoginPassword_All:showPasswardTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local desc = ""
  if self._ui._chk_showNum:IsCheck() then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PASSWORD_HIDENUMBER")
  else
    desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PASSWORD_SHOWNUMBER")
  end
  TooltipSimple_Show(self._ui._chk_showNum, desc)
end
function PaGlobal_LoginPassword_All:isStateTypeReconfirm()
  return self._state._type_Reconfirm == self._stateType
end
function PaGlobal_LoginPassword_All:Apply()
  if not lobbyPassword_checkPasswordLength(self:isStateTypeReconfirm()) then
    return
  end
  if self._state._type_CreatePassword == self._stateType then
    self._stateType = self._state._type_Reconfirm
    self._ui._txt_titleImport:SetText(PAGetString(Defines.StringSheet_GAME, "SECONDARYPASSWORD_IDENTIFY"))
    self:updatePassward()
    return
  end
  if self._state._type_Reconfirm == self._stateType and not lobbyPassword_isEqualPassword() then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "SECONDARYPASSWORD_DIFFERENCE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "SECONDARYPASSWORD_NOTICE"),
      content = messageBoxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    self:prepareOpen(true)
    return
  end
  loginToGame()
  self:prepareClose()
end
