function PaGlobal_Composition_All:initialize()
  if true == PaGlobal_Composition_All._initialize then
    return
  end
  Panel_Window_Composition_All:SetShow(false)
  Panel_Window_Composition_All:setGlassBackground(true)
  Panel_Window_Composition_All:ActiveMouseEventEffect(false)
  self._ui._txt_titleBar = UI.getChildControl(Panel_Window_Composition_All, "StaticText_Title")
  self._ui._btn_close = UI.getChildControl(self._ui._txt_titleBar, "Button_Close")
  self._ui._btn_refresh = UI.getChildControl(self._ui._txt_titleBar, "Button_Refresh")
  self._ui._webControl = UI.createControl(__ePAUIControl_WebControl, Panel_Window_Composition_All, "WebControl_Composition_WebLink")
  self._ui._webControl:SetShow(true)
  self._ui._webControl:SetPosX(self._web_basicPos.x)
  self._ui._webControl:SetPosY(self._web_basicPos.y)
  self._ui._webControl:SetSize(self._web_basicSize.x, self._web_basicSize.y)
  self._ui._webControl:ResetUrl()
  self._ui._btn_refresh:SetShow(_ContentsGroup_ResetCoherent)
  PaGlobal_Composition_All:registEventHandler()
  PaGlobal_Composition_All:validate()
  PaGlobal_Composition_All._initialize = true
end
function PaGlobal_Composition_All:registEventHandler()
  if nil == Panel_Window_Composition_All then
    return
  end
  registerEvent("FromClient_OpenMusicListLocalRepository", "FromClient_OpenMusicListLocalRepository")
  registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForComposition")
  Panel_Window_Composition_All:RegisterShowEventFunc(true, "PaGlobal_Composition_All_ShowAni()")
  Panel_Window_Composition_All:RegisterShowEventFunc(false, "PaGlobal_Composition_All_HideAni()")
  Panel_Window_Composition_All:RegisterUpdateFunc("PaGlobal_Composition_All_UpdatePerFrame")
  PaGlobal_Util_RegistWebResetControl(self._ui._btn_refresh)
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Composition_All_Close()")
end
function PaGlobal_Composition_All:prepareOpen(musicIndex)
  if nil == Panel_Window_Composition_All then
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
  local url = ""
  if nil ~= musicIndex then
    url = self:getURLForEdit(musicIndex)
  else
    url = self:getURL()
  end
  self._ui._webControl:SetUrl(self._web_basicSize.x, self._web_basicSize.y, url, false, true)
  self._ui._webControl:SetIME(true)
  PaGlobal_Composition_All:open()
end
function PaGlobal_Composition_All:open()
  if nil == Panel_Window_Composition_All then
    return
  end
  Panel_Window_Composition_All:SetShow(true)
end
function PaGlobal_Composition_All:prepareClose()
  if nil == Panel_Window_Composition_All then
    return
  end
  audioPostEvent_SystemUi(13, 5)
  _AudioPostEvent_SystemUiForXBOX(13, 5)
  ToClient_StopMusic(false)
  self._ui._webControl:ResetUrl()
  PaGlobal_Composition_All:close()
end
function PaGlobal_Composition_All:close()
  if nil == Panel_Window_Composition_All then
    return
  end
  Panel_Window_Composition_All:SetShow(false)
end
function PaGlobal_Composition_All:update()
  if nil == Panel_Window_Composition_All then
    return
  end
end
function PaGlobal_Composition_All:validate()
  if nil == Panel_Window_Composition_All then
    return
  end
end
function PaGlobal_Composition_All:resize()
  if nil == Panel_Window_Composition_All then
    return
  end
  self._ui._txt_titleBar:SetSize(self._panel_basicSize.x, self._ui._txt_titleBar:GetSizeY())
  Panel_Window_Composition_All:SetSize(self._panel_basicSize.x, self._panel_basicSize.y)
  self._ui._webControl:SetPosX(self._web_basicPos.x)
  self._ui._webControl:SetPosY(self._web_basicPos.y)
  self._ui._webControl:SetSize(self._web_basicSize.x, self._web_basicSize.y)
  Panel_Window_Composition_All:SetPosX(getScreenSizeX() * 0.5 - Panel_Window_Composition_All:GetSizeX() * 0.5)
  Panel_Window_Composition_All:SetPosY(getScreenSizeY() * 0.5 - Panel_Window_Composition_All:GetSizeY() * 0.5)
  self._ui._btn_close:ComputePos()
end
function PaGlobal_Composition_All:getURL()
  if nil == getSelfPlayer() then
    return
  end
  local url = "coui://UI_DATA/UI_Html/Window/MusicComposition/Index.html"
  return url
end
function PaGlobal_Composition_All:getURLForEdit(musicIndex)
  if nil == getSelfPlayer() then
    return
  end
  local url = "coui://UI_DATA/UI_Html/Window/MusicComposition/Index.html"
  url = url .. "?musicIndex=" .. tostring(musicIndex)
  return url
end
