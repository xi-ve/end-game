function HandleEventScroll_Farm_InstallationList_All_UpdateScroll(isUp)
  local slotCols = PaGlobal_Farm_InstallationList_All._itemSlotCol
  local slotRows = PaGlobal_Farm_InstallationList_All._itemSlotRow
  local maxSize = PaGlobal_Farm_InstallationList_All._maxItemDataCount
  local remain = maxSize % slotCols
  if 0 < remain then
    maxSize = maxSize + (slotCols - remain)
  end
  local beforeSlotIndex = PaGlobal_Farm_InstallationList_All._startItemSlotIndex
  PaGlobal_Farm_InstallationList_All._startItemSlotIndex = UIScroll.ScrollEvent(PaGlobal_Farm_InstallationList_All._ui._scroll_itemList, isUp, slotRows, maxSize, PaGlobal_Farm_InstallationList_All._startItemSlotIndex, slotCols)
  if _ContentsGroup_UsePadSnapping and beforeSlotIndex ~= PaGlobal_Farm_InstallationList_All._startItemSlotIndex then
    ToClient_padSnapIgnoreGroupMove()
  end
  PaGlobal_Farm_InstallationList_All:updateItemSlot(PaGlobal_Farm_InstallationList_All._startItemSlotIndex)
end
function HandleEventLUp_Farm_InstallationList_All_TabEvent(tabIndex)
  PaGlobal_Farm_InstallationList_All:updateTabMenu(tabIndex)
end
function HandleEventOn_Farm_InstallationList_All_InstalledTooltip(invenSlotNo, slot_Idx, isDetail)
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if nil == houseWrapper then
    return
  end
  local itemSSW = houseWrapper:getCurrentItemEnchantStatStaticWrapper(invenSlotNo)
  if nil == itemSSW then
    return
  end
  local Uislot = PaGlobal_Farm_InstallationList_All._slotUIPool[slot_Idx]
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
function HandleEventOn_Farm_InstallationList_All_NormalItemTooltip(invenType, invenSlotNo, slot_Idx, isDetail)
  local itemWrapper = getInventoryItemByType(invenType, invenSlotNo)
  local Uislot = PaGlobal_Farm_InstallationList_All._slotUIPool[slot_Idx]
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
function HandleEventOn_Farm_InstallationList_All_CacheItemTooltip(productNoRaw, slot_Idx, isDetail)
  local cPSSW = ToClient_GetCashProductStaticStatusWrapperByKeyRaw(productNoRaw)
  local itemSSW = cPSSW:getItemByIndex(0)
  local Uislot = PaGlobal_Farm_InstallationList_All._slotUIPool[slot_Idx]
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
function HandleEventLUp_Farm_InstallationList_All_InstalledDeleteObject(idx)
  if MessageBoxGetShow() then
    return
  end
  if housing_isTemporaryObject() or PaGlobal_House_InstallationMode_ObjectControl_All_GetShowPanel() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_DELETEOBJECT_ACK"))
    return
  end
  local itemName = ""
  PaGlobal_Farm_InstallationList_All._deleteItemIdx = idx
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
    if nil ~= PaGlobal_FarmInfo_All_Close then
      PaGlobal_FarmInfo_All_Close()
    end
    PaGlobal_House_InstallationMode_ObjectControl_All_Close()
    housing_deleteObject_InstalledObjectList(PaGlobal_Farm_InstallationList_All._deleteItemIdx)
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
function HandleEventLUp_Farm_InstallationList_All_InstallFurniture(invenType, invenSlotNo, iscash, productNo)
  if nil ~= PaGlobal_FarmInfo_All_Close then
    PaGlobal_FarmInfo_All_Close()
  end
  PaGlobal_House_InstallationMode_ObjectControl_All_Close()
  if MessageBoxGetShow() then
    return
  end
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if nil == houseWrapper then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_INSTALL_NEAR_HOUSEHOLD"))
    return
  end
  if false == iscash then
    housing_selectInstallationItem(invenType, invenSlotNo)
  else
    housing_selectInstallationItemForCashShop(productNo)
  end
end
function HandleEventLUp_Farm_InstallationList_All_EditItemNameClear()
  PaGlobal_Farm_InstallationList_All._ui._edit_searchBox:SetEditText("", true)
  SetFocusEdit(PaGlobal_Farm_InstallationList_All._ui._edit_searchBox)
  PaGlobal_Farm_InstallationList_All._ui._txt_searchIcon:SetShow(false)
end
function HandleEventKey_Farm_InstallationList_All_FindItemName()
  local inputKeyword = PaGlobal_Farm_InstallationList_All._ui._edit_searchBox:GetEditText()
  ClearFocusEdit()
  ToClient_Housing_List_ClearFilter()
  ToClient_Housing_List_Filter_Search(inputKeyword)
  if nil ~= inputKeyword and "" ~= inputKeyword and PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_EDIT_ITEMNAME") ~= inputKeyword then
    PaGlobal_Farm_InstallationList_All:initItemSlotScroll()
    PaGlobal_Farm_InstallationList_All:updateItemSlot(PaGlobal_Farm_InstallationList_All._startItemSlotIndex)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_ACK_SEARCH"))
    return
  end
end
function HandleEventKey_Farm_InstallationList_All_FindItemName_ForConsole(str)
  PaGlobal_Farm_InstallationList_All._ui._edit_searchBox:SetEditText(str)
  ClearFocusEdit()
  ToClient_Housing_List_ClearFilter()
  ToClient_Housing_List_Filter_Search(str)
  if nil ~= str and "" ~= str and PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_EDIT_ITEMNAME") ~= str then
    PaGlobal_Farm_InstallationList_All:initItemSlotScroll()
    PaGlobal_Farm_InstallationList_All:updateItemSlot(PaGlobal_Farm_InstallationList_All._startItemSlotIndex)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_ACK_SEARCH"))
    return
  end
end
function HandleEventLUp_Farm_InstallationList_All_ResetFurniture()
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
    localcontent = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_RESET_DESC")
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
function HandleEventLUp_Farm_InstallationList_All_Exit()
  PaGlobal_HouseName_All_ResetAlertHouseLighting()
  FromClient_Farm_InstallationList_All_CancelInstallModeMessageBox()
end
function HandleEventLUp_Farm_InstallationList_All_BasicGuide(guideType)
  local title = PaGlobal_Farm_InstallationList_All._basicTitle[guideType]
  local desc = PaGlobal_Farm_InstallationList_All._basicDesc[guideType]
  PaGlobal_Farm_InstallationList_All:updateDesc(title, desc)
end
function HandleEventLUp_Farm_InstallationList_All_ManageGuide(guideType)
  local title = PaGlobal_Farm_InstallationList_All._manageTitle[guideType]
  local desc = PaGlobal_Farm_InstallationList_All._manageDesc[guideType]
  PaGlobal_Farm_InstallationList_All:updateDesc(title, desc)
end
function HandleEventLUp_Farm_InstallationList_All_HarvestGuide(guideType)
  local title = PaGlobal_Farm_InstallationList_All._havestTitle[guideType]
  local desc = PaGlobal_Farm_InstallationList_All._havestDesc[guideType]
  PaGlobal_Farm_InstallationList_All:updateDesc(title, desc)
end
function HandleEventOn_Farm_InstallationList_All_BasicGuideTooltip(guideType)
  local control = PaGlobal_Farm_InstallationList_All._ui._rdo_basicButtons[guideType]
  local title = PaGlobal_Farm_InstallationList_All._basicTitle[guideType]
  TooltipSimple_Show(control, title)
end
function HandleEventOn_Farm_InstallationList_All_ManageGuideTooltip(guideType)
  local control = PaGlobal_Farm_InstallationList_All._ui._rdo_manageButtons[guideType]
  local title = PaGlobal_Farm_InstallationList_All._manageTitle[guideType]
  TooltipSimple_Show(control, title)
end
function HandleEventOn_Farm_InstallationList_All_HarverstGuideTooltip(guideType)
  local control = PaGlobal_Farm_InstallationList_All._ui._rdo_harvestButtons[guideType]
  local title = PaGlobal_Farm_InstallationList_All._havestTitle[guideType]
  TooltipSimple_Show(control, title)
end
function HandleEventPad_Farm_InstallationList_All_LBorRB(isLB)
  if true == isLB then
    PaGlobal_Farm_InstallationList_All._currentTabIndex = PaGlobal_Farm_InstallationList_All._currentTabIndex - 1
    if PaGlobal_Farm_InstallationList_All._currentTabIndex < PaGlobal_Farm_InstallationList_All._eTabType.all then
      PaGlobal_Farm_InstallationList_All._currentTabIndex = PaGlobal_Farm_InstallationList_All._eTabType.material
    end
  else
    PaGlobal_Farm_InstallationList_All._currentTabIndex = PaGlobal_Farm_InstallationList_All._currentTabIndex + 1
    if PaGlobal_Farm_InstallationList_All._eTabType.material < PaGlobal_Farm_InstallationList_All._currentTabIndex then
      PaGlobal_Farm_InstallationList_All._currentTabIndex = PaGlobal_Farm_InstallationList_All._eTabType.all
    end
  end
  PaGlobal_Farm_InstallationList_All:updateTabMenu(PaGlobal_Farm_InstallationList_All._currentTabIndex)
end
function HandleEventOn_Farm_InstallationList_All_FocusSlot(index)
  PaGlobal_Farm_InstallationList_All._currentItemIndex = index
end
function PaGlobal_Farm_InstallationList_All_ShowAni()
  if nil == Panel_House_InstallationMode_SeedList_All then
    return
  end
end
function PaGlobal_Farm_InstallationList_All_HideAni()
  if nil == Panel_House_InstallationMode_SeedList_All then
    return
  end
end
function FromClient_Farm_InstallationList_All_UpdateItemInventory()
  if false == PaGlobal_Farm_InstallationList_All_GetShowPanel() then
    return
  end
  PaGlobal_Farm_InstallationList_All:initItemSlotScroll()
  PaGlobal_Farm_InstallationList_All:updateItemSlot(PaGlobal_Farm_InstallationList_All._startItemSlotIndex)
end
function FromClient_Farm_InstallationList_All_UpdateInstallationActor(isAdd)
  if false == PaGlobal_Farm_InstallationList_All_GetShowPanel() then
    return
  end
  PaGlobal_Farm_InstallationList_All:updateItemSetData(true)
  PaGlobal_Farm_InstallationList_All:updateItemSlot(PaGlobal_Farm_InstallationList_All._startItemSlotIndex)
end
function FromClient_Farm_InstallationList_All_CancelInstallModeMessageBox()
  if false == PaGlobal_Farm_InstallationList_All_GetShowPanel() then
    return
  end
  PaGlobal_House_Installation_All_CancelInstallModeMessageBox()
end
function PaGlobal_Farm_InstallationList_All_Open()
  PaGlobal_Farm_InstallationList_All:prepareOpen()
end
function PaGlobal_Farm_InstallationList_All_Close()
  PaGlobal_Farm_InstallationList_All:prepareClose()
end
function PaGlobal_Farm_InstallationList_All_GetShowPanel()
  if nil == Panel_House_InstallationMode_SeedList_All then
    return false
  end
  return Panel_House_InstallationMode_SeedList_All:GetShow()
end
function PaGlobal_Farm_InstallationList_All_SetSearchFocus()
  ClearFocusEdit()
  PaGlobal_Farm_InstallationList_All._ui._edit_searchBox:SetEditText("", false)
  SetFocusEdit(PaGlobal_Farm_InstallationList_All._ui._edit_searchBox)
  PaGlobal_Farm_InstallationList_All._ui._txt_searchIcon:SetShow(false)
end
function PaGlobal_Farm_InstallationList_All_SetKeyGuide(modeState)
  PaGlobal_Farm_InstallationList_All:setKeyGuide(modeState)
end
function PaGlobal_Farm_InstallationList_All_HotKeyInstall(index)
  if nil == Panel_House_InstallationMode_SeedList_All then
    return
  end
  local data = ToClient_GetFurniture(index - 1)
  if nil == data then
    return
  end
  if true == data._isInstalled then
    HandleEventLUp_Farm_InstallationList_All_InstalledDeleteObject(data._invenSlotNo)
  elseif not data._isCashProduct then
    HandleEventLUp_Farm_InstallationList_All_InstallFurniture(data._invenType, data._invenSlotNo, false, 0)
  else
    HandleEventLUp_Farm_InstallationList_All_InstallFurniture(data._invenType, data._invenSlotNo, true, data._productNoRaw)
  end
end
function PaGlobal_Farm_InstallationList_All_UpdatePerFrame(deltaTime)
  if false == PaGlobal_Farm_InstallationList_All._isConsole then
    return
  end
  local scrollSpeed = 2
  if true == isPadPressed(__eJoyPadInputType_X) then
    if true == isPadPressed(__eJoyPadInputType_DPad_Down) then
      if true == PaGlobal_Farm_InstallationList_All._ui._frame_VScroll:GetShow() then
        local currentY = PaGlobal_Farm_InstallationList_All._ui._frame_Content:GetPosY()
        local currentYSize = PaGlobal_Farm_InstallationList_All._ui._frame_Content:GetSizeY()
        local maxPosY = PaGlobal_Farm_InstallationList_All._ui._frame_guideDescBg:GetSizeY() - currentYSize
        PaGlobal_Farm_InstallationList_All._ui._frame_Content:SetPosY(math.max(maxPosY, currentY - scrollSpeed))
        PaGlobal_Farm_InstallationList_All:updateConsoleScrollPos()
      end
    elseif true == isPadPressed(__eJoyPadInputType_DPad_Up) and true == PaGlobal_Farm_InstallationList_All._ui._frame_VScroll:GetShow() then
      local currentY = PaGlobal_Farm_InstallationList_All._ui._frame_Content:GetPosY()
      PaGlobal_Farm_InstallationList_All._ui._frame_Content:SetPosY(math.min(0, currentY + scrollSpeed))
      PaGlobal_Farm_InstallationList_All:updateConsoleScrollPos()
    end
  end
end
