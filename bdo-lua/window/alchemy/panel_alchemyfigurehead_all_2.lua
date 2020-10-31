function PaGlobal_AlchemyFigureHead_All_Open()
  PaGlobal_AlchemyFigureHead_All:prepareOpen()
end
function PaGlobal_AlchemyFigureHead_All_Close()
  PaGlobal_AlchemyFigureHead_All:prepareClose()
end
function PaGlobal_AlchemyFigureHead_All_FigureHeadFilter(slotNo, itemWrapper, count, inventoryType)
  local returnValue = true
  if nil == itemWrapper:getStaticStatus() then
    return returnValue
  end
  if 37 == itemWrapper:getStaticStatus():get():getContentsEventType() then
    returnValue = false
  end
  return returnValue
end
function PaGlobal_AlchemyFigureHead_All_StuffFilter(slotNo, itemWrapper, count, inventoryType)
  local returnValue = true
  local staticStatus = itemWrapper:getStaticStatus()
  if nil == staticStatus or nil == PaGlobal_AlchemyFigureHead_All._totemData.selectedType then
    return returnValue
  end
  local itemKey = itemWrapper:get():getKey()
  if staticStatus:isAlchemyUpgradeMaterial(PaGlobal_AlchemyFigureHead_All._totemData.itemKey) then
    returnValue = false
  end
  return returnValue
end
function PaGlobal_AlchemyFigureHead_All_FigureHeadRfunction(slotNo, itemWrapper, count, inventoryType)
  PaGlobal_AlchemyFigureHead_All._totemData.inventoryType = inventoryType
  PaGlobal_AlchemyFigureHead_All._totemData.slotNo = slotNo
  PaGlobal_AlchemyFigureHead_All._totemData.selectedType = itemWrapper:getStaticStatus():get()._contentsEventParam1
  PaGlobal_AlchemyFigureHead_All._totemData.itemKey = itemWrapper:get():getKey()
  PaGlobal_AlchemyFigureHead_All._ui.stc_totemSlot:setItemByStaticStatus(itemWrapper:getStaticStatus())
  PaGlobal_AlchemyFigureHead_All._ui.stc_totemSlot.empty = false
  if PaGlobal_AlchemyFigureHead_All._isConsole then
    PaGlobal_AlchemyFigureHead_All._ui.stc_totemSlotBG:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventOnOut_AlchemyFigureHead_All_ItemToolTipConsole(" .. inventoryType .. ", " .. slotNo .. ")")
  else
    PaGlobal_AlchemyFigureHead_All._ui.stc_totemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyFigureHead_All_ItemToolTip( true, true )")
    PaGlobal_AlchemyFigureHead_All._ui.stc_totemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyFigureHead_All_ItemToolTip( false )")
  end
  Inventory_SetFunctor(PaGlobal_AlchemyFigureHead_All_StuffFilter, PaGlobal_AlchemyFigureHead_All_StuffRfunction, nil, nil)
  PaGlobal_AlchemyFigureHead_All:setGuideText()
end
function PaGlobal_AlchemyFigureHead_All_StuffRfunction(slotNo, itemWrapper, count, inventoryType)
  PaGlobal_AlchemyFigureHead_All._blackstoneData.inventoryType = inventoryType
  PaGlobal_AlchemyFigureHead_All._blackstoneData.slotNo = slotNo
  PaGlobal_AlchemyFigureHead_All._blackstoneData.count = count
  local function setStuffFunc(itemCount)
    PaGlobal_AlchemyFigureHead_All._blackstoneData.count = itemCount
    local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
    local itemSSW = itemWrapper:getStaticStatus()
    PaGlobal_AlchemyFigureHead_All._ui.stc_blackstoneSlot:setItemByStaticStatus(itemSSW, PaGlobal_AlchemyFigureHead_All._blackstoneData.count, nil, nil, nil)
    PaGlobal_AlchemyFigureHead_All._ui.stc_blackstoneSlot.empty = false
    if PaGlobal_AlchemyFigureHead_All._isConsole then
      PaGlobal_AlchemyFigureHead_All._ui.stc_blackstoneSlotBG:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventOnOut_AlchemyFigureHead_All_ItemToolTipConsole(" .. inventoryType .. ", " .. slotNo .. ")")
    else
      PaGlobal_AlchemyFigureHead_All._ui.stc_blackstoneSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyFigureHead_All_ItemToolTip( true, false )")
      PaGlobal_AlchemyFigureHead_All._ui.stc_blackstoneSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyFigureHead_All_ItemToolTip( false )")
    end
    PaGlobal_AlchemyFigureHead_All:setGuideText()
  end
  if count > toInt64(0, 1) then
    Panel_NumberPad_Show(true, count, nil, setStuffFunc, false, nil, nil)
  else
    setStuffFunc(toInt64(0, 1))
  end
end
function PaGlobal_AlchemyFigureHead_All_UpdateTime(deltaTime)
  PaGlobal_AlchemyFigureHead_All._curTime = PaGlobal_AlchemyFigureHead_All._curTime + deltaTime
  if PaGlobal_AlchemyFigureHead_All._curTime >= PaGlobal_AlchemyFigureHead_All._maxTime then
    local fromWhere = PaGlobal_AlchemyFigureHead_All._blackstoneData.inventoryType
    local fromSlotNo = PaGlobal_AlchemyFigureHead_All._blackstoneData.slotNo
    local toWhere = PaGlobal_AlchemyFigureHead_All._totemData.inventoryType
    local toSlotNo = PaGlobal_AlchemyFigureHead_All._totemData.slotNo
    alchemyEvolve(fromWhere, fromSlotNo, toWhere, toSlotNo)
    Panel_AlchemyFigureHead_All:ignorePadSnapMoveToOtherPanelUpdate(false)
    Panel_AlchemyFigureHead_All:ClearUpdateLuaFunc()
    PaGlobal_AlchemyFigureHead_All:clearAllData()
  elseif PaGlobal_AlchemyFigureHead_All._effectFlag.startPlay.time < PaGlobal_AlchemyFigureHead_All._curTime and false == PaGlobal_AlchemyFigureHead_All._effectFlag.startPlay.isCheck then
    PaGlobal_AlchemyFigureHead_All._ui.stc_blackstoneSlot.icon:EraseAllEffect()
    PaGlobal_AlchemyFigureHead_All._ui.stc_blackstoneSlot.icon:AddEffect("fUI_Alchemy_Totem_L_Slot_01A", false)
    audioPostEvent_SystemUi(5, 85)
    _AudioPostEvent_SystemUiForXBOX(5, 85)
    PaGlobal_AlchemyFigureHead_All._effectFlag.startPlay.isCheck = true
  elseif PaGlobal_AlchemyFigureHead_All._effectFlag.contentEffect.time < PaGlobal_AlchemyFigureHead_All._curTime and false == PaGlobal_AlchemyFigureHead_All._effectFlag.contentEffect.isCheck then
    PaGlobal_AlchemyFigureHead_All._ui.stc_blackstoneSlot:clearItem()
    PaGlobal_AlchemyFigureHead_All._ui.stc_effect:EraseAllEffect()
    PaGlobal_AlchemyFigureHead_All._ui.stc_effect:AddEffect("fUI_Alchemy_Totem_01A", false)
    PaGlobal_AlchemyFigureHead_All._effectFlag.contentEffect.isCheck = true
  elseif PaGlobal_AlchemyFigureHead_All._effectFlag.slotEffect.time < PaGlobal_AlchemyFigureHead_All._curTime and false == PaGlobal_AlchemyFigureHead_All._effectFlag.slotEffect.isCheck then
    PaGlobal_AlchemyFigureHead_All._ui.stc_totemSlot.icon:EraseAllEffect()
    PaGlobal_AlchemyFigureHead_All._ui.stc_totemSlot.icon:AddEffect("fUI_Alchemy_Totem_R_Slot_01A", false)
    PaGlobal_AlchemyFigureHead_All._effectFlag.slotEffect.isCheck = true
  elseif PaGlobal_AlchemyFigureHead_All._effectFlag.resultSound.time < PaGlobal_AlchemyFigureHead_All._curTime and false == PaGlobal_AlchemyFigureHead_All._effectFlag.resultSound.isCheck then
    audioPostEvent_SystemUi(5, 83)
    _AudioPostEvent_SystemUiForXBOX(5, 83)
    PaGlobal_AlchemyFigureHead_All._effectFlag.resultSound.isCheck = true
  end
end
function HandleEventLUp_AlchemyFigureHead_All_Doit()
  if true == PaGlobal_AlchemyFigureHead_All._isConsole and (true == PaGlobal_AlchemyFigureHead_All._ui.stc_blackstoneSlot.empty or true == PaGlobal_AlchemyFigureHead_All._ui.stc_totemSlot.empty) then
    return
  end
  local doUpgrade = function()
    Panel_AlchemyFigureHead_All:RegisterUpdateFunc("PaGlobal_AlchemyFigureHead_All_UpdateTime")
    PaGlobal_AlchemyFigureHead_All._ui_pc.btn_doit:SetMonoTone(true)
    PaGlobal_AlchemyFigureHead_All._ui_pc.btn_doit:SetEnable(false)
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_AlchemyFigureHead_All._totemData.inventoryType, PaGlobal_AlchemyFigureHead_All._totemData.slotNo)
  local itemSSW = itemWrapper:getStaticStatus()
  local itemGrade = itemSSW:getGradeType()
  local itemContentsParam2 = itemSSW:get()._contentsEventParam2
  local msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local msgContent = ""
  if 2 == itemContentsParam2 or 3 == itemContentsParam2 then
    msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYFISHPRINT_MSGBOX_CONTENT1")
  elseif 4 == itemContentsParam2 then
    msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYFISHPRINT_MSGBOX_CONTENT2")
  else
    Panel_AlchemyFigureHead_All:RegisterUpdateFunc("PaGlobal_AlchemyFigureHead_All_UpdateTime")
    PaGlobal_AlchemyFigureHead_All._ui_pc.btn_doit:SetMonoTone(true)
    PaGlobal_AlchemyFigureHead_All._ui_pc.btn_doit:SetEnable(false)
  end
  if "" ~= msgContent then
    local messageBoxData = {
      title = msgTitle,
      content = msgContent,
      functionYes = doUpgrade,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, "middle")
  end
  audioPostEvent_SystemUi(1, 43)
  _AudioPostEvent_SystemUiForXBOX(1, 43)
  Panel_AlchemyFigureHead_All:ignorePadSnapMoveToOtherPanelUpdate(true)
end
function HandleEventLUp_AlchemyFigureHead_All_ClearItem(isTotem)
  if false == isTotem then
    PaGlobal_AlchemyFigureHead_All:clearBlackstoneData()
  else
    PaGlobal_AlchemyFigureHead_All:clearAllData()
  end
end
function HandleEventOnOut_AlchemyFigureHead_All_ItemToolTip(isShow, isTotem)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local slotNo = PaGlobal_AlchemyFigureHead_All._totemData.slotNo
  local WhereType = PaGlobal_AlchemyFigureHead_All._totemData.inventoryType
  local control = PaGlobal_AlchemyFigureHead_All._ui.stc_totemSlot.icon
  if false == isTotem then
    slotNo = PaGlobal_AlchemyFigureHead_All._blackstoneData.slotNo
    WhereType = PaGlobal_AlchemyFigureHead_All._blackstoneData.inventoryType
    control = PaGlobal_AlchemyFigureHead_All._ui.stc_blackstoneSlot.icon
  end
  if nil == slotNo or nil == WhereType then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemWrapper = getInventoryItemByType(WhereType, slotNo)
  if nil == itemWrapper then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  Panel_Tooltip_Item_Show(itemWrapper, control, false, true, nil, nil, nil)
end
function HandleEventOnOut_AlchemyFigureHead_All_ItemToolTipConsole(inventoryType, slotNo)
  if nil ~= Panel_Widget_Tooltip_Renew and PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if nil == itemWrapper then
    return
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  PaGlobalFunc_FloatingTooltip_Close()
end
function FromClient_AlchemyFigureHead_AllUpgrade(itemwhereType, slotNo, exp)
  if not Panel_AlchemyFigureHead_All:GetShow() then
    return
  end
  local itemWrapper = getInventoryItemByType(itemwhereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemName = itemWrapper:getStaticStatus():getName()
  local mainMsg = itemName .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DONE_UPGRADE")
  local resultMsg = {
    main = mainMsg,
    sub = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_EXP") .. string.format("%.2f", itemWrapper:getExperience() / 10000) .. "%",
    addMsg = "Icon/" .. itemWrapper:getStaticStatus():getIconPath()
  }
  Proc_ShowMessage_Ack_For_RewardSelect(resultMsg, 2.5, 33)
  Inventory_SetFunctor(PaGlobal_AlchemyFigureHead_All_FigureHeadFilter, PaGlobal_AlchemyFigureHead_All_FigureHeadRfunction, nil, nil)
  audioPostEvent_SystemUi(5, 23)
  _AudioPostEvent_SystemUiForXBOX(5, 23)
end
function FromClient_AlchemyFigureHead_AllChange(whereType, slotNo)
  if not Panel_AlchemyFigureHead_All:GetShow() then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemName = itemWrapper:getStaticStatus():getName()
  local msg = {
    main = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_DONE"),
    sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_DONE2", "itemName", itemName),
    addMsg = "Icon/" .. itemWrapper:getStaticStatus():getIconPath()
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 2.5, 33)
  Inventory_SetFunctor(PaGlobal_AlchemyFigureHead_All_FigureHeadFilter, PaGlobal_AlchemyFigureHead_All_FigureHeadRfunction, nil, nil)
  audioPostEvent_SystemUi(5, 22)
  _AudioPostEvent_SystemUiForXBOX(5, 22)
end
function FromClient_AlchemyFigureHead_AllChangeFailedByDown(whereType, slotNo)
  if not Panel_AlchemyFigureHead_All:GetShow() then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemName = itemWrapper:getStaticStatus():getName()
  local msg = {
    main = itemName .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DONE_UPGRADE"),
    sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_FAIL2", "itemName", itemName),
    addMsg = "Icon/" .. itemWrapper:getStaticStatus():getIconPath()
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 2.5, 33)
  Inventory_SetFunctor(PaGlobal_AlchemyFigureHead_All_FigureHeadFilter, PaGlobal_AlchemyFigureHead_All_FigureHeadRfunction, nil, nil)
  audioPostEvent_SystemUi(5, 23)
  _AudioPostEvent_SystemUiForXBOX(5, 23)
end
function FromClient_AlchemyFigureHead_AllEvolve(evolveType)
  if not Panel_AlchemyFigureHead_All:GetShow() then
    return
  end
  if 1 == evolveType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_LOST"))
  end
  Inventory_SetFunctor(PaGlobal_AlchemyFigureHead_All_FigureHeadFilter, PaGlobal_AlchemyFigureHead_All_FigureHeadRfunction, nil, nil)
end
function FromClient_AlchemyFigureHead_All_ReSizePanel()
  Panel_AlchemyFigureHead_All:ComputePosAllChild()
end
function PaGlobal_AlchemyFigureHead_All_ShowAni()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
end
function PaGlobal_AlchemyFigureHead_All_HideAni()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
end
