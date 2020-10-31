PaGlobal_SelectInstruments_All = {
  _ui = {
    _btn_Close_PC = nil,
    _btn_Close = nil,
    _btn_WayPoint_Shop = nil,
    _list2 = nil,
    _btn_Confirm = nil
  },
  _selectMusicIndex = -1,
  _selectTrackIndex = -1,
  _initialize = false
}
runLua("UI_Data/Script/Window/Composition/Panel_Window_SelectInstruments_All_1.lua")
runLua("UI_Data/Script/Window/Composition/Panel_Window_SelectInstruments_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SelectInstruments")
function FromClient_SelectInstruments()
  PaGlobal_SelectInstruments_All:initialize()
end
