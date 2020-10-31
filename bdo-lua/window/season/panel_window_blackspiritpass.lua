PaGlobal_BlackspiritPass = {
  _ui = {
    _stc_banner = nil,
    _stc_directBuy = nil,
    _txt_date = nil,
    _seasonIcon = {
      [1] = nil,
      [2] = nil,
      [3] = nil
    },
    _list_quest = nil,
    _stc_lockBG = nil,
    _stc_lockIcon = nil,
    _stc_lockEffect = nil,
    _stc_bottomDescBg = nil,
    _txt_bottomDesc = nil
  },
  _ui_pc = {_btn_close = nil},
  _ui_console = {},
  _rewardSlotConfig = {
    createIcon = true,
    createBorder = false,
    createCount = true
  },
  _seasonIconString = {
    [1] = {
      _title = PAGetString(Defines.StringSheet_GAME, "LUA_SEASON_DESCICON_GROWTH"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SEASON_DESC_GROWTH")
    },
    [2] = {
      _title = PAGetString(Defines.StringSheet_GAME, "LUA_SEASON_DESCICON_EQUIP"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SEASON_DESC_EQUIP")
    },
    [3] = {
      _title = PAGetString(Defines.StringSheet_GAME, "LUA_SEASON_DESCICON_ETC"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SEASON_DESC_ETC")
    }
  },
  _state = {
    none = 0,
    progressing = 1,
    clear = 2,
    clickedReward = 3
  },
  _questInfo = {},
  _normalQuestIdx = 1,
  _premiumQuestIdx = 2,
  _hasSeasonPass = false,
  _isConsole = _ContentsGroup_UsePadSnapping,
  _initialize = false
}
runLua("UI_Data/Script/Window/Season/Panel_Window_BlackspiritPass_1.lua")
runLua("UI_Data/Script/Window/Season/Panel_Window_BlackspiritPass_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_BlackspiritPass_Init")
function FromClient_luaLoadComplete_BlackspiritPass_Init()
  PaGlobal_BlackspiritPass:initialize()
end
