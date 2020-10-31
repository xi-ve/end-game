PaGlobal_LocalWarInfo_All_New = {
  _ui = {
    _stc_titleBG = nil,
    _stc_leftBG = nil,
    _stc_picTooltip = nil,
    _list2_serverList = nil,
    _frame_desc = nil,
    _tree_mapList = nil,
    _stc_mapListContent = Array.new(),
    _rule = {
      _txt_title = nil,
      _stc_background = nil,
      _txt_content = {}
    },
    _reward = {
      _txt_title = nil,
      _stc_background = nil,
      _txt_content = {}
    },
    _explanation = {
      _txt_title = nil,
      _stc_background = nil,
      _txt_content = {}
    }
  },
  _ui_pc = {_btn_close = nil, _btn_help = nil},
  _ui_console = {
    _stc_keyguideBG = nil,
    _stc_keyguideA = nil,
    _stc_keyguideB = nil,
    _stc_keyguideY = nil
  },
  _posConfig = {
    _listStartPosY = 5,
    _iconStartPosY = 88,
    _listPosYGap = 45
  },
  _eMapKeyIndex = {
    _NORMAL = 0,
    _GAMOSNEST = 10,
    _SEASONNORMAL = 11,
    _SEASONGAMOSE = 12
  },
  _mapList = {
    _NORMAL = Array.new(),
    _GAMOSNEST = Array.new(),
    _COUNT = 2
  },
  _treeMapTable = Array.new(),
  _roomTitle = Array.new(),
  _maxRoomTitleCount = 0,
  _tempRoomTitleIndex = 4,
  _openDesc = -1,
  _maxRuleSize = 40,
  _ruleCount = 9,
  _maxRewardSize = 20,
  _rewardCount = 2,
  _maxExplanationSize = 30,
  _explanationCount = 3,
  _localWarServerCountLimit = 0,
  _rule_ani_SpeedTime = 5,
  _isGrouthLocalWar = ToClient_IsContentsGroupOpen("338"),
  _isConsole = _ContentsGroup_UsePadSnapping,
  _initialize = false
}
runLua("UI_Data/Script/Window/LocalWar/Panel_LocalWarInfo_All_New_1.lua")
runLua("UI_Data/Script/Window/LocalWar/Panel_LocalWarInfo_All_New_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_LocalWarInfo_All_New_Init")
function FromClient_luaLoadComplete_LocalWarInfo_All_New_Init()
  PaGlobal_LocalWarInfo_All_New:initialize()
end
