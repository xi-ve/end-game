--[[

Contains Gui logic

]]-- 

AmityMaster_Gui = { }

AmityMaster_Gui.availableProfiles = { }
AmityMaster_Gui.availableProfilesSelectedIndex = -1

function AmityMaster_Gui.OnDrawGui() 

	ImGui.Begin("AmityMaster")	
	ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

		-- Row 1
		
		-- Drop-down list with all the profiles
		ImGui.BeginChild(1, ImVec2(ImGui.GetContentRegionAvailWidth() * 1.54,20), false) -- Using this so that the Combo box uses the entire width of the window
		_, AmityMaster_Gui.availableProfilesSelectedIndex =
			ImGui.Combo(
				"##profile_load_combo", 
				AmityMaster_Gui.availableProfilesSelectedIndex, 
				AmityMaster_Gui.availableProfiles
			)
		AmityMaster.settings.lastProfileName = AmityMaster_Gui.availableProfiles[AmityMaster_Gui.availableProfilesSelectedIndex]
		ImGui.EndChild()
		
		--Row 2
		
		-- Button for loading the profile. Also sets lastProfileName in settings
		if ImGui.Button("Load", ImVec2(ImGui.GetContentRegionAvailWidth() / 2, 20)) then
			AmityMaster_Gui.LoadSelectedProfile() 
		end
		ImGui.SameLine()
		-- Button for saving profile
		if ImGui.Button("Save", ImVec2(ImGui.GetContentRegionAvailWidth(), 20)) then
			AmityMaster_Gui.SaveSelectedProfile()
		end
		
		if ImGui.Button("Detect profile", ImVec2(ImGui.GetContentRegionAvailWidth(), 20)) then
			local npcName = AmityMaster.GetNpcName()
			local profileFound = false
			for i = 1, #AmityMaster_Gui.availableProfiles do
				if string.gsub(AmityMaster_Gui.availableProfiles[i], "_", " ") == npcName then
					print("Found profile for: " .. tostring(npcName))
					AmityMaster_Gui.availableProfilesSelectedIndex = i
					AmityMaster_Gui.LoadSelectedProfile()
					profileFound = true
					break
				end
			end
			if not profileFound then
			 print("Unable to find profile for: " .. npcName)
			end
		end
		
		if AmityMaster.profile ~= nil then
				
			-- Row 3
			
			-- Collapsing header with info on the currently loaded profile
			if ImGui.CollapsingHeader("Profile information##id_profile_information") then
				
				ImGui.Columns(2, "colums_profile_info")
				
				ImGui.Text("NPC")
				ImGui.NextColumn()
				ImGui.Text(tostring(AmityMaster.profile.npcName))
				ImGui.NextColumn()
				
				ImGui.Text("Required Amity")
				ImGui.NextColumn()
				ImGui.BeginChild(2, ImVec2(ImGui.GetContentRegionAvailWidth() * 1.55,20), false)
				_, AmityMaster.profile.requiredAmity = ImGui.SliderInt("##req_amity", AmityMaster.profile.requiredAmity, 200, 5000)
				ImGui.EndChild()
				ImGui.NextColumn()
				
				--ImGui.Text("Buy item")
				--ImGui.NextColumn()
				--_, AmityMaster.profile.buyItem = ImGui.Checkbox("##buy_item", AmityMaster.profile.buyItem)
				--ImGui.NextColumn()
				
				--ImGui.Text("Item name")
				--ImGui.NextColumn()
				--ImGui.BeginChild(3, ImVec2(ImGui.GetContentRegionAvailWidth() * 1.55,20), false)
				--_, AmityMaster.profile.buyItemName = ImGui.InputText("##item_name", AmityMaster.profile.buyItemName)
				--ImGui.EndChild()
				--ImGui.NextColumn()
				
				--ImGui.Text("Use warehouse")
				--ImGui.NextColumn()
				--_, AmityMaster.profile.useWarehouseMoney = ImGui.Checkbox("##warehouse_funds", AmityMaster.profile.useWarehouseMoney)
				
				ImGui.Columns(1)
				ImGui.Text("")
				ImGui.Columns(2, "columns_combo_info")
				
				ImGui.Text(" -- Win Combo -- ")
				ImGui.NextColumn()
				ImGui.Text(" -- Lose Combo -- ")
				ImGui.NextColumn()
				
				for i = 1, #AmityMaster.profile.win do
					
					ImGui.Text(i .. ". " .. tostring(AmityMaster.profile.win[i]))
					ImGui.NextColumn()
					ImGui.Text(i .. ". " .. tostring(AmityMaster.profile.lose[i]))
					ImGui.NextColumn()
					
				end
				
				ImGui.Columns(1)
				ImGui.Text("")
				
			end
				
			-- Row 4
			
			-- Button that starts AmityMaster
			if ImGui.Button(ternary(AmityMaster.isRunning, "Stop", "Start"), ImVec2(ImGui.GetContentRegionAvailWidth(), 20)) then
				if AmityMaster.isRunning then 
					AmityMaster.Stop("User terminated")
				else 
					AmityMaster.Start()
				end
			end
		
		
		end
		
		-- Row 5
		
		-- CollapsingHeader with advanced settings
		if ImGui.CollapsingHeader("Advanced settings##id_advanced_settings") then
			
			ImGui.Text("Global delay multiplier")
			ImGui.BeginChild(4, ImVec2(ImGui.GetContentRegionAvailWidth() * 1.55,20), false)
			_, AmityMaster.settings.delayMultiplier = ImGui.SliderFloat("##slider_delay_multiplier", AmityMaster.settings.delayMultiplier, 0.5, 8)
			ImGui.EndChild()
			
			if ImGui.Button("Play 1 Conversation", ImVec2(ImGui.GetContentRegionAvailWidth() / 2, 20)) then
				AmityMaster.limitByPlayCount = true
				AmityMaster.requiredPlayCount = 1
				AmityMaster.Start()
			end
			ImGui.SameLine()
			if ImGui.Button("Play 1 SubConversation", ImVec2(ImGui.GetContentRegionAvailWidth(), 20)) then
				AmityMaster.limitBySubPlayCount = true
				AmityMaster.requiredSubPlayCount = 1
				AmityMaster.Start()
			end
			
		end
			
	
	ImGui.End()
	
end 

function AmityMaster_Gui.RefreshAvailableProfiles()

	AmityMaster_Gui.availableProfiles = { }
	for k, v in pairs(Infinity.FileSystem.GetFiles("Profiles\\*.lua")) do
		v = string.gsub(v, ".lua", "")
		table.insert(AmityMaster_Gui.availableProfiles, v)
	end
	
end

function AmityMaster_Gui.SetProfilesSelectedIndexByName(profileName)

	for i = 1, #AmityMaster_Gui.availableProfiles do
		if AmityMaster_Gui.availableProfiles[i] == profileName then
			AmityMaster_Gui.availableProfilesSelectedIndex = i
			AmityMaster_Gui.LoadSelectedProfile()
		end
	end
	
end

function AmityMaster_Gui.LoadSelectedProfile() 

	if 	AmityMaster_Gui.availableProfiles[AmityMaster_Gui.availableProfilesSelectedIndex] ~= nil and 
		AmityMaster_Gui.availableProfiles[AmityMaster_Gui.availableProfilesSelectedIndex] ~= "" then
			AmityMaster.profile = AmityMaster_Loader.GetProfile("Profiles\\" .. AmityMaster_Gui.availableProfiles[AmityMaster_Gui.availableProfilesSelectedIndex] .. ".lua")
			print("Loaded profile: " .. AmityMaster_Gui.availableProfiles[AmityMaster_Gui.availableProfilesSelectedIndex])
	else
		print("No profile selected!")
	end
	
	AmityMaster_Gui.RefreshAvailableProfiles()
	AmityMaster_Gui.ResizeAutoFit()
	
end

function AmityMaster_Gui.SaveSelectedProfile() 

	if 	AmityMaster_Gui.availableProfiles[AmityMaster_Gui.availableProfilesSelectedIndex] ~= nil and 
		AmityMaster_Gui.availableProfiles[AmityMaster_Gui.availableProfilesSelectedIndex] ~= "" then
			AmityMaster_Loader.SaveToJsonFile(AmityMaster.profile, "Profiles\\" .. AmityMaster_Gui.availableProfiles[AmityMaster_Gui.availableProfilesSelectedIndex] .. ".lua")
			print("Saved profile: " .. AmityMaster_Gui.availableProfiles[AmityMaster_Gui.availableProfilesSelectedIndex])
	else
		print("No profile selected!")
	end
	
	AmityMaster_Gui.RefreshAvailableProfiles()
	
end

function AmityMaster_Gui.ResizeAutoFit() 

	--ImGui.SetWindowSize("AmityMaster", ImVec2(375,0))
	
end