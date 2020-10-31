MainWindow = {}
MainWindow.InventoryItemsNames = {}
MainWindow.InventoryItemsItemIds = {}
MainWindow.InventoryItemsItemEnchantKeys = {}
MainWindow.InventoryItemsSlots = {}
MainWindow.InventoryItemsPushableAmounts = {}
MainWindow.InventoryItemSelectedIndex = 1

MainWindow.AvailablesProfiles = {}
MainWindow.Profiles_SelectedIndex = 1
MainWindow.NewProfile_Name = ""
MainWindow.NewProfile_Active = false
MainWindow.NewProfile = nil

local UI = MagLib.UI

function MainWindow.DrawMainWindow()
	local valueChanged = false

	UI.Begin("AutoStorage")

	ImGui.SetWindowSize(ImVec2(500, 500), ImGuiCond_FirstUseEver)

	local btnText = "Start"

	if AutoStorage.Running == true then
		btnText = "Stop"
	end

	if ImGui.Button(btnText) then
		if AutoStorage.Running == true then
			AutoStorage.StopBot()
		else
			AutoStorage.StartBot()
		end
	end

	valueChanged, MainWindow.Profiles_SelectedIndex = ImGui.Combo("Profiles##id_profiles", table.findIndex(
                                                              		MainWindow.AvailablesProfiles,
                                                              		AutoStorage.Settings.LastProfile),
                                                              	MainWindow.AvailablesProfiles)

	if valueChanged then

		AutoStorage.Settings.LastProfile = MainWindow.AvailablesProfiles[MainWindow.Profiles_SelectedIndex]
		print("Profile selected : " .. AutoStorage.Settings.LastProfile)

		local doStart = false

		if AutoStorage.Running then
			doStart = true
		end

		if doStart then
			AutoStorage.StopBot()
		end

		AutoStorage.LoadLastProfile()

		if doStart then
			AutoStorage.StartBot()
		end
	end

	if ImGui.Button("New Profile##new_profile") then

		MainWindow.NewProfile_Active = true
		MainWindow.NewProfile = ProfileSettings()
	end

	if MainWindow.NewProfile_Active then

		_, MainWindow.NewProfile_Name = ImGui.InputText("Name##new_profile_name", MainWindow.NewProfile_Name)

		if ImGui.Button("Save##new_profile_save") then

			if MainWindow.NewProfile_Name ~= "" then

				MainWindow.NewProfile.Name = MainWindow.NewProfile_Name
				AutoStorage.Settings.LastProfile = MainWindow.NewProfile.Name .. ".json"

				AutoStorage.CurrentProfile = MainWindow.NewProfile

				AutoStorage.SaveCurrentProfile()
				AutoStorage.LoadLastProfile()
				MainWindow.RefreshAvailableProfiles()

				MainWindow.NewProfile_Name = ""
				MainWindow.NewProfile = nil
				MainWindow.NewProfile_Active = false

				valueChanged = true
			end
		end
	end

	if AutoStorage.CurrentProfile.Name ~= "" and not MainWindow.NewProfile_Active then
		-- Base settings
		UI.Text("Settings:")
		ImGui.Indent(10)
		AutoStorage.CurrentProfile.forceClearWeightPctThreshold = UI.SliderInt(
                                                          			"Max Acceptable Weight Percent: ##maxAcceptableWeightSlider",
                                                          			AutoStorage.CurrentProfile.forceClearWeightPctThreshold,
                                                          			80, 169, false, nil, nil, 200)

		AutoStorage.CurrentProfile.enableRandomWaits = UI.Checkbox("Enable Waiting Between Operations##random_wait_checkbox",
                                                           		AutoStorage.CurrentProfile.enableRandomWaits)

		if AutoStorage.CurrentProfile.enableRandomWaits then
			UI.Text("Waiting between")
			UI.SameLine()
			AutoStorage.CurrentProfile.minWaitPushingToWarehouse = UI.InputInt("##minWaitInput", AutoStorage.CurrentProfile
                                                                   				.minWaitPushingToWarehouse, 100, 1000, false,
                                                                   			nil, nil, nil, 100)
			UI.SameLine()
			UI.Text(" and")
			UI.SameLine()
			AutoStorage.CurrentProfile.maxWaitPushingToWarehouse = UI.InputInt("##minWaitInput", AutoStorage.CurrentProfile
                                                                   				.maxWaitPushingToWarehouse, 100, 1000, false,
                                                                   			nil, nil, nil, 100)
			UI.SameLine()
			UI.Text(" ms after an operation")

			if AutoStorage.CurrentProfile.minWaitPushingToWarehouse < 100 then
				AutoStorage.CurrentProfile.minWaitPushingToWarehouse = 100
			end

			if AutoStorage.CurrentProfile.maxWaitPushingToWarehouse < AutoStorage.CurrentProfile.minWaitPushingToWarehouse then
				AutoStorage.CurrentProfile.maxWaitPushingToWarehouse = AutoStorage.CurrentProfile.minWaitPushingToWarehouse
			end
		end

		ImGui.Unindent(10)
		-- Items
		UI.Text("Item configuration:")
		ImGui.Indent(10)
		if ImGui.Button("Reload Inventory Items") then
			MainWindow.getInventoryItemsForFilter()
		end

		_, MainWindow.InventoryItemSelectedIndex = ImGui.Combo("Inventory Items##id_inventory_items",
                                                       		MainWindow.InventoryItemSelectedIndex,
                                                       		MainWindow.InventoryItemsNames)

		ImGui.SameLine()

		if ImGui.SmallButton("Add##add_new_item_filter") then

			local key = MainWindow.InventoryItemsItemEnchantKeys[MainWindow.InventoryItemSelectedIndex]

			AutoStorage.CurrentProfile.ItemFilters[tostring(key)] = {
				Name = MainWindow.InventoryItemsNames[MainWindow.InventoryItemSelectedIndex],
				ItemEnchantKey = key,
				MinStack = 1,
				PushableAmount = MainWindow.InventoryItemsPushableAmounts[MainWindow.InventoryItemSelectedIndex],
				Enabled = false
			}

			valueChanged = true

			AutoStorage.SaveCurrentProfile()
			MainWindow.InventoryItemSelectedIndex = 1
			MainWindow.getInventoryItemsForFilter()
		end

		ImGui.Spacing()
		ImGui.Separator()

		ImGui.Columns(5)
		ImGui.SetColumnWidth(0, 55)
		ImGui.SetColumnWidth(1, 175)
		ImGui.SetColumnWidth(2, 90)
		ImGui.SetColumnWidth(3, 175)
		ImGui.SetColumnWidth(4, 50)

		UI.Text("Enabled")
		ImGui.NextColumn()
		UI.Text("Name")
		ImGui.NextColumn()
		UI.Text("Max Pushable")
		ImGui.NextColumn()
		UI.Text("MinStack")
		ImGui.NextColumn()
		UI.Text("")
		ImGui.NextColumn()
		ImGui.Separator()

		for iFilter, filter in pairs(AutoStorage.CurrentProfile.ItemFilters) do

			valueChanged, filter.Enabled = ImGui.Checkbox("##item_filter_enabled_" .. iFilter, filter.Enabled)
			if valueChanged then
				AutoStorage.SaveCurrentProfile()
			end

			ImGui.NextColumn()

			UI.Text(filter.Name)
			ImGui.NextColumn()

			local pushable = filter.PushableAmount
			if pushable ~= nil then
				UI.Text(math.floor(pushable))
			else
				UI.Text("Need item info!", "FFFF0000")
			end

			ImGui.NextColumn()

			ImGui.PushItemWidth(165)
			valueChanged, filter.MinStack = ImGui.SliderInt("##item_filter_minstack_" .. iFilter, filter.MinStack, 1, 1000)
			ImGui.PopItemWidth()
			if valueChanged then
				AutoStorage.SaveCurrentProfile()
			end

			ImGui.NextColumn()

			if ImGui.SmallButton("X##item_filter_delete_" .. iFilter) then
				AutoStorage.CurrentProfile.ItemFilters[tostring(iFilter.ItemEnchantKey)] = nil

				valueChanged = true
				AutoStorage.SaveCurrentProfile()
				break
			end

			ImGui.NextColumn()
		end

		ImGui.Columns(1)
		ImGui.Unindent(10)
	end

	UI.End()

	if valueChanged then
		AutoStorage.SaveSettings()
	end
end

function MainWindow.getInventoryItemsForFilter()
	local invenMaxSize = Inventory.getMaxSize()

	if invenMaxSize == 0 then
		return
	end

	local itemTableNames = {}
	local itemTableIds = {}
	local itemTableEnchantKeys = {}
	local itemTableSlots = {}
	local itemTablePushableAmounts = {}

	for i = 0, invenMaxSize - 1 do
		if Inventory.hasItemWrapper(i) then
			local name
			local itemId
			local count
			local enchantKey
			local singleItemWeight

			name, itemId, count, enchantKey, singleItemWeight = Inventory.getItemData(i)
			if (singleItemWeight == 0.0) then
				-- Prevent division by 0 and set max to 1000
				singleItemWeight = 0.1
			end

			local enchantLevel = Utils.getEnchantLevel(enchantKey)
			if name ~= nil and itemId ~= nil then
				if table.find(itemTableEnchantKeys, enchantKey) == nil and AutoStorage.getFilter(enchantKey) == nil then

					if (enchantLevel > 0) then
						name = name .. " +" .. enchantLevel
					end
					table.insert(itemTableNames, name)
					table.insert(itemTableIds, itemId)
					table.insert(itemTableEnchantKeys, enchantKey)
					table.insert(itemTableSlots, i)
					table.insert(itemTablePushableAmounts, 100 / singleItemWeight)
				end
			end
		end
	end

	MainWindow.InventoryItemsNames = itemTableNames
	MainWindow.InventoryItemsItemIds = itemTableIds
	MainWindow.InventoryItemsItemEnchantKeys = itemTableEnchantKeys
	MainWindow.InventoryItemsSlots = itemTableSlots
	MainWindow.InventoryItemsPushableAmounts = itemTablePushableAmounts
end

function MainWindow.RefreshAvailableProfiles()
	MainWindow.AvailablesProfiles = {}

	for k, v in pairs(Infinity.FileSystem.GetFiles("Profiles\\*.json")) do
		table.insert(MainWindow.AvailablesProfiles, v)

	end
end

MainWindow.RefreshAvailableProfiles()
