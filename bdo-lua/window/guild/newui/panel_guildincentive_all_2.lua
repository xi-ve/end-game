function PaGlobalFunc_GuildIncentive_All_Open()
  PaGlobal_GuildIncentive_All:prepareOpen()
end
function PaGlobalFunc_GuildIncentive_All_Close()
  PaGlobal_GuildIncentive_All:prepareClose()
end
function PaGlobalFunc_GuildIncentive_All_ShowToggle()
  if true == PaGlobalFunc_GuildIncentiveOption_All_GetShow() then
    PaGlobalFunc_GuildIncentiveOption_All_Close()
    PaGlobalFunc_GuildIncentive_All_Close()
  else
    PaGlobalFunc_GuildIncentive_All_Open()
  end
end
function PaGlobalFunc_GuildIncentive_All_MainShowToggle()
  if nil == Panel_GuildIncentive_All then
    return
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local businessFunds = myGuildListInfo:getGuildBusinessFunds_s64()
  local businessFunds10 = businessFunds * toInt64(0, 10) / toInt64(0, 100)
  local businessFunds30 = businessFunds * toInt64(0, 40) / toInt64(0, 100)
  local editMoney = tonumber64(string.gsub(PaGlobal_GuildIncentive_All._ui.edit_money:GetEditText(), ",", ""))
  if businessFunds10 > editMoney or businessFunds30 < editMoney then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_INCENTIVE_FOUNDATION_RANGEOFMONEY_ALERT"))
    return
  end
  if true == PaGlobalFunc_GuildIncentiveOption_All_GetShow() then
    PaGlobalFunc_GuildIncentiveOption_All_Close()
    PaGlobalFunc_GuildIncentive_All_Close()
  else
    ToClient_InitGuildIncentiveList(editMoney)
    PaGlobalFunc_GuildIncentiveOption_All_Open(editMoney)
    PaGlobalFunc_GuildIncentive_All_Close()
  end
end
function FromClient_GuildIncentive_All_Resize()
  PaGlobal_GuildIncentive_All:resize()
end
function PaGlobalFunc_GuildIncentive_All_Editing()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local businessFunds = myGuildListInfo:getGuildBusinessFunds_s64()
  local businessFunds10 = businessFunds * toInt64(0, 10) / toInt64(0, 100)
  local businessFunds30 = businessFunds * toInt64(0, 40) / toInt64(0, 100)
  Panel_NumberPad_Show(true, businessFunds30, nil, PaGlobalFunc_GuildIncentive_All_ConfirmFunction)
end
function PaGlobalFunc_GuildIncentive_All_ConfirmFunction(inputNumber, param)
  if nil == Panel_GuildIncentive_All then
    return
  end
  PaGlobal_GuildIncentive_All._ui.edit_money:SetEditText(makeDotMoney(inputNumber), false)
end
function PaGlobalFunc_GuildIncentive_All_CheckUiEdit(targetUI)
  if nil == Panel_GuildIncentive_All then
    return false
  end
  return nil ~= targetUI and targetUI:GetKey() == PaGlobal_GuildIncentive_All._ui.edit_money:GetKey()
end
function PaGlobalFunc_GuildIncentive_All_ClearFocusEdit()
  ClearFocusEdit()
  CheckChattingInput()
end
