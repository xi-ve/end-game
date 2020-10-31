local Actors = {}

local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos
local getTime = MagLib.getTime

-- Validate Actor
Actors.isValidActor_ByKey = function(key)
	local code = [[
    local actor = getActor(]] .. key .. [[)
    if actor then
      return true
    end

  ]]

	return Infinity.BDO.Lua.Execute(code)
end

Actors.isValidActor = function(actor)
	if actor then
		return (Actors.isValidActor_ByKey(actor:getActorKey()) and actor:isValid())
	else
		return false
	end
end

Actors.getActorWithName = function(name, actorType)
	-- Log.debugLog("MagLib.BDO.Actors getActorWithName")
	local actors = Infinity.BDO.getActorList(actorType)
	for _, actor in pairs(actors) do
		if Actors.isValidActor(actor) and actor:getName() == name then
			return actor
		end
	end

	return nil
end

Actors.getActorWithId = function(id, actorType)
	-- Log.debugLog("MagLib.BDO.Actors getActorWithName")
	local actors = Infinity.BDO.getActorList(actorType)
	for _, actor in pairs(actors) do
		if Actors.isValidActor(actor) and actor:getActorId() == id then
			return actor
		end
	end

	return nil
end

Actors.getActorWithFamilyName = function(name, actorType)
	-- Log.debugLog("MagLib.BDO.Actors getActorWithName")
	local actors = Infinity.BDO.getActorList(actorType)
	for _, actor in pairs(actors) do
		if Actors.isValidActor(actor) and actor:getFamilyName() == name then
			return actor
		end
	end

	return nil
end

Actors.getMobs = function(range)
	if range == nil then
		range = 1 / 0
	end

	local actors = Infinity.BDO.getActorList(EActorType_Monster)

	local mobs = {}
	local pPos = getPPos()
	for k, v in pairs(actors) do
		if Actors.isValidActor(v) and v:getPosition():getDistance(pPos) < range then
			table.insert(mobs, v)
		end
	end

	return mobs
end

Actors.getClosestMob = function(pos)
	local actors = Actors.getMobs()

	local closestMob = nil
	local closestMobDistance = 1 / 0
	for k, v in pairs(actors) do
		if Actors.isValidActor(actor) and not (v:getIsDead() or v:getHp() <= 0) then
			local vPos = v:getCharacterControler():getPhysPos()
			local dist = vPos:getDistance(pos)
			if dist < closestMobDistance then
				closestMob = v
				closestMobDistance = dist
			end
		end
	end

	return closestMob, closestMobDistance
end

Actors.getClosestActorWithId = function(pos, id, actorType)
	-- Log.debugLog("MagLib.BDO.Actors getActorWithName")
	local actors = Infinity.BDO.getActorList(actorType)
	local closestActor = nil
	local closestActorDistance = 1 / 0
	for _, actor in pairs(actors) do
		local vPos = actor:getCharacterControler():getPhysPos()
		local dist = vPos:getDistance(pos)
		if Actors.isValidActor(actor) and actor:getActorId() == id and dist < closestActorDistance then
			closestActor = actor
			closestActorDistance = dist
		end
	end

	return closestActor, closestActorDistance
end

-- Init
for k, v in pairs(Actors) do
	MagLib.BDO.Actors[k] = v
end
