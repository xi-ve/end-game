RenderD2D = {}
RenderD2D.defaultColors = {
	T1_node_color = "FFe5e4e2",
	T1_text_color = "FFe5e4C2",
	T1_edge_color = "FFc0c0c0",
	T2_node_color = "FF643200",
	T2_text_color = "FF643200",
	T2_edge_color = "FF8b4513"
}
RenderD2D.settings = {
	renderDistance = 2500,
	draw_navigation = true,
	draw_navigation_numbers = false,
	draw_T1 = true,
	draw_T2 = true,
	draw_destination = true,
	draw_destination_path = true,
	T1_node_color = RenderD2D.defaultColors.T1_node_color,
	T1_text_color = RenderD2D.defaultColors.T1_text_color,
	T1_edge_color = RenderD2D.defaultColors.T1_edge_color,
	T2_node_color = RenderD2D.defaultColors.T2_node_color,
	T2_text_color = RenderD2D.defaultColors.T2_text_color,
	T2_edge_color = RenderD2D.defaultColors.T2_edge_color,
	node_fill_circle = false
}
local renderSettings = RenderD2D.settings
MagLib.Core.Settings.addSettingsToHandler("MagLib_Navigation_Graph_RenderD2D", renderSettings)

local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos

local renderModule = MagLib.RenderManager.Module("MagLib_Navigation_RenderModule")
RenderD2D.renderModule = renderModule

MagLib.RenderManager.addModule(renderModule)

local toDrawUpdater = MagLib.Run.Modules.RunModule("MagLib_Navigation_RenderModule Updater Module", 250, 1000,
                                                   MagLib.Run.Modules.TimingMode.TimedNonCritical,
                                                   MagLib.Run.EPulseTimingMode.End)

toDrawUpdater.needToRun = function()
	if renderSettings.draw_navigation and MagLib.BDO.Navigation.Graph.Profiles.currentProfile and
		MagLib.BDO.Navigation.settings.navigationMode == MagLib.BDO.Navigation.Modes.Graph then
		renderModule.activate()
		return true
	else
		renderModule.deactivate()
		return false
	end
end

toDrawUpdater.run = function()
	local profile = MagLib.BDO.Navigation.Graph.Profiles.currentProfile
	local settings = renderSettings
	local _ = nil
	local onMap = false

	local drawNumbers = settings.draw_navigation_numbers
	local fillNodeCircle = settings.node_fill_circle
	local nodeColor = nil
	local nodeTextColor = nil
	local edgeColor = nil

	local renderDistance
	if not MagLib.BDO.Worldmap.isOpen() then
		renderDistance = settings.renderDistance
	else
		renderDistance = 1 / 0
	end

	-- Clearing all lines/circles/text
	renderModule.clear()

	if profile and settings.draw_navigation then
		local graph = nil
		local pPos = getPPos()
		-- T1 nodes
		if settings.draw_T1 then
			graph = profile.navGraph.graph_handler.getGraph()

			nodeColor = settings.T1_node_color
			nodeTextColor = settings.T1_text_color
			edgeColor = settings.T1_edge_color

			for _, v in pairs(graph.nodes) do
				local dist = v.pos:getDistance(pPos)
				if dist < renderDistance then
					renderModule.addCircle(v.pos, 15, nodeColor, 2, fillNodeCircle)
					if drawNumbers then
						renderModule.addText("Node #" .. v.index, 20, nodeTextColor, v.pos, 0, -40)
					end
				end
			end

			for _, v in ipairs(graph.edges) do
				local dist1 = v.from.pos:getDistance(pPos)
				local dist2 = v.to.pos:getDistance(pPos)
				if dist1 < renderDistance or dist2 < renderDistance or onMap then
					renderModule.addLine(v.from.pos, v.to.pos, edgeColor, 1)
				end
			end
		end

		-- T2
		if settings.draw_T2 then
			graph = profile.navGraph.key_graph_handler.getGraph()

			nodeColor = settings.T2_node_color
			nodeTextColor = settings.T2_text_color
			edgeColor = settings.T2_edge_color

			for _, v in pairs(graph.nodes) do
				local dist = v.pos:getDistance(pPos)
				if dist < renderDistance then
					renderModule.addCircle(v.pos, 15, nodeColor, 2, fillNodeCircle)
					if drawNumbers then
						renderModule.addText("Node #" .. v.index, 20, nodeTextColor, v.pos, 0, -40)
					end
				end
			end

			for _, v in ipairs(graph.edges) do
				local dist1 = v.from.pos:getDistance(pPos)
				local dist2 = v.to.pos:getDistance(pPos)
				if dist1 < renderDistance or dist2 < renderDistance or onMap then
					renderModule.addLine(v.from.pos, v.to.pos, edgeColor, 2)
				end
			end
		end

		-- Destination
		if settings.draw_destination then
			local dest = MagLib.BDO.Navigation.Graph.getCurrentDest()
			if dest then
				renderModule.addLine(pPos, dest, "FF4842f5", 1)
			end
		end

		-- Path
		if settings.draw_destination_path and MagLib.BDO.Navigation.Graph.Profiles.currentProfile.nav.path and
			MagLib.BDO.Navigation.Graph.Profiles.currentProfile.nav.path.waypoints then
			local waypoints = MagLib.BDO.Navigation.Graph.Profiles.currentProfile.nav.path.waypoints
			for i = 2, #waypoints do
				local prevPos = waypoints[i - 1]
				local pos = waypoints[i]
				renderModule.addLine(prevPos, pos, "FFf5da42", 3)
			end
		end
	end
end

MagLib.Run.Modules.Handler.addModule(toDrawUpdater)
toDrawUpdater.start()

MagLib.BDO.Navigation.Graph.RenderD2D = RenderD2D
