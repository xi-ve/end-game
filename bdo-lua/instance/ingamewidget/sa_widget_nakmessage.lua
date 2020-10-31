PaGlobal_SA_NakMessage = {
  _ui = {
    stc_messageBg = nil,
    stc_messageIcon = nil,
    txt_message = nil
  },
  _initialize = false,
  _default = {
    sizeX = nil,
    sizeY = nil,
    posX = nil,
    posY = nil
  },
  _targetPosX = nil,
  _targetPosY = nil,
  _defaultSpanX = 0,
  _defaultSpanY = 120,
  _curIndex = 0,
  _processIndex = 0,
  _animationEndTime = 2.3,
  _elapsedTime = 2.3,
  _tempMsg = nil,
  _posSet = false,
  _messageData = {}
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_NakMessage_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_NakMessage_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_NakMessageInit")
function FromClient_SA_NakMessageInit()
  PaGlobal_SA_NakMessage:initialize()
end
