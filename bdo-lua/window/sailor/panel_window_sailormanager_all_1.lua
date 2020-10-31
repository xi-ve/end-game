function PaGlobal_SailorManager_All:initialize()
  if true == PaGlobal_SailorManager_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_titleBG = UI.getChildControl(Panel_Window_SailorManager_All, "Static_TitleBg")
  self._ui.btn_close_PC = UI.getChildControl(self._ui.stc_titleBG, "Button_Win_Close_PCUI")
  self._ui.list_sailorList = UI.getChildControl(Panel_Window_SailorManager_All, "List2_SailorList")
  self._ui.stc_sailorInfoBG = UI.getChildControl(Panel_Window_SailorManager_All, "Static_SailorInformation")
  self._ui.stc_sailorBG = UI.getChildControl(self._ui.stc_sailorInfoBG, "Static_SailorBg")
  self._ui.stc_workerImage = UI.getChildControl(self._ui.stc_sailorBG, "Static_WorkerImage")
  self._ui.txt_workerTitle = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_WorkerTitle")
  self._ui.txt_sailorState = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_SailorState")
  self._ui.progress_exp = UI.getChildControl(self._ui.stc_sailorInfoBG, "Progress2_EXPProgress")
  self._ui.progress_loyalty = UI.getChildControl(self._ui.stc_sailorInfoBG, "Progress2_LoyaltyProgress")
  self._ui.txt_speedTitle = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_SpeedTitle")
  self._ui.txt_excelTitle = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_ExcelTitle")
  self._ui.txt_turningTitle = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_TurningTitle")
  self._ui.txt_breakTitle = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_BreakTitle")
  self._ui.txt_patienceTitle = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_PatienceTitle")
  self._ui.txt_powerTitle = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_PowerTitle")
  self._ui.txt_focusTitle = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_FocusTitle")
  self._ui.txt_sightTitle = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_SightTitle")
  self._ui.txt_speedValue = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_SpeedValue")
  self._ui.txt_turningValue = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_TurningValue")
  self._ui.txt_feedValue = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_FeedValue")
  self._ui.txt_excelValue = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_ExcelValue")
  self._ui.txt_breakValue = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_BreakValue")
  self._ui.txt_costValue = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_CostValue")
  self._ui.txt_cannonCoolTimeTitle = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_PatienceTitle")
  self._ui.txt_cannonCoolTime = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_PatienceValue")
  self._ui.txt_cannonAccuracyTitle = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_FocusTitle")
  self._ui.txt_cannonAccuracy = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_FocusValue")
  self._ui.txt_cannonMaxLengthTitle = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_PowerTitle")
  self._ui.txt_cannonMaxLength = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_PowerValue")
  self._ui.txt_cannonMaxAngleTitle = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_SightTitle")
  self._ui.txt_cannonMaxAngle = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_SightValue")
  self._ui.txt_currentValue = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_CurrentValue")
  self._ui.txt_seaWindValue = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_SeaWindValue")
  self._ui.txt_foodValue = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_FoodValue")
  self._ui.txt_loyaltyValue = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_LoyaltyValue")
  self._ui.txt_bodyWeight = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_BodyWeightValue")
  self._ui.txt_displayRoyalty = UI.getChildControl(self._ui.stc_sailorInfoBG, "StaticText_RoyaltyValue")
  self._ui.txt_guideBox = UI.getChildControl(Panel_Window_SailorManager_All, "StaticText_GuideBox")
  self._ui.txt_slotValue = UI.getChildControl(Panel_Window_SailorManager_All, "StaticText_SailorSlotCount")
  self._ui.stc_bottomBG_Console = UI.getChildControl(Panel_Window_SailorManager_All, "Static_BottomBg_ConsoleUI")
  self._ui.btn_WorkerFire_PC = UI.getChildControl(Panel_Window_SailorManager_All, "Button_doSailorFire_PCUI")
  self._ui.btn_restoreAll_PC = UI.getChildControl(Panel_Window_SailorManager_All, "Button_Restore_All_PCUI")
  self._ui.btn_ride_PC = UI.getChildControl(Panel_Window_SailorManager_All, "Button_Ride_PCUI")
  self._ui.stc_restoreList = {}
  self._ui.stc_restoreItemBG = UI.getChildControl(Panel_Window_SailorManager_All, "Static_Restore_Item_BG")
  self._ui.stc_restoreItemIconBG = UI.getChildControl(self._ui.stc_restoreItemBG, "Static_Restore_Item_Icon_BG")
  self._ui.stc_restoreItemIcon = UI.getChildControl(self._ui.stc_restoreItemIconBG, "Static_Restore_Item_Icon")
  self._ui.txt_restoreValue = UI.getChildControl(self._ui.stc_restoreItemIconBG, "StaticText_Item_Restore_Value")
  self._ui.slider_restoreItem = UI.getChildControl(self._ui.stc_restoreItemBG, "Slider_Restore_Item")
  self._ui.txt_restoreItemGuideAll = UI.getChildControl(self._ui.stc_restoreItemBG, "StaticText_Guide_RestoreAll")
  self._ui.txt_restoreItemGuide = UI.getChildControl(self._ui.stc_restoreItemBG, "StaticText_Guide_Restore")
  self._ui.btn_closeResotreItem = UI.getChildControl(self._ui.stc_restoreItemBG, "Button_Close_Item")
  local origin_guideTextY = self._ui.txt_restoreItemGuideAll:GetSizeY()
  self._ui.txt_restoreItemGuideAll:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_restoreItemGuideAll:SetText(self._ui.txt_restoreItemGuideAll:GetText())
  local add_guideTextY = 0
  if origin_guideTextY < self._ui.txt_restoreItemGuideAll:GetTextSizeY() then
    add_guideTextY = self._ui.txt_restoreItemGuideAll:GetTextSizeY() - origin_guideTextY
    self._ui.stc_restoreItemIconBG:SetPosY(self._ui.stc_restoreItemIconBG:GetPosY() + add_guideTextY)
    self._ui.stc_restoreItemBG:SetSize(self._ui.stc_restoreItemBG:GetSizeX(), self._ui.stc_restoreItemBG:GetSizeY() + add_guideTextY)
  end
  for index = 1, self._maxRestoreSlot do
    local tempItemSlot = {}
    tempItemSlot.slotBG = UI.createAndCopyBasePropertyControl(self._ui.stc_restoreItemBG, "Static_Restore_Item_Icon_BG", self._ui.stc_restoreItemBG, "Static_Restore_Item_Icon_BG_" .. index)
    tempItemSlot.slotIcon = UI.createAndCopyBasePropertyControl(self._ui.stc_restoreItemIconBG, "Static_Restore_Item_Icon", tempItemSlot.slotBG, "Static_Restore_Item_Icon_" .. index)
    tempItemSlot.itemCount = UI.createAndCopyBasePropertyControl(self._ui.stc_restoreItemIconBG, "StaticText_Restore_Count", tempItemSlot.slotBG, "StaticText_Item_Count_" .. index)
    tempItemSlot.restorePoint = UI.createAndCopyBasePropertyControl(self._ui.stc_restoreItemIconBG, "StaticText_Item_Restore_Value", tempItemSlot.slotBG, "StaticText_Item_Restore_Value_" .. index)
    tempItemSlot.slotBG:SetPosX(2 + tempItemSlot.slotBG:GetSizeX() * (index - 1))
    tempItemSlot.slotBG:SetPosY(tempItemSlot.slotBG:GetPosY() + add_guideTextY + 5)
    tempItemSlot.slotBG:SetShow(false)
    self._ui.stc_restoreList[index] = tempItemSlot
  end
  self._ui.btn_close_PC:SetShow(not self._isConsole)
  self._ui.btn_restoreAll_PC:SetShow(not self._isConsole)
  self._ui.btn_ride_PC:SetShow(not self._isConsole)
  self._ui.stc_bottomBG_Console:SetShow(self._isConsole)
  if self._ui.btn_WorkerFire_PC:GetSizeX() < self._ui.btn_WorkerFire_PC:GetTextSizeX() then
    self._ui.btn_WorkerFire_PC:SetTextMode(__eTextMode_AutoWrap)
    self._ui.btn_WorkerFire_PC:SetText(self._ui.btn_WorkerFire_PC:GetText())
    if self._ui.btn_WorkerFire_PC:GetSizeY() < self._ui.btn_WorkerFire_PC:GetTextSizeY() then
      UI.setLimitTextAndAddTooltip(self._ui.btn_WorkerFire_PC)
    end
  end
  self._ui.txt_restoreItemGuide:SetShow(false)
  self._ui.stc_restoreItemBG:SetShow(false)
  self._ui.stc_restoreItemIconBG:SetShow(false)
  self._ui.slider_restoreItem:SetShow(false)
  self._initPosX = Panel_Window_SailorManager_All:GetPosX()
  self._initPosY = Panel_Window_SailorManager_All:GetPosY()
  self._originGuideSize = self._ui.txt_guideBox:GetSizeY()
  PaGlobal_SailorManager_All:setGuideText()
  PaGlobal_SailorManager_All:registerEventHandler()
  PaGlobal_SailorManager_All:validate()
  PaGlobal_SailorManager_All._initialize = true
end
function PaGlobal_SailorManager_All:setGuideText()
  self._ui.txt_guideBox:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_guideBox:SetText(self._ui.txt_guideBox:GetText())
  self._ui.txt_guideBox:SetSize(self._ui.txt_guideBox:GetSizeX(), self._ui.txt_guideBox:GetTextSizeY() + 14)
  local gap = self._ui.txt_guideBox:GetSizeY() - self._originGuideSize
  Panel_Window_SailorManager_All:SetSize(Panel_Window_SailorManager_All:GetSizeX(), Panel_Window_SailorManager_All:GetSizeY() + gap)
  self._ui.txt_guideBox:ComputePos()
  self._ui.btn_WorkerFire_PC:ComputePos()
  self._ui.btn_restoreAll_PC:ComputePos()
  self._ui.btn_ride_PC:ComputePos()
end
function PaGlobal_SailorManager_All:registerEventHandler()
  if nil == Panel_Window_SailorManager_All then
    return
  end
  local sailorInfoTitleList = {
    [self._infoType.SPEED] = self._ui.txt_speedTitle,
    [self._infoType.EXCEL] = self._ui.txt_excelTitle,
    [self._infoType.TURNING] = self._ui.txt_turningTitle,
    [self._infoType.BRAKE] = self._ui.txt_breakTitle,
    [self._infoType.PATIENCE] = self._ui.txt_patienceTitle,
    [self._infoType.POWER] = self._ui.txt_powerTitle,
    [self._infoType.FOCUS] = self._ui.txt_focusTitle,
    [self._infoType.SIGHT] = self._ui.txt_sightTitle
  }
  for index, control in ipairs(sailorInfoTitleList) do
    control:SetIgnore(false)
    control:SetEnable(true)
    control:addInputEvent("Mouse_On", "HandleEventOnOut_SailorManagerAll_InfoTitleTooltip(true, " .. index .. ")")
    control:addInputEvent("Mouse_Out", "HandleEventOnOut_SailorManagerAll_InfoTitleTooltip(false, " .. index .. ")")
    if control:GetSizeX() < control:GetTextSizeX() then
      control:SetEnableArea(0, 0, control:GetTextSizeX(), control:GetSizeY())
    end
  end
  self._ui.btn_close_PC:addInputEvent("Mouse_LUp", "PaGlobal_SailorManager_All:prepareCloseForce()")
  self._ui.btn_WorkerFire_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_SailorManagerAll_FireSailor()")
  self._ui.btn_restoreAll_PC:addInputEvent("Mouse_LUp", "PaGlobal_SailorRestore_All:prepareOpen()")
  self._ui.btn_ride_PC:addInputEvent("Mouse_LUp", "PaGlobal_SailorOnBoard_All:prepareOpen()")
  self._ui.btn_closeResotreItem:addInputEvent("Mouse_LUp", "HandleEventLUp_SailorManagementAll_SailorRestoreClose()")
  self._ui.list_sailorList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_SailorManagerAll_CreateListControl")
  self._ui.list_sailorList:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_EmployeeDeleteAck", "FromClient_SailorManagerAll_EmployeeUpdateAck()")
  registerEvent("FromClient_EmployeeUpdateAck", "FromClient_SailorManagerAll_EmployeeUpdateAck()")
  registerEvent("onScreenResize", "FromClient_SailorManagerAll_Resize")
  registerEvent("FromClient_EmployeeVarySlotAck", "FromClient_EmployeeVarySlotAck")
end
function PaGlobal_SailorManager_All:listCreate(control, key)
  if nil == Panel_Window_SailorManager_All then
    return
  end
  local index = Int64toInt32(key)
  local btn_buttonBG = UI.getChildControl(control, "RadioButton_ButtonBg")
  local stc_sailorImg = UI.getChildControl(control, "Static_SailorImage")
  local progress_exp = UI.getChildControl(control, "Progress2_EXPProgress")
  local txt_name = UI.getChildControl(control, "StaticText_SailorName")
  local txt_state1 = UI.getChildControl(control, "StaticText_SailorState1")
  local txt_state2 = UI.getChildControl(control, "StaticText_SailorState2")
  local progress_royalty = UI.getChildControl(control, "Progress2_RemainTimeProgress")
  local btn_restore = UI.getChildControl(control, "Button_Restore_PCUI")
  local txt_displayRoyalty = UI.getChildControl(control, "StaticText_RoyaltyValue")
  local sailorInfo = self._sailorInfoList[index]
  local isEscape = false
  if __eEmployeeState_Escape == sailorInfo._state then
    btn_buttonBG:SetColor(Defines.Color.C_FFF03838)
    txt_state1:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_ESCAPE"))
    txt_state1:SetShow(true)
    isEscape = true
  else
    btn_buttonBG:SetColor(Defines.Color.C_FFFFFFFF)
    isEscape = false
    if Defines.s64_const.s64_0 ~= sailorInfo._onServantNo then
      local servantInfo = stable_getServantByServantNo(sailorInfo._onServantNo)
      if nil ~= servantInfo then
        if sailorInfo._isApply then
          local string = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EMPLOYEE_RIDE_APPLY", "name", servantInfo:getName())
          txt_state1:SetText(string)
          UI.setLimitTextAndAddTooltip(txt_state1, "", txt_state1:GetText())
          txt_state1:SetShow(true)
        else
          local string = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EMPLOYEE_RIDE_UNAPPLY", "name", servantInfo:getName())
          txt_state1:SetText(string)
          UI.setLimitTextAndAddTooltip(txt_state1, "", txt_state1:GetText())
          txt_state1:SetShow(true)
        end
      else
        txt_state1:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_BOARDING_ANOTHER_SHIP"))
        UI.setLimitTextAndAddTooltip(txt_state1, "", txt_state1:GetText())
        txt_state1:SetShow(true)
      end
    else
      txt_state1:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_STAY"))
      UI.setLimitTextAndAddTooltip(txt_state1, "", txt_state1:GetText())
      txt_state1:SetShow(true)
    end
  end
  if nil ~= sailorInfo._iconPath and "" ~= sailorInfo._iconPath then
    stc_sailorImg:ChangeTextureInfoName(sailorInfo._iconPath)
  end
  progress_exp:SetProgressRate(sailorInfo._expRate)
  progress_royalty:SetProgressRate(sailorInfo._royalRate)
  txt_name:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_LEVEL") .. sailorInfo._level .. " " .. sailorInfo._name)
  txt_state2:SetShow(false)
  btn_buttonBG:setNotImpactScrollEvent(true)
  btn_buttonBG:SetCheck(index == self._currentSailorIndex)
  btn_buttonBG:addInputEvent("Mouse_LUp", "HandleEventLUp_SailorManagerAll_SelectSailor(" .. index .. ")")
  txt_state1:addInputEvent("Mouse_LUp", "HandleEventLUp_SailorManagerAll_SelectSailorText(" .. index .. ")")
  txt_state2:addInputEvent("Mouse_LUp", "HandleEventLUp_SailorManagerAll_SelectSailorText(" .. index .. ")")
  local isOpenByESCMenu = not PaGlobal_SailorManager_All._isOpenByESCMenu
  btn_restore:SetShow(isOpenByESCMenu)
  if isOpenByESCMenu then
    if true == isEscape then
      btn_restore:addInputEvent("Mouse_LUp", "HandleEventLUp_SailorManagementAll_SailorRestore(" .. index .. "," .. __eEmployeeLoyalismType_resurrection .. ")")
    else
      btn_restore:addInputEvent("Mouse_LUp", "HandleEventLUp_SailorManagementAll_SailorRestore(" .. index .. "," .. __eEmployeeLoyalismType_Loyalty .. ")")
    end
  end
  txt_displayRoyalty:SetText(tostring(sailorInfo._loyalty) .. "/" .. tostring(sailorInfo._maxLoyalty))
end
function PaGlobal_SailorManager_All:sailorUpdate(isScrollLock)
  if nil == Panel_Window_SailorManager_All then
    return
  end
  self._sailorCount = ToClient_getEmployeeCount()
  self._ui.txt_slotValue:SetText(tostring(self._sailorCount) .. "/" .. tostring(ToClient_getEmployeeMaxSlotCount()))
  for index = 1, self._sailorCount do
    local sailorWrapper = ToClient_getEmployeeWrapperByIndex(index - 1)
    if nil ~= sailorWrapper then
      local sailorKey = sailorWrapper:getEmployeeKey()
      if true == sailorKey:isDefined() then
        local sailorName = sailorWrapper:getEmployeeName()
        local sailorInfoTemplate = {
          _level = sailorKey:getLevel(),
          _name = sailorName,
          _loyalty = sailorWrapper:getLoyalty(),
          _maxLoyalty = sailorWrapper:getMaxLoyalty(),
          _expRate = sailorWrapper:getExperienceRate(),
          _royalRate = sailorWrapper:getLoyaltyRate(),
          _isApply = sailorWrapper:isApply(),
          _state = sailorWrapper:getState(),
          _sailorNo = sailorWrapper:getEmployeeNo(),
          _sailorKey = sailorKey,
          _onServantNo = sailorWrapper:getVariousNo(),
          _resSeaCurrent = sailorWrapper:getValue(__eEmployeeAbility_Resist_OceanCurrent),
          _resSeaWind = sailorWrapper:getValue(__eEmployeeAbility_Resist_WindDirection),
          _resFood = sailorWrapper:getValue(__eEmployeeAbility_Resist_Food),
          _resLoyalty = sailorWrapper:getValue(__eEmployeeAbility_Resist_Loyalty),
          _speed = sailorWrapper:getValue(__eEmployeeAbility_Servant_Speed),
          _accel = sailorWrapper:getValue(__eEmployeeAbility_Servant_Acceleration),
          _turning = sailorWrapper:getValue(__eEmployeeAbility_Servant_Cornering),
          _break = sailorWrapper:getValue(__eEmployeeAbility_Servant_Brake),
          _cannonCoolTime = sailorWrapper:getValue(__eEmployeeAbility_Servant_CannonCoolTime),
          _cannonAccuracy = sailorWrapper:getValue(__eEmployeeAbility_Servant_CannonAccuracy),
          _cannonMaxLength = sailorWrapper:getValue(__eEmployeeAbility_Servant_CannonMaxLength),
          _cannonMaxAngle = sailorWrapper:getValue(__eEmployeeAbility_Servant_CannonMaxAngle),
          _cost = sailorWrapper:getCost(),
          _foodConsume = sailorWrapper:getFoodConsume(),
          _iconPath = sailorWrapper:getIconPath(),
          _bodyWeight = sailorWrapper:getBodyWeight()
        }
        self._sailorInfoList[index] = sailorInfoTemplate
      end
    end
  end
  local prevIndex = 0
  if true == isScrollLock then
    prevIndex = self._ui.list_sailorList:getCurrenttoIndex()
  end
  self._ui.list_sailorList:getElementManager():clearKey()
  for i = 1, self._sailorCount do
    self._ui.list_sailorList:getElementManager():pushKey(toInt64(0, i))
  end
  self._ui.list_sailorList:moveIndex(prevIndex)
  self._ui.stc_sailorInfoBG:SetShow(self._sailorCount > 0)
end
function PaGlobal_SailorManager_All:prepareOpen()
  if nil == Panel_Window_SailorManager_All then
    return
  end
  self:sailorUpdate(false)
  if 0 >= self._sailorCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_EMPTYEMPLOYEELIST"))
    return
  end
  local isOpenByESCMenu = not PaGlobal_SailorManager_All._isOpenByESCMenu
  self._ui.btn_restoreAll_PC:SetShow(isOpenByESCMenu)
  self._ui.btn_ride_PC:SetShow(isOpenByESCMenu)
  self._ui.btn_WorkerFire_PC:SetShow(isOpenByESCMenu)
  PaGlobal_SailorManager_All:resize()
  if false == isOpenByESCMenu then
    PaGlobal_SailorOnBoard_All:prepareClose()
    Panel_Window_SailorManager_All:SetPosX(getScreenSizeX() / 2 - Panel_Window_SailorManager_All:GetSizeX() / 2)
    Panel_Window_SailorManager_All:SetPosY(getScreenSizeY() / 2 - Panel_Window_SailorManager_All:GetSizeY() / 2)
  else
    PaGlobal_SailorOnBoard_All:prepareOpen()
    Panel_Window_SailorManager_All:SetPosX(self._initPosX)
    Panel_Window_SailorManager_All:SetPosY(self._initPosY)
  end
  HandleEventLUp_SailorManagerAll_SelectSailor(1)
  if nil ~= Panel_Window_WharfList and nil ~= Panel_Window_WharfInfo then
    Panel_Window_WharfList:SetShow(false)
    Panel_Window_WharfInfo:SetShow(false)
  end
  local unsealVehicleActorKeyRaw = 0
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil ~= temporaryWrapper then
    local unsealServantInfo = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
    if nil ~= unsealServantInfo then
      unsealVehicleActorKeyRaw = unsealServantInfo:getActorKeyRaw()
    end
  end
  local isShow = true
  if false == _ContentsGroup_BattleShipFireRenewal then
    isShow = false
  end
  self._ui.txt_cannonCoolTimeTitle:SetShow(isShow)
  self._ui.txt_cannonCoolTime:SetShow(isShow)
  self._ui.txt_cannonAccuracyTitle:SetShow(isShow)
  self._ui.txt_cannonAccuracy:SetShow(isShow)
  self._ui.txt_cannonMaxLengthTitle:SetShow(isShow)
  self._ui.txt_cannonMaxLength:SetShow(isShow)
  self._ui.txt_cannonMaxAngleTitle:SetShow(isShow)
  self._ui.txt_cannonMaxAngle:SetShow(isShow)
  PaGlobal_SailorManager_All:open()
end
function PaGlobal_SailorManager_All:open()
  if nil == Panel_Window_SailorManager_All then
    return
  end
  Panel_Window_SailorManager_All:SetShow(true)
end
function PaGlobal_SailorManager_All:prepareClose()
  if nil == Panel_Window_SailorManager_All then
    return
  end
  PaGlobal_SailorManager_All._isOpenByESCMenu = false
  if true == PaGlobal_SailorManager_All._ui.stc_restoreItemBG:GetShow() then
    PaGlobal_SailorManager_All._ui.stc_restoreItemBG:SetShow(false)
  end
  if true == Panel_Window_Sailor_Onboard_All:GetShow() then
    PaGlobal_SailorOnBoard_All:prepareClose()
  elseif true == Panel_Window_SailorRestore_All:GetShow() then
    PaGlobal_SailorRestore_All:prepareClose()
  else
    if nil ~= Panel_Window_WharfList and nil ~= Panel_Window_WharfInfo then
      Panel_Window_WharfList:SetShow(true)
      Panel_Window_WharfInfo:SetShow(true)
    end
    PaGlobal_SailorManager_All:close()
  end
end
function PaGlobal_SailorManager_All:prepareCloseForce()
  if nil == Panel_Window_SailorManager_All then
    return
  end
  if nil ~= Panel_Window_WharfList and nil ~= Panel_Window_WharfInfo then
    Panel_Window_WharfList:SetShow(true)
    Panel_Window_WharfInfo:SetShow(true)
  end
  PaGlobal_SailorOnBoard_All:prepareClose()
  PaGlobal_SailorRestore_All:prepareClose()
  PaGlobal_SailorManager_All:close()
end
function PaGlobal_SailorManager_All:close()
  if nil == Panel_Window_SailorManager_All then
    return
  end
  Panel_Window_SailorManager_All:SetShow(false)
end
function PaGlobal_SailorManager_All:validate()
  if nil == Panel_Window_SailorManager_All then
    return
  end
end
function PaGlobal_SailorManager_All:resize()
  if nil == Panel_Window_SailorManager_All then
    return
  end
  Panel_Window_SailorManager_All:ComputePos()
  if nil == Panel_Window_Sailor_Onboard_All then
    return
  end
  Panel_Window_Sailor_Onboard_All:ComputePos()
end
function Command_SailorModeOn()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(9991, 1, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function Command_SailorModeOff()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(9991, 0, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_SailorManager_All:slotClear()
  for _, slot in pairs(self._ui.stc_restoreList) do
    if nil ~= slot then
      slot.slotBG:SetShow(false)
    end
  end
end
function PaGlobal_SailorManager_All:getAddItionalStatString(isApply, value)
  if value <= 0 then
    return ""
  end
  if false == isApply then
    return "<PAColor0xFFFFCE22>\226\150\178" .. string.format("%.1f", value * 1.0E-4) .. "<PAOldColor>"
  else
    return "<PAColor0xFFFF0000>\226\150\188" .. string.format("%.1f", value * 1.0E-4) .. "<PAOldColor>"
  end
end
function PaGlobal_SailorManager_All:getAddItionalStatStringRaw(isApply, value)
  if value <= 0 then
    return ""
  end
  if false == isApply then
    return "<PAColor0xFFFFCE22>\226\150\178" .. string.format("%.1f", value) .. "<PAOldColor>"
  else
    return "<PAColor0xFFFF0000>\226\150\188" .. string.format("%.1f", value) .. "<PAOldColor>"
  end
end
function PaGlobal_SailorManager_All:getAddItionalStatStringReverse(isApply, value)
  if value <= 0 then
    return ""
  end
  if false == isApply then
    return "<PAColor0xFFFFCE22>\226\150\188" .. string.format("%.1f", value * 1.0E-4) .. "<PAOldColor>"
  else
    return "<PAColor0xFFFF0000>\226\150\178" .. string.format("%.1f", value * 1.0E-4) .. "<PAOldColor>"
  end
end
function PaGlobal_SailorManager_All:getAddItionalStatStringRawReverse(isApply, value)
  if value <= 0 then
    return ""
  end
  if false == isApply then
    return "<PAColor0xFFFFCE22>\226\150\188" .. string.format("%.1f", value) .. "<PAOldColor>"
  else
    return "<PAColor0xFFFF0000>\226\150\178" .. string.format("%.1f", value) .. "<PAOldColor>"
  end
end
function FromClient_EmployeeVarySlotAck(varySlotCount)
  if nil == Panel_Window_SailorManager_All then
    return
  end
  local string = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SAILORSLOTITEM_RESULT", "varySlot", tostring(varySlotCount))
  Proc_ShowMessage_Ack(string)
  PaGlobal_SailorManager_All:sailorUpdate(false)
  PaGlobal_ShipInfo_All:sailor_sailorList()
end
