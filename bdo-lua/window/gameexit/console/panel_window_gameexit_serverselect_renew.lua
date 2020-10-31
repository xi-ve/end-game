Panel_ServerSelect_Renew:SetShow(false)
local serverSelect = {
  _ui = {
    _static_Title = UI.getChildControl(Panel_ServerSelect_Renew, "Static_Title"),
    _static_StatusIconGroup = UI.getChildControl(Panel_ServerSelect_Renew, "Static_StatusIconGroup"),
    _radioButton_ServerOlvia = UI.getChildControl(Panel_ServerSelect_Renew, "RadioButton_ServerOlvia"),
    _radioButton_ServerArsha = UI.getChildControl(Panel_ServerSelect_Renew, "RadioButton_ServerArsha"),
    _radioButton_ServerNormal = UI.getChildControl(Panel_ServerSelect_Renew, "RadioButton_ServerNormal"),
    _saticText_WorldDesc = UI.getChildControl(Panel_ServerSelect_Renew, "StaticText_WorldDesc"),
    _saticText_WorldDesc2 = UI.getChildControl(Panel_ServerSelect_Renew, "StaticText_WorldDesc2"),
    _satic_BottomGroup = UI.getChildControl(Panel_ServerSelect_Renew, "Static_BottomGroup"),
    _static_InviteIcon = UI.getChildControl(Panel_ServerSelect_Renew, "Static_FriendInvite"),
    _txt_CrossplayKey = nil
  },
  _config = {_buttonRowMaxCount = 3, _buttonColMaxCount = 14},
  _serverList = {},
  _channelSelectUIPool = {},
  _selectChannel = -1,
  _inviteWorldIdx = nil,
  _inviteServerIdx = nil
}
function serverSelect:setPosition()
  local scrSizeX = getScreenSizeX()
  local scrSizeY = getScreenSizeY()
  Panel_ServerSelect_Renew:SetSize(scrSizeX, scrSizeY)
  Panel_ServerSelect_Renew:ComputePos()
  self._ui._static_StatusIconGroup:ComputePos()
  self._ui._satic_BottomGroup:ComputePos()
  self._ui._saticText_WorldDesc:ComputePos()
  self._ui._saticText_WorldDesc2:ComputePos()
  local panelSizeX = Panel_ServerSelect_Renew:GetSizeX()
  local panelSizeY = Panel_ServerSelect_Renew:GetSizeY()
  Panel_ServerSelect_Renew:SetPosX(scrSizeX / 2 - panelSizeX / 2)
  Panel_ServerSelect_Renew:SetPosY(scrSizeY / 2 - panelSizeY / 2)
  local curChannelData = getCurrentChannelServerData()
  if nil == curChannelData then
    return
  end
  local channelCount = self._config._buttonRowMaxCount * self._config._buttonColMaxCount
  for index = 0, channelCount - 1 do
    local channelList = self._channelSelectUIPool[index]
    if nil == channelList then
      return
    end
    local rowIndex = index % self._config._buttonRowMaxCount
    local colIndex = math.floor(index / self._config._buttonRowMaxCount)
    local posX = scrSizeX * 0.5 - self._ui._radioButton_ServerOlvia:GetSizeX() * 2 + self._ui._radioButton_ServerOlvia:GetSizeX() * 1.5 * rowIndex
    local posY = scrSizeY * 0.3 + self._ui._radioButton_ServerOlvia:GetSizeY() * 1.2 * colIndex
    for _, control in pairs(channelList) do
      control:SetPosX(posX)
      control:SetPosY(posY)
    end
  end
end
function serverSelect:initialize()
  self:setPosition()
  local curChannelData = getCurrentChannelServerData()
  if nil == curChannelData then
    return
  end
  local channelCount = self._config._buttonRowMaxCount * self._config._buttonColMaxCount
  local scrSizeX = getScreenSizeX()
  local scrSizeY = getScreenSizeY()
  for index = 0, channelCount - 1 do
    local channelList = {}
    channelList._button_Olvia = UI.cloneControl(self._ui._radioButton_ServerOlvia, Panel_ServerSelect_Renew, "Button_Olvia_" .. index)
    channelList._button_Arsha = UI.cloneControl(self._ui._radioButton_ServerArsha, Panel_ServerSelect_Renew, "Button_Arsha_" .. index)
    channelList._button_Normal = UI.cloneControl(self._ui._radioButton_ServerNormal, Panel_ServerSelect_Renew, "Button_Normal_" .. index)
    local rowIndex = index % self._config._buttonRowMaxCount
    local colIndex = math.floor(index / self._config._buttonRowMaxCount)
    local posX = scrSizeX * 0.5 - self._ui._radioButton_ServerOlvia:GetSizeX() * 2 + self._ui._radioButton_ServerOlvia:GetSizeX() * 1.5 * rowIndex
    local posY = scrSizeY * 0.3 + self._ui._radioButton_ServerOlvia:GetSizeY() * 1.2 * colIndex
    for _, control in pairs(channelList) do
      control:SetPosX(posX)
      control:SetPosY(posY)
      control:SetShow(false)
    end
    self._channelSelectUIPool[index] = channelList
  end
  self._ui._radioButton_ServerOlvia:SetShow(false)
  self._ui._radioButton_ServerArsha:SetShow(false)
  self._ui._radioButton_ServerNormal:SetShow(false)
  self._ui._txt_CrossplayKey = UI.getChildControl(self._ui._satic_BottomGroup, "StaticText_Crossplay_ConsoleUI")
  self._ui._txt_IconCrossplay = UI.getChildControl(self._ui._static_StatusIconGroup, "StaticText_NoAccessForCrossplay")
  self._ui._txt_CrossplayKey:SetShow(false)
  self._ui._txt_IconCrossplay:SetShow(false)
  if true == ToClient_isTotalGameClient() then
    self._ui._txt_IconCrossplay:SetShow(true)
  end
  local icons = {
    UI.getChildControl(self._ui._static_StatusIconGroup, "StaticText_PvP"),
    UI.getChildControl(self._ui._static_StatusIconGroup, "StaticText_NoEnterance"),
    UI.getChildControl(self._ui._static_StatusIconGroup, "StaticText_War"),
    UI.getChildControl(self._ui._static_StatusIconGroup, "StaticText_ExpEvent"),
    UI.getChildControl(self._ui._static_StatusIconGroup, "StaticText_Maintenance"),
    UI.getChildControl(self._ui._static_StatusIconGroup, "StaticText_NoAccessForCrossplay")
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(icons, self._ui._static_StatusIconGroup, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_LEFT, 44, 5)
  local keyGuides = {
    UI.getChildControl(self._ui._satic_BottomGroup, "StaticText_Crossplay_ConsoleUI"),
    UI.getChildControl(self._ui._satic_BottomGroup, "StaticText_Select_ConsoleUI"),
    UI.getChildControl(self._ui._satic_BottomGroup, "StaticText_Exit_ConsoleUI")
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._satic_BottomGroup, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function serverSelect:resetData()
  self._selectChannel = -1
end
function PaGlobalFunc_ServerSelect_Open()
  serverSelect:resetData()
  serverSelect:open()
end
function serverSelect:open()
  if isDeadInWatchingMode() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHANNELCHANGEOPENALERT_INDEAD"))
    return
  end
  local rv = ToClient_CheckToMoveChannel()
  if 0 ~= rv then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictedToMoveChannelOnBossSpawnPeriod"))
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoingAlterOfBlood"))
    return
  end
  if false == ToClient_isCrossNetworkPlayAllowed() then
    setSamePlatformOnly(false)
  end
  Panel_ServerSelect_Renew:SetShow(true)
  self:update()
end
function PaGlobalFunc_ServerSelect_GetShow()
  return Panel_ServerSelect_Renew:GetShow()
end
function PaGlobalFunc_ServerSelect_Close()
  serverSelect:close()
end
function serverSelect:close()
  if false == Panel_ServerSelect_Renew:GetShow() then
    return
  end
  self._inviteWorldIdx = nil
  self._inviteServerIdx = nil
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  Panel_ServerSelect_Renew:SetShow(false)
end
function PaGlobalFunc_ServerSelect_Update()
end
function serverSelect:update()
  local curChannelData = getCurrentChannelServerData()
  if nil == curChannelData then
    return
  end
  local curWorldData = getGameWorldServerDataByWorldNo(curChannelData._worldNo)
  local channelCount = getGameChannelServerDataCount(curWorldData._worldNo)
  local restrictedServerNo = curWorldData._restrictedServerNo
  local curServerNo = curChannelData._serverNo
  local channelMoveableGlobalTime = getChannelMoveableTime(curWorldData._worldNo)
  local channelMoveableRemainTime = getChannelMoveableRemainTime(curWorldData._worldNo)
  local changeRealChannelTime = convertStringFromDatetime(channelMoveableRemainTime)
  local _worldServerCount = getGameWorldServerDataCount()
  self._serverList = {}
  local tempTable = {}
  local crossplayTable = {}
  local serverIndex = 0
  local tempIndex = 0
  local crossplayIndex = 0
  for chIndex = 0, channelCount - 1 do
    local serverData = getGameChannelServerDataByWorldNo(curChannelData._worldNo, chIndex)
    if true == serverData._isSpeedChannel then
      self._serverList[serverIndex] = chIndex
      serverIndex = serverIndex + 1
    elseif __ePlatformType_COUNT == serverData._servicePlatformType then
      if false == serverData._isInstanceChannel or true == ToClient_SelfPlayerIsGM() then
        crossplayTable[crossplayIndex] = chIndex
        crossplayIndex = crossplayIndex + 1
      end
    elseif false == serverData._isInstanceChannel or true == ToClient_SelfPlayerIsGM() then
      if true == _ContentsGroup_ConsoleIntegration then
        local selfPlayerPlatform = ToClient_getGamePlatformType()
        if selfPlayerPlatform == serverData._servicePlatformType then
          tempTable[tempIndex] = chIndex
          tempIndex = tempIndex + 1
        end
      else
        tempTable[tempIndex] = chIndex
        tempIndex = tempIndex + 1
      end
    end
  end
  local isCrossplayMode = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
  if true == ToClient_isTotalGameClient() and true == isCrossplayMode then
    for idx = 0, crossplayIndex - 1 do
      self._serverList[serverIndex + idx] = crossplayTable[idx]
    end
    for idx = 0, tempIndex - 1 do
      self._serverList[serverIndex + crossplayIndex + idx] = tempTable[idx]
    end
  else
    for idx = 0, tempIndex - 1 do
      self._serverList[serverIndex + idx] = tempTable[idx]
    end
    for idx = 0, crossplayIndex - 1 do
      self._serverList[serverIndex + tempIndex + idx] = crossplayTable[idx]
    end
  end
  channelCount = serverIndex + tempIndex + crossplayIndex
  local temporaryWrapper = getTemporaryInformationWrapper()
  for chIndex = 0, channelCount - 1 do
    local serverData = getGameChannelServerDataByWorldNo(curChannelData._worldNo, self._serverList[chIndex])
    if nil ~= serverData then
      local channelInfo = self._channelSelectUIPool[chIndex]
      for _, control in pairs(channelInfo) do
        control:SetShow(false)
      end
      local currButton
      if true == serverData._isSpeedChannel then
        currButton = channelInfo._button_Olvia
        if 0 ~= temporaryWrapper:getMyAdmissionToSpeedServer() then
          currButton:SetMonoTone(false)
          currButton:SetIgnore(false)
        else
          currButton:SetMonoTone(true)
          currButton:SetIgnore(true)
        end
      elseif true == serverData._isDontPvPTendencyDecrease then
        currButton = channelInfo._button_Arsha
      else
        currButton = channelInfo._button_Normal
      end
      local isAdmission = true
      local isSiegeBeing = deadMessage_isSiegeBeingMyChannel()
      local isInSiegeBattle = deadMessage_isInSiegeBattle()
      if true == isSiegeBeing and false == isInSiegeBattle then
        isAdmission = true
      elseif restrictedServerNo ~= 0 and toInt64(0, 0) ~= channelMoveableGlobalTime then
        if restrictedServerNo == serverData._serverNo then
          isAdmission = true
        elseif channelMoveableRemainTime > toInt64(0, 0) then
          isAdmission = false
        else
          isAdmission = true
        end
      end
      local channelName = UI.getChildControl(currButton, "StaticText_ChannelName")
      local channelState = UI.getChildControl(currButton, "StaticText_Crowded")
      local channelIconMain = UI.getChildControl(currButton, "Static_IconMaintenance")
      local channelNoEnter = UI.getChildControl(currButton, "Static_IconNoEnterance")
      local channelCrossplay = UI.getChildControl(currButton, "Static_IconNoAccessForCrossplay")
      if curChannelData._worldNo == serverData._worldNo and curChannelData._serverNo == serverData._serverNo then
        currButton:addInputEvent("Mouse_LUp", "")
        currButton:SetCheck(true)
      else
        currButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_ChannelSelect( " .. chIndex .. " )")
        currButton:SetCheck(false)
      end
      local channelNameStr = getChannelName(serverData._worldNo, serverData._serverNo)
      if nil == channelNameStr then
        channelNameStr = ""
      end
      local busyState = serverData._busyState
      local tempStr = ""
      channelIconMain:SetShow(false)
      if busyState == 0 or curChannelData:isClosed() then
        tempStr = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_BUSYSTATE_0")
        channelIconMain:SetShow(true)
      elseif busyState == 1 then
        tempStr = ""
      elseif busyState == 2 then
        tempStr = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_BUSYSTATE_2")
      elseif busyState == 3 then
        tempStr = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_BUSYSTATE_3")
      elseif busyState == 4 then
        tempStr = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_BUSYSTATE_4")
      end
      self._ui._static_InviteIcon:SetShow(false)
      if nil ~= self._inviteWorldIdx and nil ~= self._inviteServerIdx then
        local inviteServerData = getGameChannelServerDataByIndex(self._inviteWorldIdx, self._inviteServerIdx)
        if nil ~= inviteServerData and inviteServerData._serverNo == serverData._serverNo then
          self._ui._static_InviteIcon:SetPosXY(currButton:GetPosX() - 15, currButton:GetPosY() - 15)
          self._ui._static_InviteIcon:SetShow(true)
        end
      end
      currButton:SetShow(true)
      channelName:SetText(channelNameStr)
      channelName:SetShow(true)
      channelState:SetText(tempStr)
      channelState:SetShow(true)
      channelNoEnter:SetShow(not isAdmission)
      channelCrossplay:SetShow(false)
      local channelIcon = UI.getChildControl(currButton, "Static_Icon")
      if true == serverData._isSpeedChannel then
        channelIcon:SetShow(true)
      elseif true == serverData._isDontPvPTendencyDecrease then
        channelIcon:SetShow(true)
      else
        channelIcon:SetShow(serverData._isSiegeBeing)
      end
      if true == ToClient_isTotalGameClient() then
        local isCrossplayMode = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
        if __ePlatformType_COUNT == serverData._servicePlatformType and false == isCrossplayMode then
          channelIconMain:SetShow(false)
          channelCrossplay:SetShow(true)
        end
      end
    end
  end
end
function PaGlobalFunc_ChannelSelect(chIndex)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  serverSelect:channelSelect(chIndex)
end
function serverSelect:channelSelect(chIndex)
  self:update()
  if true == isChannelMoveOnlySafe() then
    local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
    if false == regionInfo:get():isSafeZone() and false == ToClient_SelfPlayerIsGM() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXITSERVERSELECT_SAFEREGION"))
      return
    end
  end
  if true == PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoPlayerIsDoingTutorial"))
    return
  end
  self._selectChannel = self._serverList[chIndex]
  if nil == self._selectChannel or -1 == self._selectChannel then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CASH_CUSTOMIZATION_NOSELECT"))
    return
  end
  local curChannelData = getCurrentChannelServerData()
  local channelData = getGameChannelServerDataByWorldNo(curChannelData._worldNo, self._selectChannel)
  local channelName = getChannelName(channelData._worldNo, channelData._serverNo)
  local changeChannelTime = getChannelMoveableRemainTime(curChannelData._worldNo)
  local changeRealChannelTime = convertStringFromDatetime(changeChannelTime)
  if true == ToClient_isTotalGameClient() then
    local gamePlatformType = ToClient_getGamePlatformType()
    if nil ~= channelData then
      local servicePlatformType = channelData._servicePlatformType
      if gamePlatformType ~= servicePlatformType then
        local canCrossPlay = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
        if __ePlatformType_COUNT == servicePlatformType and false == canCrossPlay then
          local messageBoxData = {
            title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
            content = PAGetString(Defines.StringSheet_GAME, "LUA_CROSSPLAY_CANT_SELECTSERVER"),
            functionApply = MessageBox_Empty_function,
            priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
          }
          MessageBox.showMessageBox(messageBoxData)
          return
        elseif __ePlatformType_COUNT ~= servicePlatformType then
          local messageBoxData = {
            title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
            content = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_CANT_CONNECTABLE_PLATFORM"),
            functionApply = MessageBox_Empty_function,
            priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
          }
          MessageBox.showMessageBox(messageBoxData)
          return
        end
      end
    end
  end
  local isSiegeBeing = deadMessage_isSiegeBeingMyChannel()
  local isInSiegeBattle = deadMessage_isInSiegeBattle()
  if nil ~= channelData then
    local busyState = channelData._busyState
    local isSpecialCharacter = getTemporaryInformationWrapper():isSpecialCharacter()
    if busyState == 0 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_DONTJOIN"))
      return
    elseif true == getSelfPlayer():get():isBattleGroundDefine() and true == channelData._isSiegeChannel and false == isSpecialCharacter then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_BATTLEGROURND"))
      return
    end
  end
  if true == ToClient_SelfPlayerCheckAction("READ_BOOK") then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXITSERVERSELECT_READBOOK_WARNNING")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if true == isSiegeBeing and false == isInSiegeBattle then
    local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_MSG", "channelName", tostring(channelName))
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"),
      content = messageBoxMemo,
      functionYes = PaGlobalFunc_ServerSelect_MoveChannel,
      functionNo = PaGlobalFunc_ServerSelect_Update,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  elseif changeChannelTime > toInt64(0, 0) then
    local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANGECHANNEL_PENALTY", "changeRealChannelTime", changeRealChannelTime)
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"),
      content = messageBoxMemo,
      functionYes = PaGlobalFunc_ServerSelect_Update,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_MSG", "channelName", tostring(channelName))
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"),
      content = messageBoxMemo,
      functionYes = PaGlobalFunc_ServerSelect_MoveChannel,
      functionNo = PaGlobalFunc_ServerSelect_Update,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function PaGlobalFunc_ServerSelect_MoveChannel()
  serverSelect:moveChannel()
end
function serverSelect:moveChannel()
  if false == _ContentsGroup_RenewUI_ExitGame then
    if true == _ContentsGroup_NewUI_GameExit then
      PaGlobal_GameExit_ALL_SaveCurrentData()
    else
      FGlobal_gameExit_saveCurrentData()
    end
  elseif true == _ContentsGroup_NewUI_GameExit then
    PaGlobal_GameExit_ALL_SaveCurrentData()
  else
    PaGlobalFunc_GameExit_SaveCurrentData()
  end
  gameExit_MoveChannel(self._selectChannel)
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELWAIT_MSG")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"),
    content = messageBoxMemo,
    functionYes = nil,
    functionClose = nil,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_luaLoadComplete_ServerSelect()
  serverSelect:initialize()
end
function PaGlobalFunc_ServerSelect_Resize()
  serverSelect:setPosition()
end
function serverSelect:registEventHandler()
  registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_ServerSelect")
  registerEvent("FromClient_ShowXboxInviteMessage", "FromClient_GameExitServerSelect_ShowXboxInviteMessage")
  registerEvent("onScreenResize", "PaGlobalFunc_ServerSelect_Resize")
end
function FromClient_GameExitServerSelect_ShowXboxInviteMessage(worldIdx, serverIdx, userName, channelName)
  local self = serverSelect
  self._inviteWorldIdx = worldIdx
  self._inviteServerIdx = serverIdx
  local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WINDOW_XBOXCHANNELINVITE", "userName", tostring(userName), "channelName", tostring(channelName))
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"),
    content = messageBoxMemo,
    functionYes = PaGlobal_GameExitServerSelect_ApplyInvite,
    functionNo = PaGlobal_GameExitServerSelect_DeclineInvite,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_GameExitServerSelect_ApplyInvite()
  close_attacked_WindowPanelList(true)
  PaGlobalFunc_ServerSelect_Open()
end
function PaGlobal_GameExitServerSelect_DeclineInvite()
  local self = serverSelect
  self._inviteWorldNo = nil
  self._inviteServerNo = nil
end
function serverSelect:setCrossplayOption()
  local isCrossplayMode = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
  if false == setSamePlatformOnly(not isCrossplayMode) then
    ToClient_showPrivilegeError(false, true)
    return
  end
  if true == isCrossplayMode then
    self._ui._txt_CrossplayKey:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CROSSPLAY_OPTIONON"))
  else
    self._ui._txt_CrossplayKey:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CROSSPLAY_OPTIONOFF"))
  end
end
function HandleEventLUp_GameExit_ServerSelect_All_SetCrossplayOption()
  serverSelect:setCrossplayOption()
  serverSelect:update()
end
serverSelect:registEventHandler()
