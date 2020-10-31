PaGlobal_SA_Window_WorldMap = {
  _ui = {
    stc_mapImage = {},
    stc_backMapImage = {},
    stc_mapLineCurrent = nil,
    stc_mapLineNext = nil,
    stc_iconPlayer = nil,
    stc_iconPartyMember = {},
    stc_textMemberName = {},
    stc_blackBG = nil
  },
  isShow = false,
  eIndexType = {
    backMapPanel = 1,
    blackBackImage = 2,
    mapPanel = 3,
    iconPlayer = 5,
    mapLineNext = 7,
    mapLineCurrent = 8
  },
  eResizeState = {
    non = 0,
    zone100 = 1,
    zone50 = 2,
    zone25 = 3
  },
  _config = {
    strCurrentLine = {
      "renewal/PcRemaster/Remaster_BattleRoyal_KillZone100.dds",
      "renewal/PcRemaster/Remaster_BattleRoyal_KillZone50.dds",
      "renewal/PcRemaster/Remaster_BattleRoyal_KillZone25.dds"
    },
    strNextLine = {
      "renewal/PcRemaster/Remaster_BattleRoyal_SafeZone100.dds",
      "renewal/PcRemaster/Remaster_BattleRoyal_SafeZone50.dds",
      "renewal/PcRemaster/Remaster_BattleRoyal_SafeZone25.dds"
    },
    uvLine = {
      {
        x1 = 0,
        x2 = 256,
        y1 = 0,
        y2 = 256
      },
      {
        x1 = 0,
        x2 = 600,
        y1 = 0,
        y2 = 600
      },
      {
        x1 = 0,
        x2 = 326,
        y1 = 0,
        y2 = 326
      },
      {
        x1 = 0,
        x2 = 101,
        y1 = 0,
        y2 = 101
      }
    },
    currentLineOffset = 0.04,
    nextLineOffset = 0.05
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
  _partyMemberInfo = {
    count = 0,
    maxCount = 3,
    _beforeSector = {},
    _beforeSectorIndex = 0,
    _beforeMemberPos = {}
  },
  _calculateSectorSize = 128,
  _sectorRatio = 0.01,
  _clientSectorSize = 12800,
  _offsetX = 5,
  _offsetY = 5,
  _lostRegionDeltaTime = 0,
  _lostRegionRefreshTime = 1,
  _radar_type_boos = 5,
  _sizeScale = 1,
  _eResizeState = 0,
  _initialize = false,
  ping = {
    _listPingMax = 80,
    _listPingIdx = 0,
    _listPing = {}
  }
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Window_WorldMap_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Window_WorldMap_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Window_WorldMapInit")
function FromClient_SA_Window_WorldMapInit()
  PaGlobal_SA_Window_WorldMap:initialize()
end
