PaGlobal_MovieJapanGlay25 = {
  _ui = {stc_movie = nil},
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_MovieJapanGlay25_Init")
function FromClient_MovieJapanGlay25_Init()
  PaGlobal_MovieJapanGlay25:initialize()
end
function PaGlobal_MovieJapanGlay25:initialize()
  if true == PaGlobal_MovieJapanGlay25._initialize or nil == Panel_MovieJapanGlay then
    return
  end
  local sizeX = getResolutionSizeX()
  local sizeY = getResolutionSizeY()
  local uiScale = getGlobalScale()
  sizeX = sizeX / uiScale
  sizeY = sizeY / uiScale
  local movieSizeX = sizeX
  local movieSizeY = sizeX * 9 / 16
  local posX = 0
  local posY = 0
  if sizeY >= movieSizeY then
    posY = (sizeY - movieSizeY) / 2
  else
    movieSizeX = sizeY * 16 / 9
    movieSizeY = sizeY
    posX = (sizeX - movieSizeX) / 2
  end
  Panel_MovieJapanGlay:SetPosX(0)
  Panel_MovieJapanGlay:SetPosY(0)
  Panel_MovieJapanGlay:SetSize(sizeX, sizeY)
  self._ui.stc_movie = UI.createControl(__ePAUIControl_WebControl, Panel_MovieJapanGlay, "WebControl_Movie")
  self._ui.stc_movie:SetPosX(0)
  self._ui.stc_movie:SetPosY(0)
  self._ui.stc_movie:SetSize(movieSizeX, movieSizeY)
  self._isConsole = _ContentsGroup_RenewUI
  PaGlobal_MovieJapanGlay25:validate()
  PaGlobal_MovieJapanGlay25:registEventHandler()
  PaGlobal_MovieJapanGlay25._initialize = true
end
function PaGlobal_MovieJapanGlay25:prepareOpen()
  if nil == Panel_MovieJapanGlay then
    return
  end
  registerEvent("ToClient_InGameMovieCutScene", "FromClient_MovieJapanGlay25_MovieScene")
  PaGlobal_MovieJapanGlay25._masterVolume = getVolumeParam(0)
  PaGlobal_MovieJapanGlay25:resize()
  PaGlobal_MovieJapanGlay25:open()
  PaGlobal_MovieJapanGlay25:update()
end
function PaGlobal_MovieJapanGlay25:dataclear()
  self._ui.stc_movie:TriggerEvent("StopMovie", "")
  self._ui.stc_movie:ResetUrl()
  self._ui.stc_movie:SetShow(false)
  SetUIMode(Defines.UIMode.eUIMode_Default)
  setMoviePlayMode(false)
  setVolumeParamMaster(self._masterVolume)
end
function PaGlobal_MovieJapanGlay25:open()
  if nil == Panel_MovieJapanGlay then
    return
  end
  toClient_FadeInWithDarkTime(0.5, 1)
  Panel_MovieJapanGlay:SetShow(true)
end
function PaGlobal_MovieJapanGlay25:prepareClose()
  if nil == Panel_MovieJapanGlay then
    return
  end
  PaGlobal_MovieJapanGlay25:dataclear()
  PaGlobal_MovieJapanGlay25:close()
end
function PaGlobal_MovieJapanGlay25:close()
  if nil == Panel_MovieJapanGlay then
    return
  end
  Panel_MovieJapanGlay:SetShow(false)
end
function PaGlobal_MovieJapanGlay25:update()
  if nil == Panel_MovieJapanGlay then
    return
  end
  if nil == self._ui.stc_movie then
    return
  end
  self._ui.stc_movie:SetUrl(1920, 1080, "coui://UI_Data/UI_Html/InGame_Movie.html")
  setMoviePlayMode(true)
end
function PaGlobal_MovieJapanGlay25:registEventHandler()
  if nil == Panel_MovieJapanGlay then
    return
  end
  registerEvent("ToClient_InGameMovieCutScene", "FromClient_MovieJapanGlay25_MovieScene")
  registerEvent("onScreenResize", "PaGlobalFunc_MovieJapnaGlay25_Resize")
end
function PaGlobal_MovieJapanGlay25:validate()
  if nil == Panel_MovieJapanGlay then
    return
  end
end
function PaGlobal_MovieJapanGlay25:resize()
  if nil == Panel_MovieJapanGlay then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  Panel_MovieJapanGlay:SetSize(screenSizeX, screenSizeY)
  Panel_MovieJapanGlay:SetPosX(0)
  Panel_MovieJapanGlay:SetPosY(0)
  self._ui.stc_movie:SetSize(screenSizeX, screenSizeY)
  self._ui.stc_movie:SetPosX(0)
  self._ui.stc_movie:SetPosY(0)
end
function PaGlobalFunc_MovieJapnaGlay25_Open()
  PaGlobal_MovieJapanGlay25:prepareOpen()
end
function PaGlobalFunc_MovieJapnaGlay25_Close()
  PaGlobal_MovieJapanGlay25:prepareClose()
end
function FromClient_MovieJapanGlay25_MovieScene(param)
  if param == 1 then
    if nil ~= PaGlobal_MovieJapanGlay25._ui.stc_movie then
      PaGlobal_MovieJapanGlay25._ui.stc_movie:SetShow(true)
      PaGlobal_MovieJapanGlay25._ui.stc_movie:TriggerEvent("PlayMovie", "coui://UI_Movie/JP_Movie/Glay_25.webm")
    end
  elseif param == 2 then
    PaGlobal_MovieJapanGlay25:prepareClose()
  end
end
