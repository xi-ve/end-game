PaGlobal_Guild_ManufactureSelect_All = {
  _ui = {
    stc_titleArea = nil,
    btn_close = nil,
    stc_mainArea = nil,
    btn_deposit = nil,
    stc_descEdge = nil,
    stc_slotBG = nil,
    txt_desc = nil,
    stc_keyguideBG = nil,
    txt_keyGuideA = nil,
    txt_keyGuideB = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true
  },
  _categoryList = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_SELECT_CATEGORY0"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_SELECT_CATEGORY1"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_SELECT_CATEGORY2")
  },
  _category = Array.new(),
  _slotList = Array.new(),
  _itemEnchantKey = Array.new(),
  _maxColumn = 8,
  _index = -1,
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_ManufactureSelect_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_ManufactureSelect_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Guild_ManufactureSelect_All_Init")
function FromClient_Guild_ManufactureSelect_All_Init()
  PaGlobal_Guild_ManufactureSelect_All:initialize()
end
