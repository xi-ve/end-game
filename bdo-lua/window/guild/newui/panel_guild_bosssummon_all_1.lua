function PaGlobal_Guild_BossSummon_All:initialize()
  if true == self._initialize or nil == Panel_Guild_BossSummon_All then
    return
  end
  self._ui.list2_BossList = UI.getChildControl(Panel_Guild_BossSummon_All, "List2_GuildBossSummon")
  self._ui.stc_BottomBG = UI.getChildControl(Panel_Guild_BossSummon_All, "Static_BottomDescArea")
  self._ui.txt_Desc = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_Desc")
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_GUILDRAID_DESC"))
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:validate()
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_Guild_BossSummon_All:registEventHandler()
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  self._ui.list2_BossList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Guild_BossSummon_All_CreateControlList2")
  self._ui.list2_BossList:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_BossSpawnUpdateStatus", "FromClient_BossSummon_All_UpdateStatus")
  registerEvent("FromClient_BossSpawnClearCount", "FromClient_BossSummon_All_ClearCount")
end
function PaGlobal_Guild_BossSummon_All:prepareOpen()
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  self:open()
end
function PaGlobal_Guild_BossSummon_All:open()
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  Panel_Guild_BossSummon_All:SetShow(true)
end
function PaGlobal_Guild_BossSummon_All:prepareClose()
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  self:close()
end
function PaGlobal_Guild_BossSummon_All:close()
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  Panel_Guild_BossSummon_All:SetShow(false)
end
function PaGlobal_Guild_BossSummon_All:update()
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  ToClient_padSnapResetControl()
  local bossList = ToClient_bossSpawnList()
  if nil == bossList then
    return
  end
  self._ui.list2_BossList:getElementManager():clearKey()
  for ii = 0, #bossList do
    self._ui.list2_BossList:getElementManager():pushKey(bossList[ii]:get())
  end
  self._ui.list2_BossList:ComputePos()
  self._bossInfoList = Array.new()
end
function PaGlobal_Guild_BossSummon_All:validate()
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  self._ui.list2_BossList:isValidate()
  self._ui.stc_BottomBG:isValidate()
  self._ui.txt_Desc:isValidate()
end
function PaGlobal_Guild_BossSummon_All:setBossLevel(key, level)
  local info = self._bossInfoList[key]
  if nil == info then
    return
  end
  local bossKey = BossSpawnKey(key)
  if nil == bossKey then
    return
  end
  local optionWrapper = ToClient_bossSpawnOptionWrapper(bossKey, level)
  if nil == optionWrapper then
    return
  end
  info.stc_MainBG:ChangeTextureInfoName(optionWrapper:getImagePath())
  local x1, y1, x2, y2 = setTextureUV_Func(info.stc_MainBG, 0, 0, info.stc_MainBG:GetSizeX(), info.stc_MainBG:GetSizeY())
  info.stc_MainBG:getBaseTexture():setUV(x1, y1, x2, y2)
  info.stc_MainBG:setRenderTexture(info.stc_MainBG:getBaseTexture())
  info.txt_Level:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_BOSSSUMON_DIFFICULTYCOUNT", "diffy", tostring(level)))
  local itemSSW = getItemEnchantStaticStatus(optionWrapper:getItemEnchantKey())
  if nil ~= itemSSW then
    info.stc_RewardIcon:ChangeTextureInfoNameDefault("Icon/" .. itemSSW:getIconPath())
    if true == self._isConsole then
      if true == _ContentsGroup_RenewUI_Tooltip then
        info.btn_Template:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Guild_BossSummon_All_ShowConsoleItemTooltip(" .. key .. "," .. optionWrapper:getItemEnchantKey():get() .. ")")
      else
        info.btn_Template:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Guild_BossSummon_All_ShowItemTooltip(" .. key .. "," .. optionWrapper:getItemEnchantKey():get() .. ", true)")
        info.btn_Template:addInputEvent("Mouse_Out", "HandleEventOnOut_Guild_BossSummon_All_ShowItemTooltip(" .. key .. "," .. optionWrapper:getItemEnchantKey():get() .. ", false)")
      end
    else
      info.stc_RewardIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Guild_BossSummon_All_ShowItemTooltip(" .. key .. "," .. optionWrapper:getItemEnchantKey():get() .. ", true)")
      info.stc_RewardIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Guild_BossSummon_All_ShowItemTooltip(" .. key .. "," .. optionWrapper:getItemEnchantKey():get() .. ", false)")
    end
  end
  info.txt_BossName:SetText(tostring(optionWrapper:getCharacterName()))
  self._bossInfoList[key].level = level
end
function PaGlobal_Guild_BossSummon_All:selectLevel(key, isNext)
  local info = self._bossInfoList[key]
  if nil == info then
    return
  end
  local level = info.level
  local bossKey = BossSpawnKey(key)
  if true == isNext then
    level = level + 1
    local maxLevel = ToClient_bossSpawnMaxLevel(bossKey)
    if level >= maxLevel - 1 then
      level = maxLevel - 1
      info.btn_Level_Next:SetShow(false)
    end
    info.btn_Level_Prev:SetShow(true)
  else
    level = level - 1
    if level <= 0 then
      level = 0
      info.btn_Level_Prev:SetShow(false)
    end
    info.btn_Level_Next:SetShow(true)
  end
  self:setBossLevel(key, level)
end
function PaGlobal_Guild_BossSummon_All:isBossSpawnArea(key)
  if nil == getSelfPlayer() then
    return false
  end
  local selfPlayer = getSelfPlayer():get()
  if nil == selfPlayer then
    return false
  end
  local info = self._bossInfoList[key]
  if nil == info then
    return false
  end
  local pos = selfPlayer:getPosition()
  local dist = (pos.x - info.x) * (pos.x - info.x) + (pos.y - info.y) * (pos.y - info.y) + (pos.z - info.z) * (pos.z - info.z)
  local sour = info.range * info.range
  return dist < sour
end
function PaGlobal_Guild_BossSummon_All:getState(key, currentCost, maxCost, currentCount, maxCount)
  if maxCount <= currentCount then
    return self._state.CLEAR
  elseif currentCost < maxCost then
    return self._state.NOTREADY
  else
    local isAreaIn = self:isBossSpawnArea(key)
    if true == isAreaIn then
      return self._state.READY
    else
      return self._state.GOPOSITION
    end
  end
end
function PaGlobal_Guild_BossSummon_All:updateState(key)
  local info = self._bossInfoList[key]
  if nil == info then
    return
  end
  local bossKey = BossSpawnKey(key)
  if nil == bossKey then
    return
  end
  local currentCost = 0
  local currentCount = 0
  local maxCost = ToClient_bossSpawnMaxCost(bossKey)
  local maxCount = ToClient_bossSpawnMaxCount(bossKey)
  local maxLevel = ToClient_bossSpawnMaxLevel(bossKey)
  local infoWrapper = ToClient_bossSpawnStatusWrapper(bossKey)
  if nil ~= infoWrapper then
    currentCost = infoWrapper:getCurrentCost()
    currentCount = infoWrapper:getCurrentCount()
  end
  info.txt_Count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_BOSSSUMON_SUMMONCOUNT", "summonCount", tostring(maxCount - currentCount) .. "/" .. tostring(maxCount)))
  info.txt_Cost:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_BOSSSUMON_QUESTCOMPLETECOUNT", "questCompleteCount", tostring(currentCost) .. "/" .. tostring(maxCost)))
  local currentState = self:getState(key, currentCost, maxCost, currentCount, maxCount)
  if info.state == currentState then
    return
  end
  info.btn_FindPos:SetShow(false)
  info.btn_Summon:SetShow(false)
  info.txt_Cost:SetShow(false)
  info.stc_SuccessImg:SetShow(false)
  info.stc_LevelBg:SetShow(false)
  info.txt_Condition:SetShow(false)
  if currentState == self._state.NOTREADY then
    info.txt_Cost:SetShow(true)
    info.txt_Condition:SetShow(true)
  elseif currentState == self._state.GOPOSITION then
    info.btn_FindPos:SetShow(true)
    info.btn_Summon:SetShow(true)
    info.btn_Summon:SetMonoTone(true)
    info.btn_Summon:SetIgnore(true)
  elseif currentState == self._state.READY then
    info.btn_FindPos:SetShow(true)
    info.btn_Summon:SetShow(true)
    info.btn_Summon:SetMonoTone(false)
    info.btn_Summon:SetIgnore(false)
    info.stc_LevelBg:SetShow(true)
  elseif currentState == self._state.CLEAR then
    info.stc_SuccessImg:SetShow(true)
  end
  if true == self._isConsole then
    if currentState == self._state.GOPOSITION or currentState == self._state.READY then
      info.btn_Template:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Guild_BossSummon_All_RequestFindPosition(" .. key .. ")")
    end
    if currentState == self._state.READY then
      info.btn_Template:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Guild_BossSummon_All_RequestGuildBossSpawn(" .. key .. ")")
      info.btn_Template:registerPadEvent(__eConsoleUIPadEvent_Up_DpadLeft, "HandleEventLUp_Guild_BossSummon_All_SelectLevel(" .. key .. ", false)")
      info.btn_Template:registerPadEvent(__eConsoleUIPadEvent_Up_DpadRight, "HandleEventLUp_Guild_BossSummon_All_SelectLevel(" .. key .. ", true)")
    end
    info.btn_Summon:SetShow(false)
    info.btn_FindPos:SetShow(false)
    if currentState == self._state.READY then
      info.stc_LevelBg:SetPosY(info.txt_Condition:GetPosY())
      if 1 < maxLevel then
        info.btn_Template:addInputEvent("Mouse_On", "HandleEventMOnOut_Guild_BossSummon_All_ShowDpadKeyGuide(true , true)")
      else
        info.btn_Template:addInputEvent("Mouse_On", "HandleEventMOnOut_Guild_BossSummon_All_ShowDpadKeyGuide(false , true)")
      end
    else
      info.btn_Template:addInputEvent("Mouse_On", "HandleEventMOnOut_Guild_BossSummon_All_ShowDpadKeyGuide(false ,false)")
    end
  else
    info.btn_FindPos:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_BossSummon_All_RequestFindPosition(" .. key .. ")")
    info.btn_Summon:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_BossSummon_All_RequestGuildBossSpawn(" .. key .. ")")
    info.btn_Level_Prev:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_BossSummon_All_SelectLevel(" .. key .. ", false)")
    info.btn_Level_Next:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_BossSummon_All_SelectLevel(" .. key .. ", true)")
  end
  if currentState == self._state.CLEAR then
    info.stc_RewardSlotBg:SetPosY(info.stc_MainBG:GetPosY() + (info.stc_MainBG:GetSizeY() - info.stc_RewardSlotBg:GetSizeY()) / 2)
    info.stc_SuccessImg:SetPosY(info.stc_MainBG:GetPosY() + (info.stc_MainBG:GetSizeY() - info.stc_SuccessImg:GetSizeY()) / 2)
  else
    info.stc_RewardSlotBg:ComputePos()
    info.stc_SuccessImg:ComputePos()
  end
  if true == self._isConsole and currentState == self._state.READY and maxLevel == 1 then
    info.stc_RewardSlotBg:SetPosY(info.stc_MainBG:GetPosY() + (info.stc_MainBG:GetSizeY() - info.stc_RewardSlotBg:GetSizeY()) / 2)
    info.stc_LevelBg:SetShow(false)
  end
  self._bossInfoList[key].state = currentState
end
function PaGlobal_Guild_BossSummon_All:updateList(content, key)
  local bossKey = BossSpawnKey(Int64toInt32(key))
  local level = 0
  local btn_Template = UI.getChildControl(content, "Button_Template")
  local stc_MainBG = UI.getChildControl(btn_Template, "Static_BG")
  local txt_Count = UI.getChildControl(btn_Template, "StaticText_Count")
  local txt_BossName = UI.getChildControl(btn_Template, "StaticText_BossName")
  local txt_Cost = UI.getChildControl(btn_Template, "StaticText_Stack")
  local stc_RewardSlotBg = UI.getChildControl(btn_Template, "Static_Reward")
  local stc_RewardIcon = UI.getChildControl(stc_RewardSlotBg, "Static_ItemIcon")
  local btn_FindPos = UI.getChildControl(btn_Template, "Button_FindPlace")
  local btn_Summon = UI.getChildControl(btn_Template, "Button_Summon")
  btn_FindPos:SetShow(false)
  btn_Summon:SetShow(false)
  local stc_SuccessImg = UI.getChildControl(btn_Template, "Static_Success")
  local stc_LevelBg = UI.getChildControl(btn_Template, "Static_DifficultyArea")
  local txt_Level = UI.getChildControl(stc_LevelBg, "StaticText_DifficultyName")
  local btn_Level_Prev = UI.getChildControl(stc_LevelBg, "Button_Left")
  local btn_Level_Next = UI.getChildControl(stc_LevelBg, "Button_Right")
  btn_Level_Prev:SetShow(false)
  btn_Level_Next:SetShow(true)
  local txt_Condition = UI.getChildControl(btn_Template, "StaticText_Condition")
  local pos = ToClient_bossSpawnPosition(bossKey)
  local range = ToClient_bossSpawnRange(bossKey)
  local info = {
    x = 0,
    y = 0,
    z = 0,
    range = 0,
    state = -1,
    level = 0,
    btn_Template = nil,
    stc_MainBG = nil,
    txt_Count = nil,
    txt_BossName = nil,
    txt_Cost = nil,
    stc_RewardSlotBg = nil,
    stc_RewardIcon = nil,
    btn_FindPos = nil,
    btn_Summon = nil,
    stc_SuccessImg = nil,
    stc_LevelBg = nil,
    txt_Level = nil,
    btn_Level_Prev = nil,
    btn_Level_Next = nil,
    txt_Condition = nil
  }
  info.x = pos.x
  info.y = pos.y
  info.z = pos.z
  info.range = range
  info.btn_Template = btn_Template
  info.stc_MainBG = stc_MainBG
  info.txt_Count = txt_Count
  info.txt_BossName = txt_BossName
  info.txt_Cost = txt_Cost
  info.stc_RewardSlotBg = stc_RewardSlotBg
  info.stc_RewardIcon = stc_RewardIcon
  info.btn_FindPos = btn_FindPos
  info.btn_Summon = btn_Summon
  info.stc_SuccessImg = stc_SuccessImg
  info.stc_LevelBg = stc_LevelBg
  info.txt_Level = txt_Level
  info.btn_Level_Prev = btn_Level_Prev
  info.btn_Level_Next = btn_Level_Next
  info.txt_Condition = txt_Condition
  self._bossInfoList[bossKey:get()] = info
  self:setBossLevel(bossKey:get(), level)
  self:updateState(bossKey:get())
end
function PaGlobal_Guild_BossSummon_All:requestFindPosition(key)
  local info = self._bossInfoList[key]
  if nil == info then
    return
  end
  local pos = ToClient_bossSpawnPosition(BossSpawnKey(key))
  ToClient_DeleteNaviGuideByGroup(0)
  ToClient_WorldMapNaviStart(pos, NavigationGuideParam(), false, false)
end
function PaGlobal_Guild_BossSummon_All:requestGuildBossSpawn(key)
  local info = self._bossInfoList[key]
  if nil == info then
    return
  end
  ToClient_requestBossSpawn(BossSpawnKey(key), info.level)
end
function PaGlobal_Guild_BossSummon_All:showItemTooltip(key, itemEnchantKey, isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local info = self._bossInfoList[key]
  if nil == info then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  local control = info.stc_RewardIcon
  if nil ~= itemSSW and nil ~= control then
    Panel_Tooltip_Item_Show(itemSSW, control, true)
  end
end
function PaGlobal_Guild_BossSummon_All:showItemTooltip_Console(key, itemEnchantKey)
  if true == Panel_Widget_Tooltip_Renew:GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local info = self._bossInfoList[key]
  if nil == info then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  if nil ~= itemSSW then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
