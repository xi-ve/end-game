MagLib.UI.Navigation.RenderD2D = {}
local UI = MagLib.UI

MagLib.UI.Navigation.RenderD2D.drawRenderSettings = function()
	local settings = MagLib.Core.Settings.getSetting("MagLib_Navigation_Graph_RenderD2D")
	if settings then
		settings.draw_navigation = UI.Checkbox("Render Nodes", settings.draw_navigation)
		if settings.draw_navigation then
			UI.Indent(15)
			settings.draw_T1 = UI.Checkbox("Draw T1", settings.draw_T1)
			UI.SameLine()
			settings.draw_T2 = UI.Checkbox("Draw T2", settings.draw_T2)

			if settings.draw_T1 or settings.draw_T2 then
				UI.SameLine()
				settings.node_fill_circle = MagLib.UI.Checkbox("Fill Node Circle", settings.node_fill_circle)
			end
			UI.SameLine()
			settings.draw_navigation_numbers = UI.Checkbox("Draw Node Numbers", settings.draw_navigation_numbers)

			settings.renderDistance = UI.SliderInt("Render Distance", settings.renderDistance, 0, 5000)

			UI.Unindent(15)
		end

		settings.draw_destination = UI.Checkbox("Render Line to Destination", settings.draw_destination)

		UI.SameLine()
		settings.draw_destination_path = UI.Checkbox("Render Path to Destination", settings.draw_destination_path)

		if ImGui.CollapsingHeader("Colors##render_colors_header", true,
                          		ImGuiTreeNodeFlags_Framed + ImGuiTreeNodeFlags_FramePadding) then
			UI.Indent(15)
			UI.Text("Nodes:")
			if settings.draw_T1 then
				settings.T1_node_color = MagLib.UI.ColorPicker("T1 Nodes Color", settings.T1_node_color, false)
				UI.SameLine()
				settings.T1_edge_color = MagLib.UI.ColorPicker("T1 Edges Color", settings.T1_edge_color, false)

				if settings.draw_navigation_numbers then
					UI.SameLine()
					settings.T1_text_color = MagLib.UI.ColorPicker("T1 Number Color", settings.T1_text_color, false)
				end

			end

			if settings.draw_T2 then
				settings.T2_node_color = MagLib.UI.ColorPicker("T2 Nodes Color", settings.T2_node_color, false)
				UI.SameLine()
				settings.T2_edge_color = MagLib.UI.ColorPicker("T2 Edges Color", settings.T2_edge_color, false)

				if settings.draw_navigation_numbers then
					UI.SameLine()
					settings.T2_text_color = MagLib.UI.ColorPicker("T2 Number Color", settings.T2_text_color, false)
				end
			end
			UI.Button("Reset Colors", function()
				local RenderD2D = MagLib.BDO.Navigation.Graph.RenderD2D
				settings.T1_node_color = RenderD2D.defaultColors.T1_node_color

				settings.T1_text_color = RenderD2D.defaultColors.T1_text_color

				settings.T1_edge_color = RenderD2D.defaultColors.T1_edge_color

				settings.T2_node_color = RenderD2D.defaultColors.T2_node_color

				settings.T2_text_color = RenderD2D.defaultColors.T2_text_color

				settings.T2_edge_color = RenderD2D.defaultColors.T2_edge_color
			end)
			UI.Unindent(15)
		end
	end
end
