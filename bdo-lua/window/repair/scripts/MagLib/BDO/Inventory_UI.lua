local InventoryUI = {}
local UI = MagLib.UI

-- Draws a widget where you can add and remove items from the table

-- An element in the item table consists of name, itemKey and the table must be without holes
local selectedNames = {}

InventoryUI.drawItemTableSelector = function(text, internalName, itemTable, sortType, allowAddUnknown)
	local tableChanged = false

	if sortType == nil then
		sortType = 0
	end

	UI.Text(text)
	-- Add Combobox
	local names, itemDatas = MagLib.BDO.Inventory.getInventoryForCombobox()

	-- Remove entries already in itemTable
	local toRemoveIndexes = {}
	for index, itemData in ipairs(itemDatas) do
		for _, itemData_InTable in ipairs(itemTable) do
			if itemData_InTable.itemKey == itemData.itemKey then
				table.insert(toRemoveIndexes, index)
			end
		end
	end

	local toRemoveIndexesLength = #toRemoveIndexes
	if toRemoveIndexesLength > 0 then
		for i = toRemoveIndexesLength, 1, -1 do
			local index = toRemoveIndexes[i]
			table.remove(names, index)
			table.remove(itemDatas, index)
		end
	end

	local selectedName = selectedNames[internalName]
	local selectedIndex = table.find(names, selectedName)
	if selectedIndex == nil then
		selectedIndex = -1
	end

	selectedIndex = UI.Combo("Add Item:##_" .. internalName, selectedIndex, names, false, function(newIndex)
		selectedNames[internalName] = names[newIndex]
	end)
	ImGui.SameLine()
	UI.Button("Add##_a_" .. internalName, function()
		if not selectedIndex then
			return
		end
		local itemData = itemDatas[selectedIndex]
		if not itemData then
			return
		end
		table.insert(itemTable, {name = itemData.name, itemKey = itemData.itemKey})
		MagLib.BDO.Inventory.sortInventoryTable(itemTable, sortType)
		tableChanged = true
	end)

	-- Adding items not in inventory/unknown
	if allowAddUnknown then
		ImGui.SameLine()
		local popupDraw = function(self)
			if not self.inited then
				self.inited = true
				self.name = ""
				self.itemKey = 0
				self.enhanceLevel = 0
				self.itemEnchantKeyRaw = 0
			end

			self.name = UI.InputText("Item Name: ##item_popup_name_" .. self.index, self.name, true)
			self.itemKey = UI.InputInt("Item Key/Id: ##item_popup_itemKey_" .. self.index, self.itemKey, 0, 0, true)

			UI.Button("Add##item_popup_add_" .. self.index, function()
				table.insert(itemTable, {name = self.name, itemKey = self.itemKey})
				self:close()
			end)
			ImGui.SameLine()
			ImGui.Spacing(5)
			UI.Button("Close##item_popup_close_" .. self.index, function()
				self:close()
			end)
		end
		UI.Button("Add other item##item_add_another_item_" .. internalName, function()
			MagLib.UI.Popups.new("Please define the item you want to add!", popupDraw, 1 / 0)
		end)
	end

	-- Table representation with delete buttons
	--[[
  ImGui.Columns(3)
  ImGui.SetColumnWidth(0, 60)
  ImGui.SetColumnWidth(1, 305)
  ImGui.SetColumnWidth(2, 85)
  ImGui.Text("Key")
  ImGui.NextColumn()
  ImGui.Text("Name")
  ImGui.NextColumn()
  ImGui.Text("")
  ImGui.NextColumn()
  ImGui.Separator()
  ]]

	UI.Columns(3, {100, 300, 85}, {"Key", "Name", ""})

	for k, v in ipairs(itemTable) do
		local itemKey = v.itemKey
		local name = v.name
		local enhanceLevel = v.enhanceLevel
		UI.Text(math.floor(itemKey))
		ImGui.NextColumn()
		UI.Text(name)
		ImGui.NextColumn()
		UI.Button("X##_d_" .. k .. internalName, function()
			tableChanged = true
			table.remove(itemTable, k)
		end)
		ImGui.NextColumn()
	end

	ImGui.Columns(1)

	return tableChanged, itemTable
end

MagLib.UI.Inventory = InventoryUI
