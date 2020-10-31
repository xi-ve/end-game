PaGlobal_ChannelChat_Loading = {
  _ui = {_btn_Cancel = nil},
  _initialize = false
}
runLua("UI_Data/Script/Widget/Chatting/Panel_Widget_ChannelChat_Loading_1.lua")
runLua("UI_Data/Script/Widget/Chatting/Panel_Widget_ChannelChat_Loading_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Panel_Widget_ChannelChat_Loading()")
function FromClient_Panel_Widget_ChannelChat_Loading()
  PaGlobal_ChannelChat_Loading:initialize()
end
