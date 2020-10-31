PaGlobal_InventoryEquip_Detail_Renew = {
  _ui = {
    frame_information = nil,
    frame_content = nil,
    frame_vScroll = nil,
    chk_crystal = nil,
    stc_crystal_template = nil,
    chk_equipset = nil,
    stc_equipset_template = nil,
    crystalGroup = {},
    setEffectGroup = {}
  },
  _slotEquipNo = {
    [0] = CppEnums.EquipSlotNo.rightHand,
    [1] = CppEnums.EquipSlotNo.leftHand,
    [2] = CppEnums.EquipSlotNo.helm,
    [3] = CppEnums.EquipSlotNo.chest,
    [4] = CppEnums.EquipSlotNo.glove,
    [5] = CppEnums.EquipSlotNo.boots,
    [6] = CppEnums.EquipSlotNo.avatarChest,
    [7] = CppEnums.EquipSlotNo.awakenWeapon
  },
  slotConfig_Crystal = {createIcon = true, createBorder = false},
  _equipNoMin = 0,
  _equipNoMax = 7,
  _socketCount = 0,
  _listEquipmentName = {},
  _listEquipmentSize = 0,
  _listCrystal = {},
  _listCrystalSize = 0,
  _usingEquipmentUICount = 0,
  _usingCrystalUICount = 0,
  _maxSocketCount = 2,
  _setEffectData = {},
  _isOpenEquippedCrystal = false,
  _isOpenEquippedSet = false,
  _isSimpleInventory = false,
  _originPanelSizeY = 790,
  _initialize = false
}
runLua("UI_Data/Script/Window/Inventory/Console/Panel_Window_InventoryEquip_Detail_Renew_1.lua")
runLua("UI_Data/Script/Window/Inventory/Console/Panel_Window_InventoryEquip_Detail_Renew_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_InventoryEquip_Detail_Renew_Init")
function FromClient_InventoryEquip_Detail_Renew_Init()
  PaGlobal_InventoryEquip_Detail_Renew:initialize()
end
