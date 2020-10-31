PaGlobal_ShipControl_Console = {
  _ui = {
    stc_btnBG = nil,
    btn_function1 = nil,
    btn_function2 = nil,
    txt_desc = nil,
    stc_keyGuideBG = nil,
    txt_keyGuideA = nil,
    txt_keyGuideB = nil
  },
  _btnDesc = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SHIPCONTROLL_FUNCTION_1_DESC"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SHIPCONTROLL_FUNCTION_2_DESC")
  },
  _isNaviOn = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/Panel_Window_ShipControl_Console_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_Window_ShipControl_Console_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ShipControlConsoleInit")
function FromClient_ShipControlConsoleInit()
  PaGlobal_ShipControl_Console:initialize()
end
