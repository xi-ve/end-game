function PaGlobal_ShipControl_Console_Open()
  if nil == Panel_Window_ShipControl then
    return
  end
  PaGlobal_ShipControl_Console:prepareOpen()
end
function PaGlobal_ShipControl_Console_Close()
  if nil == Panel_Window_ShipControl then
    return
  end
  PaGlobal_ShipControl_Console:prepareClose()
end
function PaGlobal_ShipControl_Console_Resize()
  if nil == Panel_Window_ShipControl then
    return
  end
  PaGlobal_ShipControl_Console:resize()
end
function HandleEventLUp_ShipControl_Console_Function_1()
  if nil == Panel_Window_ShipControl then
    return
  end
  ToClient_AutoRideOnShipDetail(__eServantShipRideControlType_AutoRide)
end
function HandleEventLUp_ShipControl_Console_Function_2()
  if nil == Panel_Window_ShipControl then
    return
  end
  if true == ToClient_CheckShipRecallDistance() then
    ToClient_AutoRideOnShipDetail(__eServantShipRideControlType_Recall)
  else
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return
    end
    ToClient_DeleteNaviGuideByGroup(0)
    if true == PaGlobal_ShipControl_Console._isNaviOn then
      PaGlobal_ShipControl_Console._isNaviOn = false
      return
    end
    local seaVehicleWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
    if nil == seaVehicleWrapper then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLELIST_NOT_UNSEAL_SERVANT"))
      return
    end
    local position = float3(seaVehicleWrapper:getPositionX(), seaVehicleWrapper:getPositionY(), seaVehicleWrapper:getPositionZ())
    worldmapNavigatorStart(position, NavigationGuideParam(), false, true, true)
    temporaryWrapper:refreshUnsealVehicle(seaVehicleWrapper, true)
    PaGlobal_ShipControl_Console._isNaviOn = true
  end
  audioPostEvent_SystemUi(0, 14)
end
function HandleEventLUp_ShipControl_Console_SetDescription(descIndex)
  if nil == Panel_Window_ShipControl then
    return
  end
  local desc = PaGlobal_ShipControl_Console._btnDesc[descIndex]
  if nil ~= desc then
    PaGlobal_ShipControl_Console._ui.txt_desc:SetText(desc)
  end
end
