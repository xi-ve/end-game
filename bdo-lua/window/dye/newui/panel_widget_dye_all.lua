PaGlobal_Dye_All = {
  _ui = {
    stc_TabAreaBG = nil,
    stc_SelectedTabLine = nil,
    stc_CurrentStepArea = nil,
    txt_CurrentStep = nil,
    stc_EquipmentArea = nil,
    rdo_EquipSlot_Templete = nil,
    stc_PartArea = nil,
    chk_SelectAllPart = nil,
    txt_SelectedAmple = nil,
    stc_AmpleArea = nil,
    stc_AmpleTabArea = nil,
    rdo_AmpleAll = nil,
    rdo_AmpleMine = nil,
    rdo_AmpleMrev = nil,
    stc_MaterialArea = nil,
    stc_AmpleSlotArea = nil,
    stc_AmpleSlotBG = nil,
    scroll_Ample = nil,
    stc_AmpleTemplete = nil,
    stc_BottomArea = nil,
    slider_Enduarance = nil
  },
  _ui_pc = {btn_Dye = nil},
  _ui_console = {
    stc_KeyGuideLB = nil,
    stc_KeyGuideRB = nil,
    stc_KeyGuideLT = nil,
    stc_KeyGuideRT = nil,
    stc_KeyGuideBG = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil,
    txt_KeyGuideX = nil,
    txt_KeyGuideY = nil
  },
  _renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_Dye
  }, false),
  _rdo_characterType = {},
  _equipSlot = {},
  _rdo_PartSelect = {},
  _btn_PartReset = {},
  _rdo_AmpleCategory = {},
  _rdo_Material = {},
  _ampleSlot = {},
  _chk_ShowToggle = {},
  _stc_ShowToggleIcon = {},
  _toggleCheckValue = {},
  _isChina = isGameTypeKR2(),
  _maxTargetType = 7,
  _maxEquipSlotCount = 18,
  _maxPartCount = 12,
  _maxMaterialCount = 8,
  _maxToggleCount = 8,
  _maxAmpuleRowsCount = 3,
  _maxAmpuleColsCount = 9,
  _maxPaletteSlotCount = 27,
  _enumToggleType = {
    Underwear = 0,
    Avatar = 1,
    FaceViewHair = 2,
    Helmet = 3,
    FaceGuard = 4,
    Cloak = 5,
    WarStance = 6,
    AwakenWeapon = 7
  },
  dyePartString = {
    [0] = {
      [0] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_MAINHAND"),
      [1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_SUBHAND"),
      [3] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CHARACTER_ARMOR"),
      [4] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_GLOVES"),
      [5] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_BOOTS"),
      [6] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_HELM"),
      [18] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_MAINHANDS"),
      [19] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_SUBHANDS"),
      [14] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_BODY"),
      [15] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HANDS"),
      [16] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_BOOTS"),
      [17] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HELM"),
      [20] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_UNDERWEAR"),
      [21] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CHARACTER_ACC_0"),
      [22] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CHARACTER_ACC_1"),
      [23] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CHARACTER_ACC_2"),
      [29] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_awakenWeapon"),
      [30] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_avatarAwakenWeapon")
    },
    {
      [3] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_BARD"),
      [4] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_SADDLE"),
      [5] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_STIRRUP"),
      [6] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HORSEHEAD"),
      [12] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_FOOT"),
      [14] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_ARMOR"),
      [15] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_SADDLE"),
      [16] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_STIRRUP"),
      [17] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_FACE")
    },
    {
      [3] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_BODY"),
      [4] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_TIRE"),
      [5] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_FLAG"),
      [6] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_INSIGNIA"),
      [13] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_LAMP"),
      [25] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_CORVER"),
      [14] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_AVATAR_BODY"),
      [15] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_AVATAR_TIRE"),
      [16] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_AVATAR_FLAG"),
      [17] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_AVATAR_INSIGNIA"),
      [26] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_AVATAR_CORVER")
    },
    {
      [3] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_BARD"),
      [4] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_STIRRUP"),
      [5] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_SADDLE"),
      [6] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HORSEHEAD"),
      [12] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_FOOT"),
      [14] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_ARMOR"),
      [15] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_STIRRUP"),
      [16] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_SADDLE"),
      [17] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_FACE")
    },
    {
      [3] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_BARD"),
      [4] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_STIRRUP"),
      [5] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_SADDLE"),
      [6] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HORSEHEAD"),
      [12] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_FOOT"),
      [14] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_ARMOR"),
      [15] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_STIRRUP"),
      [16] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_SADDLE"),
      [17] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_FACE")
    },
    {
      [3] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_BARD"),
      [4] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_STIRRUP"),
      [5] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_SADDLE"),
      [6] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HORSEHEAD"),
      [12] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_FOOT"),
      [14] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_ARMOR"),
      [15] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_STIRRUP"),
      [16] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_SADDLE"),
      [17] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_FACE")
    },
    {
      [3] = PAGetString(Defines.StringSheet_GAME, "LUA_DYERENEW_DYEPART_CAMPTENT_WAREHOUSE"),
      [4] = PAGetString(Defines.StringSheet_GAME, "LUA_DYERENEW_DYEPART_CAMPTENT_REPAIRSHOP"),
      [5] = PAGetString(Defines.StringSheet_GAME, "LUA_DYERENEW_DYEPART_CAMPTENT_SHOP"),
      [6] = PAGetString(Defines.StringSheet_GAME, "LUA_DYERENEW_DYEPART_CAMPTENT_TENT"),
      [14] = PAGetString(Defines.StringSheet_GAME, "LUA_DYERENEW_DYEPART_CAMPTENT_WAREHOUSE"),
      [15] = PAGetString(Defines.StringSheet_GAME, "LUA_DYERENEW_DYEPART_CAMPTENT_REPAIRSHOP"),
      [16] = PAGetString(Defines.StringSheet_GAME, "LUA_DYERENEW_DYEPART_CAMPTENT_SHOP"),
      [17] = PAGetString(Defines.StringSheet_GAME, "LUA_DYERENEW_DYEPART_CAMPTENT_TENT")
    }
  },
  _dyeTargetString = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_DYE_TARGET_CHARACTER"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_DYE_TARGET_HORSE"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_DYE_TARGET_CARRIAGE"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_DYE_TARGET_CAMEL"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_DYE_TARGET_TENT")
  },
  _enumCharacterType = {
    Character = 0,
    Horse = 1,
    Car = 2,
    Camel = 3,
    Ship = 4,
    Empty = 5,
    Tent = 6
  },
  _equipSlotIcon = {
    [0] = {
      {
        0,
        166,
        123,
        194,
        151
      },
      {
        1,
        197,
        123,
        225,
        151
      },
      {
        29,
        228,
        93,
        256,
        121
      },
      {
        3,
        42,
        123,
        70,
        151
      },
      {
        4,
        135,
        123,
        163,
        151
      },
      {
        5,
        104,
        123,
        132,
        151
      },
      {
        6,
        11,
        123,
        39,
        151
      },
      {
        18,
        166,
        154,
        194,
        182
      },
      {
        19,
        197,
        154,
        225,
        182
      },
      {
        30,
        259,
        93,
        287,
        121
      },
      {
        14,
        42,
        154,
        70,
        182
      },
      {
        15,
        135,
        154,
        163,
        182
      },
      {
        16,
        104,
        154,
        132,
        182
      },
      {
        17,
        11,
        154,
        39,
        182
      },
      {
        20,
        73,
        154,
        101,
        182
      },
      {
        21,
        228,
        123,
        256,
        151
      },
      {
        22,
        259,
        154,
        287,
        182
      },
      {
        23,
        228,
        154,
        256,
        182
      }
    },
    [1] = {
      {
        3,
        136,
        147,
        164,
        175
      },
      {
        4,
        198,
        147,
        226,
        175
      },
      {
        5,
        105,
        147,
        133,
        175
      },
      {
        6,
        74,
        147,
        102,
        175
      },
      {
        12,
        167,
        147,
        195,
        175
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        14,
        136,
        177,
        164,
        205
      },
      {
        15,
        198,
        177,
        226,
        205
      },
      {
        16,
        105,
        177,
        133,
        205
      },
      {
        17,
        74,
        177,
        102,
        205
      },
      {
        18,
        0,
        0,
        0,
        0
      },
      {
        19,
        0,
        0,
        0,
        0
      },
      {
        20,
        0,
        0,
        0,
        0
      }
    },
    [2] = {
      {
        3,
        0,
        0,
        0,
        0
      },
      {
        4,
        377,
        272,
        423,
        318
      },
      {
        5,
        283,
        366,
        329,
        412
      },
      {
        6,
        236,
        366,
        282,
        412
      },
      {
        13,
        424,
        366,
        470,
        412
      },
      {
        25,
        424,
        272,
        470,
        318
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        14,
        424,
        225,
        470,
        271
      },
      {
        15,
        377,
        225,
        423,
        271
      },
      {
        16,
        0,
        0,
        0,
        0
      },
      {
        17,
        0,
        0,
        0,
        0
      },
      {
        26,
        377,
        319,
        423,
        365
      },
      {
        20,
        0,
        0,
        0,
        0
      },
      {
        21,
        0,
        0,
        0,
        0
      }
    },
    [3] = {
      {
        3,
        136,
        147,
        164,
        175
      },
      {
        4,
        105,
        147,
        133,
        175
      },
      {
        5,
        198,
        147,
        226,
        175
      },
      {
        6,
        74,
        147,
        102,
        175
      },
      {
        12,
        167,
        147,
        195,
        175
      },
      {
        25,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        14,
        136,
        177,
        164,
        205
      },
      {
        15,
        105,
        177,
        133,
        205
      },
      {
        16,
        198,
        177,
        226,
        205
      },
      {
        17,
        74,
        177,
        102,
        205
      },
      {
        26,
        0,
        0,
        0,
        0
      },
      {
        20,
        0,
        0,
        0,
        0
      },
      {
        21,
        0,
        0,
        0,
        0
      }
    },
    [4] = {
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        14,
        301,
        30,
        329,
        58
      },
      {
        17,
        361,
        30,
        389,
        58
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      }
    },
    [5] = {
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      }
    },
    [6] = {
      {
        3,
        451,
        35,
        479,
        63
      },
      {
        4,
        451,
        6,
        479,
        34
      },
      {
        5,
        480,
        6,
        508,
        34
      },
      {
        6,
        480,
        35,
        508,
        63
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        14,
        0,
        0,
        0,
        0
      },
      {
        15,
        0,
        0,
        0,
        0
      },
      {
        16,
        0,
        0,
        0,
        0
      },
      {
        17,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0
      }
    }
  },
  _classType = -1,
  _selected_CharacterTarget = 0,
  _selected_EquipSlotNo = -1,
  _isPartClick = false,
  _nowClickPartId = 0,
  _nowClickPartSlotId = 0,
  _isPearlPalette = false,
  _paletteShowAll = false,
  _selected_AmpleCategory = 0,
  _nowPaletteCategoryIndex = 0,
  _nowPaletteDataIndex = 0,
  _scrollStartIndex = 0,
  _scrollMaxRow = 0,
  _enableDyePearl = ToClient_IsContentsGroupOpen("82"),
  _enableCamel = ToClient_IsContentsGroupOpen("4"),
  _enableAwaken = false,
  _enableTent = ToClient_IsContentsGroupOpen("253"),
  _enableShip = ToClient_IsContentsGroupOpen("461"),
  _partDyeInfo = {},
  _updateEquipForConsole = true,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Dye/NewUI/Panel_Widget_Dye_All_1.lua")
runLua("UI_Data/Script/Window/Dye/NewUI/Panel_Widget_Dye_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_Dye_All_Init")
function FromClient_PaGlobal_Dye_All_Init()
  PaGlobal_Dye_All:initialize()
end
