function PaGlobal_SA_Widget_ScoreBoard_Detail_Open()
  PaGlobal_SA_Widget_ScoreBoard_Detail:prepareOpen()
  PaGlobal_SA_Widget_ScoreBoard_Detail_ShowAni()
  PaGlobal_SA_Widget_ScoreBoard_Open()
end
function PaGlobal_SA_Widget_ScoreBoard_Detail_Close()
  PaGlobal_SA_Widget_ScoreBoard_Detail:prepareClose()
  PaGlobal_SA_Widget_ScoreBoard_Close()
end
function HandleEventLUp_SA_Widget_ScoreBoard_Detail_ExitButton()
  local Leave_Out = function()
    ToClient_ExitBattleRoyale()
    PaGlobal_SA_Widget_ScoreBoard_Detail_WaitProcess()
  end
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_MESSAGEBOX_TITLE")
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_MESSAGEBOX_BEFORE_LOBBY")
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = Leave_Out,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_SA_Widget_ScoreBoard_Detail_ObserverMode()
  local partyCount = RequestParty_getPartyMemberCount()
  if 1 < partyCount then
    ToClient_ShowBattleRoyaleCam(true)
  else
    deadMessage_Revival(__eRespanwType_BattleRoyale, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
    ToClient_ShowBattleRoyaleCam(false)
  end
  PaGlobal_SA_Widget_ScoreBoard_Detail_Close()
  if nil ~= Panel_SA_Widget_Survival then
    PaGlobal_SA_Widget_Survival_Open()
  end
  PaGlobal_SA_Widget_ScoreBoard._wasObserverMode = true
end
function FromClient_SA_Widget_ScoreBoard_Detail_PlayEnd(rankNo, nickName1, classType1, nickName2, classType2, nickName3, classType3)
  if true == ToClient_IsBattleRoyaleTrainingRoom() then
    return
  end
  if nil ~= Panel_SA_Widget_Respon_Time and true == Panel_SA_Widget_Respon_Time:GetShow() then
    PaGlobal_SA_Widget_Respon_Message_ShowMessage(PaGlobal_SA_Widget_ScoreBoard_Detail._respawnTime)
    return
  end
  PaGlobal_deadMessage_otherPanelShow(false)
  PaGlobal_SA_Widget_ScoreBoard_Detail._isGameEnd = true
  PaGlobal_SA_Widget_ScoreBoard_SetWinner(nickName1, classType1, nickName2, classType2, nickName3, classType3)
  PaGlobal_SA_Widget_ScoreBoard_Detail_Open()
  FromClient_SA_Widget_ScoreBoard_Detail_Record()
end
function FromClient_SA_Widget_ScoreBoard_Detail_Record()
  if true == PaGlobal_SA_Widget_ScoreBoard._wasObserverMode then
    PaGlobal_SA_Widget_ScoreBoard_Detail._ui.btn_watching:SetShow(false)
    return
  end
  local battleWrapper = ToClient_BattleRoyaleRecordWrapper()
  if nil == battleWrapper or true == ToClient_IsBattleRoyaleTrainingRoom() then
    return
  end
  if nil ~= Panel_SA_Widget_Respon_Time and true == Panel_SA_Widget_Respon_Time:GetShow() then
    PaGlobal_SA_Widget_Respon_Message_ShowMessage(PaGlobal_SA_Widget_ScoreBoard_Detail._respawnTime)
    return
  end
  PaGlobal_SA_Widget_ScoreBoard_Detail._myData.rank = battleWrapper:getRanking()
  PaGlobal_SA_Widget_ScoreBoard_Detail._myData.pkCount = battleWrapper:getPlayerKills()
  PaGlobal_SA_Widget_ScoreBoard_Detail._myData.mkCount = battleWrapper:getMonsterKills()
  PaGlobal_SA_Widget_ScoreBoard_Detail._myData.damage = battleWrapper:getDamageTaken()
  PaGlobal_SA_Widget_ScoreBoard_Detail._myData.hit = battleWrapper:getDamageDone()
  PaGlobal_SA_Widget_ScoreBoard_Detail._myData.lootCount = battleWrapper:getLootCount()
  PaGlobal_SA_Widget_ScoreBoard_Detail._myData.servivalTime = battleWrapper:getServivalTime()
  PaGlobal_SA_Widget_ScoreBoard_Detail._myData.score = battleWrapper:getScore()
  PaGlobal_deadMessage_otherPanelShow(false)
  if false == PaGlobal_SA_Widget_ScoreBoard_Detail._isGameEnd then
    PaGlobal_SA_Widget_ScoreBoard_Detail._ui.btn_watching:SetShow(true)
  else
    PaGlobal_SA_Widget_ScoreBoard_Detail._ui.btn_watching:SetShow(false)
  end
  PaGlobal_SA_Widget_ScoreBoard_Detail:updateMyData()
  PaGlobal_SA_Widget_ScoreBoard_Detail_Open()
end
function FromClient_SA_Widget_ScoreBoard_Detail_ReSizePanel()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_ResultTitle:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_killEnemy:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_survivalTime:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_addDamage:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_receivedDamage:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_killMonster:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_totalScore:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_rankBonus:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_silver:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_whiteCont:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_whiteSilver:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_greenCont:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_greenSilver:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_blueCont:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_blueSilver:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_yellowCont:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_yellowSilver:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_orangeCont:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_orangeSilver:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.txt_notice:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.stc_bottomButtonBG:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.btn_watching:ComputePos()
  PaGlobal_SA_Widget_ScoreBoard_Detail._ui.btn_exit:ComputePos()
end
function PaGlobal_deadMessage_otherPanelShow(isShow)
  for index = 1, #PaGlobal_SA_Widget_ScoreBoard_Detail._closePanel do
    if nil ~= PaGlobal_SA_Widget_ScoreBoard_Detail._closePanel[index] then
      PaGlobal_SA_Widget_ScoreBoard_Detail._closePanel[index]:SetShow(isShow)
    end
  end
end
function PaGlobal_SA_Widget_ScoreBoard_Detail_WaitProcess()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_WAIT_PROCESS"),
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_SA_Widget_ScoreBoard_Detail_PlayerDead()
  FromClient_SA_Widget_ScoreBoard_Detail_Record()
end
function PaGlobal_SA_Widget_ScoreBoard_Detail_ShowAni()
  local panel = Panel_SA_Widget_ScoreBoard_Detail
  local moveAni = panel:addMoveAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  moveAni:SetStartPosition(panel:GetPosX() + 184, panel:GetPosY())
  moveAni:SetEndPosition(panel:GetPosX(), panel:GetPosY())
end
