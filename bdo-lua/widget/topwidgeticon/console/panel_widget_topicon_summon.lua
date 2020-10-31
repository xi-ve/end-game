PaGlobal_TopIcon_Summon = {
  _ui = {
    stc_Icon = nil,
    progress_Hp = nil,
    progress_Mp = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Summon_1.lua")
runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Summon_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_TopIcon_SummonInit")
function FromClient_TopIcon_SummonInit()
  PaGlobal_TopIcon_Summon:initialize()
end
