PaGlobal_Quest_All = {
  _ui = {
    stc_titleBg = nil,
    stc_contentBg = nil,
    stc_radioButtonGroup = nil,
    radio_progressing = nil,
    radio_main = nil,
    radio_recommend = nil,
    radio_repeat = nil,
    radio_new = nil,
    stc_selectBar = nil,
    stc_groupTypeBG = nil,
    txt_questCnt = nil,
    radio_questType = nil,
    radio_questTerritory = nil,
    chk_emptyGroupHide = nil,
    stc_groupFilterBg = nil,
    chk_complteHide = nil,
    btn_questBranch = nil,
    stc_eff_complete0 = nil,
    stc_eff_complete1 = nil,
    _listGroup = {},
    _listTemplate = {},
    _listScroll = {},
    stc_favorTypeBg = nil,
    txt_favorType = nil,
    _favorType = {},
    stc_DoneQuestBg = nil,
    txt_DoneQuest = nil
  },
  _ui_pc = {
    btn_question = nil,
    chk_popUp = nil,
    btn_close = nil
  },
  _ui_console = {
    stc_menuGuideLB = nil,
    stc_menuGuideRB = nil,
    stc_keyGuideBG = nil,
    stc_guideSortType = nil,
    stc_guideHideEmpty = nil,
    stc_guideSelect = nil,
    stc_guideClose = nil,
    stc_guidePreferRT = nil,
    stc_guidePreferPlus = nil,
    stc_guidePreferY = nil,
    _focusMenu = {}
  },
  _regionString = {
    [CppEnums.QuestRegionType.eQuestRegionType_None] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_99"),
    [CppEnums.QuestRegionType.eQuestRegionType_Balenos] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_1"),
    [CppEnums.QuestRegionType.eQuestRegionType_Serendia] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_2"),
    [CppEnums.QuestRegionType.eQuestRegionType_NorthCalpheon] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_3"),
    [CppEnums.QuestRegionType.eQuestRegionType_CalpheonBigCity] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_4"),
    [CppEnums.QuestRegionType.eQuestRegionType_Keplan] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_5"),
    [CppEnums.QuestRegionType.eQuestRegionType_SouthWestCalpheon] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_6"),
    [CppEnums.QuestRegionType.eQuestRegionType_Media] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_7"),
    [CppEnums.QuestRegionType.eQuestRegionType_Valencia] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_8"),
    [CppEnums.QuestRegionType.eQuestRegionType_Kamasylvia] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_9"),
    [CppEnums.QuestRegionType.eQuestRegionType_Drigan] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_10"),
    [CppEnums.QuestRegionType.eQuestRegionType_Odilita] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_11")
  },
  _regionOpen = {
    [CppEnums.QuestRegionType.eQuestRegionType_None] = true,
    [CppEnums.QuestRegionType.eQuestRegionType_Balenos] = true,
    [CppEnums.QuestRegionType.eQuestRegionType_Serendia] = true,
    [CppEnums.QuestRegionType.eQuestRegionType_NorthCalpheon] = true,
    [CppEnums.QuestRegionType.eQuestRegionType_CalpheonBigCity] = true,
    [CppEnums.QuestRegionType.eQuestRegionType_Keplan] = true,
    [CppEnums.QuestRegionType.eQuestRegionType_SouthWestCalpheon] = true,
    [CppEnums.QuestRegionType.eQuestRegionType_Media] = true,
    [CppEnums.QuestRegionType.eQuestRegionType_Valencia] = true,
    [CppEnums.QuestRegionType.eQuestRegionType_Kamasylvia] = true,
    [CppEnums.QuestRegionType.eQuestRegionType_Drigan] = true,
    [CppEnums.QuestRegionType.eQuestRegionType_Odilita] = true,
    [CppEnums.QuestRegionType.eQuestRegionType_Count] = false
  },
  _typeString = {
    [CppEnums.QuestType.eQuestType_BlackSpirit] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_1"),
    [CppEnums.QuestType.eQuestType_Story] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_2"),
    [CppEnums.QuestType.eQuestType_Town] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_3"),
    [CppEnums.QuestType.eQuestType_Adventure] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_4"),
    [CppEnums.QuestType.eQuestType_Trade] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_5"),
    [CppEnums.QuestType.eQuestType_Craft] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_6"),
    [CppEnums.QuestType.eQuestType_Repetition] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_7"),
    [CppEnums.QuestType.eQuestType_Guild] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_8"),
    [CppEnums.QuestType.eQuestType_Special] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_10"),
    [CppEnums.QuestType.eQuestType_RegionMonsterKill] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_11")
  },
  _typeOpen = {
    [CppEnums.QuestType.eQuestType_BlackSpirit] = true,
    [CppEnums.QuestType.eQuestType_Story] = true,
    [CppEnums.QuestType.eQuestType_Town] = true,
    [CppEnums.QuestType.eQuestType_Adventure] = true,
    [CppEnums.QuestType.eQuestType_Trade] = true,
    [CppEnums.QuestType.eQuestType_Craft] = true,
    [CppEnums.QuestType.eQuestType_Repetition] = true,
    [CppEnums.QuestType.eQuestType_Guild] = true,
    [CppEnums.QuestType.eQuestType_Special] = true,
    [CppEnums.QuestType.eQuestType_RegionMonsterKill] = true,
    [CppEnums.QuestType.eQuestType_Count] = false
  },
  _isContentsEnableMedia = ToClient_IsContentsGroupOpen("3"),
  _isContentsEnableValencia = ToClient_IsContentsGroupOpen("4"),
  _isContentsEnableKamasilvia = ToClient_IsContentsGroupOpen("5"),
  _isContentsEnableDragan = ToClient_IsContentsGroupOpen("6"),
  _TABTYPE = {
    PROGRESS = 1,
    MAIN = 2,
    RECOMMEND = 3,
    REPEAT = 4,
    NEW = 5,
    COUNT = 6
  },
  _FAVORTYPE = {
    ALL = 0,
    HUNT = 1,
    LIFE = 2,
    FISH = 3,
    TRADE = 4,
    ETC = 5,
    COUNT = 6
  },
  _QUESTTYPE = {
    BALCK = 0,
    STORY = 1,
    TOWN = 2,
    ADV = 3,
    TRADE = 4,
    CRAFT = 5,
    REPEAT = 6,
    COUNT = 7
  },
  _SELECTTYPE = {
    STORY = 0,
    HUNT = 1,
    LIFE = 2,
    FISH = 3,
    ADV = 4,
    ETC = 5
  },
  _config = {selectAbleFavorTypeLv = 20, slotMaxCount = 11},
  _uiPool = {
    questFavorType = {},
    groupTitle = {},
    listMain = {}
  },
  _selectWay = {
    groupID = "",
    questID = "",
    isAuto = false
  },
  _radioTabs = {},
  _currentTab = nil,
  _progressQuestCount = 0,
  _startSlotIndex = 1,
  _listCount = 0,
  _useArray = {},
  _questSortArrayRegion = {},
  _questArrayRegionCount = {},
  _questArrayRegionProgressCount = {},
  _questArrayRegionSort = {
    [0] = CppEnums.QuestRegionType.eQuestRegionType_Balenos,
    [1] = CppEnums.QuestRegionType.eQuestRegionType_Serendia,
    [2] = CppEnums.QuestRegionType.eQuestRegionType_NorthCalpheon,
    [3] = CppEnums.QuestRegionType.eQuestRegionType_CalpheonBigCity,
    [4] = CppEnums.QuestRegionType.eQuestRegionType_Keplan,
    [5] = CppEnums.QuestRegionType.eQuestRegionType_SouthWestCalpheon,
    [6] = CppEnums.QuestRegionType.eQuestRegionType_Media,
    [7] = CppEnums.QuestRegionType.eQuestRegionType_Valencia,
    [8] = CppEnums.QuestRegionType.eQuestRegionType_Kamasylvia,
    [9] = CppEnums.QuestRegionType.eQuestRegionType_Drigan,
    [10] = CppEnums.QuestRegionType.eQuestRegionType_Odilita,
    [11] = CppEnums.QuestRegionType.eQuestRegionType_None
  },
  _questSortArrayType = {},
  _questArrayTypeCount = {},
  _questArrayTypeProgressCount = {},
  _questSelectTypeString = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_QUESTSELECTTYPE_TXT_TYPE_1"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_QUESTSELECTTYPE_TXT_TYPE_2"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_QUESTSELECTTYPE_TXT_TYPE_3"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_QUESTSELECTTYPE_TXT_TYPE_4"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_QUESTSELECTTYPE_TXT_TYPE_5"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_QUESTSELECTTYPE_TXT_TYPE_6")
  },
  _groupOpen = {
    _recommendation = {},
    _repetitive = {},
    _main = {},
    _new = {}
  },
  _questArrayGroupCount = {},
  _questArrayGroupCompleteCount = {},
  _selectQuestInfo = {},
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Quest/Panel_Window_Quest_All_1.lua")
runLua("UI_Data/Script/Window/Quest/Panel_Window_Quest_All_2.lua")
runLua("UI_Data/Script/Window/Quest/Panel_Window_Quest_All_3.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Quest_All_Init")
function FromClient_Quest_All_Init()
  PaGlobal_Quest_All:initialize()
end
