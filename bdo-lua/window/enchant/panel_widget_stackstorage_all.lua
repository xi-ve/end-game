PaGlobal_StackStorage_All = {
  _ui = {
    stc_ringBG = nil,
    btn_left = nil,
    btn_right = nil,
    template_slot = nil,
    _slot = {}
  },
  _defaultPosition = {
    [0] = {x = -6, y = 30},
    [1] = {x = 81, y = 113},
    [2] = {x = 198, y = 160},
    [3] = {x = 330, y = 160},
    [4] = {x = 447, y = 113},
    [5] = {x = 534, y = 30}
  },
  _defaultCount = 4,
  _startSlotNo = 0,
  _maxSlotCount = 10,
  _aniTime = 0,
  _aniStart = false,
  _isRightAni = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Enchant/Panel_Widget_StackStorage_All_1.lua")
runLua("UI_Data/Script/Window/Enchant/Panel_Widget_StackStorage_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_StackStorage_All_Init")
function FromClient_StackStorage_All_Init()
  PaGlobal_StackStorage_All:initialize()
end
