Render2D2 = {}

Render2D2.editModeTarget = nil
Render2D2.editModeTargetIsNode = false
Render2D2.editModeTargetLastUpdate = 0

function Render2D2.render()
  if not Player.me() then
    return
  end

  if not Cache.playerPos then
    --Cache not initiated yet
    return
  end

  Log.debugLog("OnRenderD2D")

  local pPos = Cache.playerPos
  local time = Cache.time

  --Debugging stuff
  --Log.debugLog("Debug render")
  if DebugUI.raycastCheckDest then
    local collision = false
    local dPos = DebugUI.raycastCheckDest
    local collisionDist = 0
    local rVec = nil
    if DebugUI.raycastCheckSafe then
      collision, collisionDist, rVec = Raycast.safeTwoPos(pPos, dPos)
    else
      collision, collisionDist, rVec = Raycast.twoPos(pPos, dPos)
    end

    local mrVec = Vector3(dPos.X - pPos.X, dPos.Y - pPos.Y, dPos.Z - pPos.Z)
    --Log.log("rVec: " .. VectorUtils.toString(rVec) .. " | mrVec: " .. VectorUtils.toString(mrVec))


    if collision then
      local rVecLength = math.sqrt(((rVec.X ^ 2) + (rVec.Y ^ 2) + (rVec.Z ^ 2)))
      local rVecMultiplier = 1 / rVecLength
      local normedRVec = Vector3(rVec.X * rVecMultiplier, rVec.Y * rVecMultiplier, rVec.Z * rVecMultiplier)
      local distanceTC = Cache.raycasts.toTargetActorDistance --Distance to collision
      local vectorToCollision = Vector3(normedRVec.X * collisionDist, normedRVec.Y * collisionDist, normedRVec.Z * collisionDist)
      local collisionPos = Vector3(pPos.X + vectorToCollision.X, pPos.Y + vectorToCollision.Y, pPos.Z + vectorToCollision.Z)
      RenderHelper.DrawWorldCircle(collisionPos, 20, "FF000000", 1, true)
      RenderHelper.DrawWorldLine(pPos, dPos, "FF000000", 4)
    else
      RenderHelper.DrawWorldLine(pPos, dPos, "FFFFFFFF", 4)
    end
  end

  --[[--FreeMoveTask testing
    if Grinder.settings.draw_debug_freeMoveTask then
        if (AStar.shortDistanceNodes and #AStar.shortDistanceNodes > 0) then
            for k, v in pairs(AStar.shortDistanceNodes) do
                RenderHelper.DrawWorldCircle(v, 10, "FF000000", 1, true)
            end
        end

        if (FreeMoveTask.nodes and#FreeMoveTask.nodes > 0) then
            for k, v in pairs(FreeMoveTask.nodes) do
                RenderHelper.DrawWorldCircle(v, 10, "FF000000", 1, true)
            end
        end
    end]]


  if (Grinder.settings.draw_freeMove_path) then
    --Log.debugLog("freemovePath")
    if (FreeMoveTask.endDest) then
      RenderHelper.DrawWorldCircle(FreeMoveTask.endDest, 30, "FFC7C8C9", 1, true)
    end

    --Log.debugLog("After FreeMoveTask.endDest render")

    if (FreeMoveTask.path ~= nil and #FreeMoveTask.path > 0) then
      --Log.debugLog("Rendering path")
      for k, v in pairs(FreeMoveTask.path) do

        local posNode = Vector3(v.X, v.Y, v.Z)
        local nextNode = FreeMoveTask.path[k + 1]
        if nextNode then
          local nextPos = Vector3(nextNode.X, nextNode.Y, nextNode.Z)

          if (FreeMoveTask.path[k + 1] ~= nil) then
            nextNode = FreeMoveTask.path[k + 1]
            nextPos = Vector3(nextNode.X, nextNode.Y, nextNode.Z)
          else
            --From here it goes directily to endDest
            nextPos = FreeMoveTask.endDest
          end

          if posNode then
            RenderHelper.DrawWorldLine(posNode, nextPos, "FF3CFF00", 4)
          end
        end
        
      end
    elseif FreeMoveTask.endDest ~= nil then --Moving directly to dest
      RenderHelper.DrawWorldLine(Cache.playerPos, FreeMoveTask.endDest, "FF3CFF00", 4)
    end
  end


  --Log.debugLog("After FreeMoveTask Path rendering and before profile rendering")

  local currentProfile = Grinder.currentProfile
  if currentProfile then

    local renderDistance = Grinder.settings.render_navigation_distance
    local onMap = Game.isWorldmapOpen()

    --For every grindspot, render a black circle and a text, if wanted
    if (Grinder.settings.draw_grindSpots) then
      local grindSpotRadius = Grinder.settings.attack_mob_from_grindSpot_range
      for _, v in pairs(Grinder.currentProfile.areas) do
        for k, spot in pairs(v.spots) do
          local spotPos = Vector3(spot.X, spot.Y, spot.Z)
          --RenderHelper.DrawWorldCircle(spotPos, Grinder.settings.attack_mob_from_grindSpot_range, "FF000000", 2, false)
          local dist = spotPos:getDistance(pPos)
          if spotPos and k and (dist < renderDistance or onMap) then
            RenderHelper.DrawWorldText("Grindspot #" .. k, 30, "FF000000", spotPos, 30, 30)
            RenderHelper.DrawWorldCircle(spotPos, grindSpotRadius, "FF000000", 1, false)
          end
        end
      end
    end



    if Grinder.settings.draw_navigation then
      local drawNumbers = Grinder.settings.draw_navigation_numbers

      if Grinder.settings.renderT1 then

        local graph = currentProfile.navGraph.graph_handler.getGraph()
        for _, v in pairs(graph.nodes) do
          local dist = v.pos:getDistance(pPos)
          if dist < renderDistance then
            RenderHelper.DrawWorldCircle(v.pos, 15, "FFe5e4e2", 2, false)
            if drawNumbers then
              RenderHelper.DrawWorldText("Node #" .. v.index, 20, "FFe5e4C2", v.pos, 0, - 40)
            end
          end
        end

        for _, v in ipairs(graph.edges) do
          local dist = v.from.pos:getDistance(pPos)
          if dist < renderDistance or onMap then
            RenderHelper.DrawWorldLine(v.from.pos, v.to.pos, "FFc0c0c0", 1)
          end
        end
      end

      if Grinder.settings.renderT2 then
        local key_graph = currentProfile.navGraph.key_graph_handler.getGraph()
        for _, v in pairs(key_graph.nodes) do
          local dist = v.pos:getDistance(pPos)
          if dist < renderDistance or onMap then
            RenderHelper.DrawWorldCircle(v.pos, 15, "FF643200", 2, true)
            if drawNumbers then
              RenderHelper.DrawWorldText("T2 Node #" .. v.index, 30, "FF643200", v.pos, 0, - 70)
            end
          end
        end

        for _, v in ipairs(key_graph.edges) do
          local dist = v.from.pos:getDistance(pPos)
          if dist < (renderDistance * 5) or onMap then
            RenderHelper.DrawWorldLine(v.from.pos, v.to.pos, "FF8b4513", 3)
          end
        end
      end

    end

    --Render Path
    if Grinder.settings.draw_destination_path then
      --Log.debugLog("Render path")
      if currentProfile and currentProfile.nav.path and currentProfile.nav.path.waypoints then
        local pathLength = #currentProfile.nav.path.waypoints
        for k, pos in ipairs(currentProfile.nav.path.waypoints) do
          if k + 1 < pathLength then
            local nextPos = currentProfile.nav.path.waypoints[k + 1]
            RenderHelper.DrawWorldLine(pos, nextPos, "FFFFD700", 5)
          end

        end
      end

    end

    --Log.debugLog("Before destination draw")
    if Grinder.settings.draw_destination then
      --Draw currentDest and if not equal, the next node (if we are running to one)
      local playerPos = Cache.playerPos
      if (Grinder.currentDest) then
        local destAsVector = Vector3(Grinder.currentDest.X, Grinder.currentDest.Y, Grinder.currentDest.Z)
        if not Cache.raycasts.toDest then
          RenderHelper.DrawWorldLine(destAsVector, playerPos, "FF1780CC", 2)
        else
          RenderHelper.DrawWorldLine(destAsVector, playerPos, "FF2201B4", 2)
          if Grinder.settings.draw_destination_collision_point then
            local rVec = Cache.raycasts.toDestRVec
            if (rVec ~= nil) then
              local rVecLength = math.sqrt(((rVec.X ^ 2) + (rVec.Y ^ 2) + (rVec.Z ^ 2)))
              local rVecMultiplier = 1 / rVecLength
              local normedRVec = Vector3(rVec.X * rVecMultiplier, rVec.Y * rVecMultiplier, rVec.Z * rVecMultiplier)
              local distanceTC = Cache.raycasts.toDestDistance --Distance to collision
              local vectorToCollision = Vector3(normedRVec.X * distanceTC, normedRVec.Y * distanceTC, normedRVec.Z * distanceTC)
              local collisionPos = Vector3(pPos.X + vectorToCollision.X, pPos.Y + vectorToCollision.Y, pPos.Z + vectorToCollision.Z)
              RenderHelper.DrawWorldCircle(collisionPos, 20, "FF000000", 1, true)
            end
          end
        end
      end

      if currentProfile
      and currentProfile.nav.path
      and currentProfile.nav.path.waypoints
      and #currentProfile.nav.path.waypoints > 0 then
        local navDestAsVector = currentProfile.nav.path.waypoints[1]
        if not Cache.raycasts.toNextNode then
          RenderHelper.DrawWorldLine(navDestAsVector, playerPos, "FFF4DF41", 2)
        else
          RenderHelper.DrawWorldLine(navDestAsVector, playerPos, "FF000000", 2)
          if Grinder.settings.draw_destination_collision_point then
            local rVec = Cache.raycasts.toNextNodeRVec
            if (rVec ~= nil) then
              local rVecLength = math.sqrt(((rVec.X ^ 2) + (rVec.Y ^ 2) + (rVec.Z ^ 2)))
              local rVecMultiplier = 1 / rVecLength
              local normedRVec = Vector3(rVec.X * rVecMultiplier, rVec.Y * rVecMultiplier, rVec.Z * rVecMultiplier)
              local distanceTC = Cache.raycasts.toTargetActorDistance --Distance to collision
              local vectorToCollision = Vector3(normedRVec.X * distanceTC, normedRVec.Y * distanceTC, normedRVec.Z * distanceTC)
              local collisionPos = Vector3(pPos.X + vectorToCollision.X, pPos.Y + vectorToCollision.Y + 100, pPos.Z + vectorToCollision.Z)
              RenderHelper.DrawWorldCircle(collisionPos, 20, "FF000000", 1, true)
            end
          end
        end
      end
    end

  end

  --Log.debugLog("Before drawing mobs in Range")
  -- Draw mobs in range, that are not the current target
  if Cache.mobsInRange and #Cache.mobsInRange > 0 then
    for k, actor in ipairs(Cache.mobsInRange) do
      if ActorUtils.isValidActor(actor) then
        if (actor:getActorKey() ~= Grinder.currentTargetKey) then
          RenderHelper.DrawWorldCircle(actor:getPosition(), 30, "FF41F4EE", 1, false)
        end
      end
    end
  end

  --Drawing blacklisted mobs
  for k, v in pairs(Grinder.mobBlacklist) do
    if v > time then
      local actor = ActorUtils.getActor(k)
      if actor then
        RenderHelper.DrawWorldCircle(actor:getPosition(), 30, "FF123456", 1, false)
      end
    end
  end

  -- Draw current target
  --Log.debugLog("Drawing currentTarget")
  if (Grinder.currentTargetKey ~= nil) then
    local targetActor = ActorUtils.getActor(Grinder.currentTargetKey)
    if targetActor then
      RenderHelper.DrawWorldCircle(targetActor:getPosition(), 30, "FFFF5733", 4, false)
    end
    --Resetting local vars
    targetActor = nil
  end


  --Log.debugLog("Drawing CombatScript D2D")
  if (Grinder.currentCombatScript and Grinder.currentCombatScript.onRenderD2D) then
    Grinder.currentCombatScript:onRenderD2D()
  end


  --Debug logging
  if Raycast.debugging then
    local toRemoveIndex = {}
    for k, v in ipairs(Raycast.raycastDebugTracking) do
      if v.time + 100 < Infinity.Win32.GetTickCount() then
        table.remove(Raycast.raycastDebugTracking, k)
      else
        local rayStart = v.pos
        local rVec = v.rVec
        local distance = v.distance
        local col = not (v.col == 0.0)

        local rayVec = VectorUtils.multiply(rVec, distance)
        local rayEnd = VectorUtils.add(rayStart, rayVec)
        local color = "FF008000"
        if col then
          color = "FFFF0000"
        end
        RenderHelper.DrawWorldLine(rayStart, rayEnd, color, 1)
      end
    end

    for _, v in ipairs(toRemoveIndex) do
      table.remove(Raycast.raycastDebugTracking, v)
    end
  end

  --Edit Mode rendering


  if Grinder.currentProfile and Grinder.currentProfile.editMode then
    --Updating rendered target every 50ms (This is not the target actually used)
    if Render2D2.editModeTargetLastUpdate + 150 < time then
      local mousePosX, mousePosY = Infinity.BDO.Lua.Execute("return getMousePosX(), getMousePosY()")
      local mousePos = Vector2(mousePosX, mousePosY)
      Render2D2.editModeTarget, _, Render2D2.editModeTargetIsNode = Grinder.currentProfile.nav.graph_handler.getClosestElement_2DOnScreen(mousePos, 125, 50)
      Render2D2.editModeTargetLastUpdate = time
    end

    local editTarget = Render2D2.editModeTarget
    if editTarget then
      if Render2D2.editModeTargetIsNode then
        RenderHelper.DrawWorldCircle(editTarget.pos, 15, "FFD90000", 3, true)
        local edges = Grinder.currentProfile.nav.graph_handler.getEdges(editTarget)
        for _, edge in pairs(edges) do
          RenderHelper.DrawWorldLine(edge.from.pos, edge.to.pos, "FFD90000", 2)
        end
      else
        RenderHelper.DrawWorldLine(editTarget.from.pos, editTarget.to.pos, "FFD90000", 2)
      end
    end

  end




  Log.debugLog("Render end")



end
