PaGlobal_ThornCastle_DeadMessage = {
  _ui = {
    _deadBG = nil,
    _dangerBG = nil,
    _centerBG = nil,
    _deadText = nil,
    _remainTimeText = nil,
    _noticeText = nil,
    _tipText = nil,
    _btnBG = nil,
    _btnSelectButtonCconsole = nil,
    _reviveBtn = {}
  },
  _aniType = {_changeColor = 0, _changeScale = 1},
  _initialize = false,
  _reviveCoolTime = 0,
  _reviveReqTime = 0,
  _isConsole = false
}
runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_DeadMessage_1.lua")
runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_DeadMessage_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ThornCastle_DeadMessageInit")
function FromClient_ThornCastle_DeadMessageInit()
  PaGlobal_ThornCastle_DeadMessage:initialize()
end
