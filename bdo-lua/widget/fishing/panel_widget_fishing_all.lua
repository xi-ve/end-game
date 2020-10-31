PaGlobal_Fishing_All = {
  _ui = {
    _stc_fishIcon_title = nil,
    _txt_purpose = nil,
    _stc_fishBg = nil,
    _txt_fishPercent = nil,
    _stc_spaceImage = nil,
    _stc_keyguideA = nil,
    _btn_spread = nil,
    _stc_help = nil,
    _stc_consoleKey_LT = nil,
    _stc_abdPreventionBg = nil,
    _chk_abdPrevention = nil,
    _stc_abdKeyGuide = nil,
    _stc_dropTrashBg = nil,
    _txt_dropTrashDesc = nil,
    _chk_fishGradeTemplate = nil,
    _chk_fishGradeList = {},
    _stc_gradeColorList = {},
    _stc_gradeSelectList = {},
    _stc_gradeNoSetList = {}
  },
  _eGradeList = {
    _none = 0,
    _normal = 1,
    _magic = 2,
    _rare = 3,
    _unique = 4,
    _count = 5
  },
  _gradeColor = {
    [0] = 4278190080,
    [1] = 4292927712,
    [2] = 4286817603,
    [3] = 4282947792,
    [4] = 4294294074
  },
  _gameOptionActionKey = {
    Forward = 0,
    Back = 1,
    Left = 2,
    Right = 3,
    Attack = 4,
    SubAttack = 5,
    Dash = 6,
    Jump = 7
  },
  _stateValue = {
    _isFishing_Start = true,
    _isFishing_0 = true,
    _isFishing_1 = true,
    _isFishing_2 = true,
    _isJaksal_0 = true,
    _isJaksal_1 = true,
    _isJaksal_2 = true,
    _isJaksal_3 = true,
    _isJaksal_4 = true,
    _isJaksal_5 = true
  },
  _isConsole = false,
  _isFishingStart = false,
  _isJaksal = false,
  _gradeString = {},
  _helpText = "",
  _isViewData = {_abdPreventionBg = false, _helpTooltip = false},
  _currentSelectGrade = 0,
  _defaultPurposeSizeY = 0,
  _isSpreading = true,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Fishing/Panel_Widget_Fishing_All_1.lua")
runLua("UI_Data/Script/Widget/Fishing/Panel_Widget_Fishing_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Fishing_All_Init")
function FromClient_Fishing_All_Init()
  PaGlobal_Fishing_All:initialize()
end
