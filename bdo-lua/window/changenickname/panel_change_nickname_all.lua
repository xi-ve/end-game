local UIMode = Defines.UIMode
local IM = CppEnums.EProcessorInputMode
PaGlobal_ChangeNickName_All = {
  _ui = {
    stc_blockBg = nil,
    stc_TitleBg = nil,
    stc_SubBg = nil,
    stc_Illust = nil,
    btn_Apply = nil,
    btn_Cancel = nil,
    edit_Nickname = nil,
    txt_Title = nil,
    txt_Desc = nil,
    txt_ConditionDesc = nil,
    stc_Bottom_Keyguides = nil,
    stc_KeyGuide_X = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _originSpanSize = {txt_ConditionDesc = 0, edit_Nickname = 0},
  _itemType = 0,
  _isConsole = false
}
function PaGlobal_ChangeNickName_All_Init()
  PaGlobal_ChangeNickName_All:initailze()
end
registerEvent("FromClient_luaLoadComplete", "PaGlobal_ChangeNickName_All_Init")
function PaGlobal_ChangeNickName_All:initailze()
  if true == PaGlobal_ChangeNickName_All._initialize then
    return
  end
  self._ui.stc_blockBg = UI.getChildControl(Panel_Change_Nickname_All, "Static_BlockBg")
  self._ui.stc_TitleBg = UI.getChildControl(Panel_Change_Nickname_All, "Static_TitleBg")
  self._ui.stc_SubBg = UI.getChildControl(Panel_Change_Nickname_All, "Static_SubFrame")
  self._ui.stc_Illust = UI.getChildControl(Panel_Change_Nickname_All, "Static_Illust")
  self._ui.btn_Apply = UI.getChildControl(Panel_Change_Nickname_All, "Button_Apply_PCUI")
  self._ui.btn_Cancel = UI.getChildControl(Panel_Change_Nickname_All, "Button_Cancel_PCUI")
  self._ui.edit_Nickname = UI.getChildControl(Panel_Change_Nickname_All, "Edit_Nickname")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_TitleBg, "Static_Text_Title_Import")
  self._ui.txt_Desc = UI.getChildControl(Panel_Change_Nickname_All, "StaticText_ChangeNameDesc")
  self._ui.txt_ConditionDesc = UI.getChildControl(Panel_Change_Nickname_All, "StaticText_ChangeNameCondition")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.edit_Nickname, "Static_X_ConsoleUI")
  self._ui.stc_Bottom_Keyguides = UI.getChildControl(Panel_Change_Nickname_All, "Static_BottomBg_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_Bottom_Keyguides, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_Bottom_Keyguides, "StaticText_B_ConsoleUI")
  self._originSpanSize.txt_ConditionDesc = self._ui.txt_ConditionDesc:GetSpanSize().y
  self._originSpanSize.edit_Nickname = self._ui.edit_Nickname:GetSpanSize().y
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ChangeNickName_All:validate()
  PaGlobal_ChangeNickName_All:SwitchPlatform(self._isConsole)
  PaGlobal_ChangeNickName_All:registEventHandler(self._isConsole)
end
function PaGlobal_ChangeNickName_All:validate()
  if true == PaGlobal_ChangeNickName_All._initialize then
    return
  end
  self._ui.stc_blockBg:isValidate()
  self._ui.stc_TitleBg:isValidate()
  self._ui.stc_SubBg:isValidate()
  self._ui.stc_Illust:isValidate()
  self._ui.btn_Apply:isValidate()
  self._ui.btn_Cancel:isValidate()
  self._ui.edit_Nickname:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.txt_ConditionDesc:isValidate()
  self._ui.stc_Bottom_Keyguides:isValidate()
  self._ui.stc_KeyGuide_X:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
  PaGlobal_ChangeNickName_All._initialize = true
end
function PaGlobal_ChangeNickName_All:SwitchPlatform(isConsole)
  self._ui.stc_Bottom_Keyguides:SetShow(isConsole)
  self._ui.stc_KeyGuide_B:SetShow(isConsole)
  self._ui.stc_KeyGuide_X:SetShow(isConsole)
  self._ui.stc_KeyGuide_A:SetShow(isConsole)
  self._ui.btn_Apply:SetShow(not isConsole)
  self._ui.btn_Cancel:SetShow(not isConsole)
  local keyGuides = {
    self._ui.stc_KeyGuide_A,
    self._ui.stc_KeyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_Bottom_Keyguides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_ChangeNickName_All:registEventHandler(isConsole)
  self._ui.edit_Nickname:SetMaxInput(getGameServiceTypeUserNickNameLength())
  registerEvent("FromClient_ShowChangeNickname", "FromClient_ChangeNickname_All_Show")
  registerEvent("FromClient_ChangeName", "FromClient_ChangeNickname_All_ChangeSuccess")
  registerEvent("onScreenResize", "FromClient_ChangeNickname_All_OnScreenResize")
  if true == isConsole then
    Panel_Change_Nickname_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ChangeNickNameAll_ChangeNickName()")
    Panel_Change_Nickname_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_ChangeNickNameAll_ClearEdit()")
    self._ui.edit_Nickname:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_ChangeNickNameAll_ChangeNickName_Console")
    self._ui.edit_Nickname:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ChangeNickNameAll_ChangeNickName()")
  else
    self._ui.edit_Nickname:addInputEvent("Mouse_LUp", "HandleEventLUp_ChangeNickNameAll_ClearEdit()")
    self._ui.btn_Apply:addInputEvent("Mouse_LUp", "HandleEventLUp_ChangeNickNameAll_ChangeNickName()")
    self._ui.btn_Cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_ChangeNickNameAll_Close()")
  end
end
function PaGlobal_ChangeNickName_All:prepareOpen()
  self._ui.edit_Nickname:SetEditText("")
  PaGlobal_ChangeNickName_All:open()
  FromClient_ChangeNickname_All_OnScreenResize()
end
function PaGlobal_ChangeNickName_All:open()
  Panel_Change_Nickname_All:SetShow(true)
end
function PaGlobal_ChangeNickName_All:prepareClose()
  self._ui.edit_Nickname:SetEditText("")
  PaGlobal_ChangeNickName_All._itemType = 0
  ClearFocusEdit()
  CheckChattingInput()
  PaGlobal_ChangeNickName_All:close()
end
function PaGlobal_ChangeNickName_All:close()
  Panel_Change_Nickname_All:SetShow(false)
end
function HandleEventLUp_ChangeNickNameAll_Close()
  if false == Panel_Change_Nickname_All:GetShow() then
    return
  end
  PaGlobal_ChangeNickName_All:prepareClose()
end
function HandleEventPadPress_ChangeNickNameAll_Close()
  if false == Panel_Change_Nickname_All:GetShow() or false == PaGlobal_ChangeNickName_All._isConsole then
    return
  end
  PaGlobal_ChangeNickName_All:prepareClose()
end
function HandleEventLUp_ChangeNickNameAll_ClearEdit()
  if false == Panel_Change_Nickname_All:GetShow() then
    return
  end
  PaGlobal_ChangeNickName_All._ui.edit_Nickname:SetMaxInput(getGameServiceTypeUserNickNameLength())
  SetFocusEdit(PaGlobal_ChangeNickName_All._ui.edit_Nickname)
end
function PaGlobalFunc_ChangeNickNameAll_ChangeNickName_Console(str)
  if getGameServiceTypeUserNickNameLength() < string.len(str) then
    str = string.sub(str, 1, getGameServiceTypeUserNickNameLength())
  end
  PaGlobal_ChangeNickName_All._ui.edit_Nickname:SetEditText(str)
  ClearFocusEdit()
  HandleEventLUp_ChangeNickNameAll_ChangeNickName()
end
function HandleEventLUp_ChangeNickNameAll_ChangeNickName()
  if false == Panel_Change_Nickname_All:GetShow() then
    return
  end
  local userInput = PaGlobal_ChangeNickName_All._ui.edit_Nickname:GetEditText()
  if nil == userInput or "" == userInput then
    return
  end
  if true == PaGlobal_ChangeNickName_All._isConsole then
    ClearFocusEdit()
  end
  local _nameType = PaGlobal_ChangeNickName_All._itemType
  local function toClient_ChangeName()
    if 0 == _nameType then
      ToClient_RequestChangeCharacterName(userInput)
    elseif 1 == _nameType then
      ToClient_RequestChangeGuildName(userInput)
    elseif 2 == _nameType then
      ToClient_ChangeNickName(userInput)
    end
    HandleEventLUp_ChangeNickNameAll_Close()
  end
  local changeType = ""
  if 0 == _nameType then
    changeType = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_10")
  elseif 1 == _nameType then
    changeType = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_11")
  elseif 2 == _nameType then
    changeType = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_12")
  end
  local msgTitle = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAMECHANGE_14", "changeType", changeType)
  local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAMECHANGE_13", "changeType", changeType, "name", userInput)
  local messageBoxData = {
    title = msgTitle,
    content = messageBoxMemo,
    functionYes = toClient_ChangeName,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if false == PaGlobal_ChangeNickName_All._isConsole then
    MessageBox.showMessageBox(messageBoxData, nil, nil, false)
  else
    MessageBox.showMessageBox(messageBoxData)
  end
end
function FromClient_ChangeNickname_All_ChangeSuccess()
  if 2 == PaGlobal_ChangeNickName_All._itemType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_15"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_1"))
  end
end
function FromClient_ChangeNickname_All_Show(param)
  if true == Panel_Change_Nickname_All:GetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_2"))
    return
  end
  PaGlobal_ChangeNickName_All._itemType = param
  local txt_Desc = PaGlobal_ChangeNickName_All._ui.txt_Desc
  local txt_Condition = PaGlobal_ChangeNickName_All._ui.txt_ConditionDesc
  local title = PaGlobal_ChangeNickName_All._ui.txt_Title
  local subBg = PaGlobal_ChangeNickName_All._ui.stc_SubBg
  local titleBg = PaGlobal_ChangeNickName_All._ui.stc_TitleBg
  local illust = PaGlobal_ChangeNickName_All._ui.stc_Illust
  local editText = PaGlobal_ChangeNickName_All._ui.edit_Nickname
  txt_Condition:SetTextMode(__eTextMode_AutoWrap)
  txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  if 0 == param then
    title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_3"))
    txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_4"))
    local defaultNameChangeText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAMECHANGE_5_PARAM", "min", tostring(getGameServiceTypeNameMinLength()), "max", tostring(getGameServiceTypeCharacterNameLength()))
    local isNameChangeText = defaultNameChangeText
    if isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTH() or isGameTypeRussia() or isGameTypeID() or isGameTypeTR() then
      isNameChangeText = defaultNameChangeText .. [[


<PAColor0xFFF26A6A>]] .. PAGetString(Defines.StringSheet_GAME, "LUA_MAKENAME_WARNING") .. "<PAOldColor>"
    else
      isNameChangeText = defaultNameChangeText
    end
    txt_Condition:SetText(isNameChangeText)
  elseif 1 == param then
    local isGuildMaster = getSelfPlayer():get():isGuildMaster()
    if false == isGuildMaster then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_6"))
      return
    end
    title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_7"))
    txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_8"))
    local defaultNameChangeText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAMECHANGE_9_PARAM", "min", tostring(getGameServiceTypeNameMinLength()), "max", tostring(getGameServiceTypeGuildNameLength()))
    local isNameChangeText = defaultNameChangeText
    if isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTH() or isGameTypeRussia() or isGameTypeID() or isGameTypeTR() then
      isNameChangeText = defaultNameChangeText .. [[


<PAColor0xFFF26A6A>]] .. PAGetString(Defines.StringSheet_GAME, "LUA_MAKENAME_WARNING") .. "<PAOldColor>"
    else
      isNameChangeText = defaultNameChangeText
    end
    txt_Condition:SetText(isNameChangeText)
  elseif 2 == param then
    title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHANGE_NICKNAME_TITLE"))
    txt_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NICKNAME_NOTIFY_1"))
    local defaultNameChangeText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NICKNAME_NOTIFY_3_WARING_PARAM", "min", tostring(getGameServiceTypeNameMinLength()), "max", tostring(getGameServiceTypeUserNickNameLength()))
    local isNameChangeText = defaultNameChangeText
    if isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTH() or isGameTypeRussia() or isGameTypeID() or isGameTypeTR() then
      isNameChangeText = defaultNameChangeText .. [[


<PAColor0xFFF26A6A>]] .. PAGetString(Defines.StringSheet_GAME, "LUA_MAKENAME_WARNING") .. "<PAOldColor>"
    else
      isNameChangeText = defaultNameChangeText
    end
    txt_Condition:SetText(isNameChangeText)
  end
  if false == self._isConsole then
    SetFocusEdit(PaGlobal_ChangeNickName_All._ui.edit_Nickname)
  end
  if true == PaGlobal_ChangeNickName_All._isConsole then
    subBg:SetSize(subBg:GetSizeX(), txt_Desc:GetTextSizeY() + txt_Condition:GetTextSizeY() + 100)
    illust:SetSize(illust:GetSizeX(), subBg:GetSizeY())
    Panel_Change_Nickname_All:SetSize(Panel_Change_Nickname_All:GetSizeX(), titleBg:GetSizeY() + txt_Desc:GetTextSizeY() + txt_Condition:GetTextSizeY() + 100)
    local btnSizeY = PaGlobal_ChangeNickName_All._ui.btn_Apply:GetSizeY() + 20
    txt_Condition:SetSpanSize(txt_Condition:GetSpanSize().x, PaGlobal_ChangeNickName_All._originSpanSize.txt_ConditionDesc - btnSizeY)
    editText:SetSpanSize(editText:GetSpanSize().x, PaGlobal_ChangeNickName_All._originSpanSize.edit_Nickname - btnSizeY)
    InventoryWindow_Close()
  else
    subBg:SetSize(subBg:GetSizeX(), txt_Desc:GetTextSizeY() + txt_Condition:GetTextSizeY() + 170)
    illust:SetSize(illust:GetSizeX(), subBg:GetSizeY())
    Panel_Change_Nickname_All:SetSize(Panel_Change_Nickname_All:GetSizeX(), titleBg:GetSizeY() + txt_Desc:GetTextSizeY() + txt_Condition:GetTextSizeY() + 170)
  end
  FromClient_ChangeNickname_All_OnScreenResize()
  PaGlobal_ChangeNickName_All:prepareOpen()
end
function FromClient_ChangeNickname_All_OnScreenResize()
  if false == Panel_Change_Nickname_All:GetShow() then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  PaGlobal_ChangeNickName_All._ui.stc_blockBg:SetSize(screenSizeX + 500, screenSizeY + 500)
  PaGlobal_ChangeNickName_All._ui.stc_blockBg:SetSpanSize(0, 0)
  PaGlobal_ChangeNickName_All._ui.stc_blockBg:ComputePos()
  PaGlobal_ChangeNickName_All._ui.txt_Title:ComputePos()
  PaGlobal_ChangeNickName_All._ui.stc_SubBg:ComputePos()
  PaGlobal_ChangeNickName_All._ui.txt_Desc:ComputePos()
  PaGlobal_ChangeNickName_All._ui.txt_ConditionDesc:ComputePos()
  PaGlobal_ChangeNickName_All._ui.stc_TitleBg:ComputePos()
  PaGlobal_ChangeNickName_All._ui.stc_Illust:ComputePos()
  PaGlobal_ChangeNickName_All._ui.stc_blockBg:ComputePos()
  PaGlobal_ChangeNickName_All._ui.btn_Apply:ComputePos()
  PaGlobal_ChangeNickName_All._ui.btn_Cancel:ComputePos()
  PaGlobal_ChangeNickName_All._ui.stc_Bottom_Keyguides:ComputePos()
  PaGlobal_ChangeNickName_All._ui.edit_Nickname:ComputePos()
end
