Panel_Window_Copyright:SetOffsetIgnorePanel(true)
function PaGlobal_Copyright:initialize()
  if true == PaGlobal_Copyright._initialize then
    return
  end
  PaGlobal_Copyright._ui._web_copyright = UI.createControl(__ePAUIControl_WebControl, Panel_Window_Copyright, "WebControl_Copyright_WebLink")
  PaGlobal_Copyright._ui._web_copyright:SetShow(false)
  PaGlobal_Copyright._ui._web_copyright:SetVerticalMiddle()
  PaGlobal_Copyright._ui._web_copyright:SetHorizonCenter()
  PaGlobal_Copyright._ui._web_copyright:ResetUrl()
  PaGlobal_Copyright:registEventHandler()
  PaGlobal_Copyright._initialize = true
end
function PaGlobal_Copyright:registEventHandler()
  if nil == Panel_Window_Copyright then
    return
  end
  Panel_Window_Copyright:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleEvent_Copyright_WebBannerInput(\"RS_UP\")")
  Panel_Window_Copyright:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleEvent_Copyright_WebBannerInput(\"RS_DOWN\")")
  Panel_Window_Copyright:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Copyright_close()")
end
function PaGlobal_Copyright:prepareOpen(isType)
  if nil == Panel_Window_Copyright then
    return
  end
  if false == PaGlobal_Copyright._initialize then
    PaGlobal_Copyright:initialize()
  end
  local isMainUrl = ToClient_getInGameWebUrl()
  local isFileNameAndType = ToClient_getEULAFileName(isType)
  if 0 == isType then
    if true == ToClient_isPS4() then
      isUrl = "coui://UI_Data/UI_Html/copyright_PS.html"
    elseif true == ToClient_isXBox() then
      isUrl = "coui://UI_Data/UI_Html/copyright_XB.html"
    else
      isUrl = "coui://UI_Data/UI_Html/copyright.html"
    end
  elseif 1 == isType then
    isUrl = isFileNameAndType
  end
  PaGlobal_Copyright:onScreenResize()
  PaGlobal_Copyright._ui._web_copyright:SetShow(true)
  PaGlobal_Copyright._ui._web_copyright:SetUrl(PaGlobal_Copyright._screenSizeX, PaGlobal_Copyright._screenSizeY, isUrl, false, true)
end
function PaGlobal_Copyright:open(isType)
  if nil == Panel_Window_Copyright then
    return
  end
  PaGlobal_Copyright:prepareOpen(isType)
  Panel_Window_Copyright:SetShow(true)
end
function PaGlobal_Copyright_Open(isLogin, isReaccept)
  PaGlobal_Copyright:open(1)
  PaGlobal_Copyright._isLogin = isLogin
  PaGlobal_Copyright._isReaccept = isReaccept
end
function PaGlobal_Copyright:prepareClose()
  if nil == Panel_Window_Copyright then
    return
  end
  PaGlobal_Copyright._ui._web_copyright:ResetUrl()
  _AudioPostEvent_SystemUiForXBOX(1, 21)
  if true == PaGlobal_Copyright._isLogin then
    PaGlobal_PrivacyPolicy_Open(0, true)
  elseif true == PaGlobal_Copyright._isReaccept then
    PaGlobal_PrivacyPolicy_Open(0, false, true)
  end
end
function PaGlobal_Copyright:close()
  if nil == Panel_Window_Copyright then
    return
  end
  if false == PaGlobal_Copyright._isLogin then
    PaGlobal_Copyright:prepareClose()
    Panel_Window_Copyright:SetShow(false)
  else
    Panel_Window_Copyright:SetShow(false)
    if true == PaGlobal_Copyright._isLogin then
      PaGlobal_PrivacyPolicy_Open(0, true)
    end
  end
end
function PaGlobal_Copyright_close()
  PaGlobal_Copyright:close()
end
function PaGlobal_Copyright_ForceClose()
  PaGlobal_Copyright._ui._web_copyright:ResetUrl()
  _AudioPostEvent_SystemUiForXBOX(1, 21)
  Panel_Window_Copyright:SetShow(false)
  GlobalExitGameClient()
end
function PaGlobal_Copyright:update()
  if nil == Panel_Window_Copyright then
    return
  end
end
function PaGlobal_Copyright:validate()
  if nil == Panel_Window_Copyright then
    return
  end
  PaGlobal_Copyright._ui._web_copyright:isValidate()
end
function PaGlobal_Copyright:onScreenResize()
  if nil == Panel_Window_Copyright then
    return
  end
  if false == PaGlobal_Copyright._initialize then
    return
  end
  PaGlobal_Copyright._screenSizeX = getOriginScreenSizeX()
  PaGlobal_Copyright._screenSizeY = getOriginScreenSizeY()
  Panel_Window_Copyright:SetSize(PaGlobal_Copyright._screenSizeX, PaGlobal_Copyright._screenSizeY)
  Panel_Window_Copyright:SetPosX(0)
  Panel_Window_Copyright:SetPosY(0)
  PaGlobal_Copyright._ui._web_copyright:SetSize(PaGlobal_Copyright._screenSizeX, PaGlobal_Copyright._screenSizeY)
  PaGlobal_Copyright._ui._web_copyright:ComputePos()
end
function PaGlobal_Copyright:webBannerInput(key)
  if nil == Panel_Window_Copyright then
    return
  end
  PaGlobal_Copyright._ui._web_copyright:TriggerEvent("FromClient_GamePadInputForWebBanner", key)
end
