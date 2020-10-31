PaGlobal_Improvement_All = {
  _ui = {
    stc_titleBar = nil,
    stc_leftBg = nil,
    txt_desc = nil,
    stc_decoLine = nil,
    stc_improveBg = nil,
    stc_enchantItemSlot = nil,
    stc_equipItemSlot = nil,
    txt_result = nil,
    stc_leftBtnBg = nil,
    chk_skipAni = nil,
    txt_itemListTitle = nil,
    stc_itemListBg = nil,
    list2_item = nil,
    txt_enchantItemListTitle = nil,
    stc_enchantItemListBg = nil,
    list2_enchantItem = nil,
    txt_noItem = nil,
    txt_noImprovement = nil
  },
  _ui_pc = {btn_closeIcon = nil, btn_enchant = nil},
  _ui_console = {
    stc_enchantY = nil,
    stc_guideBg = nil,
    stc_guideSelect = nil,
    stc_guideCancle = nil,
    stc_guideDetail = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createEnchant = true,
    createCash = false
  },
  _materialItemKey = {
    [1] = 4906,
    [2] = 4907,
    [3] = 4908,
    [4] = 4909,
    [5] = 4910,
    [6] = 4911,
    [7] = 4912,
    [8] = 4913,
    [9] = 9771
  },
  _materialItemCount = 4,
  _useMaterialItemKey = {
    [1] = 4906,
    [2] = 4907,
    [3] = 4908,
    [4] = 4909
  },
  _whereType = CppEnums.ItemWhereType.eInventory,
  _equipSlot = {},
  _materialSlot = {},
  _equipListCount = -1,
  _equipList = {},
  _indexInvenEnd = -1,
  _materialListCount = -1,
  _materialList = {},
  _itemCount = {},
  _materialListItemCount = {},
  _slotCount = 0,
  _equipSlotNo = -1,
  _materialSlotNo = -1,
  _doImprove = false,
  _doAnimation = false,
  _animationTime = 0,
  _animationPlayTime = 6,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Enchant/Panel_Improvement_All_1.lua")
runLua("UI_Data/Script/Window/Enchant/Panel_Improvement_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Improvement_All_Init")
function FromClient_Improvement_All_Init()
  PaGlobal_Improvement_All:initialize()
end
