PaGlobal_House_InstallationMode_ObjectControl_All = {
  _eButtonType = {
    confirm = 0,
    move = 1,
    rotateLeft = 2,
    rotateRight = 3,
    delete = 4,
    exit = 5,
    loopCount = 5
  },
  _ui = {
    _stc_background = nil,
    _btn_control = {},
    _txt_detailGuide = nil,
    _btn_closeDesc = nil
  },
  _typeIsHavest = false,
  _isConfirmStep = false,
  _startPosX = 0,
  _defaultGuideSizeX = nil,
  _defaultGuideSizeY = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_ObjectControl_All_1.lua")
runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_ObjectControl_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_House_InstallationMode_ObjectControl_All_Init")
function FromClient_House_InstallationMode_ObjectControl_All_Init()
  PaGlobal_House_InstallationMode_ObjectControl_All:initialize()
end
