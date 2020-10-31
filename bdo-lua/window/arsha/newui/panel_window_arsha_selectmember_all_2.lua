function PaGlobalFunc_Arsha_SelectMember_All_Open()
  PaGlobal_Arsha_SelectMember_All:prepareOpen()
end
function PaGlobalFunc_Arsha_SelectMember_All_Close()
  PaGlobal_Arsha_SelectMember_All:prepareClose()
end
function HandleEventLUp_Arsha_SelectMember_All_Close()
  PaGlobalFunc_Arsha_SelectMember_All_Close()
end
function PaGlobalFunc_Arsha_SelectMember_UpdateList(content, userIdx)
  PaGlobal_Arsha_SelectMember_All:updateMemberContent(content, userIdx)
end
function PaGlobalFunc_Arsha_SelectMember_All_Clear()
  PaGlobal_Arsha_SelectMember_All:dataClear()
end
function HandleEventLUp_Arsha_SelectMemeber_All_ConfirmAttendMember()
  local myTeamNo = ToClient_GetMyTeamNo()
  ToClient_SelectPersonalMatchAttend(PaGlobal_Arsha_SelectMember_All._attendUserNoTemp, myTeamNo)
end
function HandleEventLUp_Arsha_SelectMember_SetAttend(userIdx)
  local myTeamNo = ToClient_GetMyTeamNo()
  local teamInfo = ToClient_GetArshaTeamInfo(myTeamNo)
  if nil == teamInfo then
    return
  end
  local userInfo = ToClient_GetTeamUserInfoAt(myTeamNo, userIdx)
  if nil == userInfo then
    return
  end
  local userNo = userInfo:getUserNo()
  PaGlobal_Arsha_SelectMember_All._attendUserNoTemp = userNo
  PaGlobal_Arsha_SelectMember_All:update()
end
function FromClient_Arsha_SelectMember_All_SelectAttendTimeAlert(second)
  local msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ARSHA_SELECTATTEND_TIMEALERT", "sec", second)
  if nil ~= msg and "" ~= msg then
    Proc_ShowMessage_Ack(msg)
  end
end
function FromClient_Arsha_SelectMember_All_PersonalMatchAttendSetted(userNo, teamNo)
  local teamInfo = ToClient_GetArshaTeamInfo(teamNo)
  if nil == teamInfo then
    return
  end
  local entryInfo = ToClient_GetEntryInfoByUserNo(userNo)
  if nil == entryInfo then
    return
  end
  local teamName = ""
  teamName = teamInfo:getTeamName()
  if "" == teamName then
    if 1 == teamNo then
      teamName = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_A")
    else
      teamName = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_B")
    end
  end
  local msg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ARSHA_TEAMATTEND_SELECTED", "playerName", entryInfo:getCharacterName(), "teamName", teamName)
  if nil ~= msg and "" ~= msg then
    Proc_ShowMessage_Ack(msg)
  end
end
function FromClient_Arsha_SelectMember_All_PersonalMatchMasterSetted(userNo, teamNo, isAutoSelected)
  local teamInfo = ToClient_GetArshaTeamInfo(teamNo)
  if nil == teamInfo then
    return
  end
  local entryInfo = ToClient_GetEntryInfoByUserNo(userNo)
  if nil == entryInfo then
    return
  end
  local teamName = ""
  teamName = teamInfo:getTeamName()
  if "" == teamName then
    if 1 == teamNo then
      teamName = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_A")
    else
      teamName = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_B")
    end
  end
  local msg = ""
  if true == isAutoSelected then
    msg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAMMASTER_CHANGED", "teamName", teamName, "playerName", entryInfo:getCharacterName())
  else
    msg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ARSHA_TEAMMASTER_SELECTED", "playerName", entryInfo:getCharacterName(), "teamName", teamName)
  end
  if nil ~= msg and "" ~= msg then
    Proc_ShowMessage_Ack(msg)
  end
  local selfPlayer = getSelfPlayer()
  local fightState = ToClient_CompetitionFightState()
  if nil ~= selfPlayer and selfPlayer:get():getUserNo() == userNo and CppEnums.CompetitionFightState.eCompetitionFightState_SelectAttend == fightState then
    PaGlobalFunc_Arsha_SelectMember_All_Open()
  end
  PaGlobalFunc_Arsha_Func_All_UpdateList()
end
function FromClient_Arsha_SelectMember_All_ArshaMyAttendSetResult(isSuccess, userNo)
  if true == isSuccess then
    PaGlobal_Arsha_SelectMember_All._attendUserNoTemp = userNo
  else
    PaGlobal_Arsha_SelectMember_All._attendUserNoTemp = toInt64(-1, -1)
  end
  PaGlobal_Arsha_SelectMember_All:updateMemberList()
end
function FromClient_Arsha_SelectMember_All_ResetArshaSelectAttendUI()
  PaGlobal_Arsha_SelectMember_All:dataClear()
end
function FromClient_Arsha_SelectMembet_All_ResetSelectMemberUI(teamNo)
  local myTeamNo = ToClient_GetMyTeamNo()
  if myTeamNo == teamNo then
    local msg = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_MYTEAM_ATTEND_ESCAPED")
    if nil ~= msg and "" ~= msg then
      Proc_ShowMessage_Ack(msg)
    end
    msg = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_RESELECT_ATTEND")
    if nil ~= msg and "" ~= msg then
      Proc_ShowMessage_Ack(msg)
    end
    PaGlobal_Arsha_SelectMember_All._attendUserNoTemp = toInt64(-1, -1)
    PaGlobal_Arsha_SelectMember_All:updateMemberList()
  else
    local msg = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_OTHERTEAM_ATTEND_ESCAPED")
    if msg ~= nil and msg ~= "" then
      Proc_ShowMessage_Ack(msg)
    end
  end
end
function FromClient_Arsha_SelectMembet_All_UpdateEntryList()
  PaGlobal_Arsha_SelectMember_All:updateMemberList()
end
function FromClient_Arsha_SelectMembet_All_UpdateTeamScore(teamNum, scoreValue, round, winTeamHP, loseTeamHP)
  if 0 == teamNum then
    PaGlobal_Arsha_SelectMember_All:dataClear()
  elseif ToClient_GetMyTeamNo() ~= teamNum then
    PaGlobal_Arsha_SelectMember_All:dataClear()
  end
end
