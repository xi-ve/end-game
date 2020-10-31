PaGlobal_SummonZod = {
  _actionType = {zod = 620},
  _ui = {
    _stc_faceLeft = nil,
    _stc_faceRight = nil,
    _stc_textBg = nil,
    _txt_characterName = nil,
    _txt_script = nil
  },
  _data = {},
  _isStartStory = false,
  _currentAction = 0,
  _currentStep = 0,
  _currentDeltaTime = 0,
  _nextDeltaTime = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Tutorial/Panel_Widget_SummonZod_1.lua")
runLua("UI_Data/Script/Widget/Tutorial/Panel_Widget_SummonZod_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SummonZod_Init")
function FromClient_SummonZod_Init()
  PaGlobal_SummonZod:initialize()
end
