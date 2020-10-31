PaGlobal_DialogNpcGift_All = {
  _ui = {
    stc_titleBg = nil,
    stc_mainBg = nil,
    stc_presentItemSlotBg = nil,
    stc_presentItemSlot = nil,
    txt_desc = nil,
    stc_line = nil,
    txt_detailDesc = nil,
    txt_interestItemTitle = nil,
    stc_interestItemBg = nil,
    stc_interestItemSlot = {},
    list2_item = nil,
    txt_NoItem = nil
  },
  _ui_pc = {
    btn_close = nil,
    btn_present = nil,
    btn_confession = nil
  },
  _ui_console = {
    stc_keyGuideBg = nil,
    stc_guideIconB = nil,
    stc_guideIconX = nil,
    stc_guideIconY = nil,
    stc_guideIconA = nil,
    stc_guideIconLTY = nil
  },
  _slotConfig = {
    createIcon = false,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true
  },
  _isConsole = false,
  _detailDescY = 0,
  _detailTextDescY = 0,
  _interestItemCount = 5,
  _count = 0,
  _slotNo = 0,
  _slotPresentItem = {},
  _enableList = {},
  _enableListSlot = {},
  _panelSizeY = 0,
  _whereType = CppEnums.ItemWhereType.eInventory,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_NpcGift_All_1.lua")
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_NpcGift_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_DialogNpcGift_All_Init")
function FromClient_DialogNpcGift_All_Init()
  PaGlobal_DialogNpcGift_All:initialize()
end
