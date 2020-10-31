-- TODO: Rewrite and add all functions into Actors.lua
MagLib.BDO.Actors.internalCache = {
	actorsInRange = {},
	actorsInRangeLastUpdated = 0,
	npcsInRange = {},
	npcsInRangeLastUpdated = 0
}

local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos
local getTime = MagLib.getTime

function MagLib.BDO.Actors.getClosestActorInfo()
	-- Log.debugLog("MagLib.BDO.Actors getClosestActorInfo")
	local npcs = MagLib.BDO.Actors.getNPCsInRange(1000)
	local closestNPC = MagLib.BDO.Actors.getClosestActorFromActorList(npcs)
	if closestNPC then
		local actorName = closestNPC:getName()
		local actorKey = closestNPC:getActorKey()
		local code = [[
    local actor = getActor(]] .. actorKey .. [[)
    if actor then
      local characterKey = actor:getCharacterKeyRaw()
      local npcData1 = getNpcInfoByCharacterKeyRaw(characterKey, 1)
      local npcData2 = getNpcInfoByCharacterKeyRaw(characterKey, 2)
      if nil ~= npcData1 then
        return npcData1:getSpawnType()
      elseif nil ~= npcData2 then
        return npcData2:getSpawnType()
      end
    end
    return "Unknown"
    ]]
		local actorType = Infinity.BDO.Lua.Execute(code)
		local actorDistance = closestNPC:getPosition():getDistance(getPPos())

		return actorName, actorKey, actorType, actorDistance
	else
		return nil
	end

end

function MagLib.BDO.Actors.getActorsInRange(range)
	-- Log.debugLog("MagLib.BDO.Actors getActorsInRange")
	if MagLib.BDO.Actors.internalCache.actorsInRangeLastUpdated + 25 > getTime() then -- Update 40 times per second, basically just preventing using it several time per second
		return MagLib.BDO.Actors.internalCache.actorsInRange
	end

	local results = {}

	local playerPos = getPPos()

	for _, v in pairs(Infinity.BDO.getActorList(EActorType_All)) do
		local actor = v
		if actor and MagLib.BDO.Actors.isValidActor(actor) then
			local actorPos = actor:getPosition()
			if (playerPos:getDistance(actorPos) < range) then
				table.insert(results, v)
			end
		end

		actor = nil
	end
	MagLib.BDO.Actors.internalCache.actorsInRangeLastUpdated = getTime()
	MagLib.BDO.Actors.internalCache.actorsInRange = results

	playerPos = nil

	return results
end

function MagLib.BDO.Actors.getNPCsInRange(range)
	-- Log.debugLog("MagLib.BDO.Actors getNPCsInRange")
	if MagLib.BDO.Actors.internalCache.npcsInRangeLastUpdated + 250 > getTime() then -- Update not every time the function is called for performance reasons
		return MagLib.BDO.Actors.internalCache.npcsInRange
	end

	local results = {}
	local pPos = getPPos()

	for _, v in pairs(Infinity.BDO.getActorList(EActorType_Npc)) do
		local actor = v
		if actor and MagLib.BDO.Actors.isValidActor(actor) then
			local actorPos = actor:getPosition()
			if (pPos:getDistance(actorPos) < range) then
				table.insert(results, v)
			end

			actorPos = nil
		end

		actor = nil
	end
	MagLib.BDO.Actors.internalCache.npcsInRangeLastUpdated = getTime()
	MagLib.BDO.Actors.internalCache.npcsInRange = results

	return results
end

function MagLib.BDO.Actors.getMobsInRange(range)
	local mobs = {}
	local isValidActor = MagLib.BDO.Actors.isValidActor
	local isAttackable = TargetHelper.isAttackable
	local pPos = getPPos()

	for _, mob in pairs(Infinity.BDO.getActorList(EActorType_Monster)) do
		if (mob) and (isValidActor(mob)) and (isAttackable(mob)) and (not mob:getIsDead()) and (not (mob:getHp() <= 0.1)) then
			local mobPos = mob:getPosition()
			if (pPos:getDistance(mobPos) <= range) then
				table.insert(mobs, mob)
			end
		end
	end

	return mobs
end

function MagLib.BDO.Actors.getMobsInRange_ReachableStraightLine(range)
	local mobs = {}
	local isValidActor = MagLib.BDO.Actors.isValidActor
	local isAttackable = TargetHelper.isAttackable
	local pPos = getPPos()

	for _, mob in pairs(Infinity.BDO.getActorList(EActorType_Monster)) do
		if (mob) and (isValidActor(mob)) and (isAttackable(mob)) and (not mob:getIsDead()) and (not (mob:getHp() <= 0.1)) then
			local mobPos = mob:getPosition()
			if (pPos:getDistance(mobPos) <= range) and not MagLib.BDO.Raycast.safeTwoPos(mobPos, pPos) then
				table.insert(mobs, mob)
			end
		end
	end

	return mobs
end

function MagLib.BDO.Actors.getActorKeyByCharacterKeyRaw(characterKey)
	-- Log.debugLog("MagLib.BDO.Actors getActorKeyByCharacterKeyRaw")
	for _, actor in ipairs(MagLib.BDO.Actors.getActorsInRange(5000)) do
		if actor and MagLib.BDO.Actors.isValidActor(actor) and actor:getCharacterKeyRaw() == characterKey then
			return actor:getActorKey()
		end
	end
	return nil
end

function MagLib.BDO.Actors.getNpcActorKeysBySpawnType(radius, spawnType)
	-- Log.debugLog("MagLib.BDO.Actors getNPCActorKeysBySpawnType")
	local rightActorResults = {}
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
          if (nil ~= npcData1 and npcData1:hasSpawnType(]] .. spawnType .. [[))
          or (nil ~= npcData2 and npcData2:hasSpawnType(]] .. spawnType .. [[))
          then
            return true
          end
        end
        return false
        ]]
				local isRightActor = Infinity.BDO.Lua.Execute(code)
				if isRightActor then
					-- Log.log("Found actor with spawnType " .. spawnType .. " | rightActorKey: " .. rightActorKey)
					table.insert(rightActorResults, actorKey)
				end
			end
		end
	end

	return rightActorResults
end

function MagLib.BDO.Actors.getClosestActorFromActorList(t)
	-- Log.debugLog("MagLib.BDO.Actors getClosestActorFromActorList")
	if t == nil then
		return nil, nil
	end

	local closestActor = nil
	local closestActorDistance = 1 / 0
	for k, v in pairs(t) do
		if MagLib.BDO.Actors.isValidActor(v) then
			local distance = getPPos():getDistance(v:getPosition())
			if closestActorDistance > distance then
				closestActor = v
				closestActorDistance = distance
			end
		end
	end
	return closestActor, closestActorDistance
end

function MagLib.BDO.Actors.getClosestActorFromNPCKeylist(t)
	-- Log.debugLog("MagLib.BDO.Actors getClosestActorFromNPCKeyList")

	if t == nil then
		return nil, nil, nil
	end

	local closestActorName = nil
	local closestActorDistance = 1 / 0
	local closestActorPos = nil
	-- table.print(t

	local pPos = getPPos()
	for k, v in pairs(t) do
		-- print(k .. ": " .. table.toString(v))
		local distance = pPos:getDistance(Vector3(v.posX, v.posY, v.posZ))
		if closestActorDistance > distance then
			closestActorName = v.name
			closestActorDistance = distance
			closestActorPos = Vector3(v.posX, v.posY, v.posZ)
		end

		distance = nil
	end

	pPos = nil

	return closestActorName, closestActorDistance, closestActorPos
end

function MagLib.BDO.Actors.getClosestKeyFromKeylist(t)
	-- Log.debugLog("MagLib.BDO.Actors getClosestKeyFromKeylist")
	if t == nil then
		return nil, nil
	end

	local closestActorKey = nil
	local closestActorDistance = 1 / 0

	local pPos = getPPos()

	for k, v in pairs(t) do
		local distance = pPos:getDistance(MagLib.BDO.Actors.getActor(v):getPosition())
		if closestActorDistance > distance then
			closestActorKey = v
			closestActorDistance = distance
		end
		distance = nil
	end

	pPos = nil

	return closestActorKey, closestActorDistance
end

function MagLib.BDO.Actors.getActor(key)
	return Infinity.BDO.getActorByActorKey(key)
end

function MagLib.BDO.Actors.getClosestFilteredActor(actorType, filterFunction)
	local _ = nil
	local closest = nil
	local closestDistance = 1 / 0
	local pPos = getPPos()

	local actors = Infinity.BDO.getActorList(actorType)
	for _, actor in pairs(actors) do
		local dist = actor:getPosition():getDistance(pPos)
		if dist < closestDistance and filterFunction(actor) then
			closest = actor
			closestDistance = dist
		end
	end

	return closest, closestDistance

end

function MagLib.BDO.Actors.getCharacterGrade(actor)
	local code = "local actor = getCharacterActor(" .. actor:getActorKey() .. ") \n return actor:getCharacterGradeType()"
	return Infinity.BDO.Lua.Execute(code)
end
