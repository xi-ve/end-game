MoveToTask = {}

function MoveToTask.work(dest, stopDistance, isNode)
  if isNode == nil then
    isNode = true
  end
  Log.debugLog("MoveToTask")
  stopDistance = stopDistance or Grinder.settings.stopDistance
  dest = Vector3(dest.X, dest.Y, dest.Z)

  if not dest then
    Log.debugLog("no dest set")
    return false
  end

  local selfPlayerPos = Cache.playerPos
  if not selfPlayerPos then
    return false
  end

  local distance = selfPlayerPos:getDistance(dest)
  if distance >= stopDistance then
    Grinder.currentDest = dest
    Grinder.currentDestIsNode = isNode
    return false
  end

  Log.debugLog("moveToTask arrived")

  Grinder.currentDest = nil
  Grinder.currentDestIsNode = nil

  Player.stopMoving()
  return true
end
