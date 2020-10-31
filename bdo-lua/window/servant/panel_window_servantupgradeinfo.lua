PaGlobal_ServantUpgradeInfo = {
  _ui = {
    _titleBar = UI.getChildControl(Panel_Window_ServantUpgradeInfo, "Static_TitleBG"),
    _bg = UI.getChildControl(Panel_Window_ServantUpgradeInfo, "Static_StatInfo")
  },
  _dataType = {
    HP = 0,
    FOOD = 1,
    SPEED = 2,
    ACCEL = 3,
    CORNERING = 4,
    BRAKE = 5,
    INVEN_COUNT = 6,
    WEIGHT = 7,
    COST = 8,
    CANNON_COUNT = 9,
    CANNON_RELOAD = 10,
    TypeCount = 11
  },
  _dataTypeUnit = {
    [0] = {
      unitStr = "",
      unitValue = 1,
      dp = 0
    },
    [1] = {
      unitStr = "",
      unitValue = 1,
      dp = 0
    },
    [2] = {
      unitStr = "%",
      unitValue = 10000,
      dp = 1
    },
    [3] = {
      unitStr = "%",
      unitValue = 10000,
      dp = 1
    },
    [4] = {
      unitStr = "%",
      unitValue = 10000,
      dp = 1
    },
    [5] = {
      unitStr = "%",
      unitValue = 10000,
      dp = 1
    },
    [6] = {
      unitStr = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_COUNT_UNIT"),
      unitValue = 1,
      dp = 0
    },
    [7] = {
      unitStr = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"),
      unitValue = 10000,
      dp = 1
    },
    [8] = {
      unitStr = "",
      unitValue = 1,
      dp = 0
    },
    [9] = {
      unitStr = PAGetString(Defines.StringSheet_GAME, "LUA_CANNON_COUNT_UNIT"),
      unitValue = 1,
      dp = 0
    },
    [10] = {
      unitStr = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND"),
      unitValue = 1,
      dp = 0
    },
    [11] = {
      unitStr = "",
      unitValue = 1,
      dp = 0
    }
  },
  _controlList = Array.new()
}
function FromClient_ServantUpgradeInfoInit()
  local self = PaGlobal_ServantUpgradeInfo
  self:init()
end
runLua("UI_Data/Script/Window/Servant/Panel_Window_ServantUpgradeInfo_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_Window_ServantUpgradeInfo_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantUpgradeInfoInit")
