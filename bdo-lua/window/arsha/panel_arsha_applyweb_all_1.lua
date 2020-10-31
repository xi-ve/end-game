function PaGlobal_ArshaApplyWeb_All:initialize()
  if true == PaGlobal_ArshaApplyWeb_All._initialize then
    return
  end
  Panel_Arsha_ApplyWeb_All:SetShow(false)
  Panel_Arsha_ApplyWeb_All:setGlassBackground(true)
  Panel_Arsha_ApplyWeb_All:ActiveMouseEventEffect(false)
  self._ui._txt_titleBar = UI.getChildControl(Panel_Arsha_ApplyWeb_All, "StaticText_Title")
  self._ui._btn_close = UI.getChildControl(self._ui._txt_titleBar, "Button_Close")
  self._ui._btn_Refresh = UI.getChildControl(self._ui._txt_titleBar, "Button_Refresh")
  self._ui._webControl = UI.createControl(__ePAUIControl_WebControl, Panel_Arsha_ApplyWeb_All, "WebControl_ArshaApplyWeb_WebLink")
  self._ui._webControl:SetShow(true)
  self._ui._webControl:SetSize(self._web_basicSize.x, self._web_basicSize.y)
  self._ui._webControl:SetHorizonCenter()
  self._ui._webControl:SetVerticalBottom()
  self._ui._webControl:ResetUrl()
  self._ui._webControl:SetSpanSize(0, 10)
  self._ui._webControl:ComputePos()
  self._ui._btn_Refresh:SetShow(_ContentsGroup_ResetCoherent)
  PaGlobal_ArshaApplyWeb_All:registEventHandler()
  PaGlobal_ArshaApplyWeb_All:validate()
  PaGlobal_ArshaApplyWeb_All._initialize = true
end
function PaGlobal_ArshaApplyWeb_All:registEventHandler()
  if nil == Panel_Arsha_ApplyWeb_All then
    return
  end
  registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForArshaWeb")
  Panel_Arsha_ApplyWeb_All:RegisterShowEventFunc(true, "PaGlobal_ArshaApplyWeb_All_ShowAni()")
  Panel_Arsha_ApplyWeb_All:RegisterShowEventFunc(false, "PaGlobal_ArshaApplyWeb_All_HideAni()")
  PaGlobal_Util_RegistWebResetControl(self._ui._btn_Refresh)
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ArshaApplyWeb_All_Close()")
end
function PaGlobal_ArshaApplyWeb_All:prepareOpen()
  if nil == Panel_Arsha_ApplyWeb_All then
    return
  end
  audioPostEvent_SystemUi(13, 6)
  _AudioPostEvent_SystemUiForXBOX(13, 6)
  self:resize()
  self._ui._webControl:SetUrl(self._web_basicSize.x, self._web_basicSize.y, self:getURL(), false, true)
  self._ui._webControl:SetIME(true)
  PaGlobal_ArshaApplyWeb_All:open()
end
function PaGlobal_ArshaApplyWeb_All:open()
  if nil == Panel_Arsha_ApplyWeb_All then
    return
  end
  Panel_Arsha_ApplyWeb_All:SetShow(true)
end
function PaGlobal_ArshaApplyWeb_All:prepareClose()
  if nil == Panel_Arsha_ApplyWeb_All then
    return
  end
  audioPostEvent_SystemUi(13, 5)
  _AudioPostEvent_SystemUiForXBOX(13, 5)
  self._ui._webControl:ResetUrl()
  PaGlobal_ArshaApplyWeb_All:close()
end
function PaGlobal_ArshaApplyWeb_All:close()
  if nil == Panel_Arsha_ApplyWeb_All then
    return
  end
  Panel_Arsha_ApplyWeb_All:SetShow(false)
end
function PaGlobal_ArshaApplyWeb_All:update()
  if nil == Panel_Arsha_ApplyWeb_All then
    return
  end
end
function PaGlobal_ArshaApplyWeb_All:validate()
  if nil == Panel_Arsha_ApplyWeb_All then
    return
  end
end
function PaGlobal_ArshaApplyWeb_All:resize()
  if nil == Panel_Arsha_ApplyWeb_All then
    return
  end
  Panel_Arsha_ApplyWeb_All:SetPosX(getScreenSizeX() * 0.5 - Panel_Arsha_ApplyWeb_All:GetSizeX() * 0.5)
  Panel_Arsha_ApplyWeb_All:SetPosY(getScreenSizeY() * 0.5 - Panel_Arsha_ApplyWeb_All:GetSizeY() * 0.5)
end
function PaGlobal_ArshaApplyWeb_All:getURL()
  if nil == getSelfPlayer() then
    return
  end
  local url = ToClient_getIngameWikiURL()
  if isGameTypeEnglish() then
    if CppEnums.CountryType.NA_ALPHA == getGameServiceType() then
      url = PaGlobal_URL_Check()
    elseif CppEnums.CountryType.NA_REAL == getGameServiceType() then
      url = PaGlobal_URL_Check()
    end
  elseif CppEnums.CountryType.SA_ALPHA == getGameServiceType() then
    url = PaGlobal_URL_Check()
  elseif CppEnums.CountryType.SA_REAL == getGameServiceType() then
    url = PaGlobal_URL_Check()
  end
  local cryptKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  local userNo = getSelfPlayer():get():getUserNo()
  local languageType = ToClient_getResourceType()
  if 0 == languageType then
    languageType = 1
  end
  url = url .. "/event/battleNew?userNo=" .. tostring(userNo) .. "&certKey=" .. tostring(cryptKey) .. "&langType=" .. tostring(languageType)
  return url
end
