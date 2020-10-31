function HandleEventLUp_Looting_All_Cancel()
  local dropType = looting_getDropType()
  if CppEnums.DropType.Type_CollectInfo == dropType or CppEnums.DropType.Type_Harvest == dropType then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_LOOT_MEMO")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_LOOT_TITLE"),
      content = messageBoxMemo,
      functionYes = FromClient_Looting_All_Cancel,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    FromClient_Looting_All_Cancel()
  end
end
function HandleEventLUp_Looting_All_LootAll(isMouseEvent)
  if false == isMouseEvent then
    if false == PaGlobal_Looting_All._ui._btn_lootAll:checkAutoDisableTime() then
      return
    end
    PaGlobal_Looting_All._ui._btn_lootAll:DoAutoDisableTime()
  end
  PaGlobal_Looting_All:initSelectSlotNo()
  looting_pickAllItemToPlayer()
  audioPostEvent_SystemUi(3, 9)
  _AudioPostEvent_SystemUiForXBOX(3, 9)
end
function HandleEventLUp_Looting_All_ServantLootAll()
  PaGlobal_Looting_All:initSelectSlotNo()
  looting_pickAllItemToServant()
end
function HandleEventLUp_Looting_All_SelectSlot(slotNo)
  PaGlobal_Looting_All:selectItem(slotNo)
end
function HandleEventRUp_Looting_All_SelectSlot(slotNo)
  PaGlobal_Looting_All:selectItem(slotNo)
end
function FromClient_Looting_All_Update(isEmpty)
  PaGlobal_Looting_All:lootingUpdate(isEmpty)
end
function FromClient_Looting_All_Cancel()
  if false == PaGloabl_Looting_All_GetShowPanel() then
    looting_cancel()
    return
  end
  PaGlobal_Looting_All:prepareClose()
  local actor = interaction_getInteractable()
  if actor ~= nil then
    Interaction_Show(actor)
  end
end
function PaGloabl_Looting_All_ShowAni()
  if nil == Panel_Window_Looting_All then
    return
  end
  Panel_Window_Looting_All:SetAlpha(0)
  UIAni.AlphaAnimationNoChild(1, Panel_Window_Looting_All, 0, 0.15)
end
function PaGloabl_Looting_All_HideAni()
  if nil == Panel_Window_Looting_All then
    return
  end
end
function PaGloabl_Looting_All_GetShowPanel()
  if nil == Panel_Window_Looting_All then
    return false
  end
  return Panel_Window_Looting_All:GetShow()
end
function PaGlobal_Looting_All_LootSlotClick(s64_count, slotNo)
  looting_slotClick(slotNo, s64_count)
end
