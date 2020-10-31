PaGlobal_MyInstruments_All = {
  _ui = {
    _btn_Close_PC = nil,
    _btn_WayPoint_Shop = nil,
    _list2 = nil,
    _btn_Confirm = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Composition/Panel_Window_MyInstruments_All_1.lua")
runLua("UI_Data/Script/Window/Composition/Panel_Window_MyInstruments_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MyInstrumentsInit")
function FromClient_MyInstrumentsInit()
  PaGlobal_MyInstruments_All:initialize()
end
