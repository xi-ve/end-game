--[[ MoveToActorTask = {}

function MoveToActorTask.needToRun()
    if not Grinder.currenTargetKey then
        return false
    end

    local selfPlayerPos = Players.getPos()
    if not selfPlayerPos then
        return false
    end

    if Player.me():isDead() then
        return false
    end

    local findActor = ActorUtils.getActor(Grinder.currentTargetKey)
    if not findActor then
        return false
    end

    local targetActor = findActor:get()
    if not targetActor then
        return false
    end

    return true
end

function MoveToActorTask.work()
    if not MoveToActorTask.needToRun() then
        return true
    end

    local selfPlayerPos = Players.getPos()
    local findActor = ActorUtils.getActor(Grinder.currentTargetKey)
    local targetActor = findActor:get()

    stopDistance = Grinder.currentCombatScript:getCombatRange() + targetActor:getBodySize()
    actorPos = targetActor:getPosition();

    if selfPlayerPos:getDistance(actorPos) > stopDistance then
        if selfPlayerPos:getDistance(actorPos) < 500
        and not Raycast.twoPos(selfPlayerPos, actorPos)
        then
            Grinder.currentDest = actorPos
            Grinder.currentDestIsNode = false
        else
            Grinder.currentDest = actorPos
            Grinder.currentDestIsNode = true
        end
        return false
    end

    Grinder.currentDest = nil
    Grinder.currentDestIsNode = nil
    return true
end]]
