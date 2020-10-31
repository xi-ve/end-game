PaGlobal_Quest_Option_All = {
  _favorType = {
    All = 0,
    Battle = 1,
    Life = 2,
    Fishing = 3,
    Trade = 4,
    Etc = 5,
    Count = 6
  },
  _sortType = {
    Distance = 0,
    TimeRecent = 1,
    Favor = 2,
    Count = 3
  },
  _sortState = {
    none = 0,
    desc = 1,
    asc = 2,
    Count = 3
  },
  _latestQuestCount = {
    zero = 0,
    one = 1,
    two = 2,
    three = 3,
    Count = 4
  },
  _questWidgetType = {
    simple = CppEnums.QuestWidgetType.eQuestWidgetType_Simple,
    extend = CppEnums.QuestWidgetType.eQuestWidgetType_Extend,
    Count = CppEnums.QuestWidgetType.eQuestWidgetType_Count
  },
  _sortTypeRealValue_Type = {
    [0] = 2,
    [1] = 1,
    [2] = 0
  },
  _sortTypeRealValue_Distance = {
    [0] = 1,
    [1] = 2,
    [2] = 0
  },
  _sortTypeRealValue_TimeRecent = {
    [0] = 2,
    [1] = 1,
    [2] = 0
  },
  _ui = {
    stc_titleBG = nil,
    btn_close = nil,
    btn_confirm = nil,
    btn_cancel = nil,
    stc_mainBG = nil,
    stc_option_displayBG = nil,
    stc_option_sortBG = nil,
    stc_option_recentBG = nil,
    txt_sortTypeDesc = nil,
    favorCheckBoxButton = {},
    sortButton_Type = {},
    sortButton_Distance = {},
    sortButton_TimeRecent = {},
    latestQuestCountButton = {},
    questWidgetTypeButton = {}
  },
  _descPadding = 15,
  _defaultSortUiIndex = 2,
  _defaultDescSizeY = 0,
  _defaultDisplayBGSizeY = 0,
  _defaultMainBGSizeY = 0,
  _defaultPanelSizeY = 0,
  _defaultSortBGStartPosY = 0,
  _defaultRecentBGStartPosY = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/QuestList/Panel_Window_Quest_Option_All_1.lua")
runLua("UI_Data/Script/Widget/QuestList/Panel_Window_Quest_Option_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Quest_Option_All_Init")
function FromClient_Quest_Option_All_Init()
  PaGlobal_Quest_Option_All:initialize()
end
