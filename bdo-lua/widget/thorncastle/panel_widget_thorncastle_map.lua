PaGlobal_ThornCastle_Map = {
  _ui = {
    _backBG = nil,
    _mapTexture = nil,
    _selfIcon = nil,
    _cripIcon = nil,
    _bossIcon = nil,
    _npcIcon = nil,
    _teamIcon = {}
  },
  _mapSizeX = 0,
  _mapSizeY = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_Map_1.lua")
runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_Map_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ThornCastle_MapInit")
function FromClient_ThornCastle_MapInit()
  PaGlobal_ThornCastle_Map:initialize()
end
