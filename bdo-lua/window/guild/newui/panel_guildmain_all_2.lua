function PaGlobalFunc_GuildMain_All_Open()
  if true == Panel_GuildMain_All:GetShow() then
    return
  end
  PaGlobal_GuildMain_All:prepareOpen()
end
function PaGlobalFunc_GuildMain_All_OnScreenResize()
  if false == Panel_GuildMain_All:GetShow() then
    return
  end
  Panel_GuildMain_All:ComputePos()
  if true == PaGlobal_GuildMain_All._isConsole then
    PaGlobal_GuildMain_All._ui.stc_Keyguide_Bg:ComputePos()
  end
end
function PaGlobalFunc_GuildMain_All_KeyGuideResize()
  if nil == Panel_GuildMain_All then
    return
  end
  PaGlobal_GuildMain_All._ui.stc_Keyguide_Bg:ComputePos()
end
function PaGlobalFunc_GuildMain_All_Close()
  if false == Panel_GuildMain_All:GetShow() then
    return
  end
  if Panel_GuildMain_All:IsUISubApp() then
    return
  end
  PaGlobal_GuildMain_All:prepareClose()
end
function HandleEventLUp_GuildMain_All_Close()
  if false == Panel_GuildMain_All:GetShow() then
    return
  end
  PaGlobal_GuildMain_All:prepareClose()
end
function PaGlobalFunc_GuildMain_All_ShowAni()
  if nil == Panel_GuildMain_All then
    return
  end
  Panel_GuildMain_All:SetAlpha(0)
  UIAni.AlphaAnimation(1, Panel_GuildMain_All, 0, 0.3)
end
function PaGlobalFunc_GuildMain_All_HideAni()
  if nil == Panel_GuildMain_All then
    return
  end
  local ani1 = UIAni.AlphaAnimation(0, Panel_GuildMain_All, 0, 0.2)
  ani1:SetHideAtEnd(true)
end
function PaGlobal_GuildMain_All_ChangePanelSize(changeSizeY)
  if nil == Panel_GuildMain_All then
    return
  end
  if nil == changeSizeY then
    changeSizeY = PaGlobal_GuildMain_All._originSizeY
  end
  Panel_GuildMain_All:SetSize(Panel_GuildMain_All:GetSizeX(), changeSizeY)
end
function PaGlobalFunc_GuildAlliance_All_ChangeBGSize(index, changeSizeY)
  if nil == Panel_GuildMain_All then
    return
  end
  if index == PaGlobal_GuildMain_All._eTABINDEX._ALLIANCE then
    if nil == changeSizeY or 0 == changeSizeY then
      PaGlobal_GuildMain_All._tabData[index].bg:SetSize(PaGlobal_GuildMain_All._tabData[index].bg:GetSizeX(), PaGlobal_GuildMain_All._tabData[index].originSizeY)
    else
      PaGlobal_GuildMain_All._tabData[index].bg:SetSize(PaGlobal_GuildMain_All._tabData[index].bg:GetSizeX(), PaGlobal_GuildMain_All._tabData[index].originSizeY + changeSizeY)
    end
  end
end
function HandleEventPadUp_GuildMain_All_PressOtherTab(isUp)
  TooltipSimple_Hide()
  local curTab = PaGlobal_GuildMain_All._currentTabIdxConsole
  if nil == curTab then
    return
  end
  if true == isUp then
    curTab = curTab + 1
    if curTab > #PaGlobal_GuildMain_All._tabBtnConsole then
      curTab = 0
    end
  else
    curTab = curTab - 1
    if curTab < 0 then
      curTab = #PaGlobal_GuildMain_All._tabBtnConsole
    end
  end
  if nil ~= PaGlobal_GuildMain_All._tabBtnConsole[curTab] then
    PaGlobal_GuildMain_All._currentTabIdxConsole = curTab
    HandleEventLUp_GuildMain_All_ClickOtherTab(PaGlobal_GuildMain_All._tabBtnConsole[curTab])
  end
end
function HandleEventLUp_GuildMain_All_ClickOtherTab(idx)
  if nil == idx then
    return
  end
  PaGlobal_GuildMain_All:otherTabOpen(idx)
end
function PaGlobalFunc_GuildMain_All_GetBgShow(idx)
  if nil == idx or nil == PaGlobal_GuildMain_All._tabData then
    return false
  end
  if nil == PaGlobal_GuildMain_All._tabData[idx] then
    return false
  end
  return PaGlobal_GuildMain_All._tabData[idx].bg:GetShow()
end
function HandleEventOnOut_GuildMain_All_ShowTooltip(isShow)
  if nil == isShow then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  if true == PaGlobal_GuildMain_All._ui.btn_PopUp:IsCheck() then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
  else
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
  end
  control = PaGlobal_GuildMain_All._ui.btn_PopUp
  name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_GuildMain_All_PearlAppTooltip(isShow)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  control = PaGlobal_GuildMain_All._ui.btn_PearlApp
  name = PAGetString(Defines.StringSheet_GAME, "LUA_PEARLAPP_TOOLTIP_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_PEARLAPP_TOOLTIP_DESC")
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_GuildMain_All_PopUp()
  if PaGlobal_GuildMain_All._ui.btn_PopUp:IsCheck() then
    Panel_GuildMain_All:OpenUISubApp()
  else
    Panel_GuildMain_All:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function HandleEventLUp_GuildMain_All_RadioBtnTooltip(type)
  if nil == type then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  control = PaGlobal_GuildMain_All._ui.rdo_btnTable[type]
  name = PAGetString(Defines.StringSheet_GAME, PaGlobal_GuildMain_All._tooltip[type])
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_GuildMain_All_CheckIsMecernary()
  if false == _ContentsGroup_BattleFieldVolunteer then
    return false
  end
  if nil == getSelfPlayer() then
    return false
  end
  if __eGuildMemberGradeVolunteer == getSelfPlayer():getGuildMemberGrade() then
    return true
  end
  return false
end
function PaGlobalFunc_GuildMain_All_AllianceOpen()
  TooltipSimple_Hide()
  PaGlobal_GuildMain_All._ui.stc_Alliance_Bg:SetShow(false)
  PaGlobal_GuildMain_All._ui.stc_AllianceInvite_Bg:SetShow(false)
  if true == PaGlobal_GuildMain_All:hasAlliance() then
    PaGlobalFunc_GuildAlliance_All_Update()
    PaGlobal_GuildMain_All._ui.stc_Alliance_Bg:SetShow(true)
    PaGlobal_GuildMain_All._tabData[PaGlobal_GuildMain_All._eTABINDEX._ALLIANCE].bg = PaGlobal_GuildMain_All._ui.stc_Alliance_Bg
  else
    local _isGuildMaster = getSelfPlayer():get():isGuildMaster()
    if false == _isGuildMaster then
      return
    end
    PaGlobalFunc_GuildAllianceInvite_All_Update()
    PaGlobal_GuildMain_All._ui.stc_AllianceInvite_Bg:SetShow(true)
    PaGlobal_GuildMain_All._tabData[PaGlobal_GuildMain_All._eTABINDEX._ALLIANCE].bg = PaGlobal_GuildMain_All._ui.stc_AllianceInvite_Bg
  end
end
function FromClient_resetCoherentUIForGuild()
  PaGlobalFunc_GuildMain_All_Close()
end
