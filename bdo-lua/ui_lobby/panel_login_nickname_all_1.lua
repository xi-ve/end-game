function PaGlobal_LoginNickname_All:initialize()
  if true == PaGlobal_LoginNickname_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.btn_Apply = UI.getChildControl(Panel_Login_Nickname_All, "Button_Apply_Import")
  self._ui.edit_Nickname = UI.getChildControl(Panel_Login_Nickname_All, "Edit_Nickname")
  self._ui.txt_Desc_1 = UI.getChildControl(Panel_Login_Nickname_All, "StaticText_1")
  self._ui.txt_Desc_2 = UI.getChildControl(Panel_Login_Nickname_All, "StaticText_2")
  self._ui.txt_Desc_3 = UI.getChildControl(Panel_Login_Nickname_All, "StaticText_3")
  self._ui.stc_Illust = UI.getChildControl(Panel_Login_Nickname_All, "Static_Illust")
  self._ui.stc_consoleKeyGuide = UI.getChildControl(Panel_Login_Nickname_All, "Static_KeyGuide_ConsoleUI")
  self._ui.txt_targetEditKey = UI.getChildControl(self._ui.edit_Nickname, "StaticText_Confirm_ConsoleUI")
  self._ui.txt_confirmKey = UI.getChildControl(self._ui.stc_consoleKeyGuide, "StaticText_ChangeName_ConsoleUI")
  self._defaultEditSizeX = self._ui.edit_Nickname:GetSizeX()
  PaGlobal_LoginNickname_All:initData()
  PaGlobal_LoginNickname_All:registEventHandler()
  PaGlobal_LoginNickname_All:validate()
  PaGlobal_LoginNickname_All._initialize = true
end
function PaGlobal_LoginNickname_All:registEventHandler()
  if nil == Panel_Login_Nickname_All then
    return
  end
  registerEvent("EventCreateNickname", "FromClient_LoginNickname_All_Open")
  registerEvent("FromClient_LoginNickName_OK_End", "FromClient_LoginNickname_All_ApplyCallback")
  self._ui.btn_Apply:addInputEvent("Mouse_LUp", "HandleEventLUp_LoginNickname_All_ApplyNickname()")
  self._ui.edit_Nickname:RegistReturnKeyEvent("HandleEventLUp_LoginNickname_All_ApplyNickname()")
  if true == self._isConsole then
    Panel_Login_Nickname_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPad_LoginNickname_All_InputEdit()")
    Panel_Login_Nickname_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_LoginNickname_All_ApplyNickname()")
    self._ui.edit_Nickname:setXboxVirtualKeyBoardEndEvent("HandleEventPad_LoginNickname_All_KeyboardEnd")
  end
end
function PaGlobal_LoginNickname_All:prepareOpen(clearStr)
  if nil == Panel_Login_Nickname_All then
    return
  end
  self._ui.edit_Nickname:SetEditText("")
  self._ui.edit_Nickname:SetMaxInput(getGameServiceTypeUserNickNameLength())
  if true == self._isConsole then
    ClearFocusEdit()
  else
    SetFocusEdit(self._ui.edit_Nickname)
  end
  self:resize()
  PaGlobal_LoginNickname_All:open()
end
function PaGlobal_LoginNickname_All:open()
  if nil == Panel_Login_Nickname_All then
    return
  end
  Panel_Login_Nickname_All:SetShow(true)
end
function PaGlobal_LoginNickname_All:prepareClose(clearStr)
  if nil == Panel_Login_Nickname_All then
    return
  end
  if nil == clearStr or true == clearStr then
    self._ui.edit_Nickname:SetEditText("")
  end
  PaGlobal_LoginNickname_All:close()
end
function PaGlobal_LoginNickname_All:close()
  if nil == Panel_Login_Nickname_All then
    return
  end
  Panel_Login_Nickname_All:SetShow(false)
end
function PaGlobal_LoginNickname_All:update()
  if nil == Panel_Login_Nickname_All then
    return
  end
end
function PaGlobal_LoginNickname_All:validate()
  if nil == Panel_Login_Nickname_All then
    return
  end
  self._ui.btn_Apply:isValidate()
  self._ui.edit_Nickname:isValidate()
  self._ui.txt_Desc_1:isValidate()
  self._ui.txt_Desc_2:isValidate()
  self._ui.txt_Desc_3:isValidate()
  self._ui.stc_Illust:isValidate()
  UI.ASSERT(nil ~= self._ui.edit_Nickname and "number" ~= type(self._ui.edit_Nickname), "Edit_Nickname")
  UI.ASSERT(nil ~= self._ui.btn_Apply and "number" ~= type(self._ui.btn_Apply), "Button_Apply_Import")
end
function PaGlobal_LoginNickname_All:initData()
  Panel_Login_Nickname_All:SetShow(false, false)
  Panel_Login_Nickname_All:setGlassBackground(true)
  self._ui.txt_Desc_1:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc_2:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc_3:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc_1:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NICKNAME_NOTIFY_1"))
  if self._isConsole then
    self._ui.txt_Desc_2:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHANGENAME_CONSOLE_TEXTBIND"))
    self._ui.txt_Desc_3:SetText("")
  else
    self._ui.txt_Desc_2:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NICKNAME_NOTIFY_2"))
    local defaultNickNameNotify = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NICKNAME_NOTIFY_3_PARAM", "min", tostring(getGameServiceTypeNameMinLength()), "max", tostring(getGameServiceTypeUserNickNameLength()))
    if isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTH() or isGameTypeRussia() or isGameTypeID() or isGameTypeTR() then
      if isGameTypeRussia() then
        defaultNickNameNotify = defaultNickNameNotify .. "\n\226\128\187 " .. PAGetString(Defines.StringSheet_GAME, "LUA_RUS_CREATENAME_RULE")
      end
      self._ui.txt_Desc_3:SetText(defaultNickNameNotify .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_MAKENAME_WARNING"))
    else
      self._ui.txt_Desc_3:SetText(defaultNickNameNotify)
    end
  end
  self._ui.txt_Desc_2:SetPosY(self._ui.txt_Desc_1:GetPosY() + self._ui.txt_Desc_1:GetTextSizeY() + 30)
  self._ui.txt_Desc_3:SetPosY(self._ui.txt_Desc_2:GetPosY() + self._ui.txt_Desc_2:GetTextSizeY() + 10)
  self._ui.stc_consoleKeyGuide:SetShow(self._isConsole)
  self._ui.txt_targetEditKey:SetShow(self._isConsole)
  self._ui.txt_confirmKey:SetShow(self._isConsole)
  self._ui.btn_Apply:SetShow(false == self._isConsole)
end
function PaGlobal_LoginNickname_All:resize()
  Panel_Login_Nickname_All:SetSize(Panel_Login_Nickname_All:GetSizeX(), self._ui.txt_Desc_1:GetTextSizeY() + self._ui.txt_Desc_2:GetTextSizeY() + self._ui.txt_Desc_3:GetTextSizeY() + 185)
  self._ui.edit_Nickname:ComputePos()
  self._ui.btn_Apply:ComputePos()
  self._ui.stc_Illust:ComputePos()
  if true == self._isConsole then
    self._ui.edit_Nickname:SetSize(self._defaultEditSizeX + self._ui.btn_Apply:GetSizeX(), self._ui.edit_Nickname:GetSizeY())
    self._ui.txt_targetEditKey:ComputePos()
  end
  self._ui.stc_consoleKeyGuide:ComputePos()
end
function PaGlobal_LoginNickname_All:applyNickname()
  ClearFocusEdit()
  lobbyNickname_createNickname(self._ui.edit_Nickname:GetEditText())
end
function PaGlobal_LoginNickname_All:applyCallback()
  local function createFamilyName()
    registerNickname()
    if true == self._isConsole then
      FromClient_LoginNickname_All_Open(false)
    end
  end
  local function cancelFamilyName()
    if true == self._isConsole then
      FromClient_LoginNickname_All_Open(false)
    end
  end
  local messageBoxContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOGIN_NICKNAME_FIRSTCREATE", "name", self._ui.edit_Nickname:GetEditText())
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxContent,
    functionYes = createFamilyName,
    functionNo = cancelFamilyName,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
  if true == self._isConsole then
    PaGlobal_LoginNickname_All_Close()
  end
end
