PaGlobal_CharInfoFootPrint_All = {
  _ui = {
    stc_KeyGuide_LT = nil,
    stc_KeyGuide_RT = nil,
    rdo_1day = nil,
    rdo_7day = nil,
    rdo_30day = nil,
    rdo_Allday = nil,
    stc_selectLine = nil,
    txt_PlayTime = nil,
    stc_PlayTiemIcon = nil,
    stc_KeyGuide_B = nil,
    stc_Box = {},
    btn_RadioTable = {}
  },
  _eDATE = {
    [0] = 1,
    [1] = 7,
    [2] = 30,
    [3] = 0
  },
  _string_DATE = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_ACHIVEMENT_DAY"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_ACHIVEMENT_WEEK"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_ACHIVEMENT_MONTH"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_ACHIVEMENT_TOTAL")
  },
  _currentTabIdx = 0,
  _selfPlayer = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_FootPrint_All_1.lua")
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_FootPrint_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CharInfoFootPrint_AllInit")
function FromClient_CharInfoFootPrint_AllInit()
  PaGlobal_CharInfoFootPrint_All:initialize()
end
