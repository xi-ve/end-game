PaGlobal_GuildWebInfo_All = {
  _ui = {
    btn_Close = nil,
    btn_Refresh = nil,
    btn_Question = nil,
    stc_Main = nil,
    stc_Web = nil
  },
  _contentsOptionWeb = ToClient_IsContentsGroupOpen("206"),
  _webSizeX = 870,
  _webSizeY = 630,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildWebInfo_All_Init")
function FromClient_GuildWebInfo_All_Init()
  PaGlobal_GuildWebInfo_All:initialize()
end
function PaGlobal_GuildWebInfo_All:initialize()
  if true == PaGlobal_GuildWebInfo_All._initialize or nil == Panel_GuildWebInfo_All then
    return
  end
  local stc_TitleBg = UI.getChildControl(Panel_GuildWebInfo_All, "Static_TitleArea")
  self._ui.btn_Close = UI.getChildControl(stc_TitleBg, "Button_Close")
  self._ui.btn_Question = UI.getChildControl(stc_TitleBg, "Button_Question")
  self._ui.btn_Refresh = UI.getChildControl(stc_TitleBg, "Button_Refresh")
  self._ui.stc_Main = UI.getChildControl(Panel_GuildWebInfo_All, "Static_Main")
  self._ui.stc_Web = UI.createControl(__ePAUIControl_WebControl, Panel_GuildWebInfo_All, "WebControl_GuildWebInfo_All_WebLink")
  self._ui.stc_Web:SetShow(true)
  self._ui.stc_Web:SetPosX(10)
  self._ui.stc_Web:SetPosY(58)
  self._ui.stc_Web:SetSize(self._webSizeX, self._webSizeY)
  self._ui.stc_Web:ResetUrl()
  self._ui.btn_Refresh:SetShow(_ContentsGroup_ResetCoherent)
  PaGlobal_GuildWebInfo_All:validate()
  PaGlobal_GuildWebInfo_All:registEventHandler()
  PaGlobal_GuildWebInfo_All._initialize = true
end
function PaGlobal_GuildWebInfo_All:registEventHandler()
  if nil == Panel_GuildWebInfo_All then
    return
  end
  Panel_GuildWebInfo_All:SetDragEnable(true)
  Panel_GuildWebInfo_All:setGlassBackground(true)
  Panel_GuildWebInfo_All:ActiveMouseEventEffect(true)
  Panel_GuildWebInfo_All:RegisterShowEventFunc(true, "PaGlobalFunc_GuildWebInfo_All_ShowAni()")
  Panel_GuildWebInfo_All:RegisterShowEventFunc(false, "PaGlobalFunc_GuildWebInfo_All_HideAni()")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildWebInfo_All_Close()")
  PaGlobal_Util_RegistWebResetControl(self._ui.btn_Refresh)
  registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForGuildWebInfoAll")
  registerEvent("FromClient_GuildWebInfoByName", "FromClient_GuildWebInfo_All_OpenGuildWebInfo_ByName")
end
function PaGlobal_GuildWebInfo_All:prepareOpen(url)
  if nil == url or "" == url then
    return
  end
  FGlobal_SetCandidate()
  self._ui.stc_Web:SetSize(self._webSizeX, self._webSizeY)
  self._ui.stc_Web:SetUrl(self._webSizeX, self._webSizeY, url, false, true)
  self._ui.stc_Web:SetIME(true)
  PaGlobalFunc_GuildWebInfo_All_OnScreenResize()
  audioPostEvent_SystemUi(13, 6)
  _AudioPostEvent_SystemUiForXBOX(13, 6)
  PaGlobal_GuildWebInfo_All:open()
end
function PaGlobal_GuildWebInfo_All:open()
  if nil == Panel_GuildWebInfo_All then
    return
  end
  Panel_GuildWebInfo_All:SetShow(true, true)
end
function PaGlobal_GuildWebInfo_All:prepareClose()
  if nil == Panel_GuildWebInfo_All then
    return
  end
  self._ui.stc_Web:ResetUrl()
  FGlobal_ClearCandidate()
  ClearFocusEdit()
  audioPostEvent_SystemUi(13, 5)
  _AudioPostEvent_SystemUiForXBOX(13, 5)
  PaGlobal_GuildWebInfo_All:close()
end
function PaGlobal_GuildWebInfo_All:close()
  if nil == Panel_GuildWebInfo_All then
    return
  end
  Panel_GuildWebInfo_All:SetShow(false, false)
end
function PaGlobal_GuildWebInfo_All:validate()
  if nil == Panel_GuildWebInfo_All then
    return
  end
  self._ui.btn_Close:isValidate()
  self._ui.stc_Main:isValidate()
  self._ui.btn_Question:isValidate()
end
function PaGlobalFunc_GuildWebInfo_All_GuildWebInfoOpen(listIdx)
  if false == PaGlobal_GuildWebInfo_All._contentsOptionWeb then
    return
  end
  local guildRanker = ToClient_GetGuildRankingInfoAt(listIdx)
  local guildNo_str = tostring(guildRanker:getGuildNo_s64())
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local curChannelData = getCurrentChannelServerData()
  local serverNo = curChannelData._worldNo
  local userNo = selfPlayer:get():getUserNo()
  local cryptKey = selfPlayer:get():getWebAuthenticKeyCryptString()
  local playerLevel = selfPlayer:get():getLevel()
  local characterNo_64 = selfPlayer:getCharacterNo_64()
  local characterName = selfPlayer:getOriginalName()
  local userNickName = selfPlayer:getUserNickname()
  local classType = selfPlayer:getClassType()
  local selfPlayerGuildNo_64 = tostring(selfPlayer:getGuildNo_s64())
  local isGuildMaster = false
  if selfPlayerGuildNo_64 == GuildNo_str then
    isGuildMaster = selfPlayer:get():isGuildMaster() or selfPlayer:get():isGuildSubMaster()
  end
  local isGameMaster = ToClient_SelfPlayerIsGM()
  local guildName = guildRanker:getGuildName()
  local guildMasterName = guildRanker:getGuildMasterNickName()
  local guildPoint = guildRanker._guildAquiredPoint
  local guildRegDate = tostring(guildRanker:getGuildCreatedDate())
  local guildArea1 = ""
  local territoryKey = ""
  local territoryWarName = ""
  local territoryKeyParam = ""
  if 0 < guildRanker:getTerritoryCount() then
    for idx = 0, guildRanker:getTerritoryCount() - 1 do
      territoryKey = guildRanker:getTerritoryKeyAt(idx)
      local territoryInfoWrapper = getTerritoryInfoWrapperByIndex(territoryKey)
      if nil ~= territoryInfoWrapper then
        guildArea1 = territoryInfoWrapper:getTerritoryName()
        local territoryComma = ","
        if "" == territoryWarName then
          territoryComma = ""
        end
        local territoryKeyParamComma = ","
        if "" == territoryKeyParam then
          territoryKeyParamComma = ""
        end
        territoryWarName = territoryWarName .. territoryComma .. guildArea1
        territoryKeyParam = territoryKeyParam .. territoryKeyParamComma .. territoryKey
      end
    end
  end
  local guildArea2 = ""
  local regionKey = ""
  local siegeWarName = ""
  local regionKeyParam = ""
  if 0 < guildRanker:getSiegeCount() then
    for idx = 0, guildRanker:getSiegeCount() - 1 do
      regionKey = guildRanker:getSiegeKeyAt(idx)
      local regionInfoWrapper = getRegionInfoWrapper(regionKey)
      if nil ~= regionInfoWrapper then
        guildArea2 = regionInfoWrapper:getAreaName()
        local siegeComma = ","
        if "" == siegeWarName then
          siegeComma = ""
        end
        local regionKeyComma = ","
        if "" == regionKeyParam then
          regionKeyComma = ""
        end
        siegeWarName = siegeWarName .. siegeComma .. guildArea2
        regionKeyParam = regionKeyParam .. regionKeyComma .. regionKey
      end
    end
  end
  local guildCount = guildRanker._guildMemberCount
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local url = PaGlobal_URL_Check(worldNo)
  url = url .. "/Guildinfo?guildNo=" .. GuildNo_str
  url = url .. "&certKey=" .. tostring(cryptKey)
  url = url .. "&userNo=" .. tostring(userNo)
  url = url .. "&level=" .. tostring(playerLevel)
  url = url .. "&characterNo=" .. tostring(characterNo_64)
  url = url .. "&characterName=" .. tostring(characterName)
  url = url .. "&userNickname=" .. tostring(userNickName)
  url = url .. "&classType=" .. tostring(classType)
  url = url .. "&isGM=" .. tostring(isGameMaster)
  url = url .. "&isMaster=" .. tostring(isGuildMaster)
  url = url .. "&guildName=" .. tostring(guildName)
  url = url .. "&guildMasterName=" .. tostring(guildMasterName)
  url = url .. "&guildPoint=" .. tostring(guildPoint)
  url = url .. "&guildRegdate=" .. guildRegDate
  url = url .. "&guildArea1=" .. tostring(territoryWarName)
  url = url .. "&territoryKey=" .. tostring(territoryKeyParam)
  url = url .. "&guildArea2=" .. tostring(siegeWarName)
  url = url .. "&regionKey=" .. tostring(regionKeyParam)
  url = url .. "&guildCount=" .. tostring(guildCount)
  PaGlobal_GuildWebInfo_All:prepareOpen(url)
end
function FGlobal_GuildWebInfoForGuildRank_Open(guildNo_string)
  if false == PaGlobal_GuildWebInfo_All._contentsOptionWeb then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local userNo = selfPlayer:get():getUserNo()
  local cryptKey = selfPlayer:get():getWebAuthenticKeyCryptString()
  local playerLevel = selfPlayer:get():getLevel()
  local classType = selfPlayer:getClassType()
  local selfPlayerGuildNo_64 = tostring(selfPlayer:getGuildNo_s64())
  local isGuildMaster = false
  if selfPlayerGuildNo_64 == guildNo_string then
    isGuildMaster = selfPlayer:get():isGuildMaster() or selfPlayer:get():isGuildSubMaster()
  end
  local isGameMaster = ToClient_SelfPlayerIsGM()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local url = PaGlobal_URL_Check(worldNo)
  url = url .. "/Guildinfo?guildNo=" .. guildNo_string
  url = url .. "&certKey=" .. tostring(cryptKey)
  url = url .. "&level=" .. tostring(playerLevel)
  url = url .. "&classType=" .. tostring(classType)
  url = url .. "&isGM=" .. tostring(isGameMaster)
  url = url .. "&isMaster=" .. tostring(isGuildMaster)
  url = url .. "&userNo=" .. tostring(userNo)
  PaGlobal_GuildWebInfo_All:prepareOpen(url)
end
function FromClient_GuildWebInfo_All_OpenGuildWebInfo_ByName()
  if false == PaGlobal_GuildWebInfo_All._contentsOptionWeb then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local guildWebInfo = ToClient_GetGuildWebInfo()
  local GuildNo_str = tostring(guildWebInfo:getGuildNo())
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local curChannelData = getCurrentChannelServerData()
  local serverNo = curChannelData._worldNo
  local userNo = selfPlayer:get():getUserNo()
  local cryptKey = selfPlayer:get():getWebAuthenticKeyCryptString()
  local playerLevel = selfPlayer:get():getLevel()
  local characterNo_64 = selfPlayer:getCharacterNo_64()
  local characterName = selfPlayer:getOriginalName()
  local classType = selfPlayer:getClassType()
  local selfPlayerGuildNo_64 = tostring(selfPlayer:getGuildNo_s64())
  local isGuildMaster = false
  if selfPlayerGuildNo_64 == GuildNo_str then
    isGuildMaster = selfPlayer:get():isGuildMaster() or selfPlayer:get():isGuildSubMaster()
  end
  local isGameMaster = ToClient_SelfPlayerIsGM()
  local guildNo = guildWebInfo:getGuildNo()
  local guildName = guildWebInfo:getGuildName()
  local guildMasterName = guildWebInfo:getGuildMasterNickName()
  local guildPoint = guildWebInfo:getGuildPoint()
  local guildRegDate = tostring(guildWebInfo:getGuildCreatedDate())
  local guildMemberCount = guildWebInfo:getGuildMemberCount()
  local guildRanking = guildWebInfo:getGuildRanking()
  local guildArea1 = ""
  local territoryKey = ""
  local territoryWarName = ""
  local territoryKeyParam = ""
  if 0 < guildWebInfo:getTerritoryCount() then
    for idx = 0, guildWebInfo:getTerritoryCount() - 1 do
      territoryKey = guildWebInfo:getTerritoryKeyAt(idx)
      local territoryInfoWrapper = getTerritoryInfoWrapperByIndex(territoryKey)
      if nil ~= territoryInfoWrapper then
        guildArea1 = territoryInfoWrapper:getTerritoryName()
        local territoryComma = ","
        if "" == territoryWarName then
          territoryComma = ""
        end
        local territoryKeyParamComma = ","
        if "" == territoryKeyParam then
          territoryKeyParamComma = ""
        end
        territoryWarName = territoryWarName .. territoryComma .. guildArea1
        territoryKeyParam = territoryKeyParam .. territoryKeyParamComma .. territoryKey
      end
    end
  end
  local guildArea2 = ""
  local regionKey = ""
  local siegeWarName = ""
  local regionKeyParam = ""
  if 0 < guildWebInfo:getRegionCount() then
    for idx = 0, guildWebInfo:getRegionCount() - 1 do
      regionKey = guildWebInfo:getRegionKeyAt(idx)
      local regionInfoWrapper = getRegionInfoWrapper(regionKey)
      if nil ~= regionInfoWrapper then
        guildArea2 = regionInfoWrapper:getAreaName()
        local siegeComma = ","
        if "" == siegeWarName then
          siegeComma = ""
        end
        local regionKeyComma = ","
        if "" == regionKeyParam then
          regionKeyComma = ""
        end
        siegeWarName = siegeWarName .. siegeComma .. guildArea2
        regionKeyParam = regionKeyParam .. regionKeyComma .. regionKey
      end
    end
  end
  local guildCount = guildWebInfo:getGuildMemberCount()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local url = PaGlobal_URL_Check(worldNo)
  url = url .. "/Guildinfo?guildNo=" .. GuildNo_str
  url = url .. "&certKey=" .. tostring(cryptKey)
  url = url .. "&userNo=" .. tostring(userNo)
  url = url .. "&level=" .. tostring(playerLevel)
  url = url .. "&characterNo=" .. tostring(characterNo_64)
  url = url .. "&characterName=" .. tostring(characterName)
  url = url .. "&userNickname=" .. tostring(userNickName)
  url = url .. "&classType=" .. tostring(classType)
  url = url .. "&isGM=" .. tostring(isGameMaster)
  url = url .. "&isMaster=" .. tostring(isGuildMaster)
  url = url .. "&guildName=" .. tostring(guildName)
  url = url .. "&guildMasterName=" .. tostring(guildMasterName)
  url = url .. "&guildPoint=" .. tostring(guildPoint)
  url = url .. "&guildRegdate=" .. guildRegDate
  url = url .. "&guildArea1=" .. tostring(territoryWarName)
  url = url .. "&territoryKey=" .. tostring(territoryKeyParam)
  url = url .. "&guildArea2=" .. tostring(siegeWarName)
  url = url .. "&regionKey=" .. tostring(regionKeyParam)
  url = url .. "&guildCount=" .. tostring(guildCount)
  PaGlobal_GuildWebInfo_All:prepareOpen(url)
end
function PaGlobalFunc_GuildWebInfo_All_GuildMainOpen()
  if false == PaGlobal_GuildWebInfo_All._contentsOptionWeb then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local GuildNo_str = tostring(myGuildInfo:getGuildNo_s64())
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local curChannelData = getCurrentChannelServerData()
  local serverNo = curChannelData._worldNo
  local userNo = selfPlayer:get():getUserNo()
  local cryptKey = selfPlayer:get():getWebAuthenticKeyCryptString()
  local playerLevel = selfPlayer:get():getLevel()
  local characterNo_64 = selfPlayer:getCharacterNo_64()
  local characterName = selfPlayer:getOriginalName()
  local userNickName = selfPlayer:getUserNickname()
  local classType = selfPlayer:getClassType()
  local selfPlayerGuildNo_64 = tostring(selfPlayer:getGuildNo_s64())
  local isGuildMaster = false
  if selfPlayerGuildNo_64 == GuildNo_str then
    isGuildMaster = selfPlayer:get():isGuildMaster() or selfPlayer:get():isGuildSubMaster()
  end
  local isGameMaster = ToClient_SelfPlayerIsGM()
  local guildName = myGuildInfo:getName()
  local guildMasterName = myGuildInfo:getGuildMasterName()
  local guildPoint = myGuildInfo:getAquiredSkillPoint()
  local guildRegDate = tostring(myGuildInfo:getGuildCreatedDate())
  local guildArea1 = ""
  local territoryKey = ""
  local territoryWarName = ""
  local territoryKeyParam = ""
  if 0 < myGuildInfo:getTerritoryCount() then
    for idx = 0, myGuildInfo:getTerritoryCount() - 1 do
      territoryKey = myGuildInfo:getTerritoryKeyAt(idx)
      local territoryInfoWrapper = getTerritoryInfoWrapperByIndex(territoryKey)
      if nil ~= territoryInfoWrapper then
        guildArea1 = territoryInfoWrapper:getTerritoryName()
        local territoryComma = ","
        if "" == territoryWarName then
          territoryComma = ""
        end
        local territoryKeyParamComma = ","
        if "" == territoryKeyParam then
          territoryKeyParamComma = ""
        end
        territoryWarName = territoryWarName .. territoryComma .. guildArea1
        territoryKeyParam = territoryKeyParam .. territoryKeyParamComma .. territoryKey
      end
    end
  end
  local guildArea2 = ""
  local regionKey = ""
  local siegeWarName = ""
  local regionKeyParam = ""
  if 0 < myGuildInfo:getSiegeCount() then
    for idx = 0, myGuildInfo:getSiegeCount() - 1 do
      regionKey = myGuildInfo:getSiegeKeyAt(idx)
      local regionInfoWrapper = getRegionInfoWrapper(regionKey)
      if nil ~= regionInfoWrapper then
        guildArea2 = regionInfoWrapper:getAreaName()
        local siegeComma = ","
        if "" == siegeWarName then
          siegeComma = ""
        end
        local regionKeyComma = ","
        if "" == regionKeyParam then
          regionKeyComma = ""
        end
        siegeWarName = siegeWarName .. siegeComma .. guildArea2
        regionKeyParam = regionKeyParam .. regionKeyComma .. regionKey
      end
    end
  end
  local guildCount = myGuildInfo:getMemberCount()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local url = PaGlobal_URL_Check(worldNo)
  url = url .. "/Guildinfo?guildNo=" .. GuildNo_str
  url = url .. "&certKey=" .. tostring(cryptKey)
  url = url .. "&userNo=" .. tostring(userNo)
  url = url .. "&level=" .. tostring(playerLevel)
  url = url .. "&characterNo=" .. tostring(characterNo_64)
  url = url .. "&characterName=" .. tostring(characterName)
  url = url .. "&userNickname=" .. tostring(userNickName)
  url = url .. "&classType=" .. tostring(classType)
  url = url .. "&isGM=" .. tostring(isGameMaster)
  url = url .. "&isMaster=" .. tostring(isGuildMaster)
  url = url .. "&guildName=" .. tostring(guildName)
  url = url .. "&guildMasterName=" .. tostring(guildMasterName)
  url = url .. "&guildPoint=" .. tostring(guildPoint)
  url = url .. "&guildRegdate=" .. guildRegDate
  url = url .. "&guildArea1=" .. tostring(territoryWarName)
  url = url .. "&territoryKey=" .. tostring(territoryKeyParam)
  url = url .. "&guildArea2=" .. tostring(siegeWarName)
  url = url .. "&regionKey=" .. tostring(regionKeyParam)
  url = url .. "&guildCount=" .. tostring(guildCount)
  PaGlobal_GuildWebInfo_All:prepareOpen(url)
end
function PaGlobalFunc_GuildWebInfo_All_OnScreenResize()
  if nil == Panel_GuildWebInfo_All then
    return
  end
  Panel_GuildWebInfo_All:SetPosX(getScreenSizeX() / 2 - Panel_GuildWebInfo_All:GetSizeX() / 2)
  Panel_GuildWebInfo_All:SetPosY(getScreenSizeY() / 2 - Panel_GuildWebInfo_All:GetSizeY() / 2)
end
function PaGlobalFunc_GuildWebInfo_All_Close()
  if nil == Panel_GuildWebInfo_All then
    return
  end
  PaGlobal_GuildWebInfo_All:prepareClose()
end
function PaGlobalFunc_GuildWebInfo_All_ShowAni()
  UIAni.fadeInSCR_Down(Panel_GuildWebInfo_All)
  local aniInfo1 = Panel_GuildWebInfo_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_GuildWebInfo_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_GuildWebInfo_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_GuildWebInfo_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_GuildWebInfo_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_GuildWebInfo_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobalFunc_GuildWebInfo_All_HideAni()
  Panel_GuildWebInfo_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_GuildWebInfo_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function FromClient_resetCoherentUIForGuildWebInfoAll()
  if Panel_GuildWebInfo_All:GetShow() then
    TooltipSimple_Hide()
    PaGlobalFunc_GuildWebInfo_All_Close()
  end
end
