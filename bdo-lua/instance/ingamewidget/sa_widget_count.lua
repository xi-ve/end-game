PaGlobal_SA_Widget_Count = {
  _ui = {
    stc_count = {}
  },
  _initialize = false,
  _currentCount = 10,
  _updateCurrentTime = 1
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Count_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Count_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_Count_Init")
function FromClient_SA_Widget_Count_Init()
  PaGlobal_SA_Widget_Count:initialize()
end
