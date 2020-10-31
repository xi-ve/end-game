NewConditionWindow = { }
NewConditionWindow.Show = false

NewConditionWindow.Conditions = {"HP >=", "HP <=", "MP >=", "MP <=", "hasBuff", "not hasBuff", "time", "remain buffTime <=", "remain buffTime >=", "Energy >=", "Energy <="}

NewConditionWindow.InventoryItemsNames = {}
NewConditionWindow.InventoryItemsItemIds = {}
NewConditionWindow.InventoryItemsSlots = {}
NewConditionWindow.InventoryItemsIsCash = {}

NewConditionWindow.BuffNames = {}
NewConditionWindow.BuffTypes = {}
NewConditionWindow.BuffLevels = {}
NewConditionWindow.BuffRemainTimes = {}

local Selected_InventoryItem_Index = 1
local Selected_Buff_Index = 1
local Selected_Condition_Index = 1
local Selected_Condition_Value = 0
local Selected_Conditions = {}

function NewConditionWindow.DrawMainWindow()
	if not NewConditionWindow.Show then
		return
	end

    ImGui.Begin("New Conditional Buff") 
            
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

    if ImGui.Button("Close##close") then
        NewConditionWindow.Show = false
    end        

    NewConditionWindow.getInventoryItemsForFilter()

    ImGui.Spacing()

    _, Selected_InventoryItem_Index = ImGui.Combo("Select Inventory Items##id_inventory_items", Selected_InventoryItem_Index, NewConditionWindow.InventoryItemsNames)

    ImGui.Spacing()

    if ImGui.Button("+##condition_add") then

    	if Selected_Condition_Index >= 1 and Selected_Condition_Index <= 4 or Selected_Condition_Index >= 10 and Selected_Condition_Index <= 11 then -- hp/mp % slider + Energy slider

    		table.insert(Selected_Conditions, {Condition = NewConditionWindow.Conditions[Selected_Condition_Index], Value = {tostring(Selected_Condition_Value)}})
    	elseif Selected_Condition_Index >= 5 and Selected_Condition_Index <= 6 then -- buff selector

    		table.insert(Selected_Conditions, {Condition = NewConditionWindow.Conditions[Selected_Condition_Index], Value = {NewConditionWindow.BuffNames[Selected_Buff_Index]}})
    	elseif Selected_Condition_Index == 7 then -- time modifier

    		table.insert(Selected_Conditions, {Condition = NewConditionWindow.Conditions[Selected_Condition_Index], Value = {tostring(Selected_Condition_Value)}})
        elseif Selected_Condition_Index >= 8 and Selected_Condition_Index <= 9 then -- time modifier and buff selector

            table.insert(Selected_Conditions, {Condition = NewConditionWindow.Conditions[Selected_Condition_Index], Value = {tostring(Selected_Condition_Value), NewConditionWindow.BuffNames[Selected_Buff_Index]}})
    	end
    	
		Selected_Buff_Index = 1
		Selected_Condition_Index = 1
		Selected_Condition_Value = 0
    end

    ImGui.SameLine()

    _, Selected_Condition_Index = ImGui.Combo("Select Condition##id_conditions", Selected_Condition_Index, NewConditionWindow.Conditions)

    if Selected_Condition_Index >= 1 and Selected_Condition_Index <= 4 then -- hp/mp % slider

    	_, Selected_Condition_Value = ImGui.SliderInt("%##condition_value", Selected_Condition_Value, 10, 100)
    elseif Selected_Condition_Index >= 5 and Selected_Condition_Index <= 6 then -- buff selector

    	NewConditionWindow.getBuffsForFilter()

    	_, Selected_Buff_Index = ImGui.Combo("Select Buff##id_buffs", Selected_Buff_Index, NewConditionWindow.BuffNames)
    elseif Selected_Condition_Index == 7 then

    	_, Selected_Condition_Value = ImGui.SliderInt("Mins##condition_value", Selected_Condition_Value, 1, 180)
    elseif Selected_Condition_Index >= 8 and Selected_Condition_Index <= 9 then

        _, Selected_Condition_Value = ImGui.SliderInt("Mins##condition_value", Selected_Condition_Value, 1, 180)
        NewConditionWindow.getBuffsForFilter()

        _, Selected_Buff_Index = ImGui.Combo("Select Buff##id_buffs", Selected_Buff_Index, NewConditionWindow.BuffNames)
    elseif Selected_Condition_Index >= 10 and Selected_Condition_Index <= 11 then -- Energy slider

        _, Selected_Condition_Value = ImGui.SliderInt("##condition_value", Selected_Condition_Value, 0, 500)
    end

    ImGui.Columns(3)
    ImGui.Text("")
    ImGui.NextColumn()
    ImGui.Text("Condition")
    ImGui.NextColumn()
    ImGui.Text("Value")
    ImGui.NextColumn() 

    for k,condition in pairs(Selected_Conditions) do
    	
    	if ImGui.Button("X##condition_remove_" .. k) then
            table.remove(Selected_Conditions, k)

            break
        end

    	ImGui.NextColumn()
    	ImGui.Text(condition.Condition)
   		ImGui.NextColumn()
    	ImGui.Text(table.combinestring(condition.Value, ";"))
    	ImGui.NextColumn() 
    end

    ImGui.Spacing()

    if ImGui.Button("Create##create_conditional_buff") then

    	if table.length(Selected_Conditions) ~= 0 then

    		local conditionalBuff = {Enabled = true, IsCash = NewConditionWindow.InventoryItemsIsCash[Selected_InventoryItem_Index], ItemId = NewConditionWindow.InventoryItemsItemIds[Selected_InventoryItem_Index], Name = NewConditionWindow.InventoryItemsNames[Selected_InventoryItem_Index], Conditions = Selected_Conditions}

    		table.insert(AutoFood.Settings.ConditionalBuffs, conditionalBuff)

    		AutoFood.SaveSettings()

    		Selected_InventoryItem_Index = 1
			Selected_Buff_Index = 1
			Selected_Condition_Index = 1
			Selected_Condition_Value = 0
			Selected_Conditions = {}

			NewConditionWindow.Show = false
    	end
    end

    ImGui.End()
end

function NewConditionWindow.getInventoryItemsForFilter()
    local invenMaxSize = Inventory.getMaxSize()
    local cashinvenMaxSize = CashInventory.getMaxSize()

    if invenMaxSize == 0 or cashinvenMaxSize == 0 then
        return
    end

    local itemTableNames = {}
    local itemTableIds = {}
    local itemTableSlots = {}
    local itemTableIsCash = {}

    if Equip.hasAlchemyStoneEquipped() then
        table.insert(itemTableNames, "AlchemyStone")
        table.insert(itemTableIds, 0)
        table.insert(itemTableSlots, -1)
        table.insert(itemTableIsCash, false)
    end

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
                    table.insert(itemTableIsCash, false)
                end
            end
        end
    end

    for i = 2, cashinvenMaxSize - 1 do
        if CashInventory.hasItemWrapper(i) then
            local name
            local itemId
            local count

            name, itemId, count = CashInventory.getItemData(i)

            if name ~= nil and itemId ~= nil then
                if table.find(itemTableIds, itemId) == nil then
                    table.insert(itemTableNames, "[Cash] " .. name)
                    table.insert(itemTableIds, itemId)
                    table.insert(itemTableSlots, i)
                    table.insert(itemTableIsCash, true)
                end
            end
        end
    end

    NewConditionWindow.InventoryItemsNames = itemTableNames
    NewConditionWindow.InventoryItemsItemIds = itemTableIds
    NewConditionWindow.InventoryItemsSlots = itemTableSlots
    NewConditionWindow.InventoryItemsIsCash = itemTableIsCash    
end

function NewConditionWindow.getBuffsForFilter()
	local names = {}
	local types = {}
	local levels = {}
	local remain = {}

	for k,buff in pairs(Buffs.getAppliedBuffs()) do
		table.insert(names, buff.Name)
		table.insert(types, buff.Type)
		table.insert(levels, buff.Level)
		table.insert(remain, buff.RemainTimeMs)
	end

	NewConditionWindow.BuffNames = names
	NewConditionWindow.BuffTypes = types
	NewConditionWindow.BuffLevels = levels
	NewConditionWindow.BuffRemainTimes = remain
end