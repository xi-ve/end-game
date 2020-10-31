PaGlobal_MiniGame_GradientY_All = {
  _ui = {
    stc_gaugeBG = nil,
    stc_gaugeBar = nil,
    stc_keyUp = nil,
    stc_keyUpEff = nil,
    stc_keyDown = nil,
    stc_keyDownEff = nil,
    stc_resultGood = nil,
    stc_resultBad = nil,
    stc_keyGuide = nil,
    stc_keyguideUp = nil,
    stc_keyguideDown = nil,
    stc_keyguideUpEff = nil,
    stc_keyguideDownEff = nil,
    txt_purposeText = nil,
    txt_keyW = nil,
    txt_keyA = nil,
    txt_keyS = nil,
    txt_keyD = nil
  },
  _keyDirection = {
    None = 0,
    Up = -1,
    Down = 1
  },
  _sequenceKeyTimeSpan = 1.1,
  _KeyTimeSpanMaxWeight = 0.25,
  _KeyTimeSpanMinWeight = 0.15,
  _speedWeight = 5,
  _currentPos = 0.5,
  _lastKeyTime = 0,
  _lastKeyDirection = 0,
  _currentSpeed = 0,
  _isGradientYPlay = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_GradientY_All_1.lua")
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_GradientY_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Minigame_GradientY_All_Init")
function FromClient_Minigame_GradientY_All_Init()
  PaGlobal_MiniGame_GradientY_All:initialize()
end
