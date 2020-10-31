function PaGlobal_ServerSelect_All:initialize()
  if true == PaGlobal_ServerSelect_All._initialize then
    return
  end
  self._isConsole = isGameServiceTypeConsole()
  self:initDesriptionData()
  self:initBackGroundImage()
  self._isBlackSpiritEnable = ToClient_IsContentsGroupOpen("1015")
  self._ui._stc_movieBg = UI.getChildControl(Panel_Lobby_ServerSelect_All, "Static_MovieBG")
  self._ui._stc_leftBg = UI.getChildControl(Panel_Lobby_ServerSelect_All, "Static_LeftBg")
  self._ui._stc_rightBg = UI.getChildControl(Panel_Lobby_ServerSelect_All, "Static_RightBg")
  self._ui._stc_channelDesc[self._CHANNEL_TYPE.SINGLE_WORLD_SYSTEM] = UI.getChildControl(self._ui._stc_leftBg, "SINGLE_WORLD_SYSTEM")
  self._ui._stc_channelDesc[self._CHANNEL_TYPE.WAR_INFO] = UI.getChildControl(self._ui._stc_leftBg, "WAR_INFO")
  self._ui._stc_channelDesc[self._CHANNEL_TYPE.OLVIA_CHANNEL] = UI.getChildControl(self._ui._stc_leftBg, "OLVIA_CHANNEL")
  self._ui._stc_channelDesc[self._CHANNEL_TYPE.PC_ROOM_CHANNEL] = UI.getChildControl(self._ui._stc_leftBg, "PC_ROOM_CHANNEL")
  self._ui._stc_channelDesc[self._CHANNEL_TYPE.ARSHA_CHANNEL] = UI.getChildControl(self._ui._stc_leftBg, "ARSHA_CHANNEL")
  self._ui._stc_channelDesc[self._CHANNEL_TYPE.SEASONCHANNEL] = UI.getChildControl(self._ui._stc_leftBg, "SEASON_CHANNEL")
  self._ui._stc_channelDesc[self._CHANNEL_TYPE.SEASON_ARSHA_CHANNEL] = UI.getChildControl(self._ui._stc_leftBg, "SEASON_ARSHA_CHANNEL")
  self._ui._tree_serverList = UI.getChildControl(Panel_Lobby_ServerSelect_All, "List2_ServerList")
  self._ui._txt_serverName = UI.getChildControl(self._ui._stc_leftBg, "StaticText_ServerName")
  self._ui._pc._btn_mainServer = UI.getChildControl(self._ui._stc_rightBg, "Button_MainServer")
  self._ui._pc._btn_mainServerSelect = UI.getChildControl(self._ui._stc_rightBg, "Button_MainServerSelect")
  self._ui._pc._btn_recentServer = UI.getChildControl(self._ui._stc_rightBg, "Button_RecentServer")
  self._ui._pc._btn_randomServer = UI.getChildControl(self._ui._stc_rightBg, "Button_RandomServer")
  self._ui._console._txt_selectKey = UI.getChildControl(self._ui._stc_rightBg, "StaticText_Select_ConsoleUI")
  self._ui._console._txt_crossplayKey = UI.getChildControl(self._ui._stc_rightBg, "StaticText_Random_ConsoleUI")
  self._ui._console._txt_recentKey = UI.getChildControl(self._ui._stc_rightBg, "StaticText_Recent_ConsoleUI")
  self._ui._console._txt_backKey = UI.getChildControl(self._ui._stc_rightBg, "StaticText_Back_ConsoleUI")
  self._ui._stc_bannerArea = UI.getChildControl(Panel_Lobby_ServerSelect_All, "Static_BannerArea_Console")
  self._ui._stc_bannerAreaObt = UI.getChildControl(Panel_Lobby_ServerSelect_All, "Static_BannerArea2_Console")
  self._ui._stc_bannerSeason = UI.getChildControl(self._ui._stc_rightBg, "Static_BannerSeason")
  self._ui._stc_bannerSeason:SetShow(false)
  self._ui._txt_versionString = UI.getChildControl(Panel_Lobby_ServerSelect_All, "StaticText_VersionString")
  self._ui._pc._btn_mainServer:SetTextMode(__eTextMode_AutoWrap)
  self._ui._pc._btn_mainServer:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_NOMAINSERVER"))
  self._ui._pc._btn_mainServer:SetTextSpan(self._ui._pc._btn_mainServer:GetTextSpan().x, self._ui._pc._btn_mainServer:GetSizeY() * 0.5 - self._ui._pc._btn_mainServer:GetTextSizeY() * 0.5)
  self._ui._pc._btn_recentServer:SetTextMode(__eTextMode_AutoWrap)
  self._ui._pc._btn_recentServer:SetText(PAGetString(Defines.StringSheet_RESOURCE, "LUA_SERVERSELECT_LASTJOINSERVER_NONE"))
  self._ui._pc._btn_recentServer:SetTextSpan(self._ui._pc._btn_recentServer:GetTextSpan().x, self._ui._pc._btn_recentServer:GetSizeY() * 0.5 - self._ui._pc._btn_recentServer:GetTextSizeY() * 0.5)
  self._ui._console._txt_recentKey:SetTextMode(__eTextMode_AutoWrap)
  self._ui._console._txt_recentKey:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_BTN_LASTJOINSERVER"))
  local isUsePadSnapping = _ContentsGroup_UsePadSnapping
  for k, value in pairs(self._ui._pc) do
    value:SetShow(not isUsePadSnapping)
  end
  for k, value in pairs(self._ui._console) do
    value:SetShow(isUsePadSnapping)
  end
  for i = self._CHANNEL_TYPE.SINGLE_WORLD_SYSTEM, #self._ui._stc_channelDesc do
    self:updateChannelDesc(i)
    self._ui._stc_channelDesc[i]:SetShow(false)
  end
  if true == _ContentsGroup_SeasonContents then
    self:updateChannelDesc(PaGlobal_ServerSelect_All._CHANNEL_TYPE.SEASONCHANNEL)
    self:updateChannelDesc(PaGlobal_ServerSelect_All._CHANNEL_TYPE.SEASON_ARSHA_CHANNEL)
  end
  self._ui._stc_channelDesc[PaGlobal_ServerSelect_All._CHANNEL_TYPE.SEASONCHANNEL]:SetShow(false)
  self._ui._stc_channelDesc[PaGlobal_ServerSelect_All._CHANNEL_TYPE.SEASON_ARSHA_CHANNEL]:SetShow(false)
  if true == self._isConsole then
    self._ui._txt_versionString:SetShow(true)
    self._ui._txt_versionString:SetText("ver." .. tostring(ToClient_getVersionString()))
  else
    self._ui._txt_versionString:SetShow(false)
  end
  self._serverListGap = self._ui._stc_rightBg:GetSizeY() - self._ui._tree_serverList:GetSizeY()
  self._ui._stc_channelDesc[self._CHANNEL_TYPE.SINGLE_WORLD_SYSTEM]:SetShow(true)
  for i = 1, self._listContentsCount do
    self._listContentsLaunchTimeTable[i] = (i - 1) * 0.03
  end
  self._ui._stc_bannerArea:SetShow(false)
  self._ui._stc_bannerAreaObt:SetShow(false)
  if true == ToClient_IsContentsGroupOpen("7") then
    self._movieOrder = {
      1,
      2,
      3
    }
    self._movieURL = {
      "coui://UI_Movie/O_01.webm",
      "coui://UI_Movie/O_02.webm",
      "coui://UI_Movie/O_03.webm"
    }
    self._movieLength = {
      8000,
      7000,
      5000
    }
  end
  self._currentMovieIndex = 1
  self:shuffleOrder(self._movieOrder)
  self:initBanners()
  self:resize()
  self:initBanners_PC()
  self:playMovie()
  self:prepareOpen()
  PaGlobal_CheckGamerTag(true)
  PaGlobal_ServerSelect_All:registEventHandler()
  PaGlobal_ServerSelect_All:validate()
  PaGlobal_ServerSelect_All._initialize = true
end
function PaGlobal_ServerSelect_All:initDesriptionData()
  self._channelDescriptionData = {
    [self._CHANNEL_TYPE.SINGLE_WORLD_SYSTEM] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CHANNELSELECTTITLE"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CHANNELSELECTDESC")
    },
    [self._CHANNEL_TYPE.WAR_INFO] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_WARCHANNEL_TITLE"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_WARCHANNEL_TERRITORY_SUB_TITLE") .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_WARCHANNEL_TERRITORY_SUB_DESC_BALENOS") .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_WARCHANNEL_TERRITORY_SUB_DESC_SERENDIA") .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_WARCHANNEL_TERRITORY_SUB_DESC_CALPEON") .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_WARCHANNEL_TERRITORY_SUB_DESC_MEDIA") .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_WARCHANNEL_TERRITORY_SUB_DESC_VALENCIA") .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_WARCHANNEL_DATE_SUB_TITLE") .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_WARCHANNEL_DATE_SUB_DESC_TERRITORYWAR") .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_WARCHANNEL_DATE_SUB_DESC_NODEWAR")
    },
    [self._CHANNEL_TYPE.OLVIA_CHANNEL] = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_SPEEDCHANNEL_TITLE"),
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_SPEEDCHANNEL_DESC")
    },
    [self._CHANNEL_TYPE.PC_ROOM_CHANNEL] = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_SEVERSELECT_PCROOMSERVER"),
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_DESC")
    },
    [self._CHANNEL_TYPE.ARSHA_CHANNEL] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_PVPICON"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_PVPDESC")
    },
    [self._CHANNEL_TYPE.SEASONCHANNEL] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_SEASON_TITLE_A"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_SEASON_DESC")
    },
    [self._CHANNEL_TYPE.SEASON_ARSHA_CHANNEL] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_SEASON_ARSHA_TITLE"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_SEASON_ARSHA_DESC")
    }
  }
  if true == self._isConsole then
    self._channelDescriptionData[self._CHANNEL_TYPE.SINGLE_WORLD_SYSTEM].desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CHANNELSELECTDESC_CONSOLE")
  end
end
function PaGlobal_ServerSelect_All:registEventHandler()
  if nil == Panel_Lobby_ServerSelect_All then
    return
  end
  self._ui._pc._btn_mainServer:addInputEvent("Mouse_LUp", "HandleEventLUp_ServerSelect_All_EnterMainServer()")
  self._ui._pc._btn_mainServerSelect:addInputEvent("Mouse_LUp", "HandleEventLUp_ServerSelect_All_ChangeMainServer()")
  self._ui._pc._btn_recentServer:addInputEvent("Mouse_LUp", "HandleEventLUp_ServerSelect_All_EnterLastJoinedServer()")
  self._ui._pc._btn_randomServer:addInputEvent("Mouse_LUp", "HandleEventLUp_ServerSelect_All_EnterRandomServer()")
  registerEvent("EventUpdateServerInformationForServerSelect", "FromClient_ServerSelect_All_EventUpdateServerInfo")
  registerEvent("onScreenResize", "FromClient_ServerSelect_All_Resize")
  registerEvent("FromClient_UnpackUserGameVariable", "FromClient_ServerSelect_All_Resize")
  unregisterEvent("ToClient_EndGuideMovie", "FromClient_Login_All_OnMovieEvent")
  registerEvent("ToClient_EndGuideMovie", "FromClient_ServerSelect_All_OnMovieEvent")
  registerEvent("FromClient_ShowXboxInviteMessage", "FromClient_ServerSelect_All_ShowXboxInviteMessage")
  registerEvent("FromClient_WebUIBannerEventForXBOX", "FromClient_ServerSelect_All_ClickBannerServerSelect")
  registerEvent("FromClient_WebUIBannerIsReadyForXBOX", "FromClient_ServerSelect_All_IsReadyForXBOX")
  Panel_Lobby_ServerSelect_All:RegisterUpdateFunc("FromClient_ServerSelect_All_PerFrameUpdate")
  Panel_Lobby_ServerSelect_All:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventLUp_ServerSelect_All_EnterLastJoinedServer()")
  if true == ToClient_isTotalGameClient() then
    Panel_Lobby_ServerSelect_All:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventLUp_GameExit_ServerSelect_All_SetCrossplayOption()")
    local isCrossplayMode = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
    if true == isCrossplayMode then
      self._ui._console._txt_crossplayKey:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CROSSPLAY_OPTIONOFF"))
    else
      self._ui._console._txt_crossplayKey:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CROSSPLAY_OPTIONON"))
    end
  else
    Panel_Lobby_ServerSelect_All:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventLUp_ServerSelect_All_EnterRandomServer()")
    self._ui._console._txt_crossplayKey:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_BTN_RANDOMJOIN"))
  end
end
function PaGlobal_ServerSelect_All:prepareOpen()
  if nil == Panel_Lobby_ServerSelect_All then
    return
  end
  self:initTreeData()
  toClient_FadeInWithDarkTime(0.5, 1)
  self._isConnecting = false
  self._ui._txt_serverName:SetText("")
  self._stc_BackgroundImage[self._currentBackIndex]:SetShow(true)
  self._stc_BackgroundImage[self._currentBackIndex]:SetAlpha(1)
  self._animationDelay = 0.5
  self._animationDelayCount = 0
  local ImageMoveAni = self._ui._stc_rightBg:addMoveAnimation(0, 0.7, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(getScreenSizeX(), 0)
  ImageMoveAni:SetEndPosition(getScreenSizeX() - self._ui._stc_rightBg:GetSizeX(), 0)
  ImageMoveAni.IsChangeChild = true
  self._ui._stc_rightBg:CalcUIAniPos(ImageMoveAni)
  self:updateTextOnButtons()
  if false == ToClient_isCrossNetworkPlayAllowed() then
    setSamePlatformOnly(false)
  end
  self._isCrossplayMode = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
  PaGlobal_ServerSelect_All:open()
end
function PaGlobal_ServerSelect_All:open()
  if nil == Panel_Lobby_ServerSelect_All then
    return
  end
  Panel_Lobby_ServerSelect_All:SetShow(true)
end
function PaGlobal_ServerSelect_All:prepareClose()
  if nil == Panel_Lobby_ServerSelect_All then
    return
  end
  PaGlobal_ServerSelect_All:close()
end
function PaGlobal_ServerSelect_All:close()
  if nil == Panel_Lobby_ServerSelect_All then
    return
  end
  Panel_Lobby_ServerSelect_All:SetShow(false)
end
function PaGlobal_ServerSelect_All:update()
  if nil == Panel_Lobby_ServerSelect_All then
    return
  end
end
function PaGlobal_ServerSelect_All:validate()
  if nil == Panel_Lobby_ServerSelect_All then
    return
  end
end
function PaGlobal_ServerSelect_All:updateChannelDesc(channelType)
  local component = self._ui._stc_channelDesc[channelType]
  local txt_title = UI.getChildControl(component, "StaticText_Title")
  local txt_desc = UI.getChildControl(component, "StaticText_Desc")
  txt_title:SetTextMode(__eTextMode_AutoWrap)
  txt_title:SetText(self._channelDescriptionData[channelType].title)
  txt_desc:SetTextMode(__eTextMode_AutoWrap)
  txt_desc:SetText(self._channelDescriptionData[channelType].desc)
  if channelType == self._CHANNEL_TYPE.OLVIA_CHANNEL then
    txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_SPEEDCHANNEL_DESC"))
  elseif channelType == self._CHANNEL_TYPE.ARSHA_CHANNEL then
    if isGameTypeKorea() then
      txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_PVPDESC_ARSHASERVER"))
    else
      txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_PVPDESC"))
    end
  elseif channelType == self._CHANNEL_TYPE.PC_ROOM_CHANNEL then
    if isGameTypeEnglish() then
      txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_TITLE_NA"))
      txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_DESC_NA"))
    elseif self._isBlackSpiritEnable then
      txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_TITLE"))
      txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_DESC"))
    else
      txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_TITLE"))
      txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_DESC_NONEBLACKSPIRIT"))
    end
  elseif channelType == self._CHANNEL_TYPE.SEASONCHANNEL then
    if true == _ContentsGroup_SeasonContents then
      txt_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_SEASON_TITLE_A"))
      txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_SEASON_DESC"))
    end
  elseif channelType == self._CHANNEL_TYPE.SEASON_ARSHA_CHANNEL and true == _ContentsGroup_SeasonContents then
    txt_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_SEASON_ARSHA_TITLE"))
    txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_SEASON_ARSHA_DESC"))
  end
  txt_title:SetPosY(0)
  txt_desc:SetPosY(txt_title:GetTextSizeY() + self._defaultYGap)
  txt_desc:SetSize(txt_desc:GetSizeX(), txt_desc:GetTextSizeY())
  local val = txt_title:GetTextSizeY() + txt_desc:GetTextSizeY() + self._defaultYGap * 2
  component:SetSize(component:GetSizeX(), val)
  component:ComputePos()
end
function PaGlobal_ServerSelect_All:shuffleOrder(table)
  if nil == table or nil == #table then
    return
  end
  if #table < 2 then
    return
  end
  for ii = 1, #table do
    local temp = table[ii]
    local posToShuffle = getRandomValue(1, #table)
    table[ii] = table[posToShuffle]
    table[posToShuffle] = temp
  end
end
function PaGlobal_ServerSelect_All:resize()
  if nil == Panel_Lobby_ServerSelect_All then
    return
  end
  Panel_Lobby_ServerSelect_All:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui._stc_rightBg:SetSize(self._ui._stc_rightBg:GetSizeX(), getScreenSizeY())
  self._ui._stc_leftBg:SetSize(self._ui._stc_leftBg:GetSizeX(), getScreenSizeY())
  self._ui._stc_rightBg:ComputePos()
  self._ui._stc_leftBg:ComputePos()
  if true == self._ani._startAnimationFinished then
    self._ui._stc_leftBg:SetPosX(0)
  end
  self._ui._tree_serverList:SetSize(self._ui._tree_serverList:GetSizeX(), getScreenSizeY() - self._serverListGap)
  self._ui._tree_serverList:ComputePos()
  for k, value in pairs(self._ui._pc) do
    value:ComputePos()
  end
  for k, value in pairs(self._ui._console) do
    value:ComputePos()
  end
  for k, value in pairs(self._ui._stc_channelDesc) do
    value:ComputePos()
  end
  self._ui._stc_bannerAreaObt:ComputePos()
  self._ui._stc_bannerArea:ComputePos()
  self._ui._txt_versionString:ComputePos()
  Panel_Lobby_ServerSelect_All:ComputePos()
  PaGlobal_CheckGamerTag(true)
  local getConsoleUIOffset = ToClient_GetConsoleUIOffset()
  self._ui._stc_movieBg:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  if nil == self._ui_web_loadingMovie then
    self._ui_web_loadingMovie = UI.createControl(__ePAUIControl_WebControl, self._ui._stc_movieBg, "Static_BgMovie")
  end
  if self._isConsole then
    self._ui_web_loadingMovie:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
    self._ui_web_loadingMovie:SetHorizonCenter()
    self._ui_web_loadingMovie:SetVerticalMiddle()
    local spanSize = self._ui_web_loadingMovie:GetSpanSize()
    if 0 ~= self._ui_web_loadingMovie:GetParentPosX() then
      spanSize.x = spanSize.x - self._ui_web_loadingMovie:GetParentPosX()
    end
    if 0 ~= self._ui_web_loadingMovie:GetParentPosY() then
      spanSize.y = spanSize.y - self._ui_web_loadingMovie:GetParentPosY()
    end
    self._ui_web_loadingMovie:SetSpanSize(spanSize.x, spanSize.y)
  end
  self:initTreeData()
end
function PaGlobal_ServerSelect_All:initTreeData()
  if nil == Panel_Lobby_ServerSelect_All then
    return
  end
  local tree = self._ui._tree_serverList
  tree:changeAnimationSpeed(11)
  tree:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_ServerSelect_All_CreateControlServerList")
  tree:createChildContent(__ePAUIList2ElementManagerType_Tree)
  tree:getElementManager():clearKey()
  local mainElement = tree:getElementManager():getMainElement()
  local worldServerCount = getGameWorldServerDataCount()
  local teenWorldIndex, adultWorldIndex
  local key = 1
  if worldServerCount <= 0 then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_CANNOT_CONNECTTOSERVER"),
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  for ii = 1, worldServerCount do
    local worldServerData = getGameWorldServerDataByIndex(ii - 1)
    local worldElement = mainElement:createChild(toInt64(0, key))
    worldElement:setIsOpen(false)
    self._treeData[key] = {isWorldServer = true, worldIndex = ii}
    self._treeMainBranchKey[ii] = key
    key = key + 1
    if isGameServiceTypeKor() and false == ToClient_IsDevelopment() then
      local channelServerData = getGameChannelServerDataByIndex(ii - 1, 0)
      if nil ~= channelServerData and false == channelServerData._isAdultWorld then
        teenWorldIndex = ii
      else
        adultWorldIndex = ii
      end
    end
    local channelCount = getGameChannelServerDataCount(worldServerData._worldNo)
    local tempTable = {}
    local tempOlviaTable = {}
    local crossplayTable = {}
    local seasonChannelTable = {}
    local seasonArshaChannelTable = {}
    for jj = 1, channelCount do
      local channelServerData = getGameChannelServerDataByIndex(ii - 1, jj - 1)
      if false == ToClient_IsDevelopment() and false == ToClient_SelfPlayerIsGM() then
        if false == channelServerData._isInstanceChannel then
          if true == channelServerData._isSpeedChannel then
            tempOlviaTable[#tempOlviaTable + 1] = {
              isWorldServer = false,
              worldIndex = ii,
              channelIndex = jj,
              isSpeedChannel = channelServerData._isSpeedChannel,
              serverNo = channelServerData._serverNo
            }
          elseif true == _ContentsGroup_SeasonContents and true == channelServerData._isSeasonChannel then
            if true == channelServerData._isDontPvPTendencyDecrease then
              seasonArshaChannelTable[#seasonArshaChannelTable + 1] = {
                isWorldServer = false,
                worldIndex = ii,
                channelIndex = jj,
                isSpeedChannel = channelServerData._isSpeedChannel,
                serverNo = channelServerData._serverNo
              }
            else
              seasonChannelTable[#seasonChannelTable + 1] = {
                isWorldServer = false,
                worldIndex = ii,
                channelIndex = jj,
                isSpeedChannel = channelServerData._isSpeedChannel,
                serverNo = channelServerData._serverNo
              }
            end
          elseif __ePlatformType_COUNT == channelServerData._servicePlatformType then
            crossplayTable[#crossplayTable + 1] = {
              isWorldServer = false,
              worldIndex = ii,
              channelIndex = jj,
              isSpeedChannel = channelServerData._isSpeedChannel,
              serverNo = channelServerData._serverNo
            }
          elseif true == _ContentsGroup_ConsoleIntegration then
            local selfPlayerPlatform = ToClient_getGamePlatformType()
            if selfPlayerPlatform == channelServerData._servicePlatformType then
              tempTable[#tempTable + 1] = {
                isWorldServer = false,
                worldIndex = ii,
                channelIndex = jj,
                isSpeedChannel = channelServerData._isSpeedChannel,
                serverNo = channelServerData._serverNo
              }
            end
          else
            tempTable[#tempTable + 1] = {
              isWorldServer = false,
              worldIndex = ii,
              channelIndex = jj,
              isSpeedChannel = channelServerData._isSpeedChannel,
              serverNo = channelServerData._serverNo
            }
          end
        end
      elseif true == channelServerData._isSpeedChannel then
        tempOlviaTable[#tempOlviaTable + 1] = {
          isWorldServer = false,
          worldIndex = ii,
          channelIndex = jj,
          isSpeedChannel = channelServerData._isSpeedChannel,
          serverNo = channelServerData._serverNo
        }
      elseif true == _ContentsGroup_SeasonContents and true == channelServerData._isSeasonChannel then
        if true == channelServerData._isDontPvPTendencyDecrease then
          seasonArshaChannelTable[#seasonArshaChannelTable + 1] = {
            isWorldServer = false,
            worldIndex = ii,
            channelIndex = jj,
            isSpeedChannel = channelServerData._isSpeedChannel,
            serverNo = channelServerData._serverNo
          }
        else
          seasonChannelTable[#seasonChannelTable + 1] = {
            isWorldServer = false,
            worldIndex = ii,
            channelIndex = jj,
            isSpeedChannel = channelServerData._isSpeedChannel,
            serverNo = channelServerData._serverNo
          }
        end
      elseif __ePlatformType_COUNT == channelServerData._servicePlatformType then
        crossplayTable[#crossplayTable + 1] = {
          isWorldServer = false,
          worldIndex = ii,
          channelIndex = jj,
          isSpeedChannel = channelServerData._isSpeedChannel,
          serverNo = channelServerData._serverNo
        }
      elseif true == _ContentsGroup_ConsoleIntegration then
        local selfPlayerPlatform = ToClient_getGamePlatformType()
        if selfPlayerPlatform == channelServerData._servicePlatformType then
          tempTable[#tempTable + 1] = {
            isWorldServer = false,
            worldIndex = ii,
            channelIndex = jj,
            isSpeedChannel = channelServerData._isSpeedChannel,
            serverNo = channelServerData._serverNo
          }
        end
      else
        tempTable[#tempTable + 1] = {
          isWorldServer = false,
          worldIndex = ii,
          channelIndex = jj,
          isSpeedChannel = channelServerData._isSpeedChannel,
          serverNo = channelServerData._serverNo
        }
      end
    end
    if true == _ContentsGroup_SeasonContents then
      for idx = 1, #seasonChannelTable do
        worldElement:createChild(toInt64(0, key))
        self._treeData[key] = seasonChannelTable[idx]
        key = key + 1
      end
      for idx = 1, #seasonArshaChannelTable do
        worldElement:createChild(toInt64(0, key))
        self._treeData[key] = seasonArshaChannelTable[idx]
        key = key + 1
      end
    end
    for ii = 1, #tempOlviaTable do
      worldElement:createChild(toInt64(0, key))
      self._treeData[key] = tempOlviaTable[ii]
      key = key + 1
    end
    local isCrossplayMode = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
    if true == ToClient_isTotalGameClient() and true == isCrossplayMode then
      for ii = 1, #crossplayTable do
        worldElement:createChild(toInt64(0, key))
        self._treeData[key] = crossplayTable[ii]
        key = key + 1
      end
      for ii = 1, #tempTable do
        worldElement:createChild(toInt64(0, key))
        self._treeData[key] = tempTable[ii]
        key = key + 1
      end
    else
      for ii = 1, #tempTable do
        worldElement:createChild(toInt64(0, key))
        self._treeData[key] = tempTable[ii]
        key = key + 1
      end
      for ii = 1, #crossplayTable do
        worldElement:createChild(toInt64(0, key))
        self._treeData[key] = crossplayTable[ii]
        key = key + 1
      end
    end
  end
  local openAdultWorld = true
  if isGameServiceTypeKor() and false == ToClient_IsDevelopment() then
    local isAdultUser = ToClient_isAdultUser()
    if true == isAdultUser then
      self:updateSingleWorldDesc(false)
    else
      self:updateSingleWorldDesc(true)
    end
    openAdultWorld = true == isAdultUser
  else
    self:updateSingleWorldDesc(false)
  end
  if openAdultWorld then
    if nil == adultWorldIndex then
      local firstWorld = tree:getElementManager():getByKey(toInt64(0, 1))
      if nil == firstWorld then
        return
      end
      firstWorld:setIsOpen(true)
    else
      local firstWorld = tree:getElementManager():getByKey(toInt64(0, adultWorldIndex))
      if nil == firstWorld then
        return
      end
      firstWorld:setIsOpen(true)
    end
  elseif nil == teenWorldIndex then
    local teenWorld = tree:getElementManager():getByKey(toInt64(0, 2))
    if nil == teenWorld then
      return
    end
    teenWorld:setIsOpen(true)
  else
    local teenWorld = tree:getElementManager():getByKey(toInt64(0, teenWorldIndex))
    if nil == teenWorld then
      return
    end
    teenWorld:setIsOpen(true)
  end
  self._treeSize = key
  tree:getElementManager():refillKeyList()
  self._listContentsCount = tree:getChildContentListSize()
end
function PaGlobal_ServerSelect_All:updateTreeData(tree, worldServerData, key, ii)
  self._treeData[key] = {isWorldServer = true, worldIndex = ii}
  self._treeMainBranchKey[ii] = key
  key = key + 1
  local worldIdx = ii - 1
  local worldServerData = getGameWorldServerDataByIndex(worldIdx)
  local channelCount = getGameChannelServerDataCount(worldServerData._worldNo)
  local tempTable = {}
  local tempOlviaTable = {}
  for jj = 1, channelCount do
    local channelServerData = getGameChannelServerDataByIndex(ii - 1, jj - 1)
    if false == ToClient_IsDevelopment() and false == ToClient_SelfPlayerIsGM() then
      if false == channelServerData._isInstanceChannel then
        if true == channelServerData._isSpeedChannel then
          tempOlviaTable[#tempOlviaTable + 1] = {
            isWorldServer = false,
            worldIndex = ii,
            channelIndex = jj,
            isSpeedChannel = channelServerData._isSpeedChannel,
            serverNo = channelServerData._serverNo
          }
        else
          tempTable[#tempTable + 1] = {
            isWorldServer = false,
            worldIndex = ii,
            channelIndex = jj,
            isSpeedChannel = channelServerData._isSpeedChannel,
            serverNo = channelServerData._serverNo
          }
        end
      end
    elseif true == channelServerData._isSpeedChannel then
      tempOlviaTable[#tempOlviaTable + 1] = {
        isWorldServer = false,
        worldIndex = ii,
        channelIndex = jj,
        isSpeedChannel = channelServerData._isSpeedChannel,
        serverNo = channelServerData._serverNo
      }
    else
      tempTable[#tempTable + 1] = {
        isWorldServer = false,
        worldIndex = ii,
        channelIndex = jj,
        isSpeedChannel = channelServerData._isSpeedChannel,
        serverNo = channelServerData._serverNo
      }
    end
  end
  for ii = 1, #tempOlviaTable do
    tree:getElementManager():pushKey(key)
    self._treeData[key] = tempOlviaTable[ii]
    key = key + 1
  end
  for ii = 1, #tempTable do
    tree:getElementManager():pushKey(key)
    self._treeData[key] = tempTable[ii]
    key = key + 1
  end
  return key
end
function PaGlobal_ServerSelect_All:updateSingleWorldDesc(isTeen)
  local parent = self._ui._stc_channelDesc[self._CHANNEL_TYPE.SINGLE_WORLD_SYSTEM]
  local txt_title = UI.getChildControl(parent, "StaticText_Title")
  local txt_desc = UI.getChildControl(parent, "StaticText_Desc")
  if isTeen then
    txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CHANNELSELECTDESC_15"))
  else
    txt_desc:SetText(self._channelDescriptionData[self._CHANNEL_TYPE.SINGLE_WORLD_SYSTEM].desc)
  end
  parent:SetSize(parent:GetSizeX(), txt_title:GetSizeY() + txt_desc:GetTextSizeY() + 15)
  parent:ComputePos()
end
function PaGlobal_ServerSelect_All:updateTextOnButtons()
  local worldServerData = getGameWorldServerDataByIndex(self._selectedWorldIndex - 1)
  if nil == worldServerData then
    return
  end
  local mainServerNo = ToClient_getUserSubCacheData(__eMainServerNo)
  local temporaryWrapper = getTemporaryInformationWrapper()
  local mainServerName = self:getMainServerName(mainServerNo)
  if -1 ~= mainServerNo and nil ~= mainServerName then
    self._ui._pc._btn_mainServer:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVERSELECT_SETMAINSERVER", "serverName", tostring(mainServerName)))
  end
  local lastServerNo = temporaryWrapper:getLastServerNo()
  local lastServerName = self:getLastServerName(lastServerNo)
  if nil == lastServerName then
    self._ui._pc._btn_recentServer:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_LASTJOINSERVER_NONE"))
    self._ui._console._txt_recentKey:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_BTN_LASTJOINSERVER"))
  else
    self._ui._pc._btn_recentServer:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVERSELECT_RECENT_SERVER", "lastJoinServer", tostring(lastServerName)))
    self._ui._console._txt_recentKey:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVERSELECT_LASTJOINSERVER_NUMBER", "lastJoinServer", tostring(lastServerName)))
  end
  self._ui._pc._btn_recentServer:SetTextSpan(self._ui._pc._btn_recentServer:GetTextSpan().x, self._ui._pc._btn_recentServer:GetSizeY() * 0.5 - self._ui._pc._btn_recentServer:GetTextSizeY() * 0.5)
end
function PaGlobal_ServerSelect_All:getMainServerName(mainServerNo)
  local worldServerCount = getGameWorldServerDataCount()
  for ii = 1, worldServerCount do
    local worldServerData = getGameWorldServerDataByIndex(ii - 1)
    local mainServerName = getChannelName(worldServerData._worldNo, mainServerNo)
    if nil ~= mainServerName then
      return mainServerName
    end
  end
  return nil
end
function PaGlobal_ServerSelect_All:getLastServerName(lastServerNo)
  local worldServerCount = getGameWorldServerDataCount()
  for ii = 1, worldServerCount do
    local worldServerData = getGameWorldServerDataByIndex(ii - 1)
    local lastServerName = getChannelName(worldServerData._worldNo, lastServerNo)
    if nil ~= lastServerName then
      return lastServerName
    end
  end
  return nil
end
function PaGlobal_ServerSelect_All:playMovie()
  local getConsoleUIOffset = ToClient_GetConsoleUIOffset()
  self._ui._stc_movieBg:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  if nil == self._ui_web_loadingMovie then
    self._ui_web_loadingMovie = UI.createControl(__ePAUIControl_WebControl, self._ui._stc_movieBg, "Static_BgMovie")
  end
  self._ui_web_loadingMovie:ResetUrl()
  if self._isConsole then
    self._ui_web_loadingMovie:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
    self._ui_web_loadingMovie:SetHorizonCenter()
    self._ui_web_loadingMovie:SetVerticalMiddle()
    local spanSize = self._ui_web_loadingMovie:GetSpanSize()
    if 0 ~= self._ui_web_loadingMovie:GetParentPosX() then
      spanSize.x = spanSize.x - self._ui_web_loadingMovie:GetParentPosX()
    end
    if 0 ~= self._ui_web_loadingMovie:GetParentPosY() then
      spanSize.y = spanSize.y - self._ui_web_loadingMovie:GetParentPosY()
    end
    self._ui_web_loadingMovie:SetSpanSize(spanSize.x, spanSize.y)
  else
    local uiScale = getGlobalScale()
    local sizeX = getResolutionSizeX()
    local sizeY = getResolutionSizeY()
    sizeX = sizeX / uiScale
    sizeY = sizeY / uiScale
    local movieSizeX = sizeX
    local movieSizeY = sizeX * 1080 / 1920
    local posX = 0
    local posY = 0
    if sizeY >= movieSizeY then
      posY = (sizeY - movieSizeY) * 0.5
    else
      movieSizeX = sizeY * 1920 / 1080
      movieSizeY = sizeY
      posX = (sizeX - movieSizeX) * 0.5
    end
    Panel_Lobby_ServerSelect_All:SetPosX(0)
    Panel_Lobby_ServerSelect_All:SetPosY(0)
    Panel_Lobby_ServerSelect_All:SetSize(sizeX, sizeY)
    local marginX = movieSizeX * 0.013
    local marginY = movieSizeY * 0.013
    if 0 < getConsoleUIOffset then
      local uiOffsetX = getOriginScreenSizeX() * getConsoleUIOffset
      local uiOffsetY = getOriginScreenSizeY() * getConsoleUIOffset
      self._ui_web_loadingMovie:SetPosX(posX - marginX * 0.5 - uiOffsetX)
      self._ui_web_loadingMovie:SetPosY(posY - marginY * 0.5 - uiOffsetY)
    else
      self._ui_web_loadingMovie:SetPosX(posX - marginX * 0.5)
      self._ui_web_loadingMovie:SetPosY(posY - marginY * 0.5)
    end
    self._ui_web_loadingMovie:SetSize(movieSizeX + marginX, movieSizeY + marginY)
  end
  self._ui_web_loadingMovie:SetUrl(1920, 1080, "coui://UI_Data/UI_Html/LobbyBG_Movie.html")
  self._ui_web_loadingMovie:ComputePos()
end
function PaGlobal_ServerSelect_All:onMovieEvent(param)
  local _fadeTime = 1
  if 1 == param then
    if nil ~= self._ui_web_loadingMovie then
      self._ui_web_loadingMovie:TriggerEvent("PlayMovie", self._movieURL[self._movieOrder[self._currentMovieIndex]])
      self._moviePlayed = true
    end
  elseif 2 == param then
    self._currentMovieIndex = self._currentMovieIndex + 1
    if nil == self._movieOrder[self._currentMovieIndex] then
      local count = #self._movieOrder
      self._currentMovieIndex = getRandomValue(1, count)
    end
    self._ui_web_loadingMovie:TriggerEvent("PlayMovie", self._movieURL[self._movieOrder[self._currentMovieIndex]])
  end
end
function PaGlobal_ServerSelect_All:updateListData()
  local worldServerData = getGameWorldServerDataByIndex(self._selectedWorldIndex - 1)
  if nil == worldServerData then
    return
  end
  for ii = 1, self._treeSize do
    self._ui._tree_serverList:requestUpdateByKey(toInt64(0, ii))
  end
  self:updateTextOnButtons()
end
function PaGlobal_ServerSelect_All:createControlServerList(content, key)
  local key32 = Int64toInt32(key)
  self._listContents[key32] = content
  if false == self._ani._startAnimationFinished then
    self._listContentsTarget[key32] = self._listContentsBaseX
    content:SetAlphaExtraChild(0)
  else
    self._listContentsAlphaTarget[key32] = 1
    self._listContentsAlphaFlag[key32] = true
  end
  local worldButtonBG = UI.getChildControl(content, "Static_WorldListBg")
  local channelButtonBG = UI.getChildControl(content, "Static_ChannelButtonBG")
  local isWorldServer = self._treeData[key32].isWorldServer
  worldButtonBG:SetShow(isWorldServer)
  channelButtonBG:SetShow(not isWorldServer)
  if true == isWorldServer then
    PaGlobal_ServerSelect_All:createWorldBranch(content, key)
  else
    PaGlobal_ServerSelect_All:createChannelBranch(content, key)
  end
end
function PaGlobal_ServerSelect_All:createWorldBranch(content, key)
  local key32 = Int64toInt32(key)
  local worldButtonBG = UI.getChildControl(content, "Static_WorldListBg")
  local txt_name = UI.getChildControl(worldButtonBG, "StaticText_ServerName")
  local worldIdx = self._treeData[key32].worldIndex
  if nil == worldIdx then
    return
  end
  local worldServerData = getGameWorldServerDataByIndex(worldIdx - 1)
  if nil ~= worldServerData then
    local name = getWorldNameByWorldNo(worldServerData._worldNo)
    txt_name:SetText(name)
  else
    txt_name:SetText("dummy")
  end
  local isExpBonusEvent = IsWorldServerEventTypeByWorldIndex(worldIdx - 1, -1, 0)
  local isDropRateEvent = IsWorldServerEventTypeByWorldIndex(worldIdx - 1, -1, 1)
  local txt_worldBonus = UI.getChildControl(worldButtonBG, "StaticText_ServerOption")
  local tempEventName = ""
  if isExpBonusEvent then
    tempEventName = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_EXPEVENT")
  end
  if isDropRateEvent then
    if "" ~= tempEventName then
      tempEventName = tempEventName .. " " .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_DROPEVENT")
    else
      tempEventName = tempEventName .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_DROPEVENT")
    end
  end
  if "" == tempEventName then
    txt_worldBonus:SetShow(false)
  else
    txt_worldBonus:SetShow(true)
    txt_worldBonus:SetText(tempEventName)
  end
  worldButtonBG:addInputEvent("Mouse_LUp", "HandleEventLUp_ServerSelect_All_SelectWorld(" .. worldIdx .. ")")
end
function PaGlobal_ServerSelect_All:createChannelBranch(content, key)
  local key32 = Int64toInt32(key)
  local worldServerIdx = self._treeData[key32].worldIndex
  local channelServerIdx = self._treeData[key32].channelIndex
  local channelButtonBG = UI.getChildControl(content, "Static_ChannelButtonBG")
  local worldServerData = getGameWorldServerDataByIndex(worldServerIdx - 1)
  local channelServerData = getGameChannelServerDataByIndex(worldServerIdx - 1, channelServerIdx - 1)
  if nil == channelServerIdx then
    return
  end
  if nil == channelServerData then
    return
  end
  local isBeingWar = channelServerData._isSiegeBeing
  local isVillageStart = channelServerData._isVillageSiege
  local changeChannelTime = getChannelMoveableRemainTime(worldServerData._worldNo)
  local changeMoveChannel = getChannelMoveableTime(worldServerData._worldNo)
  local changeRealChannelTime = convertStringFromDatetime(changeChannelTime)
  local changeSpecialChannelTime = getSpecialChannelMoveableRemainTime(worldServerData._worldNo)
  local changeMoveSpecialChannel = getSpecialChannelMoveableTime(worldServerData._worldNo)
  local changeRealSpecialChannelTime = convertStringFromDatetime(changeSpecialChannelTime)
  local isSeasonChannel = channelServerData._isSeasonChannel
  local btn_NormalSlot = UI.getChildControl(channelButtonBG, "Button_NormalServerSlot")
  local btn_ArshaSlot = UI.getChildControl(channelButtonBG, "Button_ArshaServerSlot")
  local btn_OlviaSlot = UI.getChildControl(channelButtonBG, "Button_OlviaServerSlot")
  local btn_SeasonSlot = UI.getChildControl(channelButtonBG, "Button_SeasonServerSlot")
  local txt_ServerName = UI.getChildControl(channelButtonBG, "StaticText_Name")
  local txt_State = UI.getChildControl(channelButtonBG, "StaticText_State")
  local stc_highlightBG = UI.getChildControl(channelButtonBG, "Static_SelectGradation")
  local txt_enter = UI.getChildControl(stc_highlightBG, "StaticText_Enter")
  local txt_waitChangeTime = UI.getChildControl(channelButtonBG, "StaticText_ConnectWait")
  local stc_SeasonIcon = UI.getChildControl(channelButtonBG, "StaticText_Season")
  for ii = self._CHANNEL_TYPE.WAR_INFO, self._CHANNEL_TYPE.MAX_COUNT do
    self:getChannelIcon(channelButtonBG, ii):SetShow(false)
  end
  local stc_maintanance = UI.getChildControl(channelButtonBG, "StaticText_ChannelIcon5_Maintenance")
  stc_SeasonIcon:SetShow(false)
  btn_NormalSlot:SetShow(false)
  btn_ArshaSlot:SetShow(false)
  btn_OlviaSlot:SetShow(false)
  btn_SeasonSlot:SetShow(false)
  txt_State:SetShow(false)
  stc_highlightBG:SetShow(false)
  txt_waitChangeTime:SetShow(false)
  local serverSlotButton = btn_NormalSlot
  local isAdmission = true
  local restrictedServerNo = worldServerData._restrictedServerNo
  if restrictedServerNo ~= 0 then
    if restrictedServerNo == channelServerData._serverNo then
      isAdmission = true
    elseif changeChannelTime > toInt64(0, 0) and false == isSeasonChannel then
      isAdmission = false
    elseif changeSpecialChannelTime > toInt64(0, 0) and true == isSeasonChannel then
      isAdmission = false
    else
      isAdmission = true
    end
  end
  local admissionDesc = ""
  if false == isAdmission then
    admissionDesc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVERSELECT_ISADMISSION_LIMIT", "admissionDesc", admissionDesc)
  else
    admissionDesc = ""
  end
  local channelName = getChannelName(worldServerData._worldNo, channelServerData._serverNo)
  _PA_ASSERT(nil ~= channelName, "\236\132\156\235\178\132 \236\157\180\235\166\132\236\157\128 \236\161\180\236\158\172\237\149\180\236\149\188\237\149\169\235\139\136\235\139\164.")
  local stateStr = ""
  local busyState = channelServerData._busyState
  local isPrepareToStopServer = channelServerData:isPrepareToStop()
  if false == isPrepareToStopServer then
    if busyState == 1 then
      stateStr = ""
      txt_State:SetSpanSize(5, 2)
    elseif busyState == 2 then
      stateStr = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_BUSYSTATE_2")
      txt_State:SetSpanSize(5, 2)
    elseif busyState == 3 then
      stateStr = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_BUSYSTATE_3")
      txt_State:SetSpanSize(5, 2)
    elseif busyState == 4 then
      stateStr = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_BUSYSTATE_4")
      txt_State:SetSpanSize(5, 2)
    end
  end
  txt_State:SetText(stateStr)
  local isShowWaitChangeTime = false
  if true == isLoginIDShow() then
    if changeChannelTime > toInt64(0, 0) and not isAdmission then
      txt_waitChangeTime:SetText(changeRealChannelTime)
      isShowWaitChangeTime = true
    end
  elseif not isAdmission and busyState ~= 0 then
    if changeChannelTime > toInt64(0, 0) and false == isSeasonChannel then
      txt_waitChangeTime:SetText(changeRealChannelTime)
      isShowWaitChangeTime = true
    elseif changeSpecialChannelTime > toInt64(0, 0) and true == isSeasonChannel then
      txt_waitChangeTime:SetText(changeRealSpecialChannelTime)
      isShowWaitChangeTime = true
    else
      txt_waitChangeTime:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "warTimeMinute", 0, "warTimeSecond", 0))
      isShowWaitChangeTime = true
    end
  end
  txt_State:ComputePos()
  txt_waitChangeTime:SetPosX(channelButtonBG:GetSizeX() - txt_waitChangeTime:GetSizeX() - txt_waitChangeTime:GetTextSizeX() - 10)
  if true == isGameServiceTypeDev() then
    channelName = channelName .. " " .. getDotIp(channelServerData) .. admissionDesc
  elseif true == isBeingWar then
    if true == isVillageStart then
      channelName = channelName .. " " .. admissionDesc .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_SERVERSELECT_LOCALWAR_BEING")
    else
      channelName = channelName .. " " .. admissionDesc .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_SERVERSELECT_TERRITORYWAR_BEING")
    end
  else
    channelName = channelName .. " " .. admissionDesc
  end
  txt_ServerName:SetText(channelName)
  txt_ServerName:SetShow(true)
  if true == channelServerData._isSiegeChannel and isBeingWar then
    self:showChannelIcon(channelButtonBG, self._CHANNEL_TYPE.WAR_INFO)
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if channelServerData._isSpeedChannel then
    self:showChannelIcon(channelButtonBG, self._CHANNEL_TYPE.OLVIA_CHANNEL)
    serverSlotButton = btn_OlviaSlot
    if 0 ~= temporaryWrapper:getMyAdmissionToSpeedServer() or ToClient_IsDevelopment() then
      serverSlotButton:SetIgnore(false)
      serverSlotButton:SetMonoTone(false)
    else
      serverSlotButton:SetIgnore(true)
      serverSlotButton:SetMonoTone(true)
    end
  elseif channelServerData._isPcroomChannel then
    self:showChannelIcon(channelButtonBG, self._CHANNEL_TYPE.PC_ROOM_CHANNEL)
  elseif true == isSeasonChannel and true == _ContentsGroup_SeasonContents then
    serverSlotButton = btn_SeasonSlot
    self:showChannelIcon(channelButtonBG, self._CHANNEL_TYPE.SEASONCHANNEL)
    if channelServerData._isDontPvPTendencyDecrease then
      self:showChannelIcon(channelButtonBG, self._CHANNEL_TYPE.ARSHA_CHANNEL)
    end
  elseif channelServerData._isDontPvPTendencyDecrease then
    serverSlotButton = btn_ArshaSlot
    self:showChannelIcon(channelButtonBG, self._CHANNEL_TYPE.ARSHA_CHANNEL)
  end
  if true == isPrepareToStopServer then
    self:showChannelIcon(channelButtonBG, self._CHANNEL_TYPE.READY_MAINTERNANCE)
  elseif busyState == 0 or channelServerData:isClosed() then
    self:showChannelIcon(channelButtonBG, self._CHANNEL_TYPE.MAINTERNANCE)
  end
  serverSlotButton:addInputEvent("Mouse_LUp", "HandleEventLUp_ServerSelect_All_SelectChannel(" .. key32 .. ")")
  serverSlotButton:addInputEvent("Mouse_On", "HandleEventOn_ServerSelect_All_OverChannelControl(" .. key32 .. ")")
  serverSlotButton:addInputEvent("Mouse_Out", "HandleEventOut_ServerSelect_All_OverChannelControl()")
  serverSlotButton:SetShow(true)
  if self._BUTTON_STATE.SELECTED == self._currentButtonState and self._selectedChannelIndex == channelServerIdx then
    txt_State:SetShow(false)
  elseif self._BUTTON_STATE.MAINSERVER_SELECT == self._currentButtonState then
    txt_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_SELECT"))
    txt_State:SetShow(true)
  elseif true == isShowWaitChangeTime then
    txt_State:SetShow(false)
    txt_waitChangeTime:SetShow(true)
  else
    txt_State:SetShow(true)
    txt_waitChangeTime:SetShow(false)
  end
  if nil ~= channelServerIdx and self._selectedChannelIndex == channelServerIdx then
    stc_highlightBG:SetShow(true)
    if not isAdmission then
      txt_enter:SetFontColor(Defines.Color.C_FF525B6D)
      serverSlotButton:addInputEvent("Mouse_LUp", "")
    else
      txt_enter:SetFontColor(Defines.Color.C_FFEEEEEE)
    end
    if true == isPrepareToStopServer then
      txt_enter:SetSpanSize(45, 0)
    else
      txt_enter:SetSpanSize(15, 0)
    end
  else
    stc_highlightBG:SetShow(false)
  end
  local stc_overBG = UI.getChildControl(channelButtonBG, "Static_OverHighlight")
  if key32 == self._currentHoveredKey32 then
    stc_overBG:SetShow(true)
    if true == self._ani._startAnimationFinished then
      self._listContentsTarget[key32] = self._listContentsBaseX - 10
      self._listContentsFlag[key32] = true
    else
      self._listContentsTarget[key32] = self._listContentsBaseX
      self._listContentsFlag[key32] = true
    end
  else
    stc_overBG:SetShow(false)
  end
  if true == ToClient_isTotalGameClient() then
    local isCrossPlayMode = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
    if __ePlatformType_COUNT == channelServerData._servicePlatformType and false == isCrossPlayMode then
      self:showChannelIcon(channelButtonBG, self._CHANNEL_TYPE.NO_ACCESS)
      stc_overBG:SetShow(false)
      serverSlotButton:SetMonoTone(true)
    else
      serverSlotButton:SetMonoTone(false)
    end
  end
end
function PaGlobal_ServerSelect_All:enterMemorizedChannel(channelIdx)
  local channelServerData = getGameChannelServerDataByIndex(self._selectedWorldIndex - 1, channelIdx - 1)
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
  if true == ToClient_isTotalGameClient() then
    local canCrossPlay = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
    if true == canCrossPlay then
      self._ui._console._txt_crossplayKey:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CROSSPLAY_OPTIONOFF"))
    else
      self._ui._console._txt_crossplayKey:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CROSSPLAY_OPTIONON"))
    end
    local gamePlatformType = ToClient_getGamePlatformType()
    local servicePlatformType = channelServerData._servicePlatformType
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
  if false == selectMemorizedServer(self._selectedWorldIndex - 1, channelIdx - 1) then
    PaGlobal_ServerSelect_All._isConnecting = false
  end
end
function PaGlobal_ServerSelect_All:autoConnectToLastServer()
  local rv = ToClient_CheckToMoveChannel()
  if 0 == rv then
    return false
  end
  local tempWrapper = getTemporaryInformationWrapper()
  local lastJoinServerNo = tempWrapper:getLastServerNo()
  if lastJoinServerNo <= 1 then
    return
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_AUTO_CONNECT_TO_LAST_SERVER_WHEN_RESTRICTED_TO_MOVE_CHANNEL"),
    functionYes = HandleEventLUp_ServerSelect_All_EnterLastJoinedServer,
    exitButton = false,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_1
  }
  MessageBox.showMessageBox(messageBoxData)
  return true
end
function PaGlobal_ServerSelect_All:setMainServer(worldIndex, serverIndex)
  local worldServerData = getGameWorldServerDataByIndex(worldIndex - 1)
  local serverData = getGameChannelServerDataByIndex(worldIndex - 1, serverIndex - 1)
  if nil == serverData then
    Proc_ShowMessage_Ack("\236\158\152\235\170\187\235\144\156 \236\132\156\235\178\132 \236\160\149\235\179\180\236\158\133\235\139\136\235\139\164. \235\139\164\236\139\156 \236\139\156\235\143\132\237\149\180\236\163\188\236\132\184\236\154\148.")
    return
  end
  local function Set_MainServer()
    local serverData = getGameChannelServerDataByIndex(worldIndex - 1, serverIndex - 1)
    local serverNo = serverData._serverNo
    ToClient_setUserSubCacheData(__eMainServerNo, serverNo)
    self._currentButtonState = self._BUTTON_STATE.NORMAL
    self:updateListData()
  end
  local serverName = getChannelName(worldServerData._worldNo, serverData._serverNo)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_MAINSERVERTITLE"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVERSELECT_MAINSERVERCONTENT", "serverName", serverName),
    functionApply = Set_MainServer,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_ServerSelect_All:updatePerFrame(deltaTime)
  luaTimer_UpdatePerFrame(deltaTime)
  self._updateTimeAcc = self._updateTimeAcc - deltaTime
  if self._updateTimeAcc <= 0 then
    self._updateTimeAcc = 15
    self:updateListData()
    if self._isScope then
      self._stc_BackgroundImage[self._currentBackIndex]:SetShow(true)
      self._isScope = false
      local FadeMaskAni = self._stc_BackgroundImage[self._currentBackIndex]:addTextureUVAnimation(0, 15, 0)
      FadeMaskAni:SetStartUV(self._startUV, self._startUV, 0)
      FadeMaskAni:SetEndUV(self._endUV, self._startUV, 0)
      FadeMaskAni:SetStartUV(self._startUV2, self._startUV, 1)
      FadeMaskAni:SetEndUV(self._endUV2, self._startUV, 1)
      FadeMaskAni:SetStartUV(self._startUV, self._startUV2, 2)
      FadeMaskAni:SetEndUV(self._endUV, self._startUV2, 2)
      FadeMaskAni:SetStartUV(self._startUV2, self._startUV2, 3)
      FadeMaskAni:SetEndUV(self._endUV2, self._startUV2, 3)
    else
      self._isScope = true
      local FadeMaskAni = self._stc_BackgroundImage[self._currentBackIndex]:addTextureUVAnimation(0, 15, 0)
      FadeMaskAni:SetEndUV(self._startUV, self._startUV, 0)
      FadeMaskAni:SetStartUV(self._endUV, self._startUV, 0)
      FadeMaskAni:SetEndUV(self._startUV2, self._startUV, 1)
      FadeMaskAni:SetStartUV(self._endUV2, self._startUV, 1)
      FadeMaskAni:SetEndUV(self._startUV, self._startUV2, 2)
      FadeMaskAni:SetStartUV(self._endUV, self._startUV2, 2)
      FadeMaskAni:SetEndUV(self._startUV2, self._startUV2, 3)
      FadeMaskAni:SetStartUV(self._endUV2, self._startUV2, 3)
      local fadeColor = self._stc_BackgroundImage[self._currentBackIndex]:addColorAnimation(15, 17, 0)
      fadeColor:SetStartColor(Defines.Color.C_FFFFFFFF)
      fadeColor:SetEndColor(Defines.Color.C_00FFFFFF)
      self._currentBackIndex = self._currentBackIndex + 1
      if self._totalBG < self._currentBackIndex then
        self._currentBackIndex = getRandomValue(1, self._totalBG)
      end
      local baseTexture = self._stc_BackgroundImage[self._currentBackIndex]:getBaseTexture()
      baseTexture:setUV(self._startUV, self._startUV, self._startUV2, self._startUV2)
      self._stc_BackgroundImage[self._currentBackIndex]:setRenderTexture(baseTexture)
      local fadeColor2 = self._stc_BackgroundImage[self._currentBackIndex]:addColorAnimation(12, 15, 0)
      fadeColor2:SetStartColor(Defines.Color.C_00FFFFFF)
      fadeColor2:SetEndColor(Defines.Color.C_FFFFFFFF)
    end
  end
  if false == self._startAnimationFlag then
    self._animationDelayCount = self._animationDelayCount + deltaTime
    if self._animationDelayCount > self._animationDelay then
      self:playAnimation()
    end
    if 1 < self._animationDelayCount then
      if false == _moviePlayed then
        self:startFadeIn()
        self._ui._stc_movieBg:SetShow(false)
      end
      self._startAnimationFlag = true
      self._ani._startAnimationFinished = true
      self:initTreeLateUpdate()
    end
  end
  for ii = 1, self._treeSize do
    if true == self._listContentsFlag[ii] then
      self:animateListComponents(deltaTime, ii)
    end
    if true == self._listContentsAlphaFlag[ii] then
      self:animateListComponentsAlpha(deltaTime, ii)
    end
  end
  if true == self._ani._listContentsShowAniFlag then
    self:playListComponentsAni(deltaTime)
  end
  if true == self._frameAnimationFlag then
    self:animateFrame(deltaTime)
  end
end
function PaGlobal_ServerSelect_All:playAnimation()
  if false == self._ani._startAnimationFinished then
    self._ani._listContentsShowAniFlag = true
  end
end
function PaGlobal_ServerSelect_All:playListComponentsAni(deltaTime)
  self._listContentsLaunchElapsed = self._listContentsLaunchElapsed + deltaTime
  local content = self._listContents[self._listContentsLaunchedCount]
  if self._listContentsLaunchedCount == self._treeSize + 1 or self._listContentsLaunchedCount == self._ui._tree_serverList:getChildContentListSize() + 1 or nil == self._listContentsLaunchTimeTable[self._listContentsLaunchedCount] then
    self._ani._listContentsShowAniFlag = false
    return
  elseif nil ~= content and nil ~= content.SetShow and self._listContentsLaunchElapsed >= self._listContentsLaunchTimeTable[self._listContentsLaunchedCount] then
    content:SetShow(true)
    self._listContentsAlphaFlag[self._listContentsLaunchedCount] = true
    self._listContentsAlphaTarget[self._listContentsLaunchedCount] = 1
    self._listContentsLaunchedCount = self._listContentsLaunchedCount + 1
  end
end
function PaGlobal_ServerSelect_All:animateListComponents(deltaTime, index)
  local content = self._listContents[index]
  if nil == content or nil == self._listContentsTarget[index] then
    return
  end
  local currentPos = content:GetPosX()
  local distance = self._listContentsTarget[index] - currentPos
  local acc = distance * 0.01 * deltaTime * 10
  if -1 < acc and acc < 0 then
    acc = -1
  elseif acc < 1 and 0 < acc then
    acc = 1
  end
  if 1 < math.abs(distance) then
    content:SetPosX(currentPos + acc)
  else
    content:SetPosX(self._listContentsTarget[index])
    self._listContentsFlag[index] = false
  end
end
function PaGlobal_ServerSelect_All:animateListComponentsAlpha(deltaTime, index)
  local content = self._listContents[index]
  if nil == content or nil == self._listContentsAlphaTarget[index] then
    return
  end
  local currentAlpha = content:GetAlpha()
  local distance = self._listContentsAlphaTarget[index] - currentAlpha
  local acc = distance * deltaTime * 5
  if 0.01 < math.abs(distance) then
    local nextAlpha = currentAlpha + acc
    content:SetAlphaExtraChild(nextAlpha)
    local channelBG = UI.getChildControl(content, "Static_ChannelButtonBG")
    local channelBtn = UI.getChildControl(channelBG, "Button_NormalServerSlot")
    channelBtn:SetAlpha(nextAlpha * 0.8)
    local channelSelect = UI.getChildControl(channelBG, "Static_SelectGradation")
    channelSelect:SetAlpha(nextAlpha * 0.9)
    local channelSelectYellow = UI.getChildControl(channelSelect, "Static_SelectYellow")
    channelSelectYellow:SetAlpha(nextAlpha * 0.7)
  else
    content:SetAlphaExtraChild(self._listContentsAlphaTarget[index])
    self._listContentsAlphaFlag[index] = false
    local channelBG = UI.getChildControl(content, "Static_ChannelButtonBG")
    local channelBtn = UI.getChildControl(channelBG, "Button_NormalServerSlot")
    channelBtn:SetAlpha(self._listContentsAlphaTarget[index] * 0.8)
    local channelSelect = UI.getChildControl(channelBG, "Static_SelectGradation")
    channelSelect:SetAlpha(self._listContentsAlphaTarget[index] * 0.9)
    local channelSelectYellow = UI.getChildControl(channelSelect, "Static_SelectYellow")
    channelSelectYellow:SetAlpha(self._listContentsAlphaTarget[index] * 0.7)
  end
end
function PaGlobal_ServerSelect_All:isHitTest(control)
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  local bgPosX = control:GetParentPosX()
  local bgPosY = control:GetParentPosY()
  local bgSizeX = control:GetSizeX()
  local bgSizeY = control:GetSizeY()
  if mousePosX >= bgPosX and mousePosX <= bgPosX + bgSizeX and mousePosY >= bgPosY and mousePosY <= bgPosY + bgSizeY then
    return true
  end
  return false
end
function PaGlobal_ServerSelect_All:initBackGroundImage()
  local bgIndex = {}
  for k, v in pairs(self._bgItem) do
    bgIndex[v] = k
  end
  local _bgManager = {
    [bgIndex.base] = {
      isOpen = true,
      imageCount = 3,
      iconPath = "bgBase_"
    },
    [bgIndex.calpeon] = {
      isOpen = ToClient_IsContentsGroupOpen("2"),
      imageCount = 6,
      iconPath = "bgCalpeon_"
    },
    [bgIndex.media] = {
      isOpen = ToClient_IsContentsGroupOpen("3"),
      imageCount = 2,
      iconPath = "bgMedia_"
    },
    [bgIndex.valencia] = {
      isOpen = ToClient_IsContentsGroupOpen("4"),
      imageCount = 6,
      iconPath = "bgValencia_"
    },
    [bgIndex.sea] = {
      isOpen = ToClient_IsContentsGroupOpen("83"),
      imageCount = 3,
      iconPath = "bgValenciaSea_"
    },
    [bgIndex.kamasilvia] = {
      isOpen = ToClient_IsContentsGroupOpen("5"),
      imageCount = 7,
      iconPath = "bgKamasilvia_"
    },
    [bgIndex.kamasilvia2] = {
      isOpen = ToClient_IsContentsGroupOpen("260"),
      imageCount = 3,
      iconPath = "bgKamasilvia2_Server_"
    },
    [bgIndex.dragan] = {
      isOpen = ToClient_IsContentsGroupOpen("6"),
      imageCount = 1,
      iconPath = "bgDraganServer_"
    },
    [bgIndex.odyllita] = {
      isOpen = ToClient_IsContentsGroupOpen("7"),
      imageCount = 4,
      iconPath = "bgOdyllita_"
    },
    [bgIndex.xmas] = {
      isOpen = ToClient_isEventOn("x-mas"),
      imageCount = 1,
      iconPath = "bgXmas_"
    },
    [bgIndex.halloween] = {
      isOpen = ToClient_isEventOn("Halloween"),
      imageCount = 3,
      iconPath = "bgHalloween_"
    },
    [bgIndex.thanksGivingDay] = {
      isOpen = ToClient_isEventOn("ThanksGivingDay"),
      imageCount = 2,
      iconPath = "bgThanksGivingDay_"
    },
    [bgIndex.aurora] = {
      isOpen = ToClient_isEventOn("Aurora"),
      imageCount = 2,
      iconPath = "bgAurora_"
    },
    [bgIndex.KoreaOnly] = {
      isOpen = isGameTypeKorea() and false,
      imageCount = 1,
      iconPath = "bgKoreaOnly2_"
    },
    [bgIndex.JapanOnly] = {
      isOpen = isGameTypeJapan() and false,
      imageCount = 2,
      iconPath = "bgJapanOnly_"
    },
    [bgIndex.RussiaOnly] = {
      isOpen = isGameTypeRussia() and false,
      imageCount = 0,
      iconPath = "bgRussiaOnly_"
    },
    [bgIndex.NaOnly] = {
      isOpen = isGameTypeEnglish() and false,
      imageCount = 4,
      iconPath = "bgNAOnly_"
    },
    [bgIndex.TaiwanOnly] = {
      isOpen = isGameTypeTaiwan() and false,
      imageCount = 0,
      iconPath = "bgTaiwanOnly_"
    },
    [bgIndex.KR2Only] = {
      isOpen = isGameTypeKR2() and false,
      imageCount = 0,
      iconPath = "bgKR2Only_"
    },
    [bgIndex.SAOnly] = {
      isOpen = isGameTypeSA() and false,
      imageCount = 0,
      iconPath = "bgSAOnly_"
    },
    [bgIndex.TROnly] = {
      isOpen = isGameTypeTR() and false,
      imageCount = 0,
      iconPath = "bgTROnly_"
    },
    [bgIndex.THOnly] = {
      isOpen = isGameTypeTH() and false,
      imageCount = 0,
      iconPath = "bgTHOnly_"
    },
    [bgIndex.IDOnly] = {
      isOpen = isGameTypeID() and false,
      imageCount = 0,
      iconPath = "bgIDOnly_"
    }
  }
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  local imageIndex = 1
  local startIndex, endIndex
  local tempBg = UI.getChildControl(Panel_Lobby_ServerSelect_All, "bgBase_1")
  for v, value in ipairs(_bgManager) do
    if value.isOpen then
      self._totalBG = self._totalBG + value.imageCount
      if value.imageCount > 0 then
        startIndex = imageIndex
        for index = 1, value.imageCount do
          local targetControl = UI.createControl(__ePAUIControl_Static, Panel_Lobby_ServerSelect_All, "Static_ServerSelectBg_" .. imageIndex)
          CopyBaseProperty(tempBg, targetControl)
          targetControl:ChangeTextureInfoName("New_UI_Common_forLua/Window/Lobby/" .. value.iconPath .. index .. ".dds")
          targetControl:SetSize(screenX, screenY)
          targetControl:SetPosX(0)
          targetControl:SetPosY(0)
          targetControl:SetAlpha(0)
          Panel_Lobby_ServerSelect_All:SetChildIndex(targetControl, 0)
          self._stc_BackgroundImage[imageIndex] = targetControl
          endIndex = imageIndex
          imageIndex = imageIndex + 1
        end
      end
    end
  end
  tempBg:SetShow(false)
  self._currentBackIndex = getRandomValue(startIndex, endIndex)
end
function PaGlobal_ServerSelect_All:showChannelIcon(buttonBG, iconType, monotone)
  local iconControl = self:getChannelIcon(buttonBG, iconType)
  iconControl:SetShow(true)
  iconControl:SetMonoTone(true == monotone)
  self:updateChannelIconPos(buttonBG, iconType)
  return iconControl
end
function PaGlobal_ServerSelect_All:getChannelIcon(buttonBG, iconType)
  if self._CHANNEL_TYPE.WAR_INFO == iconType then
    return UI.getChildControl(buttonBG, "StaticText_ChannelIcon4_War")
  elseif self._CHANNEL_TYPE.OLVIA_CHANNEL == iconType then
    return UI.getChildControl(buttonBG, "Static_ChannelIcon1_EXP")
  elseif self._CHANNEL_TYPE.PC_ROOM_CHANNEL == iconType then
    return UI.getChildControl(buttonBG, "Static_ChannelIcon2_PCR")
  elseif self._CHANNEL_TYPE.ARSHA_CHANNEL == iconType then
    return UI.getChildControl(buttonBG, "Static_ChannelIcon3_Arsha")
  elseif self._CHANNEL_TYPE.MAINTERNANCE == iconType then
    return UI.getChildControl(buttonBG, "StaticText_ChannelIcon5_Maintenance")
  elseif self._CHANNEL_TYPE.READY_MAINTERNANCE == iconType then
    return UI.getChildControl(buttonBG, "StaticText_ReadyForMainternance")
  elseif self._CHANNEL_TYPE.NO_ACCESS == iconType then
    return UI.getChildControl(buttonBG, "StaticText_ChannelIcon_NoAccess")
  elseif self._CHANNEL_TYPE.SEASONCHANNEL == iconType then
    return UI.getChildControl(buttonBG, "StaticText_Season")
  elseif self._CHANNEL_TYPE.SEASON_ARSHA_CHANNEL == iconType then
    return UI.getChildControl(buttonBG, "Static_ChannelIcon3_Arsha")
  end
end
function PaGlobal_ServerSelect_All:updateChannelIconPos(buttonBG, iconType)
  local addIconPos = 0
  for i = self._CHANNEL_TYPE.WAR_INFO, self._CHANNEL_TYPE.ARSHA_CHANNEL do
    if i ~= iconType then
      local temp = self:getChannelIcon(buttonBG, i)
      if true == temp:GetShow() then
        addIconPos = addIconPos + temp:GetSizeX()
      end
    end
  end
  if true == _ContentsGroup_SeasonContents and self._CHANNEL_TYPE.SEASONCHANNEL ~= iconType then
    local seasonIcon = self:getChannelIcon(buttonBG, self._CHANNEL_TYPE.SEASONCHANNEL)
    if true == seasonIcon:GetShow() then
      addIconPos = addIconPos + seasonIcon:GetSizeX()
    end
  end
  local iconControl = self:getChannelIcon(buttonBG, iconType)
  local nameContorl = UI.getChildControl(buttonBG, "StaticText_Name")
  iconControl:SetPosX(nameContorl:GetSpanSize().x + nameContorl:GetTextSizeX() + 10 + addIconPos)
end
function PaGlobal_ServerSelect_All:initTreeLateUpdate()
  if true == self._lateUpdateFlag then
    return
  end
  self:initTreeData()
  self._lateUpdateFlag = true
end
function PaGlobal_ServerSelect_All:initBanners_PC()
  if true == self._isConsole then
    return
  end
  if true == _ContentsGroup_PreSeason then
    self._ui._stc_bannerSeason:SetShow(true)
    self._ui._stc_bannerSeason:addInputEvent("Mouse_LUp", "PaGlobal_Homepage_Open()")
    self._ui._stc_bannerSeason:ComputePos()
  end
end
function PaGlobal_ServerSelect_All:initBanners()
  if false == self._isConsole then
    return
  end
  if true == _ContentsGroup_XB_Obt then
    self._ui._stc_bannerArea:SetShow(false)
    self._ui._stc_bannerAreaObt:SetShow(true)
    return
  elseif false == _ContentsGroup_Console_WebBanner then
    self._ui._stc_bannerArea:SetShow(false)
    self._ui._stc_bannerAreaObt:SetShow(false)
    return
  end
  self._ui._stc_bannerAreaObt:SetShow(false)
  self._ui._stc_bannerArea:SetShow(true)
  self._ui._stc_bannerBgList = {
    [0] = UI.getChildControl(self._ui._stc_bannerArea, "Static_TopBanner"),
    [1] = UI.getChildControl(self._ui._stc_bannerArea, "Static_MidBanner"),
    [2] = UI.getChildControl(self._ui._stc_bannerArea, "Static_BottomBanner")
  }
  local domainURL = ""
  if nil ~= ToClient_getXBoxBannerURL then
    domainURL = ToClient_getXBoxBannerURL()
  end
  if nil == domainURL or "" == domainURL then
    domainURL = "https://dev-game-portal.xbox.playblackdesert.com/Banner?bannerType="
  else
    domainURL = "https://" .. domainURL .. "/Ingame/Banner?bannerType="
  end
  domainURL = domainURL .. "0&bannerPosition="
  self._ui._web_bannerList = {}
  for ii = 0, #self._ui._stc_bannerBgList do
    self._ui._web_bannerList[ii] = UI.createControl(__ePAUIControl_WebControl, self._ui._stc_bannerBgList[ii], "web_topBanner" .. ii)
    self._ui._web_bannerList[ii]:SetSize(self._ui._stc_bannerBgList[ii]:GetSizeX() - 20, self._ui._stc_bannerBgList[ii]:GetSizeY() - 20)
    self._ui._web_bannerList[ii]:SetHorizonCenter()
    self._ui._web_bannerList[ii]:SetVerticalMiddle()
    self._ui._web_bannerList[ii]:SetUrl(self._ui._web_bannerList[ii]:GetSizeX(), self._ui._web_bannerList[ii]:GetSizeY(), domainURL .. tostring(ii), false, true)
    self._ui._stc_bannerBgList[ii]:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventPad_ServerSelect_All_ToWebBanner(\"LB\", " .. ii .. ")")
    self._ui._stc_bannerBgList[ii]:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventPad_ServerSelect_All_ToWebBanner(\"RB\", " .. ii .. ")")
    self._ui._stc_bannerBgList[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventPad_ServerSelect_All_ToWebBanner(\"CLICK\", " .. ii .. ")")
  end
  local keyGuideLB = UI.getChildControl(self._ui._stc_bannerBgList[1], "StaticText_KeyGuideLB")
  local keyGuideRB = UI.getChildControl(self._ui._stc_bannerBgList[1], "StaticText_KeyGuideRB")
  self._ui._stc_bannerBgList[1]:SetChildIndex(keyGuideLB, self._ui._stc_bannerBgList[1]:GetChildSize())
  self._ui._stc_bannerBgList[1]:SetChildIndex(keyGuideRB, self._ui._stc_bannerBgList[1]:GetChildSize())
  if _ContentsGroup_XB_Obt then
    for ii = 0, #self._ui._web_bannerList do
      self._ui._web_bannerList[ii]:ResetUrl()
    end
  end
end
function PaGlobal_ServerSelect_All:setCrossplayOption()
  local isCrossplayMode = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
  if false == setSamePlatformOnly(not isCrossplayMode) then
    ToClient_showPrivilegeError(false, true)
    return
  end
  if true == isCrossplayMode then
    self._ui._console._txt_crossplayKey:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CROSSPLAY_OPTIONON"))
  else
    self._ui._console._txt_crossplayKey:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CROSSPLAY_OPTIONOFF"))
  end
  saveGameOption(false)
end
