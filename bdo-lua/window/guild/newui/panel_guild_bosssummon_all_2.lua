function PaGlobalFunc_Guild_BossSummon_All_Update()
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  PaGlobal_Guild_BossSummon_All:update()
end
function PaGlobalFunc_Guild_BossSummon_All_CreateControlList2(content, key)
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  PaGlobal_Guild_BossSummon_All:updateList(content, key)
end
function HandleEventLUp_Guild_BossSummon_All_SelectLevel(key, isNext)
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  if nil == key or nil == isNext then
    return
  end
  PaGlobal_Guild_BossSummon_All:selectLevel(key, isNext)
end
function HandleEventLUp_Guild_BossSummon_All_RequestFindPosition(key)
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  if nil == key then
    return
  end
  PaGlobal_Guild_BossSummon_All:requestFindPosition(key)
end
function HandleEventLUp_Guild_BossSummon_All_RequestGuildBossSpawn(key)
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  if nil == key then
    return
  end
  PaGlobal_Guild_BossSummon_All:requestGuildBossSpawn(key)
end
function HandleEventOnOut_Guild_BossSummon_All_ShowItemTooltip(key, itemEnchantKey, isShow)
  if nil == Panel_Guild_BossSummon_All or true == _ContentsGroup_RenewUI_Tooltip then
    return
  end
  PaGlobal_Guild_BossSummon_All:showItemTooltip(key, itemEnchantKey, isShow)
end
function HandleEventOnOut_Guild_BossSummon_All_ShowConsoleItemTooltip(key, itemEnchantKey)
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  PaGlobal_Guild_BossSummon_All:showItemTooltip_Console(key, itemEnchantKey)
end
function HandleEventMOnOut_Guild_BossSummon_All_ShowDpadKeyGuide(showDpad, showY)
  PaGlobal_GuildMain_All:setKeyguideTextWithShow(showY, __eConsoleUIPadEvent_Y, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMPETITIONGAME_BTN_SUMMON"))
  PaGlobal_GuildMain_All:setKeyguideTextWithShow(showDpad, __eConsoleUIPadEvent_DpadLeft, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDSUMMON_LEVELSETTING_KEYGUIDE"))
end
function FromClient_BossSummon_All_UpdateStatus(key)
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  if nil == key then
    return
  end
  PaGlobal_Guild_BossSummon_All:updateState(key)
end
function FromClient_BossSummon_All_ClearCount()
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_GUILDRAID_SUMMON_RESET"))
end
