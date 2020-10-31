---@Module MagLib.BDO.Gathering
---@alias Gathering
local settings = {useToolIndexByActorIdCache = true, useToolIndexByItemKeyCache = true}
MagLib.Core.Settings.addSettingsToHandler("MagLib_Gathering", settings)

local Gathering = {}

Gathering.ToolIndex = {Axe = 0, Collector = 1, Pickaxe = 2, Hoe = 3, ButcheringKnife = 4, TanningKnife = 5}

Gathering.ToolItemKeys = {
	[Gathering.ToolIndex.Axe] = {
		16481, 720508, 16808, 720520, 16807, 16806, 16829, 16106, 16107, 16805, 16108, 16835, 16133, 693902
	},
	[Gathering.ToolIndex.Collector] = {
		16482, 720509, 16812, 720521, 16811, 16810, 16110, 16112, 16111, 16830, 16809, 16836, 16134, 693903
	},
	[Gathering.ToolIndex.Pickaxe] = {
		16847, 720512, 720524, 16827, 16828, 16826, 16832, 16126, 16128, 16825, 16127, 16838, 16138, 693906
	},
	[Gathering.ToolIndex.Hoe] = {
		16479, 16540, 16816, 16833, 720519, 16815, 16814, 16116, 16114, 16115, 16813, 16839, 16135, 693901
	},
	[Gathering.ToolIndex.ButcheringKnife] = {
		16487, 720511, 16831, 16820, 720523, 16819, 16120, 16818, 16119, 16118, 16117, 16837, 16136, 693905
	},
	[Gathering.ToolIndex.TanningKnife] = {
		16486, 720510, 16824, 720522, 16823, 16822, 16834, 16123, 16124, 16821, 16122, 16840, 16137, 693904
	}
}

Gathering.ToolApplicableActorIds = {
	[Gathering.ToolIndex.Axe] = {
		10650, 10664, 10649, 10602, 10638, 10527, 10529, 10601, 10600, 10536, 10528, 10526, 10525, 10613, 10516, 10614, 10610,
  10609, 10510, 10509, 10586, 10619, 10585, 10584, 10545, 10541, 10543, 10652, 10544, 10537, 10651, 10542, 10540, 10539,
  10538, 10547, 10546, 10508, 10648, 10647, 10646, 10645, 10606, 10605, 10618, 10617, 10507, 10506, 10505, 10504, 10503,
  10656, 10597, 10515, 10611, 10654, 10653, 10598, 10623, 10622, 10612, 10583, 10582, 10511, 10514, 10513, 10512, 10633,
  10579, 10578, 10657, 10561, 10564, 10624, 10626, 10558, 10565, 10566, 10625, 10607, 10616, 10615, 10608, 10563, 10562,
  10560, 10589, 10588, 10559, 10644, 10620, 10640, 10643, 10642, 10641, 10621
	},
	[Gathering.ToolIndex.Collector] = {
		20005, 20003, 21234, 21207, 21235, 20305, 20304, 20306, 20044, 22118, 20045, 10527, 10529, 10601, 10600, 10536, 10528,
  10526, 10525, 10613, 10516, 10614, 10610, 10609, 10510, 10509, 10586, 10619, 10585, 10584, 10545, 10541, 10543, 10652,
  10544, 10537, 10651, 10542, 10540, 10539, 10538, 10547, 10546, 10508, 10648, 10647, 10646, 10645, 10606, 10605, 10618,
  10617, 10507, 10506, 10505, 10504, 10503, 10656, 10597, 10515, 10611, 10654, 10653, 10598, 10623, 10622, 10612, 10583,
  10582, 10511, 10514, 10513, 10512, 10633, 10579, 10578, 10657, 10561, 10564, 10624, 10626, 10558, 10565, 10566, 10625,
  10607, 10616, 10615, 10608, 10563, 10562, 10560, 10589, 10588, 10559, 10644, 10620, 10640, 10643, 10642, 10641, 10621,
  20185, 20101, 20288, 20289
	},
	[Gathering.ToolIndex.Pickaxe] = {
		10006, 10130, 10129, 10128, 10098, 10119, 10097, 10100, 10118, 10120, 10117, 10116, 10115, 10095, 10094, 10093, 10099,
  10096, 10047, 10069, 10090, 10092, 10114, 10135, 10134, 10133, 10132, 10131, 10091, 10089, 10088, 10152, 10017, 10079,
  10081, 10043, 10045, 10013, 10004, 10049, 10009, 10071, 10141, 10051, 10053, 10073, 10127, 10151, 10085, 10087, 10075,
  10059, 10141, 10121, 10125, 10111, 10126, 10124, 10123, 10122, 10110, 10109, 10108, 10107, 10106, 10105, 10104, 10136,
  10061, 10063, 10057, 10150, 10065, 10149, 10153, 10157, 10067
	},
	[Gathering.ToolIndex.Hoe] = {
		10219, 10221, 10222, 10848, 10519, 10518, 10502, 10501, 10369, 10209, 10210, 10208, 10416, 10414, 10403, 10471, 10919,
  10413, 10483, 10320, 10226, 10280, 10281, 10405, 10456, 10454, 10453, 10289, 10925, 10482, 10436, 10201, 10404, 10408,
  10470, 10432, 10487, 10435, 10410, 10401, 10223, 10409, 10913, 10458, 10920, 10412, 10465, 10986, 10966, 10484, 10468,
  10472, 10469, 10287, 10478, 10967, 10464, 10288, 10486, 10878, 10918, 10480, 10455, 10457, 10485, 10924, 10931, 10247,
  10249, 10248, 10921, 10275, 10901, 10951, 10975, 10905, 10236, 10437, 10434, 10406, 10488, 10970, 10253, 10205, 10201,
  10211, 10407, 10481, 10917, 10430, 10252, 10251, 10250, 10915, 10330, 10451, 10261, 10272, 10268, 10273, 10270, 10262,
  10260, 10259, 10266, 10265, 10271, 10269, 10274, 10267, 10264, 10263, 10258, 11922, 10291
	},
	[Gathering.ToolIndex.ButcheringKnife] = {
		20005, 20003, 21234, 21207, 21235, 20305, 20304, 20306, 20044, 22118, 20045, 21758, 21754, 21757, 21756, 20185, 20101,
  20288, 20289, 21527, 21526, 21521, 21528
	},
	[Gathering.ToolIndex.TanningKnife] = {
		20005, 20003, 21234, 21207, 21235, 20305, 20304, 20306, 20044, 22118, 20045, 21758, 21754, 21757, 21756, 20185, 20101,
  24527, 21523, 21529, 20288, 20289, 21527, 21526, 21521, 21528
	}
}

Gathering.ToolNames = {
	[Gathering.ToolIndex.Axe] = "Axe",
	[Gathering.ToolIndex.Collector] = "Collector",
	[Gathering.ToolIndex.Pickaxe] = "Pickaxe",
	[Gathering.ToolIndex.Hoe] = "Hoe",
	[Gathering.ToolIndex.ButcheringKnife] = "Butchering Knife",
	[Gathering.ToolIndex.TanningKnife] = "Tanning Knife"
}

-- getToolNameByIndex
Gathering.getToolNameByIndex = function(toolIndex)
	if toolIndex == nil then
		return "Unsupported"
	end
	return Gathering.ToolNames[toolIndex]
end

-- getToolIndexByItemKey
local getToolIndexByItemKey = function(itemKey)
	for toolIndex, itemKeys in pairs(Gathering.ToolItemKeys) do
		if table.find(itemKeys, itemKey) then
			return toolIndex
		end
	end
end
local toolIndexByItemKeyCache_Cache
local toolIndexByItemKeyCache_Cache_init = function()
	toolIndexByItemKeyCache_Cache = MagLib.Core.Cache.Cache(nil, getToolIndexByItemKey)
end
Gathering.getToolIndexByItemKey = function(itemKey)
	if settings.useToolIndexByItemKeyCache then
		if not toolIndexByItemKeyCache_Cache then
			-- To save memory we only allocate this if we actually need it. If a script never uses this, no need to have the cache
			toolIndexByItemKeyCache_Cache_init()
		end

		return toolIndexByItemKeyCache_Cache:getValue(itemKey)
	else
		return getToolIndexByItemKey(itemKey)
	end
end

-- getToolIndexByActorId
local getToolIndexByActorId = function(actorId)
	for toolIndex, actorIds in pairs(Gathering.ToolApplicableActorIds) do
		if table.find(actorIds, actorId) then
			return toolIndex
		end
	end
end
local toolIndexByActorId_Cache
local toolIndexByActorId_Cache_init = function()
	toolIndexByActorId_Cache = MagLib.Core.Cache.Cache(nil, getToolIndexByActorId)
end
Gathering.getToolIndexByActorId = function(actorId)
	if settings.useToolIndexByActorIdCache then
		if not toolIndexByActorId_Cache then
			-- To save memory we only allocate this if we actually need it. If a script never uses this, no need to have the cache
			toolIndexByActorId_Cache_init()
		end
		return toolIndexByActorId_Cache:getValue(actorId)
	else
		return getToolIndexByActorId(actorId)
	end
end

-- getToolNameByActorId
Gathering.getToolNameByActorId = function(actorId)
	local toolIndex = Gathering.getToolIndexByActorId(actorId)
	if toolIndex then
		return Gathering.ToolNames[toolIndex]
	else
		return "Unsupported!"
	end
end

-- getToolItemKeysByActorId
Gathering.getToolItemKeysByActorId = function(actorId)
	local toolIndex = Gathering.getToolIndexByActorId(actorId)
	return Gathering.ToolItemKeys[toolIndex]
end

-- gather/stopGatheringTask
local currentGatheringTask = nil
local currentGatheringActor = nil
local currentGatheringFinishedFunction = nil
local gatheringTaskTriedStartingGatheringTime = nil
local gatheringTaskCanceling = false

local gatheringTaskResetRuntimeVars = function()
	currentGatheringFinishedFunction = nil
	currentGatheringActor = nil
	currentGatheringTask = nil
	gatheringTaskTriedStartingGatheringTime = nil
	gatheringTaskCanceling = false
end

local gatheringTaskOnTimeout = function()
	if currentGatheringFinishedFunction then
		currentGatheringFinishedFunction()
	end
	gatheringTaskResetRuntimeVars()
end

local gatheringTaskRunFunction = function()
	-- If we actor is gone, we gathered it.
	if gatheringTaskCanceling or not MagLib.BDO.Actors.isValidActor(currentGatheringActor) then
		if currentGatheringFinishedFunction then
			currentGatheringFinishedFunction()
		end
		-- resetting
		gatheringTaskResetRuntimeVars()
		Infinity.BDO.Selection.reset()
		return true
	end

	-- check if we are currently gathering
	if string.find(string.lower(Infinity.BDO.getLocalPlayer():getCharacterControler():getCurrentAnimation():getName()),
               	"wait") == nil then
		return false
	end

	-- Turning player towards the actor
	local actorPos = currentGatheringActor:getPosition()
	if not MagLib.BDO.Actors.LocalPlayer.faceTowards(actorPos) then
		Infinity.BDO.Selection.reset()
		return false
	end

	-- Camera to actor
	if not MagLib.BDO.Camera.setCamera(actorPos) then
		Infinity.BDO.Selection.reset()
		return false
	end

	if not gatheringTaskTriedStartingGatheringTime then
		gatheringTaskTriedStartingGatheringTime = MagLib.getTime()
	else
		if gatheringTaskTriedStartingGatheringTime + 5000 < MagLib.getTime() then
			MagLib.logger.warning("Could not start gathering process. Canceling")
			gatheringTaskCanceling = true
			return false
		end
	end

	-- Override selection
	Infinity.BDO.Selection.setTarget(currentGatheringActor:getActorKey())

	-- Interact
	if Infinity.BDO.Selection.isOverride() and Interaction.hasInteractable() then
		Interaction.interact(8)
	end

	return false
end

Gathering.stopGatheringTask = function()
	if currentGatheringTask then
		currentGatheringTask:forceTimeout()
	end
end

Gathering.gather = function(actor, finishedFunction)
	-- Do not start GatheringTask twice
	if currentGatheringTask then
		return
	end

	-- Setting runtime vars
	currentGatheringActor = actor
	currentGatheringFinishedFunction = finishedFunction

	-- Creating task
	currentGatheringTask = MagLib.Run.Tasks.new("GatheringTask", 25000, gatheringTaskRunFunction)
	currentGatheringTask.onTimeout = gatheringTaskOnTimeout
end

-- isRightTool
Gathering.isRightTool = function(actorId, itemKey, toolIndex)
	local possibleToolItemKeys
	if not toolIndex then
		possibleToolItemKeys = Gathering.getToolItemKeysByActorId(actorId)
	else
		-- forced toolIndex 
		possibleToolItemKeys = Gathering.ToolItemKeys[toolIndex]
	end
	return table.find(possibleToolItemKeys, itemKey) ~= nil
end

-- getNextRightToolData
Gathering.getNextRightToolData = function(toolIndex)
	local item = nil
	local possibleToolItemKeys = Gathering.ToolItemKeys[toolIndex]
	local iteratorFunc = function(itemData)
		if itemData.dura > 0 and table.find(possibleToolItemKeys, itemData.itemKey) then
			item = itemData
			return true
		end

		return false
	end
	MagLib.BDO.Inventory.iterator(iteratorFunc)

	return item
end

-- ownRightTool
Gathering.ownRightTool = function(actorId, allowHandsForHoe, toolIndex)
	local item = nil
	local possibleToolItemKeys
	if not toolIndex then
		possibleToolItemKeys, toolIndex = Gathering.getToolItemKeysByActorId(actorId)
	else
		-- force toolIndex
		possibleToolItemKeys = Gathering.ToolItemKeys[toolIndex]
	end
	local iteratorFunc = function(itemData)
		if itemData.dura > 0 and table.find(possibleToolItemKeys, itemData.itemKey) then
			item = itemData
			return true
		end

		return false
	end
	MagLib.BDO.Inventory.iterator(iteratorFunc)
	local gotTool = item ~= nil or (toolIndex == Gathering.ToolIndex.Hoe and allowHandsForHoe)
	return gotTool, toolIndex
end

---Return values of the equipTool function
-- @see MagLib.Gathering.requipTool
Gathering.equipTool_ReturnValues = {
	RightToolEquipped = 0, -- The right tool is equipped
	InProcess = 1, -- Equip swap is in progress
	NoToolFound = 2 -- No proper tool is in the inventory/equipped
}
---Makes sure the right tool is equipped.
-- Equips the first right tool in your inventory if a wrong tool is currently equipped. Also checks for durability.
-- @param actorId the actorId of the collectable you want to harvest with the tool
-- @param allowHandsForHoe allows no tool or a wrong tool to be equipped if no hoe is found for actors which are harvested with a hoe.
-- @return number 0: Right tool is already equipped, 1: In the process of equipping the right tool (call this again next pulse/later), 2: No proper tool in your inventory. Enums is Gathering.equipTool_ReturnValues
Gathering.equipTool = function(toolIndex, allowHandsForHoe)
	local currentTool = MagLib.BDO.Inventory.getEquippedItemData(MagLib.BDO.Inventory.EquipmentSlots.SubTool)
	local hasDuraLeft = currentTool and (currentTool.dura > 0)
	local isRightTool = currentTool and Gathering.isRightTool(nil, currentTool.itemKey, toolIndex)
	if hasDuraLeft and isRightTool then
		-- We have the right tool, that has dura left
		return Gathering.equipTool_ReturnValues.RightToolEquipped
	end

	-- We need to replace the tool because it is either wrong or broken.
	local item = Gathering.getNextRightToolData(toolIndex)

	if item then
		-- We found a proper tool
		MagLib.logger.info("Equipping " .. item.name .. " as tool of index " .. toolIndex)
		Equip.equip(item.slot)
		return Gathering.equipTool_ReturnValues.InProcess
	else
		-- No tool found
		if allowHandsForHoe and toolIndex == Gathering.ToolIndex.Hoe then
			-- It is okay to not change tools
			if isRightTool then
				-- Hoe is equipped, but dura is zero (otherwise we would have returned already)
				Equip.unequip(MagLib.BDO.Inventory.EquipmentSlots.SubTool)
				return Gathering.equipTool_ReturnValues.InProcess
			end
			return Gathering.equipTool_ReturnValues.RightToolEquipped
		else
			-- We do not have the right tool
			return Gathering.equipTool_ReturnValues.NoToolFound
		end
	end

end

MagLib.BDO.Gathering = Gathering
