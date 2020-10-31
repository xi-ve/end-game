MoveToAttackActorTask = {}

MoveToAttackActorTask.returnLastTime = false
MoveToAttackActorTask.lastTimeUpdated = 0

function MoveToAttackActorTask.needToRun()
    Log.debugLog("MoveToAttackActorTask needToRun")

end

--returns true when in arrived, returns false when not
function MoveToAttackActorTask.work()
    Log.debugLog("MoveToAttackActorTask work")

    if MoveToAttackActorTask.lastTimeUpdated + 50 > Cache.time then --Only update it 20 times a second
        return MoveToAttackActorTask.returnLastTime
    end

    MoveToAttackActorTask.lastTimeUpdated = Cache.time


    if not Grinder.currentTargetKey then
        MoveToAttackActorTask.returnLastTime = false
        return false
    end

    if not Cache.playerPos then
        MoveToAttackActorTask.returnLastTime = false
        return false
    end

    if Player.me():getIsDead() then
        MoveToAttackActorTask.returnLastTime = false
        return false
    end

    local targetActor = ActorUtils.getActor(Grinder.currentTargetKey)
    if not targetActor or not ActorUtils.isValidActor(targetActor) then
        MoveToAttackActorTask.returnLastTime = false

        targetActor = nil
        return false
    end

    local targetBodySize = 0
    local stopDistance = Grinder.currentCombatScript:getCombatRange() + targetBodySize
    local actorPos = targetActor:getPosition()

    if Cache.playerPos:getDistance(actorPos) < stopDistance then
        --Arrived
        MoveToAttackActorTask.returnLastTime = true

        targetBodySize = nil
        stopDistance = nil
        actorPos = nil
        targetActor = nil

        return true
    end

    --Log.log("MoveToAttackActorTask: currentDest => " .. VectorUtils.toString(actorPos))
    Grinder.currentDest = actorPos
    Grinder.currentDestIsNode = false

    targetActor = nil
    targetBodySize = nil
    stopDistance = nil
    actorPos = nil
    targetActor = nil


    MoveToAttackActorTask.returnLastTime = false
    return false

end
