ProfileEditor = {}

function ProfileEditor.draw(newWindow)
	if newWindow == nil then
		newWindow = true
	end
	if newWindow then
		ImGui.Begin("[Grinder] Profile Editor")

		ImGui.PushStyleColor2(ImGuiCol_Text, RenderHelper.GetColorImVec4FromHexColorString("FFFFCC99"))
		ImGui.PushStyleColor2(ImGuiCol_Button, RenderHelper.GetColorImVec4FromHexColorString("FF990000"))
		ImGui.PushStyleColor2(ImGuiCol_CheckMark, RenderHelper.GetColorImVec4FromHexColorString("FF990000"))
	end

	if (Grinder.currentProfile) then
		local recordingChanged = false
		recordingChanged, Grinder.currentProfile.isRecording = ImGui.Checkbox("Recording##bot_profile_record",
                                                                      		Grinder.currentProfile.isRecording)
		if Grinder.currentProfile.isRecording then
			ImGui.SameLine()
			_, Grinder.currentProfile.navGraph.pseudoMeshCreation = ImGui.Checkbox("Creat Pseudo Mesh##create_mesh",
                                                                       			Grinder.currentProfile.navGraph
                                                                       				.pseudoMeshCreation)
		end

		if not Grinder.currentProfile.isRecording then
			ImGui.SameLine() -- Do not put all three on the same line (isRecording, pseudoMeshCreation and editMode)
		end
		_, Grinder.currentProfile.editMode = ImGui.Checkbox("Delete Mode##delete_mode", Grinder.currentProfile.editMode)
		if Grinder.currentProfile.editMode then
			ImGui.Text("Delete Mode: \n Press the DELETE key to delete the closest Node/Edge to your mouse!")
		end

		-------------
		if ImGui.Button("Add T1 Node##Add_T1") then
			Grinder.currentProfile.navGraph.forceAddT1Node = true
		end
		ImGui.SameLine()
		if ImGui.Button("Add T2 Node##Add_T2") then
			Grinder.currentProfile.navGraph.forceAddT2Node = true
		end

		if ImGui.Button("Recalculate T2 Edges##recalcEdges") then
			Grinder.currentProfile.navGraph.recalculateT2Edges()
		end

		if Grinder.currentProfile.isRecording then
			ImGui.PushItemWidth(120)
			-- ImGui.Indent(5)
			_, Grinder.settings.auto_grind_spot = ImGui.Checkbox("Auto Grind-spot", Grinder.settings.auto_grind_spot)
			if Grinder.settings.auto_grind_spot then
				ImGui.Text("Grind spots will be added on killing a mob!")
				ImGui.Text("Minimum Distance (Default: 800):")
				ImGui.SameLine()
				_, Grinder.settings.auto_grind_spot_range = ImGui.InputInt("##auto_grind_spot_range_input",
                                                           				Grinder.settings.auto_grind_spot_range)
			end
			ImGui.PopItemWidth()
		end
		-- ImGui.Unindent(5)

		if ImGui.TreeNode("Grinding Areas") then
			ProfileEditor.drawGrindAreas()
			ImGui.TreePop()
		end
		if ImGui.TreeNode("Townrun NPCs") then
			ProfileEditor.drawNps()
			ImGui.TreePop()
		end
	else
		ImGui.Text("Load or create a profile first!")
	end

	if newWindow then
		ImGui.PopStyleColor(3)
		ImGui.End()
	end
end

function ProfileEditor.drawGrindAreas()
	local playerPos = Cache.playerPos
	if ImGui.SmallButton("Add area...") then
		table.insert(Grinder.currentProfile.areas, {minLevel = 1, maxLevel = 70, spots = {}})
	end
	if #Grinder.currentProfile.areas > 0 then
		ProfileEditor.once = true
		local removeAreaId = nil

		for areaId, areaData in pairs(Grinder.currentProfile.areas) do
			if areaData.minLevel == nil then
				areaData.minLevel = 10
			end
			if areaData.maxLevel == nil then
				areaData.maxLevel = 99
			end

			if ImGui.TreeNode("Area " .. areaId .. ": Level Range [" .. areaData.minLevel .. "-" .. areaData.maxLevel .. "]") then
				if ImGui.Button("Area " .. areaId .. ": Delete##delete_area" .. tostring(areaId)) then
					removeAreaId = areaId
				end

				ImGui.PushItemWidth(65)
				_, areaData.minLevel = ImGui.InputInt("Area " .. areaId .. ": Minimum Level", areaData.minLevel, 1, 1)
				_, areaData.maxLevel = ImGui.InputInt("Area " .. areaId .. ": Maximum Level", areaData.maxLevel)
				ImGui.PopItemWidth()

				if not areaData.spots then
					areaData.spots = {}
				end

				if ImGui.Button("Add Grind-spot##add_grind_spot_area" .. tostring(areaId)) then
					table.insert(areaData.spots, {
						X = math.floor(playerPos.X + 0.5),
						Y = math.floor(playerPos.Y + 0.5),
						Z = math.floor(playerPos.Z + 0.5)
					})
				end

				if ImGui.TreeNode(string.format("Area " .. areaId .. ": Grind Spots (%d total)##area%d_spots", #areaData.spots,
                                				areaId)) then
					local removeSpotId = nil

					-- table.print(areaData.spots)

					for spotId, spotData in pairs(areaData.spots) do
						if ImGui.Button(string.format("-##remove_area%d_spot%d", areaId, spotId)) then
							removeSpotId = spotId
						end
						ImGui.SameLine()
						ImGui.Text(string.format("%s: %0.0f, %0.0f, %0.0f (%0.0fm)", spotId, spotData.X, spotData.Y, spotData.Z,
                         						playerPos:getDistance(Vector3(spotData.X, spotData.Y, spotData.Z)) / 100))
					end
					if removeSpotId then
						areaData.spots = table.removeIndex(areaData.spots, removeSpotId)
					end
					ImGui.TreePop()
				end
				ImGui.TreePop()
			end
		end
		if removeAreaId then
			Grinder.currentProfile.areas = table.removeIndex(Grinder.currentProfile.areas, removeAreaId)
			removeAreaId = nil
		end
	end

	playerPos = nil
end

function ProfileEditor.drawNps()
	local playerPos = Cache.playerPos
	for npcType, npcDatas in pairs(Grinder.currentProfile.npcs) do
		if ImGui.TreeNode(string.format("Type: %s (%d)", npcType, #npcDatas)) then
			for i, npcData in pairs(Grinder.currentProfile.npcs[npcType]) do
				local npcPos = Vector3(npcData.posX, npcData.posY, npcData.posZ)
				local removeId = nil
				if ImGui.SmallButton(string.format("-##remove_npc%s_%d", npcType, i)) then
					removeId = i
				end
				ImGui.SameLine()
				if npcData.name then
					ImGui.Text(string.format("Name: %s (%0.0fm)", npcData.name, playerPos:getDistance(npcPos) / 100))
				else
					ImGui.Text(string.format("Key (depricated): %d (%0.0fm)", npcData.key, playerPos:getDistance(npcPos) / 100))
				end
				if removeId then
					Grinder.currentProfile.npcs[npcType] = table.removeIndex(Grinder.currentProfile.npcs[npcType], removeId)
					removeId = nil
				end

				npcPos = nil
			end
			ImGui.TreePop()
		end
	end

	playerPos = nil
end
