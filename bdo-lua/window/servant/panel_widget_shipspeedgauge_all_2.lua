function FromClient_ShipSpeedGauge_PlayerRideOn()
  if nil == Panel_Widget_ShipSpeedGauge then
    return
  end
  if true == PaGlobalFunc_OceanGuide_IsShip() then
    PaGlobal_ShipSpeedGauge:prepareOpen()
  else
    PaGlobal_ShipSpeedGauge:prepareClose()
  end
end
function FromClient_ShipSpeedGauge_PlayerRideOff()
  if nil == Panel_Widget_ShipSpeedGauge then
    return
  end
  PaGlobal_ShipSpeedGauge:prepareClose()
end
function FromClient_ShipSpeedGauge_CarriageChange(vehicleActorKeyRaw)
  if nil == Panel_Widget_ShipSpeedGauge then
    return
  end
  local characterActorProxyWrapper = getCharacterActor(vehicleActorKeyRaw)
  if nil == characterActorProxyWrapper then
    PaGlobal_ShipSpeedGauge:prepareClose()
    return
  end
end
function UpdateFunc_ShipSpeedGauge_UpdateSpeedGauge(deltaTime)
  if nil == Panel_Widget_ShipSpeedGauge then
    return
  end
  if false == Panel_Widget_ShipSpeedGauge:GetShow() then
    return
  end
  if false == _ContentsGroup_OceanCurrent then
    return
  end
  local selfPlayer = getSelfPlayer()
  local selfProxy = selfPlayer:get()
  if nil == selfProxy then
    return
  end
  local currentSpeedRate = selfProxy:getCurrentSpeedRate()
  local progressRate = PaGlobal_ShipSpeedGauge._ui._stc_progressBar:GetProgressRate()
  local updateRate = (currentSpeedRate - progressRate) * deltaTime * PaGlobal_ShipSpeedGauge._progressMoveSpeed
  PaGlobal_ShipSpeedGauge._ui._stc_progressBar:SetProgressRate(progressRate + updateRate)
end
