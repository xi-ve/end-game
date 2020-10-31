Workers = {}

function Workers.hasRecoveryItems()
	local code =
	[[
		return ToClient_getNpcRecoveryItemList() > 0
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Workers.getWorkerCount()
	local code =
	[[
		local plantCount = ToCleint_getHomePlantKeyListCount()
		local plantKeysRaw = {}

    	for plantIdx = 0, plantCount - 1 do
      		local plantKeyRaw = ToCleint_getHomePlantKeyListByIndex(plantIdx)
      		table.insert(plantKeysRaw, plantKeyRaw)
    	end

    	local totalWorkerCount = 0
		local totalWorkerCapacity = 0

    	for k,v in pairs(plantKeysRaw) do	
    		local plantKey = PlantKey()
      		plantKey:setRaw(v)

    		local plantWorkerCount = ToClient_getPlantWaitWorkerListCount(plantKey, 0)
    		local workerHouseCount = ToClient_getTownWorkerMaxCapacity(plantKey)

          	if workerHouseCount < plantWorkerCount then
            	plantWorkerCount = workerHouseCount
          	end

          	totalWorkerCapacity = totalWorkerCapacity + workerHouseCount
          	totalWorkerCount = totalWorkerCount + plantWorkerCount
    	end

    	return totalWorkerCount
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Workers.recoverAll()	
	local code =
	[[
		local plantCount = ToCleint_getHomePlantKeyListCount()
		local plantKeysRaw = {}
		local workerArray = {}

    	for plantIdx = 0, plantCount - 1 do
      		local plantKeyRaw = ToCleint_getHomePlantKeyListByIndex(plantIdx)
      		table.insert(plantKeysRaw, plantKeyRaw)
    	end

    	local totalWorkerCount = 0
		local totalWorkerCapacity = 0

    	for k,v in pairs(plantKeysRaw) do	
    		local plantKey = PlantKey()
      		plantKey:setRaw(v)

    		local plantWorkerCount = ToClient_getPlantWaitWorkerListCount(plantKey, 0)
    		local workerHouseCount = ToClient_getTownWorkerMaxCapacity(plantKey)

          	if workerHouseCount < plantWorkerCount then
            	plantWorkerCount = workerHouseCount
          	end

          	for workerIdx = 0, plantWorkerCount - 1 do
            	local workerNoRaw = ToClient_getPlantWaitWorkerNoRawByIndex(plantKey, workerIdx)
            	table.insert(workerArray, workerNoRaw)
          	end

          	totalWorkerCapacity = totalWorkerCapacity + workerHouseCount
          	totalWorkerCount = totalWorkerCount + plantWorkerCount
    	end

    	local recoveryItem = ToClient_getNpcRecoveryItemByIndex(0)
  		local recoveryItemCount = Int64toInt32(recoveryItem._itemCount_s64)
  		local restorePoint = recoveryItem._contentsEventParam1
  		local slotNo = recoveryItem._slotNo

  		local currentItemCount = recoveryItemCount

		for idx = 1, totalWorkerCount do
    		local workerNoRaw = workerArray[idx]
    		local workerWrapperLua = getWorkerWrapper(workerNoRaw, false)
    		local maxPoint = workerWrapperLua:getMaxActionPoint()
    		local currentPoint = workerWrapperLua:getActionPoint()
    		local restoreItemCount = ToClient_getNpcRecoveryItemList()
    		local restoreActionPoint = maxPoint - currentPoint
    		local itemNeedCount = (math.floor)(restoreActionPoint / restorePoint)

    		if currentItemCount < itemNeedCount then
      			itemNeedCount = currentItemCount
    		end

    		if itemNeedCount >= 1 then
      			requestRecoveryWorker(WorkerNo(workerNoRaw), slotNo, itemNeedCount)
      			currentItemCount = currentItemCount - itemNeedCount
    		end
  		end
	]]

	Infinity.BDO.Lua.Execute(code)
end

function Workers.repeatAll()
	local code =
	[[
		HandleClicked_workerManager_ReDoAll()
	]]

	Infinity.BDO.Lua.Execute(code)
end