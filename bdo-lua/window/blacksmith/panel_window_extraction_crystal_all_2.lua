function PaGlobal_Extraction_Crystal_All_Open()
  PaGlobal_Extraction_Crystal_All:prepareOpen()
end
function PaGlobal_Extraction_Crystal_All_Close()
  HandleEventRUp_Extraction_Crystal_All_ClearAllSlot()
  PaGlobal_Extraction_Crystal_All:prepareClose()
end
function HandleEventOn_Extraction_Crystal_All_ShowToolTip(key, isShow)
  UI.ASSERT_NAME(nil ~= key, "HandleEventOn_Extraction_Crystal_All_ShowToolTip\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= isShow, "HandleEventOn_Extraction_Crystal_All_ShowToolTip\236\157\152 isShow nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(key))
  if nil == Panel_Window_Extraction_Crystal_All or nil == itemWrapper then
    return
  end
  if false == PaGlobal_Extraction_Crystal_All._isConsole then
    if true == isShow then
      Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Extraction_Crystal_All, true, false)
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
function HandleEventOn_Extraction_Crystal_All_ShowListToolTip(isEquip, idx, whereType, isShow)
  UI.ASSERT_NAME(nil ~= isEquip, "HandleEventOn_Extraction_Crystal_All_ShowListToolTip\236\157\152 isEquip nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= idx, "HandleEventOn_Extraction_Crystal_All_ShowListToolTip\236\157\152 idx nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
  local itemWrapper
  if true == isEquip then
    itemWrapper = ToClient_getEquipmentItem(idx)
  else
    itemWrapper = getInventoryItemByType(whereType, idx)
  end
  if nil == itemWrapper then
    return
  end
  if false == PaGlobal_Extraction_Crystal_All._isConsole then
    if true == isShow then
      Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Extraction_Crystal_All, false, true, nil)
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
function HandleEventLUp_Extraction_Crystal_All_SelectListItem(key)
  if false == PaGlobal_Extraction_Crystal_All._isConsole then
    HandleEventLUp_Extraction_Crystal_All_CrystalItem(key)
  else
    local slotNo = PaGlobal_Extraction_Crystal_All._extractionItemInfo.slotNo[key]
    if PaGlobal_Extraction_Crystal_All._selectedItemSlotNo == slotNo then
      HandleEventRUp_Extraction_Crystal_All_ClearAllSlot()
      PaGlobal_Extraction_Crystal_All._ui.list2_extractableItem:requestUpdateVisible()
    else
      HandleEventLUp_Extraction_Crystal_All_CrystalItem(key)
    end
    PaGlobal_Extraction_Crystal_All_ShowDetailKeyGuide(true, key)
  end
end
function HandleEventLUp_Extraction_Crystal_All_SelectMaterialListItem(key)
  if false == PaGlobal_Extraction_Crystal_All._isConsole then
    HandleEventLUp_Extraction_Crystal_All_MaterialItem(key)
  else
    local slotNo = PaGlobal_Extraction_Crystal_All._materialItemInfo.slotNo[key]
    if PaGlobal_Extraction_Crystal_All._selectedMaterialSlotNo == slotNo then
      HandleEventRUp_Extraction_Crystal_All_MaterialItem()
      PaGlobal_Extraction_Crystal_All._ui.list2_materialItem:requestUpdateVisible()
    else
      HandleEventLUp_Extraction_Crystal_All_MaterialItem(key)
    end
    PaGlobal_Extraction_Crystal_All_ShowDetailKeyGuideMaterial(true, key)
  end
end
function HandleEventLUp_Extraction_Crystal_All_CrystalItem(key)
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Extraction_Crystal_All_CrystalItem\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  PaGlobal_Extraction_Crystal_All:clearAllSlot()
  for index = 1, PaGlobal_Extraction_Crystal_All._crystalCnt do
    PaGlobal_Extraction_Crystal_All._extractionItemInfo.isExtractionEquip[index] = false
  end
  for index = 1, PaGlobal_Extraction_Crystal_All._materialCnt do
    PaGlobal_Extraction_Crystal_All._materialItemInfo.isExtractionEquip[index] = false
  end
  local slotNo = PaGlobal_Extraction_Crystal_All._extractionItemInfo.slotNo[key]
  local whereType = CppEnums.ItemWhereType.eInventory
  PaGlobal_Extraction_Crystal_All._selectedItemSlotNo = slotNo
  local _key = Int64toInt32(key)
  if _key <= PaGlobal_Extraction_Crystal_All._indexInvenEnd then
    PaGlobal_Extraction_Crystal_All._selectedWhereType = CppEnums.ItemWhereType.eInventory
    whereType = CppEnums.ItemWhereType.eInventory
  elseif _key <= PaGlobal_Extraction_Crystal_All._indexCashInvenEnd then
    PaGlobal_Extraction_Crystal_All._selectedWhereType = CppEnums.ItemWhereType.eCashInventory
    whereType = CppEnums.ItemWhereType.eCashInventory
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  PaGlobal_Extraction_Crystal_All:setExtractionIcon(itemWrapper, slotNo)
  PaGlobal_Extraction_Crystal_All._extractionItemInfo.isExtractionEquip[key] = true
  PaGlobal_Extraction_Crystal_All:clearMaterialSlot()
  PaGlobal_Extraction_Crystal_All._ui.list2_extractableItem:requestUpdateVisible()
end
function HandleEventLUp_Extraction_Crystal_All_MaterialItem(key)
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Extraction_Crystal_All_MaterialItem\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  PaGlobal_Extraction_Crystal_All:clearMaterialSlot()
  if nil == PaGlobal_Extraction_Crystal_All._extractionKey then
    return
  end
  local slotNo = PaGlobal_Extraction_Crystal_All._materialItemInfo.slotNo[key]
  local whereType = PaGlobal_Extraction_Crystal_All._materialItemInfo.whereType[key]
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  PaGlobal_Extraction_Crystal_All._selectedMaterialSlotNo = slotNo
  PaGlobal_Extraction_Crystal_All:setMaterialSlotIcon(itemWrapper, whereType, slotNo)
  PaGlobal_Extraction_Crystal_All._materialItemInfo.isExtractionEquip[key] = true
end
function HandleEventRUp_Extraction_Crystal_All_MaterialItem()
  PaGlobal_Extraction_Crystal_All:clearMaterialSlot()
end
function HandleEventLUp_Extraction_Crystal_All_EquipItem(equipNo)
  UI.ASSERT_NAME(nil ~= equipNo, "HandleEventLUp_Extraction_Crystal_All_EquipItem\236\157\152 equipNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      HandleEventRUp_Equipment_All_EquipSlotRClick(equipNo)
    else
      Equipment_RClick(equipNo)
    end
  else
    InputMRUp_InventoryInfo_EquipSlot(equipNo)
  end
  PaGlobal_Extraction_Crystal_All._lastIndex = PaGlobal_Extraction_Crystal_All._ui.list2_extractableItem:getCurrenttoIndex()
end
function HandleEventLUp_Extraction_Crystal_All_ExtractionListControlCreate(control, key)
  UI.ASSERT_NAME(nil ~= control, "HandleEventLUp_Extraction_Crystal_All_ExtractionListControlCreate\236\157\152 control nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Extraction_Crystal_All_ExtractionListControlCreate\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local key_32 = Int64toInt32(key)
  local btn_item = UI.getChildControl(control, "RadioButton_ExtractableItem")
  btn_item:SetCheck(false)
  local itemSlotBg = UI.getChildControl(btn_item, "Static_ItemSlotBG")
  local itemIcon = UI.getChildControl(itemSlotBg, "Static_ItemIcon")
  local itemText = UI.getChildControl(itemSlotBg, "StaticText_ItemName")
  local itemEnchant = UI.getChildControl(itemIcon, "Static_Text_Slot_Enchant_value")
  local text_equipment = UI.getChildControl(btn_item, "StaticText_Equip")
  local hammerIcon = UI.getChildControl(btn_item, "Static_Hammer")
  local whereType = CppEnums.ItemWhereType.eInventory
  if key_32 <= PaGlobal_Extraction_Crystal_All._indexInvenEnd then
    whereType = CppEnums.ItemWhereType.eInventory
  elseif key_32 <= PaGlobal_Extraction_Crystal_All._indexCashInvenEnd then
    whereType = CppEnums.ItemWhereType.eCashInventory
  end
  if nil == PaGlobal_Extraction_Crystal_All._equipNo[key_32] then
    if false == PaGlobal_Extraction_Crystal_All._isConsole then
      itemIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Crystal_All_CrystalItem(" .. key_32 .. ")")
      itemIcon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_Crystal_All_ShowListToolTip(false," .. PaGlobal_Extraction_Crystal_All._extractionItemInfo.slotNo[key_32] .. "," .. whereType .. ",true)")
      itemIcon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_Crystal_All_ShowListToolTip(false," .. PaGlobal_Extraction_Crystal_All._extractionItemInfo.slotNo[key_32] .. "," .. whereType .. ",false)")
    else
      btn_item:addInputEvent("Mouse_On", "PaGlobal_Extraction_Crystal_All_ShowDetailKeyGuide(true," .. key_32 .. ")")
      btn_item:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Crystal_All_ShowDetailKeyGuide(false," .. key_32 .. ")")
      btn_item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_Crystal_All_ShowListToolTip(false," .. PaGlobal_Extraction_Crystal_All._extractionItemInfo.slotNo[key_32] .. "," .. whereType .. ",nil)")
    end
    btn_item:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Crystal_All_SelectListItem(" .. key_32 .. ")")
    text_equipment:SetShow(false)
    hammerIcon:SetShow(false)
  else
    if false == PaGlobal_Extraction_Crystal_All._isConsole then
      itemIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Crystal_All_EquipItem(" .. PaGlobal_Extraction_Crystal_All._equipNo[key_32] .. ")")
      itemIcon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_Crystal_All_ShowListToolTip(true," .. PaGlobal_Extraction_Crystal_All._equipNo[key_32] .. "," .. whereType .. ",true)")
      itemIcon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_Crystal_All_ShowListToolTip(true," .. PaGlobal_Extraction_Crystal_All._equipNo[key_32] .. "," .. whereType .. ",false)")
    else
      btn_item:addInputEvent("Mouse_On", "PaGlobal_Extraction_Crystal_All_ShowDetailKeyGuide(true," .. key_32 .. ")")
      btn_item:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Crystal_All_ShowDetailKeyGuide(false," .. key_32 .. ")")
      btn_item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_Crystal_All_ShowListToolTip(false," .. PaGlobal_Extraction_Crystal_All._extractionItemInfo.slotNo[key_32] .. "," .. whereType .. ",nil)")
    end
    btn_item:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Crystal_All_EquipItem(" .. PaGlobal_Extraction_Crystal_All._equipNo[key_32] .. ")")
    text_equipment:SetShow(true)
    hammerIcon:SetShow(false)
  end
  local itemName = PaGlobal_Extraction_Crystal_All._extractionItemInfo.name[key_32]
  local itemIconPath = PaGlobal_Extraction_Crystal_All._extractionItemInfo.iconPath[key_32]
  itemText:SetText(itemName)
  local itemWrapper
  if nil == PaGlobal_Extraction_Crystal_All._equipNo[key_32] then
    itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, PaGlobal_Extraction_Crystal_All._extractionItemInfo.slotNo[key_32])
  else
    itemWrapper = ToClient_getEquipmentItem(PaGlobal_Extraction_Crystal_All._equipNo[key_32])
  end
  if nil ~= itemWrapper then
    PAGlobalFunc_SetItemTextColorForNewUI(itemText, itemWrapper:getStaticStatus())
  end
  itemIcon:ChangeTextureInfoName("icon/" .. itemIconPath)
  if nil ~= PaGlobal_Extraction_Crystal_All._extractionItemInfo.itemEnchantLevle[key_32] then
    itemEnchant:SetText(PaGlobal_Extraction_Crystal_All._extractionItemInfo.itemEnchantLevle[key_32])
  end
  if true == PaGlobal_Extraction_Crystal_All._extractionItemInfo.isExtractionEquip[key_32] then
    hammerIcon:SetShow(true)
    btn_item:SetCheck(true)
  end
  control:ComputePos()
end
function HandleEventLUp_Extraction_Crystal_All_ExtractionCrystal(idx)
  UI.ASSERT_NAME(nil ~= idx, "HandleEventLUp_Extraction_Crystal_All_ExtractionCrystal\236\157\152 idx nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if true == PaGlobal_Extraction_Crystal_All._ui.stc_crystalInfo[idx].isEmpty then
    return
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_CRYSTAL_EXTRACT")
  local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOCKET_EXTRACTION_MESSAGE", "socketNum", string.format("%d", idx))
  local function ExtractionCrystal_Pop_Confirm()
    audioPostEvent_SystemUi(5, 7)
    _AudioPostEvent_SystemUiForXBOX(5, 7)
    PaGlobal_Extraction_Crystal_All._isRemove = false
    Socket_PopJewelFromSocket(idx - 1, PaGlobal_Extraction_Crystal_All._stuffWhereType, PaGlobal_Extraction_Crystal_All._stuffSlotNo)
    PaGlobal_Extraction_Crystal_All_UpdateList()
  end
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = ExtractionCrystal_Pop_Confirm,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_Extraction_Crystal_All_MaterialListControlCreate(control, key)
  UI.ASSERT_NAME(nil ~= control, "HandleEventLUp_Extraction_Crystal_All_MaterialListControlCreate\236\157\152 control nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Extraction_Crystal_All_MaterialListControlCreate\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local key_32 = Int64toInt32(key)
  local btn_item = UI.getChildControl(control, "RadioButton_ExtractionMaterialItem")
  btn_item:SetCheck(false)
  local itemSlotBg = UI.getChildControl(btn_item, "Static_ItemSlotBG")
  local itemIcon = UI.getChildControl(itemSlotBg, "Static_ItemIcon")
  local itemText = UI.getChildControl(itemSlotBg, "StaticText_ItemName")
  local itemCount = UI.getChildControl(btn_item, "StaticText_ItemCount")
  if false == PaGlobal_Extraction_Crystal_All._isConsole then
    itemIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Crystal_All_MaterialItem(" .. key_32 .. ")")
  end
  btn_item:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Crystal_All_SelectMaterialListItem(" .. key_32 .. ")")
  local itemKey
  if 255 ~= PaGlobal_Extraction_Crystal_All._materialItemInfo.slotNo[key_32] then
    itemKey = getInventoryItemByType(PaGlobal_Extraction_Crystal_All._materialItemInfo.whereType[key_32], PaGlobal_Extraction_Crystal_All._materialItemInfo.slotNo[key_32]):get():getKey():getItemKey()
    btn_item:SetMonoTone(false)
  else
    if CppEnums.ItemWhereType.eInventory == PaGlobal_Extraction_Crystal_All._materialItemInfo.whereType[key_32] then
      itemKey = PaGlobal_Extraction_Crystal_All._materialEnchantKey.stuffCrystalExtraction:getItemKey()
    else
      itemKey = PaGlobal_Extraction_Crystal_All._materialEnchantKey.stuffBlackspirit:getItemKey()
    end
    btn_item:SetMonoTone(true)
  end
  if false == PaGlobal_Extraction_Crystal_All._isConsole then
    itemIcon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_Crystal_All_ShowToolTip(" .. itemKey .. ",true)")
    itemIcon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_Crystal_All_ShowToolTip(" .. itemKey .. ",false)")
  else
    btn_item:addInputEvent("Mouse_On", "PaGlobal_Extraction_Crystal_All_ShowDetailKeyGuideMaterial(true," .. key_32 .. ")")
    btn_item:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Crystal_All_ShowDetailKeyGuideMaterial(false," .. key_32 .. ")")
    btn_item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_Crystal_All_ShowToolTip(" .. itemKey .. ",nil)")
  end
  local itemName = PaGlobal_Extraction_Crystal_All._materialItemInfo.name[key_32]
  local itemIconPath = PaGlobal_Extraction_Crystal_All._materialItemInfo.iconPath[key_32]
  local itemCnt = PaGlobal_Extraction_Crystal_All._materialItemInfo.itemCnt[key_32]
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, PaGlobal_Extraction_Crystal_All._materialItemInfo.slotNo[key_32])
  local itemSSW
  if nil ~= itemWrapper then
    itemSSW = itemWrapper:getStaticStatus()
  end
  itemText:SetText(itemName)
  PAGlobalFunc_SetItemTextColorForNewUI(itemText, itemSSW)
  itemCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENDURANCE_RECOVERY_METERIALITEMCNT", "count", tostring(itemCnt)))
  itemIcon:ChangeTextureInfoName("icon/" .. itemIconPath)
  if true == PaGlobal_Extraction_Crystal_All._materialItemInfo.isExtractionEquip[key_32] then
    btn_item:SetCheck(true)
  end
  control:ComputePos()
end
function HandleEventRUp_Extraction_Crystal_All_ClearAllSlot()
  PaGlobal_Extraction_Crystal_All:clearAllSlot()
  PaGlobal_Extraction_Crystal_All._ui.list2_extractableItem:requestUpdateVisible()
end
function HandleEventRUp_Extraction_Crystal_All_RemoveCrystal(idx)
  UI.ASSERT_NAME(nil ~= idx, "HandleEventRUp_Extraction_Crystal_All_RemoveCrystal\236\157\152 idx nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_SOCKET_REMOVE_TITLE")
  local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOCKET_REMOVE_MESSAGE", "socketNum", string.format("%d", idx))
  local function remove_crystal_do()
    PaGlobal_Extraction_Crystal_All._isRemove = true
    audioPostEvent_SystemUi(5, 7)
    _AudioPostEvent_SystemUiForXBOX(5, 7)
    Socket_PopJewelFromSocket(idx - 1, CppEnums.ItemWhereType.eCount, __eTInventorySlotNoUndefined)
  end
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = remove_crystal_do,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandlePadEventOn_Extraction_Crystal_All_SocketOnTextureChange(socketIndex, isOn)
  local control = PaGlobal_Extraction_Crystal_All._ui.stc_crystalInfo[socketIndex].stc_crystal
  if nil == control then
    return
  end
  if false == isOn then
    control:setRenderTexture(control:getBaseTexture())
  else
    control:setRenderTexture(control:getOnTexture())
  end
end
function FromClient_Extraction_Crystal_All_ReSizePanel()
  if false == PaGlobal_Extraction_Crystal_All._isConsole then
    PaGlobal_Extraction_Crystal_All._ui_pc.btn_question:ComputePos()
    PaGlobal_Extraction_Crystal_All._ui_pc.btn_close:ComputePos()
  else
  end
  PaGlobal_Extraction_Crystal_All._ui.txt_leftTopDesc:ComputePos()
  PaGlobal_Extraction_Crystal_All._ui.list2_extractableItem:ComputePos()
  PaGlobal_Extraction_Crystal_All._ui.list2_materialItem:ComputePos()
  PaGlobal_Extraction_Crystal_All._ui.stc_materialItemSlot:ComputePos()
  PaGlobal_Extraction_Crystal_All._ui.stc_extractionItemSlot:ComputePos()
  PaGlobal_Extraction_Crystal_All._ui.stc_crystalExtractImage:ComputePos()
  PaGlobal_Extraction_Crystal_All._ui.txt_noItem:ComputePos()
  for idx = 1, 3 do
    PaGlobal_Extraction_Crystal_All._ui.stc_crystalInfo[idx].txt_itemName:ComputePos()
    PaGlobal_Extraction_Crystal_All._ui.stc_crystalInfo[idx].txt_crystalDesc:ComputePos()
    PaGlobal_Extraction_Crystal_All._ui.stc_crystalInfo[idx].btn_extraction:ComputePos()
    PaGlobal_Extraction_Crystal_All._ui.stc_crystalInfo[idx].stc_itemSlot:ComputePos()
  end
end
function FromClient_Extraction_Crystal_All_UpdateList()
  if false == Panel_Window_Extraction_Crystal_All:GetShow() then
    return
  end
  PaGlobal_Extraction_Crystal_All_UpdateList()
end
function PaGlobal_Extraction_Crystal_All_UpdateList()
  PaGlobal_Extraction_Crystal_All:updateExtractionList()
  PaGlobal_Extraction_Crystal_All:updateMaterialList()
  if nil ~= PaGlobal_Extraction_Crystal_All._lastIndex then
    PaGlobal_Extraction_Crystal_All._ui.list2_extractableItem:moveIndex(PaGlobal_Extraction_Crystal_All._lastIndex)
  end
end
function PaGlobal_Extraction_Crystal_All_Result()
  PaGlobal_ExtractionResult:resetChildControl()
  PaGlobal_ExtractionResult:resetAnimation()
  if false == PaGlobal_ExtractionResult:getShow() then
    if false == PaGlobal_Extraction_Crystal_All._isRemove then
      local itemSSW
      if nil ~= PaGlobal_Extraction_Crystal_All._extractionKey then
        itemSSW = getItemEnchantStaticStatus(PaGlobal_Extraction_Crystal_All._extractionKey)
      end
      if nil ~= itemSSW then
        PaGlobal_ExtractionResult:showResultMessage(PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_CRYSTAL_EXTRACT_DONE"), itemSSW:getName(), itemSSW)
      else
        PaGlobal_ExtractionResult:showResultMessage(PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_CRYSTAL_EXTRACT_DONE"))
      end
    else
      PaGlobal_ExtractionResult:showResultMessage(PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_CRYSTAL_REMOVE_DONE"))
    end
  end
  PaGlobal_Extraction_Crystal_All._resultShowTime = 0
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, PaGlobal_Extraction_Crystal_All._extractionSlotNo)
  getSocketInformation():clearData()
  PaGlobal_Extraction_Crystal_All:setExtractionIcon(itemWrapper, PaGlobal_Extraction_Crystal_All._extractionSlotNo)
  PaGlobal_Extraction_Crystal_All:clearMaterialSlot()
  local materialItemWrapper = getInventoryItemByType(PaGlobal_Extraction_Crystal_All._stuffWhereType, PaGlobal_Extraction_Crystal_All._stuffSlotNo)
  PaGlobal_Extraction_Crystal_All:setMaterialSlotIcon(itemWrapper, PaGlobal_Extraction_Crystal_All._stuffWhereType, PaGlobal_Extraction_Crystal_All._stuffSlotNo)
  PaGlobal_Extraction_Crystal_All_UpdateList()
  Panel_Window_Extraction_Result:RegisterUpdateFunc("PaGlobal_Extraction_Crystal_All_CheckResultMsgShowTime")
end
function PaGlobal_Extraction_Crystal_All_CheckResultMsgShowTime(delta)
  PaGlobal_Extraction_Crystal_All._resultShowTime = PaGlobal_Extraction_Crystal_All._resultShowTime + delta
  if PaGlobal_Extraction_Crystal_All._resultShowTime > 3 and true == Panel_Window_Extraction_Result:GetShow() then
    Panel_Window_Extraction_Result:SetShow(false)
  end
  if PaGlobal_Extraction_Crystal_All._resultShowTime > 5 then
    PaGlobal_Extraction_Crystal_All._resultShowTime = 0
    Panel_Window_Extraction_Result:ClearUpdateLuaFunc()
  end
end
function PaGlobal_Extraction_Crystal_All_ShowDetailKeyGuide(isShow, key, socketIndex)
  PaGlobal_Extraction_Crystal_All._ui_console.stc_iconX:SetShow(isShow)
  if nil ~= socketIndex then
    HandlePadEventOn_Extraction_Crystal_All_SocketOnTextureChange(socketIndex, isShow)
    PaGlobal_Extraction_Crystal_All._ui_console.stc_iconA:SetShow(false)
  else
    PaGlobal_Extraction_Crystal_All._ui_console.stc_iconA:SetShow(true)
  end
  if false == isShow then
    PaGlobal_Extraction_Crystal_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
  else
    local slotNo = PaGlobal_Extraction_Crystal_All._extractionItemInfo.slotNo[key]
    if PaGlobal_Extraction_Crystal_All._selectedItemSlotNo == slotNo then
      PaGlobal_Extraction_Crystal_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
    else
      PaGlobal_Extraction_Crystal_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
    end
  end
  PaGlobal_Extraction_Crystal_All_KeyGuidePosUpdate()
end
function PaGlobal_Extraction_Crystal_All_ShowDetailKeyGuideMaterial(isShow, key)
  PaGlobal_Extraction_Crystal_All._ui_console.stc_iconX:SetShow(isShow)
  if false == isShow then
    PaGlobal_Extraction_Crystal_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
  else
    local slotNo = PaGlobal_Extraction_Crystal_All._materialItemInfo.slotNo[key]
    if PaGlobal_Extraction_Crystal_All._selectedMaterialSlotNo == slotNo then
      PaGlobal_Extraction_Crystal_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
    else
      PaGlobal_Extraction_Crystal_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
    end
  end
  PaGlobal_Extraction_Crystal_All_KeyGuidePosUpdate()
end
function PaGlobal_Extraction_Crystal_All_KeyGuidePosUpdate()
  local keyGuides = {
    PaGlobal_Extraction_Crystal_All._ui_console.stc_iconX,
    PaGlobal_Extraction_Crystal_All._ui_console.stc_iconA,
    PaGlobal_Extraction_Crystal_All._ui_console.stc_iconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_Extraction_Crystal_All._ui_console.stc_guideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Extraction_Crystal_All_ShowAni()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
end
function PaGlobal_Extraction_Crystal_All_HideAni()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
end
