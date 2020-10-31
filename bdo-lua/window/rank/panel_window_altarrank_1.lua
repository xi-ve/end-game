function PaGlobal_AltarRankWeb:initialize()
  if true == PaGlobal_AltarRankWeb._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_AltarRankWeb._ui.stc_titleBG = UI.getChildControl(Panel_AltarRank_Web, "Static_TitleBG")
  PaGlobal_AltarRankWeb._ui.btn_Close = UI.getChildControl(PaGlobal_AltarRankWeb._ui.stc_titleBG, "Button_Win_Close")
  PaGlobal_AltarRankWeb._ui.btn_Refresh = UI.getChildControl(PaGlobal_AltarRankWeb._ui.stc_titleBG, "Button_Refresh")
  if self._isConsole then
    local albumSizeX = Panel_CustomizingAlbum:GetSizeX()
    local albumSizeY = Panel_CustomizingAlbum:GetSizeY()
    Panel_AltarRank_Web:SetSize(albumSizeX, albumSizeY)
    PaGlobal_AltarRankWeb._ui.stc_titleBG:SetSize(albumSizeX - 8, PaGlobal_AltarRankWeb._ui.stc_titleBG:GetSizeY())
    PaGlobal_AltarRankWeb._config._WEBSIZEX = albumSizeX - 30
    PaGlobal_AltarRankWeb._config._WEBSIZEY = albumSizeY - 30 - PaGlobal_AltarRankWeb._ui.stc_titleBG:GetSizeY()
  end
  PaGlobal_AltarRankWeb._webControl = UI.createControl(__ePAUIControl_WebControl, Panel_AltarRank_Web, "WebControl_AltarRank_WebLink")
  PaGlobal_AltarRankWeb._webControl:SetShow(true)
  PaGlobal_AltarRankWeb._webControl:SetSize(PaGlobal_AltarRankWeb._config._WEBSIZEX, PaGlobal_AltarRankWeb._config._WEBSIZEY)
  PaGlobal_AltarRankWeb._webControl:SetHorizonCenter()
  PaGlobal_AltarRankWeb._webControl:SetVerticalTop()
  PaGlobal_AltarRankWeb._webControl:SetSpanSize(0, 60)
  PaGlobal_AltarRankWeb._webControl:ComputePos()
  PaGlobal_AltarRankWeb._webControl:ResetUrl()
  Panel_AltarRank_Web:SetShow(false)
  Panel_AltarRank_Web:setGlassBackground(true)
  Panel_AltarRank_Web:ActiveMouseEventEffect(true)
  self._ui.btn_Close:SetShow(not self._isConsole)
  self._ui.btn_Refresh:SetShow(not self._isConsole and _ContentsGroup_ResetCoherent)
  PaGlobal_AltarRankWeb:registEventHandler()
  PaGlobal_AltarRankWeb:validate()
  PaGlobal_AltarRankWeb._initialize = true
end
function PaGlobal_AltarRankWeb:registEventHandler()
  if nil == Panel_AltarRank_Web then
    return
  end
  PaGlobal_AltarRankWeb._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_AltarRankWeb_Close()")
  Panel_AltarRank_Web:RegisterShowEventFunc(true, "PaGlobal_AltarRankWeb_ShowAni()")
  Panel_AltarRank_Web:RegisterShowEventFunc(false, "PaGlobal_AltarRankWeb_HideAni()")
  PaGlobal_Util_RegistWebResetControl(PaGlobal_AltarRankWeb._ui.btn_Refresh)
  if self._isConsole then
    Panel_AltarRank_Web:registerPadEvent(__eConsoleUIPadEvent_LB, "Input_AltarRankWeb_ToWebBanner(\"LB\")")
    Panel_AltarRank_Web:registerPadEvent(__eConsoleUIPadEvent_RB, "Input_AltarRankWeb_ToWebBanner(\"RB\")")
    Panel_AltarRank_Web:registerPadEvent(__eConsoleUIPadEvent_A, "Input_AltarRankWeb_ToWebBanner(\"A\")")
    Panel_AltarRank_Web:registerPadEvent(__eConsoleUIPadEvent_Y, "Input_AltarRankWeb_ToWebBanner(\"Y\")")
    Panel_AltarRank_Web:registerPadEvent(__eConsoleUIPadEvent_X, "Input_AltarRankWeb_ToWebBanner(\"X\")")
    Panel_AltarRank_Web:registerPadEvent(__eConsoleUIPadEvent_LT, "Input_AltarRankWeb_ToWebBanner(\"LT\")")
    Panel_AltarRank_Web:registerPadEvent(__eConsoleUIPadEvent_RT, "Input_AltarRankWeb_ToWebBanner(\"RT\")")
    Panel_AltarRank_Web:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "Input_AltarRankWeb_ToWebBanner(\"D_LEFT\")")
    Panel_AltarRank_Web:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "Input_AltarRankWeb_ToWebBanner(\"D_RIGHT\")")
    Panel_AltarRank_Web:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "Input_AltarRankWeb_ToWebBanner(\"D_UP\")")
    Panel_AltarRank_Web:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "Input_AltarRankWeb_ToWebBanner(\"D_DOWN\")")
    Panel_AltarRank_Web:registerPadEvent(__eConsoleUIPadEvent_LSClick, "Input_AltarRankWeb_ToWebBanner(\"LS_CLICK\")")
    Panel_AltarRank_Web:registerPadEvent(__eConsoleUIPadEvent_RSClick, "Input_AltarRankWeb_ToWebBanner(\"RS_CLICK\")")
    Panel_AltarRank_Web:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "Input_AltarRankWeb_ToWebBanner(\"RS_UP\")")
    Panel_AltarRank_Web:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "Input_AltarRankWeb_ToWebBanner(\"RS_DOWN\")")
  else
    registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForAltarRank")
  end
end
function PaGlobal_AltarRankWeb:prepareOpen()
  if nil == Panel_AltarRank_Web then
    return
  end
  PaGlobal_AltarRankWeb:update()
  audioPostEvent_SystemUi(13, 6)
  _AudioPostEvent_SystemUiForXBOX(13, 6)
end
function PaGlobal_AltarRankWeb:open()
  if nil == Panel_AltarRank_Web then
    return
  end
  Panel_AltarRank_Web:SetShow(true, true)
end
function PaGlobal_AltarRankWeb:prepareClose()
  if nil == Panel_AltarRank_Web then
    return
  end
  FGlobal_ClearCandidate()
  PaGlobal_AltarRankWeb._webControl:ResetUrl()
  ClearFocusEdit()
  audioPostEvent_SystemUi(13, 5)
  _AudioPostEvent_SystemUiForXBOX(13, 5)
end
function PaGlobal_AltarRankWeb:close()
  if nil == Panel_AltarRank_Web then
    return
  end
  Panel_AltarRank_Web:SetShow(false, true)
end
function PaGlobal_AltarRankWeb:showAni()
  if nil == Panel_AltarRank_Web then
    return
  end
  UIAni.fadeInSCR_Down(Panel_AltarRank_Web)
  local aniInfo1 = Panel_AltarRank_Web:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_AltarRank_Web:GetSizeX() / 2
  aniInfo1.AxisY = Panel_AltarRank_Web:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_AltarRank_Web:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_AltarRank_Web:GetSizeX() / 2
  aniInfo2.AxisY = Panel_AltarRank_Web:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobal_AltarRankWeb:hideAni()
  if nil == Panel_AltarRank_Web then
    return
  end
  Panel_AltarRank_Web:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_AltarRank_Web, 0, 0.2)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_AltarRankWeb:update()
  if nil == Panel_AltarRank_Web then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local userNo = selfPlayer:get():getUserNo()
  local certKey = selfPlayer:get():getWebAuthenticKeyCryptString()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local url = PaGlobal_URL_Check(worldNo)
  if nil == url then
    return
  end
  url = url .. "/AltarOfBlood?stage=1&certKey=" .. tostring(certKey)
  FGlobal_SetCandidate()
  PaGlobal_AltarRankWeb._webControl:SetSize(PaGlobal_AltarRankWeb._config._WEBSIZEX, PaGlobal_AltarRankWeb._config._WEBSIZEY)
  PaGlobal_AltarRankWeb._webControl:SetUrl(PaGlobal_AltarRankWeb._config._WEBSIZEX, PaGlobal_AltarRankWeb._config._WEBSIZEY, url, false, true)
  PaGlobal_AltarRankWeb._webControl:SetIME(true)
  Panel_AltarRank_Web:SetPosX(getOriginScreenSizeX() / 2 - Panel_AltarRank_Web:GetSizeX() / 2)
  Panel_AltarRank_Web:SetPosY(getOriginScreenSizeY() / 2 - Panel_AltarRank_Web:GetSizeY() / 2)
end
function PaGlobal_AltarRankWeb:validate()
  if nil == Panel_AltarRank_Web then
    return
  end
end
