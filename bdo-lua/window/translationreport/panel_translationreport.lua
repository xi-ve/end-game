PaGlobal_TranslationReport = {
  _ui = {
    _txt_title = UI.getChildControl(Panel_TranslationReport, "StaticText_TitleArea"),
    _translationReportWebControl = nil,
    _btn_Close = nil
  },
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "Panel_TranslationReport_init")
function Panel_TranslationReport_init()
  PaGlobal_TranslationReport:Initialize()
end
function PaGlobal_TranslationReport:Initialize()
  if true == self._initialize then
    return
  end
  Panel_TranslationReport:SetShow(false, false)
  self._ui._btn_Close = UI.getChildControl(self._ui._txt_title, "Button_Close")
  self._ui._translationReportWebControl = UI.createControl(__ePAUIControl_WebControl, Panel_TranslationReport, "WebControl_TranslationReport")
  self._ui._translationReportWebControl:SetShow(true)
  self._ui._translationReportWebControl:SetSize(700, 610)
  self._ui._translationReportWebControl:SetHorizonCenter()
  self._ui._translationReportWebControl:SetVerticalTop()
  self._ui._translationReportWebControl:SetSpanSize(0, 60)
  self._ui._translationReportWebControl:ComputePos()
  self._ui._translationReportWebControl:ResetUrl()
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._btn_Close:SetShow(false)
  end
  self:RegisterEvent()
  self._initialize = true
end
function PaGlobal_TranslationReport:RegisterEvent()
  if false == _ContentsGroup_UsePadSnapping then
    self._ui._btn_Close:addInputEvent("Mouse_LUp", "TranslationReport_Close()")
  end
  registerEvent("FromClient_TranslationReport", "TranslationReport_Opne")
end
function PaGlobal_TranslationReport:Open(staticType, key1, key2, key3, textNo)
  if isGameTypeGT() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TESTSERVER_CAUTION"))
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local url = PaGlobal_URL_Check(worldNo)
  local serviceType = getGameServiceType()
  if CppEnums.CountryType.KOR_REAL == serviceType or CppEnums.CountryType.KOR_ALPHA == serviceType then
    return
  end
  audioPostEvent_SystemUi(13, 6)
  _AudioPostEvent_SystemUiForXBOX(13, 6)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local userNo = selfPlayer:get():getUserNo()
  local cryptKey = selfPlayer:get():getWebAuthenticKeyCryptString()
  local serviceResourceType = ToClient_getResourceType()
  url = url .. "/Translation" .. "?userNo=" .. tostring(userNo) .. "&certKey=" .. tostring(cryptKey) .. "&translationKey1=" .. tostring(key1) .. "&translationKey2=" .. tostring(key2) .. "&translationKey3=" .. tostring(key3) .. "&textNo=" .. tostring(textNo) .. "&serviceResourceType=" .. tostring(serviceResourceType) .. "&staticType=" .. tostring(staticType)
  self._ui._translationReportWebControl:SetUrl(700, 610, url, false, true)
  self._ui._translationReportWebControl:SetIME(true)
  self._ui._translationReportWebControl:SetHorizonCenter()
  self._ui._translationReportWebControl:SetVerticalTop()
  self._ui._translationReportWebControl:SetSpanSize(0, 60)
  self._ui._translationReportWebControl:ComputePos()
  Panel_TranslationReport:SetPosX(getScreenSizeX() / 2 - Panel_TranslationReport:GetSizeX() / 2, getScreenSizeY() / 2 - Panel_TranslationReport:GetSizeY() / 2)
  Panel_TranslationReport:SetShow(true)
end
function PaGlobal_TranslationReport:Close()
  FGlobal_ClearCandidate()
  self._ui._translationReportWebControl:ResetUrl()
  Panel_TranslationReport:SetShow(false)
end
function TranslationReport_Opne(staticType, key1, key2, key3, textNo)
  PaGlobal_TranslationReport:Open(staticType, key1, key2, key3, textNo)
end
function TranslationReport_Close()
  PaGlobal_TranslationReport:Close()
end
