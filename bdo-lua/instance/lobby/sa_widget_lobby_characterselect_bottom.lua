PaGlobal_Lobby_CharacterSelect_Bottom = {
  _ui = {
    _Static_CountDownGroup = nil,
    _StaticText_CountDown = nil,
    _StaticText_CountDownInfo = nil,
    _Static_CountDownGaugeBG = nil,
    _Progress2_CountDownGauge = nil,
    _Button_Ready = nil,
    _Progress2_1_Bar_Head = nil,
    stc_teamBG = nil,
    btn_teamReady = nil,
    stc_member = {},
    stc_invitePopUp = nil,
    btn_inviteFriend = nil,
    stc_friendListPopup = nil,
    list2_friendList = nil,
    _stc_countDown
  },
  _selectedMode = __eBattleRoyaleMode_Count,
  _initialize = false,
  _maxTeamCount = 2,
  _currentReadyCount = 0,
  _currentTeamCount = 0,
  _updateCount = 0,
  _endCount = 60,
  _characterIconUV = {
    path = "shadowarena/basic/sa_character_00.dds",
    [52] = {
      x1 = 325,
      x2 = 405,
      y1 = 697,
      y2 = 777
    },
    [53] = {
      x1 = 244,
      x2 = 324,
      y1 = 697,
      y2 = 777
    },
    [55] = {
      x1 = 82,
      x2 = 162,
      y1 = 697,
      y2 = 777
    },
    [58] = {
      x1 = 1,
      x2 = 81,
      y1 = 697,
      y2 = 777
    },
    [60] = {
      x1 = 163,
      x2 = 243,
      y1 = 697,
      y2 = 777
    },
    [63] = {
      x1 = 406,
      x2 = 486,
      y1 = 697,
      y2 = 777
    }
  }
}
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_Bottom_1.lua")
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_Bottom_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_Lobby_CharacterSelect_Bottom_Init")
function FromClient_luaLoadComplete_Lobby_CharacterSelect_Bottom_Init()
  PaGlobal_Lobby_CharacterSelect_Bottom:initialize()
end
