PaGlobal_ItemFilter_All = {
  _ui = {
    _txt_title = nil,
    _btn_select = nil,
    _btn_cancel = nil,
    _stc_mainBG = nil,
    _rdo_slotBG = nil,
    _txt_itemSpec = nil,
    _stc_KeyGuideBG = nil,
    _txt_KeyGuideA = nil,
    _txt_KeyGuideB = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCooltime = true,
    createExpiration = true,
    createExpirationBG = true,
    createExpiration2h = true,
    createClassEquipBG = true,
    createEnduranceIcon = true,
    createCash = true,
    createBagIcon = true,
    createEnduranceIcon = true,
    createCheckBox = true
  },
  _config = {
    slotCount = 0,
    slotCols = 5,
    slotRows = 2,
    slotStartX = 5,
    slotStartY = 5,
    slotGapX = 50,
    slotGapY = 50
  },
  _rdo_slots = nil,
  _itemSlots = nil,
  _slotIdxList = nil,
  _lastSlotIndex = 0,
  _currentSlotIndex = 1,
  _servantNo = nil,
  _eType = __eServantSupplyItemType_Food,
  _isGuild = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Common/Panel_Window_ItemFilter_All_1.lua")
runLua("UI_Data/Script/Window/Common/Panel_Window_ItemFilter_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ItemFilter_All_Init")
function FromClient_ItemFilter_All_Init()
  PaGlobal_ItemFilter_All:initialize()
end
