PaGlobal_Lobby_CharacterSelect_ItemSlot = {
  _ui = {
    _Static_ItemSlotBG = nil,
    _Static_AvatarSlotBG = nil,
    _Static_AvatarIcon = nil,
    _Static_ItemSlot = {},
    _itemSlotList = {},
    _Static_AvatarSlot = {},
    _itemIcons = {},
    _btn_itemShop = nil,
    _txt_point = nil
  },
  _itemData = nil,
  _slotConfig = {
    createIcon = true,
    createBorder = false,
    createCount = true,
    createCooltime = false,
    createCooltimeText = false,
    createEnchant = false
  },
  _initialize = false
}
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_ItemSlot_1.lua")
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_ItemSlot_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_Lobby_CharacterSelect_ItemSlot_Init")
registerEvent("FromClient_SetItemData", "FromClient_SetItemData")
function FromClient_luaLoadComplete_Lobby_CharacterSelect_ItemSlot_Init()
  PaGlobal_Lobby_CharacterSelect_ItemSlot:initialize()
end
function FromClient_SetItemData(index, itemKey, count)
  PaGlobal_Lobby_CharacterSelect_ItemSlot_SelectItem(index + 1, itemKey, count)
end
