function PaGlobal_Arsha_Party_All:initialize()
  if true == PaGlobal_Arsha_Party_All._initialize or nil == Panel_Widget_Arsha_Party_All then
    return
  end
  self._ui._leftTeam.stc_mainBg = UI.getChildControl(Panel_Widget_Arsha_Party_All, "Static_LeftTeam")
  self._ui._leftTeam.stc_teamNameBg = UI.getChildControl(self._ui._leftTeam.stc_mainBg, "Static_TeamTitleBG")
  self._ui._leftTeam.txt_teamName = UI.getChildControl(self._ui._leftTeam.stc_teamNameBg, "StaticText_TeamName")
  self._ui._leftTeam.stc_memberTemplate = UI.getChildControl(self._ui._leftTeam.stc_mainBg, "Static_MemberArea")
  self._ui._rightTeam.stc_mainBg = UI.getChildControl(Panel_Widget_Arsha_Party_All, "Static_RightTeam")
  self._ui._rightTeam.stc_teamNameBg = UI.getChildControl(self._ui._rightTeam.stc_mainBg, "Static_TeamTitleBG")
  self._ui._rightTeam.txt_teamName = UI.getChildControl(self._ui._rightTeam.stc_teamNameBg, "StaticText_TeamName")
  self._ui._rightTeam.stc_memberTemplate = UI.getChildControl(self._ui._rightTeam.stc_mainBg, "Static_MemberArea")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Arsha_Party_All:validate()
  PaGlobal_Arsha_Party_All:registEventHandler()
  PaGlobal_Arsha_Party_All:swichPlatform(self._isConsole)
  self._teamMemberUi = {}
  for ii = 0, CppEnums.CompetitionFreeForAll.eFreeForAllTeamLimit - 1 do
    self._teamMemberUi[ii] = {}
  end
  self._isCreate = false
  PaGlobal_Arsha_Party_All._initialize = true
end
function PaGlobal_Arsha_Party_All:swichPlatform(isConsole)
  if true == isConsole then
  else
  end
end
function PaGlobal_Arsha_Party_All:prepareOpen()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local selfActorKeyRaw = getSelfPlayer():getActorKey()
  if true == getSelfPlayer():isPartyMemberActorKey(selfActorKeyRaw) then
    if true == _ContentsGroup_NewUI_PartyWidget_All then
      Panel_Widget_Party_All:SetShow(false)
    else
      Panel_Widget_Party:SetShow(false)
    end
  end
  local state_match = ToClient_CompetitionMatchType()
  local teamA_Info, teamB_Info
  local teamA_Name = ""
  local teamB_Name = ""
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == state_match then
    teamA_Info = ToClient_GetTeamListAt(0)
    teamB_Info = ToClient_GetTeamListAt(1)
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == state_match then
    teamA_Info = ToClient_GetArshaTeamInfo(1)
    teamB_Info = ToClient_GetArshaTeamInfo(2)
  end
  if nil ~= teamA_Info and nil ~= teamB_Info then
    teamA_Name = teamA_Info:getTeamName()
    teamB_Name = teamB_Info:getTeamName()
  end
  if "" == teamA_Name or "" == teamB_Name then
    teamA_Name = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_A")
    teamB_Name = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_B")
  end
  self._ui._leftTeam.txt_teamName:SetText(teamA_Name)
  self._ui._rightTeam.txt_teamName:SetText(teamB_Name)
  PaGlobal_Arsha_Party_All:open()
  PaGlobal_Arsha_Party_All:resize()
end
function PaGlobal_Arsha_Party_All:open()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  self._ui._leftTeam.stc_mainBg:SetShow(true)
  self._ui._rightTeam.stc_mainBg:SetShow(true)
  Panel_Widget_Arsha_Party_All:SetShow(true)
end
function PaGlobal_Arsha_Party_All:prepareClose()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local selfActorKeyRaw = getSelfPlayer():getActorKey()
  if true == getSelfPlayer():isPartyMemberActorKey(selfActorKeyRaw) then
    if true == _ContentsGroup_NewUI_PartyWidget_All then
      Panel_Widget_Party_All:SetShow(true)
    else
      Panel_Widget_Party:SetShow(true)
    end
  end
  PaGlobalFunc_Arsha_Party_All_StatSlotClose()
  for ii = 0, CppEnums.CompetitionFreeForAll.eFreeForAllTeamLimit - 1 do
    if nil ~= self._teamMemberUi[ii] then
      for jj = 0, CppEnums.CompetitionFreeForAll.eFreeForAllTeamLimit - 1 do
        if nil ~= self._teamMemberUi[ii][jj] then
          UI.deleteControl(self._teamMemberUi[ii][jj]._memberBg)
          self._teamMemberUi[ii][jj] = nil
        end
      end
    end
  end
  self._teamMemberUi = {}
  for ii = 0, CppEnums.CompetitionFreeForAll.eFreeForAllTeamLimit - 1 do
    self._teamMemberUi[ii] = {}
  end
  self._isCreate = false
  PaGlobal_Arsha_Party_All:close()
end
function PaGlobal_Arsha_Party_All:close()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  self._ui._leftTeam.stc_mainBg:SetShow(false)
  self._ui._rightTeam.stc_mainBg:SetShow(false)
  Panel_Widget_Arsha_Party_All:SetShow(false)
end
function PaGlobal_Arsha_Party_All:statSlotSetShow(teamIndex, userIndex, isVisible, isFree)
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  if nil ~= self._teamMemberUi and nil ~= self._teamMemberUi[teamIndex] and nil ~= self._teamMemberUi[teamIndex][userIndex] then
    self._teamMemberUi[teamIndex][userIndex]._memberBg:SetShow(isVisible)
    self._teamMemberUi[teamIndex][userIndex]._circleBg:SetShow(isVisible)
    self._teamMemberUi[teamIndex][userIndex]._classIcon:SetShow(isVisible)
    self._teamMemberUi[teamIndex][userIndex]._leftCount:SetShow(isVisible)
    self._teamMemberUi[teamIndex][userIndex]._name:SetShow(isVisible)
    self._teamMemberUi[teamIndex][userIndex]._gaugeRate:SetShow(isVisible)
    self._teamMemberUi[teamIndex][userIndex]._progress:SetShow(isVisible)
    self._teamMemberUi[teamIndex][userIndex]._percent:SetShow(isVisible)
    for ii = 1, self._buffMaxCount do
      self._teamMemberUi[teamIndex][userIndex]._buffList[ii]:SetShow(isVisible)
    end
    local matchType = ToClient_CompetitionMatchType()
    if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == matchType or CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll == matchType then
      self._teamMemberUi[teamIndex][userIndex]._memberBg:SetShow(false)
      self._teamMemberUi[teamIndex][userIndex]._circleBg:SetShow(false)
      self._teamMemberUi[teamIndex][userIndex]._classIcon:SetShow(false)
      self._teamMemberUi[teamIndex][userIndex]._name:SetShow(false)
      self._teamMemberUi[teamIndex][userIndex]._progress:SetShow(false)
      for ii = 1, self._buffMaxCount do
        self._teamMemberUi[teamIndex][userIndex]._buffList[ii]:SetShow(false)
      end
    end
  end
end
function PaGlobal_Arsha_Party_All:createTeamUi_Round()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local playerWrapper = getSelfPlayer()
  local myTeamNo = playerWrapper:getCompetitionTeamNo()
  local teamCount = ToClient_GetTeamListCountWithOutZero()
  self._ui._leftTeam.stc_memberTemplate:SetShow(true)
  self._ui._rightTeam.stc_memberTemplate:SetShow(true)
  self._ui._leftTeam.stc_teamNameBg:SetShow(true)
  self._ui._rightTeam.stc_teamNameBg:SetShow(true)
  PaGlobalFunc_Arsha_Party_All_StatSlotClose()
  for Index = 0, teamCount - 1 do
    if 1 < Index then
      return
    end
    local teamInfo = ToClient_GetTeamListAt(Index)
    local teamNo = teamInfo:getTeamNo()
    local teamUserCount = ToClient_GetTeamUserInfoCount(teamNo)
    if false == self._isCreate then
      for userIndex = 0, teamUserCount - 1 do
        local temp = {}
        local gab = 5
        if 1 == teamNo then
          temp._memberBg = UI.cloneControl(self._ui._leftTeam.stc_memberTemplate, self._ui._leftTeam.stc_mainBg, "Static_MemberArea_Left_" .. Index .. "_" .. userIndex)
          temp._memberBg:SetPosY(self._ui._leftTeam.stc_memberTemplate:GetPosY() + (temp._memberBg:GetSizeY() + gab) * userIndex)
          temp._memberBg:SetPosX((self._ui._leftTeam.stc_memberTemplate:GetPosX() + 5) * Index)
        elseif 2 == teamNo then
          temp._memberBg = UI.cloneControl(self._ui._rightTeam.stc_memberTemplate, self._ui._rightTeam.stc_mainBg, "Static_MemberArea_Right_" .. Index .. "_" .. userIndex)
          temp._memberBg:SetPosY(self._ui._rightTeam.stc_memberTemplate:GetPosY() + (temp._memberBg:GetSizeY() + gab) * userIndex)
          temp._memberBg:SetPosX(-1 * ((self._ui._rightTeam.stc_memberTemplate:GetPosX() + 5) * Index))
        end
        temp._teamNo = teamNo
        temp._circleBg = UI.getChildControl(temp._memberBg, "Static_CircleBG")
        temp._classIcon = UI.getChildControl(temp._circleBg, "Static_ClassIcon")
        temp._leftCount = UI.getChildControl(temp._circleBg, "StaticText_LeftCount")
        temp._name = UI.getChildControl(temp._memberBg, "StaticText_CharName")
        temp._gaugeRate = UI.getChildControl(temp._memberBg, "StaticText_BlackSpiritPercent")
        temp._progress = UI.getChildControl(temp._memberBg, "Progress2_1")
        temp._percent = UI.getChildControl(temp._memberBg, "StaticText_Percent")
        temp._buffList = {}
        for ii = 1, self._buffMaxCount do
          temp._buffList[ii] = UI.getChildControl(temp._memberBg, "Static_Buff_Temp_" .. ii)
        end
        self._teamMemberUi[teamNo - 1][userIndex] = temp
      end
    end
    PaGlobalFunc_Arsha_Party_All_Setting(teamNo, teamUserCount)
  end
  self._ui._leftTeam.stc_memberTemplate:SetShow(false)
  self._ui._rightTeam.stc_memberTemplate:SetShow(false)
  self._isCreate = true
  PaGlobalFunc_Arsha_Party_All_Open()
end
function PaGlobal_Arsha_Party_All:createTeamUi_FreeForAll()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local playerWrapper = getSelfPlayer()
  local myTeamNo = playerWrapper:getCompetitionTeamNo()
  local teamCount = ToClient_GetTeamListCountWithOutZero()
  self._ui._leftTeam.stc_memberTemplate:SetShow(true)
  self._ui._rightTeam.stc_memberTemplate:SetShow(true)
  self._ui._leftTeam.stc_teamNameBg:SetShow(false)
  self._ui._rightTeam.stc_teamNameBg:SetShow(false)
  PaGlobalFunc_Arsha_Party_All_FreeForAllSlotReset()
  local otherTeamCount = 0
  for teamIndex = 0, teamCount - 1 do
    local teamInfo = ToClient_GetTeamListAt(teamIndex)
    local teamNo = teamInfo:getTeamNo()
    local Index = teamNo - 1
    if false == self._isCreate then
      local temp = {}
      local gab = 5
      if myTeamNo == teamNo then
        temp._memberBg = UI.cloneControl(self._ui._leftTeam.stc_memberTemplate, self._ui._leftTeam.stc_mainBg, "Static_MemberArea_Left_" .. Index .. "_" .. teamIndex)
        temp._memberBg:SetPosY(self._ui._leftTeam.stc_memberTemplate:GetPosY())
      else
        temp._memberBg = UI.cloneControl(self._ui._rightTeam.stc_memberTemplate, self._ui._rightTeam.stc_mainBg, "Static_MemberArea_Right_" .. Index .. "_" .. teamIndex)
        temp._memberBg:SetPosY(self._ui._rightTeam.stc_memberTemplate:GetPosY() + (temp._memberBg:GetSizeY() + gab) * otherTeamCount)
        otherTeamCount = otherTeamCount + 1
      end
      temp._teamNo = teamNo
      temp._circleBg = UI.getChildControl(temp._memberBg, "Static_CircleBG")
      temp._classIcon = UI.getChildControl(temp._circleBg, "Static_ClassIcon")
      temp._leftCount = UI.getChildControl(temp._circleBg, "StaticText_LeftCount")
      temp._name = UI.getChildControl(temp._memberBg, "StaticText_CharName")
      temp._gaugeRate = UI.getChildControl(temp._memberBg, "StaticText_BlackSpiritPercent")
      temp._progress = UI.getChildControl(temp._memberBg, "Progress2_1")
      temp._percent = UI.getChildControl(temp._memberBg, "StaticText_Percent")
      temp._buffList = {}
      for ii = 1, self._buffMaxCount do
        temp._buffList[ii] = UI.getChildControl(temp._memberBg, "Static_Buff_Temp_" .. ii)
      end
      self._teamMemberUi[0][teamNo - 1] = temp
    end
    PaGlobalFunc_Arsha_Party_All_Setting(teamNo, 0)
  end
  self._ui._leftTeam.stc_memberTemplate:SetShow(false)
  self._ui._rightTeam.stc_memberTemplate:SetShow(false)
  self._isCreate = true
  PaGlobalFunc_Arsha_Party_All_Open()
end
function PaGlobal_Arsha_Party_All:createTeamUi_Personal()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  self._ui._leftTeam.stc_memberTemplate:SetShow(true)
  self._ui._rightTeam.stc_memberTemplate:SetShow(true)
  self._ui._leftTeam.stc_teamNameBg:SetShow(true)
  self._ui._rightTeam.stc_teamNameBg:SetShow(true)
  PaGlobalFunc_Arsha_Party_All_StatSlotClose()
  for teamNo = 1, 2 do
    local teamInfo = ToClient_GetArshaTeamInfo(teamNo)
    local userIndex = 0
    local Index = teamNo - 1
    if false == self._isCreate then
      local temp = {}
      local gab = 5
      if 1 == teamNo then
        temp._memberBg = UI.cloneControl(self._ui._leftTeam.stc_memberTemplate, self._ui._leftTeam.stc_mainBg, "Static_MemberArea_Left_" .. Index .. "_" .. userIndex)
        temp._memberBg:SetPosY(self._ui._leftTeam.stc_memberTemplate:GetPosY() + (temp._memberBg:GetSizeY() + 5) * userIndex)
        temp._memberBg:SetPosX((self._ui._leftTeam.stc_memberTemplate:GetSizeX() + 5) * Index)
      elseif 2 == teamNo then
        temp._memberBg = UI.cloneControl(self._ui._rightTeam.stc_memberTemplate, self._ui._rightTeam.stc_mainBg, "Static_MemberArea_Right_" .. Index .. "_" .. userIndex)
        temp._memberBg:SetPosY(self._ui._leftTeam.stc_memberTemplate:GetPosY() + (temp._memberBg:GetSizeY() + 5) * userIndex)
        temp._memberBg:SetPosX(-1 * ((self._ui._rightTeam.stc_memberTemplate:GetPosX() + 5) * Index))
      end
      temp._teamNo = teamNo
      temp._circleBg = UI.getChildControl(temp._memberBg, "Static_CircleBG")
      temp._classIcon = UI.getChildControl(temp._circleBg, "Static_ClassIcon")
      temp._leftCount = UI.getChildControl(temp._circleBg, "StaticText_LeftCount")
      temp._name = UI.getChildControl(temp._memberBg, "StaticText_CharName")
      temp._gaugeRate = UI.getChildControl(temp._memberBg, "StaticText_BlackSpiritPercent")
      temp._progress = UI.getChildControl(temp._memberBg, "Progress2_1")
      temp._percent = UI.getChildControl(temp._memberBg, "StaticText_Percent")
      temp._buffList = {}
      for ii = 1, self._buffMaxCount do
        temp._buffList[ii] = UI.getChildControl(temp._memberBg, "Static_Buff_Temp_" .. ii)
      end
      self._teamMemberUi[teamNo - 1][userIndex] = temp
    end
    PaGlobalFunc_Arsha_Party_All_Setting(teamNo, 0)
  end
  self._ui._leftTeam.stc_memberTemplate:SetShow(false)
  self._ui._rightTeam.stc_memberTemplate:SetShow(false)
  self._isCreate = true
  PaGlobalFunc_Arsha_Party_All_Open()
end
function PaGlobal_Arsha_Party_All:setting_Round(teamNo, userCount)
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local myTeamNo = getSelfPlayer():getCompetitionTeamNo()
  local myUserNo = getSelfPlayer():get():getUserNo()
  local teamIndex = teamNo - 1
  local hpPercent = 0
  local adrenalinPoint = 0
  if 2 < teamNo then
    return
  end
  for index = 0, userCount - 1 do
    local userSlot = self._teamMemberUi[teamIndex][index]
    local userInfo = ToClient_GetTeamUserInfoAt(teamNo, index)
    if nil ~= userInfo and nil ~= userSlot then
      userSlot._memberBg:SetShow(true)
      userSlot._circleBg:SetShow(true)
      local classType = userInfo:getCharacterClass()
      userSlot._classIcon:SetShow(true)
      PaGlobalFunc_Util_ChangeTextureClass(userSlot._classIcon, classType)
      local getAp = userInfo:getAP()
      if 0 < getAp then
        adrenalinPoint = getAp / 10
        adrenalinPoint = math.floor(adrenalinPoint) / 10
      end
      if myTeamNo == teamNo or 0 == myTeamNo then
        userSlot._gaugeRate:SetShow(true)
        local adPoint = string.format("%.1f", adrenalinPoint)
        userSlot._gaugeRate:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WIDGET_ARSHA_TEAMUI_GAUGERATE", "adPoint", adPoint))
      else
        userSlot._gaugeRate:SetShow(false)
        userSlot._gaugeRate:SetText("")
      end
      local userLevel = userInfo:getCharacterLevel()
      local userName = userInfo:getCharacterName()
      userSlot._name:SetShow(true)
      userSlot._name:SetText(userLevel .. " " .. userName)
      userSlot._leftCount:SetShow(false)
      hpPercent = 100
      userSlot._progress:SetShow(true)
      userSlot._progress:SetProgressRate(hpPercent)
      userSlot._percent:SetShow(true)
      userSlot._percent:SetText(string.format("%d", math.floor(hpPercent)) .. "%")
      for ii = 1, self._buffMaxCount do
        userSlot._buffList[ii]:SetShow(false)
      end
      userSlot._memberBg:addInputEvent("Mouse_LUp", "PaGlobalFunc_Arsha_Party_All_CameraControl(" .. tostring(userInfo:getUserNo()) .. ")")
    end
  end
end
function PaGlobal_Arsha_Party_All:setting_FreeForAll(teamNo)
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local myTeamNo = getSelfPlayer():getCompetitionTeamNo()
  local myUserNo = getSelfPlayer():get():getUserNo()
  local teamIndex = teamNo - 1
  local hpPercent = 0
  local userSlot = self._teamMemberUi[0][teamIndex]
  local leaderInfo = ToClient_GetTeamLeaderInfo(teamNo)
  if nil ~= leaderInfo and nil ~= userSlot then
    local classType = leaderInfo:getCharacterClass()
    local totalHpPercent = ToClient_GetTeamTotalHpPercent(teamNo)
    if 0 <= totalHpPercent then
      hpPercent = totalHpPercent
    end
    userSlot._memberBg:SetShow(true)
    userSlot._circleBg:SetShow(true)
    userSlot._classIcon:SetShow(false)
    userSlot._leftCount:SetShow(true)
    userSlot._progress:SetShow(true)
    userSlot._progress:SetProgressRate(hpPercent)
    userSlot._percent:SetShow(true)
    userSlot._percent:SetText(string.format("%d", math.floor(hpPercent)) .. "%")
    userSlot._name:SetShow(true)
    userSlot._name:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ARSHA_TEAMUI_NAMETEXT", "name", leaderInfo:getCharacterName()))
    for ii = 1, self._buffMaxCount do
      userSlot._buffList[ii]:SetShow(false)
    end
    userSlot._gaugeRate:SetShow(false)
  end
end
function PaGlobal_Arsha_Party_All:setting_Personal(teamNo)
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local myTeamNo = getSelfPlayer():getCompetitionTeamNo()
  local myUserNo = getSelfPlayer():get():getUserNo()
  local teamIndex = teamNo - 1
  local hpPercent = 0
  local adrenalinPoint = 0
  local userSlot = self._teamMemberUi[teamIndex][0]
  local userInfo = ToClient_GetArshaAttendUserInfo(teamNo)
  if nil ~= userInfo and nil ~= userSlot then
    userSlot._memberBg:SetShow(true)
    userSlot._circleBg:SetShow(true)
    local classType = userInfo:getCharacterClass()
    userSlot._classIcon:SetShow(true)
    PaGlobalFunc_Util_ChangeTextureClass(userSlot._classIcon, classType)
    local getAP = userInfo:getAP()
    if 0 < getAP then
      adrenalinPoint = getAP / 10
      adrenalinPoint = math.floor(adrenalinPoint) / 10
    end
    if myTeamNo == teamNo or 0 == myTeamNo then
      local adPoint = string.format("%.1f", adrenalinPoint)
      userSlot._gaugeRate:SetShow(true)
      userSlot._gaugeRate:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WIDGET_ARSHA_TEAMUI_GAUGERATE", "adPoint", adPoint))
    else
      userSlot._gaugeRate:SetShow(false)
      userSlot._gaugeRate:SetText("")
    end
    local userLevel = userInfo:getCharacterLevel()
    local userName = userInfo:getCharacterName()
    userSlot._name:SetShow(true)
    userSlot._name:SetText(userLevel .. " " .. userName)
    userSlot._leftCount:SetShow(false)
    hpPercent = 100
    userSlot._progress:SetShow(true)
    userSlot._progress:SetProgressRate(hpPercent)
    userSlot._percent:SetShow(true)
    userSlot._percent:SetText(string.format("%d", math.floor(hpPercent)) .. "%")
    for ii = 1, self._buffMaxCount do
      userSlot._buffList[ii]:SetShow(false)
    end
    userSlot._memberBg:addInputEvent("Mouse_LUp", "PaGlobalFunc_Arsha_Party_All_CameraControl(" .. tostring(userInfo:getUserNo()) .. ")")
  end
end
function PaGlobal_Arsha_Party_All:updateUserHP_Round()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local myTeamNo = getSelfPlayer():getCompetitionTeamNo()
  local hpPercent = 0
  local teamUserCount = 0
  local teamIndex = 0
  local teamNo = 0
  local teamInfo
  local teamCount = ToClient_GetTeamListCountWithOutZero()
  for Index = 0, teamCount - 1 do
    if 1 < Index then
      break
    end
    teamInfo = ToClient_GetTeamListAt(Index)
    teamNo = teamInfo:getTeamNo()
    teamUserCount = ToClient_GetTeamUserInfoCount(teamNo)
    teamIndex = teamNo - 1
    for userIndex = 0, teamUserCount - 1 do
      hpPercent = 0
      local userSlot = self._teamMemberUi[teamIndex][userIndex]
      local userInfo = ToClient_GetTeamUserInfoAt(teamNo, userIndex)
      if nil == userSlot then
        PaGlobalFunc_Arsha_Party_All_Create()
        userSlot = self._teamMemberUi[teamIndex][userIndex]
      end
      if nil ~= userInfo and nil ~= userSlot then
        local getHP = userInfo:getHP()
        local getMaxHP = userInfo:getMaxHP()
        if 0 < getHP and 0 < getMaxHP then
          hpPercent = userInfo:getHP() / userInfo:getMaxHP() * 100
        end
        userSlot._progress:SetProgressRate(hpPercent)
        userSlot._percent:SetText(string.format("%d", math.floor(hpPercent)) .. "%")
        if hpPercent <= 0 then
          userSlot._name:SetFontColor(Defines.Color.C_FFC4BEBE)
        end
        local userLevel = userInfo:getCharacterLevel()
        local userName = userInfo:getCharacterName()
        userSlot._name:SetText(userLevel .. " " .. userName)
        local adrenalin = 0
        if myTeamNo == teamNo or 0 == myTeamNo then
          local getAP = userInfo:getAP()
          if 0 < getAP then
            adrenalin = getAP / 10
            adrenalin = math.floor(adrenalin) / 10
          end
          local adPoint = string.format("%.1f", adrenalin)
          userSlot._gaugeRate:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WIDGET_ARSHA_TEAMUI_GAUGERATE", "adPoint", adPoint))
        end
        local actorKey = userInfo:getActorKey()
        local skillCount = ToClient_GetUseSkillListCount(actorKey)
        local skillNo = 0
        local remainTime = 0
        local skillIconPosX = 0
        local gabX = 5
        if 1 == teamNo then
          skillIconPosX = userSlot._progress:GetPosX() + userSlot._progress:GetSizeX()
        elseif 2 == teamNo then
          skillIconPosX = userSlot._progress:GetPosX() - 15
        end
        for idx = 0, skillCount - 1 do
          skillNo = ToClient_GetUseSkillListAt(actorKey, idx)
          local skillCool = ToClient_GetSkillCoolTime_OtherUser(actorKey, idx)
          local skillSSW = getSkillTypeStaticStatus(skillNo)
          local skillName = skillSSW:getName()
          local skillIcon = skillSSW:getIconPath()
          if nil ~= userSlot._buffList[idx + 1] then
            if skillCool <= 0 then
              userSlot._buffList[idx + 1]:SetShow(false)
            else
              userSlot._buffList[idx + 1]:ChangeTextureInfoName("Icon/" .. skillIcon)
              userSlot._buffList[idx + 1]:SetShow(true)
            end
            if 1 == teamNo then
              skillIconPosX = skillIconPosX - userSlot._buffList[1]:GetSizeX() - gabX
            elseif 2 == teamNo then
              skillIconPosX = skillIconPosX + userSlot._buffList[1]:GetSizeX() + gabX
            end
            userSlot._buffList[idx + 1]:SetPosX(skillIconPosX)
          end
        end
        userSlot._memberBg:addInputEvent("Mouse_LUp", "PaGlobalFunc_Arsha_Party_All_CameraControl(" .. tostring(userInfo:getUserNo()) .. ")")
      end
    end
  end
end
function PaGlobal_Arsha_Party_All:updateUserHP_FreeForAll()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local hpPercent = 0
  local teamNo = 0
  local teamIndex = 0
  local teamInfo
  local totalUserCount = 0
  local deadUserCount = 0
  local teamCount = ToClient_GetTeamListCountWithOutZero()
  for Index = 0, teamCount - 1 do
    hpPercent = 0
    teamInfo = ToClient_GetTeamListAt(Index)
    teamNo = teamInfo:getTeamNo()
    teamIndex = teamNo - 1
    totalUserCount = ToClient_GetTeamUserInfoCount(teamNo)
    deadUserCount = ToClient_GetTeamDeadUserCount(teamNo)
    local totalHpPercent = ToClient_GetTeamTotalHpPercent(teamNo)
    if 0 <= totalHpPercent then
      hpPercent = totalHpPercent
    end
    local userSlot = self._teamMemberUi[0][teamIndex]
    if nil == userSlot then
      PaGlobalFunc_Arsha_Party_All_Create()
      userSlot = self._teamMemberUi[0][teamIndex]
    end
    if nil ~= userSlot then
      userSlot._progress:SetProgressRate(hpPercent)
      userSlot._percent:SetText(string.format("%d", math.floor(hpPercent)) .. "%")
      if hpPercent <= 0 then
        userSlot._name:SetFontColor(Defines.Color.C_FFC4BEBE)
      end
      userSlot._leftCount:SetText(tostring(totalUserCount - deadUserCount))
      if totalUserCount - deadUserCount <= 1 then
        userSlot._leftCount:SetFontColor(Defines.Color.C_FFFF0000)
      else
        userSlot._leftCount:SetFontColor(Defines.Color.C_FFFFFFFF)
      end
    end
  end
end
function PaGlobal_Arsha_Party_All:updateUserHP_Personal()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local myTeamNo = getSelfPlayer():getCompetitionTeamNo()
  local hpPercent = 0
  local teamUserCount = 0
  local teamIndex = 0
  local teamNo = 0
  local teamInfo
  for Index = 1, 2 do
    hpPercent = 0
    teamInfo = ToClient_GetArshaTeamInfo(Index)
    teamNo = teamInfo:getTeamNo()
    teamIndex = teamNo - 1
    local userSlot = self._teamMemberUi[teamIndex][0]
    local userInfo = ToClient_GetArshaAttendUserInfo(teamNo)
    if nil == userSlot then
      PaGlobalFunc_Arsha_Party_All_Create()
      userSlot = self._teamMemberUi[teamIndex][0]
    end
    if nil ~= userInfo and nil ~= userSlot then
      local getHP = userInfo:getHP()
      local getMaxHP = userInfo:getMaxHP()
      if 0 < getHP and 0 < getMaxHP then
        hpPercent = userInfo:getHP() / userInfo:getMaxHP() * 100
      end
      userSlot._progress:SetProgressRate(hpPercent)
      userSlot._percent:SetText(string.format("%d", math.floor(hpPercent)) .. "%")
      if hpPercent <= 0 then
        userSlot._name:SetFontColor(Defines.Color.C_FFC4BEBE)
      end
      userSlot._name:SetText(userInfo:getCharacterName())
      local actorKey = userInfo:getActorKey()
      local adrenalin = 0
      local skillNo = 0
      local remainTime = 0
      if myTeamNo == teamNo or 0 == myTeamNo then
        local getAP = userInfo:getAP()
        if 0 < getAP then
          adrenalin = getAP / 10
          adrenalin = math.floor(adrenalin) / 10
        end
        local adPoint = string.format("%.1f", adrenalin)
        userSlot._gaugeRate:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WIDGET_ARSHA_TEAMUI_GAUGERATE", "adPoint", adPoint))
      end
      userSlot._memberBg:addInputEvent("Mouse_LUp", "PaGlobalFunc_Arsha_Party_All_CameraControl(" .. tostring(userInfo:getUserNo()) .. ")")
    end
  end
end
function PaGlobal_Arsha_Party_All:stateSlotClose_Round()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local teamUserCount = 0
  local teamIndex = 0
  local teamNo = 0
  local teamInfo
  local teamCount = ToClient_GetTeamListCountWithOutZero()
  local beforeTeamCnt = 0
  for Index = 0, teamCount - 1 do
    if 1 < Index then
      break
    end
    teamInfo = ToClient_GetTeamListAt(Index)
    teamNo = teamInfo:getTeamNo()
    teamUserCount = ToClient_GetTeamUserInfoCount(teamNo)
    teamIndex = teamNo - 1
    beforeTeamCnt = 0
    if nil ~= self._teamMemberUi[teamIndex] then
      beforeTeamCnt = #self._teamMemberUi[teamIndex] + 1
    end
    for userIndex = 0, beforeTeamCnt - 1 do
      self:statSlotSetShow(teamIndex, userIndex, false, false)
    end
  end
end
function PaGlobal_Arsha_Party_All:stateSlotClose_FreeForAll()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local teamNo = 0
  local teamIndex = 0
  local teamInfo
  local teamCount = ToClient_GetTeamListCountWithOutZero()
  for Index = 0, teamCount - 1 do
    teamInfo = ToClient_GetTeamListAt(Index)
    teamNo = teamInfo:getTeamNo()
    teamIndex = teamNo - 1
    self:statSlotSetShow(0, teamIndex, false, true)
  end
end
function PaGlobal_Arsha_Party_All:stateSlotClose_Personal()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local teamIndex = 0
  for teamNo = 1, 2 do
    teamIndex = teamNo - 1
    self:statSlotSetShow(teamIndex, 0, false, false)
  end
end
function PaGlobal_Arsha_Party_All:registEventHandler()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  registerEvent("FromClient_UpdateUserHP", "FromClient_Arsha_Party_All_UpdateUserHP")
end
function PaGlobal_Arsha_Party_All:validate()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  self._ui._leftTeam.stc_mainBg:isValidate()
  self._ui._leftTeam.stc_teamNameBg:isValidate()
  self._ui._leftTeam.txt_teamName:isValidate()
  self._ui._leftTeam.stc_memberTemplate:isValidate()
  self._ui._rightTeam.stc_mainBg:isValidate()
  self._ui._rightTeam.stc_teamNameBg:isValidate()
  self._ui._rightTeam.txt_teamName:isValidate()
  self._ui._rightTeam.stc_memberTemplate:isValidate()
end
function PaGlobal_Arsha_Party_All:resize()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  Panel_Widget_Arsha_Party_All:SetSize(getScreenSizeX(), Panel_Widget_Arsha_Party_All:GetSizeY())
  Panel_Widget_Arsha_Party_All:ComputePos()
  self._ui._leftTeam.stc_mainBg:ComputePos()
  self._ui._rightTeam.stc_mainBg:ComputePos()
end
