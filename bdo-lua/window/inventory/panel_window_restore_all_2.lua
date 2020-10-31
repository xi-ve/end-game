function HandleEventLUp_Restore_All_Close()
  if nil == Panel_Window_Restore_All then
    return
  end
  PaGlobal_Restore_All:prepareClose()
end
function PaGlobalFunc_Restore_All_Open()
  if nil == Panel_Window_Restore_All then
    return
  end
  PaGlobal_Restore_All:prepareOpen(__eRestoreItemType_InGame)
end
function HandleEventLUp_Restore_All_Restore()
  if nil == PaGlobal_Restore_All._selectSlotNo then
    return
  end
  local itemName = MakeUpItemNameWithEnchantLevel(PaGlobal_Restore_All._restoreType, PaGlobal_Restore_All._selectSlotNo)
  local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ITEM_RESTORATION_POPUP_TITLE")
  local messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEM_RESTORATION_POPUP_CONTENT", "itemName", itemName)
  local messageBoxData = {
    title = messageTitle,
    content = messageContent,
    functionYes = Restore_Yes,
    functionNo = Restore_No,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function MakeUpItemNameWithEnchantLevel(restoreType, selectNo)
  local itemSSW = ToClient_RequestRestoreItemEnchantStaticStatusWrapperAt(restoreType, selectNo)
  if nil == itemSSW then
    return
  end
  local itemName = ""
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  if true == ToClient_IsSpecialEnchantItem(itemSSW:get()._key) then
    enchantLevel = 0
  end
  if 0 ~= enchantLevel then
    if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() then
      enchantLevel = enchantLevel + 15
    end
    if 15 < enchantLevel then
      itemName = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemSSW:getName()
    else
      itemName = "+" .. tostring(enchantLevel) .. " " .. itemSSW:getName()
    end
  else
    itemName = itemSSW:getName()
  end
  local resultItemName = PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(itemName, itemSSW)
  return resultItemName
end
function Restore_Yes()
  local restoreType = PaGlobal_Restore_All._restoreType
  local selectNo = PaGlobal_Restore_All._selectSlotNo
  ToClient_RequestRestoreItem(restoreType, selectNo)
  PaGlobal_Restore_All:updateRestoreButton()
end
function Restore_No()
  PaGlobal_Restore_All:updateRestoreButton()
end
function HandleEventLUp_Restore_All_Select(selectNo)
  PaGlobal_Restore_All._selectSlotNo = selectNo
  PaGlobal_Restore_All:updateRestoreButton()
  if PaGlobal_Restore_All._isConsole then
    HandleEventLUp_Restore_All_Restore()
  end
end
function FromClient_Restore_All_UpdateList(restoreType)
  if nil == Panel_Window_Restore_All then
    return
  end
  PaGlobal_Restore_All._restoreType = restoreType
  PaGlobal_Restore_All:updateList()
end
function FromClient_Restore_All_UpdateInfo()
  if nil == Panel_Window_Restore_All then
    return
  end
  PaGlobal_Restore_All:updateInfo()
end
function FromClient_Restore_All_ChangedRestoreReq()
  if nil == Panel_Window_Restore_All then
    return
  end
  PaGlobal_Restore_All:updateRestoreButton()
end
function FromClient_Restore_All_Reposition()
  if nil == Panel_Window_Restore_All then
    return
  end
  PaGlobal_Restore_All:reposition()
end
function PaGloabl_Restore_All_ShowAni()
  if nil == Panel_Window_Restore_All then
    return
  end
end
function PaGloabl_Restore_All_HideAni()
  if nil == Panel_Window_Restore_All then
    return
  end
end
function PaGlobal_Restore_All_CreateListControl(control, key)
  PaGlobal_Restore_All:createList(control, key)
end
function PaGloabl_Restore_All_Close()
  PaGlobal_Restore_All:prepareClose()
end
