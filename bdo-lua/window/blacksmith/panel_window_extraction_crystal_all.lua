PaGlobal_Extraction_Crystal_All = {
  _ui = {
    txt_leftTopDesc = nil,
    stc_crystalInfo = {
      [1] = {
        stc_crystal = nil,
        txt_itemName = nil,
        txt_crystalDesc = nil,
        btn_extraction = nil,
        stc_itemSlot = nil,
        isEmpty = true
      },
      [2] = {
        stc_crystal = nil,
        txt_itemName = nil,
        txt_crystalDesc = nil,
        btn_extraction = nil,
        stc_itemSlot = nil,
        isEmpty = true
      },
      [3] = {
        stc_crystal = nil,
        txt_itemName = nil,
        txt_crystalDesc = nil,
        btn_extraction = nil,
        stc_itemSlot = nil,
        isEmpty = true
      }
    },
    list2_extractableItem = nil,
    list2_materialItem = nil,
    stc_materialItemSlot = nil,
    stc_extractionItemSlot = nil,
    stc_crystalExtractImage = nil
  },
  _ui_pc = {btn_question = nil, btn_close = nil},
  _ui_console = {
    stc_guideBg = nil,
    stc_iconX = nil,
    stc_iconA = nil,
    stc_iconB = nil
  },
  _slotConfig = {
    createIcon = false,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true
  },
  _extractionItemInfo = {
    name = {},
    iconPath = {},
    slotNo = {},
    itemEnchantLevle = {},
    isExtractionEquip = {false}
  },
  _materialItemInfo = {
    name = {},
    iconPath = {},
    slotNo = {},
    whereType = {},
    isExtractionEquip = {false},
    itemCnt = {}
  },
  _materialEnchantKey = {
    stuffCrystalExtraction = ItemEnchantKey(16000),
    stuffBlackspirit = ItemEnchantKey(17000)
  },
  _equipCnt = 0,
  _equipNo = {},
  _crystalCnt = 0,
  _materialCnt = 0,
  _indexInvenEnd = -1,
  _indexCashInvenEnd = -1,
  _extractionKey = nil,
  _extractionSlotNo = 255,
  _stuffWhereType = CppEnums.ItemWhereType.eInventory,
  _selectedWhereType = CppEnums.ItemWhereType.eInventory,
  _stuffSlotNo = 255,
  _selectedItemSlotNo = nil,
  _selectedMaterialSlotNo = nil,
  _initialize = false,
  _isConsole = false,
  _isAniStart = false,
  _resultShowTime = 0,
  _isRemove = false
}
runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_Crystal_All_1.lua")
runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_Crystal_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Extraction_Crystal_AllInit")
function FromClient_Extraction_Crystal_AllInit()
  PaGlobal_Extraction_Crystal_All:initialize()
end
