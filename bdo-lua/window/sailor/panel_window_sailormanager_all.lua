PaGlobal_SailorManager_All = {
  _ui = {},
  _sailorInfoList = {},
  _sailorCount = 0,
  _currentSailorIndex = 1,
  _isConsole = false,
  _initialize = false,
  _isOpenByESCMenu = false,
  _maxRestoreSlot = 5,
  _originGuideSize = 120,
  _initPosX = 0,
  _initPosY = 0,
  _infoType = {
    SPEED = 1,
    EXCEL = 2,
    TURNING = 3,
    BRAKE = 4,
    PATIENCE = 5,
    POWER = 6,
    FOCUS = 7,
    SIGHT = 8
  }
}
PaGlobal_SailorOnBoard_All = {
  _ui = {},
  _servantList = {},
  _servantCount = 0,
  _unsealServantInfo = nil,
  _initialize = false
}
PaGlobal_SailorRestore_All = {
  _ui = {
    itemSlot = {}
  },
  _slots = {},
  slotConfig = {
    createIcon = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _selectItemIndex = -1,
  _initialize = false,
  _loyaltyRestoreItemList = {},
  _totalRestoreValue = 0
}
runLua("UI_Data/Script/Window/Sailor/Panel_Window_SailorManager_All_1.lua")
runLua("UI_Data/Script/Window/Sailor/Panel_Window_SailorManager_All_2.lua")
runLua("UI_Data/Script/Window/Sailor/Panel_Window_SailorManager_All_3.lua")
runLua("UI_Data/Script/Window/Sailor/Panel_Window_SailorManager_All_4.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SailorManagerAll_luaLoadComplete")
function FromClient_SailorManagerAll_luaLoadComplete()
  PaGlobal_SailorManager_All:initialize()
  PaGlobal_SailorOnBoard_All:initialize()
  PaGlobal_SailorRestore_All:initialize()
end
