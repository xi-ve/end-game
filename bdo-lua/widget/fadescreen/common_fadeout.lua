PaGlobal_FadeOut = {
  _ui = {
    _loadingText = nil,
    temp_img1 = nil,
    temp_img2 = nil
  },
  _ANIMATION_TIME = 0.5,
  _initialize = false,
  _fadeDuration = 0,
  _fadeDruationMaxTime = 15,
  _currentFadeTIme = 0,
  _imageFadeTime = 3,
  _totalImageCount = 0,
  _currentImageIdx = 0,
  _bgImageTexture = {},
  _bgEmptyControl = {},
  _isImageFadeOut = false,
  _isFadeProcessing = false
}
runLua("UI_Data/Script/Widget/FadeScreen/Common_FadeOut_1.lua")
runLua("UI_Data/Script/Widget/FadeScreen/Common_FadeOut_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_FadeOutInit")
function FromClient_FadeOutInit()
  PaGlobal_FadeOut:initialize()
end
