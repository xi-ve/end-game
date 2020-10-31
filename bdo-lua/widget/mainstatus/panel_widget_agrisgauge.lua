PaGlobal_AgrisGauge = {
  _ui = {
    stc_MainBG = nil,
    progress2_Fever = nil,
    txt_Fever = nil,
    btn_Close = nil
  },
  _curAgrisPointAble = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_AgrisGauge_1.lua")
runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_AgrisGauge_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_AgrisGaugeInit")
function FromClient_PaGlobal_AgrisGaugeInit()
  PaGlobal_AgrisGauge:initialize()
end
