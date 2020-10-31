function PaGlobal_MusicShare_All:initialize()
  if true == PaGlobal_MusicShare_All._initialize then
    return
  end
  Panel_Window_MusicShare_All:SetShow(false)
  Panel_Window_MusicShare_All:setGlassBackground(true)
  Panel_Window_MusicShare_All:ActiveMouseEventEffect(false)
  self._ui._txt_titleBar = UI.getChildControl(Panel_Window_MusicShare_All, "StaticText_Title")
  self._ui._btn_close = UI.getChildControl(self._ui._txt_titleBar, "Button_Close")
  self._ui._btn_refresh = UI.getChildControl(self._ui._txt_titleBar, "Button_Refresh")
  self._ui._webControl = UI.createControl(__ePAUIControl_WebControl, Panel_Window_MusicShare_All, "WebControl_MusicShare_WebLink")
  self._ui._webControl:SetShow(true)
  self._ui._webControl:SetPosX(self._web_basicPos.x)
  self._ui._webControl:SetPosY(self._web_basicPos.y)
  self._ui._webControl:SetSize(self._web_basicSize.x, self._web_basicSize.y)
  self._ui._webControl:ResetUrl()
  self._ui._btn_refresh:SetShow(_ContentsGroup_ResetCoherent)
  PaGlobal_MusicShare_All:registEventHandler()
  PaGlobal_MusicShare_All:validate()
  PaGlobal_MusicShare_All._initialize = true
end
function PaGlobal_MusicShare_All:registEventHandler()
  if nil == Panel_Window_MusicShare_All then
    return
  end
  registerEvent("FromClient_OpenExplorer", "FromClient_MusicShare_UploadMusic")
  registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForMusicShare")
  Panel_Window_MusicShare_All:RegisterShowEventFunc(true, "PaGlobal_MusicShare_All_ShowAni()")
  Panel_Window_MusicShare_All:RegisterShowEventFunc(false, "PaGlobal_MusicShare_All_HideAni()")
  PaGlobal_Util_RegistWebResetControl(self._ui._btn_refresh)
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_MusicShare_All_Close()")
end
function PaGlobal_MusicShare_All:prepareOpen(musicIndex)
  if nil == Panel_Window_MusicShare_All then
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
  self:resize()
  self._musicIndex = musicIndex
  local url = self:getURL()
  self._ui._webControl:SetUrl(self._web_basicSize.x, self._web_basicSize.y, url, false, true)
  self._ui._webControl:SetIME(true)
  PaGlobal_MusicShare_All:open()
end
function PaGlobal_MusicShare_All:open()
  if nil == Panel_Window_MusicShare_All then
    return
  end
  Panel_Window_MusicShare_All:SetShow(true)
end
function PaGlobal_MusicShare_All:prepareClose()
  if nil == Panel_Window_MusicShare_All then
    return
  end
  audioPostEvent_SystemUi(13, 5)
  _AudioPostEvent_SystemUiForXBOX(13, 5)
  ToClient_StopMusic(false)
  self._musicIndex = -1
  self._ui._webControl:ResetUrl()
  PaGlobal_MusicShare_All:close()
end
function PaGlobal_MusicShare_All:close()
  if nil == Panel_Window_MusicShare_All then
    return
  end
  Panel_Window_MusicShare_All:SetShow(false)
end
function PaGlobal_MusicShare_All:update()
  if nil == Panel_Window_MusicShare_All then
    return
  end
end
function PaGlobal_MusicShare_All:validate()
  if nil == Panel_Window_MusicShare_All then
    return
  end
end
function PaGlobal_MusicShare_All:resize()
  if nil == Panel_Window_MusicShare_All then
    return
  end
  self._ui._txt_titleBar:SetSize(self._panel_basicSize.x, self._ui._txt_titleBar:GetSizeY())
  Panel_Window_MusicShare_All:SetSize(self._panel_basicSize.x, self._panel_basicSize.y)
  self._ui._webControl:SetPosX(self._web_basicPos.x)
  self._ui._webControl:SetPosY(self._web_basicPos.y)
  self._ui._webControl:SetSize(self._web_basicSize.x, self._web_basicSize.y)
  Panel_Window_MusicShare_All:SetPosX(getScreenSizeX() * 0.5 - Panel_Window_MusicShare_All:GetSizeX() * 0.5)
  Panel_Window_MusicShare_All:SetPosY(getScreenSizeY() * 0.5 - Panel_Window_MusicShare_All:GetSizeY() * 0.5)
  self._ui._btn_close:ComputePos()
end
function PaGlobal_MusicShare_All:getURL()
  if nil == getSelfPlayer() then
    return
  end
  local musicIndex = self._musicIndex
  local musicInfo = ToClient_GetMusicInfoByIndex(musicIndex)
  if nil == musicInfo then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local url = PaGlobal_URL_Check() .. "/CompositionNotes?"
  local title = musicInfo:getMusicName()
  local ownerName = musicInfo:getAuthorName()
  local playTime = musicInfo:getMaxPlayTime()
  local userNickName = getSelfPlayer():getUserNickname()
  local isGm = ToClient_SelfPlayerIsGM()
  local cryptKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  local userNo = getSelfPlayer():get():getUserNo()
  local rank = musicInfo:getRank()
  local instrument = ""
  local trackCount = musicInfo:getTrackSize()
  for ii = 0, trackCount - 1 do
    local trackTypeIndex = musicInfo:getTrackTypeByIndex(ii)
    if false == musicInfo:isEmpty(trackTypeIndex) then
      instrument = instrument .. tostring(trackTypeIndex) .. ","
    end
  end
  instrument = string.sub(instrument, 1, string.len(instrument) - 1)
  local url = url .. "isWrite=true" .. "&userNickName=" .. tostring(userNickName) .. "&gm=" .. tostring(isGm) .. "&certKey=" .. tostring(cryptKey) .. "&musicIndex=" .. tostring(musicIndex) .. "&musicOwn=" .. tostring(ownerName) .. "&musicTitle=" .. tostring(title) .. "&time=" .. tostring(playTime) .. "&userNo=" .. tostring(userNo) .. "&instrument=" .. tostring(instrument) .. "&rank=" .. tostring(rank)
  return url
end
