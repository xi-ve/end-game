function PaGlobalFunc_Widget_Party_All_Open()
  PaGlobal_Party_All:prepareOpen()
end
function PaGlobalFunc_Widget_Party_All_Close()
  PaGlobal_Party_All:prepareClose()
end
function HandleEventLUp_Party_All_SetLootingOption()
  PaGlobal_Party_All:setLootingType()
end
function HandleEventLUp_Party_All_SelectLootingType(lootType)
  PaGlobal_Party_All:selectLootingType(lootType)
end
function HandleEventLUp_Party_All_SelectPartyOption(index)
  PaGlobal_Party_All:selectPartyOption(index)
end
function HandleEventLUp_Party_All_SelectWithdrawMemeber(index)
  PaGlobal_Party_All:selectWithdrawMember(index)
end
function HandleEventLUp_Party_All_SelectBanishMember(index)
  PaGlobal_Party_All:banishMemeber(index)
end
function HandleEventLUp_Party_All_SelectChangeLeader(index)
  PaGlobal_Party_All:selectChangeLeader(index)
end
function HandleEventLUp_Party_All_SetGrade(index)
  PaGlobal_Party_All:setGrade(index)
end
function HandleEventLUp_Party_All_ShowGradeListToggle()
  PaGlobal_Party_All:showGradeListToggle()
end
function HandleEventLUp_Party_All_ShowMarketOptionToggle()
  PaGlobal_Party_All:showMarketOptionToggle()
end
function HandleEventLUp_Party_All_ChangeMoney()
  Panel_NumberPad_Show(true, PaGlobal_Party_All._config.maxMoney, nil, PaGlobalFunc_Widget_Party_All_SetMoney)
end
function HandleEventLUp_Party_All_SetRegistItem()
  PaGlobal_Party_All:setRegistItem()
end
function HandleEventOnOut_Party_All_ShowSepcialGoodsToolTip(btnType, isShow)
  PaGlobal_Party_All:showSpecialGoodsTooltip(btnType, isShow)
end
function HandleEventLUp_Party_All_SelectPartyFollow(index)
  PaGlobal_Party_All:selectPartyFollow(index)
end
function HandleEventOnOut_Party_All_ShowSimpleTooltip(isShow, tipType, index)
  if 4 == tipType then
    if true == isShow then
      PaGlobal_Party_All._isRootShowFlag = true
    else
      PaGlobal_Party_All._isRootShowFlag = false
    end
  end
  PaGlobal_Party_All:showSimpleTooltip(isShow, tipType, index)
end
function HandleEventOnOut_Party_All_ShowNameTooltip(isShow, index)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  local control = PaGlobal_Party_All._ui.stc_members[index].control
  local partyData = PaGlobal_Party_All._partyData[index]
  if nil == partyData then
    return
  end
  TooltipSimple_Show(control, "", partyData._name)
end
function FromClient_Party_All_createPartyList()
  PaGlobal_Party_All:createPartyList()
end
function FromClient_Party_All_updatePartyList()
  PaGlobal_Party_All:updatePartyList(false)
end
function FromClient_Party_All_OnScreenResize()
  PaGlobal_Party_All:onScreenSize()
end
function FromClient_Party_All_Invite(hostName, invitePartyType)
  PaGlobal_Party_All:invite(hostName, invitePartyType)
end
function FromClient_Party_All_Refuse(reason)
  PaGlobal_Party_All:refuse(reason)
end
function FromClient_Party_All_ChangeLeader(actorKey)
  PaGlobal_Party_All:changeLeader(actorKey)
end
function FromClient_Party_All_Withdraw(withdrawType, actorKey, isMe)
  PaGlobal_Party_All:withdraw(withdrawType, actorKey, isMe)
end
function FromClient_Party_All_PartyOption_Hide()
  if nil == Panel_Widget_Party_All then
    return
  end
  PaGlobal_Party_All:showRegistItem(false)
  PaGlobal_Party_All:closePartyOption()
  PaGlobal_Party_All._ui_pc.chk_dropItem:SetCheck(false)
  PaGlobal_Party_All:showLootingType()
end
function FromClient_Party_All_NotifyPartyMemberPickupItem(userName, itemName)
  local message = ""
  message = PAGetStringParam2(Defines.StringSheet_GAME, "GAME_MESSAGE_NOTIFY_PARTYMEMBER_PICKUP_ITEM", "userName", userName, "itemName", itemName)
  Proc_ShowMessage_Ack_With_ChatType(message, nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.PartyItem)
end
function FromClient_Party_All_NotifyPartyMemberPickupItemFromPartyInventory(userName, itemName, itemCount)
  local message = ""
  message = PAGetStringParam3(Defines.StringSheet_GAME, "GAME_MESSAGE_NOTIFY_PARTYMEMBER_PICKUP_ITEM_FOR_PARTYINVENTORY", "userName", userName, "itemName", itemName, "itemCount", tostring(itemCount))
  Proc_ShowMessage_Ack_With_ChatType(message, nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.PartyItem)
end
function FromClient_Party_All_RenderModeChange(prevRenderModeList, nextRenderModeList)
  PaGlobal_Party_All:renderModeChange(prevRenderModeList, nextRenderModeList)
end
function PaGlobalFunc_Widget_Party_All_GetMemberCount()
  return PaGlobal_Party_All._partyInfo.partyMemCnt
end
function PaGlobalFunc_Widget_Party_All_GetShow()
  if nil == Panel_Widget_Party_All then
    return false
  end
  return Panel_Widget_Party_All:GetShow()
end
function PaGlobalFunc_Widget_Party_All_SetMoney(inputNum)
  PaGlobal_Party_All:setMoney(inputNum)
end
function PaGlobalFunc_Widget_Party_All_ConditionShow()
  PaGlobal_Party_All:partyConditionalShow()
end
function PaGlobalFunc_Widget_Party_All_SetMemberData(partyMemberCount)
  PaGlobal_Party_All:setPartyMember(partyMemberCount)
  return PaGlobal_Party_All._partyData
end
function PaGlobalFunc_Widget_Party_All_SetMemberDataConsole(partyMemberCount)
  PaGlobal_Party_All:setPartyMember(partyMemberCount)
  local partyData = {}
  for index = 0, partyMemberCount - 1 do
    partyData[index] = PaGlobal_Party_All._partyData[index + 1]
  end
  return partyData
end
function PaGlobalFunc_Widget_Party_All_CheckInParty(name)
  local retval = false
  for key, value in pairs(PaGlobal_Party_All._partyData) do
    if value._name == name then
      retval = true
      break
    end
  end
  return retval
end
function PaGlobalFunc_Widget_Party_All_Resize()
  PaGlobal_Party_All:onScreenSize()
end
