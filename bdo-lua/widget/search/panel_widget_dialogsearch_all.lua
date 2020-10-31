PaGlobal_DialogSearch_All = {
  _ui = {
    _txt_title = nil,
    _plus = {},
    _up = {},
    _minus = {},
    _left = {},
    _down = {},
    _right = {},
    _stc_bottomBg = nil,
    _txt_bottomDesc = nil
  },
  _variable = {
    isShow = false,
    directionIndex = 0,
    currentNpcCharacterKey = 0
  },
  _searchClearQuest = {},
  _isSearchMode = false,
  _isShowSearchObject = false,
  _additionYaw = 0,
  _additionPitch = 0,
  _yawValue = 0.02,
  _ptichValue = 0.02,
  _moveCameraDistance = 1000,
  _findCameraDistance = 0,
  _findCameraAngle = 0,
  _moveAbleAngleUp = 60,
  _moveAbleAngleDown = -40,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Search/Panel_Widget_DialogSearch_All_1.lua")
runLua("UI_Data/Script/Widget/Search/Panel_Widget_DialogSearch_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_DialogSearch_All_Init")
function FromClient_DialogSearch_All_Init()
  PaGlobal_DialogSearch_All:initialize()
end
