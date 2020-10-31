--[[
  Creates a pathfinder that uses Dijkstra.
  It takes a Handler (look at NavGraphHandler, all handlers having those functions will work).
  Once setup properly, all you need todo is call :process(...) to get a path
]] function MagLib.BDO.Navigation.Graph.Pathfinding.DijkstraPathfinder()

	-- Clears nodes data between consecutive path requests.
	local function reset(pathfinder)
		for index in pairs(pathfinder.visited) do
			local node = pathfinder.handler.getNode(index)
			if node then
				node.previous = nil
				node.distance = math.huge

				node = nil
			end
		end
		pathfinder.Q:clear()
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

	local Pathfinder = {}
	Pathfinder.Q = nil

	-- Initializes Pathfinder search with a custom handler
	function Pathfinder:initialize(handler)
		self.handler = handler
		self.Q = MagLib.Core.Bheap()
		self.Q._sort = function(a, b)
			return a.distance < b.distance
		end

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
		return Pathfinder:process_Dijkstra(source, target, maxMs, maxIterations)
	end

	function Pathfinder:process_Dijkstra(source, target, maxMs, maxIterations)
		reset(self)
		maxMs = maxMs or (1 / 0)
		maxIterations = maxIterations or (1 / 0)

		source.distance = 0
		self.visited[source.index] = true
		local nodes = self.handler.getAllNodes()
		for k = 1, #nodes do
			local node = nodes[k]
			self.Q:push(node)
		end

		local iterations = 0
		local startTime = Infinity.Win32:GetTickCount()
		while not self.Q:isEmpty() do
			local timePast = Infinity.Win32:GetTickCount() - startTime
			if timePast >= maxMs then
				return {}
			end
			local u = self.Q:pop()
			if u == target then
				-- print("Search took: " .. tostring(Infinity.Win32:GetTickCount() - startTime) .. " ms")
				return backtrace(u)
			end
			if u.distance == math.huge then
				break
			end

			-- Go through edges method <--This should be a lot faster in BDO due to high amount of edges and no need for self.handler.distance(u,v) to iterate all edges every time
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
					self.Q:sort(v_node)
				end
			end

			iterations = iterations + 1
			if iterations >= maxIterations then
				return {}
			end
			-- print("neighbor check took: " .. tostring(Infinity.Win32:GetTickCount() - startTimeNeighbors) .. " ms")
		end

		return {}
	end

	return Pathfinder
end
