PaGlobal_Jaksal_All = {
  _ui = {
    _stc_fish = nil,
    _stc_water = nil,
    _stc_crossHair = nil,
    _stc_jaksal = nil,
    _progress_fishPower = nil,
    _progress_jaksalPower = nil,
    _stc_resultSuccess = nil,
    _stc_resultFailed = nil,
    _stc_fishGet = nil,
    _txt_jaksalCount = nil,
    _txt_endTimer = nil
  },
  _fishMoveData = {
    position = float2(0, 0),
    rotate = 0,
    destPosition = float2(300, 0),
    escapePower = 1,
    escapePowerDecreasePerSec = 0.9,
    escapePowerIncreasePerSec = 0.1,
    fishRePositionTime = 0
  },
  _sumTime = 0,
  _jaksalCount = 0,
  _endTimer = 0,
  _isStoppedGame = false,
  _crosshairPosX = 0,
  _crosshairPosY = 0,
  _crosshairSpeed = 500,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Jaksal_All_1.lua")
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Jaksal_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Jaksal_All_Init")
function FromClient_Jaksal_All_Init()
  PaGlobal_Jaksal_All:initialize()
end
