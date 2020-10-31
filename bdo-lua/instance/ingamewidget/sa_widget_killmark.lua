PaGlobal_SA_Widget_KillMark = {
  _ui = {txt_killMessage = nil, stc_effectSlot = nil},
  _updateTime = 0,
  _durationTime = 3,
  _initialize = false
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_KillMark_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_KillMark_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_KillMarkInit")
function FromClient_SA_Widget_KillMarkInit()
  PaGlobal_SA_Widget_KillMark:initialize()
end
