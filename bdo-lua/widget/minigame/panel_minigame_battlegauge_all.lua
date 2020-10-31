PaGlobal_MiniGame_BattleGauge_All = {
  _ui = {
    stc_gaugeBG = nil,
    progress_myGauge = nil,
    stc_myGauge_head = nil,
    txt_titleText = nil,
    txt_remainTimeText = nil,
    stc_human = nil,
    stc_horse = nil,
    stc_currentPos = nil,
    btn_currentResult = nil,
    stc_middleLine = nil,
    stc_gong = nil,
    stc_spacebar = nil,
    txt_spacebarText = nil,
    stc_keyguideB = nil,
    stc_resultSuccess = nil,
    stc_resultFailed = nil
  },
  _ballGroup = {},
  _ball_Index = 1,
  _sumDeltaTime = 0,
  _currentPercent = 50,
  _remainTime = 11,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_BattleGauge_All_1.lua")
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_BattleGauge_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MiniGame_BattleGauge_All_Init")
function FromClient_MiniGame_BattleGauge_All_Init()
  PaGlobal_MiniGame_BattleGauge_All:initialize()
end
