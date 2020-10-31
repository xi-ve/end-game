PaGlobal_BlackspiritPassTooltip = {
  _ui = {
    _txt_title = nil,
    _stc_descBG = nil,
    _txt_desc = nil,
    _stc_expIcon = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Season/Panel_Tooltip_BlackspiritPass_1.lua")
runLua("UI_Data/Script/Window/Season/Panel_Tooltip_BlackspiritPass_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_BlackspiritPassTooltipInit")
function FromClient_PaGlobal_BlackspiritPassTooltipInit()
  PaGlobal_BlackspiritPassTooltip:initialize()
end
