local settings = {gatherDistance = 250, allowNoHoeGathering = true, waitForDeadMobToBecomeGatherableDelay = 750}
MagLib.Core.Settings.addSettingsToHandler("GatherBuddy_Gathering", settings)

-- Helper vars 
local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos

-- Runtime vars
local currentTargetObject = nil
local currentTargetObjectIndex = 0
local currentTargetActor = nil

-- gotNeededTools is a table consisiting of one entry per tool.
-- The entry will be true if the tool is needed and we got one
-- It will be false if we do not need the tool or do not have it
local gotNeededTools
local resetGotNeededTools = function()
	gotNeededTools = {
		[MagLib.BDO.Gathering.ToolIndex.Axe] = false,
		[MagLib.BDO.Gathering.ToolIndex.Collector] = false,
		[MagLib.BDO.Gathering.ToolIndex.Pickaxe] = false,
		[MagLib.BDO.Gathering.ToolIndex.Hoe] = false,
		[MagLib.BDO.Gathering.ToolIndex.ButcheringKnife] = false,
		[MagLib.BDO.Gathering.ToolIndex.TanningKnife] = false
	}

	if not MagLib.BDO.Navigation.Graph.Profiles.currentProfile then
		return
	end

	-- Checking which ones we need
	local gatheringObjects = MagLib.BDO.Navigation.Graph.Profiles.currentProfile.extra.gatheringObjects
	for _, object in ipairs(gatheringObjects) do
		if (object.toolIndex ~= nil) then
			gotNeededTools[object.toolIndex] = true -- We need this tool
		end
	end
	local currentTool = MagLib.BDO.Inventory.getEquippedItemData(MagLib.BDO.Inventory.EquipmentSlots.SubTool)
	local currentToolIndex = -1
	if currentTool then
		currentToolIndex = MagLib.BDO.Gathering.getToolIndexByItemKey(currentTool.itemKey)
	end

	-- Checking which ones we do not have
	for _, toolIndex in pairs(MagLib.BDO.Gathering.ToolIndex) do
		if toolIndex ~= currentToolIndex and not MagLib.BDO.Gathering.ownRightTool(nil, false, toolIndex) then
			-- This toolIndex we have no tool of in inventory and our current tool is not that tool.
			gotNeededTools[toolIndex] = false
		end
	end
end

-- Blocking/Mutex
local blocked = false
local resetBlock = function()
	blocked = false
end

local blockFor = function(ms)
	blocked = true
	MagLib.Run.DelayedTasks.new("ResetBlockDelayedTask", ms, resetBlock)
end

-- Filter functions
local isRightCollectable = function(actor)
	-- Too far away
	if actor:getPosition():getDistance(getPPos()) > settings.gatherDistance + 25 then
		return false
	end

	-- Is right actor ID
	if actor:getActorId() ~= currentTargetObject.actorId then
		return false
	end

	return true
end

local isRightCollectableMonsterToKill = function(actor, currentObjectOverwrite)
	local cTarget = currentObjectOverwrite or currentTargetObject

	-- Actor not dead
	if actor:getHp() <= 1 or actor:getIsDead() then
		return false, 1
	end

	-- Is a collectable monster for the right toolIndex
	if table.find(MagLib.BDO.Gathering.ToolApplicableActorIds[cTarget.toolIndex], actor:getActorId()) == nil then
		return false, 3
	end

	-- Is in the killspot
	local distanceToKillspot = cTarget.pos:getDistance(actor:getPosition())
	if distanceToKillspot > cTarget.size + 10 then
		return false, 2
	end

	-- No collision between player and mob
	if MagLib.BDO.Raycast.safeTwoPos(getPPos(), actor:getPosition(), 125) then
		return false, 4
	end

	return true
end
IsRightCollectableMonsterToKill = isRightCollectableMonsterToKill;

local isRightCollectableMonsterToGather = function(actor, currentObjectOverwrite)
	local cTarget = currentObjectOverwrite or currentTargetObject
	-- Actor dead
	if actor:getHp() > 0 then
		return false, 1
	end

	-- Is a collectable monster for the right toolIndex
	if table.find(MagLib.BDO.Gathering.ToolApplicableActorIds[cTarget.toolIndex], actor:getActorId()) == nil then
		return false, 3
	end

	-- Is in the killspot
	local distanceToKillspot = cTarget.pos:getDistance(actor:getPosition())
	if distanceToKillspot > cTarget.size then
		return false, 2
	end

	-- No collision between player and mob
	if MagLib.BDO.Raycast.safeTwoPos(getPPos(), actor:getPosition()) then
		return false, 4
	end

	return true
end
IsRightCollectableMonsterToGather = isRightCollectableMonsterToGather

local isRightCloseCollectableMonsterToKill = function(actor, currentObjectOverwrite)
	local cTarget = currentObjectOverwrite or currentTargetObject

	if (not isRightCollectableMonsterToKill(actor, cTarget)) then
		return
	end

	-- Is close
	local distanceToPlayer = actor:getPosition():getDistance(getPPos())
	if distanceToPlayer < 200 then
		return false
	end

	return true
end
IsRightCloseCollectableMonsterToKill = isRightCloseCollectableMonsterToKill

-- Update the target object from the profile
local updateTargetObject = function()
	local profile = MagLib.BDO.Navigation.Graph.Profiles.currentProfile
	local gatheringObjects = profile.extra.gatheringObjects
	-- Loop around
	if currentTargetObjectIndex < #gatheringObjects then
		currentTargetObjectIndex = currentTargetObjectIndex + 1
	else
		currentTargetObjectIndex = 1
	end
	GatherBuddy.logger.info("Switching to gathering object #" .. currentTargetObjectIndex)
	currentTargetObject = gatheringObjects[currentTargetObjectIndex]
end

local skipCurrentTargetObject = function()
	currentTargetObject = nil
	currentTargetActor = nil
end

local onBotStart = function()
	-- Get closest gathering object and set it as target upon bot start
	local closestObjectDistance = 1 / 0
	local closestObjectIndex = 1

	local pPos = MagLib.BDO.Actors.LocalPlayer.getPos()

	local gatheringObjects = MagLib.BDO.Navigation.Graph.Profiles.currentProfile.extra.gatheringObjects
	for index, object in ipairs(gatheringObjects) do
		local distance = pPos:getDistance(object.pos)
		if distance < closestObjectDistance then
			closestObjectDistance = distance
			closestObjectIndex = index
		end
	end

	GatherBuddy.logger.info("Starting at closest gathering object #" .. closestObjectIndex)
	currentTargetObjectIndex = closestObjectIndex
	currentTargetObject = gatheringObjects[closestObjectIndex]

	-- Resetting block
	resetBlock()
	resetGotNeededTools()
end
MagLib.Events.addEventHandler("OnBotStart", onBotStart)

local onBotStop = function()
	-- Stopping GatheringTask if it is running (MagLib.BDO.Gathering.gather(...) was called and did not finish it's task)
	MagLib.BDO.Gathering.stopGatheringTask()

	-- Resetting 
	resetBlock()
	resetGotNeededTools()
end
MagLib.Events.addEventHandler("OnBotStop", onBotStop)

-- gather finished callback 
local onGatherFinished = function()
	MagLib.wait(300)
	resetBlock()
end

local shouldTownrun = function()
	local noTools = true
	for _, value in pairs(gotNeededTools) do
		if value then
			noTools = false
		end
	end

	if noTools then
		GatherBuddy.logger.info("No tools left!")
		return true
	end

	local outOfEnergy = MagLib.BDO.Actors.LocalPlayer.getEnergy() <= 0
	if outOfEnergy then
		GatherBuddy.logger.info("Out of energy!")
		return true
	end

	local inventoryTooFull = Inventory.getFreeSlotCount() <= 2
	if inventoryTooFull then
		GatherBuddy.logger.info("Not enough inventory space!")
		return true
	end

	return (noTools or outOfEnergy or inventoryTooFull)
end

local handleGathering = function()
	local pPos = MagLib.BDO.Actors.LocalPlayer.getPos()
	local targetObjectPos = currentTargetObject.pos
	local distance = pPos:getDistance(targetObjectPos)

	if distance < settings.gatherDistance then
		-- Stop moving
		MagLib.BDO.Navigation.stop()
		-- Check that we get the right actor/getting the target actor
		if currentTargetActor == nil or not MagLib.BDO.Actors.isValidActor(currentTargetActor) then
			-- Get actor
			currentTargetActor = MagLib.BDO.Actors.getClosestFilteredActor(EActorType_Collect, isRightCollectable)
			if not currentTargetActor then
				currentTargetObject = nil
				currentTargetActor = nil
				return false
			end
		end

		-- If we are here, we have a valid actor
		local toolIndex = currentTargetObject.toolIndex
		local state = MagLib.BDO.Gathering.equipTool(toolIndex, settings.allowNoHoeGathering)

		if state == MagLib.BDO.Gathering.equipTool_ReturnValues.InProcess then
			-- We return since we are in process of swapping tools
			MagLib.wait(1000) -- Giving it time to swap
			return false
		elseif state == MagLib.BDO.Gathering.equipTool_ReturnValues.NoToolFound then
			-- We skip this one since we do not have the right tool.
			-- Remembering that we do not have this tool
			gotNeededTools[toolIndex] = false
			skipCurrentTargetObject()
			return false
		end

		-- We have the right tool equipped
		blocked = true
		MagLib.BDO.Gathering.gather(currentTargetActor, onGatherFinished)
		GatherBuddy.logger.info("Started gathering!")
	else
		-- Move to the gathering object
		MagLib.BDO.Navigation.moveTo(targetObjectPos, true, settings.gatherDistance - 25)
	end
end

local lastAttackedMobs = 0
local killMobs = function(filterFunc)
	-- Then we kill all still alive gatherable monsters in the area
	local actor = MagLib.BDO.Actors.getClosestFilteredActor(EActorType_Monster, filterFunc)
	if actor then
		-- We kill it
		local fought = MagLib.BDO.Actions.Combat.CombatManager.combat(actor)
		if not fought then
			-- We move closer and call onPulse
			MagLib.BDO.Actors.LocalPlayer.moveTo(actor:getPosition())
			MagLib.BDO.Actions.Combat.CombatManager.onPulse(true)
		else
			-- Stop moving so skills are properly executed
			MagLib.BDO.Actors.LocalPlayer.stopMoving()
		end
		lastAttackedMobs = MagLib.getTime()
		return true
	else
		return false
	end
end

local handleKillspot = function()
	local pPos = MagLib.BDO.Actors.LocalPlayer.getPos()
	local targetObjectPos = currentTargetObject.pos
	local distance = pPos:getDistance(targetObjectPos)

	if distance > currentTargetObject.size then
		-- Move to the gathering object
		MagLib.BDO.Navigation.moveTo(targetObjectPos, true, currentTargetObject.size - 50)
	else
		-- Firstly we check if a mob is really close to us inside the killzone and kill that one to ensure not getting stuck
		if killMobs(isRightCloseCollectableMonsterToKill) then
			return
		end

		-- Then we loot all dead bodies
		local collectableActor = MagLib.BDO.Actors.getClosestFilteredActor(EActorType_Monster,
                                                                   		isRightCollectableMonsterToGather)
		if collectableActor then
			-- Resetting selection so we do not have crosshair problems
			MagLib.BDO.Actions.Combat.CombatManager.resetTarget()
			Infinity.BDO.Selection.reset()
			-- Checking that we are close enough/on top of the collectableActor
			local collectableActorPos = collectableActor:getPosition()
			if getPPos():getDistance(collectableActorPos) > 100 then
				MagLib.BDO.Navigation.moveTo(collectableActorPos, true, 90)
				return
			else
				-- Stop moving so we can gather
				MagLib.BDO.Actors.LocalPlayer.stopMoving()
			end

			-- We want to gather the dead body
			local toolIndex = currentTargetObject.toolIndex
			local state = MagLib.BDO.Gathering.equipTool(toolIndex)
			if state == MagLib.BDO.Gathering.equipTool_ReturnValues.InProcess then
				-- We return since we are in process of swapping tools
				MagLib.wait(1000) -- Giving it time to swap
				return
			elseif state == MagLib.BDO.Gathering.equipTool_ReturnValues.NoToolFound then
				-- We skip this one since we do not have the right tool.
				-- Remembering that we do not have this tool
				gotNeededTools[toolIndex] = false
				skipCurrentTargetObject()
				return
			end

			-- We have the right tool equipped
			blocked = true
			MagLib.BDO.Gathering.gather(collectableActor, onGatherFinished)
			GatherBuddy.logger.info("Started gathering dead body!")
			return
		end

		-- lastly we kill other mobs inside or skip if there are no mobs
		if not killMobs(isRightCollectableMonsterToKill) and MagLib.getTime() - lastAttackedMobs >
			settings.waitForDeadMobToBecomeGatherableDelay then
			-- We killed and gathered all gatherable monsters in the spot
			print("KILLED AND GATHERED ALL, CONTINUING")
			currentTargetObject = nil
			currentTargetActor = nil
		end
	end
end

-- GatheringState
local work = function(self)
	-- Looting is handled by the LootingModule

	-- Check if we are gathering
	if blocked then
		return
	end

	-- Checking conditions to enter the townrun state (next state). Basically meaning we cannot gather anymore.
	if shouldTownrun() then
		return true
	end

	-- updating target object
	if currentTargetObject == nil then
		updateTargetObject()
	end

	if currentTargetObject.toolIndex == nil then
		-- Skip since currently unsupported
		GatherBuddy.logger.warning(
			"GatherBuddy does not support the given actor. Check the Profile GatheringObject list for more information!")
		currentTargetObject = nil
		return false
	end

	local isKillspot = (currentTargetObject.type == GatherObjectUtils.objectTypes.Killspot)

	if isKillspot then
		handleKillspot()
	else
		handleGathering()
	end

	return false
end

local onStateChangedTo = function()
	resetBlock()
	resetGotNeededTools()
end
GatheringState = MagLib.Run.States.State("GatheringState", work)
GatheringState.onStateChangedTo = onStateChangedTo
