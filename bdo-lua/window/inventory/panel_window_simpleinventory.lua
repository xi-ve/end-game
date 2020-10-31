PaGlobal_SimpleInventory = {
  _ui = {
    _titleBar = UI.getChildControl(Panel_Window_SimpleInventory, "StaticText_Title"),
    _invenBG = UI.getChildControl(Panel_Window_SimpleInventory, "Static_Group_Inven"),
    _equipBG = UI.getChildControl(Panel_Window_SimpleInventory, "Static_Group_Equip"),
    _characterBG = UI.getChildControl(Panel_Window_SimpleInventory, "Static_SelectCharacter"),
    _keyguideBg = UI.getChildControl(Panel_Window_SimpleInventory, "Static_Key_GuideGroup_ConsoleUI")
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true
  },
  _equipSlotConfig = {
    createIcon = false,
    createBorder = true,
    createCount = true,
    createCash = true,
    createBlack = true,
    createEnchant = true
  },
  _slotNoId = {
    [0] = "Static_Slot_RightHand",
    [1] = "Static_Slot_LeftHand",
    [2] = "Static_Slot_Gather",
    [3] = "Static_Slot_Chest",
    [4] = "Static_Slot_Glove",
    [5] = "Static_Slot_Boots",
    [6] = "Static_Slot_Helm",
    [7] = "Static_Slot_Necklace",
    [8] = "Static_Slot_Ring1",
    [9] = "Static_Slot_Ring2",
    [10] = "Static_Slot_Earing1",
    [11] = "Static_Slot_Earing2",
    [12] = "Static_Slot_Belt",
    [13] = "Static_Slot_Lantern",
    [14] = "Static_Slot_Avatar_Chest",
    [15] = "Static_Slot_Avatar_Gloves",
    [16] = "Static_Slot_Avatar_Boots",
    [17] = "Static_Slot_Avatar_Helm",
    [18] = "Static_Slot_Avatar_RightHand",
    [19] = "Static_Slot_Avatar_LeftHand",
    [20] = "Static_Slot_Avatar_UnderWear",
    [22] = "Static_Slot_FaceDecoration1",
    [23] = "Static_Slot_FaceDecoration2",
    [21] = "Static_Slot_FaceDecoration3",
    [27] = "Static_Slot_AlchemyStone",
    [29] = "Static_Slot_AwakenWeapon",
    [30] = "Static_Slot_Avatar_AwakenWeapon",
    [31] = "Static_Slot_QuestBook"
  },
  _slotNoIdToString = {
    [0] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_MAINHAND"),
    [1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_SUBHAND"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_GATHERTOOLS"),
    [3] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_UPPERBODY"),
    [4] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_GLOVES"),
    [5] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_BOOTS"),
    [6] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_HELM"),
    [7] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_NECKLACE"),
    [8] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_RING"),
    [9] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_RING"),
    [10] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EARRING"),
    [11] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EARRING"),
    [12] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_WAISTBAND"),
    [13] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_LANTERN"),
    [14] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_BODY"),
    [15] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HANDS"),
    [16] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_BOOTS"),
    [17] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HELM"),
    [18] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_MAIN"),
    [19] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_SUB"),
    [20] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_UNDERWEAR"),
    [22] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_EYES"),
    [23] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_MOUSE"),
    [21] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HEAD"),
    [27] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_alchemyStone"),
    [29] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_awakenWeapon"),
    [30] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_avatarAwakenWeapon"),
    [31] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_QUESTBOOK")
  },
  _config = {
    _slotCount = 64,
    _inventoryMax = 192,
    _slotCols = 8,
    _slotRows = 8,
    _initPosX = 10,
    _initPosY = 10
  },
  _itemWhereType = nil,
  _invenWrapper = nil,
  _currentIndex = 0,
  _currentItemCount = 0,
  _slots = Array.new(),
  _sortedItemList = Array.new(),
  _selectedTab = 0,
  _maxTabCount = 2,
  _EquipNoMin = CppEnums.EquipSlotNo.rightHand,
  _EquipNoMax = CppEnums.EquipSlotNo.equipSlotNoCount,
  _UnUsedEquipNo_01 = 100,
  _UnUsedEquipNo_02 = 101,
  _equipSlotBG = {},
  _equipSlot = {},
  _extendedSlotInfoArray = nil,
  _equipWrapper = nil,
  _characterDataCount = 0,
  _currentCharacterNo = nil,
  _currentCharacterIndex = 0,
  _selectedCharacterNo = nil,
  _selectedCharacterIndex = 0,
  _selectedCharacterClassType = __eClassType_Count,
  _originUnderWearSpanX = 0,
  _changeUnderWearSpanX = 0,
  _consoleEquipSpanY = 100,
  _isConsole = false
}
function FromClient_SimpleInventoryInit()
  local self = PaGlobal_SimpleInventory
  self:init()
end
runLua("UI_Data/Script/Window/Inventory/Panel_Window_SimpleInventory_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_SimpleInventory_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SimpleInventoryInit")