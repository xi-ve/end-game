PaGlobal_SA_Widget_ESCMenu = {
  _ui = {
    btn_close = nil,
    btn_inventory = nil,
    btn_option = nil,
    btn_exit = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_ESCMenu_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_ESCMenu_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_ESCMenu_Init")
function FromClient_SA_Widget_ESCMenu_Init()
  PaGlobal_SA_Widget_ESCMenu:initialize()
end
