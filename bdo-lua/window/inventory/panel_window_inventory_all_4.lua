function HandleEventLUp_Inventory_All_CheckPopUpUI()
  if PaGlobal_Inventory_All._ui.check_popup:IsCheck() then
    Panel_Window_Inventory_All:OpenUISubApp()
  else
    Panel_Window_Inventory_All:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function HandleEventOnOut_Inventory_All_PopupUITooltip(isShow)
  if true == isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    local desc = ""
    if PaGlobal_Inventory_All._ui.check_popup:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
    TooltipSimple_Show(PaGlobal_Inventory_All._ui.check_popup, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventLUp_Inventory_All_SelectTab()
  if false == _ContentsGroup_NewUI_BlackSmith_All then
    PaGlobal_FixEquip:StreamRecoveryStop()
  else
    PaGlobal_Endurance_Recovery_All_StreamRecoveryStop()
  end
  if DragManager:isDragging() then
    DragManager:clearInfo()
  end
  if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
    if PaGlobalFunc_ClothInventory_All_GetShow() then
      PaGlobalFunc_ClothInventory_All_Close()
    end
  elseif Panel_Window_ClothInventory:GetShow() then
    ClothInventory_Close()
  end
  PaGlobal_Inventory_All._startSlotIndex = 0
  PaGlobal_Inventory_All:selectTabSound()
  Inventory_updateSlotData(true)
  PaGlobal_Inventory_All._ui.scroll_inven:SetControlTop()
  PaGlobal_Inventory_All:changeMileageIcon()
end
function HandleEventLUp_Inventory_All_SetSorted()
  local bSorted = PaGlobal_Inventory_All._ui.check_itemSort:IsCheck()
  PaGlobal_Inventory_All:hidePuzzleControl()
  ToClient_SetSortedInventory(bSorted)
  Inventory_updateSlotData(true)
end
function HandleEventOnOut_Inventory_All_CapacityTooltip(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BUYSLOT_TOOLTIP_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BUYSLOT_TOOLTIP_DESC")
  TooltipSimple_Show(PaGlobal_Inventory_All._ui.txt_capacity, name, desc)
end
function HandleEventScroll_Inventory_All_UpdateScroll(isUp)
  local useStartSlot = inventorySlotNoUserStart()
  local inventory = Inventory_GetCurrentInventory()
  local maxSize = inventory:sizeXXX() - useStartSlot
  local prevSlotIndex = PaGlobal_Inventory_All._startSlotIndex
  PaGlobal_Inventory_All._startSlotIndex = UIScroll.ScrollEvent(PaGlobal_Inventory_All._ui.scroll_inven, isUp, PaGlobal_Inventory_All.config.slotRows, maxSize, PaGlobal_Inventory_All._startSlotIndex, PaGlobal_Inventory_All.config.slotCols)
  local intervalSlotIndex = PaGlobal_Inventory_All.INVEN_MAX_COUNT - PaGlobal_Inventory_All.INVEN_CURRENTSLOT_COUNT
  if prevSlotIndex == 0 and PaGlobal_Inventory_All._startSlotIndex == 0 or prevSlotIndex == intervalSlotIndex and PaGlobal_Inventory_All._startSlotIndex == intervalSlotIndex then
    return
  end
  Inventory_updateSlotData()
end
function HandleEventOnOut_Inventory_All_WeightTooltip(isShow)
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local s64_moneyWeight = selfPlayer:getInventory():getMoneyWeight_s64()
  local s64_equipmentWeight = selfPlayer:getEquipment():getWeight_s64()
  local s64_allWeight = selfPlayer:getCurrentWeight_s64()
  local s64_maxWeight = selfPlayer:getPossessableWeight_s64()
  local moneyWeight = Int64toInt32(s64_moneyWeight) / 10000
  local equipmentWeight = Int64toInt32(s64_equipmentWeight) / 10000
  local allWeight = Int64toInt32(s64_allWeight) / 10000
  local maxWeight = Int64toInt32(s64_maxWeight) / 10000
  local invenWeight = allWeight - equipmentWeight - moneyWeight
  if isShow == true then
    PaGlobal_Inventory_All._ui.txt_weightDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_WEIGHTHELP_1") .. string.format("%.1f", invenWeight) .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT") .. "(" .. string.format("%.1f", invenWeight / maxWeight * 100) .. "%)")
    PaGlobal_Inventory_All._ui.txt_equipDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_EQUIPHELP_1") .. string.format("%.1f", equipmentWeight) .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT") .. "(" .. string.format("%.1f", equipmentWeight / maxWeight * 100) .. "%)")
    PaGlobal_Inventory_All._ui.txt_moneyDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_MONEYHELP_1") .. string.format("%.1f", moneyWeight) .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT") .. "(" .. string.format("%.1f", moneyWeight / maxWeight * 100) .. "%)")
    Panel_Window_Inventory_All:SetChildIndex(PaGlobal_Inventory_All._ui.stc_weightTooltipBG, 9000)
    Panel_Window_Inventory_All:SetChildIndex(PaGlobal_Inventory_All._ui.txt_weightDesc, 9999)
    Panel_Window_Inventory_All:SetChildIndex(PaGlobal_Inventory_All._ui.txt_equipDesc, 9999)
    Panel_Window_Inventory_All:SetChildIndex(PaGlobal_Inventory_All._ui.txt_moneyDesc, 9999)
    PaGlobal_Inventory_All._ui.stc_weightTooltipBG:SetShow(true)
    PaGlobal_Inventory_All._ui.txt_weightDesc:SetShow(true)
    PaGlobal_Inventory_All._ui.txt_equipDesc:SetShow(true)
    PaGlobal_Inventory_All._ui.txt_moneyDesc:SetShow(true)
    local mousePosY = getMousePosY()
    local invenPosY = Panel_Window_Inventory_All:GetPosY()
    if true == Panel_Window_Inventory_All:IsUISubApp() then
      invenPosY = Panel_Window_Inventory_All:GetScreenParentPosY()
    end
    PaGlobal_Inventory_All._ui.stc_weightTooltipBG:SetPosY(mousePosY - invenPosY + 25)
    local endPosY = invenPosY + PaGlobal_Inventory_All._ui.stc_weightTooltipBG:GetPosY() + PaGlobal_Inventory_All._ui.stc_weightTooltipBG:GetSizeY()
    if endPosY > getScreenSizeY() then
      local gap = endPosY - getScreenSizeY()
      PaGlobal_Inventory_All._ui.stc_weightTooltipBG:SetPosY(PaGlobal_Inventory_All._ui.stc_weightTooltipBG:GetPosY() - gap)
    end
    PaGlobal_Inventory_All._ui.txt_weightDesc:SetPosY(PaGlobal_Inventory_All._ui.stc_weightTooltipBG:GetPosY() + 13)
    PaGlobal_Inventory_All._ui.txt_equipDesc:SetPosY(PaGlobal_Inventory_All._ui.txt_weightDesc:GetPosY() + 25)
    if true == _ContentsGroup_RenewUI_ItemMarketPlace then
      PaGlobal_Inventory_All._ui.txt_moneyDesc:SetShow(false)
      PaGlobal_Inventory_All._ui.stc_weightTooltipBG:SetSize(PaGlobal_Inventory_All._ui.stc_weightTooltipBG:GetSizeX(), PaGlobal_Inventory_All._defaultWeightTooltipSizeY)
      PaGlobal_Inventory_All._ui.stc_weightTooltipBG:SetPosY(PaGlobal_Inventory_All._ui.txt_weightDesc:GetPosY() - 12)
    end
  else
    PaGlobal_Inventory_All._ui.stc_weightTooltipBG:SetShow(false)
    PaGlobal_Inventory_All._ui.txt_weightDesc:SetShow(false)
    PaGlobal_Inventory_All._ui.txt_equipDesc:SetShow(false)
    PaGlobal_Inventory_All._ui.txt_moneyDesc:SetShow(false)
  end
end
function HandleEventOnOut_Inventory_All_BuyWeightTooltip(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BUYWEIGHT_TOOLTIP_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BUYWEIGHT_TOOLTIP_DESC")
  TooltipSimple_Show(PaGlobal_Inventory_All._ui.btn_buyWeight, name, desc)
end
function HandleEventLUp_Inventory_All_PopMoney()
  if not Panel_Window_Warehouse:GetShow() and not PaGlobalFunc_ServantInventory_GetShow() then
    return
  end
  local whereType = CppEnums.ItemWhereType.eInventory
  local slotNo = getMoneySlotNo()
  FGlobal_PopupMoveItem_Init(whereType, slotNo, CppEnums.MoveItemToType.Type_Player, getSelfPlayer():getActorKey(), true)
end
function HandleEventOnOut_Inventory_All_MoneyIconTooltip(isShow, tipType)
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "GAME_EXCHANGE_ITEMTOOLTIP_DESCRIPTION_SILVER")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TOOLTIP_SILVER_DESC")
    control = PaGlobal_Inventory_All._ui.stc_moneyIcon
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMESHOP_MONEYICON_TOOLTIP_PEARL_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TOOLTIP_PEARL_DESC")
    control = PaGlobal_Inventory_All._ui.stc_pearlIcon
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMESHOP_MONEYICON_TOOLTIP_MILEAGE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMESHOP_MONEYICON_TOOLTIP_MILEAGE_DESC")
    control = PaGlobal_Inventory_All._ui.stc_mileageIcon
  elseif 3 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_AUCTION_SEASHELL")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TOOLTIP_SEASHELL_DESC")
    control = PaGlobal_Inventory_All._ui.stc_oceanIcon
  end
  if isShow then
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventLUp_Inventory_All_OpenPearlShop()
  if Defines.UIMode.eUIMode_Default ~= GetUIMode() then
    return
  end
  InGameShop_Open()
end
function HandleEventLUp_Inventory_All_BottomButtonClick(functionType)
  if DragManager:isDragging() then
    DragManager:clearInfo()
  end
  if 0 == functionType then
    if false == _ContentsGroup_NewUI_AlchemyFigureHead_All then
      FGlobal_AlchemyFigureHead_Open()
    else
      PaGlobal_AlchemyFigureHead_All_Open()
    end
  elseif 1 == functionType then
    if true == _ContentsGroup_NewUI_AlchemyStone_All then
      PaGlobalFunc_AlchemyStone_All_Open()
    else
      FGlobal_AlchemyStone_Open()
    end
  elseif 2 == functionType then
    PaGlobalFunc_Inventory_All_OpenManufacture()
  elseif 3 == functionType then
    PaGlobalFunc_Inventory_All_OpenPalette()
  end
end
function HandleEventOnOut_Inventory_All_BottomButtonTooltip(isShow, tipType)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ALCHEMYFIGUREHEAD_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ALCHEMYFIGUREHEAD_TOOLTIP_DESC")
    control = PaGlobal_Inventory_All._ui.btn_alchemyFigureHead
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ALCHEMYSTONE_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ALCHEMYSTONE_TOOLTIP_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    control = PaGlobal_Inventory_All._ui.btn_alchemyStone
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_MANUFACTURE_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_MANUFACTURE_TOOLTIP_DESC")
    control = PaGlobal_Inventory_All._ui.btn_manufacture
  elseif 3 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DYEPALETTE_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DYEPALETTE_TOOLTIP_DESC")
    control = PaGlobal_Inventory_All._ui.btn_dyePalette
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_Inventory_All_ItemDelete()
  if true == DragManager:isDragging() and true == PaGlobalFunc_Inventory_All_CheckDragStartPanel() then
    if Panel_Window_Inventory_All == DragManager.dragStartPanel then
      local slotNo = DragManager.dragSlotInfo
      local whereType = Inventory_GetCurrentInventoryType()
      local itemWrapper = getInventoryItemByType(whereType, slotNo)
      if nil == itemWrapper then
        return
      end
      local itemCount = itemWrapper:get():getCount_s64()
      if Defines.s64_const.s64_1 == itemCount then
        PaGlobalFunc_Inventory_All_ItemDelete_Check(Defines.s64_const.s64_1, slotNo, whereType)
      else
        Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobalFunc_Inventory_All_ItemDelete_Check, nil, whereType)
      end
    elseif Panel_Window_ServantInventory == DragManager.dragStartPanel then
      local actorKeyRaw = ServantInventory_GetActorKeyRawFromDragManager()
      local vehicleActorWrapper = getVehicleActor(actorKeyRaw)
      if nil == vehicleActorWrapper then
        return
      end
      local vehicleActor = vehicleActorWrapper:get()
      if nil == vehicleActor then
        return
      end
      if true == vehicleActor:isCannon() or true == vehicleActor:isGuildVehicle() then
        local luaDelete = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETE")
        local luaDeleteItemMsg = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINVENTORY_ONLYTRASH_INVENTORY")
        local messageContent = luaDeleteItemMsg
        local messageboxData = {
          title = luaDelete,
          content = messageContent,
          functionYes = ServantInventory_Delete_No,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageboxData)
        return
      end
      local slotNo = DragManager.dragSlotInfo
      local itemWrapper = getServantInventoryItemBySlotNo(actorKeyRaw, slotNo)
      if nil == itemWrapper then
        return
      end
      local itemCount = itemWrapper:get():getCount_s64()
      if Defines.s64_const.s64_1 == itemCount then
        ServantInventory_GroundClick_Message(Defines.s64_const.s64_1, slotNo)
      else
        Panel_NumberPad_Show(true, itemCount, slotNo, ServantInventory_GroundClick_Message)
      end
    end
  elseif true == _ContentsGroup_RestoreItem then
    PaGlobalFunc_Restore_All_Open()
  end
end
function HandleEventOnOut_Inventory_All_TrashTooltip(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRASH_TOOLTIP_TITLE")
  local desc
  if true == _ContentsGroup_RestoreItem then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRASH_TOOLTIP_WITH_RESTORATION_DESC")
  else
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRASH_TOOLTIP_DESC")
  end
  TooltipSimple_Show(PaGlobal_Inventory_All._ui.btn_trash, name, desc)
end
function HandleEventLUp_Inventory_All_MakePuzzle(index)
  PaGlobal_Inventory_All:hidePuzzleControl()
  requestMakePuzzle()
end
function HandleEventOnOut_Inventory_All_PuzzleTooltip(isShow, slotIndex)
  if not isShow then
    PaGlobal_Inventory_All._ui.stc_puzzleNotice:SetShow(false)
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_Inventory_All._ui.txt_puzzleNoticeText:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_Inventory_All._ui.txt_puzzleNoticeText:SetAutoResize(true)
  PaGlobal_Inventory_All._ui.txt_puzzleNoticeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DOPUZZLE"))
  local slot = PaGlobal_Inventory_All.slots[slotIndex]
  PaGlobal_Inventory_All._ui.stc_puzzleNotice:SetPosX(slot.icon:GetPosX() - PaGlobal_Inventory_All._ui.stc_puzzleNotice:GetSizeX())
  PaGlobal_Inventory_All._ui.stc_puzzleNotice:SetPosY(slot.icon:GetPosY() - 20)
  PaGlobal_Inventory_All._ui.stc_puzzleNotice:SetSize(PaGlobal_Inventory_All._ui.txt_puzzleNoticeText:GetSizeX() + 20, PaGlobal_Inventory_All._ui.txt_puzzleNoticeText:GetTextSizeY() + 20)
  PaGlobal_Inventory_All._ui.stc_puzzleNotice:SetColor(Defines.Color.C_FF000000)
  PaGlobal_Inventory_All._ui.stc_puzzleNotice:SetShow(true)
end
function HandleEventLDown_Inventory_All_SlotLClick(index)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local slotNo = PaGlobal_Inventory_All.slots[index]._slotNo
  local inventoryType = Inventory_GetCurrentInventoryType()
  local useStartSlot = inventorySlotNoUserStart()
  local invenUseSize = selfProxy:getInventorySlotCount(not PaGlobal_Inventory_All._ui.rdo_normalInven:IsChecked())
  if Panel_Chatting_Input:IsShow() and isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
    local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
    if nil == itemWrapper then
      return
    end
    local focusEdit = GetFocusEdit()
    if ChatInput_CheckCurrentUiEdit(focusEdit) then
      FGlobal_ChattingInput_LinkedItemByInventory(slotNo, inventoryType)
    end
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
    if (isGameTypeJapan() or isGameTypeRussia()) and getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_CBT then
      return
    end
    if getSelfPlayer():isInstancePlayer() then
      local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
      if nil == itemWrapper then
        return
      end
      if itemWrapper:getStaticStatus():isStackable() then
        Panel_NumberPad_Show(true, itemWrapper:get():getCount_s64(), slotNo, PaGlobalFunc_Inventory_All_ProcessThrowItem)
      else
        PaGlobalFunc_Inventory_All_ProcessThrowItem(1, slotNo)
      end
      return
    end
    local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
    if nil ~= itemWrapper then
      ProductNote_Item_ShowToggle(itemWrapper:get():getKey():getItemKey())
      PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetShow(false)
    end
  elseif invenUseSize - useStartSlot - PaGlobal_Inventory_All._startSlotIndex == index then
    local isDye = nil ~= Panel_Widget_Dye_All and Panel_Widget_Dye_All:GetShow()
    if false == isDye then
      audioPostEvent_SystemUi(0, 0)
      PaGlobal_EasyBuy:Open(5)
    end
  end
end
function HandleEventRUp_Inventory_All_SlotRClick(index, equipSlotNo)
  if MessageBoxGetShow() then
    return
  end
  if true == PaGlobal_Inventory_All._isMarketOpen then
    return
  end
  local slotNo = PaGlobal_Inventory_All.slots[index]._slotNo
  local whereType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemName = itemWrapper:getStaticStatus():getName()
  local isCash = itemWrapper:isCash()
  if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
    if isCash then
      return
    end
    if false == PaGlobal_Inventory_All._isItemLockContentsOpen then
      return
    end
    if true == _ContentsGroup_NewUI_Dialog_All then
      if Panel_Npc_Dialog_All:IsShow() then
        return
      end
    elseif true == _ContentsGroup_RenewUI_Dailog then
      if PaGlobalFunc_MainDialog_IsShow() then
        return
      end
    elseif Panel_Npc_Dialog:IsShow() then
      return
    end
    if Panel_Window_ItemMarket_Function:GetShow() or Panel_Window_ItemMarket_RegistItem:GetShow() or false == _ContentsGroup_NewUI_RepairFunction_All and true == Panel_Window_Repair:GetShow() or true == _ContentsGroup_NewUI_RepairFunction_All and true == Panel_Dialog_Repair_Function_All:GetShow() then
      return
    end
    if false == itemWrapper:getStaticStatus():isStackable() and false == itemWrapper:isSoulCollector() then
      if ToClient_Inventory_CheckItemLock(slotNo, whereType) then
        ToClient_Inventory_RemoveItemLock(slotNo)
        Proc_ShowMessage_Ack("[" .. itemName .. "] " .. PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ITEMUNLOCK"))
      else
        ToClient_Inventory_InsertItemLock(slotNo)
        Proc_ShowMessage_Ack("[" .. itemName .. "] " .. PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ITEMLOCK"))
      end
    elseif ToClient_Inventory_CheckItemLock(slotNo, whereType) then
      ToClient_Inventory_RemoveItemLock(slotNo)
      Proc_ShowMessage_Ack("[" .. itemName .. "] " .. PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ITEMUNLOCK"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_CANNOT_ITEMLOCK"))
    end
    Inventory_updateSlotData()
  else
    PaGlobalFunc_Inventory_All_SlotRClickXXX(slotNo, equipSlotNo, index)
  end
end
function PaGlobalFunc_Inventory_All_SlotRClickXXX(slotNo, equipSlotNo, index)
  local selfProxy = getSelfPlayer():get()
  local inventoryType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  local isNormalInventory = PaGlobal_Inventory_All._ui.rdo_normalInven:IsChecked()
  if true == isNormalInventory then
    local invenUseSize = selfProxy:getInventorySlotCount(false)
    if invenUseSize < slotNo + 1 then
      return
    end
  end
  if nil ~= itemWrapper then
    local itemEnchantWrapper = itemWrapper:getStaticStatus()
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
    if selfProxy:doRideMyVehicle() and false == Panel_Window_Warehouse:GetShow() and false == PaGlobalFunc_ServantInventory_GetShow() and nil ~= Panel_Window_CampWarehouse_All and false == Panel_Window_CampWarehouse_All:GetShow() and nil ~= Panel_Dialog_NPCShop_All and false == Panel_Dialog_NPCShop_All:GetShow() and itemStatic:isUseToVehicle() then
      inventoryUseItem(inventoryType, slotNo, equipSlotNo, false)
      return
    end
    if false == _ContentsGroup_NewUI_Servant_All and Panel_Window_StableStallion:GetShow() then
      local itemMaxCount = FGlobal_MaxItemCount(slotNo)
      if nil ~= itemMaxCount then
        if itemMaxCount < Int64toInt32(itemWrapper:get():getCount_s64()) then
          Panel_NumberPad_Show(true, tonumber64(itemMaxCount), slotNo, Set_StallionItemSlot, nil, itemWrapper)
        else
          Panel_NumberPad_Show(true, itemWrapper:get():getCount_s64(), slotNo, Set_StallionItemSlot, nil, itemWrapper)
        end
      end
      return
    end
    if true == _ContentsGroup_NewUI_ServantInfo_All and true == PaGlobal_VehicleInfo_All_GetPanelShow() then
      PaGlobal_VehicleInfo_All_InvenSetFunctor(slotNo, itemWrapper, itemWrapper:get():getCount_s64(), inventoryType)
      return
    end
    if nil ~= PaGlobal_Inventory_All.rClickFunc then
      PaGlobal_Inventory_All.rClickFunc(slotNo, itemWrapper, itemWrapper:get():getCount_s64(), inventoryType)
      return
    end
    PaGlobal_TutorialManager:handleInventorySlotRClick(itemWrapper:get():getKey():getItemKey())
    PaGlobal_TutorialManager:handleInventorySlotRClickgetSlotNo(slotNo)
    if DragManager:isDragging() then
      DragManager:clearInfo()
    end
    if nil ~= Panel_Auction_Regist_Popup and Panel_Auction_Regist_Popup:GetShow() then
      if itemWrapper:getStaticStatus():isStackable() then
        Panel_NumberPad_Show(true, itemWrapper:get():getCount_s64(), slotNo, Auction_RegisterItemFromInventory)
      else
        Auction_RegisterItemFromInventory(1, slotNo)
      end
      return
    elseif nil ~= Panel_Housing_SettingVendingMachine and Panel_Housing_SettingVendingMachine:GetShow() then
      VendingMachine_RegisterItemFromInventory(slotNo, 1)
      return
    elseif nil ~= Panel_Housing_VendingMachineList and Panel_Housing_VendingMachineList:GetShow() then
      FGlobal_VendingMachineRegisterItemFromInventory(slotNo)
    elseif nil ~= Panel_Housing_ConsignmentSale and Panel_Housing_ConsignmentSale:GetShow() then
      FGlobal_ConsignmentRegisterItemFromInventory(itemWrapper:get():getCount_s64(), slotNo)
    elseif nil ~= Panel_Window_FairySetting and Panel_Window_FairySetting:GetShow() then
      PaGlobal_FairySetting_SetPortion(itemWrapper:get():getKey())
    elseif nil ~= Panel_FairyInfo and Panel_Window_FairyUpgrade:GetShow() then
      if true == itemWrapper:getStaticStatus():isStackable() then
        Panel_NumberPad_Show(true, itemWrapper:get():getCount_s64(), slotNo, PaGlobal_FairyUpgrade_RClickItemByNumberPad, false, itemWrapper:get():getKey())
      else
        PaGlobal_FairyUpgrade_RClickItem(itemWrapper:get():getKey(), slotNo, 1)
      end
    elseif false == _ContentsGroup_NewUI_Dialog_All and true == getAuctionState() then
      return
    elseif true == _ContentsGroup_NewUI_Dialog_All and true == PaGlobalFunc_DialogMain_All_GetAuctionState() then
      return
    elseif 2 == itemEnchantWrapper:get()._vestedType:getItemKey() and false == itemWrapper:get():isVested() then
      local function bindingItemUse()
        PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, equipSlotNo)
      end
      local messageContent
      if itemEnchantWrapper:isUserVested() then
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT_USERVESTED")
      else
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT")
      end
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_TITLE"),
        content = messageContent,
        functionYes = bindingItemUse,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    elseif eConnectUiType.eConnectUi_Undefined ~= itemWrapper:getStaticStatus():getConnectUi() then
      ConnectUI(itemWrapper:getStaticStatus():getConnectUi())
    elseif itemWrapper:getStaticStatus():getItemType() == 8 then
      local itemKey = itemWrapper:get():getKey():getItemKey()
      audioPostEvent_SystemUi(0, 14)
      PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetShow(true)
      Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "inventory", false, false)
      local row = math.floor((slotNo - 1) / PaGlobal_Inventory_All.config.slotCols)
      local col = (slotNo - 1) % PaGlobal_Inventory_All.config.slotCols
      PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetPosX(PaGlobal_Inventory_All.slots[index].icon:GetPosX() - 42)
      PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetPosY(PaGlobal_Inventory_All.slots[index].icon:GetPosY() + 42)
      local endPosX = PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:GetPosX() + PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:GetSizeX()
      if 0 > PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:GetPosX() then
        PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetPosX(0)
      elseif endPosX > Panel_Window_Inventory_All:GetSizeX() then
        local gap = endPosX - Panel_Window_Inventory_All:GetSizeX()
        PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetPosX(PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:GetPosX() - gap)
      end
      local _btn_MenuSizeX = PaGlobal_Inventory_All._ui.btn_manufactureOpen:GetSizeX() + 23
      local _btn_MenuTextSizeX = _btn_MenuSizeX - _btn_MenuSizeX / 2 - PaGlobal_Inventory_All._ui.btn_manufactureOpen:GetTextSizeX() / 2
      local _btn_NoteSizeX = PaGlobal_Inventory_All._ui.btn_productNote:GetSizeX() + 23
      local _btn_NoteTextSizeX = _btn_NoteSizeX - _btn_NoteSizeX / 2 - PaGlobal_Inventory_All._ui.btn_productNote:GetTextSizeX() / 2
      PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetTextSpan(_btn_MenuTextSizeX, 5)
      PaGlobal_Inventory_All._ui.btn_productNote:SetTextSpan(_btn_NoteTextSizeX, 5)
      PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetPosX(4)
      PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetPosY(4)
      PaGlobal_Inventory_All._ui.btn_productNote:SetPosX(4)
      PaGlobal_Inventory_All._ui.btn_productNote:SetPosY(38)
      if MiniGame_Manual_Value_FishingStart == true then
        PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetEnable(false)
        PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetMonoTone(true)
        PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetAlpha(0.8)
      else
        PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetEnable(true)
        PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetMonoTone(false)
        PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetAlpha(1)
      end
      PaGlobal_Inventory_All._ui.btn_manufactureOpen:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_OpenManufacture(" .. slotNo .. ")")
      PaGlobal_Inventory_All._ui.btn_productNote:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_OpenProductNote(" .. itemWrapper:get():getKey():getItemKey() .. ")")
      PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:addInputEvent("Mouse_Out", "HandleEventOut_Inventory_All_HideManufactureBG()")
      PaGlobal_Inventory_All._ui.btn_manufactureOpen:addInputEvent("Mouse_Out", "HandleEventOut_Inventory_All_HideManufactureBG()")
      PaGlobal_Inventory_All._ui.btn_productNote:addInputEvent("Mouse_Out", "HandleEventOut_Inventory_All_HideManufactureBG()")
      return
    elseif nil ~= PaGlobalFunc_ServantInventory_GetShow and true == PaGlobalFunc_ServantInventory_GetShow() or nil ~= Panel_Window_CampWarehouse_All and true == Panel_Window_CampWarehouse_All:GetShow() then
      if nil ~= FGlobal_PopupMoveItem_InitByInventory then
        FGlobal_PopupMoveItem_InitByInventory(slotNo, itemWrapper, itemWrapper:get():getCount_s64(), inventoryType)
        return
      end
    elseif itemEnchantWrapper:isPopupItem() then
      if false == _ContentsGroup_NewUI_UseItem_All then
        Panel_UserItem_PopupItem(itemEnchantWrapper, inventoryType, slotNo, equipSlotNo)
      else
        PaGlobal_UseItem_All_PopupItem(itemEnchantWrapper, inventoryType, slotNo, equipSlotNo)
      end
    elseif itemEnchantWrapper:isExchangeItemNPC() or itemWrapper:isSoulCollector() or 17 == itemWrapper:getStaticStatus():getItemType() then
      if nil == PaGlobal_Inventory_All._ui.stc_exchangeButtonBG then
        UI.ASSERT_NAME(nil ~= PaGlobal_Inventory_All._ui.stc_exchangeButtonBG, "PaGlobal_Inventory_All._ui.stc_exchangeButtonBG \237\140\168\235\132\144\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164.", "\234\185\128\236\157\152\236\167\132")
        return
      end
      PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetShow(true)
      Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "inventory", false, false)
      local row = math.floor((slotNo - 1) / PaGlobal_Inventory_All.config.slotCols)
      local col = (slotNo - 1) % PaGlobal_Inventory_All.config.slotCols
      PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetPosX(PaGlobal_Inventory_All.slots[index].icon:GetPosX() - 42)
      PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetPosY(PaGlobal_Inventory_All.slots[index].icon:GetPosY() + 42)
      local _btn_WayPointSizeX = PaGlobal_Inventory_All._ui.btn_waypoint:GetSizeX() + 23
      local _btn_WayPointTextSizeX = _btn_WayPointSizeX - _btn_WayPointSizeX / 2 - PaGlobal_Inventory_All._ui.btn_waypoint:GetTextSizeX() / 2
      local _btn_WidgetSizeX = PaGlobal_Inventory_All._ui.btn_widget:GetSizeX() + 23
      local _btn_WidgetTextSizeX = _btn_WidgetSizeX - _btn_WidgetSizeX / 2 - PaGlobal_Inventory_All._ui.btn_widget:GetTextSizeX() / 2
      PaGlobal_Inventory_All._ui.btn_waypoint:SetTextSpan(_btn_WayPointTextSizeX, 5)
      PaGlobal_Inventory_All._ui.btn_widget:SetTextSpan(_btn_WidgetTextSizeX, 5)
      PaGlobal_Inventory_All._ui.btn_waypoint:SetPosX(4)
      PaGlobal_Inventory_All._ui.btn_waypoint:SetPosY(4)
      PaGlobal_Inventory_All._ui.btn_widget:SetPosX(4)
      PaGlobal_Inventory_All._ui.btn_widget:SetPosY(38)
      if itemWrapper:isSoulCollector() then
        PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetSize(162, 40)
        PaGlobal_Inventory_All._ui.btn_waypoint:SetShow(false)
        PaGlobal_Inventory_All._ui.btn_widget:SetPosY(4)
      else
        PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetSize(162, 74)
        PaGlobal_Inventory_All._ui.btn_waypoint:SetShow(true)
        PaGlobal_Inventory_All._ui.btn_widget:SetPosY(38)
      end
      local endPosX = PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetPosX() + PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetSizeX()
      if 0 > PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetPosX() then
        PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetPosX(0)
      elseif endPosX > Panel_Window_Inventory_All:GetSizeX() then
        local gap = endPosX - Panel_Window_Inventory_All:GetSizeX()
        PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetPosX(PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetPosX() - gap)
      end
      if 17 == itemWrapper:getStaticStatus():getItemType() and false == itemEnchantWrapper:isExchangeItemNPC() then
        PaGlobal_Inventory_All._ui.btn_waypoint:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_USELESSITEM_WAYPOINT_BTN"))
        PaGlobal_Inventory_All._ui.btn_waypoint:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_NaviStart()")
      else
        PaGlobal_Inventory_All._ui.btn_waypoint:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_EXCHANGE_WAYPOINT_BTN"))
        PaGlobal_Inventory_All._ui.btn_waypoint:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_FindExchangeItemNPC( " .. slotNo .. " )")
      end
      PaGlobal_Inventory_All._ui.btn_widget:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_ObserveItemCount( " .. slotNo .. " )")
      PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:addInputEvent("Mouse_Out", "HandleEventOut_Inventory_All_HideExchangeBG()")
      PaGlobal_Inventory_All._ui.btn_waypoint:addInputEvent("Mouse_Out", "HandleEventOut_Inventory_All_HideExchangeBG()")
      PaGlobal_Inventory_All._ui.btn_widget:addInputEvent("Mouse_Out", "HandleEventOut_Inventory_All_HideExchangeBG()")
    elseif not itemStatic:isUseToVehicle() then
      local function useTradeItem()
        PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, equipSlotNo)
      end
      local itemSSW = itemWrapper:getStaticStatus()
      local item_type = itemSSW:getItemType()
      if 2 == item_type and true == itemSSW:get():isForJustTrade() then
        local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRADEITEMUSE_CONTENT")
        local messageboxData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRADEITEMUSE_TITLE"),
          content = messageContent,
          functionYes = useTradeItem,
          functionNo = MessageBox_Empty_function,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageboxData)
      else
        local equipType = itemWrapper:getStaticStatus():getEquipType()
        if 16 == equipType or 17 == equipType then
          local accSlotNo
          if true == _ContentsGroup_NewUI_Equipment_All then
            accSlotNo = PaGlobalFunc_Equipment_All_AccSlotNo(itemWrapper, true)
          else
            accSlotNo = FGlobal_AccSlotNo(itemWrapper, true)
          end
          PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, accSlotNo)
        else
          PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, equipSlotNo)
        end
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_CANT_USEITEM"))
    end
  end
end
function HandleEventLUp_Inventory_All_DropHandler(index)
  if nil == DragManager.dragStartPanel then
    return false
  end
  if true == PaGlobal_Inventory_All:isRestricted() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_CANT_REPOSITIONITEM"))
    return false
  end
  local isManufactureOpen = false
  if true == _ContentsGroup_NewUI_Manufacture_All then
    isManufactureOpen = Panel_Window_Manufacture_All:GetShow()
  else
    isManufactureOpen = Panel_Manufacture:GetShow()
  end
  local isAlchemyOpen = false
  if true == _ContentsGroup_NewUI_Alchemy_All then
    isAlchemyOpen = Panel_Window_Alchemy_All:GetShow()
  else
    isAlchemyOpen = Panel_Alchemy:IsShow()
  end
  if Panel_Window_Exchange:IsShow() or isManufactureOpen or isAlchemyOpen or MessageBoxGetShow() or false == _ContentsGroup_NewUI_XXX and true == FGlobal_Enchant_SetTargetItem() or Panel_Window_DetectUser:IsShow() or false == _ContentsGroup_NewUI_Pet_All and PaGlobalFunc_PetRegister_GetShow() or true == _ContentsGroup_NewUI_Pet_All and PaGlobal_PetRegister_All_GetShow() or true == PaGlobalFunc_RandomBoxSelect_All_GetShow() or true == Panel_UseItem_All:GetShow() then
    DragManager:clearInfo()
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_CANT_REPOSITIONITEM_WHILE_UI"))
    return false
  end
  local slotNo = PaGlobal_Inventory_All.slots[index]._slotNo
  if Panel_Window_Inventory_All == DragManager.dragStartPanel then
    if DragManager.dragWhereTypeInfo == Inventory_GetCurrentInventoryType() then
      inventory_swapItem(Inventory_GetCurrentInventoryType(), DragManager.dragSlotInfo, slotNo)
    end
    DragManager:clearInfo()
  else
    return DragManager:itemDragMove(CppEnums.MoveItemToType.Type_Player, getSelfPlayer():getActorKey())
  end
  return true
end
function HandleEventPressMove_Inventory_All_SlotDrag(index)
  if nil ~= PaGlobal_Inventory_All._inventoryDragNoUsePanel and PaGlobal_Inventory_All._inventoryDragNoUsePanel:IsShow() then
    return
  end
  if true == PaGlobal_Inventory_All._isMarketOpen then
    return
  end
  if MessageBoxGetShow() then
    return
  end
  if false == _ContentsGroup_NewUI_BlackSmith_All then
    if true == Panel_Window_Extraction_Caphras:GetShow() then
      return
    end
  elseif true == Panel_Window_Extraction_Caphras_All:GetShow() then
    return
  end
  local slotNo = PaGlobal_Inventory_All.slots[index]._slotNo
  local whereType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local isEquip = itemSSW:get():isEquipable()
  DragManager:setDragInfo(Panel_Window_Inventory_All, whereType, slotNo, "Icon/" .. itemWrapper:getStaticStatus():getIconPath(), PaGlobalFunc_Inventory_All_GroundClick, getSelfPlayer():getActorKey())
  if itemWrapper:getStaticStatus():get():isItemSkill() or itemWrapper:getStaticStatus():get():isUseToVehicle() or true == isEquip then
    QuickSlot_ShowBackGround()
  end
  Item_Move_Sound(itemWrapper)
end
function HandleEventOnOut_Inventory_All_IconTooltip(isShow, index)
  if false == isShow then
    if nil ~= PaGlobal_Inventory_All.slotOverEffect then
      PaGlobal_Inventory_All.slots[index].icon:EraseEffect(PaGlobal_Inventory_All.slotOverEffect)
    end
    PaGlobal_Inventory_All._tooltipWhereType = nil
    PaGlobal_Inventory_All._tooltipSlotNo = nil
    Panel_Tooltip_Item_Show_GeneralNormal(index, "inventory", false, false)
    TooltipSimple_Hide()
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local slotNo = PaGlobal_Inventory_All.slots[index]._slotNo
  local isNormalInventory = PaGlobal_Inventory_All._ui.rdo_normalInven:IsChecked()
  if slotNo < PaGlobal_Inventory_All.INVEN_MAX_SLOTNO and nil ~= PaGlobal_Inventory_All.effectScene.newItem[slotNo] then
    if true == isNormalInventory then
      PaGlobal_Inventory_All.newItemData[slotNo] = nil
    else
      PaGlobal_Inventory_All.newPearlItemData[slotNo] = nil
    end
    PaGlobal_Inventory_All.slots[index].icon:EraseEffect(PaGlobal_Inventory_All.effectScene.newItem[slotNo])
    PaGlobal_Inventory_All.effectScene.newItem[slotNo] = nil
    PaGlobal_Inventory_All:setNewPearlTabEffect()
  end
  local useStartSlot = inventorySlotNoUserStart()
  local invenUseSize = selfPlayer:get():getInventorySlotCount(not PaGlobal_Inventory_All._ui.rdo_normalInven:IsChecked())
  if invenUseSize - useStartSlot - PaGlobal_Inventory_All._startSlotIndex == index then
    local isDye = nil ~= Panel_Widget_Dye_All and Panel_Widget_Dye_All:GetShow()
    if not isGameTypeGT() and _ContentsGroup_EasyBuy and false == isDye then
      local name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ADDINVENTORY_TOOLTIP_NAME")
      local desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ADDINVENTORY_TOOLTIP_DESC")
      local control = PaGlobal_Inventory_All.slots[index].icon
      TooltipSimple_Show(control, name, desc)
      return
    end
  end
  if nil ~= PaGlobal_Inventory_All.slotOverEffect then
    PaGlobal_Inventory_All.slots[index].icon:EraseEffect(PaGlobal_Inventory_All.slotOverEffect)
  end
  PaGlobal_Inventory_All.slotOverEffect = PaGlobal_Inventory_All.slots[index].icon:AddEffect("UI_Inventory_EmptySlot", false, 0, 0)
  PaGlobal_Inventory_All._tooltipWhereType = Inventory_GetCurrentInventoryType()
  PaGlobal_Inventory_All._tooltipSlotNo = slotNo
  Panel_Tooltip_Item_Show_GeneralNormal(index, "inventory", true, false)
end
function HandleEventLUp_Inventory_All_OpenManufacture(slotNo)
  if true == _ContentsGroup_NewUI_Manufacture_All then
    if nil ~= Panel_Window_Manufacture_All and Panel_Window_Manufacture_All:GetShow() then
      return
    end
  elseif nil ~= Panel_Manufacture and Panel_Manufacture:GetShow() then
    return
  end
  if not IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_MANUFACTURE"))
    return
  end
  if 0 ~= ToClient_GetMyTeamNoLocalWar() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_LOCALWAR_ALERT"))
    return
  end
  if false == _ContentsGroup_NewUI_Manufacture_All then
    Manufacture_Show(nil, CppEnums.ItemWhereType.eInventory, true)
  else
    PaGlobalFunc_Manufacture_All_Open(nil, CppEnums.ItemWhereType.eInventory, true)
  end
  PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetShow(false)
  PaGlobal_Inventory_All._clickOutManufactreBG = true
end
function HandleEventLUp_Inventory_All_OpenProductNote(itemKey)
  ProductNote_Item_ShowToggle(itemKey)
  PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetShow(false)
  PaGlobal_Inventory_All._clickOutManufactreBG = true
end
function HandleEventOut_Inventory_All_HideManufactureBG()
  if true == PaGlobal_Inventory_All._clickOutManufactreBG then
    PaGlobal_Inventory_All._clickOutManufactreBG = false
    return
  end
  local invenPosX = Panel_Window_Inventory_All:GetPosX()
  local invenPosY = Panel_Window_Inventory_All:GetPosY()
  if true == Panel_Window_Inventory_All:IsUISubApp() then
    invenPosX = Panel_Window_Inventory_All:GetScreenParentPosX()
    invenPosY = Panel_Window_Inventory_All:GetScreenParentPosY()
  end
  local panelPosX = invenPosX + PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:GetPosX()
  local panelPosY = invenPosY + PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:GetPosY()
  local panelSizeX = PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:GetSizeX()
  local panelSizeY = PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:GetSizeY()
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  if panelPosX <= mousePosX and mousePosX <= panelPosX + panelSizeX and panelPosY <= mousePosY and mousePosY <= panelPosY + panelSizeY then
    return
  end
  PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetShow(false)
end
function HandleEventLUp_Inventory_All_NaviStart()
  HandleClicked_TownNpcIcon_NaviStart(16, false)
  PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetShow(false)
  PaGlobal_Inventory_All._clickOutExchangeBG = true
end
function HandleEventLUp_Inventory_All_FindExchangeItemNPC(slotNo)
  PaGlobal_Inventory_All:findExchangeItemNPCbySlotNo(slotNo)
  PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetShow(false)
  PaGlobal_Inventory_All._clickOutExchangeBG = true
end
function HandleEventLUp_Inventory_All_ObserveItemCount(slotNo)
  local inventoryType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if nil == itemWrapper then
    PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetShow(false)
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  PaGlobal_Inventory_All._whereUseItemSlotNo = slotNo
  PaGlobal_Inventory_All._whereUseItemSSW = itemSSW
  FGlobal_WhereUseITemDirectionOpen(itemSSW, slotNo)
  PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetShow(false)
  PaGlobal_Inventory_All._clickOutExchangeBG = true
end
function HandleEventOut_Inventory_All_HideExchangeBG()
  if true == PaGlobal_Inventory_All._clickOutExchangeBG then
    PaGlobal_Inventory_All._clickOutExchangeBG = false
    return
  end
  local invenPosX = Panel_Window_Inventory_All:GetPosX()
  local invenPosY = Panel_Window_Inventory_All:GetPosY()
  if true == Panel_Window_Inventory_All:IsUISubApp() then
    invenPosX = Panel_Window_Inventory_All:GetScreenParentPosX()
    invenPosY = Panel_Window_Inventory_All:GetScreenParentPosY()
  end
  local panelPosX = invenPosX + PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetPosX()
  local panelPosY = invenPosY + PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetPosY()
  local panelSizeX = PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetSizeX()
  local panelSizeY = PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetSizeY()
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  if panelPosX <= mousePosX and mousePosX <= panelPosX + panelSizeX and panelPosY <= mousePosY and mousePosY <= panelPosY + panelSizeY then
    return
  end
  PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetShow(false)
end
