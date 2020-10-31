function InputMLUp_ExpirienceWiki_All_Close()
  if true == Panel_Window_ExpirienceWiki_All:IsUISubApp() then
    Panel_Window_ExpirienceWiki_All:CloseUISubApp()
    PaGlobal_Expirience_All._ui.btn_popUp:SetCheck(false)
  end
  PaGlobal_Expirience_All:prepareClose()
end
function PaGlobal_ExpirienceWiki_All_Open()
  PaGlobal_Expirience_All:prepareOpen()
end
function PaGlobal_ExpirienceWiki_All_SetDirectLink(link)
  local self = PaGlobal_Expirience_All
  self._directLinkUrl = link
end
function PaGlobal_ExpirienceWiki_All_ShowIconToolTip(isShow)
  if isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    local desc = ""
    if PaGlobal_Expirience_All._ui.btn_popUp:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
    TooltipSimple_Show(PaGlobal_Expirience_All._ui.btn_popUp, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_ExpirienceWiki_All_FullSizeBtnToolTip(isShow)
  if isShow then
    local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EXPERIENCEWIKI_ALL_FULLSIZE")
    TooltipSimple_Show(PaGlobal_Expirience_All._ui.btn_Full, name, nil)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_ExpirienceWiki_All_CheckPopupUI()
  if true == PaGlobal_Expirience_All._ui.btn_popUp:IsCheck() then
    Panel_Window_ExpirienceWiki_All:OpenUISubApp()
  else
    Panel_Window_ExpirienceWiki_All:CloseUISubApp()
  end
end
function Panel_Window_ExpirienceWiki_All_ShowAni()
  UIAni.fadeInSCR_Down(Panel_Window_ExpirienceWiki_All)
  local aniInfo1 = Panel_Window_ExpirienceWiki_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_ExpirienceWiki_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_ExpirienceWiki_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_ExpirienceWiki_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_ExpirienceWiki_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_ExpirienceWiki_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function Panel_Window_ExpirienceWiki_All_HideAni()
  audioPostEvent_SystemUi(13, 5)
  Panel_Window_ExpirienceWiki_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_ExpirienceWiki_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function FromClient_resetCoherentUIForExpirienceWikiAll()
  if Panel_Window_ExpirienceWiki_All:GetShow() then
    TooltipSimple_Hide()
    InputMLUp_ExpirienceWiki_All_Close()
  end
end
function FromClient_ExpirienceWiki_All_GetCurrentUrl(url)
  if false == Panel_Window_ExpirienceWiki_All:GetShow() or nil == url or "" == url then
    return
  end
  PaGlobal_Expirience_All:refreshCurrentUrl(url)
end
function HandleEventLUp_ExpirienceWiki_All_SetFulllScreen()
  local isStickerUI = Panel_Window_ExpirienceWiki_All:IsUISubApp()
  if true == isStickerUI then
    Panel_Window_ExpirienceWiki_All:CloseUISubApp()
    TooltipSimple_Hide()
  end
  if false == PaGlobal_Expirience_All._isFullSize then
    PaGlobal_Expirience_All:changePanelToFullSize(true)
  else
    PaGlobal_Expirience_All:changePanelToFullSize(false)
  end
  PaGlobal_Expirience_All._ui.stc_webControl:TriggerEvent("FromClient_RequestExperienceWiki_Refresh", "")
  PaGlobal_Expirience_All._isFullSize = not PaGlobal_Expirience_All._isFullSize
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBoolNoSave(__eExperienceWIkiFullScreenNoSave, PaGlobal_Expirience_All._isFullSize)
  if true == isStickerUI then
    Panel_Window_ExpirienceWiki_All:OpenUISubApp()
  end
end
