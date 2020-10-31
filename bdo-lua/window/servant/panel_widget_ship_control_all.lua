PaGlobal_Ship_Control_All = {
  _ui = {
    stc_TitleArea = nil,
    btn_Close = nil,
    btn_ShipCall = nil,
    btn_ShipDrive = nil,
    btn_GoDrive = nil,
    stc_KeyGuide = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/Panel_Widget_Ship_Control_All_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_Widget_Ship_Control_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Ship_Control_All_Init")
function FromClient_Ship_Control_All_Init()
  PaGlobal_Ship_Control_All:initialize()
end
