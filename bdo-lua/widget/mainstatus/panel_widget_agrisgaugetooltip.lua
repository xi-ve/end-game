PaGlobal_AgrisGaugeTooltip = {
  _ui = {
    progressBG = nil,
    progressBar = nil,
    txt_feverPoint = nil,
    txt_tooltipDesc = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_AgrisGaugeTooltip_1.lua")
runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_AgrisGaugeTooltip_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_AgrisGaugeTooltipInit")
function FromClient_PaGlobal_AgrisGaugeTooltipInit()
  PaGlobal_AgrisGaugeTooltip:initialize()
end
