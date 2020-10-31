PaGlobal_Cash_Revival_BuyItem_All = {
  _ui = {
    stc_BG = nil,
    txt_notify = nil,
    stc_itemlistBG = nil,
    rdo_itemSlot_template = nil,
    stc_itemIconBG_template = nil,
    stc_itemIcon_template = nil,
    txt_itemName_template = nil,
    btn_confirm_PC = nil,
    btn_cancel_PC = nil,
    stc_keyGuide_ConsoleUI = nil,
    txt_select_ConsoleUI = nil,
    txt_cancel_ConsoleUI = nil
  },
  _itemUIPOOL = {},
  _itemUIMaxCount = 0,
  _itemListRow = -1,
  _selectedItemNo = -1,
  _cashRevivalData = {},
  _cashRevivalCount = 0,
  _selectSpawnType = 0,
  _originListBgSizeY = 0,
  _originStcBgSizeY = 0,
  _originPanelSizeY = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/DeadMessage/Panel_Cash_Revival_BuyItem_All_1.lua")
runLua("UI_Data/Script/Window/DeadMessage/Panel_Cash_Revival_BuyItem_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Cash_Revival_BuyItem_All_Init")
function FromClient_Cash_Revival_BuyItem_All_Init()
  PaGlobal_Cash_Revival_BuyItem_All:initialize()
end
