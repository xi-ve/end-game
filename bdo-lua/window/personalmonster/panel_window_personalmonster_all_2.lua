function HandleEventLUp_PersonalMonster_All_Close()
  if false == Panel_PersonalMonster_All:GetShow() then
    return
  end
  if true == PaGlobal_PersonalMonster_ALL._ui.stc_ConsoleItemList:GetShow() then
    HandleEventPadUp_PersonalMonster_All_HideRewardItem()
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
    end
    return
  end
  PaGlobal_PersonalMonster_ALL:prepareClose()
end
function HandleEventLUp_PersonalMonster_All_Open()
  if true == Panel_PersonalMonster_All:GetShow() then
    PaGlobal_PersonalMonster_ALL:prepareClose()
    return
  end
  PaGlobal_PersonalMonster_ALL:prepareOpen()
end
function HandleEventLUp_PersonalMonster_All_NavigateToMonster(reserveIndex)
  local pos = ToClient_GetReservePersonalMonsterPosition(reserveIndex)
  if nil == pos then
    return
  end
  ToClient_DeleteNaviGuideByGroup(0)
  ToClient_WorldMapNaviStart(pos, NavigationGuideParam(), false, true)
end
function HandleEventPadUp_PersonalMonster_All_ShowRewardItem(monsterKey)
  local self = PaGlobal_PersonalMonster_ALL
  local monsterKey = ToClient_GetReservePersonalMonsterKey(monsterKey)
  local monsterStatusWrapper = ToClient_GetCharacterStaticStatusWrapper(monsterKey)
  local personalMonsterWrapper = ToClient_GetPersonalMonsterWrapper(monsterKey)
  if nil ~= self._consoleRewardSlot and nil ~= monsterKey and 0 ~= monsterKey and nil ~= monsterStatusWrapper and nil ~= personalMonsterWrapper then
    PaGlobal_PersonalMonster_ALL._ui.txt_ConsoleBossName:SetText(monsterStatusWrapper:getName())
    local dropCount = personalMonsterWrapper:getDropItemCount()
    for idx = 0, dropCount do
      local itemKey = personalMonsterWrapper:getDropItemKey(idx)
      local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
      if nil ~= self._consoleRewardSlot[idx].btn then
        self._consoleRewardSlot[idx].btn:SetShow(false)
        if nil ~= itemSSW then
          self._consoleRewardSlot[idx].btn:SetShow(true)
          self._consoleRewardSlot[idx].slotIcon:setItemByStaticStatus(itemSSW)
          if true == _ContentsGroup_RenewUI_Tooltip then
            self._consoleRewardSlot[idx].btn:addInputEvent("Mouse_On", "HandleEventPadUp_PersonalMonster_All_ShowItemTooltip(" .. itemKey .. ")")
          else
            self._consoleRewardSlot[idx].btn:addInputEvent("Mouse_On", "PaGlobalFunc_PersonalMonster_All_ShowToolTip(" .. itemKey .. ")")
          end
          self._consoleRewardSlot[idx].name:SetText(itemSSW:getName())
          if self._consoleRewardSlot[idx].name:GetTextSizeX() > self._consoleRewardSlot[idx].name:GetSizeX() then
            self._consoleRewardSlot[idx].name:SetIgnore(false)
            UI.setLimitTextAndAddTooltip(self._consoleRewardSlot[idx].name)
          else
            self._consoleRewardSlot[idx].name:SetIgnore(true)
          end
          PaGlobal_PersonalMonster_ALL:convertTextToItemGradeColor(itemSSW, self._consoleRewardSlot[idx].name)
        end
      end
    end
    self._ui.stc_ConsoleItemList:SetShow(true)
  end
end
function HandleEventPadUp_PersonalMonster_All_ShowItemTooltip(itemKey)
  if nil == itemKey then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil ~= itemSSW then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, getScreenSizeX(), 0)
  end
end
function HandleEventPadUp_PersonalMonster_All_HideRewardItem()
  if false == PaGlobal_PersonalMonster_ALL._ui.stc_ConsoleItemList:GetShow() then
    return
  end
  PaGlobal_PersonalMonster_ALL._ui.stc_ConsoleItemList:SetShow(false)
end
function FromClient_PersonalMonsterAll_UpdateMonsterList()
  if true == PaGlobal_PersonalMonster_ALL._isConsole then
    return
  end
  local count = ToClient_GetReservedPersonalMonsterCount()
  for ii = 0, count - 1 do
    local infoWrapper = ToClient_GetReservedPersonalMonsterInfoWrapper(ii)
    if nil ~= infoWrapper and nil ~= Panel_UIMain then
      FromClient_updateReservePersonalMonster(infoWrapper:getCharacterKey(), infoWrapper:getPositionIndex())
    end
  end
end
function FromClient_PersonalMonster_All_UpdateList2(content, key)
  if false == Panel_PersonalMonster_All:GetShow() then
    return
  end
  PaGlobal_PersonalMonster_ALL:updateList2Control(content, key)
end
function PaGlobal_PersonalMonster_ALL_OnScreenResize()
  if false == Panel_PersonalMonster_All:GetShow() then
    return
  end
  Panel_PersonalMonster_All:ComputePos()
  PaGlobal_PersonalMonster_ALL._ui.list2_Monster:ComputePos()
  PaGlobal_PersonalMonster_ALL._ui.txt_ClosedMsg:ComputePos()
  PaGlobal_PersonalMonster_ALL._ui.stc_Desc:ComputePos()
  PaGlobal_PersonalMonster_ALL._ui.txt_Desc:ComputePos()
  PaGlobal_PersonalMonster_ALL._ui.stc_SearchMsg:ComputePos()
  if true == PaGlobal_PersonalMonster_ALL._isConsole then
    Panel_PersonalMonster_All:SetSpanSize(Panel_PersonalMonster_All:GetSpanSize().x, PaGlobal_PersonalMonster_ALL._originPanelSpanY - 140)
    PaGlobal_PersonalMonster_ALL._ui.stc_Console_KeyGuides:SetPosY(Panel_PersonalMonster_All:GetSizeY())
  end
end
function GoPersonalMonsterPos(characterKey)
  if true == isRealServiceMode() then
    return
  end
  local monsterInfoWrapper = ToClient_FindReservedPersonalMonsterInfoWrapper(characterKey)
  if nil == monsterInfoWrapper then
    Proc_ShowMessage_Ack("Not Reserved Yet")
    return
  end
  local pos = monsterInfoWrapper:getSpawnPosition()
  ToClient_WorldMapNaviStart(pos, NavigationGuideParam(), false, true)
end
function CheckPersonalMonster(characterKey)
  if true == isRealServiceMode() then
    return
  end
  local monsterInfoWrapper = ToClient_FindReservedPersonalMonsterInfoWrapper(characterKey)
  if nil == monsterInfoWrapper then
    Proc_ShowMessage_Ack("Not Reserved Yet")
    return
  end
  local option = monsterInfoWrapper:getOption()
  local characterWrapper = ToClient_GetCharacterStaticStatusWrapper(characterKey)
  local strInfo = characterKey .. "(" .. characterWrapper:getName() .. ") : "
  local lv = monsterInfoWrapper:getLevel()
  if 0 == option then
    chatting_sendMessage("", strInfo .. "Not Reserved Yet", CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
  elseif 1 == option then
    chatting_sendMessage("", strInfo .. "Spawned / Lv=" .. lv, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
  elseif 2 == option then
    chatting_sendMessage("", strInfo .. "Reserved / Lv=" .. lv, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
  elseif 3 == option then
    chatting_sendMessage("", strInfo .. "Reserved And Notified / Lv=" .. lv, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
  end
end
function CheckPersonalMonsterAll()
  if true == isRealServiceMode() then
    return
  end
  local count = ToClient_GetReservedPersonalMonsterCount()
  for ii = 0, count - 1 do
    local infoWrapper = ToClient_GetReservedPersonalMonsterInfoWrapper(ii)
    if nil ~= infoWrapper then
      CheckPersonalMonster(infoWrapper:getCharacterKey())
    end
  end
end
