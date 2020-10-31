function PaGlobal_MusicAlbum_All:initialize()
  if true == PaGlobal_MusicAlbum_All._initialize then
    return
  end
  Panel_Window_MusicAlbum_All:SetShow(false)
  Panel_Window_MusicAlbum_All:setGlassBackground(true)
  Panel_Window_MusicAlbum_All:ActiveMouseEventEffect(false)
  self._ui._txt_titleBar = UI.getChildControl(Panel_Window_MusicAlbum_All, "StaticText_Title")
  self._ui._btn_close = UI.getChildControl(self._ui._txt_titleBar, "Button_Close")
  self._ui._btn_refresh = UI.getChildControl(self._ui._txt_titleBar, "Button_Refresh")
  self._ui._webControl = UI.createControl(__ePAUIControl_WebControl, Panel_Window_MusicAlbum_All, "WebControl_MusicAlbum_WebLink")
  self._ui._webControl:SetShow(true)
  self._ui._webControl:SetHorizonCenter()
  self._ui._webControl:SetVerticalTop()
  self._ui._webControl:SetSpanSize(0, 60)
  self._ui._webControl:SetSize(self._web_basicSize.x, self._web_basicSize.y)
  self._ui._webControl:ComputePos()
  self._ui._webControl:ResetUrl()
  self._ui._btn_refresh:SetShow(_ContentsGroup_ResetCoherent)
  PaGlobal_MusicAlbum_All:registEventHandler()
  PaGlobal_MusicAlbum_All:validate()
  PaGlobal_MusicAlbum_All._initialize = true
end
function PaGlobal_MusicAlbum_All:registEventHandler()
  if nil == Panel_Window_MusicAlbum_All then
    return
  end
  registerEvent("FromClient_OnDownloadFromWeb", "FromClient_MusicAlbum_loadMusic")
  registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForMusicAlbum")
  Panel_Window_MusicAlbum_All:RegisterShowEventFunc(true, "PaGlobal_MusicAlbum_All_ShowAni()")
  Panel_Window_MusicAlbum_All:RegisterShowEventFunc(false, "PaGlobal_MusicAlbum_All_HideAni()")
  PaGlobal_Util_RegistWebResetControl(self._ui._btn_refresh)
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_MusicAlbum_All_Close()")
end
function PaGlobal_MusicAlbum_All:prepareOpen(musicIndex)
  if nil == Panel_Window_MusicAlbum_All then
    return
  end
  if not ToClient_IsPopUpToggle() then
    return
  end
  if isGameTypeKR2() then
    return
  end
  audioPostEvent_SystemUi(13, 6)
  _AudioPostEvent_SystemUiForXBOX(13, 6)
  self._updateTempSaveTime = 0
  self:resize()
  local url = self:getURL()
  self._ui._webControl:SetUrl(self._web_basicSize.x, self._web_basicSize.y, url, false, true)
  self._ui._webControl:SetIME(true)
  PaGlobal_MusicAlbum_All:open()
end
function PaGlobal_MusicAlbum_All:open()
  if nil == Panel_Window_MusicAlbum_All then
    return
  end
  Panel_Window_MusicAlbum_All:SetShow(true)
end
function PaGlobal_MusicAlbum_All:prepareClose()
  if nil == Panel_Window_MusicAlbum_All then
    return
  end
  audioPostEvent_SystemUi(13, 5)
  _AudioPostEvent_SystemUiForXBOX(13, 5)
  ToClient_StopMusic(false)
  self._ui._webControl:ResetUrl()
  PaGlobal_MusicAlbum_All:close()
end
function PaGlobal_MusicAlbum_All:close()
  if nil == Panel_Window_MusicAlbum_All then
    return
  end
  Panel_Window_MusicAlbum_All:SetShow(false)
end
function PaGlobal_MusicAlbum_All:update()
  if nil == Panel_Window_MusicAlbum_All then
    return
  end
end
function PaGlobal_MusicAlbum_All:validate()
  if nil == Panel_Window_MusicAlbum_All then
    return
  end
end
function PaGlobal_MusicAlbum_All:resize()
  if nil == Panel_Window_MusicAlbum_All then
    return
  end
  self._ui._txt_titleBar:SetSize(self._panel_basicSize.x, self._ui._txt_titleBar:GetSizeY())
  Panel_Window_MusicAlbum_All:SetSize(self._panel_basicSize.x, self._panel_basicSize.y)
  self._ui._webControl:SetHorizonCenter()
  self._ui._webControl:SetVerticalTop()
  self._ui._webControl:SetSpanSize(0, 60)
  self._ui._webControl:SetSize(self._web_basicSize.x, self._web_basicSize.y)
  self._ui._webControl:ComputePos()
  Panel_Window_MusicAlbum_All:SetPosX(getScreenSizeX() * 0.5 - Panel_Window_MusicAlbum_All:GetSizeX() * 0.5)
  Panel_Window_MusicAlbum_All:SetPosY(getScreenSizeY() * 0.5 - Panel_Window_MusicAlbum_All:GetSizeY() * 0.5)
  self._ui._btn_close:ComputePos()
end
function PaGlobal_MusicAlbum_All:getURL()
  if nil == getSelfPlayer() then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local url = PaGlobal_URL_Check() .. "/CompositionNotes?"
  local userNickName = getSelfPlayer():getUserNickname()
  local isGm = ToClient_SelfPlayerIsGM()
  local cryptKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  local userNo = getSelfPlayer():get():getUserNo()
  local url = url .. "userNickName=" .. tostring(userNickName) .. "&gm=" .. tostring(isGm) .. "&certKey=" .. tostring(cryptKey) .. "&userNo=" .. tostring(userNo)
  return url
end
