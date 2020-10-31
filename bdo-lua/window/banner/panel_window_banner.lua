PaGlobal_Banner = {
  _eBannerType = {
    _onAir = 0,
    _eventBanner = 1,
    _blackFriday = 2,
    _newProduct = 3,
    _end = 4
  },
  _eFrameState = {
    _bannerView = 0,
    _bannerViewEnd = 1,
    _bannerCheck = 2,
    _end = 3
  },
  _ui = {
    _stc_bannerArea = nil,
    _txt_close = nil,
    _webControl = nil
  },
  _texureUV = {
    x1 = 0,
    y1 = 0,
    x2 = 323,
    y2 = 242
  },
  _currentBanner = 0,
  _currentFrame = 0,
  _isWholeState = false,
  _updateTime = 0,
  _checkEndTime = 3,
  _basicTexture = {},
  _isEnableWebControl = {},
  _isDontAgainAutoSave = {},
  _isFromEventDirect = {},
  _startAniTime = {},
  _endAniTime = {},
  _viewEndTime = {},
  _initialize = false
}
runLua("UI_Data/Script/Window/Banner/Panel_Window_Banner_1.lua")
runLua("UI_Data/Script/Window/Banner/Panel_Window_Banner_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Banner_Init")
function FromClient_Banner_Init()
  PaGlobal_Banner:initialize()
end
