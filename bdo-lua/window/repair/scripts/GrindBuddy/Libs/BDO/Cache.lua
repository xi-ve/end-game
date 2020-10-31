local function split(pString, pPattern)
  local Table = {}
  local fpat = "(.-)" .. pPattern
  local last_end = 1
  local s, e, cap = pString:find(fpat, 1)
  while s do
    if s ~= 1 or cap ~= "" then
      table.insert(Table, cap)
    end
    last_end = e + 1
    s, e, cap = pString:find(fpat, last_end)
  end
  if last_end <= #pString then
    cap = pString:sub(last_end)
    table.insert(Table, cap)
  end

  fpat = nil
  last_end = nil
  s = nil
  e = nil
  cap = nil

  return Table
end

--Cache
Cache = {}

Cache.time = Infinity.Win32.GetTickCount()
function Cache.updateTime()
  --Log.debugLog("Cache updateTime")
  Cache.time = Infinity.Win32:GetTickCount()
end

Cache.playerPos = Player.getPos()

function Cache.updatePlayerPos()
  --Log.debugLog("Cache updatePlayerPos")
  Cache.playerPos = Player.getPos()
  --Log.log("Player Position: " .. VectorUtils.toString(Cache.playerPos))
end

Cache.closestNpcs = {
  marketplace = nil,
  repair = nil,
  trade = nil,
  storage = nil,
  goods = nil
}
Cache.closestNpcsLastUpdated = 0

Cache.lootActors = {}
function Cache.updateLootActors()
  local autoLootScript = Infinity.Scripting.GetScript("AutoLoot")
  if autoLootScript.IsRunning == false then
    Log.log("Starting Autoloot as it is not started yet!")
    autoLootScript:Start()
    Grinder.wait(250)
    return true
  end

  local code = [[
    local lootString = ""
    for k, v in pairs(AutoLoot.lootActors) do
      local aP  = v.Position
      local x = aP.X
      local y = aP.Y
      local z = aP.Z
      lootString = lootString .. x .. "," .. y .. "," .. z ..",".. v.ActorKey .. "|"
    end

    return lootString
  ]]
  local thisScript = Infinity.Scripting.CurrentScript
  local lootString = thisScript:LuaExec(autoLootScript, code)

  local lootPosRawTable = split(lootString, "|")
  Cache.lootActors = {}
  for k, lootPosRaw in ipairs(lootPosRawTable) do
    if lootPosRaw ~= "" and lootPosRaw ~= nil then
      local c = split(lootPosRaw, ",")
      if c then
        local lootPos = Vector3(c[1], c[2], c[3])
        local actorKey = c[4]
        table.insert(Cache.lootActors, {pos = lootPos, key = actorKey})

        lootPos = nil
        actorKey = nil
      end

      c = nil
    end
  end

  thisScript = nil
  lootString = nil
  lootPosRawTable = nil
end

function Cache.needToUpdateClosestNpcs()
  Log.debugLog("Cache needToUpdateClosestNpcs")
  if Grinder.currentProfile and Grinder.currentProfile.isRecording then
    return true
  end
  return false
end

--Updates Cache.closestNpcs with npcs in max distance 3k
function Cache.updateClosestNpcList(force)
  --Log.debugLog("Cache updateClosestNpcList")
  if Cache.needToUpdateClosestNpcs() or force then
    local marketplaceNpcKeys = ActorUtils.getNpcActorKeysBySpawnType(3000, "CppEnums.SpawnType.eSpawnType_ItemMarket")
    if marketplaceNpcKeys and #marketplaceNpcKeys > 0 then
      Cache.closestNpcs.marketplace = ActorUtils.getActor(ActorUtils.getClosestActorFromKeylist(marketplaceNpcKeys))
    else
      Cache.closestNpcs.marketplace = nil
    end

    marketplaceNpcKeys = nil


    local repairNpcKeys = ActorUtils.getNpcActorKeysBySpawnType(3000, "CppEnums.SpawnType.eSpawnType_ItemRepairer")
    if repairNpcKeys and #repairNpcKeys > 0 then
      Cache.closestNpcs.repair = ActorUtils.getActor(ActorUtils.getClosestActorFromKeylist(repairNpcKeys))
    else
      Cache.closestNpcs.repair = nil
    end

    repairNpcKeys = nil

    local tradeNpcKeys = ActorUtils.getNpcActorKeysBySpawnType(3000, "CppEnums.SpawnType.eSpawnType_TradeMerchant")
    if tradeNpcKeys and #tradeNpcKeys > 0 then
      Cache.closestNpcs.trade = ActorUtils.getActor(ActorUtils.getClosestActorFromKeylist(tradeNpcKeys))
    else
      Cache.closestNpcs.trade = nil
    end

    tradeNpcKeys = nil

    local storageNpcKeys = ActorUtils.getNpcActorKeysBySpawnType(3000, "CppEnums.SpawnType.eSpawnType_WareHouse")
    if storageNpcKeys and #storageNpcKeys > 0 then
      Cache.closestNpcs.storage = ActorUtils.getActor(ActorUtils.getClosestActorFromKeylist(storageNpcKeys))
    else
      Cache.closestNpcs.storage = nil
    end

    storageNpcKeys = nil

    local goodsNpcKeys = ActorUtils.getNpcActorKeysBySpawnType(3000, "CppEnums.SpawnType.eSpawnType_Potion")
    if goodsNpcKeys and #goodsNpcKeys > 0 then
      Cache.closestNpcs.goods = ActorUtils.getActor(ActorUtils.getClosestActorFromKeylist(goodsNpcKeys))
    else
      Cache.closestNpcs.goods = nil
    end
    goodsNpcKeys = nil

    Cache.closestNpcsLastUpdated = Cache.time
  end
end

function Cache.getClosestMonster()
  local closestMob = nil
  local closestMobDistance = 1 / 0

  local pPos = Cache.playerPos
  for _, v in pairs(Cache.mobsInRange) do
    if ActorUtils.isValidActor(v) then
      local actorKey = v:getActorKey()
      local blockedUntil = Grinder.mobBlacklist[actorKey]
      if not (blockedUntil and Cache.time < blockedUntil) then

        local distanceToMob = pPos:getDistance(v:getPosition())
        if distanceToMob < closestMobDistance then
          closestMob = v
          closestMobDistance = distanceToMob
        end
      end
    end
  end

  pPos = nil
  return closestMob, closestMobDistance
end


Cache.mobsInRange = {}
Cache.mobsInRangeLastUpdated = 0

function Cache.updateMobsInRange()

  Log.debugLog("Cache updateMobsInRange")

  Cache.mobsInRange = {}

  local pPos = Cache.playerPos

  local mobsInPlayerRange = TargetHelper.getMonstersInRange(Grinder.settings.attack_mob_from_player_range + 50)
  for _, actor in pairs(mobsInPlayerRange) do
    if actor and ActorUtils.isValidActor(actor) then
      local actorId = actor:getActorId()
      local actorKey = actor:getActorKey()

      local isBlacklistMob = false

      for _, v in pairs(Grinder.settings.blacklist_mob_ids) do
        if v.id == actorId then
          isBlacklistMob = true
          break
        end
      end

      if not isBlacklistMob then
        local blockedUntil = Grinder.mobBlacklist[actorKey]
        if blockedUntil and Cache.time < blockedUntil then
          isBlacklistMob = true
        end
      end


      if not isBlacklistMob then

        local actorPos = actor:getPosition()
        local distanceToMob = actorPos:getDistance(pPos)

        if not (distanceToMob > (Grinder.settings.attack_mob_from_player_range + 50) or distanceToMob > 3000) then

          local insert = false

          if distanceToMob < 350 then
            insert = true
          elseif not Raycast.twoPos(pPos, actorPos) then
            if (Grinder.currentProfile and Grinder.currentProfile.navGraph.graph_handler.graph.nodes and #Grinder.currentProfile.navGraph.graph_handler.graph.nodes > 0) then

              local closestNode, closestNodeDistance = Grinder.currentProfile.navGraph.graph_handler.getClosestNode(actorPos)

              if (closestNodeDistance < Grinder.settings.attack_mob_from_path_range) then
                insert = true
              else
                local _areas = Grinder.currentProfile.areas
                for _, area in pairs(_areas) do
                  for _, spot in pairs(area.spots) do
                    if (insert == false) then
                      if (actorPos:getDistance(Vector3(spot.X, spot.Y, spot.Z)) < Grinder.settings.attack_mob_from_grindSpot_range) then
                        insert = true
                      end
                    end
                  end
                end
              end

              closestNodeDistance = nil
              closestNode = nil

            else
              insert = true
            end
          else
          end

          if insert then
            table.insert(Cache.mobsInRange, actor)
          end
          insert = nil
        end

        actorPos = nil
        distanceToMob = nil
      end

      actorKey = nil
      actorId = nil
    end
  end

  mobsInPlayerRange = nil

  Log.debugLog("Successfully updated monsters in range")
  Cache.mobsInRangeLastUpdated = Cache.time
end



Cache.raycasts = {
  toTargetActor = false,
  toTargetActorDistance = 0,
  toTargetActorRVec = Vector3(0, 0, 0),
  toDest = false,
  toDestDistance = 0,
  toDestRVec = Vector3(0, 0, 0),
  toNextNode = false,
  toNextNodeDistance = 0,
  toNextNodeRVec = Vector3(0, 0, 0)
}

Cache.lastTimeRaycastCheck = 0

function Cache.updateRaycasts()
  Log.debugLog("Cache updateRaycasts")
  if Cache.playerPos then
    if Grinder.currentTargetKey then
      local targetActor = ActorUtils.getActor(Grinder.currentTargetKey)
      if targetActor then
        local targetActorPos = targetActor:getPosition()
        if targetActorPos then
          Cache.raycasts.toTargetActor, Cache.raycasts.toTargetActorDistance, Cache.raycasts.toTargetActorRVec = Raycast.twoPos(Cache.playerPos, targetActorPos)
        end
        --Resetting local vars
        targetActorPos = nil
      end
      --Resetting local vars
      targetActor = nil
    end

    if Grinder.currentDest then
      local destAsVector = Vector3(Grinder.currentDest.X, Grinder.currentDest.Y, Grinder.currentDest.Z)
      Cache.raycasts.toDest, Cache.raycasts.toDestDistance, Cache.raycasts.toDestRVec = Raycast.twoPos(Cache.playerPos, destAsVector)
      destAsVector = nil
    end

    if Grinder.currentProfile
    and Grinder.currentProfile.nav.path
    and #Grinder.currentProfile.nav.path > 0 then
      local navDestAsVector = Grinder.currentProfile.nav.path.waypoints[1]
      Cache.raycasts.toNextNode, Cache.raycasts.toNextNodeDistance, Cache.raycasts.toNextNodeRVec = Raycast.twoPos(Cache.playerPos, navDestAsVector)
      navDestAsVector = nil
    end
  end

  Cache.lastTimeRaycastCheck = Cache.time
end


Cache.inventoryItemsNames = {}
Cache.inventoryItemsIds = {}
Cache.updateInventoryItemsLastTime = 0

function Cache.updateInventoryItems()
  --Log.debugLog("Cache updateInventoryItems")
  Cache.inventoryItems = {}
  Cache.inventoryItemsIds = {}

  local invenMaxSize = Inventory.getMaxSize()

  if invenMaxSize == 0 then
    invenMaxSize = nil
    return
  end

  local itemTableNames = {}
  local itemTableIds = {}


  if invenMaxSize > 2 then
    for i = 2, invenMaxSize - 1 do
      if Inventory.hasItemWrapper(i) then
        local name
        local itemId
        local count

        name, itemId, count = Inventory.getItemData(i)

        if name ~= nil and itemId ~= nil then
          if table.find(itemTableIds, itemId) == nil then
            table.insert(itemTableNames, name)
            table.insert(itemTableIds, itemId)
          end
        end

        name = nil
        itemId = nil
        count = nil

      end
    end
  end

  invenMaxSize = nil

  Cache.inventoryItemsNames = itemTableNames
  Cache.inventoryItemsIds = itemTableIds

  itemTableNames = nil
  itemTableIds = nil

  Cache.updateInventoryItemsLastTime = Cache.time

end

Cache.playerLevel = Player.getLevel()
Cache.playerExp = Player.getCurrentExp()
Cache.playerExpPerc = Player.getCurrentExpPerc()
Cache.expGained = false
Cache.updatePlayerExpCheck = 0

function Cache.updatePlayerExp()
  --Log.debugLog("Cache updatePlayerExp")
  local newLevel = Player.getLevel()
  local newPlayerExp = Player.getCurrentExp()

  if newLevel > Cache.playerLevel or newPlayerExp > Cache.playerExp then
    Cache.expGained = true
  else
    Cache.expGained = false
  end

  Cache.playerLevel = newLevel
  Cache.playerExp = newPlayerExp
  Cache.playerExpPerc = Player.getCurrentExpPerc()


  newLevel = nil
  newPlayerExp = nil

  Cache.updatePlayerExpCheck = Cache.time
end



Cache.expGainedTable = {}
Cache.lastLevel = Player.getLevel()
Cache.lastExp = Player.getCurrentExpPerc()
Cache.lastExpUpdate = 0

Cache.percentPerMinute = 0
Cache.percentPerHour = 0
Cache.minUntilLevelup = 1 / 0
Cache.hrUntilLevelup = 1 / 0

function Cache.resetExpData()
  Log.debugLog("Cache resetExpData")
  Cache.expGainedTable = {}
  Cache.lastLevel = Player.getLevel()
  Cache.lastExp = Player.getCurrentExpPerc()
  Cache.lastExpUpdate = 0

  Cache.percentPerMinute = 0
  Cache.percentPerHour = 0
  Cache.minUntilLevelup = 1 / 0
  Cache.hrUntilLevelup = 1 / 0
end

function Cache.round(num, numDecimalPlaces)
  --Log.debugLog("Cache round")
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function Cache.updateExpData()
  --Log.debugLog("Cache updateExpData")
  if Grinder.settings.track_exp and Cache.lastExpUpdate + 1000 < Cache.time then
    --Insert into list
    local playerExpPerc = Cache.playerExpPerc
    local level = Cache.playerLevel
    local currentTime = Cache.time

    local expGained = playerExpPerc - Cache.lastExp
    if level ~= Cache.lastLevel then
      expGained = 100 - playerExpPerc
    end

    table.insert(Cache.expGainedTable, expGained)
    Cache.lastExpUpdate = currentTime
    Cache.lastLevel = Player.getLevel()
    Cache.lastExp = Player.getCurrentExpPerc()

    playerExpPerc = nil
    level = nil
    currentTime = nil

    expGained = nil
    Cache.updateEXPStats()
  end
end

Cache.lastExpCleanupTime = 0

function Cache.cleanUpExpData()
  --Log.debugLog("Cache cleanUpExpData")
  -- Keep 100 entries, meaning the last 10/6min
  local amountOfDataToKeep = 100
  local amountOfEntries = #Cache.expGainedTable
  if Cache.lastExpCleanupTime + 1000 < Cache.time then
    if amountOfEntries > amountOfDataToKeep then
      while amountOfEntries > amountOfDataToKeep do
        table.remove(Cache.expGainedTable, 1)
        amountOfEntries = #Cache.expGainedTable
      end
    end
    Cache.lastExpCleanupTime = Cache.time
  end

  amountOfDataToKeep = nil
  amountOfEntries = nil
end

function Cache.updateEXPStats()
  --Log.debugLog("Cache updateExpStats")

  Cache.cleanUpExpData()

  local gainedSum = 0
  local dataCounter = 0

  --table.print(Cache.expGainedTable)

  for _, v in pairs(Cache.expGainedTable) do
    gainedSum = gainedSum + v
    dataCounter = dataCounter + 1
  end


  local expAvgPerSecond = Cache.round(gainedSum / dataCounter, 5)

  Cache.percentPerMinute = Cache.round(expAvgPerSecond * 60, 5)
  Cache.percentPerHour = Cache.round(expAvgPerSecond * 60 * 60, 5)

  local percNeeded = 100 - Player.getCurrentExpPerc()

  Cache.minUntilLevelup = Cache.round(percNeeded / Cache.percentPerMinute, 3)
  Cache.hrUntilLevelup = Cache.round(percNeeded / Cache.percentPerHour, 3)


  gainedSum = nil
  dataCounter = nil

  expAvgPerSecond = nil
  percNeeded = nil
end


function Cache.updateCachePulse()

  Log.debugLog("Cache updateCachePulse _ Start")
  --Cache things to update every pulse
  --Time
  Cache.updateTime()
  --Player Position
  Cache.updatePlayerPos()

  if Cache.updatePlayerExpCheck + 67 then
    --Player EXP and Level
    Cache.updatePlayerExp()
  end

  --Raycasts
  if Cache.lastTimeRaycastCheck + 125 < Cache.time and Grinder.is_started then
    Cache.updateRaycasts()
  end

  --MobsInRange
  if Cache.mobsInRangeLastUpdated + 152 < Cache.time and Grinder.is_started then
    Cache.updateMobsInRange()
  end
  --Npcs
  if Grinder.currentProfile and Grinder.currentProfile.isRecording and Cache.closestNpcsLastUpdated + 1054 < Cache.time then
    Cache.updateClosestNpcList()
  end
  
  --Inventory
  if Cache.updateInventoryItemsLastTime + 512 < Cache.time then
    Cache.updateInventoryItems()
  end

  Cache.updateExpData()

end

function Cache.updateCache()
  Log.debugLog("Cache updateCache")
  --Full cache update
  --Time
  Cache.updateTime()
  --Player Position
  Cache.updatePlayerPos()
  --Player Level
  Cache.updatePlayerLevel()
  --Raycasts
  Cache.updateRaycasts()
  --Mobs in Range
  Cache.updateMobsInRange()
  --NPCs
  Cache.updateClosestNpcList(true)
  --Inventory
  Cache.updateInventoryItems()
  --Player EXP
  Cache.updatePlayerExp()

  Cache.updateExpData()
end
