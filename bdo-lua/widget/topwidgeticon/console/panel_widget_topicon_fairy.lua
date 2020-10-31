PaGlobal_TopIcon_Fairy = {
  _ui = {stc_Icon = nil},
  _initialize = false
}
runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Fairy_1.lua")
runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Fairy_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_TopIcon_FairyInit")
function FromClient_TopIcon_FairyInit()
  PaGlobal_TopIcon_Fairy:initialize()
end
