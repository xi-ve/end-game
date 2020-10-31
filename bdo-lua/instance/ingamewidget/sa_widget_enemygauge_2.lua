function FromClient_SA_Widget_EnemyGauge_ReSizePanel()
  PaGlobal_SA_Widget_EnemyGauge._ui.stc_targetName:ComputePos()
  PaGlobal_SA_Widget_EnemyGauge._ui.stc_enemyGaugeBG:ComputePos()
  PaGlobal_SA_Widget_EnemyGauge._ui.progress_enemy:ComputePos()
  PaGlobal_SA_Widget_EnemyGauge._ui.stc_bossGaugeBG:ComputePos()
  PaGlobal_SA_Widget_EnemyGauge._ui.progress_boss:ComputePos()
  PaGlobal_SA_Widget_EnemyGauge._ui.stc_playerGaugeBG:ComputePos()
  PaGlobal_SA_Widget_EnemyGauge._ui.progress_player:ComputePos()
end
function PaGlobal_SA_Widget_EnemyGauge_TargetInfo_Update(actorKey, nowHP)
  local targetActor = getCharacterActor(actorKey)
  if nil == targetActor then
    return
  end
  if 4 ~= targetActor:getCharacterGradeType() then
    PaGlobal_SA_Widget_EnemyGauge:setProgressEnemy(actorKey, nowHP)
  else
    PaGlobal_SA_Widget_EnemyGauge:setProgressBoss(actorKey, nowHP)
  end
end
function PaGlobal_SA_Widget_EnemyGauge_TargetHpInfo_Update_Player(actorKey, nowHP)
  local targetActor = getCharacterActor(actorKey)
  if nil == targetActor then
    return
  end
  PaGlobal_SA_Widget_EnemyGauge:setProgressPlayer(actorKey, nowHP)
end
function PaGlobal_SA_Widget_EnemyGauge_TargetHpInfo_Update_Other(actorKey, nowHP)
  local targetActor = getCharacterActor(actorKey)
  if nil == targetActor then
    return
  end
  PaGlobal_SA_Widget_EnemyGauge:setProgressEnemy(actorKey, nowHP)
end
function PaGlobal_SA_Widget_EnemyGauge_Update_Monster_Info(actorKey)
  PaGlobal_SA_Widget_EnemyGauge._ui.stc_targetName:SetShow(false)
  PaGlobal_SA_Widget_EnemyGauge._ui.stc_enemyGaugeBG:SetShow(false)
  PaGlobal_SA_Widget_EnemyGauge._ui.stc_bossGaugeBG:SetShow(false)
  PaGlobal_SA_Widget_EnemyGauge._ui.stc_playerGaugeBG:SetShow(false)
  local targetActor = getCharacterActor(actorKey)
  if nil == targetActor then
    return
  end
  PaGlobal_SA_Widget_EnemyGauge.targetActorKey = actorKey
  local monsterLevel = targetActor:get():getCharacterStaticStatus().level
  PaGlobal_SA_Widget_EnemyGauge.monsterList[PaGlobal_SA_Widget_EnemyGauge.targetActorKey] = monsterLevel
  local maxLevel = PaGlobal_SA_Widget_EnemyGauge:getMaxLevel()
  PaGlobal_SA_Widget_EnemyGauge.elapsedTime = 0
  local modecheck = GetUIMode()
  if Defines.UIMode.eUIMode_NpcDialog ~= modecheck then
    PaGlobal_SA_Widget_EnemyGauge:prepareOpen()
    PaGlobal_SA_Widget_EnemyGauge_RePos()
  else
    PaGlobal_SA_Widget_EnemyGauge.isMonsterBarShow = true
  end
  if true == targetActor:get():isHiddenName() then
    PaGlobal_SA_Widget_EnemyGauge._ui.stc_targetName:SetShow(false)
  else
    PaGlobal_SA_Widget_EnemyGauge._ui.stc_targetName:SetShow(true)
  end
  local mentalCardKey = ToClient_getMentalCardKey(actorKey)
  local selfPlayerWrapper = getSelfPlayer()
  local mentalLevel = -1
  local mentalLevelString = ""
  if nil ~= selfPlayerWrapper then
    local selfPlayer = selfPlayerWrapper:get()
    if nil ~= selfPlayer then
      local mentalCard = selfPlayer:getMentalKnowledge():getCardByKeyRaw(mentalCardKey)
      if nil ~= mentalCard then
        mentalLevel = mentalCard:getLevel()
      end
      mentalLevelString = PAGetString(Defines.StringSheet_GAME, "MENTAL_OBJECTCARD_" .. tostring(mentalLevel - 1))
    end
  end
  if targetActor:get():isPlayer() then
    local playerActorProxyWrapper = getPlayerActor(actorKey)
    if playerActorProxyWrapper:get():isVolunteer() then
      PaGlobal_SA_Widget_EnemyGauge._ui.stc_targetName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA"))
    else
      PaGlobal_SA_Widget_EnemyGauge._ui.stc_targetName:SetText(targetActor:getName() .. mentalLevelString)
    end
  else
    PaGlobal_SA_Widget_EnemyGauge._ui.stc_targetName:SetText(targetActor:getName() .. mentalLevelString)
  end
  local curHP = targetActor:get():getHp()
  local maxHP = targetActor:get():getMaxHp()
  local nowHP = curHP * 100 / maxHP
  if curHP < 1 then
    PaGlobal_SA_Widget_EnemyGauge:prepareClose()
    monsterList = {}
  end
  if targetActor:get():isMonster() then
    PaGlobal_SA_Widget_EnemyGauge_TargetInfo_Update(actorKey, nowHP)
    PaGlobal_SA_Widget_EnemyGauge_recentTargetInfo_TendencyOnDead_MSG(targetActor, actorKey)
  elseif targetActor:get():isPlayer() then
    PaGlobal_SA_Widget_EnemyGauge_TargetHpInfo_Update_Player(actorKey, nowHP)
  else
    PaGlobal_SA_Widget_EnemyGauge_TargetHpInfo_Update_Other(actorKey, nowHP)
    PaGlobal_SA_Widget_EnemyGauge_recentTargetInfo_TendencyOnDead_MSG(targetActor, actorKey)
  end
  if targetActor:get():getCharacterStaticStatus()._isHiddenHp then
    PaGlobal_SA_Widget_EnemyGauge:setShowGauge(false)
  elseif targetActor:get():isMonster() then
    if 4 == targetActor:getCharacterGradeType() then
      PaGlobal_SA_Widget_EnemyGauge._ui.stc_targetName:SetShow(true)
      PaGlobal_SA_Widget_EnemyGauge._ui.stc_bossGaugeBG:SetShow(true)
    else
      PaGlobal_SA_Widget_EnemyGauge._ui.stc_targetName:SetShow(true)
      PaGlobal_SA_Widget_EnemyGauge._ui.stc_enemyGaugeBG:SetShow(true)
    end
  elseif targetActor:get():isPlayer() then
    PaGlobal_SA_Widget_EnemyGauge._ui.stc_targetName:SetShow(true)
    PaGlobal_SA_Widget_EnemyGauge._ui.stc_playerGaugeBG:SetShow(true)
  else
    PaGlobal_SA_Widget_EnemyGauge._ui.stc_targetName:SetShow(true)
    PaGlobal_SA_Widget_EnemyGauge._ui.stc_enemyGaugeBG:SetShow(true)
  end
end
function PaGlobal_SA_Widget_EnemyGauge_RePos()
  Panel_SA_Widget_EnemyGauge:ComputePos()
  PaGlobal_SA_Widget_EnemyGauge:setShowGauge(true)
end
function PaGlobal_SA_Widget_EnemyGauge_HideRecentTargetInfo()
  PaGlobal_SA_Widget_EnemyGauge.monsterList = {}
  PaGlobal_SA_Widget_EnemyGauge:prepareClose()
end
function PaGlobal_SA_Widget_EnemyGauge_GameOption_NearMonsterAlertOff()
  ToClient_SetMessageFilter(10, true)
end
function PaGlobal_SA_Widget_EnemyGauge_recentTargetInfo_TendencyOnDead_MSG(targetActor, actorKey)
  if targetActor:get():hasVehicleOwner() then
    return
  end
  local targetName = targetActor:getCharacterStaticStatusWrapper():getName()
  local characterTOD = targetActor:getCharacterStaticStatusWrapper():getTendencyOnDead()
  if nil ~= characterTOD and characterTOD < 0 then
    if nil ~= PaGlobal_SA_Widget_EnemyGauge._ui.nowTarget[actorKey] then
      if PaGlobal_SA_Widget_EnemyGauge._ui.nowTarget[actorKey] < 10 then
        PaGlobal_SA_Widget_EnemyGauge._ui.nowTarget[actorKey] = PaGlobal_SA_Widget_EnemyGauge._ui.nowTarget[actorKey] + 1
      else
        PaGlobal_SA_Widget_EnemyGauge._ui.nowTarget[actorKey] = 0
        if false == ToClient_isDontPvPDecreaseTendency() then
          Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RECENTTARGETINFO_CHARACTERTOD", "getName", targetName))
        end
      end
    else
      PaGlobal_SA_Widget_EnemyGauge._ui.nowTarget[actorKey] = 0
      if false == ToClient_isDontPvPDecreaseTendency() then
        Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RECENTTARGETINFO_CHARACTERTOD", "getName", targetName))
      end
    end
  end
end
function PaGlobal_SA_Widget_EnemyGauge_UpdateTargetInfoCheckTime(fDeltatime)
  PaGlobal_SA_Widget_EnemyGauge.elapsedTime = PaGlobal_SA_Widget_EnemyGauge.elapsedTime + fDeltatime
  if PaGlobal_SA_Widget_EnemyGauge.elapsedTime > 20 then
    PaGlobal_SA_Widget_EnemyGauge.elapsedTime = 0
    PaGlobal_SA_Widget_EnemyGauge.monsterList = {}
    PaGlobal_SA_Widget_EnemyGauge:prepareClose()
    clearTargetActor()
  end
end
function PaGlobal_SA_Widget_EnemyGauge_ShowAni()
  if nil == Panel_SA_Widget_EnemyGauge then
    return
  end
end
function PaGlobal_SA_Widget_EnemyGauge_HideAni()
  if nil == Panel_SA_Widget_EnemyGauge then
    return
  end
end
