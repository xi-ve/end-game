function PaGlobal_Endurance_Recovery_All_Open()
  if nil ~= Panel_Window_Endurance_Recovery_All and true == Panel_Window_Endurance_Recovery_All:GetShow() then
    PaGlobal_Endurance_Recovery_All_Close()
  else
    Inventory_SetFunctor(nil, nil, nil, nil)
    InventoryWindow_Close()
    if false == PaGlobal_Endurance_Recovery_All._isConsole then
      if true == _ContentsGroup_NewUI_Equipment_All then
        Panel_Window_Equipment_All:SetShow(false)
      else
        Panel_Equipment:SetShow(false)
      end
    end
    PaGlobal_Endurance_Recovery_All:prepareOpen()
  end
end
function PaGlobal_Endurance_Recovery_All_Close()
  PaGlobal_Endurance_Recovery_All:prepareClose()
end
function PaGlobal_Endurance_Recovery_All_CloseSetting()
  if false == PaGlobal_Endurance_Recovery_All._isConsole then
    InventoryWindow_Show(true)
    if true == _ContentsGroup_NewUI_Inventory_All then
      PaGlobalFunc_Inventory_All_PosLoad()
    else
      Inventory_PosLoadMemory()
    end
    if true == _ContentsGroup_NewUI_Equipment_All then
      PaGlobalFunc_Equipment_All_BesideInvenPos()
    else
      Equipment_BesideInvenPos()
    end
  end
  if true == _ContentsGroup_NewUI_RepairFunction_All then
    Inventory_SetFunctor(PaGlobalFunc_RepairFunc_All_InvenFilter, PaGlobalFunc_RepairFunc_All_InvenRClick, PaGlobalFunc_RepairFunc_All_Close, nil)
  else
    Inventory_SetFunctor(Repair_InvenFilter, Repair_InvenRClick, handleMClickedRepairExitButton, nil)
  end
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      Panel_Window_Equipment_All:SetShow(true, true)
    else
      Panel_Equipment:SetShow(true, true)
    end
  end
  TooltipSimple_Hide()
  HandleEventRUp_Endurance_Recovery_All_ClearAllSlot()
end
function HandleEventLUp_Endurance_Recovery_All_OnceRecovery()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer or nil == PaGlobal_Endurance_Recovery_All._materialItemKey then
    return
  end
  if true == PaGlobal_Endurance_Recovery_All._isStreamRecovery and true == PaGlobal_Endurance_Recovery_All._isRecovery then
    return
  elseif false == PaGlobal_Endurance_Recovery_All._isStreamRecovery and true == PaGlobal_Endurance_Recovery_All._isRecovery then
    PaGlobal_Endurance_Recovery_All._isRecovery = false
  end
  local hasCashItem = doHaveContentsItem(27, 0, false)
  if false == hasCashItem and true == PaGlobal_Endurance_Recovery_All._isUseCashItem then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FIXEQUIP_USECASHALL"))
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, PaGlobal_Endurance_Recovery_All._recoveryItemSlotNo)
  if nil == itemWrapper then
    return
  end
  local memoryFlagRecoveryCount = itemWrapper:getStaticStatus():get()._repairEnduranceCount
  local maxEndurance
  local currentEndurance = itemWrapper:get():getEndurance()
  if false == itemWrapper:getStaticStatus():get():isUnbreakable() then
    maxEndurance = itemWrapper:getStaticStatus():get():getMaxEndurance()
  end
  function funcYesExe()
    PaGlobal_Endurance_Recovery_All._isRecovery = true
    local whereType = CppEnums.ItemWhereType.eInventory
    local materialItemSlotNo = PaGlobal_Endurance_Recovery_All:getMaterialFirstItem(PaGlobal_Endurance_Recovery_All._materialItemKey)
    repair_MaxEndurance(whereType, PaGlobal_Endurance_Recovery_All._recoveryItemSlotNo, whereType, materialItemSlotNo, whereType, PaGlobal_Endurance_Recovery_All._isUseCashItem)
    PaGlobal_Endurance_Recovery_All._s64_allWeight = selfPlayer:get():getCurrentWeight_s64()
    PaGlobal_Endurance_Recovery_All_RepeatRecovery()
  end
  function funNoExe()
    PaGlobal_Endurance_Recovery_All._isRecovery = false
    PaGlobal_Endurance_Recovery_All._isStreamRecovery = false
  end
  local repairAmount = ToClient_getRepairMaxEnduranceCount(PaGlobal_Endurance_Recovery_All._repairItemKey, PaGlobal_Endurance_Recovery_All._materialItemKey)
  local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_FIXEQUIP_ONLYITEMCHECK_CONTENTSTRING")
  local isMemoryFlag = PaGlobal_Endurance_Recovery_All._materialItemKey:getItemKey() == PaGlobal_Endurance_Recovery_All._materialEnchantKey.memoryFlag:getItemKey()
  local isSameItem = PaGlobal_Endurance_Recovery_All._repairItemKey:getItemKey() == PaGlobal_Endurance_Recovery_All._materialItemKey:getItemKey()
  local count = 10
  if true == isMemoryFlag then
    count = memoryFlagRecoveryCount
  elseif false == isSameItem then
    count = repairAmount
  end
  if true == PaGlobal_Endurance_Recovery_All._isUseCashItem then
    count = count * 5
  end
  contentString = contentString .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FIXEQUIP_CONTROL_MAXENDURANCERECOVERYCOUNT", "count", count)
  if true == PaGlobal_Endurance_Recovery_All._isUseCashItem and maxEndurance - currentEndurance < 15 then
    contentString = PAGetString(Defines.StringSheet_GAME, "LUA_FIXEQUIP_DURABILITY_SHORTAGE") .. contentString
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = funcYesExe,
    functionCancel = funNoExe,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_Endurance_Recovery_All_StreamRecovery()
  if false == PaGlobal_Endurance_Recovery_All._fromSlotOn then
    return
  end
  if false == PaGlobal_Endurance_Recovery_All._isStreamRecovery then
    PaGlobal_Endurance_Recovery_All._isRecovery = false
  end
  PaGlobal_Endurance_Recovery_All._isStreamRecovery = true
  HandleEventLUp_Endurance_Recovery_All_OnceRecovery()
end
function PaGlobal_Endurance_Recovery_All_RepeatRecovery()
  if nil == Panel_Window_Endurance_Recovery_All or false == Panel_Window_Endurance_Recovery_All:GetShow() then
    return
  end
  if false == PaGlobal_Endurance_Recovery_All._isStreamRecovery then
    return
  end
  if false == _ContentsGroup_NewUI_BlackSmith_All then
    return
  end
  if getSelfPlayer():get():getCurrentWeight_s64() < PaGlobal_Endurance_Recovery_All._s64_allWeight then
    PaGlobal_Endurance_Recovery_All._s64_allWeight = getSelfPlayer():get():getCurrentWeight_s64()
  else
    return
  end
  local hasCashItem = doHaveContentsItem(27, 0, false)
  if false == hasCashItem and true == PaGlobal_Endurance_Recovery_All._isUseCashItem then
    return
  end
  local whereType = CppEnums.ItemWhereType.eInventory
  local mainItemWrapper = getInventoryItemByType(whereType, PaGlobal_Endurance_Recovery_All._recoveryItemSlotNo)
  local materialItemSlotNo = PaGlobal_Endurance_Recovery_All:getMaterialFirstItem(PaGlobal_Endurance_Recovery_All._materialItemKey)
  if nil ~= materialItemSlotNo and false == mainItemWrapper:checkToRepairItemMaxEndurance() then
    repair_MaxEndurance(whereType, PaGlobal_Endurance_Recovery_All._recoveryItemSlotNo, whereType, materialItemSlotNo, whereType, PaGlobal_Endurance_Recovery_All._isUseCashItem)
  else
    PaGlobal_Endurance_Recovery_All._isStreamRecovery = false
    PaGlobal_Endurance_Recovery_All:clearAllSlot()
  end
end
function HandleEventLUp_Endurance_Recovery_All_SelectListItem(key)
  if false == PaGlobal_Endurance_Recovery_All._isConsole then
    HandleEventLUp_Endurance_Recovery_All_RecoveryItem(key)
  else
    local slotNo = PaGlobal_Endurance_Recovery_All._recoveryItemInfo.slotNo[key]
    if PaGlobal_Endurance_Recovery_All._selectedItemSlotNo == slotNo then
      HandleEventRUp_Endurance_Recovery_All_ClearAllSlot()
      PaGlobal_Endurance_Recovery_All._ui.list2_recoveryList:requestUpdateVisible()
    else
      HandleEventLUp_Endurance_Recovery_All_RecoveryItem(key)
    end
    PaGlobal_Endurance_Recovery_All_ShowDetailKeyGuide(true, key)
  end
end
function HandleEventLUp_Endurance_Recovery_All_SelectMaterialListItem(key)
  if false == PaGlobal_Endurance_Recovery_All._isConsole then
    HandleEventLUp_Endurance_Recovery_All_MaterialItem(key)
  else
    local slotNo = PaGlobal_Endurance_Recovery_All._materialItemInfo.slotNo[key]
    if PaGlobal_Endurance_Recovery_All._selectedMaterialSlotNo == slotNo then
      HandleEventRUp_Endurance_Recovery_All_ClearMaterialSlot()
    else
      HandleEventLUp_Endurance_Recovery_All_MaterialItem(key)
    end
    PaGlobal_Endurance_Recovery_All_ShowDetailKeyGuideMaterial(true, key)
  end
end
function HandleEventLUp_Endurance_Recovery_All_RecoveryItem(key)
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Endurance_Recovery_All_RecoveryItem\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  PaGlobal_Endurance_Recovery_All._isStreamRecovery = false
  local slotNo = PaGlobal_Endurance_Recovery_All._recoveryItemInfo.slotNo[key]
  local itemWrapper = getInventoryItemByType(0, slotNo)
  PaGlobal_Endurance_Recovery_All._selectedItemSlotNo = slotNo
  PaGlobal_Endurance_Recovery_All:setRecoveryIcon(itemWrapper, slotNo)
  PaGlobal_Endurance_Recovery_All:clearMaterialSlot()
  for index = 1, PaGlobal_Endurance_Recovery_All._recoveryItemCnt do
    PaGlobal_Endurance_Recovery_All._recoveryItemInfo.isRecoveryEquip[index] = false
  end
  for index = 1, PaGlobal_Endurance_Recovery_All._materialItemCnt do
    PaGlobal_Endurance_Recovery_All._materialItemInfo.isMaterialEquip[index] = false
  end
  PaGlobal_Endurance_Recovery_All._recoveryItemInfo.isRecoveryEquip[key] = true
  PaGlobal_Endurance_Recovery_All._isRecovery = false
  PaGlobal_Endurance_Recovery_All._ui.list2_recoveryList:requestUpdateVisible()
  PaGlobal_Endurance_Recovery_All:updateTopGuideText(PaGlobal_Endurance_Recovery_All._eGuideType.selectMaterial)
end
function HandleEventLUp_Endurance_Recovery_All_MaterialItem(key)
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Endurance_Recovery_All_MaterialItem\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == PaGlobal_Endurance_Recovery_All._repairItemKey then
    return
  end
  for index = 1, PaGlobal_Endurance_Recovery_All._materialItemCnt do
    PaGlobal_Endurance_Recovery_All._materialItemInfo.isMaterialEquip[index] = false
  end
  local slotNo = PaGlobal_Endurance_Recovery_All._materialItemInfo.slotNo[key]
  local itemWrapper = getInventoryItemByType(0, slotNo)
  PaGlobal_Endurance_Recovery_All:setMaterialIcon(itemWrapper)
  PaGlobal_Endurance_Recovery_All._materialItemInfo.isMaterialEquip[key] = true
  PaGlobal_Endurance_Recovery_All._isRecovery = false
  PaGlobal_Endurance_Recovery_All._isStreamRecovery = false
  PaGlobal_Endurance_Recovery_All._selectedMaterialSlotNo = slotNo
  PaGlobal_Endurance_Recovery_All:updateTopGuideText(PaGlobal_Endurance_Recovery_All._eGuideType.recovery)
end
function HandleEventLUp_Endurance_Recovery_All_EquipmentItem(equipNo)
  UI.ASSERT_NAME(nil ~= equipNo, "HandleEventLUp_Endurance_Recovery_All_equipmentItem\236\157\152 equipNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      HandleEventRUp_Equipment_All_EquipSlotRClick(equipNo)
    else
      Equipment_RClick(equipNo)
    end
  else
    InputMRUp_InventoryInfo_EquipSlot(equipNo)
  end
  PaGlobal_Endurance_Recovery_All._lastIndex = PaGlobal_Endurance_Recovery_All._ui.list2_recoveryList:getCurrenttoIndex()
end
function HandleEventLUp_Endurance_Recovery_All_RecoveryListControlCreate(control, key)
  UI.ASSERT_NAME(nil ~= control, "HandleEventLUp_Endurance_Recovery_All_RecoveryListControlCreate\236\157\152 control nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Endurance_Recovery_All_RecoveryListControlCreate\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local key_32 = Int64toInt32(key)
  local btn_item = UI.getChildControl(control, "RadioButton_ExtractableItem")
  btn_item:SetCheck(false)
  local itemSlotBg = UI.getChildControl(btn_item, "Static_ItemSlotBG")
  local itemIcon = UI.getChildControl(itemSlotBg, "Static_ItemIcon")
  local itemText = UI.getChildControl(itemSlotBg, "StaticText_ItemName")
  local itemInfoValue = UI.getChildControl(itemSlotBg, "StaticText_InfoValue")
  local itemEnchant = UI.getChildControl(itemIcon, "Static_Text_Slot_Enchant_value")
  local text_equipment = UI.getChildControl(btn_item, "StaticText_Equip")
  local hammerIcon = UI.getChildControl(btn_item, "Static_Hammer")
  if nil == PaGlobal_Endurance_Recovery_All._equipNo[key_32] then
    if false == PaGlobal_Endurance_Recovery_All._isConsole then
      itemIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Endurance_Recovery_All_RecoveryItem(" .. key_32 .. ")")
      itemIcon:addInputEvent("Mouse_On", "HandleEventOn_Endurance_Recovery_All_ShowListToolTip(false," .. PaGlobal_Endurance_Recovery_All._recoveryItemInfo.slotNo[key_32] .. ",true)")
      itemIcon:addInputEvent("Mouse_Out", "HandleEventOn_Endurance_Recovery_All_ShowListToolTip(false," .. PaGlobal_Endurance_Recovery_All._recoveryItemInfo.slotNo[key_32] .. ",false)")
    else
      btn_item:addInputEvent("Mouse_On", "PaGlobal_Endurance_Recovery_All_ShowDetailKeyGuide(true," .. key_32 .. ")")
      btn_item:addInputEvent("Mouse_Out", "PaGlobal_Endurance_Recovery_All_ShowDetailKeyGuide(false," .. key_32 .. ")")
      btn_item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Endurance_Recovery_All_ShowListToolTip(false," .. PaGlobal_Endurance_Recovery_All._recoveryItemInfo.slotNo[key_32] .. ",nil)")
    end
    btn_item:addInputEvent("Mouse_LUp", "HandleEventLUp_Endurance_Recovery_All_SelectListItem(" .. key_32 .. ")")
    text_equipment:SetShow(false)
    hammerIcon:SetShow(false)
  else
    if false == PaGlobal_Endurance_Recovery_All._isConsole then
      itemIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Endurance_Recovery_All_EquipmentItem(" .. PaGlobal_Endurance_Recovery_All._equipNo[key_32] .. ")")
      itemIcon:addInputEvent("Mouse_On", "HandleEventOn_Endurance_Recovery_All_ShowListToolTip(true," .. PaGlobal_Endurance_Recovery_All._equipNo[key_32] .. ",true)")
      itemIcon:addInputEvent("Mouse_Out", "HandleEventOn_Endurance_Recovery_All_ShowListToolTip(true," .. PaGlobal_Endurance_Recovery_All._equipNo[key_32] .. ",false)")
    else
      btn_item:addInputEvent("Mouse_On", "PaGlobal_Endurance_Recovery_All_ShowDetailKeyGuide(true," .. key_32 .. ")")
      btn_item:addInputEvent("Mouse_Out", "PaGlobal_Endurance_Recovery_All_ShowDetailKeyGuide(false," .. key_32 .. ")")
      btn_item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Endurance_Recovery_All_ShowListToolTip(true," .. PaGlobal_Endurance_Recovery_All._equipNo[key_32] .. ",nil)")
    end
    btn_item:addInputEvent("Mouse_LUp", "HandleEventLUp_Endurance_Recovery_All_EquipmentItem(" .. PaGlobal_Endurance_Recovery_All._equipNo[key_32] .. ")")
    text_equipment:SetShow(true)
    hammerIcon:SetShow(false)
  end
  local itemName = PaGlobal_Endurance_Recovery_All._recoveryItemInfo.name[key_32]
  local itemIconPath = PaGlobal_Endurance_Recovery_All._recoveryItemInfo.iconPath[key_32]
  local curEndurance = PaGlobal_Endurance_Recovery_All._recoveryItemInfo.curEndurance[key_32]
  local recoveryEndurance = PaGlobal_Endurance_Recovery_All._recoveryItemInfo.recoveryEndurance[key_32]
  local maxEndurance = PaGlobal_Endurance_Recovery_All._recoveryItemInfo.maxendurance[key_32]
  PaGlobal_Endurance_Recovery_All:updateMaterialValueText(itemInfoValue, recoveryEndurance, maxEndurance)
  local itemWrapper
  if nil ~= PaGlobal_Endurance_Recovery_All._equipNo[key_32] then
    itemWrapper = ToClient_getEquipmentItem(PaGlobal_Endurance_Recovery_All._equipNo[key_32])
  elseif nil ~= PaGlobal_Endurance_Recovery_All._recoveryItemInfo.slotNo[key_32] then
    itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, PaGlobal_Endurance_Recovery_All._recoveryItemInfo.slotNo[key_32])
  end
  if nil ~= itemWrapper then
    PAGlobalFunc_SetItemTextColorForNewUI(itemText, itemWrapper:getStaticStatus())
    local slot = {}
    SlotItem.reInclude(slot, "Endurance_Recovery_All_TargetSlot_", 0, itemIcon, PaGlobal_Endurance_Recovery_All._slotConfig)
    slot:clearItem()
    slot:setItem(itemWrapper)
  end
  itemText:SetText(itemName)
  if nil ~= PaGlobal_Endurance_Recovery_All._recoveryItemInfo.itemEnchantLevle[key_32] then
    itemEnchant:SetText(PaGlobal_Endurance_Recovery_All._recoveryItemInfo.itemEnchantLevle[key_32])
  end
  if true == PaGlobal_Endurance_Recovery_All._recoveryItemInfo.isRecoveryEquip[key_32] then
    hammerIcon:SetShow(true)
    btn_item:SetCheck(true)
    if nil ~= PaGlobal_Endurance_Recovery_All._recoveryItemInfo.slotNo[key_32] then
      local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, PaGlobal_Endurance_Recovery_All._recoveryItemInfo.slotNo[key_32])
      PaGlobal_Endurance_Recovery_All:setRecoveryIcon(itemWrapper, PaGlobal_Endurance_Recovery_All._recoveryItemInfo.slotNo[key_32])
    end
  end
  control:ComputePos()
end
function HandleEventLUp_Endurance_Recovery_All_MaterialListControlCreate(control, key)
  UI.ASSERT_NAME(nil ~= control, "HandleEventLUp_Endurance_Recovery_All_MaterialListControlCreate\236\157\152 control nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Endurance_Recovery_All_MaterialListControlCreate\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local key_32 = Int64toInt32(key)
  local btn_item = UI.getChildControl(control, "RadioButton_ExtractionMaterialItem")
  btn_item:SetCheck(false)
  local itemSlotBg = UI.getChildControl(btn_item, "Static_ItemSlotBG")
  local itemIcon = UI.getChildControl(itemSlotBg, "Static_ItemIcon")
  local itemText = UI.getChildControl(itemSlotBg, "StaticText_ItemName")
  local itemCntText = UI.getChildControl(btn_item, "StaticText_ItemCnt")
  local itemEnchant = UI.getChildControl(itemIcon, "Static_Text_Slot_Enchant_value")
  local itemName = PaGlobal_Endurance_Recovery_All._materialItemInfo.name[key_32]
  local itemIconPath = PaGlobal_Endurance_Recovery_All._materialItemInfo.iconPath[key_32]
  local itemCnt = PaGlobal_Endurance_Recovery_All._materialItemInfo.itemCnt[key_32]
  local itemKey
  if 255 ~= PaGlobal_Endurance_Recovery_All._materialItemInfo.slotNo[key_32] then
    itemKey = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, PaGlobal_Endurance_Recovery_All._materialItemInfo.slotNo[key_32]):get():getKey():getItemKey()
    btn_item:SetMonoTone(false)
    if false == PaGlobal_Endurance_Recovery_All._isConsole then
      itemIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Endurance_Recovery_All_MaterialItem(" .. key_32 .. ")")
    end
    btn_item:addInputEvent("Mouse_LUp", "HandleEventLUp_Endurance_Recovery_All_SelectMaterialListItem(" .. key_32 .. ")")
  else
    itemKey = PaGlobal_Endurance_Recovery_All._materialEnchantKey.memoryFlag:getItemKey()
    btn_item:SetMonoTone(true)
  end
  if false == PaGlobal_Endurance_Recovery_All._isConsole then
    itemIcon:addInputEvent("Mouse_On", "HandleEventOn_Endurance_Recovery_All_ShowToolTip(" .. itemKey .. ",true)")
    itemIcon:addInputEvent("Mouse_Out", "HandleEventOn_Endurance_Recovery_All_ShowToolTip(" .. itemKey .. ",false)")
  else
    btn_item:addInputEvent("Mouse_On", "PaGlobal_Endurance_Recovery_All_ShowDetailKeyGuideMaterial(true," .. key_32 .. ")")
    btn_item:addInputEvent("Mouse_Out", "PaGlobal_Endurance_Recovery_All_ShowDetailKeyGuideMaterial(false," .. key_32 .. ")")
    btn_item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Endurance_Recovery_All_ShowToolTip(" .. itemKey .. ",nil)")
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, PaGlobal_Endurance_Recovery_All._materialItemInfo.slotNo[key_32])
  itemText:SetText(itemName)
  if nil ~= itemWrapper then
    PAGlobalFunc_SetItemTextColorForNewUI(itemText, itemWrapper:getStaticStatus())
  end
  itemCntText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENDURANCE_RECOVERY_METERIALITEMCNT", "count", tostring(itemCnt)))
  local slot = {}
  SlotItem.reInclude(slot, "Endurance_Recovery_All_MaterialSlot_", 0, itemIcon, PaGlobal_Endurance_Recovery_All._slotConfig)
  slot:clearItem()
  slot:setItem(itemWrapper)
  if nil ~= PaGlobal_Endurance_Recovery_All._materialItemInfo.itemEnchantLevle[key_32] then
    itemEnchant:SetText(PaGlobal_Endurance_Recovery_All._materialItemInfo.itemEnchantLevle[key_32])
  end
  if true == PaGlobal_Endurance_Recovery_All._materialItemInfo.isMaterialEquip[key_32] then
    btn_item:SetCheck(true)
  end
  control:ComputePos()
end
function HandleEventLUp_Endurance_Recovery_All_CashItemBtn()
  local cashItemStaticStatus = getItemEnchantStaticStatus(PaGlobal_Endurance_Recovery_All._materialEnchantKey.cashItem)
  local inventory = getSelfPlayer():get():getCashInventory()
  if nil == inventory then
    return
  end
  if 0 == PaGlobal_Endurance_Recovery_All._useItemCount then
    if false == PaGlobal_Endurance_Recovery_All._isConsole then
      PaGlobal_EasyBuy:Open(7, nil, false)
    end
    PaGlobal_Endurance_Recovery_All._ui.btn_useCashItem:SetCheck(false)
    PaGlobal_Endurance_Recovery_All._isUseCashItem = false
  elseif true == PaGlobal_Endurance_Recovery_All._isUseCashItem then
    PaGlobal_Endurance_Recovery_All._isUseCashItem = false
    PaGlobal_Endurance_Recovery_All._ui.btn_useCashItem:SetCheck(false)
  else
    PaGlobal_Endurance_Recovery_All._isUseCashItem = true
    PaGlobal_Endurance_Recovery_All._ui.btn_useCashItem:SetCheck(true)
  end
  PaGlobal_Endurance_Recovery_All:setCashItemIcon()
end
function HandleEventOn_Endurance_Recovery_All_ShowCashItemToolTip(isShow, isCashToolTip)
  UI.ASSERT_NAME(nil ~= isShow, "HandleEventOn_Endurance_Recovery_All_ShowCashItemToolTip\236\157\152 isShow nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= isCashToolTip, "HandleEventOn_Endurance_Recovery_All_ShowCashItemToolTip\236\157\152 isCashToolTip nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local name, desc, targetControl
  if false == isCashToolTip then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FIXEQUIP_STREAMRECOVERY_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FIXEQUIP_STREAMRECOVERY_TOOLTIP_DESC")
    targetControl = PaGlobal_Endurance_Recovery_All._ui_pc.btn_streamRecovery
  else
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FIXEQUIP_TOOLTIP_APPLYCASH_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FIXEQUIP_TOOLTIP_APPLYCASH_DESC")
    targetControl = PaGlobal_Endurance_Recovery_All._ui.btn_useCashItem
  end
  if true == isShow then
    TooltipSimple_Show(targetControl, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOn_Endurance_Recovery_All_ShowToolTip(key, isShow)
  UI.ASSERT_NAME(nil ~= key, "HandleEventOn_Endurance_System_All_ShowToolTip\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(key))
  if nil == Panel_Window_Endurance_Recovery_All or nil == itemWrapper then
    return
  end
  if false == PaGlobal_Endurance_Recovery_All._isConsole then
    if true == isShow then
      Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Endurance_Recovery_All, true, false)
    else
      Panel_Tooltip_Item_hideTooltip()
    end
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventOn_Endurance_Recovery_All_ShowListToolTip(isEquip, idx, isShow)
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  local itemWrapper
  if true == isEquip then
    itemWrapper = ToClient_getEquipmentItem(idx)
  else
    itemWrapper = getInventoryItemByType(0, idx)
  end
  if nil == itemWrapper then
    return
  end
  if false == PaGlobal_Endurance_Recovery_All._isConsole then
    if true == isShow then
      Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Endurance_Recovery_All, false, true, nil)
    else
      Panel_Tooltip_Item_hideTooltip()
    end
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventRUp_Endurance_Recovery_All_ClearAllSlot()
  PaGlobal_Endurance_Recovery_All._selectedItemSlotNo = nil
  PaGlobal_Endurance_Recovery_All:clearAllSlot()
  PaGlobal_Endurance_Recovery_All._ui.list2_recoveryList:requestUpdateVisible()
end
function HandleEventRUp_Endurance_Recovery_All_ClearMaterialSlot()
  PaGlobal_Endurance_Recovery_All:clearMaterialSlot()
end
function FromClient_Endurance_Recovery_All_ReSizePanel()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  if false == PaGlobal_Endurance_Recovery_All._isConsole then
    PaGlobal_Endurance_Recovery_All._ui_pc.btn_question:ComputePos()
    PaGlobal_Endurance_Recovery_All._ui_pc.btn_close:ComputePos()
  end
  PaGlobal_Endurance_Recovery_All._ui_pc.btn_onceRecovery:ComputePos()
  PaGlobal_Endurance_Recovery_All._ui_pc.btn_streamRecovery:ComputePos()
  PaGlobal_Endurance_Recovery_All._ui.stc_leftTopDesc:ComputePos()
  PaGlobal_Endurance_Recovery_All._ui.list2_recoveryList:ComputePos()
  PaGlobal_Endurance_Recovery_All._ui.list2_materialList:ComputePos()
  PaGlobal_Endurance_Recovery_All._ui.btn_useCashItem:ComputePos()
  PaGlobal_Endurance_Recovery_All._ui.txt_useItemCount:ComputePos()
  PaGlobal_Endurance_Recovery_All._ui.stc_recoveryItemSlot:ComputePos()
  PaGlobal_Endurance_Recovery_All._ui.stc_memoryItemSlot:ComputePos()
  PaGlobal_Endurance_Recovery_All._ui.stc_meterialItemSlot:ComputePos()
  PaGlobal_Endurance_Recovery_All._ui.progress2_maxEndurance:ComputePos()
  PaGlobal_Endurance_Recovery_All._ui.progress2_curEndurance:ComputePos()
  PaGlobal_Endurance_Recovery_All._ui.stc_enduranceValue:ComputePos()
end
function PaGlobal_Endurance_Recovery_All_IsClickedStreamRecovery()
  return PaGlobal_Endurance_Recovery_All._isStreamRecovery
end
function PaGlobal_Endurance_Recovery_All_StreamRecoveryStop()
  PaGlobal_Endurance_Recovery_All._isStreamRecovery = false
end
function PaGlobal_Endurance_Recovery_All_MaterialItemKey()
  if nil == PaGlobal_Endurance_Recovery_All._materialItemKey then
    return
  end
  return PaGlobal_Endurance_Recovery_All._materialItemKey:getItemKey()
end
function PaGlobal_Endurance_Recovery_All_FilterMaterialItem(slotNo, whereType, itemWrapper)
  UI.ASSERT_NAME(nil ~= slotNo, "PaGlobal_Endurance_Recovery_All_FilterMaterialItem\236\157\152 slotNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= whereType, "PaGlobal_Endurance_Recovery_All_FilterMaterialItem\236\157\152 whereType nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= itemWrapper, "PaGlobal_Endurance_Recovery_All_FilterMaterialItem\236\157\152 itemWrapper nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == itemWrapper then
    return true
  end
  if nil ~= PaGlobal_Endurance_Recovery_All._repairItemKey and true == itemWrapper:checkToRepairItemMaxEnduranceWithMoneyAndItem(PaGlobal_Endurance_Recovery_All._repairItemKey) and (PaGlobal_Endurance_Recovery_All._recoveryItemSlotNo ~= slotNo or CppEnums.ItemWhereType.eInventory ~= whereType) then
    return false
  end
  return true
end
function PaGlobal_Endurance_Recovery_All_FixEquipContinue(slotNo)
  UI.ASSERT_NAME(nil ~= slotNo, "PaGlobal_Endurance_Recovery_All_FixEquipContinue\236\157\152 slotNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local whereType = CppEnums.ItemWhereType.eInventory
  local mainItemWrapper = getInventoryItemByType(whereType, PaGlobal_Endurance_Recovery_All._recoveryItemSlotNo)
  if nil == mainItemWrapper then
    return
  end
  if getSelfPlayer():get():getCurrentWeight_s64() < PaGlobal_Endurance_Recovery_All._s64_allWeight then
    PaGlobal_Endurance_Recovery_All._s64_allWeight = getSelfPlayer():get():getCurrentWeight_s64()
  else
    return
  end
  local hasCashItem = doHaveContentsItem(27, 0, false)
  if false == hasCashItem and true == PaGlobal_Endurance_Recovery_All._isUseCashItem then
    return
  end
  if mainItemWrapper:checkToRepairItemMaxEndurance() then
    repair_MaxEndurance(whereType, PaGlobal_Endurance_Recovery_All._recoveryItemSlotNo, whereType, slotNo, whereType, PaGlobal_Endurance_Recovery_All._isUseCashItem)
  else
    PaGlobal_Endurance_Recovery_All._isStreamRecovery = false
    PaGlobal_Endurance_Recovery_All:clearAllSlot()
  end
end
function PaGlobal_Endurance_Recovery_All_UpdateList()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  PaGlobal_Endurance_Recovery_All:updateEnduranceList()
  PaGlobal_Endurance_Recovery_All:setCashItemIcon()
  local whereType = CppEnums.ItemWhereType.eInventory
  if nil ~= PaGlobal_Endurance_Recovery_All._materialItemKey then
    local materialItemSlotNo = PaGlobal_Endurance_Recovery_All:getMaterialFirstItem(PaGlobal_Endurance_Recovery_All._materialItemKey)
    if nil == materialItemSlotNo then
      PaGlobal_Endurance_Recovery_All:clearMaterialSlot()
    else
      local itemWrapper = getInventoryItemByType(whereType, materialItemSlotNo)
      PaGlobal_Endurance_Recovery_All:setMaterialIcon(itemWrapper)
    end
  end
  if nil ~= PaGlobal_Endurance_Recovery_All._recoveryItemSlotNo and 255 ~= PaGlobal_Endurance_Recovery_All._recoveryItemSlotNo then
    local itemWrapper = getInventoryItemByType(whereType, PaGlobal_Endurance_Recovery_All._recoveryItemSlotNo)
    PaGlobal_Endurance_Recovery_All:setRecoveryIcon(itemWrapper, PaGlobal_Endurance_Recovery_All._recoveryItemSlotNo)
  end
  if nil ~= PaGlobal_Endurance_Recovery_All._lastIndex then
    PaGlobal_Endurance_Recovery_All._ui.list2_recoveryList:moveIndex(PaGlobal_Endurance_Recovery_All._lastIndex)
  end
  PaGlobal_Endurance_Recovery_All_RepeatRecovery()
end
function PaGlobal_Endurance_Recovery_All_ShowDetailKeyGuide(isShow, key)
  PaGlobal_Endurance_Recovery_All._ui_console.btn_iconX:SetShow(isShow)
  if false == isShow then
    PaGlobal_Endurance_Recovery_All._ui_console.btn_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
  else
    local slotNo = PaGlobal_Endurance_Recovery_All._recoveryItemInfo.slotNo[key]
    if PaGlobal_Endurance_Recovery_All._selectedItemSlotNo == slotNo then
      PaGlobal_Endurance_Recovery_All._ui_console.btn_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
    else
      PaGlobal_Endurance_Recovery_All._ui_console.btn_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
    end
  end
  PaGlobal_Endurance_Recovery_All_KeyGuidePosUpdate()
end
function PaGlobal_Endurance_Recovery_All_ShowDetailKeyGuideMaterial(isShow, key)
  PaGlobal_Endurance_Recovery_All._ui_console.btn_iconX:SetShow(isShow)
  if false == isShow then
    PaGlobal_Endurance_Recovery_All._ui_console.btn_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
  else
    local slotNo = PaGlobal_Endurance_Recovery_All._materialItemInfo.slotNo[key]
    if PaGlobal_Endurance_Recovery_All._selectedMaterialSlotNo == slotNo then
      PaGlobal_Endurance_Recovery_All._ui_console.btn_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
    else
      PaGlobal_Endurance_Recovery_All._ui_console.btn_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
    end
  end
  PaGlobal_Endurance_Recovery_All_KeyGuidePosUpdate()
end
function PaGlobal_Endurance_Recovery_All_KeyGuidePosUpdate()
  local keyGuides = {
    PaGlobal_Endurance_Recovery_All._ui_console.btn_iconX,
    PaGlobal_Endurance_Recovery_All._ui_console.btn_iconA,
    PaGlobal_Endurance_Recovery_All._ui_console.btn_iconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_Endurance_Recovery_All._ui_console.stc_guideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Endurance_Recovery_All_ShowAni()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
end
function PaGlobal_Endurance_Recovery_All_HideAni()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
end
function FromClient_Endurance_Recovery_All_UpdateList()
  if nil == Panel_Window_Endurance_Recovery_All or false == Panel_Window_Endurance_Recovery_All:GetShow() then
    return
  end
  PaGlobal_Endurance_Recovery_All_UpdateList()
end
