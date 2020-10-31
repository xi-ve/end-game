Servant = {}

function Servant.getSpeeds(actorKey)		
	local code = 
	[[
		local tSpeeds = {}

		local servantWrapper = getServantInfoFromActorKey(]] .. actorKey .. [[)

		if servantWrapper == nil then

			servantWrapper = getServantInfoFromActorKey(ServantInfo_GetActorKey())
		end

		if servantWrapper == nil then

			servantWrapper = getServantInfoFromActorKey(ShipInfo_GetActorKey())
		end

		if servantWrapper == nil then

			servantWrapper = getServantInfoFromActorKey(CarriageInfo_GetActorKey())
		end

		if servantWrapper == nil then

			servantWrapper = getServantInfoFromActorKey(WorkerShipInfo_GetActorKey())
		end

		if servantWrapper ~= nil then

			tSpeeds[1] = servantWrapper:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed)
			tSpeeds[2] = servantWrapper:getStat(CppEnums.ServantStatType.Type_Acceleration)
			tSpeeds[3] = servantWrapper:getStat(CppEnums.ServantStatType.Type_CorneringSpeed)
			tSpeeds[4] = servantWrapper:getStat(CppEnums.ServantStatType.Type_BrakeSpeed)
			tSpeeds[5] = servantWrapper:getVehicleType()
		end

		return unpack(tSpeeds)
	]]

	return {Infinity.BDO.Lua.Execute(code)}
end

function Servant.getTent()
	local code =
	[[
		return PaGlobalFunc_Camp_All_GetActorKeyRaw()
	]]

	local tentActorKey = Infinity.BDO.Lua.Execute(code)

	if tentActorKey == nil then
		return nil
	end

	local actor = Infinity.BDO.getActorByActorKey(tentActorKey)

	if actor == nil then
		return nil
	end 

	return actor
end