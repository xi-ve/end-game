function HandleEventLUp_VehicleInfo_All_Close()
  PaGlobal_VehicleInfo_All:prepareClose()
end
function HandleEventOn_VehicleInfo_All_TextTooltip(tooltipType)
  local name, control, desc
  if PaGlobal_VehicleInfo_All._eTooltipType._exp == tooltipType then
    name = PaGlobal_VehicleInfo_All._ui._txt_expValue:GetText()
    control = PaGlobal_VehicleInfo_All._ui._txt_expValue
  elseif PaGlobal_VehicleInfo_All._eTooltipType._remainTime == tooltipType then
    name = PaGlobal_VehicleInfo_All._ui._txt_remainPeriod:GetText()
    control = PaGlobal_VehicleInfo_All._ui._txt_remainPeriod
  elseif PaGlobal_VehicleInfo_All._eTooltipType._deadCount == tooltipType then
    name = PaGlobal_VehicleInfo_All._ui._txt_deadCount:GetText()
    control = PaGlobal_VehicleInfo_All._ui._txt_deadCount
  elseif PaGlobal_VehicleInfo_All._eTooltipType._name == tooltipType then
    name = PaGlobal_VehicleInfo_All._ui._txt_nameValue:GetText()
    control = PaGlobal_VehicleInfo_All._ui._txt_nameValue
  elseif PaGlobal_VehicleInfo_All._eTooltipType._rentTime == tooltipType then
    control = PaGlobal_VehicleInfo_All._ui._txt_rentTime
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_SERVANTINFO_RENTENDTIME")
    desc = PaGlobal_VehicleInfo_All._ui._txt_rentTime:GetText()
  end
  if nil == control then
    HandleEventOut_VehicleInfo_All_TextTooltip()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOut_VehicleInfo_All_TextTooltip()
  if _ContentsGroup_UsePadSnapping then
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOn_VehicleInfo_All_ServantTierTooltip()
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_GRADEINFO_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_GENERATIONDESC")
  if true == PaGlobal_VehicleInfo_All._isConsole then
    local pos = {}
    local control = Panel_Window_VehicleInfo_All
    pos.x = control:GetPosX() + control:GetSizeX()
    pos.y = control:GetPosY()
    TooltipSimple_ShowSetSetPos_Console(pos, name, desc)
  else
    local control = PaGlobal_VehicleInfo_All._ui._txt_tierValue
    TooltipSimple_Show(control, name, desc)
  end
end
function HandleEventOut_VehicleInfo_All_ServantTierTooltip()
  TooltipSimple_Hide()
end
function HandleEventOn_VehicleInfo_All_StallionTooltip()
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local name = ""
  local desc = ""
  local isStallion = servantWrapper:isStallion()
  if true == isStallion then
    uiControl = PaGlobal_VehicleInfo_All._ui._stc_goodHorseIcon
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TEXT_STALLIONICONNAME")
    if isContentsNineTierEnable then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TEXT_STALLIONICONDESC")
      desc2 = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TEXT_STALLIONICONDESC2")
      desc = string.format("%s %s", desc, desc2)
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TEXT_STALLIONICONDESC")
    end
  else
    uiControl = PaGlobal_VehicleInfo_All._ui._stc_goodHorseIcon
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TEXT_NOTSTALLIONICONNAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TEXT_NOTSTALLIONICONDESC")
  end
  if true == PaGlobal_VehicleInfo_All._isConsole then
    local pos = {}
    uiControl = Panel_Window_VehicleInfo_All
    pos.x = uiControl:GetPosX() + uiControl:GetSizeX()
    pos.y = uiControl:GetPosY()
    TooltipSimple_ShowSetSetPos_Console(pos, name, desc)
    return
  end
  registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
  TooltipSimple_Show(uiControl, name, desc)
end
function HandleEventOut_VehicleInfo_All_StallionTooltip()
  TooltipSimple_Hide()
end
function HandleEventOn_VehicleInfo_All_WeightTooltip()
  local control
  if true == PaGlobal_VehicleInfo_All._ui._stc_weightGuide:GetShow() then
    control = PaGlobal_VehicleInfo_All._ui._stc_weightGuide
  elseif true == PaGlobal_VehicleInfo_All._ui._stc_heavyAlert:GetShow() then
    control = PaGlobal_VehicleInfo_All._ui._stc_heavyAlert
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_WEIGHT_TOOLTIP")
  TooltipSimple_Show(control, name)
end
function HandleEventOut_VehicleInfo_All_WeightTooltip()
  TooltipSimple_Hide()
end
function HandleEventOn_VehicleInfo_All_RentEndTimeTooltip(isShow, rentTime)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_SERVANTINFO_RENTENDTIME")
  desc = rentTime
  control = PaGlobal_VehicleInfo_All._ui._txt_rentTime
  TooltipSimple_Show(control, name, desc)
end
function HandlerEventScroll_VehicleInfo_All_InventoryScroll(isUp)
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  local prevSlotIndex = PaGlobal_VehicleInfo_All._inventory._startInvenSlotIndex
  local config = PaGlobal_VehicleInfo_All._inventory._config
  PaGlobal_VehicleInfo_All._inventory._startInvenSlotIndex = UIScroll.ScrollEvent(PaGlobal_VehicleInfo_All._ui._scroll_vertical, isUp, config.row, config.contentsCount, PaGlobal_VehicleInfo_All._inventory._startInvenSlotIndex, config.col)
  if prevSlotIndex ~= PaGlobal_VehicleInfo_All._inventory._startInvenSlotIndex then
    Panel_Tooltip_Item_hideTooltip()
    PaGlobal_VehicleInfo_All:updateInventorySlot()
  end
end
function HandleEventRUp_VehicleInfo_All_InvenSlotRClick(slotNo)
  FGlobal_PopupMoveItem_Init(CppEnums.ItemWhereType.eServantInventory, slotNo, CppEnums.MoveItemToType.Type_Vehicle, PaGlobal_VehicleInfo_All._actorKeyRaw, true)
  local itemWrapper = getServantInventoryItemBySlotNo(PaGlobal_VehicleInfo_All._actorKeyRaw, slotNo)
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
end
function HandleEventRUp_VehicleInfo_All_VehicleInvenTooltip_ForConsole(slotNo)
  if false == PaGlobal_VehicleInfo_All._isConsole or nil == slotNo then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemWrapper = getServantInventoryItemBySlotNo(PaGlobal_VehicleInfo_All._actorKeyRaw, slotNo)
  if nil == itemWrapper then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare, 0)
end
function HandleEventRUp_VehicleInfo_All_EquipItemRClick(slotNo)
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local itemWrapper = servantWrapper:getEquipItem(slotNo)
  if nil == itemWrapper then
    return
  end
  servant_doUnequip(servantWrapper:getActorKeyRaw(), slotNo)
end
function HandleEventOn_VehicleInfo_All_EquipItemTooltip(slotNo, isOn)
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  if true == isOn and true == PaGlobal_VehicleInfo_All._isConsole then
    local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
    local itemWrapper
    if nil ~= servantWrapper then
      itemWrapper = servantWrapper:getEquipItem(slotNo)
    end
    if nil ~= itemWrapper then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare, 0)
    end
  else
    Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "ServantShipEquipment", isOn)
  end
end
function HandleEventLUp_VehicleInfo_All_EquipShow(slotNo)
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local isShowEquip = PaGlobal_VehicleInfo_All._ui._chk_equipShow[slotNo]:IsCheck()
  if true == PaGlobal_VehicleInfo_All._isConsole then
    isShowEquip = not isShowEquip
    PaGlobal_VehicleInfo_All._ui._chk_equipShow[slotNo]:SetCheck(isShowEquip)
  end
  if isShowEquip then
    ToClient_SetVehicleEquipSlotFlag(servantWrapper:getVehicleType(), slotNo)
  else
    ToClient_ResetVehicleEquipSlotFlag(servantWrapper:getVehicleType(), slotNo)
  end
  ToClient_setShowVehicleEquip()
end
function HandleEventOn_VehicleInfo_All_SetKeyGuideY(isShow)
  PaGlobal_VehicleInfo_All._ui._console.txt_keyGuideY:SetShow(isShow)
  PaGlobal_VehicleInfo_All:setAlignKeyGuide()
end
function HandleEventOn_VehicleInfo_All_SkillTooltip(isShow, index)
  if false == isShow then
    if true == _ContentsGroup_NewUI_Tooltip_All then
      if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Close then
        PaGlobal_Tooltip_Skill_Servant_All_Close()
      end
    elseif nil ~= PaGlobal_Tooltip_Servant_Close then
      PaGlobal_Tooltip_Servant_Close()
    end
    return
  end
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local skillWrapper = servantWrapper:getSkill(PaGlobal_VehicleInfo_All._skillIndexList[index])
  if nil == skillWrapper then
    return
  end
  local desc = skillWrapper:getDescription()
  local content = PaGlobal_VehicleInfo_All:getSkillList():GetContentByKey(toInt64(0, index))
  local stc_BG = UI.getChildControl(content, "Static_SkillName")
  local stc_skillBG = UI.getChildControl(stc_BG, "Static_VehicleSkillBG")
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Open then
      PaGlobal_Tooltip_Skill_Servant_All_Open(skillWrapper, stc_skillBG, false)
    end
  elseif nil ~= PaGlobal_Tooltip_Servant_Open then
    PaGlobal_Tooltip_Servant_Open(skillWrapper, stc_skillBG, false)
  end
end
function HandleEventOn_VehicleInfo_All_WarningTooltip(isShow, index)
  if false == isShow then
    if _ContentsGroup_UsePadSnapping then
    else
      TooltipSimple_Hide()
    end
    return
  end
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local name, desc
  local skillWrapper = servantWrapper:getSkill(PaGlobal_VehicleInfo_All._skillIndexList[index])
  local content = PaGlobal_VehicleInfo_All:getSkillList():GetContentByKey(toInt64(0, index))
  local stc_BG = UI.getChildControl(content, "Static_SkillName")
  local stc_warning = UI.getChildControl(stc_BG, "Static_Warning")
  if nil ~= skillWrapper then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_NEEDSKILLTITLE")
    desc = skillWrapper:getConditionDescription()
    TooltipSimple_Show(stc_warning, name, desc)
  end
end
function HandleEventLUp_VehicleInfo_All_ServantSkillLock(index)
  PaGlobal_VehicleInfo_All:updateServantSkillLock(index)
end
function HandleEventLUp_VehicleInfo_All_LinkedServantSkill(index)
  PaGloabl_LinkedSkill_All_Open(PaGlobal_VehicleInfo_All._actorKeyRaw, index)
end
function HandleEventLUp_VehicleInfo_All_SetAutoFeed()
  repeat
    break -- pseudo-goto
  until true
end
function PaGlobalFunc_HorseInfo_GetIsCheckAutoCarrot()
  return false
end
function FromClient_VehicleInfo_All_OpenSevantInfomation(actorKeyRaw)
  local servantWrapper = getServantInfoFromActorKey(actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  if servantWrapper:isGuildServant() then
    if false == servantWrapper:isMyGuildServant() then
      return
    end
  elseif false == servantWrapper:isSelfVehicle() then
    return
  end
  if nil ~= Panel_Window_CampWarehouse_All and Panel_Window_CampWarehouse_All:GetShow() then
    PaGlobalFunc_CampWarehouse_All_Close()
  end
  local vehicleType = servantWrapper:getVehicleType()
  if PaGlobal_VehicleInfo_All:isCheckNormal(vehicleType) then
    PaGlobal_VehicleInfo_All:prepareOpen(PaGlobal_VehicleInfo_All._eViewType._normal, actorKeyRaw)
  elseif PaGlobal_VehicleInfo_All:isCheckCarriage(vehicleType) then
    PaGlobal_VehicleInfo_All:prepareOpen(PaGlobal_VehicleInfo_All._eViewType._carriage, actorKeyRaw)
  elseif PaGlobal_VehicleInfo_All:isCheckShip(vehicleType) then
    if true == _ContentsGroup_OceanCurrent then
      PaGlobal_ShipInfo_All:prepareOpen(actorKeyRaw, false)
    elseif true == _ContentsGroup_RenewUI then
      PaGlobal_ShipInfo_All:prepareOpen(actorKeyRaw, false)
    else
      ShipInfo_OpenByActorKeyRaw(actorKeyRaw)
    end
  elseif PaGlobal_VehicleInfo_All:isCheckBigShip(vehicleType) then
    if true == _ContentsGroup_OceanCurrent then
      PaGlobal_ShipInfo_All:prepareOpen(actorKeyRaw, true)
    else
      WorkerShipInfo_OpenByActorKeyRaw(actorKeyRaw)
    end
  end
end
function FromClient_VehicleInfo_All_UpdateHp()
  if false == Panel_Window_VehicleInfo_All:GetShow() then
    return
  end
  PaGlobal_VehicleInfo_All:updateHp()
end
function FromClient_VehicleInfo_All_UpdateMp()
  if false == Panel_Window_VehicleInfo_All:GetShow() then
    return
  end
  PaGlobal_VehicleInfo_All:updateStamina()
end
function FromClient_VehicleInfo_All_UpdateLevel()
  if false == Panel_Window_VehicleInfo_All:GetShow() then
    return
  end
  PaGlobal_VehicleInfo_All:updateLevel()
end
function FromClient_VehicleInfo_All_ServantEquipmentUpdate()
  if false == Panel_Window_VehicleInfo_All:GetShow() then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  FromClient_VehicleInfo_All_UpdateAll()
end
function FromClient_VehicleInfo_All_UpdateAll()
  if false == Panel_Window_VehicleInfo_All:GetShow() then
    return
  end
  PaGlobal_VehicleInfo_All:updateData(PaGlobal_VehicleInfo_All._viewType)
end
function PaGloabl_VehicleInfo_All_ShowAni()
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
end
function PaGloabl_VehicleInfo_All_HideAni()
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
end
function PaGlobal_VehicleInfo_All_Close()
  PaGlobal_VehicleInfo_All:prepareClose()
end
function PaGlobal_VehicleInfo_All_GetActorKeyRaw()
  return PaGlobal_VehicleInfo_All._actorKeyRaw
end
function PaGlobal_VehicleInfo_All_InfoUpdate()
  PaGlobal_VehicleInfo_All:update(PaGlobal_VehicleInfo_All._viewType)
end
function PaGlobal_VehicleInfo_All_GetPanelShow()
  if nil == Panel_Window_VehicleInfo_All then
    return false
  end
  return Panel_Window_VehicleInfo_All:GetShow()
end
function PaGlobal_VehicleInfo_All_InvenSetFunctor(slotNo, itemWrapper, s64_count, inventoryType)
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  local itemSS = itemSSW:get()
  if nil == itemSS then
    return
  end
  PaGlobal_VehicleInfo_All._inventoryType = inventoryType
  PaGlobal_VehicleInfo_All._inventroySlotNo = slotNo
  local servantKind = servantWrapper:getServantKind()
  local servantKindSub = servantWrapper:getServantKindSub()
  if true == itemSS:isServantTypeUsable(servantKind, servantKindSub) then
    if 2 == itemSS._vestedType:getItemKey() and false == itemWrapper:get():isVested() then
      local messageContent
      if itemSSW:isUserVested() then
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT_USERVESTED")
      else
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT")
      end
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_TITLE"),
        content = messageContent,
        functionYes = PaGlobal_VehicleInfo_All_InventoryUseItem,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      PaGlobal_VehicleInfo_All_InventoryUseItem()
    end
  else
    Panel_NumberPad_Show(true, s64_count, slotNo, PaGlobal_VehicleInfo_All_MoveInventoryItemFromActorToActor, nil, inventoryType)
    if nil ~= itemWrapper then
      local itemStatic = itemWrapper:getStaticStatus():get()
      if nil ~= itemStatic then
        audioPostEvent_SystemItem(itemStatic._itemMaterial)
      end
    end
  end
end
function PaGlobal_VehicleInfo_All_MoveInventoryItemFromActorToActor(s64_count, slotNo, whereType)
  moveInventoryItemFromActorToActor(getSelfPlayer():get():getActorKeyRaw(), PaGlobal_VehicleInfo_All._actorKeyRaw, whereType, slotNo, s64_count)
end
function PaGlobal_VehicleInfo_All_InventoryUseItem()
  inventoryUseItem(PaGlobal_VehicleInfo_All._inventoryType, PaGlobal_VehicleInfo_All._inventroySlotNo, CppEnums.EquipSlotNoClient.eEquipSlotNoCount, false)
end
function PaGlobal_VehicleInfo_All_UpdateSkillList(control, key)
  PaGlobal_VehicleInfo_All:updateSkillList(control, key)
end
function PaGlobal_VehicleInfo_All_UpdateHorseList(control, key)
  PaGlobal_VehicleInfo_All:updateHorseList(control, key)
end
function PaGlobal_VehicleInfo_All_Open(actorKeyRaw)
  local servantWrapper = getServantInfoFromActorKey(actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  FromClient_VehicleInfo_All_OpenSevantInfomation(actorKeyRaw)
end
function PaGlobal_VehicleInfo_All_OpenHorseInfo()
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  local selfPlayer = getSelfPlayer()
  local selfProxy = selfPlayer:get()
  if nil == selfProxy then
    return
  end
  local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
  local vehicleProxy = getVehicleActor(actorKeyRaw)
  if nil == vehicleProxy then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEINFO_HORSEINFOALERTMSG"))
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  if false == ToClient_isCheckRenderModeGame() then
    return
  end
  if CppEnums.VehicleType.Type_Horse == vehicleType or CppEnums.VehicleType.Type_Camel == vehicleType or CppEnums.VehicleType.Type_Donkey == vehicleType or CppEnums.VehicleType.Type_Elephant == vehicleType or CppEnums.VehicleType.Type_RidableBabyElephant == vehicleType then
    PaGlobal_VehicleInfo_All_Open(actorKeyRaw)
  end
end
function IsNowEquipCheck()
  return false
end
function PaGlobal_VehicleInfo_All_ToggleAutoFeed()
  if false == PaGlobal_VehicleInfo_All._isConsole then
    return
  end
  if true == PaGlobal_VehicleInfo_All._ui._chk_autoFeed:IsCheck() then
    PaGlobal_VehicleInfo_All._ui._chk_autoFeed:SetCheck(false)
  else
    PaGlobal_VehicleInfo_All._ui._chk_autoFeed:SetCheck(true)
  end
  if true == _ContentsGroup_RenewUI then
    FGlobal_ToggleServantAutoCarrot_PadInput()
  else
    HandlePadEventX_ServantMpBar_ToggleAutoCarrot()
  end
end
function PaGlobalFunc_HorseInfo_GetIsCheckAutoCarrot()
  if nil == PaGlobal_VehicleInfo_All._ui._chk_autoFeed then
    return true
  end
  return PaGlobal_VehicleInfo_All._ui._chk_autoFeed:IsCheck()
end
function PaGlobalFunc_VehicleInfo_All_StallionTooltipForConsole()
  if true == PaGlobal_VehicleInfo_All._stallionTooltipShow then
    HandleEventOut_VehicleInfo_All_StallionTooltip()
    PaGlobal_VehicleInfo_All._stallionTooltipShow = false
  else
    HandleEventOn_VehicleInfo_All_StallionTooltip()
    PaGlobal_VehicleInfo_All._tierTooltipShow = false
    PaGlobal_VehicleInfo_All._stallionTooltipShow = true
  end
end
function PaGlobalFunc_VehicleInfo_All_ServantTierTooltipForConsole()
  if true == PaGlobal_VehicleInfo_All._tierTooltipShow then
    HandleEventOut_VehicleInfo_All_ServantTierTooltip()
    PaGlobal_VehicleInfo_All._tierTooltipShow = false
  else
    HandleEventOn_VehicleInfo_All_ServantTierTooltip()
    PaGlobal_VehicleInfo_All._stallionTooltipShow = false
    PaGlobal_VehicleInfo_All._tierTooltipShow = true
  end
end
