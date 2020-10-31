function PaGlobal_SA_Widget_ScoreBoard_Open()
  PaGlobal_SA_Widget_ScoreBoard:prepareOpen()
  PaGlobal_SA_Widget_ScoreBoard_ShowAni()
end
function PaGlobal_SA_Widget_ScoreBoard_Close()
  PaGlobal_SA_Widget_ScoreBoard:prepareClose()
end
function FromClient_SA_Widget_ScoreBoard_ReSizePanel()
  PaGlobal_SA_Widget_ScoreBoard._ui.stc_resultIcon:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard._ui.stc_totalResultIcon:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard._ui.stc_myRankBG:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard._ui.stc_myCharIcon:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard._ui.txt_myUserID:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard._ui.txt_myRankValue:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard._ui.txt_myKillValue:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard._ui.stc_otherRankIcon:ComputePos()
end
function FromClient_SA_Widget_ScoreBoard_MyRecord(attackerActorKeyRaw, isSkipDeathPenalty, isHasRestoreExp, isAblePvPMatchRevive, respawnTime)
  PaGlobal_SA_Widget_ScoreBoard_SetMyScore()
  local isOtherRankShow = true
  if false == PaGlobal_SA_Widget_ScoreBoard._isGameEnd then
    isOtherRankShow = false
  end
  PaGlobal_SA_Widget_ScoreBoard:showOtherRank(isOtherRankShow)
  if nil ~= attackerActorKeyRaw then
    local attackerActorProxyWrapper = getActor(attackerActorKeyRaw)
    if nil == attackerActorProxyWrapper then
      return
    end
    PaGlobal_SA_Widget_ScoreBoard._attackerName = attackerActorProxyWrapper:getOriginalName()
    local deadMsg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_DEADMSG_MAIN", "classType", tostring(PaGlobal_SA_Widget_ScoreBoard._attackerName))
    PaGlobal_SA_Widget_ScoreBoard._ui.stc_resultIcon:SetText(deadMsg)
  end
end
function FromClient_SA_Widget_ScoreBoard_BattleRoyaleStateChanged(state)
  if __eBattleRoyaleState_Playing == state then
    PaGlobal_SA_Widget_ScoreBoard._maxPlayerCount = ToClient_BattleRoyaleTotalPlayerCount()
  end
end
function PaGlobal_SA_Widget_ScoreBoard_CreateListControl(control, idx)
  local listIdx = Int64toInt32(idx) - 1
  local battleWrapper = ToClient_GetShadowArenaScoreRecod(listIdx)
  local otherRankBg = UI.getChildControl(control, "Static_OtherRankBG_Winner")
  local characterIcon = UI.getChildControl(otherRankBg, "Static_CharacterIcon")
  local userNameText = UI.getChildControl(otherRankBg, "StaticText_UserID")
  local rankText = UI.getChildControl(otherRankBg, "StaticText_OtherRankValue")
  local firstRankText = UI.getChildControl(otherRankBg, "StaticText_OtherRankValue_Winner")
  local secondRankText = UI.getChildControl(otherRankBg, "StaticText_OtherRankValue_2nd")
  local thirdRankText = UI.getChildControl(otherRankBg, "StaticText_OtherRankValue_3rd")
  local killCountText = UI.getChildControl(otherRankBg, "StaticText_OtherKillScoreValue")
  if nil == battleWrapper then
    return
  end
  local killCnt = battleWrapper:getPlayerKills()
  local rank = battleWrapper:getRanking()
  local classType = battleWrapper:getClassType()
  characterIcon:ChangeTextureInfoName(PaGlobal_SA_Widget_ScoreBoard._characterIconUV.path)
  local x1, y1, x2, y2 = setTextureUV_Func(characterIcon, PaGlobal_SA_Widget_ScoreBoard._characterIconUV[classType].x1, PaGlobal_SA_Widget_ScoreBoard._characterIconUV[classType].y1, PaGlobal_SA_Widget_ScoreBoard._characterIconUV[classType].x2, PaGlobal_SA_Widget_ScoreBoard._characterIconUV[classType].y2)
  characterIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  characterIcon:setRenderTexture(characterIcon:getBaseTexture())
  local userNickName = battleWrapper:getUserNickname()
  userNameText:SetText(userNickName)
  firstRankText:SetShow(false)
  secondRankText:SetShow(false)
  thirdRankText:SetShow(false)
  rankText:SetShow(true)
  if 1 == rank then
    firstRankText:SetShow(true)
    rankText:SetShow(false)
  elseif 2 == rank then
    secondRankText:SetShow(true)
    rankText:SetShow(false)
  elseif 3 == rank then
    thirdRankText:SetShow(true)
    rankText:SetShow(false)
  else
    rankText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_RESULT_RANK", "rank", tostring(rank)))
  end
  killCountText:SetText(killCnt)
end
function PaGlobal_SA_Widget_ScoreBoard_SetWinner(rank, nickName1, classType1, nickName2, classType2, nickName3, classType3)
  local isOtherRankShow = false
  PaGlobal_SA_Widget_ScoreBoard._isGameEnd = true
  if nil == nickName1 or nil == classType1 then
    return
  end
  PaGlobal_SA_Widget_ScoreBoard:showAllRank(isOtherRankShow)
  if nil ~= nickName1 then
    PaGlobal_SA_Widget_ScoreBoard:setWinnerInfo(1, nickName1, classType1)
  end
  if nil ~= nickName2 then
    PaGlobal_SA_Widget_ScoreBoard:setWinnerInfo(2, nickName2, classType2)
  end
  if nil ~= nickName3 then
    PaGlobal_SA_Widget_ScoreBoard:setWinnerInfo(3, nickName3, classType3)
  end
  PaGlobal_SA_Widget_ScoreBoard_SetMyScore()
  PaGlobal_SA_Widget_ScoreBoard._ui.stc_resultIcon:SetShow(false)
  PaGlobal_SA_Widget_ScoreBoard._ui.stc_totalResultIcon:SetShow(true)
end
function PaGlobal_SA_Widget_ScoreBoard_SetMyScore()
  if true == PaGlobal_SA_Widget_ScoreBoard._wasObserverMode then
    return
  end
  local battleWrapper = ToClient_BattleRoyaleRecordWrapper()
  if nil == battleWrapper or true == ToClient_IsBattleRoyaleTrainingRoom() then
    return
  end
  local killCnt = battleWrapper:getPlayerKills()
  local rank = battleWrapper:getRanking()
  local classSymbolInfo = CppEnums.ClassType_Symbol[getSelfPlayer():getClassType()]
  PaGlobal_SA_Widget_ScoreBoard._ui.txt_myUserID:SetText(getFamilyName())
  PaGlobal_SA_Widget_ScoreBoard._ui.txt_myRankValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_RESULT_RANK", "rank", tostring(rank)))
  PaGlobal_SA_Widget_ScoreBoard._ui.txt_myKillValue:SetText(killCnt)
  local classType = battleWrapper:getClassType()
  if nil == PaGlobal_SA_Widget_ScoreBoard._characterIconUV[classType] then
    return
  end
  PaGlobal_SA_Widget_ScoreBoard._ui.stc_myCharIcon:ChangeTextureInfoName(PaGlobal_SA_Widget_ScoreBoard._characterIconUV.path)
  local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_SA_Widget_ScoreBoard._ui.stc_myCharIcon, PaGlobal_SA_Widget_ScoreBoard._characterIconUV[classType].x1, PaGlobal_SA_Widget_ScoreBoard._characterIconUV[classType].y1, PaGlobal_SA_Widget_ScoreBoard._characterIconUV[classType].x2, PaGlobal_SA_Widget_ScoreBoard._characterIconUV[classType].y2)
  PaGlobal_SA_Widget_ScoreBoard._ui.stc_myCharIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  PaGlobal_SA_Widget_ScoreBoard._ui.stc_myCharIcon:setRenderTexture(PaGlobal_SA_Widget_ScoreBoard._ui.stc_myCharIcon:getBaseTexture())
end
function PaGlobal_SA_Widget_ScoreBoard_ShowAni()
  local panel = Panel_SA_Widget_ScoreBoard
  local moveAni = panel:addMoveAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  moveAni:SetStartPosition(panel:GetPosX() - 100, panel:GetPosY())
  moveAni:SetEndPosition(panel:GetPosX(), panel:GetPosY())
end
