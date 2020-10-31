PaGlobal_GuildIntroduce_All = {
  _ui = {
    stc_Title = nil,
    txt_Title = nil,
    stc_MainBg = nil,
    edit_Introduce = nil,
    btn_Promote = nil,
    btn_Save = nil,
    btn_Reset = nil,
    btn_Close = nil,
    stc_KeyGuide_Bg = nil,
    stc_keyGuide_A = nil,
    stc_keyGuide_B = nil,
    stc_keyGuide_X = nil,
    stc_keyGuide_Y = nil
  },
  _isConsole = false,
  _isMaster = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildIntroduce_All_Init")
function FromClient_GuildIntroduce_All_Init()
  PaGlobal_GuildIntroduce_All:initialize()
end
function PaGlobal_GuildIntroduce_All:initialize()
  if nil == Panel_GuildInfo_All or nil == Panel_GuildIntroduce_All then
    return
  end
  self._ui.stc_Title = UI.getChildControl(Panel_GuildIntroduce_All, "Static_TitleArea")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_Title, "StaticText_TItle")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_Title, "Button_Close")
  self._ui.stc_MainBg = UI.getChildControl(Panel_GuildIntroduce_All, "Static_MainArea")
  self._ui.edit_Introduce = UI.getChildControl(self._ui.stc_MainBg, "MultilineEdit_NoticeSquare")
  self._ui.btn_Promote = UI.getChildControl(self._ui.stc_MainBg, "Button_IntroNotify")
  self._ui.btn_Save = UI.getChildControl(self._ui.stc_MainBg, "Button_Write")
  self._ui.btn_Reset = UI.getChildControl(self._ui.stc_MainBg, "Button_Reset")
  self._ui.stc_KeyGuide_Bg = UI.getChildControl(Panel_GuildIntroduce_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_keyGuide_A = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_A_ConsoleUI")
  self._ui.stc_keyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_B_ConsoleUI")
  self._ui.stc_keyGuide_X = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_X_ConsoleUI")
  self._ui.stc_keyGuide_Y = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_Y_ConsoleUI")
  self.keyguide = {
    self._ui.stc_keyGuide_A,
    self._ui.stc_keyGuide_Y,
    self._ui.stc_keyGuide_X,
    self._ui.stc_keyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self.keyguide, self._ui.stc_KeyGuide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_GuildIntroduce_All:switchPlatform(self._isConsole)
  PaGlobal_GuildIntroduce_All:registerEvent()
  PaGlobal_GuildIntroduce_All:validate()
end
function PaGlobal_GuildIntroduce_All:registerEvent()
  if false == self._isConsole then
    self._ui.edit_Introduce:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildIntroduce_EditName()")
    self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildIntroduce_Close()")
    self._ui.btn_Reset:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildIntroduce_Reset()")
    self._ui.btn_Save:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildIntroduce_Save()")
    self._ui.btn_Promote:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildIntroduce_Promote()")
    self._ui.btn_Promote:addInputEvent("Mouse_On", "HandleEventOnOut_GuildIntroduce_Tooltip( true, 0)")
    self._ui.btn_Promote:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildIntroduce_Tooltip( false )")
    self._ui.btn_Reset:addInputEvent("Mouse_On", "HandleEventOnOut_GuildIntroduce_Tooltip( true, 1)")
    self._ui.btn_Reset:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildIntroduce_Tooltip( false)")
    self._ui.btn_Save:addInputEvent("Mouse_On", "HandleEventOnOut_GuildIntroduce_Tooltip( true, 2)")
    self._ui.btn_Save:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildIntroduce_Tooltip(false)")
    self._ui.edit_Introduce:addInputEvent("Mouse_On", "HandleEventOnOut_GuildIntroduce_Tooltip(false)")
  else
    Panel_GuildIntroduce_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_GuildIntroduce_Save()")
    self._ui.edit_Introduce:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_GuildIntroduce_EndVirtualKey")
    Panel_GuildIntroduce_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  end
  if isGameTypeTaiwan() then
    self._ui.edit_Introduce:SetMaxEditLine(7)
  else
    self._ui.edit_Introduce:SetMaxEditLine(10)
  end
  self._ui.edit_Introduce:SetMaxInput(200)
end
function PaGlobal_GuildIntroduce_All:switchPlatform(isConsole)
  self._ui.stc_KeyGuide_Bg:SetShow(isConsole)
  self._ui.btn_Promote:SetShow(not isConsole)
  self._ui.btn_Reset:SetShow(not isConsole)
  self._ui.btn_Save:SetShow(not isConsole)
  self._ui.btn_Close:SetShow(not isConsole)
end
function PaGlobal_GuildIntroduce_All:validate()
  self._ui.stc_Title:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_MainBg:isValidate()
  self._ui.edit_Introduce:isValidate()
  self._ui.btn_Promote:isValidate()
  self._ui.btn_Save:isValidate()
  self._ui.btn_Reset:isValidate()
end
function PaGlobalFunc_GuildIntroduce_Open()
  if true == Panel_GuildIntroduce_All:GetShow() then
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    return
  end
  local guildIntroduce = guildWrapper:getGuildIntrodution()
  PaGlobal_GuildIntroduce_All._ui.edit_Introduce:SetEditText(guildIntroduce, false)
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  PaGlobal_GuildIntroduce_All._isMaster = true == isGuildMaster or true == isGuildSubMaster
  if false == PaGlobal_GuildIntroduce_All._isMaster then
    PaGlobal_GuildIntroduce_All._ui.edit_Introduce:SetIgnore(true)
    PaGlobal_GuildIntroduce_All._ui.txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_INTRODUCETITLE"))
  else
    PaGlobal_GuildIntroduce_All._ui.edit_Introduce:SetIgnore(false)
    PaGlobal_GuildIntroduce_All._ui.txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDINTRODUCEREGIST_TITLE"))
  end
  if true == PaGlobal_GuildIntroduce_All._isConsole then
    if true == PaGlobal_GuildIntroduce_All._isMaster then
      Panel_GuildIntroduce_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_GuildIntroduce_Reset()")
      Panel_GuildIntroduce_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_GuildIntroduce_EditName()")
      Panel_GuildIntroduce_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_GuildIntroduce_Save()")
    else
      Panel_GuildIntroduce_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      Panel_GuildIntroduce_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
      Panel_GuildIntroduce_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    end
    PaGlobal_GuildIntroduce_All._ui.stc_keyGuide_A:SetShow(PaGlobal_GuildIntroduce_All._isMaster)
    PaGlobal_GuildIntroduce_All._ui.stc_keyGuide_Y:SetShow(PaGlobal_GuildIntroduce_All._isMaster)
    PaGlobal_GuildIntroduce_All._ui.stc_keyGuide_X:SetShow(PaGlobal_GuildIntroduce_All._isMaster)
    PaGlobal_GuildIntroduce_All._ui.stc_keyGuide_B:SetShow(true)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_GuildIntroduce_All.keyguide, PaGlobal_GuildIntroduce_All._ui.stc_KeyGuide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    PaGlobal_GuildIntroduce_All._ui.btn_Promote:SetShow(PaGlobal_GuildIntroduce_All._isMaster)
    PaGlobal_GuildIntroduce_All._ui.btn_Save:SetShow(PaGlobal_GuildIntroduce_All._isMaster)
    PaGlobal_GuildIntroduce_All._ui.btn_Reset:SetShow(PaGlobal_GuildIntroduce_All._isMaster)
  end
  Panel_GuildIntroduce_All:ComputePos()
  Panel_GuildIntroduce_All:SetShow(true)
end
function PaGlobalFunc_GuildIntroduce_Close()
  ClearFocusEdit()
  CheckChattingInput()
  Panel_GuildIntroduce_All:SetShow(false)
end
function PaGlobalFunc_GuildIntroduce_EditName()
  SetFocusEdit(PaGlobal_GuildIntroduce_All._ui.edit_Introduce)
end
function PaGlobalFunc_GuildIntroduce_EndVirtualKey(str)
  ClearFocusEdit()
  PaGlobal_GuildIntroduce_All._ui.edit_Introduce:SetEditText(str, true)
end
function HandleEventLUp_GuildIntroduce_Reset()
  if false == PaGlobal_GuildIntroduce_All._isMaster then
    return
  end
  PaGlobal_GuildIntroduce_All._ui.edit_Introduce:SetEditText("", true)
  ClearFocusEdit()
  ToClient_RequestSetIntrodution(tostring(""))
end
function HandleEventLUp_GuildIntroduce_Save()
  if false == PaGlobal_GuildIntroduce_All._isMaster then
    return
  end
  ToClient_RequestSetIntrodution(PaGlobal_GuildIntroduce_All._ui.edit_Introduce:GetEditText())
  ClearFocusEdit()
  CheckChattingInput()
end
function HandleEventLUp_GuildIntroduce_Promote()
  if false == PaGlobal_GuildIntroduce_All._isMaster then
    return
  end
  local confirmPromote = function()
    local guildWrapper = ToClient_GetMyGuildInfoWrapper()
    local guildIntroduce = guildWrapper:getGuildIntrodution()
    ToClient_SetLinkedGuildInfoByGuild()
    chatting_sendMessageNoMatterEmpty("", guildIntroduce, CppEnums.ChatType.World)
  end
  PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROMOTE_BTN_MESSAGE_DESC"), confirmPromote, MessageBox_Empty_function, nil, nil)
end
function HandleEventOnOut_GuildIntroduce_Tooltip(isShow, tiptype)
  if false == isShow or nil == tiptype then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 0 == tiptype then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROMOTE_BTN_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROMOTE_BTN_DESC")
    control = PaGlobal_GuildIntroduce_All._ui.btn_Promote
  elseif 1 == tiptype then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHAT_SOCIALMENU_BTN_RESET")
    control = PaGlobal_GuildIntroduce_All._ui.btn_Reset
  elseif 2 == tiptype then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDINTRODUCE_WRITE_TOOLTIP_TITLE")
    control = PaGlobal_GuildIntroduce_All._ui.btn_Save
  end
  if nil == control then
    UI.ASSERT_NAME(false, "Tooltop Control is nil / type = " .. tostring(tiptype), "\234\185\128\234\183\188\236\154\176")
    return
  end
  TooltipSimple_Show(control, name, desc)
end
