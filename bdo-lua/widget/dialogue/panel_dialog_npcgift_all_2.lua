function PaGlobalFunc_DialogNpcGift_All_Open()
  PaGlobal_DialogNpcGift_All:prepareOpen()
end
function PaGlobalFunc_DialogNpcGift_All_Close()
  PaGlobal_DialogNpcGift_All:prepareClose()
end
function HandleEventOnOut_DialogNpcGift_All_InterestItemTooltip(idx)
  if nil == idx then
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_hideTooltip()
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
    return
  end
  local needSS = ToClient_getInterestNpcGift(idx)
  if nil == needSS then
    return
  end
  if nil == Panel_Dialog_NpcGift_All then
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show(needSS, Panel_Dialog_NpcGift_All, true, false)
  else
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, needSS, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventOnOut_DialogNpcGift_All_EnableItemTooltip(itemKey, whereType, slotIdx, isShow)
  if false == isShow then
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_hideTooltip()
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
    return
  end
  if nil == itemKey then
    return
  end
  if nil == Panel_Dialog_NpcGift_All then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotIdx)
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show(itemWrapper, Panel_Dialog_NpcGift_All, false, true)
  else
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventLUp_DialogNpcGift_All_SelectItem(slotIdx, count)
  if nil == slotIdx then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_DialogNpcGift_All._whereType, slotIdx)
  if nil == itemWrapper then
    return
  end
  PaGlobal_DialogNpcGift_All._slotNo = slotIdx
  PaGlobal_DialogNpcGift_All._presentItemName = itemWrapper:getStaticStatus():getName()
  PaGlobal_DialogNpcGift_All._count = 0
  if 1 == count then
    PaGlobalFunc_DialogNpcGift_All_PresentItemSetting(count)
  else
    Panel_NumberPad_Show(true, toInt64(0, count), 0, PaGlobalFunc_DialogNpcGift_All_PresentItemSetting)
  end
end
function HandleEventOnOut_DialogNpcGift_All_PresentItemTooltip(isShow)
  if 0 == PaGlobal_DialogNpcGift_All._slotNo then
    return
  end
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_DialogNpcGift_All._whereType, PaGlobal_DialogNpcGift_All._slotNo)
  if nil == itemWrapper then
    return
  end
  Panel_Tooltip_Item_Show(itemWrapper:getStaticStatus(), Panel_Dialog_NpcGift_All, true, false)
end
function HandleEventLUp_DialogNpcGift_All_PresentSend()
  if 0 == PaGlobal_DialogNpcGift_All._count then
    return
  end
  local messageBoxtitle = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NPC_GIFT_CONFIRM", "itemName", tostring(PaGlobal_DialogNpcGift_All._presentItemName), "count", tostring(PaGlobal_DialogNpcGift_All._count))
  local messageBoxData = {
    title = messageBoxtitle,
    content = messageBoxMemo,
    functionYes = PaGlobalFunc_DialogNpcGift_All_PresentConfirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "middle")
end
function PaGlobalFunc_DialogNpcGift_All_PresentConfirm()
  ToClient_giveNpcGift(PaGlobal_DialogNpcGift_All._whereType, PaGlobal_DialogNpcGift_All._slotNo, PaGlobal_DialogNpcGift_All._count)
end
function HandleEventLUp_DialogNpcGift_All_Propose()
  ToClient_proposeToNpc()
end
function FromClient_DialogNpcGift_All_VaryIntimacyUpdate()
  PaGlobal_DialogNpcGift_All._count = 0
  PaGlobal_DialogNpcGift_All._slotNo = 0
  PaGlobal_DialogNpcGift_All._slotPresentItem.empty = true
  PaGlobal_DialogNpcGift_All._slotPresentItem:clearItem()
  PaGlobal_DialogNpcGift_All:updateList()
end
function FromClient_DialogNpcGift_All_SuccessProposeToNpc(npcName)
  PaGlobalFunc_DialogNpcGift_All_Close()
  local message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SUCCESS_PROPOSETONPC", "name", npcName)
  Proc_ShowMessage_Ack(message)
  if false == _ContentsGroup_NewUI_Dialog_All then
    PaGlobal_SetProposeToNpc()
  else
    PaGlobalFunc_DialogMain_All_SetProposeToNpc()
  end
end
function FromeClient_DialogNpcGift_All_OnScrenResize()
  if nil == Panel_Dialog_NpcGift_All then
    return
  end
  PaGlobal_DialogNpcGift_All:resize()
end
function PaGlobalFunc_DialogNpcGift_All_UpdateItemList(control, key)
  if nil == Panel_Dialog_NpcGift_All then
    return
  end
  local btn_list = UI.getChildControl(control, "RadioButton_ItemList")
  local stc_slotBg = UI.getChildControl(control, "Static_ItemSlotBg")
  local txt_name = UI.getChildControl(control, "StaticText_ItemName")
  local _key = Int64toInt32(key)
  if nil == PaGlobal_DialogNpcGift_All._enableList[_key] then
    return
  end
  local slotIdx = PaGlobal_DialogNpcGift_All._enableList[_key]
  local itemWrapper = getInventoryItemByType(PaGlobal_DialogNpcGift_All._whereType, slotIdx)
  local itemKey = itemWrapper:get():getKey():getItemKey()
  local itemCount = Int64toInt32(itemWrapper:get():getCount_s64())
  local enchantLevel = itemWrapper:getStaticStatus():get()._key:getEnchantLevel()
  local enchantText = ""
  if 16 <= enchantLevel then
    enchantText = HighEnchantLevel_ReplaceString(enchantLevel) .. " "
  end
  txt_name:SetTextMode(__eTextMode_AutoWrap)
  txt_name:SetText(enchantText .. itemWrapper:getStaticStatus():getName())
  PAGlobalFunc_SetItemTextColorForNewUI(txt_name, itemWrapper:getStaticStatus())
  local slot = {}
  SlotItem.reInclude(slot, "NpcGift_All_Slot_", 0, stc_slotBg, PaGlobal_DialogNpcGift_All._slotConfig)
  slot:clearItem()
  slot:setItem(itemWrapper)
  if false == PaGlobal_DialogNpcGift_All._isConsole then
    slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_DialogNpcGift_All_EnableItemTooltip(" .. itemKey .. ", " .. PaGlobal_DialogNpcGift_All._whereType .. ", " .. slotIdx .. ", true)")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_DialogNpcGift_All_EnableItemTooltip(" .. itemKey .. ", " .. PaGlobal_DialogNpcGift_All._whereType .. ", " .. slotIdx .. ", false)")
    slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogNpcGift_All_SelectItem(" .. slotIdx .. "," .. itemCount .. ")")
    btn_list:addInputEvent("Mouse_On", "HandleEventOnOut_DialogNpcGift_All_EnableItemTooltip(" .. itemKey .. ", " .. PaGlobal_DialogNpcGift_All._whereType .. ", " .. slotIdx .. ", true)")
    btn_list:addInputEvent("Mouse_Out", "HandleEventOnOut_DialogNpcGift_All_EnableItemTooltip(" .. itemKey .. ", " .. PaGlobal_DialogNpcGift_All._whereType .. ", " .. slotIdx .. ", false)")
  else
    control:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_DialogNpcGift_All_EnableItemTooltip(" .. itemKey .. ", " .. PaGlobal_DialogNpcGift_All._whereType .. ", " .. slotIdx .. ", true)")
  end
  btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogNpcGift_All_SelectItem(" .. slotIdx .. "," .. itemCount .. ")")
  btn_list:SetCheck(false)
  btn_list:setNotImpactScrollEvent(true)
end
function PaGlobalFunc_DialogNpcGift_All_PresentItemSetting(count)
  if nil == count then
    return
  end
  PaGlobal_DialogNpcGift_All._count = count
  local itemWrapper = getInventoryItemByType(PaGlobal_DialogNpcGift_All._whereType, PaGlobal_DialogNpcGift_All._slotNo)
  if nil == itemWrapper then
    return
  end
  PaGlobal_DialogNpcGift_All:setItemToSlot(PaGlobal_DialogNpcGift_All._slotPresentItem, itemWrapper:getStaticStatus(), count)
end
function HandleEventRUp_DialogNpcGift_All_PresentItemClear()
  PaGlobal_DialogNpcGift_All._count = 0
  PaGlobal_DialogNpcGift_All._slotNo = 0
  PaGlobal_DialogNpcGift_All._slotPresentItem.empty = true
  PaGlobal_DialogNpcGift_All._slotPresentItem:clearItem()
  if true == Panel_NumberPad_IsPopUp() then
    Panel_NumberPad_Close()
  end
end
