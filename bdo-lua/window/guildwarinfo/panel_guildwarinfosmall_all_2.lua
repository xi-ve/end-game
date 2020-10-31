function PaGlobalFunc_GuildWarInfoSmall_All_Open(selectedTerritoryKey)
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  PaGlobal_GuildWarInfoSmall_All:prepareOpen(selectedTerritoryKey)
end
function PaGlobalFunc_GuildWarInfoSmall_All_Close()
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  TooltipSimple_Hide()
  PaGlobal_GuildWarInfoSmall_All:prepareClose()
end
function PaGlobalFunc_GuildWarInfoSmall_All_GetShow()
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  return Panel_GuildWarInfoSmall_All:GetShow()
end
function PaGlobalFunc_GuildWarInfoSmall_All_UpdateOffenceGuildList(content, index)
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  PaGlobal_GuildWarInfoSmall_All:updateOffenceGuildList(content, index)
end
function PaGlobalFunc_GuildWarInfoSmall_All_UpdatePerFrame(deltaTime)
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  PaGlobal_GuildWarInfoSmall_All._reloadTimer = PaGlobal_GuildWarInfoSmall_All._reloadTimer + deltaTime
  if PaGlobal_GuildWarInfoSmall_All._reloadTimer > 30 then
    ToClient_RequestSiegeScore(PaGlobal_GuildWarInfoSmall_All._selectedTerritoryKey)
    PaGlobal_GuildWarInfoSmall_All._reloadTimer = 0
  end
end
function HandleEventLUp_GuildWarInfoSmall_All_SetComboBox()
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  PaGlobal_GuildWarInfoSmall_All:setComboBox()
end
function HandleEventLUp_GuildWarInfoSmall_All_ShowComboBox()
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  PaGlobal_GuildWarInfoSmall_All:showComboBox()
end
function HandleEventLUp_GuildWarInfoSmall_All_OpenBigWindow()
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  local territoryKey = PaGlobal_GuildWarInfoSmall_All._ui.stc_ComboBox:GetSelectIndex()
  PaGlobalFunc_GuildWarInfo_All_Open(territoryKey)
  PaGlobalFunc_GuildWarInfoSmall_All_Close()
end
function HandleEventLUp_GuildWarInfoSmall_All_Reload()
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  if 5 < PaGlobal_GuildWarInfoSmall_All._reloadTimer then
    ToClient_RequestSiegeScore(PaGlobal_GuildWarInfoSmall_All._selectedTerritoryKey)
    PaGlobal_GuildWarInfoSmall_All._reloadTimer = 0
  end
end
function HandleEventOnOut_GuildWarInfoSmall_All_ShowTooltip(isShow)
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_SMALL_TO_BIG_TOOLTIP_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_SMALL_TO_BIG_TOOLTIP_DESC")
  local uiControl = PaGlobal_GuildWarInfoSmall_All._ui.btn_Big
  TooltipSimple_Show(uiControl, name, desc)
end
function FromClient_GuildWarInfoSmall_All_UpdateScoreData()
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  if false == PaGlobal_GuildWarInfoSmall_All._initialize then
    return
  end
  if false == PaGlobalFunc_GuildWarInfoSmall_All_GetShow() then
    return
  end
  PaGlobal_GuildWarInfoSmall_All:update(PaGlobal_GuildWarInfoSmall_All._selectedTerritoryKey)
end
function FromClient_GuildWarInfoSmall_All_NotifyStartSiege(msgType, regionKeyRaw)
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  if false == PaGlobal_GuildWarInfoSmall_All._initialize then
    return
  end
  if false == PaGlobalFunc_GuildWarInfoSmall_All_GetShow() then
    return
  end
  if 0 == msgType or 1 == msgType then
    PaGlobal_GuildWarInfoSmall_All:update(PaGlobal_GuildWarInfoSmall_All._selectedTerritoryKey)
  end
end
