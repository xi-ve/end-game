PaGlobal_FishEncyclopedia_All = {
  _ui = {
    stc_topBg = nil,
    btn_question = nil,
    btn_close = nil,
    stc_radioButtonBg_PC = nil,
    radiobuttons_PC = {},
    stc_selectLine_PC = nil,
    stc_radioButtonBg_Console = nil,
    radiobuttons_Console = {},
    stc_LB_Console = nil,
    stc_RB_Console = nil,
    stc_selectLine_Console = nil,
    stc_midBg = nil,
    stc_pageBtnBg = nil,
    txt_achivementValue = nil,
    progress_achivementRate = nil,
    txt_pageNumber = nil,
    btn_leftPage_PC = nil,
    btn_rightPage_PC = nil,
    stc_DpadLeft_Console = nil,
    stc_DpadRight_Console = nil,
    stc_pageLeft = {},
    stc_pageRight = {},
    stc_bottomBg_Console = nil,
    btn_close_console = nil,
    btn_detail_console = nil,
    stc_tooltip_left = {},
    stc_tooltip_right = {}
  },
  _selectedTab = 1,
  _currentPage = 1,
  _categoryParamIndex = 0,
  _maxTabCount = 4,
  _maxRateCount = 5,
  _maxRankSlotCount = 10,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishEncyclopedia_All_1.lua")
runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishEncyclopedia_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_FishEncyclopedia_All_Init")
function FromClient_FishEncyclopedia_All_Init()
  PaGlobal_FishEncyclopedia_All:initialize()
end
