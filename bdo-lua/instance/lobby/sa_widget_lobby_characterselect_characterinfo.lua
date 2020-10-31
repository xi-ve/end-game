PaGlobal_Lobby_CharacterSelect_CharacterInfo = {
  _ui = {
    _Static_WinCount = nil,
    _Static_CharacterInfo = nil,
    _Static_SkillInfo = nil,
    _StaticText_WinIcon = nil,
    _Static_StatGraph = nil,
    _StaticText_CharacterName = nil,
    _StaticText_ClassName = nil,
    _StaticText_ClassStory = nil,
    _Static_SkillSlot = {},
    _Static_skillName = {},
    _Static_skillDetail = {}
  },
  slotConfig_Skill = {
    createIcon = true,
    createEffect = true,
    createFG = false,
    createFGDisabled = false,
    createLevel = false,
    createLearnButton = false,
    createCooltime = false,
    createCooltimeText = false,
    template = {
      effect = {}
    }
  },
  _characterSymbolIconUV = {
    path = "shadowarena/basic/sa_character_00.dds",
    [52] = {
      x1 = 343,
      x2 = 458,
      y1 = 465,
      y2 = 580
    },
    [53] = {
      x1 = 343,
      x2 = 458,
      y1 = 349,
      y2 = 464
    },
    [55] = {
      x1 = 343,
      x2 = 458,
      y1 = 117,
      y2 = 232
    },
    [58] = {
      x1 = 343,
      x2 = 458,
      y1 = 1,
      y2 = 116
    },
    [60] = {
      x1 = 343,
      x2 = 458,
      y1 = 233,
      y2 = 348
    },
    [63] = {
      x1 = 343,
      x2 = 458,
      y1 = 581,
      y2 = 696
    }
  },
  _selectBattleType = nil,
  _winGame = 0,
  _nowSelectClassNo = nil,
  _characterName = nil,
  _characterDesc = nil,
  _textureIndex = nil,
  _originCharacterInfoSizeY = 0,
  _storySpanSizeY = 0,
  _maxSkillCount = 4,
  _rClickSkillKey = 8,
  _initialize = false
}
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_CharacterInfo_1.lua")
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_CharacterInfo_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_Lobby_CharacterSelect_CharacterInfo_Init")
function FromClient_luaLoadComplete_Lobby_CharacterSelect_CharacterInfo_Init()
  PaGlobal_Lobby_CharacterSelect_CharacterInfo:initialize()
end
