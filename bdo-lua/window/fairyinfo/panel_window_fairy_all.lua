PaGlobal_FairyRegister_All = {
  _ui = {
    stc_TitleBG = nil,
    stc_RegisterBG = nil,
    stc_IconBack = nil,
    txt_StaticIconText = nil,
    stc_NamingPolicyBG = nil,
    txt_NamingPolicyDesc = nil,
    stc_CenterBG = nil,
    edit_Name = nil,
    stc_PetIconBG = nil,
    stc_PetIcon = nil,
    txt_Desc = nil,
    stc_BottomButtonBG = nil,
    stc_BottomKeyGuide = nil
  },
  _ui_pc = {
    btn_Close_pc = nil,
    btn_Yes_pc = nil,
    btn_No_pc = nil
  },
  _ui_console = {
    stc_KeyGuide_X = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  tempFromWhereType = nil,
  tempFromSlotNo = nil,
  _initialize = false
}
PaGlobal_FairyInfo_All = {
  _ui = {
    stc_TitleBG = nil,
    stc_TitleImage = nil,
    stc_BasicInfoBG = nil,
    txt_FairyTier = nil,
    txt_FairyName = nil,
    stc_LevleInfoBG = nil,
    txt_Level = nil,
    txt_Exp = nil,
    progress2_Exp = nil,
    txt_FairyDesc = nil,
    stc_PotionBG = nil,
    stc_HPPotionBG = nil,
    stc_MPPotionBG = nil,
    stc_QuestionMarkHP = nil,
    stc_QuestionMarkMP = nil,
    txt_HPSet = nil,
    txt_MPSet = nil,
    stc_PotionLockBG = nil,
    stc_SkillBG = nil,
    _skillIconBg = {},
    _skillIcon = {},
    _skillMasterIcon = {},
    _skillName = {},
    _skillDesc = {},
    stc_BottomButtonBG = nil,
    chk_Lantern = nil,
    stc_BottomKeyGuide = nil
  },
  _ui_pc = {
    btn_Question_pc = nil,
    btn_Close_pc = nil,
    btn_FairyUpgrade_pc = nil,
    btn_FairyGrowth_pc = nil,
    btn_PotionSetting_pc = nil,
    btn_LearnableSkill_pc = nil,
    btn_Rebirth_pc = nil,
    btn_Summon_pc = nil,
    btn_Unsummon_pc = nil,
    btn_Release_pc = nil,
    btn_SkinChange_pc = nil,
    btn_ChangeSkill = nil
  },
  _ui_console = {
    stc_KeyGuide_LTX = nil,
    stc_KeyGuide_LTY = nil,
    stc_KeyGuide_LTA = nil,
    stc_KeyGuide_RTX = nil,
    stc_KeyGuide_X = nil,
    stc_KeyGuide_Y = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _skillKey = {},
  _fairykey = nil,
  _fairyNo = nil,
  _isUnseal = nil,
  _learnPotionSkill = false,
  _iconPath = nil,
  _fairyName = nil,
  _skillTooltipDesc = {},
  _fairyLevel = 0,
  _isFairyMaxLevel = false,
  currentLevel = 0,
  _fairyTier = 0,
  _fairyTierMax = 3,
  _currentHpKey = nil,
  _currentMpKey = nil,
  _isAnimate = false,
  _const_Ani_Time = 8.5,
  _timeStamp = 0,
  _fromWhereType = 0,
  _fromSlotNo = 0,
  _currentExpRate = 0,
  _checkLanternMouseOn = nil,
  _enableFairyUpgrade = false,
  eFairyMaxEquipSkill = 30,
  _MaxSkillCount = 5,
  _fairyAttrStr = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_ATTR_1"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_ATTR_2"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_ATTR_3"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_ATTR_4"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYINFO_ATTR_5")
  },
  _GenerationStr = {
    [0] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRY_INFO_GENERATION_1"),
    [1] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRY_INFO_GENERATION_2"),
    [2] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRY_INFO_GENERATION_3"),
    [3] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRY_INFO_GENERATION_4")
  },
  _InfoDescStr = {
    [0] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRY_INFO_DESC"),
    [1] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRY_INFO_DESC_2"),
    [2] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRY_INFO_DESC_3"),
    [3] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRY_INFO_DESC_4")
  },
  _buttonName = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_INFO_FREEDOM_NAME"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_INFO_TIERUPGRADE_NAME")
  },
  _keyguide = {},
  _initialize = false,
  _config = {}
}
PaGlobal_FairyGrowth_All = {
  _ui = {
    stc_TitleBG = nil,
    stc_LeftSlotGroupBG = nil,
    stc_LeftSlotBG = nil,
    stc_FairyIcon = nil,
    stc_FeedIcon = nil,
    txt_FeedCount = nil,
    progress2_Preview = nil,
    progress2_Exp = nil,
    txt_PreviewLevel = nil,
    txt_PreviewExpRate = nil,
    txt_GuideText = nil,
    txt_NoEquip = nil,
    stc_FeedItemGroupBG = nil,
    list2_FeedItem = nil,
    stc_HoneySlotGroupBG = nil,
    stc_HoneyBG = nil
  },
  _ui_pc = {btn_Close_pc = nil, btn_GrowthConfirm_pc = nil},
  _ui_console = {
    stc_KeyGuide_LTX = nil,
    stc_KeyGuide_X = nil,
    stc_KeyGuide_Y = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _itemGradeColor = {
    [__eItemGradeNormal] = Defines.Color.C_FFFFFFFF,
    [__eItemGradeMagic] = 4284350320,
    [__eItemGradeRare] = 4283144191,
    [__eItemGradeUnique] = 4294953010,
    [__eItemGradeEpic] = 4294929408,
    [__eItemGradeTypeCount] = Defines.Color.C_FFFFFFFF
  },
  _rdo_Honey = {},
  _MAX_HONEY_COUNT = 2,
  _itemList = {},
  _itemListCount = 0,
  _honeyList = {},
  _honeyListCount = 0,
  _isAnimating = false,
  _currentItemEnchantKey = nil,
  _currentItemSlotNo = 0,
  _currentItemStackCount = 0,
  _currentSelectEquipItemIndex = -1,
  _selectListBar = nil,
  _const_aniTime = 2.3,
  _ani_TimeStamp = 0,
  _isHoneySelect = false,
  _currentSelectHoneyItemIndex = -1,
  _previewExpRate = 0,
  _previewLevel = 0,
  _diffExp = 0,
  _animeLv = 0,
  _animeExp = 0,
  _initialize = false
}
PaGlobal_FairySetting_All = {
  _ui = {
    stc_TitleBG = nil,
    stc_MainBG = nil,
    stc_HPItemSlotBG = nil,
    stc_QuestionMarkHP = nil,
    stc_HPItemSlot = nil,
    txt_currentHPValue = nil,
    progress2_Hp = nil,
    slider_HP = nil,
    stc_MPItemSlotBG = nil,
    stc_QuestionMarkMP = nil,
    stc_MPItemSlot = nil,
    txt_currentMPValue = nil,
    progress2_Mp = nil,
    slider_MP = nil,
    stc_DescBG = nil,
    txt_Desc = nil,
    stc_BottomButtonBG = nil,
    list2_Potion = nil,
    txt_NoPotion = nil,
    stc_BottomKeyGuide = nil
  },
  _ui_pc = {
    btn_Close_pc = nil,
    btn_Yes_pc = nil,
    btn_No_pc = nil
  },
  _ui_console = {
    stc_KeyGuide_X = nil,
    stc_KeyGuide_Y = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _currentFairyNoStr = nil,
  _currentHpKey = nil,
  _currentMpKey = nil,
  _currentHpRate = 0,
  _currentMpRate = 0,
  _currentClassType = nil,
  _currentTier = 0,
  _potionList = {},
  _potionListCount = 0,
  _initialize = false,
  _prevSnappedControl = nil
}
PaGlobal_FairySkill_All = {
  _ui = {
    stc_TitleBG = nil,
    stc_TitleName = nil,
    stc_MainBG = nil,
    list2_Skill = nil,
    stc_skillIcons = {}
  },
  _ui_pc = {btn_Close_Top_pc = nil, btn_Close_Bottom_pc = nil},
  _ui_console = {stc_KeyGuide_B = nil},
  exceptGroupkey = {},
  _initialize = false
}
PaGlobal_FairyChoiceTheReset_All = {
  _ui = {
    stc_TitleBG = nil,
    stc_MainBG = nil,
    rdo_Skill = nil,
    rdo_Voice = nil,
    stc_BottomButtonBG = nil,
    stc_BottomKeyGuide = nil
  },
  _ui_pc = {
    btn_Close_pc = nil,
    btn_Select_pc = nil,
    btn_Cancel_pc = nil
  },
  _ui_console = {
    stc_KeyGuide_Y = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _isClearSkill = false,
  _fairyAttr = false,
  _fairyNo = nil,
  _initialize = false
}
PaGlobal_FairyTierUpgrade_All = {
  _ui = {
    stc_TitleBG = nil,
    stc_MainBG = nil,
    stc_FairyBG = nil,
    stc_FairyIcon = nil,
    txt_Percentage = nil,
    stc_Blcok_Sucess = nil,
    stc_Blcok_Fail = nil,
    stc_Blcok_TierUpgrade = nil,
    stc_HoneyGroup = nil,
    stc_HoneyBG = nil,
    stc_SliderBG = nil,
    txt_SelectName = nil,
    txt_SelectCount = nil,
    progress2_Honey = nil,
    txt_MinCount = nil,
    txt_MaxCount = nil,
    stc_BottomButtonBG = nil,
    stc_BottomKeyGuide = nil
  },
  _ui_pc = {
    btn_Close_pc = nil,
    btn_Detail_pc = nil,
    btn_Upgrade_pc = nil,
    slider_Honey_pc = nil,
    btnSlider_Honey_pc = nil
  },
  _ui_console = {
    slider_Honey_console = nil,
    stc_KeyGuide_Y = nil,
    stc_KeyGuide_X = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _rdo_Honey = {},
  _HoenyCount = 2,
  _rim = {},
  _rimCount = 4,
  _rimSpeed = 2,
  _currentItemKey = nil,
  _currentItemSlotNo = nil,
  _currentItemStackCount = 0,
  _currentItemWhereType = nil,
  _currentItemCountInInventory = 0,
  _currentItemClickIndex = -1,
  _itemList = {},
  _currentItemCount = 0,
  _maxSuccessRate = 0,
  _maxSubjectCount = 0,
  _currentSuccessRate = 0,
  _isResultAnimating = false,
  _resultAniElapsed = 0,
  _resultAniLength = 3,
  _resultMessagePosX = 0,
  _resultMessagePosY = 232,
  _result = 0,
  _RIM_ANI_STATE = {
    IDLE = 1,
    ROTATING = 2,
    INDICATING = 3,
    WAITING_FOR_RESULT = 4
  },
  _RESULT_TYPE = {
    UNDEFINED = 0,
    SUCCESS = 1,
    FAIL = 2
  },
  _initialize = false
}
PaGlobal_FairyChangeSkill_All = {
  _ui = {
    stc_TitleBG = nil,
    txt_Title_Name = nil,
    stc_MainBG = nil,
    stc_HasSkillSlot = nil,
    stc_GetSkillSlot = nil,
    mtl_Change = nil,
    btn_Template = nil,
    stc_MasterIcon = nil,
    stc_SkillSlotBg = nil,
    txt_SkillName = nil,
    txt_SkillDesc = nil,
    btn_ViewSkill = nil,
    btn_VIewHelp = nil,
    stc_SlotBG = nil
  },
  _ui_pc = {btn_Close_pc = nil, btn_Change_pc = nil},
  _ui_console = {
    stc_KeyGuide = nil,
    txt_KeyGuide_A = nil,
    txt_KeyGuide_B = nil
  },
  _slotConfig = {createIcon = true},
  _ANI_STATE = {
    START = 1,
    PLAY = 2,
    STOP = 3
  },
  _skillKeyList = nil,
  _skillSlot = {},
  _learnSkillMaxCount = 4,
  _selectSkillKey = nil,
  _fairyNo = nil,
  _fairyLevel = nil,
  _changeAniState = nil,
  _aniStartTime = 0,
  _aniEndTime = 0,
  _aniDelayTime = 3,
  _changeAnimationEffect = nil,
  _changeEffect = nil,
  _changeEffectControl = nil,
  _newSkillkey = nil,
  _initialize = false
}
PaGlobal_FairyChangeSkill_Viewhelper_All = {
  _ui = {
    stc_TitleArea = nil,
    stc_Title = nil,
    btn_Win_Close = nil,
    stc_MainArea = nil,
    stc_LineBG = nil,
    stc_Text_Desc = nil
  },
  _ui_pc = {btn_Close_pc = nil},
  _isAllSkillShow = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_Fairy_All_1.lua")
runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_Fairy_All_2.lua")
runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_Fairy_All_3.lua")
runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_Fairy_All_4.lua")
runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_Fairy_All_5.lua")
runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_Fairy_All_6.lua")
if _ContentsGroup_FairyTierUpgradeAndRebirth then
  runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_Fairy_All_7.lua")
end
runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_Fairy_All_8.lua")
if _ContentsGroup_FairyChangeSkill then
  runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_Fairy_All_9.lua")
  runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairySkillChange_Viewhelp_All.lua")
end
registerEvent("FromClient_luaLoadComplete", "FromClient_FairyAllInit")
registerEvent("FromClient_FairyNewSkillKey", "FromClient_FairyNewSkillKey")
registerEvent("FromClient_InventoryUpdate", "PaGlobal_FairyChangeSkill_CurrentItemCountSetting")
function FromClient_FairyAllInit()
  PaGlobal_FairyRegister_All:initialize()
  PaGlobal_FairyInfo_All:initialize()
  PaGlobal_FairyGrowth_All:initialize()
  PaGlobal_FairySetting_All:initialize()
  PaGlobal_FairySkill_All:initialize()
  PaGlobal_FairyChoiceTheReset_All:initialize()
  if _ContentsGroup_FairyTierUpgradeAndRebirth then
    PaGlobal_FairyTierUpgrade_All:initialize()
  end
  if _ContentsGroup_FairyChangeSkill then
    PaGlobal_FairyChangeSkill_All:initialize()
    PaGlobal_FairyChangeSkill_Viewhelper_All:initialize()
  end
end
