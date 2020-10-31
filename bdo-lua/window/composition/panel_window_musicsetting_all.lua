PaGlobal_MusicSetting_All = {
  _ui = {
    _rbtn_Track = {},
    _static_txt_title = nil,
    _btn_Close = nil,
    _txt_MusicName = nil,
    _txt_PlayTime = nil,
    _txt_AuthorName = nil,
    _txt_ConposerName = nil,
    _rbtn_Solo = nil,
    _rbtn_Ensemble = nil,
    _btn_Request = nil,
    _btn_Play = nil,
    _btn_Cancel = nil,
    _static_MainBg = nil,
    _static_stateBg = nil,
    _static_playKindBg = nil,
    _static_BottomBg = nil,
    _static_selectCharaterBg = nil,
    _static_selectCharaterList = nil
  },
  _playKindBgPos = nil,
  _selectIndex = 0,
  _characterIndexList = {},
  _isOpenTrack = {},
  _type = {
    _SOLO = 0,
    _ENSEMBLE = 1,
    _COUNT = 2
  },
  _partyInfo = {},
  _partyCnt = 4,
  _stateStr = {
    _WAIT = PAGetString(Defines.StringSheet_GAME, "LUA_MUSIC_RESEMBLE_WAIT"),
    _READY = PAGetString(Defines.StringSheet_GAME, "LUA_MUSIC_RESEMBLE_READY"),
    _REFUSE = PAGetString(Defines.StringSheet_GAME, "LUA_MUSIC_RESEMBLE_REFUSE")
  },
  _state = {
    _WAIT = 0,
    _READY = 1,
    _REFUSE = 2
  },
  _currentType = 2,
  _musicIndex = -1,
  _trackIndex = -1,
  _initialize = false,
  _defaultSizeY = 0,
  _resembleGap = 100,
  _trackStartPosX = 0,
  _trackGapX = 0,
  _isRequestEnsemble = false,
  _panelDefaultSizeY = 0,
  _mainBgDefaultSizeY = 0,
  _instrumentTrackListSize = 0
}
runLua("UI_Data/Script/Window/Composition/Panel_Window_MusicSetting_All_1.lua")
runLua("UI_Data/Script/Window/Composition/Panel_Window_MusicSetting_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MusicSetting_All_Init")
function FromClient_MusicSetting_All_Init()
  PaGlobal_MusicSetting_All:initialize()
end
