PaGlobal_QuestTypeSet_All = {
  _ui = {
    stc_desc = nil,
    stc_centerBg = nil,
    stc_deco = nil,
    stc_types = {},
    stc_selectedTypeDesc = nil,
    stc_selectedTypeNameBg = nil,
    txt_selectedTypeName = nil
  },
  _ui_console = {
    stc_keyGuideBg = nil,
    stc_confirm = nil,
    stc_cancle = nil
  },
  _TYPE = {
    STORY = 0,
    HUNT = 1,
    LIFE = 2,
    FISH = 3,
    ADV = 4,
    ETC = 5,
    COUNT = 6
  },
  _questTypeStr = {
    [0] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE1"),
      titleDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_ALL")
    },
    [1] = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_QUEST_T_GENERAL"),
      titleDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_QUEST_GENERAL")
    },
    [2] = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_QUEST_T_GATHERING"),
      titleDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_QUEST_GATHERING")
    },
    [3] = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_QUEST_T_FISHING"),
      titleDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_QUEST_FISHING")
    },
    [4] = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_QUEST_T_TRADE"),
      titleDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_QUEST_TRADE")
    },
    [5] = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_QUEST_T_REPEATABLE"),
      titleDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_QUEST_REPEATABLE")
    }
  },
  _questTypeGroup = {},
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Quest/Panel_Window_QuestTypeSet_All_1.lua")
runLua("UI_Data/Script/Window/Quest/Panel_Window_QuestTypeSet_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_QuestTypeSet_All_Init")
function FromClient_QuestTypeSet_All_Init()
  PaGlobal_QuestTypeSet_All:initialize()
end
