PaGlobal_DialogExchange_All = {
  _ui = {list2_exchange = nil, stc_titleBg = nil},
  _ui_pc = {stc_bottomGuideBg = nil, txt_listGuide = nil},
  _ui_console = {
    stc_bottomGuideBg = nil,
    stc_guidIconA = nil,
    stc_guidIconB = nil
  },
  _slotConfig = {
    createIcon = false,
    createBorder = true,
    createCount = false,
    createEnchant = true,
    createCash = true
  },
  _dialogListCount = 0,
  _listkeyGuideCount = 2,
  _listKeyGuides = {},
  _listKeyGuideString = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_LIST_KEYGUIDE_NORMAL"),
  _lastTopIndex = 0,
  _selectIndex = 0,
  _resultItemMsg = {count = nil, name = nil},
  _isExchange = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_ExchangeList_All_1.lua")
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_ExchangeList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_DialogExchange_All_Init")
function FromClient_DialogExchange_All_Init()
  PaGlobal_DialogExchange_All:initialize()
end
