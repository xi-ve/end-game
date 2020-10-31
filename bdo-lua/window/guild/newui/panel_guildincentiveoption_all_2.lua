function PaGlobalFunc_GuildIncentiveOption_All_Open(editMoney)
  PaGlobal_GuildIncentiveOption_All:prepareOpen(editMoney)
end
function PaGlobalFunc_GuildIncentiveOption_All_Close()
  PaGlobal_GuildIncentiveOption_All:prepareClose()
end
function PaGlobalFunc_GuildIncentiveOption_All_GetShow()
  if nil == Panel_GuildIncentiveOption_All then
    return false
  end
  return Panel_GuildIncentiveOption_All:GetShow()
end
function HandleEventScroll_GuildIncentiveOption_All_Scroll(isUp)
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  local memberCount = ToClient_getGuildIncentiveListCount()
  UIScroll.ScrollEvent(PaGlobal_GuildIncentiveOption_All._ui.frame_vScroll, isUp, memberCount, memberCount, 0, 1)
end
function HandleEventLUp_GuildIncentiveOption_All_Grade(index)
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  PaGlobal_GuildIncentiveOption_All._incentiveIdx = index
  Panel_NumberPad_Show(true, toInt64(0, 10), 0, PaGlobalFunc_GuildIncentiveOption_All_GradeCallBack)
end
function HandleEventLUp_GuildIncentiveOption_All_ListSort(sortType)
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  PaGlobalFunc_GuildIncentiveOption_All_TitleLineReset()
  PaGlobal_GuildIncentiveOption_All._selectSortType = sortType
  if 0 == PaGlobal_GuildIncentiveOption_All._selectSortType then
    if false == PaGlobal_GuildIncentiveOption_All._listSort.name then
      PaGlobal_GuildIncentiveOption_All._ui._title.txt_name:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_INCENTIVE_M_CHARNAME") .. "\226\150\178")
      PaGlobal_GuildIncentiveOption_All._listSort.name = true
    else
      PaGlobal_GuildIncentiveOption_All._ui._title.txt_name:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_INCENTIVE_M_CHARNAME") .. "\226\150\188")
      PaGlobal_GuildIncentiveOption_All._listSort.name = false
    end
    table.sort(PaGlobal_GuildIncentiveOption_All._memberlistData, guildIncentiveCompareName)
  elseif 1 == PaGlobal_GuildIncentiveOption_All._selectSortType then
    if false == PaGlobal_GuildIncentiveOption_All._listSort.ap then
      PaGlobal_GuildIncentiveOption_All._ui._title.txt_activity:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_INCENTIVE_M_CONTRIBUTED") .. "\226\150\178")
      PaGlobal_GuildIncentiveOption_All._listSort.ap = true
    else
      PaGlobal_GuildIncentiveOption_All._ui._title.txt_activity:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_INCENTIVE_M_CONTRIBUTED") .. "\226\150\188")
      PaGlobal_GuildIncentiveOption_All._listSort.ap = false
    end
    table.sort(PaGlobal_GuildIncentiveOption_All._memberlistData, guildIncentiveCompareAp)
  end
  PaGlobal_GuildIncentiveOption_All:update()
end
function HandleEventLUp_GuildIncentiveOption_All_UpdateIncentiveRadio(index, bValue)
  local userNoStr = tostring(PaGlobal_GuildIncentiveOption_All._memberlistData[index + 1].userNo)
  PaGlobal_GuildIncentiveOption_All._isAllButton[userNoStr] = bValue
  PaGlobal_GuildIncentiveOption_All:update()
end
function HandleEventOnOut_GuildIncentiveOption_All_TaxSimpleTooltip(isShow, index)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_SEVERSELECT_PK")
  local dataIdx = PaGlobal_GuildIncentiveOption_All._memberlistData[index + 1].idx
  local incentive = ToClient_getGuildMemberIncentiveMoney_s64(dataIdx)
  local incentiveAfterTax = ToClient_getGuildMemberIncentiveMoneyAfterTax_s64(dataIdx)
  TooltipSimple_Show(PaGlobal_GuildIncentiveOption_All._ui._memberlist[index]._incentiveValue, "", PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_INCENTIVE_MONEY") .. " " .. makeDotMoney(incentiveAfterTax))
end
function HandleEventLUp_GuildIncentiveOption_All_GiveIncentive()
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_INCENTIVE_PAYMENTS")
  local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_INCENTIVE_PAYMENTS_CONFIRM")
  if true == ToClient_isConsoleOnlyChannel() then
    contentString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_INCENTIVE_PAYMENTS_CONFIRM_ONLY_SERVER")
  end
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = PaGlobalFunc_GuildIncentiveOption_All_PayIncentiveConfirm,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_GuildIncentiveOption_All_Resize()
  PaGlobal_GuildIncentiveOption_All:resize()
end
function PaGlobalFunc_GuildIncentiveOption_All_GradeCallBack(count)
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  local index = PaGlobal_GuildIncentiveOption_All._incentiveIdx
  local dataIdx = PaGlobal_GuildIncentiveOption_All._memberlistData[index + 1].idx
  local editMoney = PaGlobal_GuildIncentiveOption_All._moneyValue
  local isAll = PaGlobal_GuildIncentiveOption_All._ui._memberlist[index]._radio_All:IsCheck()
  if true == isAll then
    local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
    if nil == myGuildListInfo then
      return
    end
    local memberCount = ToClient_getGuildIncentiveListCount()
    for i = 0, memberCount - 1 do
      if true == PaGlobal_GuildIncentiveOption_All._ui._memberlist[i]._radio_All:IsCheck() then
        local tempIdx = PaGlobal_GuildIncentiveOption_All._memberlistData[i + 1].idx
        ToClient_SetGuildMemberIncentiveGrade(tempIdx, Int64toInt32(count), editMoney)
      end
    end
  else
    ToClient_SetGuildMemberIncentiveGrade(dataIdx, Int64toInt32(count), editMoney)
  end
  PaGlobal_GuildIncentiveOption_All:update()
end
function PaGlobalFunc_GuildIncentiveOption_All_TitleLineReset()
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  PaGlobal_GuildIncentiveOption_All._ui._title.txt_name:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_INCENTIVE_M_CHARNAME"))
  PaGlobal_GuildIncentiveOption_All._ui._title.txt_activity:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_INCENTIVE_M_CONTRIBUTED"))
end
function PaGlobalFunc_GuildIncentiveOption_All_PayIncentiveConfirm()
  ToClient_PayGuildMemberIncentive()
  PaGlobalFunc_GuildIncentiveOption_All_Close()
  PaGlobalFunc_GuildIncentive_All_Close()
end
function guildIncentiveCompareName(w1, w2)
  if true == PaGlobal_GuildIncentiveOption_All._listSort.name then
    if w1.name < w2.name then
      return true
    end
  elseif w2.name < w1.name then
    return true
  end
end
function guildIncentiveCompareAp(w1, w2)
  if true == PaGlobal_GuildIncentiveOption_All._listSort.ap then
    if w2.ap < w1.ap then
      return true
    end
  elseif w1.ap < w2.ap then
    return true
  end
end
