PaGlobal_TopIcon_GuildServant = {_initialize = false}
runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_GuildServant_1.lua")
runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_GuildServant_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_TopIcon_GuildServantInit")
function FromClient_TopIcon_GuildServantInit()
  PaGlobal_TopIcon_GuildServant:initialize()
end
