PaGlobal_SA_Widget_Respon_Time = {
  _ui = {
    stc_responBG = nil,
    txt_info = nil,
    txt_time = nil
  },
  _respawnTime = 300,
  _brStartTime = 0,
  _timer = 1,
  _lastUpdateTime = 0,
  _curTime = 0,
  _initialize = false
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Respon_Time_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Respon_Time_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_Respon_TimeInit")
function FromClient_SA_Widget_Respon_TimeInit()
  PaGlobal_SA_Widget_Respon_Time:initialize()
end
