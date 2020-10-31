PaGlobal_BloodAltarRetry_All = {
  _ui = {
    stc_backBG = nil,
    stc_descBG = nil,
    txt_desc = nil,
    stc_bottomBtnBG = nil,
    btn_retry = nil,
    txt_hasItem = nil,
    btn_cancel = nil,
    stc_keyGuideBg = nil
  },
  _needItemHasCount = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/BloodAltar/Panel_Window_BloodAltarRetry_All_1.lua")
runLua("UI_Data/Script/Window/BloodAltar/Panel_Window_BloodAltarRetry_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_BloodAltarRetry_Initialize")
function FromClient_BloodAltarRetry_Initialize()
  PaGlobal_BloodAltarRetry_All:initialize()
end
