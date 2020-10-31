function PaGlobalFunc_Arsha_FuncList_All_Open()
  PaGlobal_Arsha_FuncList_All:prepareOpen()
end
function PaGlobalFunc_Arsha_FuncList_All_Close()
  PaGlobal_Arsha_FuncList_All:prepareClose()
end
function HandleEventLUp_Arsha_FuncList_All_SelectButton(selectIdx)
  PaGlobalFunc_Arsha_FuncList_All_Close()
  if nil == PaGlobal_Arsha_FuncList_All._buttonType[selectIdx] or nil == PaGlobal_Arsha_FuncList_All._buttonType[selectIdx].bType then
    return
  end
  if PaGlobal_Arsha_FuncList_All._buttonType[selectIdx].bType == "GameStart" then
    HandleEventLUp_Arsha_Func_All_GameStart()
  elseif PaGlobal_Arsha_FuncList_All._buttonType[selectIdx].bType == "GameStop" then
    HandleEventLUp_Arsha_Func_All_GameStop()
  elseif PaGlobal_Arsha_FuncList_All._buttonType[selectIdx].bType == "AllResrrection" then
    HandleEventLUp_Arsha_Func_All_AllPlayerResurrection()
  elseif PaGlobal_Arsha_FuncList_All._buttonType[selectIdx].bType == "TeamNameChange" then
    HandleEventLUp_Arsha_Func_All_ChangeTeamNameOpen(1)
  elseif PaGlobal_Arsha_FuncList_All._buttonType[selectIdx].bType == "InviteList" then
    HandleEventLUp_Arsha_Func_All_InviteListOpen()
  elseif PaGlobal_Arsha_FuncList_All._buttonType[selectIdx].bType == "ArshaOpenClose" then
    HandleEventLUp_Arsha_Func_All_OpenOrClose()
  elseif PaGlobal_Arsha_FuncList_All._buttonType[selectIdx].bType == "GoATeam" then
    HandleEventLUp_Arsha_Func_All_TeamChange(1)
  elseif PaGlobal_Arsha_FuncList_All._buttonType[selectIdx].bType == "GoBTeam" then
    HandleEventLUp_Arsha_Func_All_TeamChange(2)
  elseif PaGlobal_Arsha_FuncList_All._buttonType[selectIdx].bType == "GoWait" then
    HandleEventLUp_Arsha_Func_All_TeamChange(0)
  elseif PaGlobal_Arsha_FuncList_All._buttonType[selectIdx].bType == "GoExit" then
    HandleEventLUp_Arsha_Func_All_Exit()
  end
end
