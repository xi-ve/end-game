PaGlobal_CharInfo_All = {
  _ui = {
    stc_TitleBg = nil,
    txt_Title = nil,
    btn_Close = nil,
    btn_Question = nil,
    btn_StickerUI = nil,
    stc_TabBg = nil,
    rdo_BasicInfo = nil,
    rdo_FamSkill = nil,
    rdo_Title = nil,
    rdo_History = nil,
    rdo_Challenge = nil,
    rdo_footPrint = nil,
    rdo_Life = nil,
    rdo_CashBuff = nil,
    stc_KeyGuide_LB = nil,
    stc_KeyGuide_RB = nil,
    btn_Resize = nil,
    stc_BasicBg = nil,
    stc_FamliyBg = nil,
    stc_TitleBg = nil,
    stc_HistoryBg = nil,
    stc_ChallengeBg = nil,
    stc_FootPrintBg = nil,
    stc_LifeBg = nil,
    stc_CashBuffBg = nil,
    stc_selectLine = nil,
    stc_tooltip = nil,
    txt_tooltip = nil,
    stc_SimpleTooltipBg = nil,
    txt_SimpleTooltipTitle = nil,
    txt_SimpleTooltipDesc = nil,
    rdo_tabTable = {}
  },
  _TABINDEX = {
    _basic = 0,
    _familySkill = 1,
    _title = 2,
    _history = 3,
    _challenge = 4,
    _footPrint = 5,
    _life = 6,
    _cashBuff = 7,
    _totalCount = 8
  },
  _TABSTRING = {
    [0] = "UI_WINDOW_CHARACTERINFO_TAB_INFO",
    "PANEL_WINDOW_CHARACTERINFO_TAB_EDANA",
    "UI_WINDOW_CHARACTERINFO_TAB_TITLE",
    "UI_WINDOW_CHARACTERINFO_TAB_HISTORY",
    "UI_WINDOW_CHARACTERINFO_TAB_CHALLENGE",
    "PANEL_CHARACTERINFO_ACHIVEMENTTITLE",
    "CHARACTERINFO_TEXT_SUBTITLE_CRAFT",
    "UI_WINDOW_CHARACTERINFO_TAB_BUFF"
  },
  _tabData = {},
  _consoleBtnTable = {},
  _consoleIdx = 0,
  _currentTabIdx = nil,
  _checkLPress = false,
  _oriTabSize = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_All_1.lua")
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CharInfo_AllInit")
function FromClient_CharInfo_AllInit()
  PaGlobal_CharInfo_All:initialize()
end
