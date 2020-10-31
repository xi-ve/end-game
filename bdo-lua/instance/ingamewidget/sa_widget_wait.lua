PaGlobal_SA_Widget_Wait = {
  _ui = {
    txt_wait_value1 = nil,
    txt_wait_value2 = nil,
    txt_wait_value = nil
  },
  _initialize = false,
  _maxPlayerCnt = 0,
  _beforeCnt = 50
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Wait_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Wait_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_WaitInit")
function FromClient_SA_Widget_WaitInit()
  PaGlobal_SA_Widget_Wait:initialize()
end
