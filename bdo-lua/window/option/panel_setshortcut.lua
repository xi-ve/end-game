Panel_SetShortCut:SetShow(false)
local UI_color = Defines.Color
local eShortCutType = {quickSlot = 0, easyShortcut = 1}
local newShortCut = {
  ui = {
    _key = {
      key_ESC = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_ESC"),
      key_F1 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_F1"),
      key_F2 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_F2"),
      key_F3 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_F3"),
      key_F4 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_F4"),
      key_F5 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_F5"),
      key_F6 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_F6"),
      key_F7 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_F7"),
      key_F8 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_F8"),
      key_F9 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_F9"),
      key_F10 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_F10"),
      key_F11 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_F11"),
      key_F12 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_F12"),
      key_Wave = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_Wave"),
      key_1 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_1"),
      key_2 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_2"),
      key_3 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_3"),
      key_4 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_4"),
      key_5 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_5"),
      key_6 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_6"),
      key_7 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_7"),
      key_8 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_8"),
      key_9 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_9"),
      key_0 = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_0"),
      key_Minus = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_Minus"),
      key_Plus = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_Plus"),
      key_BackSpace = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_BackSpace"),
      key_Tab = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_Tab"),
      key_Q = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_Q"),
      key_W = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_W"),
      key_E = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_E"),
      key_R = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_R"),
      key_T = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_T"),
      key_Y = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_Y"),
      key_U = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_U"),
      key_I = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_I"),
      key_O = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_O"),
      key_P = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_P"),
      key_MiddilParenthesisLeft = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_MiddilParenthesisLeft"),
      key_MiddilParenthesisRight = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_MiddilParenthesisRight"),
      key_ReverseSlash = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_ReverseSlash"),
      key_Caps = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_Caps"),
      key_A = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_A"),
      key_S = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_S"),
      key_D = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_D"),
      key_F = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_F"),
      key_G = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_G"),
      key_H = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_H"),
      key_J = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_J"),
      key_K = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_K"),
      key_L = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_L"),
      key_Colon = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_Colon"),
      key_DubbleQuotes = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_DubbleQuotes"),
      key_Enter = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_Enter"),
      key_ShiftLeft = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_ShiftLeft"),
      key_Z = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_Z"),
      key_X = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_X"),
      key_C = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_C"),
      key_V = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_V"),
      key_B = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_B"),
      key_N = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_N"),
      key_M = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_M"),
      key_Comma = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_Comma"),
      key_Dot = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_Dot"),
      key_Question = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_Question"),
      key_ShiftRight = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_ShiftRight"),
      key_CtrlLeft = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_CtrlLeft"),
      key_WinLeft = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_WinLeft"),
      key_AltLeft = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_AltLeft"),
      key_Space = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_Space"),
      key_AltRight = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_AltRight"),
      key_WinRight = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_WinRight"),
      key_CtrlRight = UI.getChildControl(Panel_SetShortCut, "StaticText_Key_CtrlRight")
    },
    guideMsgBg = UI.getChildControl(Panel_SetShortCut, "Static_NotifyBg"),
    guideMsg = nil,
    noneSetKeyBG = UI.getChildControl(Panel_SetShortCut, "Static_BotBG"),
    noneSetKeyTitle = UI.getChildControl(Panel_SetShortCut, "Static_NoneSetKeyTitle"),
    noneSetKeyScroll = UI.getChildControl(Panel_SetShortCut, "Scroll_List"),
    btn_Close = UI.getChildControl(Panel_SetShortCut, "Button_Win_Close"),
    btn_Question = UI.getChildControl(Panel_SetShortCut, "Button_Question"),
    btn_UnSet = UI.getChildControl(Panel_SetShortCut, "Button_Key_Unset")
  },
  noneSetPool = {},
  noneSetDataArray = {},
  config = {
    tempKey = -1,
    tempType = false,
    noneSetCount = 0,
    noneSetUiCount = 6,
    noneSetUiGapX = 230,
    noneSetImportantCount = 0,
    noneSetStartIdx = 0
  },
  _shortCutType = eShortCutType.quickSlot,
  _defaultPanelSize = {x = 0, y = 0},
  _minusSizeY = 0,
  _easyShortCutMatch = {},
  _easySelectIdx = 0
}
local keyMatching = {
  [CppEnums.VirtualKeyCode.KeyCode_ESCAPE] = {
    ui = newShortCut.ui._key.key_ESC,
    isQuickEnable = false,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_F1] = {
    ui = newShortCut.ui._key.key_F1,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_F2] = {
    ui = newShortCut.ui._key.key_F2,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_F3] = {
    ui = newShortCut.ui._key.key_F3,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_F4] = {
    ui = newShortCut.ui._key.key_F4,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_F5] = {
    ui = newShortCut.ui._key.key_F5,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_F6] = {
    ui = newShortCut.ui._key.key_F6,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_F7] = {
    ui = newShortCut.ui._key.key_F7,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_F8] = {
    ui = newShortCut.ui._key.key_F8,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_F9] = {
    ui = newShortCut.ui._key.key_F9,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_F10] = {
    ui = newShortCut.ui._key.key_F10,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_F11] = {
    ui = newShortCut.ui._key.key_F11,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_F12] = {
    ui = newShortCut.ui._key.key_F12,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_OEM_3] = {
    ui = newShortCut.ui._key.key_Wave,
    isQuickEnable = false,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_1] = {
    ui = newShortCut.ui._key.key_1,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_2] = {
    ui = newShortCut.ui._key.key_2,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_3] = {
    ui = newShortCut.ui._key.key_3,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_4] = {
    ui = newShortCut.ui._key.key_4,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_5] = {
    ui = newShortCut.ui._key.key_5,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_6] = {
    ui = newShortCut.ui._key.key_6,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_7] = {
    ui = newShortCut.ui._key.key_7,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_8] = {
    ui = newShortCut.ui._key.key_8,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_9] = {
    ui = newShortCut.ui._key.key_9,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_0] = {
    ui = newShortCut.ui._key.key_0,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_SUBTRACT] = {
    ui = newShortCut.ui._key.key_Minus,
    isQuickEnable = false,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_ADD] = {
    ui = newShortCut.ui._key.key_Plus,
    isQuickEnable = false,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_BACK] = {
    ui = newShortCut.ui._key.key_BackSpace,
    isQuickEnable = false,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_TAB] = {
    ui = newShortCut.ui._key.key_Tab,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_Q] = {
    ui = newShortCut.ui._key.key_Q,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_W] = {
    ui = newShortCut.ui._key.key_W,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_E] = {
    ui = newShortCut.ui._key.key_E,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_R] = {
    ui = newShortCut.ui._key.key_R,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_T] = {
    ui = newShortCut.ui._key.key_T,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_Y] = {
    ui = newShortCut.ui._key.key_Y,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_U] = {
    ui = newShortCut.ui._key.key_U,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_I] = {
    ui = newShortCut.ui._key.key_I,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_O] = {
    ui = newShortCut.ui._key.key_O,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_P] = {
    ui = newShortCut.ui._key.key_P,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_CAPITAL] = {
    ui = newShortCut.ui._key.key_Caps,
    isQuickEnable = false,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_A] = {
    ui = newShortCut.ui._key.key_A,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_S] = {
    ui = newShortCut.ui._key.key_S,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_D] = {
    ui = newShortCut.ui._key.key_D,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_F] = {
    ui = newShortCut.ui._key.key_F,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_G] = {
    ui = newShortCut.ui._key.key_G,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_H] = {
    ui = newShortCut.ui._key.key_H,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_J] = {
    ui = newShortCut.ui._key.key_J,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_K] = {
    ui = newShortCut.ui._key.key_K,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_L] = {
    ui = newShortCut.ui._key.key_L,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_OEM_7] = {
    ui = newShortCut.ui._key.key_DubbleQuotes,
    isQuickEnable = false,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_RETURN] = {
    ui = newShortCut.ui._key.key_Enter,
    isQuickEnable = false,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_Z] = {
    ui = newShortCut.ui._key.key_Z,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_X] = {
    ui = newShortCut.ui._key.key_X,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_C] = {
    ui = newShortCut.ui._key.key_C,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_V] = {
    ui = newShortCut.ui._key.key_V,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_B] = {
    ui = newShortCut.ui._key.key_B,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_N] = {
    ui = newShortCut.ui._key.key_N,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_M] = {
    ui = newShortCut.ui._key.key_M,
    isQuickEnable = true,
    isEasyEnable = true
  },
  [CppEnums.VirtualKeyCode.KeyCode_OEM_2] = {
    ui = newShortCut.ui._key.key_Question,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_SHIFT] = {
    ui = newShortCut.ui._key.key_ShiftLeft,
    isQuickEnable = true,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_CONTROL] = {
    ui = newShortCut.ui._key.key_CtrlLeft,
    isQuickEnable = false,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_MENU] = {
    ui = newShortCut.ui._key.key_AltLeft,
    isQuickEnable = false,
    isEasyEnable = false
  },
  [CppEnums.VirtualKeyCode.KeyCode_SPACE] = {
    ui = newShortCut.ui._key.key_Space,
    isQuickEnable = true,
    isEasyEnable = false
  }
}
local keyString = {
  [CppEnums.VirtualKeyCode.KeyCode_ESCAPE] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Esc"),
  [CppEnums.VirtualKeyCode.KeyCode_F1] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F1"),
  [CppEnums.VirtualKeyCode.KeyCode_F2] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F2"),
  [CppEnums.VirtualKeyCode.KeyCode_F3] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F3"),
  [CppEnums.VirtualKeyCode.KeyCode_F4] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F4"),
  [CppEnums.VirtualKeyCode.KeyCode_F5] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F5"),
  [CppEnums.VirtualKeyCode.KeyCode_F6] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F6"),
  [CppEnums.VirtualKeyCode.KeyCode_F7] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F7"),
  [CppEnums.VirtualKeyCode.KeyCode_F8] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F8"),
  [CppEnums.VirtualKeyCode.KeyCode_F9] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F9"),
  [CppEnums.VirtualKeyCode.KeyCode_F10] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F10"),
  [CppEnums.VirtualKeyCode.KeyCode_F11] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F11"),
  [CppEnums.VirtualKeyCode.KeyCode_F12] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F12"),
  [CppEnums.VirtualKeyCode.KeyCode_OEM_3] = "OEM_3",
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
  [CppEnums.VirtualKeyCode.KeyCode_SUBTRACT] = "SUBTRACT",
  [CppEnums.VirtualKeyCode.KeyCode_ADD] = "ADD",
  [CppEnums.VirtualKeyCode.KeyCode_BACK] = "BACK",
  [CppEnums.VirtualKeyCode.KeyCode_TAB] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Tab"),
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
  [CppEnums.VirtualKeyCode.KeyCode_CAPITAL] = "CAPITAL",
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
  [CppEnums.VirtualKeyCode.KeyCode_RETURN] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Enter"),
  [CppEnums.VirtualKeyCode.KeyCode_SHIFT] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Shift"),
  [CppEnums.VirtualKeyCode.KeyCode_Z] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Z"),
  [CppEnums.VirtualKeyCode.KeyCode_X] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_X"),
  [CppEnums.VirtualKeyCode.KeyCode_C] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_C"),
  [CppEnums.VirtualKeyCode.KeyCode_V] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_V"),
  [CppEnums.VirtualKeyCode.KeyCode_B] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_B"),
  [CppEnums.VirtualKeyCode.KeyCode_N] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_N"),
  [CppEnums.VirtualKeyCode.KeyCode_M] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_M"),
  [CppEnums.VirtualKeyCode.KeyCode_OEM_2] = "/",
  [CppEnums.VirtualKeyCode.KeyCode_SHIFT] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Shift"),
  [CppEnums.VirtualKeyCode.KeyCode_CONTROL] = "CONTROL",
  [CppEnums.VirtualKeyCode.KeyCode_MENU] = "MENU",
  [CppEnums.VirtualKeyCode.KeyCode_SPACE] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Space")
}
local actionString = {
  [CppEnums.ActionInputType.ActionInputType_MoveFront] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_0"),
  [CppEnums.ActionInputType.ActionInputType_MoveBack] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_1"),
  [CppEnums.ActionInputType.ActionInputType_MoveLeft] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_2"),
  [CppEnums.ActionInputType.ActionInputType_MoveRight] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_3"),
  [CppEnums.ActionInputType.ActionInputType_Attack1] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_4"),
  [CppEnums.ActionInputType.ActionInputType_Attack2] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_5"),
  [CppEnums.ActionInputType.ActionInputType_Dash] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_6"),
  [CppEnums.ActionInputType.ActionInputType_Jump] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_7"),
  [CppEnums.ActionInputType.ActionInputType_Interaction] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_8"),
  [CppEnums.ActionInputType.ActionInputType_AutoRun] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_9"),
  [CppEnums.ActionInputType.ActionInputType_WeaponInOut] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_10"),
  [CppEnums.ActionInputType.ActionInputType_CameraReset] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_11"),
  [CppEnums.ActionInputType.ActionInputType_CrouchOrSkill] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_12"),
  [CppEnums.ActionInputType.ActionInputType_GrabOrGuard] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_13"),
  [CppEnums.ActionInputType.ActionInputType_Kick] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_14"),
  [CppEnums.ActionInputType.ActionInputType_ServantOrder1] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_15"),
  [CppEnums.ActionInputType.ActionInputType_ServantOrder2] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_16"),
  [CppEnums.ActionInputType.ActionInputType_ServantOrder3] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_17"),
  [CppEnums.ActionInputType.ActionInputType_ServantOrder4] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_18"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot1] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_19"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot2] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_20"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot3] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_21"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot4] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_22"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot5] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_23"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot6] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_24"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot7] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_25"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot8] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_26"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot9] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_27"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot10] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_28"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot11] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_29"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot12] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_30"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot13] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_31"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot14] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_32"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot15] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_33"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot16] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_34"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot17] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_35"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot18] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_36"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot19] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_37"),
  [CppEnums.ActionInputType.ActionInputType_QuickSlot20] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_38"),
  [CppEnums.ActionInputType.ActionInputType_Complicated0] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_39"),
  [CppEnums.ActionInputType.ActionInputType_Complicated1] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_40"),
  [CppEnums.ActionInputType.ActionInputType_Complicated2] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_41"),
  [CppEnums.ActionInputType.ActionInputType_Complicated3] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_42"),
  [CppEnums.ActionInputType.ActionInputType_AutoMoveWalkMode] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_43"),
  [CppEnums.ActionInputType.ActionInputType_CameraUp] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_44"),
  [CppEnums.ActionInputType.ActionInputType_CameraDown] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_45"),
  [CppEnums.ActionInputType.ActionInputType_CameraLeft] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_46"),
  [CppEnums.ActionInputType.ActionInputType_CameraRight] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_47"),
  [CppEnums.ActionInputType.ActionInputType_CameraRotateGameMode] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_48"),
  [CppEnums.ActionInputType.ActionInputType_PushToTalk] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_49"),
  [CppEnums.ActionInputType.ActionInputType_Undefined] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_00")
}
local uiString = {
  [__eUiInputType_CursorOnOff] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_0"),
  [__eUiInputType_Help] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_1"),
  [__eUiInputType_MentalKnowledge] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_2"),
  [__eUiInputType_Inventory] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_3"),
  [__eUiInputType_BlackSpirit] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_4"),
  [__eUiInputType_Chat] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_5"),
  [__eUiInputType_PlayerInfo] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_6"),
  [__eUiInputType_Skill] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_7"),
  [__eUiInputType_WorldMap] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_8"),
  [__eUiInputType_Dyeing] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_9"),
  [__eUiInputType_ProductionNote] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_10"),
  [__eUiInputType_Manufacture] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_11"),
  [__eUiInputType_Guild] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_12"),
  [__eUiInputType_Mail] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_13"),
  [__eUiInputType_FriendList] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_14"),
  [__eUiInputType_Present] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_15"),
  [__eUiInputType_QuestHistory] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_16"),
  [__eUiInputType_Cancel] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_17"),
  [__eUiInputType_CashShop] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_18"),
  [__eUiInputType_BeautyShop] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_19"),
  [__eUiInputType_AlchemyStone] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_20"),
  [__eUiInputType_House] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_21"),
  [__eUiInputType_Worker] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_22"),
  [__eUiInputType_Pet] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_23"),
  [__eUiInputType_Maid] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_24"),
  [__eUiInputType_Servant] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_25"),
  [__eUiInputType_GuildServant] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_26")
}
local shortCutType = {action = 0, ui = 1}
local defaultShortCut = {
  [CppEnums.ContryCode.eContryCode_KOR] = {
    [shortCutType.action] = {
      [CppEnums.ActionInputType.ActionInputType_MoveFront] = CppEnums.VirtualKeyCode.KeyCode_W,
      [CppEnums.ActionInputType.ActionInputType_MoveBack] = CppEnums.VirtualKeyCode.KeyCode_S,
      [CppEnums.ActionInputType.ActionInputType_MoveLeft] = CppEnums.VirtualKeyCode.KeyCode_A,
      [CppEnums.ActionInputType.ActionInputType_MoveRight] = CppEnums.VirtualKeyCode.KeyCode_D,
      [CppEnums.ActionInputType.ActionInputType_Attack1] = CppEnums.VirtualKeyCode.KeyCode_LBUTTON,
      [CppEnums.ActionInputType.ActionInputType_Attack2] = CppEnums.VirtualKeyCode.KeyCode_RBUTTON,
      [CppEnums.ActionInputType.ActionInputType_Dash] = CppEnums.VirtualKeyCode.KeyCode_SHIFT,
      [CppEnums.ActionInputType.ActionInputType_Jump] = CppEnums.VirtualKeyCode.KeyCode_SPACE,
      [CppEnums.ActionInputType.ActionInputType_Interaction] = CppEnums.VirtualKeyCode.KeyCode_R,
      [CppEnums.ActionInputType.ActionInputType_AutoRun] = CppEnums.VirtualKeyCode.KeyCode_T,
      [CppEnums.ActionInputType.ActionInputType_WeaponInOut] = CppEnums.VirtualKeyCode.KeyCode_TAB,
      [CppEnums.ActionInputType.ActionInputType_CameraReset] = nil,
      [CppEnums.ActionInputType.ActionInputType_CrouchOrSkill] = CppEnums.VirtualKeyCode.KeyCode_Q,
      [CppEnums.ActionInputType.ActionInputType_GrabOrGuard] = CppEnums.VirtualKeyCode.KeyCode_E,
      [CppEnums.ActionInputType.ActionInputType_Kick] = CppEnums.VirtualKeyCode.KeyCode_F,
      [CppEnums.ActionInputType.ActionInputType_ServantOrder1] = CppEnums.VirtualKeyCode.KeyCode_Z,
      [CppEnums.ActionInputType.ActionInputType_ServantOrder2] = CppEnums.VirtualKeyCode.KeyCode_X,
      [CppEnums.ActionInputType.ActionInputType_ServantOrder3] = CppEnums.VirtualKeyCode.KeyCode_C,
      [CppEnums.ActionInputType.ActionInputType_ServantOrder4] = CppEnums.VirtualKeyCode.KeyCode_V,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot1] = CppEnums.VirtualKeyCode.KeyCode_0,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot2] = CppEnums.VirtualKeyCode.KeyCode_1,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot3] = CppEnums.VirtualKeyCode.KeyCode_2,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot4] = CppEnums.VirtualKeyCode.KeyCode_3,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot5] = CppEnums.VirtualKeyCode.KeyCode_4,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot6] = CppEnums.VirtualKeyCode.KeyCode_5,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot7] = CppEnums.VirtualKeyCode.KeyCode_6,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot8] = CppEnums.VirtualKeyCode.KeyCode_7,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot9] = CppEnums.VirtualKeyCode.KeyCode_8,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot10] = CppEnums.VirtualKeyCode.KeyCode_9,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot11] = nil,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot12] = nil,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot13] = nil,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot14] = nil,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot15] = nil,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot16] = nil,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot17] = nil,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot18] = nil,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot19] = nil,
      [CppEnums.ActionInputType.ActionInputType_QuickSlot20] = nil
    },
    [shortCutType.ui] = {
      [__eUiInputType_CursorOnOff] = CppEnums.VirtualKeyCode.KeyCode_CONTROL,
      [__eUiInputType_Help] = CppEnums.VirtualKeyCode.KeyCode_F1,
      [__eUiInputType_MentalKnowledge] = CppEnums.VirtualKeyCode.KeyCode_H,
      [__eUiInputType_Inventory] = CppEnums.VirtualKeyCode.KeyCode_I,
      [__eUiInputType_BlackSpirit] = CppEnums.VirtualKeyCode.KeyCode_OEM_2,
      [__eUiInputType_Chat] = CppEnums.VirtualKeyCode.KeyCode_RETURN,
      [__eUiInputType_PlayerInfo] = CppEnums.VirtualKeyCode.KeyCode_P,
      [__eUiInputType_Skill] = CppEnums.VirtualKeyCode.KeyCode_K,
      [__eUiInputType_WorldMap] = CppEnums.VirtualKeyCode.KeyCode_M,
      [__eUiInputType_Dyeing] = CppEnums.VirtualKeyCode.KeyCode_J,
      [__eUiInputType_ProductionNote] = CppEnums.VirtualKeyCode.KeyCode_F2,
      [__eUiInputType_Manufacture] = CppEnums.VirtualKeyCode.KeyCode_L,
      [__eUiInputType_Guild] = CppEnums.VirtualKeyCode.KeyCode_G,
      [__eUiInputType_Mail] = CppEnums.VirtualKeyCode.KeyCode_B,
      [__eUiInputType_FriendList] = CppEnums.VirtualKeyCode.KeyCode_N,
      [__eUiInputType_Present] = CppEnums.VirtualKeyCode.KeyCode_Y,
      [__eUiInputType_QuestHistory] = CppEnums.VirtualKeyCode.KeyCode_O,
      [__eUiInputType_Cancel] = CppEnums.VirtualKeyCode.KeyCode_ESCAPE,
      [__eUiInputType_CashShop] = CppEnums.VirtualKeyCode.KeyCode_F3,
      [__eUiInputType_BeautyShop] = CppEnums.VirtualKeyCode.KeyCode_F4,
      [__eUiInputType_AlchemyStone] = CppEnums.VirtualKeyCode.KeyCode_U,
      [__eUiInputType_House] = nil,
      [__eUiInputType_Worker] = nil,
      [__eUiInputType_Pet] = nil,
      [__eUiInputType_Maid] = nil,
      [__eUiInputType_Servant] = nil,
      [__eUiInputType_GuildServant] = nil
    }
  },
  [CppEnums.ContryCode.eContryCode_JAP] = {
    [shortCutType.action] = {},
    [shortCutType.ui] = {}
  },
  [CppEnums.ContryCode.eContryCode_RUS] = {
    [shortCutType.action] = {},
    [shortCutType.ui] = {}
  },
  [CppEnums.ContryCode.eContryCode_KR2] = {
    [shortCutType.action] = {},
    [shortCutType.ui] = {}
  },
  [CppEnums.ContryCode.eContryCode_NA] = {
    [shortCutType.action] = {},
    [shortCutType.ui] = {}
  }
}
local myKey = {
  action = {},
  ui = {}
}
function newShortCut:SetDefaultKey()
  for key, value in pairs(keyMatching) do
    local isDefine = keyCustom_IsDefine(key)
    if false == isDefine then
    else
      local actionKey = keyCustom_getDefineAction(key)
      if actionKey <= CppEnums.ActionInputType.ActionInputType_Undefined then
        myKey.action = {enums = actionKey, virtualKeyCode = key}
      else
        local uiKey = keyCustom_getDefineUI(key)
        if uiKey <= __eUiInputType_Undefined then
          myKey.ui = {enums = actionKey, virtualKeyCode = key}
        else
        end
      end
    end
  end
end
function newShortCut:Init()
  self.ui.guideMsg = UI.getChildControl(self.ui.guideMsgBg, "Static_NotifyText")
  for k, value in pairs(newShortCut.ui._key) do
    value:SetIgnore(true)
  end
  for noneSetIdx = 0, self.config.noneSetUiCount - 1 do
    local tempArray = {}
    tempArray.keyDesc = UI.createAndCopyBasePropertyControl(Panel_SetShortCut, "StaticText_SelectValue", self.ui.noneSetKeyBG, "SetShortCut_noneSetKeyDesc_" .. noneSetIdx)
    tempArray.btn = UI.createAndCopyBasePropertyControl(Panel_SetShortCut, "StaticText_SelectButton", tempArray.keyDesc, "SetShortCut_noneSetKeyBtn_" .. noneSetIdx)
    tempArray.keyDesc:SetPosX(10 + noneSetIdx % 2 * self.config.noneSetUiGapX)
    tempArray.keyDesc:SetPosY(33 + (tempArray.keyDesc:GetSizeY() + 5) * math.floor(noneSetIdx / 2))
    tempArray.btn:SetPosX(145)
    tempArray.btn:SetPosY(0)
    tempArray.keyDesc:addInputEvent("Mouse_UpScroll", "newShortCut_NoneSetScroll( true )")
    tempArray.keyDesc:addInputEvent("Mouse_DownScroll", "newShortCut_NoneSetScroll( false )")
    tempArray.btn:addInputEvent("Mouse_UpScroll", "newShortCut_NoneSetScroll( true )")
    tempArray.btn:addInputEvent("Mouse_DownScroll", "newShortCut_NoneSetScroll( false )")
    self.noneSetPool[noneSetIdx] = tempArray
  end
  self._defaultPanelSize.x = Panel_SetShortCut:GetSizeX()
  self._defaultPanelSize.y = Panel_SetShortCut:GetSizeY()
  self._minusSizeY = self.ui.noneSetKeyBG:GetSizeY()
  if true == isGameTypeKR2() then
    self.ui.btn_Question:SetShow(false)
  end
end
function newShortCut:Update()
  if eShortCutType.quickSlot == self._shortCutType then
    self:updateQuickSlot()
  elseif eShortCutType.easyShortcut == self._shortCutType then
    self:updateEasyShortCut()
  end
end
function newShortCut:updateQuickSlot()
  for key, value in pairs(keyMatching) do
    local isDefine = keyCustom_IsDefine(key)
    if false == isDefine then
      value.ui:SetFontColor(UI_color.C_FFEFEFEF)
    else
      local actionKey = keyCustom_getDefineAction(key)
      if actionKey <= CppEnums.ActionInputType.ActionInputType_Undefined then
        value.ui:SetFontColor(UI_color.C_FFEF5378)
        value.ui:addInputEvent("Mouse_On", "HandleOnOut_newShortCut_ActionKeyToolTip( true, true, " .. actionKey .. ", " .. key .. " )")
        value.ui:addInputEvent("Mouse_Out", "HandleOnOut_newShortCut_ActionKeyToolTip( false, true, " .. actionKey .. ", " .. key .. " )")
        value.ui:setTooltipEventRegistFunc("HandleOnOut_newShortCut_ActionKeyToolTip( true, true, " .. actionKey .. ", " .. key .. " )")
      else
        local uiKey = keyCustom_getDefineUI(key)
        if uiKey <= __eUiInputType_Undefined then
          value.ui:SetFontColor(UI_color.C_FF8EBD00)
          value.ui:addInputEvent("Mouse_On", "HandleOnOut_newShortCut_ActionKeyToolTip( true, false, " .. uiKey .. ", " .. key .. " )")
          value.ui:addInputEvent("Mouse_Out", "HandleOnOut_newShortCut_ActionKeyToolTip( false, false, " .. uiKey .. ", " .. key .. " )")
          value.ui:setTooltipEventRegistFunc("HandleOnOut_newShortCut_ActionKeyToolTip( true, false, " .. uiKey .. ", " .. key .. " )")
        else
          _PA_ASSERT(true, "\236\181\156\235\140\128\237\152\184 : \237\130\164\234\176\128 \236\132\164\236\160\149\235\144\152\236\150\180 \236\158\136\235\139\164\235\169\180, \236\149\161\236\133\152\236\157\180\235\130\152 UI \236\164\145 \237\149\152\235\130\152\236\151\172\236\149\188 \237\149\152\235\138\148\235\141\176 ???")
        end
      end
    end
    if true == value.isQuickEnable then
      value.ui:SetIgnore(false)
      value.ui:SetEnable(true)
    else
      value.ui:SetIgnore(true)
      value.ui:SetEnable(false)
      value.ui:SetFontColor(UI_color.C_FF888888)
    end
  end
  if true == isGameTypeKR2() then
    self:updateNoneSetKey(false)
  else
    self:updateNoneSetKey(true)
    self:UpdateNoneSetKey()
  end
end
function newShortCut:updateEasyShortCut()
  local count = ToClent_getButtonShortcutsEventCount()
  for idx = 0, count - 1 do
    local data = ToClent_getButtonShortcutsEventAt(idx)
    if 0 ~= data:getKeyCode() then
      self._easyShortCutMatch[data:getKeyCode()] = idx
    end
  end
  for key, value in pairs(keyMatching) do
    value.ui:SetFontColor(UI_color.C_FFEFEFEF)
    if nil ~= self._easyShortCutMatch[key] then
      value.ui:SetFontColor(UI_color.C_FF8EBD00)
      value.ui:addInputEvent("Mouse_On", "HandleOnOut_newShortCut_EasyShortCutToolTip(true, " .. key .. ")")
      value.ui:addInputEvent("Mouse_Out", "HandleOnOut_newShortCut_EasyShortCutToolTip(false, " .. key .. ")")
      value.ui:setTooltipEventRegistFunc("HandleOnOut_newShortCut_EasyShortCutToolTip(true, " .. key .. ")")
    end
    if true == value.isEasyEnable then
      value.ui:SetIgnore(false)
      value.ui:SetEnable(true)
    else
      value.ui:SetIgnore(true)
      value.ui:SetEnable(false)
      value.ui:SetFontColor(UI_color.C_FF888888)
    end
  end
  self:updateNoneSetKey(false)
  local selectData = ToClent_getButtonShortcutsEventAt(self._easySelectIdx)
  self.ui.guideMsg:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SHORTCUT_GUIDEMESSAGE", "button", selectData:getButtonString()))
  UI.setLimitAutoWrapTextAndAddTooltip(self.ui.guideMsg, 2)
end
function newShortCut:updateNoneSetKey(isShow)
  self.ui.noneSetKeyTitle:SetShow(isShow)
  self.ui.noneSetKeyBG:SetShow(isShow)
  if true == isShow then
    Panel_SetShortCut:SetSize(self._defaultPanelSize.x, self._defaultPanelSize.y)
  else
    Panel_SetShortCut:SetSize(self._defaultPanelSize.x, self._defaultPanelSize.y - self._minusSizeY)
    self.ui.noneSetKeyScroll:SetShow(false)
  end
end
function newShortCut:UpdateNoneSetKey()
  for idx = 0, self.config.noneSetUiCount - 1 do
    local slot = self.noneSetPool[idx]
    slot.keyDesc:SetShow(false)
  end
  self.noneSetDataArray = {}
  self.config.noneSetCount = 0
  self.config.noneSetImportantCount = 0
  for idx = 0, CppEnums.ActionInputType.ActionInputType_Undefined - 1 do
    local checkValue = keyCustom_GetString_ActionKey(idx)
    if "" == checkValue then
      local isImportant = self:CheckImportantShortCut(true, idx)
      if 1 == isImportant then
        self.config.noneSetImportantCount = self.config.noneSetImportantCount + 1
      end
      self.noneSetDataArray[self.config.noneSetCount] = {
        isAction = true,
        idx = idx,
        important = isImportant
      }
      self.config.noneSetCount = self.config.noneSetCount + 1
    end
  end
  for idx = 0, __eUiInputType_Undefined - 1 do
    local checkValue = keyCustom_GetString_UiKey(idx)
    if "" == checkValue then
      local isImportant = self:CheckImportantShortCut(false, idx)
      if 1 == isImportant then
        self.config.noneSetImportantCount = self.config.noneSetImportantCount + 1
      end
      self.noneSetDataArray[self.config.noneSetCount] = {
        isAction = false,
        idx = idx,
        important = isImportant
      }
      self.config.noneSetCount = self.config.noneSetCount + 1
    end
  end
  local noneSetKetSort = function(a, b)
    if b.important < a.important then
      return true
    else
      return false
    end
  end
  table.sort(self.noneSetDataArray, noneSetKetSort)
  local uiIdx = 0
  for idx = self.config.noneSetStartIdx, self.config.noneSetCount - 1 do
    if uiIdx >= self.config.noneSetUiCount then
      break
    end
    local data = self.noneSetDataArray[idx]
    local _string = ""
    if data.isAction then
      _string = actionString[data.idx]
    else
      _string = uiString[data.idx]
    end
    if nil == _string then
      _string = ""
    end
    local slot = self.noneSetPool[uiIdx]
    if 1 == data.important then
      slot.keyDesc:SetFontColor(UI_color.C_FFF26A6A)
      slot.btn:SetFontColor(UI_color.C_FFF26A6A)
      _string = PAGetString(Defines.StringSheet_GAME, "LUA_SETSHORTCUT_NECESSARY") .. " " .. _string
    else
      slot.keyDesc:SetFontColor(UI_color.C_FFEFEFEF)
      slot.btn:SetFontColor(UI_color.C_FFEFEFEF)
    end
    slot.keyDesc:SetText(_string)
    slot.keyDesc:SetShow(true)
    slot.btn:addInputEvent("Mouse_LUp", "HandleClicked_NewShortCut_SetImportantKey( " .. idx .. ", " .. data.idx .. " )")
    uiIdx = uiIdx + 1
  end
  UIScroll.SetButtonSize(self.ui.noneSetKeyScroll, self.config.noneSetUiCount / 2, self.config.noneSetCount / 2)
  if self.config.noneSetCount > 6 then
    self.ui.noneSetKeyScroll:SetShow(true)
  else
    self.ui.noneSetKeyScroll:SetShow(false)
  end
end
function newShortCut:CheckImportantShortCut(isAction, key)
  if isAction then
    if key == CppEnums.ActionInputType.ActionInputType_MoveFront or key == CppEnums.ActionInputType.ActionInputType_MoveBack or key == CppEnums.ActionInputType.ActionInputType_MoveLeft or key == CppEnums.ActionInputType.ActionInputType_MoveRight or key == CppEnums.ActionInputType.ActionInputType_Attack1 or key == CppEnums.ActionInputType.ActionInputType_Attack2 or key == CppEnums.ActionInputType.ActionInputType_Dash or key == CppEnums.ActionInputType.ActionInputType_Jump or key == CppEnums.ActionInputType.ActionInputType_Interaction or key == CppEnums.ActionInputType.ActionInputType_CrouchOrSkill or key == CppEnums.ActionInputType.ActionInputType_GrabOrGuard or key == CppEnums.ActionInputType.ActionInputType_Kick or key == CppEnums.ActionInputType.ActionInputType_QuickSlot1 or key == CppEnums.ActionInputType.ActionInputType_QuickSlot2 or key == CppEnums.ActionInputType.ActionInputType_QuickSlot3 or key == CppEnums.ActionInputType.ActionInputType_QuickSlot4 or key == CppEnums.ActionInputType.ActionInputType_QuickSlot5 or key == CppEnums.ActionInputType.ActionInputType_QuickSlot6 or key == CppEnums.ActionInputType.ActionInputType_QuickSlot7 or key == CppEnums.ActionInputType.ActionInputType_QuickSlot8 or key == CppEnums.ActionInputType.ActionInputType_QuickSlot9 or key == CppEnums.ActionInputType.ActionInputType_QuickSlot10 then
      return 1
    end
  elseif key == __eUiInputType_Inventory or key == __eUiInputType_BlackSpirit or key == __eUiInputType_Chat or key == __eUiInputType_PlayerInfo or key == __eUiInputType_Skill or key == __eUiInputType_WorldMap or key == __eUiInputType_Manufacture or key == __eUiInputType_Guild or key == __eUiInputType_Mail or key == __eUiInputType_FriendList or key == __eUiInputType_QuestHistory or key == __eUiInputType_Cancel or key == __eUiInputType_CashShop or key == __eUiInputType_BeautyShop or key == __eUiInputType_AlchemyStone or key == __eUiInputType_House or key == __eUiInputType_Worker or key == __eUiInputType_Pet or key == __eUiInputType_Maid or key == __eUiInputType_Servant or key == __eUiInputType_GuildServant then
    return 1
  end
  return 0
end
function newShortCut:Open(eShortCutType)
  Panel_SetShortCut:SetShow(true)
  self._shortCutType = eShortCutType
  self:Update()
end
function newShortCut:Close()
  if false == Panel_SetShortCut:GetShow() then
    return
  end
  self.config.tempKey = -1
  self.config.tempType = false
  if Panel_Tooltip_SimpleText:GetShow() then
    TooltipSimple_Hide()
  end
  if eShortCutType.easyShortcut == self._shortCutType then
    PaGlobal_ButtonShortcuts_All_CurrentRefresh()
  end
  Panel_SetShortCut:SetShow(false)
end
function FGlobal_NewShortCut_SetQuickSlot(actionKey, isActionType)
  newShortCut.config.tempKey = actionKey
  newShortCut.config.tempType = isActionType
  newShortCut:Open(eShortCutType.quickSlot)
  local targetKeyString = ""
  if newShortCut.config.tempType then
    targetKeyString = actionString[newShortCut.config.tempKey]
  else
    targetKeyString = uiString[newShortCut.config.tempKey]
  end
  newShortCut.ui.guideMsg:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SETSHORTCUT_SELECTKEY", "key", targetKeyString))
end
function PaGlobal_NewShortCut_SetEasyShortCut(selectIdx)
  if false == _ContentsGroup_NewUI_ButtonShortcuts_All then
    return
  end
  newShortCut._easySelectIdx = selectIdx
  newShortCut._easyShortCutMatch = {}
  newShortCut:Open(eShortCutType.easyShortcut)
end
function FGlobal_NewShortCut_Close()
  newShortCut:Close()
end
function HandleClicked_NewShortCut_Close()
  newShortCut:Close()
end
function HandleClicked_NewShortCut_SetImportantKey(dataIdx, index)
  local data = newShortCut.noneSetDataArray[dataIdx]
  local string = ""
  if data.isAction then
    string = actionString[data.idx]
  else
    string = uiString[data.idx]
  end
  newShortCut.config.tempKey = data.idx
  newShortCut.config.tempType = data.isAction
  newShortCut.ui.guideMsg:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SETSHORTCUT_SELECTKEY", "key", string))
end
function HandleOnOut_newShortCut_ActionKeyToolTip(isShow, isAction, keyIdx, uiIdx)
  local keyString
  if isAction then
    keyString = actionString[keyIdx]
  else
    keyString = uiString[keyIdx]
  end
  local control = keyMatching[uiIdx].ui
  if isShow then
    registTooltipControl(control, Panel_Tooltip_SimpleText)
    if nil ~= keyString then
      TooltipSimple_Show(control, keyString, nil)
    end
  else
    TooltipSimple_Hide()
  end
end
function HandleOnOut_newShortCut_EasyShortCutToolTip(isShow, keyCode)
  local easyIdx = newShortCut._easyShortCutMatch[keyCode]
  if false == isShow or nil == easyIdx then
    TooltipSimple_Hide()
    return
  end
  local data = ToClent_getButtonShortcutsEventAt(easyIdx)
  local control = keyMatching[keyCode].ui
  TooltipSimple_Show(control, data:getButtonString(), nil)
end
function HandleClicked_NewShortCutPushed(virtualKeyCode)
  if eShortCutType.quickSlot == newShortCut._shortCutType then
    HandleClicked_NewShortCut_QuickCutPushed(virtualKeyCode)
  elseif eShortCutType.easyShortcut == newShortCut._shortCutType then
    HandleClicked_NewShortCut_EsayCutPushed(virtualKeyCode)
  end
end
function HandleClicked_NewShortCut_QuickCutPushed(virtualKeyCode)
  if -1 ~= newShortCut.config.tempKey then
    local function doSetKey()
      _NewShortCutPushed(virtualKeyCode)
    end
    local pressedKeyString = keyString[virtualKeyCode]
    local targetKeyString = ""
    if newShortCut.config.tempType then
      targetKeyString = actionString[newShortCut.config.tempKey]
    else
      targetKeyString = uiString[newShortCut.config.tempKey]
    end
    local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SETSHORTCUT_SURETHISKEY", "press", pressedKeyString, "string", targetKeyString)
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = doSetKey,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function HandleClicked_NewShortCut_EsayCutPushed(virtualKeyCode)
  PaGlobalFunc_ButtonShorcuts_All_Register(virtualKeyCode)
end
function HandleClicked_NewShortCut_Unset()
  if eShortCutType.quickSlot == newShortCut._shortCutType then
    newShortCut:handleEventUnset_quickslot()
  elseif eShortCutType.easyShortcut == newShortCut._shortCutType then
    newShortCut:handleEventUnset_easyShortcut()
  end
end
function newShortCut:handleEventUnset_quickslot()
  local string = ""
  if true == newShortCut.config.tempType then
    string = actionString[newShortCut.config.tempKey]
  else
    string = uiString[newShortCut.config.tempKey]
  end
  local function doUnSet()
    if true == newShortCut.config.tempType then
      keyCustom_clearActionVirtualKeyCode(newShortCut.config.tempKey)
    else
      keyCustom_clearUIVirtualKeyCode(newShortCut.config.tempKey)
    end
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SETSHORTCUT_DELETEKEY", "key", string))
    newShortCut:Close()
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SETSHORTCUT_SUREDELETEKEY", "key", string)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = doUnSet,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function newShortCut:handleEventUnset_easyShortcut()
  local selectData = ToClent_getButtonShortcutsEventAt(self._easySelectIdx)
  local string = selectData:getButtonString()
  local function doUnSet()
    PaGlobalFunc_ButtonShorcuts_All_RemoveByGlobalKeyBinder()
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SETSHORTCUT_DELETEKEY", "key", string))
    newShortCut:Close()
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SETSHORTCUT_SUREDELETEKEY", "key", string)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = doUnSet,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function _NewShortCutPushed(virtualKeyCode)
  if true == newShortCut.config.tempType then
    keyCustom_CheckAndSet_ActionKeyUseVirtualKeyCode(newShortCut.config.tempKey, virtualKeyCode)
  else
    keyCustom_CheckAndSet_UiKeyUseVirtualKeyCode(newShortCut.config.tempKey, virtualKeyCode)
  end
  keyCustom_applyChange()
  newShortCut:Update()
  FGlobal_NewQuickSlot_Update()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SETSHORTCUT_COMPLETESETKEY"))
  newShortCut.config.tempKey = -1
  newShortCut:Close()
end
function newShortCut_NoneSetScroll(isScrollUp)
  newShortCut.config.noneSetStartIdx = UIScroll.ScrollEvent(newShortCut.ui.noneSetKeyScroll, isScrollUp, newShortCut.config.noneSetUiCount / 2, newShortCut.config.noneSetCount, newShortCut.config.noneSetStartIdx, 2)
  newShortCut:UpdateNoneSetKey()
end
function newShortCut:registEventHandler()
  for key, value in pairs(keyMatching) do
    value.ui:addInputEvent("Mouse_LUp", "HandleClicked_NewShortCutPushed( " .. key .. " )")
  end
  self.ui.noneSetKeyBG:addInputEvent("Mouse_UpScroll", "newShortCut_NoneSetScroll( true )")
  self.ui.noneSetKeyBG:addInputEvent("Mouse_DownScroll", "newShortCut_NoneSetScroll( false )")
  self.ui.btn_UnSet:addInputEvent("Mouse_LUp", "HandleClicked_NewShortCut_Unset()")
  self.ui.btn_Close:addInputEvent("Mouse_LUp", "HandleClicked_NewShortCut_Close()")
  if isGameTypeEnglish() then
    self.ui.btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"QuickSlot\" )")
  end
end
newShortCut:Init()
newShortCut:registEventHandler()
