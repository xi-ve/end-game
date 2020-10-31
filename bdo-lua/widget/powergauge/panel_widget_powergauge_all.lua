PaGlobal_PowerGauge_All = {
  _ui = {_progress_gauge = nil, _txt_gaugeValue = nil},
  _wpValue = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/PowerGauge/Panel_Widget_PowerGauge_All_1.lua")
runLua("UI_Data/Script/Widget/PowerGauge/Panel_Widget_PowerGauge_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PowerGauge_All_Init")
function FromClient_PowerGauge_All_Init()
  PaGlobal_PowerGauge_All:initialize()
end
