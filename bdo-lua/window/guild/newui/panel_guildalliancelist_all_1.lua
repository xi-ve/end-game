function PaGlobal_GuildAllianceList_All:initialize()
  if true == PaGlobal_GuildAllianceList_All._initialize or nil == Panel_GuildAllianceList_All then
    return
  end
  self._ui.stc_LeftBg = UI.getChildControl(Panel_GuildAllianceList_All, "Static_LeftArea")
  self._ui.stc_Left = UI.getChildControl(self._ui.stc_LeftBg, "Static_LeftInfo")
  self._ui.stc_MarkBg = UI.getChildControl(self._ui.stc_Left, "Static_MarkBG")
  self._ui.stc_Mark = UI.getChildControl(self._ui.stc_MarkBg, "Static_Mark")
  self._ui.txt_Name = UI.getChildControl(self._ui.stc_Left, "StaticText_AlianceName")
  self._ui.txt_Territory = UI.getChildControl(self._ui.stc_Left, "StaticText_AlianceTerritory")
  self._ui.txt_MemberCount = UI.getChildControl(self._ui.stc_Left, "StaticText_AlianceMember")
  self._ui.list2_GuildList = UI.getChildControl(self._ui.stc_LeftBg, "List2_GuildList")
  self._ui.stc_Bottom = UI.getChildControl(self._ui.stc_LeftBg, "Static_BottomArea")
  self._ui.txt_TodayCommentTitle = UI.getChildControl(self._ui.stc_Bottom, "StaticText_TodayComment")
  self._ui.stc_RightBg = UI.getChildControl(Panel_GuildAllianceList_All, "Static_RIghtArea")
  self._ui.txt_allianceInfoTitle = UI.getChildControl(self._ui.stc_RightBg, "StaticText_AlianceInfo")
  self._ui.stc_TitleBar = UI.getChildControl(self._ui.stc_RightBg, "Static_ListTitleBar")
  self._ui.txt_GradeBar = UI.getChildControl(self._ui.stc_TitleBar, "StaticText_Grade")
  self._ui.txt_LevelBar = UI.getChildControl(self._ui.stc_TitleBar, "StaticText_Level")
  self._ui.txt_ClassBar = UI.getChildControl(self._ui.stc_TitleBar, "StaticText_Class")
  self._ui.txt_NameBar = UI.getChildControl(self._ui.stc_TitleBar, "StaticText_Name")
  self._ui.txt_GuildBar = UI.getChildControl(self._ui.stc_TitleBar, "StaticText_Guild")
  self._ui.list2_Member = UI.getChildControl(self._ui.stc_RightBg, "List2_1_MemberList")
  self._ui.stc_OnlyConsoleBg = UI.getChildControl(self._ui.stc_Bottom, "Static_OnlyConsoleBG")
  UI.setLimitTextAndAddTooltip(self._ui.txt_allianceInfoTitle)
  self._ui.stc_Bottom:SetAlpha(0.5)
  if false == _ContentsGroup_UsePadSnapping then
    self._ui.stc_webControl = UI.createControl(__ePAUIControl_WebControl, self._ui.stc_Bottom, "WebControl_AlliComment")
    self._ui.stc_webControl:SetShow(true)
    self._ui.stc_webControl:SetSize(self._ui.stc_Bottom:GetSizeX() - 10, self._ui.stc_Bottom:GetSizeY() - 30)
    self._ui.stc_webControl:SetHorizonCenter()
    self._ui.stc_webControl:SetVerticalBottom()
    self._ui.stc_webControl:SetSpanSize(self._ui.stc_webControl:GetSpanSize().x, self._ui.stc_webControl:GetSpanSize().y + 5)
    self._ui.stc_webControl:ResetUrl()
  else
    local content = UI.getChildControl(self._ui.list2_GuildList, "List2_1_Content")
    self._ui.list2_GuildList:SetSize(self._ui.list2_GuildList:GetSizeX(), content:GetSizeY() * 10)
    self._ui.list2_GuildList:ComputePos()
    self._ui.txt_TodayCommentTitle:SetShow(false)
    self._ui.stc_OnlyConsoleBg:SetShow(true)
  end
  PaGlobal_GuildAllianceList_All:validate()
  PaGlobal_GuildAllianceList_All:registEventHandler()
  PaGlobal_GuildAllianceList_All._initialize = true
end
function PaGlobal_GuildAllianceList_All:registEventHandler()
  if nil == Panel_GuildAllianceList_All then
    return
  end
  self._ui.list2_GuildList:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_GuildAlliance_All_List2GuildUpdate")
  self._ui.list2_GuildList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_Member:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_GuildAlliance_All_List2MemberUpdate")
  self._ui.list2_Member:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_GuildAllianceList_All:update()
  if nil == Panel_GuildAllianceList_All then
    return
  end
  local myAllianceWrapper = ToClient_GetMyGuildAllianceWrapper()
  if nil == myAllianceWrapper then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  PaGlobal_GuildAllianceList_All:AllianceInfoUpdate(myAllianceWrapper)
  PaGlobal_GuildAllianceList_All:open()
end
function PaGlobal_GuildAllianceList_All:AllianceInfoUpdate(myAllianceWrapper)
  local isSet = setGuildTextureByAllianceNo(myAllianceWrapper:guildAllianceNo_s64(), self._ui.stc_Mark)
  local x1, y1, x2, y2 = 0, 0, 1, 1
  if false == isSet then
    self._ui.stc_Mark:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_Mark, 183, 1, 188, 6)
  end
  self._ui.stc_Mark:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.stc_Mark:setRenderTexture(self._ui.stc_Mark:getBaseTexture())
  self._ui.txt_Name:SetText(myAllianceWrapper:getRepresentativeName())
  local memberCount = tostring(myAllianceWrapper:getUserCount()) .. " / 100"
  self._ui.txt_MemberCount:SetText(memberCount)
  local txtheader = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_ALLIANCEINFO_OCCUPYAREA") .. " : "
  self._ui.txt_Territory:SetText(txtheader)
  self._ui.txt_Territory:SetTextMode(__eTextMode_LimitText)
  self._ui.txt_Territory:SetText(self._ui.txt_Territory:GetText())
  local myGuildAllianceCache = ToClient_GetMyGuildAlliancChairGuild()
  local guildArea1 = ""
  local territoryKey = ""
  local territoryWarName = ""
  if 0 < myGuildAllianceCache:getTerritoryCount() then
    for idx = 0, myGuildAllianceCache:getTerritoryCount() - 1 do
      territoryKey = myGuildAllianceCache:getTerritoryKeyAt(idx)
      if 0 <= territoryKey then
        local territoryInfoWrapper = getTerritoryInfoWrapperByIndex(territoryKey)
        if nil ~= territoryInfoWrapper then
          guildArea1 = territoryInfoWrapper:getTerritoryName()
          local territoryComma = ", "
          if "" == territoryWarName then
            territoryComma = ""
          end
          territoryWarName = territoryWarName .. territoryComma .. guildArea1
        end
        self._ui.txt_Territory:SetText(txtheader .. territoryWarName)
      end
    end
  end
  local guildArea2 = ""
  local regionKey = ""
  local siegeWarName = ""
  if 0 < myGuildAllianceCache:getSiegeCount() then
    for idx = 0, myGuildAllianceCache:getSiegeCount() - 1 do
      regionKey = myGuildAllianceCache:getSiegeKeyAt(idx)
      if 0 < regionKey then
        local regionInfoWrapper = getRegionInfoWrapper(regionKey)
        if nil ~= regionInfoWrapper then
          guildArea2 = regionInfoWrapper:getAreaName()
          local siegeComma = ", "
          if "" == siegeWarName then
            siegeComma = ""
          end
          siegeWarName = siegeWarName .. siegeComma .. guildArea2
        end
        self._ui.txt_Territory:SetText(txtheader .. siegeWarName)
      end
    end
  end
  self._ui.txt_Territory:addInputEvent("Mouse_On", "HandleEventOnOut_GuildAlliance_All_TerritortyTooltip( true )")
  self._ui.txt_Territory:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildAlliance_All_TerritortyTooltip( false )")
  self._ui.txt_Territory:SetIgnore(false)
  self._ui.txt_Territory:SetEnableArea(0, 0, self._ui.txt_Territory:GetTextSizeX(), self._ui.txt_Territory:GetSizeY())
  self._list2UI = {}
  local guildTotalCount = myAllianceWrapper:getMemberCount()
  self._ui.list2_GuildList:getElementManager():clearKey()
  for index = 0, guildTotalCount - 1 do
    self._ui.list2_GuildList:getElementManager():pushKey(toInt64(0, index))
  end
  PaGlobal_GuildAllianceList_All:updateAllGuildMember()
end
function PaGlobal_GuildAllianceList_All:UpdateAliyNotice(myAllianceWrapper)
  local myGuildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildWrapper then
    return
  end
  local myGuildNo_s64 = myGuildWrapper:getGuildNo_s64()
  if nil == myAllianceWrapper then
    return
  end
  local leaderGuildIndex = 0
  local guildCount = myAllianceWrapper:getMemberCount()
  for index = 0, guildCount - 1 do
    local guildWrapper = myAllianceWrapper:getMemberGuild(index)
    if guildWrapper:isAllianceChair() then
      leaderGuildIndex = index
      break
    end
  end
  local getSelfPlayerGet = getSelfPlayer():get()
  local guildWrapper = myAllianceWrapper:getMemberGuild(leaderGuildIndex)
  local guildNo_s64 = guildWrapper:getGuildNo_s64()
  local myUserNo = getSelfPlayerGet:getUserNo()
  local cryptKey = getSelfPlayerGet:getWebAuthenticKeyCryptString()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  guildCommentsWebUrl = PaGlobal_URL_Check(worldNo)
  local isGuildMaster = getSelfPlayerGet:isGuildMaster()
  local isGuildSubMaster = getSelfPlayerGet:isGuildSubMaster()
  local isAdmin = 0
  if myGuildNo_s64 == guildNo_s64 and (isGuildMaster or isGuildSubMaster) then
    isAdmin = 1
  end
  if false == _ContentsGroup_RenewUI then
    self._ui.stc_webControl:ResetUrl()
    if nil ~= guildCommentsWebUrl then
      FGlobal_SetCandidate()
      local url = guildCommentsWebUrl .. "/guild?guildNo=" .. tostring(myGuildNo_s64) .. "&userNo=" .. tostring(myUserNo) .. "&certKey=" .. tostring(cryptKey) .. "&isMaster=" .. tostring(isAdmin) .. "&chairGuildNo=" .. tostring(guildNo_s64)
      self._ui.stc_webControl:SetUrl(self._ui.stc_Bottom:GetSizeX() - 10, self._ui.stc_Bottom:GetSizeY() - 30, url, false, true)
      self._ui.stc_webControl:SetIME(true)
    end
  end
end
function PaGlobal_GuildAllianceList_All:updateAllGuildMember()
  local myAllianceWrapper = ToClient_GetMyGuildAllianceWrapper()
  if nil == myAllianceWrapper then
    return
  end
  self._ui.list2_Member:getElementManager():clearKey()
  local guildTotalCount = myAllianceWrapper:getMemberCount()
  for index = 0, guildTotalCount - 1 do
    local guildWrapper = myAllianceWrapper:getMemberGuild(Int64toInt32(index))
    if nil ~= guildWrapper then
      local guildMembercount = guildWrapper:getMemberCount()
      for idx = 0, guildMembercount - 1 do
        local memberWrapper = guildWrapper:getMember(Int64toInt32(idx))
        if nil == memberWrapper then
          return
        end
        local nickName = memberWrapper:getName()
        local characterName = memberWrapper:getCharacterName()
        self._ui.list2_Member:getElementManager():pushKey(memberWrapper:getUserNo())
      end
    end
  end
  HandleEventOn_GuildAlliance_All_LoadScrollPos()
end
function PaGlobal_GuildAllianceList_All:open()
  if nil == Panel_GuildAllianceList_All then
    return
  end
  Panel_GuildAllianceList_All:SetShow(true)
end
function PaGlobal_GuildAllianceList_All:prepareClose()
  if nil == Panel_GuildAllianceList_All then
    return
  end
  PaGlobal_GuildAllianceList_All:close()
end
function PaGlobal_GuildAllianceList_All:close()
  if nil == Panel_GuildAllianceList_All then
    return
  end
  Panel_GuildAllianceList_All:SetShow(false)
end
function PaGlobal_GuildAllianceList_All:validate()
  if nil == Panel_GuildAllianceList_All then
    return
  end
  self._ui.stc_LeftBg:isValidate()
  self._ui.stc_Left:isValidate()
  self._ui.stc_MarkBg:isValidate()
  self._ui.stc_MarkBg:isValidate()
  self._ui.txt_Name:isValidate()
  self._ui.txt_Territory:isValidate()
  self._ui.txt_MemberCount:isValidate()
  self._ui.list2_GuildList:isValidate()
  self._ui.stc_Bottom:isValidate()
  self._ui.txt_TodayCommentTitle:isValidate()
  self._ui.stc_RightBg:isValidate()
  self._ui.txt_allianceInfoTitle:isValidate()
  self._ui.stc_TitleBar:isValidate()
  self._ui.txt_GradeBar:isValidate()
  self._ui.txt_LevelBar:isValidate()
  self._ui.txt_ClassBar:isValidate()
  self._ui.txt_NameBar:isValidate()
  self._ui.txt_GuildBar:isValidate()
  self._ui.list2_Member:isValidate()
end
