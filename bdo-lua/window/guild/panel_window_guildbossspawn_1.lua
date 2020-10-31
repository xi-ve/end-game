function PaGlobal_GuildBossSpawn:init()
  if nil == Panel_Window_Guild then
    return
  end
  self._ui._guildBG = UI.getChildControl(Panel_Window_Guild, "Static_Frame_BossSpawn")
  self._ui._list2_bossList = UI.getChildControl(Panel_Window_GuildBossSpawn, "List2_GuildBossSummon")
  self._ui._list2_bossList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_GuildBossList_CreateControlList2")
  self._ui._list2_bossList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._guildBG:MoveChilds(self._ui._guildBG:GetID(), Panel_Window_GuildBossSpawn)
  registerEvent("FromClient_BossSpawnUpdateStatus", "FromClient_BossSpawnUpdateStatus")
  registerEvent("FromClient_BossSpawnClearCount", "FromClient_BossSpawnClearCount")
end
function PaGlobal_GuildBossSpawn:open()
  if nil == Panel_Window_Guild then
    return
  end
  local bossList = ToClient_bossSpawnList()
  if nil == bossList then
    return
  end
  self._ui._list2_bossList:getElementManager():clearKey()
  for ii = 0, #bossList do
    self._ui._list2_bossList:getElementManager():pushKey(bossList[ii]:get())
  end
  self._ui._list2_bossList:ComputePos()
  self._bossSpawnInfoList = Array.new()
  self._ui._guildBG:SetShow(true)
end
function PaGlobal_GuildBossSpawn:close()
  if nil == Panel_Window_Guild then
    return
  end
  self._ui._guildBG:SetShow(false)
end
function PaGlobal_GuildBossSpawn:setBossInfo(key, level)
end
function PaGlobal_GuildBossSpawn:requestFindPosition(key)
  local pos = ToClient_bossSpawnPosition(BossSpawnKey(key))
  ToClient_DeleteNaviGuideByGroup(0)
  ToClient_WorldMapNaviStart(pos, NavigationGuideParam(), false, false)
end
function PaGlobal_GuildBossSpawn:isBossSpawnArea(key)
  if nil == getSelfPlayer() then
    return false
  end
  local selfPlayer = getSelfPlayer():get()
  if nil == selfPlayer then
    return false
  end
  local m = self._bossSpawnInfoList[key]
  if nil == m then
    return false
  end
  local p = selfPlayer:getPosition()
  local dist = (p.x - m.x) * (p.x - m.x) + (p.y - m.y) * (p.y - m.y) + (p.z - m.z) * (p.z - m.z)
  local sour = m.range * m.range
  return dist < sour
end
function PaGlobal_GuildBossSpawn:getState(key, currentCost, maxCost, currentCount, maxCount)
  if maxCount <= currentCount then
    return self._state.Clear
  elseif currentCost < maxCost then
    return self._state.NotReady
  else
    local isAreaIn = self:isBossSpawnArea(key)
    if true == isAreaIn then
      return self._state.Ready
    else
      return self._state.GoPostion
    end
  end
end
function PaGlobal_GuildBossSpawn:updateState(key)
  if nil == Panel_Window_Guild then
    return
  end
  if nil == self._ui._guildBG then
    return
  end
  if false == self._ui._guildBG:GetShow() then
    return
  end
  local info = self._bossSpawnInfoList[key]
  if nil == info then
    return
  end
  local bossKey = BossSpawnKey(key)
  local currentCost = 0
  local maxCost = ToClient_bossSpawnMaxCost(bossKey)
  local currentCount = 0
  local maxCount = ToClient_bossSpawnMaxCount(bossKey)
  local infoWrapper = ToClient_bossSpawnStatusWrapper(bossKey)
  if nil ~= infoWrapper then
    currentCost = infoWrapper:getCurrentCost()
    currentCount = infoWrapper:getCurrentCount()
  end
  info.txt_count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_BOSSSUMON_SUMMONCOUNT", "summonCount", tostring(maxCount - currentCount) .. "/" .. tostring(maxCount)))
  info.txt_cost:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_BOSSSUMON_QUESTCOMPLETECOUNT", "questCompleteCount", tostring(currentCost) .. "/" .. tostring(maxCost)))
  local currentState = self:getState(key, currentCost, maxCost, currentCount, maxCount)
  if info.state == currentState then
    return
  end
  info.btn_findPos:SetShow(false)
  info.btn_summon:SetShow(false)
  info.txt_cost:SetShow(false)
  info.successImg:SetShow(false)
  info.levelBg:SetShow(false)
  info.txt_condition:SetShow(false)
  if currentState == self._state.NotReady then
    info.txt_cost:SetShow(true)
    info.txt_condition:SetShow(true)
  elseif currentState == self._state.GoPostion then
    info.btn_findPos:SetShow(true)
    info.btn_summon:SetShow(true)
    info.btn_summon:SetMonoTone(true)
    info.btn_summon:SetIgnore(true)
  elseif currentState == self._state.Ready then
    info.btn_findPos:SetShow(true)
    info.btn_summon:SetShow(true)
    info.btn_summon:SetMonoTone(false)
    info.btn_summon:SetIgnore(false)
    info.levelBg:SetShow(true)
  else
    if currentState == self._state.Clear then
      info.successImg:SetShow(true)
    else
    end
  end
  self._bossSpawnInfoList[key].state = currentState
end
function PaGlobal_GuildBossSpawn:requestGuildBossSpawn(key)
  local info = self._bossSpawnInfoList[key]
  if nil == info then
    return
  end
  ToClient_requestBossSpawn(BossSpawnKey(key), info.level)
end
function PaGlobal_GuildBossSpawn:selectLevelPrev(key)
  local info = self._bossSpawnInfoList[key]
  if nil == info then
    return
  end
  local level = info.level
  local bossKey = BossSpawnKey(key)
  level = level - 1
  if level <= 0 then
    level = 0
    info.btn_level_prev:SetShow(false)
  end
  info.btn_level_next:SetShow(true)
  self:selectLevel(key, level)
end
function PaGlobal_GuildBossSpawn:selectLevelNext(key)
  local info = self._bossSpawnInfoList[key]
  if nil == info then
    return
  end
  local level = info.level
  local bossKey = BossSpawnKey(key)
  local maxLevel = ToClient_bossSpawnMaxLevel(bossKey)
  level = level + 1
  if level >= maxLevel - 1 then
    level = maxLevel - 1
    info.btn_level_next:SetShow(false)
  end
  info.btn_level_prev:SetShow(true)
  self:selectLevel(key, level)
end
function PaGlobal_GuildBossSpawn:selectLevel(key, level)
  local info = self._bossSpawnInfoList[key]
  if nil == info then
    return
  end
  local bossKey = BossSpawnKey(key)
  local optionWrapper = ToClient_bossSpawnOptionWrapper(bossKey, level)
  if nil == optionWrapper then
    return
  end
  info.mainBg:ChangeTextureInfoName(optionWrapper:getImagePath())
  local x1, y1, x2, y2 = setTextureUV_Func(info.mainBg, 0, 0, info.mainBg:GetSizeX(), info.mainBg:GetSizeY())
  info.mainBg:getBaseTexture():setUV(x1, y1, x2, y2)
  info.mainBg:setRenderTexture(info.mainBg:getBaseTexture())
  info.txt_level:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_BOSSSUMON_DIFFICULTYCOUNT", "diffy", tostring(level)))
  local itemSSW = getItemEnchantStaticStatus(optionWrapper:getItemEnchantKey())
  if nil ~= itemSSW then
    info.rewardIcon:ChangeTextureInfoNameDefault("Icon/" .. itemSSW:getIconPath())
    info.rewardIcon:addInputEvent("Mouse_On", "PaGlobal_GuildBossSpawn:itemTooltipShow(" .. key .. "," .. optionWrapper:getItemEnchantKey():get() .. ", 0)")
    info.rewardIcon:addInputEvent("Mouse_Out", "PaGlobal_GuildBossSpawn:itemTooltipHide()")
  end
  info.txt_bossName:SetText(tostring(optionWrapper:getCharacterName()))
  self._bossSpawnInfoList[key].level = level
end
function PaGlobal_GuildBossSpawn:itemTooltipShow(key, itemEnchantKey)
  local info = self._bossSpawnInfoList[key]
  if nil == info then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  local control = info.rewardIcon
  if nil ~= itemSSW and nil ~= control then
    Panel_Tooltip_Item_Show(itemSSW, control, true)
  end
end
function PaGlobal_GuildBossSpawn:itemTooltipHide()
  Panel_Tooltip_Item_hideTooltip()
end
