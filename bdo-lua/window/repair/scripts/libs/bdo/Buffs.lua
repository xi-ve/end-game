Buffs = {}

function Buffs.hasBuffByName(name)
	for k,v in pairs(Buffs.getAppliedBuffs()) do
		if v.Name == name then
			return true
		end
	end

	return false
end

function Buffs.getBuffRemainingTimeByName(name)
	for k,v in pairs(Buffs.getAppliedBuffs()) do
		if v.Name == name then
			return v.RemainTimeMs
		end
	end

	return -1
end

function Buffs.getAppliedBuffs()
	local buffs = {}

	local buffCount = Buffs.getBuffCount()
	local debuffCount = Buffs.getDeBuffCount()

	for index = 0, buffCount - 1 do

		local buffDesc = Buffs.getBuffDesc(index)
		local buffType = Buffs.getBuffType(index)
		local buffLevel = Buffs.getBuffLevel(index)
		local remainTimeMs = Buffs.getBuffTimeMs(index)
		local isDebuff = Buffs.isDebuff(index)

		table.insert(buffs, {Name = buffDesc, Type = buffType, Level = buffLevel, RemainTimeMs = remainTimeMs, IsDebuff = isDebuff})
	end

	for index = 0, debuffCount - 1 do

		local buffDesc = Buffs.getBuffDesc(index, true)
		local buffType = Buffs.getBuffType(index, true)
		local buffLevel = Buffs.getBuffLevel(index, true)
		local remainTimeMs = Buffs.getBuffTimeMs(index, true)
		local isDebuff = Buffs.isDebuff(index, true)

		table.insert(buffs, {Name = buffDesc, Type = buffType, Level = buffLevel, RemainTimeMs = remainTimeMs, IsDebuff = isDebuff})
	end

	return buffs
end

function Buffs.getBuffCount()
	local code = 
	[[
		local count = 0

		for index = 0, 20 do

			local appliedBuff = (getSelfPlayer()):getAppliedBuffByIndex(index, false)

  			if appliedBuff ~= nil then

    			count = count + 1
  			end
		end

		return count
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Buffs.getDeBuffCount()
	local code = 
	[[
		local count = 0

		for index = 0, 20 do

			local appliedBuff = (getSelfPlayer()):getAppliedBuffByIndex(index, true)

  			if appliedBuff ~= nil then

    			count = count + 1
  			end
		end

		return count
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Buffs.getBuffName(index, isDebuff)
	if isDebuff == nil then
		isDebuff = false
	end

	local code = 
	[[
		local name = ""

		local appliedBuff = (getSelfPlayer()):getAppliedBuffByIndex(]] .. index .. [[, ]] .. tostring(isDebuff) .. [[)

  		if appliedBuff ~= nil then

    		name = appliedBuff:getBuffName()
  		end

		return name
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Buffs.getBuffDesc(index, isDebuff)
	if isDebuff == nil then
		isDebuff = false
	end

	local code = 
	[[
		local desc = ""

		local appliedBuff = (getSelfPlayer()):getAppliedBuffByIndex(]] .. index .. [[, ]] .. tostring(isDebuff) .. [[)

  		if appliedBuff ~= nil then

    		desc = appliedBuff:getBuffDesc()
  		end

		return desc
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Buffs.getBuffType(index, isDebuff)
	if isDebuff == nil then
		isDebuff = false
	end

	local code = 
	[[
		local v = nil

		local appliedBuff = (getSelfPlayer()):getAppliedBuffByIndex(]] .. index .. [[, ]] .. tostring(isDebuff) .. [[)

  		if appliedBuff ~= nil then

    		v = appliedBuff:getBuffType()
  		end

		return v
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Buffs.getBuffLevel(index, isDebuff)
	if isDebuff == nil then
		isDebuff = false
	end

	local code = 
	[[
		local v = nil

		local appliedBuff = (getSelfPlayer()):getAppliedBuffByIndex(]] .. index .. [[, ]] .. tostring(isDebuff) .. [[)

  		if appliedBuff ~= nil then

    		v = appliedBuff:getBuffLevel()
  		end

		return v
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Buffs.getIconName(index, isDebuff)
	if isDebuff == nil then
		isDebuff = false
	end

	local code = 
	[[
		local v = nil

		local appliedBuff = (getSelfPlayer()):getAppliedBuffByIndex(]] .. index .. [[, ]] .. tostring(isDebuff) .. [[)

  		if appliedBuff ~= nil then

    		v = appliedBuff:getIconName()
  		end

		return v
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Buffs.isDebuff(index, isDebuff)
	if isDebuff == nil then
		isDebuff = false
	end

	local code = 
	[[
		local v = nil

		local appliedBuff = (getSelfPlayer()):getAppliedBuffByIndex(]] .. index .. [[, ]] .. tostring(isDebuff) .. [[)

  		if appliedBuff ~= nil then

    		v = appliedBuff:isDebuff()
  		end

		return v
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Buffs.isOverlappable(index, isDebuff)
	if isDebuff == nil then
		isDebuff = false
	end

	local code = 
	[[
		local v = nil

		local appliedBuff = (getSelfPlayer()):getAppliedBuffByIndex(]] .. index .. [[, ]] .. tostring(isDebuff) .. [[)

  		if appliedBuff ~= nil then

    		v = appliedBuff:isOverlappable()
  		end

		return v
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Buffs.getBuffTimeMs(index, isDebuff)
	if isDebuff == nil then
		isDebuff = false
	end

	local code = 
	[[
		local time = nil

		local appliedBuff = (getSelfPlayer()):getAppliedBuffByIndex(]] .. index .. [[, ]] .. tostring(isDebuff) .. [[)

  		if appliedBuff ~= nil then

    		time = Int64toInt32(appliedBuff:getRemainedTime_u64())
  		end

		return time
	]]

	return Infinity.BDO.Lua.Execute(code)
end