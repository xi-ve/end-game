PaGlobal_SA_Widget_Respon_Message = {
  _ui = {
    stc_responMessage = nil,
    stc_icon = nil,
    txt_message = nil
  },
  _initialize = false,
  _respawnTime = 10,
  _updateCurrentTime = 1
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Respon_Message_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Respon_Message_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_Respon_Message_Init")
function FromClient_SA_Widget_Respon_Message_Init()
  PaGlobal_SA_Widget_Respon_Message:initialize()
end
