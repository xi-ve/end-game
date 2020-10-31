PaGlobal_GuildMemberInfo_All = {
  _ui = {
    txt_FamilyName = nil,
    txt_CharacterName = nil,
    txt_ActionPoint = nil,
    txt_Energy = nil,
    txt_OccupyChance = nil,
    txt_LeftTime = nil,
    txt_DailySalary = nil,
    txt_ContractPenalty = nil,
    txt_PriceLimit = nil
  },
  _siegeString = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_SIEGEGRADE_TOOLTIP_NAME_A"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_SIEGEGRADE_TOOLTIP_NAME_B"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_SIEGEGRADE_TOOLTIP_NAME_C"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_SIEGEGRADE_TOOLTIP_NAME_D"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_SIEGEGRADE_TOOLTIP_NAME_E")
  },
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildMemberInfo_All_Init")
function FromClient_GuildMemberInfo_All_Init()
  PaGlobal_GuildMemberInfo_All:initialize()
end
function PaGlobal_GuildMemberInfo_All:initialize()
  if nil == Panel_Guild_MemberInfo_All or true == self._initialize then
    return
  end
  local centerBg = UI.getChildControl(Panel_Guild_MemberInfo_All, "Static_CenterBg")
  self._ui.txt_FamilyName = UI.getChildControl(centerBg, "StaticText_FamilyNameValue")
  self._ui.txt_CharacterName = UI.getChildControl(centerBg, "StaticText_CharacterNameValue")
  self._ui.txt_ActionPoint = UI.getChildControl(centerBg, "StaticText_ActionPointValue")
  self._ui.txt_Energy = UI.getChildControl(centerBg, "StaticText_EnergyValue")
  self._ui.txt_OccupyChance = UI.getChildControl(centerBg, "StaticText_OccupyChanceValue")
  self._ui.txt_LeftTime = UI.getChildControl(centerBg, "StaticText_LeftTimeValue")
  self._ui.txt_DailySalary = UI.getChildControl(centerBg, "StaticText_DailySalaryValue")
  self._ui.txt_ContractPenalty = UI.getChildControl(centerBg, "StaticText_ContractPenaltyValue")
  self._ui.txt_PriceLimit = UI.getChildControl(centerBg, "StaticText_PriceLimitValue")
  PaGlobal_GuildMemberInfo_All:SetTitleTextLimit(centerBg)
  PaGlobal_GuildMemberInfo_All:validate()
  PaGlobal_GuildMemberInfo_All:registEventHandler()
end
function PaGlobal_GuildMemberInfo_All:SetTitleTextLimit(parentControl)
  local txt_FamilyName_Title = UI.getChildControl(parentControl, "StaticText_FamilyNameTitle")
  local txt_CharacterName_Title = UI.getChildControl(parentControl, "StaticText_CharacterNameTitle")
  local txt_ActionPoint_Title = UI.getChildControl(parentControl, "StaticText_ActionPointTitle")
  local txt_Energy_Title = UI.getChildControl(parentControl, "StaticText_EnergyTitle")
  local txt_OccupyChance_Title = UI.getChildControl(parentControl, "StaticText_OccupyChanceTitle")
  local txt_LeftTime_Title = UI.getChildControl(parentControl, "StaticText_LeftTimeTitle")
  local txt_DailySalary_Title = UI.getChildControl(parentControl, "StaticText_DailySalaryTitle")
  local txt_ContractPenalty_Title = UI.getChildControl(parentControl, "StaticText_ContractPenaltyTitle")
  local txt_PriceLimit_Title = UI.getChildControl(parentControl, "StaticText_PriceLimitTitle")
  local localFunc_SetLimitText = function(control)
    if nil == control then
      return
    end
    control:SetTextMode(__eTextMode_LimitText)
    control:SetText(control:GetText())
  end
  localFunc_SetLimitText(txt_FamilyName_Title)
  localFunc_SetLimitText(txt_CharacterName_Title)
  localFunc_SetLimitText(txt_ActionPoint_Title)
  localFunc_SetLimitText(txt_Energy_Title)
  localFunc_SetLimitText(txt_OccupyChance_Title)
  localFunc_SetLimitText(txt_LeftTime_Title)
  localFunc_SetLimitText(txt_DailySalary_Title)
  localFunc_SetLimitText(txt_ContractPenalty_Title)
  localFunc_SetLimitText(txt_PriceLimit_Title)
end
function PaGlobal_GuildMemberInfo_All:validate()
  self._ui.txt_FamilyName:isValidate()
  self._ui.txt_CharacterName:isValidate()
  self._ui.txt_ActionPoint:isValidate()
  self._ui.txt_Energy:isValidate()
  self._ui.txt_OccupyChance:isValidate()
  self._ui.txt_LeftTime:isValidate()
  self._ui.txt_DailySalary:isValidate()
  self._ui.txt_ContractPenalty:isValidate()
  self._ui.txt_PriceLimit:isValidate()
end
function PaGlobal_GuildMemberInfo_All:registEventHandler()
  Panel_Guild_MemberInfo_All:ignorePadSnapMoveToOtherPanel()
  PaGlobal_registerPanelOnBlackBackground(Panel_Guild_MemberInfo_All)
end
function PaGlobal_GuildMemberInfo_All:prepareOpen()
  if true == Panel_Guild_MemberInfo_All:GetShow() then
    return
  end
  local memberIdx
  if true == _ContentsGroup_NewUI_Guild_All then
    memberIdx = PaGlobalFunc_GuildMemberList_All_GetSelectMemeberIdx()
  else
    memberIdx = PaGlobalFunc_GuildMemberFunction_GetMemberIndex()
  end
  if nil == memberIdx then
    return
  end
  PaGlobal_GuildMemberInfo_All:update(memberIdx)
  PaGlobal_GuildMemberInfo_All:open()
end
function PaGlobal_GuildMemberInfo_All:open()
  Panel_Guild_MemberInfo_All:SetShow(true)
end
function PaGlobal_GuildMemberInfo_All:update(memberIdx)
  local guildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == guildInfo then
    return
  end
  local memberInfo = guildInfo:getMember(memberIdx)
  if nil == memberInfo then
    UI.ASSERT(false, "memberInfo is nil")
    return
  end
  self._ui.txt_FamilyName:SetText(memberInfo:getName())
  if true == memberInfo:isOnline() then
    self._ui.txt_CharacterName:SetText(memberInfo:getCharacterName())
  else
    self._ui.txt_CharacterName:SetText("-")
  end
  local activityValue = memberInfo:getUsableActivity()
  if 10000 < activityValue then
    activityValue = 10000
  end
  self._ui.txt_ActionPoint:SetText(tostring(memberInfo:getTotalActivity()) .. " (<PAColor0xfface400>+" .. tostring(activityValue) .. "<PAOldColor>)")
  local wp = memberInfo:getMaxWp()
  if wp <= 0 then
    wp = "-"
  end
  self._ui.txt_Energy:SetText(wp .. " / " .. memberInfo:getExplorationPoint())
  local isWarGradeOpen = ToClient_IsContentsGroupOpen("388")
  local warStr = "-"
  if true == isWarGradeOpen then
    local grade = memberInfo:getSiegeCombatantGrade()
    if nil ~= grade and 0 < grade then
      warStr = self._siegeString[grade]
    end
  end
  self._ui.txt_OccupyChance:SetText(warStr)
  local leftTime = memberInfo:getContractedExpirationUtc()
  if 0 < Int64toInt32(getLeftSecond_TTime64(leftTime)) then
    leftTimeStr = convertStringFromDatetime(getLeftSecond_TTime64(leftTime))
  else
    leftTimeStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_MASTER_REMAINPERIOD")
  end
  self._ui.txt_LeftTime:SetText(leftTimeStr)
  local dailySalary = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_MASTER_MONEY", "money", makeDotMoney(memberInfo:getContractedBenefit()))
  self._ui.txt_DailySalary:SetText(dailySalary)
  local paneltyStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_MASTER_MONEY", "money", makeDotMoney(memberInfo:getContractedPenalty()))
  self._ui.txt_ContractPenalty:SetText(paneltyStr)
  local memberIsLimit = memberInfo:getIsPriceLimit()
  local memberIsGrade = memberInfo:getGrade()
  local limitPrice = memberInfo:getPriceLimit()
  if 0 == memberIsGrade then
    self._ui.txt_PriceLimit:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_TOOLTIP_LIMITPRICE_NO"))
  elseif true == memberIsLimit then
    self._ui.txt_PriceLimit:SetText(makeDotMoney(limitPrice))
  else
    self._ui.txt_PriceLimit:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_TOOLTIP_LIMITPRICE_NO"))
  end
end
function PaGlobal_GuildMemberInfo_All:prepareClose()
  if false == Panel_Guild_MemberInfo_All:GetShow() then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobal_GuildMemberInfo_All:close()
end
function PaGlobal_GuildMemberInfo_All:close()
  Panel_Guild_MemberInfo_All:SetShow(false)
end
function PaGlobalFunc_GuildMemberInfo_All_Open()
  PaGlobal_GuildMemberInfo_All:prepareOpen()
end
function PaGlobalFunc_GuildMemberInfo_All_Close()
  PaGlobal_GuildMemberInfo_All:prepareClose()
end
