--[[
  Creates a pathfinder that uses AStar. Still should be faster than Dijkstra in a lot of cases.
  It takes a Handler (look at NavGraphHandler, all handlers having those functions will work).
  Once setup properly, all you need todo is call :process(...) to get a path
]] function MagLib.BDO.Navigation.Graph.Pathfinding.AStarPathfinder()

	-- Clears nodes data between consecutive path requests.
	local function reset(pathfinder)
		for index in pairs(pathfinder.visited) do
			local node = pathfinder.handler.getNode(index)
			if node then
				node.previous = nil
				node.distance = 1 / 0
				node.cost = 1 / 0

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

	function Pathfinder:process(source, target, maxMs, maxIterations)
		if source == nil or target == nil then
			return {}
		end
		return Pathfinder:process_AStar(source, target, maxMs, maxIterations)
	end

	function Pathfinder:process_AStar(source, target, maxMs, maxIterations)
		reset(self)

		maxMs = maxMs or (1 / 0)
		maxIterations = maxIterations or (1 / 0)

		local targetPos = target.pos

		source.distance = 0
		source.cost = 0
		self.visited[source.index] = true
		local nodes = self.handler.getAllNodes()
		for k = 1, #nodes do
			local node = nodes[k]
			self.Q:push(node)
		end

		self.Q:push(source)

		local iterations = 0
		local startTime = Infinity.Win32:GetTickCount()

		self.handler.getEdges(source)

		while not self.Q:isEmpty() do
			-- Max time check
			local timePast = Infinity.Win32:GetTickCount() - startTime
			if timePast >= maxMs then
				return {}
			end

			-- Reached target check
			local u = self.Q:pop()
			if u == target then
				-- print("Search took: " .. tostring(Infinity.Win32:GetTickCount() - startTime) .. " ms")
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
			-- print("#edges:" .. #edges)
			if #edges == 0 then
				-- Node has no edges, do nothing?
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
							-- Ensuring it is picked as next node, meaning we found the path, this makes it not always the optimal path, but a close to optimal on
							v_node.cost = new_cost
							v_node.distance = 0
						else
							v_node.cost = new_cost
							v_node.distance = new_distance
						end

						v_node.previous = u
						self.visited[v_node.index] = true
						-- self.Q:push(v_node)
						self.Q:sort(v_node)
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

	return Pathfinder

end
