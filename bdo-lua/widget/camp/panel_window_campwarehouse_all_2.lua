function PaGlobalFunc_CampWarehouse_All_Open(actorKeyRaw)
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    if nil ~= Panel_Window_ServantInventory and Panel_Window_ServantInventory:GetShow() then
      ServantInventory_Close()
    end
    if nil ~= PaGlobal_VehicleInfo_All_GetPanelShow and PaGlobal_VehicleInfo_All_GetPanelShow() then
      HandleEventLUp_VehicleInfo_All_Close()
    end
    if nil ~= Panel_Window_Warehouse and Panel_Window_Warehouse:GetShow() then
      FromClient_Warehouse_All_Close()
    end
    if nil ~= Panel_Window_ServantInventory and Panel_Window_ServantInventory:GetShow() then
      ServantInventory_Close()
    end
  end
  PaGlobal_CampWarehouse_All:prepareOpen(actorKeyRaw)
end
function PaGlobalFunc_CampWarehouse_All_Close()
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  PaGlobal_CampWarehouse_All:prepareClose()
  if nil ~= Panel_Window_Inventory and Panel_Window_Inventory:GetShow() then
    if false == _ContentsGroup_UsePadSnapping then
      HandleClicked_InventoryWindow_Close()
    else
      PaGlobalFunc_InventoryInfo_Close()
      PaGlobalFunc_FloatingTooltip_Close()
    end
  elseif nil ~= Panel_Window_Inventory_All and Panel_Window_Inventory_All:GetShow() and false == _ContentsGroup_UsePadSnapping then
    PaGlobalFunc_Inventory_All_Close()
  end
end
function PaGlobalFunc_CampWarehouse_All_CloseWareHouseOnly()
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  PaGlobal_CampWarehouse_All:prepareClose()
end
function HandleEventLUp_CampWarehouse_All_Close()
  PaGlobalFunc_CampWarehouse_All_Close()
  ToClient_openCampingInfo()
end
function PaGlobalFunc_CampWarehouse_All_GetShow()
  if nil == Panel_Window_CampWarehouse_All then
    return false
  end
  return Panel_Window_CampWarehouse_All:GetShow()
end
function PaGlobalFunc_CampWarehouse_All_GetActorKeyRaw()
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  return PaGlobal_CampWarehouse_All._vehicleActorKeyRaw
end
function PaGlobalFunc_CampWarehouse_All_RemoveCampItem(count64, slotNo)
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  local vehicleActor = getVehicleActor(PaGlobal_CampWarehouse_All._vehicleActorKeyRaw)
  if nil == vehicleActor then
    return
  end
  local itemWrapper = getServantInventoryItemBySlotNo(PaGlobal_CampWarehouse_All._vehicleActorKeyRaw, slotNo)
  if nil ~= itemWrapper then
  end
end
function PaGlobalFunc_CampWarehouse_All_RemoveCampItemPopUp(index)
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  if _ContentsGroup_UsePadSnapping then
    InputMRUp_InventoryInfo_ServantInvenSlot(index)
    PaGlobalFunc_FloatingTooltip_Close()
  else
    local slotNo = PaGlobal_CampWarehouse_All._campInvenIndexList[index]
    local actorKeyRaw = PaGlobal_CampWarehouse_All._vehicleActorKeyRaw
    local inventoryType = CppEnums.ItemWhereType.eServantInventory
    local itemWrapper = getServantInventoryItemBySlotNo(actorKeyRaw, index + 1)
    if nil == itemWrapper then
      return
    end
    FGlobal_PopupMoveItem_Init(inventoryType, index + 1, CppEnums.MoveItemToType.Type_Vehicle, actorKeyRaw, true)
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
end
function PaGlobalFunc_CampWarehouse_All_PushFromInventoryItem(s64_count, whereType, slotNo, fromActorKeyRaw)
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  PaGlobal_CampWarehouse_All._targetActorKeyRaw = fromActorKeyRaw
  Panel_NumberPad_Show_MaxCount(true, s64_count, slotNo, PaGlobalFunc_CampWarehouse_All_PushFromInventoryItemXXX, nil, whereType)
end
function PaGlobalFunc_CampWarehouse_All_PushFromInventoryItemXXX(s64_count, slotNo, whereType)
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  local vehicleActor = getVehicleActor(PaGlobal_CampWarehouse_All._vehicleActorKeyRaw)
  if nil == vehicleActor then
    return
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eServantInventory, slotNo)
  local moveToType = CppEnums.MoveItemToType.Type_CampingTent
  if nil ~= itemWrapper then
    moveInventoryItemFromActorToActor(PaGlobal_CampWarehouse_All._playerActorKeyRaw, PaGlobal_CampWarehouse_All._vehicleActorKeyRaw, whereType, slotNo, count64)
  end
end
function PaGlobalFunc_CampWarehouse_All_ShowFloatingTooltip(index, isShow)
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  local itemWrapper = getServantInventoryItemBySlotNo(PaGlobal_CampWarehouse_All._vehicleActorKeyRaw, index + 1)
  if nil == itemWrapper then
    return
  end
  if _ContentsGroup_RenewUI_Tooltip then
    if false == isShow then
      PaGlobalFunc_FloatingTooltip_Close()
      return
    end
    PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, PaGlobal_CampWarehouse_All._ui.stc_campSlotBGList[index])
  else
    Panel_Tooltip_Item_SetPosition(index + 1, PaGlobal_CampWarehouse_All._ui.slot_campSlotList[index], "servant_inventory")
    if false == isShow then
      Panel_Tooltip_Item_Show_GeneralNormal(index + 1, "servant_inventory", false, 0)
      return
    end
    Panel_Tooltip_Item_Show_GeneralNormal(index + 1, "servant_inventory", true, 0)
  end
end
function PaGlobalFunc_CampWarehouse_All_ShowDetailTooltip(index)
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  if nil ~= Panel_Widget_Tooltip_Renew and PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  PaGlobal_CampWarehouse_All:showDetailTooltip(index)
end
function FromClient_CampWarehouse_All_UpdateCampInven()
  if nil == Panel_Window_CampWarehouse_All then
    return
  end
  PaGlobal_CampWarehouse_All:updateCampInven()
end
