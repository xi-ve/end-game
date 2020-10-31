PaGlobal_PersonalMonster_ALL = {
  _ui = {
    stc_Title = nil,
    btn_Close = nil,
    stc_MainBg = nil,
    list2_Monster = nil,
    stc_Desc = nil,
    txt_ClosedMsg = nil,
    stc_SearchMsg = nil,
    txt_Search = nil,
    txt_SearchInfo = nil,
    stc_ConsoleItemList = nil,
    txt_ConsoleBossName = nil,
    btn_ItemBg = nil,
    stc_ItemListBg = nil,
    stc_ItemSlotBg = nil,
    stc_ItemIcon = nil,
    txt_ItemName = nil,
    stc_Console_KeyGuides = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_Y = nil,
    stc_KeyGuide_B = nil
  },
  _slotConfig = {createIcon = true, createBorder = true},
  _difficultyIconBG = {
    [1] = {
      x1 = 1,
      y1 = 1,
      x2 = 120,
      y2 = 120
    },
    [2] = {
      x1 = 121,
      y1 = 1,
      x2 = 240,
      y2 = 120
    },
    [3] = {
      x1 = 241,
      y1 = 1,
      x2 = 360,
      y2 = 120
    }
  },
  _difficultyIcon = {
    [1] = {
      x1 = 361,
      y1 = 1,
      x2 = 480,
      y2 = 120
    },
    [2] = {
      x1 = 1,
      y1 = 121,
      x2 = 120,
      y2 = 240
    },
    [3] = {
      x1 = 121,
      y1 = 121,
      x2 = 240,
      y2 = 240
    },
    [4] = {
      x1 = 241,
      y1 = 121,
      x2 = 360,
      y2 = 240
    },
    [5] = {
      x1 = 361,
      y1 = 121,
      x2 = 480,
      y2 = 240
    }
  },
  _difficultyRoma = {
    [1] = "I",
    [2] = "II",
    [3] = "III",
    [4] = "IV",
    [5] = "V",
    [6] = "VI",
    [7] = "VII"
  },
  _difficultyText = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALMONSTER_DIFFICULTY_1"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALMONSTER_DIFFICULTY_2"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALMONSTER_DIFFICULTY_3")
  },
  _isConsole = false,
  _initialize = false,
  _pcRewardSlotCount = 8,
  _originPanelSizeY = 0,
  _originList2SizeY = 0,
  _originMainBgSizeY = 0,
  _originPanelSpanY = 0,
  _list2ContentSizeY = 0,
  _consoleRewardSlot = {}
}
runLua("UI_Data/Script/Window/PersonalMonster/Panel_Window_PersonalMonster_All_1.lua")
runLua("UI_Data/Script/Window/PersonalMonster/Panel_Window_PersonalMonster_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PersonalMonsterAll_Init")
function FromClient_PersonalMonsterAll_Init()
  PaGlobal_PersonalMonster_ALL:initialize()
end
