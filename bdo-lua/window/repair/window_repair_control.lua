function PaGlobal_Repair:handleMClickedEquippedItemButton()
  PaGlobal_Repair:messageBoxRepairAllEquippedItem()
  PaGlobal_Repair:cursor_PosUpdate()
  self._uiRepairCursor:AddEffect("fUI_Repair01", false, -8, -8)
end
function PaGlobal_Repair:handleMClickedInvenItemButton()
  PaGlobal_Repair:messageBoxRepairAllInvenItem()
  PaGlobal_Repair:cursor_PosUpdate()
  self._uiRepairCursor:AddEffect("fUI_Repair01", false, -8, -8)
end
function PaGlobal_Repair:RepairExit()
  handleMClickedRepairExitButton()
end
function handleMClickedRepairExitButton()
  PaGlobal_Repair:repair_OpenPanel(false, nil)
  if false == _ContentsGroup_NewUI_BlackSmith_All then
    PaGlobal_FixEquip:fixEquipExit()
  elseif nil ~= Panel_Window_Endurance_Recovery_All and true == Panel_Window_Endurance_Recovery_All:GetShow() then
    PaGlobal_Endurance_Recovery_All_Close()
  end
  PaGlobal_Repair:setIsCamping(false)
  if true == _ContentsGroup_NewUI_NpcShop_All then
    if nil ~= Panel_Dialog_NPCShop_All and false == PaGlobalFunc_NPCShop_ALL_GetShow() then
      PaGlobalFunc_NPCShop_ALL_SetIsCamping(false)
    end
  elseif nil ~= Panel_Window_NpcShop and false == Panel_Window_NpcShop:GetShow() then
    npcShop:setIsCamping(false)
  end
  if _ContentsGroup_NewUI_Camp_All then
    PaGlobalFunc_Camp_All_SetIsCamping(false)
  else
    PaGlobal_Camp:setIsCamping(false)
  end
end
function Repair_InvenFilter(slotNo, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  local isAble = itemWrapper:checkToRepairItem()
  return not isAble
end
function Repair_InvenRClick(slotNo, itemWrapper, s64_itemCount, itemWhereType)
  local self = PaGlobal_Repair
  local isAble = itemWrapper:checkToRepairItem()
  if not isAble then
    return
  end
  PaGlobal_Repair:cursor_PosUpdate()
  self._uiRepairCursor:AddEffect("fUI_Repair01", false, -8, -8)
  local isCamping
  if _ContentsGroup_NewUI_Camp_All then
    isCamping = PaGlobalFunc_Camp_All_GetIsCamping()
  else
    isCamping = PaGlobal_Camp:getIsCamping()
  end
  local repairPrice = repair_getRepairPrice_s64(itemWhereType, slotNo, CppEnums.ServantType.Type_Count, isCamping)
  if repairPrice > Defines.s64_const.s64_0 then
    local strPrice = string.format("%d", Int64toInt32(repairPrice))
    local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "REPAIR_MESSAGEBOX_MEMO", "price", makeDotMoney(strPrice))
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "REPAIR_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = Repair_Item_MessageBox_Confirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    self._repairWhereType = itemWhereType
    self._repairSlotNo = slotNo
  end
end
function PaGlobal_Repair:repair_EquipWindowRClick(equipSlotNo, itemWrapper)
  local isAble = itemWrapper:checkToRepairItem()
  if not isAble then
    return
  end
  PaGlobal_Repair:cursor_PosUpdate()
  self._uiRepairCursor:AddEffect("fUI_Repair01", false, -8, -8)
  local isCamping
  if _ContentsGroup_NewUI_Camp_All then
    isCamping = PaGlobalFunc_Camp_All_GetIsCamping()
  else
    isCamping = PaGlobal_Camp:getIsCamping()
  end
  local repairPrice = repair_getRepairPrice_s64(CppEnums.ItemWhereType.eEquip, equipSlotNo, CppEnums.ServantType.Type_Count, isCamping)
  if repairPrice > Defines.s64_const.s64_0 then
    local strPrice = string.format("%d", Int64toInt32(repairPrice))
    local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "REPAIR_MESSAGEBOX_MEMO", "price", makeDotMoney(strPrice))
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "REPAIR_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = Repair_Item_MessageBox_Confirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    self._repairWhereType = CppEnums.ItemWhereType.eEquip
    self._repairSlotNo = equipSlotNo
  end
end
function PaGlobal_Repair:messageBoxRepairAllEquippedItem()
  local isCamping
  if _ContentsGroup_NewUI_Camp_All then
    isCamping = PaGlobalFunc_Camp_All_GetIsCamping()
  else
    isCamping = PaGlobal_Camp:getIsCamping()
  end
  local s64_totalPrice = repair_RepairAllPrice_s64(CppEnums.ItemWhereType.eEquip, true, CppEnums.ServantType.Type_Count, false, isCamping)
  if s64_totalPrice > Defines.s64_const.s64_0 then
    local strPrice = string.format("%d", Int64toInt32(s64_totalPrice))
    local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "REPAIR_EQUIP_MESSAGEBOX_MEMO", "price", makeDotMoney(strPrice))
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = Repair_AllItem_MessageBox_Confirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    local messageboxMemo = PAGetString(Defines.StringSheet_GAME, "REPAIR_NOT_MESSAGEBOX_MEMO")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function PaGlobal_Repair:handleMClickedHorseItemRepairButton()
  local s64_totalPrice = repair_RepairAllPrice_s64(CppEnums.ItemWhereType.eServantEquip, true, CppEnums.ServantType.Type_Vehicle, false, false)
  if s64_totalPrice > Defines.s64_const.s64_0 then
    local strPrice = string.format("%d", Int64toInt32(s64_totalPrice))
    local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "REPAIR_EQUIP_MESSAGEBOX_MEMO", "price", makeDotMoney(strPrice))
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = Repair_AllItem_MessageBox_Confirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    local messageboxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_REPAIR_SERVANT_DISTANCEREPAIR")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function PaGlobal_Repair:handleMClickedShipItemRepairButton()
  local s64_totalPrice = repair_RepairAllPrice_s64(CppEnums.ItemWhereType.eServantEquip, true, CppEnums.ServantType.Type_Ship, false, false)
  if s64_totalPrice > Defines.s64_const.s64_0 then
    local strPrice = string.format("%d", Int64toInt32(s64_totalPrice))
    local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "REPAIR_EQUIP_MESSAGEBOX_MEMO", "price", makeDotMoney(strPrice))
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = Repair_AllItem_MessageBox_Confirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    local messageboxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_REPAIR_SERVANT_DISTANCEREPAIR")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function PaGlobal_Repair:handleMClickedElephantRepairButton()
  local s64_totalPrice = repair_RepairAllPrice_s64(CppEnums.ItemWhereType.eServantEquip, true, CppEnums.ServantType.Type_Vehicle, true, false)
  local GuildMoneyRepairElephant = function()
    repair_AllItem(CppEnums.ItemWhereType.eGuildWarehouse)
  end
  if s64_totalPrice > Defines.s64_const.s64_0 then
    local strPrice = string.format("%d", Int64toInt32(s64_totalPrice))
    local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "REPAIR_EQUIP_MESSAGEBOX_MEMO_ELEPHANT", "price", makeDotMoney(strPrice))
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = GuildMoneyRepairElephant,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    local messageboxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_REPAIR_SERVANT_DISTANCEREPAIR")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function PaGlobal_Repair:messageBoxRepairAllInvenItem()
  local isCamping
  if _ContentsGroup_NewUI_Camp_All then
    isCamping = PaGlobalFunc_Camp_All_GetIsCamping()
  else
    isCamping = PaGlobal_Camp:getIsCamping()
  end
  local inventory_s64 = repair_RepairAllPrice_s64(CppEnums.ItemWhereType.eInventory, true, CppEnums.ServantType.Type_Count, false, isCamping)
  local totalPrices_64 = repair_RepairAllPrice_s64(CppEnums.ItemWhereType.eCashInventory, false, CppEnums.ServantType.Type_Count, false, isCamping)
  if totalPrices_64 > Defines.s64_const.s64_0 then
    local strPrice = string.format("%d", Int64toInt32(totalPrices_64))
    local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "REPAIR_INVENTORY_MESSAGEBOX_MEMO", "price", makeDotMoney(strPrice))
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = Repair_AllItem_MessageBox_Confirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    local messageboxMemo = PAGetString(Defines.StringSheet_GAME, "REPAIR_NOT_MESSAGEBOX_MEMO")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function Repair_AllItem_MessageBox_Confirm()
  local isCamping
  if _ContentsGroup_NewUI_Camp_All then
    isCamping = PaGlobalFunc_Camp_All_GetIsCamping()
  else
    isCamping = PaGlobal_Camp:getIsCamping()
  end
  local self = PaGlobal_Repair
  local invenMoney = self._uiRepairInvenMoney:IsCheck()
  local wareHouseMoney = self._uiRepairWareHouseMoney:IsCheck()
  local moneyWhereType = CppEnums.ItemWhereType.eInventory
  if invenMoney then
    moneyWhereType = CppEnums.ItemWhereType.eInventory
  else
    moneyWhereType = CppEnums.ItemWhereType.eWarehouse
  end
  if isCamping then
    repair_AllItemByCamping()
  else
    repair_AllItem(moneyWhereType)
  end
end
function Repair_Item_MessageBox_Confirm()
  local isCamping
  if _ContentsGroup_NewUI_Camp_All then
    isCamping = PaGlobalFunc_Camp_All_GetIsCamping()
  else
    isCamping = PaGlobal_Camp:getIsCamping()
  end
  local self = PaGlobal_Repair
  local invenMoney = self._uiRepairInvenMoney:IsCheck()
  local wareHouseMoney = self._uiRepairWareHouseMoney:IsCheck()
  local moneyWhereType = CppEnums.ItemWhereType.eInventory
  if invenMoney then
    moneyWhereType = CppEnums.ItemWhereType.eInventory
  else
    moneyWhereType = CppEnums.ItemWhereType.eWarehouse
  end
  if isCamping then
    repair_ItemByCamping(self._repairWhereType, self._repairSlotNo, CppEnums.ServantType.Type_Count)
  else
    repair_Item(self._repairWhereType, self._repairSlotNo, moneyWhereType, CppEnums.ServantType.Type_Count)
  end
end
