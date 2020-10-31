function HandleEventScroll_CargoLoading_WarehouseScroll(isUp)
  local slotCols = PaGlobal_CargoLoading:getSlotCols(PaGlobal_CargoLoading._eSlotType.inventory)
  local useStartSlot = PaGlobal_CargoLoading._startSlot_warehouse
  local maxSize = PaGlobal_CargoLoading._maxCount_warehouse - useStartSlot
  local remain = maxSize % slotCols
  if 0 < remain then
    maxSize = maxSize + (slotCols - remain)
  end
  PaGlobal_CargoLoading._startSlotIndex_warehouse = UIScroll.ScrollEvent(PaGlobal_CargoLoading._ui._scroll_warehouse, isUp, PaGlobal_CargoLoading._config.slotRows_w, maxSize, PaGlobal_CargoLoading._startSlotIndex_warehouse, slotCols)
  PaGlobal_CargoLoading:updateMyInventorySlot()
end
function HandleEventScroll_CargoLoading_ServantScroll(isUp)
  local slotCols = PaGlobal_CargoLoading:getSlotCols(PaGlobal_CargoLoading._eSlotType.servant)
  local useStartSlot = PaGlobal_CargoLoading._startSlot_ship
  local maxSize = PaGlobal_CargoLoading._maxCount_ship - useStartSlot
  local remain = maxSize % slotCols
  if 0 < remain then
    maxSize = maxSize + (slotCols - remain)
  end
  PaGlobal_CargoLoading._startSlotIndex_ship = UIScroll.ScrollEvent(PaGlobal_CargoLoading._ui._scroll_ship, isUp, PaGlobal_CargoLoading._config.slotRows_s, maxSize, PaGlobal_CargoLoading._startSlotIndex_ship, slotCols)
  PaGlobal_CargoLoading:updateServantSlot()
end
function HandleEventMOn_CargoLoading_IconOver(type, index)
  local slot = PaGlobal_CargoLoading._slots[type][index]
  if nil == slot or nil == slot.slotNo then
    return
  end
  if PaGlobal_CargoLoading._eSlotType.inventory == type then
    if PaGlobal_CargoLoading._eMySlot.myInven == PaGlobal_CargoLoading._currentMySlotType then
      local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slot.slotNo)
      if nil == itemWrapper then
        return
      end
    elseif PaGlobal_CargoLoading._eMySlot.myWarehouse == PaGlobal_CargoLoading._currentMySlotType then
      local warehouseWrapper = PaGlobal_CargoLoading:getWarehouse()
      if nil == warehouseWrapper then
        return
      end
      local itemWrapper = warehouseWrapper:getItem(slot.slotNo)
      if nil == itemWrapper then
        return
      end
    end
    Panel_Tooltip_Item_Show_GeneralNormal(index, "CargoLoadingWarehouse", true)
  elseif PaGlobal_CargoLoading._eSlotType.servant == type then
    local itemWrapper = getServantInventoryItemBySlotNo(PaGlobal_CargoLoading._servantActorKey, slot.slotNo)
    if nil == itemWrapper then
      return
    end
    Panel_Tooltip_Item_Show_GeneralNormal(index, "CargoLoadingServant", true)
  end
  if PaGlobal_CargoLoading._slotNilEffect[index] then
    slot.icon:EraseEffect(PaGlobal_CargoLoading._slotNilEffect[index])
  end
  PaGlobal_CargoLoading._slotNilEffect[index] = slot.icon:AddEffect("UI_Inventory_EmptySlot", false, -1.5, -1.5)
end
function HandleEventMOut_CargoLoading_IconOut(type, index)
  if PaGlobal_CargoLoading._eSlotType.inventory == type then
    Panel_Tooltip_Item_Show_GeneralNormal(index, "CargoLoadingWarehouse", false)
  elseif PaGlobal_CargoLoading._eSlotType.servant == type then
    Panel_Tooltip_Item_Show_GeneralNormal(index, "CargoLoadingServant", false)
  end
end
function HandleEventMLUp_CargoLoading_Close()
  PaGlobal_CargoLoading:prepareClose()
end
function HandleEventMLUp_CargoLoading_CheckSort()
  local isSorted = PaGlobal_CargoLoading._ui._chk_sortButton:IsCheck()
  ToClient_SetSortedWarehouse(isSorted)
  ToClient_SetSortedInventory(isSorted)
  PaGlobal_CargoLoading:updateMyInventorySlot()
end
function HandleEventMLUp_CargoLoading_UpdateMySlot(_eMySlot)
  PaGlobal_CargoLoading._currentMySlotType = _eMySlot
  PaGlobal_CargoLoading:initSlotInfo_warehouse()
  PaGlobal_CargoLoading:initSlotInfo_ship()
  PaGlobal_CargoLoading:updateMyInventorySlot()
  PaGlobal_CargoLoading:repositionSelectLine()
end
function HandleEventMRUp_CargoLoading_SlotRClick(eSlotType, slotIndex)
  local actorKeyRaw = PaGlobal_CargoLoading._servantActorKey
  local vehicleActor = getVehicleActor(actorKeyRaw)
  if nil == vehicleActor then
    return
  end
  PaGlobal_CargoLoading._clickedSlotType = eSlotType
  local slots = PaGlobal_CargoLoading._slots[eSlotType]
  if nil == slots[slotIndex].slotNo then
    return
  end
  Panel_NumberPad_Close()
  FGlobal_PopupMoveItem_Init(CppEnums.ItemWhereType.eServantInventory, slots[slotIndex].slotNo, CppEnums.MoveItemToType.Type_ShipWarehouse, actorKeyRaw, true)
  Panel_Tooltip_Item_hideTooltip()
  local itemWrapper = PaGlobal_CargoLoading_GetMoveItem(slots[slotIndex].slotNo)
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
end
function FromClient_CargoLoading_UpdateMyInventorySlot()
  if false == Panel_Window_CargoLoading_ALL:GetShow() then
    return
  end
  PaGlobal_CargoLoading:updateMyInventorySlot()
end
function FromClient_CargoLoading_UpdateServantinven()
  PaGlobal_CargoLoading:updateServantSlot()
end
function FromClient_CargoLoading_Resize()
  PaGlobal_CargoLoading:resize()
end
function PaGlobal_CargoLoading_GetMoveItem(slotNo)
  if nil == slotNo then
    return nil
  end
  local itemWrapper
  if PaGlobal_CargoLoading._eSlotType.inventory == PaGlobal_CargoLoading._clickedSlotType then
    if PaGlobal_CargoLoading._eMySlot.myInven == PaGlobal_CargoLoading._currentMySlotType then
      return getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
    elseif PaGlobal_CargoLoading._eMySlot.myWarehouse == PaGlobal_CargoLoading._currentMySlotType then
      local warehouseWrapper = PaGlobal_CargoLoading:getWarehouse()
      if nil == warehouseWrapper then
        return nil
      end
      return warehouseWrapper:getItem(slotNo)
    end
  elseif PaGlobal_CargoLoading._eSlotType.servant == PaGlobal_CargoLoading._clickedSlotType then
    return getServantInventoryItemBySlotNo(PaGlobal_CargoLoading._servantActorKey, slotNo)
  end
end
function PaGlobal_CargoLoading_PopToSomewhere(s64_count, slotNo)
  if s64_count > toInt64(0, 1) then
    Panel_NumberPad_Show(true, s64_count, slotNo, PaGlobal_CargoLoading_requestPopToInventory)
  else
    PaGlobal_CargoLoading_requestPopToInventory(s64_count, slotNo)
  end
end
function HandleEventMLUp_CargoLoading_ToggleBarterInfo()
  if true == Panel_Window_Barter_Search:IsShow() then
    PaGlobal_BarterInfoSearch:close()
  else
    PaGlobal_BarterInfoSearch:open()
  end
end
function HandleEventMOn_CargoLoading_SimpleTooltip()
  local self = PaGlobal_CargoLoading
  TooltipSimple_Show(self._ui._btn_barterInfo, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTERINFO_TITLE"), "")
end
function HandleEventMOut_CargoLoading_SimpleTooltip()
  TooltipSimple_Hide()
end
