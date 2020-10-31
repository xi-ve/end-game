Maids = {}

function Maids.hasStorageMaid()
	local code = 
	[[
		for i=0, getTotalMaidList() do
			local maidInfoWrapper = getMaidDataByIndex(i)

        	if maidInfoWrapper ~= nil then
        		if maidInfoWrapper:isAbleInWarehouse() then
              		return true
            	end
        	end
		end

		return false
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Maids.hasMarketMaid()
	local code = 
	[[
		for i=0, getTotalMaidList() do
			local maidInfoWrapper = getMaidDataByIndex(i)

        	if maidInfoWrapper ~= nil then
        		if maidInfoWrapper:isAbleSubmitMarket() then
              		return true
            	end
        	end
		end

		return false
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Maids.getMarketMaidCooldown()
	local code = 
	[[
		local cooldown = 100000

		for i=0, getTotalMaidList() do
			local maidInfoWrapper = getMaidDataByIndex(i)

        	if maidInfoWrapper ~= nil then
        		if maidInfoWrapper:isAbleSubmitMarket() then
              		local coolTime = maidInfoWrapper:getCoolTime()

              		if coolTime < cooldown then
              			cooldown = coolTime
              		end
            	end
        	end
		end

		return cooldown
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Maids.getStorageMaidCooldown()
	local code = 
	[[
		local cooldown = 100000

		for i=0, getTotalMaidList() do
			local maidInfoWrapper = getMaidDataByIndex(i)

        	if maidInfoWrapper ~= nil then
        		if maidInfoWrapper:isAbleInWarehouse() then
              		local coolTime = maidInfoWrapper:getCoolTime()

              		if coolTime < cooldown then
              			cooldown = coolTime
              		end
            	end
        	end
		end

		return cooldown
	]]

	return Infinity.BDO.Lua.Execute(code)
end