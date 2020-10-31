function PaGlobalFunc_GuildAlliance_All_Update()
  PaGlobal_GuildAlliance_All:update()
end
function FromClient_GuildAlliance_All_List2Update(content, key)
  PaGlobal_GuildAlliance_All:list2Update(content, key)
end
function FromClient_GuildAlliance_All_InfoChanged()
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._ALLIANCE) then
    return
  end
  PaGlobal_GuildAlliance_All:update()
end
function FromClient_GuildAlliance_All_DisbandAlliance()
  PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_MESSAGE_DISBAND_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_MESSAGE_DISBAND_DONE"), nil, nil, MessageBox_Empty_function, nil)
  if true == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._ALLIANCE) then
    PaGlobalFunc_GuildAllianceInvite_All_ResetInvite()
  end
end
function FromClient_GuildAlliance_All_NoticeChanged()
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._ALLIANCE) then
    return
  end
  PaGlobal_GuildAlliance_All:updateNotice()
end
function HandleEventLUp_GuildAlliance_All_DisbandAlliance()
  local ConfirmDisband = function()
    ToClient_RequestDestroyGuildAlliance()
  end
  PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_MESSAGE_DISBAND_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_MESSAGE_DISBAND_INFO"), ConfirmDisband, MessageBox_Empty_function, nil, nil)
end
function HandleEventLUp_GuildAlliance_All_MarkChange()
  local selfPlayer = getSelfPlayer()
  local isChairman = selfPlayer:get():isGuildAllianceChair()
  if false == isChairman then
    return
  end
  local SaveConfirm = function()
    guildMarkUpdate(true)
    ClearFocusEdit()
  end
  PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCE_ADDMARK_MESSAGEBOX_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCE_ADDMARK_MESSAGEBOX_TEXT"), SaveConfirm, MessageBox_Empty_function, nil, nil)
end
function HandleEventLUp_GuildAlliance_All_ResetNotice()
  local selfPlayer = getSelfPlayer()
  local isChairman = selfPlayer:get():isGuildAllianceChair()
  if false == isChairman then
    return
  end
  ToClient_SetGuildAllianceNotice("")
  PaGlobal_GuildAlliance_All._ui.edit_Notice:SetEditText("")
end
function HandleEventLUp_GuildAlliance_All_SetEditText()
  local selfPlayer = getSelfPlayer()
  local isChairman = selfPlayer:get():isGuildAllianceChair()
  if false == isChairman then
    return
  end
  SetFocusEdit(PaGlobal_GuildAlliance_All._ui.edit_Notice)
  PaGlobal_GuildAlliance_All._ui.edit_Notice:SetEditText(PaGlobal_GuildAlliance_All._ui.edit_Notice:GetEditText(), true)
end
function HandleEventLUp_GuildAlliance_All_SaveNotice()
  local selfPlayer = getSelfPlayer()
  local isChairman = selfPlayer:get():isGuildAllianceChair()
  if false == isChairman then
    return
  end
  ToClient_SetGuildAllianceNotice(PaGlobal_GuildAlliance_All._ui.edit_Notice:GetEditText())
  ClearFocusEdit()
end
function PaGlobalFunc_GuildAlliance_All_EndVirtualKeyboard(str)
  PaGlobal_GuildAlliance_All._ui.edit_Notice:SetEditText(str)
  ClearFocusEdit()
end
function HandleEventOnOut_GuildAlliance_All_Tooltip(tipType)
  if nil == tipType then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDALLIANCEMARK_BTN_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDALLIANCEMARK_BTN_TOOLTIP_DESC")
    control = PaGlobal_GuildAlliance_All._ui.btn_Mark
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_MESSAGE_DISBAND_TITLE")
    control = PaGlobal_GuildAlliance_All._ui.btn_Exit
  end
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
