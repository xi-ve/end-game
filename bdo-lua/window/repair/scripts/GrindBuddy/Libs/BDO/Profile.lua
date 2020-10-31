function NewProfile(name)
    local _p = {}
    _p.areas = {}
    _p.npcs = {}
    _p.navGraph = NavGraph()
    _p.nav = Navigator(_p.navGraph)
    _p.name = name



    --Dynamic vars
    _p.isRecording = false
    _p.editMode = false

    --Record NPC functions
    _p.recordNpcs = function(radius)
        Log.debugLog("_p recordNpcs")

        if not _p.npcs then
            _p.npcs = { }
        end

        if Cache.closestNpcs.marketplace then
            _p.addNpcToListIfNotAlready(Cache.closestNpcs.marketplace, "Marketplace", radius)
        end

        if Cache.closestNpcs.repair then
            _p.addNpcToListIfNotAlready(Cache.closestNpcs.repair, "Repair", radius)
        end

        if Cache.closestNpcs.trade then
            _p.addNpcToListIfNotAlready(Cache.closestNpcs.trade, "Trade", radius)
        end

        if Cache.closestNpcs.storage then
            _p.addNpcToListIfNotAlready(Cache.closestNpcs.storage, "Storage", radius)
        end

        if Cache.closestNpcs.goods then
            _p.addNpcToListIfNotAlready(Cache.closestNpcs.goods, "Potions", radius)
        end
    end

    _p.addNpcToListIfNotAlready = function(actor, type, radius)

        if not _p.npcs[type] then
            _p.npcs[type] = {}
        end

        local npcs = _p.npcs[type]
        if actor then
            local actorKey = actor:getActorKey()
            local actorName = actor:getName()

            local actorPos = actor:getPosition()
            if actorPos:getDistance(Cache.playerPos) > radius then
                return
            end

            local known = false
            for _, v in pairs(npcs) do
                if v.name == actorName then
                    known = true
                end
            end
            if not known then
                --only add if we can add a path, if not, then just don't do it.
                Log.log(string.format("Added %s with name %s", type, actorName))
                table.insert(npcs, { name = actorName, posX = actorPos.X, posY = actorPos.Y, posZ = actorPos.Z})
            end


            actorKey = nil
            actorName = nil
            actorPos = nil
            known = nil
        end

        npcs = nil
    end


    --OnPulse
    _p.npcRecordLastTime = 0
    _p.lastRemovedTime = 0

    _p.onPulse = function()

        local time = Cache.time

        if _p.isRecording or _p.navGraph.forceAddT1Node == true or _p.navGraph.forceAddT2Node == true or _p.navGraph.forceAddT3Node == true then
            _p.navGraph.record()

            if _p.npcRecordLastTime + 750 < time then --Only do this a bit more than 1 times a second
                _p.recordNpcs(1500)
                _p.npcRecordLastTime = time
            end

            if Grinder.settings.auto_grind_spot and Cache.expGained then
                local areaData, closestGrindSpotDistance = _p.closestGrindArea(Cache.playerPos)
                if areaData == nil then
                    Log.log("Please add at least one Grindspot for auto grind spot placement to work")

                    closestGrindSpotDistance = nil
                    return
                end

                local _x = math.floor(Cache.playerPos.X)
                local _y = math.floor(Cache.playerPos.Y)
                local _z = math.floor(Cache.playerPos.Z)

                local shouldAdd = true
                local newSpotVec = Vector3(_x, _y, _z)
                for _, spot in pairs(areaData.spots) do
                    local distanceBetween = Vector3(spot.X, spot.Y, spot.Z):getDistance(newSpotVec)
                    --Log.log(distanceBetween)
                    if distanceBetween < Grinder.settings.auto_grind_spot_range then
                        shouldAdd = false
                    end

                    distanceBetween = nil
                end

                if shouldAdd then
                    table.insert(areaData.spots, {
                        X = _x,
                        Y = _y,
                        Z = _z
                    })
                    print(string.format("Added grind-spot at (%d, %d, %d)", _x, _y, _z))
                end


                _x = nil
                _y = nil
                _z = nil
                shouldAdd = nil
                newSpotVec = nil
            end
        end


        if _p.editMode then
            if Infinity.BDO.Input.IsKeyPressed(KeyCode_DELETE) and _p.lastRemovedTime + 750 < time then

                --Delete Hotkey is pressed. We take the closest Node to the players mouse
                local mousePosX, mousePosY = Infinity.BDO.Lua.Execute("return getMousePosX(), getMousePosY()")
                local mousePos = Vector2(mousePosX, mousePosY)

                local nav = _p.nav
                local closestT1, closestT1Dist, closestT1IsNode = nav.graph_handler.getClosestElement_2DOnScreen(mousePos, 125, 50)
                if closestT1 then
                    if closestT1IsNode then
                        --Handle it as node
                        local nodePos = closestT1.pos
                        -- First we remove the node itself, removeNode also removes all Edges of the node
                        Log.log("Removing T1 Node #" .. closestT1.index)
                        nav.graph_handler.removeNode(closestT1)

                        --Now we check if a T2 node was on top of the T1 node
                        local closestT2Node, closestT2NodeDist = nav.key_graph_handler.getClosestNode(nodePos)
                        if closestT2Node and closestT2NodeDist < 20 then
                            --There was a T2 Node on top ==> Removing it as well
                            Log.log("Removing T2 Node #" .. closestT2Node.index)
                            nav.key_graph_handler.removeNode(closestT2Node)
                        end

                    else
                        --Handle it as edge
                        Log.log("Removing Edge from Node #" .. closestT1.from.index .. " to Node #" .. closestT1.to.index)
                        nav.graph_handler.removeEdge(closestT1)
                    end

                end

                _p.lastRemovedTime = time
            end
        end
    end

    _p.closestGrindArea = function(pos)
        --Log.debugLog("_p closestGrindArea")
        local closestGrindSpotAreaData = nil
        local closestGrindSpotDistance = 1 / 0

        for _, areaData in pairs(_p.areas) do
            for _, spot in pairs(areaData.spots) do
                local distanceToPlayer = Vector3(spot.X, spot.Y, spot.Z):getDistance(pos)
                if distanceToPlayer < closestGrindSpotDistance then
                    closestGrindSpotAreaData = areaData
                    closestGrindSpotDistance = distanceToPlayer
                end

                distanceToPlayer = nil
            end
        end

        return closestGrindSpotAreaData, closestGrindSpotDistance
    end

    _p.closestGrindSpot = function(pos)

        local closestGrindSpot = nil
        local closestGrindSpotDistance = 1 / 0

        for _, areaData in pairs(_p.areas) do
            for _, spot in pairs(areaData.spots) do
                local distanceToPlayer = Vector3(spot.X, spot.Y, spot.Z):getDistance(pos)
                if distanceToPlayer < closestGrindSpotDistance then
                    closestGrindSpot = spot
                    closestGrindSpotDistance = distanceToPlayer
                end

                distanceToPlayer = nil
            end
        end

        return closestGrindSpot, closestGrindSpotDistance

    end


    --Saving and Loading stuff
    _p.initFromRaw = function(raw)
        _p.npcs = raw.npcs

        if not _p.npcs then
            _p.npcs = {}
        end

        _p.areas = raw.areas
        if not _p.areas then
            _p.areas = {}
        end

        local Node = NodeConstructor()

        --Rebuild normal graph
        local graph_handler = _p.navGraph.graph_handler
        for _, node in pairs(raw.graph.graph.nodes) do
            local pos = Vector3(node.X, node.Y, node.Z)
            local index = node.index
            graph_handler.addNode_forcedIndex(pos, index)

            pos = nil
            index = nil
        end

        for _, edge in pairs(raw.graph.graph.edges) do
            local from = graph_handler.getNode(edge.fromIndex)
            local to = graph_handler.getNode(edge.toIndex)
            graph_handler.addEdge(from, to, edge.weigth, false)

            from = nil
            to = nil
        end

        --Rebuild key graph
        graph_handler = _p.navGraph.key_graph_handler
        for _, node in pairs(raw.graph.key_graph.nodes) do
            local pos = Vector3(node.X, node.Y, node.Z)
            local index = node.index
            graph_handler.addNode_forcedIndex(pos, index)

            pos = nil
            index = nil
        end

        for _, edge in pairs(raw.graph.key_graph.edges) do
            local from = graph_handler.getNode(edge.fromIndex)
            local to = graph_handler.getNode(edge.toIndex)
            graph_handler.addEdge(from, to, edge.weigth, false)

            from = nil
            to = nil
        end

        _p.navGraph.pathfinder.resetPathfinders()

        Node = nil
        graph_handler = nil


    end

    _p.toRaw = function()
        local raw = {}
        raw.npcs = _p.npcs
        raw.areas = _p.areas


        raw.graph = {}
        --Handle graph
        raw.graph.graph = {nodes = {}, edges = {}}
        local graph_handler = _p.navGraph.graph_handler
        for _, node in pairs(graph_handler.graph.nodes) do
            local pos = node.pos
            table.insert(raw.graph.graph.nodes, {X = pos.X, Y = pos.Y, Z = pos.Z, index = node.index})

            pos = nil
        end

        for _, edge in pairs(graph_handler.graph.edges) do
            local fromIndex = edge.from.index
            local toIndex = edge.to.index
            local weight = edge.weigth
            table.insert(raw.graph.graph.edges, {fromIndex = fromIndex, toIndex = toIndex, weight = edge.weigth})

            fromIndex = nil
            toIndex = nil
            weight = nil
        end

        --Handle key_graph
        raw.graph.key_graph = {nodes = {}, edges = {}}
        local key_graph_handler = _p.navGraph.key_graph_handler
        for _, node in pairs(key_graph_handler.graph.nodes) do
            local pos = node.pos
            table.insert(raw.graph.key_graph.nodes, {X = pos.X, Y = pos.Y, Z = pos.Z, index = node.index})

            pos = nil
        end

        for _, edge in pairs(key_graph_handler.graph.edges) do
            local fromIndex = edge.from.index
            local toIndex = edge.to.index
            local weight = edge.weigth
            table.insert(raw.graph.key_graph.edges, {fromIndex = fromIndex, toIndex = toIndex, weight = edge.weigth})

            fromIndex = nil
            toIndex = nil
            weight = nil
        end


        graph_handler = nil



        return raw
    end

    return _p
end

Profile = {}

Profile.profilesDirectory = "\\Profiles"

function Profile.newProfile(name)
    Log.log("Creating new profile with name " .. name)
    return NewProfile(name)
end

function Profile.saveProfile(profile)
    if profile then
        local raw = profile.toRaw()
        local name = profile.name

        Log.log("Saving profile with the name " .. name)

        local fileName = Profile.profilesDirectory .. "\\" .. name .. ".json"

        local json_string = JSON:encode_pretty(raw)
        Infinity.FileSystem.WriteFile(fileName, json_string)

        raw = nil
        name = nil
        fileName = nil
        json_string = nil
    else
        Log.log("Load or create a profile first !")
    end
    Profile.refreshProfiles()
end
Profile.saveToFile = Profile.saveProfile

function Profile.loadProfile(name)
    Log.log("Loading profile with the name " .. name)
    local fileName = Profile.profilesDirectory .. "\\" .. name .. ".json"
    local json = Infinity.FileSystem.ReadFile(fileName)
    local raw = JSON:decode(json)
    if raw.navGraph and raw.navGraph.connections then
        Log.log("Converting legacy Profile to new Profile structure...")
        raw = Profile.convertToRawFromLegacy(raw)
    end

    local loaded_profile = NewProfile(name)
    loaded_profile.initFromRaw(raw)
    Grinder.settings.profile_name = name

    fileName = nil
    json = nil
    raw = nil

    return loaded_profile
end

function Profile.refreshProfiles()
    Grinder.availableProfiles = {} -- Reset table on refresh for now
    table.insert(Grinder.availableProfiles, "New profile...")
    local _profiles_dir = Profile.profilesDirectory .. "\\*.json"
    local _profiles = Infinity.FileSystem.GetFiles(_profiles_dir)
    for _, name in ipairs(_profiles) do
        table.insert(Grinder.availableProfiles, name:sub(1, name:len() - 5))
    end

    _profiles_dir = nil
    _profiles = nil
end

function Profile.convertToRawFromLegacy(raw)
    local new = {}
    new.areas = raw.areas
    new.npcs = raw.npcs

    new.graph = {}
    new.graph.graph = {nodes = {}, edges = {}}
    for k, v in pairs(raw.navGraph.nodes) do
        table.insert(new.graph.graph.nodes, {X = v.X, Y = v.Y, Z = v.Z, index = v.Id})
    end

    for k, v in pairs(raw.navGraph.connections) do
        for _, toCon in pairs(v) do
            table.insert(new.graph.graph.edges, {fromIndex = k, toIndex = toCon})
        end
    end

    new.graph.key_graph = {nodes = {}, edges = {}}

    return new
end
