function PaGlobal_CouponCode:initialize()
  if true == PaGlobal_CouponCode._initialize or nil == Panel_Window_CouponCode then
    return
  end
  self._ui.stc_Title = UI.getChildControl(Panel_Window_CouponCode, "StaticText_Title")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_Title, "StaticText_TitleIcon")
  self._ui.btn_Close = UI.getChildControl(Panel_Window_CouponCode, "Button_Close")
  self._ui.btn_Qusetion = UI.getChildControl(Panel_Window_CouponCode, "Button_Question")
  self._ui.btn_Refresh = UI.getChildControl(Panel_Window_CouponCode, "Button_Refresh")
  self._ui.stc_webControl = UI.createControl(__ePAUIControl_WebControl, Panel_Window_CouponCode, "WebControl_CouponCode")
  self._ui.stc_webControl:SetShow(true)
  self._ui.stc_webControl:SetHorizonCenter()
  self._ui.stc_webControl:SetSize(self._webSizeX, self._webSizeY)
  self._ui.stc_webControl:ComputePos()
  self._ui.stc_webControl:SetPosY(self._ui.stc_Title:GetSizeY() + 5)
  self._ui.stc_webControl:ResetUrl()
  PaGlobal_CouponCode:validate()
  PaGlobal_CouponCode:registEventHandler()
  self._ui.btn_Refresh:SetShow(_ContentsGroup_ResetCoherent)
  self._ui.btn_Close:SetShow(not _ContentsGroup_UsePadSnapping)
  PaGlobal_CouponCode._initialize = true
end
function PaGlobal_CouponCode:registEventHandler()
  Panel_Window_CouponCode:SetShow(false, false)
  Panel_Window_CouponCode:ActiveMouseEventEffect(true)
  Panel_Window_CouponCode:setGlassBackground(true)
  Panel_Window_CouponCode:RegisterShowEventFunc(true, "PaGlobalFunc_CouponCode_ShowAni()")
  Panel_Window_CouponCode:RegisterShowEventFunc(false, "PaGlobalFunc_CouponCode_HideAni()")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_CouponCode_Close()")
  PaGlobal_Util_RegistWebResetControl(self._ui.btn_Refresh)
  registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForCouponCode")
end
function PaGlobal_CouponCode:prepareOpen()
  if nil == Panel_Window_CouponCode then
    return
  end
  FGlobal_SetCandidate()
  local baseUrl = ToClient_getIngameCouponURL()
  local _certKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  local _userNo = getSelfPlayer():get():getUserNo()
  local _langType = ToClient_getResourceType()
  local _langTypeString = Defines.LanguageTypeToString[_langType]
  if "DV" == _langTypeString then
    _langTypeString = "KR"
  end
  if CppEnums.ServiceResourceType.eServiceResourceType_ID == _langType then
    _langTypeString = "EN"
  end
  baseUrl = baseUrl .. "?certKey=" .. tostring(_certKey) .. "&userNo=" .. tostring(_userNo) .. "&languageType=" .. tostring(_langTypeString)
  self._ui.stc_webControl:SetUrl(self._webSizeX, self._webSizeY, baseUrl, false, true)
  self._ui.stc_webControl:SetIME(true)
  PaGlobal_CouponCode:open()
  Panel_Window_CouponCode:ComputePos()
end
function PaGlobal_CouponCode:open()
  if nil == Panel_Window_CouponCode then
    return
  end
  Panel_Window_CouponCode:SetShow(true)
end
function PaGlobal_CouponCode:prepareClose()
  if nil == Panel_Window_CouponCode then
    return
  end
  FGlobal_ClearCandidate()
  self._ui.stc_webControl:ResetUrl()
  PaGlobal_CouponCode:close()
end
function PaGlobal_CouponCode:close()
  if nil == Panel_Window_CouponCode then
    return
  end
  Panel_Window_CouponCode:SetShow(false)
end
function PaGlobal_CouponCode:validate()
  self._ui.stc_Title:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.btn_Qusetion:isValidate()
end
