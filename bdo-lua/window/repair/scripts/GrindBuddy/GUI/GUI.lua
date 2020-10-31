GUI = {}

GUI.navTestDest = Vector3(0, 0, 0)

GUI.renderOnce = false
GUI.renderChannelUI = false

local logoImage = Infinity.Rendering.LoadTextureFromImageFile(
                  	Infinity.Scripting.CurrentScript.Directory .. "Images\\Logo.png")
local redColor = RenderHelper.GetColorImVec4FromHexColorString("FFFF0000")

local selected = true

local currentTab = 0

local UI = MagLib.UI

function GUI.renderNewUI()
	MagLib.UI.newWindow("[GrindBuddy] " .. Grinder.version.BUILD_INFORMATION, nil, ImGuiWindowFlags_MenuBar)
	-- ImGui.Begin("[GrindBuddy] " .. Grinder.version.BUILD_INFORMATION, nil, ImGuiWindowFlags_MenuBar)
	ImGui.SetWindowSize(ImVec2(450, 600))

	if ImGui.BeginMenuBar() then
		if ImGui.BeginMenu("Home##home_menue", true) then
			currentTab = 0
			ImGui.EndMenu()
		end
		--[[if ImGui.BeginMenu("Profile Editor##profileEditor_menue", true) then
            currentTab = 1
            ImGui.EndMenu()
        end]]
		if ImGui.BeginMenu("Townruns##townruns_menue", true) then
			currentTab = 2
			ImGui.EndMenu()
		end
		if ImGui.BeginMenu("Grinder##grinder_menue", true) then
			currentTab = 3
			ImGui.EndMenu()
		end
		if ImGui.BeginMenu("Advanced##advanced_menue", true) then
			currentTab = 4
			ImGui.EndMenu()
		end
		if ImGui.BeginMenu("Render##render_menue", true) then
			currentTab = 5
			ImGui.EndMenu()
		end
		if ImGui.BeginMenu("Security##security_menue", true) then
			currentTab = 6
			ImGui.EndMenu()
		end
		ImGui.EndMenuBar()
	end

	ImGui.Image(logoImage, ImVec2(450, 150), ImVec2(0, 0), ImVec2(1, 1), ImVec4(1, 1, 1, 1), ImVec4(0, 0, 0, 0))

	-- Draw the current tab
	if currentTab == 0 then
		GUI.drawMain()
	elseif currentTab == 1 then
		ProfileEditor.draw(false)
	elseif currentTab == 2 then
		GUI.drawTownruns()
	elseif currentTab == 3 then
		GrinderUI.draw(false)
	elseif currentTab == 4 then
		AdvancedUI.draw(false)
	elseif currentTab == 5 then
		RenderUI.draw(false)
	elseif currentTab == 6 then
		SecurityUI.draw()
	end

	MagLib.UI.endWindow()
	-- ImGui.End()

	if Grinder.settings.show_debug_ui then
		DebugUI.draw(true)
	end

	if GUI.renderChannelUI then
		MagLib.UI.newWindow("[GrindBuddy] Channel Swap Settings")
		ChannelUI.draw()
		MagLib.UI.endWindow()
	end
end

function GUI.drawMain()
	if Grinder.is_started == true then
		if ImGui.Button("Stop##bot_start_button", ImVec2(60, 30)) then
			Grinder.stopBot()
		end
	else
		if ImGui.Button("Start##bot_start_button", ImVec2(60, 30)) then
			if Grinder.currentProfile then
				Grinder.startBot()
			else
				Log.log("Please select a profile first!")
			end
		end
	end

	ImGui.SameLine()
	ImGui.Text("                                                                                                        ")
	ImGui.SameLine()
	if ImGui.Button("Exit##exit_bot", ImVec2(60, 30)) then
		local thisScript = Infinity.Scripting.CurrentScript
		thisScript:Stop()
	end

	UI.Separator()
	MagLib.UI.Settings.SettingsProfileSelector(true)

	GUI.renderExpStats()
	-- GUI.renderStoppedUi()

	ImGui.Text("Profile: ")
	ImGui.SameLine()
	if Grinder.availableProfiles == nil or #Grinder.availableProfiles == 0 then
		Grinder.getPossibleProfiles()
	end

	_, GUI.selectedProfileIndex = ImGui.Combo("", GUI.selectedProfileIndex, Grinder.availableProfiles)

	if Grinder.availableProfiles[GUI.selectedProfileIndex] == "New profile..." then
		GUI.renderProfileNameUi()
	elseif Grinder.availableProfiles[GUI.selectedProfileIndex] ~= nil and
		Grinder.availableProfiles[GUI.selectedProfileIndex] ~= "" then
		if ImGui.SmallButton("Save current Profile!##btn_save_profile") then
			Profile.saveProfile(Grinder.currentProfile)
		end
	end

	ImGui.Separator()

	GUI.renderCombatScriptCombo()

	if Grinder.currentProfile then
		ImGui.Separator()
		ProfileEditor.draw(false)
	end
end

local townRunTab = 0

function GUI.drawTownruns()
	if ImGui.Button("Force Repair ##forceRepair", ImVec2(80, 30)) then
		Grinder.forceTownRun = true
		Grinder.forceRepair = true
	end
	ImGui.SameLine()
	if ImGui.Button("Force Storage##forceWarehousing", ImVec2(80, 30)) then
		Grinder.forceTownRun = true
		Grinder.forceStorage = true
	end
	ImGui.SameLine()
	if ImGui.Button("Force Restock##forceRestock", ImVec2(80, 30)) then
		Grinder.forceTownRun = true
		Grinder.forcePotionBuy = true
	end
	ImGui.SameLine()
	if ImGui.Button("Force Selling##forceSell", ImVec2(80, 30)) then
		Grinder.forceTownRun = true
		Grinder.forceSell = true
	end
	ImGui.SameLine()
	if ImGui.Button("Force Market##forceSell", ImVec2(80, 30)) then
		Grinder.forceTownRun = true
		Grinder.forceMarketplace = true
	end

	ImGui.Separator()
	--[[ImGui.Text("Tent Pos: " .. VectorUtils.toString(Grinder.settings.tent_pos))

    if ImGui.Button("Set Tent Position##set_tent_pos") then
        local pPos = Cache.playerPos
        Grinder.settings.tent_pos = {X = pPos.X, Y = pPos.Y, Z = pPos.Z}
    end
    ImGui.SameLine()
    if ImGui.Button("Reset##reset_tent_pos") then
        Grinder.settings.tent_pos = nil
    end]]
	_, Grinder.settings.doRepairRuns = ImGui.Checkbox("Repair Equipment##repair_eq", Grinder.settings.doRepairRuns)

	_, Grinder.settings.doMarketplace = ImGui.Checkbox("Deposit at Marketplace##do_Marketplace",
                                                   	Grinder.settings.doMarketplace)
	if Grinder.settings.doMarketplace then
		ImGui.Text("The bot will use AutoSell, so please configure it before!")
	end
	ImGui.Separator()

	ImGui.Text("Silver to keep in Inventory")
	ImGui.SameLine()
	ImGui.PushItemWidth(220)
	_, Grinder.settings.keep_silver_amount = ImGui.InputInt("##keep_silver_amount", Grinder.settings.keep_silver_amount)
	ImGui.PopItemWidth()

	_, Grinder.settings.use_Inventory_Money = ImGui.Checkbox("Use Inventory Money##useInventoryMoney",
                                                         	Grinder.settings.use_Inventory_Money)

	ImGui.Separator()

	if (ImGui.Button("[Warehousing]", ImVec2(100, 33))) then
		townRunTab = 1
	end
	ImGui.SameLine()

	if (ImGui.Button("[Restock]", ImVec2(100, 33))) then
		townRunTab = 2
	end
	ImGui.SameLine()

	if (ImGui.Button("[Sell Items]", ImVec2(100, 33))) then
		townRunTab = 3
	end

	ImGui.Separator()

	if townRunTab == 1 then
		WarehouseUI.draw(false)
	elseif townRunTab == 2 then
		BuyPotionsUI.draw(false)
	elseif townRunTab == 3 then
		SellingUI.draw(false)
	end
end

function GUI.draw()
	-- ImGui.PushStyleVar1(ImGuiStyleVar_WindowRounding, 10)
	if not GUI.renderedOnce then
		-- GUI.renderedOnce = true
		GUI.renderNewUI()
	end
end

function GUI.renderStartedUi()
end

GUI.pendingNewProfileName = ""
GUI.selectedProfileIndex = -1

function GUI.renderProfileNameUi()
	ImGui.Text("Profile Name: ")
	ImGui.SameLine()
	local _
	_, GUI.pendingNewProfileName = ImGui.InputText("##profileName", GUI.pendingNewProfileName)
	ImGui.Spacing()
	if ImGui.SmallButton("Create Profile") then
		if table.find(Grinder.availableProfiles, GUI.pendingNewProfileName) ~= nil then
			Log.log("There is already a profile with this name!")
		else
			-- Log.log("Creating new profile with name: " .. GUI.pendingNewProfileName)
			Grinder.currentProfile = Profile.newProfile(GUI.pendingNewProfileName)
			Profile.saveProfile(Grinder.currentProfile)
			-- Profile.loadProfile(GUI.pendingNewProfileName)
			Grinder.getPossibleProfiles()
			GUI.selectedProfileIndex = table.find(Grinder.availableProfiles, GUI.pendingNewProfileName)
			GUI.pendingNewProfileName = ""
		end
	end
end

GUI.selectedCSIndex = -1

function GUI.renderCombatScriptCombo()
	ImGui.Spacing()
	if Grinder.availableCombatScripts == nil or #Grinder.availableCombatScripts == 0 then
		Grinder.getPossibleCombatScripts()
	end

	ImGui.Text("Combatscript: ")
	ImGui.SameLine()
	local csSelected
	csSelected, GUI.selectedCSIndex = ImGui.Combo("##combaScriptName", GUI.selectedCSIndex, Grinder.availableCombatScripts)

	if csSelected then
		Grinder.loadCombatScript(GUI.selectedCSIndex)
	end
end

function GUI.renderStoppedUi()
	ImGui.Text("Profile: ")
	ImGui.SameLine()
	if Grinder.availableProfiles == nil or #Grinder.availableProfiles == 0 then
		Grinder.getPossibleProfiles()
	end

	_, GUI.selectedProfileIndex = ImGui.Combo("", GUI.selectedProfileIndex, Grinder.availableProfiles)

	if Grinder.availableProfiles[GUI.selectedProfileIndex] == "New profile..." then
		GUI.renderProfileNameUi()
	elseif Grinder.availableProfiles[GUI.selectedProfileIndex] ~= nil and
		Grinder.availableProfiles[GUI.selectedProfileIndex] ~= "" then
		if ImGui.SmallButton("Save current Profile!##btn_save_profile") then
			Profile.saveProfile(Grinder.availableProfiles[GUI.selectedProfileIndex])
		end
	end

	ImGui.Separator()

	GUI.renderCombatScriptCombo()

	ImGui.Separator()

	if ImGui.TreeNode("Townruns") then
		ImGui.BeginGroup()

		ImGui.Text("Tent Pos: " .. VectorUtils.toString(Grinder.settings.tent_pos))

		if ImGui.Button("Set Tent Position##set_tent_pos") then
			local pPos = Cache.playerPos
			Grinder.settings.tent_pos = {X = pPos.X, Y = pPos.Y, Z = pPos.Z}
		end
		ImGui.SameLine()
		if ImGui.Button("Reset##reset_tent_pos") then
			Grinder.settings.tent_pos = nil
		end

		_, Grinder.settings.doRepairRuns = ImGui.Checkbox("Repair Equipment", Grinder.settings.doRepairRuns)
		ImGui.SameLine()
		if ImGui.Button("Force##forceRepair") then
			Grinder.forceTownRun = true
			Grinder.forceRepair = true
		end

		if (ImGui.Checkbox("Town: [Warehousing]", Grinder.settings.show_warehouse_options)) then
			Grinder.settings.show_warehouse_options = not Grinder.settings.show_warehouse_options
		end
		ImGui.SameLine()
		if ImGui.Button("Force##forceWarehousing") then
			Grinder.forceTownRun = true
			Grinder.forceStorage = true
		end

		if (ImGui.Checkbox("Town: [Restock]", Grinder.settings.show_general_goods_options)) then
			Grinder.settings.show_general_goods_options = not Grinder.settings.show_general_goods_options
		end
		ImGui.SameLine()
		if ImGui.Button("Force##forceRestock") then
			Grinder.forceTownRun = true
			Grinder.forcePotionBuy = true
		end

		if (ImGui.Checkbox("Town: [Sell Items]", Grinder.settings.show_sell_options)) then
			Grinder.settings.show_sell_options = not Grinder.settings.show_sell_options
		end
		ImGui.SameLine()
		if ImGui.Button("Force##forceSell") then
			Grinder.forceTownRun = true
			Grinder.forceSell = true
		end

		ImGui.EndGroup()
		ImGui.TreePop()
	end

	if ImGui.Checkbox("Profile: [Editor]", Grinder.settings.show_profile_editor_ui) then
		Grinder.settings.show_profile_editor_ui = not Grinder.settings.show_profile_editor_ui
	end

	if ImGui.Checkbox("Other: [Grinder Settings]", Grinder.settings.show_grinder_ui) then
		Grinder.settings.show_grinder_ui = not Grinder.settings.show_grinder_ui
	end

	if ImGui.Checkbox("Other: [Render Settings]", Grinder.settings.show_render_ui) then
		Grinder.settings.show_render_ui = not Grinder.settings.show_render_ui
	end

	if ImGui.Checkbox("Other: [Advanced Settings]", Grinder.settings.show_advanced_ui) then
		Grinder.settings.show_advanced_ui = not Grinder.settings.show_advanced_ui
	end
end

function GUI.renderExpStats()
	ImGui.Separator()
	_, Grinder.settings.track_exp = ImGui.Checkbox("Track EXP##exp_tracker", Grinder.settings.track_exp)
	if Grinder.settings.track_exp then
		ImGui.Text("EXP Stats:")
		ImGui.SameLine()
		if Cache.percentPerHour > 10 then
			ImGui.Text(Cache.percentPerHour .. "%%/hr")
		else
			ImGui.Text(Cache.percentPerMinute .. "%%/min")
		end

		if Cache.hrUntilLevelup < 1 then
			ImGui.Text(Cache.minUntilLevelup .. " minutes until next levelup!")
		else
			ImGui.Text(Cache.hrUntilLevelup .. " hours until next levelup!")
		end

		ImGui.SameLine()
		if ImGui.Button("Reset Statistics") then
			Cache.updateExpData()
		end
	end

	ImGui.Separator()
end
