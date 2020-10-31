PaGlobal_CharInfoHistory_All = {
  _ui = {
    stc_KeyGuide_LT = nil,
    stc_KeyGuide_RT = nil,
    btn_YearLeft = nil,
    btn_YearRight = nil,
    txt_Year = nil,
    rdo_MonthTable = {},
    stc_SelectLine = nil,
    frame_ListTemp = nil,
    frame_ContentTemp = nil,
    frame_VertiCenterLine = nil,
    frame_HoriLeftCircle = nil,
    frame_HoriLeftLine = nil,
    frame_HoriRightCircle = nil,
    frame_HoriRightLine = nil,
    frame_HistoryLeft = nil,
    frame_HistoryRight = nil,
    frame_DateLeft = nil,
    frame_DateRight = nil,
    frame_List = nil,
    frame_Content = nil,
    frame_VertiScroll = nil
  },
  _pastMonth_DayCount = {
    [1] = 31,
    [2] = 29,
    [3] = 31,
    [4] = 30,
    [5] = 31,
    [6] = 30,
    [7] = 31,
    [8] = 31,
    [9] = 30,
    [10] = 31,
    [11] = 30,
    [12] = 31
  },
  _currentValue = {
    _year = 0,
    _month = 0,
    _day = 0,
    _myHistory = 0,
    _guildHistory = 1
  },
  _firstLogYearValue = 2014,
  _haveInfoMonth = nil,
  _firstOpenCheck = true,
  _currentidx = nil,
  _oriFrameSizeY = 0,
  _selfPlayer = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_History_All_1.lua")
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_History_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CharInfoHistory_AllInit")
function FromClient_CharInfoHistory_AllInit()
  PaGlobal_CharInfoHistory_All:initialize()
end
