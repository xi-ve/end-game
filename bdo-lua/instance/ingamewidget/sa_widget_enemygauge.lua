PaGlobal_SA_Widget_EnemyGauge = {
  _ui = {
    stc_targetName = nil,
    stc_enemyGaugeBG = nil,
    progress_enemy = nil,
    stc_bossGaugeBG = nil,
    progress_boss = nil
  },
  _initialize = false,
  elapsedTime = 0,
  monsterList = {},
  appliedBuff_UIPool = {},
  appliedBuff_UIPool_Last = 0,
  appliedBuff_DATAPool = {},
  targetActorKey = 0,
  nowTarget = {},
  isMonsterBarShow = false,
  hpColor = {
    _75 = 4293444145,
    _50 = 4292647697,
    _25 = 4292442624,
    _10 = 4290660864,
    _5 = 4293676845,
    _base = 4294955350
  }
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_EnemyGauge_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_EnemyGauge_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_EnemyGaugeInit")
function FromClient_SA_Widget_EnemyGaugeInit()
  PaGlobal_SA_Widget_EnemyGauge:initialize()
end
