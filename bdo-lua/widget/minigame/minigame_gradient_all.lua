PaGlobal_MiniGame_Gradient_All = {
  _ui = {
    stc_mouseBody_L = nil,
    stc_mouseBody_R = nil,
    stc_gaugeBG = nil,
    stc_gaugeBar = nil,
    stc_resultGood = nil,
    stc_resultBad = nil
  },
  _clickDirection = {
    None = 0,
    Left = -1,
    Right = 1
  },
  _sequenceClickTimeSpan = 1,
  _ClickTimeSpanMaxWeight = 0.35,
  _ClickTimeSpanMinWeight = 0.15,
  _speedWeight = 1,
  _currentPos = 0.5,
  _lastClickTime = 0,
  _lastClickDirection = 0,
  _currentSpeed = 0,
  _isGradientPlay = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MiniGame/MiniGame_Gradient_All_1.lua")
runLua("UI_Data/Script/Widget/MiniGame/MiniGame_Gradient_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Minigame_Gradient_All_Init")
function FromClient_Minigame_Gradient_All_Init()
  PaGlobal_MiniGame_Gradient_All:initialize()
end
