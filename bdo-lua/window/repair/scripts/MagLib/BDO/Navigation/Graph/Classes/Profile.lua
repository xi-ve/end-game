local getPlayerPos = MagLib.BDO.Actors.LocalPlayer.getPosition
local getTime = MagLib.getTime
local Actors = MagLib.BDO.Actors

MagLib.BDO.Navigation.Graph.Profile = function(name)
	local p = {
		name = name,

		-- Profile data
		navGraph = MagLib.BDO.Navigation.Graph.NavGraph(),
		nav = nil, -- Setting this up later, after creation
		npcs = {},
		extra = {},

		-- Hardcoded vars
		npcRecordRadius = 1000,

		-- Dynamic vars
		isRecording = false,
		editMode = false,

		-- Stuff mostly set by either the profile itself or tasks/modules spawned by the profile.
		-- onPulse
		npcRecordLastTime = 0,
		lastRemovedTime = 0
	}

	p.recordNpcs = function(radius)
		if not p.npcs then
			p.npcs = {}
		end

		-- Only do this once a second
		if p.npcRecordLastTime + 1000 > getTime() then
			return
		end

		-- Iterate through all npcs
		for _, actor in ipairs(MagLib.BDO.Actors.getNPCsInRange(radius)) do
			if MagLib.BDO.Actors.isValidActor(actor) then
				local actorKey = actor:getActorKey()
				if actorKey then
					local code = [[
                      local actor = getActor(]] .. actorKey .. [[)
                    if actor then
                        local characterKey = actor:getCharacterKeyRaw()
                        local npcData1 = getNpcInfoByCharacterKeyRaw(characterKey, 1)
                        local npcData2 = getNpcInfoByCharacterKeyRaw(characterKey, 2)

                        --Check different types
                        if (nil ~= npcData1) then
                            if (npcData1:hasSpawnType(CppEnums.SpawnType.eSpawnType_ItemMarket)) then
                                return 1
                            elseif (npcData1:hasSpawnType(CppEnums.SpawnType.eSpawnType_ItemRepairer)) then
                                return 2
                            elseif (npcData1:hasSpawnType(CppEnums.SpawnType.eSpawnType_TradeMerchant)) then
                                return 3
                            elseif (npcData1:hasSpawnType(CppEnums.SpawnType.eSpawnType_WareHouse)) then
                                return 4
                            elseif (npcData1:hasSpawnType(CppEnums.SpawnType.eSpawnType_Potion)) then
                                return 5
                            end
                        elseif (nil ~= npcData2) then
                            if (npcData2:hasSpawnType(CppEnums.SpawnType.eSpawnType_ItemMarket)) then
                                return 1
                            elseif (npcData2:hasSpawnType(CppEnums.SpawnType.eSpawnType_ItemRepairer)) then
                                return 2
                            elseif (npcData2:hasSpawnType(CppEnums.SpawnType.eSpawnType_TradeMerchant)) then
                                return 3
                            elseif (npcData2:hasSpawnType(CppEnums.SpawnType.eSpawnType_WareHouse)) then
                                return 4
                            elseif (npcData2:hasSpawnType(CppEnums.SpawnType.eSpawnType_Potion)) then
                                return 5
                            end
                        end
                    end
                    return nil
                    ]]

					local actorType = Infinity.BDO.Lua.Execute(code)

					if actorType == 1 then
						p.addNpcToList(actor, "Marketplace")
					elseif actorType == 2 then
						p.addNpcToList(actor, "Repair")
					elseif actorType == 3 then
						p.addNpcToList(actor, "Trade")
					elseif actorType == 4 then
						p.addNpcToList(actor, "Storage")
					elseif actorType == 5 then
						p.addNpcToList(actor, "Potions")
					end
				end
			end
		end

		p.npcRecordLastTime = getTime()

	end

	-- Adds Npcs to the npc list, but only if in range and not already in the list
	p.addNpcToList = function(actor, type, radius)
		if actor and actor:isValid() then
			local actorKey = actor:getActorKey()
			local actorName = actor:getName()
			local actorPos = actor:getPosition()

			if not p.npcs[type] then
				p.npcs[type] = {}
			end

			local known = false
			for _, v in pairs(p.npcs[type]) do
				if v.name == actorName then
					known = true
					break
				end
			end

			if not known then
				print(string.format("Added %s with name %s", type, actorName))
				table.insert(p.npcs[type], {name = actorName, posX = actorPos.X, posY = actorPos.Y, posZ = actorPos.Z})
			end
		end
	end

	-- Recording Module
	p.recordModule = MagLib.Run.Modules.RunModule("Profile Recording Module", 25, 75,
                                              	MagLib.Run.Modules.TimingMode.TimedCritical,
                                              	MagLib.Run.EPulseTimingMode.Beginning)
	p.recordModule.needToRun = function()
		if p.isRecording or p.navGraph.forceAddT1Node == true or p.navGraph.forceAddT2Node == true then
			return true
		else
			-- Disabling the module if not needed, forceAdd buttons and recording checkbox should activate this module
			p.recordModule:stop()
			return false
		end
	end

	p.recordModule.run = function()
		p.navGraph.record()
		p.recordNpcs(500)
		-- if p.npcRecordLastTime + 750 < MagLib.getTime() then --Only do this a bit more than 1 times a second
		--    p.recordNpcs(1500)
		--    p.npcRecordLastTime = time
		-- end
	end

	MagLib.Run.Modules.Handler.addModule(p.recordModule)
	p.recordModule.start()

	-- onPulse
	p.onPulse = function()

	end

	p.onUnload = function()
		-- Removing the modules from the handler
		MagLib.Run.Modules.Handler.removeModule(p.recordModule)
	end

	-- Saving and Loading stuff
	p.initFromRaw = function(raw)
		p.npcs = raw.npcs

		if not p.npcs then
			p.npcs = {}
		end

		p.extra = MagLib.Utils.Json.deserialize(raw.extra)
		if not p.extra then
			p.extra = {}
		end

		-- local Node = MagLib.BDO.Navigation.Graph.Node

		-- Rebuild normal graph
		local graph_handler = p.navGraph.graph_handler
		for _, node in pairs(raw.graph.graph.nodes) do
			local pos = Vector3(node.X, node.Y, node.Z)
			local index = node.index
			graph_handler.addNode_forcedIndex(pos, index)
		end

		for _, edge in pairs(raw.graph.graph.edges) do
			local from = graph_handler.getNode(edge.fromIndex)
			local to = graph_handler.getNode(edge.toIndex)
			graph_handler.addEdge(from, to, edge.weigth, false)
		end

		-- Rebuild key graph
		graph_handler = p.navGraph.key_graph_handler
		for _, node in pairs(raw.graph.key_graph.nodes) do
			local pos = Vector3(node.X, node.Y, node.Z)
			local index = node.index
			graph_handler.addNode_forcedIndex(pos, index)
		end

		for _, edge in pairs(raw.graph.key_graph.edges) do
			local from = graph_handler.getNode(edge.fromIndex)
			local to = graph_handler.getNode(edge.toIndex)

			graph_handler.addEdge(from, to, edge.weigth, false)
		end

		p.navGraph.pathfinder.resetPathfinders()

	end

	p.toRaw = function()
		local raw = {}
		raw.npcs = p.npcs

		raw.graph = {}
		-- Handle graph
		raw.graph.graph = {nodes = {}, edges = {}}
		local graph_handler = p.navGraph.graph_handler
		for _, node in pairs(graph_handler.graph.nodes) do
			local pos = node.pos
			table.insert(raw.graph.graph.nodes, {X = pos.X, Y = pos.Y, Z = pos.Z, index = node.index})
		end

		for _, edge in pairs(graph_handler.graph.edges) do
			local fromIndex = edge.from.index
			local toIndex = edge.to.index
			local weight = edge.weigth
			table.insert(raw.graph.graph.edges, {fromIndex = fromIndex, toIndex = toIndex, weight = edge.weigth})
		end

		-- Handle key_graph
		raw.graph.key_graph = {nodes = {}, edges = {}}
		local key_graph_handler = p.navGraph.key_graph_handler
		for _, node in pairs(key_graph_handler.graph.nodes) do
			local pos = node.pos
			table.insert(raw.graph.key_graph.nodes, {X = pos.X, Y = pos.Y, Z = pos.Z, index = node.index})
		end

		for _, edge in pairs(key_graph_handler.graph.edges) do
			local fromIndex = edge.from.index
			local toIndex = edge.to.index
			local weight = edge.weigth
			table.insert(raw.graph.key_graph.edges, {fromIndex = fromIndex, toIndex = toIndex, weight = edge.weigth})
		end

		---extra data, deep iteration,
		raw.extra = MagLib.Utils.Json.serialize(p.extra)
		return raw
	end

	p = setmetatable(p, {
		__eq = function(a, b)
			return a.name == b.name
		end, -- TODO:Check every node or make a hash from the json or sth.
		__tostring = function(n)
			return n:tostring()
		end
	})

	p.nav = MagLib.BDO.Navigation.Graph.Navigator(p.navGraph)

	return p
end
