local settings = {
	maxRange = 300,
	recordTrees = true,
	recordPlants = true,
	recordOres = true,
	defaultTreeToolIndex = MagLib.BDO.Gathering.ToolIndex.Axe,
	defaultKillzoneToolIndex = MagLib.BDO.Gathering.ToolIndex.ButcheringKnife
}
MagLib.Core.Settings.addSettingsToHandler("GatherBuddy_Recording", settings)

local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos

local collectFilterFunc = function(actor)
	local pPos = getPPos()
	local collectablePos = actor:getPosition()

	-- Check distance
	local distance = pPos:getDistance(collectablePos)
	if distance > settings.maxRange then
		return false
	end

	-- Check if already existing
	local currentProfile = MagLib.BDO.Navigation.Graph.Profiles.currentProfile

	if GatherObjectUtils.isKnownInProfile(currentProfile, actor) then
		return false
	end

	--[[
    for _, existingCollectable in pairs(gatheringObjects) do 
        if MagLib.Utils.Vector.equal(existingCollectable.pos, collectablePos) then 
            --Same pos, collectable already here
            return false
        end
    end
    ]]

	--[[
        Check if it should be recorded by comparing to tool index
        Trees -> Axe/Collector
        Plants -> Hoe
        Ores -> Pickaxe
    ]]
	local toolIndex = MagLib.BDO.Gathering.getToolIndexByActorId(actor:getActorId())
	if (toolIndex == MagLib.BDO.Gathering.ToolIndex.Axe or toolIndex == MagLib.BDO.Gathering.ToolIndex.Collector) and
		not settings.recordTrees then
		return false
	elseif toolIndex == MagLib.BDO.Gathering.ToolIndex.Hoe and not settings.recordPlants then
		return false
	elseif toolIndex == MagLib.BDO.Gathering.ToolIndex.Pickaxe and not settings.recordOres then
		return false
	end

	return true
end

local run = function()
	-- Checking that we are recording
	if not MagLib.BDO.Navigation.Graph.Profiles.currentProfile or
		not MagLib.BDO.Navigation.Graph.Profiles.currentProfile.isRecording then
		return
	end

	local collectable = MagLib.BDO.Actors.getClosestFilteredActor(EActorType_Collect, collectFilterFunc)
	if collectable then
		local name = collectable:getName()
		local actorId = collectable:getActorId()
		local pos = collectable:getPosition()

		GatherBuddy.logger.info("Adding new collectable " .. name .. " to list!")
		GatherObjectUtils.addGatheringObjectToProfile(MagLib.BDO.Navigation.Graph.Profiles.currentProfile, name, actorId, pos)
	end
end

RecordingModule = MagLib.Run.Modules.RunModule("Recording Module", 100, 250,
                                               MagLib.Run.Modules.TimingMode.TimedNonCritical,
                                               MagLib.Run.EPulseTimingMode.Beginning)
RecordingModule.run = run

RecordingModule.start()
MagLib.Run.Modules.Handler.addModule(RecordingModule)
