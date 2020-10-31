function PaGlobal_EventNotifyContent_All:initialize()
  if true == PaGlobal_EventNotifyContent_All._initialize then
    return
  end
  Panel_EventNotifyContent_All:SetShow(false)
  Panel_EventNotifyContent_All:setGlassBackground(true)
  Panel_EventNotifyContent_All:ActiveMouseEventEffect(false)
  local stc_titleArea = UI.getChildControl(Panel_EventNotifyContent_All, "Static_TitleArea")
  self._ui._btn_close = UI.getChildControl(stc_titleArea, "Button_Close")
  self._ui._btn_Sticker = UI.getChildControl(stc_titleArea, "CheckButton_PopUp")
  self._ui._stc_keyGuideBG = UI.getChildControl(Panel_EventNotifyContent_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_keyGuideB = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Close")
  self._ui._btn_Sticker:SetShow(_ContentsGroup_PopUp)
  self._ui._webControl = UI.createControl(__ePAUIControl_WebControl, Panel_EventNotifyContent_All, "WebControl_EventNotifyContent_WebLink")
  self._ui._webControl:SetShow(true)
  self._ui._webControl:SetSize(self._webSize.x, self._webSize.y)
  self._ui._webControl:SetHorizonCenter()
  self._ui._webControl:SetVerticalTop()
  self._ui._webControl:SetSpanSize(0, 60)
  self._ui._webControl:ComputePos()
  self._ui._webControl:ResetUrl()
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._btn_close:SetShow(false)
    local keyGuide = {
      self._ui._stc_keyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  PaGlobal_EventNotifyContent_All:registEventHandler()
  PaGlobal_EventNotifyContent_All:validate()
  PaGlobal_EventNotifyContent_All._initialize = true
end
function PaGlobal_EventNotifyContent_All:registEventHandler()
  if nil == Panel_EventNotifyContent_All then
    return
  end
  Panel_EventNotifyContent_All:RegisterShowEventFunc(true, "PaGloabl_EventNotifyContent_All_ShowAni()")
  Panel_EventNotifyContent_All:RegisterShowEventFunc(false, "PaGloabl_EventNotifyContent_All_HideAni()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_EventNotifyContent_All_Close()")
  self._ui._btn_Sticker:addInputEvent("Mouse_LUp", "HandleEventLUp_EventNotifyContent_All_PopupUI()")
  self._ui._btn_Sticker:addInputEvent("Mouse_On", "HandleEventOnOut_EventNotifyContent_All_PopupUITooltip(true)")
  self._ui._btn_Sticker:addInputEvent("Mouse_Out", "HandleEventOnOut_EventNotifyContent_All_PopupUITooltip(false)")
  registerEvent("FromWeb_ExecuteLuaFuncByEvent", "FromClient_EventNotifyContent_All_ExecuteLuaFuncByEvent")
end
function PaGlobal_EventNotifyContent_All:prepareOpen()
  if nil == Panel_EventNotifyContent_All then
    return
  end
  audioPostEvent_SystemUi(13, 6)
  _AudioPostEvent_SystemUiForXBOX(13, 6)
  self:resize()
  PaGlobal_EventNotifyContent_All:open()
end
function PaGlobal_EventNotifyContent_All:open()
  if nil == Panel_EventNotifyContent_All then
    return
  end
  Panel_EventNotifyContent_All:SetShow(true)
end
function PaGlobal_EventNotifyContent_All:prepareClose()
  if nil == Panel_EventNotifyContent_All then
    return
  end
  self._ui._webControl:ResetUrl()
  audioPostEvent_SystemUi(13, 5)
  _AudioPostEvent_SystemUiForXBOX(13, 5)
  if true == Panel_EventNotifyContent_All:IsUISubApp() then
    Panel_EventNotifyContent_All:CloseUISubApp()
    PaGlobal_EventNotifyContent_All._ui._btn_Sticker:SetCheck(false)
  end
  PaGlobal_EventNotifyContent_All:close()
end
function PaGlobal_EventNotifyContent_All:close()
  if nil == Panel_EventNotifyContent_All then
    return
  end
  Panel_EventNotifyContent_All:SetShow(false)
end
function PaGlobal_EventNotifyContent_All:update()
  if nil == Panel_EventNotifyContent_All then
    return
  end
end
function PaGlobal_EventNotifyContent_All:validate()
  if nil == Panel_EventNotifyContent_All then
    return
  end
  self._ui._btn_close:isValidate()
  self._ui._btn_Sticker:isValidate()
  self._ui._stc_keyGuideBG:isValidate()
  self._ui._stc_keyGuideB:isValidate()
end
function PaGlobal_EventNotifyContent_All:getURL(eventIndex)
  if nil == getSelfPlayer() then
    return
  end
  local url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL", "index", eventIndex)
  if isGameTypeKorea() then
    if CppEnums.CountryType.KOR_ALPHA == getGameServiceType() then
      url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_DEV_URL", "index", eventIndex)
    elseif CppEnums.CountryType.KOR_REAL == getGameServiceType() then
      url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL", "index", eventIndex)
    end
  elseif isGameTypeTaiwan() then
    if CppEnums.CountryType.TW_ALPHA == getGameServiceType() then
      url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL_TW_ALPHA", "index", eventIndex)
    elseif CppEnums.CountryType.TW_REAL == getGameServiceType() then
      url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL_TW", "index", eventIndex)
    end
  elseif isGameTypeSA() then
    if CppEnums.CountryType.SA_ALPHA == getGameServiceType() then
      url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL_SA_ALPHA", "index", eventIndex)
    elseif CppEnums.CountryType.SA_REAL == getGameServiceType() then
      url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL_SA", "index", eventIndex)
    end
  elseif isGameTypeTR() then
    if CppEnums.CountryType.TR_ALPHA == getGameServiceType() then
      url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL_TR_ALPHA", "index", eventIndex)
    elseif CppEnums.CountryType.TR_REAL == getGameServiceType() then
      url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL_TR", "index", eventIndex)
    end
  elseif isGameTypeTH() then
    if CppEnums.CountryType.TH_ALPHA == getGameServiceType() then
      url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL_TH_ALPHA", "index", eventIndex)
    elseif CppEnums.CountryType.TH_REAL == getGameServiceType() then
      url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL_TH", "index", eventIndex)
    end
  elseif isGameTypeID() then
    if CppEnums.CountryType.ID_ALPHA == getGameServiceType() then
      url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL_ID_ALPHA", "index", eventIndex)
    elseif CppEnums.CountryType.ID_REAL == getGameServiceType() then
      url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL_ID", "index", eventIndex)
    end
  elseif CppEnums.CountryType.RUS_ALPHA == getGameServiceType() then
    url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL_RUS_ALPHA", "index", eventIndex)
  elseif CppEnums.CountryType.RUS_REAL == getGameServiceType() then
    url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL_RUS", "index", eventIndex)
  elseif CppEnums.CountryType.JPN_ALPHA == getGameServiceType() then
    url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL_JP_ALPHA", "index", eventIndex)
  elseif CppEnums.CountryType.JPN_REAL == getGameServiceType() then
    url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL_JP", "index", eventIndex)
  else
    url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_URL", "index", eventIndex)
  end
  local cryptKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  local userNo = getSelfPlayer():get():getUserNo()
  url = url .. "&certKey=" .. tostring(cryptKey) .. "&userNo=" .. tostring(userNo)
  return url
end
function PaGlobal_EventNotifyContent_All:setWebURL(url, isType)
  self._ui._webControl:SetUrl(self._webSize.x, self._webSize.y, url, false, isType)
end
function PaGlobal_EventNotifyContent_All:resize()
  if nil == Panel_EventNotifyContent_All then
    return
  end
  Panel_EventNotifyContent_All:SetPosX(getScreenSizeX() * 0.5 - Panel_EventNotifyContent_All:GetSizeX() * 0.5)
  Panel_EventNotifyContent_All:SetPosY(getScreenSizeY() * 0.5 - Panel_EventNotifyContent_All:GetSizeY() * 0.5)
end
