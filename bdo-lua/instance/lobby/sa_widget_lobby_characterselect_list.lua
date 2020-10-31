PaGlobal_Lobby_CharacterSelect_List = {
  _ui = {
    _Static_CharactorListGroup = nil,
    _Button_SlotExpansive = nil,
    _RadioButton_CharacterSlot_Activation = {},
    _Static_CharacterIcon = {},
    _StaticText_CharacterName = {},
    _Static_LockIcon = {}
  },
  _ACTIVATION_COUNT = nil,
  _nowSelectClassNo = nil,
  _nowSelectIndex = nil,
  _initialize = false,
  _characterIconUV = {
    path = "shadowarena/basic/sa_character_00.dds",
    [52] = {
      x1 = 1,
      x2 = 171,
      y1 = 325,
      y2 = 405
    },
    [53] = {
      x1 = 1,
      x2 = 171,
      y1 = 244,
      y2 = 324
    },
    [55] = {
      x1 = 1,
      x2 = 171,
      y1 = 82,
      y2 = 162
    },
    [58] = {
      x1 = 1,
      x2 = 171,
      y1 = 1,
      y2 = 81
    },
    [60] = {
      x1 = 1,
      x2 = 171,
      y1 = 163,
      y2 = 243
    },
    [63] = {
      x1 = 1,
      x2 = 171,
      y1 = 406,
      y2 = 486
    }
  }
}
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_List_1.lua")
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_List_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_Lobby_CharacterSelect_List_Init")
function FromClient_luaLoadComplete_Lobby_CharacterSelect_List_Init()
  PaGlobal_Lobby_CharacterSelect_List:initialize()
end
