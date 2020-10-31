function PaGlobal_ClanList_All_Open()
  PaGlobal_ClanList_All:prepareOpen()
end
function PaGlobal_ClanList_All_Close()
  PaGlobal_ClanList_All:prepareClose()
end
function PaGlobal_ClanList_All_Update()
  PaGlobal_ClanList_All:listUpdate()
end
function PaGlobal_ClanList_All_ShowAni()
  local aniInfo1 = Panel_Window_ClanList_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.12)
  aniInfo1.AxisX = Panel_Window_ClanList_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_ClanList_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_ClanList_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.12)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_ClanList_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_ClanList_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobal_ClanList_All_HideAni()
  local aniInfo1 = Panel_Window_ClanList_All:addColorAnimation(0, 0.1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function PaGlobal_ClanList_All_SwapFamilyOrCharacterName()
  if nil == Panel_Window_ClanList_All then
    return
  end
  PaGlobal_ClanList_All._showFamilyName = not PaGlobal_ClanList_All._showFamilyName
  PaGlobal_ClanList_All_Update()
end
function HandleEventLUp_ClanList_All_MemberMenu(memberIdx)
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local memberData = myGuildInfo:getMember(memberIdx)
  if nil == memberData then
    return
  end
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  if false == isGuildMaster and false == isGuildSubMaster then
    PaGlobal_ClanList_All._ui.stc_menuBG:SetShow(false)
    return
  end
  PaGlobal_ClanList_All._selectedMemberIdx = memberIdx
  if true == PaGlobal_ClanList_All._isConsole then
    local uiPool = PaGlobal_ClanList_All._listPool[memberIdx]
    if nil == uiPool then
      PaGlobal_ClanList_All._ui.stc_menuBG:SetShow(false)
      return
    end
    PaGlobal_ClanList_All._ui.stc_menuBG:SetPosX(Panel_Window_ClanList_All:GetSizeX())
    PaGlobal_ClanList_All._ui.stc_menuBG:SetPosY(PaGlobal_ClanList_All._ui.frame_clanList:GetPosY() + uiPool.memberBG:GetPosY())
  else
    PaGlobal_ClanList_All._ui.stc_menuBG:SetPosX(getMousePosX() - Panel_Window_ClanList_All:GetPosX())
    PaGlobal_ClanList_All._ui.stc_menuBG:SetPosY(getMousePosY() - Panel_Window_ClanList_All:GetPosY())
  end
  PaGlobal_ClanList_All._ui.stc_menuBG:SetShow(true)
  PaGlobal_ClanList_All._ui.btn_setSubMaster:SetShow(false)
  PaGlobal_ClanList_All._ui.btn_kickClan:SetShow(false)
  PaGlobal_ClanList_All._ui.btn_unsetSubMaster:SetShow(false)
  local grade = memberData:getGrade()
  if true == isGuildMaster then
    if __eGuildMemberGradeMaster == grade then
      PaGlobal_ClanList_All._ui.stc_menuBG:SetShow(false)
    elseif __eGuildMemberGradeSubMaster == grade then
      PaGlobal_ClanList_All._ui.btn_unsetSubMaster:SetShow(true)
      PaGlobal_ClanList_All._ui.btn_kickClan:SetShow(true)
      PaGlobal_ClanList_All:setButtonPos(2)
    elseif __eGuildMemberGradeNormal == grade then
      PaGlobal_ClanList_All._ui.btn_setSubMaster:SetShow(true)
      PaGlobal_ClanList_All._ui.btn_kickClan:SetShow(true)
      PaGlobal_ClanList_All:setButtonPos(2)
    else
      PaGlobal_ClanList_All._ui.btn_kickClan:SetShow(true)
      PaGlobal_ClanList_All:setButtonPos(1)
    end
  elseif true == isGuildSubMaster then
    if __eGuildMemberGradeNormal == grade or __eGuildMemberGradeJunior == grade then
      PaGlobal_ClanList_All._ui.btn_kickClan:SetShow(true)
      PaGlobal_ClanList_All:setButtonPos(1)
    else
      PaGlobal_ClanList_All._ui.stc_menuBG:SetShow(false)
    end
  end
end
function HandleEventOut_ClanList_All_MouseOutClanMenu()
  local sizeX = PaGlobal_ClanList_All._ui.stc_menuBG:GetSizeX()
  local sizeY = PaGlobal_ClanList_All._ui.stc_menuBG:GetSizeY()
  local posX = PaGlobal_ClanList_All._ui.stc_menuBG:GetPosX()
  local posY = PaGlobal_ClanList_All._ui.stc_menuBG:GetPosY()
  local mousePosX = getMousePosX() - Panel_Window_ClanList_All:GetPosX()
  local mousePosY = getMousePosY() - Panel_Window_ClanList_All:GetPosY()
  if posX <= mousePosX and mousePosX <= posX + sizeX and posY <= mousePosY and mousePosY <= posY + sizeY then
  else
    PaGlobal_ClanList_All._ui.stc_menuBG:SetShow(false)
  end
end
function HandleEventLUp_ClanList_All_SetSubMaster()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local memberIdx = PaGlobal_ClanList_All._selectedMemberIdx
  local memberData = myGuildInfo:getMember(memberIdx)
  if nil == memberData then
    return
  end
  local SetSubMasterDo = function()
    ToClient_RequestChangeGuildMemberGrade(PaGlobal_ClanList_All._selectedMemberIdx, 1)
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_GUILDSUBMASTER"),
    content = "'" .. memberData:getName() .. "'" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_GUILDSUBMASTER_QUESTION"),
    functionYes = SetSubMasterDo,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
  PaGlobal_ClanList_All._ui.stc_menuBG:SetShow(false)
end
function HandleEventLUp_ClanList_All_KickClan()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local memberIdx = PaGlobal_ClanList_All._selectedMemberIdx
  local memberData = myGuildInfo:getMember(memberIdx)
  if nil == memberData then
    return
  end
  PaGlobal_ClanList_All._selectedMemberUserNo = memberData:getUserNo()
  local KickClanDo = function()
    ToClient_RequestExpelMemberFromGuild(PaGlobal_ClanList_All._selectedMemberIdx, PaGlobal_ClanList_All._selectedMemberUserNo)
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_EXPEL_CLANMEMBER"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CLAN_TEXT_EXPEL_CLANMEMBER_QUESTION", "name", memberData:getName()),
    functionYes = KickClanDo,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
  PaGlobal_ClanList_All._ui.stc_menuBG:SetShow(false)
end
function HandleEventLUp_ClanList_All_UnsetSubMaster()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local memberIdx = PaGlobal_ClanList_All._selectedMemberIdx
  local memberData = myGuildInfo:getMember(memberIdx)
  if nil == memberData then
    return
  end
  local UnsetSubMasterDo = function()
    ToClient_RequestChangeGuildMemberGrade(PaGlobal_ClanList_All._selectedMemberIdx, 2)
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_CLAN_TEXT_DEMOTE_CLANMEMBER_TITLE"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CLAN_TEXT_DEMOTE_CLANMEMBER_QUESTION", "name", memberData:getName()),
    functionYes = UnsetSubMasterDo,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
  PaGlobal_ClanList_All._ui.stc_menuBG:SetShow(false)
end
function HandleEventLUp_ClanList_All_LeaveClan()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    _PA_ASSERT(false, "ResponseGuildInviteForGuildGrade \236\151\144\236\132\156 \234\184\184\235\147\156 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
    return
  end
  local DestroyClan = function()
    PaGlobal_ClanList_All_Close()
    ToClient_RequestDestroyGuild()
  end
  local DisJoinClan = function()
    PaGlobal_ClanList_All_Close()
    ToClient_RequestDisjoinGuild()
  end
  if true == getSelfPlayer():get():isGuildMaster() then
    if ToClient_GetMyGuildInfoWrapper():getMemberCount() <= 1 then
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DISPERSE_CLAN"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DISPERSE_CLAN_ASK"),
        functionYes = DestroyClan,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_CANT_CLAN_DISPERSE"))
    end
  else
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WITHDRAW_CLAN"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CLANLIST_CLANOUT_ASK"),
      functionYes = DisJoinClan,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function HandleEventPadX_ClanList_All_ShowXBOXProfile(index)
  if nil == Panel_Window_ClanList_All then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    PaGlobal_ClanList_All_Close()
    return
  end
  local memberInfo = myGuildInfo:getMember(index)
  if nil == memberInfo then
    return
  end
  if false == memberInfo:isOnline() then
    return
  end
  if getSelfPlayer():get():getUserNo() == memberInfo:getUserNo() then
    return
  end
  local isShow = ToClient_showXboxProfile(memberInfo:getUserNo())
  if false == isShow then
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_CANNOTSHOWXBOXPROFILE", "GuildMember", memberInfo:getName()),
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function HandleEventOn_ClanList_All_ShowTooltipAndKeyGuide(index, isSelf, samePlatform, isOnline)
  if nil == Panel_Window_ClanList_All then
    return
  end
  local list = PaGlobal_ClanList_All._listPool[index]
  if nil ~= list and true == list.memberName:IsLimitText() then
    PaGlobal_ClanList_All._currentPadOnIndex = index
    PaGlobal_ClanList_All._ui.stc_tooltipBG:SetShow(true)
    PaGlobal_ClanList_All:refreshTooltip(index)
  end
  if true == isOnline then
    PaGlobal_ClanList_All._ui.btn_keyGuideX:SetShow(false == isSelf and false == ToClient_isPS4() and true == samePlatform)
  else
    PaGlobal_ClanList_All._ui.btn_keyGuideX:SetShow(false)
  end
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  PaGlobal_ClanList_All._ui.btn_keyGuideA:SetShow(isGuildMaster or isGuildSubMaster)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_ClanList_All._keyGuides, PaGlobal_ClanList_All._ui.stc_bottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function HandleEventOut_ClanList_All_HideTooltip(isShow)
  if nil == Panel_Window_ClanList_All then
    return
  end
  PaGlobal_ClanList_All._ui.stc_tooltipBG:SetShow(false)
end
function HandleEventOn_ClanList_All_DefaultKeyGuide()
  PaGlobal_ClanList_All._ui.btn_keyGuideX:SetShow(false)
  PaGlobal_ClanList_All._ui.btn_keyGuideA:SetShow(true)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_ClanList_All._keyGuides, PaGlobal_ClanList_All._ui.stc_bottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function FromClient_ClanList_All_OnScreenResize()
  local scrSizeX = getOriginScreenSizeX()
  local scrSizeY = getOriginScreenSizeY()
  local panelSizeX = Panel_Window_ClanList_All:GetSizeX()
  local panelSizeY = Panel_Window_ClanList_All:GetSizeY()
  Panel_Window_ClanList_All:SetPosX((scrSizeX - panelSizeX) * 0.5)
  Panel_Window_ClanList_All:SetPosY((scrSizeY - panelSizeY) * 0.5)
end
