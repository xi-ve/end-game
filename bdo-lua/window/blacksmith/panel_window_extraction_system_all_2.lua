function PaGlobal_Extraction_System_All_Open()
  PaGlobal_Extraction_System_All:prepareOpen()
end
function PaGlobal_Extraction_System_All_Close()
  HandleEventRUp_Extraction_System_All_ClearItemSlot()
  PaGlobal_Extraction_System_All:prepareClose()
end
function HandleEventOn_Extraction_System_All_SkipAniButton()
  if false == PaGlobal_Extraction_System_All._isSkipAni then
    PaGlobal_Extraction_System_All._ui.btn_skipAni:SetCheck(true)
    PaGlobal_Extraction_System_All._isSkipAni = true
  else
    PaGlobal_Extraction_System_All._ui.btn_skipAni:SetCheck(false)
    PaGlobal_Extraction_System_All._isSkipAni = false
  end
end
function HandleEventOn_Extraction_System_All_ShowToolTip(key, isShow)
  UI.ASSERT_NAME(nil ~= key, "HandleEventOn_Extraction_System_All_ShowToolTip\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(key))
  if nil == itemWrapper then
    return
  end
  if false == PaGlobal_Extraction_System_All._isConsole then
    if true == isShow then
      Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Extraction_System_All, true, false)
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
function HandleEventOn_Extraction_System_All_ShowResultToolTip(isShow)
  if nil == PaGlobal_Extraction_System_All._resultItemKey then
    return
  end
  local ItemSSW = getItemEnchantStaticStatus(PaGlobal_Extraction_System_All._resultItemKey)
  if nil == ItemSSW then
    return
  end
  if false == PaGlobal_Extraction_System_All._isConsole then
    if false == isShow then
      Panel_Tooltip_Item_hideTooltip()
    else
      Panel_Tooltip_Item_Show_WithoutEndurance(ItemSSW, Panel_Window_Extraction_System_All, true, false, nil)
    end
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, ItemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventOn_Extraction_System_All_ShowListToolTip(isEquip, idx, isShow)
  UI.ASSERT_NAME(nil ~= isEquip, "HandleEventOn_Extraction_System_All_ShowListToolTip\236\157\152 isEquip nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= idx, "HandleEventOn_Extraction_System_All_ShowListToolTip\236\157\152 idx nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == Panel_Window_Extraction_System_All then
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
  if false == PaGlobal_Extraction_System_All._isConsole then
    if true == isShow then
      Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Extraction_System_All, false, true, nil)
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
function HandleEventRUp_Extraction_System_All_ClearItemSlot()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  if nil == PaGlobal_Extraction_System_All._listControl[1] then
    return
  end
  PaGlobal_Extraction_System_All:clearAllSlot()
  PaGlobal_Extraction_System_All._ui.stc_extractableItemSlot:EraseAllEffect()
  PaGlobal_Extraction_System_All._ui.stc_materialItemSlot:EraseAllEffect()
  PaGlobal_Extraction_System_All._ui.stc_resultItmeSlot:EraseAllEffect()
  PaGlobal_Extraction_System_All._ui.stc_resultMaterialItemSlot:EraseAllEffect()
  for index = 1, PaGlobal_Extraction_System_All._systemCnt do
    PaGlobal_Extraction_System_All._itemInfo.isExtractionEquip[index] = false
  end
  PaGlobal_Extraction_System_All._ui.list2_extractableItem:requestUpdateVisible()
  if false == PaGlobal_Extraction_System_All._isConsole then
    Panel_Tooltip_Item_hideTooltip()
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
end
function HandleEventLUp_Extraction_System_All_SelectListItem(key)
  if false == PaGlobal_Extraction_System_All._isConsole then
    HandleEventLUp_Extraction_System_All_SystemItem(key)
  else
    local slotNo = PaGlobal_Extraction_System_All._itemInfo.slotNo[key]
    if PaGlobal_Extraction_System_All._selectedItemSlotNo == slotNo then
      HandleEventRUp_Extraction_System_All_ClearItemSlot()
      PaGlobal_Extraction_System_All._ui.list2_extractableItem:requestUpdateVisible()
    else
      HandleEventLUp_Extraction_System_All_SystemItem(key)
    end
    PaGlobal_Extraction_System_All_ShowDetailKeyGuide(true, key)
  end
end
function HandleEventLUp_Extraction_System_All_SystemItem(key)
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Extraction_System_All_SystemItem\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  for index = 1, PaGlobal_Extraction_System_All._systemCnt do
    PaGlobal_Extraction_System_All._itemInfo.isExtractionEquip[index] = false
  end
  local slotNo = PaGlobal_Extraction_System_All._itemInfo.slotNo[key]
  local itemWrapper = getInventoryItemByType(0, slotNo)
  PaGlobal_Extraction_System_All:setExtractionIcon(itemWrapper, slotNo)
  PaGlobal_Extraction_System_All._itemInfo.isExtractionEquip[key] = true
  PaGlobal_Extraction_System_All._selectedItemSlotNo = slotNo
  PaGlobal_Extraction_System_All._curSelectKey = key
  PaGlobal_Extraction_System_All_ChangeHammerIcon()
  PaGlobal_Extraction_System_All._ui.stc_extractableItemSlot:EraseAllEffect()
  PaGlobal_Extraction_System_All._ui.stc_materialItemSlot:EraseAllEffect()
  PaGlobal_Extraction_System_All._ui.stc_extractableItemSlot:AddEffect("fUI_BlackExtractGamos_01C", false, 0.5, 0)
  PaGlobal_Extraction_System_All._ui.stc_materialItemSlot:AddEffect("fUI_BlackExtractGamos_01B", false, 0, 0)
end
function HandleEventLUp_Extraction_System_All_equipmentItem(equipNo)
  UI.ASSERT_NAME(nil ~= equipNo, "HandleEventLUp_Extraction_System_All_equipmentItem\236\157\152 equipNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      HandleEventRUp_Equipment_All_EquipSlotRClick(equipNo)
    else
      Equipment_RClick(equipNo)
    end
  else
    InputMRUp_InventoryInfo_EquipSlot(equipNo)
  end
  PaGlobal_Extraction_System_All._lastIndex = PaGlobal_Extraction_System_All._ui.list2_extractableItem:getCurrenttoIndex()
end
function HandleEventLUp_Extraction_System_All_ListControlCreate(control, key)
  UI.ASSERT_NAME(nil ~= control, "HandleEventLUp_Extraction_System_All_ListControlCreate\236\157\152 control nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Extraction_System_All_ListControlCreate\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local key_32 = Int64toInt32(key)
  local btn_item = UI.getChildControl(control, "RadioButton_ExtractableItem")
  btn_item:SetCheck(false)
  local itemSlotBg = UI.getChildControl(btn_item, "Static_ItemSlotBG")
  local itemIcon = UI.getChildControl(itemSlotBg, "Static_ItemIcon")
  local itemText = UI.getChildControl(btn_item, "StaticText_ItemName")
  local itemEnchant = UI.getChildControl(itemIcon, "Static_Text_Slot_Enchant_value")
  local text_equipment = UI.getChildControl(btn_item, "StaticText_Equip")
  local hammerIcon = UI.getChildControl(btn_item, "Static_Hammer")
  if nil == PaGlobal_Extraction_System_All._equipNo[key_32] then
    if false == PaGlobal_Extraction_System_All._isConsole then
      itemIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_System_All_SystemItem(" .. key_32 .. ")")
      itemIcon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_System_All_ShowListToolTip(false," .. PaGlobal_Extraction_System_All._itemInfo.slotNo[key_32] .. ",true)")
      itemIcon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_System_All_ShowListToolTip(false," .. PaGlobal_Extraction_System_All._itemInfo.slotNo[key_32] .. ",false)")
    else
      btn_item:addInputEvent("Mouse_On", "PaGlobal_Extraction_System_All_ShowDetailKeyGuide(true," .. key_32 .. ")")
      btn_item:addInputEvent("Mouse_Out", "PaGlobal_Extraction_System_All_ShowDetailKeyGuide(false," .. key_32 .. ")")
      btn_item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_System_All_ShowListToolTip(false," .. PaGlobal_Extraction_System_All._itemInfo.slotNo[key_32] .. ",nil)")
    end
    btn_item:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_System_All_SelectListItem(" .. key_32 .. ")")
    text_equipment:SetShow(false)
    hammerIcon:SetShow(false)
  else
    if false == PaGlobal_Extraction_System_All._isConsole then
      itemIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_System_All_equipmentItem(" .. PaGlobal_Extraction_System_All._equipNo[key_32] .. ")")
      itemIcon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_System_All_ShowListToolTip(true," .. PaGlobal_Extraction_System_All._equipNo[key_32] .. ",true)")
      itemIcon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_System_All_ShowListToolTip(true," .. PaGlobal_Extraction_System_All._equipNo[key_32] .. ",false)")
    else
      btn_item:addInputEvent("Mouse_On", "PaGlobal_Extraction_System_All_ShowDetailKeyGuide(true," .. key_32 .. ")")
      btn_item:addInputEvent("Mouse_Out", "PaGlobal_Extraction_System_All_ShowDetailKeyGuide(false," .. key_32 .. ")")
      btn_item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_System_All_ShowListToolTip(true," .. PaGlobal_Extraction_System_All._equipNo[key_32] .. ",nil)")
    end
    btn_item:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_System_All_equipmentItem(" .. PaGlobal_Extraction_System_All._equipNo[key_32] .. ")")
    text_equipment:SetShow(true)
    hammerIcon:SetShow(false)
  end
  PaGlobal_Extraction_System_All._listControl[key_32] = control
  local itemName = PaGlobal_Extraction_System_All._itemInfo.name[key_32]
  local itemIconPath = PaGlobal_Extraction_System_All._itemInfo.iconPath[key_32]
  itemText:SetText(itemName)
  local itemWrapper
  if nil == PaGlobal_Extraction_System_All._equipNo[key_32] then
    itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, PaGlobal_Extraction_System_All._itemInfo.slotNo[key_32])
  else
    itemWrapper = ToClient_getEquipmentItem(PaGlobal_Extraction_System_All._equipNo[key_32])
  end
  if nil ~= itemWrapper then
    PAGlobalFunc_SetItemTextColorForNewUI(itemText, itemWrapper:getStaticStatus())
  end
  itemIcon:ChangeTextureInfoName("icon/" .. itemIconPath)
  if nil ~= PaGlobal_Extraction_System_All._itemInfo.itemEnchantLevle[key_32] then
    itemEnchant:SetText(PaGlobal_Extraction_System_All._itemInfo.itemEnchantLevle[key_32])
  end
  if true == PaGlobal_Extraction_System_All._itemInfo.isExtractionEquip[key_32] then
    hammerIcon:SetShow(true)
    btn_item:SetCheck(true)
  end
  control:ComputePos()
end
function HandleEventLUp_Extraction_System_All_Extraction()
  if nil == PaGlobal_Extraction_System_All._resultMaterialKey then
    return
  end
  local itemName = getItemEnchantStaticStatus(PaGlobal_Extraction_System_All._resultMaterialKey):getName()
  local msgBoxTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EXTRACTIONSYSTEM_TITLE")
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXTRACTIONSYSTEM_POPUPMSG", "itemName", itemName)
  local messageBoxData = {
    title = msgBoxTitle,
    content = messageBoxMemo,
    functionYes = PaGlobal_Extraction_System_All_ExtractionSystem,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_Extraction_System_All_ReSizePanel()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  if false == PaGlobal_Extraction_System_All._isConsole then
    PaGlobal_Extraction_System_All._ui_pc.btn_close:ComputePos()
    PaGlobal_Extraction_System_All._ui_pc.btn_extraction:ComputePos()
  else
  end
  PaGlobal_Extraction_System_All._ui.stc_extractableItemSlot:ComputePos()
  PaGlobal_Extraction_System_All._ui.stc_materialItemSlot:ComputePos()
  PaGlobal_Extraction_System_All._ui.stc_resultItmeSlot:ComputePos()
  PaGlobal_Extraction_System_All._ui.stc_resultMaterialItemSlot:ComputePos()
  PaGlobal_Extraction_System_All._ui.txt_leftBottomDesc:ComputePos()
  PaGlobal_Extraction_System_All._ui.btn_skipAni:ComputePos()
  PaGlobal_Extraction_System_All._ui.list2_extractableItem:ComputePos()
  PaGlobal_Extraction_System_All._ui.txt_noItem:ComputePos()
end
function FromClient_Extraction_System_All_GetExtractResult(rv)
  PaGlobal_ExtractionResult:resetChildControl()
  PaGlobal_ExtractionResult:resetAnimation()
  if 0 == rv then
    audioPostEvent_SystemUi(3, 2)
    _AudioPostEvent_SystemUiForXBOX(3, 2)
    local mainString
    if nil == PaGlobal_Extraction_System_All._resultItemKey then
      return
    end
    local resultItemWrapper = getItemEnchantStaticStatus(PaGlobal_Extraction_System_All._resultItemKey)
    if nil == resultItemWrapper then
      return
    end
    local resultItemName = resultItemWrapper:getName()
    local resultMaterialWrapper = getItemEnchantStaticStatus(PaGlobal_Extraction_System_All._resultMaterialKey)
    if nil == resultMaterialWrapper then
      return
    end
    local resultMaterialName = resultMaterialWrapper:getName()
    mainString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_EXTRACTIONSYSTEM_RESULTMSG", "item1", resultItemName, "itme2", resultMaterialName)
    PaGlobal_ExtractionResult:showResultMessage(mainString, resultItemName .. ", " .. resultMaterialName, PaGlobal_Extraction_System_All._resultItemKey, PaGlobal_Extraction_System_All._resultMaterialKey, nil, true)
    PaGlobal_Extraction_System_All._ui._icon_resultItem.icon:SetMonoTone(false)
    PaGlobal_Extraction_System_All._ui._icon_resultMaterial.icon:SetMonoTone(false)
  else
    audioPostEvent_SystemUi(5, 2)
    _AudioPostEvent_SystemUiForXBOX(5, 2)
    local rvString = PAGetStringSymNo(rv)
    local carphString = PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantRegistCaphrasToExtract")
    local crystalString = PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUsePushedJewelItem")
    local title = PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTIONSYSTEM_FAIL_TITLE")
    local sub = ""
    if rvString == carphString then
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTIONSYSTEM_FAIL_DESC_1")
    elseif rvString == crystalString then
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTIONSYSTEM_FAIL_DESC_2")
    else
      sub = rvString
    end
    PaGlobal_ExtractionResult:showResultMessage(sub, title, nil, nil, nil, false)
  end
  PaGlobal_Extraction_System_All._resultShowTime = 0
  Panel_Window_Extraction_Result:RegisterUpdateFunc("PaGlobal_Extraction_System_All_CheckResultMsgShowTime")
  PaGlobal_Extraction_System_All._isEndExtraction = true
end
function PaGlobal_Extraction_System_All_CheckResultMsgShowTime(DeltaTime)
  PaGlobal_Extraction_System_All._resultShowTime = PaGlobal_Extraction_System_All._resultShowTime + DeltaTime
  if PaGlobal_Extraction_System_All._resultShowTime > 3 and true == Panel_Window_Extraction_Result:GetShow() then
    Panel_Window_Extraction_Result:SetShow(false)
  end
  if PaGlobal_Extraction_System_All._resultShowTime > 5 then
    PaGlobal_Extraction_System_All._resultShowTime = 0
    Panel_Window_Extraction_Result:ClearUpdateLuaFunc()
  end
end
function PaGlobal_Extraction_System_All_ChangeHammerIcon()
  if nil == PaGlobal_Extraction_System_All._curSelectKey then
    return
  end
  if nil == PaGlobal_Extraction_System_All._preSelectKey then
    PaGlobal_Extraction_System_All._preSelectKey = PaGlobal_Extraction_System_All._curSelectKey
  end
  local btn_item = UI.getChildControl(PaGlobal_Extraction_System_All._listControl[PaGlobal_Extraction_System_All._preSelectKey], "RadioButton_ExtractableItem")
  local hammerIcon = UI.getChildControl(btn_item, "Static_Hammer")
  hammerIcon:SetShow(false)
  btn_item = UI.getChildControl(PaGlobal_Extraction_System_All._listControl[PaGlobal_Extraction_System_All._curSelectKey], "RadioButton_ExtractableItem")
  hammerIcon = UI.getChildControl(btn_item, "Static_Hammer")
  hammerIcon:SetShow(true)
  PaGlobal_Extraction_System_All._preSelectKey = PaGlobal_Extraction_System_All._curSelectKey
end
function PaGlobal_Extraction_System_All_ExtractionSystem()
  PaGlobal_Extraction_System_All._isAniStart = true
  PaGlobal_Extraction_System_All._ui._icon_items.icon:SetIgnore(true)
  PaGlobal_Extraction_System_All._ui._icon_material.icon:SetIgnore(true)
  PaGlobal_Extraction_System_All._ui.list2_extractableItem:SetEnable(false)
  PaGlobal_Extraction_System_All._ui_pc.btn_extraction:SetEnable(false)
  PaGlobal_Extraction_System_All._ui_console.stc_iconY_extraction:SetMonoTone(true)
  Panel_Window_Extraction_System_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  PaGlobal_Extraction_System_All._ui.stc_extractableItemSlot:EraseAllEffect()
  PaGlobal_Extraction_System_All._ui.stc_materialItemSlot:EraseAllEffect()
  PaGlobal_Extraction_System_All._ui.stc_resultItmeSlot:EraseAllEffect()
  PaGlobal_Extraction_System_All._ui.stc_resultMaterialItemSlot:EraseAllEffect()
  PaGlobal_Extraction_System_All._ui.stc_extractableItemSlot:AddEffect("fUI_BlackExtractGamos_01A", false, 0.5, 0)
  PaGlobal_Extraction_System_All._ui.stc_materialItemSlot:AddEffect("", false, 0, 0)
  PaGlobal_Extraction_System_All._ui.stc_resultItmeSlot:AddEffect("", false, 0, 0)
  PaGlobal_Extraction_System_All._ui.stc_resultMaterialItemSlot:AddEffect("", false, 0, 0)
  PaGlobal_Extraction_System_All._isSoundFX = true
  if false == PaGlobal_Extraction_System_All._isSkipAni then
    audioPostEvent_SystemUi(5, 72)
    _AudioPostEvent_SystemUiForXBOX(5, 72)
  end
  Panel_Window_Extraction_System_All:RegisterUpdateFunc("PaGlobal_Extraction_System_All_UpdateExtractionAni")
end
function PaGlobal_Extraction_System_All_UpdateExtractionAni(delta)
  if nil == Panel_Window_Extraction_System_All or false == PaGlobal_Extraction_System_All._isAniStart then
    return
  end
  PaGlobal_Extraction_System_All._ui.btn_skipAni:SetIgnore(true)
  PaGlobal_Extraction_System_All._delta_ani_time = PaGlobal_Extraction_System_All._delta_ani_time + delta
  if PaGlobal_Extraction_System_All._sound_ani_time < PaGlobal_Extraction_System_All._delta_ani_time and true == PaGlobal_Extraction_System_All._isSoundFX and false == PaGlobal_Extraction_System_All._isSkipAni then
    audioPostEvent_SystemUi(5, 73)
    _AudioPostEvent_SystemUiForXBOX(5, 73)
    PaGlobal_Extraction_System_All._isSoundFX = false
  end
  if PaGlobal_Extraction_System_All._const_ani_time < PaGlobal_Extraction_System_All._delta_ani_time or true == PaGlobal_Extraction_System_All._isSkipAni then
    PaGlobal_Extraction_System_All._ui._icon_items.icon:SetIgnore(false)
    PaGlobal_Extraction_System_All._ui._icon_material.icon:SetIgnore(false)
    PaGlobal_Extraction_System_All._delta_ani_time = 0
    PaGlobal_Extraction_System_All._ui.btn_skipAni:SetIgnore(false)
    ToClient_requestExtractItem(PaGlobal_Extraction_System_All._extractableSlotNo, PaGlobal_Extraction_System_All._materialSlotNo)
    PaGlobal_Extraction_System_All._isAniStart = false
    PaGlobal_Extraction_System_All:clearExtractionSlot()
    Panel_Window_Extraction_System_All:ClearUpdateLuaFunc()
  end
end
function PaGlobal_Extraction_System_All_ShowDetailKeyGuide(isShow, key)
  PaGlobal_Extraction_System_All._ui_console.stc_iconX:SetShow(isShow)
  if false == isShow then
    PaGlobal_Extraction_System_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
  else
    local slotNo = PaGlobal_Extraction_System_All._itemInfo.slotNo[key]
    if PaGlobal_Extraction_System_All._selectedItemSlotNo == slotNo then
      PaGlobal_Extraction_System_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
    else
      PaGlobal_Extraction_System_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
    end
  end
  PaGlobal_Extraction_System_All_KeyGuidePosUpdate()
end
function PaGlobal_Extraction_System_All_KeyGuidePosUpdate()
  local keyGuides = {
    PaGlobal_Extraction_System_All._ui_console.stc_iconX,
    PaGlobal_Extraction_System_All._ui_console.stc_iconA,
    PaGlobal_Extraction_System_All._ui_console.stc_iconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_Extraction_System_All._ui_console.stc_bottomGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Extraction_System_All_UpdateList()
  if nil == Panel_Window_Extraction_System_All or false == Panel_Window_Extraction_System_All:GetShow() then
    return
  end
  PaGlobal_Extraction_System_All:updateExtractionList()
  PaGlobal_Extraction_System_All:updateToolTip()
  if nil ~= PaGlobal_Extraction_System_All._lastIndex then
    PaGlobal_Extraction_System_All._ui.list2_extractableItem:moveIndex(PaGlobal_Extraction_System_All._lastIndex)
  end
end
function PaGlobal_Extraction_System_All_ShowAni()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
end
function PaGlobal_Extraction_System_All_HideAni()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
end
