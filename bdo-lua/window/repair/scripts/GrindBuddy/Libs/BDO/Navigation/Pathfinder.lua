function NewPathfinder()
    -- Dependencies
    local class = ClassConstructor()
    local bheap = NewBheap()

    -- Clears nodes data between consecutive path requests.
    local function resetForDijkstra(pathfinder)
        for index in pairs(pathfinder.visited) do
            local node = pathfinder.handler.getNode(index)
            if node then
                node.previous = nil
                node.distance = math.huge

                node = nil
            end
        end
        pathfinder.Q_Dijkstra:clear()
        pathfinder.visited = {}
    end


    -- Clears nodes data between consecutive path requests.
    local function resetForAStar(pathfinder)
        for index in pairs(pathfinder.visited) do
            local node = pathfinder.handler.getNode(index)
            if node then
                node.previous = nil
                node.distance = 1 / 0
                node.cost = 1 / 0

                node = nil
            end
        end
        pathfinder.Q_AStar:clear()
        pathfinder.visited = {}
    end


    -- Builds and returns the path to the goal node
    local function backtrace(node)
        local path = {}

        repeat
            table.insert(path, 1, node)
            node = node.previous
        until not node

        return path
    end

    -- Initializes Pathfinder search with a custom handler
    local Pathfinder = class()
    Pathfinder.useAStar = true
    Pathfinder.Q_Dijkstra = nil
    Pathfinder.Q_AStar = nil

    function Pathfinder:initialize(handler)
        self.handler = handler
        self.Q_Dijkstra = NewBheap()
        self.Q_AStar = NewBheap()

        self.visited = {}
    end


    -- Processes the graph for shortest paths
    -- source  : the starting node from which the search will spread
    -- target  : the goal location. If passed, returns the shortest path from
    --  source to this target. If not given, will evaluate all the shortest
    --  paths length from to source to all nodes in the graph. This length can
    --  be retrieved by indexing in each node after the search (node.distance)
    -- Returns : an array of nodes (if target supplied)
    function Pathfinder:process(source, target, maxMs, maxIterations)
        if source == nil or target == nil then
            return {}
        end
        if Pathfinder.useAStar then
            return Pathfinder:process_AStar(source, target, maxMs, maxIterations)
        else
            return Pathfinder:process_Dijkstra(source, target, maxMs, maxIterations)
        end
    end

    --ASTar
    function Pathfinder:process_AStar(source, target, maxMs, maxIterations)
        resetForAStar(self)

        maxMs = maxMs or (1 / 0)
        maxIterations = maxIterations or (1 / 0)

        local targetPos = target.pos

        source.distance = 0
        source.cost = 0
        self.visited[source.index] = true
        local nodes = self.handler.getAllNodes()
        for k = 1, #nodes do
            local node = nodes[k]
            self.Q_AStar:push(node)
        end

        self.Q_AStar:push(source)

        local iterations = 0
        local startTime = Infinity.Win32:GetTickCount()

        self.handler.getEdges(source)


        while not self.Q_AStar:isEmpty() do
            --Max time check
            local timePast = Infinity.Win32:GetTickCount() - startTime
            if timePast >= maxMs then
                return {}
            end

            --Reached target check
            local u = self.Q_AStar:pop()
            if u == target then
                --print("Search took: " .. tostring(Infinity.Win32:GetTickCount() - startTime) .. " ms")
                targetPos = nil
                nodes = nil
                startTime = nil
                iterations = nil
                timePast = nil

                return backtrace(u)
            end

            if u.distance == math.huge then
                targetPos = nil
                nodes = nil
                startTime = nil
                iterations = nil

                timePast = nil
                break
            end


            local edges = self.handler.getEdges(u)
            --print("#edges:" .. #edges)
            if #edges == 0 then
                --Node has no edges, do nothing?
            else
                for k = 1, #edges do
                    local v = edges[k]
                    local v_node
                    if v.from == u then
                        v_node = v.to
                    else
                        v_node = v.from
                    end

                    local new_cost = u.cost + (v.weight or 1)
                    local new_distance = new_cost + (v_node.pos:getDistance(targetPos))

                    if new_distance < v_node.distance then
                        if v_node == target then
                            --Ensuring it is picked as next node, meaning we found the path, this makes it not always the optimal path, but a close to optimal on
                            v_node.cost = new_cost
                            v_node.distance = 0
                        else
                            v_node.cost = new_cost
                            v_node.distance = new_distance
                        end

                        v_node.previous = u
                        self.visited[v_node.index] = true
                        --self.Q_AStar:push(v_node)
                        self.Q_AStar:sort(v_node)
                    end

                    new_cost = nil
                    new_distance = nil
                    v = nil
                    v_node = nil
                end
            end

            iterations = iterations + 1
            if iterations >= maxIterations then

                targetPos = nil
                nodes = nil
                startTime = nil
                iterations = nil
                timePast = nil
                return {}
            end

            edges = nil
            u = nil
            timePast = nil
        end


        targetPos = nil
        nodes = nil
        startTime = nil
        iterations = nil

        return {}

    end

    function Pathfinder:process_Dijkstra(source, target, maxMs, maxIterations)
        resetForDijkstra(self)
        maxMs = maxMs or (1 / 0)
        maxIterations = maxIterations or (1 / 0)

        source.distance = 0
        self.visited[source.index] = true
        local nodes = self.handler.getAllNodes()
        for k = 1, #nodes do
            local node = nodes[k]
            self.Q_Dijkstra:push(node)
        end

        local iterations = 0
        local startTime = Infinity.Win32:GetTickCount()
        while not self.Q_Dijkstra:isEmpty() do
            local timePast = Infinity.Win32:GetTickCount() - startTime
            if timePast >= maxMs then
                return {}
            end
            local u = self.Q_Dijkstra:pop()
            if u == target then
                --print("Search took: " .. tostring(Infinity.Win32:GetTickCount() - startTime) .. " ms")
                return backtrace(u)
            end
            if u.distance == math.huge then break end


            --Go through edges method <--This should be a lot faster in BDO due to high amount of edges and no need for self.handler.distance(u,v) to iterate all edges every time
            local edges = self.handler.getEdges(u)
            for k = 1, #edges do
                local v = edges[k]
                local v_node
                if v.from == u then
                    v_node = v.to
                else
                    v_node = v.from
                end

                local alt = u.distance + (v.weight or 1)
                if alt < v_node.distance then
                    v_node.distance = alt
                    v_node.previous = u
                    self.visited[v_node.index] = true
                    self.Q_Dijkstra:sort(v_node)
                end
            end

            iterations = iterations + 1
            if iterations >= maxIterations then
                return {}
            end
            --print("neighbor check took: " .. tostring(Infinity.Win32:GetTickCount() - startTimeNeighbors) .. " ms")
        end

        return {}
    end

    return Pathfinder
end
