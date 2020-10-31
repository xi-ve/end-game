function PaGlobalFunc_Arsha_TeamNameChange_All_Open(editTeamIdx)
  PaGlobal_Arsha_TeamNameChange_All:prepareOpen(editTeamIdx)
end
function PaGlobalFunc_Arsha_TeamNameChange_All_Close()
  PaGlobal_Arsha_TeamNameChange_All:prepareClose()
end
function HandleEventLUp_Arsha_TeamNameChange_All_Close()
  PaGlobal_Arsha_TeamNameChange_All:prepareClose()
end
function HandleEventLUp_Arsha_TeamNameChange_All_Confirm()
  PaGlobal_Arsha_TeamNameChange_All:confirm()
end
function PaGlobalFunc_Arsha_TeamNameChange_All_UiEdit_A(targetUI)
  return nil ~= targetUI and targetUI:GetKey() == PaGlobal_Arsha_TeamNameChange_All._ui.edit_teamA:GetKey()
end
function PaGlobalFunc_Arsha_TeamNameChange_All_UiEdit_B(targetUI)
  return nil ~= targetUI and targetUI:GetKey() == PaGlobal_Arsha_TeamNameChange_All._ui.edit_teamB:GetKey()
end
function PaGlobalFunc_Arsha_TeamNameChange_All_VirtualKeyboardEnd_A(str)
  PaGlobal_Arsha_TeamNameChange_All._ui.edit_teamA:SetEditText(str, true)
  ClearFocusEdit()
end
function PaGlobalFunc_Arsha_TeamNameChange_All_VirtualKeyboardEnd_B(str)
  PaGlobal_Arsha_TeamNameChange_All._ui.edit_teamB:SetEditText(str, true)
  ClearFocusEdit()
end
function PaGlobalFunc_Arsha_TeamNameChange_All_ClearFocusEdit()
  ClearFocusEdit()
  CheckChattingInput()
end
