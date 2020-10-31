function HandleEventLUp_House_InstallationList_All_TabMenu(tabIndex)
  PaGlobal_House_InstallationList_All:updateTabMenu(tabIndex)
end
function HandleEventOn_House_InstallationList_All_TabMenuTooltip(tabIndex)
  local name
  if PaGlobal_House_InstallationList_All._eTabMenu.All == tabIndex then
    name = PAGetString(Defines.StringSheet_RESOURCE, "HOUSING_BTN_SEARCH_ALL")
  elseif PaGlobal_House_InstallationList_All._eTabMenu.Goods == tabIndex then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HOUSE_INSTALLATIONMODE_SEARCH_GOODS")
  elseif PaGlobal_House_InstallationList_All._eTabMenu.Furniture == tabIndex then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HOUSE_INSTALLATIONMODE_SEARCH_FURNITURE")
  elseif PaGlobal_House_InstallationList_All._eTabMenu.BaseMaterial == tabIndex then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HOUSE_INSTALLATIONMODE_SEARCH_BASEMATERIAL")
  elseif PaGlobal_House_InstallationList_All._eTabMenu.Tools == tabIndex then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HOUSE_INSTALLATIONMODE_SEARCH_TOOLS")
  end
  if nil ~= name then
    local control = PaGlobal_House_InstallationList_All._ui._rdo_tabMenu[tabIndex]
    TooltipSimple_Show(control, name)
  end
end
function HandleEventLUp_House_InstallationList_All_CategoryComboBox()
  if nil == Panel_House_InstallationMode_List_All then
    return
  end
  if true == PaGlobal_House_InstallationList_All._ui._combo_categoryType:isClicked() then
    HandleEventLUp_House_InstallationList_All_SelectCategoryComboBox()
  end
  PaGlobal_House_InstallationList_All._ui._combo_categoryType:ToggleListbox()
  ToClient_padSnapRefreshTarget(PaGlobal_House_InstallationList_All._ui._combo_categoryType)
end
function HandleEventLUp_House_InstallationList_All_SelectCategoryComboBox()
  if nil == Panel_Window_Delivery_All then
    return
  end
  local selectIndex = PaGlobal_House_InstallationList_All._ui._combo_categoryType:GetSelectIndex()
  PaGlobal_House_InstallationList_All:updateCategoryFilter(PaGlobal_House_InstallationList_All._categoryList[selectIndex + 1])
end
function HandleEventOn_House_InstallationList_All_InstalledTooltip(invenSlotNo, slot_Idx, isDetail)
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if nil == houseWrapper then
    return
  end
  local itemSSW = houseWrapper:getCurrentItemEnchantStatStaticWrapper(invenSlotNo)
  if nil == itemSSW then
    return
  end
  local Uislot = PaGlobal_House_InstallationList_All._slotUIPool[slot_Idx]
  if true == PaGlobal_House_InstallationList_All._isConsole then
    if true == isDetail then
      if true == PaGlobalFunc_TooltipInfo_GetShow() then
        PaGlobalFunc_TooltipInfo_Close()
      else
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, PaGlobal_House_InstallationList_All._ui._stc_backGround:GetPosX())
        PaGlobalFunc_FloatingTooltip_Close()
        return
      end
    end
    PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, Uislot._slotItem.icon)
  else
    Panel_Tooltip_Item_Show(itemSSW, Uislot._slotItem.icon, true, false, nil)
  end
end
function HandleEventOn_House_InstallationList_All_NormalItemTooltip(invenType, invenSlotNo, slot_Idx, isDetail)
  local itemWrapper = getInventoryItemByType(invenType, invenSlotNo)
  local Uislot = PaGlobal_House_InstallationList_All._slotUIPool[slot_Idx]
  if true == PaGlobal_House_InstallationList_All._isConsole then
    if true == isDetail then
      if true == PaGlobalFunc_TooltipInfo_GetShow() then
        PaGlobalFunc_TooltipInfo_Close()
      else
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare, PaGlobal_House_InstallationList_All._ui._stc_backGround:GetPosX())
        PaGlobalFunc_FloatingTooltip_Close()
        return
      end
    end
    PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, Uislot._slotItem.icon)
  else
    Panel_Tooltip_Item_Show(itemWrapper, Uislot._slotItem.icon, false, false, nil)
  end
end
function HandleEventOn_House_InstallationList_All_CacheItemTooltip(productNoRaw, slot_Idx, isDetail)
  local cPSSW = ToClient_GetCashProductStaticStatusWrapperByKeyRaw(productNoRaw)
  local itemSSW = cPSSW:getItemByIndex(0)
  local Uislot = PaGlobal_House_InstallationList_All._slotUIPool[slot_Idx]
  if nil == itemSSW then
    return
  end
  if true == PaGlobal_House_InstallationList_All._isConsole then
    if true == isDetail then
      if true == PaGlobalFunc_TooltipInfo_GetShow() then
        PaGlobalFunc_TooltipInfo_Close()
      else
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, PaGlobal_House_InstallationList_All._ui._stc_backGround:GetPosX())
        PaGlobalFunc_FloatingTooltip_Close()
        return
      end
    end
    PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, Uislot._slotItem.icon)
  else
    Panel_Tooltip_Item_Show(itemSSW, Uislot._slotItem.icon, true, false)
  end
end
function HandleEventLUp_House_InstallationList_All_InstalledDeleteObject(idx)
  if MessageBoxGetShow() then
    return
  end
  if housing_isTemporaryObject() or PaGlobal_House_InstallationMode_ObjectControl_All_GetShowPanel() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_DELETEOBJECT_ACK"))
    return
  end
  local itemName = ""
  PaGlobal_House_InstallationList_All._deleteItemIdx = idx
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if nil == houseWrapper then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_GOTO_NEAR_HOUSEHOLD"))
    return
  end
  local itemSSW = houseWrapper:getCurrentItemEnchantStatStaticWrapper(idx)
  local installationType
  if nil ~= itemSSW then
    installationType = itemSSW:getCharacterStaticStatus():getObjectStaticStatus():getInstallationType()
    itemName = itemSSW:getName()
  end
  local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local messageContent = ""
  if CppEnums.InstallationType.eType_WallPaper == installationType or CppEnums.InstallationType.eType_FloorMaterial == installationType or CppEnums.InstallationType.eType_Havest == installationType then
    messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_CONFIRM_ITEMDELETE", "itemName", itemName)
  else
    messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_MSGBOX_CONTENT", "itemName", itemName)
  end
  local messageBox_HouseInstallation_Delete_InstalledObjectDo = function()
    PaGlobal_House_InstallationMode_ObjectControl_All_Close()
    housing_deleteObject_InstalledObjectList(PaGlobal_House_InstallationList_All._deleteItemIdx)
  end
  local messageBoxData = {
    title = messageTitle,
    content = messageContent,
    functionYes = messageBox_HouseInstallation_Delete_InstalledObjectDo,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_House_InstallationList_All_InstallFurniture(invenType, invenSlotNo, iscash, productNo)
  PaGlobal_House_InstallationMode_ObjectControl_All_Close()
  if MessageBoxGetShow() then
    return
  end
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if nil == houseWrapper then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_INSTALL_NEAR_HOUSEHOLD"))
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  if false == iscash then
    housing_selectInstallationItem(invenType, invenSlotNo)
  else
    housing_selectInstallationItemForCashShop(productNo)
  end
end
function HandleEventScroll_House_InstallationList_All_UpdateScroll(isUp)
  local slotCols = PaGlobal_House_InstallationList_All._itemSlotCol
  local slotRows = PaGlobal_House_InstallationList_All._itemSlotRow
  local maxSize = PaGlobal_House_InstallationList_All._maxItemDataCount
  local remain = maxSize % slotCols
  if 0 < remain then
    maxSize = maxSize + (slotCols - remain)
  end
  local beforeSlotIndex = PaGlobal_House_InstallationList_All._startItemSlotIndex
  PaGlobal_House_InstallationList_All._startItemSlotIndex = UIScroll.ScrollEvent(PaGlobal_House_InstallationList_All._ui._scroll_itemList, isUp, slotRows, maxSize, PaGlobal_House_InstallationList_All._startItemSlotIndex, slotCols)
  if _ContentsGroup_UsePadSnapping and beforeSlotIndex ~= PaGlobal_House_InstallationList_All._startItemSlotIndex then
    ToClient_padSnapIgnoreGroupMove()
  end
  PaGlobal_House_InstallationList_All:updateItemSlot(PaGlobal_House_InstallationList_All._startItemSlotIndex)
end
function HandleEventLUp_House_InstallationList_All_EditItemNameClear()
  PaGlobal_House_InstallationList_All._ui._edit_searchBox:SetEditText("", true)
  SetFocusEdit(PaGlobal_House_InstallationList_All._ui._edit_searchBox)
  PaGlobal_House_InstallationList_All._ui._txt_searchIcon:SetShow(false)
end
function HandleEventKey_House_InstallationList_All_FindItemName()
  local inputKeyword = PaGlobal_House_InstallationList_All._ui._edit_searchBox:GetEditText()
  ClearFocusEdit()
  ToClient_Housing_List_ClearFilter()
  ToClient_Housing_List_Filter_Search(inputKeyword)
  if nil ~= inputKeyword and "" ~= inputKeyword and PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_EDIT_ITEMNAME") ~= inputKeyword then
    PaGlobal_House_InstallationList_All:initItemSlotScroll()
    PaGlobal_House_InstallationList_All:updateItemSlot(PaGlobal_House_InstallationList_All._startItemSlotIndex)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_ACK_SEARCH"))
    return
  end
end
function HandleEventKey_House_InstallationList_All_FindItemName_ForConsole(str)
  PaGlobal_House_InstallationList_All._ui._edit_searchBox:SetEditText(str)
  ClearFocusEdit()
  ToClient_Housing_List_ClearFilter()
  ToClient_Housing_List_Filter_Search(str)
  if nil ~= str and "" ~= str and PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_EDIT_ITEMNAME") ~= str then
    PaGlobal_House_InstallationList_All:initItemSlotScroll()
    PaGlobal_House_InstallationList_All:updateItemSlot(PaGlobal_House_InstallationList_All._startItemSlotIndex)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_ACK_SEARCH"))
    return
  end
end
function HandleEventLUp_House_InstallationList_All_ResetFurniture()
  if MessageBoxGetShow() then
    return
  end
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if nil == houseWrapper then
    return
  end
  local installedCount = houseWrapper:getInstallationCount()
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local freeNormalInventorySlot = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eInventory):getFreeCount()
  local freeCashInventorySlot = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eCashInventory):getFreeCount()
  local installedItemCount = houseWrapper:getInstallationCount()
  local installedNoramlItemCount = 0
  local installedCashItemCount = 0
  for installed_Idx = 0, installedItemCount do
    local itemSSW = houseWrapper:getCurrentItemEnchantStatStaticWrapper(installed_Idx)
    if nil ~= itemSSW then
      if itemSSW:get():isCash() then
        installedCashItemCount = installedCashItemCount + 1
      else
        installedNoramlItemCount = installedNoramlItemCount + 1
      end
    end
  end
  PaGlobal_House_InstallationMode_ObjectControl_All_Close()
  local function installed_Delete_All()
    for idx = 0, installedItemCount - 1 do
      housing_deleteObject_InstalledObjectList(idx)
    end
  end
  local localtitle = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_INSTALLMODE_WITHDRAW_1")
  local localcontent = ""
  local localfunctionYes, localfunctionApply, localfunctionCancle
  if 0 == installedCount then
    localcontent = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_INSTALLMODE_WITHDRAW_2")
    localfunctionApply = MessageBox_Empty_function
  elseif 0 == freeNormalInventorySlot or 0 == freeCashInventorySlot then
    localcontent = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_INSTALLMODE_WITHDRAW_3")
    localfunctionApply = MessageBox_Empty_function
  elseif freeNormalInventorySlot < installedNoramlItemCount or freeCashInventorySlot < installedCashItemCount then
    localcontent = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_HOUSING_INSTALLMODE_WITHDRAW_4", "InstalledCount", installedCount, "FreeInventorySlot", freeNormalInventorySlot)
    localfunctionYes = installed_Delete_All
    localfunctionCancle = MessageBox_Empty_function
  else
    localcontent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSING_INSTALLMODE_WITHDRAW_5", "count", installedCount) .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_INSTALLMODE_WITHDRAW_6")
    localfunctionYes = installed_Delete_All
    localfunctionCancle = MessageBox_Empty_function
  end
  local messageboxData = {
    title = localtitle,
    content = localcontent,
    functionYes = localfunctionYes,
    functionApply = localfunctionApply,
    functionNo = localfunctionCancle,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_House_InstallationList_All_Exit()
  PaGlobal_HouseName_All_ResetAlertHouseLighting()
  FromClient_House_InstallationList_All_CancelInstallModeMessageBox()
end
function HandleEventPad_House_InstallationList_All_LBorRB(isLB)
  if true == isLB then
    PaGlobal_House_InstallationList_All._currentTabIndex = PaGlobal_House_InstallationList_All._currentTabIndex - 1
    if PaGlobal_House_InstallationList_All._currentTabIndex < PaGlobal_House_InstallationList_All._eTabMenu.All then
      PaGlobal_House_InstallationList_All._currentTabIndex = PaGlobal_House_InstallationList_All._eTabMenu.Tools
    end
  else
    PaGlobal_House_InstallationList_All._currentTabIndex = PaGlobal_House_InstallationList_All._currentTabIndex + 1
    if PaGlobal_House_InstallationList_All._eTabMenu.Tools < PaGlobal_House_InstallationList_All._currentTabIndex then
      PaGlobal_House_InstallationList_All._currentTabIndex = PaGlobal_House_InstallationList_All._eTabMenu.All
    end
  end
  PaGlobal_House_InstallationList_All:updateTabMenu(PaGlobal_House_InstallationList_All._currentTabIndex)
end
function HandleEventOn_House_InstallationList_All_FocusSlot(index)
  PaGlobal_House_InstallationList_All._currentItemIndex = index
end
function HandleEventOn_House_InstallationList_All_CartItemTooltip(itemIndex, slotIndex, isDetail)
  local data = housing_getShoppingBasketItemByIndex_New(itemIndex)
  if nil == data then
    return
  end
  local itemSSW = data:getItemByIndex(0)
  if nil == itemSSW then
    return
  end
  local control = PaGlobal_House_InstallationList_All._slotUICartPool[slotIndex]._slotItem.icon
  if true == PaGlobal_House_InstallationList_All._isConsole then
    if true == isDetail then
      if true == PaGlobalFunc_TooltipInfo_GetShow() then
        PaGlobalFunc_TooltipInfo_Close()
      else
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, PaGlobal_House_InstallationList_All._ui._stc_backGround:GetPosX())
        PaGlobalFunc_FloatingTooltip_Close()
        return
      end
    end
    PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, control)
  else
    Panel_Tooltip_Item_Show(itemSSW, control, true, false)
  end
end
function HandleEventScroll_House_InstallationList_All_UpdateCartScroll(isUp)
  local slotCols = PaGlobal_House_InstallationList_All._cartItemSlotCol
  local slotRows = PaGlobal_House_InstallationList_All._cartItemSlotRow
  local maxSize = PaGlobal_House_InstallationList_All._maxCartItemDataCount
  local remain = maxSize % slotCols
  if 0 < remain then
    maxSize = maxSize + (slotCols - remain)
  end
  local beforeSlotIndex = PaGlobal_House_InstallationList_All._startCartItemSlotIndex
  PaGlobal_House_InstallationList_All._startCartItemSlotIndex = UIScroll.ScrollEvent(PaGlobal_House_InstallationList_All._ui._scroll_cartItemList, isUp, slotRows, maxSize, PaGlobal_House_InstallationList_All._startCartItemSlotIndex, slotCols)
  if (_ContentsGroup_UsePadSnapping or ToClient_IsDevelopment()) and beforeSlotIndex ~= PaGlobal_House_InstallationList_All._startCartItemSlotIndex then
    ToClient_padSnapIgnoreGroupMove()
  end
  PaGlobal_House_InstallationList_All:updateCartItemSlot()
end
function HandleEventLUp_House_InstallationList_All_CartItemRemove(slot_Idx)
  housing_clearShoppingBasketItemByIndex(slot_Idx)
  PaGlobal_House_InstallationList_All_UpdateCart()
  Panel_Tooltip_Item_hideTooltip()
end
function HandleEventLUp_House_InstallationList_All_CartBuyAll()
  local buyCartDo = function()
    housing_buyShoppinBasketItems()
  end
  local messageBoxMemo = ""
  if getSelfPlayer():get():isMyHouseVisiting() then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_CART_BUYITEMALL_MSGMEMO1")
  else
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_CART_BUYITEMALL_MSGMEMO2")
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = housing_buyShoppinBasketItems,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_House_InstallationList_All_CartResetAll()
  housing_clearShoppingBasketItems()
  PaGlobal_House_InstallationList_All_UpdateCart()
end
function HandleEventPad_House_InstallationList_All_LBorRB(isLB)
  if true == isLB then
    PaGlobal_House_InstallationList_All._currentTabIndex = PaGlobal_House_InstallationList_All._currentTabIndex - 1
    if PaGlobal_House_InstallationList_All._currentTabIndex < PaGlobal_House_InstallationList_All._eTabMenu.All then
      PaGlobal_House_InstallationList_All._currentTabIndex = PaGlobal_House_InstallationList_All._eTabMenu.Tools
    end
  else
    PaGlobal_House_InstallationList_All._currentTabIndex = PaGlobal_House_InstallationList_All._currentTabIndex + 1
    if PaGlobal_House_InstallationList_All._eTabMenu.Tools < PaGlobal_House_InstallationList_All._currentTabIndex then
      PaGlobal_House_InstallationList_All._currentTabIndex = PaGlobal_House_InstallationList_All._eTabMenu.All
    end
  end
  PaGlobal_House_InstallationList_All:updateTabMenu(PaGlobal_House_InstallationList_All._currentTabIndex)
end
function HandleEventOn_House_InstallationList_All_FocusSlot(index)
  PaGlobal_House_InstallationList_All._currentItemIndex = index
end
function FromClient_House_InstallationList_All_UpdateItemInventory()
  if false == PaGlobal_House_InstallationList_All_GetShowPanel() then
    return
  end
  PaGlobal_House_InstallationList_All:updateItemSetData(true)
  PaGlobal_House_InstallationList_All:updateItemSlot(PaGlobal_House_InstallationList_All._startItemSlotIndex)
  PaGlobal_House_InstallationList_All:updateCartItemSetData()
end
function FromClient_House_InstallationList_All_UpdateInstallationActor(isAdd)
  if false == PaGlobal_House_InstallationList_All_GetShowPanel() then
    return
  end
  PaGlobal_House_InstallationList_All:updateItemSetData(true)
  PaGlobal_House_InstallationList_All:updateItemSlot(PaGlobal_House_InstallationList_All._startItemSlotIndex)
end
function FromClient_House_InstallationList_All_CancelInstallModeMessageBox()
  if false == PaGlobal_House_InstallationList_All_GetShowPanel() then
    return
  end
  PaGlobal_House_Installation_All_CancelInstallModeMessageBox()
end
function FromClient_House_InstallationList_All_EventHousingPointUpdate()
  if false == PaGlobal_House_InstallationList_All_GetShowPanel() then
    return
  end
  PaGlobal_House_InstallationList_All:updatePoint()
end
function PaGlobal_House_InstallationList_All_ShowAni()
  if nil == Panel_House_InstallationMode_List_All then
    return
  end
end
function PaGlobal_House_InstallationList_All_HideAni()
  if nil == Panel_House_InstallationMode_List_All then
    return
  end
end
function PaGlobal_House_InstallationList_All_Open()
  PaGlobal_House_InstallationList_All:prepareOpen()
end
function PaGlobal_House_InstallationList_All_Close()
  PaGlobal_House_InstallationList_All:prepareClose()
end
function PaGlobal_House_InstallationList_All_UpdateCart()
  PaGlobal_House_InstallationList_All:updateCartItemSetData()
end
function PaGlobal_House_InstallationList_All_GetShowPanel()
  if nil == Panel_House_InstallationMode_List_All then
    return false
  end
  return Panel_House_InstallationMode_List_All:GetShow()
end
function PaGlobal_House_InstallationList_All_SetSearchFocus()
  ClearFocusEdit()
  PaGlobal_House_InstallationList_All._ui._edit_searchBox:SetEditText("", false)
  SetFocusEdit(PaGlobal_House_InstallationList_All._ui._edit_searchBox)
  PaGlobal_House_InstallationList_All._ui._txt_searchIcon:SetShow(false)
end
function PaGlobal_House_InstallationList_All_SetKeyGuide(modeState)
  PaGlobal_House_InstallationList_All:setKeyGuide(modeState)
end
