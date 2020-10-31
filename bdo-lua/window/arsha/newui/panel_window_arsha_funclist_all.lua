PaGlobal_Arsha_FuncList_All = {
  _ui = {
    stc_titleArea = nil,
    txt_title = nil,
    stc_mainBg = nil,
    btn_template = nil
  },
  _ui_console = {
    stc_bottomGuideBg = nil,
    stc_guideA = nil,
    stc_guideB = nil
  },
  _buttonType = {
    [1] = {
      bType = "GameStart",
      isHost = true,
      isSubHost = false
    },
    [2] = {
      bType = "GameStop",
      isHost = true,
      isSubHost = false
    },
    [3] = {
      bType = "AllResrrection",
      isHost = true,
      isSubHost = false
    },
    [4] = {
      bType = "TeamNameChange",
      isHost = true,
      isSubHost = false
    },
    [5] = {
      bType = "InviteList",
      isHost = true,
      isSubHost = true
    },
    [6] = {
      bType = "ArshaOpenClose",
      isHost = true,
      isSubHost = false
    },
    [7] = {
      bType = "GoATeam",
      isHost = false,
      isSubHost = false
    },
    [8] = {
      bType = "GoBTeam",
      isHost = false,
      isSubHost = false
    },
    [9] = {
      bType = "GoWait",
      isHost = false,
      isSubHost = false
    },
    [10] = {
      bType = "GoExit",
      isHost = false,
      isSubHost = false
    }
  },
  _buttonString = {
    [1] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMPETITIONGAME_BTN_GAMESTART"),
    [2] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMPETITIONGAME_BTN_GAMESTOP"),
    [3] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMPETITIONGAME_ALLRESURRECTION"),
    [4] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARSHA_TEAMNAMECHANGE_TITLE"),
    [5] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARSHA_INVITELIST"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_SIMPLETOOLTIP_OPENCLOSE_TITLE"),
    [7] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARSHA_GO_A"),
    [8] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARSHA_GO_B"),
    [9] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARSHA_GO_WAIT"),
    [10] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARSHA_EXIT")
  },
  _btnMaxCount = 11,
  _showBtnCount = 0,
  _uiBtnList = {},
  _funcBtnList = {},
  _showBtnList = Array.new(),
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_FuncList_All_1.lua")
runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_FuncList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Arsha_FuncList_All_Init")
function FromClient_Arsha_FuncList_All_Init()
  PaGlobal_Arsha_FuncList_All:initialize()
end
