PaGlobal_PetFusion_All = {
  _ui = {
    stc_FusionBG = nil,
    stc_LeaderPetIconBG = nil,
    stc_LeaderGradeLine = nil,
    stc_LeaderPetMarkBG = nil,
    stc_LeaderPetIcon = nil,
    txt_LeaderPetTier = nil,
    txt_LeaderPetLevel = nil,
    stc_PetIconBG_Templete = nil,
    stc_PetGradeLine_Templete = nil,
    stc_PetIcon_Templete = nil,
    txt_PetTier_Templete = nil,
    stc_PetPlusIcon_Templete = nil,
    stc_SelectDesc_BG = nil,
    txt_SelectTitle = nil,
    txt_SelectDesc = nil,
    stc_SelectBG = nil,
    stc_SelectLookIcon = nil,
    stc_QuestionMarkIcon = nil,
    txt_SelectedPetLevel = nil,
    txt_N1Title = nil,
    txt_N1Value = nil,
    progress_N1 = nil,
    txt_N2Title = nil,
    txt_N2Value = nil,
    progress_N2 = nil,
    edit_PetName = nil,
    txt_FusionDesc = nil,
    stc_FusionDoneBG = nil,
    txt_CompleteTierChange = nil,
    stc_Effect_Bottom = nil,
    stc_CompletePetIcon = nil,
    stc_Effect = nil,
    txt_CompletePetGrade = nil,
    txt_PetNameLevel = nil,
    txt_SpecialSkill = nil,
    stc_GradeLine = nil,
    stc_CompleteEffectBG = nil,
    txt_CompleteMessage = nil,
    stc_SelectLookBG = nil,
    list2_Look = nil,
    stc_SelectSkillBG = nil,
    list2_Skill = nil
  },
  _ui_pc = {
    btn_Close = nil,
    rdo_SelectLook = nil,
    rdo_SelectSkill = nil,
    btn_Yes = nil,
    btn_No = nil,
    btn_Compelte_Confirm = nil,
    btn_SelectLook_Close = nil,
    btn_SelectSkill_Close = nil
  },
  _ui_console = {
    stc_Bottom_KeyGuideBG = nil,
    txt_KeyGuideY = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil
  },
  _config = {
    _subPetMaxTableCount = 4,
    _skillSlotMaxCount = 3,
    _petMaxTableCount = 5,
    _defaultName = PAGetString(Defines.StringSheet_GAME, "PANEL_PETLIST_PETCOMPOSE_NAME"),
    _infoTextsizeGap = 0,
    _defaultPetNameCount = 10,
    _defaultPetName = {
      [0] = "Darcy",
      [1] = "Buddy",
      [2] = "Orbit",
      [3] = "Rushmore",
      [4] = "Carolina",
      [5] = "Cindy",
      [6] = "Waffles",
      [7] = "Sparky",
      [8] = "Bailey",
      [9] = "Wichita",
      [10] = "Buck"
    }
  },
  _gradeColorConfig = {
    [0] = Defines.Color.C_FFEFEFEF,
    [1] = Defines.Color.C_FFB5FF6D,
    [2] = Defines.Color.C_FF008AFF,
    [3] = Defines.Color.C_FFFFCE22
  },
  _tierProgressTextureConfig = {
    _texture = "Renewal/PcRemaster/Remaster_Pet_00.dds",
    [0] = {
      125,
      167,
      157,
      183
    },
    [1] = {
      125,
      184,
      157,
      200
    },
    [2] = {
      158,
      167,
      190,
      183
    },
    [3] = {
      125,
      218,
      157,
      234
    }
  },
  _tierEfectConfig = {
    [0] = "fUI_PetGlow_01A",
    [1] = "fUI_PetGlow_Success_02A_Green",
    [2] = "fUI_PetGlow_Success_02A_Blue",
    [3] = "fUI_PetGlow_Success_02A_Yellow"
  },
  _tierBottomEfectConfig = {
    [0] = "fUI_PetGlow_Bot",
    [1] = "fUI_PetGlow_Bot_Green",
    [2] = "fUI_PetGlow_Bot_Blue",
    [3] = "fUI_PetGlow_Bot_Yellow"
  },
  _completeTierTextureConfig = {
    _texture = "renewal/pcremaster/remaster_pet_00.dds",
    [0] = {
      157,
      102,
      189,
      134
    },
    [1] = {
      124,
      102,
      156,
      134
    },
    [2] = {
      157,
      69,
      189,
      101
    },
    [3] = {
      124,
      69,
      156,
      101
    }
  },
  _gradeStrConfig = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_PETCOMPOSE_SAME_GRADETYPE_CLASSIC_TITLE"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_PETCOMPOSE_SAME_GRADETYPE_LIMITED_TITLE"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_PETCOMPOSE_SAME_GRADETYPE_PREMIUM_TITLE"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_PETCOMPOSE_SAME_GRADETYPE_EVENT_TITLE"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_PETCOMPOSE_SAME_GRADETYPE_SPECIAL_TITLE"),
    [5] = "",
    [6] = "",
    [7] = "",
    [8] = "",
    [9] = ""
  },
  _mainPetSlotTable = {},
  _subPetSlotTableList = {},
  _skillSlotList = {},
  _skillRandomSlotList = {},
  _completeSkillTableList = {},
  _staticText_SelectSkillDesc = {},
  _selectSkillList = {},
  _petNoList = {},
  _sealPetIndexList = {},
  _isFourTier = false,
  _mainPetTier = -1,
  _mainRace = nil,
  _mainIsJokerPetUse = false,
  _currentSkillIndex = -1,
  _currentLookIndex = 0,
  _isFusionAble = false,
  _lookDataTableList = {},
  _skillDataTableList = {},
  _completeDataTable = {},
  _currentRate = 0,
  _isFusion = false,
  _completeDelayTime = 0,
  _isFusionStart = false,
  _fusionStartDelayTime = 0,
  _isComplete = false,
  _petName = nil,
  _isConsole = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetFusion_All_1.lua")
runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetFusion_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PetFusion_All_Init")
function FromClient_PetFusion_All_Init()
  PaGlobal_PetFusion_All:initialize()
end
