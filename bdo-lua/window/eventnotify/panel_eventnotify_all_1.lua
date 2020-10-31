function PaGlobal_EventNotify_All:initialize()
  if true == PaGlobal_EventNotify_All._initialize then
    return
  end
  Panel_EventNotify_All:SetShow(false)
  Panel_EventNotify_All:setGlassBackground(true)
  Panel_EventNotify_All:ActiveMouseEventEffect(false)
  self._ui._txt_titleBar = UI.getChildControl(Panel_EventNotify_All, "StaticText_Title")
  self._ui._btn_close = UI.getChildControl(self._ui._txt_titleBar, "Button_Close")
  self._ui._btn_refresh = UI.getChildControl(self._ui._txt_titleBar, "Button_Refresh")
  self._ui._stc_keyGuideBG = UI.getChildControl(Panel_EventNotify_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_keyGuideB = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Close")
  self._ui._webControl = UI.createControl(__ePAUIControl_WebControl, Panel_EventNotify_All, "WebControl_EventNotify_WebLink")
  self._ui._webControl:SetShow(true)
  self._ui._webControl:SetSize(self._web_basicSize.x, self._web_basicSize.y)
  self._ui._webControl:SetHorizonCenter()
  self._ui._webControl:SetVerticalTop()
  self._ui._webControl:SetSpanSize(0, 60)
  self._ui._webControl:ComputePos()
  self._ui._webControl:ResetUrl()
  self._ui._btn_refresh:SetShow(_ContentsGroup_ResetCoherent)
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._btn_close:SetShow(false)
    local keyGuide = {
      self._ui._stc_keyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  PaGlobal_EventNotify_All:registEventHandler()
  PaGlobal_EventNotify_All:validate()
  PaGlobal_EventNotify_All._initialize = true
end
function PaGlobal_EventNotify_All:registEventHandler()
  if nil == Panel_EventNotify_All then
    return
  end
  registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForEventNotify")
  Panel_EventNotify_All:RegisterShowEventFunc(true, "PaGloabl_EventNotify_All_ShowAni()")
  Panel_EventNotify_All:RegisterShowEventFunc(false, "PaGloabl_EventNotify_All_HideAni()")
  PaGlobal_Util_RegistWebResetControl(self._ui._btn_refresh)
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGloabl_EventNotify_All_Close()")
end
function PaGlobal_EventNotify_All:prepareOpen(isDo, isMenu)
  if nil == Panel_EventNotify_All then
    return
  end
  if not ToClient_IsPopUpToggle() then
    return
  end
  if isGameTypeKR2() then
    return
  end
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper:isEventBeforeShow() and nil == isDo then
    PaGlobal_MainQuestWidget_TopQuestGuide_Open()
    return
  end
  if not TutorialQuestCompleteCheck() and not isMenu then
    return
  end
  audioPostEvent_SystemUi(13, 6)
  _AudioPostEvent_SystemUiForXBOX(13, 6)
  self:resize()
  if true == isGameTypeEnglish() then
    self._ui._webControl:SetUrl(self._web_englishSize.x, self._web_englishSize.y, self:getURL(), false, true)
  else
    self._ui._webControl:SetUrl(self._web_basicSize.x, self._web_basicSize.y, self:getURL(), false, true)
  end
  PaGlobal_EventNotify_All:open()
end
function PaGlobal_EventNotify_All:open()
  if nil == Panel_EventNotify_All then
    return
  end
  Panel_EventNotify_All:SetShow(true)
end
function PaGlobal_EventNotify_All:prepareClose()
  if nil == Panel_EventNotify_All then
    return
  end
  audioPostEvent_SystemUi(13, 5)
  _AudioPostEvent_SystemUiForXBOX(13, 5)
  FGlobal_LevelupGuide_Open()
  local tempWrapper = getTemporaryInformationWrapper()
  if not tempWrapper:isEventBeforeShow() then
    if false == _ContentsGroup_RenewUI then
      PaGlobal_MainQuestWidget_TopQuestGuide_Open()
    end
    tempWrapper:setEventBeforeShow(true)
  end
  PaGlobal_EventNotify_All:close()
end
function PaGlobal_EventNotify_All:close()
  if nil == Panel_EventNotify_All then
    return
  end
  Panel_EventNotify_All:SetShow(false)
end
function PaGlobal_EventNotify_All:update()
  if nil == Panel_EventNotify_All then
    return
  end
end
function PaGlobal_EventNotify_All:validate()
  if nil == Panel_EventNotify_All then
    return
  end
  self._ui._txt_titleBar:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._btn_refresh:isValidate()
  self._ui._stc_keyGuideBG:isValidate()
  self._ui._stc_keyGuideB:isValidate()
end
function PaGlobal_EventNotify_All:resize()
  if nil == Panel_EventNotify_All then
    return
  end
  if true == isGameTypeEnglish() then
    self._ui._txt_titleBar:SetSize(self._panel_englishSize.x, self._ui._txt_titleBar:GetSizeY())
    Panel_EventNotify_All:SetSize(self._panel_englishSize.x, self._panel_englishSize.y)
    self._ui._webControl:SetSize(self._web_englishSize.x, self._web_englishSize.y)
    self._ui._webControl:ComputePos()
  else
    self._ui._txt_titleBar:SetSize(self._panel_basicSize.x, self._ui._txt_titleBar:GetSizeY())
    Panel_EventNotify_All:SetSize(self._panel_basicSize.x, self._panel_basicSize.y)
    self._ui._webControl:SetSize(self._web_basicSize.x, self._web_basicSize.y)
    self._ui._webControl:ComputePos()
  end
  Panel_EventNotify_All:SetPosX(getScreenSizeX() * 0.5 - Panel_EventNotify_All:GetSizeX() * 0.5)
  Panel_EventNotify_All:SetPosY(getScreenSizeY() * 0.5 - Panel_EventNotify_All:GetSizeY() * 0.5)
  self._ui._btn_close:ComputePos()
end
function PaGlobal_EventNotify_All:getURL()
  if nil == getSelfPlayer() then
    return
  end
  local url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL")
  if isGameTypeKorea() then
    if CppEnums.CountryType.KOR_ALPHA == getGameServiceType() then
      url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_DEV_URL")
    elseif CppEnums.CountryType.KOR_REAL == getGameServiceType() then
      url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL")
    end
  elseif isGameTypeTaiwan() then
    if CppEnums.CountryType.TW_ALPHA == getGameServiceType() then
      url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL_TW_ALPHA")
    elseif CppEnums.CountryType.TW_REAL == getGameServiceType() then
      url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL_TW")
    end
  elseif isGameTypeSA() then
    if CppEnums.CountryType.SA_ALPHA == getGameServiceType() then
      url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL_SA_ALPHA")
    elseif CppEnums.CountryType.SA_REAL == getGameServiceType() then
      url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL_SA")
    end
  elseif isGameTypeTR() then
    if CppEnums.CountryType.TR_ALPHA == getGameServiceType() then
      url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL_TR_ALPHA")
    elseif CppEnums.CountryType.TR_REAL == getGameServiceType() then
      url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL_TR")
    end
  elseif isGameTypeTH() then
    if CppEnums.CountryType.TH_ALPHA == getGameServiceType() then
      url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL_TH_ALPHA")
    elseif CppEnums.CountryType.TH_REAL == getGameServiceType() then
      url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL_TH")
    end
  elseif isGameTypeID() then
    if CppEnums.CountryType.ID_ALPHA == getGameServiceType() then
      url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL_ID_ALPHA")
    elseif CppEnums.CountryType.ID_REAL == getGameServiceType() then
      url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL_ID")
    end
  elseif CppEnums.CountryType.RUS_ALPHA == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL_RUS_ALPHA")
  elseif CppEnums.CountryType.RUS_REAL == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL_RUS")
  elseif CppEnums.CountryType.JPN_ALPHA == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL_JP_ALPHA")
  elseif CppEnums.CountryType.JPN_REAL == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL_JP")
  else
    url = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTNOTIFY_URL")
  end
  local cryptKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  local userNo = getSelfPlayer():get():getUserNo()
  url = url .. "?certKey=" .. tostring(cryptKey) .. "&userNo=" .. tostring(userNo)
  return url
end
