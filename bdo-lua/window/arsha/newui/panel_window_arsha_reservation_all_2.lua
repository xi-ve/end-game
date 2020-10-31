function PaGlobalFunc_Arsha_Reservation_All_Open()
  if nil == Panel_Window_Arsha_Reservation_All then
    return
  end
  PaGlobal_Arsha_Reservation_All:prepareOpen()
end
function PaGlobalFunc_Arsha_Reservation_All_Close()
  if nil == Panel_Window_Arsha_Reservation_All then
    return
  end
  PaGlobal_Arsha_Reservation_All:prepareClose()
end
function PaGlobalFunc_Arsha_Reservation_All_GetShow()
  if nil == Panel_Window_Arsha_Reservation_All then
    return
  end
  return Panel_Window_Arsha_Reservation_All:GetShow()
end
function PaGlobaFunc_Arsha_Reservation_All_ESCMenuFunc()
  if true == ToClient_IsInstanceRandomMatching() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RANDOMMATCH_FAILACK"))
    return
  end
  if ToClient_IsHostInArena() and ToClient_IsCompetitionHost() then
    PaGlobalFunc_Arsha_Func_All_Open()
  elseif ToClient_IsMyselfInArena() then
    PaGlobalFunc_Arsha_Func_All_Open()
  elseif ToClient_IsCompetitionHost() == false then
    PaGlobalFunc_Arsha_Reservation_All_Open()
  else
    PaGlobalFunc_Arsha_Func_All_HostJoin()
  end
end
function PaGlobalFunc_Arsha_Reservation_All_Refresh()
  if nil == Panel_Window_Arsha_Reservation_All then
    return
  end
  PaGlobal_Arsha_Reservation_All:refresh()
end
function HandleEventLUp_Arsha_Reservation_All_Join(isObserver)
  if nil == Panel_Window_Arsha_Reservation_All then
    return
  end
  PaGlobal_Arsha_Reservation_All:join(isObserver)
end
function HandleEventLUp_Arsha_Reservation_All_Reservation(reservationIndex, isReservation)
  if nil == Panel_Window_Arsha_Reservation_All then
    return
  end
  PaGlobal_Arsha_Reservation_All:reservation(reservationIndex, isReservation)
end
function HandleRSticEventUp_Arsha_Reservation_All_MoveScroll(isUp)
  if nil == Panel_Window_Arsha_Reservation_All or false == Panel_Window_Arsha_Reservation_All:GetShow() then
    return
  end
  PaGlobal_Arsha_Reservation_All:moveScroll(isUp)
end
function FromClient_Arsha_Reservation_All_ChangeReservationInfo(dayIndex, dayValue, dayOfWeekValue, reservationGuildName, guildNo, isReservation)
  if nil == Panel_Window_Arsha_Reservation_All then
    return
  end
  PaGlobal_Arsha_Reservation_All:changeReservationInfo(dayIndex, dayValue, dayOfWeekValue, reservationGuildName, guildNo, isReservation)
end
function FromClient_Arsha_Reservation_All_RequestTransferHost(hostCharacterName, userNo)
  local function transferHost()
    ToClient_RequestAcceptTransferHost(userNo, true)
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_TRANSFER_HOST_TO_OTHERGUILDMASTER", "characterName", hostCharacterName)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = transferHost,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_Arsha_Reservation_All_ChangedHost(isHostMyself)
  if true == isHostMyself then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GET_ARSHAHOST"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RELEASE_ARSHAHOST_DESC"))
    PaGlobalFunc_Arsha_Func_All_Close()
  end
end
function FromClient_Arsha_Reservation_All_ChangedAssistant(isAssistant)
  if true == isAssistant then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_SET_TO_ASSISTANT"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_RELEASE_FROM_ASSISTANT"))
  end
end
