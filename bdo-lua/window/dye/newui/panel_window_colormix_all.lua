PaGlobal_ColorMix = {
  _ui = {
    stc_titleBG = nil,
    stc_mainBG = nil,
    stc_descBG = nil,
    txt_desc = nil,
    stc_Arrow = nil
  },
  _ui_pc = {btn_close = nil, btn_mixColor = nil},
  _ui_console = {},
  _slotConfig = {
    createIcon = true,
    createBorder = false,
    createCount = true,
    createCash = true
  },
  _slotCount = 3,
  _slotList = {},
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Dye/NewUI/Panel_Window_ColorMix_All_1.lua")
runLua("UI_Data/Script/Window/Dye/NewUI/Panel_Window_ColorMix_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ColorMixInit")
function FromClient_ColorMixInit()
  PaGlobal_ColorMix:initialize()
end
