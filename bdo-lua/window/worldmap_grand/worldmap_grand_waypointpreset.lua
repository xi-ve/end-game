PaGlobal_Worldmap_Grand_WaypointPreset = {
  _ui = {
    _waypointBtn = {},
    _applyBtn = nil,
    _deleteBtn = nil,
    _closeBtn = nil
  },
  _maxCount = 3,
  _targetIdx = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/WorldMap_Grand/Worldmap_Grand_WaypointPreset_1.lua")
runLua("UI_Data/Script/Window/WorldMap_Grand/Worldmap_Grand_WaypointPreset_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_Worldmap_Grand_WaypointPreset_Init")
function FromClient_luaLoadComplete_Worldmap_Grand_WaypointPreset_Init()
  PaGlobal_Worldmap_Grand_WaypointPreset:initialize()
end
