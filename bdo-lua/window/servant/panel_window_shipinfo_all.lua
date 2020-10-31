PaGlobal_ShipInfo_All = {
  _ui = {},
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _equipSlotBG = {},
  _equipSlotCashBG = {},
  _equipSlotBGIcon = {},
  _equipSlotCashBGIcon = {},
  _equipItemSlots = {},
  _equipItemCashSlots = {},
  _equipSlotNoBig = {
    3,
    4,
    5,
    25,
    12
  },
  _equipCashSlotNoBig = {
    14,
    15,
    16,
    26,
    0
  },
  _equipSlotNoSmall = {
    4,
    5,
    6,
    25,
    0
  },
  _equipCashSlotNoSmall = {
    15,
    16,
    14,
    26,
    0
  },
  _equipSlotBigShipUV = {
    [3] = {
      x1 = 87,
      y1 = 259,
      x2 = 129,
      y2 = 301
    },
    [4] = {
      x1 = 1,
      y1 = 216,
      x2 = 43,
      y2 = 258
    },
    [5] = {
      x1 = 173,
      y1 = 259,
      x2 = 215,
      y2 = 301
    },
    [25] = {
      x1 = 1,
      y1 = 259,
      x2 = 43,
      y2 = 301
    },
    [12] = {
      x1 = 173,
      y1 = 302,
      x2 = 215,
      y2 = 344
    },
    [14] = {
      x1 = 130,
      y1 = 259,
      x2 = 172,
      y2 = 301
    },
    [15] = {
      x1 = 44,
      y1 = 216,
      x2 = 86,
      y2 = 258
    },
    [16] = {
      x1 = 216,
      y1 = 259,
      x2 = 258,
      y2 = 301
    },
    [26] = {
      x1 = 44,
      y1 = 259,
      x2 = 86,
      y2 = 301
    },
    [0] = {
      x1 = 44,
      y1 = 259,
      x2 = 86,
      y2 = 301
    }
  },
  _equipSlotSmallShipUV = {
    [4] = {
      x1 = 1,
      y1 = 216,
      x2 = 43,
      y2 = 258
    },
    [5] = {
      x1 = 1,
      y1 = 302,
      x2 = 43,
      y2 = 344
    },
    [6] = {
      x1 = 87,
      y1 = 216,
      x2 = 129,
      y2 = 258
    },
    [25] = {
      x1 = 1,
      y1 = 259,
      x2 = 43,
      y2 = 301
    },
    [15] = {
      x1 = 44,
      y1 = 216,
      x2 = 86,
      y2 = 258
    },
    [16] = {
      x1 = 44,
      y1 = 302,
      x2 = 86,
      y2 = 344
    },
    [14] = {
      x1 = 130,
      y1 = 259,
      x2 = 172,
      y2 = 301
    },
    [26] = {
      x1 = 44,
      y1 = 259,
      x2 = 86,
      y2 = 301
    },
    [0] = {
      x1 = 44,
      y1 = 259,
      x2 = 86,
      y2 = 301
    }
  },
  _equipSlotNo = {
    3,
    4,
    5,
    6,
    12,
    25,
    14,
    15,
    16,
    17,
    26
  },
  _equipSlotID = {
    [3] = "Static_ItemSlot1",
    [4] = "Static_ItemSlot2",
    [5] = "Static_ItemSlot3",
    [6] = "Static_ItemSlot1",
    [12] = "Static_ItemSlot4",
    [25] = "Static_ItemSlot5",
    [14] = "Static_PearlItemSlot1",
    [15] = "Static_PearlItemSlot2",
    [16] = "Static_PearlItemSlot3",
    [17] = "Static_PearlItemSlot4",
    [26] = "Static_PearlItemSlot4"
  },
  _contractSlotNum = 12,
  _equipSlotMaxCount = 5,
  _totemSlotNum = 6,
  _totemCheckButton = nil,
  _extendedSlotInfoArray = nil,
  _isBigShip = false,
  _invenSlotBG = {},
  _invenItemSlots = {},
  _config = {
    row = -1,
    col = 10,
    gap = 5,
    startPos = 5,
    size = 45,
    count = 0,
    contentsCount = 0,
    CONST_COUNT = 30
  },
  _useStartSlot = nil,
  _sailorList = {},
  _infoType = {
    SPEED = 1,
    EXCEL = 2,
    TURNING = 3,
    BRAKE = 4,
    PATIENCE = 5,
    POWER = 6,
    FOCUS = 7,
    SIGHT = 8
  },
  _shipSkillIndex = {},
  _tooltipControls = nil,
  _sailorOnboardCount = 0,
  _currentSailorIndex = 0,
  _actorKeyRaw = nil,
  _servantNo = nil,
  _isGuildShip = false,
  _startInvenSlotIndex = 0,
  _initialize = false,
  _moveItemToType = nil,
  _inventoryType = nil,
  _inventorySlotNo = 0
}
runLua("UI_Data/Script/Window/Servant/Panel_Window_ShipInfo_All_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_Window_ShipInfo_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ShipInfoAll_luaLoadComplete")
function FromClient_ShipInfoAll_luaLoadComplete()
  PaGlobal_ShipInfo_All:initialize()
end
