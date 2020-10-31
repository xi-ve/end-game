PaGlobal_Worldmap_Grand_WaypointOption = {
  _ui = {
    _title = nil,
    _mainBG = nil,
    _typeOptionBtn = {},
    _styleOptionBtn = {},
    _typeOptionBtnDesc = nil,
    _styleOptionBtnDesc = nil,
    _applyBtn = nil,
    _deleteBtn = nil,
    _closeBtn = nil
  },
  _optionCount = 2,
  _targetTypeOption = nil,
  _targetStyleOption = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/WorldMap_Grand/Worldmap_Grand_WaypointOption_1.lua")
runLua("UI_Data/Script/Window/WorldMap_Grand/Worldmap_Grand_WaypointOption_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_Worldmap_Grand_WaypointOption_Init")
function FromClient_luaLoadComplete_Worldmap_Grand_WaypointOption_Init()
  PaGlobal_Worldmap_Grand_WaypointOption:initialize()
end
