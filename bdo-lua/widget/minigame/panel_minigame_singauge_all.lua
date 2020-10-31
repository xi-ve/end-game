PaGlobal_SinGauge_All = {
  _eGaugeState = {
    _wait = 0,
    _rightProgress = 1,
    _leftProgress = 2
  },
  _ui = {
    _stc_sinGaugeBg = nil,
    _progress_gaugeBar = nil,
    _progress_barHead = nil,
    _stc_sinGaugeBarEffect = nil,
    _stc_gaugeLine = nil,
    _stc_spaceBar = nil,
    _txt_space = nil,
    _stc_keyguideA = nil,
    _stc_spaceBarEffect = nil,
    _stc_resultPerfect = nil,
    _stc_resultGood = nil,
    _stc_resultBad = nil
  },
  _gameOptionActionKey = {
    Forward = 0,
    Back = 1,
    Left = 2,
    Right = 3,
    Attack = 4,
    SubAttack = 5,
    Dash = 6,
    Jump = 7
  },
  _gaugeSpeed = 0,
  _maxProgressValue = 100,
  _minProgressValue = 5,
  _progressValue = 0,
  _prevTickCount = 0,
  _gaugeTripCount = 0,
  _checkTripCount = 3,
  _gaugeState = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SinGauge_All_1.lua")
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SinGauge_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SinGauge_All_Init")
function FromClient_SinGauge_All_Init()
  PaGlobal_SinGauge_All:initialize()
end
