PaGlobal_GuideMessage = {
  _eState = {
    _non = 0,
    _state1Ing = 2,
    _state1End = 3,
    _state2Ing = 5,
    _state2End = 6
  },
  _ui = {_static_State1BG = nil, _static_State2BG = nil},
  _classList = {
    __eClassType_Warrior,
    __eClassType_Sorcerer,
    __eClassType_Giant,
    __eClassType_Tamer,
    __eClassType_BladeMaster,
    __eClassType_BladeMasterWoman,
    __eClassType_Mystic,
    __eClassType_Valkyrie,
    __eClassType_Kunoichi,
    __eClassType_DarkElf,
    __eClassType_WizardMan,
    __eClassType_WizardWoman,
    __eClassType_NinjaMan,
    __eClassType_Combattant,
    __eClassType_ElfRanger_Reserved1,
    __eClassType_ElfRanger_Reserved2,
    __eClassType_KunoichiOld
  },
  _isStart = false,
  _currentTime = 0,
  _currentState = 0,
  _STATE1_START_TIME = 20,
  _STATE1_END_TIME = 30,
  _STATE2_START_TIME = 32,
  _STATE2_END_TIME = 40,
  _initialize = false
}
runLua("UI_Data/Script/Instance/GuideMessage/Instance_Widget_GuideMessage_1.lua")
runLua("UI_Data/Script/Instance/GuideMessage/Instance_Widget_GuideMessage_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuideMessageInit")
function FromClient_GuideMessageInit()
  PaGlobal_GuideMessage:initialize()
end
