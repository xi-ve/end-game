function PaGlobalFunc_GuildJoinRequestList_All_Open()
  PaGlobal_GuildJoinRequestList_All:prepareOpen()
end
function PaGlobalFunc_GuildJoinRequestList_All_Close()
  PaGlobal_GuildJoinRequestList_All:prepareClose()
end
function HandleEventLUp_GuildJoinRequestList_All_Refresh()
  PaGlobal_GuildJoinRequestList_All:Refresh()
end
function FromClient_GuildJoinRequestList_All_loadCompleteGuildApplicants()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._RECRUIT) then
    return
  end
  PaGlobal_GuildJoinRequestList_All:update()
end
function FromClient_GuildJoinRequestList_All_deleteGuildApplicantGuild()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._RECRUIT) then
    return
  end
  PaGlobal_GuildJoinRequestList_All:update()
end
function PaGlobalFunc_GuildJoinRequestList_All_CreateControlList2(content, index)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._RECRUIT) then
    return
  end
  PaGlobal_GuildJoinRequestList_All:createList(content, index)
end
