TargetHelper = {}

function TargetHelper.getClosestMonsterTarget(range)
	local buffer = {}

	local lpPos = Infinity.BDO.getLocalPlayer():getPosition()

	for k,v in pairs(Infinity.BDO.getActorList(EActorType_Monster)) do
		if TargetHelper.isAttackable(v) and not v:getIsDead() and v:getPosition():getDistance(lpPos) <= range then
			table.insert(buffer, v)
		end
	end

	if table.length(buffer) == 0 then
		return nil
	end

	table.sort(buffer, function(a, b) return a:getPosition():getDistance(lpPos) < b:getPosition():getDistance(lpPos) end)

	return buffer[1]
end

function TargetHelper.getClosestPlayerTarget(range)
	local buffer = {}

	local lpPos = Infinity.BDO.getLocalPlayer():getPosition()

	for k,v in pairs(Infinity.BDO.getActorList(EActorType_Player)) do
		if v:getActorKey() ~= Infinity.BDO.getLocalPlayer():getActorKey() and not v:getIsDead() and v:getPosition():getDistance(lpPos) <= range then
			table.insert(buffer, v)
		end
	end

	if table.length(buffer) == 0 then
		return nil
	end

	table.sort(buffer, function(a, b) return a:getPosition():getDistance(lpPos) < b:getPosition():getDistance(lpPos) end)

	return buffer[1]
end

function TargetHelper.getClosestMonsterTargetFromContainer(tMonsters, blackList)
	local buffer = {}

	local lpPos = Infinity.BDO.getLocalPlayer():getPosition()

	for k,v in pairs(tMonsters) do
		if not v:getIsDead() then
			local shouldAdd = true

			if blackList ~= nil then
				for kk,vv in pairs(blackList) do
					if vv:getDistance(v:getPosition()) <= 25 then
						shouldAdd = false
						break
					end
				end
			end

			if shouldAdd then
				table.insert(buffer, v)
			end
		end
	end

	if table.length(buffer) == 0 then
		return nil
	end

	table.sort(buffer, function(a, b) return a:getPosition():getDistance(lpPos) < b:getPosition():getDistance(lpPos) end)

	return buffer[1]
end

function TargetHelper.getClosestPlayerTargetFromContainer(tPlayers, blackList)
	local buffer = {}

	local lpPos = Infinity.BDO.getLocalPlayer():getPosition()

	for k,v in pairs(tPlayers) do
		if not v:getIsDead() and v:getActorKey() ~= Infinity.BDO.getLocalPlayer():getActorKey() then
			local shouldAdd = true

			if blackList ~= nil then
				for kk,vv in pairs(blackList) do
					if vv:getDistance(v:getPosition()) <= 25 then
						shouldAdd = false
						break
					end
				end
			end

			if shouldAdd then
				table.insert(buffer, v)
			end
		end
	end

	if table.length(buffer) == 0 then
		return nil
	end

	table.sort(buffer, function(a, b) return a:getPosition():getDistance(lpPos) < b:getPosition():getDistance(lpPos) end)

	return buffer[1]
end

function TargetHelper.getMonstersInRange(range)
	local buffer = {}

	local lpPos = Infinity.BDO.getLocalPlayer():getPosition()

	for k,v in pairs(Infinity.BDO.getActorList(EActorType_Monster)) do
		if TargetHelper.isAttackable(v) and not v:getIsDead() and v:getPosition():getDistance(lpPos) <= range then
			table.insert(buffer, v)
		end
	end
	
	return buffer
end

function TargetHelper.getPlayersInRange(range)
	local buffer = {}

	local lpPos = Infinity.BDO.getLocalPlayer():getPosition()

	for k,v in pairs(Infinity.BDO.getActorList(EActorType_Player)) do
		if v:getActorKey() ~= Infinity.BDO.getLocalPlayer():getActorKey() and not v:getIsDead() and v:getPosition():getDistance(lpPos) <= range then
			table.insert(buffer, v)
		end
	end
	
	return buffer
end

function TargetHelper.getMonstersInRangeOfLocation(pos, range, blacklist)	
	local buffer = {}
	
	for k,v in pairs(Infinity.BDO.getActorList(EActorType_Monster)) do
		if TargetHelper.isAttackable(v) and not v:getIsDead() and v:getPosition():getDistance(pos) <= range then

			if blacklist ~= nil then
				--print("has blacklist")
				local isBlackListed = false

				for kb,vb in pairs(blacklist) do
					
					if vb == v:getActorId() then
						--print("blacklisted actorid found")
						isBlackListed = true
						break
					end
				end

				if not isBlackListed then
					table.insert(buffer, v)
				end
			else
				--print("has no blacklist")
				table.insert(buffer, v)
			end
		end
	end
	
	return buffer
end

function TargetHelper.getPlayersInRangeOfLocation(pos, range, blacklist)	
	local buffer = {}
	
	for k,v in pairs(Infinity.BDO.getActorList(EActorType_Player)) do
		if v:getActorKey() ~= Infinity.BDO.getLocalPlayer():getActorKey() and not v:getIsDead() and v:getPosition():getDistance(pos) <= range then

			if blacklist ~= nil then
				--print("has blacklist")
				local isBlackListed = false

				for kb,vb in pairs(blacklist) do
					
					if vb == v:getActorId() then
						--print("blacklisted actorid found")
						isBlackListed = true
						break
					end
				end

				if not isBlackListed then
					table.insert(buffer, v)
				end
			else
				--print("has no blacklist")
				table.insert(buffer, v)
			end
		end
	end
	
	return buffer
end

function TargetHelper.getClosestMonsterAttack(tMonsters)
	local buffer = {}

	local lpPos = Infinity.BDO.getLocalPlayer():getPosition()

	for k,v in pairs(tMonsters) do
		if not v:getIsDead() and TargetHelper.isAttacking(v) then
			table.insert(buffer, v)
		end
	end

	if table.length(buffer) == 0 then
		return nil
	end

	table.sort(buffer, function(a, b) return a:getPosition():getDistance(lpPos) < b:getPosition():getDistance(lpPos) end)

	return buffer[1]
end

function TargetHelper.getClosestPlayerAttack(tPlayers)
	local buffer = {}

	local lpPos = Infinity.BDO.getLocalPlayer():getPosition()

	for k,v in pairs(tPlayers) do
		if not v:getIsDead() and TargetHelper.isAttacking(v) then
			table.insert(buffer, v)
		end
	end

	if table.length(buffer) == 0 then
		return nil
	end

	table.sort(buffer, function(a, b) return a:getPosition():getDistance(lpPos) < b:getPosition():getDistance(lpPos) end)

	return buffer[1]
end

function TargetHelper.isAttacking(actor)
	return string.find(actor:getCharacterControler():getCurrentAnimation():getName(), "ATTACK") ~= nil or
	string.find(actor:getCharacterControler():getCurrentAnimation():getName(), "BT_") ~= nil
end

function TargetHelper.isAttackable(actor)
	if actor == nil then
		return false
	end

	return Infinity.BDO.Datasheets.CharacterStaticStatusManager.isAttackable(actor:getActorId())
end