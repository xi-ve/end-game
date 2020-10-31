function PaGlobal_GuildWarfare_All:initialize()
  if true == PaGlobal_GuildWarfare_All._initialize then
    return
  end
  self._ui.stc_TopBG = UI.getChildControl(Panel_GuildWarfare_All, "Static_TopArea")
  self._ui.txt_CharName = UI.getChildControl(self._ui.stc_TopBG, "StaticText_M_CharName")
  self._ui.stc_CommadCenter = UI.getChildControl(self._ui.stc_TopBG, "Static_M_CommandCenter")
  self._ui.stc_Tower = UI.getChildControl(self._ui.stc_TopBG, "Static_M_Tower")
  self._ui.stc_CastleGate = UI.getChildControl(self._ui.stc_TopBG, "Static_M_CastleGate")
  self._ui.stc_Summons = UI.getChildControl(self._ui.stc_TopBG, "Static_M_Summons")
  self._ui.stc_Installation = UI.getChildControl(self._ui.stc_TopBG, "Static_M_Installation")
  self._ui.stc_Member = UI.getChildControl(self._ui.stc_TopBG, "Static_M_Member")
  self._ui.stc_Death = UI.getChildControl(self._ui.stc_TopBG, "Static_M_Death")
  self._ui.stc_KillBySiege = UI.getChildControl(self._ui.stc_TopBG, "Static_M_KillBySiege")
  self._ui.txt_Sort = UI.getChildControl(self._ui.stc_TopBG, "StaticText_Sort")
  self._ui.stc_MainBG = UI.getChildControl(Panel_GuildWarfare_All, "Static_MainArea")
  self._ui.stc_LeftBG = UI.getChildControl(self._ui.stc_MainBG, "Static_LeftBG")
  self._ui.stc_RightBG = UI.getChildControl(self._ui.stc_MainBG, "Static_RIghtBG")
  self._ui.list2_Warfare = UI.getChildControl(self._ui.stc_MainBG, "List2_Warfare")
  self._ui.txt_IconHelper = UI.getChildControl(Panel_GuildWarfare_All, "StaticText_IconHelper")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._icons = {
    [0] = self._ui.txt_CharName,
    self._ui.stc_CommadCenter,
    self._ui.stc_Tower,
    self._ui.stc_CastleGate,
    self._ui.stc_Summons,
    self._ui.stc_Installation,
    self._ui.stc_Member,
    self._ui.stc_Death,
    self._ui.stc_KillBySiege
  }
  self._isListDescSort = {
    name = false,
    command = false,
    tower = false,
    castlegate = false,
    summons = false,
    installation = false,
    member = false,
    death = false,
    killBySiege = false
  }
  self._ui.txt_CharName:SetSize(self._ui.txt_CharName:GetTextSizeX(), self._ui.txt_CharName:GetSizeY())
  self._ui.txt_CharName:SetPosX((self._ui.stc_LeftBG:GetSizeX() - self._ui.stc_RightBG:GetSizeX() - self._ui.txt_CharName:GetSizeX()) / 2)
  self._ui.list2_Warfare:changeAnimationSpeed(50)
  if false == self._isConsole then
    self._ui.list2_Warfare:changeScrollMoveIndex(10)
  end
  PaGlobal_GuildWarfare_All:validate()
  PaGlobal_GuildWarfare_All:registEventHandler(self._isConsole)
  PaGlobal_GuildWarfare_All._initialize = true
end
function PaGlobal_GuildWarfare_All:registEventHandler(isConsole)
  if nil == Panel_GuildWarfare_All then
    return
  end
  self._ui.list2_Warfare:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_GuildWarfare_CreateContents_All")
  self._ui.list2_Warfare:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_Warfare:addInputEvent("Mouse_UpScroll", "Panel_GuildWarfare_All_SaveScrollData()")
  self._ui.list2_Warfare:addInputEvent("Mouse_DownScroll", "Panel_GuildWarfare_All_SaveScrollData()")
  for idx, control in pairs(self._icons) do
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarfare_Select_SortType( " .. idx .. ")")
    if 0 ~= idx then
      control:addInputEvent("Mouse_On", "HandleEventLUp_GuildWarfare_IconToolTip_Show(" .. idx .. ", true)")
      control:addInputEvent("Mouse_Out", "HandleEventLUp_GuildWarfare_IconToolTip_Show(" .. idx .. ", false)")
    end
  end
end
function PaGlobal_GuildWarfare_All:update()
  if false == self._initialize then
    return
  end
  self:updateGuildListData()
  self:sortDataList()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  self._ui.list2_Warfare:getElementManager():clearKey()
  local memberCount = myGuildInfo:getMemberCount()
  local volunteerCount = myGuildInfo:getVolunteerMemberCount()
  for index = 0, memberCount + volunteerCount - 1 do
    local dataIdx = self._guildWarfareDataList[index + 1].idx
    local isVolunteer = self._guildWarfareDataList[index + 1].isVolunteer
    local myGuildMemberInfo
    if false == isVolunteer then
      myGuildMemberInfo = myGuildInfo:getMember(dataIdx)
    elseif true == isVolunteer then
      myGuildMemberInfo = myGuildInfo:getVolunteerMember(dataIdx)
    end
    if nil ~= myGuildMemberInfo then
      self._ui.list2_Warfare:getElementManager():pushKey(toInt64(0, index + 1))
    end
  end
  PaGlobal_GuildWarfare_All_LoadScrollData()
end
function PaGlobal_GuildWarfare_All:createListContents(contents, key)
  contents:SetIgnore(not self._isConsole)
  local index = Int64toInt32(key)
  local dataIdx = self._guildWarfareDataList[index].idx
  local isVolunteer = self._guildWarfareDataList[index].isVolunteer
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  local myGuildMemberInfo
  if false == isVolunteer then
    myGuildMemberInfo = myGuildInfo:getMember(dataIdx)
  elseif true == isVolunteer then
    myGuildMemberInfo = myGuildInfo:getVolunteerMember(dataIdx)
  end
  local txt_CharName = UI.getChildControl(contents, "StaticText_V_CharName")
  local txt_CommandCenter = UI.getChildControl(contents, "StaticText_V_CommandCenter")
  local txt_Tower = UI.getChildControl(contents, "StaticText_V_Tower")
  local txt_CastleGate = UI.getChildControl(contents, "StaticText_V_CastleGate")
  local txt_Summons = UI.getChildControl(contents, "StaticText_V_Summons")
  local txt_Installation = UI.getChildControl(contents, "StaticText_V_Installation")
  local txt_Member = UI.getChildControl(contents, "StaticText_V_Member")
  local txt_Death = UI.getChildControl(contents, "StaticText_V_Death")
  local txt_KillBySiege = UI.getChildControl(contents, "StaticText_V_KillBySiege")
  txt_CommandCenter:SetText(self._guildWarfareDataList[index].command)
  txt_Tower:SetText(self._guildWarfareDataList[index].tower)
  txt_CastleGate:SetText(self._guildWarfareDataList[index].castlegate)
  txt_Summons:SetText(self._guildWarfareDataList[index].summons)
  txt_Installation:SetText(self._guildWarfareDataList[index].installation)
  txt_Member:SetText(self._guildWarfareDataList[index].member)
  txt_Death:SetText(self._guildWarfareDataList[index].death)
  txt_KillBySiege:SetText(self._guildWarfareDataList[index].killBySiege)
  local isActivity = self:activityCheck(myGuildMemberInfo)
  if true == myGuildMemberInfo:isOnline() and (false == myGuildMemberInfo:isGhostMode() or true == isActivity) then
    if myGuildMemberInfo:isSelf() then
      txt_CharName:SetFontColor(Defines.Color.C_FFEF9C7F)
    else
      txt_CharName:SetFontColor(Defines.Color.C_FFC4BEBE)
    end
    if false == ToClient_isTotalGameClient() then
      txt_CharName:SetText(myGuildMemberInfo:getName() .. " (" .. myGuildMemberInfo:getCharacterName() .. ")")
    else
      local selfPlayerPlatformType = ToClient_getGamePlatformType()
      local memberPlatformType = myGuildMemberInfo:getPlatformType()
      local platformID
      if selfPlayerPlatformType == memberPlatformType then
        if true == ToClient_isPS4() then
          platformID = " / ( " .. tostring(ToClient_getOnlineId(myGuildMemberInfo:getUserNo())) .. " )"
        elseif true == ToClient_isXBox() then
          platformID = " / ( " .. tostring(ToClient_getXboxGuildUserGamerTag(myGuildMemberInfo:getUserNo())) .. " )"
        end
      end
      if nil == platformID then
        platformID = " / ( - )"
      end
      txt_CharName:SetText(myGuildMemberInfo:getName() .. " (" .. myGuildMemberInfo:getCharacterName() .. ")" .. platformID)
      txt_CharName:SetTextMode(__eTextMode_LimitText)
      UI.setLimitTextAndAddTooltip(txt_CharName)
    end
    txt_CommandCenter:SetFontColor(Defines.Color.C_FFC4BEBE)
    txt_Tower:SetFontColor(Defines.Color.C_FFC4BEBE)
    txt_CastleGate:SetFontColor(Defines.Color.C_FFC4BEBE)
    txt_Summons:SetFontColor(Defines.Color.C_FFC4BEBE)
    txt_Installation:SetFontColor(Defines.Color.C_FFC4BEBE)
    txt_Member:SetFontColor(Defines.Color.C_FFC4BEBE)
    txt_Death:SetFontColor(Defines.Color.C_FFC4BEBE)
    txt_KillBySiege:SetFontColor(Defines.Color.C_FFC4BEBE)
  else
    if false == ToClient_isTotalGameClient() then
      txt_CharName:SetText(myGuildMemberInfo:getName() .. " ( - )")
    else
      txt_CharName:SetText(myGuildMemberInfo:getName() .. " ( - ) / ( - )")
    end
    txt_CharName:SetFontColor(Defines.Color.C_FF515151)
    txt_CommandCenter:SetFontColor(Defines.Color.C_FF515151)
    txt_Tower:SetFontColor(Defines.Color.C_FF515151)
    txt_CastleGate:SetFontColor(Defines.Color.C_FF515151)
    txt_Summons:SetFontColor(Defines.Color.C_FF515151)
    txt_Installation:SetFontColor(Defines.Color.C_FF515151)
    txt_Member:SetFontColor(Defines.Color.C_FF515151)
    txt_Death:SetFontColor(Defines.Color.C_FF515151)
    txt_KillBySiege:SetFontColor(Defines.Color.C_FF515151)
  end
  if _ContentsGroup_NewSiegeRule then
    local killCount = myGuildMemberInfo:guildMasterCount() + myGuildMemberInfo:squadLeaderCount() + myGuildMemberInfo:squadMemberCount()
    txt_Member:SetText(killCount)
  end
end
function PaGlobal_GuildWarfare_All:validate()
  self._ui.stc_TopBG:isValidate()
  self._ui.txt_CharName:isValidate()
  self._ui.stc_CommadCenter:isValidate()
  self._ui.stc_Tower:isValidate()
  self._ui.stc_CastleGate:isValidate()
  self._ui.stc_Summons:isValidate()
  self._ui.stc_Installation:isValidate()
  self._ui.stc_Member:isValidate()
  self._ui.stc_Death:isValidate()
  self._ui.stc_KillBySiege:isValidate()
  self._ui.txt_Sort:isValidate()
  self._ui.stc_MainBG:isValidate()
  self._ui.list2_Warfare:isValidate()
end
function PaGlobal_GuildWarfare_All:hideSortIcon()
  self._ui.txt_Sort:SetShow(false)
end
function PaGlobal_GuildWarfare_All:setSortIcon(index, isDsce)
  self._ui.txt_Sort:SetPosX(self._icons[index]:GetPosX() + self._icons[index]:GetSizeX())
  if 0 == index then
    self._ui.txt_Sort:SetFontColor(Defines.Color.C_FFD8AD70)
  else
    self._ui.txt_Sort:SetFontColor(Defines.Color.C_FFFFFFFF)
  end
  if isDsce then
    self._ui.txt_Sort:SetText("\226\150\188")
  else
    self._ui.txt_Sort:SetText("\226\150\178")
  end
  self._ui.txt_Sort:SetShow(true)
end
function PaGlobal_GuildWarfare_All:updateGuildListData()
  local myGuildWarfareListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildWarfareListInfo then
    return
  end
  local memberCount = myGuildWarfareListInfo:getMemberCount()
  local volunteerCount = myGuildWarfareListInfo:getVolunteerMemberCount()
  for index = 1, memberCount do
    local myGuildMemberInfo = myGuildWarfareListInfo:getMember(index - 1)
    if nil ~= myGuildMemberInfo then
      self._guildWarfareDataList[index] = {
        idx = index - 1,
        command = myGuildMemberInfo:commandPostCount(),
        tower = myGuildMemberInfo:towerCount(),
        castlegate = myGuildMemberInfo:gateCount(),
        help = myGuildMemberInfo:assistCount(),
        summons = myGuildMemberInfo:summonedCount(),
        installation = myGuildMemberInfo:obstacleCount(),
        master = myGuildMemberInfo:guildMasterCount(),
        commander = myGuildMemberInfo:squadLeaderCount(),
        member = myGuildMemberInfo:squadMemberCount(),
        death = myGuildMemberInfo:deathCount(),
        name = myGuildMemberInfo:getName(),
        killBySiege = myGuildMemberInfo:killBySiegeWeaponCount(),
        isVolunteer = false
      }
      if _ContentsGroup_NewSiegeRule then
        local killCount = myGuildMemberInfo:guildMasterCount() + myGuildMemberInfo:squadLeaderCount() + myGuildMemberInfo:squadMemberCount()
        self._guildWarfareDataList[index].member = killCount
      end
    end
  end
  for index = 1, volunteerCount do
    local myGuildVolunteerMemberInfo = myGuildWarfareListInfo:getVolunteerMember(index - 1)
    if nil ~= myGuildVolunteerMemberInfo then
      self._guildWarfareDataList[memberCount + index] = {
        idx = index - 1,
        command = myGuildVolunteerMemberInfo:commandPostCount(),
        tower = myGuildVolunteerMemberInfo:towerCount(),
        castlegate = myGuildVolunteerMemberInfo:gateCount(),
        help = myGuildVolunteerMemberInfo:assistCount(),
        summons = myGuildVolunteerMemberInfo:summonedCount(),
        installation = myGuildVolunteerMemberInfo:obstacleCount(),
        master = myGuildVolunteerMemberInfo:guildMasterCount(),
        commander = myGuildVolunteerMemberInfo:squadLeaderCount(),
        member = myGuildVolunteerMemberInfo:squadMemberCount(),
        death = myGuildVolunteerMemberInfo:deathCount(),
        name = myGuildVolunteerMemberInfo:getName(),
        killBySiege = myGuildVolunteerMemberInfo:killBySiegeWeaponCount(),
        isVolunteer = true
      }
      if _ContentsGroup_NewSiegeRule then
        local killCount = myGuildVolunteerMemberInfo:guildMasterCount() + myGuildVolunteerMemberInfo:squadLeaderCount() + myGuildVolunteerMemberInfo:squadMemberCount()
        self._guildWarfareDataList[memberCount + index].member = killCount
      end
    end
  end
end
function PaGlobal_GuildWarfare_All:activityCheck(memberInfo)
  local value = 0
  value = value + memberInfo:commandPostCount()
  value = value + memberInfo:towerCount()
  value = value + memberInfo:gateCount()
  value = value + memberInfo:assistCount()
  value = value + memberInfo:summonedCount()
  value = value + memberInfo:obstacleCount()
  value = value + memberInfo:guildMasterCount()
  value = value + memberInfo:squadLeaderCount()
  value = value + memberInfo:squadMemberCount()
  value = value + memberInfo:deathCount()
  value = value + memberInfo:killBySiegeWeaponCount()
  return 0 < value
end
function PaGlobal_GuildWarfare_All:selectSortType(sortType)
  self._selectedSortType = sortType
  local isDsce
  if 0 == sortType then
    self._isListDescSort.name = not self._isListDescSort.name
    isDsce = self._isListDescSort.name
  elseif 1 == sortType then
    self._isListDescSort.command = not self._isListDescSort.command
    isDsce = self._isListDescSort.command
  elseif 2 == sortType then
    self._isListDescSort.tower = not self._isListDescSort.tower
    isDsce = self._isListDescSort.tower
  elseif 3 == sortType then
    self._isListDescSort.castlegate = not self._isListDescSort.castlegate
    isDsce = self._isListDescSort.castlegate
  elseif 4 == sortType then
    self._isListDescSort.summons = not self._isListDescSort.summons
    isDsce = self._isListDescSort.summons
  elseif 5 == sortType then
    self._isListDescSort.installation = not self._isListDescSort.installation
    isDsce = self._isListDescSort.installation
  elseif 6 == sortType then
    self._isListDescSort.member = not self._isListDescSort.member
    isDsce = self._isListDescSort.member
  elseif 7 == sortType then
    self._isListDescSort.death = not self._isListDescSort.death
    isDsce = self._isListDescSort.death
  elseif 8 == sortType then
    self._isListDescSort.killBySiege = not self._isListDescSort.killBySiege
    isDsce = self._isListDescSort.killBySiege
  end
  self:setSortIcon(sortType, isDsce)
  self:update()
end
local guildListCompareCommandCenter = function(w1, w2)
  if PaGlobal_GuildWarfare_All._isListDescSort.command then
    if w1.command < w2.command then
      return true
    end
  elseif w2.command < w1.command then
    return true
  end
end
local guildListCompareTower = function(w1, w2)
  if PaGlobal_GuildWarfare_All._isListDescSort.tower then
    if w1.tower < w2.tower then
      return true
    end
  elseif w2.tower < w1.tower then
    return true
  end
end
local guildListCompareCastleGate = function(w1, w2)
  if PaGlobal_GuildWarfare_All._isListDescSort.castlegate then
    if w1.castlegate < w2.castlegate then
      return true
    end
  elseif w2.castlegate < w1.castlegate then
    return true
  end
end
local guildListCompareSummons = function(w1, w2)
  if PaGlobal_GuildWarfare_All._isListDescSort.summons then
    if w1.summons < w2.summons then
      return true
    end
  elseif w2.summons < w1.summons then
    return true
  end
end
local guildListCompareInstallation = function(w1, w2)
  if PaGlobal_GuildWarfare_All._isListDescSort.installation then
    if w1.installation < w2.installation then
      return true
    end
  elseif w2.installation < w1.installation then
    return true
  end
end
local guildListCompareMember = function(w1, w2)
  if PaGlobal_GuildWarfare_All._isListDescSort.member then
    if w1.member < w2.member then
      return true
    end
  elseif w2.member < w1.member then
    return true
  end
end
local guildListCompareDeath = function(w1, w2)
  if PaGlobal_GuildWarfare_All._isListDescSort.death then
    if w1.death < w2.death then
      return true
    end
  elseif w2.death < w1.death then
    return true
  end
end
local guildListCompareCharName = function(w1, w2)
  if PaGlobal_GuildWarfare_All._isListDescSort.name then
    if w1.name < w2.name then
      return true
    end
  elseif w2.name < w1.name then
    return true
  end
end
local guildListCompareKillBySiege = function(w1, w2)
  if PaGlobal_GuildWarfare_All._isListDescSort.killBySiege then
    if w1.killBySiege < w2.killBySiege then
      return true
    end
  elseif w2.killBySiege < w1.killBySiege then
    return true
  end
end
function PaGlobal_GuildWarfare_All:sortDataList()
  if 0 == self._selectedSortType then
    table.sort(self._guildWarfareDataList, guildListCompareCharName)
  elseif 1 == self._selectedSortType then
    table.sort(self._guildWarfareDataList, guildListCompareCommandCenter)
  elseif 2 == self._selectedSortType then
    table.sort(self._guildWarfareDataList, guildListCompareTower)
  elseif 3 == self._selectedSortType then
    table.sort(self._guildWarfareDataList, guildListCompareCastleGate)
  elseif 4 == self._selectedSortType then
    table.sort(self._guildWarfareDataList, guildListCompareSummons)
  elseif 5 == self._selectedSortType then
    table.sort(self._guildWarfareDataList, guildListCompareInstallation)
  elseif 6 == self._selectedSortType then
    table.sort(self._guildWarfareDataList, guildListCompareMember)
  elseif 7 == self._selectedSortType then
    table.sort(self._guildWarfareDataList, guildListCompareDeath)
  elseif 8 == self._selectedSortType then
    table.sort(self._guildWarfareDataList, guildListCompareKillBySiege)
  end
end
function PaGlobal_GuildWarfare_All:initGuildListSort()
  self._selectedSortType = 0
  self._isListDescSort.name = true
  self:setSortIcon(self._selectedSortType, self._isListDescSort.name)
end
