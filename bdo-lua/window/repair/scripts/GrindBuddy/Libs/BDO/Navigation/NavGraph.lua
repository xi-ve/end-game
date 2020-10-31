NavGraph = function()
    local _n = {}
    _n.Node = NodeConstructor()



    _n.forceAddT1Node = false
    _n.forceAddT2Node = false
    _n.pseudoMeshCreation = false

    _n.minDistanceBetweenNodes_T1 = 0
    _n.edgeMaxDistance_T1 = 0

    _n.minDistanceBetweenNodes_T2 = 0
    _n.edgeMaxDistance_T2 = 0

    _n.updateMinDistanceBetweenNodes = function(newValue)
        _n.minDistanceBetweenNodes_T1 = newValue
        _n.edgeMaxDistance_T1 = newValue * 2

        _n.minDistanceBetweenNodes_T2 = newValue * 12 --4
        _n.edgeMaxDistance_T2 = newValue * 12 * 2 -- 4 * 1.85
    end

    _n.updateMinDistanceBetweenNodes(250)



    -- Implements Node class (from node.lua)
    function _n.Node:initialize(index) self.index = index end
    function _n.Node:toString() return ('Node: %s'):format(self.index) end
    function _n.Node:isEqualTo(n) return self.index == n.index end

    -- Internal graph data
    _n.graph_handler = nil
    _n.key_graph_handler = nil

    _n.resetGraph = function()
        _n.graph_handler = NewNavGraphHandler("Main Graph")
        _n.key_graph_handler = NewNavGraphHandler("Key Graph")
    end

    _n.resetGraph()

    --Pathfinders
    _n.pathfinder = {}
    _n.pathfinder.graph = NewPathfinder()
    _n.pathfinder.key_graph = NewPathfinder()

    _n.pathfinder.resetPathfinders = function()
        _n.pathfinder.graph:initialize(_n.graph_handler)
        _n.pathfinder.key_graph:initialize(_n.key_graph_handler)
    end

    _n.pathfinder.resetPathfinders()

    _n.lastNewNodeCheck = 0
    _n.lastHigherNodeCheck = 0

    _n.processAutoAdd = function(minDistance)
        local time = Cache.time

        if _n.lastNewNodeCheck + 75 < time then
            --Auto process for normal graph
            _n.lastNewNodeCheck = time
            _n.processAutoAdd_graph(minDistance)
            if _n.lastHigherNodeCheck + 500 < time then
                _n.lastHigherNodeCheck = time
                _n.processAutoAdd_higherNodes(minDistance)

            end
        end

        time = nil
    end

    _n.recalculateT2Edges = function()
        local pPos = Player.getPos()
        local key_graph_nodes = _n.key_graph_handler.getAllNodes()

        local edgeMaxDistance = _n.edgeMaxDistance_T2

        for k1, _node in pairs(key_graph_nodes) do
            local nodePos = _node.pos
            local distanceToPlayer = pPos:getDistance(nodePos)
            if distanceToPlayer < edgeMaxDistance * 3 then
                local closestT1Node = _n.graph_handler.getClosestNode(nodePos)

                for k2, _node_2 in pairs(key_graph_nodes) do
                    if _node ~= _node_2 then
                        local nodePos_2 = _node_2.pos
                        distanceToPlayer = pPos:getDistance(nodePos_2)
                        if distanceToPlayer < edgeMaxDistance * 10 then
                            local distanceBetween = nodePos:getDistance(nodePos_2)
                            if distanceBetween <= edgeMaxDistance then
                                local edgeBetween = _n.key_graph_handler.find_edge(_node, _node_2)
                                if not edgeBetween then
                                    --Test if we can find a path over the normal graph
                                    local closestT1Node_2 = _n.graph_handler.getClosestNode(nodePos_2)

                                    local pathBetween = _n.pathfinder.graph:process(closestT1Node, closestT1Node_2, nil, 300)
                                    if pathBetween and #pathBetween > 0 then
                                        _n.key_graph_handler.addEdge(_node, _node_2, distanceBetween)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    _n.processAutoAdd_higherNodes = function()
        local pos = Player.getPos()


        --Process key graph
        local minDistance_T2 = _n.minDistanceBetweenNodes_T2
        local edgeMaxDistance_T1 = _n.edgeMaxDistance_T1
        --Get closest node and add new node if distance is okay.
        local closestNode, closestNodeDistance = _n.key_graph_handler.getClosestNode(pos)
        if closestNodeDistance >= minDistance_T2 or _n.forceAddT2Node then
            local newNodeIndex = _n.key_graph_handler.addNode(pos)
            local newNode = _n.key_graph_handler.getNode(newNodeIndex)

            local newT1NodeIndex = _n.graph_handler.addNode(pos, false)
            _n.graph_handler.addEdgesToNodeByIndex(newT1NodeIndex, 0, edgeMaxDistance_T1, true)

            _n.recalculateT2Edges()

            _n.forceAddT2Node = false

            newNodeIndex = nil
            newNode = nil
            newT1NodeIndex = nil
        end



        minDistance_T2 = nil
        edgeMaxDistance_T1 = nil
        closestNode = nil
        closestNodeDistance = nil


    end

    _n.processAutoAdd_graph = function(minDistance)
        minDistance = minDistance or _n.minDistanceBetweenNodes_T1
        local edgeMaxDistance = _n.edgeMaxDistance_T1
        local pos = Player.getPos()

        if not _n.pseudoMeshCreation or _n.forceAddT1Node then
            --Get closest node and add new node if distance is okay.
            local closestNode, closestNodeDistance = _n.graph_handler.getClosestNode(pos)
            if closestNodeDistance >= minDistance or _n.forceAddT1Node then
                local newNodeIndex = _n.graph_handler.addNode(pos)
                _n.graph_handler.addEdgesToNodeByIndex(newNodeIndex, 0, edgeMaxDistance, true)
                _n.forceAddT1Node = false

                newNodeIndex = nil
            end

            closestNode = nil
            closestNodeDistance = nil
        else
            local possiblePos = {}
            minDistance = minDistance - 1

            --4 on x axis
            table.insert(possiblePos, Vector3(pos.X + 1.2 * minDistance, pos.Y + 100, pos.Z))
            table.insert(possiblePos, Vector3(pos.X + 2.3 * minDistance, pos.Y + 100, pos.Z))
            table.insert(possiblePos, Vector3(pos.X - 1.2 * minDistance, pos.Y + 100, pos.Z))
            table.insert(possiblePos, Vector3(pos.X - 2.3 * minDistance, pos.Y + 100, pos.Z))

            --4 on z axis
            table.insert(possiblePos, Vector3(pos.X, pos.Y + 100, pos.Z + 1.2 * minDistance))
            table.insert(possiblePos, Vector3(pos.X, pos.Y + 100, pos.Z + 2.3 * minDistance))
            table.insert(possiblePos, Vector3(pos.X, pos.Y + 100, pos.Z - 1.2 * minDistance))
            table.insert(possiblePos, Vector3(pos.X, pos.Y + 100, pos.Z - 2.3 * minDistance))

            --8 on x&z axis

            table.insert(possiblePos, Vector3(pos.X + 1.2 * minDistance, pos.Y + 100, pos.Z + 1.2 * minDistance))
            table.insert(possiblePos, Vector3(pos.X + 1.2 * minDistance, pos.Y + 100, pos.Z - 1.2 * minDistance))
            table.insert(possiblePos, Vector3(pos.X - 1.2 * minDistance, pos.Y + 100, pos.Z + 1.2 * minDistance))
            table.insert(possiblePos, Vector3(pos.X - 1.2 * minDistance, pos.Y + 100, pos.Z - 1.2 * minDistance))

            table.insert(possiblePos, Vector3(pos.X + 1.2 * minDistance, pos.Y + 100, pos.Z + 1.2 * minDistance))
            table.insert(possiblePos, Vector3(pos.X - 1.2 * minDistance, pos.Y + 100, pos.Z + 1.2 * minDistance))
            table.insert(possiblePos, Vector3(pos.X + 1.2 * minDistance, pos.Y + 100, pos.Z + 1.2 * minDistance))
            table.insert(possiblePos, Vector3(pos.X - 1.2 * minDistance, pos.Y + 100, pos.Z - 1.2 * minDistance))

            minDistance = minDistance + 1
            local done = false
            while done == false do
                local newPossiblePos = {}
                for _, extraPos in ipairs(possiblePos) do
                    if not Raycast.safeTwoPos(pos, extraPos, 50, 30) then
                        local extraPos_lowered = Vector3(extraPos.X, extraPos.Y - 25, extraPos.Z)
                        if not Raycast.twoPos(pos, extraPos_lowered, 50) then
                            --Can be lowered, insert at the back again
                            table.insert(newPossiblePos, extraPos_lowered)
                        else
                            local closestNode, closestNodeDistance = _n.graph_handler.getClosestNode(extraPos)
                            if closestNodeDistance >= minDistance then
                                local newNodeIndex = _n.graph_handler.addNode(extraPos, false)
                                _n.graph_handler.addEdgesToNodeByIndex(newNodeIndex, 0, edgeMaxDistance, false)

                                newNodeIndex = nil
                            end

                            closestNode = nil
                            closestNodeDistance = nil
                        end

                        extraPos_lowered = nil
                    end

                end

                possiblePos = newPossiblePos
                if #possiblePos == 0 then
                    done = true
                end

                newPossiblePos = nil
            end

            possiblePos = nil
            done = nil


        end

        edgeMaxDistance = nil
        pos = nil
    end


    _n.record = function()
        _n.processAutoAdd()
    end

    return _n
end
