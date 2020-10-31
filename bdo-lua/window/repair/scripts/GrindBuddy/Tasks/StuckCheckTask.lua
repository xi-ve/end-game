StuckCheckTask = {}
StuckCheckTask.posHistory = {}
StuckCheckTask.lastTimeAdd = 0
StuckCheckTask.lastTimeReset = 0

StuckCheckTask.lastTimeChecked = 0

StuckCheckTask.lastJumpTime = 0
StuckCheckTask.lastLeftClickTime = 0
StuckCheckTask.newDestSetTime = 0

StuckCheckTask.lastTpTime = 0

StuckCheckTask.lastActionTime = 0

StuckCheckTask.unstuckRoutineIndex = 0

StuckCheckTask.strict = true

StuckCheckTask.lastStuckPos = nil
StuckCheckTask.lastStuckTime = 0

StuckCheckTask.lastShortStuck = 0

function StuckCheckTask.reset()
  StuckCheckTask.posHistory = {}
  StuckCheckTask.lastTimeAdd = 0
  StuckCheckTask.lastTimeReset = 0

  StuckCheckTask.lastJumpTime = Cache.time
  StuckCheckTask.lastLeftClickTime = Cache.time
  StuckCheckTask.newDestSetTime = Cache.time
end

StuckCheckTask.jump = function()
  local time = Cache.time
  StuckCheckTask.lastJumpTime = time
  Grinder.lastJumpTime = time
  --[[if not Infinity.BDO.Input.isEmptyQueue() then
        Infinity.BDO.Input.clearQueue()
    end]]
  Input.pressOnce({KeyCode_W, KeyCode_SPACE}, 275)

  time = nil
end

function StuckCheckTask.pulse()

  local time = Cache.time

  if StuckCheckTask.lastTimeReset + 10052 < time or StuckCheckTask.lastTimeChecked + 2000 < time or AttackActorTask.lastFoughtTime + 2991 > time then
    StuckCheckTask.posHistory = {}
    StuckCheckTask.lastTimeReset = time
  end

  local nav = Grinder.currentProfile.nav
  if (not nav.arrived and nav.isNavigating) or (not nav.direct_nav.arrived and nav.direct_nav.isNavigating) then
    if StuckCheckTask.lastTimeAdd + 81 < time then
      table.insert(StuckCheckTask.posHistory, Cache.playerPos)
      StuckCheckTask.lastTimeAdd = time
    end
  end
end

StuckCheckTask.lastStuckStatus = false
function StuckCheckTask.work()
  --Log.debugLog("StuckCheckTask")

  local nav = Grinder.currentProfile.nav
  if not((not nav.arrived and nav.isNavigating) or (not nav.direct_nav.arrived and nav.direct_nav.isNavigating)) then
    return false
  end

  if Teleport.isTpAllowed() then
    return false
  end

  local time = Cache.time

  if (StuckCheckTask.newDestSetTime + 500 > time) then
    return false
  end

  if StuckCheckTask.lastActionTime + 250 > time then
    return false
  end

  StuckCheckTask.lastTimeChecked = time


  --[[shortStuck
    local shortStuck = false
    if #StuckCheckTask.posHistory > 0 and StuckCheckTask.lastShortStuck + 5000 < time then
        shortStuck = true
        local checkAmount = 14 --+1
        if #StuckCheckTask.posHistory <= checkAmount then
            checkAmount = #StuckCheckTask.posHistory - 1
        end
        for c = 0, checkAmount do
            local distance = StuckCheckTask.posHistory[#StuckCheckTask.posHistory - c]:getDistance2D(Cache.playerPos)
            if distance > 23 then
                shortStuck = false
                break
            end
        end
    end

    if shortStuck then
        Log.log("Short stuck detected! Jumping!")
        local dest = FreeMoveTask.endDest or Grinder.currentDest
        StuckCheckTask.lastShortStuck = time
        if dest and Raycast.hasJumpable(Cache.playerPos, dest) then
            StuckCheckTask.jump()
            return true
        end
    end]]

  --Normal stuck
  --Log.debugLog("Check for normal Stuck")
  if StuckCheckTask.posHistory and #StuckCheckTask.posHistory > 10 and AttackActorTask.lastFoughtTime + 491 < time then
    local stuck = false
    --Log.debugLog("IsStuck")
    stuck = true
    local checkAmount = 20 --+1


    if #StuckCheckTask.posHistory <= checkAmount then
      checkAmount = #StuckCheckTask.posHistory - 1
    end
    for c = 0, checkAmount do
      local distance = StuckCheckTask.posHistory[#StuckCheckTask.posHistory - c]:getDistance2D(Cache.playerPos)
      if distance > 73 then
        stuck = false
        break
      end
    end

    StuckCheckTask.lastStuckStatus = stuck
    if stuck then
      --[[
            local closestMob = TargetHelper.getClosestMonsterTarget(500)
            if closestMob ~= nil then
                Log.log("Stuck and there is a mob really close. Attacking mob!")
                if Grinder.fightCloseEnemys() then
                    return true
                end
            end
            ]]


      local canJump = false
      if not StuckCheckTask.lastStuckPos or StuckCheckTask.lastStuckPos:getDistance(Cache.playerPos) > 100 then
        Log.log("Stuck detected!")
        StuckCheckTask.lastStuckPos = Cache.playerPos
        StuckCheckTask.lastStuckTime = Cache.time
        canJump = true
      else
        if StuckCheckTask.lastStuckTime + 5000 > Cache.time then
          canJump = true
        else
          if not Grinder.settings.allow_unsafe_tp_for_unstuck then
            if Grinder.settings.log_verbose then
              Log.log("Not jumping since we are stuck too long!")
            end
            Player.blockMovement(1000)
          end
        end
      end

      if canJump and StuckCheckTask.lastJumpTime + 1200 < time then
        Log.log("Trying to jump to unstuck!")
        StuckCheckTask.jump()
        StuckCheckTask.lastActionTime = time
        StuckCheckTask.unstuckRoutineIndex = 1
        Grinder.wait(500)
        return true
      end


      --[[if StuckCheckTask.lastLeftClickTime + 458 < Cache.time and StuckCheckTask.unstuckRoutineIndex == 1 then
                if Grinder.settings.log_verbose then
                    Log.log("Trying to LMB Attack to unstuck!")
                end
                StuckCheckTask.lastLeftClickTime = Cache.time
                if not Infinity.BDO.Input.isEmptyQueue() then
                    Infinity.BDO.Input.clearQueue()
                end
                Infinity.BDO.Input.PressKeys_Once({KeyCode_LBUTTON}, 50)
                StuckCheckTask.lastActionTime = Cache.time
                StuckCheckTask.unstuckRoutineIndex = 2
                return true
            end]]


      if StuckCheckTask.lastTpTime + 2392 < time then
        Log.log("Trying to use tp to unstuck!")

        if (Grinder.currentDest ~= nil) then

          local dest = VectorUtils.tableToVector3(Grinder.currentDest)
          --We need to move somewhere
          Grinder.currentProfile.nav.moveTo(dest, Grinder.currentDestIsNode)
          Grinder.currentProfile.nav.navigate()
          dest = nil

          if nav.direct_nav.dest then
            StuckCheckTask.findPosClearPathAndTp(nav.direct_nav.dest)
          elseif nav.path and nav.path.waypoints and #nav.path.waypoints > 0 then
            StuckCheckTask.findPosClearPathAndTp(nav.path.waypoints[1])
          else
            StuckCheckTask.findPosAndTp()
          end

          nav = nil
        end


        StuckCheckTask.lastTpTime = time
        StuckCheckTask.lastActionTime = time
        StuckCheckTask.unstuckRoutineIndex = 0
        return true
      end

      return false
    end
  end

  return false
end

function StuckCheckTask.circularCollision(pos)
  --Log.debugLog("circulatCollision")
  local lPlayerPosTemp = pos

  for angle = 0, 360, 2 do

    local x = lPlayerPosTemp.X + (50 * math.cos(angle / (180 / math.pi)))
    local z = lPlayerPosTemp.Z + (50 * math.sin(angle / (180 / math.pi)))

    local nPos = Vector3(x, lPlayerPosTemp.Y, z)

    local rVec = lPlayerPosTemp:getDirectionVector(nPos)
    local rCast = Infinity.BDO.getSceneManager():CastRay(lPlayerPosTemp, rVec, 50, 1, 32)

    if rCast ~= 0 then
      if not Raycast.twoPos(nPos, Cache.playerPos) then
        return true
      end
    end
  end

  return false
end

function StuckCheckTask.findPosClearPathAndTp(dest)
  --Log.debugLog("findPosClearPathAndTp")

  local lPlayerPosTemp = Cache.playerPos

  if lPlayerPosTemp:getDistance(dest) < 200 then
    Teleport.tpTo(dest, Grinder.settings.allow_unsafe_tp_for_unstuck)
  else
    Teleport.forceTpTo(dest)
  end
  lPlayerPosTemp = nil
end


function StuckCheckTask.findPosAndTp()
  --Log.debugLog("findPosAndTp")
  for i = 20, 150, 10 do
    local lPlayerPosTemp = Cache.playerPos

    for angle = 0, 360, 2 do

      local x = lPlayerPosTemp.X + (250 * math.cos(angle / (180 / math.pi)))
      local z = lPlayerPosTemp.Z + (250 * math.sin(angle / (180 / math.pi)))

      if not StuckCheckTask.circularCollision(Vector3(x, lPlayerPosTemp.Y + i, z)) then
        Teleport.tpTo(Vector3(x, lPlayerPosTemp.Y + i, z), true)
        return
      end
    end
  end
end
