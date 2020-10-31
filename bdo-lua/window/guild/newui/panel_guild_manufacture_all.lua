PaGlobal_Guild_Manufacture_All = {
  _ui = {
    stc_topArea = nil,
    txt_subTitle = nil,
    stc_mainArea = nil,
    stc_slotBG = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true
  },
  _slot = Array.new(),
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_Manufacture_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_Manufacture_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Guild_Manufacture_All_Init")
function FromClient_Guild_Manufacture_All_Init()
  PaGlobal_Guild_Manufacture_All:initialize()
end
