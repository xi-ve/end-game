local UI = MagLib.UI

local settings = {autoKillspotSize = false, killspotSize = 500}
MagLib.Core.Settings.addSettingsToHandler("GatherBuddy_ProfileEditor", settings)

local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos

local axeCollectorComboTable = {[1] = "Axe", [2] = "Collector"}

local killspotToolComboTable = {[1] = "Collector", [2] = "Butchering Knife", [3] = "Tanning Knife"}

local drawGatheringObjectsEditor = function(currentProfile)
	if ImGui.CollapsingHeader("Gathering Objects") then
		local pPos = getPPos()

		local gatheringObjects = currentProfile.extra.gatheringObjects
		if not gatheringObjects then
			-- Create and set local var
			currentProfile.extra.gatheringObjects = {}
			gatheringObjects = currentProfile.extra.gatheringObjects
		end

		-- settings.autoKillspotSize = UI.Checkbox("Auto Killspot Size", settings.autoKillspotSize)
		-- if not settings.autoKillspotSize then
		-- UI.SameLine() 
		settings.killspotSize = UI.InputInt("Killspot Size", settings.killspotSize, 50, 200, false, nil, nil, nil, 250)
		-- end
		UI.SameLine()
		if UI.SimpleButton("Add Killspot") then
			local newKillspotSize = settings.killspotSize
			-- if settings.autoKillspotSize then 
			--    newKillspotSize = GatherObjectUtils.getOptimalKillspotSize(pPos)
			-- end
			GatherObjectUtils.addKillspotObjectToProfile(currentProfile, pPos, newKillspotSize)
		end

		UI.Columns(7, {55, 80, 100, 80, 200, 100, 60}, {"Index", "Type", "Name", "Actor ID", "Tool", "Distance", "Remove"})
		local amountOfGatheringObjects = #gatheringObjects

		for i = 1, amountOfGatheringObjects do
			local object = gatheringObjects[i]
			local isKillspot = (object.type == GatherObjectUtils.objectTypes.Killspot)
			UI.Text(i)
			UI.NextColumn()

			local typeString = "Gather"
			if isKillspot then
				typeString = "Killspot"
			end
			UI.Text(typeString)
			UI.NextColumn()

			if not isKillspot then
				UI.Text(tostring(object.name))
			end
			UI.NextColumn()

			if not isKillspot then
				local actorId = object.actorId
				UI.Text(actorId)
			end
			UI.NextColumn()

			-- Selector for Tool
			local toolIndex = object.toolIndex
			if not isKillspot and
				(toolIndex == MagLib.BDO.Gathering.ToolIndex.Axe or toolIndex == MagLib.BDO.Gathering.ToolIndex.Collector) then
				-- Combo to decide which to use
				local tempToolIndex = 1 -- Axe
				if toolIndex == MagLib.BDO.Gathering.ToolIndex.Collector then
					tempToolIndex = 2 -- Collector 
				end
				local changed
				tempToolIndex, changed = UI.Combo("##tool_select_combo_" .. i, tempToolIndex, axeCollectorComboTable)

				-- if the value changed, we update the object
				if changed then
					if tempToolIndex == 1 then
						-- Axe
						object.toolIndex = MagLib.BDO.Gathering.ToolIndex.Axe
					else
						-- Collector
						object.toolIndex = MagLib.BDO.Gathering.ToolIndex.Collector
					end
				end
			elseif isKillspot then
				local tempToolIndex = 1 -- Collector
				if toolIndex == MagLib.BDO.Gathering.ToolIndex.ButcheringKnife then
					tempToolIndex = 2 -- Butchering Knife
				elseif toolIndex == MagLib.BDO.Gathering.ToolIndex.TanningKnife then
					tempToolIndex = 3 -- Tanning Knife
				end
				local changed
				tempToolIndex, changed = UI.Combo("##tool_select_combo" .. i, tempToolIndex, killspotToolComboTable)

				-- if the value changed, we update the object
				if changed then
					if tempToolIndex == 1 then
						-- Collector
						object.toolIndex = MagLib.BDO.Gathering.ToolIndex.Collector
					elseif tempToolIndex == 2 then
						-- ButcheringKnife
						object.toolIndex = MagLib.BDO.Gathering.ToolIndex.ButcheringKnife
					else
						-- TanningKnife
						object.toolIndex = MagLib.BDO.Gathering.ToolIndex.TanningKnife
					end
				end
			else
				UI.Indent(10) -- Because Combo boxes stick out a bit
				if (toolIndex ~= nil) then
					UI.Text(MagLib.BDO.Gathering.getToolNameByIndex(toolIndex))
				else
					UI.Text("Unsupported", "FFFF0000")
					UI.SameLine()
					if UI.SimpleButton("?") then
						UI.Popups.new("Unsupported Actor!", function(self)
							UI.Text("The given actor is not yet supported by GatherBuddy.")
							UI.Text("Please send Magxm a PM with the ActorID (here it is " .. object.actorId .. " )")
							UI.Text("Please include what tools can be used on the actor.")
							UI.Text("Possible tools are Hoe, Axe, Collector, Butchering Knife and Tanning Knife.")
							if UI.SimpleButton("Close") then
								self:close()
							end
						end)
					end
				end
				UI.Unindent(10)
			end
			UI.NextColumn()

			UI.Text(math.floor(pPos:getDistance(object.pos)))
			UI.NextColumn()

			if UI.SimpleButton("x##remove_gatheringObject_" .. i) then
				table.remove(gatheringObjects, i)
				break
			end
			UI.NextColumn()
		end

		UI.EndColumns()
	end
end

DrawProfileTab = function()
	MagLib.UI.Navigation.drawProfileSelection(true)
	local currentProfile = MagLib.BDO.Navigation.Graph.Profiles.currentProfile
	if currentProfile then
		UI.Separator()
		MagLib.UI.Navigation.drawProfileEditor()

		-- Recording settings 
		if MagLib.BDO.Navigation.Graph.Profiles.currentProfile and
			MagLib.BDO.Navigation.Graph.Profiles.currentProfile.isRecording then
			local recordingSettings = MagLib.Core.Settings.getSetting("GatherBuddy_Recording")
			local radarSettings = MagLib.Core.Settings.getSetting("GatherBuddy_RenderD2D_Radar")
			recordingSettings.recordTrees = UI.Checkbox("Record Trees:", recordingSettings.recordTrees, nil,
                                            			radarSettings.treeColor, true)
			UI.SameLine()
			recordingSettings.recordPlants = UI.Checkbox("Record Plants:", recordingSettings.recordPlants, nil,
                                             			radarSettings.plantColor, true)
			UI.SameLine()
			recordingSettings.recordOres = UI.Checkbox("Record Ores:", recordingSettings.recordOres, nil, radarSettings.oreColor,
                                           			true)
			-- Default Tool for Trees Combo
			if recordingSettings.recordTrees then
				local tempToolIndex, changed
				if recordingSettings.defaultTreeToolIndex == MagLib.BDO.Gathering.ToolIndex.Axe then
					tempToolIndex = 1 -- Axe
				else
					tempToolIndex = 2 -- Collector
				end
				tempToolIndex, changed = MagLib.UI.Combo("Default Tool for Trees: ", tempToolIndex, axeCollectorComboTable)
				if changed then
					if tempToolIndex == 1 then
						-- Axe
						recordingSettings.defaultTreeToolIndex = MagLib.BDO.Gathering.ToolIndex.Axe
					else
						-- Collector 
						recordingSettings.defaultTreeToolIndex = MagLib.BDO.Gathering.ToolIndex.Collector
					end
				end
			end
		end

		---Gathering specific
		drawGatheringObjectsEditor(currentProfile)
		UI.Separator()
	end
end
