MainWindow = {}
MainWindow.InventoryItemsNames = {}
MainWindow.InventoryItemsItemIds = {}
MainWindow.InventoryItemsItemEnchantKeys = {}
MainWindow.InventoryItemsSlots = {}

MainWindow.InventoryItemSelectedIndex = 1

MainWindow.InputItemId = 0

MainWindow.AvailablesProfiles = {}
MainWindow.Profiles_SelectedIndex = 1
MainWindow.NewProfile_Name = ""
MainWindow.NewProfile_Active = false
MainWindow.NewProfile = nil

local UI = MagLib.UI

function MainWindow.DrawMainWindow()
	local valueChanged = false

	ImGui.Begin("AutoSell")

	ImGui.SetWindowSize(ImVec2(500, 500), ImGuiCond_FirstUseEver)

	local btnText = "Start"

	if AutoSell.Running == true then
		btnText = "Stop "
	end

	if ImGui.Button(btnText) then
		if AutoSell.Running == true then
			AutoSell.StopBot()
		else
			AutoSell.StartBot()
		end
	end

	local total_w = ImGui.GetContentRegionAvail().x - 260
	ImGui.SameLine(total_w)
	ImGui.PushItemWidth(total_w)
	valueChanged, AutoSell.Settings.RenderNpcs =
		ImGui.Checkbox("Render Npcs##id_render_npcs", AutoSell.Settings.RenderNpcs)
	ImGui.SameLine()
	valueChanged, AutoSell.Settings.MoneyCollect.Enabled = ImGui.Checkbox("Collect Sales Money##id_collect_sales_money",
                                                                      	AutoSell.Settings.MoneyCollect.Enabled)

	if ImGui.CollapsingHeader("Inventory##id_inventory") then

		valueChanged, MainWindow.Profiles_SelectedIndex = ImGui.Combo("Profiles##id_profiles", table.findIndex(
                                                              			MainWindow.AvailablesProfiles,
                                                              			AutoSell.Settings.LastProfile),
                                                              		MainWindow.AvailablesProfiles)

		if valueChanged then

			AutoSell.Settings.LastProfile = MainWindow.AvailablesProfiles[MainWindow.Profiles_SelectedIndex]
			print("Profile selected : " .. AutoSell.Settings.LastProfile)

			local doStart = false

			if AutoSell.Running then
				doStart = true
			end

			if doStart then
				AutoSell.StopBot()
			end

			AutoSell.LoadLastProfile()

			if doStart then
				AutoSell.StartBot()
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
					AutoSell.Settings.LastProfile = MainWindow.NewProfile.Name .. ".json"

					AutoSell.CurrentProfile = MainWindow.NewProfile

					AutoSell.SaveCurrentProfile()
					AutoSell.LoadLastProfile()
					MainWindow.RefreshAvailableProfiles()

					MainWindow.NewProfile_Name = ""
					MainWindow.NewProfile = nil
					MainWindow.NewProfile_Active = false

					valueChanged = true
				end
			end
		end

		ImGui.Spacing()

		if AutoSell.CurrentProfile.Name ~= "" and not MainWindow.NewProfile_Active then

			if ImGui.Button("Add To Filter##id_addfilter") then
				local canAdd = true

				for k, v in pairs(AutoSell.CurrentProfile.Inventory.Items) do
					if v.ItemEnchantKey == MainWindow.InventoryItemsItemEnchantKeys[MainWindow.InventoryItemSelectedIndex] then
						canAdd = false
						break
					end
				end

				if canAdd then
					table.insert(AutoSell.CurrentProfile.Inventory.Items, {
						Name = MainWindow.InventoryItemsNames[MainWindow.InventoryItemSelectedIndex],
						ItemId = MainWindow.InventoryItemsItemIds[MainWindow.InventoryItemSelectedIndex],
						ItemEnchantKey = MainWindow.InventoryItemsItemEnchantKeys[MainWindow.InventoryItemSelectedIndex],
						MinPrice = false,
						MaxPrice = false,
						RecentPrice = true,
						CustomPrice = false,
						CustomPriceValue = 0,
						Enabled = false
					})

					AutoSell.SaveCurrentProfile()
					valueChanged = true
					AutoSell.updateInventoryItemsForFilter()
				end
			end
			__, MainWindow.InventoryItemSelectedIndex = ImGui.Combo("Inventory Items##id_inventory_items",
                                                        			MainWindow.InventoryItemSelectedIndex,
                                                        			MainWindow.InventoryItemsNames)

			ImGui.Spacing()

			ImGui.Text("Item Filters:")
			ImGui.Indent(5)
			ImGui.Spacing()

			ImGui.Columns(7)
			ImGui.SetColumnWidth(0, 60)
			ImGui.SetColumnWidth(1, 50)
			ImGui.SetColumnWidth(2, 75)
			ImGui.SetColumnWidth(3, 150)
			ImGui.SetColumnWidth(4, 150)
			ImGui.SetColumnWidth(5, 130)
			ImGui.SetColumnWidth(6, 50)

			ImGui.Text("Enabled")
			ImGui.NextColumn()
			ImGui.Text("ItemId")
			ImGui.NextColumn()
			ImGui.Text("EnchantKey")
			ImGui.NextColumn()
			ImGui.Text("Name")
			ImGui.NextColumn()
			ImGui.Text("Custom Price")
			ImGui.NextColumn()
			ImGui.Text("Min TransferStack")
			ImGui.NextColumn()
			ImGui.Text("")
			ImGui.NextColumn()

			for k, v in pairs(AutoSell.CurrentProfile.Inventory.Items) do
				v.Enabled = UI.Checkbox("##enable_checkbox_" .. k, v.Enabled)
				ImGui.NextColumn()
				ImGui.Text(v.ItemId)
				ImGui.NextColumn()
				ImGui.Text(v.ItemEnchantKey)
				ImGui.NextColumn()
				ImGui.Text(v.Name)
				ImGui.NextColumn()

				local customPriceValueChanged = false
				customPriceValueChanged, v.CustomPriceValue = ImGui.InputInt("##inventory_item_filter_custompricevalue_" .. k,
                                                             				v.CustomPriceValue, 0, 0, 0)

				if customPriceValueChanged then

					AutoSell.SaveCurrentProfile()
					valueChanged = true
				end

				local minStack = v.MinStack

				if minStack == nil then
					minStack = 0
					v.MinStack = 0

					AutoSell.SaveCurrentProfile()
					valueChanged = true
				end

				ImGui.NextColumn()
				local slidertxt = minStack
				if minStack == 0 then
					slidertxt = "auto"
				else
					slidertxt = v.MinStack
				end

				valueChanged, v.MinStack = ImGui.SliderInt("##item_filter_minstack_" .. k, v.MinStack, 0, 1000, slidertxt)

				if valueChanged then
					AutoSell.SaveCurrentProfile()
				end

				ImGui.NextColumn()

				if ImGui.Button("X##inventory_filter_remove_" .. k) then
					table.remove(AutoSell.CurrentProfile.Inventory.Items, k)

					AutoSell.SaveCurrentProfile()
					AutoSell.updateInventoryItemsForFilter()
					valueChanged = true
					break
				end

				ImGui.NextColumn()
			end
			ImGui.Unindent(5)
		end
	end

	if valueChanged == true then

		AutoSell.SaveSettings()
	end

	ImGui.End()
end

function MainWindow.RefreshAvailableProfiles()
	MainWindow.AvailablesProfiles = {}

	for k, v in pairs(Infinity.FileSystem.GetFiles("Profiles\\*.json")) do
		table.insert(MainWindow.AvailablesProfiles, v)

	end
end

MainWindow.RefreshAvailableProfiles()
