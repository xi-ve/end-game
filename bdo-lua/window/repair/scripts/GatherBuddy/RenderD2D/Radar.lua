local settings = {
	enabled = false,
	renderTrees = true,
	treeColor = "FFDAFF00",
	renderPlants = true,
	plantColor = "FF00FF2F",
	renderOres = true,
	oreColor = "FFFF7F00",
	drawIndicatorsToUnadded = true,
	indicatorMaxLength = 100,
	renderMobs = true,
	mobColor = "FF76FF00",
	mobColor_gatherable = "FF32A83C",
	renderMobs_situational_text = true,
	mobColor_collision = "FFA8329",
	mobColor_unknown = "FF000000",
	mobColor_notInKillspot = "FFA8A432",
	mobColor_supported = "FF00FF00"
}
MagLib.Core.Settings.addSettingsToHandler("GatherBuddy_RenderD2D_Radar", settings)

local getPPos = MagLib.BDO.Actors.LocalPlayer.getPosition

-- Adding and activating render module
local renderModule = MagLib.RenderManager.Module("Radar")
renderModule.activate()
MagLib.RenderManager.addModule(renderModule)

local textRenderModule = MagLib.RenderManager.Module("Radar(Text)")
textRenderModule.activate()
MagLib.RenderManager.addModule(textRenderModule)

-- Object updating
local updateModule = MagLib.Run.Modules.RunModule("RenderD2D_Radar_Updater", 250, 1000,
                                                  MagLib.Run.Modules.TimingMode.TimedNonCritical,
                                                  MagLib.Run.EPulseTimingMode.End)
updateModule.run = function()
	-- clearing render modules
	renderModule.clear()
	textRenderModule.clear()

	local currentProfile = MagLib.BDO.Navigation.Graph.Profiles.currentProfile

	if not settings.enabled or not (settings.renderTrees or settings.renderPlants or settings.renderOres) then
		-- Nothing to render in radar
		return
	end

	-- Get all Collect Actors and handle rendering
	local actors = Infinity.BDO.getActorList(EActorType_Collect)
	for _, actor in pairs(actors) do
		local actorPos = actor:getPosition()

		-- Check what kind of actor it is by checking toolIndex and then adding it to the renderModule
		local toolIndex = MagLib.BDO.Gathering.getToolIndexByActorId(actor:getActorId())
		-- Determine if and in what color/size the circles will be rendered
		local circleSize = nil
		local color = nil
		local render = false

		-- First we check if it is already a gathering object in our profile, if not we render it with toolIndex based colors
		if not GatherObjectUtils.isKnownInProfile(currentProfile, actor) then
			-- Not in the profile
			if (toolIndex == MagLib.BDO.Gathering.ToolIndex.Axe or toolIndex == MagLib.BDO.Gathering.ToolIndex.Collector) then
				if settings.renderTrees then
					circleSize = 50
					color = settings.treeColor
					render = true
				end
			elseif toolIndex == MagLib.BDO.Gathering.ToolIndex.Hoe then
				if settings.renderPlants then
					circleSize = 60
					color = settings.plantColor
					render = true
				end
			elseif toolIndex == MagLib.BDO.Gathering.ToolIndex.Pickaxe then
				if settings.renderOres then
					circleSize = 50
					color = settings.oreColor
					render = true
				end
			end

			-- Indicator
			if settings.drawIndicatorsToUnadded and render then
				renderModule.addPlayerCentricIndicator(actorPos, settings.indicatorMaxLength, color, 1.5)
			end
		end

		if render then
			renderModule.addCircle(actorPos, circleSize, color, 1, false)
		end
	end

	if settings.renderMobs then
		-- Get all mob actor and handle rendering
		local actors = Infinity.BDO.getActorList(EActorType_Monster)
		for _, actor in pairs(actors) do
			local aPos = actor:getPosition()

			-- Getting right killspot
			local gatheringObjects = MagLib.BDO.Navigation.Graph.Profiles.currentProfile.extra.gatheringObjects
			local closestGatheringSpot = nil
			local closestGatheringSpotDistance = 1 / 0
			if gatheringObjects ~= nil then
				for _, go in pairs(gatheringObjects) do
					local isKillspot = (go.type == GatherObjectUtils.objectTypes.Killspot)
					if (isKillspot) then
						-- We only want killspots
						local dist = aPos:getDistance(go.pos)
						local inKillspot = (dist < go.size)
						if (dist < closestGatheringSpotDistance) then
							closestGatheringSpotDistance = dist
							closestGatheringSpot = go
						end
					end
				end
			end

			local isInKillspot = (closestGatheringSpot ~= nil)
			if (isInKillspot) then
				local isCollectableMonster, notKillableReason = IsRightCollectableMonsterToKill(actor, closestGatheringSpot)
				if isCollectableMonster then
					-- Can kill
					renderModule.addCircle(aPos, 50, settings.mobColor, 1, false)
					if (settings.renderMobs_situational_text) then
						textRenderModule.addText("Will kill", 18, settings.mobColor, aPos, 0, 0)
					end
				else
					if notKillableReason == 1 then
						-- Is dead, checking gathering
						local canCollect, notCollectReason = IsRightCollectableMonsterToGather(actor, closestGatheringSpot)
						if canCollect then
							renderModule.addCircle(aPos, 50, settings.mobColor_gatherable, 1, false)
							if (settings.renderMobs_situational_text) then
								textRenderModule.addText("Will gather", 18, settings.mobColor_gatherable, aPos, 0, 0)
							end
						else
							if notCollectReason == 1 then
								-- Should not happen, actor is dead, cannot be dead and alive
								renderModule.addCircle(aPos, 50, "FFFF0000", 1, false)
								textRenderModule.addText("Ungatherable", 18, "FFFF0000", aPos, 0, 0)
							elseif notCollectReason == 2 then
								-- Not in killspot
								if (settings.renderMobs_situational) then
									renderModule.addCircle(aPos, 50, settings.mobColor_notInKillspot, 1, false)
									if (settings.renderMobs_situational_text) then
										textRenderModule.addText("Not in Killspot", 18, settings.mobColor_notInKillspot, aPos, 0, 0)
									end
								end
							elseif notCollectReason == 3 then
								-- Is unknown
								if (settings.renderMobs_situational) then
									renderModule.addCircle(aPos, 50, settings.mobColor_unknown, 1, false)
									if (settings.renderMobs_situational_text) then
										textRenderModule.addText("Unknown mob", 18, settings.mobColor_unknown, aPos, 0, 0)
									end
								end
							elseif notCollectReason == 4 then
								-- collision
								if (settings.renderMobs_situational) then
									renderModule.addCircle(aPos, 50, settings.mobColor_collision, 1, false)
									if (settings.renderMobs_situational_text) then
										textRenderModule.addText("Collision", 18, settings.mobColor_collision, aPos, 0, 0)
									end
								end
							end
						end
					elseif notKillableReason == 2 then
						-- Is not in the killspot
						if (settings.renderMobs_situational) then
							renderModule.addCircle(aPos, 50, settings.mobColor_notInKillspot, 1, false)
							if (settings.renderMobs_situational_text) then
								textRenderModule.addText("Not in Killspot", 18, settings.mobColor_notInKillspot, aPos, 0, 0)
							end
						end
					elseif notKillableReason == 3 then
						-- Is unknown
						if (settings.renderMobs_situational) then
							renderModule.addCircle(aPos, 50, settings.mobColor_unknown, 1, false)
							if (settings.renderMobs_situational_text) then
								textRenderModule.addText("Unknown mob", 18, settings.mobColor_unknown, aPos, 0, 0)
							end
						end
					elseif notKillableReason == 4 then
						-- collision
						if (settings.renderMobs_situational) then
							renderModule.addCircle(aPos, 50, settings.mobColor_collision, 1, false)
							if (settings.renderMobs_situational_text) then
								textRenderModule.addText("Collision", 18, settings.mobColor_collision, aPos, 0, 0)
							end
						end
					end
				end
			else
				-- it is not in a killspot, so we just render if it is supported or not
				local bKnifeIndex = MagLib.BDO.Gathering.ToolIndex.ButcheringKnife;
				local bSupported = table.find(MagLib.BDO.Gathering.ToolApplicableActorIds[bKnifeIndex], actor:getActorId()) ~= nil
				local tKnifeIndex = MagLib.BDO.Gathering.ToolIndex.TanningKnife;
				local tSupported = table.find(MagLib.BDO.Gathering.ToolApplicableActorIds[tKnifeIndex], actor:getActorId()) ~= nil

				if (bSupported or tSupported) then
					-- Is supported
					renderModule.addCircle(aPos, 50, settings.mobColor_supported, 1, false)
					if (settings.renderMobs_situational_text) then
						textRenderModule.addText("Supported", 18, settings.mobColor_supported, aPos, 0, 0)
					end
				else
					-- Is unknown
					if (settings.renderMobs_situational) then
						renderModule.addCircle(aPos, 50, settings.mobColor_unknown, 1, false)
						if (settings.renderMobs_situational_text) then
							textRenderModule.addText("Unknown mob", 18, settings.mobColor_unknown, aPos, 0, 0)
						end
					end
				end
			end
		end
	end
end

updateModule.start()
MagLib.Run.Modules.Handler.addModule(updateModule)
