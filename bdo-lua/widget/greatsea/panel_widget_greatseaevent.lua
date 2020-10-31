PaGlobal_GreatSeaEvent = {
  _ui = {
    _progressBar = nil,
    _resultBackGround = nil,
    _txt_seafaringMainDesc = nil,
    _txt_seafaringSubDesc = nil
  },
  _updateCurrentTime = 0,
  _updateCompleteTime = 3,
  _regionKey = 0,
  _isSearch = false,
  _currentSeafaringTime = 0,
  _completeSeafaringTime = 5
}
function FromClient_GreatSeaEventInit()
  local self = PaGlobal_GreatSeaEvent
  self:init()
end
runLua("UI_Data/Script/Widget/GreatSea/Panel_Widget_GreatSeaEvent_1.lua")
runLua("UI_Data/Script/Widget/GreatSea/Panel_Widget_GreatSeaEvent_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GreatSeaEventInit")
