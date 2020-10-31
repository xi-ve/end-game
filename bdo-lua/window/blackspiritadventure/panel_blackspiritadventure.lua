local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local isBlackSpiritAdventure = ToClient_IsContentsGroupOpen("1015")
local isExtentionBlackSpiritAdventure = ToClient_IsContentsGroupOpen("1497")
local isPopUpContentsEnable = ToClient_IsContentsGroupOpen("240")
PaGlobal_BlackSpiritAdventure = {
  _Web = nil,
  _ui = {
    _stc_title = nil,
    _btn_Refresh = nil,
    _btn_Question = nil,
    _chk_popUp = nil
  },
  _webSizeX = 918,
  _webSizeY = 655
}
function BlackSpiritAdventure_ShowAni()
  if nil == Panel_Window_BlackSpiritAdventure then
    return
  end
  audioPostEvent_SystemUi(0, 22)
  _AudioPostEvent_SystemUiForXBOX(0, 22)
  UIAni.fadeInSCR_Down(Panel_Window_BlackSpiritAdventure)
  local aniInfo1 = Panel_Window_BlackSpiritAdventure:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.2)
  aniInfo1.AxisX = Panel_Window_BlackSpiritAdventure:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_BlackSpiritAdventure:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_BlackSpiritAdventure:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.2)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_BlackSpiritAdventure:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_BlackSpiritAdventure:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function BlackSpiritAdventure_HideAni()
  if nil == Panel_Window_BlackSpiritAdventure then
    return
  end
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  Panel_Window_BlackSpiritAdventure:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_BlackSpiritAdventure, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_BlackSpiritAdventure:initialize()
  if nil == Panel_Window_BlackSpiritAdventure then
    return
  end
  self._Web = UI.createControl(__ePAUIControl_WebControl, Panel_Window_BlackSpiritAdventure, "WebControl_BlackSpiritAdventure_WebLink")
  self._Web:SetShow(true)
  self._Web:SetSize(self._webSizeX, self._webSizeY)
  self._Web:SetHorizonCenter()
  self._Web:SetVerticalTop()
  self._Web:SetSpanSize(0, 60)
  self._Web:ComputePos()
  self._Web:ResetUrl()
  self._ui._stc_title = UI.getChildControl(Panel_Window_BlackSpiritAdventure, "StaticText_TitleArea")
  self._ui._btn_Refresh = UI.getChildControl(self._ui._stc_title, "Button_Refresh")
  self._ui._btn_Refresh:SetShow(_ContentsGroup_ResetCoherent)
  self._ui._btn_Close = UI.getChildControl(self._ui._stc_title, "Button_Win_Close")
  self._ui._btn_Question = UI.getChildControl(self._ui._stc_title, "Button_Question")
  self._ui._btn_Question:SetShow(false)
  self._ui._chk_popUp = UI.getChildControl(self._ui._stc_title, "CheckButton_PopUp")
  self._ui._chk_popUp:SetShow(isPopUpContentsEnable)
  self:registerEventHandler()
end
function PaGlobal_BlackSpiritAdventure:registerEventHandler()
  if nil == Panel_Window_BlackSpiritAdventure then
    return
  end
  Panel_Window_BlackSpiritAdventure:SetShow(false)
  Panel_Window_BlackSpiritAdventure:setMaskingChild(true)
  Panel_Window_BlackSpiritAdventure:setGlassBackground(true)
  Panel_Window_BlackSpiritAdventure:SetDragAll(true)
  Panel_Window_BlackSpiritAdventure:RegisterShowEventFunc(true, "BlackSpiritAdventure_ShowAni()")
  Panel_Window_BlackSpiritAdventure:RegisterShowEventFunc(false, "BlackSpiritAdventure_HideAni()")
  PaGlobal_Util_RegistWebResetControl(self._ui._btn_Refresh)
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "BlackSpiritAd_Hide()")
  self._ui._chk_popUp:addInputEvent("Mouse_LUp", "HandleClicked_BlackSpiritAdventure_PopUp()")
  self._ui._chk_popUp:addInputEvent("Mouse_On", "BlackSpirit_PopUp_ShowIconToolTip( true )")
  self._ui._chk_popUp:addInputEvent("Mouse_Out", "BlackSpirit_PopUp_ShowIconToolTip( false )")
end
function PaGlobal_BlackSpiritAdventure:show(cooltimeOff)
  if nil == Panel_Window_BlackSpiritAdventure then
    return
  end
  if isBlackSpiritAdventure then
    Panel_Window_BlackSpiritAdventure:SetShow(true, true)
    Panel_Window_BlackSpiritAdventure:SetPosX(getScreenSizeX() / 2 - Panel_Window_BlackSpiritAdventure:GetSizeX() / 2)
    Panel_Window_BlackSpiritAdventure:SetPosY(getScreenSizeY() / 2 - Panel_Window_BlackSpiritAdventure:GetSizeY() / 2)
  else
    return
  end
  local myUserNo = getSelfPlayer():get():getUserNo()
  local cryptKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local bAdventureWebUrl = PaGlobal_URL_Check(worldNo)
  local isNationType = "KR"
  if isGameTypeKorea() then
    isNationType = "KR"
  elseif isGameTypeJapan() then
    isNationType = "JP"
  elseif isGameTypeRussia() then
    isNationType = "RU"
  elseif isGameTypeEnglish() then
    isNationType = "EN"
  elseif isGameTypeTaiwan() then
    isNationType = "TW"
  elseif isGameTypeSA() then
    isNationType = "SA"
  elseif isGameTypeTR() then
    isNationType = "TR"
  elseif isGameTypeTH() then
    isNationType = "TH"
  elseif isGameTypeID() then
    isNationType = "ID"
  else
    _PA_LOG("\236\160\149\237\131\156\234\179\164", "\236\131\136\235\161\156\236\154\180 \234\181\173\234\176\128 \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128\235\144\152\236\151\136\236\156\188\235\139\136 \236\157\180 \235\161\156\234\183\184\235\165\188 \235\176\156\234\178\172\237\149\152\235\169\180 \237\149\180\235\139\185 \235\139\180\235\139\185\236\158\144\236\151\144\234\178\140 \236\149\140\235\160\164\236\163\188\236\132\184\236\154\148 \234\188\173!!!")
    isNationType = "KR"
  end
  if true == isExtentionBlackSpiritAdventure then
    if nil ~= bAdventureWebUrl then
      local url = bAdventureWebUrl .. "/MarbleGame/Start?userNo=" .. tostring(myUserNo) .. "&certKey=" .. tostring(cryptKey) .. "&nationCode=" .. tostring(isNationType)
      _PA_LOG("\237\151\136\236\158\172\236\132\157", "url : " .. tostring(url))
      self._Web:SetUrl(self._webSizeX, self._webSizeY, url)
    end
  elseif nil ~= bAdventureWebUrl then
    local url = bAdventureWebUrl .. "/BoardGame?userNo=" .. tostring(myUserNo) .. "&certKey=" .. tostring(cryptKey) .. "&nationCode=" .. tostring(isNationType) .. "&cooltimeOff=" .. tostring(cooltimeOff)
    _PA_LOG("\234\180\145\236\154\180", "url : " .. tostring(url))
    self._Web:SetUrl(self._webSizeX, self._webSizeY, url)
  end
end
function BlackSpiritAd_Hide()
  if nil == Panel_Window_BlackSpiritAdventure then
    return
  end
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  Panel_Window_BlackSpiritAdventure:SetShow(false, false)
  Panel_Window_BlackSpiritAdventure:CloseUISubApp()
  PaGlobal_BlackSpiritAdventure._ui._chk_popUp:SetCheck(false)
  PaGlobal_BlackSpiritAdventure._Web:ResetUrl()
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  end
end
function FGlobal_BlackSpiritAdventure_Open()
  PaGlobal_BlackSpiritAdventure:show(false)
end
function Web_BlackSpirit_DiceSound()
  audioPostEvent_SystemUi(11, 16)
  _AudioPostEvent_SystemUiForXBOX(11, 16)
end
function BlackSpirit_PopUp_ShowIconToolTip(isShow)
  if isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    local desc = ""
    if PaGlobal_BlackSpiritAdventure._ui._chk_popUp:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
    TooltipSimple_Show(PaGlobal_BlackSpiritAdventure._ui._chk_popUp, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleClicked_BlackSpiritAdventure_PopUp()
  if nil == Panel_Window_BlackSpiritAdventure then
    return
  end
  if PaGlobal_BlackSpiritAdventure._ui._chk_popUp:IsCheck() then
    Panel_Window_BlackSpiritAdventure:OpenUISubApp()
  else
    Panel_Window_BlackSpiritAdventure:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function FromClient_openDiceGamebyNpcTalk()
  PaGlobal_BlackSpiritAdventure:show(true)
end
function FromClient_resetCoherentUIForBlackSpiritAdventure()
  if nil ~= Panel_Window_BlackSpiritAdventure and false == Panel_Window_BlackSpiritAdventure:GetShow() then
    return
  end
  TooltipSimple_Hide()
  BlackSpiritAd_Hide()
end
function FromClient_BlackSpiritAdventure_Initialize()
  PaGlobal_BlackSpiritAdventure:initialize()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_BlackSpiritAdventure_Initialize")
registerEvent("FromClient_openDiceGamebyNpcTalk", "FromClient_openDiceGamebyNpcTalk")
registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForBlackSpiritAdventure")
