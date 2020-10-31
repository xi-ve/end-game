PaGlobal_SummonBelmorn = {
  _actionType = {
    belmorn0 = 621,
    belmorn1 = 622,
    belmorn2 = 623,
    belmorn3 = 624,
    belmorn4 = 625,
    belmorn5 = 626,
    belmorn6 = 627
  },
  _ui = {
    _stc_faceLeft = nil,
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
runLua("UI_Data/Script/Widget/Tutorial/Panel_Widget_SummonBelmorn_1.lua")
runLua("UI_Data/Script/Widget/Tutorial/Panel_Widget_SummonBelmorn_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SummonBelmorn_Init")
function FromClient_SummonBelmorn_Init()
  PaGlobal_SummonBelmorn:initialize()
end
