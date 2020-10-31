PaGlobal_PowerSave_All = {
  _ui = {
    stc_center = nil,
    stc_top = nil,
    stc_bottom = nil,
    stc_centerEffect = nil,
    txt_desc = nil
  },
  _originMarkPosX = 0,
  _originTopMarkPosY = 0,
  _originBottomMarkPosY = 0,
  _isAnimating = false,
  _isOpen = false,
  _initialize = false,
  _renderMode = nil
}
runLua("UI_Data/Script/Window/PowerSave/Panel_Window_PowerSave_All_1.lua")
runLua("UI_Data/Script/Window/PowerSave/Panel_Window_PowerSave_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_PowerSave_All_Init")
function FromClient_PaGlobal_PowerSave_All_Init()
  PaGlobal_PowerSave_All:initialize()
end
