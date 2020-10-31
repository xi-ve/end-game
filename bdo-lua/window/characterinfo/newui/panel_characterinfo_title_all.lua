PaGlobal_CharInfoTitle_All = {
  _ui = {
    stc_TitleBg = nil,
    txt_TitleName = nil,
    txt_TitleDesc = nil,
    txt_Desc_ForGlobal = nil,
    txt_TitleCondi = nil,
    btn_Apply = nil,
    txt_TotalCount = nil,
    txt_TotalRate = nil,
    prog2_TotalTitle = nil,
    txt_Reward = nil,
    txt_RewardDesc = nil,
    stc_prog2Table = {},
    rdo_tabTable = {},
    rdo_Tab_World = nil,
    rdo_Tab_Combat = nil,
    rdo_Tab_Life = nil,
    rdo_Tab_Fish = nil,
    stc_KeyGuide_RT = nil,
    stc_KeyGuide_LT = nil,
    stc_SelectBar = nil,
    edit_Title = nil,
    btn_Search = nil,
    stc_KeyGuide_Search = nil,
    stc_Console_FilterBg = nil,
    rdo_Console_All = nil,
    rdo_Console_Known = nil,
    rdo_Console_Unknown = nil,
    stc_FilterBg = nil,
    comb_Filter = nil,
    list2_Title = nil,
    txt_CoolTime = nil,
    stc_Console_KeyGuides = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil,
    stc_KeyGuide_Y = nil
  },
  _eTITLETYPE = {
    _WORLD = 0,
    _COMBAT = 1,
    _LIFE = 2,
    _FISH = 3
  },
  _comboText = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TITLE_FILTER_ALL"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TITLE_FILTER_GET"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TITLE_FILTER_NOGET")
  },
  _currentTab = nil,
  _curCategoryCount = 0,
  _selectedIdx = nil,
  _saveTab = nil,
  _list2ScrollData = {_list2Idx = 0, _ScrollPos = 0},
  _isApplyBtnShow = false,
  _isFiltered = false,
  _isApplied = false,
  _selfPlayer = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Title_All_1.lua")
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Title_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CharInfoTitle_AllInit")
function FromClient_CharInfoTitle_AllInit()
  PaGlobal_CharInfoTitle_All:initialize()
end
