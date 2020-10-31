PaGlobal_House_Installation_All = {
  _eInstallType = {housing = 0, seed = 1},
  _eRadioType = {
    firstFloor = 0,
    secondFloor = 1,
    thirdFloor = 2,
    fourFloor = 3,
    loopCount = 3
  },
  _eButtonType = {
    rotationLeft = 0,
    rotationRight = 1,
    rotateAngle = 2
  },
  _eModeState = {
    none = 0,
    translation = 1,
    detail = 2,
    watingConfirm = 3,
    count = 4
  },
  _ui = {
    _stc_titleGroup = nil,
    _txt_title = nil,
    _rdo_floors = {},
    _txt_pointBaseValue = nil,
    _txt_pointOptionValue = nil,
    _txt_pointBonusValue = nil,
    _txt_pointTotalValue = nil,
    _txt_interiorSensePoint = nil,
    _stc_consoleMove = nil,
    _stc_bottomGroup = nil,
    _btn_rotation = {},
    _chk_rotateAngle = nil,
    _stc_titleGroupFarm = nil,
    _txt_titleFarm = nil,
    _txt_useFarmInfo = nil,
    _stc_consoleKeyBG = nil,
    _keyGuide = {
      _txt_RS_click = nil,
      _txt_RS_updown = nil,
      _txt_RS_leftright = nil,
      _txt_RS = nil,
      _txt_LS = nil,
      _txt_LB_RB = nil,
      _txt_LT_RT = nil,
      _txt_Y = nil,
      _txt_X = nil,
      _txt_A = nil,
      _txt_B = nil
    }
  },
  _keyGuideString = {build = nil, install = nil},
  _value = {
    isConfirm = false,
    isCanMove = false,
    isCanDelete = false,
    isCanCancel = false
  },
  _eInstallMode = 0,
  _isInstallMode = false,
  _renderMode = nil,
  _isConsole = false,
  _eState = 0,
  _screenGapSize = {x = 0, y = 0},
  _initialize = false
}
runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_All_1.lua")
runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_House_Installation_All_Init")
function FromClient_House_Installation_All_Init()
  PaGlobal_House_Installation_All:initialize()
end
