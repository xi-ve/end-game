function HandleEventUpdate_ShipCannon_GuageUpdateFrame(deltaTime)
  local nowPower = ToClient_getCommonGauge()
  if PaGlobal_ShipCannon.currentPower == nowPower then
    return
  end
  local maxPower = ToClient_getMaxCommonGauge()
  local percent = nowPower / maxPower * 50
  if 50 == math.floor(percent) then
    return
  end
  PaGlobal_ShipCannon:updateGaugeAll(percent)
end
function PaGloabl_ShipCannon_ShowAni()
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
end
function PaGloabl_ShipCannon_HideAni()
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
end
function FromClient_ShipCannon_PlayerRideOn(actorKeyRaw)
  if nil == Panel_Widget_OceanWind then
    return
  end
  local vehicleActor = getVehicleActor(actorKeyRaw)
  if nil == vehicleActor then
    return
  end
  local characterKey = vehicleActor:getCharacterKeyRaw()
  local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
  if nil == shipStaticStatus then
    return
  end
  if false == shipStaticStatus:getIsUseCannonByRideShip() then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local seatPosition = selfPlayer:get():getVehicleSeatIndex()
  if 0 == seatPosition then
    PaGlobal_ShipCannon:prepareOpen(PaGlobal_ShipCannon._eCannon.left)
    PaGlobal_ShipCannon:prepareOpen(PaGlobal_ShipCannon._eCannon.right)
  end
end
function FromClient_ShipCannon_PlayerRideOff()
  if nil == Panel_Widget_OceanWind then
    return
  end
  PaGlobal_ShipCannon:prepareClose(PaGlobal_ShipCannon._eCannon.left)
  PaGlobal_ShipCannon:prepareClose(PaGlobal_ShipCannon._eCannon.right)
end
function FromClient_UpdateCannonStatCount(cannonStatCount, vehicleType)
  PaGlobal_ShipCannon:updateBulletCount(cannonStatCount)
end
function FromClient_ShipCannon_OnScreenResize()
  PaGlobal_ShipCannon:repositionAll()
end
function FromClient_UpdateCannonCoolTime_Left(gaugeState)
  if false == _ContentsGroup_ManualCannonFire then
    return
  end
  if gaugeState == __eManualCannonFireCoolTimeState_AfterFire then
    PaGloabl_ShipCannon_ActionEventAfterFire_Left()
  elseif gaugeState == __eManualCannonFireCoolTimeState_One then
    PaGloabl_ShipCannon_ActionEventGaugeOne_Left()
  elseif gaugeState == __eManualCannonFireCoolTimeState_Two then
    PaGloabl_ShipCannon_ActionEventGaugeTwo_Left()
  elseif gaugeState == __eManualCannonFireCoolTimeState_Full then
    PaGloabl_ShipCannon_ActionEventGaugeFull_Left()
  end
end
function FromClient_UpdateCannonCoolTime_Right(gaugeState)
  if false == _ContentsGroup_ManualCannonFire then
    return
  end
  if gaugeState == __eManualCannonFireCoolTimeState_AfterFire then
    PaGloabl_ShipCannon_ActionEventAfterFire_Right()
  elseif gaugeState == __eManualCannonFireCoolTimeState_One then
    PaGloabl_ShipCannon_ActionEventGaugeOne_Right()
  elseif gaugeState == __eManualCannonFireCoolTimeState_Two then
    PaGloabl_ShipCannon_ActionEventGaugeTwo_Right()
  elseif gaugeState == __eManualCannonFireCoolTimeState_Full then
    PaGloabl_ShipCannon_ActionEventGaugeFull_Right()
  end
end
function PaGloabl_ShipCannon_ActionEventGaugeFull_Left()
  PaGlobal_ShipCannon:updateCooltime(PaGlobal_ShipCannon._eCannon.left, PaGlobal_ShipCannon._eCooltime.ready)
  PaGlobal_ShipCannon:SetShowGuageAll(true)
end
function PaGloabl_ShipCannon_ActionEventAfterFire_Left()
  PaGlobal_ShipCannon:hideCooltime(PaGlobal_ShipCannon._eCannon.left)
  PaGlobal_ShipCannon:hideGuageAndCache()
end
function PaGloabl_ShipCannon_ActionEventGaugeOne_Left()
  PaGlobal_ShipCannon:updateCooltime(PaGlobal_ShipCannon._eCannon.left, PaGlobal_ShipCannon._eCooltime.one)
end
function PaGloabl_ShipCannon_ActionEventGaugeTwo_Left()
  PaGlobal_ShipCannon:updateCooltime(PaGlobal_ShipCannon._eCannon.left, PaGlobal_ShipCannon._eCooltime.two)
end
function PaGloabl_ShipCannon_ActionEventHideGauge_Left()
  PaGlobal_ShipCannon:prepareClose(PaGlobal_ShipCannon._eCannon.left)
  PaGlobal_ShipCannon:hideGuageAndCache()
end
function PaGloabl_ShipCannon_ActionEventGaugeFull_Right()
  PaGlobal_ShipCannon:updateCooltime(PaGlobal_ShipCannon._eCannon.right, PaGlobal_ShipCannon._eCooltime.ready)
  PaGlobal_ShipCannon:SetShowGuageAll(true)
end
function PaGloabl_ShipCannon_ActionEventAfterFire_Right()
  PaGlobal_ShipCannon:hideCooltime(PaGlobal_ShipCannon._eCannon.right)
  PaGlobal_ShipCannon:hideGuageAndCache()
end
function PaGloabl_ShipCannon_ActionEventGaugeOne_Right()
  PaGlobal_ShipCannon:updateCooltime(PaGlobal_ShipCannon._eCannon.right, PaGlobal_ShipCannon._eCooltime.one)
end
function PaGloabl_ShipCannon_ActionEventGaugeTwo_Right()
  PaGlobal_ShipCannon:updateCooltime(PaGlobal_ShipCannon._eCannon.right, PaGlobal_ShipCannon._eCooltime.two)
end
function PaGloabl_ShipCannon_ActionEventHideGauge_Right()
  PaGlobal_ShipCannon:prepareClose(PaGlobal_ShipCannon._eCannon.right)
  PaGlobal_ShipCannon:hideGuageAndCache()
end
