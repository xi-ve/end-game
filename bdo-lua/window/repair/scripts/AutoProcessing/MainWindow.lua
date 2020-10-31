MainWindow = {}
MainWindow.ManufactureActions = {
	"MANUFACTURE_SHAKE", "MANUFACTURE_GRIND", "MANUFACTURE_FIREWOOD", "MANUFACTURE_DRY", "MANUFACTURE_THINNING",
 "MANUFACTURE_HEAT", "MANUFACTURE_RAINWATER", "REPAIR_ITEM", "MANUFACTURE_ALCHEMY", "MANUFACTURE_COOK",
 "MANUFACTURE_ROYALGIFT_COOK", "MANUFACTURE_ROYALGIFT_ALCHEMY", "MANUFACTURE_GUILD", "MANUFACTURE_CRAFT"
}
MainWindow.ManufactureActions_SelectedIndex = 1
MainWindow.InventoryItemsNames = {}
MainWindow.InventoryItemsItemIds = {}
MainWindow.InventoryItemsSlots = {}

local NewRecipe_List = {}
local NewRecipe_Material_SelectedIndex = 1
local NewRecipe_Material_MinCount = 5

local MoveToWarehouse_SelectedIndex = 1

local UI = MagLib.UI

function MainWindow.DrawMainWindow()
	local valueChanged = false

	ImGui.Begin("AutoProcessing")

	ImGui.SetWindowSize(ImVec2(500, 500), ImGuiCond_FirstUseEver)

	local btnText = "Start"

	if AutoProcessing.Running == true then
		btnText = "Stop"
	end

	if ImGui.Button(btnText) then
		if AutoProcessing.Running == true then
			AutoProcessing.StopBot()
		else
			AutoProcessing.StartBot()
		end
	end

	if AutoProcessing.Running == true then
		ImGui.SameLine()
		local currentAction = Infinity.BDO.getLocalPlayer():getCharacterControler():getCurrentAnimation():getName()
		if currentAction == "WAIT" or currentAction == "WAIT2" then
			UI.Text("Sometimes you need to wiggle a bit left/right until it starts to work!", "FFFF0000")
		end
	end

	local hUptime = ((AutoProcessing.UpTime / 1000) / (60 * 60))

	ImGui.Text(string.format("UpTime:  %02.f:%02.f:%02.f", math.floor(hUptime),
                         	math.floor((AutoProcessing.UpTime / 1000) / 60) % 60, (AutoProcessing.UpTime / 1000) % 60))

	local weightPct = LocalPlayer.getWeightPercent()
	if weightPct >= 80 then
		UI.Text(
			"Please start with less than 80%% Weight \n and enough weight for the materials to ensure that there are no issues!",
			"FFFF0000")
	end

	if ImGui.CollapsingHeader("MoveToWarehouse##id_movetowarehouse") then

		MainWindow.getInventoryItemsForFilter()

		if ImGui.Button("Add To Filter##id_addfilter_movetowarehouse") then
			table.insert(AutoProcessing.Settings.MoveToWarehouse, {
				ItemId = MainWindow.InventoryItemsItemIds[MoveToWarehouse_SelectedIndex],
				Name = MainWindow.InventoryItemsNames[MoveToWarehouse_SelectedIndex]
			})

			MoveToWarehouse_SelectedIndex = 1
			valueChanged = true
		end

		_, MoveToWarehouse_SelectedIndex = ImGui.Combo("Inventory Items##id_inventory_items_movetowarehouse",
                                               		MoveToWarehouse_SelectedIndex, MainWindow.InventoryItemsNames)

		ImGui.Columns(3)
		ImGui.Text("")
		ImGui.NextColumn()
		ImGui.Text("ItemId")
		ImGui.NextColumn()
		ImGui.Text("Name")
		ImGui.NextColumn()

		for k, v in pairs(AutoProcessing.Settings.MoveToWarehouse) do

			if ImGui.Button("X##inventory_filter_movetowarehouse_remove_" .. k) then
				table.remove(AutoProcessing.Settings.MoveToWarehouse, k)

				valueChanged = true
				break
			end

			ImGui.NextColumn()
			ImGui.Text(v.ItemId)
			ImGui.NextColumn()
			ImGui.Text(v.Name)
			ImGui.NextColumn()
		end

		ImGui.Columns(1)
	end

	if ImGui.CollapsingHeader("Recipes##id_recipes") then

		if ImGui.CollapsingHeader("New Recipe##id_new_recipe") then

			MainWindow.getInventoryItemsForFilter()

			if ImGui.Button("Create Recipe##id_create_recipe") then
				table.insert(AutoProcessing.Settings.Recipes, {
					Enabled = true,
					Materials = NewRecipe_List,
					Action = MainWindow.ManufactureActions[MainWindow.ManufactureActions_SelectedIndex]
				})

				NewRecipe_List = {}
				MainWindow.ManufactureActions_SelectedIndex = 1

				valueChanged = true
			end

			ImGui.Spacing()
			ImGui.Spacing()
			ImGui.Spacing()

			if ImGui.Button("Add To Filter##id_addfilter_items") then
				table.insert(NewRecipe_List, {
					ItemId = MainWindow.InventoryItemsItemIds[NewRecipe_Material_SelectedIndex],
					Name = MainWindow.InventoryItemsNames[NewRecipe_Material_SelectedIndex],
					MinCount = NewRecipe_Material_MinCount
				})

				NewRecipe_Material_SelectedIndex = 1
				NewRecipe_Material_MinCount = 5
			end

			_, NewRecipe_Material_SelectedIndex = ImGui.Combo("Inventory Items##id_inventory_items",
                                                  			NewRecipe_Material_SelectedIndex, MainWindow.InventoryItemsNames)
			_, MainWindow.ManufactureActions_SelectedIndex = ImGui.Combo("Action##id_manufacture_action",
                                                             			MainWindow.ManufactureActions_SelectedIndex,
                                                             			MainWindow.ManufactureActions)

			_, NewRecipe_Material_MinCount = ImGui.InputInt("Min Count##items_input_mincount", NewRecipe_Material_MinCount, 0, 0,
                                                			0)

			ImGui.Columns(4)
			ImGui.Text("")
			ImGui.NextColumn()
			ImGui.Text("ItemId")
			ImGui.NextColumn()
			ImGui.Text("Name")
			ImGui.NextColumn()
			ImGui.Text("MinCount")
			ImGui.NextColumn()

			for k, v in pairs(NewRecipe_List) do

				if ImGui.SmallButton("X##inventory_filter_remove_" .. k) then
					table.remove(NewRecipe_List, k)

					break
				end

				ImGui.NextColumn()
				ImGui.Text(v.ItemId)
				ImGui.NextColumn()
				ImGui.Text(v.Name)
				ImGui.NextColumn()
				ImGui.Text(v.MinCount)
				ImGui.NextColumn()
			end

			ImGui.Columns(1)
		end

		if ImGui.CollapsingHeader("Owned Recipe##id_owned_recipes") then

			ImGui.Columns(4)
			ImGui.Text("")
			ImGui.NextColumn()
			ImGui.Text("Action")
			ImGui.NextColumn()
			ImGui.Text("Recipe")
			ImGui.NextColumn()
			ImGui.Text("")
			ImGui.NextColumn()

			for k, v in pairs(AutoProcessing.Settings.Recipes) do

				if v.Enabled == nil then
					v.Enabled = true
					valueChanged = true
				end

				valueChanged, v.Enabled = ImGui.Checkbox("##recipe_enabled_" .. k, v.Enabled)

				ImGui.NextColumn()
				ImGui.Text(v.Action)
				ImGui.NextColumn()
				ImGui.Text(MainWindow.tableToString(v.Materials))
				ImGui.NextColumn()

				if ImGui.SmallButton("X##recipe_filter_remove_" .. k) then
					table.remove(AutoProcessing.Settings.Recipes, k)

					valueChanged = true
					break
				end

				ImGui.NextColumn()
			end

			ImGui.Columns(1)
		end
	end

	if valueChanged == true then
		AutoProcessing.SaveSettings()
	end

	ImGui.End()
end

function MainWindow.getInventoryItemsForFilter()
	local invenMaxSize = Inventory.getMaxSize()

	if invenMaxSize == 0 then
		return
	end

	local itemTableNames = {}
	local itemTableIds = {}
	local itemTableSlots = {}

	for i = 2, invenMaxSize - 1 do
		if Inventory.hasItemWrapper(i) then
			local name
			local itemId
			local count

			name, itemId, count = Inventory.getItemData(i)

			if name ~= nil and itemId ~= nil then
				if table.find(itemTableIds, itemId) == nil then
					table.insert(itemTableNames, name)
					table.insert(itemTableIds, itemId)
					table.insert(itemTableSlots, i)
				end
			end
		end
	end

	MainWindow.InventoryItemsNames = itemTableNames
	MainWindow.InventoryItemsItemIds = itemTableIds
	MainWindow.InventoryItemsSlots = itemTableSlots
end

function MainWindow.tableToString(table)
	local s = ""

	for k, v in pairs(table) do
		if s:len() == 0 then
			s = v.Name .. "(" .. v.MinCount .. ")"
		else
			s = s .. " + " .. v.Name .. "(" .. v.MinCount .. ")"
		end
	end

	return s
end
