PaGlobal_ShipEquipManagement = {
  _ui = {
    _btn_close = nil,
    _stc_equipSlotGroup = nil,
    _stc_equipSlots = nil,
    _txt_equipEffectDesc = nil,
    _stc_avatarSlotGroup = nil,
    _stc_avatarSlots = nil,
    _txt_avatarEffectDesc = nil,
    _radio_myBag = nil,
    _radio_pearlBag = nil,
    _stc_selectLine = nil,
    _stc_inventoryBG = nil,
    _stc_inventorySlot = nil,
    _scroll_inventory = nil,
    _progress_weightBar = nil,
    _txt_weightValue = nil,
    _btn_confirm = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _equipSlotNo = {
    3,
    4,
    5,
    6,
    25,
    12
  },
  _avatarSlotNo = {
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
    [25] = "Static_ItemSlot4",
    [12] = "Static_ItemSlot5"
  },
  _avatarSlotID = {
    [14] = "Static_ItemSlot1",
    [15] = "Static_ItemSlot2",
    [16] = "Static_ItemSlot3",
    [17] = "Static_ItemSlot4",
    [26] = "Static_ItemSlot4"
  },
  _equipItemSlots = nil,
  _avatarItemSlots = nil,
  _contractSlotNum = 12,
  _config = {
    slotCount = 48,
    slotCols = 6,
    slotRows = 0,
    slotStartX = 5,
    slotStartY = 3,
    slotGapX = 49,
    slotGapY = 48
  },
  _invenSlotBG = nil,
  _inventoryItemSlots = nil,
  _maxCountInventory = 0,
  _useStartSlot = nil,
  _startInvenSlotIndex = 0,
  _servantActorKey = 0,
  _currentWhereType = CppEnums.ItemWhereType.eInventory,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/ShipEquipManagement/Panel_Window_ShipEquipManagement_ALL_1.lua")
runLua("UI_Data/Script/Window/Servant/ShipEquipManagement/Panel_Window_ShipEquipManagement_ALL_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ShipEquipManagement_Init")
function FromClient_ShipEquipManagement_Init()
  PaGlobal_ShipEquipManagement:initialize()
end
