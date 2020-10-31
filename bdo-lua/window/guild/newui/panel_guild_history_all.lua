PaGlobal_Guild_History_All = {
  _ui = {
    stc_topArea = nil,
    btn_left = nil,
    btn_right = nil,
    txt_titleYear = nil,
    rdo_titleMonth = nil,
    stc_line = nil,
    stc_mainArea = nil,
    frame_history = nil,
    frameContent = nil,
    frameScroll = nil,
    txt_date = nil,
    stc_verticalLine = nil,
    stc_leftWing = nil,
    stc_rightWing = nil,
    txt_leftDay = nil,
    txt_rightDay = nil,
    txt_leftHistory = nil,
    txt_rightHistory = nil,
    _monthControl = {},
    _dayHistoryValue = {}
  },
  _dayCount = {
    31,
    29,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  },
  _firstLogYearValue = 2014,
  _year = nil,
  _month = nil,
  _day = nil,
  _guildHistory = 1,
  _firstOpenCheck = true,
  _haveInfoMonth = nil,
  _listCount = 0,
  _noScroll_FrameSize = 0,
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_History_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_History_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Guild_History_All_Init")
function FromClient_Guild_History_All_Init()
  PaGlobal_Guild_History_All:initialize()
end
