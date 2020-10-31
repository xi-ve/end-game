function PaGlobalFunc_ClothInventory_All_Open()
  if nil == Panel_Window_ClothInventory_All then
    return
  end
  PaGlobal_ClothInventory_All:prepareOpen()
end
function PaGlobalFunc_ClothInventory_All_Close()
  if nil == Panel_Window_ClothInventory_All then
    return
  end
  PaGlobal_ClothInventory_All:prepareClose()
end
function PaGlobalFunc_ClothInventory_All_GetShow()
  if nil == Panel_Window_ClothInventory_All then
    return
  end
  return Panel_Window_ClothInventory_All:GetShow()
end
function FromClient_ClothInventory_All_ShowInventoryBag(bagType, bagSize, fromWhereType, fromSlotNo)
  if nil == Panel_Window_ClothInventory_All then
    return
  end
  UI.ASSERT_NAME(nil ~= bagType, "FromClient_ClothInventory_All_ShowInventoryBag bagType nil", "\235\176\149\236\132\156\236\156\164")
  UI.ASSERT_NAME(nil ~= bagSize, "FromClient_ClothInventory_All_ShowInventoryBag bagSize nil", "\235\176\149\236\132\156\236\156\164")
  UI.ASSERT_NAME(nil ~= fromWhereType, "FromClient_ClothInventory_All_ShowInventoryBag fromWhereType nil", "\235\176\149\236\132\156\236\156\164")
  UI.ASSERT_NAME(nil ~= fromSlotNo, "FromClient_ClothInventory_All_ShowInventoryBag fromSlotNo nil", "\235\176\149\236\132\156\236\156\164")
  PaGlobal_ClothInventory_All:showInventoryBag(bagType, bagSize, fromWhereType, fromSlotNo)
end
function PaGlobalFunc_ClothInventory_All_UpdateInventoryBag()
  if false == Panel_Window_ClothInventory_All:GetShow() then
    return
  end
  PaGlobal_ClothInventory_All:updateInventoryBag()
end
function PaGloablFunc_ClothInventory_All_SetFilter(slotNo, itemWrapper, count, inventoryType)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return true
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if false == itemSSW:get():checkToPushToInventoryBag() then
    return true
  end
  if CppEnums.InventoryBagType.eInventoryBagType_Misc == PaGlobal_ClothInventory_All._inventoryBagType and false == itemSSW:isUserVested() and true == itemWrapper:get():isVested() then
    return true
  end
  if false == ToClient_CheckToPushToInventoryBag(PaGlobal_ClothInventory_All._fromWhereType, PaGlobal_ClothInventory_All._fromSlotNo, PaGlobal_ClothInventory_All._fromWhereType, slotNo) then
    return true
  end
  if CppEnums.ItemWhereType.eCashInventory == PaGlobal_ClothInventory_All._bagType then
    if 0 == Inventory_GetCurrentInventoryType() then
      return true
    end
  elseif CppEnums.ItemWhereType.eInventory == PaGlobal_ClothInventory_All._bagType and 17 == Inventory_GetCurrentInventoryType() then
    return true
  end
  if CppEnums.InventoryBagType.eInventoryBagType_Misc == PaGlobal_ClothInventory_All._inventoryBagType or CppEnums.InventoryBagType.eInventoryBagType_MiscForCash == PaGlobal_ClothInventory_All._inventoryBagType then
    return false
  end
  local myClass = selfPlayer:getClassType()
  local isEuqipItem = itemSSW:isEquipable()
  local isUsableItem = itemSSW:get()._usableClassType:isOn(myClass)
  local isPushableItem = itemWrapper:isPushableInventoryBag()
  if isEuqipItem and isUsableItem and isPushableItem then
    return false
  end
  return true
end
function HandleEventRUp_ClothInventory_All_InvenRClick(slotNo, itemWrapper, count, inventoryType)
  local itemStatic = itemWrapper:getStaticStatus()
  if nil == itemWrapper then
    return
  end
  if false == itemStatic:get():checkToPushToInventoryBag() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CLOTHINVENTORY_INPUTALERT"))
    return
  end
  local itemCount = itemWrapper:get():getCount_s64()
  local useNumberPad = itemStatic:isStackable() and Int64toInt32(itemCount) > 1
  if useNumberPad then
    Panel_NumberPad_Show(true, itemCount, nil, function(inputNumber)
      ToClient_ReqPushInventoryItemToInventoryBag(inventoryType, slotNo, PaGlobal_ClothInventory_All._fromWhereType, PaGlobal_ClothInventory_All._fromSlotNo, inputNumber)
    end)
  else
    ToClient_ReqPushInventoryItemToInventoryBag(inventoryType, slotNo, PaGlobal_ClothInventory_All._fromWhereType, PaGlobal_ClothInventory_All._fromSlotNo, 1)
  end
end
function HandleEventRUp_ClothInventory_All_ClothInvenRClick(fromWhereType, fromSlotNo, bagIndex, bagWhereType)
  local itemWrapper = getInventoryBagItemByType(fromWhereType, fromSlotNo, bagIndex)
  if nil == itemWrapper then
    return
  end
  local itemCount = itemWrapper:get():getCount_s64()
  local useNumberPad = itemWrapper:getStaticStatus():isStackable() and Int64toInt32(itemCount) > 1
  if useNumberPad then
    Panel_NumberPad_Show(true, itemCount, nil, function(inputNumber)
      ToClient_ReqPopInventoryBagItemToInventory(fromWhereType, fromSlotNo, bagIndex, bagWhereType, inputNumber)
    end)
  else
    ToClient_ReqPopInventoryBagItemToInventory(fromWhereType, fromSlotNo, bagIndex, bagWhereType, 1)
  end
end
function PaGlobalFunc_ClothInventory_All_ChangeAllItem()
  if nil == Panel_Window_ClothInventory_All then
    return
  end
  if false == PaGlobalFunc_ClothInventory_All_GetShow() then
    return
  end
  ToClient_ReqEquipItemFromInventoryBag(PaGlobal_ClothInventory_All._fromWhereType, PaGlobal_ClothInventory_All._fromSlotNo)
end
function PaGlobalFunc_ClothInventory_All_ShowFloatingTooltip(isShow, fromWhereType, fromSlotNo, index)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  PaGlobal_ClothInventory_All._currSlotInfo.index = index
  PaGlobal_ClothInventory_All._currSlotInfo.fromSlotNo = fromSlotNo
  PaGlobal_ClothInventory_All._currSlotInfo.fromWhereType = fromWhereType
  if nil == fromWhereType or nil == fromSlotNo or nil == index then
    return
  end
  local itemWrapper = getInventoryBagItemByType(fromWhereType, fromSlotNo, index)
  if nil ~= itemWrapper then
    if true == _ContentsGroup_RenewUI_Tooltip then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, PaGlobal_ClothInventory_All._slot[index].icon)
    else
      Panel_Tooltip_Item_Show(itemWrapper, PaGlobal_ClothInventory_All._slot[index].icon, false, true, nil, nil, nil, nil, "InventoryBag", fromSlotNo)
    end
  end
end
function PaGlobalFunc_ClothInventory_All_ShowDetailToolTip(fromWhereType, fromSlotNo, index)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local index = PaGlobal_ClothInventory_All._currSlotInfo.index
  local fromSlotNo = PaGlobal_ClothInventory_All._currSlotInfo.fromSlotNo
  local fromWhereType = PaGlobal_ClothInventory_All._currSlotInfo.fromWhereType
  if nil == fromWhereType or nil == fromSlotNo or nil == index then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if true == PaGlobal_ClothInventory_All._isConsole then
    PaGlobalFunc_FloatingTooltip_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  local itemWrapper = getInventoryBagItemByType(fromWhereType, fromSlotNo, index)
  if nil ~= itemWrapper then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0)
  end
end
