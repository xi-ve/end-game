PaGlobal_WareHouse_Search_All = {
  _ui = {
    frame_Result = nil,
    edit_Search = nil,
    btn_Search = nil,
    btn_Reset = nil,
    frameContent = nil,
    stc_RegionName = nil,
    txt_NoResult = nil,
    btn_close = nil,
    stc_keyGuideBG = nil,
    stc_keyGuideB = nil,
    stc_keyGuideY = nil,
    verticalScroll = nil
  },
  _slotCount = 0,
  _itemSlot = {},
  _startSlotIndex = 0,
  _slotConfig = {
    createIcon = false,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    isTranslation = true
  },
  _maxRow = 0,
  _maxCol = 0,
  _maxSlotIndex = 0,
  _curWayPointKey = nil,
  _isGuildWareHouse = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/WareHouse/Panel_Window_WareHouse_Search_All_1.lua")
runLua("UI_Data/Script/Window/WareHouse/Panel_Window_WareHouse_Search_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_WareHouseSearchInit")
function FromClient_WareHouseSearchInit()
  PaGlobal_WareHouse_Search_All:initialize()
end
