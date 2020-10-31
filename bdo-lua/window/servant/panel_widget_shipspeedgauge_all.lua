PaGlobal_ShipSpeedGauge = {
  _ui = {_stc_progressBG = nil, _stc_progressBar = nil},
  _initialize = false,
  _progressMoveSpeed = 2
}
runLua("UI_Data/Script/Window/Servant/Panel_Widget_ShipSpeedGauge_All_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_Widget_ShipSpeedGauge_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ShipSpeedGauge_Init")
function FromClient_ShipSpeedGauge_Init()
  PaGlobal_ShipSpeedGauge:initialize()
end
