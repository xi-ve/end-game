PaGlobal_SA_Widget_ScoreBoard_Detail = {
  _ui = {
    txt_ResultTitle = nil,
    txt_killEnemy = nil,
    txt_survivalTime = nil,
    txt_addDamage = nil,
    txt_receivedDamage = nil,
    txt_killMonster = nil,
    txt_totalScore = nil,
    txt_rankBonus = nil,
    txt_silver = nil,
    txt_whiteCont = nil,
    txt_whiteSilver = nil,
    txt_greenCont = nil,
    txt_greenSilver = nil,
    txt_blueCont = nil,
    txt_blueSilver = nil,
    txt_yellowCont = nil,
    txt_yellowSilver = nil,
    txt_orangeCont = nil,
    txt_orangeSilver = nil,
    txt_notice = nil,
    stc_bottomButtonBG = nil,
    btn_watching = nil,
    btn_exit = nil
  },
  _closePanel = {
    Panel_SA_NakMessage,
    Panel_SA_Widget_Party,
    Panel_SA_Looting_Equip,
    Panel_SA_Widget_Survival,
    Panel_SA_MainFrame,
    Panel_SA_Widget_Minimap,
    Panel_SA_Window_WorldMap,
    Panel_SA_Widget_KeyInfo,
    Panel_SA_Looting,
    Panel_SA_Widget_Quest,
    Panel_SA_KillLog,
    Panel_SA_SkillList,
    Panel_SA_Widget_EnemyGauge
  },
  _myData = {
    rank = 0,
    pkCount = 0,
    mkCount = 0,
    damage = 0,
    hit = 0,
    servivalTime = 0,
    score = 0
  },
  _initialize = false,
  _isGameEnd = false,
  _whiteItemPrice = 10000,
  _greenItemPrice = 30000,
  _blueItemPrice = 80000,
  _yellowItemPrice = 400000,
  _orangeItemPrice = 400000,
  _respawnTime = 10
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Scoreboard_Detail_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Scoreboard_Detail_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_ScoreBoard_DetailInit")
function FromClient_SA_Widget_ScoreBoard_DetailInit()
  PaGlobal_SA_Widget_ScoreBoard_Detail:initialize()
end
