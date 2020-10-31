PaGlobal_Manufacture_All = {
  _ui = {
    stc_titleBG = nil,
    btn_question = nil,
    btn_close = nil,
    stc_radioButtonGroup = nil,
    stc_decoLine = nil,
    stc_selectLine = nil,
    stc_keyguideLB = nil,
    stc_keyguideRB = nil,
    stc_circle = nil,
    txt_lifeStatTitle = nil,
    txt_lifeStatValue = nil,
    stc_leftBG = nil,
    chk_identicalItem = nil,
    txt_manufactureName = nil,
    btn_craftingNote = nil,
    btn_manufacture = nil,
    btn_massManufacture = nil,
    stc_listBG = nil,
    txt_knowledgeCount = nil,
    list2_knowledgeList = nil,
    txt_noList = nil,
    stc_knowledgeDetailBG = nil,
    frame_knowledgeDesc = nil,
    txt_knowledgeDesc = nil,
    scroll_vertical = nil,
    _pointList = {},
    _slotList = {}
  },
  SLOT_POSITION = {
    [0] = {
      [0] = {114, -11}
    },
    [1] = {
      [0] = {-16, 111},
      [1] = {244, 111}
    },
    [2] = {
      [0] = {114, -11},
      [1] = {-6, 160},
      [2] = {234, 160}
    },
    [3] = {
      [0] = {24, 25},
      [1] = {204, 25},
      [2] = {24, 207},
      [3] = {204, 207}
    },
    [4] = {
      [0] = {114, -11},
      [1] = {-6, 80},
      [2] = {234, 80},
      [3] = {34, 212},
      [4] = {194, 212}
    }
  },
  _slotConfig = {
    createIcon = true,
    createBorder = false,
    createCount = true,
    createCash = true
  },
  MANUFACTURE_INFO = {
    [0] = {
      slotCount = 2,
      name = PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_SHAKE"),
      desc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC2_SHAKE"),
      mentalThemeKey = 30200,
      actionName = "MANUFACTURE_SHAKE",
      tooltipDesc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC_SHAKE")
    },
    [1] = {
      slotCount = 2,
      name = PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_GRIND"),
      desc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC2_GRIND"),
      mentalThemeKey = 30500,
      actionName = "MANUFACTURE_GRIND",
      tooltipDesc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC_GRIND")
    },
    [2] = {
      slotCount = 3,
      name = PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_WOODSPLITTING"),
      desc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC2_FIREWOOD"),
      mentalThemeKey = 30700,
      actionName = "MANUFACTURE_FIREWOOD",
      tooltipDesc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC_FIREWOOD")
    },
    [3] = {
      slotCount = 1,
      name = PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_DRY"),
      desc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC2_DRY"),
      mentalThemeKey = 30300,
      actionName = "MANUFACTURE_DRY",
      tooltipDesc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC_DRY")
    },
    [4] = {
      slotCount = 1,
      name = PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_THINNING"),
      desc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC2_THINNING"),
      mentalThemeKey = 30400,
      actionName = "MANUFACTURE_THINNING",
      tooltipDesc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC_THINNING")
    },
    [5] = {
      slotCount = 2,
      name = PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_HEATING"),
      desc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC2_HEAT"),
      mentalThemeKey = 30600,
      actionName = "MANUFACTURE_HEAT",
      tooltipDesc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC_HEAT")
    },
    [6] = {
      slotCount = 1,
      name = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_RAINWATER"),
      desc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC2_RAINWATER"),
      mentalThemeKey = 30800,
      actionName = "MANUFACTURE_RAINWATER",
      tooltipDesc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC_RAINWATER")
    },
    [7] = {
      slotCount = 1,
      name = PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_REPAIR"),
      desc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC2_REPAIR"),
      mentalThemeKey = nil,
      actionName = "REPAIR_ITEM",
      tooltipDesc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC_REPAIR")
    },
    [8] = {
      slotCount = 5,
      name = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_MANUFACTURE_ALCHEMY"),
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAME_MANUFACTURE_DESC2_ALCHEMY"),
      mentalThemeKey = 31009,
      actionName = "MANUFACTURE_ALCHEMY",
      tooltipDesc = PAGetString(Defines.StringSheet_GAME, "LUA_GAME_MANUFACTURE_DESC_ALCHEMY")
    },
    [9] = {
      slotCount = 3,
      name = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_MANUFACTURE_COOK"),
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAME_MANUFACTURE_DESC2_COOK"),
      mentalThemeKey = 30109,
      actionName = "MANUFACTURE_COOK",
      tooltipDesc = PAGetString(Defines.StringSheet_GAME, "LUA_GAME_MANUFACTURE_DESC_COOK")
    },
    [10] = {
      slotCount = 3,
      name = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_MANUFACTURE_ROYALGIFT_COOK"),
      desc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC_ROYALGIFT_COOK"),
      mentalThemeKey = 30110,
      actionName = "MANUFACTURE_ROYALGIFT_COOK",
      tooltipDesc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC_ROYALGIFT_COOK")
    },
    [11] = {
      slotCount = 3,
      name = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_MANUFACTURE_ROYALGIFT_ALCHEMY"),
      desc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC_ROYALGIFT_ALCHEMY"),
      mentalThemeKey = 31012,
      actionName = "MANUFACTURE_ROYALGIFT_ALCHEMY",
      tooltipDesc = PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_DESC_ROYALGIFT_ALCHEMY")
    },
    [12] = {
      slotCount = 5,
      name = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_GUILDMANURACTURE_NAME"),
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_GUILDMANUFACTURE_DESC"),
      mentalThemeKey = 31013,
      actionName = "MANUFACTURE_GUILD",
      tooltipDesc = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_GUILDMANUFACTURE_SUBDESC")
    },
    [13] = {
      slotCount = 5,
      name = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_CRAFT_NAME"),
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_CRAFT_DESC"),
      mentalThemeKey = 30800,
      actionName = "MANUFACTURE_CRAFT",
      tooltipDesc = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_CRAFT_SUBDESC")
    }
  },
  INSTALLATIONTYPE_ACTIONNAME = {
    [CppEnums.InstallationType.eType_Mortar] = "MANUFACTURE_GRIND",
    [CppEnums.InstallationType.eType_Stump] = "MANUFACTURE_FIREWOOD",
    [CppEnums.InstallationType.eType_FireBowl] = "MANUFACTURE_HEAT",
    [CppEnums.InstallationType.eType_Anvil] = "REPAIR_ITEM"
  },
  MANUFACTURE_TYPE = {
    SHAKE = 0,
    GRIND = 1,
    FIREWOOD = 2,
    DRY = 3,
    THINNING = 4,
    HEAT = 5,
    RAINWATER = 6,
    REPAIRITEM = 7,
    ALCHEMY = 8,
    COOK = 9,
    RGCOOK = 10,
    RGALCHEMY = 11,
    GUILDMANUFACTURE = 12,
    CRAFT = 13
  },
  _listAction = {},
  _manufactureMaxCount = 14,
  _maxActionBtn = 0,
  _slotMaxCount = 5,
  _usingSlotCount = 0,
  _actionIndex = -1,
  _selectIndex = -1,
  _usingInstallationType = 0,
  _startKnowledgeIndex = 0,
  _isMassManufacture = false,
  _invenShow = false,
  _isFromWarehouse = false,
  _canRepeat = false,
  _isEnableBtn = {},
  _noneStackItemList = {},
  _noneStackItemCheck = false,
  _hasNoneStackItem = false,
  _selectedWarehouseItemKey = -1,
  _selectedWarehouseItemSlotNo = -1,
  _targetWarehouseSlotNo = -1,
  _waypointKey_ByWareHouse = 0,
  _currentRepeatItemKey = nil,
  _defaultSlotNo = 255,
  _materialItemWhereType = CppEnums.ItemWhereType.eInventory,
  _materialSlotNoList = {
    [0] = 255,
    255,
    255,
    255,
    255
  },
  _materialSlotNoListItemIn = {
    [0] = false,
    false,
    false,
    false,
    false
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Alchemy/Panel_Window_Manufacture_All_1.lua")
runLua("UI_Data/Script/Window/Alchemy/Panel_Window_Manufacture_All_2.lua")
runLua("UI_Data/Script/Window/Alchemy/Panel_Window_Manufacture_All_3.lua")
runLua("UI_Data/Script/Window/Alchemy/Panel_Window_Manufacture_All_4.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Manufacture_All_Init")
function FromClient_Manufacture_All_Init()
  PaGlobal_Manufacture_All:initialize()
end
