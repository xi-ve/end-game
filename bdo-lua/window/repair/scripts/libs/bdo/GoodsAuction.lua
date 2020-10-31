GoodsAuction = {}

function GoodsAuction.getHorseMarketSkillsNames()
	local code = 
	[[
		local skills = {}
		
		for index = 1, 65 do
    		local skillWrapper = getVehicleSkillStaticStatus(index)

    		if skillWrapper ~= nil and true == skillWrapper:isMarketFilter() then
      			table.insert(skills, skillWrapper:getName())
    		end
  		end

		return unpack(skills)
	]]

	return {Infinity.BDO.Lua.Execute(code)}
end

function GoodsAuction.getHorseMarketSkillsIndexies()
	local code = 
	[[
		local indexies = {}

		for index = 1, 65 do
    		local skillWrapper = getVehicleSkillStaticStatus(index)

    		if skillWrapper ~= nil and true == skillWrapper:isMarketFilter() then
      			table.insert(indexies, index)
    		end
  		end

		return unpack(indexies)
	]]

	return {Infinity.BDO.Lua.Execute(code)}
end

function GoodsAuction.getHorseMarketServantListCount()
	local code = 
	[[
		local myAuctionInfo = RequestGetAuctionInfo()
		return myAuctionInfo:getServantAuctionListCount()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function GoodsAuction.getHorseMarketServantDataByIndex(index)
	local code =
	[[
		local myAuctionInfo = RequestGetAuctionInfo()
		local auctionServantInfo = myAuctionInfo:getServantAuctionListAt(]] .. index .. [[)

		local vehicleType = auctionServantInfo:getVehicleType()
		local tier = auctionServantInfo:getTier()
		local matingCount = auctionServantInfo:getMatingCount()
		local matingReset = auctionServantInfo:doClearCountByMating()
		local isMale = auctionServantInfo:isMale()
		local isStallion = auctionServantInfo:isStallion()
		local level = auctionServantInfo:getLevel()
		local maxHp = auctionServantInfo:getMaxHp()
		local maxMp = auctionServantInfo:getMaxMp()
		local maxWeight = Int64toInt32(auctionServantInfo:getMaxWeight_s64()) / 10000
		local moveSpeed = auctionServantInfo:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed) / 10000
		local accelerationSpeed = auctionServantInfo:getStat(CppEnums.ServantStatType.Type_Acceleration) / 10000
		local corneringSpeed = auctionServantInfo:getStat(CppEnums.ServantStatType.Type_CorneringSpeed) / 10000
		local brakeSpeed = auctionServantInfo:getStat(CppEnums.ServantStatType.Type_BrakeSpeed) / 10000
		local price = Int64toInt32(auctionServantInfo:getAuctoinPrice_s64())
		local deadCount = auctionServantInfo:getDeadCount()
		local deadReset = auctionServantInfo:doClearCountByDead()

		return vehicleType, tier, matingCount, isMale, isStallion, level, maxHp, maxMp, maxWeight, moveSpeed, accelerationSpeed, corneringSpeed, brakeSpeed, price, deadCount
	]]

	local vehicleType, tier, matingCount, isMale, isStallion, level, maxHp, maxMp, maxWeight, moveSpeed, accelerationSpeed, corneringSpeed, brakeSpeed, price, deadCount = Infinity.BDO.Lua.Execute(code)

	return {VehicleType = vehicleType, Tier = tier, MatingCount = matingCount, IsMale = isMale, IsStallion = isStallion, Level = level, MaxHp = maxHp, MaxMp = maxMp, MaxWeight = maxWeight, MoveSpeed = moveSpeed, AccelerationSpeed = accelerationSpeed, CorneringSpeed = corneringSpeed, BrakeSpeed = brakeSpeed, Price = price, DeadCount = deadCount}
end

function GoodsAuction.getHorseMarketServantSkillDataByIndex(index)
	local code =
	[[
		local myAuctionInfo = RequestGetAuctionInfo()
		local auctionServantInfo = myAuctionInfo:getServantAuctionListAt(]] .. index .. [[)

		local skills = {}

		local learnSkillCount = vehicleSkillStaticStatus_skillCount()

        for jj = 1, learnSkillCount - 1 do

          local skillWrapper = auctionServantInfo:getSkill(jj)

          if nil ~= skillWrapper then
            
            table.insert(skills, jj)
          end
      	end

		return unpack(skills)
	]]

	return {Infinity.BDO.Lua.Execute(code)}
end

function GoodsAuction.getHorseMarketWarehouseMoney()
	local code =
	[[		
		return Int64toInt32(warehouse_moneyFromNpcShop_s64())
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function GoodsAuction.getHorseMarketgetStableFreeSlots()
	local code =
	[[		
		local sealedCount = stable_currentSlotCount()
    	local unsealedCount = stable_currentRegionSlotCountAll() - sealedCount + Int64toInt32(stable_currentRegionSlotCountOfOtherCharacter())

    	local usedSlots = sealedCount + unsealedCount

    	return stable_maxSlotCount() - usedSlots
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function GoodsAuction.buyServantInHorseMarketBySlotIndex(slotIndex)
	local code =
	[[		
		stable_requestBuyItNowServant(]] .. slotIndex .. [[, CppEnums.ItemWhereType.eWarehouse)
	]]

	Infinity.BDO.Lua.Execute(code)
end