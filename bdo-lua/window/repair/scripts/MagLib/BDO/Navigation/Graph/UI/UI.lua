local UI = MagLib.UI
UI.Navigation = {}
local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos

------------PROFILE-----------------
function UI.Navigation.drawFullProfileUI()
	UI.Navigation.drawProfileSelection()
	local currentProfile = MagLib.BDO.Navigation.Graph.Profiles.currentProfile

	if currentProfile then
		UI.Navigation.drawProfileEditor()
		-- ImGui.Text("No Profile loaded!")
	end
end

local newProfilePopupOpen = false

local refreshButtonWidth = 80
local refreshButtonSize = ImVec2(refreshButtonWidth, 0)
local newButtonWidth = 80
local newButtonSize = ImVec2(newButtonWidth, 0)

function UI.Navigation.drawProfileSelection(fullLine, color, disallowNewProfile)
	local availableProfiles = MagLib.BDO.Navigation.Graph.Profiles.availableProfiles
	local currentIndex = MagLib.BDO.Navigation.Graph.Profiles.getCurrentProfileIndex()

	local changeFunction = function(newIndex)
		MagLib.BDO.Navigation.Graph.Profiles.loadProfile(availableProfiles[newIndex])
	end

	local comboWidth = nil
	if (fullLine) then
		if fullLine then
			local spaceLeft = ImGui.GetContentRegionAvailWidth()
			local minWidth = UI.minSliderLineWidth
			if spaceLeft < minWidth then
				spaceLeft = minWidth
			end
			comboWidth = spaceLeft - refreshButtonWidth - UI.defaultFramePadding
			if not disallowNewProfile then
				comboWidth = comboWidth - newButtonWidth - UI.defaultFramePadding
			end
		end
	end

	ImGui.Spacing()
	UI.Combo("Profile: ", currentIndex, availableProfiles, false, changeFunction, color, comboWidth)
	ImGui.SameLine()
	if UI.SimpleButton("Refresh!##btn_refresh_profiles", color, refreshButtonSize) then
		MagLib.BDO.Navigation.Graph.Profiles.refreshProfiles()
	end

	if not disallowNewProfile then
		ImGui.SameLine()
		-- Opens a popup where you can input the profile name and creates the profile
		if UI.SimpleButton("New Profile!##btn_new_profile", color, newButtonSize) then
			-- Only one popup should be open at all times
			if not newProfilePopupOpen then
				-- Creates new Popup
				UI.Popups.new("Profile name", function(self)
					newProfilePopupOpen = true

					ImGui.SetWindowSize(ImVec2(600, 75))

					-- Input for profile name
					self.profileName = UI.InputText("Profile name:", self.profileName)

					UI.SameLine()
					-- unique create button
					UI.Button("Create##create_profile_popup_index_" .. self.index, function()
						local containsSpaces = string.find(self.profileName, " ") ~= nil
						local containsNothing = self.profileName == ""

						if self.profileName ~= nil and not containsNothing and not containsSpaces then
							MagLib.BDO.Navigation.Graph.Profiles.newProfile(self.profileName)
							self.close()
						else
							MagLib.logger.warning("Please give the Profile a valid name! Needs to include characters and no spaces!")
						end
					end, color)

					ImGui.SameLine()
					UI.Button("Close", function()
						newProfilePopupOpen = false
						self.close()
					end, color)
				end)
			end
		end
	end

	if currentIndex ~= -1 then
		UI.Button("Save!##btn_save_profile", function()
			MagLib.BDO.Navigation.Graph.Profiles.saveProfile()
		end, color)

		ImGui.SameLine()
		UI.Button("Unload!##btn_unload_profile", function()
			MagLib.BDO.Navigation.Graph.Profiles.unloadProfile()
		end, color)
	end
end

local function drawNPCs()
	local pPos = getPPos()
	local currentProfile = MagLib.BDO.Navigation.Graph.Profiles.currentProfile
	for npcType, npcDatas in pairs(currentProfile.npcs) do
		if ImGui.TreeNode(string.format("Type: %s (%d)", npcType, #npcDatas)) then
			for i, npcData in pairs(currentProfile.npcs[npcType]) do
				local npcPos = Vector3(npcData.posX, npcData.posY, npcData.posZ)
				local removeId = nil
				if ImGui.SmallButton(string.format("-##remove_npc%s_%d", npcType, i)) then
					removeId = i
				end
				ImGui.SameLine()
				ImGui.Text(string.format("Name: %s (%0.0fm)", npcData.name, pPos:getDistance(npcPos) / 100))

				if removeId then
					currentProfile.npcs[npcType] = table.removeIndex(currentProfile.npcs[npcType], removeId)
					removeId = nil
				end

				npcPos = nil
			end
			ImGui.TreePop()
		end
	end
end

function UI.Navigation.drawProfileEditor()
	local currentProfile = MagLib.BDO.Navigation.Graph.Profiles.currentProfile
	local changeFunction = function(new)
		if new == true then
			currentProfile.recordModule.start()
		end
	end
	local new_isRecording = nil
	new_isRecording = UI.Checkbox("Recording: ", currentProfile.isRecording, changeFunction)
	currentProfile.isRecording = new_isRecording
	if new_isRecording then
		ImGui.SameLine()
		currentProfile.navGraph.pseudoMeshCreation = UI.Checkbox("Create Pseudo Mesh: ",
                                                         		currentProfile.navGraph.pseudoMeshCreation)
	end

	-- if not new_isRecording then
	ImGui.SameLine() -- Do not put all three on the same line (isRecording, pseudoMeshCreation and editMode)
	-- end

	local newEditMode = nil
	newEditMode = UI.Checkbox("(Not working) Delete Mode: ", currentProfile.editMode)
	currentProfile.editMode = newEditMode
	if newEditMode then
		ImGui.Text("Delete Mode: \n Press the DELETE key to delete the closest Node/Edge to your mouse!")
	end

	if ImGui.Button("Add T1 Node##Add_T1") then
		currentProfile.navGraph.forceAddT1Node = true
		currentProfile.recordModule.start()
	end
	ImGui.SameLine()
	if ImGui.Button("Add T2 Node##Add_T2") then
		currentProfile.navGraph.forceAddT2Node = true
		currentProfile.recordModule.start()
	end

	if ImGui.Button("Recalculate T2 Edges##recalcEdges") then
		currentProfile.navGraph.recalculateT2Edges()
	end

	if ImGui.TreeNode("Profile NPCs") then
		drawNPCs()
		ImGui.TreePop()
	end
end

function UI.Navigation.drawNavigationSettings()
	local navSettings = MagLib.Core.Settings.getSetting("MagLib_Navigation_Graph")
	-- Teleport settings
	navSettings.use_tp = UI.Checkbox("Allow Teleport with no players around", navSettings.use_tp)
	if navSettings.use_tp then
		navSettings.tp_delay = UI.SliderInt("TP Delay", navSettings.tp_delay, 25, 500)
		navSettings.tp_maxDistance = UI.SliderInt("TP Distance", navSettings.tp_maxDistance, 25, 500)
		navSettings.tp_height_offset = UI.SliderInt("TP Height Offset", navSettings.tp_height_offset, 0, 150)
	end

	-- Pathing settings
	navSettings.skip_path_nodes = UI.Checkbox("Skip Nodes in Path if possible", navSettings.skip_path_nodes)
	if not navSettings.skip_path_nodes then
		navSettings.emulate_human_movement = UI.Checkbox("Interpolate path", navSettings.emulate_human_movement)
		if navSettings.emulate_human_movement then
			UI.Indent(15)
			navSettings.interpolation_movement_smoothness = UI.SliderInt("Roundness",
                                                             			navSettings.interpolation_movement_smoothness, 0, 10)
			navSettings.interpolation_path_smoothness = UI.SliderInt("Interpolation Strength",
                                                         			navSettings.interpolation_path_smoothness, 0, 10)
			UI.Unindent(15)
		end
	end

end
