MainWindow = { }

MainWindow.InventoryItemsNames = {}
MainWindow.InventoryItemsItemIds = {}

local Selected_InventoryItem_Index = 1

function MainWindow.DrawMainWindow()
	local valueChanged = false

    ImGui.Begin("AutoLoot")

    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

    valueChanged, AutoLoot.Settings.DrawLootActors = ImGui.Checkbox("Draw Loot Actors##draw_loot_actors", AutoLoot.Settings.DrawLootActors)

    if ImGui.CollapsingHeader("BlackList##id_blacklist") then

        if ImGui.Button("Load Inventory Items") then

            MainWindow.getInventoryItemsForFilter()

        end

        if ImGui.Button("Add") then
            if table.length(MainWindow.InventoryItemsNames) ~= 0 then
                local itemId = MainWindow.InventoryItemsItemIds[Selected_InventoryItem_Index]
                local canAdd = true
                for k,v in pairs(AutoLoot.Settings.BlackList) do
                    if v.ItemId == itemId then

                        canAdd = false
                        break
                    end
                end

                if canAdd and not AutoLoot.shouldNotLoot(itemId) then

                    table.insert(AutoLoot.Settings.BlackList, {ItemId = itemId, Name = MainWindow.InventoryItemsNames[Selected_InventoryItem_Index]})
                    valueChanged = true

                end
            end
        end


        ImGui.SameLine()

        _, Selected_InventoryItem_Index = ImGui.Combo("Select Inventory Item##id_inventory_items", Selected_InventoryItem_Index, MainWindow.InventoryItemsNames)

        ImGui.Columns(4)
        ImGui.SetColumnWidth(0, 30)
        ImGui.SetColumnWidth(1, 80)
        ImGui.SetColumnWidth(2, 80)

        ImGui.Text("")
        ImGui.NextColumn()
        ImGui.Text("ItemId")
        ImGui.NextColumn()
        ImGui.Text("EnchantLvL")
        ImGui.NextColumn()
        ImGui.Text("Name")
        ImGui.NextColumn()

        for k,v in pairs(AutoLoot.Settings.BlackList) do

            if ImGui.SmallButton("X##id_items_list_delete_" .. k) then                
                table.remove(AutoLoot.Settings.BlackList, k)

                valueChanged = true
                break
            end

            ImGui.NextColumn()

            ImGui.Text(tostring(Utils.getItemId(v.ItemId)))
            ImGui.NextColumn()
            ImGui.Text(tostring(Utils.getEnchantLevel(v.ItemId)))
            ImGui.NextColumn()
            ImGui.Text(v.Name)
            ImGui.NextColumn()

        end
    end

    if valueChanged then
        AutoLoot.SaveSettings()
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

    for i = 2, invenMaxSize - 1 do
        if Inventory.hasItemWrapper(i) then
            local name
            local itemId
            local enchantKey

            name, itemId, _, enchantKey = Inventory.getItemData(i)

            if name ~= nil and itemId ~= nil then
                local enchantLevel = Utils.getEnchantLevel(enchantKey)

                if table.find(itemTableIds, enchantKey) == nil then

                    if enchantLevel > 0 then
                        table.insert(itemTableNames, "+" .. tostring(enchantLevel) .. " " .. name)
                    else
                        table.insert(itemTableNames, name)
                    end

                    table.insert(itemTableIds, enchantKey)
                end
            end
        end
    end

    MainWindow.InventoryItemsNames = itemTableNames
    MainWindow.InventoryItemsItemIds = itemTableIds
end