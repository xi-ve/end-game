PaGlobal_ButtonShortcuts_All = {
  _eOpenType = {currentSet = 0, allSet = 1},
  _ui = {
    stc_titleBg = nil,
    stc_markIcon = nil,
    stc_curSetBg = nil,
    txt_curSetTitle = nil,
    txt_curSetName = nil,
    radio_curSetKey = nil,
    stc_allListBg = nil,
    edit_search = nil,
    btn_search = nil,
    chk_all = nil,
    list2_keySet = nil,
    stc_bottomDescBg = nil,
    txt_bottomDesc = nil,
    btn_close = nil,
    btn_reset = nil,
    btn_allView = nil,
    btn_confirm = nil,
    btn_question = nil
  },
  _UIMODE = {
    Current = {index = 0, size = 0},
    List = {index = 1, size = 0},
    ListOnly = {
      index = 2,
      size = 0,
      offset = 0
    }
  },
  _buttonPos = {
    [0] = 0,
    [1] = 0,
    [2] = 0
  },
  _keyString = {
    [CppEnums.VirtualKeyCode.KeyCode_1] = "1",
    [CppEnums.VirtualKeyCode.KeyCode_2] = "2",
    [CppEnums.VirtualKeyCode.KeyCode_3] = "3",
    [CppEnums.VirtualKeyCode.KeyCode_4] = "4",
    [CppEnums.VirtualKeyCode.KeyCode_5] = "5",
    [CppEnums.VirtualKeyCode.KeyCode_6] = "6",
    [CppEnums.VirtualKeyCode.KeyCode_7] = "7",
    [CppEnums.VirtualKeyCode.KeyCode_8] = "8",
    [CppEnums.VirtualKeyCode.KeyCode_9] = "9",
    [CppEnums.VirtualKeyCode.KeyCode_0] = "0",
    [CppEnums.VirtualKeyCode.KeyCode_SUBTRACT] = "-",
    [CppEnums.VirtualKeyCode.KeyCode_ADD] = "+",
    [CppEnums.VirtualKeyCode.KeyCode_Q] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Q"),
    [CppEnums.VirtualKeyCode.KeyCode_W] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_W"),
    [CppEnums.VirtualKeyCode.KeyCode_E] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_E"),
    [CppEnums.VirtualKeyCode.KeyCode_R] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_R"),
    [CppEnums.VirtualKeyCode.KeyCode_T] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_T"),
    [CppEnums.VirtualKeyCode.KeyCode_Y] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Y"),
    [CppEnums.VirtualKeyCode.KeyCode_U] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_U"),
    [CppEnums.VirtualKeyCode.KeyCode_I] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_I"),
    [CppEnums.VirtualKeyCode.KeyCode_O] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_O"),
    [CppEnums.VirtualKeyCode.KeyCode_P] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_P"),
    [CppEnums.VirtualKeyCode.KeyCode_A] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_A"),
    [CppEnums.VirtualKeyCode.KeyCode_S] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_S"),
    [CppEnums.VirtualKeyCode.KeyCode_D] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_D"),
    [CppEnums.VirtualKeyCode.KeyCode_F] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F"),
    [CppEnums.VirtualKeyCode.KeyCode_G] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_G"),
    [CppEnums.VirtualKeyCode.KeyCode_H] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_H"),
    [CppEnums.VirtualKeyCode.KeyCode_J] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_J"),
    [CppEnums.VirtualKeyCode.KeyCode_K] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_K"),
    [CppEnums.VirtualKeyCode.KeyCode_L] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_L"),
    [CppEnums.VirtualKeyCode.KeyCode_OEM_7] = "'",
    [CppEnums.VirtualKeyCode.KeyCode_Z] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Z"),
    [CppEnums.VirtualKeyCode.KeyCode_X] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_X"),
    [CppEnums.VirtualKeyCode.KeyCode_V] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_V"),
    [CppEnums.VirtualKeyCode.KeyCode_N] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_N"),
    [CppEnums.VirtualKeyCode.KeyCode_M] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_M"),
    [CppEnums.VirtualKeyCode.KeyCode_OEM_2] = "/",
    [CppEnums.VirtualKeyCode.KeyCode_MENU] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Alt")
  },
  _ePanelType = 0,
  _listOriginPos = 0,
  _bottomBgOriginSizeY = 0,
  _currentSetId = -1,
  _curMode = 0,
  _curId = -1,
  _curButtonsShortcuts = nil,
  _openButtonsShortcuts = nil,
  _registerKey = nil,
  _searchText = "",
  _altString = "Alt + ",
  _defaultEditTxt = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_SEARCHTEXT"),
  _nothingTxt = PAGetString(Defines.StringSheet_GAME, "LUA_SHORTCUT_BUTTONDEFAULT"),
  _initialize = false
}
runLua("UI_Data/Script/Window/ButtonShortcuts/Panel_Window_ButtonShortcuts_All_1.lua")
runLua("UI_Data/Script/Window/ButtonShortcuts/Panel_Window_ButtonShortcuts_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ButtonShorcuts_All_Init")
function FromClient_ButtonShorcuts_All_Init()
  PaGlobal_ButtonShortcuts_All:initialize()
end
