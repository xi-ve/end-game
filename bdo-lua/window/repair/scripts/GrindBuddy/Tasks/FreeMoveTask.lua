FreeMoveTask = {}


FreeMoveTask.gridSize = 4000
FreeMoveTask.gridBoxSize = 100

FreeMoveTask.endDest = nil
FreeMoveTask.endDestPathavailable = false
FreeMoveTask.needTo = false
FreeMoveTask.initTime = 0

FreeMoveTask.recalcPathTime = 0
FreeMoveTask.lastRecalcPathPos = Vector3(0, 0, 0)
FreeMoveTask.lastRecalcPathEndPos = Vector3(0, 0, 0)

FreeMoveTask.lastJumpTime = 0

FreeMoveTask.path = {}
FreeMoveTask.arrived = false
FreeMoveTask.finishedRunningOnPath = false
FreeMoveTask.nextDest = Vector3(0, 0, 0)

FreeMoveTask.nodesCenter = nil
FreeMoveTask.nodes = {}

FreeMoveTask.lastStuckCheck = 0
FreeMoveTask.lastStuckCheckPos = Vector3(0, 0, 0)
FreeMoveTask.lastStuckAttackMob = true

FreeMoveTask.lastTpTime = 0

FreeMoveTask.stuckStartTime = 0
FreeMoveTask.stuckAlready = false



function FreeMoveTask.init(dest)
    Log.debugLog("FreeMoveTask init")
    if dest == nil then
        return false
    end

    FreeMoveTask.reset()
    FreeMoveTask.endDest = dest
    FreeMoveTask.needTo = true
    return true
end

function FreeMoveTask.reset()
    Log.debugLog("FreeMoveTask reset")
    FreeMoveTask.endDest = nil
    FreeMoveTask.needTo = false
    FreeMoveTask.initTime = 0

    FreeMoveTask.recalcPathTime = 0

    FreeMoveTask.path = {}
    FreeMoveTask.arrived = false
    FreeMoveTask.finishedRunningOnPath = false
    FreeMoveTask.nextDest = Vector3(0, 0, 0)
end

function FreeMoveTask.work()
    Log.debugLog("FreeMoveTask work")
    if not FreeMoveTask.endDest then
        return
    end
    if Cache.playerPos:getDistance(FreeMoveTask.endDest) < 150 then
        FreeMoveTask.reset()
        Player.stopMoving()
        return
    end
    Player.moveTo(FreeMoveTask.endDest)
end

function FreeMoveTask.findDest(needToBeAbleToMoveToPos)

end

function FreeMoveTask.recalculatePath()

end

function FreeMoveTask.getClosestNodeIndex(pos)

end

function FreeMoveTask.recalculateNodes(forcing)

end

function FreeMoveTask.hasJumpableObstacle(from, to)

end

-- determines which neighbors are valid (in range and raycast)
FreeMoveTask.valid_node_func = function (node, neighbor)

end
