function PaGlobalFunc_GuildWarScore_All_Open(guildNo)
  if nil == Panel_GuildWarScore_All then
    return
  end
  PaGlobal_GuildWarScore_All:prepareOpen(guildNo)
end
function PaGlobalFunc_GuildWarScore_All_Close()
  if nil == Panel_GuildWarScore_All then
    return
  end
  PaGlobal_GuildWarScore_All:prepareClose()
end
function PaGlobalFunc_GuildWarScore_All_GetShow()
  if nil == Panel_GuildWarScore_All then
    return
  end
  return Panel_GuildWarScore_All:GetShow()
end
function PaGlobalFunc_GuildWarScore_All_Update()
  if nil == Panel_GuildWarScore_All then
    return
  end
  if 0 ~= PaGlobal_GuildWarScore_All._selectedGuildNo then
    PaGlobal_GuildWarScore_All:update(PaGlobal_GuildWarScore_All._selectedGuildNo)
  end
end
function PaGlobalFunc_GuildWarInfoScore_All_UpdateScoreList(content, index)
  if nil == Panel_GuildWarScore_All then
    return
  end
  PaGlobal_GuildWarScore_All:updateScoreList(content, index)
end
function HandleEventOnOut_GuildWarScore_All_ShowTitleTooltip(isShow, index)
  if nil == Panel_GuildWarScore_All then
    return
  end
  PaGlobal_GuildWarScore_All:shopTitleTooltip(isShow, index)
end
