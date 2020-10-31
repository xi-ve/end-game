function PaGlobalFunc_Arsha_Func_All_Open()
  PaGlobal_Arsha_Func_All:prepareOpen()
end
function PaGlobalFunc_Arsha_Func_All_Close()
  PaGlobal_Arsha_Func_All:prepareClose()
end
function HandleEventLUp_Arsha_Func_All_Close()
  PaGlobalFunc_Arsha_Func_All_Close()
end
function PaGlobalFunc_Arsha_Func_All_SubMenuPowerClose()
  Panel_Window_ArshaPvPSubMenu_All:SetShow(false)
end
function PaGlobalFunc_Arsha_Func_All_HostJoin()
  ToClient_RequestEnterCompetitionHost()
end
function ArshaDebuff(isOn)
  ToClient_ArshaDebuffOnOff(isOn)
end
function HandleEventOnOut_Arsha_Func_All_CommonTooltip(isShow, tipType)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_RESURRECTION_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_RESURRECTION_DESC")
    control = PaGlobal_Arsha_Func_All._ui.btn_allResurrection
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_GAMESTOP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_GAMESTOP_DESC")
    control = PaGlobal_Arsha_Func_All._ui.btn_gameStop
  elseif 3 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_GAMESTART_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_GAMESTART_DESC")
    control = PaGlobal_Arsha_Func_All._ui.btn_gameStart
  elseif 4 == tipType then
    local isOpenType
    if PaGlobal_Arsha_Func_All._isOpen then
      isOpenType = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_OPENTYPE")
    else
      isOpenType = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_CLOSETYPE")
    end
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_OPENCLOSE_TITLE")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_OPENCLOSE_DESC", "isOpenType", isOpenType)
    control = PaGlobal_Arsha_Func_All._ui._attenderSet.chk_lock
  elseif 5 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_INVITELIST_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_INVITELIST_DESC")
    control = PaGlobal_Arsha_Func_All._ui._attenderSet.btn_inviteList
  elseif 6 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_EXIT_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_EXIT_DESC")
    control = PaGlobal_Arsha_Func_All._ui._attenderSet.btn_exit
  elseif 7 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_WAIT_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_WAIT_DESC")
    control = PaGlobal_Arsha_Func_All._ui._attenderSet.rdo_waiter
  elseif 8 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_WATCH_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_WATCH_DESC")
    control = PaGlobal_Arsha_Func_All._ui._attenderSet.rdo_watcher
  end
  if nil == control then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_Arsha_Func_All_Exit()
  local ArshaPvP_Exit = function()
    ToClient_RequestLeaveMyself()
  end
  local isHost = ToClient_IsCompetitionHost()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_EXIT_BTN_DESC_MESSAGEBOX_NORMAL")
  if true == isHost then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_EXIT_BTN_DESC_MESSAGEBOX_HOST")
  else
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_EXIT_BTN_DESC_MESSAGEBOX_NORMAL")
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = ArshaPvP_Exit,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandlePadEvent_Arsha_Func_All_ArshaExit()
  HandleEventLUp_Arsha_Func_All_Exit()
end
function HandleEventLUp_Arsha_Func_All_SelectMainMenu(selectIdx)
  TooltipSimple_Hide()
  Panel_NumberPad_Close()
  PaGlobal_Arsha_Func_All:selectMainMenu(selectIdx)
  PaGlobal_Arsha_Func_All:update()
  PaGlobalFunc_Arsha_Func_All_SubMenuPowerClose()
end
function HandlePadEventLBRB_Arsha_Func_All_MainTabChange(moveIdx)
  local selectIdx = PaGlobal_Arsha_Func_All._curMenu + moveIdx
  if selectIdx < PaGlobal_Arsha_Func_All._menuType.GAME then
    selectIdx = PaGlobal_Arsha_Func_All._menuType.ATTENDER
  elseif selectIdx > PaGlobal_Arsha_Func_All._menuType.ATTENDER then
    selectIdx = PaGlobal_Arsha_Func_All._menuType.GAME
  end
  HandleEventLUp_Arsha_Func_All_SelectMainMenu(selectIdx)
end
function HandleEventLUp_Arsha_Func_All_SelectWaitMenu(selectIdx)
  TooltipSimple_Hide()
  PaGlobal_Arsha_Func_All:selectWaitList(selectIdx)
  PaGlobal_Arsha_Func_All:updateList()
  PaGlobalFunc_Arsha_Func_All_SubMenuPowerClose()
end
function HandlePadEventLTRT_Arsha_Func_All_SubTabChange(moveIdx)
  if PaGlobal_Arsha_Func_All._menuType.ATTENDER ~= PaGlobal_Arsha_Func_All._curMenu then
    return
  end
  local selectIdx = PaGlobal_Arsha_Func_All._curWaitList + moveIdx
  if selectIdx < PaGlobal_Arsha_Func_All._waitListType.WAITER then
    selectIdx = PaGlobal_Arsha_Func_All._waitListType.WATCHER
  elseif selectIdx > PaGlobal_Arsha_Func_All._waitListType.WATCHER then
    selectIdx = PaGlobal_Arsha_Func_All._waitListType.WAITER
  end
  HandleEventLUp_Arsha_Func_All_SelectWaitMenu(selectIdx)
end
function HandleEventLUp_Arsha_Func_All_InviteListOpen()
  PaGlobalFunc_Arsha_InviteList_All_Open()
end
function HandleEventLUp_Arsha_Func_All_AllPlayerResurrection()
  ToClient_RequestRebirthPlayerAll()
end
function HandleEventLUp_Arsha_Func_All_GameStart()
  ToClient_RequestStartArshaMatch()
end
function HandleEventLUp_Arsha_Func_All_GameStop()
  ToClient_RequestSetFight(CppEnums.CompetitionFightState.eCompetitionFightState_Done)
end
function HandleEventLUp_Arsha_Func_All_OpenOrClose()
  local isHost = ToClient_IsCompetitionHost()
  if nil == isHost or false == isHost then
    PaGlobal_Arsha_Func_All._ui._attenderSet.chk_lock:SetCheck(not PaGlobal_Arsha_Func_All._ui._attenderSet.chk_lock:IsCheck())
    return
  end
  local isOpen = ToClient_IsCompetitionOpen_HostOnly()
  PaGlobal_Arsha_Func_All._isOpen = not isOpen
  PaGlobalFunc_Arsha_Func_All_RequestCompititionOption()
end
function HandleEventLUp_Arsha_Func_All_ChangeTeamNameOpen(teamIdx)
  PaGlobalFunc_Arsha_TeamNameChange_All_Open(teamIdx)
end
function HandleEventLUp_Arsha_Func_All_SetFocusInviteName()
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  SetFocusEdit(PaGlobal_Arsha_Func_All._ui._attenderSet.edit_inviteName)
  PaGlobal_Arsha_Func_All._ui._attenderSet.edit_inviteName:SetEditText(PaGlobal_Arsha_Func_All._ui._attenderSet.edit_inviteName:GetEditText(), true)
end
function HandleEventLUp_Arsha_Func_All_InviteConfirm()
  local characterName = PaGlobal_Arsha_Func_All._ui._attenderSet.edit_inviteName:GetEditText()
  local isObserver = PaGlobal_Arsha_Func_All._ui._attenderSet.rdo_inviteWatcher:IsCheck()
  if nil == characterName or "" == characterName then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SUMMON_ACK"))
    return
  end
  ToClient_RequestInviteCompetition(characterName, isObserver)
  ClearFocusEdit()
end
function HandleVirtualKeyEndEvent_Arsha_Func_All_InviteName(str)
  PaGlobal_Arsha_Func_All._ui._attenderSet.edit_inviteName:SetEditText(str)
  HandleEventLUp_Arsha_Func_All_InviteConfirm()
  ClearFocusEdit()
end
function HandleEventLUp_Arsha_Func_All_TeamChange(teamNo)
  if nil == getSelfPlayer() then
    return
  end
  local userNo = getSelfPlayer():get():getUserNo()
  ToClient_RequestSetTeam(userNo, teamNo)
end
function HandlePadEvent_Arsha_Func_All_GoWait()
  HandleEventLUp_Arsha_Func_All_TeamChange(0)
end
function HandleEventOut_Arsha_Func_All_SubMenuOff()
  local panelPosX = Panel_Window_ArshaPvPSubMenu_All:GetPosX()
  local panelPosY = Panel_Window_ArshaPvPSubMenu_All:GetPosY()
  local panelSizeX = Panel_Window_ArshaPvPSubMenu_All:GetSizeX()
  local panelSizeY = Panel_Window_ArshaPvPSubMenu_All:GetSizeY()
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  if panelPosX <= mousePosX and mousePosX <= panelPosX + panelSizeX and panelPosY <= mousePosY and mousePosY <= panelPosY + panelSizeY then
    return
  end
  if true == PaGlobal_Arsha_Func_All._isConsole then
    return
  end
  Panel_Window_ArshaPvPSubMenu_All:SetShow(false)
end
function HandleEventLUp_Arsha_Func_All_TeamSubMenuShow(idx, controlType, userNo_s64, isAssistant)
  local isHost = ToClient_IsCompetitionHost()
  local isSubHost = ToClient_IsCompetitionAssistant()
  local matchMode = ToClient_CompetitionMatchType()
  local contents
  PaGlobal_Arsha_Func_All._subMenuShowControl = Array.new()
  PaGlobal_Arsha_Func_All._ui_subMenu.btn_kick:SetShow(false)
  PaGlobal_Arsha_Func_All._ui_subMenu.btn_kickAll:SetShow(false)
  PaGlobal_Arsha_Func_All._ui_subMenu.btn_teamChange:SetShow(false)
  PaGlobal_Arsha_Func_All._ui_subMenu.btn_subMaster:SetShow(false)
  PaGlobal_Arsha_Func_All._ui_subMenu.btn_teamMaster:SetShow(false)
  if true == isAssistant then
    PaGlobal_Arsha_Func_All._ui_subMenu.btn_subMaster:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_RELEASE"))
  else
    PaGlobal_Arsha_Func_All._ui_subMenu.btn_subMaster:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARSHA_SUBMENU_UPGRADE"))
  end
  if 0 == controlType then
    contents = PaGlobal_Arsha_Func_All._ui._attenderSet.list2_teamAList:GetContentByKey(toInt64(0, idx))
    if true == isHost then
      PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_kick)
      PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_subMaster)
      if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == matchMode then
        PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_kickAll)
        PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_teamChange)
        PaGlobal_Arsha_Func_All._ui_subMenu.btn_kickAll:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_TeamAllKick(1, " .. 0 .. ")")
      elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == matchMode then
        PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_teamChange)
        PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_teamMaster)
        PaGlobal_Arsha_Func_All._ui_subMenu.btn_teamMaster:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_TeamMaster(" .. userNo_s64 .. ",1)")
      end
    elseif true == isSubHost then
      PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_kick)
    end
  elseif 1 == controlType then
    contents = PaGlobal_Arsha_Func_All._ui._attenderSet.list2_teamBList:GetContentByKey(toInt64(0, idx))
    if true == isHost then
      PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_kick)
      PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_subMaster)
      if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == matchMode then
        PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_kickAll)
        PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_teamChange)
        PaGlobal_Arsha_Func_All._ui_subMenu.btn_kickAll:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_TeamAllKick(2, " .. 0 .. ")")
      elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == matchMode then
        PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_teamChange)
        PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_teamMaster)
        PaGlobal_Arsha_Func_All._ui_subMenu.btn_teamMaster:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_TeamMaster(" .. userNo_s64 .. ",2)")
      end
    elseif true == isSubHost then
      PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_kick)
    end
  elseif 2 == controlType then
    contents = PaGlobal_Arsha_Func_All._ui._attenderSet.list2_waitList:GetContentByKey(toInt64(0, idx))
    if true == isHost then
      PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_kick)
      PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_subMaster)
      if CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll ~= matchMode then
        PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_teamChange)
      end
    elseif true == isSubHost then
      PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_kick)
    end
  elseif 3 == controlType then
    contents = PaGlobal_Arsha_Func_All._ui._attenderSet.list2_waitList:GetContentByKey(toInt64(0, idx))
    if true == isHost or true == isSubHost then
      PaGlobal_Arsha_Func_All._subMenuShowControl:push_back(PaGlobal_Arsha_Func_All._ui_subMenu.btn_kick)
    end
  end
  local shotBtnCount = PaGlobal_Arsha_Func_All._subMenuShowControl:length()
  if nil ~= contents and 0 < shotBtnCount then
    local btn_mainBg = UI.getChildControl(contents, "Button_Template")
    local stc_name = UI.getChildControl(btn_mainBg, "StaticText_CharName")
    local btnSizeY = PaGlobal_Arsha_Func_All._ui_subMenu.btn_kick:GetSizeY()
    local btnSizeX = PaGlobal_Arsha_Func_All._ui_subMenu.btn_kick:GetSizeX()
    local gabY = 5
    local panelSizeY = shotBtnCount * btnSizeY + (shotBtnCount - 1) * gabY + 4 * gabY
    Panel_Window_ArshaPvPSubMenu_All:SetSize(btnSizeX + 20, panelSizeY)
    Panel_Window_ArshaPvPSubMenu_All:SetPosX(stc_name:GetParentPosX())
    Panel_Window_ArshaPvPSubMenu_All:SetPosY(stc_name:GetParentPosY() + stc_name:GetSizeY())
    Panel_Window_ArshaPvPSubMenu_All:SetShow(true)
    if true == PaGlobal_Arsha_Func_All._isConsole then
      PaGlobal_Arsha_Func_All._ui_subMenu.stc_keyGuideBg:SetSize(Panel_Window_ArshaPvPSubMenu_All:GetSizeX(), PaGlobal_Arsha_Func_All._ui_subMenu.stc_keyGuideBg:GetSizeY())
      PaGlobal_Arsha_Func_All._ui_subMenu.stc_keyGuideBg:ComputePos()
      PaGlobal_Arsha_Func_All:setSubMenuAlignKeyGuide()
    end
    local startPosY = 2 * gabY
    for ii = 1, shotBtnCount do
      PaGlobal_Arsha_Func_All._subMenuShowControl[ii]:SetShow(true)
      PaGlobal_Arsha_Func_All._subMenuShowControl[ii]:SetPosY(startPosY)
      PaGlobal_Arsha_Func_All._subMenuShowControl[ii]:ComputePos()
      startPosY = startPosY + btnSizeY + gabY
    end
    PaGlobal_Arsha_Func_All._ui_subMenu.btn_kick:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_TeamUserKick(" .. idx .. ", " .. userNo_s64 .. ")")
    if CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll == matchMode then
      PaGlobal_Arsha_Func_All._ui_subMenu.btn_kickAll:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_TeamAllKick(" .. userNo_s64 .. ", " .. 1 .. ")")
    end
    PaGlobal_Arsha_Func_All._ui_subMenu.btn_teamChange:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_UserTeamChange(" .. idx .. ", " .. userNo_s64 .. ", " .. tostring(not isAssistant) .. ")")
    PaGlobal_Arsha_Func_All._ui_subMenu.btn_subMaster:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_UserUpgrade(" .. idx .. ", " .. userNo_s64 .. ", " .. tostring(not isAssistant) .. ")")
  end
end
function HandleEventLUp_Arsha_Func_All_TeamMaster(userNo, teamNo)
  if nil == userNo or nil == teamNo then
    return
  end
  PaGlobalFunc_Arsha_Func_All_SubMenuPowerClose()
  ToClient_SetPersonalMatchTeamMaster(userNo, teamNo)
end
function HandleEventLUp_Arsha_Func_All_TeamAllKick(teamNo, isMode)
  if nil == teamNo then
    return
  end
  PaGlobalFunc_Arsha_Func_All_SubMenuPowerClose()
  if 0 == teamNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_ALLKICK_NOWAITMEMBERKICK"))
    return
  end
  if 1 == isMode then
    local userinfo = ToClient_GetCompetitionDefinedUser(teamNo)
    teamNo = userinfo:getTeamNo()
  end
  local function KickTeamAll()
    ToClient_RequestLeaveTeam(teamNo)
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_ALLKICK_EXECUTE")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = KickTeamAll,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_Arsha_Func_All_TeamUserKick(idx, userNo_str)
  local userinfo = ToClient_GetCompetitionDefinedUser(userNo_str)
  PaGlobalFunc_Arsha_Func_All_SubMenuPowerClose()
  local characterName
  if nil ~= userinfo then
    characterName = userinfo:getCharacterName()
  end
  local function KickUserCompetition()
    ToClient_RequestLeavePlayer(userNo_str)
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_USERKICK_MESSAGEBOX", "name", characterName)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = KickUserCompetition,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_Arsha_Func_All_UserTeamChange(idx, userNo_str, isAssistant)
  PaGlobalFunc_Arsha_TeamChange_All_Open(idx, userNo_str, isAssistant)
  PaGlobalFunc_Arsha_Func_All_SubMenuPowerClose()
end
function HandleEventLUp_Arsha_Func_All_UserUpgrade(idx, userNo_str, isAssistant)
  local function ChangeAssistantUser()
    ToClient_RequestChangeAssistans(userNo_str, isAssistant)
  end
  PaGlobalFunc_Arsha_Func_All_SubMenuPowerClose()
  local userinfo = ToClient_GetCompetitionDefinedUser(userNo_str)
  local characterName = ""
  if nil ~= userinfo then
    characterName = userinfo:getCharacterName()
  end
  local message
  if true == isAssistant then
    message = "LUA_COMPETITION_REQUEST_SET_ASSISTANT"
  else
    message = "LUA_COMPETITION_REQUEST_RELEASE_ASSISTANT"
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, message, "name", characterName)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = ChangeAssistantUser,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandlePadEventY_Arsha_Func_All_FuncListOpen()
  PaGlobalFunc_Arsha_FuncList_All_Open()
end
function HandleEventLUp_Arsha_Func_All_GameSetModeChange(matchMode)
  local isHost = ToClient_IsCompetitionHost()
  local isSubHost = ToClient_IsCompetitionAssistant()
  Panel_NumberPad_Close()
  ToClient_CompetitionMatchTypeChange(matchMode)
  PaGlobalFunc_Arsha_Func_All_RequestCompititionOption()
end
function PaGlobalFunc_Arsha_Func_All_GameReSetTextETC(controlList)
  if nil == controlList then
    return
  end
  local lastIndex = #controlList
  local resetControl = controlList[lastIndex]
  resetControl:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARSHA_ROUNDCOUNT_ETC"))
end
function HandleEventLUp_Arsha_Func_All_GameSetLevelChange(selectIdx)
  Panel_NumberPad_Close()
  if 1 == selectIdx then
    PaGlobal_Arsha_Func_All._levelLimit = PaGlobal_Arsha_Func_All._setLevel[1]
  elseif 2 == selectIdx then
    PaGlobal_Arsha_Func_All._levelLimit = PaGlobal_Arsha_Func_All._setLevel[2]
  else
    local s64_maxNumber = toInt64(0, 65)
    Panel_NumberPad_Show(true, s64_maxNumber, param, PaGlobalFunc_Arsha_Func_All_LevelLimitConfirm)
    PaGlobal_NumberPad_All_CancleSetting(PaGlobal_Arsha_Func_All:updateGameSetMenuValue())
    return
  end
  PaGlobalFunc_Arsha_Func_All_GameReSetTextETC(PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameLevel)
  PaGlobalFunc_Arsha_Func_All_RequestCompititionOption()
end
function HandleEventLUp_Arsha_Func_All_GameSetRoundChange(selectIdx)
  Panel_NumberPad_Close()
  if 1 == selectIdx then
    PaGlobal_Arsha_Func_All._targetScore = PaGlobal_Arsha_Func_All._setRound[1]
  elseif 2 == selectIdx then
    PaGlobal_Arsha_Func_All._targetScore = PaGlobal_Arsha_Func_All._setRound[2]
  elseif 3 == selectIdx then
    PaGlobal_Arsha_Func_All._targetScore = PaGlobal_Arsha_Func_All._setRound[3]
  elseif 4 == selectIdx then
    PaGlobal_Arsha_Func_All._targetScore = PaGlobal_Arsha_Func_All._setRound[4]
  else
    local s64_maxNumber = toInt64(0, 10)
    Panel_NumberPad_Show(true, s64_maxNumber, param, PaGlobalFunc_Arsha_Func_All_RoundCountConfirm)
    PaGlobal_NumberPad_All_CancleSetting(PaGlobal_Arsha_Func_All:updateGameSetMenuValue())
    return
  end
  PaGlobalFunc_Arsha_Func_All_GameReSetTextETC(PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameRound)
  PaGlobalFunc_Arsha_Func_All_RequestCompititionOption()
end
function HandleEventLUp_Arsha_Func_All_GameSetLifePartyChange(selectIdx)
  Panel_NumberPad_Close()
  if 1 == selectIdx then
    PaGlobal_Arsha_Func_All._lifeLimit = PaGlobal_Arsha_Func_All._setLife[1]
  elseif 2 == selectIdx then
    PaGlobal_Arsha_Func_All._lifeLimit = PaGlobal_Arsha_Func_All._setLife[2]
  elseif 3 == selectIdx then
    PaGlobal_Arsha_Func_All._lifeLimit = PaGlobal_Arsha_Func_All._setLife[3]
  elseif 4 == selectIdx then
    PaGlobal_Arsha_Func_All._lifeLimit = PaGlobal_Arsha_Func_All._setLife[4]
  else
    local s64_maxNumber = toInt64(0, 10)
    Panel_NumberPad_Show(true, s64_maxNumber, param, PaGlobalFunc_Arsha_Func_All_LifePartyCountConfirm)
    PaGlobal_NumberPad_All_CancleSetting(PaGlobal_Arsha_Func_All:updateGameSetMenuValue())
    return
  end
  PaGlobalFunc_Arsha_Func_All_GameReSetTextETC(PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameLife)
  PaGlobalFunc_Arsha_Func_All_RequestCompititionOption(PaGlobal_Arsha_Func_All._lifeLimit)
end
function HandleEventLUp_Arsha_Func_All_GameSetTimeLimitChange(selectIdx)
  Panel_NumberPad_Close()
  if 1 == selectIdx then
    PaGlobal_Arsha_Func_All._timeLimit = PaGlobal_Arsha_Func_All._setTime[1]
  elseif 2 == selectIdx then
    PaGlobal_Arsha_Func_All._timeLimit = PaGlobal_Arsha_Func_All._setTime[2]
  elseif 3 == selectIdx then
    PaGlobal_Arsha_Func_All._timeLimit = PaGlobal_Arsha_Func_All._setTime[3]
  elseif 4 == selectIdx then
    PaGlobal_Arsha_Func_All._timeLimit = PaGlobal_Arsha_Func_All._setTime[4]
  else
    local s64_maxNumber = toInt64(0, 60)
    Panel_NumberPad_Show(true, s64_maxNumber, param, PaGlobalFunc_Arsha_Func_All_LimitTimeCountConfirm)
    PaGlobal_NumberPad_All_CancleSetting(PaGlobal_Arsha_Func_All:updateGameSetMenuValue())
    return
  end
  PaGlobalFunc_Arsha_Func_All_GameReSetTextETC(PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameTime)
  PaGlobalFunc_Arsha_Func_All_RequestCompititionOption()
end
function HandleEventLUp_Arsha_Func_All_GameSetMaxMemberChange(selectIdx)
  Panel_NumberPad_Close()
  if 1 == selectIdx then
    PaGlobal_Arsha_Func_All._maxPartyMemberCount = PaGlobal_Arsha_Func_All._setMember[1]
  elseif 2 == selectIdx then
    PaGlobal_Arsha_Func_All._maxPartyMemberCount = PaGlobal_Arsha_Func_All._setMember[2]
  elseif 3 == selectIdx then
    PaGlobal_Arsha_Func_All._maxPartyMemberCount = PaGlobal_Arsha_Func_All._setMember[3]
  elseif 4 == selectIdx then
    PaGlobal_Arsha_Func_All._maxPartyMemberCount = PaGlobal_Arsha_Func_All._setMember[4]
  else
    local s64_maxNumber = toInt64(0, 5)
    Panel_NumberPad_Show(true, s64_maxNumber, param, PaGlobalFunc_Arsha_Func_All_PartyMemberCountConfirm)
    PaGlobal_NumberPad_All_CancleSetting(PaGlobal_Arsha_Func_All:updateGameSetMenuValue())
    return
  end
  PaGlobalFunc_Arsha_Func_All_GameReSetTextETC(PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameMember)
  PaGlobalFunc_Arsha_Func_All_RequestCompititionOption()
end
function HandleEventOnOut_Arsha_Func_All_GameSetModeTooltip(isShow, mode)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == mode then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARSHA_TEAMMODE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_ROUND_DESC")
    control = PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameType[mode + 1]
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll == mode then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARSHA_ALIVEMODE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_FREE_DESC")
    control = PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameType[mode + 1]
  end
  if nil == control then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_Arsha_Func_All_GameSetTooltip(isShow, setType)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 1 == setType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_LIMITLEVEL_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_LIMITLEVEL_DESC")
    control = PaGlobal_Arsha_Func_All._ui._gameSet.txt_gameLevelTitle
  elseif 2 == setType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_ROUNDTYPE_ROUND_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_ROUNDTYPE_ROUND_DESC")
    control = PaGlobal_Arsha_Func_All._ui._gameSet.txt_gameRoundTitle
  elseif 3 == setType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_ROUNDTYPE_FREE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_ROUNDTYPE_FREE_DESC")
    control = PaGlobal_Arsha_Func_All._ui._gameSet.txt_gameLifeTitle
  elseif 4 == setType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_LIMITTIME_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_LIMITTIME_DESC")
    control = PaGlobal_Arsha_Func_All._ui._gameSet.txt_gameTimeTitle
  elseif 5 == setType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_LIMITMEMBER_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_LIMITMEMBER_DESC")
    control = PaGlobal_Arsha_Func_All._ui._gameSet.txt_gameMemberTitle
  end
  if nil == control then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_Arsha_Func_All_LevelLimitConfirm(inputNumber, param)
  PaGlobal_Arsha_Func_All._levelLimit = Int64toInt32(inputNumber)
  local lastIndex = #PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameLevel
  PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameLevel[lastIndex]:SetText(PaGlobal_Arsha_Func_All._levelLimit)
  PaGlobalFunc_Arsha_Func_All_RequestCompititionOption()
end
function PaGlobalFunc_Arsha_Func_All_RoundCountConfirm(inputNumber, param)
  PaGlobal_Arsha_Func_All._targetScore = Int64toInt32(inputNumber)
  local lastIndex = #PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameRound
  PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameRound[lastIndex]:SetText(PaGlobal_Arsha_Func_All._targetScore)
  PaGlobalFunc_Arsha_Func_All_RequestCompititionOption()
end
function PaGlobalFunc_Arsha_Func_All_LifePartyCountConfirm(inputNumber, param)
  PaGlobal_Arsha_Func_All._targetScore = Int64toInt32(inputNumber)
  local lastIndex = #PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameLife
  PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameLife[lastIndex]:SetText(PaGlobal_Arsha_Func_All._targetScore)
  PaGlobalFunc_Arsha_Func_All_RequestCompititionOption()
end
function PaGlobalFunc_Arsha_Func_All_LimitTimeCountConfirm(inputNumber, param)
  PaGlobal_Arsha_Func_All._timeLimit = Int64toInt32(inputNumber)
  local lastIndex = #PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameTime
  PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameTime[lastIndex]:SetText(PaGlobal_Arsha_Func_All._timeLimit)
  PaGlobalFunc_Arsha_Func_All_RequestCompititionOption()
end
function PaGlobalFunc_Arsha_Func_All_PartyMemberCountConfirm(inputNumber, param)
  PaGlobal_Arsha_Func_All._maxPartyMemberCount = Int64toInt32(inputNumber)
  local lastIndex = #PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameMember
  PaGlobal_Arsha_Func_All._ui._gameSet.rdo_gameMember[lastIndex]:SetText(PaGlobal_Arsha_Func_All._maxPartyMemberCount)
  PaGlobalFunc_Arsha_Func_All_RequestCompititionOption()
end
function PaGlobalFunc_Arsha_Func_All_RequestCompititionOption(targetScore)
  if nil == targetScore then
    targetScore = PaGlobal_Arsha_Func_All._targetScore
  end
  local limitTimeSum = PaGlobal_Arsha_Func_All._timeLimit * 60
  ToClient_RequestCompetitionOption(PaGlobal_Arsha_Func_All._isOpen, limitTimeSum, targetScore, PaGlobal_Arsha_Func_All._levelLimit, PaGlobal_Arsha_Func_All._maxPartyMemberCount, PaGlobal_Arsha_Func_All._maxWaitTime)
end
function PaGlobalFunc_Arsha_Func_All_InviteMemberUiEdit(targetUI)
  return nil ~= targetUI and targetUI:GetKey() == PaGlobal_Arsha_Func_All._ui._attenderSet.edit_inviteName:GetKey()
end
function PaGlobalFunc_Arsha_Func_All_ClearFocusEdit()
  PaGlobal_Arsha_Func_All._ui._attenderSet.edit_inviteName:SetEditText("")
  ClearFocusEdit()
  CheckChattingInput()
end
function getArshaPvpOption()
  local option = {}
  option._isOpen = PaGlobal_Arsha_Func_All._isOpen
  option._timeLimit = PaGlobal_Arsha_Func_All._timeLimit
  option._targetScore = PaGlobal_Arsha_Func_All._targetScore
  option._levelLimit = PaGlobal_Arsha_Func_All._levelLimit
  option._maxPartyMemberCount = PaGlobal_Arsha_Func_All._maxPartyMemberCount
  option._maxWaitTime = PaGlobal_Arsha_Func_All._maxWaitTime
  return option
end
function PaGlobalFunc_Arsha_Func_All_UpdateList()
  PaGlobal_Arsha_Func_All:updateList()
end
function PaGlobalFunc_Arsha_Func_All_WaitUpdate(contents, key)
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  local idx = Int64toInt32(key)
  local isWaitList = PaGlobal_Arsha_Func_All._ui._attenderSet.rdo_waiter:IsCheck()
  local btn_mainBg = UI.getChildControl(contents, "Button_Template")
  local txt_level = UI.getChildControl(btn_mainBg, "StaticText_Level")
  local txt_class = UI.getChildControl(btn_mainBg, "StaticText_Class")
  local txt_name = UI.getChildControl(btn_mainBg, "StaticText_CharName")
  local listType, listInfo
  if true == isWaitList then
    listType = 2
    listInfo = ToClient_GetTeamUserInfoAt(0, idx)
  else
    listType = 3
    listInfo = ToClient_GetObserverListAt(idx)
  end
  if nil == listInfo then
    _PA_ASSERT_NAME(false, "\234\180\128\236\160\132\236\158\144/\235\140\128\234\184\176\236\158\144 \236\160\149\235\179\180\234\176\128 nil\236\157\180\235\157\188\235\139\136 \236\157\180\236\131\129\237\149\152\235\139\164", "\236\160\149\236\167\128\237\152\156")
    return
  end
  if true == isWaitList and 0 ~= listInfo:getTeamNo() then
    return
  end
  local userNo = listInfo:getUserNo()
  local userLevel = listInfo:getCharacterLevel()
  local userClass = listInfo:getCharacterClass()
  local characterName = listInfo:getCharacterName()
  local isAssistant = listInfo:isAssistant()
  txt_level:SetText(userLevel)
  txt_name:SetText(characterName)
  PaGlobalFunc_Util_ChangeTextureClass(txt_class, userClass)
  if true == listInfo:isHost() then
    txt_name:SetFontColor(Defines.Color.C_FFFFD237)
  elseif listInfo:isAssistant() then
    txt_name:SetFontColor(Defines.Color.C_FFB5FF6D)
  else
    txt_name:SetFontColor(Defines.Color.C_FFFFFFFF)
  end
  local isHost = ToClient_IsCompetitionHost()
  local isSubHost = ToClient_IsCompetitionAssistant()
  local eventControl = btn_mainBg
  if false == PaGlobal_Arsha_Func_All._isConsole then
    txt_name:SetIgnore(false)
    eventControl = txt_name
  end
  if true == isHost or true == isSubHost then
    eventControl:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_TeamSubMenuShow( " .. idx .. ", " .. listType .. ", " .. tostring(userNo) .. ", " .. tostring(isAssistant) .. " )")
  else
    eventControl:addInputEvent("Mouse_LUp", "")
  end
end
function PaGlobalFunc_Arsha_Func_All_TeamAListUpdate(contents, key)
  PaGlobal_Arsha_Func_All._curUpdateListIdx = PaGlobal_Arsha_Func_All._teamListType.RED
  PaGlobalFunc_Arsha_Func_All_TeamListUpdate(contents, key)
end
function PaGlobalFunc_Arsha_Func_All_TeamBListUpdate(contents, key)
  PaGlobal_Arsha_Func_All._curUpdateListIdx = PaGlobal_Arsha_Func_All._teamListType.BLUE
  PaGlobalFunc_Arsha_Func_All_TeamListUpdate(contents, key)
end
function PaGlobalFunc_Arsha_Func_All_TeamListUpdate(contents, key)
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  if nil == PaGlobal_Arsha_Func_All._curUpdateListIdx then
    return
  end
  if PaGlobal_Arsha_Func_All._curUpdateListIdx > PaGlobal_Arsha_Func_All._teamListType.COUNT then
    return
  end
  local idx = Int64toInt32(key)
  local matchMode = ToClient_CompetitionMatchType()
  local listInfo, teamInfo
  local btn_mainBg = UI.getChildControl(contents, "Button_Template")
  local txt_class = UI.getChildControl(btn_mainBg, "StaticText_Class")
  local txt_name = UI.getChildControl(btn_mainBg, "StaticText_CharName")
  local txt_level = UI.getChildControl(btn_mainBg, "StaticText_Level")
  local stc_teamMaster = UI.getChildControl(btn_mainBg, "Static_Reader")
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == matchMode then
    listInfo = ToClient_GetTeamUserInfoAt(PaGlobal_Arsha_Func_All._curUpdateListIdx, idx)
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll == matchMode then
    if PaGlobal_Arsha_Func_All._teamListType.RED == PaGlobal_Arsha_Func_All._curUpdateListIdx then
      teamInfo = ToClient_GetTeamListAt(idx)
      if nil == teamInfo then
        return
      end
      listInfo = ToClient_GetTeamLeaderInfo(teamInfo:getTeamNo())
    else
      listInfo = ToClient_GetEntryListAt(idx)
    end
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == matchMode then
    listInfo = ToClient_GetTeamUserInfoAt(PaGlobal_Arsha_Func_All._curUpdateListIdx, idx)
    teamInfo = ToClient_GetArshaTeamInfo(PaGlobal_Arsha_Func_All._curUpdateListIdx)
    if nil == teamInfo then
      return
    end
  end
  if nil == listInfo then
    _PA_ASSERT_NAME(false, "\237\140\128\236\155\144 \236\160\149\235\179\180\234\176\128 nil\236\157\180\235\157\188\235\139\136 \236\157\180\236\131\129\237\149\152\235\139\164", "\236\160\149\236\167\128\237\152\156")
    return
  end
  local userNo = listInfo:getUserNo()
  local userLevel = listInfo:getCharacterLevel()
  local userClass = listInfo:getCharacterClass()
  local userName = listInfo:getUserName()
  local characterName = listInfo:getCharacterName()
  local isAssistant = listInfo:isAssistant()
  txt_level:SetText(userLevel)
  PaGlobalFunc_Util_ChangeTextureClass(txt_class, userClass)
  txt_name:SetText(characterName)
  if true == listInfo:isHost() then
    txt_name:SetFontColor(Defines.Color.C_FFFFD237)
  elseif listInfo:isAssistant() then
    txt_name:SetFontColor(Defines.Color.C_FFB5FF6D)
  else
    txt_name:SetFontColor(Defines.Color.C_FFFFFFFF)
  end
  stc_teamMaster:SetShow(false)
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == matchMode then
    if userNo == teamInfo:getTeamMaster() then
      stc_teamMaster:SetShow(true)
    end
    if true == listInfo:isDeadInPersonalMatch() then
      txt_name:SetFontColor(Defines.Color.C_FF444444)
    end
  end
  local isHost = ToClient_IsCompetitionHost()
  local isSubHost = ToClient_IsCompetitionAssistant()
  local listType = PaGlobal_Arsha_Func_All._curUpdateListIdx - 1
  local eventControl = btn_mainBg
  if false == PaGlobal_Arsha_Func_All._isConsole then
    txt_name:SetIgnore(false)
    eventControl = txt_name
  end
  if true == isHost or true == isSubHost then
    eventControl:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_TeamSubMenuShow( " .. idx .. ", " .. listType .. ", " .. tostring(userNo) .. ", " .. tostring(isAssistant) .. " )")
  else
    eventControl:addInputEvent("Mouse_LUp", "")
  end
end
function FromClient_Arsha_Func_All_UpdateTeamUserList()
  if not Panel_Window_Arsha_Func_All:GetShow() then
    return
  end
  PaGlobalFunc_Arsha_Func_All_UpdateList()
end
function FromClient_Arsha_Func_All_ChangeMatchType()
  if not Panel_Window_Arsha_Func_All:GetShow() then
    return
  end
  PaGlobal_Arsha_Func_All:update()
end
function FromClient_Arsha_Func_All_UpdateTeamScore(teamNum, scoreValue, round, winTeamHP, loseTeamHP)
  if 0 == teamNum then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAMSCORE_DRAW", "currentRound", round))
  else
    local matchMode = ToClient_CompetitionMatchType()
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
    local teamWinString = teamB_Name
    local teamLoseString = teamA_Name
    if 1 == teamNum then
      teamWinString = teamA_Name
      teamLoseString = teamB_Name
    end
    if 0 == matchMode then
      Proc_ShowMessage_Ack(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAMSCORE", "currentRound", round, "teamNo", teamWinString, "score", scoreValue))
    elseif 1 == matchMode then
      local leaderInfo = ToClient_GetTeamLeaderInfo(teamNum)
      Proc_ShowMessage_Ack(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAMSCORE", "currentRound", round, "teamNo", leaderInfo:getCharacterName(), "score", scoreValue))
    elseif 2 == matchMode then
      Proc_ShowMessage_Ack(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAMSCORE", "currentRound", round, "teamNo", teamWinString, "score", scoreValue))
    end
    Proc_ShowMessage_Ack(PAGetStringParam4(Defines.StringSheet_GAME, "LUA_ARSHA_TEAMWIN_PERCENT_HP", "teamNameA", teamWinString, "hpA", winTeamHP, "teamNameB", teamLoseString, "hpB", loseTeamHP))
  end
end
function FromClient_Arsha_Func_All_CompetitionMatchDone(teamNo, rank, teamHpPercent)
  if 0 == teamNo then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_MATCH_DONE_DRAW", "teamNo", teamNo))
    return
  end
  local matchMode = ToClient_CompetitionMatchType()
  if 0 == matchMode then
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
    local winTeamName = teamB_Name
    if 1 == teamNo then
      winTeamName = teamA_Name
    end
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_MATCH_DONE", "teamNo", winTeamName))
  elseif 1 == matchMode then
    local leaderInfo = ToClient_GetTeamLeaderInfo(teamNo)
    if nil ~= leaderInfo then
      Proc_ShowMessage_Ack(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_COMPETITION_MATCH_DONE_FREEFORALL", "rank", rank, "hpPercent", tostring(teamHpPercent), "leaderName", leaderInfo:getCharacterName()))
    end
  elseif 2 == matchMode then
    local teamA_Info = ToClient_GetArshaTeamInfo(1)
    local teamB_Info = ToClient_GetArshaTeamInfo(2)
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
    local winTeamName = teamB_Name
    if 1 == teamNo then
      winTeamName = teamA_Name
    end
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_MATCH_DONE", "teamNo", winTeamName))
  end
end
function FromClient_Arsha_Func_All_CompetitionOptionChange(isOpen, matchTimeLimit, targetScore, levelLimit, maxPartyMemberCount, maxWaitTime)
  PaGlobal_Arsha_Func_All._ui._attenderSet.chk_lock:SetCheck(isOpen)
  PaGlobal_Arsha_Func_All._isOpen = isOpen
  PaGlobal_Arsha_Func_All._targetScore = targetScore
  PaGlobal_Arsha_Func_All._levelLimit = levelLimit
  PaGlobal_Arsha_Func_All._maxPartyMemberCount = maxPartyMemberCount
  PaGlobal_Arsha_Func_All._maxWaitTime = maxWaitTime
  local isHost = ToClient_IsCompetitionHost()
  if true == isHost then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SETTING_GAME_ACK"))
  end
  PaGlobal_Arsha_Func_All:update()
  PaGlobalFunc_Arsha_Hud_All_Update()
end
function FromClient_Arsha_Func_All_CompetitionUseItemModeChange(isCanUseItemMode)
  if true == isCanUseItemMode then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_CHANGED_CANUSEITEMMODE"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_CHANGED_CANNOTUSEITEMMODE"))
  end
end
function FromClient_Arsha_Func_All_JoinNewPlayer(characterName, isEntryUser)
  if true == isEntryUser then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_JOINNEWPLAYER_ENTRY", "characterName", characterName))
  else
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_JOINNEWPLAYER_OBSERVER", "characterName", characterName))
  end
end
function FromClient_Arsha_Func_All_KillHistory(deadUserInfo, attackerUserInfo)
  if nil == attackerUserInfo then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_USERDEAD_SELF", "characterName", deadUserInfo:getCharacterName()))
  else
    Proc_ShowMessage_Ack(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_COMPETITION_USERDEAD_ATTACKED", "attackerName", attackerUserInfo:getCharacterName(), "deadUserName", deadUserInfo:getCharacterName()))
  end
end
function FromClient_Arsha_Func_All_EntryUserChangeTeam(userInfo)
  local matchMode = ToClient_CompetitionMatchType()
  if 1 == matchMode or nil == userInfo then
    return
  end
  local message = ""
  local teamNo = userInfo:getTeamNo()
  if 0 == teamNo then
    message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_CHANGE_TO_WAITING", "playerName", userInfo:getCharacterName())
  else
    local teamInfo = ToClient_GetArshaTeamInfo(teamNo)
    local teamName = ""
    if nil ~= teamInfo then
      teamName = teamInfo:getTeamName()
    end
    if "" == teamName then
      if 1 == teamNo then
        teamName = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_A")
      elseif 2 == teamNo then
        teamName = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_B")
      end
    end
    message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_COMPETITION_USER_CHANGETEAM", "characterName", userInfo:getCharacterName(), "teamNo", teamName)
  end
  chatting_sendMessage("", message, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
end
function FromClient_Arsha_Func_All_GetOutUserFromCompetition(outUserInfo)
  if nil == outUserInfo then
    return
  end
  if true == outUserInfo:isHost() then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_GAMEHOST_LEAVE", "characterName", outUserInfo:getCharacterName()))
  else
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GETOUT_FROM_COMPETITION", "characterName", outUserInfo:getCharacterName()))
  end
end
function FromClient_Arsha_Func_All_ChangeAssistant(userInfo)
end
function FromClient_Arsha_Func_All_NotifyUseSkill(userName, skillName)
  local message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ARSHA_NOTIFYUSESKILL_MESSAGE", "userName", userName, "skillName", skillName)
  chatting_sendMessage("", message, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
end
function FromClient_Arsha_Func_All_NotifyUseSkillCoolTime()
end
function FromClient_Arsha_Func_All_ChangeTeamName()
  PaGlobal_Arsha_Func_All:update()
  PaGlobalFunc_Arsha_Hud_All_Update()
end
function FromClient_Arsha_Func_All_CompetitionMatchDoneToObserver(winteamno, matchResult)
  if __eCompetitionResult_Draw == matchResult then
    local msg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_DRAW_MAIN"),
      sub = "",
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, 46, false)
  else
    local teamA_Info = ToClient_GetArshaTeamInfo(1)
    local teamB_Info = ToClient_GetArshaTeamInfo(2)
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
    local winTeamName = teamB_Name
    if 1 == winteamno then
      winTeamName = teamA_Name
    end
    local msg = {
      main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_MATCH_DONE", "teamNo", winTeamName),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_FIGHTSTATE_STOP_MAIN"),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, 45, false)
  end
end
