MoveToNpcTask = {}

MoveToNpcTask.lastFreeMoveTaskPos = Vector3(0, 0, 0)
MoveToNpcTask.lastFreeMoveTaskPosTime = 0

function MoveToNpcTask.work(npcPos, npcName, stopDistance)
  Log.debugLog("MoveToNpcTask work")
  if not stopDistance or stopDistance < 20 then
    stopDistance = Grinder.settings.stopDistance
  end

  local localPlayer = Infinity.BDO.getLocalPlayer()
  local selfPlayerPos = Cache.playerPos

  if not selfPlayerPos then return false end

  Log.debugLog("MoveToNpc calculations")
  local distanceToNpc = selfPlayerPos:getDistance(npcPos)
  local forceRunning = false
  if distanceToNpc < stopDistance + 500 and distanceToNpc > stopDistance then

  end

  --[[if distanceToNpc < 500 then
        distanceToNpc = distanceToNpc - (Player.me():getBodySize() + ActorUtils.getActorWithName(npcName, 850):getBodySize())
    end]]

  if distanceToNpc > stopDistance then
    if not MoveToTask.work(npcPos, stopDistance) then --if not arrived
      return nil
    end
  end

  Log.debugLog("MoveToNpc arrived")
  Grinder.resetNav()

  Grinder.currentProfile.nav.path = {}
  Grinder.currentProfile.nav.arrived = true

  if npcName ~= nil then
    return ActorUtils.getActorWithName(npcName, stopDistance * 3)
  else
    --Get closest Actor
    local actorName, actorKey, actorType, actorDistance = ActorUtils.getClosestActorInfo()

    --Get actor
    local actor = ActorUtils.getActor(actorKey)

    --Get actor with the right position (10 difference allowed)
    if actorName == npcName or actor:getPosition():getDistance(npcPos) < stopDistance then
      --TODO:Update profiles NPCs if this NPC is in there somewhere
    else
      Log.log("Wrong NPC is closest one. Please rerecord this NPC as we are now using Names instead of positions only and you are using a profile recorded before that change!")

      local rVec = Vector3(Cache.playerPos.X - npcPos.X, Cache.playerPos.Y - npcPos.Y, Cache.playerPos.Z - npcPos.Z)
      local destVec = Vector3(rVec.X / 5 + Cache.playerPos.X, rVec.Y / 5 + Cache.playerPos.Y, rVec.Z / 5 + Cache.playerPos.Z)
      Teleport.tpTo(destVec)
      return nil
      --TODO:Remove it from the list if actor is not there or handle it otherwise
    end

    return actor
  end
end
