PaGlobal_SeasonReward_All = {
  _ui = {
    stc_titleBG = nil,
    btn_close = nil,
    list2_season = nil,
    stc_centerBG = nil,
    stc_topBG = nil,
    stc_slotGroup = nil,
    template_radioSlot = nil,
    txt_seasonTitle = nil,
    rewardSlotList = {},
    rewardItemSlot = nil,
    stc_rewardBG = nil,
    stc_itemSlotBG = nil,
    stc_itemSlot = nil,
    txt_itemName = nil,
    txt_ready = nil,
    txt_complete = nil,
    txt_lock = nil,
    stc_normalEffect = nil,
    stc_exchangeEffect = nil,
    stc_descBG = nil,
    txt_conditionDesc = nil,
    stc_bottomBG = nil,
    txt_ticketCount = nil,
    btn_exchange = nil,
    stc_keyguideBG = nil,
    stc_keyguideA = nil,
    stc_keyguideB = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCash = true
  },
  _maxRewardCount = 5,
  _selectedSeasonNo = 1,
  _selectedItemIndex = 1,
  _slotGroupSizeX = 240,
  _slotSizeX = 48,
  _isConsole = _ContentsGroup_UsePadSnapping,
  _initialize = false
}
runLua("UI_Data/Script/Window/Season/Panel_Window_SeasonReward_All_1.lua")
runLua("UI_Data/Script/Window/Season/Panel_Window_SeasonReward_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_SeasonReward_All_Init")
function FromClient_luaLoadComplete_SeasonReward_All_Init()
  PaGlobal_SeasonReward_All:initialize()
end
