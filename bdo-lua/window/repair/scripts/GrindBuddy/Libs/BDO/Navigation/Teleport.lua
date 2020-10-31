Teleport = {}
Teleport.allowWithPlayers = false
Teleport.lastTpTime = 0

Teleport.forceTpInitTime = 0
Teleport.forceTpDest = nil
function Teleport.forceTpTo(dest)
  local pPos = Cache.playerPos
  local dist = dest:getDistance(pPos)
  if dist < 4000 then
    Teleport.forceTpDest = Vector3(dest.X, dest.Y + 100, dest.Z)
    Teleport.forceTpInitTime = Cache.time
  end
end

local function isPlayerCloseToGrindspot(range)
  Log.debugLog("Teleport isPlayerCloseToGrindspot")
  local _areas = Grinder.currentProfile.areas
  local pPos = Cache.playerPos
  for _, area in pairs(_areas) do
    for _, spot in pairs(area.spots) do
      if (pPos:getDistance(Vector3(spot.X, spot.Y, spot.Z)) < range) then
        return true
      end
    end
  end

  return false
end


function Teleport.forcePulse()
  if Teleport.forceTpDest ~= nil then

    if Teleport.forceTpInitTime + 1000 < Cache.time then
      Teleport.forceTpDest = nil
      return false
    end

    local dest = Teleport.forceTpDest
    local pPos = Cache.playerPos
    local dist = pPos:getDistance(dest)

    if dist < 75 then
      Teleport.forceTpDest = nil
    elseif dist > 2500 then
      Grinder.currentProfile.nav.moveTo(dest, true)
      Grinder.currentProfile.nav.navigate()
      StuckCheckTask.jump()
      Teleport.forceTpDest = nil
    else
      Teleport.tpWithUnstuckJump(dest, Grinder.settings.allow_unsafe_tp_for_unstuck, 200)
      Grinder.wait(200)
      return true
    end
  end
  return false
end

function Teleport.isTpAllowed()
  if not Grinder.settings.use_tp then
    return false
  end

  if Player.isPlayerNearby() then
    if Teleport.allowWithPlayers == false then
      return false
    end
  end

  if (Grinder.currentlyDoingTownrun or Grinder.currentlyFinishedTownrun) and Grinder.settings.no_tp_onTownrun then
    return false
  end

  return true
end

function Teleport.tpWithUnstuckJump(dest, force, maxDistance, delay)
  force = false --temp fix
  if not force and not Teleport.isTpAllowed() then
    return false
  end
  Teleport.tpTo(dest, force, maxDistance, delay)

  StuckCheckTask.jump()

end

function Teleport.tpTo(dest, force, maxDistance, delay)
  if not force and not Teleport.isTpAllowed() then
    return false
  end

  local time = Cache.time
  local useTownrunTp_Force = Grinder.settings.use_townrun_tp_faraway_grindspot and not isPlayerCloseToGrindspot(2000)

  if Grinder.settings.townrun_tp_different_speed and (Grinder.currentlyDoingTownrun or Grinder.currentlyFinishedTownrun or useTownrunTp_Force) then
    maxDistance = maxDistance or Grinder.settings.townrun_tp_maxDistance
    delay = delay or Grinder.settings.townrun_tp_delay
  else
    maxDistance = maxDistance or Grinder.settings.tp_maxDistance
    delay = delay or Grinder.settings.tp_delay
  end

  if Teleport.lastTpTime + delay > time then
    return false
  end

  Teleport.lastTpTime = time

  local from = Cache.playerPos

  if Infinity.BDO.getLocalPlayer():getMovementControler():getIsMoving() then
    Infinity.BDO.getLocalPlayer():getMovementControler():setIsMoving(false)
  end

  local distance = from:getDistance(dest)

  if distance > maxDistance then
    local rVec = Raycast.rVec(from, dest) --rVec always has length 1
    rVec = VectorUtils.multiply(rVec, maxDistance * 0.9) -- Makes it not too long
    rVec = Vector3(rVec.X, rVec.Y, rVec.Z)
    dest = VectorUtils.addition(from, rVec)

    rVec = nil
  end
  dest = Vector3(dest.X, dest.Y + Grinder.settings.tp_height_offset, dest.Z)
  Infinity.BDO.getLocalPlayer():getCharacterControler():setPhysPos(dest)

  Grinder.wait(25)

  distance = nil
  dest = nil
  from = nil
  time = nil

  return true
end
