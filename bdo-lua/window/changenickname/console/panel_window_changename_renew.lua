local _panel = Panel_Window_ChangeName_Renew
local UIMode = Defines.UIMode
local IM = CppEnums.EProcessorInputMode
_panel:SetShow(false, false)
_panel:setGlassBackground(true)
local ChangeName = {
  _ui = {
    txt_title = UI.getChildControl(_panel, "Static_Text_Title_Import"),
    stc_centerBG = UI.getChildControl(_panel, "Static_CenterBg"),
    stc_image = nil,
    txt_desc = nil,
    txt_namingRule = nil,
    edit_nickname = nil,
    stc_BottomBG = UI.getChildControl(_panel, "Static_BottomArea"),
    txt_KeyGuide_A = nil,
    txt_KeyGuide_B = nil
  },
  _defaultSizeY = 295,
  _defaultGapSizeY = 25,
  _currentNameType = -1
}
function ChangeName:resize()
  self._ui.txt_desc:SetPosY(self._defaultGapSizeY)
  self._ui.txt_namingRule:SetPosY(self._ui.txt_desc:GetPosY() + self._ui.txt_desc:GetTextSizeY() + self._defaultGapSizeY)
  self._ui.edit_nickname:SetPosY(self._ui.txt_namingRule:GetPosY() + self._ui.txt_namingRule:GetTextSizeY() + self._defaultGapSizeY)
  local totalCenterSizeY = math.max(self._ui.edit_nickname:GetPosY() + self._ui.edit_nickname:GetSizeY() + self._defaultGapSizeY, self._ui.stc_image:GetSizeY())
  local currentSizeY = self._ui.stc_centerBG:GetSizeY()
  local gapSizeY = totalCenterSizeY - currentSizeY
  _panel:SetSize(_panel:GetSizeX(), _panel:GetSizeY() + gapSizeY)
  self._ui.stc_centerBG:SetSize(self._ui.stc_centerBG:GetSizeX(), self._ui.stc_centerBG:GetSizeY() + gapSizeY)
  _panel:ComputePos()
  self._ui.stc_centerBG:ComputePos()
  self._ui.stc_image:ComputePos()
  self._ui.stc_BottomBG:ComputePos()
end
function PaGlobal_ChangeName_Init()
  local self = ChangeName
  self._ui.stc_image = UI.getChildControl(self._ui.stc_centerBG, "Static_Image")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_centerBG, "StaticText_Desc")
  self._ui.txt_namingRule = UI.getChildControl(self._ui.stc_centerBG, "StaticText_NamingRule")
  self._ui.edit_nickname = UI.getChildControl(self._ui.stc_centerBG, "Edit_Nickname")
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_namingRule:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_KeyGuide_A = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_Confirm_ConsoleUI")
  self._ui.txt_KeyGuide_B = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_Cancel_ConsoleUI")
  local keyGuides = {
    self._ui.txt_KeyGuide_A,
    self._ui.txt_KeyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_BottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self._ui.edit_nickname:SetMaxInput(getGameServiceTypeUserNickNameLength())
  self._ui.edit_nickname:setXboxVirtualKeyBoardEndEvent("Input_ChangeName_KeyboardEnd")
  _panel:registerPadEvent(__eConsoleUIPadEvent_Up_X, "Input_ChangeName_Edit()")
  _panel:registerPadEvent(__eConsoleUIPadEvent_Up_A, "Input_ChangeName_Change()")
  registerEvent("FromClient_ShowChangeNickname", "FromClient_ShowChangeNickname")
  registerEvent("FromClient_ChangeName", "FromClient_ChangeName")
end
function Input_ChangeName_Edit()
  if not _panel:GetShow() then
    return
  end
  local self = ChangeName
  SetFocusEdit(self._ui.edit_nickname)
end
function Input_ChangeName_Change()
  local self = ChangeName
  local name = self._ui.edit_nickname:GetEditText()
  local maxLength = getGameServiceTypeUserNickNameLength()
  if maxLength < string.len(name) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNameLengthIsTooLong"))
    ChangeNickname_Close()
    return
  end
  local function toClient_ChangeName()
    if 0 == self._currentNameType then
      ToClient_RequestChangeCharacterName(name)
    elseif 1 == self._currentNameType then
      ToClient_RequestChangeGuildName(name)
    elseif 2 == self._currentNameType then
      ToClient_ChangeNickName(name)
    end
    ChangeNickname_Close()
  end
  local changeType = ""
  if 0 == self._currentNameType then
    changeType = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_10")
  elseif 1 == self._currentNameType then
    changeType = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_11")
  elseif 2 == self._currentNameType then
    changeType = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_12")
  end
  local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAMECHANGE_13", "changeType", changeType, "name", name)
  local messageBoxData = {
    title = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAMECHANGE_14", "changeType", changeType),
    content = messageBoxMemo,
    functionYes = toClient_ChangeName,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function Input_ChangeName_KeyboardEnd(str)
  local self = ChangeName
  self._ui.edit_nickname:SetEditText(str)
  ClearFocusEdit()
end
function FromClient_ChangeName()
  if 2 == ChangeName._currentNameType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_15"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_1"))
  end
end
function FromClient_ShowChangeNickname(type)
  if _panel:GetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_2"))
    return
  end
  local self = ChangeName
  self._currentNameType = type
  self._ui.edit_nickname:SetEditText("")
  if 0 == self._currentNameType then
    self._ui.txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_3"))
    self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_4"))
    self._ui.txt_namingRule:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAMECHANGE_5_PARAM", "min", tostring(getGameServiceTypeNameMinLength()), "max", tostring(getGameServiceTypeCharacterNameLength())))
  elseif 1 == self._currentNameType then
    local isGuildMaster = getSelfPlayer():get():isGuildMaster()
    if not isGuildMaster then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_6"))
      return
    end
    self._ui.txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_7"))
    self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_8"))
    self._ui.txt_namingRule:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAMECHANGE_9_PARAM", "min", tostring(getGameServiceTypeNameMinLength()), "max", tostring(getGameServiceTypeGuildNameLength())))
  elseif 2 == self._currentNameType then
    self._ui.txt_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHANGE_NICKNAME_TITLE"))
    self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NICKNAME_NOTIFY_1"))
    self._ui.txt_namingRule:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NICKNAME_NOTIFY_3_WARING_PARAM", "min", tostring(getGameServiceTypeNameMinLength()), "max", tostring(getGameServiceTypeUserNickNameLength())))
  end
  self:resize()
  _panel:SetShow(true)
  PaGlobalFunc_InventoryInfo_Close()
end
function ChangeNickname_Close()
  local self = ChangeName
  self._ui.edit_nickname:SetEditText("")
  ClearFocusEdit()
  CheckChattingInput()
  _panel:SetShow(false)
end
registerEvent("FromClient_luaLoadComplete", "PaGlobal_ChangeName_Init")
