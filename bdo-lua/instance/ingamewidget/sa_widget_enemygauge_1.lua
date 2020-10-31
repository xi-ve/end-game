function PaGlobal_SA_Widget_EnemyGauge:initialize()
  if true == PaGlobal_SA_Widget_EnemyGauge._initialize then
    return
  end
  self._ui.stc_targetName = UI.getChildControl(Panel_SA_Widget_EnemyGauge, "Static_Name_TargetName")
  self._ui.stc_enemyGaugeBG = UI.getChildControl(Panel_SA_Widget_EnemyGauge, "Static_EnemyGauge_BG")
  self._ui.progress_enemy = UI.getChildControl(self._ui.stc_enemyGaugeBG, "Progress2_1")
  self._ui.stc_bossGaugeBG = UI.getChildControl(Panel_SA_Widget_EnemyGauge, "Static_BossGauge_BG")
  self._ui.progress_boss = UI.getChildControl(self._ui.stc_bossGaugeBG, "Progress2_1")
  self._ui.stc_playerGaugeBG = UI.getChildControl(Panel_SA_Widget_EnemyGauge, "Static_PlayerGauge_BG")
  self._ui.progress_player = UI.getChildControl(self._ui.stc_playerGaugeBG, "Progress2_1")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_SA_Widget_EnemyGauge:registEventHandler()
  if nil == Panel_SA_Widget_EnemyGauge then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_EnemyGauge_ReSizePanel")
  Panel_SA_Widget_EnemyGauge:RegisterShowEventFunc(true, "PaGlobal_SA_Widget_EnemyGauge_ShowAni()")
  Panel_SA_Widget_EnemyGauge:RegisterShowEventFunc(false, "PaGlobal_SA_Widget_EnemyGauge_HideAni()")
  registerEvent("EvnetLeaveInstanceDungeon", "PaGlobal_SA_Widget_EnemyGauge_HideRecentTargetInfo")
  registerEvent("update_Monster_Info_Req", "PaGlobal_SA_Widget_EnemyGauge_Update_Monster_Info")
  Panel_SA_Widget_EnemyGauge:RegisterUpdateFunc("PaGlobal_SA_Widget_EnemyGauge_UpdateTargetInfoCheckTime")
end
function PaGlobal_SA_Widget_EnemyGauge:prepareOpen()
  if nil == Panel_SA_Widget_EnemyGauge then
    return
  end
  PaGlobal_SA_Widget_EnemyGauge:open()
end
function PaGlobal_SA_Widget_EnemyGauge:open()
  if nil == Panel_SA_Widget_EnemyGauge then
    return
  end
  Panel_SA_Widget_EnemyGauge:SetShow(true)
end
function PaGlobal_SA_Widget_EnemyGauge:prepareClose()
  if nil == Panel_SA_Widget_EnemyGauge then
    return
  end
  PaGlobal_SA_Widget_EnemyGauge:close()
end
function PaGlobal_SA_Widget_EnemyGauge:close()
  if nil == Panel_SA_Widget_EnemyGauge then
    return
  end
  Panel_SA_Widget_EnemyGauge:SetShow(false)
end
function PaGlobal_SA_Widget_EnemyGauge:update()
  if nil == Panel_SA_Widget_EnemyGauge then
    return
  end
end
function PaGlobal_SA_Widget_EnemyGauge:validate()
  if nil == Panel_SA_Widget_EnemyGauge then
    return
  end
  self._ui.stc_targetName:isValidate()
  self._ui.stc_enemyGaugeBG:isValidate()
  self._ui.progress_enemy:isValidate()
  self._ui.stc_bossGaugeBG:isValidate()
  self._ui.progress_boss:isValidate()
  self._ui.stc_playerGaugeBG:isValidate()
  self._ui.progress_player:isValidate()
end
function PaGlobal_SA_Widget_EnemyGauge:setShowGauge(isShow)
  self._ui.stc_targetName:SetShow(isShow)
  self._ui.stc_enemyGaugeBG:SetShow(isShow)
  self._ui.stc_bossGaugeBG:SetShow(isShow)
  self._ui.stc_playerGaugeBG:SetShow(isShow)
end
function PaGlobal_SA_Widget_EnemyGauge:setProgressEnemy(actorKey, nowHP)
  local targetActor = getCharacterActor(actorKey)
  if nil == targetActor then
    return
  end
  self._ui.stc_enemyGaugeBG:SetShow(true)
  self._ui.stc_bossGaugeBG:SetShow(false)
  self._ui.stc_playerGaugeBG:SetShow(false)
  if checkActiveCondition(targetActor:getCharacterKey()) == true then
    self._ui.progress_enemy:SetProgressRate(nowHP)
  else
    self._ui.progress_enemy:SetProgressRate(100)
  end
end
function PaGlobal_SA_Widget_EnemyGauge:setProgressBoss(actorKey, nowHP)
  local targetActor = getCharacterActor(actorKey)
  if nil == targetActor then
    return
  end
  self._ui.stc_enemyGaugeBG:SetShow(false)
  self._ui.stc_bossGaugeBG:SetShow(true)
  self._ui.stc_playerGaugeBG:SetShow(false)
  if checkActiveCondition(targetActor:getCharacterKey()) == true then
    self._ui.progress_boss:SetProgressRate(nowHP)
  else
    self._ui.progress_boss:SetProgressRate(100)
  end
end
function PaGlobal_SA_Widget_EnemyGauge:setProgressPlayer(actorKey, nowHP)
  local targetActor = getCharacterActor(actorKey)
  if nil == targetActor then
    return
  end
  self._ui.stc_enemyGaugeBG:SetShow(false)
  self._ui.stc_bossGaugeBG:SetShow(false)
  self._ui.stc_playerGaugeBG:SetShow(true)
  if checkActiveCondition(targetActor:getCharacterKey()) == true then
    self._ui.progress_player:SetProgressRate(nowHP)
  else
    self._ui.progress_player:SetProgressRate(100)
  end
end
function PaGlobal_SA_Widget_EnemyGauge:getMaxLevel()
  local level = 0
  for actorKey, monsterLevel in pairs(self.monsterList) do
    if monsterLevel > level then
      level = monsterLevel
    end
  end
  return level
end
function PaGlobal_SA_Widget_EnemyGauge:updateStunGauge(targetActor, stun, maxStun)
end
