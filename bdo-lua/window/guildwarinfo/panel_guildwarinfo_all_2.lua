function PaGlobalFunc_GuildWarInfo_All_Open(territoryKey)
  if nil == Panel_GuildWarInfo_All then
    return
  end
  if PaGlobalFunc_GuildWarInfo_All_GetShow() or false == ToClient_IsGrowStepOpen(__eGrowStep_guildWarInfo) then
    return
  end
  PaGlobal_GuildWarInfo_All:prepareOpen(territoryKey)
end
function HandleEventLUp_GuildWarInfo_All_OpenSmallWindow()
  if nil == Panel_GuildWarInfo_All then
    return
  end
  PaGlobalFunc_GuildWarInfo_All_Close()
  PaGlobalFunc_GuildWarInfoSmall_All_Open(PaGlobal_GuildWarInfo_All._selectedTerritoryKey)
end
function HandleEventLUp_GuildWarInfo_All_OpenScoreWindow(index)
  if nil == Panel_GuildWarInfo_All then
    return
  end
  if true == PaGlobalFunc_GuildWarScore_All_GetShow() then
    PaGlobalFunc_GuildWarScore_All_Close()
    return
  end
  HandleEventLUp_GuildWarInfo_All_Reload()
  if nil == index then
    PaGlobalFunc_GuildWarScore_All_Open(PaGlobal_GuildWarInfo_All._defenceGuildNo)
  else
    PaGlobalFunc_GuildWarScore_All_Open(PaGlobal_GuildWarInfo_All._offenceGuildNoList[index - 1])
  end
end
function PaGlobalFunc_GuildWarInfo_All_Close()
  if nil == Panel_GuildWarInfo_All then
    return
  end
  PaGlobal_GuildWarInfo_All:prepareClose()
end
function PaGlobalFunc_GuildWarInfo_All_GetShow()
  if nil == Panel_GuildWarInfo_All then
    return
  end
  return Panel_GuildWarInfo_All:GetShow()
end
function PaGlobalFunc_GuildWarInfo_All_UpdateGuildList(content, index)
  if nil == Panel_GuildWarInfo_All then
    return
  end
  if nil == content or nil == index then
    return
  end
  PaGlobal_GuildWarInfo_All:updateGuildList(content, index)
end
function PaGlobalFunc_GuildWarInfo_All_UpdatePerFrameFunc(deltaTime)
  if nil == Panel_GuildWarInfo_All then
    return
  end
  PaGlobal_GuildWarInfo_All._reloadTimer = PaGlobal_GuildWarInfo_All._reloadTimer + deltaTime
  if PaGlobal_GuildWarInfo_All._reloadTimer > 30 then
    ToClient_RequestSiegeScore(PaGlobal_GuildWarInfo_All._selectedTerritoryKey)
    PaGlobal_GuildWarInfo_All._reloadTimer = 0
  end
end
function HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(isShow, uiIndex, tIndex, index, isConsoleShow)
  if nil == Panel_GuildWarInfo_All or PaGlobal_GuildWarInfo_All._isConsole and true ~= isConsoleShow then
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local uiControl, name
  if 0 == uiIndex then
    uiControl = PaGlobal_GuildWarInfo_All._defenceGuildInfo.stc_Title[tIndex]
  elseif 1 == uiIndex then
    uiControl = PaGlobal_GuildWarInfo_All._offenceGuildInfo_2[index].stc_Title[tIndex]
  elseif 2 == uiIndex then
    uiControl = PaGlobal_GuildWarInfo_All._offenceGuildInfo_4[index].stc_Title[tIndex]
  elseif 3 == uiIndex then
    uiControl = PaGlobal_GuildWarInfo_All._offenceGuildListInfo[index].stc_Title[tIndex]
  end
  if 0 == tIndex then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDWARINFO_ENDURANCETITLE")
  elseif 1 == tIndex then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDWARINFO_OBJECTKILLCOUNTTITLE")
  elseif 2 == tIndex then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDWARINFO_PLAYERKILLCOUNTTITLE")
  elseif 3 == tIndex then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDWARINFO_SERVANTKILLCOUNTTITLE")
  elseif 4 == tIndex then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDWARINFO_DEATHCOUNTTITLE")
  end
  TooltipSimple_Show(uiControl, name)
end
function HandleEventOnOut_GuildWarInfo_All_ShowSmallWindowTooltip(isShow)
  if nil == Panel_GuildWarInfo_All then
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_BIG_TO_SMALL_TOOLTIP_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_BIG_TO_SMALL_TOOLTIP_DESC")
  local uiControl = PaGlobal_GuildWarInfo_All._ui.btn_Small
  TooltipSimple_Show(uiControl, name, desc)
end
function HandleEventOnOut_GuildWarInfo_All_ShowRefreshTooltip(isShow)
  if nil == Panel_GuildWarInfo_All then
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDWARINFO_RELOADBUTTON")
  local uiControl = PaGlobal_GuildWarInfo_All._ui.btn_Reload
  TooltipSimple_Show(uiControl, name)
end
function HandleEventLUp_GuildWarInfo_All_SelectTab(index)
  if nil == Panel_GuildWarInfo_All then
    return
  end
  PaGlobal_GuildWarInfo_All:selectTab(index)
end
function HandleEventLBRB_GuildWarInfo_All_ChangeTabConsole(flag)
  if nil == Panel_GuildWarInfo_All then
    return
  end
  PaGlobal_GuildWarInfo_All:changeTab(flag)
end
function HandleEventLUp_GuildWarInfo_All_Reload()
  if nil == Panel_GuildWarInfo_All then
    return
  end
  if 5 < PaGlobal_GuildWarInfo_All._reloadTimer then
    ToClient_RequestSiegeScore(PaGlobal_GuildWarInfo_All._selectedTerritoryKey)
    PaGlobal_GuildWarInfo_All._reloadTimer = 0
  end
end
function FromClient_GuildWarInfo_All_UpdateScoreData()
  if nil == Panel_GuildWarInfo_All then
    return
  end
  PaGlobal_GuildWarInfo_All:updateBasicInfo()
  PaGlobalFunc_GuildWarScore_All_Update()
end
function PaGloabl_ContentsName_ShowAni()
  if nil == Panel_GuildWarInfo_All then
    return
  end
end
function PaGloabl_ContentsName_HideAni()
  if nil == Panel_GuildWarInfo_All then
    return
  end
end
