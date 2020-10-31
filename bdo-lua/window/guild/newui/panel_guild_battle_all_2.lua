function PaGlobalFunc_Guild_Battle_All_Open(index)
  if nil == Panel_GuildMain_All then
    return
  end
  PaGlobal_Guild_Battle_All:prepareOpen(index)
end
function PaGlobalFunc_Guild_Battle_All_Close()
  if nil == Panel_GuildMain_All then
    return
  end
  PaGlobal_Guild_Battle_All:prepareClose()
end
function PaGlobalFunc_Guild_Battle_All_IsShow()
  if nil == Panel_GuildMain_All then
    return false
  end
  return PaGlobal_GuildMain_All._ui.stc_GuildBattle_Bg:GetShow()
end
function PaGlobal_Guild_Battle_All_UpdateGuildBattleInfo()
  ToClient_GuildBattle_UpdateGuildBattleInfo()
end
function PaGlobal_Guild_Battle_All_UpdateRemainTime()
  PaGlobal_Guild_Battle_All:UpdateRemainTime()
end
function HandleEventLUp_Guild_Battle_All_Reservation()
  ToClient_GuildBattle_ReserveGuildBattle(PaGlobal_Guild_Battle_All._battingPrice)
end
function HandleEventLUp_Guild_Battle_All_Reservation_Cancel()
  ToClient_GuildBattle_CancelGuildBattle()
end
function HandleEventLUp_Guild_Battle_All_Join()
  if true == ToClient_isPersonalBattle() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_CANNOT_GUILDBATTLE_SERVER"))
    return
  end
  local rv = ToClient_CheckToJoinBattle()
  if 0 ~= rv then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictedToJoinBattle"))
    return
  end
  ToClient_GuildBattle_JoinGuildBattle()
end
function HandleEventLUp_Guild_Battle_All_UnJoin()
  ToClient_GuildBattle_UnjoinGuildBattle()
end
function HandleEventLUp_Guild_Battle_All_Start()
  ToClient_GuildBattle_StartGuildBattle()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_WE_ARE_READY_SHORT"))
end
function HandleEventLUp_Guild_Battle_All_SetPrice()
  if nil == Panel_GuildMain_All then
    return
  end
  local setEditText = function(inputNumber)
    PaGlobal_Guild_Battle_All._battingPrice = Int64toInt32(inputNumber)
  end
  local myGuildInfo = ToClient_GuildBattle_GetMyGuildInfoWrapper()
  local getGuildMoney = myGuildInfo:getGuildBusinessFunds_s64()
  Panel_NumberPad_Show(true, getGuildMoney, 0, setEditText)
end
function FromClient_Guild_Battle_All_NotifyGuildBattleJoin()
  PaGlobal_Guild_Battle_All:notifyJoinGuildBattle()
end
function FromClient_Guild_Battle_All_ResponseRequestGuildBattleInfo()
  PaGlobal_Guild_Battle_All:UpdateGuildBattleInfo()
end
function FromClient_Guild_Battle_All_ReserveGuildBattleSuccess(cancel)
  PaGlobal_Guild_Battle_All:SetProgressServer(cancel)
  ToClient_GuildBattle_UpdateGuildBattleInfo()
end
function FromClient_Guild_Battle_All_ModeChangeRequest(mode)
end
function FromClient_Guild_Battle_All_CancelAnotherGuild(cancel)
  if true == cancel then
    ToClient_GuildBattle_UpdateGuildBattleInfo()
  end
end
function guildbattleStop(isstop)
  ToClient_GuildBattle_RequestGuildBattleStop(isstop)
end
