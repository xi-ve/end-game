PaGlobal_Guild_Battle_All = {
  _ui = {
    stc_noReservationArea = nil,
    txt_explain = nil,
    txt_bottomDesc = nil,
    stc_reservationArea = nil,
    stc_waitGuild = nil,
    txt_waitOtherGuild = nil,
    btn_reservation = nil,
    btn_cancel = nil,
    btn_join = nil,
    btn_start = nil,
    btn_quit = nil,
    txt_progress = nil,
    txt_waitTimeTitle = nil,
    stc_progressBG = nil,
    progress_time = nil,
    txt_leftTime = nil,
    _myGuildInfo = nil,
    _otherGuildInfo = nil
  },
  _battingPrice = 0,
  _canCancel = true,
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_Battle_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_Battle_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Guild_Battle_All_Init")
function FromClient_Guild_Battle_All_Init()
  PaGlobal_Guild_Battle_All:initialize()
end
