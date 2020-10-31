function PaGlobal_RepairFunc_All_MoveTab(value)
  if nil == Panel_Dialog_Repair_Function_All then
    return
  end
  PaGlobal_Endurance_Recovery_All_Close()
  PaGlobal_RepairFunc_All._currentTabIndex = PaGlobal_RepairFunc_All._currentTabIndex + value
  if PaGlobal_RepairFunc_All._funcButtonCount < PaGlobal_RepairFunc_All._currentTabIndex then
    PaGlobal_RepairFunc_All._currentTabIndex = 1
  elseif PaGlobal_RepairFunc_All._currentTabIndex < 1 then
    PaGlobal_RepairFunc_All._currentTabIndex = PaGlobal_RepairFunc_All._funcButtonCount
  end
  for idx = 1, PaGlobal_RepairFunc_All._funcButtonCount do
    if true == PaGlobal_RepairFunc_All._btnTable[idx - 1]:GetShow() then
      PaGlobal_RepairFunc_All._btnTable[idx - 1]:SetCheck(false)
    end
  end
  PaGlobal_RepairFunc_All._btnTable[PaGlobal_RepairFunc_All._currentTabIndex - 1]:SetCheck(true)
  local posX = PaGlobal_RepairFunc_All._btnTable[PaGlobal_RepairFunc_All._currentTabIndex - 1]:GetPosX() + PaGlobal_RepairFunc_All._btnTable[PaGlobal_RepairFunc_All._currentTabIndex - 1]:GetSizeX() * 0.5 - PaGlobal_RepairFunc_All._ui_console.stc_iconA:GetSizeX() * 0.5
  PaGlobal_RepairFunc_All._ui_console.stc_iconA:SetPosX(posX)
  posX = PaGlobal_RepairFunc_All._btnTable[PaGlobal_RepairFunc_All._currentTabIndex - 1]:GetPosX() + PaGlobal_RepairFunc_All._btnTable[PaGlobal_RepairFunc_All._currentTabIndex - 1]:GetSizeX() * 0.5 - PaGlobal_RepairFunc_All._ui.stc_selectLine:GetSizeX() * 0.5
  PaGlobal_RepairFunc_All._ui.stc_selectLine:SetShow(true)
  PaGlobal_RepairFunc_All._ui.stc_selectLine:SetPosX(posX)
end
function PaGlobal_RepairFunc_All_SelectCurrentTab()
  if nil == Panel_Dialog_Repair_Function_All then
    return
  end
  PaGlobal_RepairFunc_All._funcTable[PaGlobal_RepairFunc_All._currentTabIndex - 1]()
end
function PaGlobalFunc_RepairFunc_All_Open(eType)
  PaGlobal_RepairFunc_All:prepareOpen(eType)
end
function PaGlobalFunc_RepairFunc_All_Close()
  PaGlobal_RepairFunc_All:prepareClose()
end
function HandleEventLUp_RepairFunc_All_Guild()
  local s64_totalPrice = repair_RepairAllPrice_s64(CppEnums.ItemWhereType.eServantEquip, true, CppEnums.ServantType.Type_Vehicle, true, false)
  local GuildMoneyRepairElephant = function()
    repair_AllItem(CppEnums.ItemWhereType.eGuildWarehouse)
  end
  PaGlobalFunc_RepairFunc_All_SelectBarPos(PaGlobal_RepairFunc_All._BTN_ENUM.GUILD)
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
function HandleEventLUp_RepairFunc_All_Ship()
  local s64_totalPrice = repair_RepairAllPrice_s64(CppEnums.ItemWhereType.eServantEquip, true, CppEnums.ServantType.Type_Ship, false, false)
  PaGlobalFunc_RepairFunc_All_SelectBarPos(PaGlobal_RepairFunc_All._BTN_ENUM.SHIP)
  if s64_totalPrice > Defines.s64_const.s64_0 then
    local strPrice = string.format("%d", Int64toInt32(s64_totalPrice))
    local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "REPAIR_EQUIP_MESSAGEBOX_MEMO", "price", makeDotMoney(strPrice))
    if false == PaGlobal_RepairFunc_All._isConsole then
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
        content = messageboxMemo,
        functionYes = PaGlobalFunc_RepairFunc_All_MessageBoxConfirm_AllItem,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
        content = messageboxMemo,
        functionApply = PaGlobalFunc_RepairFunc_All_MessageBoxConfirm_AllItem_Console,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBoxCheck.showMessageBox(messageboxData)
    end
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
function HandleEventLUp_RepairFunc_All_Horse()
  local s64_totalPrice = repair_RepairAllPrice_s64(CppEnums.ItemWhereType.eServantEquip, true, CppEnums.ServantType.Type_Vehicle, false, false)
  PaGlobalFunc_RepairFunc_All_SelectBarPos(PaGlobal_RepairFunc_All._BTN_ENUM.HORSE)
  if s64_totalPrice > Defines.s64_const.s64_0 then
    local strPrice = string.format("%d", Int64toInt32(s64_totalPrice))
    local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "REPAIR_EQUIP_MESSAGEBOX_MEMO", "price", makeDotMoney(strPrice))
    if false == PaGlobal_RepairFunc_All._isConsole then
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
        content = messageboxMemo,
        functionYes = PaGlobalFunc_RepairFunc_All_MessageBoxConfirm_AllItem,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
        content = messageboxMemo,
        functionApply = PaGlobalFunc_RepairFunc_All_MessageBoxConfirm_AllItem_Console,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBoxCheck.showMessageBox(messageboxData)
    end
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
function HandleEventLUp_RepairFunc_All_MaxEndurance()
  PaGlobalFunc_RepairFunc_All_SelectBarPos(PaGlobal_RepairFunc_All._BTN_ENUM.MAXENDURANCE)
  if true == _ContentsGroup_NewUI_BlackSmith_All then
    PaGlobal_Endurance_Recovery_All_Open()
  else
    PaGlobal_FixEquip:handleMClickedFixEquipItemButton()
  end
end
function HandleEventLUp_RepairFunc_All_Equipment()
  local isCamping = PaGlobal_RepairFunc_All._isCamping
  local s64_totalPrice = repair_RepairAllPrice_s64(CppEnums.ItemWhereType.eEquip, true, CppEnums.ServantType.Type_Count, false, isCamping)
  PaGlobalFunc_RepairFunc_All_SelectBarPos(PaGlobal_RepairFunc_All._BTN_ENUM.EQUIPMENT)
  if s64_totalPrice > Defines.s64_const.s64_0 then
    local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "REPAIR_EQUIP_MESSAGEBOX_MEMO", "price", makeDotMoney(s64_totalPrice))
    if false == PaGlobal_RepairFunc_All._isConsole then
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
        content = messageboxMemo,
        functionYes = PaGlobalFunc_RepairFunc_All_MessageBoxConfirm_AllItem,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
        content = messageboxMemo,
        functionApply = PaGlobalFunc_RepairFunc_All_MessageBoxConfirm_AllItem_Console,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBoxCheck.showMessageBox(messageboxData)
    end
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
function HandleEventLUp_RepairFunc_All_Inventory()
  local isCamping = PaGlobal_RepairFunc_All._isCamping
  local inventory_s64 = repair_RepairAllPrice_s64(CppEnums.ItemWhereType.eInventory, true, CppEnums.ServantType.Type_Count, false, isCamping)
  local totalPrices_64 = repair_RepairAllPrice_s64(CppEnums.ItemWhereType.eCashInventory, false, CppEnums.ServantType.Type_Count, false, isCamping)
  PaGlobalFunc_RepairFunc_All_SelectBarPos(PaGlobal_RepairFunc_All._BTN_ENUM.INVENTORY)
  if totalPrices_64 > Defines.s64_const.s64_0 then
    local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "REPAIR_INVENTORY_MESSAGEBOX_MEMO", "price", makeDotMoney(totalPrices_64))
    if false == PaGlobal_RepairFunc_All._isConsole then
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
        content = messageboxMemo,
        functionYes = PaGlobalFunc_RepairFunc_All_MessageBoxConfirm_AllItem,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "REPAIR_ALL_MESSAGEBOX_TITLE"),
        content = messageboxMemo,
        functionApply = PaGlobalFunc_RepairFunc_All_MessageBoxConfirm_AllItem_Console,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBoxCheck.showMessageBox(messageboxData)
    end
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
function HandleEventLUp_RepairFunc_All_InventoryOpen()
  Inventory_SetFunctor(PaGlobalFunc_RepairFunc_All_InvenFilter, PaGlobalFunc_RepairFunc_All_InvenRClick, nil, nil)
  InventoryWindow_Show(true)
end
function FromClient_RepairFunc_All_OnScreenEvent()
  if nil == Panel_Dialog_Repair_Function_All then
    return
  end
  PaGlobal_RepairFunc_All:resize()
end
function FromClient_RepairFunc_All_MaxEnduranceLuckyRepairEvent()
  if nil ~= Panel_LuckyRepair_Result and false == Panel_LuckyRepair_Result:GetShow() then
    PaGlobal_RepairFunc_All._luckyRepairMSG.MSG:SetText(PAGetString(Defines.StringSheet_GAME, "REPAIR_LUCKY_TEXT"))
    Panel_LuckyRepair_Result:RegisterUpdateFunc("RegisterUpdateFunc_RepairFunc_All_ShowTime")
    Panel_LuckyRepair_Result:SetShow(true)
    PaGlobal_RepairFunc_All._resultMsg_ShowTime = 0
  end
end
function RegisterUpdateFunc_RepairFunc_All_ShowTime(deltaTime)
  if nil == Panel_LuckyRepair_Result then
    return
  end
  PaGlobal_RepairFunc_All._resultMsg_ShowTime = PaGlobal_RepairFunc_All._resultMsg_ShowTime + deltaTime
  if PaGlobal_RepairFunc_All._resultMsg_ShowTime > 3 and true == Panel_LuckyRepair_Result:GetShow() then
    Panel_LuckyRepair_Result:ClearUpdateLuaFunc()
    Panel_LuckyRepair_Result:SetShow(false)
    PaGlobal_RepairFunc_All._resultMsg_ShowTime = 0
  end
end
function PaGlobalFunc_RepairFunc_All_MoneyUpdate()
  if false == PaGlobal_RepairFunc_All._initialize then
    return
  end
  if true == _ContentsGroup_RenewUI_InventoryEquip then
    return
  end
  PaGlobal_RepairFunc_All._otherPanel._uiRepairInven:SetText(makeDotMoney(getSelfPlayer():get():getInventory():getMoney_s64()))
  PaGlobal_RepairFunc_All._otherPanel._uiRepairWareHouse:SetText(makeDotMoney(warehouse_moneyFromNpcShop_s64()))
end
function PaGlobalFunc_RepairFunc_All_MoneySetPos()
  if false == PaGlobal_RepairFunc_All._initialize then
    return
  end
  if true == _ContentsGroup_RenewUI_InventoryEquip then
    return
  end
  PaGlobal_RepairFunc_All._otherPanel._uiRepairInven:SetSpanSize(PaGlobal_RepairFunc_All._uiRepairValueDefaultSpanX, PaGlobal_RepairFunc_All._otherPanel._uiRepairInven:GetSpanSize().y)
  PaGlobal_RepairFunc_All._otherPanel._uiRepairWareHouse:SetSpanSize(PaGlobal_RepairFunc_All._uiRepairValueDefaultSpanX, PaGlobal_RepairFunc_All._otherPanel._uiRepairWareHouse:GetSpanSize().y)
  local titleEndPosX = PaGlobal_RepairFunc_All._otherPanel._uiRepairInvenMoney:GetPosX() + PaGlobal_RepairFunc_All._otherPanel._uiRepairInvenMoney:GetSizeX() + PaGlobal_RepairFunc_All._uiRepairTextSizeX
  local gap = 10
  if titleEndPosX + gap > PaGlobal_RepairFunc_All._otherPanel._uiRepairInven:GetPosX() then
    local diff = titleEndPosX + gap - PaGlobal_RepairFunc_All._otherPanel._uiRepairInven:GetPosX()
    PaGlobal_RepairFunc_All._otherPanel._uiRepairInven:SetSpanSize(PaGlobal_RepairFunc_All._uiRepairValueDefaultSpanX + diff, PaGlobal_RepairFunc_All._otherPanel._uiRepairInven:GetSpanSize().y)
    PaGlobal_RepairFunc_All._otherPanel._uiRepairWareHouse:SetSpanSize(PaGlobal_RepairFunc_All._uiRepairValueDefaultSpanX + diff, PaGlobal_RepairFunc_All._otherPanel._uiRepairWareHouse:GetSpanSize().y)
  end
end
function PaGlobalFunc_RepairFunc_All_SelectBarPos(btnEnum)
  if false == PaGlobal_RepairFunc_All._initialize then
    return
  end
  if false == PaGlobal_RepairFunc_All._isConsole then
    local posX = PaGlobal_RepairFunc_All._ui.radio_btn[btnEnum]:GetPosX() + PaGlobal_RepairFunc_All._ui.radio_btn[btnEnum]:GetSizeX() / 2 - PaGlobal_RepairFunc_All._ui.stc_selectLine:GetSizeX() / 2
    PaGlobal_RepairFunc_All._ui.stc_selectLine:SetShow(true)
    PaGlobal_RepairFunc_All._ui.stc_selectLine:SetPosX(posX)
  end
end
function PaGlobalFunc_RepairFunc_All_SetIsCamping(isCamping)
  PaGlobal_RepairFunc_All._isCamping = isCamping
end
function PaGlobalFunc_RepairFunc_All_InvenFilter(sloNo, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  local isAble = itemWrapper:checkToRepairItem()
  return not isAble
end
function PaGlobalFunc_RepairFunc_All_InvenRClick(slotNo, itemWrapper, s64_itemCount, itemWhereType)
  local isAble = itemWrapper:checkToRepairItem()
  if not isAble then
    return
  end
  PaGlobalFunc_RepairFunc_All_CursorPosUpdate()
  PaGlobal_RepairFunc_All._ui.stc_cursor:EraseAllEffect()
  PaGlobal_RepairFunc_All._ui.stc_cursor:AddEffect("fUI_Repair01", false, -8, -8)
  local isCamping = PaGlobal_RepairFunc_All._isCamping
  local repairPrice = repair_getRepairPrice_s64(itemWhereType, slotNo, CppEnums.ServantType.Type_Count, isCamping)
  if repairPrice > Defines.s64_const.s64_0 then
    local strPrice = string.format("%d", Int64toInt32(repairPrice))
    local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "REPAIR_MESSAGEBOX_MEMO", "price", makeDotMoney(strPrice))
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "REPAIR_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = PaGlobalFunc_RepairFunc_All_MessageBoxConform_Item,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    if false == _ContentsGroup_RenewUI_InventoryEquip then
      MessageBox.showMessageBox(messageboxData)
    else
      MessageBoxCheck.showMessageBox(messageboxData)
    end
    PaGlobal_RepairFunc_All._repairWhereType = itemWhereType
    PaGlobal_RepairFunc_All._repairSlotNo = slotNo
  end
end
function PaGlobalFunc_RepairFunc_All_EquipWindowRClick(equipSlotNo, itemWrapper)
  local isAble = itemWrapper:checkToRepairItem()
  if not isAble then
    return
  end
  PaGlobalFunc_RepairFunc_All_CursorPosUpdate()
  PaGlobal_RepairFunc_All._ui.stc_cursor:EraseAllEffect()
  PaGlobal_RepairFunc_All._ui.stc_cursor:AddEffect("fUI_Repair01", false, -8, -8)
  local isCamping = PaGlobal_RepairFunc_All._isCamping
  local repairPrice = repair_getRepairPrice_s64(CppEnums.ItemWhereType.eEquip, equipSlotNo, CppEnums.ServantType.Type_Count, isCamping)
  if repairPrice > Defines.s64_const.s64_0 then
    local strPrice = string.format("%d", Int64toInt32(repairPrice))
    local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "REPAIR_MESSAGEBOX_MEMO", "price", makeDotMoney(strPrice))
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "REPAIR_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = PaGlobalFunc_RepairFunc_All_MessageBoxConform_Item,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    if false == _ContentsGroup_RenewUI_InventoryEquip then
      MessageBox.showMessageBox(messageboxData)
    else
      MessageBoxCheck.showMessageBox(messageboxData)
    end
    PaGlobal_RepairFunc_All._repairWhereType = CppEnums.ItemWhereType.eEquip
    PaGlobal_RepairFunc_All._repairSlotNo = equipSlotNo
  end
end
function PaGlobalFunc_RepairFunc_All_CursorPosUpdate()
  PaGlobal_RepairFunc_All._ui.stc_cursor:SetPosX(getMousePosX() - Panel_Dialog_Repair_Function_All:GetPosX())
  PaGlobal_RepairFunc_All._ui.stc_cursor:SetPosY(getMousePosY() - Panel_Dialog_Repair_Function_All:GetPosY())
end
function PaGlobalFunc_RepairFunc_All_MessageBoxConfirm_AllItem()
  local invenMoney = PaGlobal_RepairFunc_All._otherPanel._uiRepairInvenMoney:IsCheck()
  local wareHouseMoney = PaGlobal_RepairFunc_All._otherPanel._uiRepairWareHouseMoney:IsCheck()
  local moneyWhereType = CppEnums.ItemWhereType.eInventory
  if invenMoney then
    moneyWhereType = CppEnums.ItemWhereType.eInventory
  else
    moneyWhereType = CppEnums.ItemWhereType.eWarehouse
  end
  if true == PaGlobal_RepairFunc_All._isCamping then
    repair_AllItemByCamping()
  else
    repair_AllItem(moneyWhereType)
  end
end
function PaGlobalFunc_RepairFunc_All_MessageBoxConfirm_AllItem_Console()
  local moneyWhereType = MessageBoxCheck.isCheck()
  if PaGlobal_RepairFunc_All._isCamping then
    repair_AllItemByCamping()
  else
    repair_AllItem(moneyWhereType)
  end
end
function PaGlobalFunc_RepairFunc_All_MessageBoxConform_Item()
  local isCamping = PaGlobal_RepairFunc_All._isCamping
  local moneyItemWrapper
  local moneyWhereType = CppEnums.ItemWhereType.eInventory
  local money = 0
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == PaGlobal_RepairFunc_All._otherPanel._uiRepairInvenMoney:IsCheck() then
      moneyWhereType = CppEnums.ItemWhereType.eInventory
    else
      moneyWhereType = CppEnums.ItemWhereType.eWarehouse
    end
  else
    moneyWhereType = MessageBoxCheck.isCheck()
  end
  if CppEnums.ItemWhereType.eInventory == moneyWhereType then
    moneyItemWrapper = getInventoryItemByType(moneyWhereType, getMoneySlotNo())
    if nil == moneyItemWrapper then
      PaGlobal_RepairFunc_All:not_Enough_Money()
      return
    end
    money = moneyItemWrapper:get():getCount_s64()
  else
    money = warehouse_moneyFromNpcShop_s64()
  end
  local repairPrice = repair_getRepairPrice_s64(PaGlobal_RepairFunc_All._repairWhereType, PaGlobal_RepairFunc_All._repairSlotNo, CppEnums.ServantType.Type_Count, isCamping)
  if money < repairPrice then
    PaGlobal_RepairFunc_All:not_Enough_Money()
    return
  end
  if true == isCamping then
    repair_ItemByCamping(PaGlobal_RepairFunc_All._repairWhereType, PaGlobal_RepairFunc_All._repairSlotNo, CppEnums.ServantType.Type_Count)
  else
    repair_Item(PaGlobal_RepairFunc_All._repairWhereType, PaGlobal_RepairFunc_All._repairSlotNo, moneyWhereType, CppEnums.ServantType.Type_Count)
  end
end
function PaGlobalFunc_RepairFunc_All_IsCampingType()
  if nil == Panel_Dialog_Repair_Function_All or false == Panel_Dialog_Repair_Function_All:GetShow() then
    return false
  end
  return PaGlobal_RepairFunc_All._isCamping
end
