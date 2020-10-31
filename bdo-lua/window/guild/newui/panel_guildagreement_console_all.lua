PaGlobal_GuildAgreement_Console_All = {
  _ui = {
    _txt_Title = nil,
    _stc_Frame = nil,
    _stc_FrameContent = nil,
    _stc_FrameScroll = nil,
    _txt_Desc = nil,
    _stc_Sign = nil,
    _stc_BottomBg = nil,
    _txt_Period = nil,
    _txt_DailySalary = nil,
    _txt_PenaltyFee = nil,
    _txt_Employer = nil,
    _txt_Contractor = nil,
    _stc_KeyguideBG = nil,
    _stc_Keyguide_A = nil,
    _stc_Keyguide_Y = nil,
    _stc_Keyguide_B = nil
  },
  _isJoin = false,
  _isRecieved = false,
  _initialize = false,
  _sendContractPeriod = -1,
  _sendDailyPayment = -1,
  _sendPenaltyCost = -1,
  _memberInfo = {
    _memberIdx = -1,
    _memberBenefit = nil,
    _memberPenalty = nil,
    _usableActivity = nil
  },
  _s64_guildNo = nil
}
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildAgreement_Console_All_Init")
function FromClient_GuildAgreement_Console_All_Init()
  PaGlobal_GuildAgreement_Console_All:initialize()
end
function PaGlobal_GuildAgreement_Console_All:initialize()
  if nil == Panel_GuildAgreement_Console_All or true == self._initialize then
    return
  end
  local titleBg = UI.getChildControl(Panel_GuildAgreement_Console_All, "Static_TopBg")
  self._ui._txt_Title = UI.getChildControl(titleBg, "StaticText_TitleIcon")
  self._ui._stc_Frame = UI.getChildControl(Panel_GuildAgreement_Console_All, "Frame_Detail")
  self._ui._stc_FrameContent = UI.getChildControl(self._ui._stc_Frame, "Frame_1_Content")
  self._ui._stc_FrameScroll = UI.getChildControl(self._ui._stc_Frame, "Frame_1_VerticalScroll")
  self._ui._txt_Desc = UI.getChildControl(self._ui._stc_FrameContent, "StaticText_Content")
  self._ui._stc_Sign = UI.getChildControl(self._ui._stc_FrameContent, "Static_Sign")
  self._ui._stc_BottomBg = UI.getChildControl(Panel_GuildAgreement_Console_All, "Static_ConstractInfoBg")
  self._ui._txt_Period = UI.getChildControl(self._ui._stc_BottomBg, "StaticText_PeriodValue")
  self._ui._txt_DailySalary = UI.getChildControl(self._ui._stc_BottomBg, "StaticText_DailyPaymentValue")
  self._ui._txt_PenaltyFee = UI.getChildControl(self._ui._stc_BottomBg, "StaticText_PenaltyCostValue")
  self._ui._txt_Employer = UI.getChildControl(self._ui._stc_BottomBg, "StaticText_FromValue")
  self._ui._txt_Contractor = UI.getChildControl(self._ui._stc_BottomBg, "StaticText_ToValue")
  self._ui._stc_KeyguideBG = UI.getChildControl(Panel_GuildAgreement_Console_All, "Static_BottomBg")
  self._ui._stc_Keyguide_A = UI.getChildControl(self._ui._stc_KeyguideBG, "Button_Confirm")
  self._ui._stc_Keyguide_Y = UI.getChildControl(self._ui._stc_KeyguideBG, "Button_Option")
  self._ui._stc_Keyguide_B = UI.getChildControl(self._ui._stc_KeyguideBG, "Button_Close")
  self._ui._txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_3"))
  self._ui._stc_FrameContent:SetSize(self._ui._stc_FrameContent:GetSizeX(), self._ui._txt_Desc:GetTextSizeY() + 10)
  if self._ui._stc_Frame:GetSizeX() < self._ui._stc_FrameContent:GetSizeY() then
    self._ui._stc_FrameScroll:GetShow(true)
  else
    self._ui._stc_FrameScroll:GetShow(false)
  end
  self._ui._stc_Frame:UpdateContentPos()
  self._ui._stc_Frame:UpdateContentScroll()
  self._ui._stc_FrameScroll:SetControlPos(0)
  self._ui._txt_Employer:SetTextMode(__eTextMode_LimitText)
  self._ui._txt_Contractor:SetTextMode(__eTextMode_LimitText)
  local periodTitle = UI.getChildControl(self._ui._stc_BottomBg, "StaticText_PeriodTitle")
  local paymentTitle = UI.getChildControl(self._ui._stc_BottomBg, "StaticText_DailyPaymentTitle")
  local penaltyTitle = UI.getChildControl(self._ui._stc_BottomBg, "StaticText_PenaltyCostTitle")
  periodTitle:SetTextMode(__eTextMode_LimitText)
  paymentTitle:SetTextMode(__eTextMode_LimitText)
  penaltyTitle:SetTextMode(__eTextMode_LimitText)
  periodTitle:SetText(periodTitle:GetText())
  paymentTitle:SetText(paymentTitle:GetText())
  penaltyTitle:SetText(penaltyTitle:GetText())
  self.keyGuides = {
    self._ui._stc_Keyguide_Y,
    self._ui._stc_Keyguide_A,
    self._ui._stc_Keyguide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self.keyGuides, self._ui._stc_KeyguideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_GuildAgreement_Console_All:registerEvent()
  PaGlobal_GuildAgreement_Console_All:validate()
end
function PaGlobal_GuildAgreement_Console_All:registerEvent()
  Panel_GuildAgreement_Console_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  Panel_GuildAgreement_Console_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
end
function PaGlobal_GuildAgreement_Console_All:dataClear()
  self._memberInfo._memberIdx = -1
  self._memberInfo._memberBenefit = nil
  self._memberInfo._memberPenalty = nil
  self._memberInfo._usableActivity = nil
  self._sendContractPeriod = -1
  self._sendDailyPayment = -1
  self._sendPenaltyCost = -1
  self._isRecieved = false
  self._isJoin = false
  Panel_GuildAgreement_Console_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  Panel_GuildAgreement_Console_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
end
function PaGlobal_GuildAgreement_Console_All:prepareOpen()
  PaGlobal_GuildAgreement_Console_All:open()
end
function PaGlobal_GuildAgreement_Console_All:open()
  Panel_GuildAgreement_Console_All:SetShow(true)
end
function PaGlobal_GuildAgreement_Console_All:alignKeyGuide()
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self.keyGuides, self._ui._stc_KeyguideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_GuildAgreement_Console_All:prepareClose()
  if true == self._isRecieved then
    PaGlobalFunc_GuildAgreement_All_InviteRefuse()
  end
  PaGlobal_GuildAgreement_Console_All:close()
end
function PaGlobal_GuildAgreement_Console_All:close()
  Panel_GuildAgreement_Console_All:SetShow(false)
end
function PaGlobal_GuildAgreement_Console_All:validate()
  self._ui._stc_Frame:isValidate()
  self._ui._stc_FrameContent:isValidate()
  self._ui._stc_FrameScroll:isValidate()
  self._ui._txt_Desc:isValidate()
  self._ui._stc_Sign:isValidate()
  self._ui._stc_BottomBg:isValidate()
  self._ui._txt_Period:isValidate()
  self._ui._txt_DailySalary:isValidate()
  self._ui._txt_PenaltyFee:isValidate()
  self._ui._txt_Employer:isValidate()
  self._ui._txt_Contractor:isValidate()
  self._ui._stc_KeyguideBG:isValidate()
  self._ui._stc_Keyguide_A:isValidate()
  self._ui._stc_Keyguide_Y:isValidate()
  self._ui._stc_Keyguide_B:isValidate()
end
function PaGlobalFunc_AgreementGuild_Master_ContractOpen(memberIdx, requesterMemberGrade, usaAbleActivity)
  if nil == Panel_GuildAgreement_Console_All then
    return
  end
  PaGlobal_GuildAgreement_Console_All:dataClear()
  PaGlobal_GuildAgreement_Console_All._isJoin = false
  local myguildwrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == myguildwrapper then
    return
  end
  local memberinfo = myguildwrapper:getMember(memberIdx)
  if nil == memberinfo then
    _PA_ASSERT(false, "PaGlobalFunc_AgreementGuild_Master_ContractOpen \236\157\152 \235\169\164\235\178\132\236\157\184\235\141\177\236\138\164\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164 " .. tostring(memberIdx))
    return
  end
  PaGlobal_GuildAgreement_Console_All._memberInfo._memberIdx = memberIdx
  if 10000 < usaAbleActivity then
    usaAbleActivity = 10000
  end
  PaGlobal_GuildAgreement_Console_All._memberInfo._usableActivity = usaAbleActivity
  PaGlobal_GuildAgreement_Console_All._ui._txt_Employer:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_GUILDHOUSECONTROL_OWNGUILD_MASTER_TITLE"))
  local name = memberinfo:getName()
  PaGlobal_GuildAgreement_Console_All._ui._txt_Contractor:SetText(name)
  local benefit = memberinfo:getContractedBenefit()
  local penalty = memberinfo:getContractedPenalty()
  PaGlobal_GuildAgreement_Console_All._memberInfo._memberBenefit = benefit
  PaGlobal_GuildAgreement_Console_All._memberInfo._memberPenalty = penalty
  PaGlobal_GuildAgreement_Console_All._ui._txt_DailySalary:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_MASTER_MONEY", "money", makeDotMoney(benefit)))
  PaGlobal_GuildAgreement_Console_All._ui._txt_PenaltyFee:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_MASTER_MONEY", "money", makeDotMoney(penalty)))
  local periodText = ""
  local expiration = memberinfo:getContractedExpirationUtc()
  local leftTime = getLeftSecond_TTime64(expiration)
  if leftTime > toInt64(0, 0) then
    periodText = convertStringFromDatetime(leftTime)
  else
    periodText = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_MASTER_REMAINPERIOD")
  end
  PaGlobal_GuildAgreement_Console_All._ui._txt_Period:SetText(periodText)
  local contractAble = memberinfo:getContractableUtc()
  local contractAbleTo = false
  local isRenew = false
  if 0 == requesterMemberGrade then
    if toInt64(0, 0) >= getLeftSecond_TTime64(contractAble) then
      isRenew = true
    end
  elseif 1 == requesterMemberGrade then
    if toInt64(0, 0) >= getLeftSecond_TTime64(contractAble) then
      contractAbleTo = true
    end
    isRenew = (2 == memberinfo:getGrade() or 5 == memberinfo:getGrade()) and contractAbleTo
  end
  PaGlobal_GuildAgreement_Console_All._ui._stc_Keyguide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_AGREEMENTGUILDMASTER_BTN_PERIOD_RENEW"))
  PaGlobal_GuildAgreement_Console_All._ui._stc_Keyguide_A:SetShow(isRenew)
  PaGlobal_GuildAgreement_Console_All._ui._stc_Keyguide_Y:SetShow(isRenew)
  PaGlobal_GuildAgreement_Console_All:alignKeyGuide()
  if true == isRenew then
    Panel_GuildAgreement_Console_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_GuildAgreement_All_SendReContract()")
    Panel_GuildAgreement_Console_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_GuildAgreement_Option_All_Open()")
  end
  PaGlobal_GuildAgreement_Console_All._ui._txt_Title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_MASTER_CONTRACT", "guildName", myguildwrapper:getName()))
  PaGlobal_GuildAgreement_Console_All:prepareOpen()
end
function PaGlobalFunc_GuildAgreement_All_SendReContract()
  if nil == PaGlobal_GuildAgreement_Console_All._memberInfo._memberIdx or PaGlobal_GuildAgreement_Console_All._memberInfo._memberIdx < 0 then
    return
  end
  if 0 > PaGlobal_GuildAgreement_Console_All._sendContractPeriod or 0 > PaGlobal_GuildAgreement_Console_All._sendDailyPayment or 0 > PaGlobal_GuildAgreement_Console_All._sendPenaltyCost then
    return
  end
  ToClient_SuggestGuildContract(PaGlobal_GuildAgreement_Console_All._memberInfo._memberIdx, tonumber(PaGlobal_GuildAgreement_Console_All._sendContractPeriod), tonumber(PaGlobal_GuildAgreement_Console_All._sendDailyPayment), tonumber(PaGlobal_GuildAgreement_Console_All._sendPenaltyCost))
  PaGlobal_GuildAgreement_Console_All:prepareClose()
end
function PaGlobal_AgreementGuild_InviteOpen(isJoin, hostUserName, hostName, guildName, period, benefit, penalty, s64_guildNo)
  PaGlobal_GuildAgreement_Console_All:dataClear()
  local selfPlayer = getSelfPlayer()
  if selfPlayer:get():isGuildMaster() then
    return
  end
  if nil == s64_guildNo then
    return
  end
  PaGlobal_GuildAgreement_Console_All._isRecieved = true
  PaGlobal_GuildAgreement_Console_All._isJoin = isJoin
  PaGlobal_GuildAgreement_Console_All._ui._txt_Title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_MASTER_CONTRACT", "guildName", guildName))
  PaGlobal_GuildAgreement_Console_All._ui._txt_Period:SetText(period .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY"))
  PaGlobal_GuildAgreement_Console_All._ui._txt_DailySalary:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_MASTER_MONEY", "money", makeDotMoney(benefit)))
  PaGlobal_GuildAgreement_Console_All._ui._txt_PenaltyFee:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_MASTER_MONEY", "money", makeDotMoney(penalty)))
  PaGlobal_GuildAgreement_Console_All._ui._txt_Employer:SetText(hostUserName .. "(" .. hostName .. ")")
  PaGlobal_GuildAgreement_Console_All._ui._txt_Contractor:SetText(selfPlayer:getUserNickname())
  PaGlobal_GuildAgreement_Console_All._ui._stc_Keyguide_A:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDAGREEMENT_CONTRACT"))
  PaGlobal_GuildAgreement_Console_All._ui._stc_Keyguide_Y:SetShow(false)
  PaGlobal_GuildAgreement_Console_All:alignKeyGuide()
  Panel_GuildAgreement_Console_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_GuildAgreement_All_Confirm()")
  PaGlobal_GuildAgreement_Console_All:prepareOpen()
end
function PaGlobalFunc_AgreementGuild_Open_ForJoin(targetKeyRaw, targetName, preGuildActivity)
  if nil == targetKeyRaw then
    return
  end
  local myguildwrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == myguildwrapper then
    return
  end
  PaGlobal_GuildAgreement_Console_All._isJoin = true
  PaGlobal_GuildAgreement_Console_All._ui._txt_Contractor:SetText(targetName)
  PaGlobal_GuildAgreement_Console_All._ui._txt_Employer:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_GUILDHOUSECONTROL_OWNGUILD_MASTER_TITLE"))
  local guildName = myguildwrapper:getName()
  PaGlobal_GuildAgreement_Console_All._ui._txt_Title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_MASTER_CONTRACT", "guildName", guildName))
  PaGlobal_GuildAgreement_Console_All._ui._stc_Keyguide_A:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDAGREEMENT_CONTRACT"))
  PaGlobal_GuildAgreement_Console_All._ui._stc_Keyguide_A:SetShow(true)
  PaGlobal_GuildAgreement_Console_All._ui._stc_Keyguide_Y:SetShow(true)
  PaGlobal_GuildAgreement_Console_All:alignKeyGuide()
  Panel_GuildAgreement_Console_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_GuildAgreement_All_SendInvite(" .. targetName .. ")")
  Panel_GuildAgreement_Console_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_GuildAgreement_Option_All_Open()")
  PaGlobalFunc_GuildAgreement_Option_All_Open()
  PaGlobalFunc_GuildAgreement_Option_All_ContractDateSet(4)
  PaGlobalFunc_GuildAgreement_Option_All_Confirm()
  PaGlobal_GuildAgreement_Console_All:prepareOpen()
end
function PaGlobalFunc_GuildAgreement_All_SendInvite()
  if 0 > PaGlobal_GuildAgreement_Console_All._sendContractPeriod or 0 > PaGlobal_GuildAgreement_Console_All._sendDailyPayment or 0 > PaGlobal_GuildAgreement_Console_All._sendPenaltyCost then
    return
  end
  toClient_RequestInviteGuild(PaGlobal_GuildAgreement_Console_All._ui._txt_Contractor:GetText(), tonumber(PaGlobal_GuildAgreement_Console_All._sendContractPeriod), tonumber(PaGlobal_GuildAgreement_Console_All._sendDailyPayment), tonumber(PaGlobal_GuildAgreement_Console_All._sendPenaltyCost))
  PaGlobal_GuildAgreement_Console_All_Close()
end
function PaGlobal_GuildAgreement_Console_All_Close()
  if false == Panel_GuildAgreement_Console_All:GetShow() then
    return
  end
  PaGlobal_GuildAgreement_Console_All:prepareClose()
end
function PaGlobalFunc_GuildAgreement_All_Confirm()
  if Defines.UIMode.eUIMode_Default ~= GetUIMode() then
    return
  end
  local inputName = getSelfPlayer():getUserNickname()
  if PaGlobal_GuildAgreement_Console_All._isJoin then
    ToClient_RequestAcceptGuildInvite()
  else
    ToClient_RenewGuildContract(true)
  end
  PaGlobal_GuildAgreement_Console_All._isRecieved = false
  PaGlobal_GuildAgreement_Console_All:prepareClose()
end
function PaGlobalFunc_GuildAgreement_All_InviteRefuse()
  if Defines.UIMode.eUIMode_Default ~= GetUIMode() then
    return
  end
  if PaGlobal_GuildAgreement_Console_All._isJoin then
    ToClient_RequestRefuseGuildInvite()
  else
    ToClient_RenewGuildContract(false)
  end
end
function PaGlobalFunc_GuildAgreement_All_GetIsJoin()
  return PaGlobal_GuildAgreement_Console_All._isJoin
end
function PaGlobalFunc_GuildAgreement_All_GetMemberData()
  return PaGlobal_GuildAgreement_Console_All._memberInfo._usableActivity, PaGlobal_GuildAgreement_Console_All._memberInfo._memberBenefit, PaGlobal_GuildAgreement_Console_All._memberInfo._memberPenalty
end
function PaGlobalFunc_GuildAgreement_All_ContractOptionConfirm(period, payment, penalty)
  if nil == period or nil == payment or nil == penalty then
    return
  end
  PaGlobal_GuildAgreement_Console_All._sendContractPeriod = period
  PaGlobal_GuildAgreement_Console_All._sendDailyPayment = payment
  PaGlobal_GuildAgreement_Console_All._sendPenaltyCost = penalty
  PaGlobal_GuildAgreement_Console_All._ui._txt_Period:SetText(period .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY"))
  PaGlobal_GuildAgreement_Console_All._ui._txt_DailySalary:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_MASTER_MONEY", "money", makeDotMoney(payment)))
  PaGlobal_GuildAgreement_Console_All._ui._txt_PenaltyFee:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_MASTER_MONEY", "money", makeDotMoney(penalty)))
end
