Actor = {}
LocalPlayer = {}
Deadbody = {}

function Deadbody.getName(actorKey)
	local code =
	[[
		local actor = getDeadBodyActor(]] .. actorKey .. [[)

		if actor == nil then
			return "nA"
		end

		return actor:getStaticStatusName()
	]]

	Infinity.BDO.Lua.Execute(code)
end

function Actor.setAction(actionName)
	local code =
	[[
		getSelfPlayer():setActionChart(]] .. actionName .. [[)
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Actor.isSetInteracatbleFrag(actorKey, index)
	local code =
	[[
		local actorProxyWrapper = getActor(]] .. actorKey .. [[)

		if actorProxyWrapper == nil then
			return false
		end

		return actor:isSetInteracatbleFrag(]] .. index .. [[)
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Actor.getHp(actorKey)
	local code =
	[[
		local actorProxyWrapper = getActor(]] .. actorKey .. [[)

		if actorProxyWrapper == nil then
			return 0
		end

		return (actorProxyWrapper:get()):getHp()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Actor.getName(actorKey)
	local code =
	[[
		local actorProxyWrapper = getActor(]] .. actorKey .. [[)

		if actorProxyWrapper == nil then
			return ""
		end

		return actorProxyWrapper:getName()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Actor.getPosition(actorKey)
	local code =
	[[
		local actorProxyWrapper = getActor(]] .. actorKey .. [[)

		if actorProxyWrapper == nil then
			return nil
		end

		return actorProxyWrapper:getPositionX(), actorProxyWrapper:getPositionY(), actorProxyWrapper:getPositionZ()
	]]

	local x,y,z = Infinity.BDO.Lua.Execute(code)

	if x == nil then
		return nil
	end

	return Vector3(x,y,z)
end

function LocalPlayer.getActorKey()
	local code =
	[[
		return ((getSelfPlayer()):get()):getActorKeyRaw()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function LocalPlayer.getRagepercentage()
	local code =
	[[
		local selfPlayer = getSelfPlayer()
  		local adrenallin = selfPlayer:getAdrenalin()

  		adrenallin = adrenallin / 10
  		adrenallin = math.floor(adrenallin) / 10

  		return adrenallin
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function LocalPlayer.getIsHiddenName()
	local code =
	[[
		return ((getSelfPlayer()):get()):isEquipCamouflage()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function LocalPlayer.getWp()
	local code =
	[[
		return getSelfPlayer():getWp()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function LocalPlayer.isDead()
	local code = 
	[[		
  		return getSelfPlayer():isDead()
	]]

	local ret = Infinity.BDO.Lua.Execute(code)

	if ret == nil then
		return false
	end

	return ret
end

function LocalPlayer.hasFreeWeight()
	local code = 
	[[		
  		 	local selfPlayerWrapper = getSelfPlayer()
  		 	local selfPlayer = selfPlayerWrapper:get()
  		 	
  		 	local allWeight = Int64toInt32(selfPlayer:getCurrentWeight_s64())
  			local maxWeight = Int64toInt32(selfPlayer:getPossessableWeight_s64())

  			return allWeight < maxWeight
	]]
	
	return Infinity.BDO.Lua.Execute(code)
end

function LocalPlayer.getCappedFreeWeight()
	local code = 
	[[		
  		 	local selfPlayerWrapper = getSelfPlayer()
  		 	local selfPlayer = selfPlayerWrapper:get()
  		 	
  		 	local allWeight = Int64toInt32(selfPlayer:getCurrentWeight_s64())
  			local maxWeight = Int64toInt32(selfPlayer:getPossessableWeight_s64())

  			return ((maxWeight * 1.7) - allWeight)/10000
	]]
	
	return Infinity.BDO.Lua.Execute(code)
end

function LocalPlayer.isApplyCharge(charge)
	local code = 
	[[		
  		return (selfPlayer:get()):isApplyChargeSkill(]] .. charge .. [[) == true
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function LocalPlayer.getHpPercentage()
	local code = 
	[[		
  		local selfPlayer = (getSelfPlayer()):get()
  		local hp = selfPlayer:getHp()
  		local maxhp = selfPlayer:getMaxHp()

  		return (hp / maxhp) * 100
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function LocalPlayer.getHp()
	local code = 
	[[		
  		local selfPlayer = (getSelfPlayer()):get()
  		local hp = selfPlayer:getHp()
  		
  		return hp
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function LocalPlayer.getMpPercentage()
	local code = 
	[[		
  		local selfPlayer = (getSelfPlayer()):get()
  		local mp = selfPlayer:getMp()
  		local maxmp = selfPlayer:getMaxMp()

  		return (mp / maxmp) * 100
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function LocalPlayer.getMp()
	local code = 
	[[		
  		local selfPlayer = (getSelfPlayer()):get()

  		return selfPlayer:getMp()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function LocalPlayer.getStamina()
	local code = 
	[[		
  		local selfPlayer = (getSelfPlayer()):get()
  		local stamina = selfPlayer:getStamina()
  		
  		return stamina:getSp()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function LocalPlayer.getWeightPercent()
	local code = 
	[[		
  		local selfPlayerWrapper = getSelfPlayer()
      	local selfPlayer = selfPlayerWrapper:get()
      	local s64_allWeight = selfPlayer:getCurrentWeight_s64()
      	local s64_maxWeight = selfPlayer:getPossessableWeight_s64()
      	local allWeight = Int64toInt32(s64_allWeight) / 10000
      	local maxWeight = Int64toInt32(s64_maxWeight) / 10000
      	local playerWeightPercent = allWeight / maxWeight * 100
      	
      	return playerWeightPercent
	]]

	return Infinity.BDO.Lua.Execute(code)
end