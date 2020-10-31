function PaGlobalFunc_GuildFunctionPanel_All_OpenByGuildInfo()
  PaGlobal_GuildFunctionPanel_All._openType = PaGlobal_GuildFunctionPanel_All._eOpenType.INFO
  PaGlobal_GuildFunctionPanel_All:prepareOpen()
end
function PaGlobalFunc_GuildFunctionPanel_All_OpenByGuildMember()
  PaGlobal_GuildFunctionPanel_All._openType = PaGlobal_GuildFunctionPanel_All._eOpenType.LIST
  PaGlobal_GuildFunctionPanel_All:prepareOpen()
end
function PaGlobalFunc_GuildFunctionPanel_All_OpenByAllyInfo()
  PaGlobal_GuildFunctionPanel_All._openType = PaGlobal_GuildFunctionPanel_All._eOpenType.ALLYINFO
  PaGlobal_GuildFunctionPanel_All:prepareOpen()
end
function PaGlobalFunc_GuildFunctionPanel_All_Close()
  PaGlobal_GuildFunctionPanel_All:prepareClose()
end
function HandleEventPadPress_GuildFunctionPanel_All_PressGuildInfoFunc(btnType)
  local eFuncType = PaGlobal_GuildFunctionPanel_All._eFuncType
  if btnType == eFuncType.leaveGuild then
    HandleEventLUp_GuildInfo_All_DismissGuild()
  elseif btnType == eFuncType.disperseGuild then
    HandleEventLUp_GuildInfo_All_DismissGuild()
  elseif btnType == eFuncType.guildMark then
    if true == ToClient_isConsole() then
      PaGlobalFunc_GuildChangeMark_All_Open()
    else
      HandleEventLUp_GuildInfo_All_ChangeGuildMark()
    end
  elseif btnType == eFuncType.guildIntro then
    if false == ToClient_isPS4() then
      PaGlobalFunc_GuildIntroduce_Open()
    else
      PaGlobalFunc_GuildIntro_All_Open()
    end
  elseif btnType == eFuncType.guildNotice then
    HandleEventLUp_GuildInfo_All_SetFocusEdit()
  elseif btnType == eFuncType.declareWar then
    HandleEventLUp_GuildInfo_All_DeclareWar()
  elseif btnType == eFuncType.joinReward then
    HandleEventLUp_GuildMemberList_All_TakeSiegeReward()
  elseif btnType == eFuncType.joinMemberCount then
    HandleEventLUp_GuildInfo_All_IncreaseMember()
  elseif btnType == eFuncType.mandateMaster then
    HandleEventLUp_GuildInfo_All_GuildMasterMandate()
  elseif btnType == eFuncType.guildWareHouse then
    HandleEventLUp_GuildInfo_All_RequestWareHouseOpen()
  elseif btnType == eFuncType.protectionIncrease then
    HandleEventLUp_GuildInfo_All_IncreaseProtectedMember()
  elseif btnType == eFuncType.payGuildTax then
    HandleEventLUp_GuildInfo_All_TaxPayment()
  elseif btnType == eFuncType.arshaAdminGet then
    HandleEventLUp_GuildInfo_All_RequestArsha()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  PaGlobal_GuildFunctionPanel_All:prepareClose()
end
function HandleEventPadPress_GuildFunctionPanel_All_PressMemberInfoFunc(btnType)
  local eFuncType = PaGlobal_GuildFunctionPanel_All._eFuncType
  if btnType == eFuncType.showInfo then
    if nil ~= PaGlobalFunc_GuildMemberInfo_All_Open then
      PaGlobalFunc_GuildMemberInfo_All_Open()
    elseif nil ~= PaGlobalFunc_GuildMemberInfo_Open then
      PaGlobalFunc_GuildMemberInfo_Open()
    end
  elseif btnType == eFuncType.recvPay then
    HandleEventLUp_GuildMemberList_All_TakeFund()
  elseif btnType == eFuncType.joinReward then
    HandleEventLUp_GuildMemberList_All_TakeSiegeReward()
  elseif btnType == eFuncType.renewAgreement then
    HandlePadEventA_GuildMemberList_All_ContractClick()
  elseif btnType == eFuncType.inviteParty then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.PARTY_INVITE)
  elseif btnType == eFuncType.deportation then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.DEPORTATION)
  elseif btnType == eFuncType.appointCommander then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_COMMANDER)
  elseif btnType == eFuncType.cancelCommander then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.CANCLE_APPOINT)
  elseif btnType == eFuncType.changeMaster then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.CHANGE_MASTER)
  elseif btnType == eFuncType.showContract then
    HandlePadEventA_GuildMemberList_All_ContractClick()
  elseif btnType == eFuncType.clanDeportation then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.DEPORTATION)
  elseif btnType == eFuncType.voiceOption then
    PaGlobalFunc_GuildVoiceSet_All_Open()
  elseif btnType == eFuncType.funding then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.PRICELIMIT)
  elseif btnType == eFuncType.protection then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.PROTECT_MEMBER)
  elseif btnType == eFuncType.cancelProtection then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.CANCLE_PROTECT_MEMBER)
  elseif btnType == eFuncType.participation then
    PaGlobalFunc_GuildMemberList_All_SetRequestParticipateAtSiege()
  elseif btnType == eFuncType.incentive then
    HandleEventLUp_GuildMemberList_All_IncentiveOption()
  elseif btnType == eFuncType.appointSupply then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.SUPPLY)
  elseif btnType == eFuncType.inviteLargeParty then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.LARGEPARTY_INVITE)
  elseif btnType == eFuncType.payGuildTaxAllMember then
    HandleEventLUp_GuildMemberList_All_Deposit()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  PaGlobal_GuildFunctionPanel_All:prepareClose()
end
function HandleEventPadPress_GuildFunctionPanel_All_PressAllyInfoFunc(btnType)
  local eFuncType = PaGlobal_GuildFunctionPanel_All._eFuncType
  if btnType == eFuncType.allyNotice then
    HandleEventLUp_GuildAlliance_All_SetEditText()
  elseif btnType == eFuncType.allyMarkChange then
    if true == ToClient_isConsole() then
      PaGlobalFunc_GuildChangeMark_All_Open()
    else
      HandleEventLUp_GuildAlliance_All_MarkChange()
    end
  elseif btnType == eFuncType.allydisperse then
    HandleEventLUp_GuildAlliance_All_DisbandAlliance()
  elseif btnType == eFuncType.allyNoticeReset then
    HandleEventLUp_GuildAlliance_All_ResetNotice()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  PaGlobal_GuildFunctionPanel_All:prepareClose()
end
