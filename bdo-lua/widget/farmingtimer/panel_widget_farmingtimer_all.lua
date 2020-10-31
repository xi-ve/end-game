PaGlobal_FarmingTimer = {
  _ui = {
    txt_Time = nil,
    chk_Start = nil,
    btn_Stop = nil,
    btn_Reset = nil,
    txt_SlotCount = nil,
    btn_Report = nil,
    btn_Close = nil,
    btn_Popup = nil,
    stc_empty = nil
  },
  _config = {
    _eStart = 0,
    _ePause = 1,
    _eStop = 2,
    _eReset = 3,
    _eReport = 4,
    _ePopup = 5
  },
  _isStart = false,
  _isReportOpenPossible = true,
  _timer = 0,
  _lastUpdateTime = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/FarmingTimer/Panel_Widget_FarmingTimer_1.lua")
runLua("UI_Data/Script/Widget/FarmingTimer/Panel_Widget_FarmingTimer_2.lua")
