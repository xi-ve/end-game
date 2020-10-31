PaGlobal_PetControl_All = {
  _ui = {
    Btn_PetInfo = nil,
    Btn_Follow = nil,
    Btn_Wait = nil,
    Btn_Find = nil,
    Btn_GetItem = nil,
    Btn_Play = nil,
    Btn_Seal = nil,
    Dot_RedIcon = nil,
    Dot_GreenIcon = nil,
    Dot_YellowIcon = nil,
    Dot_PurpleIcon = nil,
    Dot_GrayIcon1 = nil,
    Dot_GrayIcon2 = nil,
    Btn_IconPet = nil,
    Stc_IconPetBg = nil,
    Stc_HungryBG = nil,
    Progrss_Hungry = nil,
    Txt_HungryAlert = nil,
    Btn_AllSeal = nil
  },
  _petIcons = {},
  _commandButtons = {},
  _maxUnsealCount = nil,
  _currentPetIndex = nil,
  _isPlayOpen = nil,
  _isHungry = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/PetInfo/Panel_Widget_PetControl_All_1.lua")
runLua("UI_Data/Script/Window/PetInfo/Panel_Widget_PetControl_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PetControl_All_Init")
function FromClient_PetControl_All_Init()
  PaGlobal_PetControl_All:initialize()
end
