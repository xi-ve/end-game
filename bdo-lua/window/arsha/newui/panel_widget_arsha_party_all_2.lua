function PaGlobalFunc_Arsha_Party_All_Open()
  PaGlobal_Arsha_Party_All:prepareOpen()
end
function PaGlobalFunc_Arsha_Party_All_Close()
  PaGlobal_Arsha_Party_All:prepareClose()
end
function HandleEventLUp_Arsha_Party_All_Close()
  PaGlobalFunc_Arsha_Party_All_Close()
end
function PaGlobalFunc_Arsha_Party_All_Resize()
  PaGlobal_Arsha_Party_All:resize()
end
function PaGlobalFunc_Arsha_Party_All_CameraControl(teamNo)
  ToClient_ForceChangeScreenModeActor(toInt64(0, teamNo))
end
function PaGlobalFunc_Arsha_Party_All_Create()
  PaGlobalFunc_Arsha_Party_All_Resize()
  local matchType = ToClient_CompetitionMatchType()
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == matchType then
    PaGlobal_Arsha_Party_All:createTeamUi_Round()
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll == matchType then
    PaGlobal_Arsha_Party_All:createTeamUi_FreeForAll()
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == matchType then
    PaGlobal_Arsha_Party_All:createTeamUi_Personal()
  end
end
function PaGlobalFunc_Arsha_Party_All_StatSlotClose()
  local matchType = ToClient_CompetitionMatchType()
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == matchType then
    PaGlobal_Arsha_Party_All:stateSlotClose_Round()
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll == matchType then
    PaGlobal_Arsha_Party_All:stateSlotClose_FreeForAll()
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == matchType then
    PaGlobal_Arsha_Party_All:stateSlotClose_Personal()
  end
end
function PaGlobalFunc_Arsha_Party_All_Setting(teamNo, userCount)
  local matchType = ToClient_CompetitionMatchType()
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == matchType then
    PaGlobal_Arsha_Party_All:setting_Round(teamNo, userCount)
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll == matchType then
    PaGlobal_Arsha_Party_All:setting_FreeForAll(teamNo)
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == matchType then
    PaGlobal_Arsha_Party_All:setting_Personal(teamNo)
  end
end
function PaGlobalFunc_Arsha_Party_All_FreeForAllSlotReset()
  for ii = 0, CppEnums.CompetitionFreeForAll.eFreeForAllTeamLimit - 1 do
    PaGlobal_Arsha_Party_All:statSlotSetShow(0, ii, false, true)
  end
end
function FromClient_Arsha_Party_All_UpdateUserHP()
  local matchType = ToClient_CompetitionMatchType()
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == matchType then
    PaGlobal_Arsha_Party_All:updateUserHP_Round()
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll == matchType then
    PaGlobal_Arsha_Party_All:updateUserHP_FreeForAll()
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == matchType then
    PaGlobal_Arsha_Party_All:updateUserHP_Personal()
  end
end
