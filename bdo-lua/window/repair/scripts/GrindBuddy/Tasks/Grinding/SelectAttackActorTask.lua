SelectAttackActorTask = {}

SelectAttackActorTask.lastChanged = 0
SelectAttackActorTask.lastSelectedActorKey = nil

--Returns true if there is an enemy in range and false when there is none, sets Grinder.currentTargetKey
function SelectAttackActorTask.work()
    Log.debugLog("SelectAttackActorTask work")

    local currentTargetKey = Grinder.currentTargetKey
    local key = nil

    if SelectAttackActorTask.lastChanged + 23 < Cache.time then --Only update ~40 times per second

        --[[if currentTargetKey and SelectAttackActorTask.lastChanged + 1295 > Cache.time then
            local currentTargetActor = ActorUtils.getActor(currentTargetKey)
            if currentTargetActor and currentTargetActor:isValid() then
                local currentTargetHp = TargetHelper.getHp(currentTargetActor)
                if currentTargetHp and currentTargetHp > 0 and (not Grinder.mobBlacklist[currentTargetKey] or Grinder.mobBlacklist[currentTargetKey] < Cache.time) then
                    return true
                end
            end
        end]]

        local targetActor = nil
        local targetActorDistance = 1 / 0
        local playerPos = Cache.playerPos

        for _, actor in pairs(Cache.mobsInRange) do
            if actor and ActorUtils.isValidActor(actor) then
                local actorDistance = actor:getPosition():getDistance(playerPos)
                if actorDistance < 4000 then
                    if (actorDistance < targetActorDistance) and ((not Grinder.mobBlacklist[actor:getActorKey()]) or Grinder.mobBlacklist[actor:getActorKey()] < Cache.time) and not Raycast.twoPos(Cache.playerPos, actor:getPosition()) and ActorUtils.isValidActor_ByKey(actor:getActorKey()) then
                        targetActor = actor
                        targetActorDistance = actorDistance
                    end
                end

                actorDistance = nil
            end
        end


        if targetActor and ActorUtils.isValidActor(targetActor) and TargetHelper.isAttackable(targetActor) then
            local tempKey = targetActor:getActorKey()
            local targetHp = TargetHelper.getHp(targetActor)
            if targetHp and targetHp > 0 then
                key = tempKey
            end

            tempKey = nil
            targetHp = nil
        end

        if key ~= nil then
            Log.debugLog("Selected mob with key " .. key .. " as target!")
            if Grinder.settings.log_verbose and key ~= SelectAttackActorTask.lastSelectedActorKey then
                Log.log("Selected mob with key " .. key .. " as next target!")
            end
            Grinder.currentTargetKey = key
            SelectAttackActorTask.lastSelectedActorKey = key
            SelectAttackActorTask.lastChanged = Cache.time
        else
            Grinder.currentTargetKey = nil
        end

        targetActor = nil
        targetActorDistance = nil
        playerPos = nil

    end

    if key ~= nil and key ~= SelectAttackActorTask.lastSelectedActorKey then
        --Grinder.allInputUp()
        Grinder.wait(250)
        Input.waitForReset()
        --return false ??
    end

    currentTargetKey = nil
    key = nil

    return Grinder.currentTargetKey ~= nil

end
