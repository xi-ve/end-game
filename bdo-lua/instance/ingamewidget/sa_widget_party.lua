PaGlobal_SA_Widget_Party = {
  _ui = {stc_partyMember = nil},
  _initialize = false,
  _partyMember = {},
  _partyMemberData = {},
  _maxPartyMemberCount = 2,
  _partyMemberCount = 0,
  _partyType = nil,
  _gabY = 10,
  _texUV = {
    path = "shadowarena/basic/sa_character_00.dds",
    [__eClassType_Shadow_Warrior_Type2] = {
      x1 = 1,
      x2 = 171,
      y1 = 325,
      y2 = 405
    },
    [__eClassType_Shadow_Maehwa_Type1] = {
      x1 = 1,
      x2 = 171,
      y1 = 244,
      y2 = 324
    },
    [__eClassType_Shadow_Sorcerer_Type1] = {
      x1 = 1,
      x2 = 171,
      y1 = 82,
      y2 = 162
    },
    [__eClassType_Shadow_Giant_Type2] = {
      x1 = 1,
      x2 = 171,
      y1 = 1,
      y2 = 81
    },
    [__eClassType_Shadow_Kunoichi_Type2] = {
      x1 = 1,
      x2 = 171,
      y1 = 163,
      y2 = 243
    },
    [__eClassType_Shadow_WizardWoman_Type1] = {
      x1 = 1,
      x2 = 171,
      y1 = 406,
      y2 = 486
    }
  }
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Party_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Party_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_PartyInit")
function FromClient_SA_Widget_PartyInit()
  PaGlobal_SA_Widget_Party:initialize()
end
