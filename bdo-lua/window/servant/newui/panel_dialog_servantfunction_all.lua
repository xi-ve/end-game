PaGlobal_ServantFunction_All = {
  _ui = {
    _rdo_FunctionList = nil,
    _rdo_LinkCarridge = nil,
    _rdo_Exchange = nil,
    _rdo_MatingMarket = nil,
    _rdo_HorseMarket = nil,
    _rdo_RentalMarket = nil,
    _rdo_Exit = nil,
    _stc_KeyGuide_LB = nil,
    _stc_KeyGuide_RB = nil,
    _stc_TabButtonBar = nil,
    _stc_KeyGuide_A = nil
  },
  _ENUM = {
    _LIST = 0,
    _LINK = 1,
    _EXCHANGE = 2,
    _MATING = 3,
    _MARKET = 4,
    _RENTAL = 5,
    _COUNT = 6
  },
  _ENUM_NPC_TYPE = {
    _LAND = 0,
    _GUILD_LAND = 1,
    _SEA = 2,
    _GUILD_SEA = 3
  },
  _randomName_ForConsole = {
    "Darcy",
    "Buddy",
    "Orbit",
    "Rushmore",
    "Carolina",
    "Cindy",
    "Waffles",
    "Sparky",
    "Bailey",
    "Wichita",
    "Buck"
  },
  _tabButtonForCategory = {},
  _functionButtons = {},
  _functionButtonCount = 0,
  _tempBtnTable = {},
  _currentTab = nil,
  _currentNpcType = nil,
  _isGuild = false,
  _isConsole = false,
  _initailize = false
}
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantFunction_All_1.lua")
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantFunction_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantFunction_All_Init")
function FromClient_ServantFunction_All_Init()
  PaGlobal_ServantFunction_All:initialize()
end
