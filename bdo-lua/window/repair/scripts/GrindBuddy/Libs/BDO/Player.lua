Player = {}


local function round(num, numDecimalPlaces)
  local mult = 10^numDecimalPlaces
  return math.floor(num * mult + 0.5) / mult
end

local function roundUp(num)
  return math.floor(num) + 1
end

local function normalizeYaw(yaw)
  local PI = 3.14159265358979323846
  while (yaw > PI) do
    yaw = -PI + (yaw - PI)
  end

  while (yaw < (-PI)) do
    yaw = PI + (yaw + PI)
  end

  return yaw
end

function Player.me()
  --Log.debugLog("Player me")
  --[[local time = 60001
    if Cache and Cache.time then
        time = Cache.time
    end
    if Player.localPlayerTime + 60000 < time then
        local lPlayer = Infinity.BDO.getLocalPlayer()
        Player.localPlayer = lPlayer


        time = nil

        return lPlayer
    else

        time = nil
        return Player.localPlayer
    end]]

  return Infinity.BDO.getLocalPlayer()
end

Player.currentDest = nil
Player.currentOrigin = nil
Player.isCurrentlyMoving = false

Player.ignoreCameraUntil = 0

function Player.setCamera(to, speedMult)
  if Player.ignoreCameraUntil < Cache.time then
    speedMult = speedMult or 1
    --Setting camera
    local PI = 3.14159265358979323846
    local rotFaceTarget = to:getRotationToFace(Player.getPos())
    local yawFaceTarget = normalizeYaw(rotFaceTarget - (2 * PI))

    local curYaw = Infinity.BDO.getCameraManager():getYaw()
    if Grinder.settings.camera_to_movement and Grinder.settings.camera_real_swing then
      local distUp = nil
      local distDown = nil
      if (curYaw < yawFaceTarget) then
        distUp = round(math.abs(yawFaceTarget - curYaw), 4)
        distDown = round(math.abs((curYaw - (-PI)) + (PI - yawFaceTarget)), 4)
      else
        distUp = round(math.abs((curYaw - (PI)) + (-PI - yawFaceTarget)), 4)
        distDown = round(math.abs(yawFaceTarget - curYaw), 4)
      end

      local speed = round(Grinder.settings.camera_real_swing_speed * speedMult, 4)
      if (distDown < distUp) then
        if distDown > speed then
          speed = speed * (roundUp(distDown)^3) --Scaling speed
          yawFaceTarget = curYaw - speed
        end
      else
        speed = speed * (roundUp(distUp)^3)
        if distUp > speed then
          speed = speed * (roundUp(distUp)^3) --Scaling speed
          yawFaceTarget = curYaw + speed
        end
      end
    end
    Infinity.BDO.getCameraManager():setYaw(yawFaceTarget)
  end
end

function Player.moveTo(destination, force)
  Log.debugLog("Player.moveTo")
  if force == nil then
    force = false
  end

  if force or Player.blockMovementUntil < Cache.time then
    Log.debugLog("Moving to " .. VectorUtils.toString(destination))
    --if not Player.currentDest or (Player.currentDest.X ~= destination.X and Player.currentDest.Z ~= destination.Z) then
    if Grinder.settings.camera_to_movement and Player.ignoreCameraUntil < Cache.time then
      Player.setCamera(destination)
      Infinity.BDO.getUIManager():setIsCursorActive(false)
      Input.pressOnce({KeyCode_W}, 150)
      return
    end


    --Setting movement
    local movementControler = Player.me():getMovementControler()
    movementControler:setDestination(destination)
    --end

    local playerPos = Cache.playerPos
    --if not Player.currentOrigin or (Player.currentOrigin.X ~= playerPos.X and Player.currentOrigin.Z ~= playerPos.Z) then
    movementControler:setOrigin(playerPos)
    --end

    playerPos = nil

    movementControler:setIsMoving(true)
  end
end

function Player.stopMoving()
  Log.debugLog("Player stopMoving")
  Player.me():getMovementControler():setIsMoving(false)
  --Player.movementControler:setDestination(Vector3(0, 0, 0))
  --Player.movementControler:setOrigin(Vector3(0, 0, 0))
end


Player.blockMovementUntil = 0
function Player.blockMovement(ms)
  Player.blockMovementUntil = Cache.time + ms
  Player.stopMoving()
end

function Player.getPos()
  --Log.debugLog("Player getPos")
  local selfPlayer = Player.me()
  local playerPos = selfPlayer:getPosition()

  selfPlayer = nil

  return Vector3(math.floor(playerPos.X), math.floor(playerPos.Y), math.floor(playerPos.Z))
end

function Player.getPlayersAmount(in_range)
  --TODO: Redo to use infinity internal actor cache
  --[[local code = [[
    local players = {}
    for _, key in ipairs(Actors.getActorsKey(in_range, Actors.EActorType_Player)) do
        local player = getActor(key)
        if player then
            table.insert(players, key)
        end
    end
    return #players
    ]]
  return 0
  --return Infinity.BDO.Lua.Execute(code)
end

function Player.getLevel()
  --Log.debugLog("Player getLevel")
  --local levelAsString = tostring(Player.me():getLevel()):sub(1, - 3)
  --return tonumber(levelAsString)
  return Player.me():getLevel()
end


function Player.getSkillXP()
  --Log.debugLog("Player getSkillXP")
  return Player.me():getSkillPointExperience():getUnsafe()
end

function Player.getCurrentExp()
  --Log.debugLog("Player getCurrentExp")
  return Player.me():getCurrentExp():getUnsafe()
end

function Player.getCurrentExpPerc()
  --Log.debugLog("Player getCurrentExpPerc")
  return (Player.getCurrentExp() / Player.me():getRequiredExp():getUnsafe() * 100)
  --[[local code = [[
    local player = getSelfPlayer():get()
    local s64_needExp = player:getNeedExp_s64()
    local s64_exp = player:getExp_s64()
    local _const = Defines.s64_const

    if s64_needExp > _const.s64_10000 then
      rate = Int64toInt32(s64_exp * Defines.s64_const.s64_1000 * Defines.s64_const.s64_100 / s64_needExp)
    elseif _const.s64_0 ~= s64_needsExp then
      rate = Int64toInt32(s64_exp * Defines.s64_const.s64_1000 * Defines.s64_const.s64_100 / s64_needExp)
    end

    local real_rate = rate / 1000
    return real_rate]]
end

function Player.isPlayerNearby()
  --Log.debugLog("Player isPlayerNearby")
  
  --[[
  -- Old
  local speedhackScript = Infinity.Scripting.GetScript("Speedhack")

  if speedhackScript and speedhackScript.IsRunning then
    return Infinity.Scripting.CurrentScript:LuaExec(speedhackScript, "return Speedhack.hasNonWhiteListedPlayers()")
  else
    return Infinity.BDO.getLocalPlayer():getIsOtherPlayersNearby()
  end
  ]] 
  return Infinity.Whitelist.IsNonWhitelistedPlayerStreamed()
end

function Player.isBattleMode()
  --Log.debugLog("Player isBattleMode")
  local combatStance = Player.me():getCombatStance()
  if combatStance == 1 or combatStance == 2 then
    combatStance = nil
    return true
  else
    combatStance = nil
    return false
  end
end

function Player.getHp()
  --Log.debugLog("Player getHp")
  return Player.me():getHp()
end

function Player.getHpPercent()
  --Log.debugLog("Player getHpPercent")
  local maxHp = Player.me():getMaxHp()
  local currentHp = Player.getHp()
  return currentHp / maxHp * 100
end

function Player.getMp()
  --Log.debugLog("Player getMp")
  return Player.me():getMp()
end

function Player.getMpPercent()
  --Log.debugLog("Player getMpPercent")
  local maxMp = Player.me():getMaxMp()
  local currentMp = Player.getMp()
  return currentMp / maxMp * 100
end

function Player.getWp()
  --Log.debugLog("Player getWp")
  return Player.me():getMp()
end

function Player.getWpPercent()
  --Log.debugLog("Player getWpPercent")
  return Player.getMpPercent()
end
