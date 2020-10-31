function PaGlobal_Arena_Waiting_Open()
  PaGlobal_Arena_Waiting:prepareOpen()
end
function PaGlobal_Arena_Waiting_Close()
  PaGlobal_Arena_Waiting:prepareClose()
end
function PaGlobal_Arena_Waiting_Refresh()
  ToClient_requestBattleGroundPvPInfo()
  ToClient_requestBattleGroundPvPWaitionList()
  PaGlobal_Arena_Waiting._ui.btn_refresh:SetAutoDisableTime(1)
end
function FromClient_Arena_Waiting_ReSizePanel()
  Panel_Arena_Waiting:ComputePosAllChild()
end
function FromClient_NotifyBattleGroundPvPWaitingList()
  PaGlobal_Arena_Waiting._ui.txt_total:SetText(tostring(ToClient_BattleGroundPvPWaitingListCount()))
  local myTurn = ToClient_BattleGroundPvPMyOrderNumber()
  if 0 == myTurn then
    PaGlobal_Arena_Waiting._ui.txt_myTurn:SetText("-")
    return
  end
  PaGlobal_Arena_Waiting._ui.txt_myTurn:SetText(tostring(myTurn))
end
