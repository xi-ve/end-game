PaGlobal_SA_Widget_Inventory = {
  _ui = {
    btn_close = nil,
    txt_attValue = nil,
    txt_dpValue = nil,
    stc_equipBG = nil,
    stc_characterIcon = nil,
    stc_equip = {},
    stc_radioGroup = nil,
    btn_all = nil,
    btn_equip = nil,
    btn_posion = nil,
    buttons = {},
    frame_1 = nil,
    frame_Content = nil,
    stc_iconBG = nil,
    stc_iconSlot = nil,
    frame_vScroll = nil,
    stc_invenItem = {}
  },
  slotConfig_Equip = {
    createIcon = true,
    createBorder = false,
    createCount = false,
    createCooltime = false,
    createCooltimeText = false,
    createEnchant = true
  },
  _maxEquipItem = 6,
  _equipItemSlot = {},
  _equipEnum = {
    [0] = CppEnums.EquipSlotNoClient.eEquipSlotNoRightHand,
    [1] = CppEnums.EquipSlotNoClient.eEquipSlotNoLeftHand,
    [2] = CppEnums.EquipSlotNoClient.eEquipSlotNoChest,
    [3] = CppEnums.EquipSlotNoClient.eEquipSlotNoGlove,
    [4] = CppEnums.EquipSlotNoClient.eEquipSlotNoBoots,
    [5] = CppEnums.EquipSlotNoClient.eEquipSlotNoHelm
  },
  _equipIconTexUV = {
    path = "ShadowArena/Contents/SA_Ingame_02.dds",
    [0] = {
      x1 = 1,
      x2 = 47,
      y1 = 1,
      y2 = 47
    },
    [1] = {
      x1 = 48,
      x2 = 94,
      y1 = 1,
      y2 = 47
    },
    [2] = {
      x1 = 142,
      x2 = 188,
      y1 = 1,
      y2 = 47
    },
    [3] = {
      x1 = 189,
      x2 = 235,
      y1 = 1,
      y2 = 47
    },
    [4] = {
      x1 = 48,
      x2 = 94,
      y1 = 48,
      y2 = 94
    },
    [5] = {
      x1 = 95,
      x2 = 141,
      y1 = 1,
      y2 = 47
    }
  },
  _itemGradeTexUV = {
    path = "ShadowArena/Contents/SA_Ingame_01.dds",
    [0] = {
      x1 = 48,
      x2 = 94,
      y1 = 243,
      y2 = 289
    },
    [1] = {
      x1 = 95,
      x2 = 141,
      y1 = 243,
      y2 = 289
    },
    [2] = {
      x1 = 142,
      x2 = 188,
      y1 = 243,
      y2 = 289
    },
    [3] = {
      x1 = 189,
      x2 = 235,
      y1 = 243,
      y2 = 289
    },
    [4] = {
      x1 = 236,
      x2 = 282,
      y1 = 243,
      y2 = 289
    }
  },
  _characterIconUV = {
    path = "ShadowArena/Basic/SA_Character_00.dds",
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
  _isDeadPlayer = false,
  _whereType = CppEnums.ItemWhereType.eInstanceInventory,
  _maxItemSlotCnt = 0,
  _inventoryItemSlot = {},
  _maxCol = 1,
  _maxRow = 8,
  _startSlotIndex = 0,
  _tooltipSlotNo = 0,
  _deleteSlotNo = 0,
  _deleteItemCount = 0,
  over_SlotEffect = nil,
  _itemIconUV = {
    path = "ShadowArena/Contents/SA_Ingame_01.dds",
    x1 = 1,
    x2 = 47,
    y1 = 243,
    y2 = 289
  },
  slotConfig_Inven = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCooltime = true,
    createExpiration = true,
    createExpirationBG = true,
    createExpiration2h = true,
    createClassEquipBG = true,
    createEnduranceIcon = true,
    createCooltimeText = true,
    createCash = true,
    createItemLock = true,
    createBagIcon = true,
    createSoulComplete = true
  },
  _padding = 5,
  filterFunc = nil,
  rClickFunc = nil,
  _initialize = false
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Inventory_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Inventory_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_InventoryInit")
function FromClient_SA_Widget_InventoryInit()
  PaGlobal_SA_Widget_Inventory:initialize()
end
