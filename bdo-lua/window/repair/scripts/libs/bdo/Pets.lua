Pets = {}

function Pets.isSealed(petId)
	local code = 
	[[
		for sealPetIndex = 0, ToClient_getPetSealedList() - 1 do
    		local petData = ToClient_getPetSealedDataByIndex(sealPetIndex)
    		local _petNo = petData._petNo

    		if _petNo == ]] .. petId .. [[ then
      			return true
    		end
  		end

  		return false
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Pets.getUnsealedPetNoByIndex(index)
	local code = 
	[[
		local pcPetData = ToClient_getPetUnsealedDataByIndex(]] .. index .. [[)
		return Int64toInt32(pcPetData:getPcPetNo())
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Pets.getUnsealedCount()
	local code = 
	[[
		return ToClient_getPetUnsealedList()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Pets.hasUnsealedPets()
	return Pets.getUnsealedCount() ~= 0
end

function Pets.hasPetFood()
	local code = 
	[[
		return ToClient_Pet_GetFeedItemCount() ~= 0
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Pets.feedAll(index)
	local code = 
	[[
		ToClient_Pet_UseFeedItemFullAll(]] .. index .. [[)
	]]

	return Infinity.BDO.Lua.Execute(code)
end