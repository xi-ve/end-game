PaGlobal_PetInfo_All = {
  _ui = {
    stc_PetIcon = nil,
    stc_ActionTitle = nil,
    txt_PetName = nil,
    txt_PetLevel = nil,
    progress_PetExp = nil,
    txt_ExpValue = nil,
    txt_Tier = nil,
    txt_baseSkill = nil,
    txt_SpecialSkill = nil
  },
  _ui_pc = {btn_Close = nil, btn_Question = nil},
  _ui_console = {stc_KeyGuideBG = nil, txt_KeyGuideB = nil},
  _actionSlot = {},
  _actionCount = nil,
  _skillSlot = {},
  _skillDesc = {},
  _skillCount = nil,
  _skillDescGapSizeY = 50,
  _currentPetNo = nil,
  _currentPetLv = nil,
  _isConsole = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetInfo_All_1.lua")
runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetInfo_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PetInfo_All_Init")
function FromClient_PetInfo_All_Init()
  PaGlobal_PetInfo_All:initialize()
end
