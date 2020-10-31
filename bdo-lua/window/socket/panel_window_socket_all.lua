PaGlobal_Socket_All = {
  _ui = {
    stc_titleBg = nil,
    stc_leftAreaBg = nil,
    stc_imageArea = nil,
    stc_imagePartArea = nil,
    stc_extractArea = nil,
    stc_equipSlot = nil,
    stc_crystalInfoBg = {},
    stc_crystalInfo = {},
    stc_crystalSlotBg = {},
    stc_crystalSlot = {},
    stc_descArea = nil,
    txt_desc = nil,
    stc_rightArea = nil,
    stc_tabBg = nil,
    radio_tab = {},
    stc_selectBar = nil,
    list2_item = nil
  },
  _ui_pc = {
    btn_question = nil,
    btn_close = nil,
    stc_LClick = nil,
    stc_RClick = nil
  },
  _ui_console = {
    stc_guideBg = nil,
    stc_iconLB = nil,
    stc_iconRB = nil,
    stc_select = nil,
    stc_cancle = nil,
    stc_detail = nil,
    stc_delete = nil
  },
  _slotConfig = {
    createIcon = false,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true
  },
  _TAB = {EQUIPMENT = 1, CRYSCTAL = 2},
  _crystalSlotBgUV = {
    normal = {
      x1 = 256,
      y1 = 1,
      x2 = 306,
      y2 = 51
    },
    disable = {
      x1 = 460,
      y1 = 205,
      x2 = 510,
      y2 = 255
    }
  },
  _equipItemSlotInfo = {},
  _selectTab = 1,
  _slotNo = -1,
  _socketSlotCount = 3,
  _selectKey = -1,
  _indexInvenEnd = -1,
  _indexPopSocket = -1,
  _isItemLock = false,
  _equipList = {},
  _crystalList = {},
  _slotIconList = {},
  _isConsole = _ContentsGroup_UsePadSnapping,
  _whereType = CppEnums.ItemWhereType.eInventory,
  _initialize = false
}
runLua("UI_Data/Script/Window/Socket/Panel_Window_Socket_All_1.lua")
runLua("UI_Data/Script/Window/Socket/Panel_Window_Socket_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Socket_All_Init")
function FromClient_Socket_All_Init()
  PaGlobal_Socket_All:initialize()
end
