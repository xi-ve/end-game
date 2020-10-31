MagLib.BDO.Navigation.Graph.Navigator = function(navGraph)
	local self = {}
	local settings = MagLib.BDO.Navigation.Graph.settings
	local getTime = MagLib.getTime
	local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos
	local Vector = MagLib.Utils.Vector
	local Raycast = MagLib.BDO.Raycast
	local Teleport = MagLib.BDO.Navigation.Graph.Teleport

	-- References
	self.navGraph = navGraph
	self.graph_handler = self.navGraph.graph_handler
	self.key_graph_handler = self.navGraph.key_graph_handler

	self.pathfinder = self.navGraph.pathfinder

	self.direct_nav = MagLib.BDO.Navigation.Graph.DirectNavigator()

	self.stopDistance = 200
	self.defaultStopDistance = 200

	self.dest = nil
	self.arrived = false
	self.path = {} -- {dest = position, waypoints = {node1,node2,node3,node4}}
	self.paused = false

	self.reset = function()
		self.dest = nil
		self.arrived = false
		self.path = {}
		self.direct_nav.reset()
	end

	self.moveTo = function(dest, overNodes, stopDistance)
		if overNodes == nil then
			overNodes = false
		end

		if stopDistance then
			self.stopDistance = stopDistance
		else
			self.stopDistance = self.defaultStopDistance
		end

		dest = Vector3(math.floor(dest.X), math.floor(dest.Y), math.floor(dest.Z))

		if overNodes then
			-- print("move To: ".. Vector.toString(dest) .. " | current set is dest: " .. Vector.toString(self.dest))
			if (not self.dest) or Vector.equal(dest, self.dest) == false then
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
		self.reset()
		MagLib.BDO.Actors.LocalPlayer.stopMoving()
	end

	self.direct_moveTo = function(dest)
		self.onMoveTo(dest, false, false)
		self.direct_nav.direct_moveTo(dest, false)
	end

	self.navigate = function()
		if self.paused then
			return
		end

		if self.direct_nav.dest and self.direct_nav.arrived == false then
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

		local pPos = getPPos()

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

		local stopDistance = 125

		-- Recalculating path
		--[[if self.path and self.path.dest and self.path.waypoints and #self.path.waypoints > 10 and self.path.tier_nodes and self.path.tier_nodes.tier2_nodes and self.path.tier_nodes.tier3_nodes and self.lastRecalc + 333 < Infinity.Win32:GetTickCount() then
            local removedSth
            self.path.tier_nodes, removedSth = self.updatePath_removeArrived(self.path.tier_nodes)
            if removedSth then
                self.path = self.calculatePath(pPos, self.dest, self.path)
            end
        end]]

		-- If new destination
		if (not self.path) or (not self.path.dest) or Vector.equal(self.path.dest, self.dest) == false then
			self.path = self.calculatePath(pPos, self.dest, self.path)
			if self.path == nil or
				((self.path.waypoints and #self.path.waypoints == 0) and pPos:getDistance(self.dest) > (stopDistance + 50)) then
				-- Log.log("Error: Could not find a path to destination. Please check your Navgraph!")
			end

			pPos = nil
			stopDistance = nil

			return true
		end

		if self.path and self.path.dest and (not self.path.tier == 0) and self.path.waypoints and #self.path.waypoints <= 3 and
			self.lastRecalc + 50 < Infinity.Win32:GetTickCount() then
			self.path = self.calculatePath(pPos, self.dest, self.path)
		end

		-- Skipping nodes
		if self.path.waypoints and #self.path.waypoints > 0 and settings.skip_path_nodes then
			self.path.waypoints = self.skipNodes(self.path.waypoints)
		end

		local waypoints = self.path.waypoints
		-- table.print(waypoints)

		-- Actual navigation
		local waypointsLength = 0
		if waypoints then
			waypointsLength = #waypoints
		end

		if waypointsLength == 0 then
			-- No waypoints/finished waypoints
			if pPos:getDistance2D(self.dest) < stopDistance then
				self.arrived = true
				self.stop()
			else
				self.path = self.calculatePath(pPos, self.dest, self.path)

				pPos = nil
				stopDistance = nil
				waypoints = nil
				waypointsLength = nil

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
				-- if Raycast.safeTwoPos(pPos, nextPos) then
				--  --Do something to handle objects in the way
				-- end
				if (nextPos:getDistance(pPos) > 4500) then
					-- Log.log("Direct line to next position in path is way too far away. Resetting path!")
					MagLib.wait(500) -- Waiting 500ms so that if we cannot find a path we do not try to spam this and have -5fps
					self.path = nil
					return true
				end
				local isLastWaypoint = #waypoints <= 1
				self.onMoveTo(nextPos, true, isLastWaypoint)
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

	self.onMoveTo = function(dest, isOverNodes, isEndDest)
		if MagLib.BDO and MagLib.BDO.Actions and MagLib.BDO.Actions.Combat and MagLib.BDO.Actions.Combat.CombatManager then
			MagLib.BDO.Actions.Combat.CombatManager.onMoveTo(dest, isOverNodes, isEndDest)
		end
	end

	self.lastTimeSkippedNodes = 0
	self.skipNodes = function(waypoints)
		if waypoints == nil then
			return {}
		end

		local pPos = getPPos()
		local currentPath = waypoints

		if self.lastTimeSkippedNodes + 521 < getTime() and settings.skip_path_nodes then
			self.lastTimeSkippedNodes = getTime()
			local done = false
			while done == false do
				if #currentPath > 2 then
					local nextNode = currentPath[2]
					if not Raycast.safeTwoPos(pPos, nextNode) and nextNode:getDistance(pPos) < 3250 and math.abs(pPos.Y - nextNode.Y) <
						150 then
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

	self.createT1Path = function(start, dest)
		-- Closest nodes to start
		local closestStartNode = self.graph_handler.getClosestNode(start)
		-- Closest nodes to stop
		local closestDestNode = self.graph_handler.getClosestNode(dest)

		-- print("From node " .. closestStartNode.index .. " to node " .. closestDestNode.index)

		-- Use T1 nodes directly
		local positions = self.calculatePath_T1(closestStartNode, closestDestNode)
		if positions and #positions > 0 then
			table.insert(positions, dest)
		end

		closestStartNode = nil
		closestDestNode = nil

		return positions
	end

	self.createT2Path = function(start, dest)

		-- Closest nodes to start
		local closestStartNode = self.key_graph_handler.getClosestNode(start)
		-- Closest nodes to stop
		local closestDestNode = self.key_graph_handler.getClosestNode(dest)

		-- Get the path over T2 nodes

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
			local pPos = getPPos()
			local nextPos = nodes[1]
			waypoints = self.createT1Path(pPos, nextPos)

			pPos = nil
			nextPos = nil
		end

		return waypoints
	end

	self.removeFirstIfArrived = function(posList, stopDistance)
		local pPos = getPPos()
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
	-- Creates a path from start to destination, if currentPath is set, it will continue on current path
	self.calculatePath = function(start, dest, currentPath)
		self.lastRecalc = Infinity.Win32:GetTickCount()

		local pPos = getPPos()

		if start:getDistance2D(dest) < self.stopDistance then
			self.arrived = true
			self.stop()

			pPos = nil

			return {dest = dest, waypoints = {dest}, tier = 0, tier_nodes = {tier2_nodes = {}, tier3_nodes = {}}}
		end

		-- We return this later as the path, put coords to move to in here
		local positions = {}

		local tier_nodes = nil
		if currentPath ~= nil and currentPath.dest and Vector.equal(currentPath.dest, dest) and currentPath.waypoints and
			currentPath.tier and currentPath.tier_nodes.tier3_nodes and currentPath.tier_nodes.tier2_nodes then
			tier_nodes = currentPath.tier_nodes
		else
			tier_nodes = {tier2_nodes = {}, tier3_nodes = {}}
			currentPath = {}
			currentPath.tier = -1
		end

		local tierToUse
		if currentPath.tier == 0 then
			-- Direct path
			positions = {dest}
		elseif currentPath.tier ~= -1 then
			tierToUse = currentPath.tier
			local removedSth
			tier_nodes, removedSth = self.updatePath_removeArrived(tier_nodes)
			if removedSth then
				-- currentPath.waypoints = {}
				removedSth = nil
			end

			if tierToUse == 2 then
				if currentPath.waypoints and #currentPath.waypoints == 0 then
					-- We have no T1 nodes in Path, so we check T2 nodes
					if #tier_nodes.tier2_nodes == 0 then
						-- We have no T2 Nodes, so we just need to move straight to dest
						positions = {dest}
					else
						-- #tier_nodes.tier2_nodes > 0 here, creating T1 from T2
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
			-- Check if direct path is possible
			if start:getDistance(dest) < 1850 and not Raycast.safeTwoPos(start, dest, 60, 60) then
				tierToUse = 0
				positions = {dest}
			else
				tierToUse = self.calculatePath_decideTierToUse(start, dest)
				-- Deciding on Tier of Nodes to use
				if settings.log_verbose then
					-- Log.log("Using Tier "..tierToUse.." nodes for navigation!")
				end
				if tierToUse == 2 then
					-- Use T2 nodes and then calculate path to next T2 over T1
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

		-- TODO:Human nav/Path modifications
		if settings.emulate_human_movement then
			positions = self.modPathHumanLike(positions)
		end

		-- newpath, tier_nodes = {tier2_nodes = {}, tier3_nodes = {}}, waypoints are T1 nodes
		local newPath = {dest = dest, waypoints = positions, tier = tierToUse, tier_nodes = tier_nodes}
		-- table.print(newPath)
		return newPath
	end

	self.calculatePath_decideTierToUse = function(start, dest)
		--[[

        local pPos = getPPos()

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

		-- Distance start -> stop
		local startStopDist = start:getDistance(dest)

		-- Tier of Nodes to use (Confidence lower to 0 is best) and calculate path -- Old
		-- local T1_confidence = (closestT1StartNode_Distance / self.navGraph.minDistanceBetweenNodes_T1) + (closestT1StopNode_Distance / self.navGraph.minDistanceBetweenNodes_T1) + startStopDist
		-- local T2_confidence = (closestT2StartNode_Distance / self.navGraph.minDistanceBetweenNodes_T2 / 3) + (closestT2StopNode_Distance / self.navGraph.minDistanceBetweenNodes_T2 / 3) + startStopDist * 0.6

		-- Tier of Nodes to use (Confidence lower is best) and calculate path
		local T1_confidence = 1500 + startStopDist -- 500 + startStopDist
		local T2_confidence = 5500 + startStopDist * 0.8 -- 1500 + startStopDist * 0.7

		-- print("T1 confidence:" .. T1_confidence)
		-- print("T2 confidence:" .. T2_confidence)

		-- Deciding on Tier of Nodes to use
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

		-- Log.debugLog("navigator modPathHumanLike")
		if not currentPath then
			return {}
		end

		local strength_node_amount = settings.interpolation_movement_smoothness
		local smoothness = settings.interpolation_path_smoothness

		local destPos = currentPath[#currentPath]

		local pPos = getPPos()

		local path = {}
		local pathLength = #currentPath
		if pathLength >= 2 then
			for k = 1, pathLength - 1 do
				local node = currentPath[k]
				-- if pPos:getDistance(node) < 4000 then
				local nextNode = currentPath[k + 1]
				local connectionVec = Vector.subtract(nextNode, node)
				local connectionVecLength = Vector.getLength(connectionVec)
				local amountOfNodes = math.floor(strength_node_amount * (connectionVecLength / 400)) - 1
				local stepVec = Vector.divide(connectionVec, amountOfNodes)
				table.insert(path, node)
				local lastInserted = node
				if amountOfNodes >= 1 then
					for i = 1, amountOfNodes do
						local nextStepNode = Vector.addition(lastInserted, stepVec)
						table.insert(path, nextStepNode)
						lastInserted = nextStepNode

						nextStepNode = nil
					end
				end
				-- else
				--    table.insert(path, node)
				-- end

				node = nil
				nextNode = nil
				connectionVec = nil
				connectionVecLength = nil
				amountOfNodes = nil
				stepVec = nil
				lastInserted = nil
			end
		end

		-- local path = currentPath

		if smoothness >= 1 then
			for j = 1, smoothness do
				local newPath = {}
				pathLength = #path

				local pRot = Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():getRotation()

				local backwardsVec = Vector.multiply(Vector3(math.cos(pRot), math.sin(pRot), math.tan(pRot)), (-1))

				local thirdPreviousNode = Vector.addition(pPos, Vector.multiply(backwardsVec, 2))
				local twoPreviousNode = Vector.addition(pPos, backwardsVec)
				local previousNode = path[1]
				local startNode = path[2]
				local nextNode = path[3]
				local twoNextNode = path[4]
				local thirdNextNode = path[5]

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
						end

						if twoNextNode == nil then
							twoNextNode = nextNode
							thirdNextNode = nextNode
						end

						if thirdNextNode == nil then
							thirdNextNode = twoNextNode
						end

						-- Calculating coords of new node.
						local newNode = self.interpolate(thirdPreviousNode, twoPreviousNode, previousNode, startNode, nextNode,
                                 						twoNextNode, thirdNextNode)

						table.insert(newPath, newNode)

						newNode = nil

					end

				end

				path = newPath
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
		local pPos = getPPos()
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

	-- p3 is current node
	self.interpolate = function(p0, p1, p2, p3, p4, p5, p6)

		local add = Vector.addition
		local sub = Vector.subtract
		local mul = Vector.multiply
		local div = Vector.divide

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
		-- newNode = p3

		return newNode
	end

	return self
end
