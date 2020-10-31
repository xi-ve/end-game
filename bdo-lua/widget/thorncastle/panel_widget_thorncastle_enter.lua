PaGlobal_ThornCastle_Enter = {
  _ui = {
    _joinMessageBox = {_confirmBtn = nil, _cancelBtn = nil},
    _matchingBox = {_cancelBtn = nil}
  },
  _initialize = false
}
runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_Enter_1.lua")
runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_Enter_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ThornCastle_EnterInit")
function FromClient_ThornCastle_EnterInit()
  PaGlobal_ThornCastle_Enter:initialize()
end
