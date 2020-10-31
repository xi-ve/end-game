UIManager = {}

UIManager.SearchNPCName = ""
UIManager.FilteredNPCs = {}

function UIManager.GUIDraw()
	DebugManager.Trace("UIManager.GUIDraw()", DEBUG_VERBOSITY_LOUD)

	ImGui.SetNextWindowContentSize(ImVec2(450, 0))
	ImGui.Begin("Friends", true, ImGuiWindowFlags_AlwaysAutoResize)

	_, Application.AmityTarget = ImGui.SliderInt("Amity Target##sliderint_amity_target", Application.AmityTarget, 1, 1000)

	if Application.ActiveNPC == nil then
		ImGui.Text("NPC Name")

		local submittedNPCName = false

		submittedNPCName, UIManager.SearchNPCName = ImGui.InputText("##text_npc_name", UIManager.SearchNPCName, nil,
                                                            		ImGuiInputTextFlags_EnterReturnsTrue)

		ImGui.SameLine()

		if submittedNPCName or ImGui.Button("Search##button_search", ImVec2(ImGui.GetContentRegionAvailWidth(), 20)) then
			UIManager.FilteredNPCs = {}

			for i = 1, GameRegion.GetCount() do
				local territoryName = GameRegion.GetTerritoryNameByIndex(i - 1)
				local areaName = GameRegion.GetAreaNameByIndex(i - 1)
				local regionKey = GameRegion.GetRegionKeyByIndex(i - 1)

				for j = 1, GameRegion.GetNPCCount(regionKey) do
					local npcName = GameRegion.GetNPCNameByIndex(j - 1)

					if string.find(string.lower(npcName), string.lower(UIManager.SearchNPCName)) then
						table.insert(UIManager.FilteredNPCs, {
							territoryName = territoryName,
							areaName = areaName,
							npcName = npcName,
							npcPosition = {
								x = GameRegion.GetNPCPositionXByIndex(j - 1),
								y = GameRegion.GetNPCPositionYByIndex(j - 1),
								z = GameRegion.GetNPCPositionZByIndex(j - 1)
							}
						})
					end
				end
			end

			UIManager.SearchNPCName = ""
		end

		if #UIManager.FilteredNPCs > 0 then
			ImGui.TextColored(RenderHelper.GetColorImVec4FromHexColorString("FFa1f542"),
                  			"Press Start while standing in the open world.")
			ImGui.Columns(4, "columns_filtered_npcs")

			ImGui.Text("Territory Name")
			ImGui.NextColumn()
			ImGui.Text("Area Name")
			ImGui.NextColumn()
			ImGui.Text("NPC Name")
			ImGui.NextColumn()
			ImGui.Text("")
			ImGui.NextColumn()

			for i = 1, #UIManager.FilteredNPCs do
				local filteredNPC = UIManager.FilteredNPCs[i]

				ImGui.Text(filteredNPC.territoryName)
				ImGui.NextColumn()
				ImGui.Text(filteredNPC.areaName)
				ImGui.NextColumn()
				ImGui.Text(filteredNPC.npcName)
				ImGui.NextColumn()

				if ImGui.Button("Start##button_start_" .. i) and not GameDialog.IsOpen() then
					Application.ActiveNPC = filteredNPC

					GameNavigation.MoveTo(Application.ActiveNPC.npcPosition.x, Application.ActiveNPC.npcPosition.y,
                      					Application.ActiveNPC.npcPosition.z)
				end

				ImGui.NextColumn()
			end
		end
	else
		if ImGui.Button("Stop##button_stop") then
			Application.ActiveNPC = nil
		end
	end

	ImGui.End()
end
