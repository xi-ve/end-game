PaGlobal_SA_Widget_GuardGauge = {
  _ui = {
    stc_guardGaugeBg = nil,
    progress_guard = nil,
    txt_guardGaugeText = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_GuardGauge_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_GuardGauge_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_GuardGaugeInit")
function FromClient_SA_Widget_GuardGaugeInit()
  PaGlobal_SA_Widget_GuardGauge:initialize()
end
