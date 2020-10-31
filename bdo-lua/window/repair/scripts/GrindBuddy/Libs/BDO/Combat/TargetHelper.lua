function TargetHelper.getHp(actor)
    Log.debugLog("TargetHelper getHp")
    --local code = [[
    --local actorProxy = getActor(]] .. actorKey .. [[):get()
    --return actorProxy:getHp()
    --]]
    if actor and ActorUtils.isValidActor(actor) and (not actor:getIsDead()) then
        --Log.debugLog("Target hp: " .. actorHp)
        return actor:getHp()
    else
        --Log.debugLog("Target hp: 0 (actor == nil or not valid)")
        return 0
    end
end

function TargetHelper.getClosestAttackingMonsters(tMonsters)
    Log.debugLog("TargetHelper getClosestAttackingMonsters")
    local buffer = {}

    local lpPos = Infinity.BDO.getLocalPlayer():getPosition()

    for k, v in pairs(tMonsters) do
        if not v:getIsDead() and TargetHelper.isAttacking(v) then
            table.insert(buffer, v)
        end
    end

    if table.length(buffer) == 0 then
        lpPos = nil
        buffer = nil
        return nil
    end

    table.sort(buffer, function(a, b) return a:getPosition():getDistance(lpPos) < b:getPosition():getDistance(lpPos) end)
    lpPos = nil

    return buffer
end
