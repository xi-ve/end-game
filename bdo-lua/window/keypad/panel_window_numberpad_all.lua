PaGlobal_NumberPad_All = {
  _ui = {
    stc_title = nil,
    btn_close = nil,
    edit_displayNumber = nil,
    chk_maxCount = nil,
    btn_backspace = nil,
    btn_clear = nil,
    btn_moneyAllSelect = nil,
    btn_weightAllSelect = nil,
    btn_confirm = nil,
    btn_cancel = nil,
    stc_keyGuideBg = nil,
    btn_confirm_consoleUI = nil,
    btn_cancel_consoleUI = nil,
    btn_numbers = {}
  },
  _numberPad = {
    s64_moneyMaxNumber = Defines.s64_const.s64_0,
    s64_weightMaxNumber = Defines.s64_const.s64_0,
    s64_inputNumber = Defines.s64_const.s64_0,
    param0 = nil,
    param1 = nil,
    confirmFunction = nil,
    init_Number = false,
    _type = ""
  },
  _numberKeyCode = {
    CppEnums.VirtualKeyCode.KeyCode_0,
    CppEnums.VirtualKeyCode.KeyCode_1,
    CppEnums.VirtualKeyCode.KeyCode_2,
    CppEnums.VirtualKeyCode.KeyCode_3,
    CppEnums.VirtualKeyCode.KeyCode_4,
    CppEnums.VirtualKeyCode.KeyCode_5,
    CppEnums.VirtualKeyCode.KeyCode_6,
    CppEnums.VirtualKeyCode.KeyCode_7,
    CppEnums.VirtualKeyCode.KeyCode_8,
    CppEnums.VirtualKeyCode.KeyCode_9,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD0,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD1,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD2,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD3,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD4,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD5,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD6,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD7,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD8,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD9
  },
  MAX_NUMBER_BTN_COUNT = 10,
  _isExchange = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Keypad/Panel_Window_NumberPad_All_1.lua")
runLua("UI_Data/Script/Window/Keypad/Panel_Window_NumberPad_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_NumberPad_All_Init")
function FromClient_NumberPad_All_Init()
  PaGlobal_NumberPad_All:initialize()
end
