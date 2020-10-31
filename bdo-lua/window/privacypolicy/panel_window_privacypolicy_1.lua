Panel_Window_PrivacyPolicy:SetOffsetIgnorePanel(true)
function PaGlobal_PrivacyPolicy:initialize()
  if true == PaGlobal_PrivacyPolicy._initialize then
    return
  end
  PaGlobal_PrivacyPolicy._ui._web_privacyPolicy = UI.createControl(__ePAUIControl_WebControl, Panel_Window_PrivacyPolicy, "WebControl_Copyright_WebLink")
  PaGlobal_PrivacyPolicy._ui._web_privacyPolicy:SetShow(false)
  PaGlobal_PrivacyPolicy._ui._web_privacyPolicy:SetVerticalMiddle()
  PaGlobal_PrivacyPolicy._ui._web_privacyPolicy:SetHorizonCenter()
  PaGlobal_PrivacyPolicy._ui._web_privacyPolicy:ResetUrl()
  PaGlobal_PrivacyPolicy:registEventHandler()
  PaGlobal_PrivacyPolicy._initialize = true
end
function PaGlobal_PrivacyPolicy:registEventHandler()
  if nil == Panel_Window_PrivacyPolicy then
    return
  end
  Panel_Window_PrivacyPolicy:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleEvent_PrivacyPolicy_WebBannerInput(\"RS_UP\")")
  Panel_Window_PrivacyPolicy:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleEvent_PrivacyPolicy_WebBannerInput(\"RS_DOWN\")")
  Panel_Window_PrivacyPolicy:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_PrivacyPolicy_close()")
end
function PaGlobal_PrivacyPolicy:prepareOpen(isType)
  if nil == Panel_Window_PrivacyPolicy then
    return
  end
  if false == PaGlobal_PrivacyPolicy._initialize then
    PaGlobal_PrivacyPolicy:initialize()
  end
  PaGlobal_PrivacyPolicy._ui._web_privacyPolicy:ResetUrl()
  local isMainUrl = ToClient_getInGameWebUrl()
  local isFileNameAndType = ToClient_getEULAFileName(1)
  local isUrl = isFileNameAndType
  if 0 == isType then
    local url = ToClient_getEULAFileName(3)
    isUrl = url
  elseif 1 == isType then
    local url = ToClient_getEULAFileName(2)
    isUrl = url
  end
  PaGlobal_PrivacyPolicy:onScreenResize()
  PaGlobal_PrivacyPolicy._ui._web_privacyPolicy:SetShow(true)
  PaGlobal_PrivacyPolicy._ui._web_privacyPolicy:SetUrl(PaGlobal_PrivacyPolicy._screenSizeX, PaGlobal_PrivacyPolicy._screenSizeY, isUrl, false, true)
end
function PaGlobal_PrivacyPolicy:open(isType)
  if nil == Panel_Window_PrivacyPolicy then
    return
  end
  PaGlobal_PrivacyPolicy._isType = isType
  PaGlobal_PrivacyPolicy:prepareOpen(isType)
  Panel_Window_PrivacyPolicy:SetShow(true)
end
function PaGlobal_PrivacyPolicy_Open(isType, isLogin, isReaccept)
  PaGlobal_PrivacyPolicy:open(isType)
  PaGlobal_PrivacyPolicy._isLogin = isLogin
  PaGlobal_PrivacyPolicy._isReaccept = isReaccept
end
function PaGlobal_PrivacyPolicy:prepareClose()
  if nil == Panel_Window_PrivacyPolicy then
    return
  end
  PaGlobal_PrivacyPolicy._ui._web_privacyPolicy:ResetUrl()
  _AudioPostEvent_SystemUiForXBOX(1, 21)
  if true == isGameServiceTypeConsole() and true == PaGlobal_PrivacyPolicy._isLogin then
    if true == _ContentsGroup_NewUI_Login_All then
      PaGlobal_LoginNickname_All_Open()
    else
      PaGlobalFunc_LoginNickname_Open()
    end
  end
end
function PaGlobal_PrivacyPolicy:continueLoginProcess()
  PaGlobal_PrivacyPolicy._ui._web_privacyPolicy:ResetUrl()
  local myPlatformType = ToClient_getGamePlatformType()
  if __ePlatformType_PS == myPlatformType then
    ToClient_requestPSReacceptPolicy()
  else
    ToClient_requestXboxReacceptPolicy()
  end
  registerNickname()
end
function PaGlobal_PrivacyPolicy:close()
  if nil == Panel_Window_PrivacyPolicy then
    return
  end
  if true == PaGlobal_PrivacyPolicy._isReaccept then
    if 1 == PaGlobal_PrivacyPolicy._isType then
      PaGlobal_PrivacyPolicy:continueLoginProcess()
    else
      Panel_Window_PrivacyPolicy:SetShow(false)
      PaGlobal_PrivacyPolicy:open(1)
      return
    end
  elseif false == PaGlobal_PrivacyPolicy._isLogin then
    PaGlobal_PrivacyPolicy:prepareClose()
    Panel_Window_PrivacyPolicy:SetShow(false)
  else
    Panel_Window_PrivacyPolicy:SetShow(false)
    if true == isGameServiceTypeConsole() and true == PaGlobal_PrivacyPolicy._isLogin then
      if 1 == PaGlobal_PrivacyPolicy._isType then
        if true == _ContentsGroup_NewUI_Login_All then
          PaGlobal_LoginNickname_All_Open()
        else
          PaGlobalFunc_LoginNickname_Open()
        end
        local myPlatformType = ToClient_getGamePlatformType()
        if __ePlatformType_PS == myPlatformType then
          ToClient_requestPSReacceptPolicy()
        else
          ToClient_requestXboxReacceptPolicy()
        end
      else
        PaGlobal_PrivacyPolicy:open(1)
        return
      end
    end
  end
  PaGlobal_PrivacyPolicy._isType = -1
end
function PaGlobal_PrivacyPolicy_close()
  PaGlobal_PrivacyPolicy:close()
end
function PaGlobal_PrivacyPolicy_ForceClose()
  PaGlobal_PrivacyPolicy._isType = -1
  PaGlobal_PrivacyPolicy._ui._web_privacyPolicy:ResetUrl()
  _AudioPostEvent_SystemUiForXBOX(1, 21)
  Panel_Window_PrivacyPolicy:SetShow(false)
  GlobalExitGameClient()
end
function PaGlobal_PrivacyPolicy:update()
  if nil == Panel_Window_PrivacyPolicy then
    return
  end
end
function PaGlobal_PrivacyPolicy:validate()
  if nil == Panel_Window_PrivacyPolicy then
    return
  end
  PaGlobal_PrivacyPolicy._ui._web_privacyPolicy:isValidate()
end
function PaGlobal_PrivacyPolicy:onScreenResize()
  if nil == Panel_Window_PrivacyPolicy then
    return
  end
  if false == PaGlobal_PrivacyPolicy._initialize then
    return
  end
  PaGlobal_PrivacyPolicy._screenSizeX = getOriginScreenSizeX()
  PaGlobal_PrivacyPolicy._screenSizeY = getOriginScreenSizeY()
  Panel_Window_PrivacyPolicy:SetSize(PaGlobal_PrivacyPolicy._screenSizeX, PaGlobal_PrivacyPolicy._screenSizeY)
  Panel_Window_PrivacyPolicy:SetPosX(0)
  Panel_Window_PrivacyPolicy:SetPosY(0)
  PaGlobal_PrivacyPolicy._ui._web_privacyPolicy:SetSize(PaGlobal_PrivacyPolicy._screenSizeX, PaGlobal_PrivacyPolicy._screenSizeY)
  PaGlobal_PrivacyPolicy._ui._web_privacyPolicy:ComputePos()
end
function PaGlobal_PrivacyPolicy:webBannerInput(key)
  if nil == Panel_Window_PrivacyPolicy then
    return
  end
  PaGlobal_PrivacyPolicy._ui._web_privacyPolicy:TriggerEvent("FromClient_GamePadInputForWebBanner", key)
end
