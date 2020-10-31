PaGlobal_MiniGame_Buoy_All = {
  _ui = {
    stc_timingBG = nil,
    progress_timing = nil,
    stc_timingProgress_head = nil,
    stc_timing = nil,
    stc_arrow = nil,
    stc_horseIcon = nil,
    stc_jumpIcon = nil,
    stc_spacebar = nil,
    txt_spacebarText = nil,
    stc_keyguideA = nil,
    txt_purposeText = nil,
    stc_resultGood = nil,
    stc_resultBad = nil,
    txt_resultText = nil
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
  _progressBar_SpeedPerSec = 0.95,
  _progressBar_speedValue3 = 0.9,
  _progressBar_speedValue2 = 0.1,
  _progressBar_speedValue1 = 0,
  _timing_min = 0.3,
  _timing_max = 0.4,
  _timing_Middle = 0.75,
  _timing_Movingmax = 0.95,
  _timing_movingSpeed = 2,
  _timing_Speed = 2,
  _endAnimationTime = 2,
  _currentTimingValue = 0,
  _currentProgressValue = 0,
  _isUpTiming = true,
  _isUpProgress = true,
  _doMoving = true,
  _playMode = 0,
  _progressBarSpeed = 0,
  _sumTime = 0,
  _isWin = false,
  _buoy_WinCount = 0,
  _isBarMoveStart = false,
  _failTime = 0,
  _realEndTime = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Buoy_All_1.lua")
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Buoy_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MiniGame_Buoy_All_Init")
function FromClient_MiniGame_Buoy_All_Init()
  PaGlobal_MiniGame_Buoy_All:initialize()
end
