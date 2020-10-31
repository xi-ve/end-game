PaGlobal_Endurance_Recovery_All = {
  _eGuideType = {
    selectItem = 0,
    selectMaterial = 1,
    recovery = 2
  },
  _ui = {
    stc_leftTopDesc = nil,
    list2_recoveryList = nil,
    list2_materialList = nil,
    btn_useCashItem = nil,
    txt_useItemCount = nil,
    stc_recoveryItemSlot = nil,
    stc_memoryItemSlot = nil,
    stc_meterialItemSlot = nil,
    txt_topGuide = nil,
    txt_materialValue = nil,
    progress2_maxEndurance = nil,
    progress2_curEndurance = nil,
    txt_noItem = nil
  },
  _ui_pc = {
    btn_question = nil,
    btn_close = nil,
    btn_onceRecovery = nil,
    btn_streamRecovery = nil,
    stc_streamRecoveryToolTip = nil
  },
  _ui_console = {
    stc_guideBg = nil,
    btn_iconX = nil,
    btn_iconA = nil,
    btn_iconB = nil,
    stc_buttonArea = nil,
    btn_onceRecovery = nil,
    btn_streamRecovery = nil
  },
  _initialize = false,
  _isConsole = false,
  _recoveryItemInfo = {
    name = {},
    iconPath = {},
    slotNo = {},
    curEndurance = {},
    recoveryEndurance = {},
    maxendurance = {},
    itemEnchantLevle = {},
    isRecoveryEquip = {false}
  },
  _materialItemInfo = {
    name = {},
    iconPath = {},
    slotNo = {},
    itemCnt = {},
    itemEnchantLevle = {},
    isMaterialEquip = {false}
  },
  _slotConfig = {
    createIcon = false,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = false
  },
  _materialEnchantKey = {
    eventItem = ItemEnchantKey(17729),
    cashItem = ItemEnchantKey(17598),
    memoryFlag = ItemEnchantKey(44195),
    driganFlag = ItemEnchantKey(9750),
    timeFlag = ItemEnchantKey(721008),
    sandFlag = ItemEnchantKey(721031)
  },
  _fromSlotOn = false,
  _repairItemKey = nil,
  _recoveryItemSlotNo = 255,
  _recoveryItemWhereType = CppEnums.ItemWhereType.eInventory,
  _materialItemKey = nil,
  _selectedItemSlotNo = nil,
  _selectedMaterialSlotNo = nil,
  _equipCnt = 0,
  _equipNo = {},
  _materialItemCnt = 0,
  _recoveryItemCnt = 0,
  _useItemCount = 0,
  _isUseCashItem = false,
  _isStreamRecovery = false,
  _s64_allWeight = 0,
  _isRecovery = false
}
runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Endurance_Recovery_All_1.lua")
runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Endurance_Recovery_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Endurance_Recovery_AllInit")
function FromClient_Endurance_Recovery_AllInit()
  PaGlobal_Endurance_Recovery_All:initialize()
end
