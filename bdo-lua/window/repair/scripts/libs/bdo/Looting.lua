Looting = {}

function Looting.hasItem(slotNo)
	local code =
	[[
		return looting_getItem(]] .. slotNo .. [[) ~= nil
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Looting.getItemId(slotNo)
	local code =
	[[
		local itemWrapper = looting_getItem(]] .. slotNo .. [[)

		if itemWrapper == nil then
    		return nil
  		end

  		return ((itemWrapper:get()):getKey()):getItemKey()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Looting.getItemName(slotNo)
	local code =
	[[
		local itemWrapper = looting_getItem(]] .. slotNo .. [[)

		if itemWrapper == nil then
    		return nil
  		end

  		return (itemWrapper:getStaticStatus()):getName()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Looting.getItemGrade(slotNo)
	local code =
	[[
		local itemWrapper = looting_getItem(]] .. slotNo .. [[)

		if itemWrapper == nil then
    		return nil
  		end

  		return (itemWrapper:getStaticStatus()):getGradeType()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Looting.getItemCount(slotNo)
	local code =
	[[
		local itemWrapper = looting_getItem(]] .. slotNo .. [[)

		if itemWrapper == nil then
    		return nil
  		end

  		return Int64toInt32((itemWrapper:get()):getCount_s64())
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Looting.pickItem(slotNo, count)
	local code =
	[[
		local itemWrapper = looting_getItem(]] .. slotNo .. [[)

		if itemWrapper == nil then
    		return
  		end

  		looting_slotClick(]] .. slotNo .. [[, ]] .. count .. [[)
	]]

	Infinity.BDO.Lua.Execute(code)
end