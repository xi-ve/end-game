PaGlobal_TopIcon_Maid = {
  _ui = {stc_Icon = nil},
  _initialize = false
}
runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Maid_1.lua")
runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Maid_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_TopIcon_MaidInit")
function FromClient_TopIcon_MaidInit()
  PaGlobal_TopIcon_Maid:initialize()
end
