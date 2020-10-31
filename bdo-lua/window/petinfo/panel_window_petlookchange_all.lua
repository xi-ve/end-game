PaGlobal_PetLookChange_All = {
  _ui = {
    stc_TitleBG = nil,
    stc_PetIconBG = nil,
    stc_PetIcon = nil,
    txt_LookIndex = nil,
    list2_Pet = nil
  },
  _ui_pc = {
    btn_Title_Close = nil,
    btn_Title_Question = nil,
    btn_Left = nil,
    btn_Right = nil,
    btn_Bottom_Change = nil,
    btn_Bottom_Close = nil
  },
  _ui_console = {
    stc_KeyGuideLB = nil,
    stc_KeyGuideRB = nil,
    stc_KeyGuideGroup = nil,
    txt_KeyGuideY = nil,
    txt_KeyGuideB = nil
  },
  _selectedPetIndex = 0,
  _selectedLookIndex = 0,
  _petCount = 0,
  _changableIndex = {},
  _whereType = nil,
  _slotNo = nil,
  _isConsole = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetLookChange_All_1.lua")
runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetLookChange_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PetLookChange_All_Init")
function FromClient_PetLookChange_All_Init()
  PaGlobal_PetLookChange_All:initialize()
end
