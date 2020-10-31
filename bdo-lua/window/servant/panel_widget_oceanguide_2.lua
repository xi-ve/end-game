function FromClient_OceanGuide_UpdateOceanCurrent(_float4)
  if nil == Panel_Widget_OceanWind then
    return
  end
  if true == _ContentsGroup_OceanCurrent then
    local txt_Flow = PaGlobal_OceanGuide._oceanCurrent._ui.txt_flow
    local stc_Ring = PaGlobal_OceanGuide._oceanCurrent._ui.stc_Ring
    local dx = _float4.x * -1
    local dy = _float4.z * -1
    local power = math.floor(math.sqrt(dx * dx + dy * dy) + 0.5) * 0.1
    local iconUV, ringUV = PaGlobalFunc_OceanGuide_ChangeStateTexture(1, power)
    if -1 ~= ringUV then
      local x1, y1, x2, y2 = setTextureUV_Func(stc_Ring, ringUV[1], ringUV[2], ringUV[3], ringUV[4])
      stc_Ring:getBaseTexture():setUV(x1, y1, x2, y2)
      stc_Ring:setRenderTexture(stc_Ring:getBaseTexture())
    end
    if -1 ~= iconUV then
      x1, y1, x2, y2 = setTextureUV_Func(txt_Flow, iconUV[1], iconUV[2], iconUV[3], iconUV[4])
      txt_Flow:getBaseTexture():setUV(x1, y1, x2, y2)
      txt_Flow:setRenderTexture(txt_Flow:getBaseTexture())
    end
    if power <= 0 then
      PaGlobal_OceanGuide._oceanCurrent._ui.stc_Sequence:SetShow(false)
      PaGlobal_OceanGuide._oceanCurrent._ui.stc_Sequence_All:SetShow(false)
    elseif 1 == _float4.w then
      PaGlobal_OceanGuide._oceanCurrent._ui.stc_Sequence:SetShow(true)
      PaGlobal_OceanGuide._oceanCurrent._ui.stc_Sequence_All:SetShow(false)
    else
      PaGlobal_OceanGuide._oceanCurrent._ui.stc_Sequence:SetShow(false)
      PaGlobal_OceanGuide._oceanCurrent._ui.stc_Sequence_All:SetShow(true)
    end
    local radian = math.atan2(dx, dy)
    PaGlobal_OceanGuide._nowCurrentRadian = radian
    txt_Flow:SetText(tostring(power * 100))
  else
    Panel_Widget_OceanCurrent:SetShow(false)
  end
end
function FromClient_OceanGuide_UpdateWindDirection(_float3)
  if nil == Panel_Widget_OceanWind then
    return
  end
  if true == _ContentsGroup_OceanCurrent then
    local float3 = _float3
    local txt_Flow = PaGlobal_OceanGuide._oceanWind._ui.txt_flow
    local stc_Ring = PaGlobal_OceanGuide._oceanWind._ui.stc_Ring
    local dx = float3.x * -1
    local dy = float3.z * -1
    local radian = math.atan2(dx, dy)
    local power = math.floor(math.sqrt(dx * dx + dy * dy) + 0.5) * 0.1
    local iconUV, ringUV = PaGlobalFunc_OceanGuide_ChangeStateTexture(2, power)
    if -1 ~= ringUV then
      local x1, y1, x2, y2 = setTextureUV_Func(stc_Ring, ringUV[1], ringUV[2], ringUV[3], ringUV[4])
      stc_Ring:getBaseTexture():setUV(x1, y1, x2, y2)
      stc_Ring:setRenderTexture(stc_Ring:getBaseTexture())
    end
    if -1 ~= iconUV then
      x1, y1, x2, y2 = setTextureUV_Func(txt_Flow, iconUV[1], iconUV[2], iconUV[3], iconUV[4])
      txt_Flow:getBaseTexture():setUV(x1, y1, x2, y2)
      txt_Flow:setRenderTexture(txt_Flow:getBaseTexture())
    end
    PaGlobal_OceanGuide._oceanWind._ui.stc_Sequence:SetShow(0 < power)
    PaGlobal_OceanGuide._nowWindRadian = radian
    txt_Flow:SetText(tostring(power * 100))
  else
    Panel_Widget_OceanWind:SetShow(false)
  end
end
function FromClient_OceanGuide_PlayerRideOn()
  if nil == Panel_Widget_OceanWind then
    return
  end
  if true == PaGlobalFunc_OceanGuide_IsShip() then
    PaGlobal_OceanGuide:prepareOpen()
  else
    PaGlobal_OceanGuide:prepareClose()
  end
end
function FromClient_OceanGuide_PlayerRideOff()
  if nil == Panel_Widget_OceanWind then
    return
  end
  PaGlobal_OceanGuide:prepareClose()
end
function FromClient_OceanGuide_CarriageChange(vehicleActorKeyRaw)
  if nil == Panel_Widget_OceanWind then
    return
  end
  local characterActorProxyWrapper = getCharacterActor(vehicleActorKeyRaw)
  if nil == characterActorProxyWrapper then
    PaGlobal_OceanGuide:prepareClose()
    return
  end
end
function UpdateFunc_OceanGuide_ArrowbyPlayer()
  if nil == Panel_Widget_OceanWind then
    return
  end
  if nil ~= PaGlobal_OceanGuide._oceanCurrent._ui.stc_Sequence and nil ~= PaGlobal_OceanGuide._oceanWind._ui.stc_Sequence and nil ~= PaGlobal_OceanGuide._nowCurrentRadian and nil ~= PaGlobal_OceanGuide._nowWindRadian then
    local cameraRadian = getCameraRotation()
    PaGlobal_OceanGuide._oceanCurrent._ui.stc_Sequence:SetRotate(math.pi + PaGlobal_OceanGuide._nowCurrentRadian - cameraRadian)
    PaGlobal_OceanGuide._oceanWind._ui.stc_Sequence:SetRotate(math.pi + PaGlobal_OceanGuide._nowWindRadian - cameraRadian)
  end
end
function PaGlobalFunc_OceanGuide_ChangeStateTexture(type, power)
  local icon = {
    [1] = {
      {
        1,
        86,
        29,
        108
      },
      {
        30,
        86,
        29,
        108
      },
      {
        1,
        109,
        29,
        131
      },
      {
        59,
        86,
        87,
        108
      }
    },
    [2] = {
      {
        88,
        86,
        116,
        108
      },
      {
        117,
        86,
        145,
        108
      },
      {
        146,
        86,
        174,
        108
      },
      {
        175,
        86,
        203,
        108
      }
    }
  }
  local ring = {
    {
      256,
      1,
      340,
      85
    },
    {
      171,
      1,
      255,
      85
    },
    {
      341,
      1,
      425,
      85
    },
    {
      426,
      1,
      510,
      85
    }
  }
  local powerLevel = 0
  if 0 <= power and power < 1.9 then
    powerLevel = 1
  elseif 1.9 <= power and power < 4.2 then
    powerLevel = 2
  elseif 4.2 <= power and power < 7 then
    powerLevel = 3
  elseif 7 <= power then
    powerLevel = 4
  else
    return -1, -1
  end
  return icon[type][powerLevel], ring[powerLevel]
end
function PaGlobalFunc_OceanGuide_IsShip()
  local selfProxy = getSelfPlayer():get()
  local vehicleProxy = getVehicleActor(selfProxy:getRideVehicleActorKeyRaw())
  if nil == vehicleProxy then
    return false
  end
  local seatPosition = selfProxy:getVehicleSeatIndex()
  if 0 ~= seatPosition then
    return false
  end
  local servantType = vehicleProxy:get():getServantType()
  if nil ~= servantType and servantType == CppEnums.ServantType.Type_Ship then
    return true
  end
  return false
end
