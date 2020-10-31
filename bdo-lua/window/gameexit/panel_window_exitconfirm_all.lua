PaGlobal_ExitConfirm_All = {
  _ui = {
    _stc_block = nil,
    _stc_bg = nil,
    _txt_title = nil,
    _btn_confirm = nil,
    _btn_close = nil,
    _txt_rewardDesc = nil,
    _txt_gameExitDesc = nil
  },
  _dailyStampSlotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  },
  _changeTexture = {},
  _changeItemText = {},
  _changeBaseText = {},
  _changeBtnText = {},
  _rewardCount = 3,
  _dayControl = {},
  _initialize = false
}
runLua("UI_Data/Script/Window/GameExit/Panel_Window_ExitConfirm_All_1.lua")
runLua("UI_Data/Script/Window/GameExit/Panel_Window_ExitConfirm_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ExitConfirm_All_Init")
function FromClient_ExitConfirm_All_Init()
  PaGlobal_ExitConfirm_All:initialize()
end
