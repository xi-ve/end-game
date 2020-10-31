local recordSettings = MagLib.Core.Settings.getSetting("GatherBuddy_Recording")

GatherObjectUtils = {}
GatherObjectUtils.objectTypes = {Gather = 0, Killspot = 1}

GatherObjectUtils.isKnownInProfile = function(profile, actor)
	if profile == nil or profile.extra == nil or profile.extra.gatheringObjects == nil then
		return false
	end

	local actorPos = actor:getPosition()
	local currentGatherObjects = profile.extra.gatheringObjects
	for _, gatherObject in pairs(currentGatherObjects) do
		if MagLib.Utils.Vector.equal(gatherObject.pos, actorPos) then
			-- Same pos, gatherObjects known
			return true
		end
	end

	return false

end

GatherObjectUtils.getOptimalKillspotSize = function(pos)
	return 500 -- TODO
end

GatherObjectUtils.addKillspotObjectToProfile = function(profile, pos, size)
	table.insert(profile.extra.gatheringObjects, {
		pos = pos,
		size = size,
		type = GatherObjectUtils.objectTypes.Killspot,
		toolIndex = recordSettings.defaultKillzoneToolIndex
	})
end

GatherObjectUtils.addGatheringObjectToProfile = function(profile, name, actorId, pos)
	local toolIndex = MagLib.BDO.Gathering.getToolIndexByActorId(actorId)
	if (toolIndex == MagLib.BDO.Gathering.ToolIndex.Axe or toolIndex == MagLib.BDO.Gathering.ToolIndex.Collector) then
		-- If it is a tree, we want to change it to settings.defaultTreeToolIndex
		toolIndex = recordSettings.defaultTreeToolIndex
	end
	table.insert(profile.extra.gatheringObjects, {
		name = name,
		actorId = actorId,
		pos = pos,
		toolIndex = toolIndex,
		type = GatherObjectUtils.objectTypes.Gather
	})
end
