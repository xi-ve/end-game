
function NewNavGraphHandler(name)
    local handler = {}
    handler.graph = {nodes = {}, edges = {}}
    handler.Node = NodeConstructor()
    handler.graphName = name

    handler.node_size = 0
    handler.edge_size = 0
    -- Implements Node class (from node.lua)
    function handler.Node:initialize(index) self.index = index end
    function handler.Node:toString() return ('Node: %s'):format(self.index) end
    function handler.Node:isEqualTo(n) return self.index == n.index end


    -- Returns the distance between node a and node b.
    -- The distance should be the weight of the edge between the nodes
    -- if existing, otherwise 0 (I could not figure anything better here).
    handler.distance = function(a, b)
        local e = handler.find_edge(a, b)
        return e and e.weight or 0
    end

    handler.nodeCount = function()
        local count = 0
        for _, _ in ipairs(handler.graph) do
            count = count + 1
        end
        return count
    end

    -- Collects values from a map-table to an array
    handler.collect = function(map)
        local array = {}
        for _, element in pairs(map) do table.insert(array, element) end
        return array
    end

    -- Returns an array of all nodes in the graph
    handler.getAllNodes = function()
        return handler.collect(handler.graph.nodes)
    end

    -- Returns an array of all edges in the graph
    handler.getAllEdges = function()
        return handler.collect(handler.graph.edges)
    end

    -- Returns a Node
    handler.getNode = function(index)
        return handler.graph.nodes[index]
    end

    --Returns closest Node and distance to it
    handler.getClosestNode = function(pos, use3dDistance, okDistance, filterFunc)
        okDistance = okDistance or 10

        if use3dDistance == nil then
            use3dDistance = true
        end
        local closestNode
        local closestNodeDistance = 1 / 0


        for _, node in pairs(handler.graph.nodes) do
            local distance
            if use3dDistance then
                distance = pos:getDistance(node.pos)
            else
                distance = pos:getDistance2D(node.pos)
            end

            --No need to iterate over the rest, this one seems fine
            if distance <= okDistance then
                return node, distance
            end

            local filterOk = true
            if filterFunc then 
                filterOk = filterFunc(node.pos)
            end
            
            if distance < closestNodeDistance then
                closestNode = node
                closestNodeDistance = distance
            end

            distance = nil
        end

        if closestNode == nil and filterFunc then
            --Doing the same again without the filterFunc if no node was found with it
            for _, node in pairs(handler.graph.nodes) do
                local distance
                if use3dDistance then
                    distance = pos:getDistance(node.pos)
                else
                    distance = pos:getDistance2D(node.pos)
                end
    
                --No need to iterate over the rest, this one seems fine
                if distance <= okDistance then
                    return node, distance
                end
    
                if distance < closestNodeDistance  then
                    closestNode = node
                    closestNodeDistance = distance
                end
    
                distance = nil
            end
        end

        return closestNode, closestNodeDistance
    end

    --Returns closest Node or Edge to a 2d position on screen
    handler.getClosestElement_2DOnScreen = function(pos, maxDistance, okDistance)
        okDistance = okDistance or 40
        maxDistance = maxDistance or (1 / 0)

        local closest = nil
        local closestDist = 1 / 0
        local isNode = true

        local _ = nil
        local nodes = handler.getAllNodes()

        for _, node in pairs(nodes) do
            local nodePos = RenderHelper.ToScreen(node.pos)
            if nodePos then
                local dist = VectorUtils.Distance2(pos, nodePos)
                if dist < closestDist and dist < maxDistance then
                    closest = node
                    closestDist = dist
                    isNode = true

                    if dist < okDistance then --Instant return for better performance
                        return node, dist, isNode
                    end
                end

                dist = nil
            end

            nodePos = nil
            node = nil
        end

        nodes = nil


        local edges = handler.getAllEdges()
        for _, edge in pairs(edges) do
            local from = edge.from
            local to = edge.to
            local toMiddleOfEdge = VectorUtils.divide(VectorUtils.sub(to.pos, from.pos), 2)
            --Giving 3 points on the edge
            local edgePos3D_1 = VectorUtils.add(from.pos, VectorUtils.multiply(toMiddleOfEdge, 1.25))
            local edgePos3D_2 = VectorUtils.add(from.pos, VectorUtils.multiply(toMiddleOfEdge, 0.75))
            local edgePos3D_3 = VectorUtils.add(from.pos, toMiddleOfEdge)

            local set = false
            local dist = 0


            local edgePos_1 = RenderHelper.ToScreen(edgePos3D_1)
            if edgePos_1 then
                dist = VectorUtils.Distance2(pos, edgePos_1)
                if dist < closestDist and dist < maxDistance then
                    closest = edge
                    closestDist = dist
                    isNode = false
                    set = true

                    if dist < okDistance then --Instant return for better performance
                        return edge, dist, isNode
                    end
                end

            end
            if not set then
                local edgePos_2 = RenderHelper.ToScreen(edgePos3D_2)
                if edgePos_2 then
                    dist = VectorUtils.Distance2(pos, edgePos_2)
                    if dist < closestDist and dist < maxDistance then
                        closest = edge
                        closestDist = dist
                        isNode = false
                        set = true

                        if dist < okDistance then --Instant return for better performance
                            return edge, dist, isNode
                        end
                    end
                end
            end
            if not set then
                local edgePos_3 = RenderHelper.ToScreen(edgePos3D_3)
                if edgePos_3 then
                    dist = VectorUtils.Distance2(pos, edgePos_3)
                    if dist < closestDist and dist < maxDistance then
                        closest = edge
                        closestDist = dist
                        isNode = false
                        set = true

                        if dist < okDistance then --Instant return for better performance
                            return edge, dist, isNode
                        end

                    end
                end
            end

        end

        return closest, closestDist, isNode
    end

    -- Looks for an edge between a and b.
    handler.find_edge = function(a, b)
        local edges_list = handler.graph.edges
        for _, edge in ipairs(edges_list) do
            if (edge.from == a and edge.to == b)
            or (edge.from == b and edge.to == a)
            then
                edges_list = nil
                return edge
            end


        end

        edges_list = nil

        return nil
    end

    handler.getEdges = function(n)
        local edges = {}
        for _, edge in ipairs(handler.graph.edges) do
            if edge.from == n or edge.to == n then
                table.insert(edges, edge)
            end
        end
        return edges
    end

    handler.removeEdgeByIndex = function(index)
        --print("edge rm #" .. index)
        handler.edge_size = handler.edge_size - 1
        table.remove(handler.graph.edges, index)
    end

    handler.removeEdge = function(edge)
        local removeIndex = nil
        local edges = handler.getAllEdges()
        for k, v in pairs(edges) do
            if v.from.index == edge.from.index and v.to.index == edge.to.index then
                removeIndex = k
                break
            end
        end

        if removeIndex ~= nil then
            handler.removeEdgeByIndex(removeIndex)
            removeIndex = nil
        end

        edges = nil
    end

    --Removes a node and all edges that the node is a part of
    handler.removeNodeByIndex = function(index)
        handler.removeNode(handler.getNode(index))
    end

    -- Adds a new edge between nodes labelled from and to
    handler.addEdge = function(from, to, weight, log)
        --[[if log == nil then
            log = true
        end
        if log then
            Log.log("[" .. handler.graphName .. "] Adding Edge from " .. from.index .. " to " .. to.index)
        end]]
        handler.edge_size = handler.edge_size + 1
        table.insert(handler.graph.edges,
        {from = from, to = to, weight = weight or 0})
    end

    -- Sets the weight of edge from -> to
    handler.setEdgeWeight = function(from, to, weight)
        local e = handler.find_edge(handler.graph.nodes[from], handler.graph.nodes[to])
        if e then e.weight = weight end
    end

    --Adds fitting Edges to a node
    handler.addEdgesToNodeByIndex = function(index, minDist, maxDist, raycast)
        handler.addEdgesToNode(handler.graph.nodes[index], minDist, maxDist, raycast)
    end

    handler.addEdgesToNode = function(rootNode, minDist, maxDist, raycast)
        minDist = minDist or 0
        maxDist = maxDist or (1 / 0)
        if raycast == nil then
            raycast = true
        end

        local rootNodePos = rootNode.pos
        for k, node in pairs(handler.graph.nodes) do
            if rootNode ~= node then
                local nodePos = node.pos
                local distance = rootNodePos:getDistance(nodePos)
                if distance > minDist and distance < maxDist then
                    local ok = true
                    if raycast and Raycast.safeTwoPos(rootNodePos, nodePos, 150, 30) then
                        ok = false
                    end

                    if ok then
                        local edgeBetween = handler.find_edge(rootNode, node)
                        if not edgeBetween then
                            handler.addEdge(rootNode, node, distance)
                        end

                        edgeBetween = nil
                    end

                    ok = nil
                end


                nodePos = nil
                distance = nil
            end
        end

        rootNodePos = nil
    end

    handler.removeNodeByIndex = function(index)
        handler.removeNode(handler.getNode())
    end

    handler.removeNode = function(node)
        --Remove edges that are connected to the nodes
        local edgeIndexesToRemove = {}
        for k, edge in ipairs(handler.graph.edges) do
            if edge.from.index == node.index or edge.to.index == node.index then
                table.insert(edgeIndexesToRemove, k)
                --print("Flagged edge #" .. k .. " from Node #" .. edge.from.index .. " to  Node #" .. edge.to.index)
            end
        end
        table.sort(edgeIndexesToRemove, function(a, b) return a > b end)

        for _, index in ipairs(edgeIndexesToRemove) do
            handler.removeEdgeByIndex(index)
        end

        --Remove the actual node
        handler.node_size = handler.node_size - 1
        handler.graph.nodes[node.index] = nil


        edgeIndexesToRemove = nil
    end

    handler.addNode_forcedIndex = function(position, index)
        handler.node_size = handler.node_size + 1
        local newIndex = index
        handler.graph.nodes[newIndex] = handler.Node(newIndex)
        handler.graph.nodes[newIndex].pos = position

        newIndex = nil
    end

    -- Adds a new node, returns index of new node
    handler.addNode = function(position, log)
        if log == nil then
            log = true
        end

        handler.node_size = handler.node_size + 1
        local newIndex = table.firstBorder(handler.graph.nodes) + 1
        handler.graph.nodes[newIndex] = handler.Node(newIndex)
        handler.graph.nodes[newIndex].pos = position
        if log then
            Log.log("[" .. handler.graphName .. "] Added node #" .. tostring(newIndex))
        end
        return newIndex
    end

    handler.getGraph = function()
        return handler.graph
    end

    -- Returns an array of neighbors of node n
    handler.getNeighbors = function(n)
        local neighbors = {}
        for _, edge in ipairs(handler.graph.edges) do
            if edge.from == n then
                table.insert(neighbors, edge.to)
            elseif edge.to == n then
                table.insert(neighbors, edge.from)
            end
        end
        return neighbors
    end

    return handler
end
