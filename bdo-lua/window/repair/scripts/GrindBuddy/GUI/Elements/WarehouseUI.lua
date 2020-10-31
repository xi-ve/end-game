WarehouseUI = {}
WarehouseUI.selectedItemInputIndex = -1
WarehouseUI.inputName = ""
WarehouseUI.inputItemId = -1

WarehouseUI.selectedTakeOutItemInputIndex = -1
WarehouseUI.inputTakeOutName = ""
WarehouseUI.inputTakeOutAmount = 0
WarehouseUI.inputTakeOutItemId = -1
WarehouseUI.inputTakeOutAmountManual = 0

function WarehouseUI.draw(newWindow)
    if newWindow == nil then
        newWindow = true
    end

    if newWindow then
        ImGui.Begin("[Townrun]: Warehouse")

        ImGui.PushStyleColor2(ImGuiCol_Text, RenderHelper.GetColorImVec4FromHexColorString("FFFFCC99"))
        ImGui.PushStyleColor2(ImGuiCol_Button, RenderHelper.GetColorImVec4FromHexColorString("FF990000"))
        ImGui.PushStyleColor2(ImGuiCol_CheckMark, RenderHelper.GetColorImVec4FromHexColorString("FF990000"))
    end

    --ImGui.Text("Use Maid:")
    --ImGui.SameLine()
    --_, Grinder.settings.use_maid_storage = ImGui.Checkbox("##UseMaid", Grinder.settings.use_maid_storage)

    ImGui.Text("Use Legacy Method For Storage Interaction:")
    ImGui.SameLine()
    _, Grinder.settings.use_legacy_warehouse = ImGui.Checkbox("##legacy_storage", Grinder.settings.use_legacy_warehouse)

    if ImGui.CollapsingHeader("Depositing##depositing_header") then
        _, Grinder.settings.doWarehouse = ImGui.Checkbox("Deposit Items##deposit_items_checkbox", Grinder.settings.doWarehouse)
        _, WarehouseUI.selectedItemInputIndex = ImGui.Combo("##id_inventory_items_selling", WarehouseUI.selectedItemInputIndex, Cache.inventoryItemsNames)
        if ImGui.Button("Add") then
            --local shouldAdd = true
            if table.length(Cache.inventoryItemsNames) ~= 0 and WarehouseUI.selectedItemInputIndex > - 1 then
                local itemId = Cache.inventoryItemsIds[WarehouseUI.selectedItemInputIndex]
                local canAdd = true
                for k, v in pairs(Grinder.settings.deposit_items) do
                    if v.itemId == itemId then
                        canAdd = false
                        break
                    end
                end

                if canAdd then
                    table.insert(Grinder.settings.deposit_items, {name = Cache.inventoryItemsNames[WarehouseUI.selectedItemInputIndex], itemId = itemId, })
                end

                itemId = nil
                canAdd = nil
            end
        end
        ImGui.SameLine()
        ImGui.Text("Select Inventory Item and press the Add Button!")

        ImGui.Spacing()

        ImGui.Columns(3)
        ImGui.SetColumnWidth(0, 60)
        ImGui.SetColumnWidth(1, 305)
        ImGui.SetColumnWidth(2, 85)
        ImGui.Text("Id")
        ImGui.NextColumn()
        ImGui.Text("Name")
        ImGui.NextColumn()
        ImGui.Text("")
        ImGui.NextColumn()
        ImGui.Separator()


        for k, v in pairs(Grinder.settings.deposit_items) do
            ImGui.Text(math.floor(tostring(v.itemId)))
            ImGui.NextColumn()
            ImGui.Text(tostring(v.name))
            ImGui.NextColumn()

            if ImGui.Button("Delete##id_items_list_delete_" .. k) then
                table.remove(Grinder.settings.deposit_items, k)
                break
            end

            ImGui.NextColumn()
        end

        ImGui.Columns(1)
        ImGui.Separator()

        ImGui.Text("Name:")
        ImGui.SameLine()
        _, WarehouseUI.inputName = ImGui.InputText("##deposit_input_name", WarehouseUI.inputName)
        ImGui.Text("Id:")
        ImGui.SameLine()
        _, WarehouseUI.inputItemId = ImGui.InputInt("##items_input_itemid", WarehouseUI.inputItemId, 0, 0, 0)
        ImGui.SameLine()
        if ImGui.Button("Add##items_add_itemid_selling") then
            if WarehouseUI.inputItemId > 0 and table.find(Grinder.settings.deposit_items, WarehouseUI.inputItemId) == nil then
                table.insert(Grinder.settings.deposit_items, {name = WarehouseUI.inputName, itemId = WarehouseUI.inputItemId})
                --Resetting
                WarehouseUI.inputItemId = 0
                WarehouseUI.inputName = ""
            end
        end
        ImGui.Spacing()
        ImGui.Spacing()
        ImGui.Spacing()
        ImGui.Spacing()
        ImGui.Spacing()
    end

    if ImGui.CollapsingHeader("Take out") then
        ImGui.Text("Following Item will be filled up to a specific amount every time the bot comes to the storage.")


        _, Grinder.settings.doTakeOut = ImGui.Checkbox("Take out##take_out_checkbox", Grinder.settings.doTakeOut)

        _, WarehouseUI.selectedTakeOutItemInputIndex = ImGui.Combo("##id_inventory_TakeOutitems", WarehouseUI.selectedTakeOutItemInputIndex, Cache.inventoryItemsNames)

        ImGui.Text("Amount: ")
        ImGui.SameLine()
        _, WarehouseUI.inputTakeOutAmount = ImGui.InputInt("##amount_inventory_TakeOutitems", WarehouseUI.inputTakeOutAmount)
        if ImGui.Button("Add##add_inventory_takeOutitems") then
            --local shouldAdd = true
            if table.length(Cache.inventoryItemsNames) ~= 0 and WarehouseUI.selectedTakeOutItemInputIndex > - 1 then
                local itemId = Cache.inventoryItemsIds[WarehouseUI.selectedTakeOutItemInputIndex]
                local canAdd = true
                for k, v in pairs(Grinder.settings.takeFromStorage_items) do
                    if v.itemId == itemId then
                        canAdd = false
                        break
                    end
                end

                if canAdd then
                    table.insert(Grinder.settings.takeFromStorage_items, {name = Cache.inventoryItemsNames[WarehouseUI.selectedTakeOutItemInputIndex], itemId = itemId, amount = WarehouseUI.inputTakeOutAmount})
                end

                itemId = nil
                canAdd = nil
            end
        end
        ImGui.SameLine()
        ImGui.Text("Select Inventory Item and press the Add Button!")

        ImGui.Spacing()

        ImGui.Columns(4)
        ImGui.SetColumnWidth(0, 60)
        ImGui.SetColumnWidth(1, 250)
        ImGui.SetColumnWidth(2, 60)
        ImGui.SetColumnWidth(3, 60)

        ImGui.Text("Id")
        ImGui.NextColumn()
        ImGui.Text("Name")
        ImGui.NextColumn()
        ImGui.Text("Amount")
        ImGui.NextColumn()
        ImGui.Text("")
        ImGui.NextColumn()
        ImGui.Separator()


        for k, v in pairs(Grinder.settings.takeFromStorage_items) do
            ImGui.Text(math.floor(tostring(v.itemId)))
            ImGui.NextColumn()
            ImGui.Text(tostring(v.name))
            ImGui.NextColumn()
            ImGui.Text(tostring(v.amount))
            ImGui.NextColumn()

            if ImGui.Button("Delete##id_takeOutItems_list_delete_" .. k) then
                table.remove(Grinder.settings.takeFromStorage_items, k)
                break
            end

            ImGui.NextColumn()
        end

        ImGui.Columns(1)
        ImGui.Separator()

        ImGui.Text("Name:")
        ImGui.SameLine()
        _, WarehouseUI.inputTakeOutName = ImGui.InputText("##takeOutItems_input_name_manual", WarehouseUI.inputTakeOutName)
        ImGui.Text("Id:")
        ImGui.SameLine()
        _, WarehouseUI.inputTakeOutItemId = ImGui.InputInt("##takeOutItems_input_itemid_manual", WarehouseUI.inputTakeOutItemId, 0, 0, 0)
        ImGui.Text("Amount: ")
        ImGui.SameLine()
        _, WarehouseUI.inputTakeOutAmountManual = ImGui.InputInt("##amount_inventory_TakeOutitems_manual", WarehouseUI.inputTakeOutAmountManual)

        if ImGui.Button("Add##takeOutItems_add_itemid_selling_manual") then
            if WarehouseUI.inputTakeOutItemId > 0 and table.find(Grinder.settings.sell_items, WarehouseUI.inputTakeOutItemId) == nil then
                table.insert(Grinder.settings.takeFromStorage_items, {name = WarehouseUI.inputTakeOutName, itemId = WarehouseUI.inputTakeOutItemId, amount = WarehouseUI.inputTakeOutAmountManual})
                --Resetting
                WarehouseUI.inputTakeOutItemId = 0
                WarehouseUI.inputTakeOutName = ""
            end
        end
    end

    if newWindow then
        ImGui.PopStyleColor(3)
        ImGui.End()
    end
end
