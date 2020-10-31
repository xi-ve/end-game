PaGlobal_GuildAgreement_Option_All = {
  _ui = {
    _stc_optionBg = nil,
    _stc_BottomBg = nil,
    _stc_Keyguide_A = nil,
    _stc_Keyguide_B = nil,
    _stc_Keyguide_Y = nil,
    _txt_DailyPayment = nil,
    _txt_PenaltyCost = nil,
    _txt_DailyPayRange = nil,
    _txt_DailyPenatlyRange = nil
  },
  _periodValue = {
    [0] = 0,
    [1] = 1,
    [2] = 7,
    [3] = 14,
    [4] = 30,
    [5] = 180,
    [6] = 365
  },
  _paymentPerDay = {
    [0] = 0,
    [1] = 1000,
    [2] = 7000,
    [3] = 14000,
    [4] = 30000,
    [5] = 180000,
    [6] = 365000
  },
  _cancellationCharge = {
    [0] = 0,
    [1] = 500,
    [2] = 3500,
    [3] = 7000,
    [4] = 15000,
    [5] = 90000,
    [6] = 182500
  },
  _curContractDayIndex = -1,
  _memberBenefit = nil,
  _memberPenalty = nil,
  _maxBenefitValue = nil,
  _maxpenaltyCostValue = -1,
  _usableActivity = nil,
  _isJoin = false,
  _daybuttonTable = nil,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildAgreement_Option_All_Init")
function FromClient_GuildAgreement_Option_All_Init()
  PaGlobal_GuildAgreement_Option_All:initialize()
end
function PaGlobal_GuildAgreement_Option_All:initialize()
  if nil == Panel_GuildAgreementOption_All or true == self._initialize then
    return
  end
  self._daybuttonTable = Array.new()
  self._ui._stc_optionBg = UI.getChildControl(Panel_GuildAgreementOption_All, "Static_SignContentBg")
  self._ui._txt_DailyPayment = UI.getChildControl(self._ui._stc_optionBg, "Edit_DailyPayment")
  self._ui._txt_PenaltyCost = UI.getChildControl(self._ui._stc_optionBg, "Edit_PenaltyCost")
  self._ui._txt_DailyPayRange = UI.getChildControl(self._ui._stc_optionBg, "StaticText_DailyPaymentRange")
  self._ui._txt_DailyPenatlyRange = UI.getChildControl(self._ui._stc_optionBg, "StaticText_PenaltyRange")
  self._ui._stc_BottomBg = UI.getChildControl(Panel_GuildAgreementOption_All, "Static_BottomBg")
  self._ui._stc_Keyguide_A = UI.getChildControl(self._ui._stc_BottomBg, "StaticText_A_ConsoleUI")
  self._ui._stc_Keyguide_B = UI.getChildControl(self._ui._stc_BottomBg, "StaticText_B_ConsoleUI")
  self._ui._stc_Keyguide_Y = UI.getChildControl(self._ui._stc_BottomBg, "StaticText_Y_ConsoleUI")
  local stringDate = {
    [1] = "1",
    [2] = "7",
    [3] = "15",
    [4] = "30",
    [5] = "90",
    [6] = "365"
  }
  for idx = 1, 6 do
    local control = UI.getChildControl(self._ui._stc_optionBg, "RadioButton_" .. stringDate[idx] .. "D")
    control:SetText(tostring(self._periodValue[idx]) .. PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_LIFETIME"))
    if nil == control then
      _PA_ASSERT(false, "nil == control ")
      break
    end
    self._daybuttonTable:push_back(control)
  end
  local keyGuide = {
    self._ui._stc_Keyguide_Y,
    self._ui._stc_Keyguide_A,
    self._ui._stc_Keyguide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_BottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_GuildAgreement_Option_All:registerEvent()
  PaGlobal_GuildAgreement_Option_All:validate()
end
function PaGlobal_GuildAgreement_Option_All:registerEvent()
  PaGlobal_registerPanelOnBlackBackground(Panel_GuildAgreementOption_All)
  Panel_GuildAgreementOption_All:ignorePadSnapMoveToOtherPanel()
  for idx = 1, #self._daybuttonTable do
    if nil ~= self._daybuttonTable[idx] then
      self._daybuttonTable[idx]:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildAgreement_Option_All_ContractDateSet(" .. idx .. ")")
    end
  end
  self._ui._txt_DailyPayment:addInputEvent("Mouse_LUp", "HandleEventPadClick_GuildAgreement_Option_All_NumPadOpen(true)")
  self._ui._txt_PenaltyCost:addInputEvent("Mouse_LUp", "HandleEventPadClick_GuildAgreement_Option_All_NumPadOpen(false)")
  Panel_GuildAgreementOption_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_GuildAgreement_Option_All_Confirm()")
end
function PaGlobal_GuildAgreement_Option_All:dataClear()
  self._curContractDayIndex = -1
  self._isJoin = nil
  self._memberBenefit = nil
  self._memberPenalty = nil
  self._usableActivity = nil
end
function PaGlobal_GuildAgreement_Option_All:prepareOpen()
  PaGlobal_GuildAgreement_Option_All:dataClear()
  self._isJoin = PaGlobalFunc_GuildAgreement_All_GetIsJoin()
  local usableActivity, beneift, penalty = PaGlobalFunc_GuildAgreement_All_GetMemberData()
  if false == self._isJoin and (nil == usableActivity or nil == beneift or nil == penalty) then
    UI.ASSERT(false, "Contract Data is nil")
    return
  end
  self._memberBenefit = beneift
  self._memberPenalty = penalty
  self._usableActivity = usableActivity
  self._ui._txt_PenaltyCost:SetIgnore(self._isJoin)
  self._ui._txt_DailyPayment:SetIgnore(self._isJoin)
  PaGlobal_GuildAgreement_Option_All:setMaxPenalty(self._cancellationCharge[0], 0)
  PaGlobal_GuildAgreement_Option_All:setMaxDailyPayment(self._paymentPerDay[0], 0)
  for idx = 1, #self._daybuttonTable do
    if nil == self._daybuttonTable[idx] then
      return
    end
    if 1 == idx then
      PaGlobal_GuildAgreement_Option_All._daybuttonTable[idx]:SetCheck(true)
    else
      PaGlobal_GuildAgreement_Option_All._daybuttonTable[idx]:SetCheck(false)
    end
  end
  PaGlobalFunc_GuildAgreement_Option_All_ContractDateSet(1)
  _AudioPostEvent_SystemUiForXBOX(8, 14)
  PaGlobal_GuildAgreement_Option_All:open()
end
function PaGlobal_GuildAgreement_Option_All:prepareClose()
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  PaGlobal_GuildAgreement_Option_All:close()
end
function PaGlobal_GuildAgreement_Option_All:open()
  Panel_GuildAgreementOption_All:SetShow(true)
end
function PaGlobal_GuildAgreement_Option_All:close()
  Panel_GuildAgreementOption_All:SetShow(false)
end
function PaGlobal_GuildAgreement_Option_All:validate()
  self._ui._stc_optionBg:isValidate()
  self._ui._txt_DailyPayment:isValidate()
  self._ui._txt_PenaltyCost:isValidate()
  self._ui._txt_DailyPayRange:isValidate()
  self._ui._txt_DailyPenatlyRange:isValidate()
  self._ui._stc_BottomBg:isValidate()
  self._ui._stc_Keyguide_A:isValidate()
  self._ui._stc_Keyguide_B:isValidate()
  self._ui._stc_Keyguide_Y:isValidate()
  for idx = 1, 6 do
    self._daybuttonTable[idx]:isValidate()
  end
end
function PaGlobal_GuildAgreement_Option_All:setMaxDailyPayment(payPerDay, max_Benefit)
  if nil == max_Benefit then
    max_Benefit = 0
  end
  local maxBenefit = math.min(max_Benefit, CppEnums.GuildBenefit.eMaxContractedBenefit)
  self._ui._txt_DailyPayRange:SetText(makeDotMoney(toInt64(0, payPerDay)) .. " ~ " .. makeDotMoney(maxBenefit) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_INCENTIVE_MONEY"))
end
function PaGlobal_GuildAgreement_Option_All:setMaxPenalty(inputPenalty, max_Penalty)
  if nil == max_Penalty then
    max_Penalty = 0
  end
  local maxPenalty = math.min(tonumber(max_Penalty), tonumber(CppEnums.GuildBenefit.eMaxContractedPenalty))
  self._ui._txt_DailyPenatlyRange:SetText(makeDotMoney(toInt64(0, inputPenalty)) .. " ~ " .. makeDotMoney(maxPenalty) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_INCENTIVE_MONEY"))
end
function HandleEventPadClick_GuildAgreement_Option_All_NumPadOpen(isDailySalry)
  if true == isDailySalry then
    local maxBenefit = 0
    if nil ~= PaGlobal_GuildAgreement_Option_All._maxBenefitValue then
      maxBenefit = math.min(tonumber(PaGlobal_GuildAgreement_Option_All._maxBenefitValue), tonumber(CppEnums.GuildBenefit.eMaxContractedBenefit))
    end
    Panel_NumberPad_Show(true, toInt64(0, maxBenefit), isDailySalry, PaGlobalFunc_GuildAgreement_Option_All_NumPadClose, nil, nil, nil, nil, nil)
  else
    local maxpenalty = 0
    if nil ~= PaGlobal_GuildAgreement_Option_All._maxpenaltyCostValue then
      maxpenalty = PaGlobal_GuildAgreement_Option_All._maxpenaltyCostValue
    end
    Panel_NumberPad_Show(true, toInt64(0, maxpenalty), isDailySalry, PaGlobalFunc_GuildAgreement_Option_All_NumPadClose, nil, nil, nil, nil, nil)
  end
  Panel_NumberPad_SetType("Guild_AgreementOption")
end
function PaGlobalFunc_GuildAgreement_Option_All_NumPadClose(inputNumber, isDailySalry)
  if true == isDailySalry then
    PaGlobal_GuildAgreement_Option_All._ui._txt_DailyPayment:SetText(tostring(inputNumber))
    PaGlobal_GuildAgreement_Option_All:setMaxDailyPayment(Int64toInt32(inputNumber), PaGlobal_GuildAgreement_Option_All._maxBenefitValue)
  else
    PaGlobal_GuildAgreement_Option_All._ui._txt_PenaltyCost:SetText(tostring(inputNumber))
    PaGlobal_GuildAgreement_Option_All:setMaxPenalty(Int64toInt32(inputNumber), PaGlobal_GuildAgreement_Option_All._maxpenaltyCostValue)
  end
end
function PaGlobalFunc_GuildAgreement_Option_All_ContractDateSet(idx)
  if nil == idx then
    return
  end
  PaGlobal_GuildAgreement_Option_All._curContractDayIndex = idx
  local payment = tonumber(PaGlobal_GuildAgreement_Option_All._paymentPerDay[idx])
  local penalty = tonumber(PaGlobal_GuildAgreement_Option_All._cancellationCharge[idx])
  if true == PaGlobal_GuildAgreement_Option_All._isJoin then
    PaGlobal_GuildAgreement_Option_All._ui._txt_DailyPayment:SetText(payment)
    PaGlobal_GuildAgreement_Option_All._ui._txt_PenaltyCost:SetText(penalty)
    PaGlobal_GuildAgreement_Option_All._ui._txt_DailyPayRange:SetText(makeDotMoney(toInt64(0, payment)) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_INCENTIVE_MONEY"))
    PaGlobal_GuildAgreement_Option_All._ui._txt_DailyPenatlyRange:SetText(makeDotMoney(toInt64(0, penalty)) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_INCENTIVE_MONEY"))
  else
    local usableActivity = PaGlobal_GuildAgreement_Option_All._usableActivity
    if nil == PaGlobal_GuildAgreement_Option_All._memberBenefit or nil == PaGlobal_GuildAgreement_Option_All._memberPenalty then
      UI.ASSERT(false, "nil == PaGlobal_GuildAgreement_Option_All._memberBenefit or nil == PaGlobal_GuildAgreement_Option_All._memberPenalty")
      return
    end
    local tempBenefit32 = Int64toInt32(PaGlobal_GuildAgreement_Option_All._memberBenefit)
    local tempPenalty32 = Int64toInt32(PaGlobal_GuildAgreement_Option_All._memberPenalty)
    local useBenefit = 0
    if payment > tempBenefit32 then
      useBenefit = payment
    else
      useBenefit = tempBenefit32
    end
    local usePenalty = 0
    if penalty > tempPenalty32 then
      usePenalty = penalty
    else
      usePenalty = tempPenalty32
    end
    PaGlobal_GuildAgreement_Option_All._maxBenefitValue = useBenefit + useBenefit * (usableActivity / 100 / 100)
    PaGlobal_GuildAgreement_Option_All._maxpenaltyCostValue = usePenalty + usePenalty * (usableActivity / 100 / 100)
    PaGlobal_GuildAgreement_Option_All:setMaxDailyPayment(payment, PaGlobal_GuildAgreement_Option_All._maxBenefitValue)
    PaGlobal_GuildAgreement_Option_All:setMaxPenalty(penalty, PaGlobal_GuildAgreement_Option_All._maxpenaltyCostValue)
    PaGlobal_GuildAgreement_Option_All._ui._txt_DailyPayment:SetText(tostring(payment))
    PaGlobal_GuildAgreement_Option_All._ui._txt_PenaltyCost:SetText(tostring(penalty))
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
end
function PaGlobalFunc_GuildAgreement_Option_All_Confirm()
  local dailyPay = tonumber(PaGlobal_GuildAgreement_Option_All._ui._txt_DailyPayment:GetText())
  local penaltyCost = tonumber(PaGlobal_GuildAgreement_Option_All._ui._txt_PenaltyCost:GetText())
  local standardDailyPay = PaGlobal_GuildAgreement_Option_All._paymentPerDay[PaGlobal_GuildAgreement_Option_All._curContractDayIndex]
  local standardPenaltyCost = PaGlobal_GuildAgreement_Option_All._cancellationCharge[PaGlobal_GuildAgreement_Option_All._curContractDayIndex]
  local period = PaGlobal_GuildAgreement_Option_All._periodValue[PaGlobal_GuildAgreement_Option_All._curContractDayIndex]
  if nil == dailyPay then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_AGREEMENTGUILD_MASTER_DAILYMONEY"))
    return
  end
  if nil == penaltyCost then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_AGREEMENTGUILD_MASTER_PENALTIES"))
    return
  end
  if -1 == PaGlobal_GuildAgreement_Option_All._curContractDayIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_AGREEMENTGUILD_MASTER_PERIOD_EDIT"))
    return
  end
  if false == PaGlobal_GuildAgreement_Option_All._isJoin then
    if dailyPay < standardDailyPay then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_AGREEMENTGUILD_MASTER_DAILYMONEY_LESS"))
      return
    elseif dailyPay > PaGlobal_GuildAgreement_Option_All._maxBenefitValue then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_AGREEMENTGUILD_MASTER_DAILYMONEY_TOOMUCH"))
      return
    elseif penaltyCost < standardPenaltyCost then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_AGREEMENTGUILD_MASTER_BREACH_LESS"))
      return
    elseif penaltyCost > PaGlobal_GuildAgreement_Option_All._maxpenaltyCostValue then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_AGREEMENTGUILD_MASTER_BREACH_TOOMUCH"))
      return
    end
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobalFunc_GuildAgreement_All_ContractOptionConfirm(period, dailyPay, penaltyCost)
  PaGlobal_GuildAgreement_Option_All:prepareClose()
end
function PaGlobalFunc_GuildAgreement_Option_All_Open()
  if true == Panel_GuildAgreementOption_All:GetShow() then
    return
  end
  PaGlobal_GuildAgreement_Option_All:prepareOpen()
end
function PaGlobalFunc_GuildAgreement_Option_All_Close()
  if false == Panel_GuildAgreementOption_All:GetShow() then
    return
  end
  PaGlobal_GuildAgreement_Option_All:prepareClose()
end
