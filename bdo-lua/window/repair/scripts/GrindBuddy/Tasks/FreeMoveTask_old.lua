FreeMoveTask = {}


FreeMoveTask.gridSize = 4000
FreeMoveTask.gridBoxSize = 100

FreeMoveTask.endDest = Vector3(0, 0, 0)
FreeMoveTask.endDestPathAvaible = false
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
    --resetting everything

    if dest.X == FreeMoveTask.endDest.X and dest.Y == FreeMoveTask.endDest.Y then
        return true
    end

    FreeMoveTask.reset()

    --Log.log("FreeMoveTask: New init!")
    FreeMoveTask.endDest = Vector3(dest.X, dest.Y, dest.Z)
    --[[if not FreeMoveTask.nodes or #FreeMoveTask.nodes == 0 or not FreeMoveTask.nodesCenter then
        FreeMoveTask.recalculateNodes()
    end
    if FreeMoveTask.endDest:getDistance(FreeMoveTask.nodesCenter) > FreeMoveTask.gridSize / 3 then
        FreeMoveTask.recalculateNodes(true)
    end]]



    if (FreeMoveTask.endDest:getDistance(Cache.playerPos) > FreeMoveTask.gridSize / 2) then
        --Target is too far away and not reachable over current node mesh
        if (Grinder.currentProfile) then
            Grinder.currentDest = VectorUtils.tableToVector3(Grinder.currentProfile.navGraph.nodes[Grinder.currentProfile.navGraph.getClosestNode(FreeMoveTask.endDest)])
            FreeMoveTask.reset()
            FreeMoveTask.endDestPathAvaible = false
            --Log.log("FreeMoveTask: Nah!")
            return false
        else
            Log.log("Cannot reach currently set FreeMove destination since it is too far away and not reachable over the currently set mesh!")
        end
    end

    FreeMoveTask.recalculatePath()
    if not FreeMoveTask.path or #FreeMoveTask == 0 then
        Grinder.currentDest = VectorUtils.tableToVector3(Grinder.currentProfile.navGraph.nodes[Grinder.currentProfile.navGraph.getClosestNode(FreeMoveTask.endDest)])
        FreeMoveTask.reset()
        FreeMoveTask.endDestPathAvaible = false
        return
    end


    FreeMoveTask.needTo = true
    FreeMoveTask.arrived = false
    FreeMoveTask.finishedRunningOnPath = false
    FreeMoveTask.initTime = Cache.time

    return true
end

function FreeMoveTask.reset()
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
    --[[if (Grinder.currentDest ~= FreeMoveTask.endDest) then
        Log.log("Dest changed, stopping FreeMoveTask")
        Log.log("From " .. VectorUtils.toString(FreeMoveTask.endDest) .. " to " .. .. VectorUtils.toString(Grinder.currentDest))
        FreeMoveTask.arrived = true --Not really arrived, but destination changed, so we just reset everything
    end]]


    if FreeMoveTask.arrived then
        --Log.log("FreeMoveTask arrived!")
        FreeMoveTask.reset()
        return
    end

    if FreeMoveTask.endDest == nil then
        FreeMoveTask.arrived = true
        return nil
    end

    if
    (FreeMoveTask.lastRecalcPathEndPos.X ~= FreeMoveTask.endDest.X
    and FreeMoveTask.lastRecalcPathEndPos.Z ~= FreeMoveTask.endDest.Z)
    or
    (FreeMoveTask.recalcPathTime + 9876 < Cache.time)
    --and Cache.playerPos:getDistance2D(FreeMoveTask.lastRecalcPathPos) > 350
    then
        FreeMoveTask.recalculatePath()
    end

    if FreeMoveTask.nextDest and FreeMoveTask.lastJumpTime + 2054 < Cache.time and FreeMoveTask.hasJumpableObstacle(Cache.playerPos, FreeMoveTask.nextDest) then
        FreeMoveTask.lastJumpTime = Cache.time
        if not Infinity.BDO.Input.isEmptyQueue() then
            Infinity.BDO.Input.clearQueue()
        end
        Infinity.BDO.Input.PressKeys_Once({KeyCode_W, KeyCode_SPACE}, 75)
    end

    --Unstuck
    if FreeMoveTask.lastStuckCheck + 98 < Cache.time then
        local distDiff = Cache.playerPos:getDistance2D(FreeMoveTask.lastStuckCheckPos)
        FreeMoveTask.lastStuckCheck = Cache.time
        FreeMoveTask.lastStuckCheckPos = Cache.playerPos
        if (distDiff < 30) then
            --Log.log("Something is blocking us that is not detected by raycast. Maybe a mob?")
            local closestMob = nil
            local closestMobDistance = 1 / 0
            for k, v in ipairs(Cache.mobsInRange) do
                if ActorUtils.isValidActor(v) then
                    local distance = Cache.playerPos:getDistance2D(v:getPosition())
                    if distance < closestMobDistance then
                        closestMob = v
                        closestMobDistance = distance
                    end
                end
            end
            if closestMob and closestMobDistance < 400 then
                --Log.log("Stuck but found mob! Attacking... Distance is: " .. closestMobDistance)
                local closestMobKey = closestMob:getActorKey()
                if Grinder.currentCombatScript and type(Grinder.currentCombatScript.combat) == "function" then
                    Grinder.currentTargetKey = closestMobKey
                    Grinder.currentCombatScript:combat(closestMobKey)
                    FreeMoveTask.lastStuckAttackMob = true
                    return
                else
                    Log.log("Error: No combat script selected!")
                    FreeMoveTask.lastStuckAttackMob = false
                    return
                end
            else
                --Log.log("Closest mob distance is: " .. tostring(closestMobDistance))
                if FreeMoveTask.lastStuckAttackMob then
                    FreeMoveTask.lastStuckAttackMob = false
                else
                    if not FreeMoveTask.stuckAlready then
                        FreeMoveTask.stuckAlready = true
                        FreeMoveTask.stuckStartTime = Cache.time
                    else
                        if FreeMoveTask.stuckStartTime + 2125 < Cache.time then
                            if FreeMoveTask.lastTpTime + 1874 < Cache.time then
                                if Cache.playerPos:getDistance(FreeMoveTask.nextDest) < 250 then
                                    Teleport.tpTo(FreeMoveTask.nextDest)
                                    return
                                elseif Cache.playerPos:getDistance(FreeMoveTask.endDest) < 250 then
                                    Teleport.tpTo(FreeMoveTask.endDest)
                                    return
                                end
                                FreeMoveTask.lastTpTime = Cache.time
                            end
                            FreeMoveTask.lastStuckAttackMob = false
                            return
                        end
                    end
                end
            end
        end
    end

    FreeMoveTask.stuckAlready = false

    if FreeMoveTask.path and #FreeMoveTask.path > 0 and FreeMoveTask.arrived == false then
        FreeMoveTask.nextDest = FreeMoveTask.path[1]
        local nextStopDistance = 150
        if Cache.playerPos:getDistance2D(FreeMoveTask.nextDest) <= nextStopDistance and Cache.playerPos:getDistance(FreeMoveTask.nextDest) <= 500 then
            table.remove(FreeMoveTask.path, 1)
            if #FreeMoveTask.path ~= 0 then
                Player.moveTo(FreeMoveTask.path[1])
                return
            else
                FreeMoveTask.finishedRunningOnPath = true
                FreeMoveTask.nextDest = FreeMoveTask.endDest
                Player.moveTo(FreeMoveTask.nextDest)
                return
            end

        else
            Player.moveTo(FreeMoveTask.nextDest)
            return
        end
    else
        if not FreeMoveTask.arrived then
            if Cache.playerPos:getDistance2D(FreeMoveTask.endDest) < 75 then
                FreeMoveTask.arrived = true
                return
            else
                Player.moveTo(FreeMoveTask.endDest)
                return
            end
        end
    end

end

function FreeMoveTask.recalculatePath()
    Log.log("Calculating path to destination! [Could lag!]")
    FreeMoveTask.recalculateNodes()
    local pPos = Cache.playerPos
    local startPosNode = FreeMoveTask.nodes[FreeMoveTask.getClosestNodeIndex(pPos)]
    local endPosNode = FreeMoveTask.nodes[FreeMoveTask.getClosestNodeIndex(FreeMoveTask.endDest)]

    FreeMoveTask.path = AStar.path(startPosNode, endPosNode, FreeMoveTask.nodes, FreeMoveTask.valid_node_func)
    if FreeMoveTask.path == nil then
        Log.log("Did not find path to destination!")
        FreeMoveTask.needTo = false
        Grinder.currentDest = FreeMoveTask.endDest
    else
        Log.debugLog("#FreeMoveTask.path: " .. #FreeMoveTask.path)
    end
    FreeMoveTask.recalcPathTime = Cache.time
    FreeMoveTask.lastRecalcPathPos = Cache.playerPos
    FreeMoveTask.lastRecalcPathEndPos = FreeMoveTask.endDest
end

function FreeMoveTask.getClosestNodeIndex(pos)
    Log.debugLog("Getting closest node to " .. VectorUtils.toString(pos))
    pos = Vector3(pos.X, pos.Y, pos.Z)
    local closestNodeIndex = nil
    local closestNodeDistance = 1 / 0
    for k, v in ipairs(FreeMoveTask.nodes) do
        local distance = v:getDistance(pos)
        if distance < closestNodeDistance then
            closestNodeIndex = k
            closestNodeDistance = v:getDistance(pos)
        end
    end
    return closestNodeIndex
end

function FreeMoveTask.recalculateNodes(forcing)
    forcing = forcing or false
    --repositioning grid if needed, if not, return since we will use current grid, but only if there are already nodes
    --[[Conditions to recalulate nodes:
    *Current center is further away than 5000
    *No nodes calculated
    ]]
    if not forcing and FreeMoveTask.nodesCenter and #FreeMoveTask.nodes > 0 and FreeMoveTask.nodesCenter:getDistance(Cache.playerPos) < FreeMoveTask.gridSize / 4 then
        --NEED to recalc if y value changed too much
        if (-200) < FreeMoveTask.nodesCenter.Y - Cache.playerPos.Y and FreeMoveTask.nodesCenter.Y - Cache.playerPos.Y < 200 then
            return
        end
    end
    if Grinder.settings.log_verbose or Grinder.settings.log_debug then
        Log.log("Recalculating navigation nodes [Could lag!]")
    end
    --[[if (FreeMoveTask.nodesCenter) then
        Log.log("Doing this because: ")
        Log.log("FreeMoveTask.nodesCenter: " .. tostring(FreeMoveTask.nodesCenter))
        Log.log("#FreeMoveTask.nodes: " .. tostring(#FreeMoveTask.nodes))
        Log.log("FreeMoveTask.nodesCenter:getDistance(Cache.playerPos): " .. tostring(FreeMoveTask.nodesCenter:getDistance(Cache.playerPos)))
        Log.log("FreeMoveTask.nodesCenter.Y - Cache.playerPos.Y: " .. tostring(FreeMoveTask.nodesCenter.Y - Cache.playerPos.Y))
    end]]
    FreeMoveTask.nodesCenter = Cache.playerPos

    FreeMoveTask.nodes = {}
    local x = math.floor(FreeMoveTask.nodesCenter.X - (FreeMoveTask.gridSize / 2))
    local xStop = math.floor(FreeMoveTask.nodesCenter.X + (FreeMoveTask.gridSize / 2))
    local zStart = math.floor(FreeMoveTask.nodesCenter.Z - (FreeMoveTask.gridSize / 2))
    local zStop = math.floor(FreeMoveTask.nodesCenter.Z + (FreeMoveTask.gridSize / 2))
    local y = math.floor(FreeMoveTask.nodesCenter.Y + 50)

    while (x < xStop) do
        local z = zStart
        while (z < zStop) do
            table.insert(FreeMoveTask.nodes, Vector3(x, y, z))
            z = z + FreeMoveTask.gridBoxSize
        end
        x = x + FreeMoveTask.gridBoxSize
    end
end

function FreeMoveTask.hasJumpableObstacle(from, to)
    local objectInWay = Raycast.safeTwoPos(from, to)
    if objectInWay then
        local rVec = from:getDirectionVector(to)
        local maxHeightAddition = 100
        for heightAddition = 0, maxHeightAddition, 10 do
            if not Raycast.twoPos(from, Vector3(to.X, to.Y + heightAddition, to.Z), 100) then
                return true
            end
        end
    end
    return false
end

-- determines which neighbors are valid (in range and raycast)
FreeMoveTask.valid_node_func = function (node, neighbor)
    local MAX_DIST = 310
    local MAX_PLAYER_DIST = 1500

    if AStar.distance(node.X, node.Y, node.Z, neighbor.X, neighbor.Y, neighbor.Z) > MAX_PLAYER_DIST then
        return flase
    end

    if AStar.distance(node.X, node.Y, node.Z, neighbor.X, neighbor.Y, neighbor.Z) < MAX_DIST then
        if not Raycast.safeTwoPos(Vector3(node.X, node.Y, node.Z), Vector3(neighbor.X, neighbor.Y, neighbor.Z)) then
            return true
        end
    end
    return false
end
