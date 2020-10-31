PaGlobal_GameExit_All = {
  _eType = {_basic = 0, _all = 1},
  _eExitMode = {
    _non = -1,
    _gameExit = 0,
    _backCharacter = 1,
    _swapCharacter = 2
  },
  _ui = {
    _pc = {
      _btn_close = nil,
      _btn_qeustion = nil,
      _btn_tray = nil,
      _chk_listToggle = nil,
      _btn_leftArrow = nil,
      _btn_rightArrow = nil
    },
    _console = {
      _btn_LB = nil,
      _btn_RB = nil,
      _btn_changeAccount = nil,
      _stc_keyGuideBg = nil
    },
    _stc_block = nil,
    _stc_mainBg = nil,
    _stc_bottomBg = nil,
    _stc_functionGroup = nil,
    _btn_gameExit = nil,
    _btn_serverChange = nil,
    _btn_selectCharacter = nil,
    _stc_connectedCharLine = nil,
    _copyUICharacterSlot = {
      _stc_characterSlot = nil,
      _stc_picture = nil,
      _stc_charSlotShadow = nil,
      _stc_charSlotUnderLine = nil,
      _txt_level = nil,
      _txt_name = nil,
      _txt_location = nil,
      _txt_enchantFailCount = nil,
      _txt_energy = nil,
      _txt_changePicture_console = nil,
      _txt_contidion = nil,
      _txt_remindTime = nil,
      _btn_change_pc = nil,
      _btn_takePicture_pc = nil,
      _stc_photoIcon = nil,
      _btn_move_pc = nil,
      _btn_inven_pc = nil,
      _stc_invenIcon = nil,
      _txt_servantIcon = nil,
      _stc_seasonIcon = nil
    },
    _stc_questIcon = nil,
    _txt_questTitle = nil,
    _txt_questList = nil,
    _txt_questList2 = nil,
    _stc_logIcon = nil,
    _txt_logTitle = nil,
    _frame_todayMyChallenge = nil,
    _frame_contents = nil,
    _scroll_frame = nil,
    _txt_frameContents = nil,
    _stc_allCharList = nil,
    _stc_charInfo = nil,
    _charInfo = {
      _stc_classMarkIcon = nil,
      _txt_level = nil,
      _txt_name = nil,
      _txt_location = nil,
      _txt_contidion = nil,
      _txt_remindTime = nil,
      _btn_takePicture_pc = nil,
      _btn_move_pc = nil,
      _btn_inven_pc = nil,
      _btn_change_pc = nil
    },
    _stc_charList = nil,
    _charList = {
      _stc_characterSlot = nil,
      _stc_picture = nil,
      _stc_charSlotShadow = nil,
      _txt_enchantFailCount = nil,
      _txt_energy = nil,
      _txt_servantIcon = nil,
      _stc_emptyIcon = nil
    },
    _stc_connectedCharList = nil,
    _stc_selectImage = nil,
    _tray = {
      _txt_title = nil,
      _btn_confirm = nil,
      _btn_cancel = nil,
      _chk_tray = nil,
      _txt_trayString = nil,
      _txt_contentsString = nil
    }
  },
  _basic = {
    _stc_characterSlotPool = {},
    _stc_picturePool = {},
    _stc_charSlotShowPool = {},
    _stc_charSlotUnderLinePool = {},
    _txt_levelPool = {},
    _txt_namePool = {},
    _txt_locationPool = {},
    _txt_enchantFailCountPool = {},
    _txt_energyPool = {},
    _txt_changePicture_consolePool = {},
    _txt_contidionPool = {},
    _txt_remindTimePool = {},
    _btn_change_pcPool = {},
    _btn_takePicture_pcPool = {},
    _btn_move_pcPool = {},
    _btn_invenPool = {},
    _txt_servantIconPool = {},
    _stc_classIconPool = {},
    _stc_seasonIconPool = {}
  },
  _all = {
    _stc_characterSlotPool = {},
    _stc_picturePool = {},
    _stc_charSlotShowPool = {},
    _txt_enchantFailCountPool = {},
    _txt_energyPool = {},
    _txt_servantIconPool = {},
    _stc_emptyIconPool = {},
    _stc_seasonIconPool = {}
  },
  _totalCharacterSlot = 4,
  _prevUIMode = 0,
  _exitMode = -1,
  _isExitPhoto = false,
  _exit_Time = 0,
  _prevTime = 0,
  _isConsole = _ContentsGroup_UsePadSnapping,
  _eServantView = {
    vehicle = CppEnums.ServantType.Type_Vehicle,
    ship = CppEnums.ServantType.Type_Ship,
    max = 1
  },
  _servantTextureUV = {
    [CppEnums.ServantType.Type_Vehicle] = {
      x1 = 375,
      y1 = 142,
      x2 = 405,
      y2 = 172
    },
    [CppEnums.ServantType.Type_Ship] = {
      x1 = 406,
      y1 = 142,
      x2 = 436,
      y2 = 172
    }
  },
  _servantOverTextureUV = {
    [CppEnums.ServantType.Type_Vehicle] = {
      x1 = 375,
      y1 = 173,
      x2 = 405,
      y2 = 203
    },
    [CppEnums.ServantType.Type_Ship] = {
      x1 = 406,
      y1 = 173,
      x2 = 436,
      y2 = 203
    }
  },
  _servantClickTextureUV = {
    [CppEnums.ServantType.Type_Vehicle] = {
      x1 = 375,
      y1 = 204,
      x2 = 405,
      y2 = 234
    },
    [CppEnums.ServantType.Type_Ship] = {
      x1 = 406,
      y1 = 204,
      x2 = 436,
      y2 = 234
    }
  },
  _photoIndex = 0,
  _prevClickIndex = 0,
  _changeIndex = 0,
  _nowPlayCharaterSlotNo = nil,
  _nowSnapSlotNo = nil,
  _eViewType = 0,
  _panelSizeY = 0,
  _GroupSpanSizeY = 0,
  _config = {
    slotCols = 7,
    slotRows = 3,
    slotStartX = 10,
    slotStartY = 10,
    slotSizeX = 0,
    slotSizeY = 0,
    slotGapX = 5,
    slotGapY = 5
  },
  _isValksContensOption = false,
  _selectCharacterIdx = -1,
  _startScrollPos = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/GameExit/Panel_Window_GameExit_All_1.lua")
runLua("UI_Data/Script/Window/GameExit/Panel_Window_GameExit_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GameExit_All_Init")
function FromClient_GameExit_All_Init()
  PaGlobal_GameExit_All:initialize()
end
