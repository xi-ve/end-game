function PaGlobal_Arena_Battle_Open()
  if false == Panel_Arena_Battle:GetShow() then
    PaGlobal_Arena_Battle:prepareOpen()
  else
    PaGlobal_Arena_Battle_Close()
  end
end
function PaGlobal_Arena_Battle_Close()
  PaGlobal_Arena_Waiting_Close()
  PaGlobal_Arena_Battle:prepareClose()
end
function PaGlobal_Arena_Battle_UpdatePvPTime(deleta)
  PaGlobal_Arena_Battle:updatePvPTime(deleta)
end
function PaGlobal_Arena_Battle_Accept()
  ToClient_requestJoinBattleGroundPvP(true)
  allClearMessageData()
end
function PaGlobal_Arena_Battle_Cancle()
  ToClient_requestJoinBattleGroundPvP(false)
  allClearMessageData()
end
function FromClient_NotifyEnterBattleGround()
  if false == ToClient_isConsole() then
    PaGlobalFunc_ServantIcon_UpdateOtherIcon(PaGlobalFunc_ServantIcon_GetBattleIndex())
  end
end
function FromClient_Arena_BattleRenderModeChangeState(prevRenderModeList, nextRenderModeList)
  if nil ~= Panel_Arena_Battle and true == Panel_Arena_Battle:GetShow() then
    PaGlobal_Arena_Battle_Open()
  end
end
function FromClient_Arena_Battle_HpChanged()
  PaGlobal_Arena_Battle:settingUserHp()
end
function FromClient_Arena_Battle_AddDamage()
  PaGlobal_Arena_Battle:settingUserHp()
end
function FromClient_NotifyBattleGroundPvPOrder()
  FromClient_DialogMain_All_HideDialog(false)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_ARENA_WAITING_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_ARENA_WAITING_DESC"),
    functionApply = PaGlobal_Arena_Battle_Accept,
    functionCancel = PaGlobal_Arena_Battle_Cancle,
    isProgress = true,
    isTimeCount = true,
    countTime = 4.5,
    isStartTimer = true,
    afterFunction = PaGlobal_Arena_Battle_Cancle,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_Arena_Battle_NotifyBattleGroundResult(isDraw, winner, loser)
  local resultString = ""
  if true == isDraw then
    resultString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ARENABATTLE_DRAW", "winner", winner, "loser", loser)
  else
    resultString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ARENABATTLE_RESULT", "winner", winner, "loser", loser)
  end
  Proc_ShowMessage_Ack(resultString)
end
function FromClient_Arena_Battle_ChangeUserInfo()
  if nil == Panel_Arena_Battle then
    return
  end
  if false == ToClient_isConsole() then
    PaGlobalFunc_ServantIcon_UpdateOtherIcon(PaGlobalFunc_ServantIcon_GetBattleIndex())
  end
  PaGlobal_Arena_Battle:settingUserInfo()
end
function FromClient_Arena_Battle_ReSizePanel()
  Panel_Arena_Battle:ComputePosAllChild()
end
function PaGlobal_Arena_Battle_ShowAni()
  if nil == Panel_Arena_Battle then
    return
  end
end
function PaGlobal_Arena_Battle_HideAni()
  if nil == Panel_Arena_Battle then
    return
  end
end
