local settings = {renderKnownObjects = true, knownObjectColor = "FF3A32A8"}
MagLib.Core.Settings.addSettingsToHandler("GatherBuddy_RenderD2D_Profile", settings)

local getPPos = MagLib.BDO.Actors.LocalPlayer.getPosition

-- Adding and activating render module
local renderModule = MagLib.RenderManager.Module("Profile")
renderModule.activate()
MagLib.RenderManager.addModule(renderModule)

-- Object updating
local updateModule = MagLib.Run.Modules.RunModule("RenderD2D_Profile_Updater", 250, 1000,
                                                  MagLib.Run.Modules.TimingMode.TimedNonCritical,
                                                  MagLib.Run.EPulseTimingMode.End)

updateModule.run = function()
	renderModule.clear()

	if not settings.renderKnownObjects then
		return
	end
	local currentProfile = MagLib.BDO.Navigation.Graph.Profiles.currentProfile
	if not currentProfile then
		return
	end

	local onWorldmap = MagLib.BDO.Worldmap.isOpen()

	-- Render all known objects
	if not (currentProfile == nil or currentProfile.extra == nil or currentProfile.extra.gatheringObjects == nil) and
		settings.renderKnownObjects then

		local currentGatherObjects = currentProfile.extra.gatheringObjects
		local amountOfGatheringObjects = #currentGatherObjects
		local toolIndex = nil
		local circleSize = nil
		local color = settings.knownObjectColor

		for index = 1, amountOfGatheringObjects do
			local gatherObject = currentGatherObjects[index]
			local isKillspot = (gatherObject.type == GatherObjectUtils.objectTypes.Killspot)
			local text = "#" .. index
			if not isKillspot then
				-- Gathering
				toolIndex = gatherObject.toolIndex
				if (toolIndex == MagLib.BDO.Gathering.ToolIndex.Axe or toolIndex == MagLib.BDO.Gathering.ToolIndex.Collector) then
					circleSize = 50
				elseif toolIndex == MagLib.BDO.Gathering.ToolIndex.Hoe then
					circleSize = 60
				elseif toolIndex == MagLib.BDO.Gathering.ToolIndex.Pickaxe then
					circleSize = 50
				end
			else
				-- Killspot
				circleSize = gatherObject.size
				if not onWorldmap then
					text = text .. " Killspot"
				end
			end
			renderModule.addCircle(gatherObject.pos, circleSize, color, 1, false)
			local textSize = 40
			if onWorldmap then
				textSize = 20
			end

			renderModule.addText(text, textSize, "FFFFFFFF", gatherObject.pos, 0, -25)
		end
	end

end
updateModule.start()
MagLib.Run.Modules.Handler.addModule(updateModule)
