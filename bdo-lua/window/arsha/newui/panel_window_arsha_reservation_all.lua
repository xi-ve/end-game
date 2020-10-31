PaGlobal_Arsha_Reservation_All = {
  _ui = {
    stc_TitleBG = nil,
    btn_Close = nil,
    stc_SubTitleBG = nil,
    stc_ButtonBG = nil,
    btn_Template = nil,
    stc_RightArea = nil,
    frame_Desc = nil,
    frame_Content = nil,
    frame_Scroll = nil,
    txt_Desc = nil,
    stc_BottomBG = nil,
    btn_Refresh = nil,
    btn_Join = nil,
    btn_ObserverJoin = nil,
    stc_KeyGuide = nil,
    stc_KeyGroup = {},
    txt_Unavailale = nil
  },
  _reservationSlot = {},
  _reservationSlotTemplate = {
    btn_Template = nil,
    txt_DayOfWeek = nil,
    txt_Date = nil,
    txt_GuildName = nil,
    btn_Reserve = nil
  },
  _dayOfWeekString = {
    [CppEnums.VillageSiegeType.eVillageSiegeType_Sunday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_SUNDAY"),
    [CppEnums.VillageSiegeType.eVillageSiegeType_Monday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_MONDAY"),
    [CppEnums.VillageSiegeType.eVillageSiegeType_Tuesday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_TUESDAY"),
    [CppEnums.VillageSiegeType.eVillageSiegeType_Wednesday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_WEDNESDAY"),
    [CppEnums.VillageSiegeType.eVillageSiegeType_Thursday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_THURSDAY"),
    [CppEnums.VillageSiegeType.eVillageSiegeType_Friday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_FRIDAY"),
    [CppEnums.VillageSiegeType.eVillageSiegeType_Saturday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_SATURDAY")
  },
  _isArshaAvailable = false,
  _panelSizeY = 0,
  _isConsole = _ContentsGroup_UsePadSnapping,
  _initialize = false
}
runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_Reservation_All_1.lua")
runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_Reservation_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Arsha_Reservation_All_Init")
function FromClient_Arsha_Reservation_All_Init()
  PaGlobal_Arsha_Reservation_All:initialize()
end
