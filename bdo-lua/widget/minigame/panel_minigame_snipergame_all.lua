PaGlobal_MiniGame_SniperGame_All = {
  _ui = {
    _hole = nil,
    _blackboxes = {},
    _crossHair = nil,
    _deviationMark = nil,
    _deviationHit = {},
    _deviationMiss = {},
    _breathContainer = nil,
    _breathBlue = nil,
    _breathYellow = nil,
    _debugText = nil,
    _middlePointDev = nil,
    _fade = nil,
    _fadeCircle = nil
  },
  _bestRadius = 50,
  _bestRadiusThreshold = 5,
  _minRadius = 10,
  _maxRadius = 150,
  _breathXOffset = 4,
  _breathAndContainerRatio = 1,
  _startAniTimePassed = 0,
  _startAniIsPlaying = false,
  _startAniTimeLimit = 0.3,
  _startAniDelay = 0.05,
  centerX = 0,
  centerY = 0,
  _holeTargetX = nil,
  _holeTargetY = nil,
  _holeSize = 2600,
  _holeAniSpeed = 500,
  _lensDistortionPower = 1.3,
  _lensDistortionSize = 0.8,
  _showDebugInfo = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperGame_All_1.lua")
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperGame_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MiniGame_SniperGame_All_Init")
function FromClient_MiniGame_SniperGame_All_Init()
  PaGlobal_MiniGame_SniperGame_All:initialize()
end
