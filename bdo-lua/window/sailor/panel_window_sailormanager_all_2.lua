function PaGlobalFunc_SailorManagerAll_CreateListControl(control, key)
  if nil == Panel_Window_SailorManager_All then
    return
  end
  PaGlobal_SailorManager_All:listCreate(control, key)
end
function HandleEventLUp_SailorManagerAll_SelectSailor(index)
  if nil == Panel_Window_SailorManager_All then
    return
  end
  if true == PaGlobal_SailorManager_All._ui.stc_restoreItemBG:GetShow() then
    PaGlobal_SailorManager_All._ui.stc_restoreItemBG:SetShow(false)
  end
  local control = PaGlobal_SailorManager_All._ui
  PaGlobal_SailorManager_All._currentSailorIndex = index
  local sailorInfo = PaGlobal_SailorManager_All._sailorInfoList[index]
  if nil == sailorInfo then
    return
  end
  if nil ~= sailorInfo._iconPath and "" ~= sailorInfo._iconPath then
    control.stc_workerImage:ChangeTextureInfoName(sailorInfo._iconPath)
  end
  local isRide = false
  if __eEmployeeState_Escape == sailorInfo._state then
    control.txt_sailorState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_ESCAPE"))
  elseif Defines.s64_const.s64_0 ~= sailorInfo._onServantNo then
    local servantInfo = stable_getServantByServantNo(sailorInfo._onServantNo)
    if nil ~= servantInfo then
      if sailorInfo._isApply then
        local string = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EMPLOYEE_RIDE_APPLY", "name", servantInfo:getName())
        control.txt_sailorState:SetText(string)
      else
        local string = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EMPLOYEE_RIDE_UNAPPLY", "name", servantInfo:getName())
        control.txt_sailorState:SetText(string)
      end
    else
      control.txt_sailorState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_BOARDING_ANOTHER_SHIP"))
    end
    isRide = true
  else
    control.txt_sailorState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_STAY"))
    isRide = false
  end
  control.txt_workerTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_LEVEL") .. sailorInfo._level .. " " .. sailorInfo._name)
  control.progress_exp:SetProgressRate(sailorInfo._expRate)
  control.progress_loyalty:SetProgressRate(sailorInfo._royalRate)
  control.txt_speedValue:SetText(string.format("%.1f", sailorInfo._speed * 1.0E-4) .. "%")
  control.txt_turningValue:SetText(string.format("%.1f", sailorInfo._turning * 1.0E-4) .. "%")
  control.txt_feedValue:SetText(sailorInfo._foodConsume)
  control.txt_excelValue:SetText(string.format("%.1f", sailorInfo._accel * 1.0E-4) .. "%")
  control.txt_breakValue:SetText(string.format("%.1f", sailorInfo._break * 1.0E-4) .. "%")
  control.txt_costValue:SetText(sailorInfo._cost)
  control.txt_cannonCoolTime:SetText(string.format("%.1f", sailorInfo._cannonCoolTime * 1.0E-4) .. "%")
  control.txt_cannonAccuracy:SetText(string.format("%.1f", sailorInfo._cannonAccuracy * 1.0E-4) .. "%")
  control.txt_cannonMaxLength:SetText(string.format("%.1f", sailorInfo._cannonMaxLength * 1.0E-4) .. "%")
  control.txt_cannonMaxAngle:SetText(string.format("%.1f", sailorInfo._cannonMaxAngle * 1.0E-4) .. "%")
  control.txt_currentValue:SetText(string.format("%.1f", sailorInfo._resSeaCurrent) .. "%")
  control.txt_seaWindValue:SetText(string.format("%.1f", sailorInfo._resSeaWind) .. "%")
  control.txt_foodValue:SetText(string.format("%.1f", sailorInfo._resFood) .. "%")
  control.txt_loyaltyValue:SetText(string.format("%.1f", sailorInfo._resLoyalty) .. "%")
  local str_AllWeight = makeWeightString(sailorInfo._bodyWeight, 1)
  local strWeight = str_AllWeight .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT")
  control.txt_bodyWeight:SetText(strWeight)
  control.txt_displayRoyalty:SetText(tostring(sailorInfo._loyalty) .. "/" .. tostring(sailorInfo._maxLoyalty))
  PaGlobalFunc_SailorOnBoardAll_AddStatforShip(sailorInfo)
  if __eEmployeeState_Escape == sailorInfo._state then
    PaGlobal_SailorManager_All._ui.btn_ride_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EMPLOYEE_SHIP_RIDE"))
    PaGlobal_SailorManager_All._ui.btn_ride_PC:SetIgnore(true)
    PaGlobal_SailorManager_All._ui.btn_ride_PC:SetMonoTone(true)
    PaGlobal_SailorManager_All._ui.btn_ride_PC:addInputEvent("Mouse_LUp", "")
  else
    PaGlobal_SailorManager_All._ui.btn_ride_PC:SetMonoTone(false)
    PaGlobal_SailorManager_All._ui.btn_ride_PC:SetIgnore(false)
    if true == isRide then
      PaGlobal_SailorManager_All._ui.btn_ride_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EMPLOYEE_SHIP_DROP"))
      PaGlobal_SailorManager_All._ui.btn_ride_PC:addInputEvent("Mouse_LUp", "HandlerEventLUp_SailorManager_All_Ride()")
    else
      PaGlobal_SailorManager_All._ui.btn_ride_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EMPLOYEE_SHIP_RIDE"))
      PaGlobal_SailorManager_All._ui.btn_ride_PC:addInputEvent("Mouse_LUp", "HandlerEventLUp_SailorManager_All_Ride()")
    end
  end
end
function HandleEventLUp_SailorManagerAll_SelectSailorText(index)
  PaGlobal_SailorManager_All._currentSailorIndex = index
  for i = 1, PaGlobal_SailorManager_All._sailorCount do
    local control = PaGlobal_SailorManager_All._ui.list_sailorList:GetContentByKey(i)
    if nil ~= control then
      local btn_buttonBG = UI.getChildControl(control, "RadioButton_ButtonBg")
      btn_buttonBG:SetCheck(false)
      if index == i then
        btn_buttonBG:SetCheck(true)
      end
    end
  end
  HandleEventLUp_SailorManagerAll_RefreshSailor()
end
function HandleEventOnOut_SailorManagerAll_InfoTitleTooltip(isShow, infoType)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control = "", "", nil
  if PaGlobal_SailorManager_All._infoType.SPEED == infoType then
    control = PaGlobal_SailorManager_All._ui.txt_speedTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_SPEED_DESC")
  elseif PaGlobal_SailorManager_All._infoType.EXCEL == infoType then
    control = PaGlobal_SailorManager_All._ui.txt_excelTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_ACCELATION_DESC")
  elseif PaGlobal_SailorManager_All._infoType.TURNING == infoType then
    control = PaGlobal_SailorManager_All._ui.txt_turningTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_CORNERING_DESC")
  elseif PaGlobal_SailorManager_All._infoType.BRAKE == infoType then
    control = PaGlobal_SailorManager_All._ui.txt_breakTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_BRAKING_DESC")
  elseif PaGlobal_SailorManager_All._infoType.PATIENCE == infoType then
    control = PaGlobal_SailorManager_All._ui.txt_patienceTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_PATIENCE_DESC")
  elseif PaGlobal_SailorManager_All._infoType.POWER == infoType then
    control = PaGlobal_SailorManager_All._ui.txt_powerTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_POWER_DESC")
  elseif PaGlobal_SailorManager_All._infoType.FOCUS == infoType then
    control = PaGlobal_SailorManager_All._ui.txt_focusTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_FOCUS_DESC")
  elseif PaGlobal_SailorManager_All._infoType.SIGHT == infoType then
    control = PaGlobal_SailorManager_All._ui.txt_sightTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_SIGHT_DESC")
  end
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_SailorManagerAll_RefreshSailor()
  HandleEventLUp_SailorManagerAll_SelectSailor(PaGlobal_SailorManager_All._currentSailorIndex)
end
function HandleEventLUp_SailorManagerAll_FireSailor()
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_FIRE_ALTER_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_FIRE_ALTER_CONTENT"),
    functionYes = SailorManagerAll_FireSailor,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function SailorManagerAll_FireSailor()
  if nil == Panel_Window_SailorManager_All then
    return
  end
  local sailorWrapper = ToClient_getEmployeeWrapperByIndex(PaGlobal_SailorManager_All._currentSailorIndex - 1)
  if nil == sailorWrapper then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOSELECT_EMPLOYEE_FOR_DISMISSAL"))
  else
    ToClient_requestDeleteEmployee(sailorWrapper:getEmployeeNo())
    PaGlobal_SailorManager_All:sailorUpdate(true)
  end
end
function HandleEventLUp_SailorManagementAll_SailorRestore(sailorIndex, loyalismType)
  if nil == Panel_Window_SailorManager_All then
    return
  end
  local listControl = PaGlobal_SailorManager_All._ui.list_sailorList:GetContentByKey(sailorIndex)
  local btn_restore = UI.getChildControl(listControl, "Button_Restore_PCUI")
  if nil == btn_restore then
    return
  end
  PaGlobal_SailorManager_All:slotClear()
  local recoveryItemSize = ToClient_getRecoveryItemCount()
  local isExistItem = false
  for index = 1, recoveryItemSize do
    local recoveryItem = ToClient_GetRecoveryItemByIndex(index - 1, loyalismType)
    if nil ~= recoveryItem then
      isExistItem = true
    end
  end
  if false == isExistItem and __eEmployeeLoyalismType_Loyalty == loyalismType then
    Proc_ShowMessage_Ack_With_ChatType(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_NORECOVERYITEM"), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
    return
  elseif false == isExistItem and __eEmployeeLoyalismType_resurrection == loyalismType then
    Proc_ShowMessage_Ack_With_ChatType(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_NORESURRECTIONITEM"), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
    return
  end
  local restoreItemList = PaGlobal_SailorManager_All._ui.stc_restoreList
  local realIndex = 1
  for index = 1, recoveryItemSize do
    local recoveryItem = ToClient_GetRecoveryItemByIndex(index - 1, loyalismType)
    if nil ~= recoveryItem then
      local restoreSlot = restoreItemList[realIndex]
      if nil == restoreSlot then
        _PA_SVC_LOG("\236\138\172\235\161\175\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164. \236\132\160\236\155\144 \236\182\169\236\132\177\235\143\132 \237\154\140\235\179\181 UI\234\176\128 \236\188\156\236\167\128\236\167\128 \236\149\138\236\157\132\234\178\129\235\139\136\235\139\164.")
        return
      end
      local recoveryItemKey = recoveryItem:get():getKey():getItemKey()
      local recoveryItemCount = recoveryItem:get():getCount_s64()
      local itemStatic = recoveryItem:getStaticStatus()
      if nil == itemStatic then
        _PA_SVC_LOG("itemStatic \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164. \236\132\160\236\155\144 \236\182\169\236\132\177\235\143\132 \237\154\140\235\179\181 UI\234\176\128 \236\188\156\236\167\128\236\167\128 \236\149\138\236\157\132\234\178\129\235\139\136\235\139\164.")
        return
      end
      restoreSlot.slotIcon:ChangeTextureInfoName("icon/" .. itemStatic:getIconPath())
      restoreSlot.itemCount:SetText(tostring(recoveryItemCount))
      restoreSlot.restorePoint:SetText("+" .. tostring(ToClient_getRecoveryValue(loyalismType, recoveryItemKey)))
      restoreSlot.slotBG:SetShow(true)
      restoreSlot.restorePoint:SetShow(loyalismType == __eEmployeeLoyalismType_Loyalty)
      restoreSlot.slotIcon:addInputEvent("Mouse_RUp", "HandlerEventRUp_SailorManagementAll_requestRecoveryEmployee(" .. sailorIndex .. "," .. index - 1 .. ", " .. loyalismType .. ")")
      realIndex = realIndex + 1
    end
  end
  PaGlobal_SailorManager_All._ui.stc_restoreItemBG:SetShow(true)
  local windowPosX = btn_restore:GetParentPosX() + btn_restore:GetSizeX() - Panel_Window_SailorManager_All:GetPosX()
  local windowPosY = btn_restore:GetParentPosY() - Panel_Window_SailorManager_All:GetPosY()
  PaGlobal_SailorManager_All._ui.stc_restoreItemBG:SetPosXY(windowPosX, windowPosY)
end
function HandleEventLUp_SailorManagementAll_SailorRestoreClose()
  if nil == Panel_Window_SailorManager_All then
    return
  end
  PaGlobal_SailorManager_All._ui.stc_restoreItemBG:SetShow(false)
end
function HandlerEventRUp_SailorManagementAll_requestRecoveryEmployee(sailorIndex, itemIndex, restoreValue)
  if nil == Panel_Window_SailorManager_All then
    return
  end
  local sailorInfo = PaGlobal_SailorManager_All._sailorInfoList[sailorIndex]
  if nil ~= sailorInfo then
    if true == isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
      ToClient_requestRecoveryEmployee(sailorInfo._sailorNo, itemIndex, restoreValue, true)
    else
      ToClient_requestRecoveryEmployee(sailorInfo._sailorNo, itemIndex, restoreValue, false)
    end
  end
end
function FromClient_SailorManagerAll_ServantInfoUpdate()
  if nil == Panel_Window_SailorManager_All or nil == Panel_Window_Sailor_Onboard_All then
    return
  end
end
function FromClient_SailorManagerAll_EmployeeUpdateAck()
  if nil == Panel_Window_SailorManager_All or nil == Panel_Window_Sailor_Onboard_All then
    return
  end
  PaGlobal_SailorManager_All:sailorUpdate(true)
  PaGlobal_SailorOnBoard_All:update()
  local sailorInfo = PaGlobal_SailorManager_All._sailorInfoList[PaGlobal_SailorManager_All._currentSailorIndex]
  PaGlobalFunc_SailorOnBoardAll_AddStatforShip(sailorInfo)
  HandleEventLUp_SailorManagerAll_RefreshSailor()
  if nil ~= Panel_Window_SailorRestore_All and true == Panel_Window_SailorRestore_All:GetShow() then
    PaGlobal_SailorRestore_All:restoringUpdate()
  end
end
function PaGlobal_SailorManager_All_CloseForce()
  PaGlobal_SailorManager_All:prepareCloseForce()
end
function HandlerEventLUp_SailorManager_All_Ride()
  if nil == Panel_Window_Sailor_Onboard_All then
    return
  end
  if false == Panel_Window_Sailor_Onboard_All:GetShow() then
    PaGlobal_SailorOnBoard_All:prepareOpen()
  end
  local sailorInfo = PaGlobal_SailorManager_All._sailorInfoList[PaGlobal_SailorManager_All._currentSailorIndex]
  local unsealServantInfo = PaGlobal_SailorOnBoard_All._unsealServantInfo
  if nil == unsealServantInfo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOSELECT_SHIP_ON_BOARD_EMPLOYEE"))
  elseif nil == sailorInfo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOSELECT_EMPLOYEE_ON_BOARD_SHIP"))
  else
    local servantInfo = stable_getServantByServantNo(sailorInfo._onServantNo)
    if nil ~= servantInfo then
      if unsealServantInfo:getServantNo() ~= sailorInfo._onServantNo then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_ISAPPLYDEFFERENTSHIP"))
      else
        ToClient_requestUnApplyEmployee(sailorInfo._sailorNo)
      end
    else
      ToClient_requestApplyEmployee(sailorInfo._sailorNo, unsealServantInfo:getServantNo())
    end
  end
end
function FromClient_SailorManagerAll_Resize()
  PaGlobal_SailorManager_All:resize()
end
function HandlerEventLUp_SailorManager_All_OpenByESCMenu()
  if true == Panel_Window_SailorManager_All:GetShow() then
    return
  end
  PaGlobal_SailorManager_All._isOpenByESCMenu = true
  PaGlobal_SailorManager_All:prepareOpen()
end
