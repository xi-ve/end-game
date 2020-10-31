PaGlobal_DialogList_All = {
  _ui = {
    stc_titleBg = nil,
    stc_title = nil,
    stc_titleDeco = nil,
    stc_splitTabBg = nil,
    btn_splitRadiolist = {},
    stc_selectBar = nil,
    list2_button = nil,
    stc_subBg = nil
  },
  _ui_pc = {stc_listKeyGuideBg = nil, txt_listKeyGuide = nil},
  _ui_console = {
    stc_bottomBg = nil,
    stc_iconA = nil,
    stc_iconB = nil,
    stc_iconLB = nil,
    stc_iconRB = nil
  },
  _dialogQuestButtonIcon = {
    [0] = {
      texture = "Combine/Etc/Combine_Etc_Quest_00.dds",
      x1 = 42,
      y1 = 103,
      x2 = 82,
      y2 = 143
    },
    [1] = {
      texture = "Combine/Etc/Combine_Etc_Quest_00.dds",
      x1 = 288,
      y1 = 103,
      x2 = 328,
      y2 = 143
    },
    [2] = {
      texture = "Combine/Etc/Combine_Etc_Quest_00.dds",
      x1 = 247,
      y1 = 103,
      x2 = 287,
      y2 = 143
    },
    [3] = {
      texture = "Combine/Etc/Combine_Etc_Quest_00.dds",
      x1 = 124,
      y1 = 103,
      x2 = 164,
      y2 = 143
    },
    [4] = {
      texture = "Combine/Etc/Combine_Etc_Quest_00.dds",
      x1 = 165,
      y1 = 103,
      x2 = 205,
      y2 = 143
    },
    [5] = {
      texture = "Combine/Etc/Combine_Etc_Quest_00.dds",
      x1 = 206,
      y1 = 103,
      x2 = 246,
      y2 = 143
    },
    [6] = {
      texture = "Combine/Etc/Combine_Etc_Quest_00.dds",
      x1 = 83,
      y1 = 103,
      x2 = 123,
      y2 = 143
    },
    [7] = {
      texture = "CRenewal/UI_Icon/Console_Icon_02.dds",
      x1 = 156,
      y1 = 229,
      x2 = 186,
      y2 = 259
    },
    [8] = {
      texture = "Combine/Etc/Combine_Etc_Quest_00.dds",
      x1 = 1,
      y1 = 103,
      x2 = 41,
      y2 = 143
    },
    [9] = {
      texture = "Renewal/UI_Icon/Console_Icon_02.dds",
      x1 = 125,
      y1 = 229,
      x2 = 155,
      y2 = 259
    },
    [10] = {
      texture = "Renewal/UI_Icon/Console_Icon_02.dds",
      x1 = 0,
      y1 = 0,
      x2 = 1,
      y2 = 1
    },
    [11] = {
      texture = "Renewal/UI_Icon/Console_Icon_02.dds",
      x1 = 0,
      y1 = 0,
      x2 = 1,
      y2 = 1
    }
  },
  _dialogButtonIcon = {
    [0] = {
      texture = "Combine/Icon/Combine_Dialogue_Icon_00.dds",
      x1 = 319,
      y1 = 339,
      x2 = 349,
      y2 = 369
    },
    [1] = {
      texture = "Combine/Icon/Combine_Dialogue_Icon_00.dds",
      x1 = 412,
      y1 = 339,
      x2 = 442,
      y2 = 369
    },
    [2] = {
      texture = "Combine/Icon/Combine_Dialogue_Icon_00.dds",
      x1 = 443,
      y1 = 339,
      x2 = 473,
      y2 = 369
    },
    [3] = {
      texture = "Combine/Icon/Combine_Dialogue_Icon_00.dds",
      x1 = 381,
      y1 = 339,
      x2 = 411,
      y2 = 369
    },
    [4] = {
      texture = "Combine/Icon/Combine_Dialogue_Icon_00.dds",
      x1 = 350,
      y1 = 339,
      x2 = 380,
      y2 = 369
    },
    [5] = {
      texture = "Combine/Icon/Combine_Dialogue_Icon_00.dds",
      x1 = 350,
      y1 = 339,
      x2 = 380,
      y2 = 369
    },
    [6] = {
      texture = "Renewal/UI_Icon/Console_DialogueIcon_00.dds",
      x1 = 218,
      y1 = 1,
      x2 = 248,
      y2 = 31
    }
  },
  _dialogTitleType = {
    [CppEnums.DialogState.eDialogState_Talk] = {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_LIST_ALL_WINDOWTITLE_TALK"),
      texture = "combine/icon/combine_title_icon_00.dds",
      x1 = 230,
      y1 = 230,
      x2 = 285,
      y2 = 285
    },
    [CppEnums.DialogState.eDialogState_QuestList] = {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_LIST_ALL_WINDOWTITLE_QUEST"),
      texture = "combine/icon/combine_title_icon_00.dds",
      x1 = 59,
      y1 = 2,
      x2 = 114,
      y2 = 57
    },
    [CppEnums.DialogState.eDialogState_Help] = {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_LIST_ALL_WINDOWTITLE_HELP"),
      texture = "combine/icon/combine_title_icon_00.dds",
      x1 = 59,
      y1 = 2,
      x2 = 114,
      y2 = 57
    },
    [CppEnums.DialogState.eDialogState_Exchange] = {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_LIST_ALL_WINDOWTITLE_EXCHANGE"),
      texture = "combine/icon/combine_title_icon_00.dds",
      x1 = 230,
      y1 = 230,
      x2 = 285,
      y2 = 285
    },
    [CppEnums.DialogState.eDialogState_MainQuestList] = {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_LIST_ALL_WINDOWTITLE_MAINQUEST"),
      texture = "combine/icon/combine_dialogue_icon_00.dds",
      x1 = 83,
      y1 = 452,
      x2 = 123,
      y2 = 492
    }
  },
  _dialogListCount = 0,
  _listShowMaxCount = 0,
  _listContentSizeY = 0,
  _listOriginSizeY = 0,
  _panelOriginSizeY = 0,
  _isQuestComplete = false,
  _isContactTalk = false,
  _btnSplitString = {},
  _splitIdx = 0,
  _SPLIT_IDX = {
    ALL = 0,
    RECOMMENDATION = 1,
    REPEAT = 2,
    MAIN = 3
  },
  _moveAblelist = {},
  _listKeyGuideString = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_LIST_KEYGUIDE_NORMAL"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_LIST_KEYGUIDE_BLACKSPIRIT")
  },
  _initialize = false
}
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_List_All_1.lua")
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_List_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_DialogList_All_Init")
function FromClient_DialogList_All_Init()
  PaGlobal_DialogList_All:initialize()
end
