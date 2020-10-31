PaGlobal_TotalReward_All = {
  _ui = {
    stc_topGroup = nil,
    stc_contentGroup = nil,
    stc_bottomGroup = nil,
    stc_bottom_KeyGuides = nil,
    btn_close = nil,
    btn_itemLog = nil,
    txt_itemLogText = nil,
    stc_mouseR = nil,
    txt_receiveBagText = nil,
    frame_BG = nil,
    frame_totalReward = nil,
    frame_content = nil,
    stc_group = nil,
    txt_groupTitle = nil,
    stc_itemSlotBg = nil,
    txt_noItem = nil,
    frame_totalReward_vscroll = nil,
    frame_totalReward_vscroll_ctrl = nil,
    btn_receiveSilver = nil,
    btn_receiveAll = nil,
    stc_moneyArea = nil,
    stc_rewardArea = nil,
    txt_moneyText = nil,
    txt_rewardText = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _uiSlot = {},
  _itemDatas = {},
  _categoryGroups = {},
  _rewardSilver = toInt64(0, 0),
  _rewardSilverIndex = {},
  _ICONSIZE = 46,
  _COL_SLOT_COUNT = 8,
  _CONTENT_FRAME_SIZE_Y = 420,
  _ORIGIN_PANEL_SIZE_Y = 710,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/RewardList/Panel_Window_TotalReward_All_1.lua")
runLua("UI_Data/Script/Window/RewardList/Panel_Window_TotalReward_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_TotalReward_All_Init")
registerEvent("FromClient_luaLoadComplete", "FromClient_TotalRewardHistory_All_Init")
function FromClient_TotalReward_All_Init()
  PaGlobal_TotalReward_All:initialize()
end
