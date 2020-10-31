PaGlobal_SA_Widget_Minimap = {
  _ui = {
    stc_miniMap = nil,
    stc_regionCondition = nil,
    txt_remainTimer = nil,
    stc_InvenBG = nil,
    txt_inven = nil,
    stc_keyInven = nil,
    stc_EscBG = nil,
    stc_keyEsc = nil,
    txt_Esc = nil,
    stc_mapImage = {},
    stc_backMapImage = {}
  },
  _initialize = false,
  _isShow = false,
  _eIndexType = {
    backMapPanel = 1,
    blackBackImage = 2,
    mapPanel = 3,
    iconPlayer = 5,
    mapLineNext = 7,
    mapLineCurrent = 8
  },
  _eResizeStateType = {
    non = 0,
    zone100 = 1,
    zone50 = 2,
    zone25 = 3
  },
  _maxMapWcount = 10,
  _maxMapHcount = 10,
  _minimapSize = int2(0, 0),
  _resizeMinimapSize = int2(0, 0),
  _miniSectorSize = int2(0, 0),
  _playerIconBasePos = int2(0, 0),
  _sectorIndex = {},
  _sectorStartPos = {},
  _beforePlayerPos = int3(0, 0, 0),
  _beforeSector = int3(0, 0, 0),
  _beforeSectorIndex = 0,
  _beforeRotate = 0,
  _beforeSector_LB = int2(0, 0),
  _beforeSector_RT = int2(0, 0),
  _ratio = {x = 0, y = 0},
  _lostRegionInfo = {
    currentPos = float2(0, 0),
    currentRadius = 9999999,
    nextPos = float2(0, 0),
    nextRadius = 9999999,
    isCallNextRegion = false
  },
  _calculateSectorSize = 128,
  _sectorRatio = 0.01,
  _clientSectorSize = 12800,
  _offsetX = 5,
  _offsetY = 5,
  _lostRegionDeltaTime = 0,
  _lostRegionRefreshTime = 1,
  _sizeScale = 1,
  _eResizeState = 0,
  _brStartTime = 0,
  _timer = 0,
  _lastUpdateTime = 0,
  _isGameStart = false
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Minimap_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Minimap_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_MinimapInit")
function FromClient_SA_Widget_MinimapInit()
  PaGlobal_SA_Widget_Minimap:initialize()
end
