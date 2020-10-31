PaGlobal_SkillGroup = {
  _panel = nil,
  _ui = {
    _rdo_groupBg = nil,
    _rdo_subGroupBg = nil,
    _stc_TopFuncBg = nil,
    _txt_skillPoint = nil,
    _selectLine = nil,
    _subSelectLine = nil,
    _stc_bottomArea = nil,
    _btn_allReset = nil,
    _btn_modify = nil,
    _btn_lockSpirit = nil,
    _btn_cooltimeSet = nil,
    _btn_movie = nil,
    _btn_question = nil,
    _edit_search = nil,
    _btn_search = nil,
    _focusEffect = nil
  },
  _tab = {},
  _subTab = {},
  _frame = {},
  _frameScroll = {},
  _skillGroupList = {},
  _skillLineList = {},
  _addSkillLineList = {},
  _baseSkillGroupControl = nil,
  _baseLineControl = {},
  _deepeningSkill = {frame = nil},
  _slotConfig = {createIcon = true},
  eTabIndex = {
    weapon = 0,
    succession = 1,
    awaken = 2,
    deepening = 3,
    count = 4
  },
  _skillCCTypeConfig = {
    iconPath = "combine/etc/combine_etc_skill_00.dds",
    uv = {
      [1] = {
        x1 = 272,
        y1 = 817,
        x2 = 292,
        y2 = 837
      },
      [2] = {
        x1 = 272,
        y1 = 838,
        x2 = 292,
        y2 = 858
      },
      [3] = {
        x1 = 272,
        y1 = 859,
        x2 = 292,
        y2 = 879
      },
      [4] = {
        x1 = 293,
        y1 = 817,
        x2 = 313,
        y2 = 837
      },
      [5] = {
        x1 = 293,
        y1 = 838,
        x2 = 313,
        y2 = 858
      },
      [6] = {
        x1 = 356,
        y1 = 817,
        x2 = 376,
        y2 = 837
      },
      [7] = {
        x1 = 314,
        y1 = 817,
        x2 = 334,
        y2 = 837
      },
      [8] = {
        x1 = 314,
        y1 = 838,
        x2 = 334,
        y2 = 858
      },
      [9] = {
        x1 = 356,
        y1 = 838,
        x2 = 376,
        y2 = 858
      },
      [10] = {
        x1 = 335,
        y1 = 817,
        x2 = 355,
        y2 = 837
      },
      [11] = {
        x1 = 335,
        y1 = 838,
        x2 = 355,
        y2 = 858
      },
      [12] = {
        x1 = 335,
        y1 = 859,
        x2 = 355,
        y2 = 879
      },
      [13] = {
        x1 = 356,
        y1 = 859,
        x2 = 376,
        y2 = 879
      },
      [14] = {
        x1 = 293,
        y1 = 859,
        x2 = 313,
        y2 = 879
      },
      [15] = {
        x1 = 314,
        y1 = 859,
        x2 = 334,
        y2 = 879
      },
      [16] = {
        x1 = 377,
        y1 = 817,
        x2 = 397,
        y2 = 837
      },
      [17] = {
        x1 = 377,
        y1 = 838,
        x2 = 397,
        y2 = 858
      }
    }
  },
  _baseFrameSizeY = 0,
  _recentSkill = {},
  _currentTab = 0,
  _currentSubTab = 0,
  _subTabControlCnt = 4,
  _subGroupSize = 1,
  _maxFrameCount = 4,
  _maxDeepeningSkillCount = 0,
  _mouseOnSkillGroupNo = -1,
  _selectSkillNo = 0,
  _selectKey = 0,
  _renderMode = nil,
  _isEditMode = false,
  _isLevelupEffect = false,
  _filterText = nil,
  _filterKeyList = {},
  _filterIndex = 0,
  _subGroupList = {},
  _hideDontUseTree = false,
  _isDialog = false,
  _isLoading = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_Tab_1.lua")
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_Tab_2.lua")
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_Tab_3.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SkillGroupInit")
function FromClient_SkillGroupInit()
  PaGlobal_SkillGroup:init()
end
