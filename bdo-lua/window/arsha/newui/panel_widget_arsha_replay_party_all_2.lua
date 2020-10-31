function PaGlobalFunc_Arsha_Replay_Party_All_Open()
  PaGlobal_Arsha_Replay_Party_All:prepareOpen()
end
function PaGlobalFunc_Arsha_Replay_Party_All_Close()
  PaGlobal_Arsha_Replay_Party_All:prepareClose()
end
function PaGlobalFunc_Arsha_Replay_Party_All_Resize()
  PaGlobal_Arsha_Replay_Party_All:resize()
end
function PaGlobalFunc_Arsha_Replay_Party_All_Setting(teamNo)
  PaGlobal_Arsha_Replay_Party_All:setting(teamNo)
end
function FromClient_Arsha_Replay_Party_All_UpdateUserHP()
  PaGlobal_Arsha_Replay_Party_All:updateUserHP()
end
function FromClient_Arsha_Party_All_SetMember(teamNo, actorKeyRaw)
  PaGlobal_Arsha_Replay_Party_All:setMember(teamNo, actorKeyRaw)
end
function FromClient_Arsha_Replay_Party_All_Create()
  PaGlobalFunc_Arsha_Party_All_Resize()
  PaGlobal_Arsha_Replay_Party_All:createTeamUi()
end
function FromClient_Arsha_Replay_Party_All_Close()
  PaGlobalFunc_Arsha_Replay_Party_All_Close()
end
