function PaGlobalFunc_GuildAllianceInvite_All_Update()
  PaGlobal_GuildAllianceInvite_All:update()
end
function PaGlobalFunc_GuildAllianceInvite_All_UpdateMemberCount(count)
  if nil == PaGlobal_GuildAllianceInvite_All._selectedGuildInfoIdx or PaGlobal_GuildAllianceInvite_All._selectedGuildInfoIdx < 0 then
    UI.ASSERT(false, "PaGlobal_GuildAllianceInvite_All._selectedGuildInfoIdx  == " .. tostring(PaGlobal_GuildAllianceInvite_All._selectedGuildInfoIdx))
    return
  end
  local memberCount = Int64toInt32(count)
  if memberCount < PaGlobal_GuildAllianceInvite_All._minMemberCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCE_WARNING_MIN_LIMIT_GUILD_COUNT"))
    PaGlobal_GuildAllianceInvite_All:setMemberCount(PaGlobal_GuildAllianceInvite_All._selectedGuildInfoIdx, PaGlobal_GuildAllianceInvite_All._minMemberCount)
  else
    PaGlobal_GuildAllianceInvite_All:setMemberCount(PaGlobal_GuildAllianceInvite_All._selectedGuildInfoIdx, memberCount)
  end
  PaGlobal_GuildAllianceInvite_All:computeMemberCount()
  PaGlobal_GuildAllianceInvite_All:changeMiniDesc()
end
function PaGlobalFunc_GuildAllianceInvite_All_UpdateTaxRate(count)
  if nil == PaGlobal_GuildAllianceInvite_All._selectedGuildInfoIdx or PaGlobal_GuildAllianceInvite_All._selectedGuildInfoIdx < 0 then
    UI.ASSERT(false, "PaGlobal_GuildAllianceInvite_All._selectedGuildInfoIdx  == " .. tostring(PaGlobal_GuildAllianceInvite_All._selectedGuildInfoIdx))
    return
  end
  local taxRate = Int64toInt32(count)
  Panel_NumberPad_Close()
  if taxRate < PaGlobal_GuildAllianceInvite_All._taxRate_Default[PaGlobal_GuildAllianceInvite_All._curAddGuildInfo + 1] then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_WARNING_TAXCONST_MIN"))
    taxRate = PaGlobal_GuildAllianceInvite_All._taxRate_Default[PaGlobal_GuildAllianceInvite_All._curAddGuildInfo + 1]
  end
  PaGlobal_GuildAllianceInvite_All:setRate(PaGlobal_GuildAllianceInvite_All._selectedGuildInfoIdx, taxRate)
  PaGlobal_GuildAllianceInvite_All:computTaxRate()
  PaGlobal_GuildAllianceInvite_All:changeMiniDesc()
end
function PaGlobalFunc_GuildAllianceInvite_All_RegistGuildName(index)
  if "" == PaGlobal_GuildAllianceInvite_All._ui.guildInfo[index].edit_guildName:GetEditText() then
    PaGlobal_GuildAllianceInvite_All._ui.guildInfo[index].edit_guildName:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_INPUTMEMBERNAME_TEXT"))
  end
  ClearFocusEdit()
end
function PaGlobalFunc_GuildAllianceInvite_All_RegistAllianceName()
  PaGlobal_GuildAllianceInvite_All._allianceName = PaGlobal_GuildAllianceInvite_All._ui.edit_searchGuild:GetEditText()
  if "" == PaGlobal_GuildAllianceInvite_All._allianceName then
    PaGlobal_GuildAllianceInvite_All._ui.edit_searchGuild:SetEditText(PaGlobal_GuildAllianceInvite_All._defaultAllianceName)
  end
  ClearFocusEdit()
end
function PaGlobalFunc_GuildAllianceInvite_All_ResetInvite()
  PaGlobalFunc_GuildMain_All_AllianceOpen()
  PaGlobal_GuildAllianceInvite_All._isInvite = false
  PaGlobal_GuildAllianceInvite_All:reSetGuildInfo()
end
function HandleEventOnOut_GuildAllianceInvite_All_ShowToolTip(isShow, index)
  if false == isShow or nil == index then
    TooltipSimple_Hide()
    return
  end
  local isAddType = false
  if PaGlobal_GuildAllianceInvite_All._ui.guildInfo[index].stc_addIcon:GetShow() then
    isAddType = true
  end
  local name, desc, control
  if true == isAddType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCE_ADDALLIANCETIP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCE_ADDALLIANCETIP_INFO")
    control = PaGlobal_GuildAllianceInvite_All._ui.guildInfo[index].stc_guildInfoBg
  else
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDALLIANCEINFO_DELETE_ALLIANCE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCE_DELETEALLIANCETIP_INFO")
    control = PaGlobal_GuildAllianceInvite_All._ui.guildInfo[index].btn_close
  end
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_GuildAllianceInvite_All_FocusGuildName(index)
  PaGlobal_GuildAllianceInvite_All._selectedGuildInfoIdx = index
  Panel_NumberPad_Close()
  PaGlobal_GuildAllianceInvite_All._ui.guildInfo[index].edit_guildName:SetEditText("")
  SetFocusEdit(PaGlobal_GuildAllianceInvite_All._ui.guildInfo[index].edit_guildName)
end
function HandleEventLUp_GuildAllianceInvite_All_FocusAllianceName()
  Panel_NumberPad_Close()
  if "" == PaGlobal_GuildAllianceInvite_All._allianceName then
    PaGlobal_GuildAllianceInvite_All._ui.edit_searchGuild:SetEditText("")
  else
    SetFocusEdit(PaGlobal_GuildAllianceInvite_All._ui.edit_searchGuild)
  end
end
function HandleEventLUp_GuildAllianceInvite_All_ReSet()
  PaGlobal_GuildAllianceInvite_All:reSetGuildInfo()
end
function HandleEventLUp_GuildAllianceInvite_All_CreateAlliance()
  if PaGlobal_GuildAllianceInvite_All._defaultAllianceName ~= PaGlobal_GuildAllianceInvite_All._ui.edit_searchGuild:GetEditText() then
    PaGlobal_GuildAllianceInvite_All._allianceName = tostring(PaGlobal_GuildAllianceInvite_All._ui.edit_searchGuild:GetEditText())
  end
  for ii = 1, PaGlobal_GuildAllianceInvite_All._curAddGuildInfo do
    if 1 == ii then
      PaGlobal_GuildAllianceInvite_All._allianceMemberName[ii] = tostring(PaGlobal_GuildAllianceInvite_All._ui.guildInfo[ii].txt_guildName:GetText())
    else
      PaGlobal_GuildAllianceInvite_All._allianceMemberName[ii] = tostring(PaGlobal_GuildAllianceInvite_All._ui.guildInfo[ii].edit_guildName:GetEditText())
    end
  end
  local isDone = 0
  local basicText = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_INPUTMEMBERNAME_TEXT")
  for ii = 1, PaGlobal_GuildAllianceInvite_All._curAddGuildInfo do
    if nil ~= PaGlobal_GuildAllianceInvite_All._allianceMemberName[ii] or "" ~= PaGlobal_GuildAllianceInvite_All._allianceMemberName[ii] or basicText ~= PaGlobal_GuildAllianceInvite_All._allianceMemberName[ii] then
      isDone = isDone + 1
    end
  end
  if nil == PaGlobal_GuildAllianceInvite_All._allianceName or "" == PaGlobal_GuildAllianceInvite_All._allianceName then
    PaGlobal_GuildAllianceInvite_All:notInputMessage(0)
  elseif isDone ~= PaGlobal_GuildAllianceInvite_All._curAddGuildInfo then
    PaGlobal_GuildAllianceInvite_All:notInputMessage(1)
  elseif 100 ~= PaGlobal_GuildAllianceInvite_All._curTaxRate then
    PaGlobal_GuildAllianceInvite_All:notInputMessage(2)
  else
    isDone = 0
    PaGlobal_GuildAllianceInvite_All:createAlliance()
  end
end
function HandleEventLUp_GuildAllianceInvite_All_CancelInvite()
  ToClient_CancelCreateGuildAlliance()
  PaGlobal_GuildAllianceInvite_All._isInvite = false
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_CANCEL_CREATE_ALLIANCE"))
  PaGlobal_GuildAllianceInvite_All:changeMiniDesc()
end
function PaGlobalFunc_GuildAllianceInvite_All_End_VirtualKey_MemberName(str)
  PaGlobal_GuildAllianceInvite_All._ui.guildInfo[index].edit_guildName:SetEditText(str)
  ClearFocusEdit()
  PaGlobal_GuildAllianceInvite_All._ui.guildInfo[index].stc_guildInfoBg:SetCheck(false)
end
function PaGlobalFunc_GuildAllianceInvite_All_End_VirtualKey_AllianceName(str)
  PaGlobal_GuildAllianceInvite_All._ui.edit_searchGuild:SetEditText(str)
  ClearFocusEdit()
  PaGlobal_GuildAllianceInvite_All._ui.guildInfo[index].stc_guildInfoBg:SetCheck(false)
end
function HandleEventLUp_GuildAllianceInvite_All_AddGuildInfo(index)
  UI.ASSERT_NAME(nil ~= index, "HandleEventLUp_GuildAllianceInvite_All_AddGuildInfo index is nil ", "\234\185\128\236\156\164\236\167\128")
  if PaGlobal_GuildAllianceInvite_All._curMemberCount + PaGlobal_GuildAllianceInvite_All._minMemberCount > PaGlobal_GuildAllianceInvite_All._maxMemberCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_WARNING_MAX_GUILDMEMBER_COUNT"))
    return
  end
  if nil == PaGlobal_GuildAllianceInvite_All._ui.guildInfo[index] then
    PaGlobal_GuildAllianceInvite_All:createGuildInfo(index)
  end
  PaGlobal_GuildAllianceInvite_All:setGuildInfo(false, index)
  PaGlobal_GuildAllianceInvite_All._curAddGuildInfo = PaGlobal_GuildAllianceInvite_All._curAddGuildInfo + 1
  PaGlobal_GuildAllianceInvite_All:changeTaxConstRate()
  PaGlobal_GuildAllianceInvite_All:changeMiniDesc()
  if PaGlobal_GuildAllianceInvite_All._maxAddGuildInfo == PaGlobal_GuildAllianceInvite_All._curAddGuildInfo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_TOTALMEMEBEROVER_TEXT"))
    return
  end
  local addIndex = index + 1
  if nil == PaGlobal_GuildAllianceInvite_All._ui.guildInfo[addIndex] then
    PaGlobal_GuildAllianceInvite_All:createGuildInfo(addIndex)
  end
  PaGlobal_GuildAllianceInvite_All:setGuildInfo(true, addIndex)
end
function HandleEventLUp_GuildAllianceInvite_All_ClearGuildInfo(index)
  UI.ASSERT_NAME(nil ~= index, "HandleEventLUp_GuildAllianceInvite_All_ClearGuildInfo index is nil ", "\234\185\128\236\156\164\236\167\128")
  if index ~= PaGlobal_GuildAllianceInvite_All._curAddGuildInfo then
    PaGlobal_GuildAllianceInvite_All:changeGuildInfoIndex(index)
  end
  PaGlobal_GuildAllianceInvite_All._memberCount[PaGlobal_GuildAllianceInvite_All._curAddGuildInfo] = 0
  PaGlobal_GuildAllianceInvite_All._taxRate[PaGlobal_GuildAllianceInvite_All._curAddGuildInfo] = 0
  PaGlobal_GuildAllianceInvite_All._ui.guildInfo[PaGlobal_GuildAllianceInvite_All._curAddGuildInfo].stc_guildInfoBg:SetShow(false)
  PaGlobal_GuildAllianceInvite_All._curAddGuildInfo = PaGlobal_GuildAllianceInvite_All._curAddGuildInfo - 1
  PaGlobal_GuildAllianceInvite_All:computeMemberCount()
  PaGlobal_GuildAllianceInvite_All:computTaxRate()
  PaGlobal_GuildAllianceInvite_All:changeMiniDesc()
  for ii = PaGlobal_GuildAllianceInvite_All._curAddGuildInfo + 1, #PaGlobal_GuildAllianceInvite_All._ui.guildInfo do
    PaGlobal_GuildAllianceInvite_All._ui.guildInfo[ii].stc_guildInfoBg:SetShow(false)
  end
  PaGlobal_GuildAllianceInvite_All:setGuildInfo(true, PaGlobal_GuildAllianceInvite_All._curAddGuildInfo + 1)
end
function HandleEventLUp_GuildAllianceInvite_All_MemberCountClick(index)
  PaGlobal_GuildAllianceInvite_All._selectedGuildInfoIdx = index
  local maxLimitMemberCount = PaGlobal_GuildAllianceInvite_All._maxMemberCount - (PaGlobal_GuildAllianceInvite_All._curMemberCount - PaGlobal_GuildAllianceInvite_All._memberCount[index])
  maxLimitMemberCount = toInt64(0, maxLimitMemberCount)
  Panel_NumberPad_Close()
  Panel_NumberPad_Show(true, maxLimitMemberCount, 0, PaGlobalFunc_GuildAllianceInvite_All_UpdateMemberCount)
end
function HandleEventLUp_GuildAllianceInvite_All_TaxRateClick(index)
  PaGlobal_GuildAllianceInvite_All._selectedGuildInfoIdx = index
  local maxLimitRate = PaGlobal_GuildAllianceInvite_All._maxTaxRate - (PaGlobal_GuildAllianceInvite_All._curTaxRate - PaGlobal_GuildAllianceInvite_All._taxRate[index])
  maxLimitRate = toInt64(0, maxLimitRate)
  Panel_NumberPad_Close()
  Panel_NumberPad_Show(true, maxLimitRate, 0, PaGlobalFunc_GuildAllianceInvite_All_UpdateTaxRate)
end
function FromClient_GuildAllianceInvite_All_DoneAlliance(index, guildName)
  PaGlobal_GuildAllianceInvite_All._isInvite = true
  if __eCreateGuildAlliance_Create == index then
    PaGlobal_GuildAllianceInvite_All._ui.txt_miniDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDALLIANCEINFO_AGREE_WAITTING_TEXT"))
  elseif __eCreateGuildAlliance_Complete == index or __eCreateGuildAlliance_AcceptJoin == index then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDALLIANCE_ACCEPT_JOIN", "guildName", guildName))
    PaGlobalFunc_GuildMain_All_AllianceOpen()
  elseif __eCreateGuildAlliance_Reject == index then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDALLIANCE_REJECT_JOIN", "guildName", guildName))
    PaGlobalFunc_GuildAllianceInvite_All_ResetInvite()
  else
    PaGlobalFunc_GuildMain_All_AllianceOpen()
  end
end
