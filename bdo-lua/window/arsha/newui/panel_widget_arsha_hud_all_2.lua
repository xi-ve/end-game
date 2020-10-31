function PaGlobalFunc_Arsha_Hud_All_Open()
  PaGlobal_Arsha_Hud_All:prepareOpen()
end
function PaGlobalFunc_Arsha_Hud_All_Close()
  PaGlobal_Arsha_Hud_All:prepareClose()
end
function PaGlobalFunc_Arsha_Hud_All_Hide()
  PaGlobal_Arsha_Hud_All:close()
end
function PaGlobalFunc_Arsha_Hud_All_Update()
  PaGlobal_Arsha_Hud_All:update()
end
function FromClient_Arsha_Hud_All_OnScreenResize()
  if nil == Panel_Widget_Arsha_Hud_All then
    return
  end
  Panel_Widget_Arsha_Hud_All:ComputePos()
end
function FromClient_Arsha_Hud_All_UpdateFightState(fightState, isShowingResultMessage)
  if nil == fightState or "" == fightState then
    return
  end
  PaGlobal_Arsha_Hud_All._fightState = fightState
  PaGlobal_Arsha_Hud_All:setTeamInfo()
  PaGlobalFunc_Arsha_SelectMember_All_Close()
  if CppEnums.CompetitionFightState.eCompetitionFightState_Fight == fightState then
    PaGlobal_Arsha_Hud_All:changeMatchType()
    PaGlobal_Arsha_Hud_All:open()
    if nil ~= PaGlobalFunc_Arsha_Party_All_Create then
      PaGlobalFunc_Arsha_Party_All_Create()
    end
    local message = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_FIGHTSTATE_START_MAIN"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_FIGHTSTATE_START_SUB"),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(message, 5, 56, false)
  elseif CppEnums.CompetitionFightState.eCompetitionFightState_Done == fightState then
    PaGlobal_Arsha_Hud_All:open()
    PaGlobalFunc_Arsha_Party_All_Close()
    PaGlobalFunc_Arsha_SelectMember_All_Clear()
    PaGlobal_Arsha_Hud_All._ui.txt_leftPoint:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_WAITING"))
    PaGlobal_Arsha_Hud_All._ui.txt_rightPoint:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_WAITING"))
    if false == isShowingResultMessage then
      local message = {
        main = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_FIGHTSTATE_STOP_MAIN"),
        sub = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_FIGHTSTATE_STOP_SUB"),
        addMsg = ""
      }
      Proc_ShowMessage_Ack_For_RewardSelect(message, 5, 57, false)
    end
    PaGlobal_Arsha_Hud_All:changeMatchType()
  elseif CppEnums.CompetitionFightState.eCompetitionFightState_Wait == fightState then
    PaGlobal_Arsha_Hud_All:changeMatchType()
    PaGlobal_Arsha_Hud_All:open()
    PaGlobalFunc_Arsha_Party_All_Close()
  elseif CppEnums.CompetitionFightState.eCompetitionFightState_SelectAttend == fightState then
    PaGlobalFunc_Arsha_Party_All_Close()
    if 0 < ToClient_GetMyTeamNo() then
      PaGlobalFunc_Arsha_SelectMember_All_Open()
    end
    PaGlobal_Arsha_Hud_All:changeMatchType()
  else
    if true == ToClient_IsMyselfInArena() then
      PaGlobal_Arsha_Hud_All:open()
    else
      PaGlobal_Arsha_Hud_All:close()
    end
    PaGlobal_Arsha_Hud_All:changeMatchType()
  end
  PaGlobal_Arsha_Hud_All:alignTeamName()
end
function FromClient_Arsha_Hud_All_UpdateTeamScore()
  PaGlobal_Arsha_Hud_All:update()
end
function FromClient_Arsha_Hud_All_UpdateTeamScoreForReplay(teamNum, scoreValue)
  PaGlobal_Arsha_Hud_All:setScoreForReplay(teamNum, scoreValue)
end
function FromClient_Arsha_Hud_All_UpdatePersonalMatchAliveAttendCount()
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal ~= ToClient_CompetitionMatchType() then
    return
  end
  local teamA_Info = ToClient_GetArshaTeamInfo(1)
  local teamB_Info = ToClient_GetArshaTeamInfo(2)
  if CppEnums.CompetitionFightState.eCompetitionFightState_Done == ToClient_CompetitionFightState() then
    PaGlobal_Arsha_Hud_All._ui.txt_leftPoint:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_WAITING"))
    PaGlobal_Arsha_Hud_All._ui.txt_rightPoint:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_WAITING"))
  elseif nil ~= teamA_Info and nil ~= teamB_Info then
    local teamAAliveCount = teamA_Info:getAliveAttendCount()
    local teamBAliveCount = teamB_Info:getAliveAttendCount()
    PaGlobal_Arsha_Hud_All._ui.txt_leftPoint:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_ALIVECOUNT_SCORE", "aliveCount", teamAAliveCount))
    PaGlobal_Arsha_Hud_All._ui.txt_rightPoint:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_ALIVECOUNT_SCORE", "aliveCount", teamBAliveCount))
  else
    PaGlobal_Arsha_Hud_All._ui.txt_leftPoint:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_WAITING"))
    PaGlobal_Arsha_Hud_All._ui.txt_rightPoint:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_WAITING"))
  end
  PaGlobal_Arsha_Hud_All:alignTeamName()
end
function FromClient_Arsha_Hud_All_ScoreReset()
  PaGlobal_Arsha_Hud_All._ui.txt_leftPoint:SetText(0)
  PaGlobal_Arsha_Hud_All._ui.txt_rightPoint:SetText(0)
  PaGlobal_Arsha_Hud_All:alignTeamName()
end
function FromClient_Arsha_Hud_All_WaitTimeAlert(second)
  local msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_WAIT_BEFORE_FIGHT", "waitTime", second)
  if msg ~= nil and msg ~= "" then
    Proc_ShowMessage_Ack(msg)
  end
end
function FromClient_Arsha_Hud_All_TeamMasterOut(teamNo)
  if teamNo == ToClient_GetMyTeamNo() then
    local msg = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_MYTEAM_MASTER_ESCAPED")
    if msg ~= nil and msg ~= "" then
      Proc_ShowMessage_Ack(msg)
    end
  else
    return
  end
end
function FromClient_Arsha_Hud_All_Debuff()
end
function FromClient_Arsha_Hud_All_PersonalMatchDebuff(debuffTeamNo)
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal ~= ToClient_CompetitionMatchType() then
    return
  end
  if 1 ~= debuffTeamNo and 2 ~= debuffTeamNo then
    return
  end
  local teamInfo = ToClient_GetArshaTeamInfo(debuffTeamNo)
  if nil == teamInfo then
    return
  end
  local userInfo = ToClient_GetEntryInfoByUserNo(teamInfo:getAttendPlayer())
  if nil == userInfo then
    return
  end
  local teamName = teamInfo:getTeamName()
  if "" == teamName then
    if 1 == debuffTeamNo then
      teamName = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_A")
    else
      teamName = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_B")
    end
  end
  local msg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ARSHAPERSONALMATCH_DEBUFF_APPLIED", "teamName", teamName, "playerName", userInfo:getCharacterName())
  Proc_ShowMessage_Ack(msg)
end
function PaGlobalFunc_Arsha_Hud_All_UpdateFrame(deltaTime)
  local isPlaying = PaGlobal_Arsha_Hud_All._fightState == CppEnums.CompetitionFightState.eCompetitionFightState_Fight
  if not isPlaying then
    return
  end
  if PaGlobal_Arsha_Hud_All._delayTime > PaGlobal_Arsha_Hud_All._competitionGameDeltaTime + deltaTime then
    PaGlobal_Arsha_Hud_All._competitionGameDeltaTime = PaGlobal_Arsha_Hud_All._competitionGameDeltaTime + deltaTime
    return
  end
  PaGlobal_Arsha_Hud_All._competitionGameDeltaTime = 0
  PaGlobal_Arsha_Hud_All:updateTimerWidget()
end
function FromClient_ReplayArshaLimitTime(limitTime)
  PaGlobal_Arsha_Hud_All:setTimeForReplay(limitTime)
end
