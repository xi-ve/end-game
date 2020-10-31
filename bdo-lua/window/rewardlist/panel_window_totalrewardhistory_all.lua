PaGlobal_TotalRewardHistory_All = {
  _mainControl = nil,
  _ui = {
    frame_itemLog = nil,
    frame_itemLog_content = nil,
    frame_itemLog_vscroll = nil,
    frame_itemLog_vscroll_ctrl = nil,
    stc_keyGuideBg = nil,
    stc_keyGuideScroll = nil,
    txt_noLog = nil,
    txt_dateTitle = nil,
    stc_itemLog = nil
  },
  _isConsole = false,
  _logTable = {},
  _itemLogControl = {},
  _initialize = false
}
runLua("UI_Data/Script/Window/RewardList/Panel_Window_TotalRewardHistory_All_1.lua")
runLua("UI_Data/Script/Window/RewardList/Panel_Window_TotalRewardHistory_All_2.lua")
function FromClient_TotalRewardHistory_All_Init()
  PaGlobal_TotalRewardHistory_All:initialize()
end
