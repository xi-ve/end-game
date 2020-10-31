PaGlobal_RepairFunc_All = {
  _eType = {_dialog = 0, _camp = 1},
  _ui = {
    radio_btn = {},
    stc_selectLine = nil,
    stc_cursor = nil
  },
  _ui_console = {
    stc_iconLB = nil,
    stc_iconRB = nil,
    stc_iconA = nil
  },
  _otherPanel = {
    _uiRepairMessageBG = nil,
    _uiRepairInven = nil,
    _uiRepairWareHouse = nil,
    _uiRepairInvenMoney = nil,
    _uiRepairWareHouseMoney = nil,
    _repairMessag = nil,
    _repairMessageJP = nil
  },
  _uiRepairInvenMoneyTextSizeX = 0,
  _uiRepairWareHouseMoneyTextSizeX = 0,
  _uiRepairTextSizeX = 0,
  _uiRepairValueDefaultSpanX = 0,
  _BTN_ENUM = {
    GUILD = 1,
    SHIP = 2,
    HORSE = 3,
    MAXENDURANCE = 4,
    EQUIPMENT = 5,
    INVENTORYALL = 6,
    INVENTORY = 7,
    EXIT = 8
  },
  _BTN_COUNT = 8,
  _resultMsg_ShowTime = 0,
  _luckyRepairMSG = {},
  _repairWhereType = 0,
  _repairSlotNo = 0,
  _isCamping = false,
  _eRepairType = 0,
  _isContentsEnable = ToClient_IsContentsGroupOpen("36"),
  _isConsole = false,
  _initialize = false,
  _btnTable = {},
  _funcTable = {},
  _funcButtonCount = 1,
  _currentTabIndex = 1
}
runLua("UI_Data/Script/Window/Repair/Panel_Dialog_Repair_Function_All_1.lua")
runLua("UI_Data/Script/Window/Repair/Panel_Dialog_Repair_Function_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RepairFunc_All_Init")
function FromClient_RepairFunc_All_Init()
  PaGlobal_RepairFunc_All:initialize()
end
