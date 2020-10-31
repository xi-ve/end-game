PaGlobal_MiniGame_Find_All = {
  _ui = {
    _template = {
      _stc_openSlot = nil,
      _stc_closeSlot = nil,
      _stc_rewardSlot = nil
    },
    _btn_close = nil,
    _frame_desc = nil,
    _txt_grade = nil,
    _stc_grade = {
      [1] = nil,
      [2] = nil,
      [3] = nil,
      [4] = nil,
      [5] = nil
    },
    _txt_endurance = nil,
    _txt_RClickCnt = nil,
    _stc_emptyIcon = nil,
    _txt_emptyCnt = nil,
    _stc_subObjIcon = nil,
    _txt_subObjCnt = nil,
    _stc_trapIcon = nil,
    _txt_trapCnt = nil,
    _progress_damage = nil,
    _stc_rewardFocus = nil,
    _txt_commercial = nil,
    _stc_flower = nil,
    _stc_maskBG = nil,
    _stc_bubbleBG = nil,
    _txt_bubbleChat = nil,
    _stc_blackSpirit = nil,
    _tutorial = {
      [1] = {
        _stc_BG = nil,
        _stc_maskingBG = nil,
        _stc_focusBox = nil
      },
      [2] = {
        _stc_BG = nil,
        _stc_maskingBG = nil,
        _stc_focusBox = nil
      },
      [3] = {
        _stc_BG = nil,
        _stc_maskingBG = nil,
        _stc_focusBox = nil
      }
    },
    _stc_startMsg = nil,
    _stc_timerMsg = nil
  },
  _ui_pc = {
    _btn_close = nil,
    _stc_mouseLDesc = nil,
    _stc_mouseRDesc = nil,
    _stc_startMsg_PCKey = nil
  },
  _ui_console = {
    _stc_KeyGuide = nil,
    _stc_Key_Scroll = nil,
    _stc_Key_Reward = nil,
    _stc_Key_DeepDig = nil,
    _stc_Key_ShallowDig = nil,
    _stc_Key_Exit = nil,
    _stc_startMsg_ConsoleKey = nil
  },
  _keyGuideList = {},
  _config = {
    _slotCols = 16,
    _slotRows = 16,
    _totalSlotSize = 576,
    _slotStartPosX = 13,
    _slotStartPosY = 65,
    _rewardMaxCount = 6,
    _nextGameSec = 3,
    _endGameSec = 5,
    _slotTypeDefault = 0,
    _slotTypeEmpty = 1,
    _slotTypeMain = 2,
    _slotTypeSub = 3,
    _slotTypeTrap = 5
  },
  _clickType = {LClcik = 1, RClcik = 2},
  _state = {
    None = 0,
    Play = 1,
    Wait = 2,
    Reward = 3
  },
  _tutorialCount = 3,
  _rewardSlotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true
  },
  _slots = Array.new(),
  _rewardSlot = Array.new(),
  _damageSlot = Array.new(),
  _gameState = nil,
  _readyToEndGame = false,
  _readyToNextGame = false,
  _curSec = 0,
  _gameMaxDepth = 5,
  _gameCurDepth = 0,
  _gameLastDepth = 0,
  _curRClickCount = 0,
  _tmpRClickCount = 0,
  _curPecent = 0,
  _curEmptyCnt = 0,
  _curSubObjCnt = 0,
  _curTrapCnt = 0,
  _rewardIndex = 0,
  _mainColCnt = 0,
  _mainRowCnt = 0,
  _addSize = 16,
  _curSlotSize = 0,
  _stateMsgKey = 0,
  _tutorialOpen = 0,
  _tutorialTime = 0,
  _tutorialIndex = -1,
  _tutorialEffectShow = false,
  _miniGameResult_OriginSizeX = nil,
  _alphaDirChange = false,
  _alphaValue = 0,
  _gradeMouseArea_SizeX = 0,
  _gradeMouseL_DescSizeX = 0,
  _gradeMouseR_DescSizeX = 0,
  _isConsole = _ContentsGroup_UsePadSnapping,
  _initialize = false,
  _isMainLoad = false
}
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Find_All_1.lua")
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Find_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MiniGame_Find_All_Init")
function FromClient_MiniGame_Find_All_Init()
  PaGlobal_MiniGame_Find_All:initialize()
end
