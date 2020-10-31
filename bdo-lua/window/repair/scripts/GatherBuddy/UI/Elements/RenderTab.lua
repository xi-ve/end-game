local UI = MagLib.UI

local drawRadarSettings = function()
	local settings = MagLib.Core.Settings.getSetting("GatherBuddy_RenderD2D_Radar")
	UI.Text("Useful to locate ores, etc.")
	settings.enabled = UI.Checkbox("Enable Radar", settings.enabled, nil, nil, true)
	if settings.enabled then
		UI.Indent(15)
		-- Render X Bools
		settings.renderTrees = UI.Checkbox("Render Trees:", settings.renderTrees,nil, nil, true)
		UI.SameLine(nil, 80)
		settings.renderPlants = UI.Checkbox("Render Plants:", settings.renderPlants,nil, nil, true)
		UI.SameLine(nil, 80)
		settings.renderOres = UI.Checkbox("Render Ores:", settings.renderOres,nil, nil, true)

		-- Colors
		settings.treeColor = UI.ColorPicker("Tree:", settings.treeColor)
		UI.SameLine(nil, 20)
		settings.plantColor = UI.ColorPicker("Plant:", settings.plantColor)
		UI.SameLine(nil, 20)
		settings.oreColor = UI.ColorPicker("Ore:", settings.oreColor)

		settings.renderMobs = UI.Checkbox("Render Mobs:", settings.renderMobs, true)
		if settings.renderMobs then
			UI.Indent(15)
			settings.renderMobs = UI.Checkbox("Render Additonal Text On Mobs:", settings.renderMobs, nil, nil, true)
			settings.mobColor = UI.ColorPicker("Killable Mob:", settings.mobColor)
			UI.SameLine(nil, 20)
			settings.mobColor_gatherable = UI.ColorPicker("Gatherable Mob:", settings.mobColor_gatherable)
			UI.SameLine(nil, 20)
			settings.mobColor_notInKillspot = UI.ColorPicker("Not in Killspot:", settings.mobColor_notInKillspot)

			settings.mobColor_unknown = UI.ColorPicker("Unknown Mob Color:", settings.mobColor_unknown)
			UI.SameLine(nil, 20)
			settings.mobColor_collision = UI.ColorPicker("Invalid Due To Collision:", settings.mobColor_collision)

			UI.Unindent(15)
		end

		-- Others
		settings.drawIndicatorsToUnadded = UI.Checkbox("Draw Indicators to gather objects not in your profile",
                                               		settings.drawIndicatorsToUnadded)

		UI.Unindent(15)
	end
end

local drawProfileSettings = function()
	local settings = MagLib.Core.Settings.getSetting("GatherBuddy_RenderD2D_Profile")

	settings.renderKnownObjects = UI.Checkbox("Render known Objects:", settings.renderKnownObjects, nil, nil, true)
	if settings.renderKnownObjects then
		UI.SameLine()
		settings.knownObjectColor = UI.ColorPicker("Known Object Color:", settings.knownObjectColor)
	end
end
DrawRenderTab = function()

	if ImGui.CollapsingHeader("Radar") then
		ImGui.Indent(15)
		drawRadarSettings()
		ImGui.Unindent(15)
	end

	if ImGui.CollapsingHeader("Profile") then
		ImGui.Indent(15)
		drawProfileSettings()
		if ImGui.CollapsingHeader("Navigation") then
			ImGui.Indent(15)
			UI.Navigation.RenderD2D.drawRenderSettings()
			ImGui.Unindent(15)
		end
		ImGui.Unindent(15)
	end
end
