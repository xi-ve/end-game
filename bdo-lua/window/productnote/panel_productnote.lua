local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local IM = CppEnums.EProcessorInputMode
PaGlobal_ProductNote = {
  _productWeb = nil,
  _ui = {
    _btn_Close = nil,
    _btn_PopUp = nil,
    _btn_Refresh = nil,
    _titleBar = nil
  },
  _isPopUpContentsEnable = _ContentsGroup_PopUp,
  _sizeX = 0,
  _sizeY = 0,
  _panelSizeX = 0,
  _panelSizeY = 0,
  _titleBarSizeX = 0,
  _webSizeX = 700,
  _webSizeY = 558,
  _initialize = false
}
function Panel_ProductNote_ShowAni()
  UIAni.fadeInSCR_Down(Panel_ProductNote)
  local aniInfo1 = Panel_ProductNote:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_ProductNote:GetSizeX() / 2
  aniInfo1.AxisY = Panel_ProductNote:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_ProductNote:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_ProductNote:GetSizeX() / 2
  aniInfo2.AxisY = Panel_ProductNote:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function Panel_ProductNote_HideAni()
  Panel_ProductNote:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_ProductNote, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_ProductNote:initialize()
  if nil == Panel_ProductNote then
    return
  end
  self._ui._titleBar = UI.getChildControl(Panel_ProductNote, "Static_TitleBg")
  self._ui._btn_Close = UI.getChildControl(self._ui._titleBar, "Button_Close")
  self._ui._btn_PopUp = UI.getChildControl(self._ui._titleBar, "CheckButton_PopUp")
  self._ui._btn_Refresh = UI.getChildControl(self._ui._titleBar, "Button_Refresh")
  self._ui._btn_PopUp:SetShow(self._isPopUpContentsEnable)
  PaGlobal_Util_RegistWebResetControl(self._ui._btn_Refresh)
  self._ui._btn_Refresh:SetShow(_ContentsGroup_ResetCoherent)
  self._ui._buttonQuestion = UI.getChildControl(self._ui._titleBar, "Button_Question")
  PaGlobal_Util_RegistHelpTooltipEvent(self._ui._buttonQuestion, "\"ProductNote\"")
  self._productWeb = UI.createControl(__ePAUIControl_WebControl, Panel_ProductNote, "WebControl_ProductNote")
  self._productWeb:SetShow(true)
  self._productWeb:SetSize(self._webSizeX, self._webSizeY)
  self._productWeb:SetHorizonCenter()
  self._productWeb:SetVerticalTop()
  self._productWeb:SetSpanSize(0, 60)
  self._productWeb:ComputePos()
  self._productWeb:ResetUrl()
  self._initialize = true
  ProductNote_onScreenResize()
  self:registerEventHandler()
end
function PaGlobal_ProductNote:registerEventHandler()
  if nil == Panel_ProductNote then
    return
  end
  registerEvent("onScreenResize", "ProductNote_onScreenResize")
  Panel_ProductNote:SetShow(false, false)
  Panel_ProductNote:ActiveMouseEventEffect(true)
  Panel_ProductNote:setGlassBackground(true)
  Panel_ProductNote:RegisterShowEventFunc(true, "Panel_ProductNote_ShowAni()")
  Panel_ProductNote:RegisterShowEventFunc(false, "Panel_ProductNote_HideAni()")
  self._ui._btn_PopUp:addInputEvent("Mouse_LUp", "HandleClicked_ProductNote_PopUp()")
  self._ui._btn_PopUp:addInputEvent("Mouse_On", "ProductNote_PopUp_ShowIconToolTip( true )")
  self._ui._btn_PopUp:addInputEvent("Mouse_Out", "ProductNote_PopUp_ShowIconToolTip( false )")
  self._ui._buttonQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"ProductNote\" )")
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "Panel_ProductNote_ShowToggle()")
end
function Panel_ProductNote_ShowToggle()
  local isShow = Panel_ProductNote:IsShow()
  if ToClient_IsConferenceMode() then
    return
  end
  if true == ToClient_WorldMapIsShow() then
    return
  end
  if isShow == true then
    FGlobal_ClearCandidate()
    PaGlobal_ProductNote._productWeb:ResetUrl()
    audioPostEvent_SystemUi(13, 5)
    Panel_ProductNote:SetShow(false, false)
    ClearFocusEdit()
    PaGlobal_ProductNote._ui._btn_PopUp:SetCheck(false)
    if Panel_ProductNote:IsUISubApp() then
      Panel_ProductNote:CloseUISubApp()
    end
    return false
  else
    if false == _ContentsGroup_ProductNote then
      return
    end
    audioPostEvent_SystemUi(13, 6)
    Panel_ProductNote:SetShow(true, true)
    FGlobal_SetCandidate()
    PaGlobal_ProductNote._productWeb:SetUrl(PaGlobal_ProductNote._sizeX, PaGlobal_ProductNote._sizeY, "coui://UI_Data/UI_Html/Window/ProductNote/ProductNote_CategoryItemList.html?nodeProduct")
    PaGlobal_ProductNote._productWeb:SetIME(true)
    return true
  end
  return true
end
function ProductNote_Item_ShowToggle(itemKey)
  local isShow = Panel_ProductNote:IsShow()
  if ToClient_IsConferenceMode() then
    return
  end
  if true == ToClient_WorldMapIsShow() then
    return
  end
  if isShow == true then
    FGlobal_ClearCandidate()
    PaGlobal_ProductNote._productWeb:ResetUrl()
    audioPostEvent_SystemUi(13, 5)
    Panel_ProductNote:SetShow(false, false)
    if false == CheckChattingInput() then
      ClearFocusEdit()
    end
    PaGlobal_ProductNote._ui._btn_PopUp:SetCheck(false)
    if Panel_ProductNote:IsUISubApp() then
      Panel_ProductNote:CloseUISubApp()
    end
  else
    if false == _ContentsGroup_ProductNote then
      return
    end
    audioPostEvent_SystemUi(13, 6)
    Panel_ProductNote:SetShow(true, true)
    FGlobal_SetCandidate()
    PaGlobal_ProductNote._productWeb:SetUrl(PaGlobal_ProductNote._sizeX, PaGlobal_ProductNote._sizeY, "coui://UI_Data/UI_Html/Window/ProductNote/ProductNote_CategoryItemList.html?manufacture&" .. itemKey)
    PaGlobal_ProductNote._productWeb:SetIME(true)
  end
end
function ProductNote_onScreenResize()
  if false == PaGlobal_ProductNote._initialize then
    return
  end
  PaGlobal_ProductNote._sizeX = 875
  PaGlobal_ProductNote._sizeY = 697
  PaGlobal_ProductNote._panelSizeX = 895
  PaGlobal_ProductNote._panelSizeY = 767
  PaGlobal_ProductNote._titleBarSizeX = 895
  Panel_ProductNote:SetSize(PaGlobal_ProductNote._panelSizeX, PaGlobal_ProductNote._panelSizeY)
  PaGlobal_ProductNote._ui._titleBar:SetSize(PaGlobal_ProductNote._panelSizeX, 50)
  PaGlobal_ProductNote._productWeb:SetSize(PaGlobal_ProductNote._sizeX, PaGlobal_ProductNote._sizeY)
  PaGlobal_ProductNote._productWeb:SetHorizonCenter()
  PaGlobal_ProductNote._productWeb:SetVerticalTop()
  PaGlobal_ProductNote._productWeb:SetSpanSize(0, 60)
  PaGlobal_ProductNote._productWeb:ComputePos()
  Panel_ProductNote:SetPosX(math.floor((getScreenSizeX() - Panel_ProductNote:GetSizeX()) / 2))
  Panel_ProductNote:SetPosY(math.floor((getScreenSizeY() - Panel_ProductNote:GetSizeY()) / 2))
end
function HandleClicked_ProductNote_PopUp()
  if PaGlobal_ProductNote._ui._btn_PopUp:IsCheck() then
    Panel_ProductNote:OpenUISubApp()
  else
    Panel_ProductNote:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function ProductNote_PopUp_ShowIconToolTip(isShow)
  if isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    local desc = ""
    if PaGlobal_ProductNote._ui._btn_PopUp:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
    TooltipSimple_Show(PaGlobal_ProductNote._ui._btn_PopUp, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function FromClient_resetCoherentUIForProductWeb()
  if false == Panel_ProductNote:GetShow() then
    return
  end
  TooltipSimple_Hide()
  FGlobal_ClearCandidate()
  PaGlobal_ProductNote._productWeb:ResetUrl()
  audioPostEvent_SystemUi(13, 5)
  Panel_ProductNote:SetShow(false, false)
  ClearFocusEdit()
  PaGlobal_ProductNote._ui._btn_PopUp:SetCheck(false)
  if Panel_ProductNote:IsUISubApp() then
    Panel_ProductNote:CloseUISubApp()
  end
end
function FromClient_ProductNote_Initialize()
  PaGlobal_ProductNote:initialize()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_ProductNote_Initialize")
registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForProductWeb")
