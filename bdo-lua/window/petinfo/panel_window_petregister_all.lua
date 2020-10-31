PaGlobal_PetRegister_All = {
  _ui = {
    stc_TitleBG = nil,
    stc_CenterBG = nil,
    edit_Name = nil,
    stc_PetIconBG = nil,
    stc_PetIcon = nil,
    txt_RegistDesc = nil,
    stc_NamingPolicyBG = nil,
    txt_NamingPolicy = nil
  },
  _ui_pc = {
    btn_Close = nil,
    stc_ButtonGroup = nil,
    btn_Confirm = nil,
    btn_Cancel = nil
  },
  _ui_console = {
    stc_KeyGuideGroup = nil,
    txt_KeyGuideX = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil
  },
  _config = {
    _defaultPetNameCount = 10,
    _defaultPetName = {
      [0] = "Darcy",
      [1] = "Buddy",
      [2] = "Orbit",
      [3] = "Rushmore",
      [4] = "Carolina",
      [5] = "Cindy",
      [6] = "Waffles",
      [7] = "Sparky",
      [8] = "Bailey",
      [9] = "Wichita",
      [10] = "Buck"
    }
  },
  _fromWhereType = -1,
  _fromSlotNo = -1,
  _isConsole = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetRegister_All_1.lua")
runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetRegister_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PetRegister_All_Init")
function FromClient_PetRegister_All_Init()
  PaGlobal_PetRegister_All:initialize()
end
