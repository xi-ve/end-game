function PaGlobalFunc_Arsha_TeamChange_All_Open(idx, userNo_Str, isObserver)
  if nil == userNo_Str then
    UI.ASSERT_NAME(nil ~= userNo_Str, "Arsha_TeamChange_All, userNo_Str\234\176\128 nil\236\157\180\235\169\180 \236\149\136 \235\144\156\235\139\164.", "\236\154\176\236\160\149\235\172\180")
    return
  end
  PaGlobal_Arsha_TeamChange_All:prepareOpen(idx, userNo_Str, isObserver)
end
function PaGlobalFunc_Arsha_TeamChange_All_Close()
  PaGlobal_Arsha_TeamChange_All:prepareClose()
end
function HandleEventLUp_Arsha_TeamChange_All_Close()
  PaGlobalFunc_Arsha_TeamChange_All_Close()
end
function HandleEventLUp_Arsha_TeamChange_All_Confirm()
  local teamNo_s32 = 0
  if PaGlobal_Arsha_TeamChange_All._ui.rdo_teamA:IsCheck() then
    teamNo_s32 = 1
  elseif PaGlobal_Arsha_TeamChange_All._ui.rdo_teamB:IsCheck() then
    teamNo_s32 = 2
  elseif PaGlobal_Arsha_TeamChange_All._ui.rdo_teamW:IsCheck() then
    teamNo_s32 = 0
  end
  ToClient_RequestSetTeam(PaGlobal_Arsha_TeamChange_All._savedIdx, teamNo_s32)
  PaGlobalFunc_Arsha_TeamChange_All_Close()
end
