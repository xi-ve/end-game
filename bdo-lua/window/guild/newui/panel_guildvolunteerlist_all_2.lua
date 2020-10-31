function PaGlobalFunc_GuildVolunteerList_All_Open()
  PaGlobal_GuildVolunteerList_All:prepareOpen()
end
function PaGlobalFunc_GuildVolunteerList_All_Close()
  PaGlobal_GuildVolunteerList_All:prepareClose()
end
function FromClient_GuildVolunteerList_All_ResponseGuildUpdate()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MARCENARY) then
    return
  end
  PaGlobal_GuildVolunteerList_All:update()
  if nil == PaGlobal_GuildVolunteerList_All._ui.btn_hire then
    return
  end
  if nil ~= getSelfPlayer() then
    PaGlobal_GuildVolunteerList_All._isGuildMaster = getSelfPlayer():get():isGuildMaster()
    PaGlobal_GuildVolunteerList_All._isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
    if true == PaGlobal_GuildVolunteerList_All._isGuildMaster or true == PaGlobal_GuildVolunteerList_All._isGuildSubMaster then
      PaGlobal_GuildVolunteerList_All._ui.btn_hire:SetShow(true)
    else
      PaGlobal_GuildVolunteerList_All._ui.btn_hire:SetShow(false)
    end
  else
    PaGlobal_GuildVolunteerList_All._ui.btn_hire:SetShow(false)
  end
end
function HandleEventScroll_GuildVolunteerList_All_Scroll(isUp)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MARCENARY) then
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  local volunteerCount = guildWrapper:getVolunteerMemberCount()
  UIScroll.ScrollEvent(PaGlobal_GuildVolunteerList_All._ui.frame_vScroll, isUp, volunteerCount, volunteerCount, 0, 1)
  PaGlobal_GuildVolunteerList_All:update()
end
function HandleEventOnOut_GuildVolunteerList_All_TitleTooltip(isShow, titleType)
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MARCENARY) then
    return
  end
  local control, name, desc
  local control = PaGlobal_GuildVolunteerList_All._ui._titleList[titleType]
  if PaGlobal_GuildVolunteerList_All._SortType.APOINT == titleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_ACTIVITY_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_ACTIVITY_CONTENTS")
  elseif PaGlobal_GuildVolunteerList_All._SortType.CONTACT == titleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_CONTRACT_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_CONTRACT_CONTENTS")
  elseif PaGlobal_GuildVolunteerList_All._SortType.WPOINT == titleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_CONTRIBUTEDTENDENCY_TOOLTIP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_CONTRIBUTEDTENDENCY_TOOLTIP_DESC")
  elseif PaGlobal_GuildVolunteerList_All._SortType.VOICE == titleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_VOICECHAT_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_VOICECHAT_TOOLTIP_DESC")
  elseif PaGlobal_GuildVolunteerList_All._SortType.WGRADE == titleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_SIEGEGRADE_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_SIEGEGRADE_TOOLTIP_DESC")
  end
  if nil == control or nil == name or nil == desc then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleOnOut_GuildVolunteerList_All_GradeTooltip(isShow, index)
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MARCENARY) then
    return
  end
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_VOLUNTEER_LIST_GRADE_ICON_TOOLTIP")
  control = PaGlobal_GuildVolunteerList_All._ui._volunteerList[index]._grade
  TooltipSimple_Show(control, name, desc)
end
function HandleOnOut_GuildVolunteerList_All_ContractTooltipShow(isShow, index)
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MARCENARY) then
    return
  end
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_VOLUNTEER_LIST_CONTRACT_BUTTON_TOOLTIP_TITLE")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_VOLUNTEER_LIST_CONTRACT_BUTTON_TOOLTIP_DESC")
  control = PaGlobal_GuildVolunteerList_All._ui._volunteerList[index]._contractBtn
  TooltipSimple_Show(control, name, desc)
end
function HandleClicked_GuildVolunteerList_All_Recruite()
  if true == _ContentsGroup_NewUI_Guild_All then
    PaGlobalFunc_Guild_RegistSolider_All_Open()
  else
    PaGlobalFunc_GuildRegistSoldier_Open()
  end
end
function HandleClicked_GuildVolunteerList_All_ContractButton(isSelf, index)
  FGlobal_AgreementVolunteer_ListContract_Open(isSelf, index + 1)
end
function HandleClicked_GuildVolunteerList_All_Menu(index)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MARCENARY) then
    return
  end
  local volunteerMember = ToClient_GetMyGuildInfoWrapper():getVolunteerMember(index)
  local buttonPosY = 5
  PaGlobal_GuildVolunteerList_All._curClickVolunteerIdx = -1
  if true == PaGlobal_GuildVolunteerList_All._ui_pc.stc_funcBg:GetShow() then
    PaGlobal_GuildVolunteerList_All._ui_pc.stc_funcBg:SetShow(false)
    return
  end
  local charName = UI.getChildControl(PaGlobal_GuildVolunteerList_All._ui.stc_listContent, "StaticText_C_CharName")
  if true == volunteerMember:isOnline() and false == volunteerMember:isGhostMode() then
    local buttonListBgX = PaGlobal_GuildVolunteerList_All._ui._volunteerList[index]._charName:GetPosX() + PaGlobal_GuildVolunteerList_All._ui._volunteerList[index]._charName:GetSizeX() / 2 - PaGlobal_GuildVolunteerList_All._ui_pc.stc_funcBg:GetSizeX() / 2
    local buttonLsitBgY = getMousePosY() - PaGlobal_GuildVolunteerList_All._ui_pc.stc_funcBg:GetSizeY() - Panel_GuildVolunteerList_All:GetPosY() + 10
    PaGlobal_GuildVolunteerList_All._ui_pc.stc_funcBg:SetPosX(buttonListBgX)
    PaGlobal_GuildVolunteerList_All._ui_pc.stc_funcBg:SetPosY(buttonLsitBgY)
    PaGlobal_GuildVolunteerList_All._ui_pc.stc_funcBg:SetShow(true)
    PaGlobal_GuildVolunteerList_All._curClickVolunteerIdx = index
  end
end
function HandleClicked_GuildVolunteerList_All_ActivityButton()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MARCENARY) then
    return
  end
  if -1 == PaGlobal_GuildVolunteerList_All._curClickVolunteerIdx then
    return
  end
  PaGlobal_GuildVolunteerList_All._ui_pc.stc_funcBg:SetShow(false)
  if true == _ContentsGroup_NewUI_Guild_All then
    PaGlobalFunc_GuildUseFund_All_ShowToggle(PaGlobal_GuildVolunteerList_All._curClickVolunteerIdx, true, true)
  else
    PaGlobal_Guild_UseGuildFunds:ShowToggle(PaGlobal_GuildVolunteerList_All._curClickVolunteerIdx, true, true)
  end
end
