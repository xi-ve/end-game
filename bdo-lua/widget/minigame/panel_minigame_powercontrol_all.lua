PaGlobal_PowerControl_All = {
  _direction = {
    none = -1,
    left = 0,
    right = 1
  },
  _ui = {
    _stc_gauge_BG_L = nil,
    _stc_gauge_BG_R = nil,
    _stc_danger_L = nil,
    _stc_danger_R = nil,
    _progress_gauge_L = nil,
    _progress_gauge_R = nil,
    _stc_gaugeDeco_L = nil,
    _stc_gaugeDeco_R = nil,
    _stc_milky_L = nil,
    _stc_milky_R = nil,
    _stc_mouseBG = nil,
    _stc_mouse_L = nil,
    _stc_mouse_R = nil,
    _stc_keyguideBG = nil,
    _txt_gameTimer = nil,
    _txt_milkyRate = nil,
    _stc_result_success = nil,
    _stc_result_failed = nil,
    _progress_Milk = nil
  },
  _directionType = 0,
  _milkRate = 0,
  _leftMilkyRate = 0,
  _rightMilkyRate = 0,
  _isGamePlaying = false,
  _gameEndTimer = 0,
  _endTimer = 0,
  _ePressType_L = -1,
  _ePressType_R = -1,
  _isFullMilk = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_PowerControl_All_1.lua")
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_PowerControl_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PowerControl_All_Init")
function FromClient_PowerControl_All_Init()
  PaGlobal_PowerControl_All:initialize()
end
