function PaGlobal_SailorOnBoard_All:initialize()
  if true == PaGlobal_SailorOnBoard_All._initialize then
    return
  end
  self._ui.stc_titleBG = UI.getChildControl(Panel_Window_Sailor_Onboard_All, "Static_TitleBg")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBG, "Button_Win_Close_PCUI")
  self._ui.stc_myShipInfo = UI.getChildControl(Panel_Window_Sailor_Onboard_All, "Static_MyShipInfo")
  self._ui.stc_shipIcon = UI.getChildControl(self._ui.stc_myShipInfo, "Static_ShipIcon")
  self._ui.txt_shipName = UI.getChildControl(self._ui.stc_myShipInfo, "StaticText_ShipName")
  self._ui.txt_shipType = UI.getChildControl(self._ui.stc_myShipInfo, "StaticText_ShipType")
  self._ui.txt_shipCost = UI.getChildControl(self._ui.stc_myShipInfo, "StaticText_Cost")
  self._ui.stc_statInfo = UI.getChildControl(Panel_Window_Sailor_Onboard_All, "Static_StatInfo")
  self._ui.txt_speed = UI.getChildControl(self._ui.stc_statInfo, "StaticText_Speed_Value")
  self._ui.txt_accel = UI.getChildControl(self._ui.stc_statInfo, "StaticText_Accel_Value")
  self._ui.txt_turning = UI.getChildControl(self._ui.stc_statInfo, "StaticText_Turning_Value")
  self._ui.txt_break = UI.getChildControl(self._ui.stc_statInfo, "StaticText_Break_Value")
  self._ui.txt_resSeaCurrentTitle = UI.getChildControl(self._ui.stc_statInfo, "StaticText_Res_SeaCurrent")
  self._ui.txt_resSeaWindTitle = UI.getChildControl(self._ui.stc_statInfo, "StaticText_Res_SeaWind")
  self._ui.txt_resFoodTitle = UI.getChildControl(self._ui.stc_statInfo, "StaticText_Res_Food")
  self._ui.txt_resLoyaltyTitle = UI.getChildControl(self._ui.stc_statInfo, "StaticText_Res_Loyalty")
  self._ui.txt_resSeaCurrent = UI.getChildControl(self._ui.stc_statInfo, "StaticText_Res_SeaCurrent_Value")
  self._ui.txt_resSeaWind = UI.getChildControl(self._ui.stc_statInfo, "StaticText_Res_SeaWind_Value")
  self._ui.txt_resFood = UI.getChildControl(self._ui.stc_statInfo, "StaticText_Res_Food_Value")
  self._ui.txt_resLoyalty = UI.getChildControl(self._ui.stc_statInfo, "StaticText_Res_Loyalty_Value")
  self._ui.txt_cannonCoolTimeTitle = UI.getChildControl(self._ui.stc_statInfo, "StaticText_PatienceTitle")
  self._ui.txt_cannonAccuracyTitle = UI.getChildControl(self._ui.stc_statInfo, "StaticText_NavalgunCooltimeTitle")
  self._ui.txt_cannonMaxLengthTitle = UI.getChildControl(self._ui.stc_statInfo, "StaticText_MaximumrangeTitle")
  self._ui.txt_cannonMaxAngleTitle = UI.getChildControl(self._ui.stc_statInfo, "StaticText_AngleTitle")
  self._ui.txt_cannonCoolTime = UI.getChildControl(self._ui.stc_statInfo, "StaticText_NavalgunCooltimeValue")
  self._ui.txt_cannonAccuracy = UI.getChildControl(self._ui.stc_statInfo, "StaticText_AccuryValue")
  self._ui.txt_cannonMaxLength = UI.getChildControl(self._ui.stc_statInfo, "StaticText_MaximumrangeValue")
  self._ui.txt_cannonMaxAngle = UI.getChildControl(self._ui.stc_statInfo, "StaticText_AngleValue")
  self._ui.stc_bottom = UI.getChildControl(Panel_Window_Sailor_Onboard_All, "Static_Bottom")
  self._ui.btn_complete = UI.getChildControl(self._ui.stc_bottom, "Button_Complete")
  self._ui.btn_cancel = UI.getChildControl(self._ui.stc_bottom, "Button_Cancel")
  self._ui.btn_complete:SetShow(false)
  self._ui.btn_cancel:SetShow(false)
  PaGlobal_SailorOnBoard_All:registerEventHandler()
  PaGlobal_SailorOnBoard_All:validate()
  PaGlobal_SailorOnBoard_All._initialize = true
end
function PaGlobal_SailorOnBoard_All:registerEventHandler()
  if nil == Panel_Window_Sailor_Onboard_All then
    return
  end
  self._ui.btn_complete:addInputEvent("Mouse_LUp", "HandlerEventLUp_SailorOnBoardAll_Complete()")
  self._ui.btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_SailorOnBoard_All:prepareClose()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_SailorOnBoard_All:prepareClose()")
end
function PaGlobal_SailorOnBoard_All:update()
  if nil == Panel_Window_Sailor_Onboard_All then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil ~= temporaryWrapper then
    self._unsealServantInfo = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
    if nil ~= self._unsealServantInfo then
      self._unsealVehicleActorKeyRaw = self._unsealServantInfo:getActorKeyRaw()
      self._ui.stc_shipIcon:ChangeTextureInfoName(self._unsealServantInfo:getIconPath1())
      self._ui.txt_shipName:SetText(self._unsealServantInfo:getName())
      local cost = ToClient_GetServantStat(self._unsealServantInfo:getServantNo(), __eEmployeeAbility_Employee_Cost)
      local maxCost = self._unsealServantInfo:getEmployeeMaxCost()
      self._ui.txt_shipCost:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPINFO_CURRENT_COST") .. " : " .. tostring(cost) .. " / " .. tostring(maxCost))
      local shipTypeStr = self._unsealServantInfo:getDisplayName()
      if nil == shipTypeStr then
        shipTypeStr = ""
      end
      self._ui.txt_shipType:SetText(shipTypeStr)
      self._ui.txt_shipType:SetSize(self._ui.txt_shipType:GetTextSizeX(), self._ui.txt_shipType:GetTextSizeY())
      self._ui.txt_shipType:ComputePos()
    end
  end
  if 0 < PaGlobal_SailorManager_All._currentSailorIndex then
    local sailorInfo = PaGlobal_SailorManager_All._sailorInfoList[PaGlobal_SailorManager_All._currentSailorIndex]
    PaGlobalFunc_SailorOnBoardAll_AddStatforShip(sailorInfo)
  end
end
function PaGlobal_SailorOnBoard_All:setPanelPosition()
  if nil == Panel_Window_Sailor_Onboard_All or nil == Panel_Window_SailorManager_All then
    return
  end
  local pos = float2()
  pos.x = Panel_Window_SailorManager_All:GetPosX() + Panel_Window_SailorManager_All:GetSizeX() + 10
  pos.y = Panel_Window_SailorManager_All:GetPosY()
  Panel_Window_Sailor_Onboard_All:SetPosX(pos.x)
  Panel_Window_Sailor_Onboard_All:SetPosY(pos.y)
end
function PaGlobal_SailorOnBoard_All:prepareOpen()
  if nil == Panel_Window_Sailor_Onboard_All then
    return
  end
  PaGlobal_SailorOnBoard_All:setPanelPosition()
  PaGlobal_SailorOnBoard_All:update()
  if true == Panel_Window_SailorRestore_All:GetShow() then
    PaGlobal_SailorRestore_All:prepareClose()
  end
  local isShow = true
  if false == _ContentsGroup_BattleShipFireRenewal or false == ToClient_IsManualCannonFireServant(self._unsealVehicleActorKeyRaw) then
    isShow = false
    self._ui.txt_resSeaCurrentTitle:SetPosY(self._ui.txt_cannonCoolTimeTitle:GetPosY())
    self._ui.txt_resSeaWindTitle:SetPosY(self._ui.txt_cannonAccuracyTitle:GetPosY())
    self._ui.txt_resFoodTitle:SetPosY(self._ui.txt_cannonMaxLengthTitle:GetPosY())
    self._ui.txt_resLoyaltyTitle:SetPosY(self._ui.txt_cannonMaxAngleTitle:GetPosY())
    self._ui.txt_resSeaCurrent:SetPosY(self._ui.txt_cannonCoolTime:GetPosY())
    self._ui.txt_resSeaWind:SetPosY(self._ui.txt_cannonAccuracy:GetPosY())
    self._ui.txt_resFood:SetPosY(self._ui.txt_cannonMaxLength:GetPosY())
    self._ui.txt_resLoyalty:SetPosY(self._ui.txt_cannonMaxAngle:GetPosY())
  else
    self._ui.txt_resSeaCurrentTitle:SetPosY(self._ui.txt_cannonCoolTimeTitle:GetPosY() + 130)
    self._ui.txt_resSeaWindTitle:SetPosY(self._ui.txt_cannonAccuracyTitle:GetPosY() + 130)
    self._ui.txt_resFoodTitle:SetPosY(self._ui.txt_cannonMaxLengthTitle:GetPosY() + 130)
    self._ui.txt_resLoyaltyTitle:SetPosY(self._ui.txt_cannonMaxAngleTitle:GetPosY() + 130)
    self._ui.txt_resSeaCurrent:SetPosY(self._ui.txt_cannonCoolTime:GetPosY() + 130)
    self._ui.txt_resSeaWind:SetPosY(self._ui.txt_cannonAccuracy:GetPosY() + 130)
    self._ui.txt_resFood:SetPosY(self._ui.txt_cannonMaxLength:GetPosY() + 130)
    self._ui.txt_resLoyalty:SetPosY(self._ui.txt_cannonMaxAngle:GetPosY() + 130)
  end
  self._ui.txt_cannonCoolTimeTitle:SetShow(isShow)
  self._ui.txt_cannonAccuracyTitle:SetShow(isShow)
  self._ui.txt_cannonMaxLengthTitle:SetShow(isShow)
  self._ui.txt_cannonMaxAngleTitle:SetShow(isShow)
  self._ui.txt_cannonCoolTime:SetShow(isShow)
  self._ui.txt_cannonAccuracy:SetShow(isShow)
  self._ui.txt_cannonMaxLength:SetShow(isShow)
  self._ui.txt_cannonMaxAngle:SetShow(isShow)
  PaGlobal_SailorOnBoard_All:open()
end
function PaGlobal_SailorOnBoard_All:open()
  if nil == Panel_Window_Sailor_Onboard_All then
    return
  end
  Panel_Window_Sailor_Onboard_All:SetShow(true)
end
function PaGlobal_SailorOnBoard_All:prepareClose()
  if nil == Panel_Window_Sailor_Onboard_All then
    return
  end
  PaGlobal_SailorOnBoard_All:close()
end
function PaGlobal_SailorOnBoard_All:close()
  if nil == Panel_Window_Sailor_Onboard_All then
    return
  end
  Panel_Window_Sailor_Onboard_All:SetShow(false)
end
function PaGlobal_SailorOnBoard_All:validate()
  if nil == Panel_Window_Sailor_Onboard_All then
    return
  end
end
function HandlerEventLUp_SailorOnBoardAll_Complete()
end
function PaGlobalFunc_SailorOnBoardAll_AddStatforShip(sailorInfo)
  local self = PaGlobal_SailorOnBoard_All
  if nil == Panel_Window_Sailor_Onboard_All or nil == sailorInfo then
    return
  end
  local speed = PaGlobalFunc_SailorOnBoardAll_GetTotalStat(__eEmployeeAbility_Servant_Speed)
  local accel = PaGlobalFunc_SailorOnBoardAll_GetTotalStat(__eEmployeeAbility_Servant_Acceleration)
  local cornering = PaGlobalFunc_SailorOnBoardAll_GetTotalStat(__eEmployeeAbility_Servant_Cornering)
  local braking = PaGlobalFunc_SailorOnBoardAll_GetTotalStat(__eEmployeeAbility_Servant_Brake)
  local cannonCoolTime = ToClient_GetManualCannonFireCannonStatus(__eServantStatTypeCannonCoolTime)
  local cannonAccuracy = ToClient_GetManualCannonFireCannonStatus(__eServantStatTypeCannonAccuracy)
  local cannonMaxLength = ToClient_GetManualCannonFireCannonStatus(__eServantStatTypeCannonMaxLength) * 0.01
  local cannonMaxAngle = ToClient_GetManualCannonFireCannonStatus(__eServantStatTypeCannonMaxAngle)
  local cannonAccuracyView = cannonAccuracy - 90
  if 100 < cannonAccuracyView then
    cannonAccuracyView = 100
  end
  local cannonCoolTimeStat = PaGlobalFunc_SailorOnBoardAll_GetTotalStat(__eEmployeeAbility_Servant_CannonCoolTime)
  local cannonAccuracyStat = PaGlobalFunc_SailorOnBoardAll_GetTotalStat(__eEmployeeAbility_Servant_CannonAccuracy)
  local cannonMaxLengthStat = PaGlobalFunc_SailorOnBoardAll_GetTotalStat(__eEmployeeAbility_Servant_CannonMaxLength)
  local cannonMaxAngleStat = PaGlobalFunc_SailorOnBoardAll_GetTotalStat(__eEmployeeAbility_Servant_CannonMaxAngle)
  if nil ~= PaGlobal_SailorOnBoard_All._unsealServantInfo then
    local resSeaCurrent = ToClient_GetEmployeeAbillityByServant(self._unsealServantInfo:getServantNo(), __eEmployeeAbility_Resist_OceanCurrent)
    local resSeaWind = ToClient_GetEmployeeAbillityByServant(self._unsealServantInfo:getServantNo(), __eEmployeeAbility_Resist_WindDirection)
    local resFood = ToClient_GetEmployeeAbillityByServant(self._unsealServantInfo:getServantNo(), __eEmployeeAbility_Resist_Food)
    local resLoyalty = ToClient_GetEmployeeAbillityByServant(self._unsealServantInfo:getServantNo(), __eEmployeeAbility_Resist_Loyalty)
    local statString = {
      _speed = {
        origin = string.format("%.1f", speed * 1.0E-4) .. "%",
        add = PaGlobal_SailorManager_All:getAddItionalStatString(sailorInfo._isApply, sailorInfo._speed)
      },
      _accel = {
        origin = string.format("%.1f", accel * 1.0E-4) .. "%",
        add = PaGlobal_SailorManager_All:getAddItionalStatString(sailorInfo._isApply, sailorInfo._accel)
      },
      _turning = {
        origin = string.format("%.1f", cornering * 1.0E-4) .. "%",
        add = PaGlobal_SailorManager_All:getAddItionalStatString(sailorInfo._isApply, sailorInfo._turning)
      },
      _break = {
        origin = string.format("%.1f", braking * 1.0E-4) .. "%",
        add = PaGlobal_SailorManager_All:getAddItionalStatString(sailorInfo._isApply, sailorInfo._break)
      },
      _resSeaCurrent = {
        origin = string.format("%.1f", resSeaCurrent * 1.0E-4) .. "%",
        add = PaGlobal_SailorManager_All:getAddItionalStatString(sailorInfo._isApply, sailorInfo._resSeaCurrent)
      },
      _resSeaWind = {
        origin = string.format("%.1f", resSeaWind * 1.0E-4) .. "%",
        add = PaGlobal_SailorManager_All:getAddItionalStatString(sailorInfo._isApply, sailorInfo._resSeaWind)
      },
      _resFood = {
        origin = string.format("%.1f", resFood * 1.0E-4) .. "%",
        add = PaGlobal_SailorManager_All:getAddItionalStatString(sailorInfo._isApply, sailorInfo._resFood)
      },
      _resLoyalty = {
        origin = string.format("%.1f", resLoyalty * 1.0E-4) .. "%",
        add = PaGlobal_SailorManager_All:getAddItionalStatString(sailorInfo._isApply, sailorInfo._resLoyalty)
      },
      _cannonCoolTime = {
        origin = string.format("%.1f", cannonCoolTime) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND"),
        add = PaGlobal_SailorManager_All:getAddItionalStatStringRawReverse(sailorInfo._isApply, sailorInfo._cannonCoolTime / 10000)
      },
      _cannonAccuracy = {
        origin = string.format("%.2f", cannonAccuracyView) .. "%",
        add = PaGlobal_SailorManager_All:getAddItionalStatStringRaw(sailorInfo._isApply, cannonAccuracy * sailorInfo._cannonAccuracy / cannonAccuracyStat)
      },
      _cannonMaxLength = {
        origin = string.format("%.1f", cannonMaxLength),
        add = PaGlobal_SailorManager_All:getAddItionalStatStringRaw(sailorInfo._isApply, cannonMaxLength * sailorInfo._cannonMaxLength / cannonMaxLengthStat)
      },
      _cannonMaxAngle = {
        origin = string.format("%.1f", cannonMaxAngle) .. "\203\154",
        add = PaGlobal_SailorManager_All:getAddItionalStatStringRaw(sailorInfo._isApply, cannonMaxAngle * sailorInfo._cannonMaxAngle / cannonMaxAngleStat)
      }
    }
    PaGlobal_SailorOnBoard_All._ui.txt_speed:SetShow(true)
    PaGlobal_SailorOnBoard_All._ui.txt_accel:SetShow(true)
    PaGlobal_SailorOnBoard_All._ui.txt_turning:SetShow(true)
    PaGlobal_SailorOnBoard_All._ui.txt_break:SetShow(true)
    PaGlobal_SailorOnBoard_All._ui.txt_speed:SetText(statString._speed.origin)
    PaGlobal_SailorOnBoard_All._ui.txt_accel:SetText(statString._accel.origin)
    PaGlobal_SailorOnBoard_All._ui.txt_turning:SetText(statString._turning.origin)
    PaGlobal_SailorOnBoard_All._ui.txt_break:SetText(statString._break.origin)
    PaGlobal_SailorOnBoard_All._ui.txt_resSeaCurrent:SetText("0.0%")
    PaGlobal_SailorOnBoard_All._ui.txt_resSeaWind:SetText("0.0%")
    PaGlobal_SailorOnBoard_All._ui.txt_resFood:SetText("0.0%")
    PaGlobal_SailorOnBoard_All._ui.txt_resLoyalty:SetText("0.0%")
    PaGlobal_SailorOnBoard_All._ui.txt_cannonCoolTime:SetText(statString._cannonCoolTime.origin)
    PaGlobal_SailorOnBoard_All._ui.txt_cannonAccuracy:SetText(statString._cannonAccuracy.origin)
    PaGlobal_SailorOnBoard_All._ui.txt_cannonMaxLength:SetText(statString._cannonMaxLength.origin)
    PaGlobal_SailorOnBoard_All._ui.txt_cannonMaxAngle:SetText(statString._cannonMaxAngle.origin)
    local isCorrectShip = nil ~= PaGlobal_SailorOnBoard_All._unsealServantInfo and PaGlobal_SailorOnBoard_All._unsealServantInfo:getServantNo() == sailorInfo._onServantNo
    if false == sailorInfo._isApply and false == isCorrectShip or true == isCorrectShip and true == sailorInfo._isApply then
      PaGlobal_SailorOnBoard_All._ui.txt_speed:SetText(statString._speed.origin .. statString._speed.add)
      PaGlobal_SailorOnBoard_All._ui.txt_accel:SetText(statString._accel.origin .. statString._accel.add)
      PaGlobal_SailorOnBoard_All._ui.txt_turning:SetText(statString._turning.origin .. statString._turning.add)
      PaGlobal_SailorOnBoard_All._ui.txt_break:SetText(statString._break.origin .. statString._break.add)
      PaGlobal_SailorOnBoard_All._ui.txt_resSeaCurrent:SetText(statString._resSeaCurrent.origin .. statString._resSeaCurrent.add)
      PaGlobal_SailorOnBoard_All._ui.txt_resSeaWind:SetText(statString._resSeaWind.origin .. statString._resSeaWind.add)
      PaGlobal_SailorOnBoard_All._ui.txt_resFood:SetText(statString._resFood.origin .. statString._resFood.add)
      PaGlobal_SailorOnBoard_All._ui.txt_resLoyalty:SetText(statString._resLoyalty.origin .. statString._resLoyalty.add)
      PaGlobal_SailorOnBoard_All._ui.txt_cannonCoolTime:SetText(statString._cannonCoolTime.origin .. statString._cannonCoolTime.add)
      PaGlobal_SailorOnBoard_All._ui.txt_cannonAccuracy:SetText(statString._cannonAccuracy.origin .. statString._cannonAccuracy.add)
      PaGlobal_SailorOnBoard_All._ui.txt_cannonMaxLength:SetText(statString._cannonMaxLength.origin .. statString._cannonMaxLength.add)
      PaGlobal_SailorOnBoard_All._ui.txt_cannonMaxAngle:SetText(statString._cannonMaxAngle.origin .. statString._cannonMaxAngle.add)
    end
  end
end
function PaGlobalFunc_SailorOnBoardAll_GetTotalStat(eEmployeeAbility)
  local basicStat = 0
  if nil ~= PaGlobal_SailorOnBoard_All._unsealServantInfo then
    if __eEmployeeAbility_Servant_Speed == eEmployeeAbility then
      basicStat = PaGlobal_SailorOnBoard_All._unsealServantInfo:getStat(__eServantStatTypeSpeed)
    elseif __eEmployeeAbility_Servant_Acceleration == eEmployeeAbility then
      basicStat = PaGlobal_SailorOnBoard_All._unsealServantInfo:getStat(__eServantStatTypeAcceleration)
    elseif __eEmployeeAbility_Servant_Cornering == eEmployeeAbility then
      basicStat = PaGlobal_SailorOnBoard_All._unsealServantInfo:getStat(__eServantStatTypeCornering)
    elseif __eEmployeeAbility_Servant_Brake == eEmployeeAbility then
      basicStat = PaGlobal_SailorOnBoard_All._unsealServantInfo:getStat(__eServantStatTypeBrake)
    elseif __eEmployeeAbility_Servant_CannonCoolTime == eEmployeeAbility then
      basicStat = PaGlobal_SailorOnBoard_All._unsealServantInfo:getStat(__eServantStatTypeCannonCoolTime)
    elseif __eEmployeeAbility_Servant_CannonAccuracy == eEmployeeAbility then
      basicStat = PaGlobal_SailorOnBoard_All._unsealServantInfo:getStat(__eServantStatTypeCannonAccuracy)
    elseif __eEmployeeAbility_Servant_CannonMaxLength == eEmployeeAbility then
      basicStat = PaGlobal_SailorOnBoard_All._unsealServantInfo:getStat(__eServantStatTypeCannonMaxLength)
    elseif __eEmployeeAbility_Servant_CannonMaxAngle == eEmployeeAbility then
      basicStat = PaGlobal_SailorOnBoard_All._unsealServantInfo:getStat(__eServantStatTypeCannonMaxAngle)
    end
  end
  local addStat = 0
  local sailor
  for index = 1, PaGlobal_SailorManager_All._sailorCount do
    sailor = PaGlobal_SailorManager_All._sailorInfoList[index]
    if nil ~= PaGlobal_SailorOnBoard_All._unsealServantInfo and PaGlobal_SailorOnBoard_All._unsealServantInfo:getServantNo() == sailor._onServantNo and sailor._isApply then
      if __eEmployeeAbility_Servant_Speed == eEmployeeAbility then
        addStat = addStat + sailor._speed
      elseif __eEmployeeAbility_Servant_Acceleration == eEmployeeAbility then
        addStat = addStat + sailor._accel
      elseif __eEmployeeAbility_Servant_Cornering == eEmployeeAbility then
        addStat = addStat + sailor._turning
      elseif __eEmployeeAbility_Servant_Brake == eEmployeeAbility then
        addStat = addStat + sailor._break
      elseif __eEmployeeAbility_Servant_CannonCoolTime == eEmployeeAbility then
        addStat = addStat + sailor._cannonCoolTime
      elseif __eEmployeeAbility_Servant_CannonAccuracy == eEmployeeAbility then
        addStat = addStat + sailor._cannonAccuracy
      elseif __eEmployeeAbility_Servant_CannonMaxLength == eEmployeeAbility then
        addStat = addStat + sailor._cannonMaxLength
      elseif __eEmployeeAbility_Servant_CannonMaxAngle == eEmployeeAbility then
        addStat = addStat + sailor._cannonMaxAngle
      end
    end
  end
  return basicStat + addStat
end
