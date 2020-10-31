function HandleEventLUp_ServerSelect_All_EnterMainServer()
  if PaGlobal_ServerSelect_All:autoConnectToLastServer() then
    return
  end
  local mainServerNo = ToClient_getUserSubCacheData(__eMainServerNo)
  if -1 == mainServerNo then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_MAINSERVERTITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_MAINSERVERALERT"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local worldServerIdx = PaGlobal_ServerSelect_All._treeData[PaGlobal_ServerSelect_All._selectedWorldIndex].worldIndex
  local worldServerData = getGameWorldServerDataByIndex(worldServerIdx - 1)
  local restrictedServerNo = worldServerData._restrictedServerNo
  if 0 ~= restrictedServerNo and mainServerNo ~= restrictedServerNo then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_MAINSERVERTITLE"),
      content = PAGetString(Defines.StringSheet_SymbolNo, "eErrNoChannelMoveableTimeIsInvalid"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  for ii = 1, #PaGlobal_ServerSelect_All._treeData do
    if nil ~= PaGlobal_ServerSelect_All._treeData[ii].channelIndex then
      local serverData = getGameChannelServerDataByIndex(worldServerIdx - 1, PaGlobal_ServerSelect_All._treeData[ii].channelIndex - 1)
      if nil ~= serverData and mainServerNo == serverData._serverNo and false == PaGlobal_ServerSelect_All._isConnecting then
        PaGlobal_ServerSelect_All:enterMemorizedChannel(PaGlobal_ServerSelect_All._treeData[ii].channelIndex)
        break
      end
    end
  end
end
function HandleEventLUp_ServerSelect_All_ChangeMainServer()
  if PaGlobal_ServerSelect_All._BUTTON_STATE.MAINSERVER_SELECT ~= PaGlobal_ServerSelect_All._currentButtonState then
    PaGlobal_ServerSelect_All._currentButtonState = PaGlobal_ServerSelect_All._BUTTON_STATE.MAINSERVER_SELECT
  else
    PaGlobal_ServerSelect_All._currentButtonState = PaGlobal_ServerSelect_All._BUTTON_STATE.NORMAL
  end
  PaGlobal_ServerSelect_All._selectedChannelIndex = nil
  PaGlobal_ServerSelect_All:updateListData()
end
function HandleEventLUp_ServerSelect_All_EnterLastJoinedServer()
  local tempWrapper = getTemporaryInformationWrapper()
  local lastJoinServerNo = tempWrapper:getLastServerNo()
  if 1 == lastJoinServerNo then
    return
  end
  for ii = 1, #PaGlobal_ServerSelect_All._treeData do
    if nil ~= PaGlobal_ServerSelect_All._treeData[ii].channelIndex then
      local serverData = getGameChannelServerDataByIndex(PaGlobal_ServerSelect_All._selectedWorldIndex - 1, PaGlobal_ServerSelect_All._treeData[ii].channelIndex - 1)
      if nil ~= serverData and lastJoinServerNo == serverData._serverNo and false == PaGlobal_ServerSelect_All._isConnecting then
        PaGlobal_ServerSelect_All:enterMemorizedChannel(PaGlobal_ServerSelect_All._treeData[ii].channelIndex)
        break
      end
    end
  end
end
function HandleEventLUp_GameExit_ServerSelect_All_SetCrossplayOption()
  PaGlobal_ServerSelect_All:setCrossplayOption()
  FromClient_ServerSelect_All_EventUpdateServerInfo()
end
function HandleEventLUp_ServerSelect_All_EnterRandomServer()
  if isGameServiceTypeKor() and false == ToClient_IsDevelopment() and false == ToClient_CanEnterNonAdultWorld() then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_CANT_CONNECTABLE_TIME"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if false == PaGlobal_ServerSelect_All._isConnecting then
    PaGlobal_ServerSelect_All._isConnecting = true
    local rv = selectRandomServer(PaGlobal_ServerSelect_All._selectedWorldIndex - 1)
    if -1 == rv then
      PaGlobal_ServerSelect_All._isConnecting = false
    end
  end
end
function HandleEventLUp_ServerSelect_All_SelectChannel(key32)
  if nil == key32 then
    if nil ~= PaGlobal_ServerSelect_All._selectedChannelIndex then
      local oldSelect = PaGlobal_ServerSelect_All._selectedChannelIndex
      PaGlobal_ServerSelect_All._selectedChannelIndex = nil
      PaGlobal_ServerSelect_All._ui._tree_serverList:requestUpdateByKey(toInt64(0, oldSelect))
    end
    PaGlobal_ServerSelect_All._ui._txt_serverName:SetText("")
    for ii = 2, #PaGlobal_ServerSelect_All._ui._stc_channelDesc do
      PaGlobal_ServerSelect_All._ui._stc_channelDesc[ii]:SetShow(false)
    end
    if true == _ContentsGroup_SeasonContents then
      PaGlobal_ServerSelect_All._ui._stc_channelDesc[PaGlobal_ServerSelect_All._CHANNEL_TYPE.SEASONCHANNEL]:SetShow(false)
      PaGlobal_ServerSelect_All._ui._stc_channelDesc[PaGlobal_ServerSelect_All._CHANNEL_TYPE.SEASON_ARSHA_CHANNEL]:SetShow(false)
    end
    return
  end
  PaGlobal_ServerSelect_All._listContentsTarget[key32] = PaGlobal_ServerSelect_All._listContentsBaseX - 10
  PaGlobal_ServerSelect_All._listContentsFlag[key32] = true
  if nil == PaGlobal_ServerSelect_All._treeData[key32] then
    return
  end
  local worldServerIdx = PaGlobal_ServerSelect_All._treeData[key32].worldIndex
  local channelServerIdx = PaGlobal_ServerSelect_All._treeData[key32].channelIndex
  local worldServerData = getGameWorldServerDataByIndex(worldServerIdx - 1)
  local channelServerData = getGameChannelServerDataByIndex(worldServerIdx - 1, channelServerIdx - 1)
  local channelName = getChannelName(worldServerData._worldNo, channelServerData._serverNo)
  PaGlobal_ServerSelect_All._ui._txt_serverName:SetText(channelName)
  if PaGlobal_ServerSelect_All._BUTTON_STATE.MAINSERVER_SELECT == PaGlobal_ServerSelect_All._currentButtonState then
    PaGlobal_ServerSelect_All._selectedChannelIndex = nil
    for ii = 2, #PaGlobal_ServerSelect_All._ui._stc_channelDesc do
      PaGlobal_ServerSelect_All._ui._stc_channelDesc[ii]:SetShow(false)
    end
    if true == _ContentsGroup_SeasonContents then
      PaGlobal_ServerSelect_All._ui._stc_channelDesc[PaGlobal_ServerSelect_All._CHANNEL_TYPE.SEASONCHANNEL]:SetShow(false)
      PaGlobal_ServerSelect_All._ui._stc_channelDesc[PaGlobal_ServerSelect_All._CHANNEL_TYPE.SEASON_ARSHA_CHANNEL]:SetShow(false)
    end
    PaGlobal_ServerSelect_All:setMainServer(worldServerIdx, channelServerIdx)
    return
  end
  if false == PaGlobal_ServerSelect_All._isConsole and (PaGlobal_ServerSelect_All._selectedWorldIndex ~= worldServerIdx or PaGlobal_ServerSelect_All._selectedChannelIndex ~= channelServerIdx) then
    PaGlobal_ServerSelect_All._selectedWorldIndex = worldServerIdx
    PaGlobal_ServerSelect_All._selectedChannelIndex = channelServerIdx
    local channelServerData = getGameChannelServerDataByIndex(worldServerIdx - 1, channelServerIdx - 1)
    if nil == channelServerData then
      return
    end
    local isBeingWar = channelServerData._isSiegeBeing
    local isVillageStart = channelServerData._isVillageSiege
    local channelType
    if channelServerData._isSeasonChannel and true == _ContentsGroup_SeasonContents then
      if channelServerData._isSeasonChannel and channelServerData._isDontPvPTendencyDecrease then
        channelType = PaGlobal_ServerSelect_All._CHANNEL_TYPE.SEASON_ARSHA_CHANNEL
      else
        channelType = PaGlobal_ServerSelect_All._CHANNEL_TYPE.SEASONCHANNEL
      end
    elseif channelServerData._isSpeedChannel then
      channelType = PaGlobal_ServerSelect_All._CHANNEL_TYPE.OLVIA_CHANNEL
    elseif channelServerData._isPcroomChannel then
      channelType = PaGlobal_ServerSelect_All._CHANNEL_TYPE.PC_ROOM_CHANNEL
    elseif channelServerData._isDontPvPTendencyDecrease then
      channelType = PaGlobal_ServerSelect_All._CHANNEL_TYPE.ARSHA_CHANNEL
    elseif channelServerData._isSiegeChannel then
      channelType = PaGlobal_ServerSelect_All._CHANNEL_TYPE.WAR_INFO
    end
    for ii = 2, #PaGlobal_ServerSelect_All._ui._stc_channelDesc do
      PaGlobal_ServerSelect_All._ui._stc_channelDesc[ii]:SetShow(false)
    end
    if true == _ContentsGroup_SeasonContents then
      PaGlobal_ServerSelect_All._ui._stc_channelDesc[PaGlobal_ServerSelect_All._CHANNEL_TYPE.SEASONCHANNEL]:SetShow(false)
      PaGlobal_ServerSelect_All._ui._stc_channelDesc[PaGlobal_ServerSelect_All._CHANNEL_TYPE.SEASON_ARSHA_CHANNEL]:SetShow(false)
    end
    if nil ~= PaGlobal_ServerSelect_All._ui._stc_channelDesc[channelType] then
      PaGlobal_ServerSelect_All._ui._stc_channelDesc[channelType]:SetShow(true)
      PaGlobal_ServerSelect_All._ui._stc_channelDesc[channelType]:SetAlphaExtraChild(0)
      UIAni.AlphaAnimation(1, PaGlobal_ServerSelect_All._ui._stc_channelDesc[channelType], 0, 0.8)
    end
    PaGlobal_ServerSelect_All._currentButtonState = PaGlobal_ServerSelect_All._BUTTON_STATE.SELECTED
    PaGlobal_ServerSelect_All._ui._tree_serverList:getElementManager():refillKeyList()
  else
    local channelServerData = getGameChannelServerDataByIndex(worldServerIdx - 1, channelServerIdx - 1)
    if nil == channelServerData then
      return
    end
    if channelServerData._isPcroomChannel and true == isGameServiceTypeKor() and false == ToClient_isPCRoomLoginUserServerSelect() then
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_CANT_CONNECTABLE_PCROOM"),
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
      HandleEventLUp_ServerSelect_All_SelectChannel(nil)
      return
    end
    if true == ToClient_isTotalGameClient() then
      local gamePlatformType = ToClient_getGamePlatformType()
      local servicePlatformType = channelServerData._servicePlatformType
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
    HandleEventLUp_ServerSelect_All_EnterChannel(key32)
  end
end
function HandleEventLUp_ServerSelect_All_EnterChannel(key32)
  if nil == PaGlobal_ServerSelect_All._treeData[key32] then
    return
  end
  local worldIndex = PaGlobal_ServerSelect_All._treeData[key32].worldIndex
  local serverIdx = PaGlobal_ServerSelect_All._treeData[key32].channelIndex
  if isGameServiceTypeKor() and false == ToClient_isAdultUser() and false == ToClient_CanEnterNonAdultWorld() then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_CANT_CONNECTABLE_TIME"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  selectServerGroup(worldIndex - 1, serverIdx - 1)
end
function HandleEventOn_ServerSelect_All_OverChannelControl(key32)
  if false == PaGlobal_ServerSelect_All:isHitTest(PaGlobal_ServerSelect_All._listContents[key32]) then
    return
  end
  if PaGlobal_ServerSelect_All._ani._startAnimationFinished then
    for ii = 1, #PaGlobal_ServerSelect_All._listContentsTarget do
      PaGlobal_ServerSelect_All._listContentsTarget[ii] = PaGlobal_ServerSelect_All._listContentsBaseX
    end
  end
  local oldIndex = PaGlobal_ServerSelect_All._currentHoveredKey32
  PaGlobal_ServerSelect_All._currentHoveredKey32 = key32
  if nil ~= oldIndex then
    PaGlobal_ServerSelect_All._ui._tree_serverList:requestUpdateByKey(toInt64(0, oldIndex))
  end
  PaGlobal_ServerSelect_All._ui._tree_serverList:requestUpdateByKey(toInt64(0, key32))
  if true == PaGlobal_ServerSelect_All._isConsole then
    PaGlobal_ServerSelect_All._ui._txt_serverName:SetText("")
    for ii = 2, #PaGlobal_ServerSelect_All._ui._stc_channelDesc do
      PaGlobal_ServerSelect_All._ui._stc_channelDesc[ii]:SetShow(false)
    end
    if true == _ContentsGroup_SeasonContents then
      PaGlobal_ServerSelect_All._ui._stc_channelDesc[PaGlobal_ServerSelect_All._CHANNEL_TYPE.SEASONCHANNEL]:SetShow(false)
      PaGlobal_ServerSelect_All._ui._stc_channelDesc[PaGlobal_ServerSelect_All._CHANNEL_TYPE.SEASON_ARSHA_CHANNEL]:SetShow(false)
    end
    if nil == PaGlobal_ServerSelect_All._treeData[key32] then
      return
    end
    local worldServerIdx = PaGlobal_ServerSelect_All._treeData[key32].worldIndex
    local channelServerIdx = PaGlobal_ServerSelect_All._treeData[key32].channelIndex
    local worldServerData = getGameWorldServerDataByIndex(worldServerIdx - 1)
    local channelServerData = getGameChannelServerDataByIndex(worldServerIdx - 1, channelServerIdx - 1)
    if nil == channelServerData or nil == worldServerData then
      return
    end
    local channelName = getChannelName(worldServerData._worldNo, channelServerData._serverNo)
    PaGlobal_ServerSelect_All._ui._txt_serverName:SetText(channelName)
    local channelType
    if channelServerData._isSpeedChannel then
      channelType = PaGlobal_ServerSelect_All._CHANNEL_TYPE.OLVIA_CHANNEL
    elseif channelServerData._isPcroomChannel then
      channelType = PaGlobal_ServerSelect_All._CHANNEL_TYPE.PC_ROOM_CHANNEL
    elseif channelServerData._isDontPvPTendencyDecrease then
      channelType = PaGlobal_ServerSelect_All._CHANNEL_TYPE.ARSHA_CHANNEL
    elseif channelServerData._isSiegeChannel then
      channelType = PaGlobal_ServerSelect_All._CHANNEL_TYPE.WAR_INFO
    end
    if nil ~= PaGlobal_ServerSelect_All._ui._stc_channelDesc[channelType] then
      PaGlobal_ServerSelect_All._ui._stc_channelDesc[channelType]:SetShow(true)
      PaGlobal_ServerSelect_All._ui._stc_channelDesc[channelType]:SetAlphaExtraChild(0)
      UIAni.AlphaAnimation(1, PaGlobal_ServerSelect_All._ui._stc_channelDesc[channelType], 0, 0.8)
    end
  end
end
function HandleEventOut_ServerSelect_All_OverChannelControl()
  if PaGlobal_ServerSelect_All._ani._startAnimationFinished then
    for ii = 1, PaGlobal_ServerSelect_All._listContentsCount do
      PaGlobal_ServerSelect_All._listContentsTarget[ii] = PaGlobal_ServerSelect_All._listContentsBaseX
      PaGlobal_ServerSelect_All._listContentsFlag[ii] = true
    end
  end
end
function HandleEventLUp_ServerSelect_All_SelectWorld(worldIndex)
  HandleEventLUp_ServerSelect_All_SelectChannel(nil)
  if isGameServiceTypeKor() and false == ToClient_IsDevelopment() then
    local isAdultUser = ToClient_isAdultUser()
    local isAdultWorld
    local serverData = getGameChannelServerDataByIndex(worldIndex - 1, 0)
    if serverData == nil then
      isAdultWorld = true
    else
      isAdultWorld = serverData._isAdultWorld
    end
    if isAdultUser ~= isAdultWorld then
      local msg = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_ADULT_CANT_CONNECT")
      if false == isAdultWorld then
        msg = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_NONADULT_CANT_CONNECT")
      end
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
        content = msg,
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
      return
    end
    if true == isAdultUser and true == isAdultWorld then
      PaGlobal_ServerSelect_All:updateSingleWorldDesc(false)
    elseif false == isAdultUser and false == isAdultWorld then
      PaGlobal_ServerSelect_All:updateSingleWorldDesc(true)
    end
    if false == isAdultUser and false == ToClient_CanEnterNonAdultWorld() then
      return
    end
  end
  PaGlobal_ServerSelect_All._currentButtonState = PaGlobal_ServerSelect_All._BUTTON_STATE.NORMAL
  local key = PaGlobal_ServerSelect_All._treeMainBranchKey[worldIndex]
  for ii = 1, #PaGlobal_ServerSelect_All._treeMainBranchKey do
    local mainElement = PaGlobal_ServerSelect_All._ui._tree_serverList:getElementManager():getByKey(toInt64(0, PaGlobal_ServerSelect_All._treeMainBranchKey[ii]), false)
    mainElement:setIsOpen(false)
  end
  local selectedElement = PaGlobal_ServerSelect_All._ui._tree_serverList:getElementManager():getByKey(toInt64(0, key))
  selectedElement:setIsOpen(true)
  PaGlobal_ServerSelect_All._ui._tree_serverList:getElementManager():refillKeyList()
  PaGlobal_ServerSelect_All._ui._tree_serverList:moveTopIndex()
  PaGlobal_ServerSelect_All._selectedWorldIndex = worldIndex
end
function HandleEventPad_ServerSelect_All_ToWebBanner(key, bannerIndex)
  if "CLICK" == key and not PaGlobal_ServerSelect_All._bannerIsReady[bannerIndex] then
    MessageBox.showMessageBox({
      content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WEBCONTROL_PAGE_NOT_READY"),
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    })
    return
  end
  PaGlobal_ServerSelect_All._ui._web_bannerList[bannerIndex]:TriggerEvent("FromClient_GamePadInputForWebBanner", key)
end
function FromClient_ServerSelect_All_Resize()
  PaGlobal_ServerSelect_All:resize()
end
function FromClient_ServerSelect_All_OnMovieEvent(param)
  PaGlobal_ServerSelect_All:onMovieEvent(param)
end
function FromClient_ServerSelect_All_PerFrameUpdate(deltaTime)
  PaGlobal_ServerSelect_All:updatePerFrame(deltaTime)
end
function FromClient_ServerSelect_All_EventUpdateServerInfo()
  if nil == Panel_Lobby_ServerSelect_All then
    return
  end
  if false == Panel_Lobby_ServerSelect_All:IsShow() then
    PaGlobal_ServerSelect_All:initialize()
    PaGlobal_ServerSelect_All:prepareOpen()
  else
    PaGlobal_ServerSelect_All:initTreeData()
  end
end
function FromClient_ServerSelect_All_ShowXboxInviteMessage(worldIdx, serverIdx, userName, channelName)
  PaGlobal_ServerSelect_All._inviteWorldIdx = worldIdx
  PaGlobal_ServerSelect_All._inviteServerIdx = serverIdx
  if true == ToClient_isPS4() then
    PaGlobal_ServerSelect_All_ApplyInvite()
    return
  end
  local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WINDOW_XBOXCHANNELINVITE", "userName", tostring(userName), "channelName", tostring(channelName))
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"),
    content = messageBoxMemo,
    functionYes = PaGlobal_ServerSelect_All_ApplyInvite,
    functionNo = PaGlobal_ServerSelect_All_DeclineInvite,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_ServerSelect_All_ClickBannerServerSelect(linkType, link)
  if Defines.ConsoleBannerLinkType.InGameWeb == linkType then
    PaGlobalFunc_WebControl_Open(link)
  else
    MessageBox.showMessageBox({
      content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WEBCONTROL_PAGE_NOT_READY"),
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    })
  end
end
function FromClient_ServerSelect_All_IsReadyForXBOX(bannerType, bannerIndex)
  if 0 == bannerType then
    PaGlobal_ServerSelect_All._bannerIsReady[bannerIndex] = true
  end
end
function PaGlobal_ServerSelect_All_ShowAni()
  if nil == Panel_Lobby_ServerSelect_All then
    return
  end
end
function PaGlobal_ServerSelect_All_HideAni()
  if nil == Panel_Lobby_ServerSelect_All then
    return
  end
end
function PaGlobal_ServerSelect_All_CreateControlServerList(content, key)
  PaGlobal_ServerSelect_All:createControlServerList(content, key)
end
function PaGlobal_ServerSelect_All_ApplyInvite()
  local worldIdx = PaGlobal_ServerSelect_All._inviteWorldIdx
  local serverIdx = PaGlobal_ServerSelect_All._inviteServerIdx
  local worldServerData = getGameWorldServerDataByIndex(worldIdx)
  local serverData = getGameChannelServerDataByIndex(worldIdx, serverIdx)
  if nil == serverData then
    Proc_ShowMessage_Ack("Not correct Server data.")
    return
  end
  if true == ToClient_isTotalGameClient() then
    local canCrossPlay = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
    local gamePlatformType = ToClient_getGamePlatformType()
    local servicePlatformType = serverData._servicePlatformType
    if gamePlatformType ~= servicePlatformType then
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
  local changeChannelTime = getChannelMoveableRemainTime(worldServerData._worldNo)
  local isAdmission = true
  local restrictedServerNo = worldServerData._restrictedServerNo
  if restrictedServerNo ~= 0 then
    if restrictedServerNo == serverData._serverNo then
      isAdmission = true
    elseif changeChannelTime > toInt64(0, 0) then
      isAdmission = false
    else
      isAdmission = true
    end
  end
  if false == isAdmission then
    local changeRealChannelTime = convertStringFromDatetime(changeChannelTime)
    local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANGECHANNEL_PENALTY", "changeRealChannelTime", changeRealChannelTime)
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"),
      content = messageBoxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if serverData._isSpeedChannel and 0 == temporaryWrapper:getMyAdmissionToSpeedServer() then
    Proc_ShowMessage_Ack("You cannot join this Server.")
    return
  end
  if true == _ContentsGroup_Console_WebBanner then
    for ii = 0, #PaGlobal_ServerSelect_All._ui._web_bannerList do
      PaGlobal_ServerSelect_All._ui._web_bannerList[ii]:ResetUrl()
    end
    PaGlobal_ServerSelect_All._bannerIsReady = {}
  end
  selectServerGroup(worldIdx, serverIdx)
end
function PaGlobal_ServerSelect_All_DeclineInvite()
  PaGlobal_ServerSelect_All._inviteWorldIdx = nil
  PaGlobal_ServerSelect_All._inviteServerIdx = nil
end
function PaGlobal_ServerSelect_All_GetBannerPosX()
  return PaGlobal_ServerSelect_All._ui._stc_bannerArea:GetPosX()
end
function PaGlobal_ServerSelect_All_GetBannerPosY()
  return PaGlobal_ServerSelect_All._ui._stc_bannerArea:GetPosY()
end
function PaGlobal_ServerSelect_All_GetBannerSizeX()
  return PaGlobal_ServerSelect_All._ui._stc_bannerArea:GetSizeX()
end
function PaGlobal_ServerSelect_All_GetBannerSizeY()
  return PaGlobal_ServerSelect_All._ui._stc_bannerArea:GetSizeY()
end
