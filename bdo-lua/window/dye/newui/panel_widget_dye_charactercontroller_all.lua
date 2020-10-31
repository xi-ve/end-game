PaGlobal_Dye_CharacterController = {
  _ui_pc = {
    chk_SeePlayer = nil,
    chk_ShowUI = nil,
    chk_Weather = nil,
    btn_Pose = nil,
    btn_Pallet = nil,
    btn_Inventory = nil,
    btn_Exit = nil
  },
  _ui_console = {
    stc_KeyGuideBG = nil,
    txt_KeyGuideLSClick = nil,
    txt_KeyGuideB = nil
  },
  _weatherCount = 6,
  _btn_Weather = {},
  _isLdown = false,
  _isRdown = false,
  _lMovePos = 0,
  _yMovePos = 0,
  _isPaletteShow = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Dye/NewUI/Panel_Widget_Dye_CharacterController_All_1.lua")
runLua("UI_Data/Script/Window/Dye/NewUI/Panel_Widget_Dye_CharacterController_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_Dye_CharacterController_Init")
function FromClient_PaGlobal_Dye_CharacterController_Init()
  PaGlobal_Dye_CharacterController:initialize()
end
