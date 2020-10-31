ActorUtils = {}
ActorUtils.internalCache = {
	actorsInRange = {},
	actorsInRangeLastUpdated = 0,
	npcsInRange = {},
	npcsInRangeLastUpdated = 0
}
function ActorUtils.isValidActor(actor)
	if actor then
		return actor:isValid()
	else
		return false
	end
end

function ActorUtils.isValidActor_ByKey(key)
	local code = [[
    local actor = getActor(]] .. key .. [[)
    local hp = 0
    if actor then
        hp = actor:get():getHp()
    end

    return hp > 0

    ]]

	return Infinity.BDO.Lua.Execute(code)
end

function ActorUtils.getClosestActorInfo()
	-- Log.debugLog("ActorUtils getClosestActorInfo")
	local npcs = ActorUtils.getNPCsInRange(1000)
	local closestNPC = ActorUtils.getClosestActorFromActorList(npcs)
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
		local actorDistance = closestNPC:getPosition():getDistance(Cache.playerPos)

		npcs = nil

		return actorName, actorKey, actorType, actorDistance
	else
		npcs = nil
		return nil
	end

end

function ActorUtils.getActorWithName(name, range)
	-- Log.debugLog("ActorUtils getActorWithName")
	local actorsInRange = ActorUtils.getActorsInRange(range)

	for k, v in ipairs(actorsInRange) do
		if ActorUtils.isValidActor(v) and v:getName() == name then
			actorsInRange = nil
			return v
		end
	end

	actorsInRange = nil
	return nil
end

function ActorUtils.getActorsInRange(range)
	-- Log.debugLog("ActorUtils getActorsInRange")
	if ActorUtils.internalCache.actorsInRangeLastUpdated + 25 > Cache.time then -- Update 40 times per second, basically just preventing using it several time per second
		return ActorUtils.internalCache.actorsInRange
	end

	local results = {}

	local playerPos = Cache.playerPos

	for _, v in pairs(Infinity.BDO.getActorList(EActorType_All)) do
		local actor = v
		if actor and ActorUtils.isValidActor(actor) then
			local actorPos = actor:getPosition()
			if (playerPos:getDistance(actorPos) < range) then
				table.insert(results, v)
			end
		end

		actor = nil
	end
	ActorUtils.internalCache.actorsInRangeLastUpdated = Cache.time
	ActorUtils.internalCache.actorsInRange = results

	playerPos = nil

	return results
end

function ActorUtils.getNPCsInRange(range)
	-- Log.debugLog("ActorUtils getNPCsInRange")
	if ActorUtils.internalCache.npcsInRangeLastUpdated + 250 > Cache.time then -- Update not every time the function is called for performance reasons
		return ActorUtils.internalCache.npcsInRange
	end

	local results = {}

	for _, v in pairs(Infinity.BDO.getActorList(EActorType_Npc)) do
		local actor = v
		if actor and ActorUtils.isValidActor(actor) then
			local actorPos = actor:getPosition()
			if (Player.getPos():getDistance(actorPos) < range) then
				table.insert(results, v)
			end

			actorPos = nil
		end

		actor = nil
	end
	ActorUtils.internalCache.npcsInRangeLastUpdated = Cache.time
	ActorUtils.internalCache.npcsInRange = results

	return results
end

function ActorUtils.getActorKeyByCharacterKeyRaw(characterKey)
	-- Log.debugLog("ActorUtils getActorKeyByCharacterKeyRaw")
	for _, actor in ipairs(ActorUtils.getActorsInRange(5000)) do
		if actor and ActorUtils.isValidActor(actor) and actor:getCharacterKeyRaw() == characterKey then
			return actor:getActorKey()
		end
	end
	return nil
end

function ActorUtils.getNpcActorKeysBySpawnType(radius, spawnType)
	-- Log.debugLog("ActorUtils getNPCActorKeysBySpawnType")
	local rightActorResults = {}
	for _, actor in ipairs(ActorUtils.getNPCsInRange(radius)) do
		if ActorUtils.isValidActor(actor) then
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

function ActorUtils.getClosestActorFromActorList(t)
	-- Log.debugLog("ActorUtils getClosestActorFromActorList")
	if t == nil then
		return nil, nil
	end

	local closestActor = nil
	local closestActorDistance = 1 / 0
	for k, v in pairs(t) do
		if ActorUtils.isValidActor(v) then
			local distance = Cache.playerPos:getDistance(v:getPosition())
			if closestActorDistance > distance then
				closestActor = v
				closestActorDistance = distance
			end
		end
	end
	return closestActor, closestActorDistance
end

function ActorUtils.getClosestActorFromNPCKeylist(t)
	-- Log.debugLog("ActorUtils getClosestActorFromNPCKeyList")

	if t == nil then
		return nil, nil, nil
	end

	local closestActorName = nil
	local closestActorDistance = 1 / 0
	local closestActorPos = nil
	-- table.print(t

	local pPos = Cache.playerPos
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

function ActorUtils.getClosestActorFromKeylist(t)
	-- Log.debugLog("ActorUtils getClosestActorFromKeylist")
	if t == nil then
		return nil, nil
	end

	local closestActorKey = nil
	local closestActorDistance = 1 / 0

	local pPos = Cache.playerPos

	for k, v in pairs(t) do
		local distance = pPos:getDistance(ActorUtils.getActor(v):getPosition())
		if closestActorDistance > distance then
			closestActorKey = v
			closestActorDistance = distance
		end
		distance = nil
	end

	pPos = nil

	return closestActorKey, closestActorDistance
end

function ActorUtils.getActor(key)
	-- Log.debugLog("ActorUtils getActor")
	return Infinity.BDO.getActorByActorKey(key)
end

function ActorUtils.getAttackableActorsKey(radius)
	-- Log.debugLog("ActorUtils getAttackableActorsKey")
	local results = {}
	for _, actor in pairs(ActorUtils.getActorsInRange(radius)) do
		if ActorUtils.isValidActor(actor) then
			local actorKey = actor:getActorKey()
			if TargetHelper.isAttackable(actorKey) then
				local actorDead = actor:getIsDead()
				if actor and not actorDead then
					table.insert(results, actorKey)
				end

				actorDead = nil
			end

			actorKey = nil
		end
	end
	-- Log.log("Found attackable actor keys!")
	-- table.print(results)
	return results
end
