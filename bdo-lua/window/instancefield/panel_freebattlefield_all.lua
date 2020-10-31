PaGlobal_FreeBaettleField_All = {
  _ui = {
    btn_close = nil,
    list2_FieldList = nil,
    stc_KeyGuide_Bg = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil,
    stc_KeyGuide_Y = nil,
    txt_desc = nil
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/InstanceField/Panel_FreeBattleField_All_1.lua")
runLua("UI_Data/Script/Window/InstanceField/Panel_FreeBattleField_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_FreeBattleField_Init")
function FromClient_FreeBattleField_Init()
  PaGlobal_FreeBaettleField_All:initialize()
end
