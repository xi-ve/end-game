function HandlerEventLUp_ShipInfoAll_RadioButtonSelect()
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  local control = PaGlobal_ShipInfo_All._ui
  local barHalfSize = control.stc_selcBar:GetSizeX() / 2
  local centerPos = float2()
  if control.radio_basicInfo:IsCheck() then
    local btnHalfSize = control.radio_basicInfo:GetSizeX() / 2
    centerPos.x = control.radio_basicInfo:GetPosX() + btnHalfSize - barHalfSize
    centerPos.y = control.stc_selcBar:GetPosY()
    PaGlobal_ShipInfo_All:basic_Update()
  elseif control.radio_sailorInfo:IsCheck() then
    local btnHalfSize = control.radio_sailorInfo:GetSizeX() / 2
    centerPos.x = control.radio_sailorInfo:GetPosX() + btnHalfSize - barHalfSize
    centerPos.y = control.stc_selcBar:GetPosY()
    if false == PaGlobal_ShipInfo_All_isShowSailorInfo() then
      return
    end
    PaGlobal_ShipInfo_All:sailor_Update()
  end
  control.stc_sailorInfoGroup:SetShow(control.radio_sailorInfo:IsCheck())
  control.stc_baseInfoGroup:SetShow(control.radio_basicInfo:IsCheck())
  control.stc_selcBar:SetPosX(centerPos.x)
  control.stc_selcBar:SetPosY(centerPos.y)
end
function HandlerEventScrollDown_ShipInfoAll_ShipInven(isUp)
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  local prevSlotIndex = PaGlobal_ShipInfo_All._startInvenSlotIndex
  PaGlobal_ShipInfo_All._startInvenSlotIndex = UIScroll.ScrollEvent(PaGlobal_ShipInfo_All._ui.list_basic_ShipInven, isUp, PaGlobal_ShipInfo_All._config.row, PaGlobal_ShipInfo_All._config.contentsCount, PaGlobal_ShipInfo_All._startInvenSlotIndex, PaGlobal_ShipInfo_All._config.col)
  if prevSlotIndex ~= PaGlobal_ShipInfo_All._startInvenSlotIndex then
    Panel_Tooltip_Item_hideTooltip()
    PaGlobal_ShipInfo_All:basic_invenUpdate()
  end
end
function HandlerEventMouseOn_ShipInfoAll_EquipItem(index, isOn, isCash)
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  local slot, slotNoTable
  if false == isCash then
    slot = PaGlobal_ShipInfo_All._equipItemSlots[index]
    if false == PaGlobal_ShipInfo_All._isBigShip then
      slotNoTable = PaGlobal_ShipInfo_All._equipSlotNoSmall
    else
      slotNoTable = PaGlobal_ShipInfo_All._equipSlotNoBig
    end
  else
    slot = PaGlobal_ShipInfo_All._equipItemCashSlots[index]
    if false == PaGlobal_ShipInfo_All._isBigShip then
      slotNoTable = PaGlobal_ShipInfo_All._equipCashSlotNoSmall
    else
      slotNoTable = PaGlobal_ShipInfo_All._equipCashSlotNoBig
    end
  end
  local slotNo = slotNoTable[index]
  if true == _ContentsGroup_RenewUI_Tooltip then
    _AudioPostEvent_SystemUiForXBOX(50, 0)
    if true == isOn then
      local servantWrapper = getServantInfoFromActorKey(PaGlobal_ShipInfo_All._actorKeyRaw)
      if nil == servantWrapper then
        return
      end
      if slotNo == CppEnums.EquipSlotNoClient.eEquipSlotNoHelm and true == PaGlobal_ShipInfo_All._isBigShip then
        slotNo = CppEnums.EquipSlotNoClient.eEquipSlotNoChest
      end
      local itemWrapper = servantWrapper:getEquipItem(slotNo)
      if nil == itemWrapper then
        return
      end
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0)
      PaGlobalFunc_FloatingTooltip_Close()
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  else
    if true == _ContentsGroup_UsePadSnapping and slotNo == CppEnums.EquipSlotNoClient.eEquipSlotNoHelm and true == PaGlobal_ShipInfo_All._isBigShip then
      slotNo = CppEnums.EquipSlotNoClient.eEquipSlotNoChest
    end
    Panel_Tooltip_Item_SetPosition(slotNo, slot, "ServantShipEquipment")
    Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "ServantShipEquipment", isOn)
  end
end
function HandlerEventMouseOn_ShipInfoAll_EquipItem_Console(slotNo, isOn)
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    return
  end
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  if true == isOn then
    local itemWrapper = getServantInventoryItemBySlotNo(PaGlobal_ShipInfo_All._actorKeyRaw, slotNo)
    if nil == itemWrapper then
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0)
    PaGlobalFunc_FloatingTooltip_Close()
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
end
function HandlerEventRUp_ShipInfoAll_EquipItem(slotNo)
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_ShipInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local itemWrapper = servantWrapper:getEquipItem(slotNo)
  if nil == itemWrapper then
    return
  end
  servant_doUnequip(servantWrapper:getActorKeyRaw(), slotNo)
end
function HandleEventLUp_ShipInfoAll_SelectSailor(index)
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  if false == _ContentsGroup_Sailor then
    return
  end
  local control = PaGlobal_ShipInfo_All._ui
  PaGlobal_ShipInfo_All._currentSailorIndex = index
  local sailorInfo = PaGlobal_ShipInfo_All._sailorList[index]
  if nil == sailorInfo then
    return
  end
  if nil ~= sailorInfo._iconPath and "" ~= sailorInfo._iconPath then
    control.stc_sailor_image:ChangeTextureInfoName(sailorInfo._iconPath)
  end
  if __eEmployeeState_Escape == sailorInfo._state then
    control.txt_sailor_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_ESCAPE"))
  elseif Defines.s64_const.s64_0 ~= sailorInfo._onServantNo then
    local servantInfo = stable_getServantByServantNo(sailorInfo._onServantNo)
    if nil ~= servantInfo then
      if sailorInfo._isApply then
        local string = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EMPLOYEE_RIDE_APPLY", "name", servantInfo:getName())
        control.txt_sailor_State:SetText(string)
      else
        local string = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EMPLOYEE_RIDE_UNAPPLY", "name", servantInfo:getName())
        control.txt_sailor_State:SetText(string)
      end
    else
      control.txt_sailor_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_BOARDING_ANOTHER_SHIP"))
    end
  else
    control.txt_sailor_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_STAY"))
  end
  control.txt_sailor_name:SetText("Lv." .. sailorInfo._level .. " " .. sailorInfo._name)
  control.progress_sailor_exp:SetProgressRate(sailorInfo._expRate)
  control.progress_sailor_loyalty:SetProgressRate(sailorInfo._royalRate)
  control.txt_sailor_speed:SetText(string.format("%.1f", sailorInfo._speed * 1.0E-4) .. "%")
  control.txt_sailor_turning:SetText(string.format("%.1f", sailorInfo._turning * 1.0E-4) .. "%")
  control.txt_sailor_feed:SetText(sailorInfo._foodConsume)
  control.txt_sailor_accel:SetText(string.format("%.1f", sailorInfo._accel * 1.0E-4) .. "%")
  control.txt_sailor_break:SetText(string.format("%.1f", sailorInfo._break * 1.0E-4) .. "%")
  control.txt_sailor_cost:SetText(sailorInfo._cost)
  control.txt_sailor_cannonCoolTimeValue:SetText(string.format("%.1f", sailorInfo._cannonCoolTime * 1.0E-4) .. "%")
  control.txt_sailor_cannonAccuracyValue:SetText(string.format("%.1f", sailorInfo._cannonAccuracy * 1.0E-4) .. "%")
  control.txt_sailor_cannonMaxLengthValue:SetText(string.format("%.1f", sailorInfo._cannonMaxLength * 1.0E-4) .. "%")
  control.txt_sailor_cannonMaxAngleValue:SetText(string.format("%.1f", sailorInfo._cannonMaxAngle * 1.0E-4) .. "%")
  control.txt_currentValue:SetText(string.format("%.1f", sailorInfo._resSeaCurrent) .. "%")
  control.txt_seaWindValue:SetText(string.format("%.1f", sailorInfo._resSeaWind) .. "%")
  control.txt_foodValue:SetText(string.format("%.1f", sailorInfo._resFood) .. "%")
  control.txt_loyaltyValue:SetText(string.format("%.1f", sailorInfo._resLoyalty) .. "%")
  local str_AllWeight = makeWeightString(sailorInfo._bodyWeight, 1)
  local strWeight = str_AllWeight .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT")
  control.txt_bodyWeight:SetText(strWeight)
  control.txt_displayRoyalty:SetText(tostring(sailorInfo._loyalty) .. "/" .. tostring(sailorInfo._maxLoyalty))
end
function HandleEventMOn_ShipInfo_Tooltip_Open(actorKeyRaw, key32)
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  PaGlobal_ShipInfo_All:ShipInfo_Tooltip_Open(actorKeyRaw, key32)
end
function HandleEventMOn_ShipInfoAll_ShipFoodTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local vehicleProxy = getVehicleActor(PaGlobal_ShipInfo_All._actorKeyRaw)
  local strFood
  if nil ~= vehicleProxy then
    local currentMp = getMpToActor(vehicleProxy)
    local maxMp = getMaxMpToActor(vehicleProxy)
    strFood = makeDotMoney(currentMp) .. "/" .. makeDotMoney(maxMp)
  end
  if nil == strFood then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_NAME")
  local desc = strFood
  TooltipSimple_Show(PaGlobal_ShipInfo_All._ui.txt_basic_ShipFood, name, desc)
end
function HandleEventMOn_ShipInfoAll_ShipItemFilterTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SHIPINFO_FOODSUPPLY_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SHIPINFO_FOODSUPPLY_DESC")
  TooltipSimple_Show(PaGlobal_ShipInfo_All._ui.btn_foodEmergency, name, desc)
end
function HandleEventMOn_ShipInfoAll_WeightTooltip(control, isShow)
  local name = ""
  local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPINFO_ALL_WEIGHT_INFO")
  if true == PaGlobal_ShipInfo_All._isConsole then
    if true == Panel_Tooltip_SimpleText:GetShow() then
      TooltipSimple_Hide()
      return
    end
    local pos = {}
    pos.x = control:GetParentPosX()
    pos.y = control:GetParentPosY() - 80
    TooltipSimple_ShowSetSetPos_Console(pos, name, desc)
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_ShipInfoAll_InfoTitleTooltip(isShow, infoType)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control = "", "", nil
  if PaGlobal_ShipInfo_All._infoType.SPEED == infoType then
    control = PaGlobal_ShipInfo_All._ui.txt_sailor_speedTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_SPEED_DESC")
  elseif PaGlobal_ShipInfo_All._infoType.EXCEL == infoType then
    control = PaGlobal_ShipInfo_All._ui.txt_sailor_accelTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_ACCELATION_DESC")
  elseif PaGlobal_ShipInfo_All._infoType.TURNING == infoType then
    control = PaGlobal_ShipInfo_All._ui.txt_sailor_turningTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_CORNERING_DESC")
  elseif PaGlobal_ShipInfo_All._infoType.BRAKE == infoType then
    control = PaGlobal_ShipInfo_All._ui.txt_sailor_breakTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_BRAKING_DESC")
  elseif PaGlobal_ShipInfo_All._infoType.PATIENCE == infoType then
    control = PaGlobal_ShipInfo_All._ui.txt_sailor_cannonCoolTime
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_PATIENCE_DESC")
  elseif PaGlobal_ShipInfo_All._infoType.POWER == infoType then
    control = PaGlobal_ShipInfo_All._ui.txt_sailor_cannonMaxLength
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_POWER_DESC")
  elseif PaGlobal_ShipInfo_All._infoType.FOCUS == infoType then
    control = PaGlobal_ShipInfo_All._ui.txt_sailor_cannonAccuracy
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_FOCUS_DESC")
  elseif PaGlobal_ShipInfo_All._infoType.SIGHT == infoType then
    control = PaGlobal_ShipInfo_All._ui.txt_sailor_cannonMaxAngle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_SIGHT_DESC")
  end
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventMLUp_ShipInfoAll_ShowEquipToggle()
  PaGlobal_ShipInfo_All:showEquipToggle()
end
function HandleEventMLUp_ShipInfoAll_OpenItemFilter(type)
  PaGlobal_ItemFilter_All_Open(PaGlobal_ShipInfo_All._servantNo, PaGlobal_ShipInfo_All._isGuildShip, type)
end
function HandleEventRUp_ShipInfo_All_SlotRClick(slotNo)
  PaGlobal_ShipInfo_All._moveItemToType = CppEnums.MoveItemToType.Type_Ship
  FGlobal_PopupMoveItem_Init(CppEnums.ItemWhereType.eServantInventory, slotNo, CppEnums.MoveItemToType.Type_Ship, PaGlobal_ShipInfo_All._actorKeyRaw, true)
  Panel_Tooltip_Item_hideTooltip()
  local itemWrapper = PaGlobal_ShipInfo_All_GetMoveItem(slotNo)
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
end
function HandleEventLUp_ShipInfoAll_ServantSkillLock(index)
  PaGlobal_ShipInfo_All:updateServantSkillLock(index)
end
function HandleEventDPadLeft_ShipInfoAll_changePadSnapTargetItemSlot()
  ToClient_padSnapChangeToTarget(PaGlobal_ShipInfo_All._invenSlotBG[0])
end
function PaGlobalFunc_ShipInfoAll_CreateSkillList(control, key)
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  local index = Int64toInt32(key)
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_ShipInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local skillWrapper = servantWrapper:getSortedSkillForDisplay(PaGlobal_ShipInfo_All._shipSkillIndex[index])
  if nil == skillWrapper then
    return
  end
  local stc_BG = UI.getChildControl(control, "Static_SkillName")
  local stc_skillBG = UI.getChildControl(stc_BG, "Static_ShipSkillBG")
  local stc_skliIcon = UI.getChildControl(stc_BG, "Static_ShipSkill")
  local chk_skillLockIcon = UI.getChildControl(stc_skliIcon, "CheckButton_SkillLockIcon")
  local txt_skillName = UI.getChildControl(stc_BG, "StaticText_ShipName")
  local txt_skillDesc = UI.getChildControl(stc_BG, "StaticText_ShipCost")
  txt_skillName:SetText(skillWrapper:getName())
  UI.setLimitTextAndAddTooltip(txt_skillName)
  txt_skillDesc:SetText(skillWrapper:getDescription())
  UI.setLimitAutoWrapTextAndAddTooltip(txt_skillDesc, 2)
  stc_skliIcon:ChangeTextureInfoName("Icon/" .. skillWrapper:getIconPath())
  if true == _ContentsGroup_UsePadSnapping then
    stc_BG:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventMOn_ShipInfo_Tooltip_Open(" .. PaGlobal_ShipInfo_All._actorKeyRaw .. ", " .. index .. ")")
    stc_BG:registerPadEvent(__eConsoleUIPadEvent_Up_DpadLeft, "HandleEventDPadLeft_ShipInfoAll_changePadSnapTargetItemSlot()")
  else
    stc_skliIcon:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfo_Tooltip_Open(" .. PaGlobal_ShipInfo_All._actorKeyRaw .. ", " .. index .. ")")
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    stc_skliIcon:addInputEvent("Mouse_Out", "PaGlobal_Tooltip_Skill_Servant_All_Close()")
  else
    stc_skliIcon:addInputEvent("Mouse_Out", "PaGlobal_Tooltip_Servant_Close()")
  end
  stc_skliIcon:SetShow(true)
  stc_skillBG:SetShow(false)
  if true == _ContentsGroup_ServantSkill_Lock and false == servantWrapper:isGuildServant() then
    local skillKey = skillWrapper:getKey()
    local servantType = servantWrapper:getServantType()
    if ToClient_checkCanBlockVehicleSkillCommand(skillKey) then
      chk_skillLockIcon:SetShow(true)
      chk_skillLockIcon:SetCheck(ToClient_isBlockVehicleSkillCommand(skillKey, servantType))
      chk_skillLockIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_ShipInfoAll_ServantSkillLock(" .. index .. ")")
    else
      chk_skillLockIcon:SetShow(false)
    end
  else
    chk_skillLockIcon:SetShow(false)
  end
end
function PaGlobalFunc_ShipInfoAll_CreateSailorList(control, key)
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  if false == _ContentsGroup_Sailor then
    return
  end
  local index = Int64toInt32(key)
  local btn_buttonBG = UI.getChildControl(control, "RadioButton_ButtonBg")
  local stc_sailorImg = UI.getChildControl(control, "Static_SailorImage")
  local progress_exp = UI.getChildControl(control, "Progress2_EXPProgress")
  local txt_name = UI.getChildControl(control, "StaticText_SailorName")
  local txt_Loyalty = UI.getChildControl(control, "StaticText_Loyalty")
  local txt_displayRoyalty = UI.getChildControl(control, "StaticText_LoyaltyValue")
  local progress_royalty = UI.getChildControl(control, "Progress2_RemainTimeProgress")
  local sailorInfo = PaGlobal_ShipInfo_All._sailorList[index]
  if __eEmployeeState_Escape == sailorInfo._state then
    btn_buttonBG:SetColor(Defines.Color.C_FFF03838)
    txt_Loyalty:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_ESCAPE"))
    txt_Loyalty:SetShow(true)
  else
    btn_buttonBG:SetColor(Defines.Color.C_FFFFFFFF)
    if Defines.s64_const.s64_0 ~= sailorInfo._onServantNo then
      local servantInfo = stable_getServantByServantNo(sailorInfo._onServantNo)
      if nil ~= servantInfo then
        if sailorInfo._isApply then
          local string = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EMPLOYEE_RIDE_APPLY", "name", servantInfo:getName())
          txt_Loyalty:SetText(string)
          UI.setLimitTextAndAddTooltip(txt_Loyalty, "", txt_Loyalty:GetText())
          txt_Loyalty:SetShow(true)
        else
          local string = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EMPLOYEE_RIDE_UNAPPLY", "name", servantInfo:getName())
          txt_Loyalty:SetText(string)
          UI.setLimitTextAndAddTooltip(txt_Loyalty, "", txt_Loyalty:GetText())
          txt_Loyalty:SetShow(true)
        end
      else
        txt_Loyalty:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_BOARDING_ANOTHER_SHIP"))
        UI.setLimitTextAndAddTooltip(txt_Loyalty, "", txt_Loyalty:GetText())
        txt_Loyalty:SetShow(true)
      end
    else
      txt_Loyalty:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_STAY"))
      UI.setLimitTextAndAddTooltip(txt_Loyalty, "", txt_Loyalty:GetText())
      txt_Loyalty:SetShow(true)
    end
  end
  if nil ~= sailorInfo._iconPath and "" ~= sailorInfo._iconPath then
    stc_sailorImg:ChangeTextureInfoName(sailorInfo._iconPath)
  end
  progress_exp:SetProgressRate(sailorInfo._expRate)
  progress_royalty:SetProgressRate(sailorInfo._royalRate)
  txt_name:SetText("Lv." .. sailorInfo._level .. " " .. sailorInfo._name)
  btn_buttonBG:setNotImpactScrollEvent(true)
  btn_buttonBG:SetCheck(index == PaGlobal_ShipInfo_All._currentSailorIndex)
  btn_buttonBG:addInputEvent("Mouse_LUp", "HandleEventLUp_ShipInfoAll_SelectSailor(" .. index .. ")")
  txt_displayRoyalty:SetText(tostring(sailorInfo._loyalty) .. "/" .. tostring(sailorInfo._maxLoyalty))
end
function PaGlobal_ShipInfo_All_Inventory_SetFunctor(slotNo, itemWrapper, s64_count, inventoryType)
  PaGlobal_ShipInfo_All:inventory_SetFunctor(slotNo, itemWrapper, s64_count, inventoryType)
end
function PaGlobal_ShipInfo_All_Close()
  PaGlobal_ShipInfo_All:prepareClose()
end
function PaGlobal_ShipInfo_All_GetMoveItem(slotNo)
  if PaGlobal_ShipInfo_All._moveItemToType == CppEnums.MoveItemToType.Type_NewShip then
    return getServantInventoryItemBySlotNo(PaGlobal_ShipInfo_All._actorKeyRaw, slotNo)
  elseif PaGlobal_ShipInfo_All._inventoryType == nil then
    return nil
  else
    return getInventoryItemByType(PaGlobal_ShipInfo_All._inventoryType, slotNo)
  end
  return nil
end
function PaGlobal_ShipInfo_All_PopToSomewhere(s64_count, slotNo)
  if s64_count > toInt64(0, 1) then
    Panel_NumberPad_Show(true, s64_count, slotNo, PaGlobal_ShipInfo_All_requestPopToInventory)
  else
    PaGlobal_ShipInfo_All_requestPopToInventory(s64_count, slotNo)
  end
end
function PaGlobal_ShipInfo_All_requestPopToInventory(s64_count, slotNo)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfActorKeyRaw = selfPlayer:getActorKey()
  if PaGlobal_ShipInfo_All._moveItemToType == CppEnums.MoveItemToType.Type_NewShip then
    moveInventoryItemFromActorToActor(PaGlobal_ShipInfo_All._actorKeyRaw, selfActorKeyRaw, CppEnums.ItemWhereType.eServantInventory, slotNo, s64_count)
  else
    if PaGlobal_ShipInfo_All._inventoryType == nil then
      return
    end
    moveInventoryItemFromActorToActor(selfActorKeyRaw, PaGlobal_ShipInfo_All._actorKeyRaw, PaGlobal_ShipInfo_All._inventoryType, slotNo, s64_count)
  end
end
function FromClient_ShipInfo_ChangeEquipItem(slotNo)
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  if true == Panel_Window_ShipInfo_All:GetShow() then
    Panel_Tooltip_Item_hideTooltip()
    PaGlobal_ShipInfo_All:basic_Update()
  end
end
function FromClient_ShipInfo_UpdateItem()
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  if true == Panel_Window_ShipInfo_All:GetShow() then
    PaGlobal_ShipInfo_All:basic_invenUpdate()
  end
end
function FromClient_ShipInfo_UpdateCannonStat()
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  if true == Panel_Window_ShipInfo_All:GetShow() then
    PaGlobal_ShipInfo_All:basic_Update()
  end
end
function FromClient_ShipInfo_UpdateFoodStat()
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  if true == Panel_Window_ShipInfo_All:GetShow() then
    PaGlobal_ShipInfo_All:basic_Update()
  end
end
function PaGlobal_ShipInfo_All_isShowSailorInfo()
  if false == _ContentsGroup_Sailor then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_ShipInfo_All._actorKeyRaw)
  local characterKey = servantWrapper:getCharacterKeyRaw()
  local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
  local isShowSailorInfo = nil ~= shipStaticStatus and 0 < shipStaticStatus:getEmployeeMaxCost() and 0 < ToClient_getEmployeeCount()
  if false == isShowSailorInfo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_EMPTYEMPLOYEELIST"))
    PaGlobal_ShipInfo_All._ui.radio_basicInfo:SetCheck(true)
    PaGlobal_ShipInfo_All._ui.radio_sailorInfo:SetCheck(false)
    return false
  end
  return true
end
function PaGlobal_ShipInfo_All_GetShowPanel()
  if nil == Panel_Window_ShipInfo_All then
    return false
  end
  return Panel_Window_ShipInfo_All:GetShow()
end
