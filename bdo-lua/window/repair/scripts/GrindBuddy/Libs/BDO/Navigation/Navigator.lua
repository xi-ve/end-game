function Navigator(navGraph)
    local self = {}
    local _Player = Player
    local _Grinder = Grinder
    --References
    self.navGraph = navGraph
    self.graph_handler = self.navGraph.graph_handler
    self.key_graph_handler = self.navGraph.key_graph_handler

    self.pathfinder = self.navGraph.pathfinder

    self.direct_nav = NewDirectNav()

    self.stopDistance = 200

    self.dest = nil
    self.arrived = false
    self.path = {}
    -- {dest = position, waypoints = {node1,node2,node3,node4}}

    self.reset = function()
        self.dest = nil
        self.arrived = false
        self.path = {}
        self.direct_nav.reset()
    end

    self.moveTo = function(dest, overNodes)
        Log.debugLog("nav moveTo")
        if overNodes == nil then
            overNodes = false
        end

        dest = Vector3(math.floor(dest.X), math.floor(dest.Y), math.floor(dest.Z))

        if overNodes then
            if (not self.dest) or VectorUtils.equal(dest, self.dest) == false then
                self.dest = dest
                self.arrived = false
                self.isNavigating = true
            end
        else
            self.direct_nav.moveTo(dest)
        end
    end

    self.stop = function(dest)
        self.dest = nil
        self.isNavigating = false
        _Player.stopMoving()
    end

    self.direct_moveTo = function(dest)
        Log.debugLog("nav direct_moveTo")
        self.direct_nav.direct_moveTo(dest, false)
        self.onMoveTo()
    end

    self.navigate = function()
        Log.debugLog("nav navigate")

        if self.direct_nav.dest and self.direct_nav.arrived == false then
            --print("here")
            self.direct_nav.navigate()
            if self.path and self.path.waypoints and #self.path.waypoints < 30 then
                self.path.waypoints = {}
            end
            return
        end

        if self.arrived then
            self.arrived = false
            self.stop()
            return true
        end

        if self.dest == nil or not self.isNavigating then
            return false
        end

        --local pPos = Cache.playerPos

        --[[  if not self.overNodes then
            if pPos:getDistance(self.dest) < self.stopDistance then
                self.arrived = true
                self.stop()
            else
                self.direct_moveTo(self.dest)
                --Resetting if T2 Node Nav, to make path a bit faster potentially
                if self.path and self.path.waypoints and self.path.tier_nodes and self.path.tier_nodes.tier2_nodes and #self.path.tier_nodes.tier2_nodes >= 1 then
                    self.path.waypoints = {}
                end
            end
            --if self.path and self.path.waypoints then
            --      self.path.waypoints = {}
            --end
            return
        end]]
        local pPos = _Player.getPos()
        local stopDistance = 125

        --Recalculating path
        --[[if self.path and self.path.dest and self.path.waypoints and #self.path.waypoints > 10 and self.path.tier_nodes and self.path.tier_nodes.tier2_nodes and self.path.tier_nodes.tier3_nodes and self.lastRecalc + 333 < Infinity.Win32:GetTickCount() then
            local removedSth
            self.path.tier_nodes, removedSth = self.updatePath_removeArrived(self.path.tier_nodes)
            if removedSth then
                self.path = self.calculatePath(pPos, self.dest, self.path)
            end
        end]]
        --If new destination
        if (not self.path) or (not self.path.dest) or VectorUtils.equal(self.path.dest, self.dest) == false then
            self.path = self.calculatePath(pPos, self.dest, self.path)
            if
                self.path == nil or
                    ((self.path.waypoints and #self.path.waypoints == 0) and
                        pPos:getDistance(self.dest) > (stopDistance + 50))
             then
                Log.log("Error: Could not find a path to destination. Please check your Navgraph!")
            end

            pPos = nil
            stopDistance = nil

            return true
        end

        if
            self.path and self.path.dest and (not self.path.tier == 0) and self.path.waypoints and
                #self.path.waypoints <= 3 and
                self.lastRecalc + 50 < Infinity.Win32:GetTickCount()
         then
            self.path = self.calculatePath(pPos, self.dest, self.path)
        end

        --Skipping nodes
        if
            self.path.waypoints and #self.path.waypoints > 0 and Grinder.settings.skip_path_nodes and
                (not (Grinder.settings.disable_skip_path_nodes_onTownrun and
                    (Grinder.currentlyDoingTownrun or Grinder.currentlyFinishedTownrun)))
         then
            self.path.waypoints = self.skipNodes(self.path.waypoints)
        end

        local waypoints = self.path.waypoints
        --table.print(waypoints)

        --Actual navigation
        local waypointsLength = 0
        if waypoints then
            waypointsLength = #waypoints
        end

        if waypointsLength == 0 then
            --No waypoints/finished waypoints
            if pPos:getDistance2D(self.dest) < stopDistance then
                self.arrived = true
                self.stop()
            else
                self.path = self.calculatePath(pPos, self.dest, self.path)

                return true
            end
        else
            local nextStopDistance = self.stopDistance
            if waypointsLength > 1 then
                stopDistance = 125
            end

            local nextPos = waypoints[1]

            if pPos:getDistance2D(nextPos) <= nextStopDistance and math.abs(pPos.Y - nextPos.Y) <= 250 then
                table.remove(waypoints, 1)
            else
                --if Raycast.safeTwoPos(pPos, nextPos) then
                --    --Do something to handle objects in the way
                --end
                if (nextPos:getDistance(pPos) > 5555) then
                    Log.log("Direct line to next position in path is way too far away. Resetting path!")
                    Grinder.wait(500) --Waiting 500ms so that if we cannot find a path we do not try to spam this and have -5fps
                    self.path = nil
                    self.direct_nav.dest = nil
                    return true
                end
                self.direct_moveTo(nextPos)
            end

            nextStopDistance = nil
            nextPos = nil
        end

        pPos = nil
        stopDistance = nil
        waypoints = nil
        waypointsLength = nil

        return true
    end

    self.onMoveTo = function()
        Log.debugLog("nav onMoveTo")
        local pPos = Cache.playerPos
        if
            Grinder.currentCombatScript and Grinder.currentCombatScript.onMoveTo and
                Grinder.lastJumpTime + 2000 < Cache.time and
                self.path and
                self.path.waypoints and
                #self.path.waypoints > 0
         then
            --Log.debugLog("onMoveTo callback to combatscript")
            local waypoints = self.path.waypoints
            local onMoveToDest = waypoints[1]
            if Grinder.settings.emulate_human_movement and waypoints and #waypoints > 0 then
                local indexToRemove = {}
                for k, node in ipairs(waypoints) do
                    if node:getDistance(pPos) < 1000 then
                        if not Raycast.safeTwoPos(pPos, node, 40, 80) then
                            table.insert(indexToRemove, (k - 1))
                            onMoveToDest = node
                        end
                    else
                        break
                    end
                end
                if #indexToRemove >= 1 then
                    for k = #indexToRemove, 1, -1 do
                        if k >= 1 then
                            table.remove(self.path.waypoints, k)
                        end
                    end
                end

                indexToRemove = nil
            end
            Grinder.currentCombatScript:onMoveTo(onMoveToDest, true)

            waypoints = nil
            onMoveToDest = nil
        end

        pPos = nil
    end

    self.lastTimeSkippedNodes = 0
    self.skipNodes = function(waypoints)
        Log.debugLog("nav skipNodes")
        if waypoints == nil then
            return {}
        end

        local pPos = Cache.playerPos
        local currentPath = waypoints

        if self.lastTimeSkippedNodes + 521 < Cache.time and Grinder.settings.skip_path_nodes then
            if
                (not (Grinder.settings.disable_skip_path_nodes_onTownrun and
                    (Grinder.currentlyDoingTownrun or Grinder.currentlyFinishedTownrun)))
             then
                self.lastTimeSkippedNodes = Cache.time
                local done = false
                while done == false do
                    if #currentPath > 2 then
                        local nextNode = currentPath[2]
                        if
                            not Raycast.safeTwoPos(pPos, nextNode) and nextNode:getDistance(pPos) < 3250 and
                                math.abs(pPos.Y - nextNode.Y) < 150
                         then
                            table.remove(currentPath, 1)
                        else
                            done = true
                        end

                        nextNode = nil
                    else
                        done = true
                    end
                end

                done = nil
            end
        end

        pPos = nil

        return currentPath
    end

    self.calculatePath_T1 = function(startNode, destNode)
        local waypoints = self.pathfinder.graph:process(startNode, destNode)

        local positions = {}

        for _, v in ipairs(waypoints) do
            table.insert(positions, v.pos)
        end

        waypoints = nil

        return positions
    end

    self.calculatePath_T2 = function(startNode, destNode)
        local waypoints = self.pathfinder.key_graph:process(startNode, destNode)

        local positions = {}

        for _, v in ipairs(waypoints) do
            table.insert(positions, v.pos)
        end

        waypoints = nil

        return positions
    end

    local startNodeFilterFunc = function(pos)
        local pPos = Player.getPos()
        return not Raycast.twoPos(pos, pPos)
    end

    self.createT1Path = function(start, dest)
        --Closest nodes to start
        local closestStartNode = self.graph_handler.getClosestNode(start, true, 50, startNodeFilterFunc)
        --Closest nodes to stop
        local closestDestNode = self.graph_handler.getClosestNode(dest)

        --print("From node " .. closestStartNode.index .. " to node " .. closestDestNode.index)

        --Use T1 nodes directly
        local positions = self.calculatePath_T1(closestStartNode, closestDestNode)
        if positions and #positions > 0 then
            table.insert(positions, dest)
        end

        closestStartNode = nil
        closestDestNode = nil

        return positions
    end

    self.createT2Path = function(start, dest)
        --Closest nodes to start
        local closestStartNode = self.key_graph_handler.getClosestNode(start)
        --Closest nodes to stop
        local closestDestNode = self.key_graph_handler.getClosestNode(dest)

        --Get the path over T2 nodes

        local t2_positions = self.calculatePath_T2(closestStartNode, closestDestNode)
        if #t2_positions > 0 then
            table.insert(t2_positions, dest)
        end

        closestStartNode = nil
        closestDestNode = nil

        return t2_positions
    end

    self.getT1FromT2Path = function(nodes)
        local waypoints
        if nodes and #nodes > 0 then
            local pPos = Player.getPos()
            local nextPos = nodes[1]
            waypoints = self.createT1Path(pPos, nextPos)

            pPos = nil
            nextPos = nil
        end

        return waypoints
    end

    self.removeFirstIfArrived = function(posList, stopDistance)
        local pPos = Player.getPos()
        local removed = false

        if posList and #posList > 0 then
            local distance = posList[1]:getDistance(pPos)
            if distance <= stopDistance then
                table.remove(posList, 1)
                removed = true
            end

            distance = nil
        end

        pPos = nil

        return posList, removed
    end

    self.updatePath_removeArrived = function(nodeList)
        local removed1, removed2
        nodeList.tier3_nodes, removed1 = self.removeFirstIfArrived(nodeList.tier3_nodes, 3500)
        nodeList.tier2_nodes, removed2 = self.removeFirstIfArrived(nodeList.tier2_nodes, 1250)
        return nodeList, (removed1 or removed2)
    end

    self.lastRecalc = 0
    --Creates a path from start to destination, if currentPath is set, it will continue on current path
    self.calculatePath = function(start, dest, currentPath)
        Log.debugLog("nav calculate path")
        self.lastRecalc = Infinity.Win32:GetTickCount()

        local pPos = Player.getPos()

        if start:getDistance2D(dest) < self.stopDistance then
            self.arrived = true
            self.stop()

            pPos = nil

            return {dest = dest, waypoints = {dest}, tier = 0, tier_nodes = {tier2_nodes = {}, tier3_nodes = {}}}
        end

        --We return this later as the path, put coords to move to in here
        local positions = {}

        local tier_nodes = nil
        if
            currentPath ~= nil and currentPath.dest and VectorUtils.equal(currentPath.dest, dest) and
                currentPath.waypoints and
                currentPath.tier and
                currentPath.tier_nodes.tier3_nodes and
                currentPath.tier_nodes.tier2_nodes
         then
            tier_nodes = currentPath.tier_nodes
        else
            tier_nodes = {tier2_nodes = {}, tier3_nodes = {}}
            currentPath = {}
            currentPath.tier = -1
        end

        local tierToUse
        if currentPath.tier == 0 then
            --Direct path
            positions = {dest}
        elseif currentPath.tier ~= -1 then
            tierToUse = currentPath.tier
            local removedSth
            tier_nodes, removedSth = self.updatePath_removeArrived(tier_nodes)
            if removedSth then
                --currentPath.waypoints = {}
                removedSth = nil
            end

            if tierToUse == 2 then
                if currentPath.waypoints and #currentPath.waypoints == 0 then
                    --We have no T1 nodes in Path, so we check T2 nodes
                    if #tier_nodes.tier2_nodes == 0 then
                        --We have no T2 Nodes, so we just need to move straight to dest
                        positions = {dest}
                    else
                        --#tier_nodes.tier2_nodes > 0 here, creating T1 from T2
                        positions = self.getT1FromT2Path(tier_nodes.tier2_nodes)
                    end
                else
                    positions = currentPath.waypoints
                end
            else
                if currentPath.waypoints and #currentPath.waypoints == 0 then
                    positions = self.createT1Path(start, dest)
                else
                    positions = currentPath.waypoints
                end
            end
        else
            --Check if direct path is possible
            if
                start:getDistance(dest) < 1850 and not Raycast.safeTwoPos(start, dest, 60, 60) and
                    not Grinder.currentlyDoingTownrun
             then
                tierToUse = 0
                positions = {dest}
            else
                tierToUse = self.calculatePath_decideTierToUse(start, dest)
                --Deciding on Tier of Nodes to use
                if Grinder.settings.log_verbose then
                    Log.log("Using Tier " .. tierToUse .. " nodes for navigation!")
                end
                if tierToUse == 2 then
                    --Use T2 nodes and then calculate path to next T2 over T1
                    tier_nodes.tier2_nodes = self.createT2Path(start, dest)
                    if #tier_nodes.tier2_nodes > 0 then
                        positions = self.getT1FromT2Path(tier_nodes.tier2_nodes)
                    else
                        tierToUse = 1
                        positions = self.createT1Path(start, dest)
                    end
                else
                    positions = self.createT1Path(start, dest)
                end
            end
        end

        --TODO:Human nav/Path modifications
        if Grinder.settings.emulate_human_movement then
            positions = self.modPathHumanLike(positions)
        end

        --newpath, tier_nodes = {tier2_nodes = {}, tier3_nodes = {}}, waypoints are T1 nodes
        local newPath = {dest = dest, waypoints = positions, tier = tierToUse, tier_nodes = tier_nodes}
        --table.print(newPath)
        return newPath
    end

    self.calculatePath_decideTierToUse = function(start, dest)
        --[[

        local pPos = Player.getPos()

        --Closest nodes to start
        local closestT1StartNode = self.graph_handler.getClosestNode(start)
        local closestT1StartNode_Distance = pPos:getDistance(closestT1StartNode.pos)

        local closestT2StartNode = self.key_graph_handler.getClosestNode(start)
        local closestT2StartNode_Distance = pPos:getDistance(closestT2StartNode.pos)



        --Closest nodes to stop
        local closestT1StopNode = self.graph_handler.getClosestNode(dest)
        local closestT1StopNode_Distance = pPos:getDistance(closestT1StopNode.pos)

        local closestT2StopNode = self.key_graph_handler.getClosestNode(dest)
        local closestT2StopNode_Distance = pPos:getDistance(closestT2StopNode.pos)
]]
        --Distance start -> stop
        local startStopDist = start:getDistance(dest)

        --Tier of Nodes to use (Confidence lower to 0 is best) and calculate path -- Old
        --local T1_confidence = (closestT1StartNode_Distance / self.navGraph.minDistanceBetweenNodes_T1) + (closestT1StopNode_Distance / self.navGraph.minDistanceBetweenNodes_T1) + startStopDist
        --local T2_confidence = (closestT2StartNode_Distance / self.navGraph.minDistanceBetweenNodes_T2 / 3) + (closestT2StopNode_Distance / self.navGraph.minDistanceBetweenNodes_T2 / 3) + startStopDist * 0.6

        --Tier of Nodes to use (Confidence lower is best) and calculate path
        local T1_confidence = 1500 + startStopDist --500 + startStopDist
        local T2_confidence = 5500 + startStopDist * 0.8 -- 1500 + startStopDist * 0.7

        --print("T1 confidence:" .. T1_confidence)
        --print("T2 confidence:" .. T2_confidence)

        --Deciding on Tier of Nodes to use
        if T2_confidence < T1_confidence and #self.navGraph.key_graph_handler.graph.nodes > 0 then
            T1_confidence = nil
            T2_confidence = nil
            return 2
        else
            T1_confidence = nil
            T2_confidence = nil
            return 1
        end
    end

    self.modPathHumanLike = function(currentPath)
        if Teleport.isTpAllowed() then
            return currentPath
        end

        --Log.debugLog("navigator modPathHumanLike")
        if not currentPath then
            return {}
        end

        local strength_node_amount = Grinder.settings.interpolation_movement_smoothness
        local smoothness = Grinder.settings.interpolation_path_smoothness

        local destPos = currentPath[#currentPath]

        local pPos = Player.getPos()

        local path = {}
        local pathLength = #currentPath
        if pathLength >= 2 then
            for k = 1, pathLength - 1 do
                local node = currentPath[k]
                --if pPos:getDistance(node) < 4000 then
                local nextNode = currentPath[k + 1]
                local connectionVec = VectorUtils.subtract(nextNode, node)
                local connectionVecLength = VectorUtils.getLength(connectionVec)
                local amountOfNodes = math.floor(strength_node_amount * (connectionVecLength / 400)) - 1
                local stepVec = VectorUtils.divide(connectionVec, amountOfNodes)
                table.insert(path, node)
                local lastInserted = node
                if amountOfNodes >= 1 then
                    for i = 1, amountOfNodes do
                        local nextStepNode = VectorUtils.addition(lastInserted, stepVec)
                        table.insert(path, nextStepNode)
                        lastInserted = nextStepNode

                        nextStepNode = nil
                    end
                end
                --else
                --    table.insert(path, node)
                --end

                node = nil
                nextNode = nil
                connectionVec = nil
                connectionVecLength = nil
                amountOfNodes = nil
                stepVec = nil
                lastInserted = nil
            end
        end

        --local path = currentPath

        if smoothness >= 1 then
            for j = 1, smoothness do
                local newPath = {}
                pathLength = #path --reusing local var

                local pRot = Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():getRotation()

                local backwardsVec = VectorUtils.multiply(Vector3(math.cos(pRot), math.sin(pRot), math.tan(pRot)), (-1))

                local thirdPreviousNode = VectorUtils.addition(pPos, VectorUtils.multiply(backwardsVec, 2))
                local twoPreviousNode = VectorUtils.addition(pPos, backwardsVec)
                local previousNode = path[1]
                local startNode = path[2]
                local nextNode = path[3]
                local twoNextNode = path[4]
                local thirdNextNode = path[5]
                local fourthNextNode = nil

                if pathLength >= 1 then
                    for k = 1, pathLength do
                        thirdPreviousNode = twoPreviousNode
                        twoPreviousNode = previousNode
                        previousNode = startNode
                        startNode = nextNode
                        nextNode = twoNextNode
                        twoNextNode = thirdNextNode

                        if startNode == nil then
                            break
                        end

                        local newThirdNextNode = path[k + 3]
                        if newThirdNextNode ~= nil then
                            thirdNextNode = newThirdNextNode
                        else
                            thirdNextNode = nil
                        end

                        if thirdPreviousNode == nil then
                            thirdPreviousNode = twoPreviousNode
                        end

                        if twoPreviousNode == nil then
                            twoPreviousNode = previousNode
                            thirdPreviousNode = previousNode
                        end

                        if previousNode == nil then
                            previousNode = startNode
                            twoPreviousNode = startNode
                            thirdPreviousNode = startNode
                        end

                        if nextNode == nil then
                            nextNode = startNode
                            twoNextNode = startNode
                            thirdNextNode = startNode
                            fourthNextNode = startNode
                        end

                        if twoNextNode == nil then
                            twoNextNode = nextNode
                            thirdNextNode = nextNode
                            fourthNextNode = nextNode
                        end

                        if thirdNextNode == nil then
                            thirdNextNode = twoNextNode
                        end

                        --Calculating coords of new node.
                        local newNode =
                            self.interpolate(
                            thirdPreviousNode,
                            twoPreviousNode,
                            previousNode,
                            startNode,
                            nextNode,
                            twoNextNode,
                            thirdNextNode
                        )

                        table.insert(newPath, newNode)

                        newNode = nil
                    end
                end

                path = newPath

                pRot = nil
                pathLength = nil
                backwardsVec = nil

                thirdPreviousNode = nil
                twoPreviousNode = nil
                previousNode = nil
                startNode = nil
                nextNode = nil
                twoNextNode = nil
                thirdNextNode = nil

                newPath = nil
            end
        end

        table.insert(path, destPos)

        strength_node_amount = nil
        smoothness = nil
        destPos = nil
        pPos = nil

        return path
    end

    self.findGoodNodePos = function(previous, pos)
        local pPos = Player.getPos()
        local prevToPlayerDist = previous:getDistance(pPos)
        local posToPlayerDist = pos:getDistance(pPos)
        if prevToPlayerDist > 3000 or posToPlayerDist > 3000 then
            pPos = nil
            prevToPlayerDist = nil
            posToPlayerDist = nil

            return pos
        end

        local stepSize = 10
        for yMod = -70, 70, stepSize do
            local newPos = Vector3(pos.X, pos.Y + (-1 * yMod), pos.Z)
            if Raycast.twoPos(previous, newPos, 20) then
                pPos = nil
                prevToPlayerDist = nil
                posToPlayerDist = nil
                return Vector3(pos.X, pos.Y + ((-1 * yMod) + stepSize), pos.Z)
            end
        end

        pPos = nil
        prevToPlayerDist = nil
        posToPlayerDist = nil

        return Vector3(pos.X, pos.Y - 70, pos.Z)
    end

    --p3 is current node
    self.interpolate = function(p0, p1, p2, p3, p4, p5, p6)
        local toString = VectorUtils.toString

        local add = VectorUtils.addition
        local sub = VectorUtils.subtract
        local mul = VectorUtils.multiply
        local div = VectorUtils.divide

        local a = sub(p1, p0)
        local b = sub(p2, p1)
        local c = sub(p3, p2)
        local d = sub(p4, p3)
        local e = sub(p5, p4)
        local f = sub(p6, p5)

        local x0 = (1 * p3.X + add(p0, mul(a, 0.05)).X) / 3
        local x1 = (1 * p3.X + add(p1, mul(b, 0.20)).X) / 3
        local x2 = (4 * p3.X + add(p2, mul(c, 0.25)).X) / 3
        local x3 = (4 * p3.X + add(p3, mul(d, 0.25)).X) / 3
        local x4 = (1 * p3.X + add(p4, mul(e, 0.20)).X) / 3
        local x5 = (1 * p3.X + add(p5, mul(f, 0.05)).X) / 3

        local newX = (x0 + x1 + x2 + x3 + x4 + x5) / 6

        local y0 = (1 * p3.Y + add(p0, mul(a, 0.05)).Y) / 3
        local y1 = (1 * p3.Y + add(p1, mul(b, 0.10)).Y) / 3
        local y2 = (4 * p3.Y + add(p2, mul(c, 0.35)).Y) / 3
        local y3 = (4 * p3.Y + add(p3, mul(d, 0.35)).Y) / 3
        local y4 = (1 * p3.Y + add(p4, mul(e, 0.10)).Y) / 3
        local y5 = (1 * p3.Y + add(p5, mul(f, 0.05)).Y) / 3

        local newY = (y0 + y1 + y2 + y3 + y4 + y5) / 6

        local z0 = (1 * p3.Z + add(p0, mul(a, 0.05)).Z) / 3
        local z1 = (1 * p3.Z + add(p1, mul(b, 0.20)).Z) / 3
        local z2 = (4 * p3.Z + add(p2, mul(c, 0.25)).Z) / 3
        local z3 = (4 * p3.Z + add(p3, mul(d, 0.25)).Z) / 3
        local z4 = (1 * p3.Z + add(p4, mul(e, 0.20)).Z) / 3
        local z5 = (1 * p3.Z + add(p5, mul(f, 0.05)).Z) / 3

        local newZ = (z0 + z1 + z2 + z3 + z4 + z5) / 6

        local newNode = Vector3(newX, newY, newZ)
        --newNode = p3

        --print("p3: " .. toString(p2) .. " | newNode: " .. toString(newNode))

        add = nil
        sub = nil
        mul = nil
        div = nil
        a = nil
        b = nil
        c = nil
        d = nil
        e = nil
        f = nil
        x0 = nil
        x1 = nil
        x2 = nil
        x3 = nil
        x4 = nil
        x5 = nil
        newX = nil
        y0 = nil
        y1 = nil
        y2 = nil
        y3 = nil
        y4 = nil
        y5 = nil
        newY = nil
        z0 = nil
        z1 = nil
        z2 = nil
        z3 = nil
        z4 = nil
        z5 = nil
        newZ = nil

        return newNode
    end

    return self
end
